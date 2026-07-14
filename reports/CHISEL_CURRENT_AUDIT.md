# Chisel RTL 当前实现审查：功能、时序与控制效率

> 审查日期：2026-07-14  
> 范围：`rtl/src/main/scala/aec/`，并对照 `Track-B/spec.md`。本文审查当前
> source-of-truth；`CHISEL_SPEC_BUG_REVIEW.md` 中已标记 Fixed 的历史问题不重复计数。

## 实施更新（2026-07-14）

本审查之后已完成以下整改；下文保留原始问题描述作为基线：

- BUG-01～06：补齐GMEM b64、修复CTA restart和四路barrier、按byte处理preload，
  增加abort/drain soft reset，并为LMEM packed tag增加epoch回绕scrub。
- GPR改为每partition 32个lane-local 512x32 SRAM，支持完整warp vector read/write；
  LMEM tag由256个macro降到64个。
- GMEM按128-byte line coalesce，store保留全量preflight，atomic同line聚合RMW；
  Local LSU增加aligned word fast path，local/external仲裁改为round-robin。
- special coordinate改为共享注册单元，MTCH改为逐destination lane迭代，SFU扩展到4个physical lanes。

当前macro footprint约`591,911 um²`，是审查基线`922,968 um²`的64.1%。public regression
36/36通过；ABI smoke由877降到159 cycles，ADD由2384降到406，ATOM由6628降到372。

尚未完成：EFF-01的完整multi-instruction-in-flight/Decoupled queue重构、其余local valid
bitmap RAM化，以及锁定ASAP7环境下的完整top post-buffer STA/PPA。

## 1. 结论摘要

当前代码能通过已有 5 个 Chisel 定向测试，仓库证据也记录了 36/36 public case
通过，但仍存在 public case 没覆盖到的明显问题。最优先的三个功能问题是：

1. `LD.gmem.b64` 是规范合法指令，但前端没有 64-bit GMEM backend，会进入
   unsupported assertion。
2. CTA 完成后的 `restartCta` 与 `allDone` 同周期重复处理，multi-CTA kernel
   会跳过 CTA，甚至提前返回 DONE。
3. 四个 scheduler 同周期到达 `SYNC.CT` 时只向 barrier 提交一个 warp，其余
   warp 已被置 blocked，之后无法再次到达，形成死锁。

静态统计如下：

| 类别 | Critical | High | Medium | 合计 |
|---|---:|---:|---:|---:|
| 明显功能 bug / 鲁棒性缺陷 | 3 | 2 | 1 | 6 |
| 时序高风险点 | 2 | 3 | 0 | 5 |
| 控制与吞吐低效点 | 1 | 5 | 1 | 7 |

这些数字是独立根因数，不是受影响 opcode 或 testcase 数量。

## 2. 明显功能 bug

### BUG-01 Critical：合法 `LD.gmem.b64` 没有执行路径

- 规范：`spec.md:608` 明确 `LD` 支持 `.b64`；`spec.md:831-836` 定义 8-byte
  load 和 register pair 约束。
- Validator：`AecValidator.scala:73-75` 接受 dtype `1` 的合法 LD。
- 前端：`EvalTop.scala:450-452` 的 `legalGmem` 仅允许 dtype `0/2/3/8`，排除了
  `.b64`。
- LSU：`GmemLsu.scala:17-20,27` 的数据路径固定为每 lane 32 bits，也没有第二个
  destination word。

因此合法指令不会进入 `canStart`，而会在 `EvalTop.scala:508-513` 设置
`unsupportedTrap`，随后 assertion 终止仿真。这不是性能退化，而是 ISA 功能缺失。

建议：给 GMEM LSU 增加 width64、最多两条 line part 的拼装以及 64-bit loadData，
并复用现有 pair writeback；补充 line 尾部 `addr[6:0]=121..127` 的跨 line 测试。

### BUG-02 Critical：multi-CTA 完成路径会重复推进 CTA 坐标

- `EvalTop.scala:132-141` 在 `restartCta` 为真时重置 warp，并清除
  `restartCta`。
- `EvalTop.scala:795-800` 同时仅凭旧的 `allDone` 再次推进 CTA，并重新置
  `restartCta`。

时序过程为：CTA 0 完成的周期把 `ctaX` 改为 1、`restartCta` 改为 1；下一周期
寄存器边沿前，`allDone` 仍来自尚未执行 sequential reset 的旧 warpState，因此
restart 分支和 completion 分支同时命中。后面的 completion 赋值再次推进 `ctaX`，
覆盖前面清除 `restartCta` 的赋值。

