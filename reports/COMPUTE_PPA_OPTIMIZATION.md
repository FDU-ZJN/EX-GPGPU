# FPU、SFU 与 INT 时序优先 PPA 优化评估

> 以 250 MHz（4,000 ps）为目标的实施顺序、回退门槛和复现命令见
> [`COMPUTE_250MHZ_TIMING_PLAN.md`](COMPUTE_250MHZ_TIMING_PLAN.md)。该计划使用本评估
> 的开源项目选择，并纳入了后续 `ppa_250mhz_*` 实验结果。

## 1. 结论摘要

本评估以当前 RTL、现有 ASAP7 单元级报告和 `local/` 中锁定的开源源码为依据，
参考可信度按项目要求采用：XiangShan/YunSuan > FPUv2/fudian > Berkeley
HardFloat > Ventus。现阶段最合理的实施顺序如下。

1. **先修 INT warp wrapper 的控制扇出，再换算术核。** 当前 INT 最差路径主要是
   跨 16 个物理 lane 的共享控制网，而不是 32 位加法器。应先做 4-lane cluster
   本地状态和寄存化 issue/retire；否则移植更快的 ALU 或乘法器不会提高 Fmax。
2. **FP32 保持现有 FPUv2/fudian 主干。** 当前单元级 Fmax 为 259.33 MHz，是四类
   单元中余量最大的。继续增加流水级的收益有限，且 16 lane 面积已经最大。
3. **FP64 优先评估 XiangShan/YunSuan `FloatFMA`，但先做隔离式 A/B top。** 当前
   FP64 只有 116.22 MHz，关键路径进入 FMA 内部。YunSuan 的 Booth/CSA 和显式
   多级寄存结构更适合时序优先目标，但不能在没有独立综合与 bit-exact 验证前
   直接替换现有后端。
4. **SFU 的第一移植目标是 XiangShan 高基数 DIV/SQRT 和乘法压缩树。** 当前
   HardFloat 小型 DIV/SQRT 使用 53 位核统一处理 f32/f64，且配置为每周期 1 bit；
   `SIN/COS/EXP/LOG` 又使用 48-cycle 串行乘法器。它们的延迟直接放大评分公式中的
   execution cycles。SFU 只有一个物理 lane，可以接受适度面积增长来换取 Fmax 和
   周期数。
5. **INT 的 MUL、shift、bitfield 不应继续使用逐 bit/逐级串行实现。** 建议分别
   改为 2 级 Booth/Wallace、2 级 barrel shifter、2 至 3 级 bitfield datapath。
   其中乘法器优先抽取 XiangShan `ArrayMulDataModule`；普通 ALU 只借鉴 Ventus 的
   简洁组合结构，不建议移植完整 Ventus execution pipeline。

在没有新一轮同口径 ASAP7 A/B 数据前，本文不声称任何候选已经改善 PPA。下文的
收益判断是基于结构、现有关键路径和算法迭代次数的工程预期。

## 2. 当前实现和测量基线

现有 `reports/UNIT_TIMING_ASAP7.md` 使用 Yosys/ABC/OpenSTA 和 ASAP7 RVT TT NLDM，
在 10 ns 约束、层次化 mapping 下得到：

| 单元 | 物理 lane | 面积 (um2) | 关键路径 (ps) | Fmax (MHz) | 判断 |
|---|---:|---:|---:|---:|---|
| INT32 | 16 | 12,424.23 | 8,678.04 | 115.23 | 共享控制扇出主导 |
| FP32 | 16 | 34,797.18 | 3,856.05 | 259.33 | 暂不优先替换 |
| FP64 | 2 | 14,602.34 | 8,604.27 | 116.22 | FMA 内部长组合路径 |
| DIV/SFU | 1 | 6,933.31 | 8,262.13 | 121.03 | 迭代算术、归一化和打包混合路径 |

这些结果是理想时钟、无提取线延迟的综合级数据；没有 activity VCD，因此 power
和完整 `ppa_valid` 仍为 false。它们可以用于相同 flow 内的相对比较，不能作为
signoff 数据。

当前开源代码接入情况：

| 当前目录/模块 | 实际来源 | 本地差异 |
|---|---|---|
| `rtl/src/main/scala/FPUv2` | `local/fpuv2` | 除 `FMA.scala` 外基本一致；FMA 已增加流水和 backpressure cut |
| `rtl/src/main/scala/fudian` | FPUv2 的 fudian submodule | `FADD/FCMA/FMUL` 已有本项目修改 |
| `rtl/src/main/scala/hardfloat` | Berkeley HardFloat | 基本原样，`primitives.scala` 有本项目修改 |
| `AecIntAlu/AecIntDivider` | 本项目实现 | divider 仅参考 Ventus 的多周期组织，并非直接拷贝 |
| `AESSFU` | 本项目集成 | HardFloat DIV/SQRT + 自研 transcendental |

