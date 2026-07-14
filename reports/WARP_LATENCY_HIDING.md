# Warp Latency Hiding 流水线调度设计

> 日期：2026-07-14  
> 状态：depth-4 ROB、tagged completion、load overlap 已实现
> 基线：当前 `AecEvalTop`、32-bank vector GPR、4 个固定 partition、每 partition 2 个 warp

## 实施结果（2026-07-14）

- 每warp加入depth-4 ROB和`{warp,epoch,sequence,robIndex,pc}` tag；backend可乱序完成，
  GPR/predicate和error只从ROB head顺序提交。
- INT、FP32、FP64、SFU、GMEM和共享Local LSU接受请求后释放frontend FSM，等待响应时
  sibling warp和同warp无依赖指令可继续issue。
- 64-bit pair在commit端锁定两个cycle；source-use scoreboard覆盖GPR pair和predicate
  RAW/WAW；control、barrier、store和atomic保持serializing。
- GMEM/Local load可与年轻独立计算重叠；store/atomic仅在本warp ROB为空时执行，避免
  speculative memory side effect。
- 为避免复制宽向量operand，本版保留每partition一个collector，而不是建议稿中的两个
  slot/多组backend request queue。公开回归几何平均cycles降至旧RTL的94.90%，因此暂不
  为额外queue支付面积和高扇出代价。
- manifest回归与in-process realtime differential均为36/36。代表变化：GEMM
  `1090 -> 959`、DIV `617 -> 573`、SYNC.CT `1077 -> 889`、partial warp
  `539 -> 465`。

后续可选优化仅包括tagged连续GPR read、第二collector slot和同partition多条GMEM
instruction queue；这些不是当前正确性所需，且应在完整PPA后决定。

## 1. 目标与非目标

当前每个 partition 只有一个 `pipeState` 和一份 `held` instruction。指令一旦进入
operand collection，整个 partition 会一直被占用到 execution、memory 和 writeback
完成；同 partition 的另一个 warp 即使完全 runnable，也不能执行。因此 FP64、DIV/SFU
或 GMEM 的长延迟会直接转化为 scheduler 空转。

本设计的目标是：

- 一个 warp 等待执行单元或 memory response 时，立即调度另一个 ready warp；
- operand read、不同 execution backend 和 writeback 可以流水重叠；
- 同一 warp 允许多条互不依赖的普通指令在途；
- 保持 per-warp program order、精确异常、predicate/active mask、barrier 和 memory
  ordering 语义；
- 继续使用当前每 partition 32 个 512x32 lane banks，不增加 GPR 数据副本；
- 先利用现有 8 个 resident warps，不要求多个 CTA 同时驻留。

本设计不要求第一版达到每周期 issue 一条 warp instruction，也不要求投机执行跨越
branch、barrier、MBAR、store 或 atomic。正确、可回压和无死锁优先。

## 2. 当前阻塞点

当前路径为：

```text
select warp
   -> fetch/decode
   -> read A
   -> read B
   -> read C
   -> optional pair-high reads
   -> dispatch
   -> wait backend/LSU
   -> vector writeback
   -> PC+1, warp runnable
```

主要阻塞原因：

1. `partitionFree = pipeState === pipeIdle`，同 partition 两个 warp 不能交叠。
2. `held(s)`、operand buffer 和 writeData 每 partition 只有一份，无法区分多条指令。
3. Execution request/response 直接连接 FSM，没有独立 request/result queue。
4. PC 在 retirement 才推进；没有 fetch PC 与 commit PC 的区分。
5. Scoreboard 虽然存在，但当前一条指令在途使其无法发挥 latency hiding 价值。
6. GMEM LSU 和 Local LSU 完成前都占住 partition pipeline。
7. 没有 per-warp sequence、ROB 或 completion tag，不能安全接收乱序完成结果。

## 3. 推荐总体数据流

```text
                     per-partition (2 warps)

 Warp context 0 ----+                         +--> INT request queue --> INT
                    |                         |
 Warp context 1 ----+--> issue scheduler --> operand collector
                              |               |
                              |               +--> FP32 request queue --> FP32
                              |               +--> FP64 request queue --> FP64
                              |               +--> SFU request queue  --> SFU
                              |               +--> LSU request queue  --> LSU
                              |               +--> CVT request queue  --> CVT
                              |
                 32-bank vector GPR
                              ^
                              |
 backend completions --> completion router --> per-warp ROB/result slots
                                                |
                                                v
                                     in-order commit arbiter
                                                |
                                                v
                                      vector GPR/predicate WB
```