后果：

- `grid=[2,1,1]` 时 CTA 1 尚未执行便可能直接返回 DONE；
- 更大的 grid 会隔 CTA 跳过，并对新 CTA 做重复清零；
- `%ctaid.*`、GMEM 输出和执行周期均错误。

现有 36 个 public manifest 的 grid 全部是 `[1,1,1]`，所以 36/36 不能覆盖该问题。
建议将完成条件改为 `running && !restartCta && allDone ...`，或合并成单一 CTA
transition FSM，并增加 grid `[2,1,1]`、`[2,2,2]` 定向差分。

### BUG-03 Critical：多 scheduler 同周期 barrier arrive 会丢 warp

- 每个 scheduler 解码到 `SYNC.CT` 都立即执行
  `warpState(issueWarp) := blocked`：`EvalTop.scala:478-479`。
- barrier 入口却用一个 `PriorityEncoder` 将四路 arrive 压成一路：
  `EvalTop.scala:746-748`。
- 未被选中的 arrive 没有 pending/ready/retry 状态；其 warp 已 blocked，不能重新
  fetch 同一条 `SYNC.CT`。

当 warp 0、2、4、6 等来自不同 partition 的 warp 同周期到达时，只有一个被 barrier
记入 `arrived`，其他 warp 永久丢失，required set 永远无法满足，最终 timeout。
现有两个 public barrier case 都只有 64 threads，warp 0/1 位于同一 scheduler，受
partition 串行控制，无法产生四路同时 arrive。

建议：barrier 接口改成 4-way mask/Vec arrive，或给每个 scheduler 增加
Decoupled pending，只有 barrier accept 后才把 warp 置 blocked。至少增加 128/256
threads、不同 warp 延迟相同的 barrier 测试。

### BUG-04 High：CMEM/PMEM preload 忽略 byte address 低位并可能越界回绕

- 顶层接受任意低 16-bit byte address，只检查 `load_addr[31:16]`：
  `EvalTop.scala:98-105`。
- `LocalLsu.scala:77-84` 直接用 `address(15,2)+preloadWord` 选择 32-bit word，并将
  strobe 每四位分组；`address(1,0)` 没有参与 byte placement。

规范 `spec.md:167-168` 定义 PMEM/CMEM load address 为 byte address，没有规定
4-byte 或 16-byte 对齐。比如地址 `1`、`load_strb=1` 应写 byte 1，当前实现会写
word 0 的 byte 0。地址接近 `0xffff` 时，四个 word 的 14-bit 地址加法还会截断并
回绕到地址 0，顶层也未检查 `load_addr + highest_enabled_byte < 65536`。

建议按 16 个 byte strobe 逐 byte 计算 `load_addr+i` 的 word/offset，并在接受 load
前对所有 enabled byte 做范围预检。

### BUG-05 High：错误结束后流水线未清理，后续 launch 会继承旧事务

多个 error 路径只执行 `running := false`、`resultValid := true`，例如
`EvalTop.scala:613-617,626-630,670-675,720-721`。新 launch 初始化 PC、warpState、
GPR valid，但没有清理以下状态：

- `pipeState/fetchPending` 及 held instruction；
- scoreboard busy bits；
- barrier generation；
- execution unit、local LSU、GMEM LSU 和 atomic lock 的在途状态。

结果握手后 `launch_ready` 会重新变高，因此接口允许的下一次 launch 可能收到旧
backend completion、旧 scoreboard reservation 或旧 barrier generation，产生错误
写回/死锁。官方 runner 当前是一次 reset 后一次 launch，因而未覆盖。

建议增加 top-level abort/drain FSM：错误后阻止 result delivery 直到在途外部事务
安全结束，并同步 flush/epoch-tag 所有内部 completion；新 launch 必须从统一 idle
状态开始。

### BUG-06 Medium：LMEM 8-bit generation 在第 256 次 clear 回绕

`LocalLsu.scala:34-35,61,112` 用 8-bit generation tag 代替 bulk clear。每次 launch/
CTA restart 加一，回绕后旧 LMEM word 的 tag 会再次等于当前 generation，违反每个
CTA/thread LMEM 初值为 0 的要求。multi-CTA kernel 本身就可能在一次 launch 内消耗
大量 generation。