因此，“移植 FPUv2/HardFloat”在很大程度上已经完成。后续真正新增的高价值来源是
较新的 XiangShan/YunSuan 算术核。

## 3. 参考项目评估

### 3.1 XiangShan / YunSuan

锁定版本为 XiangShan `8a42e727cc58db2b00d4bb2de7b397355f89257c`，其 YunSuan
submodule 为 `447cd17b1637f998daeb6be3efcd4890f48cb2b9`。

可用设计：

| 候选 | 上游文件 | 优点 | 主要适配成本 | 建议 |
|---|---|---|---|---|
| 混合精度 FMA | `yunsuan/fpu/FloatFMA.scala` | Booth partial product、CSA 压缩树、显式多级寄存；支持 f16/f32/f64 | 约 1,138 行；依赖 YunSuan opcode/util/vector helper；上游为 Chisel 6.6，本项目为 3.5.6；固定 `fire` 接口需包成 Decoupled | FP64 首选 A/B；FP32 仅在面积可接受时考虑 |
| FP adder | `yunsuan/fpu/FloatAdder.scala` | far/close path 分离、格式专用 pipeline | 文件和 helper 较多；语义、NaN boxing 与 AEC 需要适配 | 可作为 ADD/SUB 独立 pipe，优先级低于 FMA |
| FP DIV | `yunsuan/fpu/FloatDivider.scala` | 高基数 SRT/QDS、早停、格式相关迭代数 | 约 1,719 行并依赖 sqrt/vector 包；接口复杂 | SFU 中高收益、高风险候选 |
| FP SQRT | `yunsuan/fpu/fqrt/fpsqrt_r16.scala` | radix-16，f32 约 6 次主迭代、f64 约 13 次 | 约 784 行，QDS/CSA helper 较多 | 与 FP DIV 一起移植，不单独散改 |
| INT DIV | `xiangshan/backend/fu/SRT16Divider.scala` | 每轮生成多位商、早停和特殊值旁路 | 依赖 XiangShan utility/CSA/CDE；原文件按 64 位系统接口组织 | 抽取纯 datapath 为 32 位 AEC adapter |
| Booth/Wallace MUL | `xiangshan/backend/fu/Multiplier.scala` | 两个寄存边界，成熟 partial-product compressor | 依赖 `C22/C32/C53` 和 `SignExt`，但依赖范围可控 | INT MUL 和 SFU 48x48 乘法的首选来源 |

不能把整个 XiangShan backend 作为依赖引入。正确做法是保留上游版权头，复制最小
闭包到独立 package，并用 AEC adapter 隔离 opcode、valid/ready、flush 和 flags。

### 3.2 FPUv2 / fudian

锁定 FPUv2 版本为 `8bb935f065b53bb409a50d7a76523e965ec3decf`，fudian submodule
为 `2dfaac60c32c8de46087cc9b9d3de3fe6f095760`。当前 FP32/FP64 已使用该设计，且
为满足 100 MHz 已在 `FMA.scala` 和 fudian adder 内加入额外寄存边界。

继续使用它的优势是接口和 Chisel 版本最匹配，回归风险最低。短期应继续做：

- 对 FP64 关键路径按 far path、near path、round/pack 分段，而不是继续增加 wrapper FSM；
- 保留 FP32 原结构，避免 16 lane 同时承担一次大面积替换；
- 复核当前 overflow 修补逻辑，最终应把语义修复放入 pipe 内，避免 retirement mux
  重新形成高扇出或长路径。

局限是当前 FMA 已偏离上游，后续修改必须靠本项目 differential tests 维护；此外
FPUv2 顶层 checkout 未发现明确的根 LICENSE 文件。正式分发前必须确认其许可来源，
不能仅依据代码可见或 GitHub 可访问就认定可再分发。

### 3.3 Berkeley HardFloat

锁定版本为 `0ecaef097ce2accbd16a61613699450ed5533f29`，BSD 3-Clause。
HardFloat 的最大价值是 IEEE-754 recoded format、特殊值处理、rounding 和参考语义，
不一定是最高频率实现。

当前 `DivSqrtRecFNToRaw_small(11, 53, 0)` 的 `options=0` 表示每周期 1 bit。上游提供
`divSqrtOpt_twoBitsPerCycle=16`，可直接形成一个低成本 A/B 候选：

- 预期约减半主迭代周期；
- 每周期组合逻辑加深，可能降低 SFU Fmax；
- 必须分别测 `options=0` 和 `options=16` 的 Fmax、area、DIV/SQRT cycles，按
  `fmax / cycles` 而不是单看 Fmax 决策。