四个 partition 仍然互相独立，各管理固定两个 warp 和一套 GPR/执行资源。这样避免增加
跨 partition GPR crossbar；每个 partition 内通过 queue 和 tag 实现重叠。

## 4. Warp Context 与状态拆分

当前单一 `warpState` 应拆成更具体的状态，而不是普通指令 issue 后直接 blocked：

```scala
class WarpContext extends Bundle {
  val fetchPc = UInt(32.W)
  val epoch = UInt(4.W)
  val halted = Bool()
  val controlBlocked = Bool()
  val barrierBlocked = Bool()
  val outstanding = UInt(4.W)
  val nextSequence = UInt(6.W)
  val retireSequence = UInt(6.W)
}
```

Warp 可 issue 的条件建议为：

```text
active
&& !halted
&& !controlBlocked
&& !barrierBlocked
&& issue queue/ROB 有空间
&& source scoreboard ready
&& destination free
&& 目标 backend queue ready
```

普通 ALU/FP/Load 指令进入 operand collector 后，warp 保持可调度；只有真实 dependency、
结构冲突或 serializing instruction 才阻塞它。

## 5. Instruction Tag 与 Metadata

所有离开 decode/issue 的事务必须携带完整 tag，不能继续依赖唯一的 `held(s)`：

```scala
class AecInstructionTag extends Bundle {
  val partition = UInt(2.W)
  val warpLocal = UInt(1.W)
  val warp = UInt(3.W)
  val epoch = UInt(4.W)
  val sequence = UInt(6.W)
  val pc = UInt(32.W)
}
```

Issue packet 至少还应保存：

```text
raw instruction / opcode / dtype / subop / ext
executeMask
dest / destHi / predicate destination
usesSrcA/B/C
srcA/B/C pair flags
backend class
isStore / isAtomic / isControl / isSerializing
```

Execution request、LSU request、result packet 和 debug commit 都携带相同 tag。Completion
只有在 `packet.epoch == warpContext.epoch` 时才有效；abort、flush 或新 CTA 可以通过
增加 epoch 丢弃旧 completion。

## 6. Fetch、Decode 与 Issue Scheduler

### 6.1 Fetch

每 partition 保留一个 IMEM read port，并为两个 warp 各设置 1--2 entry instruction
buffer。Fetch arbiter round-robin选择未 blocked 且 instruction buffer 未满的 warp。

同步 IMEM response 必须带 `{warpLocal, pc, epoch}`，避免 response 返回时 warp选择已经
变化。

### 6.2 Decode

Decode 生成 source-use mask，避免当前所有指令固定读取 A/B/C：

| 指令类型 | GPR vector read |
|---|---:|
| LOADI/RDTSC/CPY special | 0 |
| unary/LD address | 1 |
| binary/ST/ordinary ATOM | 2 |
| MAD/FMA/CAS | 3 |
| 64-bit source pair | 每个 source 再增加 high-word read |

若两个 source register 相同，可读取一次后在 operand slot 内复制。

### 6.3 Issue policy

每周期在两个 warp 的 instruction-buffer head 中选择 oldest-ready。推荐策略：

1. 优先避免某个 warp 长期饥饿；基本 round-robin 即可。
2. 只有 ROB entry、operand slot 和目标 backend queue 都可分配时才 issue。
3. Issue 时原子地 reserve scoreboard destination、分配 sequence/ROB entry并推进
   `fetchPc`。
4. Control/serializing instruction 采用第 12 节的特殊规则。

第一版可限制每周期每 partition 最多 issue 一条。

## 7. Vector GPR 与 Operand Collector

继续使用当前映射：

```text
bank = lane_id
row  = {warpLocal, regIndex}
```

32 个 bank 同周期返回完整 warp 的一个 source。需要修改当前 GPR handshake，使同步
SRAM可以连续接受 read request：

```text
cycle N   : request srcA of instruction X
cycle N+1 : response srcA(X), request srcB(X)
cycle N+2 : response srcB(X), request srcA(Y)
```

当前 `pending` 结构在 response 周期禁止新 request，会人为插入 bubble。可改成：

- 一级 registered response tag；
- response 后接 1--2 entry skid queue；
- queue 满或本周期 vector writeback 时才停止 read。

Operand collector 建议使用 2 个 slot/partition：

```scala
class OperandSlot extends Bundle {
  val valid = Bool()
  val tag = new AecInstructionTag
  val issue = new AecIssueMetadata
  val needMask = UInt(6.W) // A/B/C/AHi/BHi/CHi
  val operands = Vec(6, Vec(32, UInt(32.W)))
}
```

Collector轮流为slot发vector read；一个slot收齐实际需要的source且backend queue ready
后立即dispatch并释放slot。Collector不等待execution completion。