建议使用不会在允许执行次数内回绕的 tag，或在回绕前扫描清 tag SRAM；更优方案是
将 LMEM backing store 放到规范所述 external memory service，并用地址 epoch 管理。

## 3. 时序高风险点

### TIM-01 Critical：warp-wide capture/clear 控制网扇出到数千寄存器

`AecWarpRequestBuffer`、INT/FP wrapper 和 32-lane result arrays 使用单一
arm/capture/state 条件控制整包数据。仓库已有 ASAP7 单元报告
`reports/UNIT_TIMING_ASAP7.md`：在 2000 ps 目标下，四个单元最差路径为
218528.80--403784.66 ps，观察到 2.3--4.7 pF 的单网负载，Fmax 仅 2.48--4.58 MHz。
报告指出最差路径不是算术本体，而是 warp request/control 高扇出。

这已经是有 STA 数据支持的 timing failure，不应仅标为“可能优化”。应按 lane/operand
分组寄存 capture enable，避免综合重新合并，并在完整物理流程中设置 max fanout/
transition 和 buffer tree。

### TIM-02 Critical：超过 11 万 bit 的 validity 向量产生超宽 barrel shift/OR

- 每个 GPR partition 有 16384-bit `gprValid`，四份共 65536 bits：
  `RegisterFile.scala:37,59-60,72-76`。
- SMEM/CMEM/PMEM valid 各 16384 bits，共 49152 bits：
  `LocalLsu.scala:29,38-39,60,65-66`。

动态读写使用 `vector(index)` 和 `1.U << index`。生成 RTL 已展开成 16384-bit 右移、
32767-bit 左移与 OR，例如 `AecEvalTop.sv:8636,8724-8728,9012-9014,11396-11401`。
这些既是极差的组合时序/布线结构，也会让 valid storage 无法自然映射到小 RAM。

建议将 valid 与 data 一起 bank，或使用每 bank epoch/tag RAM；GPR 可在每 CTA 使用
窄 generation tag，避免 64K resettable valid flops。

### TIM-03 High：special-register 坐标计算实例化四套组合除法/取模

`EvalTop.scala:599-607` 在每个 scheduler 内组合计算 `% launchBlockX`、`/` 和
`launchBlockX * launchBlockY`。当前 lint 对生成 RTL报告 16 条 width expand/truncate
warning；虽然 total threads <=256 时 8-bit linearTid 的数值范围够用，但组合 `/`、
`%` 会形成深且面积大的通路，并被复制四次。

建议在 launch 时预计算维度/stride，在 CPY special 路径用多周期加减或共享 divider；
也可维护每 lane 的 x/y/z 常量映射，完全移出 issue 关键路径。

### TIM-04 High：`MTCH` 构造 1024 个 32-bit 比较及大归约网络

`EvalTop.scala:551-555` 对每个 destination lane，再遍历全部 32 个 other lane：总计
1024 个 32-bit equality comparator，加上 mask 生成。`SHUF` 在
`EvalTop.scala:528-540` 也形成 32 组动态 Vec 索引（大 mux）。两者从 operand arrays
直接组合到 writeData registers，没有流水级。

建议用 1--4 个比较器迭代 32x32 配对，或按 value hash/bank；SHUF 使用分级交换网络
并插寄存器。

### TIM-05 High：完整 top 尚无有效 signoff 时序证据

现有正式文档明确 `reports/PPA.md` 中 13.8 ns 示例只是旧 `AecFpUnit`，而
`UNIT_TIMING_ASAP7.md` 也是四个 compute unit 的独立测量，不代表 `aec_eval_top`。
当前 top 还包含 704 个 SRAM macro、超宽 valid shift、四套坐标 divider 和 collective
网络，不能由单元报告推断收敛。

建议在修复 TIM-01/02 后对完整 judged hierarchy 做 locked ASAP7 + SRAM 的 post-buffer
STA；在此之前不应宣称达到目标频率。

## 4. 控制、吞吐与面积低效点

### EFF-01 Critical：每 partition 只允许一条 warp instruction 在途

`EvalTop.scala:229-234` 规定 `partitionFree = pipeState === pipeIdle`，同一 partition
的两个 warp 必须等当前指令完成全部 operand collect、execute/memory 和 writeback
后才能取下一条。长延迟 FP64、DIV/SFU 和 GMEM 期间完全无法切换到另一个 warp。