HardFloat 不提供 `SIN/COS/EXP/LOG`，不能解决 transcendental engine 的主要周期数。

### 3.4 Ventus

锁定版本为 `681172541a8a34ffb43c483a19c075acbc11a4eb`。Ventus 与本项目同为 GPU，
Decoupled 风格和 warp execution 集成最接近，但算术核较旧：INT divider 为低基数
迭代结构，FP32 DIV/SQRT 为 radix-4 SRT。适合用作简单可靠的接口参考，不适合作为
追求最高时序/吞吐的最终算术核。

可复用部分主要是 `ScalarALU` 的共享 add/sub/compare 和左右移位组织，以及
`FloatDivSqrt` 的特殊值/归一化状态划分。完整 execution pipeline 不应移植。

## 4. 分单元优化方案

### 4.1 INT

当前最差路径中，一个 x1 inverter 驱动约 1.17 pF，单级延迟约 4.60 ns，下一共享
级又消耗约 3.19 ns。该现象证明第一优先级是物理层次友好的控制复制。

| 优先级 | 改动 | 来源 | 时序/周期预期 | 面积风险 |
|---|---|---|---|---|
| P0 | 16 lane 划为 4 个 4-lane cluster；cluster 本地寄存 `issue/ready/retire`，顶层只汇总 4 个信号 | 本项目结构优化 | 直接针对当前最差路径；目标先达到 200 MHz 级单元余量 | 少量控制寄存器 |
| P1 | 32-cycle shift-add MUL/MAD 替换为 2-stage Booth/Wallace | XiangShan `ArrayMulDataModule(32)` | MUL 约从 32 cycle 降至 2 至 3 cycle；关键路径由寄存切分控制 | 16 lane 全复制时面积显著增加 |
| P1 | 5-cycle shift 改为两级 barrel shifter | Ventus ALU 结构参考 | shift 由 5 cycle 降至 2 cycle | 小幅增加 mux 面积 |
| P1 | BFX/BINS 改为寄存化 mask/shift/merge | 本项目实现 | 最坏不再随 lsb/width 线性增长，目标 2 至 3 cycle | 中低 |
| P2 | AEC INT DIV 接入 32-bit SRT16 | XiangShan | 主迭代约按 4 bit/cycle 下降，并有特殊值旁路 | 中高；只在 SFU 单 lane 实例化 |

乘法器不要一开始就复制 16 份。先综合 1、4、16 个实例的面积和 Fmax，再结合公开
case 中 MUL/MAD 占比选择。若面积主导，可让每个 4-lane cluster 共享 1 个乘法器；
若 benchmark 由 GEMM 主导，则应保留每 lane 乘法吞吐。

### 4.2 FPU

FP32 当前 259.33 MHz，优先动作是保持功能稳定并减少不必要的格式转换实例。FP64
当前 116.22 MHz，应并行比较两条路线：

| 路线 | 内容 | 优点 | 风险 | 决策门槛 |
|---|---|---|---|---|
| A：继续重定时 FPUv2 | 在现有 far/near、CSA、round/pack 间增加真正的 elastic cut | 改动小，现有 differential tests 可直接复用 | 可能接近原结构上限 | FP64 >= 200 MHz，面积增幅 <= 20% |
| B：移植 YunSuan FMA | 最小闭包 + `AecFpPipeCtrl` adapter；先只用于 2 个 FP64 lane | 更成熟的高性能结构，可直接利用 Booth/CSA pipeline | Chisel 6 -> 3.5 backport、接口和 IEEE corner case 适配工作量大 | bit-exact 全过，Fmax/area 明显优于路线 A |

不建议立即让 YunSuan 的 64-bit mixed-format FMA 覆盖全部 16 个 FP32 lane。即使单核
Fmax 更高，也可能因格式复用逻辑导致总面积和功耗显著上升，降低 Perf/Area 和
Perf/Watt。

### 4.3 SFU

当前 SFU 有三个独立问题：

1. f32 也先扩成 53-bit，再进入同一个 HardFloat DIV/SQRT 核；
2. RSQ 先做 SQRT 再做 DIV，完整执行两次迭代核；
3. transcendental 每次 48x48 乘法需要 48 cycle，一个函数又串行执行多次乘法。

建议方案：

