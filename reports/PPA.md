# PPA 报告

## 1. 架构与优化目标

计算单元以 250 MHz（4.000 ns）为优化目标。项目最初实现的是 8-warp 高性能
版本，包含 4 个双 warp 调度分区。后续了解到完整 PPA 的运行时间和综合规模
限制后，提交版切换为单调度器、2 个物理驻留 warp 槽位。该修改减少寄存器、
scoreboard、执行后端和完成网络的复制量，并通过两个 warp 交织、每 warp 4 项
ROB 和流水 GMEM 保留延时隐藏能力。

## 2. PPA 流程

官方 PPA flow 放在与 `rtl/` 并级的
`TrackB-b-013/ppa-flow/`。根入口直接转发到该流程：

```bash
scripts/run_ppa.sh --output /tmp/b013-ppa
```

`rtl/files.f` 指定当前评分 RTL：

```text
sv/generated/eval_core/AecEvalCore.sv
sv/aec_eval_top.sv
sv/asap7_sram_wrappers.sv
```

流程使用 Yosys、ABC、OpenSTA、ASAP7 RVT TT NLDM 和锁定 ASAP7 SRAM。
standard-cell 与 SRAM 均执行 checksum 校验。Yosys 完成一次综合和映射，
OpenSTA 复用同一 mapped netlist 进行周期搜索，从而减少重复 mapping 时间。

本次候选包完成了工具、5 组 standard-cell Liberty、4 组 SRAM Liberty 和锁定
清单检查，检查结果全部通过。

## 3. full-core 优化数据

层次化 operand-select 将 backend 的高扇出选择逻辑拆分到本地操作簇。修改前后
logic-only 对比为：

| 版本 | 频率 |
| --- | ---: |
| 层次化前 | 16.35 MHz |
| 层次化后 | 27.17 MHz |
| 提升 | 66.18% |

当前单 scheduler、2 个 physical resident warp slot 的正式 full-core 面积结果为：

| 面积项目 | 面积 (um2) | 占比 |
| --- | ---: | ---: |
| 标准单元 | 189,825.04 | 51.1% |
| SRAM macro | 181,444.67 | 48.9% |
| 总面积 | 371,269.70 | 100.0% |

总面积换算为 `0.3713 mm2`。该版本映射后共 2,374,721 cells；SRAM 共 154 个
macro，包括 33 个 `srambank_128x4x32_6t122` 和 121 个
`srambank_256x4x32_6t122`。最新时序优化版本映射为 2,377,075 cells，仅增加
2,354 cells，增幅约 0.10%。由于不同 cell 类型的 Liberty 面积不同，cell 数量
增量不直接等同于面积增量；从规模变化看，最新版本的面积仍接近 `0.371 mm2`。

这里的 2-warp 指两个物理 resident warp slot。设计仍保留较大的 GPR SRAM、完整
执行单元，以及最多 8 个 architectural warp 的上下文，因此面积不会简单缩小为
原 8-warp 版本的四分之一。正式面积数据来自
`evidence/ppa-gmem-r/raw/result.json` 和 `evidence/ppa-gmem-r/raw/synth.stat`。

该修改消除了约 2048 fanout 的 backend operand 路径，关键路径随后移动到 GMEM
控制。raw 锁定 SRAM 口径的记录值为 8.05 MHz。raw 表示原样计入官方锁定
SRAM Liberty timing arc；logic-only 用于观察 RTL 控制逻辑本身。两类数据共同
用于区分宏时序和 RTL 组合控制的优化收益。

精简日志位于 `evidence/raw_timing/`，包括 constraints、source list、
logic-only log、STA upper-bound、synth.stat 和 resolved file list。

## 4. 原 8-warp 高性能版本的子模块数据

最初 8-warp 架构采用 4 个双 warp 分区，warp-facing 计算单元配置为 INT 16 个
物理 lane、FP32 16 个物理 lane、FP64 2 个物理 lane、SFU 1 个物理 lane。
这些子模块先在 100 MHz 层级映射中形成完整基线：

| 8-warp 阶段子模块 | 物理 lane | 面积 (um2) | 关键延时 (ps) | Fmax (MHz) | mapped cell |
| --- | ---: | ---: | ---: | ---: | ---: |
| INT32 | 16 | 12,424.23 | 8,678.04 | 115.23 | 126,757 |
| FP32 | 16 | 34,797.18 | 3,856.05 | 259.33 | 400,774 |
| FP64 | 2 | 14,602.34 | 8,604.27 | 116.22 | 154,889 |
| DIV/SFU | 1 | 6,933.31 | 8,262.13 | 121.03 | 73,320 |

继续以 250 MHz 为目标进行局部流水、控制本地化和 datapath 优化后，各子模块
取得的代表性数据为：