这使 GPU 最核心的 latency hiding 失效，也使 scoreboard 基本冗余：一条指令在途时
根本不会发下一条，因此不存在需要 scoreboard 解决的跨指令 RAW/WAW 并发。

### EFF-02 High：所有指令固定读取 A/B/C 的全部 32 lanes

正常指令无论 unary、binary、immediate 还是 memory，都先经过 `pipeReadAB` 和
`pipeReadC`；pair 再经过 AHi/BHi/CHi：`EvalTop.scala:282-295,516-595`。
寄存器 bank 又因为 `pending` 在 response 周期不接受替代请求，单个 32-lane stage
约需 64 cycles：`RegisterFile.scala:41-70`。

粗略固定开销：

| 指令类型 | operand collect | writeback | 未含 execute 的固定量级 |
|---|---:|---:|---:|
| 普通 32-bit | 约 128 cycles | 32 cycles | 约 160 cycles |
| pair/FP64 | 约 320 cycles | 64 cycles | 约 384 cycles |

即使 `LOADI`、`RDTSC` 或 unary op 也承担大量无用读。应由 decode 生成 source-use mask，
只采集实际操作数，并允许 response/next request 同周期交接。

### EFF-03 High：GMEM 无 coalescing，逐 lane 且每 part 等 32-cycle response

`GmemLsu.scala:7-12,32-66,91-145` 每次只处理一个 participating lane，并在发下一条
line request 前等待当前 response。32 个 lane 即使访问同一 128-byte line，也不会
合并。store 还先完整 read preflight，再 replay write，事务数再翻倍。

因此 16-tag external engine 在每个 LSU 上实际最多只有一个 outstanding；四个 LSU
合计通常最多 4 个，且 `MemoryEngine.scala:29-30` 在任意 response valid 周期禁止发
新 request。128-byte/cycle 的公开 service 带宽几乎未利用。

建议先按 `(address >> 7)` 聚合 warp lane，生成 line mask/data 和 lane placement；允许
最多 16 条 line 在途，并把 preflight 改为不产生外部 read 的地址范围检查（若 error
只能由外部 model 返回，则需提交/回滚协议或 runner 允许的精确异常方案）。

### EFF-04 High：Local LSU 全局串行且逐 byte 访问

四个 scheduler 共用一个 `AecLocalLsu`，使用固定优先级仲裁：
`EvalTop.scala:702-731`。LSU 对每 lane 的 32-bit access 按 4 个 byte 循环执行
`readAccess -> readLo/writeLo`；64-bit 则 8 次：`LocalLsu.scala:153-177`。
即便地址 word-aligned 也没有 word fast path，且固定 PriorityEncoder 会让低编号
partition 长期占优。

建议增加 aligned 32/64-bit fast path、banked SMEM 并行 lane 合并，以及 round-robin
仲裁；CMEM/PMEM read 可单独走只读端口。

### EFF-05 High：存储介质选择过于单一，704 个 SRAM 与 11 万 valid flops 同时存在

由 Chisel 参数可直接得到 macro 数：

| 用途 | macro 数 |
|---|---:|
| 4 份 IMEM（每份 4x32-bit slice） | 16 |
| 4 个 GPR partition、每个双读副本 | 128 |
| SMEM | 16 |
| LMEM data | 256 |
| LMEM generation tag（只用 8/32 bits） | 256 |
| CMEM + PMEM | 32 |
| 合计 | 704 |

按仓库 PPA 文档记录的单 macro `1311.0336 um^2`，仅 macro footprint 约
`922,968 um^2`（0.923 mm²），未含标准单元和布线。但这不表示“所有存储都应继续
换成 SRAM”。当前问题恰恰是没有按容量、端口、复位和访问模式分别选型：一边用
SRAM 存低利用率 tag，一边又用超过 11 万个 resettable flop 存 valid bitmap。

#### GPR 是否应改成寄存器

不建议把完整 GPR 阵列直接改成 `Reg(Vec(...))`：8 warps x 32 lanes x 256 GPR x
32 bits 共 `2,097,152` 个数据 bit。以当前 ASAP7 RVT `DFFHQNx1` Liberty area
`0.2916 um^2` 粗算，仅裸 DFF 就约 `611,529 um^2`，还不包括 256:1 read mux、write
decode、时钟树和布线；当前两份 GPR SRAM 共 128 个 macro，footprint 约
`167,812 um^2`。全寄存器 GPR 的面积至少约为当前双副本 SRAM 的 3.6 倍，而且动态
读 mux 很可能成为新关键路径。

