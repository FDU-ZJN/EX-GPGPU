# 设计报告

## 1. 设计目标与演进故事

ZGPGPU 面向 `TrackB-b-013/spec.md` 定义的 AEC 128-bit 定长指令集和
GPGPU 外部接口。项目最初实现的是 8-warp 高性能版本：4 个调度分区，每个
分区驻留 2 个 warp，以较高的硬件复制量换取延时隐藏能力。这个版本适合功能
和吞吐探索，但完整 Yosys/ABC/OpenSTA 流程的运行时间和中间网表规模很快成为
主要限制。后续了解到赛题 PPA 的时间限制后，提交版切换为 1 个调度器和 2 个
物理驻留 warp 槽位。

这次切换不是简单把“最多 8 warp”改成“最多 2 warp”。架构状态仍保存一个 CTA
内最多 8 个 warp 的 PC、active mask、call stack、barrier 和完成状态；两个
物理槽位每次绑定一对偶数对齐的架构 warp，当前一对完成或阻塞条件允许切换时，
再绑定下一对。因此提交版减少的是寄存器文件、scoreboard、ROB 端口、执行后端
和大 mux 的物理复制量，而不是 ISA 可见的 CTA 能力。

当前配置在 `FrontendTypes.scala` 中明确为：

```text
Schedulers   = 1
ResidentWarps = 2
```

这种架构选择把“以面积堆并行”改成“以有限乱序和流水访存隐藏延时”。它降低了
综合规模，也使关键路径更容易定位，同时保留两个 warp 之间的交织和同一 warp
内部独立指令的延时重叠。

## 2. 评分层次与源码关系

评分顶层为 `aec_eval_top`。手写
`rtl/sv/aec_eval_top.sv` 只完成规范端口和低有效复位适配，内部实例化 Chisel
生成的 `AecEvalCore`。顶层没有 debug、trace、retire monitor 或 testcase
专用端口；C++ runner 和断言不属于评分层次。

权威源码位于 `rtl/src/main/scala/`，评分 SystemVerilog 为
`rtl/sv/generated/eval_core/AecEvalCore.sv`。通过以下命令可重新生成：

```bash
make -C rtl eval-generate
```

`rtl/files.f` 只列出当前生成核心、ABI wrapper 和 SRAM wrapper，供正式 PPA
流程读取。生成 RTL 与仿真、PPA 使用同一个 judged hierarchy，避免验证一套 RTL、
综合另一套 RTL。

## 3. 前端、调度与物理 warp 重绑定

启动校验器先检查 grid、block、program size、预加载范围和总线程数。合法 launch
建立 CTA 状态，每个架构 warp 根据线程余量生成 active mask。一个 warp 固定
32 lane，partial warp 的无效 lane 从取指到写回始终由 mask 屏蔽。

单调度器在两个驻留槽位之间 round-robin。一个物理槽位绑定的架构 warp ID
参与寄存器地址、scoreboard、ROB tag、访存 token 和 completion 路由。绑定变化
时 epoch 增加；旧 epoch 的迟到 completion 不能写入新 warp。分支、CALL/RET、
SYNC_CT、MBAR 和 HALT 等控制操作在 ROB 为空时处理，避免错误路径或未退休副作用
越过控制边界。

指令经过预译码、合法性校验、依赖检查、ROB 分配、operand collection 和后端
dispatch。编码校验发生在任何架构副作用之前，包括 opcode、dtype、subop、
predicate control 和 MBZ 字段。非法编码返回 `INVALID`；除零、越界等动态错误
返回 `EXEC_ERROR`。

## 4. Scoreboard、ROB 与乱序完成

当前每个物理 warp 有一个 4-entry ROB，共两个 ROB。发射时为真实目的 GPR 和
predicate 预留依赖，寄存器对操作同时锁定低、高两个寄存器。scoreboard 阻止
RAW 和 WAW 冲突，但允许无依赖的后续指令进入不同长延时后端。

ROB tag 包含：

```text
warp + epoch + sequence + robIndex + pc
```

INT、FP32、FP64、SFU、转换、local LSU 和 GMEM 可以按各自延时完成。completion
fabric 在模块边界进行注册和仲裁，将结果写入对应 ROB entry；提交端只退休
ready 的 ROB head。因此这里是“顺序提交、乱序完成”，不是任意乱序发射。该方式
足以让短整数操作与较早的 FP/SFU/访存并行执行，同时保持异常、谓词写回和架构
状态精确。

早期 8-warp 版本中，宽 operand 数据和 completion 选择跨多个分区传播，形成
最高约 2048 fanout 的路径。当前设计把 operand select 下沉到
`AecPartitionBackend`，按操作簇分层选择；completion 也先局部编码/注册，再送
ROB。logic-only 诊断中该修改曾将 16.35 MHz 提升到 27.17 MHz，说明层次化控制
确实消除了一个主要瓶颈。该数值仅是历史诊断，不是当前 full-core 正式 Fmax。

保留 ROB 是有意识的取舍。删除 ROB 会减少 entry 状态、tag 比较和 completion
扇出，但会迫使同一 warp 在每条长延时指令后停顿，两个物理 warp 也不足以完全
掩盖访存和 SFU 延时。当前 2 x 4 entry 是在面积、控制复杂度和延时隐藏之间的
折中。

## 5. 寄存器文件与执行单元

寄存器文件按 lane 分 bank，服务两个物理 warp 槽位。同步 SRAM 读结果经过明确
capture stage，operand store 保存 A/B/C 以及 64-bit 操作所需的高半部。写回按
lane mask 执行，predicate bank 与 GPR scoreboard 一致更新。

