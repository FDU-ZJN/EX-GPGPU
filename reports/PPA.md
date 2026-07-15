# PPA flow

本文档记录当前仓库的 RTL PPA 流程、命令、输出和已知边界。流程依据
`Track-B/spec.md` 第 12 节使用 Yosys、ABC、OpenSTA 和 ASAP7 RVT TT NLDM。

## 快速命令

查看命令帮助：

```bash
make ppa-help
make -C rtl ppa-help
```

仅做 generic proxy（不属于正式 PPA）：

```bash
make -C rtl ppa OUT_DIR=/tmp/ppa-proxy PPA_STRICT=1
```

运行 ASAP7 面积和时序分析：

```bash
make ppa \
  ASAP7_ROOT=/path/to/asap7sc7p5t_28 \
  ASAP7_SRAM_ROOT=/path/to/asap7_sram_0p0 \
  PERIOD_PS=1000 \
  OUT_DIR=reports/yosys
```

等价的规范入口：

```bash
scripts/run_ppa.sh \
  --output reports/yosys \
  --asap7-root /path/to/asap7sc7p5t_28 \
  --asap7-sram-root /path/to/asap7_sram_0p0 \
  --period-ps 1000
```

正式 `aec_eval_top` 配置使用：

```bash
scripts/run_ppa.sh \
  --output reports/ppa \
  --asap7-root /path/to/asap7sc7p5t_28 \
  --asap7-sram-root /path/to/asap7_sram_0p0 \
  --top aec_eval_top \
  --rtl-sources 'rtl/sv/generated/eval/AecEvalTop.sv rtl/sv/aec_eval_top.sv rtl/sv/asap7_sram_wrappers.sv' \
  --activity-vcd evidence/performance.vcd
```

根目录 `make ppa` 和 `scripts/run_ppa.sh` 默认使用正式评分 top
`aec_eval_top` 及其生成 RTL/ABI adapter。单元级开发测量仍可通过
`PPA_TOP`/`--top` 和 `RTL_SOURCES`/`--rtl-sources` 显式选择。

## 流程阶段

1. `prepare_asap7_liberty.sh` 在 `ASAP7_ROOT/LIB/NLDM` 中选择 RVT/TT 的
   AO、INVBUF、OA、SEQ、SIMPLE 五个 archive。
2. 五个 `.lib.7z` 分别解压到 `liberty/`，不拼接完整 `library()` block。
3. 流程用 `Track-B/sram/ASAP7_SRAM_LOCK.sha256` 校验锁定 SRAM checkout，
   将 native SRAM 作为 library/blackbox 读取，再由 Yosys 执行
   `proc; memory_map; flatten; techmap; opt`。
4. ABC 通过五个独立 Liberty 加载标准单元，完成 combinational mapping。
5. `dfflibmap` 使用 SEQ Liberty 映射寄存器，随后再次执行 ABC 清理 DFF
   反相和 mux 周边的 generic cell。
6. 对 mapped netlist 执行 hierarchy 检查和 generic `$`/`$_` cell 检查。
7. OpenSTA 分别读取五个标准单元库和锁定 SRAM Liberty，读取 mapped netlist，执行
   `link_design`、clock/input/output delay 约束和最大路径分析。
8. OpenSTA Tcl 通过 Liberty `area` 累加标准单元面积；SRAM 按锁定 LEF 的
   `30.348 x 43.2 = 1311.0336 um^2`/实例累加，不使用其为 0 的 Liberty area。
9. 若传入 activity VCD，则执行 `read_vcd` 和 `report_power`。

## 输出文件

`OUT_DIR` 下会产生：

| 文件 | 内容 |
|---|---|
| `liberty_manifest.txt` | archive、解压文件、SHA256、cell 数量、ASAP7 revision |
| `liberty/*.lib` | 五个独立 Liberty 文件 |
| `abc.script` | ABC 五库映射脚本 |
| `yosys_mapping.log` | Yosys/ABC/DFF 映射日志 |
| `mapped_netlist.v` | 标准单元 mapped netlist |
| `generic_cells.txt` | generic cell 检查结果 |
| `opensta.tcl` | OpenSTA 约束和报告脚本 |
| `opensta.log` | OpenSTA link/分析日志 |
| `checks.rpt` | 最差 max path 原始报告 |
| `worst_slack.rpt` | worst slack |
| `tns.rpt` | total negative slack |
| `timing_checks.txt` | setup、unconstrained endpoint、loop 检查 |
| `design_area.rpt` | OpenSTA Liberty cell area 累加 |
| `power.rpt` | 有 activity VCD 时生成的功耗报告 |
| `ppa_summary.txt` | area、delay、slack、TNS、fmax、cell count |
| `metadata.txt` | 工具版本、top、corner、period、报告有效性 |

## 单位和指标

ASAP7 Liberty 声明：

```text
time_unit : "1ps"
```

因此 `PERIOD_PS=1000` 直接传给 OpenSTA，代表 1000 ps；OpenSTA 的 path delay、
slack 和 TNS 也直接以 ps 解释。

```text
fmax_mhz = 1000000 / critical_path_delay_ps
```

没有 activity VCD 时，流程仍可产生面积和时序结果，但 `ppa_valid=false`，不能
作为 spec 要求的完整 power/PPA 结果。

## 失败策略

默认 `PPA_STRICT=1`。以下情况返回非零：

- ASAP7_ROOT、ASAP7_SRAM_ROOT、五个标准单元 Liberty archive 或锁定 SRAM view 缺失；
- Liberty cell 数量为零；
- Yosys/ABC/DFF mapping 失败；
- mapped netlist 含 generic Yosys cell 或没有标准单元；
- OpenSTA link、timing check 或 numeric report 失败；
- 没有有效 path、存在 unresolved cell、multiple driver、loop 或 unconstrained
  timing endpoint。

`PPA_STRICT=0` 只允许保留诊断产物，不会把失败结果标记为正式 PPA。

## 时序结果示例

当前 `AecFpUnit` 开发配置在 1000 ps 约束下的修正后结果约为：

```text
critical_path_delay_ps = 13827.108
worst_slack_ps          = -12827.108
fmax_mhz                = 72.32
```

关键路径从一个 `DFFHQNx1_ASAP7_75t_R` 的 QN 输出到
`io_resp_bits_result[0]`，经过约 95 个标准单元。瓶颈是深组合逻辑、高扇出和
大量小驱动 `INVx1`/`NAND2`/`NOR2`/`OAI31`/`AOI21` 单元串联；该结果是
`AecFpUnit` 单元分析，不代表尚未接入的 `aec_eval_top` 正式竞赛 PPA。

## 可复现性

建议将原始输出目录保存到 `evidence/ppa/<run-id>/`，并记录：

- `ASAP7_ROOT` checkout revision；
- Yosys/OpenSTA 版本；
- `PPA_TOP`、RTL source list 和 clock period；
- activity VCD 的生成命令和 workload；
- `ppa_summary.txt`、`metadata.txt`、`checks.rpt`、`worst_slack.rpt`、
  `tns.rpt`、`design_area.rpt` 和 `power.rpt`。