## 8. Backend Request Queue

每个 partition 的后端前增加小队列：

| Backend | 建议request queue深度 | 原因 |
|---|---:|---|
| INT | 2 | 常用、短延迟 |
| FP32 | 2 | 两个16-lane groups |
| FP64 | 2 | 16个2-lane groups，长延迟 |
| DIV/SFU | 2 | 最长延迟，必须尽早释放scheduler |
| GMEM LSU | 2--4 | 等待32-cycle memory response |
| Local LSU | 2 | 共享资源、延迟长 |
| CVT/special | 2 | 当前逐 lane转换 |

执行单元可以保持现有 warp-wide request 接口和内部 physical-lane grouping；关键是其
request/response不再直接占有 partition FSM。

每个 backend response 进入 completion queue，不直接写 GPR。队列必须保留完整 tag、
lane mask、result、predicate、flags 和 error。

## 9. Per-warp ROB 与精确异常

允许同一 warp 多条独立指令在途后，各后端会乱序完成。例如后发的 INT ADD 可能早于
先发的 DIV 完成。为维持 program order，需要每 warp 一个小型 ROB。

建议初始深度 4：

```scala
class WarpRobEntry extends Bundle {
  val valid = Bool()
  val ready = Bool()
  val tag = new AecInstructionTag
  val dest = UInt(8.W)
  val destHi = Bool()
  val laneMask = UInt(32.W)
  val predicateWrite = Bool()
  val predicate = UInt(3.W)
  val resultSlot = UInt(resultSlotWidth.W)
  val error = Bool()
  val sideEffect = UInt(2.W) // none/store/atomic/control
}
```

为避免每个 ROB entry 复制 `32x64` result，建议使用共享 result-slot RAM/register bank，
ROB只保存slot指针。每 partition 4--8 个 result slots 即可。

Completion router按 `{warpLocal, sequence, epoch}` 找到ROB entry并置ready。Commit arbiter
只允许各 warp 的ROB head退休；不同warp之间可以round-robin commit。

### 9.1 Error规则

若ROB head记录error：

1. 不写GPR/predicate，不执行该指令side effect；
2. 停止该warp及kernel的新issue；
3. 增加warp/kernel epoch，使更年轻completion失效；
4. 清除更年轻ROB、operand slot和backend queue entry；
5. 等待已接受的external transaction安全drain；
6. 返回 INVALID 或 EXEC_ERROR。

这要求side-effecting指令不能在到达ROB head之前修改架构memory。

## 10. Vector Writeback 与 Commit

每 partition 每周期最多提交一条32-bit destination：

```text
ROB head ready
   -> commit arbiter grant
   -> 32 lane banks parallel write
   -> scoreboard release
   -> result slot free
   -> ROB head pop
   -> debug commit
```

Pair destination锁定两个连续周期：

```text
cycle W0: R[d]
cycle W1: R[d+1]
then retire
```

在W1之前scoreboard不能release该pair。Predicate独立使用寄存器写口；若实现允许，可与
无GPR写回冲突的cycle并行。

因为官方SRAM是1RW，vector writeback与operand read冲突。第一版使用writeback优先：

```text
pair-high > oldest ROB head writeback > operand collector read
```

Result queue/ROB提供缓冲，避免execution unit直接被GPR端口反压。后续可以在写mask与
read lane banks不相交时做per-bank并发，但不是第一版要求。

## 11. Scoreboard语义

Scoreboard在issue时reserve，在commit完成后release：

- RAW：任何source或source pair busy时不issue；
- WAW：destination或destination pair busy时不issue；
- Predicate RAW/WAW同理；
- WAR不需要跟踪，因为operand在issue后不一定立刻读完，必须保证更年轻write不能在
  更老read完成前发生。最简单做法是：ROB按序commit天然阻止同warp年轻write提前；
  若未来允许更激进commit，则需显式read-complete token。

当前 scoreboard 的source检查必须配合source-use mask，否则 unused source会造成假
dependency。

可选 forwarding：backend completion可直接转发给等待的operand slot，但第一版可以
等commit后再从GPR读取，控制更简单。

## 12. Control、Barrier 与 Serializing Instruction

第一版不要跨以下指令投机issue：

### 12.1 BR/BRX/CALL/RET

- 只有该warp更老ROB entry全部commit后才执行；
- 设置 `controlBlocked`，停止后续fetch/issue；
- resolve后更新fetchPc/call stack并解除阻塞；
- 不需要为错误路径做复杂instruction flush。

### 12.2 HALT

