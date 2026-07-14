# 250 MHz 计算单元时序优化实施计划

## 1. 目标和边界

目标是在锁定的 ASAP7 RVT TT NLDM、`PERIOD_PS=4000`、层次化映射
（`PPA_FLATTEN=0`）下，使 INT32、FP32、FP64、DIV/SFU 四个单元和最终
`aec_eval_top` 均满足 250 MHz。单元级通过条件是关键路径不超过 4,000 ps、
worst slack 非负、TNS 为 0，且不存在 unconstrained endpoint、组合环或 unresolved
cell。由于当前结果是理想时钟、无布局布线寄生的综合级结果，内部实现以
3,800 ps 为收敛目标，保留约 5% 余量；4,000 ps 只是硬性验收线。

优化排序遵循评分公式 `throughput = work * fmax / cycles`。任何提高频率却明显增加
执行周期或面积的候选，都必须用 `fmax / (cycles_per_warp * area_um2)` 再比较，不能
仅按 Fmax 接受。无 activity VCD 时只能声称 timing/area 有效，不能声称完整 PPA 或
Perf/Watt 有效。

## 2. 已有数据和当前判断

以下结果来自 `rtl/reports/ppa_250mhz_*`，均使用 4,000 ps 约束。`best evidence`
表示已有报告中的最好检查点，不表示当前未提交 Scala 源码仍与该检查点完全一致。

| 单元 | 100 MHz 基线 | best evidence | best area (um2) | 距 4 ns | 决策 |
|---|---:|---:|---:|---:|---|
| INT32 | 8,678 ps / 115 MHz | 2,637 ps / 379 MHz | 12,696.70 | +1,363 ps | 已达标，冻结 |
| FP32 | 3,856 ps / 259 MHz | 3,915 ps / 255 MHz | 40,204.12 | +85 ps | 达标但余量不足 |
| FP64 | 8,604 ps / 116 MHz | 4,601 ps / 217 MHz | 15,957.65 | -601 ps | 第一优化重点 |
| DIV/SFU | 8,262 ps / 121 MHz | 6,230 ps / 161 MHz | 5,907.61 | -2,230 ps | 第二优化重点 |

FP64 的 stage 15/16 跌到约 17,954 ps / 55.7 MHz，证明“在 `FarPath`、`NearPath`
内部继续叠加 `RegNext`/`RegEnable`，同时把 `FADDPipe.latency` 提到 3”这条路线已经
回退。后续必须从 stage 14 等价结构重建 A/B 基线，不得把 stage 15/16 当作继续优化
的起点。FP32 只有 85 ps 路径余量，共享 FMA 的 FP64 改动必须按精度参数隔离。

## 3. 固定测量方法

每次只改变一个结构点，并生成独立输出目录。先生成 RTL、跑 bit-exact/backpressure
回归，再综合；失败候选不覆盖上一个通过检查点。

```bash
make -C rtl generate
make -C rtl fp32-diff COUNT=5000 SEED=250 BACKPRESSURE=35
make -C rtl fp64-diff COUNT=5000 SEED=251 BACKPRESSURE=35
make -C rtl sfu-diff  COUNT=5000 SEED=252 BACKPRESSURE=35

make -C rtl ppa PPA_TOP=AecEightLaneIntUnit \
  RTL_SOURCES='sv/generated/int/AecEightLaneIntUnit.sv' PERIOD_PS=4000 \
  PPA_FLATTEN=0 OUT_DIR=reports/ppa_250mhz_candidate/int \
  ASAP7_ROOT="$ASAP7_ROOT" ASAP7_SRAM_ROOT="$ASAP7_SRAM_ROOT"
make -C rtl ppa PPA_TOP=AecFp32Unit \
  RTL_SOURCES='sv/generated/fp32/AecFp32Unit.sv' PERIOD_PS=4000 \
  PPA_FLATTEN=0 OUT_DIR=reports/ppa_250mhz_candidate/fp32 \
  ASAP7_ROOT="$ASAP7_ROOT" ASAP7_SRAM_ROOT="$ASAP7_SRAM_ROOT"
make -C rtl ppa PPA_TOP=AecFp64Unit \
  RTL_SOURCES='sv/generated/fp64/AecFp64Unit.sv' PERIOD_PS=4000 \
  PPA_FLATTEN=0 OUT_DIR=reports/ppa_250mhz_candidate/fp64 \
  ASAP7_ROOT="$ASAP7_ROOT" ASAP7_SRAM_ROOT="$ASAP7_SRAM_ROOT"
make -C rtl ppa PPA_TOP=AecSfuWarpUnit \
  RTL_SOURCES='sv/generated/sfu/AecSfuWarpUnit.sv' PERIOD_PS=4000 \
  PPA_FLATTEN=0 OUT_DIR=reports/ppa_250mhz_candidate/sfu \
  ASAP7_ROOT="$ASAP7_ROOT" ASAP7_SRAM_ROOT="$ASAP7_SRAM_ROOT"
```