GPR 的目标架构直接采用每 partition 32 个 lane banks，不保留串行 collector 的过渡
方案：

```text
bank = lane_id
row  = {warp_local, reg_index}
```

每个 bank 保存两个 warp 的同一 lane，共 `2 x 256 = 512` 个 32-bit word，正好映射
一个允许的 512x32 macro。每个 partition 使用 32 个 macro，四个 partition 共 128 个
512x32 macro，面积约 `88,474 um^2`；相对当前 128 个 1024x32 双副本 macro 节省约
`79,339 um^2`。

访问控制建议：

- 32 个 bank 同周期读取同一个 register index，一次得到完整 warp 的一个 source；
  `src1/src2/src3` 按 source 分别占用 RF read cycle。
- `src1 == src2` 时只读一次并广播；unary、immediate 等指令由 source-use mask 关闭
  不需要的读取。
- Vector writeback 时，每个 bank 的 write enable 直接使用 `commitMask(lane)`；普通
  32-bit destination 一个周期写完，register pair 使用两个周期。
- Operand read 与 writeback 通过 bank arbiter 和 result queue 解耦，具体完整数据流见
  第 5 节。

- 当前 65536-bit `gprValid` 可以保留为 standard-cell 状态，但必须按 lane/bank 局部化，
  避免生成 16K-bit 动态 shift；或者改成打包 epoch/tag SRAM。data SRAM 与 valid/tag
  不必使用同一种介质。
- predicate 总共只有 2048 bits，且需要灵活 lane read/write，继续用寄存器是合理的。

#### 各类状态的建议介质

| 状态 | 当前实现 | 更合理的方向 |
|---|---|---|
| IMEM、SMEM、CMEM、PMEM | SRAM | 容量大，继续 SRAM；按实际深度选允许的 256/512/1024 macro |
| GPR data | 双副本 SRAM | 每 partition 32 个 512x32 lane banks，配合 vector collector/writeback，见第 5 节 |
| predicate、scoreboard、queue、控制状态 | 寄存器 | 容量小且端口灵活，继续寄存器 |
| GPR/SMEM/CMEM/PMEM valid | 超宽寄存器位图 | bank-local valid、打包 tag SRAM 或 epoch；禁止全宽动态 shift |
| LMEM data | 256 个 SRAM | 优先移到规范的 external LMEM backing；若驻留 DUT 则保留 SRAM，不应改成海量寄存器 |
| LMEM generation tag | 256 个 32-bit SRAM，仅用低 8 bits | 4 个 8-bit tag 打包到一个 32-bit word，理论上可降至 64 个 macro；或随 external LMEM 消除 |
| operand/result staging | 寄存器 | 容量较小且频繁访问，保留寄存器，但按 lane 分散 enable 以控制扇出 |

因此优化优先级应是：先消除/外移 LMEM data+tag，打包 tag 和局部化 valid；GPR
直接重构为 lane-banked vector RF，不再继续优化逐 lane 串行 collector。只有很小、
高频、端口密集的状态适合换成寄存器，完整 GPR 不属于这一类。

### EFF-06 High：执行资源复制与前后端串行度不匹配

每个 partition 实例化 16 INT lanes、16 FP32 lanes、2 FP64 lanes，但前端每条普通
指令仅 operand collection + writeback 就约 160 cycles，且同 partition 没有第二条
指令在途。大量算术资源绝大多数时间空闲，却显著增加面积、capture fanout 和功耗。

在不先增加多 warp/multi-instruction 流水能力的情况下，更合理的是共享或减少物理
lane；若保留 16 lanes，则前端至少需要 banked operand collect、warp queue 和独立
writeback queue 才能喂满。

### EFF-07 Medium：固定优先级仲裁可能造成饥饿

local LSU 和 external LSU 都用 `PriorityEncoder`：`EvalTop.scala:706,764`。持续有请求
时，低编号 scheduler 可反复获胜，高编号 partition 没有 age/round-robin 保证。
正确程序最终可能仍完成，但 tail latency 和 barrier 到达偏差会被放大。

## 5. 推荐的成熟 GPU 风格数据流

当前 `pipeState` 把 operand collect、execute/memory 和逐 lane writeback 串成一条
instruction-serial FSM。建议改成各级解耦、允许多个 warp/instruction 在途的数据流：