整数后端使用 8-lane 物理簇，分 4 组完成 32-lane warp。FP16、BF16、FP32 和
FP64 使用参数化浮点流水；DIV/SQRT 和 SFU 为多周期。转换路径按 lane 串行，
使宽度、符号、舍入、饱和、NaN 和 Infinity 行为更容易逐项验证。SHUF、VOTE、
MTCH 和 RDTSC 等 collective 使用指令开始时的 execute mask，避免途中谓词变化
影响同一条指令的其他 lane。

第三方浮点源码包括带许可证的 Berkeley HardFloat 1.5，以及源自
THU-DSP-LAB FPUv2/Fudian 的实现。AEC 自有的接口适配、metadata、调度、校验、
scoreboard、ROB、访存和退休逻辑位于 `rtl/src/main/scala/aec/`。

## 6. 外部访存总览

规范外部接口以 128 Byte line 访问，并提供 4-bit tag。当前
`AecExternalMemoryEngine` 维护 16 个 outstanding slot，记录 space、warp、
address、write、cacheable 和内部 token。普通 load 只排队窄 descriptor，不在
每个队列项复制 1024-bit wdata 和 128-bit wstrb；串行 store 使用一个专用宽
payload slot。请求一旦 valid 且受到 backpressure，地址、数据、strobe、space
和 tag 保持稳定。

LMEM 通过外部 service 的独立 memory space 实现。地址按 CTA 线性线程号、
warp/lane 和每线程 4 KiB aperture 计算，跨线程私有区的访问在发出外部请求前
报错。GMEM 与 LMEM 的 completion 使用 tag 元数据恢复归属，不在 DUT 内维护
外部存储镜像。

## 7. GMEM 流水线

原始 GMEM LSU 逐 lane 扫描地址、逐 line 组织请求，并在一个大 FSM 中完成
coalesce、等待和结果放置。这种结构功能直接，但控制扇出大，而且固定扫描周期
不能利用外部 memory pipeline。

当前 `AecGmemPipeline` 将 load 拆分为以下阶段：

1. lane 地址按 4-lane bank 生成并检查对齐、范围和 space；
2. 相同 128 Byte line 的 lane 被合并为 line descriptor；
3. descriptor 分配内部 4-bit token，并送入 cache/外部引擎；
4. 多个普通 load line 可以同时 outstanding；
5. completion 通过 token 找回指令、line 和 lane word；
6. 结果按 bank 放置，最终形成 ROB completion。

这样在 cache 到 GMEM 路径插入 register/queue 时，不必等待每个 line 完整返回
才开始下一个 line，外部固定延时可由多个 outstanding 请求覆盖。store 和 atomic
没有盲目套用同样并发：store 先发无副作用 preflight read，确认所有活动 lane
均合法后再 replay write；atomic 按活动 lane 顺序完成 read-modify-write。
保守路径牺牲 cycle，但保证任一 lane 报错时不会留下部分写副作用。

## 8. 64 KiB Line Cache

当前 cache 为 64 KiB direct-mapped load cache，共 512 条 128 Byte line。
每条 line 使用 1 个 metadata SRAM 和 32 个 512x32 data SRAM word bank。
metadata 保存 valid、space 和 tag；data bank 让 1024-bit line 以 32 个 32-bit
word 存储，正好匹配锁定 SRAM 宏。

cache 采用显式的同步 SRAM 两级返回：

- L1 记录发起 lookup 的 request；
- L2 注册 metadata 和整条 line，再进行 hit/miss 判断；
- 4-entry miss descriptor queue 只保存窄字段；
- 2-entry completion queue 隔离 cache 返回和 LSU backpressure；
- store/atomic 使用单独 bypass holding register；
- fill 优先占用单端口 SRAM，lookup admission 不依赖 SRAM dataout；
- write completion 使对应 line 失效，避免读到旧数据。

设计中特别避免 `valid` 组合依赖下游 `ready`，也不让宏的 1024-bit dataout
直接参与请求 admission。这样既满足 Decoupled 协议，也切断了“SRAM 输出经
tag compare、大 mux 再回到 enable”的长组合环路。cache 没有 miss merging，
但 4 项 descriptor 队列和 16 个外部 tag 可并发处理独立 line。

## 9. 本地存储与 SRAM 使用

SMEM、CMEM 和 PMEM 由 local LSU 管理。byte store 使用显式 read-modify-write，
不在单端口 SRAM 上同时拉高 read/write。CMEM/PMEM preload 支持 byte strobe 并
记录容量高水位；SMEM 在 launch 时通过 valid metadata 提供逻辑清零，因为锁定
宏没有 reset。

大容量、规则阵列使用官方 SRAM wrapper；小型控制状态、ROB、scoreboard、
queue pointer、tag table 和 cache 初始化 metadata 使用寄存器。该划分避免把
极小数组强制推成 SRAM 带来额外端口/时序成本，也避免把 64 KiB cache 和完整
寄存器文件展开成大量触发器。官方 wrapper、行为模型、Liberty 和 LEF 未修改。

## 10. 正确性与 PPA 的总体取舍

提交版的核心思想不是追求所有模块最大并行，而是在综合可完成的规模内保留最
有效的并行：两个 warp 交织、每 warp 4 项 ROB、按操作类别独立后端、普通 load
多 outstanding。对最难保证精确性的 store、atomic 和 conversion 则选择串行。

这一取舍使公开用例保持 36/36，通过本次候选包重跑共 20,936 cycle；相比此前
2-warp 基线 21,178 cycle 减少 242 cycle。对应 PPA 数据和提交参数见
`PPA.md` 与 `LIMITATIONS.md`。