每个候选保存 Scala diff、生成的 SystemVerilog、`ppa_summary.txt`、`checks.rpt`、
`timing_checks.txt`、`design_area.rpt`、`metadata.txt` 和周期统计。报告目录不是源码
检查点，因此还要给通过候选建立明确的 Git commit 或 patch；否则无法从匿名 mapped
cell 名恢复 stage 14 的 RTL。

## 4. Batch 0：恢复可复现基线

1. 用当前源码重新生成四个 top，确认生成 RTL 没有陈旧文件。
2. 重跑四项 4 ns STA，把结果记为 `current-rebuild`，不得用历史报告代替。
3. 从现有变更中逐项重建 INT stage 10、FP32 stage 13、FP64 stage 14、SFU stage 14
   的等价检查点；每恢复一个就立即跑功能和 STA，并保存 patch。
4. 对比历史报告的 area、cell count 和关键路径。数值不一致时，以可复现结果为准并
   更新本文，不把历史最好值作为已实现结果。

该批次的退出条件是四个 top 都有“源码 patch -> 生成命令 -> RTL -> 报告”的完整链路。

## 5. Batch 1：FP64 收敛到 4 ns

### 5.1 保留 FPUv2/fudian 主干

先走低风险路线，不立即移植 YunSuan。stage 14 已从 8,604 ps 缩到 4,601 ps，只需
再减少约 13.1%。其最差路径中一个 `NOR4xp25` 驱动约 230 fF，单级消耗约 3,562 ps，
随后仍有近 1 ns 的选择/控制链；首要问题是共享控制负载，不是再增加完整算术级数。

具体修改：

1. 在 `FPUv2/FMA.scala` 给 FP64 单独参数化 register cut，FP32 保持已验证结构。
   cut 必须是包含 payload、valid 和 backpressure 的单一 elastic stage，禁止只延迟
   data 而让 `op/rm/flags/ctrl` 走另一条级数。
2. 在 `fudian/FADD.scala` 的 `FCMA_ADD_s1` 入口复制 far/near/special 三类本地控制，
   让一个寄存位最多驱动一个路径实例。不要使用贯穿整个模块的共享 `enable` 去门控
   大量 `RegEnable`，该形式正是 stage 15/16 的回退来源。
3. 把 far/near 选择和 special-case 元数据随各自 payload 流水，在 `FCMA_ADD_s2`
   前只做一级局部选择。若单级仍超过 3.8 ns，再把 round/pack 独立为一个 elastic stage，
   而不是继续切 `FarPath`/`NearPath` 内部。
4. 每次 FP64 变化同时重跑 FP32 STA。FP32 不允许低于 250 MHz；推荐门槛为
   3,800 ps，至少要保住当前 4,000 ps 硬线。

接受门槛：FP64 <= 3,800 ps，FP32 <= 3,800 ps；FP64 面积相对 stage 14 增长不超过
10%；ADD/MUL/FMA initiation interval 不退化；FP32/FP64 bit-exact 和 35% 随机
backpressure 全过。

### 5.2 YunSuan FloatFMA 隔离式 A/B

只有 FPUv2 路线连续两个局部结构候选仍大于 4,000 ps 时，才启动 YunSuan A/B。
参考固定为 XiangShan `8a42e727...`、YunSuan `447cd17b...` 的
`yunsuan/fpu/FloatFMA.scala`。复制带 Mulan PSL v2 版权头的最小依赖闭包到独立 package，
建立只含 2 个 FP64 lane 的 adapter top；不要把整个 XiangShan backend 引入工程，
也不要同时替换 16 个 FP32 lane。

YunSuan 候选只有在 bit-exact、stall/flush、<=3,800 ps、面积和 cycles 四项都优于
FPUv2 最好候选时才接入正式 FP64 wrapper。

## 6. Batch 2：SFU 收敛到 4 ns

SFU stage 14 的 6,230 ps 路径跨越约 30 级逻辑，并包含多处 45--76 fF 高负载网络。
需要同时切断状态译码扇出和 `packQ34` 的动态归一化链，单纯切换 HardFloat 的迭代
选项不能解决该路径。

1. 将 `AecTranscendental.scala` 中函数式 `packQ34` 改为一个 Decoupled 两级模块：
   第一级完成 sign/abs、LZC、msb 和动态 shift；第二级完成 guard/sticky、round、
   exponent 和 normal/subnormal/overflow 选择。FSM 增加 `packIssue/packWait`，所有
   SIN/COS/EXP/LOG 出口统一走该模块。
2. 把当前由 15 个 state compare 共同驱动的 multiplier operand mux 改成显式命令寄存器。
   FSM 每个多项式步骤只发一次 `{a,b,nextState}`，随后等待响应；`state` 不直接驱动
   96-bit 算术核的输入选择。