```text
  IMEM / Fetch
       |
       v
  Decode + per-warp issue queue
       |
       v
  Scoreboard / dependency check
       |
       v
  Vector operand collector <------+
       |                           |
       v                           | bank arbitration
  Execution request queues         |
       |                           |
       +--> INT ----------------+  |
       +--> FP32 ---------------+  |
       +--> FP64 ---------------+  |
       +--> DIV/SFU ------------+  |
       +--> LSU/coalescer ------+  |
                                |  |
                                v  |
                         Result queues
                                |
                                v
                     Vector writeback arbiter
                                |
                                v
                     Lane-banked GPR / predicate
```

各连接使用 Decoupled queue。一个 warp 的长延迟操作进入 execution queue 并 reserve
destination 后，scheduler 应立即选择另一个 runnable warp；不能像当前实现一样在
`pipeReadAB` 时就把整个 warp/partition 阻塞到最终 writeback。

### 5.1 Lane-banked vector GPR

正式吞吐重构推荐每个两-warp partition 使用 32 个 lane bank：

```text
bank = lane_id
row  = {warp_local, reg_index}
```

每个 bank 的深度是 `2 warps x 256 registers = 512 words`，正好对应一个允许的
`512x32` SRAM。四个 partition 共使用 128 个 512x32 macro。读取某个 source register
时，32 个 bank 同周期返回完整 warp：

```text
cycle R0: src1[0..31]
cycle R1: src2[0..31]
cycle R2: src3[0..31]   // 仅 MAD/FMA 等 ternary 指令
```

这种组织相对当前 128 个 1024x32 GPR macro 的面积比较为：

| GPR 组织 | Macro 组成 | 锁定 LEF 面积 |
|---|---:|---:|
| 当前双副本 | 128 x 1024x32 | 167812.3 um^2 |
| 32 lane-bank vector RF | 128 x 512x32 | 88473.6 um^2 |

Lane-bank 把一个完整 warp 的单源采集从约 64 cycles 降到 1 cycle；相对当前双副本
还减少约 79338.7 um²。因此它同时改善面积与吞吐，并适合已经实例化的 16-lane
INT/FP32 backend。

按 lane banking 也使 predicated writeback 简单：每个 bank 的 write enable 直接由
`commitMask(lane)` 控制，inactive lane 的 bank 不写，不需要读改写。普通 32-bit
destination 可在一个 RF 周期写完 32 lanes，64-bit pair 使用两个 RF 周期。

### 5.2 Source-use decode 与 vector operand collector

Decode 必须产生明确的 source-use metadata，例如 `usesSrc1/2/3`、`srcPair` 和
`writesDest/predicate`。Collector 只读取真正使用的 source：

- `LOADI/RDTSC/CPY %special` 不读取 GPR；
- unary instruction 读取一个 vector source；
- binary ALU/load/store 通常读取 1--2 个 source；
- MAD/FMA/CAS 最多读取三个 source；
- `src1 == src2` 时只读一次并在 operand buffer 内广播；
- 64-bit pair 的每个 source 使用两个 RF read cycles。

每个 lane SRAM 是 1RW，operand read 与 writeback 需要 bank arbiter。建议 writeback
优先以避免 result queue 反压执行单元，collector 在其余周期读取；2--4 entry result
queue 用于吸收短期 read/write 冲突。

### 5.3 16-lane subwarp execution

保留当前每 partition 的 16 个 INT/FP32 physical lanes，但让 operand/result buffer
以完整 32-lane warp 为接口：

```text
32-lane operand buffer
       |
       +--> beat 0: lanes  0..15 --> 16-lane unit --+
       +--> beat 1: lanes 16..31 --> 16-lane unit --+
                                                    v
                                         32-lane result buffer
                                                    |
                                                    v
                                      one vector RF write cycle
```

执行结果先进入 result buffer，只有所有 executing lane 均未产生 error 时才生成统一
commit packet，可自然满足 warp instruction precise error。普通 binary instruction
的独占资源需求从当前约 `128 read + execute + 32 write` cycles，降低为约
`2 vector reads + 2 execution beats + 1 vector write`；流水重叠后，不同指令的 read、
execute 和 writeback 还能并行，因此总体 issue interval 不等于这五项简单相加。

FP64、DIV/SFU 可以使用更窄的物理 lane，但必须通过 request/result queue 解耦；不能
因为一个 warp 正在做几十周期运算而锁住同 partition 的另一个 warp。