HALT必须等待该warp更老ROB entry和memory side effect全部完成，然后标记halted。CTA
completion还必须检查所有partition queue、ROB和external outstanding为空。

### 12.3 SYNC.CT

Warp到达barrier前必须：

- 更老ROB全部commit；
- 更老store/atomic完成；
- operand/backend/result queue中没有该warp旧事务。

随后置 `barrierBlocked` 并提交4路arrive。Release时设置下一PC并解除对应warp。

### 12.4 MBAR

MBAR作为per-warp memory fence：等待该warp更老memory outstanding归零后退休。不能再
依赖“LSU instruction-serial，所以此前访问必然完成”的隐式假设。

## 13. Load、Store 与 Atomic

### 13.1 Load

Load可以在ROB head之前发往memory，因为它只填result slot，不产生架构写副作用。
Response携带tag，完成后置对应ROB entry ready；GPR仍只在commit时更新。

### 13.2 Store

为了精确异常和program order，第一版将store视为commit-gated：

1. issue/operand collect后生成store descriptor，放入ROB/Store Queue；
2. 地址和line-group preflight可以提前执行，但不发有副作用的write；
3. 只有store成为ROB head且所有preflight成功时，授权LSU发write；
4. 等所有write completion后store退休。

这样年轻store不会越过更老的DIV、load error或control instruction。

### 13.3 Atomic

Atomic同样commit-gated。Preflight可提前按line聚合，但实际RMW必须在ROB head、取得
atomic ownership后按ascending lane ID执行。完成的old values进入result slot，全部
RMW成功后才能GPR writeback和retire。

### 13.4 Outstanding counters

至少维护：

```text
per-warp issued memory count
per-warp committed store/atomic count
per-CTA outstanding count
global external tag count
```

MBAR、SYNC.CT、HALT、CTA切换和kernel result分别检查对应scope的counter。

## 14. Local LSU

当前Local LSU为四个partition共享且一次处理一条instruction。第一版可以保持其内部
serialized/aligned-fast-path设计，但必须在入口和出口增加tagged queue：

```text
partition local request queues
          -> round-robin arbiter
          -> Local LSU
          -> tagged completion router
```

等待Local LSU时只阻塞发出该请求的ROB entry，不阻塞整个partition。Store/atomic仍按
第13节commit-gated。后续再考虑SMEM banking和多lane并行。

## 15. 调度示例

假设warp 0执行GMEM load，warp 1执行独立INT指令：

```text
cycle    scheduler/collector       INT             LSU             commit
-----    -------------------       ---             ---             ------
  0      W0 read address
  1      W0 dispatch load                          coalesce
  2      W1 read srcA                              mem wait
  3      W1 read srcB                              mem wait
  4      W1 dispatch ADD           group 0         mem wait
  5      W1 next instruction       group 1         mem wait
  6                              ADD complete       mem wait
  7                                                              W1 ADD WB
 ...      W1 continues                              mem wait
 34                                                  load done
 35                                                              W0 load WB
```

当前架构在cycle 2--34会因W0 load占住partition而无法执行W1；新架构用W1及同warp其他
独立指令覆盖memory latency。

## 16. 公平性、回压与无死锁规则

1. Warp issue、Local LSU、GMEM request和commit仲裁均使用round-robin或oldest-ready，
   禁止固定PriorityEncoder长期饿死高编号请求。
2. Backend只有在result/completion queue有保留空间时才能接受request，避免完成后无法
   回压导致环形等待。
3. Operand slot只有在ROB entry已分配后才能发起read。
4. Store/atomic只有在ROB head时才能取得side-effect授权。
5. Pair writeback一旦开始必须锁定两个cycle。
6. Flush时使用epoch使无法物理撤回的completion变成无效，而不是等待它写入错误warp。
7. CTA切换必须检查ROB、operand slots、backend queues、Local LSU和external tags都为空。

## 17. 建议Chisel模块拆分

不要继续把所有逻辑增加到 `EvalTop.scala`。建议拆分：

```text
frontend/WarpContext.scala
frontend/FetchQueue.scala
frontend/PartitionScheduler.scala
frontend/OperandCollector.scala
frontend/WarpRob.scala
frontend/CompletionRouter.scala
frontend/WritebackArbiter.scala
frontend/MemoryOrderTracker.scala
frontend/RegisterFile.scala
```

执行接口调整：

```text
AecExecRequest  += tag
AecExecResponse += tag
AecLocalMemoryRequest += tag
AecLineRequest / completion metadata += instruction sequence or table index
```

顶层只负责：launch/CTA lifecycle、四个partition实例、共享Local LSU、external memory
adapter、barrier和结果接口。

## 18. 分阶段实现计划