3. 完成前两项并确认 <=4 ns 后，用 XiangShan
   `xiangshan/backend/fu/Multiplier.scala::ArrayMulDataModule` 的 Booth/CSA 结构替换
   48-cycle shift-add 核。只抽取 `C22/C32/C53`、符号扩展和 compressor 的最小闭包，
   保留 Mulan PSL v2 头；配置为 Booth 生成、CSA 压缩、CPA/Q34 slice 三个寄存阶段。
   SFU 只有一个实例，允许用适度面积换每个 polynomial step 从约 48 cycle 降到固定
   3 cycle。
4. 对 HardFloat `DivSqrtRecFNToRaw_small(11,53,options)` 做 `options=0` 与
   `divSqrtOpt_twoBitsPerCycle=16` 的隔离 A/B。按 `fmax/cycles` 选择；若两位/周期导致
   4 ns 失败则保留 1 bit/cycle。
5. 高基数 DIV/SQRT 放在最后。优先建立独立 f32 top 比较 YunSuan
   `FloatDivider.scala`、`fqrt/fpsqrt_r16.scala` 和现有 HardFloat；只有独立 top 满足
   4 ns、特殊值/rounding 正确且综合收益显著时才接入 SFU，f64 暂留 HardFloat。

接受门槛：SFU <=3,800 ps；正常有限 transcendental <=4 ULP，特殊值符合 ISA；随机
backpressure 下输出保持稳定；DIV/SQRT/RSQ 以及四个 transcendental 分别记录 latency
和 initiation interval；面积增长必须被 cycle 降幅抵消。

## 7. Batch 3：保护已达标单元

- INT stage 10 结构冻结。其 2,637 ps 最差路径仍由约 569 fF 负载主导，但已有
  1,363 ps 余量；除非 top-level 路径指向 INT wrapper，否则不再为单元 Fmax 增加流水。
- FP32 当前仅有 85 ps 余量。把 FP64 特有 register cut 置于 `expWidth=11 && precision=53`
  的 elaboration 分支，避免共享 FMA 修改无意改变 FP32 latency。
- 每个 FP64/SFU 候选完成后固定重跑 INT/FP32 smoke STA。任何单元跌破 4 ns，候选立即
  回退，不进入 top-level 集成。
- 不以手工 `dontTouch`、异或 lane index 或匿名控制复制作为最终物理修复。确需保留
  层次时应使用明确的本地寄存边界，并在功能和综合报告中证明没有改变架构语义。

## 8. Batch 4：正式 top 收敛

四个单元全部达到 3,800 ps 后，重新生成 `AecEvalTop.sv`，使用正式
`aec_eval_top`、ABI adapter 和锁定 SRAM wrapper 在 4,000 ps 下分析。若 top 失败，
只处理跨模块路径：scheduler dispatch、warp result arbitration、scoreboard wakeup、
GPR/SRAM 地址与 write-enable。算术单元内部已通过的 pipeline 不再因 top-level 控制
问题重写。

最终验收依次为：

1. `scripts/build.sh` 和 Scala/Verilator lint 全过；
2. FP32/FP64/SFU differential 与随机 backpressure 全过；
3. `scripts/run_tests.sh --suite public` 的 CModel/RTL 结果一致；
4. 四个单元和 `aec_eval_top` 在 4,000 ps 下 slack >= 0、TNS = 0；
5. 使用相同 public workload 记录优化前后 cycles，生成 activity VCD 后再报告 power；
6. 保存第三方源码 commit、许可证、原文件清单、本地修改和生成命令。

## 9. 实施顺序和停止条件

| 顺序 | 工作项 | 退出条件 | 失败时动作 |
|---:|---|---|---|
| 0 | 重建四个可复现检查点 | source/RTL/report 一致 | 不进入结构优化 |
| 1 | FP64 控制本地化和单一 elastic cut | FP64/FP32 <=3.8 ns | 两个候选失败后启动 YunSuan A/B |
| 2 | SFU pack 两级化和 multiplier 命令寄存 | SFU <=4.0 ns | 从关键路径重新定位，不先换 DIV 核 |
| 3 | SFU Booth/CSA multiplier | <=3.8 ns 且 score proxy 改善 | 保留 timing cut，回退 multiplier |
| 4 | HardFloat/YunSuan DIV/SQRT A/B | fmax/cycles/area 综合改善 | 保留原 HardFloat |
| 5 | `aec_eval_top` 4 ns 收敛 | slack >=0、TNS=0、回归全过 | 仅修跨模块路径 |

此顺序把 250 MHz 时序目标与吞吐评分分开控制：先用最小寄存边界达到 4 ns，再用
XiangShan/YunSuan 的 Booth/CSA、高基数算法减少周期。候选没有同口径报告和功能证据
时，不进入正式实现。