### 5.4 Warp scheduler、scoreboard 与在途状态

每个 scheduler 每周期从两个 warp 中选择 source ready 且目标 execution queue 有空间
的 warp。Warp 仅在以下情况停止 issue：

- scoreboard 报告 RAW/WAW 或 predicate dependency；
- 目标 execution/memory queue 满；
- control instruction 尚未 resolve；
- warp 正等待 `SYNC.CT`；
- warp 已 HALT。

普通 instruction 进入 operand collector 不应把 `warpState` 设为 blocked。Scoreboard
在 issue 时 reserve GPR/predicate destination，在最终 vector writeback 时 release；
memory ordering 另用 per-warp token/sequence 管理。这样才能同时存在例如：warp 0 的
FP instruction 正在执行、warp 1 正在采集 INT operands、之前的 load 正在等待 GMEM。

所有 execution/result packet 都必须携带 `{partition, warp, pc, destination,
executeMask, sequence/epoch}`，不能继续依赖每 partition 唯一的 `held(s)`。Epoch 还能
用于错误 abort 或新 launch 时丢弃旧 completion，解决 BUG-05。

### 5.5 LSU 数据流

LSU 不应接收逐 lane transaction，而应接收完整 warp address/data vectors：

```text
warp memory request
       |
       v
address/range precheck
       |
       v
128-byte line coalescer
       |
       v
tagged outstanding request table (up to 16)
       |
       v
load-data placement / store completion
       |
       v
vector result queue
```

Coalescer 按 `address >> 7` 聚合 lane，使同一 line 的 load/store 只产生一次或少数 line
request；tag table 保存 lane placement、byte mask、warp 和 instruction sequence。
MBAR、barrier 和 kernel completion 根据 per-warp/per-CTA outstanding counter 判断，
而不是依赖“整个 LSU instruction 串行完成”隐式保证顺序。

### 5.6 建议落地顺序

1. 将 GPR 改成每 partition 32 个 512x32 lane banks，增加 source-use decode。
2. 增加 32-lane operand/result buffer，INT/FP32 以两个 16-lane beat 执行。
3. 把 writeback 改成 commit-mask 控制的单周期 vector bank write；pair 使用两周期。
4. 将 operand collector、execution 和 writeback 拆成独立 Decoupled queue/FSM。
5. 允许另一 warp 在当前 warp 执行期间 issue，使 scoreboard 真正管理多指令在途。
6. 给 FP64、DIV/SFU 和 LSU 增加 request/result queue 与完整 metadata。
7. 最后加入 GMEM line coalescer、多 outstanding transaction 和精确 abort/epoch。

每一步都需要在 public regression 之外增加 bank read/write conflict、predicated partial
write、RAW/WAW、两 warp overlap、execution backpressure、error abort 和 barrier
drain 定向测试，并重新运行完整 top STA/PPA。

## 6. 验证与证据边界

本次执行：

- `sbt test`：1 suite、5 tests，全部通过；这些测试只覆盖 decode/validator、FLO、
  部分整数多周期和 conversion，不覆盖上述 multi-CTA、四路 barrier、b64 GMEM 或
  preload unaligned。
- 对当前生成的 `AecEvalTop.sv` 运行 Verilator lint：无 fatal error，报告 16 条
  special-register `/`、`%` 相关 width expand/truncate warning。
- 仓库已有 `evidence/public_realtime_summary.json`：36/36；所有 public grid 均为
  `[1,1,1]`，barrier case 为 64 threads，因此不能反证 BUG-01..04。

本次没有改动 RTL，也没有把静态推断冒充 post-layout 时序。完整 top 的正式 PPA
仍需 locked ASAP7/locked SRAM、有效约束和 activity 后重新执行。

## 7. 建议处理顺序

1. 先修 BUG-02/03，并增加 multi-CTA、128/256-thread 同步 barrier regression；这两项
   会让合法 kernel 跳 CTA或永久 timeout。
2. 补齐 BUG-01 的 GMEM b64 load，再修 preload byte-address 边界。
3. 设计统一 abort/drain/flush 和 LMEM epoch 方案，保证可重复 launch。
4. 优先消除 TIM-01/02 后再做完整 top STA；否则算术 datapath 的局部优化不会解决
   当前最差控制网和超宽 shift。
5. 用 source-use mask、warp queue、coalescer 和 aligned local fast path重构吞吐，之后
   再决定执行 lane 数和 SRAM 复制策略。