### Phase 1：仅跨warp latency hiding

- 每 warp最多1条未退休普通指令；
- 为执行单元/LSU增加request/result queue和tag；
- instruction dispatch后释放operand collector；
- scheduler可运行另一个warp；
- 不需要同warp多entry ROB，只需每warp一个completion slot。

验收：warp 0等待GMEM/SFU时warp 1持续产生commit；结果与CModel一致。

### Phase 2：同warp多条独立指令在途

- 增加depth-4 ROB、sequence和source-use scoreboard；
- PC在issue推进；
- completion乱序、commit顺序；
- control指令保持serializing。

验收：先发DIV、后发独立ADD，ADD允许先完成但只能按序retire。

### Phase 3：Memory overlap

- Load提前发出；
- Store Queue和commit-gated store；
- Atomic commit-gated RMW；
- per-warp/per-CTA outstanding counter；
- MBAR/SYNC/HALT按scope drain。

验收：多warp load overlap、store精确异常、atomic lane order和barrier visibility全部通过。

### Phase 4：吞吐与PPA优化

- GPR连续vector read及response skid queue；
- 调整各queue深度；
- backend/result forwarding；
- 增加GMEM多line outstanding；
- 依据VCD和STA缩减不必要的physical lanes或buffer。

## 19. 验证计划

### 19.1 定向功能测试

- warp 0 GMEM stall时warp 1 INT commit；
- warp 0 DIV stall时warp 1 load/store；
- 同warp RAW阻止年轻指令issue；
- 独立指令乱序完成、顺序commit；
- WAW、pair RAW/WAW和predicate dependency；
- result queue、operand queue和backend随机backpressure；
- pair writeback中间不能被读取；
- branch/CALL/RET前后ROB drain；
- barrier前store完成、release后访问可见；
- younger load error不能覆盖older commit，younger store不能提前产生副作用；
- abort/CTA切换后旧epoch completion被丢弃。

### 19.2 Assertions

建议加入：

```text
同warp commit sequence严格递增
未ready ROB entry不能commit
error entry不能write GPR/predicate/memory
scoreboard busy destination不能再次reserve
GPR同bank不能同周期read和write
pair low/high之间不能release scoreboard
store/atomic side effect必须来自ROB head
barrier arrive时该warp更老memory/ROB均为空
CTA result时所有queue和outstanding均为空
completion epoch不匹配时不能修改任何状态
```

### 19.3 性能计数器

为了判断latency hiding是否有效，仿真记录：

```text
warp issue count / cycle
partition idle cycles及原因
scoreboard RAW/WAW stall
operand collector busy/read-write conflict
backend queue full
ROB full/head-not-ready
GMEM/Local LSU wait cycles
commit bandwidth
每个warp active但未issue的cycles
```

Acceptance不应只看总cycles下降，还应确认长延迟期间其他warp确实在issue/commit。

## 20. PPA与实现取舍

Latency hiding会增加queue、ROB、tag和result-slot面积，但能够提高现有INT/FP/SFU资源
利用率。控制增长需要避免重新制造高扇出关键路径：

- ROB、operand slots和result slots按partition/warp局部化；
- queue valid/ready用小范围控制，不把单一global enable广播到32x64-bit数据阵列；
- result data按lane bank保存，metadata与data分离；
- scheduler readiness使用分层归约并在需要时插寄存器；
- 不用完整warp大Mux在多个backend之间直接组合，使用registered completion queue。

建议初始参数：

| 项目 | 初值 |
|---|---:|
| Warp/partition | 2 |
| ROB entries/warp | 4 |
| Operand slots/partition | 2 |
| INT/FP request queue | 2 |
| SFU/FP64 request queue | 2 |
| LSU request queue | 4 |
| Shared result slots/partition | 6 |
| Commit width/partition | 1 warp instruction/cycle |

最终深度应由public/hidden-like workload的stall统计和完整ASAP7 PPA决定，不应仅凭经验
继续加深。

## 21. 推荐结论

最稳妥的实现路线是先完成Phase 1：把当前“整条指令占住partition”的控制拆成tagged
request/result queue，使两个warp真正交错。随后以depth-4 per-warp ROB实现同warp独立
指令重叠，并把store/atomic改成commit-gated side effect。

核心不变量是：

> 可以乱序等待和乱序完成，但同一warp只能按序产生架构副作用；所有memory写、atomic、
> GPR/predicate写和error都必须在明确的commit点发生。

只增加warp round-robin而不增加tag、queue和commit ordering，无法实现安全的latency
hiding；只增加queue而让store/atomic提前产生副作用，也会破坏规范要求的精确异常和
program order。
