#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$root/.." && pwd)
command=${1:-run}
period=${PERIOD_PS:-4000}
jobs=${PPA_JOBS:-16}
path_count=${PPA_PATH_COUNT:-20}
iteration=${PPA_ITERATION:-$(date -u +%Y%m%dT%H%M%SZ)}
change=${PPA_CHANGE:-unspecified RTL iteration}
verification=${PPA_VERIFICATION:-not recorded}
out_root=${LANE_PPA_OUT_ROOT:-$repo/reports/ppa_compute_units}
evidence_root=${PPA_EVIDENCE_ROOT:-$repo/evidence/logs}
selected=${LANE_PPA_UNITS:-int,sfu}

units=(int sfu)
tops=(AecIntAlu AESSFU)
sources=(
  "$root/sv/generated/int/AecEightLaneIntUnit.sv"
  "$root/sv/generated/sfu/AecSfuWarpUnit.sv"
)
baseline_area=(384.3288000000136 1860.4225799999567)
baseline_delay=(1702.890000000 4286.979000000)
baseline_fmax=(587.236991 233.264497)
baseline_slack=(2273.946000000 -304.083000000)
baseline_tns=(0.000000000 -7593.108000000)

is_selected() {
  local unit=$1 item
  IFS=',' read -ra requested <<< "$selected"
  for item in "${requested[@]}"; do [[ "$item" == "$unit" ]] && return 0; done
  return 1
}

summary_value() {
  local file=$1 key=$2
  [[ -f "$file" ]] || return 0
  awk -F= -v key="$key" '$1 == key {print $2}' "$file" | tail -n 1
}

status_for() {
  awk -v slack="$1" -v tns="$2" 'BEGIN {print (slack >= 0.0 && tns == 0.0) ? "PASS" : "FAIL"}'
}

run_unit() {
  local index=$1 unit=${units[$1]} top=${tops[$1]} source=${sources[$1]}
  local out="$out_root/$unit" archive="$evidence_root/$unit/$iteration"
  local activity=""
  [[ -s "$out/activity.vcd" ]] && activity="$out/activity.vcd"
  mkdir -p "$out" "$archive"
  OUT_DIR="$out" PERIOD_PS="$period" PPA_TOP="$top" RTL_SOURCES="$source" \
    ASAP7_ROOT="${ASAP7_ROOT:-}" ASAP7_SRAM_ROOT="${ASAP7_SRAM_ROOT:-}" \
    PPA_JOBS="$jobs" PPA_PATH_COUNT="$path_count" PPA_STRICT="${PPA_STRICT:-1}" \
    ACTIVITY_VCD="$activity" ACTIVITY_SCOPE="$top" \
    "$root/scripts/report_yosys_ppa.sh" > "$archive/ppa.log" 2>&1

  local file
  for file in ppa_summary.txt metadata.txt design_area.rpt worst_slack.rpt tns.rpt \
    checks.rpt timing_checks.txt critical_paths.rpt critical_paths_in2out.rpt \
    critical_paths_in2reg.rpt critical_paths_reg2out.rpt critical_paths_reg2reg.rpt \
    yosys_area.txt yosys_frontend.log yosys_finalize.log yosys_mapping.log opensta.log; do
    [[ -f "$out/$file" ]] && cp "$out/$file" "$archive/$file"
  done
}

ensure_history() {
  local index=$1 unit history
  unit=${units[$index]}
  history="$repo/reports/${unit}_ppa_history.tsv"
  [[ -f "$history" ]] && return
  printf 'iteration\tchange\tverification\tdelay_ps\tfmax_mhz\tslack_ps\ttns_ps\tarea_um2\tstatus\tevidence\n' > "$history"
  printf 'baseline\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    'Original single-lane implementation' 'Existing baseline reports' \
    "${baseline_delay[$index]}" "${baseline_fmax[$index]}" "${baseline_slack[$index]}" \
    "${baseline_tns[$index]}" "${baseline_area[$index]}" \
    "$(status_for "${baseline_slack[$index]}" "${baseline_tns[$index]}")" \
    "N/A" >> "$history"
}

