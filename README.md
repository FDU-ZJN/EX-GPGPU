# ZGPGPU Track B 提交（b-013）

本仓库是 b-013 小组的 AEC GPGPU 赛题正式提交，包含可综合 Chisel 源码、生成的
SystemVerilog、功能 CModel、规定入口脚本、四份中文报告、精简复现证据、官方
赛题资料和完整 Git 历史。

- 赛道：Track B
- 小组：b-013
- 评分顶层：`aec_eval_top`
- Chisel 核心：`AecEvalCore`
- 当前架构：1 个调度器、2 个物理驻留 warp 槽位
- CTA 能力：最多 8 个架构 warp，通过 warp 对重绑定执行
- Warp 宽度：32 lane

## 架构演进

项目最初实现的是 8-warp 高性能版本，采用 4 个双 warp 调度分区，以硬件复制
换取延时隐藏。后续了解到完整 PPA 的运行时间和综合规模限制后，提交版本切换为
单调度器、2 个物理驻留 warp 槽位。架构仍保存最多 8 个 warp 的 PC、active
mask、call stack、barrier 和完成状态，两个物理槽位依次绑定架构 warp 对。

当前设计保留两个 4-entry ROB、scoreboard、分 bank 寄存器文件、分层 operand
select、注册化 completion fabric、8-lane INT 物理簇、FP32/FP64/SFU 后端、
64 KiB direct-mapped line cache、16-tag 外部访存引擎和流水 GMEM load 路径。
store/atomic 使用精确 preflight/replay 路径。

详细设计见 [reports/DESIGN.md](reports/DESIGN.md)。

## 提交目录

```text
TrackB-b-013/  官方规范、评分、公开用例、锁定 SRAM、PPA flow、ISA 验证工具
rtl/           Chisel 源码、生成 SystemVerilog、ABI adapter、RTL runner
cmodel/        Python 功能模型、C/C++ API 和构建文件
scripts/       build、CModel/RTL run、公开回归、PPA、审查和打包入口
reports/       DESIGN、VERIFICATION、PPA、LIMITATIONS
evidence/      JSON、memory dump、PPA summary、STA/综合关键日志
README.md      提交入口
```

`TrackB-b-013/` 是提交根目录下与 `rtl/`、`cmodel/` 并级的官方资料子目录。

## 工具版本

| 工具 | 版本 |
| --- | --- |
| JDK | 17 |
| SBT | 1.8.2 |
| Scala | 2.13.10 |
| Chisel | 3.5.6 |
| ChiselTest | 0.5.6 |
| Verilator | 5.049-devel |
| GCC/G++ | 13.3.0 |
| Python | 3.12.3 |
| Yosys | 0.64+308，commit `78e05dfb0` |
| OpenSTA | commit `66c29303` |
| ASAP7 | 7.5-track v28，RVT TT NLDM |
| ASAP7 SRAM | PDK 1.7，锁定 commit `522eeccbccefcd66e61893fa1059df24d95e9f86` |

评测不依赖网络下载。ASAP7 标准单元和 SRAM 锁定视图随
`TrackB-b-013/ppa-flow/` 提供。

## 构建

在仓库根目录执行：

```bash
scripts/build.sh
```

该入口构建 CModel C++ API 和 Verilator 评分 RTL runner。

## 单用例运行

```bash
scripts/run_cmodel.sh \
  --case TrackB-b-013/testcases/tests/aec_cases/abi/c0_smoke/case.yaml \
  --output /tmp/b013-cmodel-smoke

scripts/run_rtl.sh \
  --case TrackB-b-013/testcases/tests/aec_cases/abi/c0_smoke/case.yaml \
  --output /tmp/b013-rtl-smoke
```

两个入口读取相同的 `case.yaml`、AEC binary、launch 参数和 memory image，
并在指定输出目录写入 `result.json` 和要求的 GMEM dump。

## 公开回归

```bash
scripts/run_tests.sh --suite public --output /tmp/b013-public
scripts/run_tests.sh --model cmodel --suite public --output /tmp/b013-cmodel-public
```

提交证据记录：