| 8-warp 阶段子模块 | 面积 (um2) | 关键延时 (ps) | Fmax (MHz) | mapped cell |
| --- | ---: | ---: | ---: | ---: |
| INT32 stage10 | 12,696.70 | 2,636.56 | 379.28 | 134,712 |
| FP32 stage13 | 40,204.12 | 3,914.85 | 255.44 | 447,897 |
| FP64 stage14 | 15,957.65 | 4,600.94 | 217.35 | 169,178 |
| DIV/SFU stage14 | 5,907.61 | 6,229.80 | 160.52 | 64,066 |

早期 frontend 也按子模块拆分测量。该时点 scoreboard 保存 8 个架构 warp 的
依赖状态，ROB 保存完整 warp result payload，代表性 partition 包含一个真实
32-lane register bank、一个 scoreboard 和两个 4-entry ROB：

| 8-warp 阶段 frontend 子模块 | Fmax (MHz) | 最小周期 (ns) | 标准单元面积 (um2) |
| --- | ---: | ---: | ---: |
| AecScoreboard | 14.04 | 71.232 | 5,644.91 |
| 单个 AecWarpRob | 15.78 | 63.374 | 5,145.12 |
| 代表性双 warp partition | 3.80 | 263.351 | 28,936.75 |

这些数据推动了后续修改：scoreboard 收缩为两个物理 slot、ROB control 与宽
payload 分层、operand select 本地化、completion 注册化，以及最终从 4 个分区
收缩为 1 个分区。

## 5. 当前单 lane 计算单元数据

INT、SFU、FP32、FP64 的开发 PPA 保持在单 lane/单单元层级，不包含多 lane
调度层。当前统计如下：

| 单元 | 面积 (um2) | 关键延时 (ps) | 估算 Fmax (MHz) | mapped cell |
| --- | ---: | ---: | ---: | ---: |
| INT | 11,376.38 | 218,528.80 | 4.576 | 135,012 |
| SFU | 7,377.54 | 279,662.97 | 3.576 | 82,529 |
| FP32 | 25,582.78 | 219,876.31 | 4.548 | 308,265 |
| FP64 | 12,628.15 | 403,784.66 | 2.477 | 141,548 |

对应 summary、metadata、timing checks、WNS、TNS 和 area 文件位于
`evidence/compute_unit_ppa/`。单元表保持原始测量层级，便于继续针对 INT、
SFU 和浮点 datapath 进行迭代。

## 6. 已实施的 PPA 优化

1. 4 个双 warp 分区收缩为 1 个双 warp 分区；
2. operand selection 下沉至 `AecPartitionBackend`，按 INT/FP/SFU 分层；
3. completion 先局部仲裁和注册，再送入 ROB；
4. register file 按 lane 分 bank，缩短宽 operand 选择路径；
5. ordinary load descriptor 仅保存窄 metadata；
6. cache miss queue 使用 4 项窄 descriptor；
7. cache SRAM dataout 增加结果寄存级；
8. GMEM 地址、line coalesce、token routing 和结果放置分 bank/分级；
9. store/atomic 使用独立宽 holding slot；
10. 小型控制状态使用寄存器，大容量规则阵列使用锁定 SRAM；
11. PPA 采用模块级快速定位和 full-core 数据分层记录；
12. 综合结果复用于多次 STA 周期搜索。

## 7. PPA 运行时间组织

ABC 的最大模块形成主要运行时间长尾，因此开发迭代按以下层级组织：

```text
单元 generic 检查
  -> 单 lane INT/SFU/FP PPA
  -> frontend/GMEM/cache logic-only
  -> full-core logic-only
  -> full-core raw locked-SRAM
```

每轮保存 source list、constraint、summary 和关键路径；Liberty 由
`TrackB-b-013/ppa-flow/` 统一提供。该方式减少重复库拷贝、重复 mapping 和
大型中间文件 I/O，使频繁 RTL 迭代可以快速获得趋势数据。

## 8. 全核与子模块优化结论

受赛程时间和完整 PPA 单轮运行时间影响，本阶段没有对整个 GPU 进行充分的 PPA
探索。full-core 集成时序因此停留在跨模块大扇出路径上，主要涉及 operand、
completion 和 GMEM 控制的宽广播。相比之下，原 8-warp 阶段的计算子模块已经
完成多轮局部流水和控制本地化：INT32 达到 379.28 MHz，FP32 达到
255.44 MHz，FP64 达到 217.35 MHz，DIV/SFU 达到 160.52 MHz，体现了较好的
子模块 PPA 优化效果。

当前 2-warp 版本进一步完成层次化 operand-select、completion 注册、GMEM load
流水、store/atomic 分离、cache 返回分级和窄 descriptor。logic-only 频率提升
66.18%，说明全核大扇出已经能够通过模块边界和局部控制继续分解，设计具有足够
大的后续 PPA 优化潜力。

## 9. 数据索引

- full-core 与 GMEM 时序：`evidence/raw_timing/`
- 单元 PPA：`evidence/compute_unit_ppa/`
- 原 8-warp 子模块 PPA：`evidence/compute_unit_ppa/8warp_history/`
- 架构和 GMEM 优化日志：`evidence/historical_logs/`
- 正式流程：`TrackB-b-013/ppa-flow/`
- 评分 RTL filelist：`rtl/files.f`