record_history() {
  local index=$1 unit summary history
  unit=${units[$index]}
  summary="$out_root/$unit/ppa_summary.txt"
  history="$repo/reports/${unit}_ppa_history.tsv"
  local delay fmax slack tns area status evidence tmp
  ensure_history "$index"
  delay=$(summary_value "$summary" critical_path_delay_ps)
  fmax=$(summary_value "$summary" fmax_mhz)
  slack=$(summary_value "$summary" worst_slack_ps)
  tns=$(summary_value "$summary" tns_ps)
  area=$(summary_value "$summary" area_um2)
  status=$(status_for "$slack" "$tns")
  evidence="evidence/logs/$unit/$iteration/ppa_summary.txt"
  tmp="$history.tmp"
  awk -F '\t' -v iteration="$iteration" 'NR == 1 || $1 != iteration' "$history" > "$tmp"
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$iteration" "$change" "$verification" "$delay" "$fmax" "$slack" "$tns" "$area" "$status" "$evidence" >> "$tmp"
  mv "$tmp" "$history"
}

write_report() {
  local index=$1 unit top history report tmp
  unit=${units[$index]}
  top=${tops[$index]}
  history="$repo/reports/${unit}_ppa_history.tsv"
  report="$repo/reports/$unit.md"
  tmp="$report.tmp"
  ensure_history "$index"
  local latest base_area base_fmax area fmax slack tns delay status area_delta fmax_delta
  latest=$(tail -n 1 "$history")
  IFS=$'\t' read -r _ _ _ delay fmax slack tns area status _ <<< "$latest"
  base_area=${baseline_area[$index]}; base_fmax=${baseline_fmax[$index]}
  area_delta=$(awk -v now="$area" -v base="$base_area" 'BEGIN {printf "%.2f", (now/base-1.0)*100.0}')
  fmax_delta=$(awk -v now="$fmax" -v base="$base_fmax" 'BEGIN {printf "%.2f", (now/base-1.0)*100.0}')

  cat > "$tmp" <<EOF
# ${unit^^} 单 Lane PPA

## 口径

- Top：\`$top\`，仅 lane-local 计算单元，不包含多 lane、warp 调度、scoreboard、ROB 或写回仲裁。
- 工艺：ASAP7 7.5-track v28，RVT TT NLDM，理想时钟，周期 4000 ps（250 MHz）。
- 通过条件：OpenSTA \`WNS >= 0\` 且 \`TNS = 0\`。无活动 VCD 时功耗记为 \`N/A\`。
- 原始 PPA 日志及关键路径归档在 \`evidence/logs/$unit/<iteration>/\`。
- 复现入口：\`make -C rtl lane-ppa PERIOD_PS=4000 ASAP7_ROOT=... ASAP7_SRAM_ROOT=... PPA_ITERATION=<name>\`。

## 当前结果

| Top | 关键路径 (ps) | Fmax (MHz) | 4 ns slack (ps) | TNS (ps) | 面积 (um^2) | 频率变化 | 面积变化 | 250 MHz |
|---|---:|---:|---:|---:|---:|---:|---:|:---:|
| \`$top\` | $delay | $fmax | $slack | $tns | $area | ${fmax_delta}% | ${area_delta}% | $status |

## 迭代记录

| 轮次 | 结构变更 | 功能验证 | 关键路径 (ps) | Fmax (MHz) | Slack (ps) | TNS (ps) | 面积 (um^2) | 结论 | 证据 |
|---|---|---|---:|---:|---:|---:|---:|:---:|---|
EOF
  tail -n +2 "$history" | while IFS=$'\t' read -r iter row_change row_verification row_delay row_fmax row_slack row_tns row_area row_status row_evidence; do
    if [[ "$row_evidence" == N/A ]]; then
      printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s | N/A |\n' \
        "$iter" "$row_change" "$row_verification" "$row_delay" "$row_fmax" "$row_slack" \
        "$row_tns" "$row_area" "$row_status" >> "$tmp"
    else
      printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s | [%s](../%s) |\n' \
        "$iter" "$row_change" "$row_verification" "$row_delay" "$row_fmax" "$row_slack" \
        "$row_tns" "$row_area" "$row_status" summary "$row_evidence" >> "$tmp"
    fi
  done
  cat >> "$tmp" <<EOF

## 参考与限制

- 结构优化参考仓库内 \`local/XiangShan/yunsuan\` 的分级归约、受限移位和多周期算术组织；未直接引入其向量调度层。
- 结果为综合后、布局前 NLDM 估计，不包含布线寄生；比较不同迭代时必须保持同一工具、Liberty、约束和层级设置。
EOF
  mv "$tmp" "$report"
}

case "$command" in
  run)
    mkdir -p "$out_root" "$evidence_root"
    for i in "${!units[@]}"; do
      is_selected "${units[$i]}" || continue
      run_unit "$i"
      record_history "$i"
      write_report "$i"
    done
    ;;
  summary)
    for i in "${!units[@]}"; do write_report "$i"; done
    ;;
  *) echo "usage: $0 {run|summary}" >&2; exit 2 ;;
esac