| 项目 | 结果 |
| --- | ---: |
| RTL public suite | 36 / 36 |
| CModel public suite | 36 / 36 |
| RTL public cycles | 20,936 |
| ISA-gap cases | 61 |
| ISA opcode coverage | 53 / 53 |
| 锁定 SRAM 行为模型 | 4 / 4 |

机器可读结果位于 `evidence/final_public36/` 和
`evidence/final_isa/coverage.json`。详细说明见
[reports/VERIFICATION.md](reports/VERIFICATION.md)。

## Chisel 与生成 RTL

Chisel 源码基准为 `rtl/src/main/scala/`，当前保留 61 个实际依赖的 Scala
文件。评分 SystemVerilog 为：

```text
rtl/sv/generated/eval_core/AecEvalCore.sv
SHA256: cd87a68f5b1f6d98431278574f5c40bf649995c5bf7a978d907a112381e631d8
```

一键生成命令：

```bash
make -C rtl eval-generate
```

`rtl/sv/aec_eval_top.sv` 只完成规范 ABI、`mem_req_space` 和低有效复位适配。
仿真与 PPA 使用同一个 `AecEvalCore`，`rtl/files.f` 是 PPA 源文件清单。

### 精简的第三方源码闭包

- Berkeley HardFloat：仅保留 AEC conversion、compare、DIV/SQRT 所需的 13 个
  Scala 文件及 LICENSE。
- fudian：仅保留 `FPToFP` 转换所需的 5 个 Scala 文件。
- OpenXiangShan/YunSuan：仅保留固定格式 FMA、兼容 helper 和 AEC Decoupled
  adapter 共 3 个文件，位于 `rtl/src/main/scala/aec/fp/yunsuan/`。
- 早期未被评分设计引用的 `FPUv2/` 已从提交中移除。

第三方来源和设计集成方式见 [reports/DESIGN.md](reports/DESIGN.md)。

## PPA

正式入口：

```bash
scripts/run_ppa.sh --output /tmp/b013-ppa
```

该脚本转发到 `TrackB-b-013/ppa-flow/`，读取 `rtl/files.f`，使用锁定的
Yosys、OpenSTA、ASAP7 standard-cell 和 SRAM 数据。

2-warp 全核 PPA：

| 项目 | 值 |
| --- | ---: |
| Logic-only 频率（层次化前） | 16.35 MHz |
| Logic-only 频率（层次化后） | 27.17 MHz |
| 提升 | 66.18% |
| 标准单元面积 | 189,825.04 um² (51.1%) |
| SRAM macro 面积 | 181,444.67 um² (48.9%) |
| 总面积 | 371,269.70 um² (0.3713 mm²) |

原 8-warp 阶段代表性子模块数据：

| 子模块 | Fmax |
| --- | ---: |
| INT32 | 379.28 MHz |
| FP32 | 255.44 MHz |
| FP64 | 217.35 MHz |
| DIV/SFU | 160.52 MHz |

子模块优化数据表明各计算单元具备可独立达到 250 MHz 目标的 PPA 条件。
全核 2-warp 的 logic-only 频率通过层次化 operand-select 提升 66.18%，
当前关键路径已转移至 GMEM 控制和跨模块大扇出。

详细数据和证据索引见 [reports/PPA.md](reports/PPA.md)。

## 报告

- [DESIGN.md](reports/DESIGN.md)：架构、调度、ROB、cache、GMEM 和设计取舍。
- [VERIFICATION.md](reports/VERIFICATION.md)：CModel/RTL、公开回归和 ISA 覆盖。
- [PPA.md](reports/PPA.md)：8-warp 子模块、2-warp full-core 与流程数据。
- [LIMITATIONS.md](reports/LIMITATIONS.md)：当前提交范围和参数。

## 提交审查与打包

静态提交审查：

```bash
scripts/check_submission.sh
```

生成包含完整 `.git/` 历史的归档：

```bash
scripts/package_submission.sh --output /tmp/TrackB-b-013.tar.gz
```

提交中不包含 build cache、VCD/FST、FIR/annotation、对象文件、mapped JSON、
mapped netlist 或本地工具安装。