| 优先级 | 改动 | 参考来源 | 预期 |
|---|---|---|---|
| P0 | 把 `packQ34` 的 LZC、动态 shift、round/pack 拆成两个寄存阶段 | 本项目 | 直接缩短当前 8.26 ns 混合路径 |
| P0 | 48x48 串行乘法器替换为 2 至 3 级 Booth/CSA；仅保留 Q34 所需 product slice | XiangShan multiplier | 每个 polynomial step 从约 48 cycle 降到固定少量 cycle；SFU 仅一份，面积可控 |
| P1 | 独立 f32 DIV/SQRT 高基数核，f64 暂保留 HardFloat | XiangShan/YunSuan | 避免所有 f32 操作承担 53-bit datapath；优先改善占比更高的 f32 SFU |
| P1 | A/B HardFloat 1-bit 与 2-bit/cycle 配置 | HardFloat | 最小代码改动，验证 latency/Fmax 折衷 |
| P2 | `.approx` RCP/RSQ 使用 estimate + 0/1 次 Newton，`.full` 保留精确路径 | XiangShan `Estimate7` 仅作初值参考 | 利用 ISA 对 approx 的宽松容差，减少 cycles |
| P2 | 全量移植 YunSuan FP DIV/SQRT | XiangShan/YunSuan | 当独立 f32 路线验证后，再评估统一替换 |

四个参考项目均没有可直接移植的 `SIN/COS/EXP/LOG` 完整实现。当前多项式和 range
reduction 仍需本项目维护。可借用 XiangShan multiplier/LZC/shift primitives，不能
宣称 transcendental 整体来自 XiangShan。

## 5. 推荐实施批次

### Batch 1：低风险时序修复

- INT 4-lane cluster 控制寄存化；
- SFU `packQ34` 两级切分；
- HardFloat `options=0/16` 双配置单元级 A/B；
- 保持所有现有算术算法和接口不变。

### Batch 2：吞吐关键算术替换

- 抽取 XiangShan `ArrayMulDataModule` 的最小依赖闭包；
- 先替换单实例 SFU 48x48 multiplier；
- 再评估 INT 32-bit multiplier 的 4/16 实例配置；
- 同时把 shift 和 bitfield 改为固定级数 pipeline。

### Batch 3：高风险高收益移植

- 建立 YunSuan FP64 FMA 独立 top，与现有 FPUv2 FP64 同向量对比；
- 建立 YunSuan f32 DIV/SQRT 独立 top，与 HardFloat 和 Ventus 三方对比；
- 只有在功能、Fmax、area、cycles 四项均有数据后才接入 `AESSFU`/warp wrapper。

## 6. A/B 验证与接受标准

每个候选必须使用同一 revision、同一 RTL top、同一 `PERIOD_PS` 搜索方法和同一
ASAP7 库。至少保存：`ppa_summary.txt`、`checks.rpt`、`design_area.rpt`、
`metadata.txt`、mapped netlist 和测试日志。

| 项目 | 必须满足 |
|---|---|
| Correctness | FP32/FP64 bit-exact differential 全过；SFU normal finite <= 4 ULP；特殊值符合 spec |
| Backpressure | 随机 ready/valid stall、连续 issue、输出保持和 reset/flush 全覆盖 |
| Timing | 无 unconstrained endpoint、loop、multiple driver；以二分 period 得到有效 Fmax |
| Area | 报告 standard-cell area；比较单实例和实际 lane 复制后的总面积 |
| Cycles | 分别记录 ADD/MUL/FMA/DIV/SQRT/RSQ/transcendental 的 request-to-response latency 和 steady-state initiation interval |
| Power | 最终候选必须用相同 workload VCD；无 VCD 时不得声称 Perf/Watt 改善 |

推荐用下式做候选排序，而不是仅按单元 Fmax：

```text
unit_score_proxy = fmax_mhz / (cycles_per_warp * area_um2)
```

该 proxy 不替代正式评分，只用于在相同功能和 lane 数下排除“频率略升但周期/面积
大幅恶化”的方案。

## 7. 许可证与可复现性

| 来源 | 许可证/状态 | 移植要求 |
|---|---|---|
| XiangShan/YunSuan | Mulan PSL v2 | 保留源文件版权和免责声明，随分发提供许可证副本，记录精确 commit |
| Berkeley HardFloat | BSD 3-Clause | 保留版权、条件和免责声明；当前仓库已有 `hardfloat/LICENSE` |
| Ventus | 主项目 Mulan PSL v2，部分继承文件另有 Apache/BSD 标识 | 按具体源文件 SPDX/版权头处理，不能只引用顶层许可证 |
| FPUv2/fudian | 本地 FPUv2 顶层未发现明确 LICENSE | 在确认上游许可前，不新增来自该 checkout 的拷贝；已有代码也应补做合规审计 |

每次移植应在报告中记录：上游 URL、commit、原始文件列表、本地修改摘要、生成命令
和验证命令。禁止只复制生成后的 SystemVerilog 而不保留可复现的 Chisel 源码和
生成入口。
