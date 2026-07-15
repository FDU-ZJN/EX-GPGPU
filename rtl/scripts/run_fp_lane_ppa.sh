#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$root/.." && pwd)
command=${1:-run}
period=${PERIOD_PS:-4000}
jobs=${PPA_JOBS:-16}
path_count=${PPA_PATH_COUNT:-20}
iteration=${FP_PPA_ITERATION:-iter-$(date +%Y%m%d-%H%M%S)}
change=${FP_PPA_CHANGE:-unspecified}
verification=${FP_PPA_VERIFICATION:-PASS}
history="$repo/reports/FP_FPU_PPA_HISTORY.tsv"
report="$repo/reports/FP_FPU_PPA.md"
requested_report="$repo/reports/fpu32,64.md"
best_root="$repo/reports/ppa_compute_units"
trial_root="$repo/reports/ppa_fp_trials/$iteration"
units=(fp32 fp64)
tops=(AecFp32PipeUnit AecFp64PipeUnit)
sources=(
  "$root/sv/generated/fp32_lane/AecFp32PipeUnit.sv"
  "$root/sv/generated/fp64_lane/AecFp64PipeUnit.sv"
)

summary_value() {
  local file=$1 key=$2
  awk -F= -v key="$key" '$1 == key {print $2}' "$file" | tail -n 1
}

sanitize() {
  printf '%s' "$1" | tr '\t\r\n' '   '
}

source_hash() {
  bash "$root/scripts/fp_source_hash.sh"
}

check_generated() {
  local expected current
  [[ -s "$root/sv/generated/.fp_source.sha256" ]] || {
    echo "missing FP source fingerprint; run make -C rtl fp-generate" >&2
    exit 2
  }
  expected=$(tr -d '[:space:]' < "$root/sv/generated/.fp_source.sha256")
  current=$(source_hash)
  [[ "$expected" == "$current" ]] || {
    echo "generated FP RTL is stale; run make -C rtl fp-generate" >&2
    exit 2
  }
  printf '%s' "$current"
}

run_unit() {
  local index=$1 unit=${units[$1]} top=${tops[$1]} source=${sources[$1]}
  local out="$trial_root/$unit"
  OUT_DIR="$out" PERIOD_PS="$period" PPA_TOP="$top" RTL_SOURCES="$source" \
    ASAP7_ROOT="${ASAP7_ROOT:-}" ASAP7_SRAM_ROOT="${ASAP7_SRAM_ROOT:-}" \
    PPA_JOBS="$jobs" PPA_PATH_COUNT="$path_count" PPA_STRICT="${PPA_STRICT:-1}" \
    PPA_SOURCE_HASH="$fp_source_hash" \
    "$root/scripts/report_yosys_ppa.sh"
}

render_report() {
  mkdir -p "$(dirname "$report")"
  {
    echo '# FP32/FP64 单 Lane FPU PPA 迭代'
    echo
    echo '## 口径'
    echo
    echo '- 范围：`AecFp32PipeUnit` 与实际部署配置 `AecFp64PipeUnit(false)`；不包含多 lane、warp 调度、scoreboard、RegBank 或完成仲裁。'
    echo '- 工艺：ASAP7 7.5-track v28，RVT TT NLDM。目标周期 4 ns，收敛门槛为关键路径不超过 3.8 ns（约 263 MHz）。'
    echo '- 功耗：没有统一 workload VCD 时记为 `N/A`。当前文档比较时序与标准单元面积。'
    echo '- 生成一致性：每轮 metadata 记录 Chisel 源码指纹；指纹不匹配时 PPA 入口直接失败。'
    echo '- `/local/xiangshan` 当前未挂载；结构参考仓库内源自 YunSuan commit `447cd17b1637f998daeb6be3efcd4890f48cb2b9` 的实现。'
    echo
    echo '## 当前最佳'
    echo
    echo '| 单元 | 关键路径 (ps) | Fmax (MHz) | 4 ns slack (ps) | TNS (ps) | 面积 (um^2) | Cells | 3.8 ns |'
    echo '|---|---:|---:|---:|---:|---:|---:|:---:|'
    local unit file delay fmax slack tns area cells gate
    for unit in "${units[@]}"; do
      file="$best_root/$unit/ppa_summary.txt"
      if [[ -s "$file" ]]; then
        delay=$(summary_value "$file" critical_path_delay_ps)
        fmax=$(summary_value "$file" fmax_mhz)
        slack=$(summary_value "$file" worst_slack_ps)
        tns=$(summary_value "$file" tns_ps)
        area=$(summary_value "$file" area_um2)
        cells=$(summary_value "$file" mapped_cell_count)
        gate=$(awk -v d="$delay" 'BEGIN {print (d <= 3800.0) ? "PASS" : "FAIL"}')
        printf '| %s | %s | %s | %s | %s | %s | %s | %s |\n' "${unit^^}" "$delay" "$fmax" "$slack" "$tns" "$area" "$cells" "$gate"
      else
        printf '| %s | N/A | N/A | N/A | N/A | N/A | N/A | N/A |\n' "${unit^^}"
      fi
    done
    echo
    echo '## 全部轮次'
    echo
    echo '| 轮次 | 变更 | 验证 | 状态 | FP32 ps | FP32 MHz | FP32 um^2 | FP64 ps | FP64 MHz | FP64 um^2 |'
    echo '|---|---|---|---|---:|---:|---:|---:|---:|---:|'
    if [[ -s "$history" ]]; then
      awk -F '\t' '{printf "| %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |\n", $1,$2,$3,$4,$5,$6,$9,$11,$12,$15}' "$history"
    fi
    echo
    echo '采纳规则：功能验证通过，至少一个单元 Fmax 提升不低于 1%，且另一单元退化不超过 1%。达到 3.8 ns 后，连续两轮无有效收益即停止。'
  } > "$report.tmp"
  mv "$report.tmp" "$report"
  cp "$report" "$requested_report"
}

archive_evidence() {
  local unit src dst name
  for unit in "${units[@]}"; do
    src="$trial_root/$unit"
    dst="$repo/evidence/logs/$iteration/$unit"
    mkdir -p "$dst"
    for name in yosys_frontend.log yosys_mapping.log yosys_finalize.log opensta.log metadata.txt ppa_summary.txt; do
      [[ -s "$src/$name" ]] && cp "$src/$name" "$dst/$name"
    done
    [[ -s "$trial_root/$unit.log" ]] && cp "$trial_root/$unit.log" "$dst/ppa.log"
  done
}

record_trial() {
  local f32="$trial_root/fp32/ppa_summary.txt" f64="$trial_root/fp64/ppa_summary.txt"
  local d32 m32 s32 t32 a32 c32 d64 m64 s64 t64 a64 c64 status
  d32=$(summary_value "$f32" critical_path_delay_ps); m32=$(summary_value "$f32" fmax_mhz)
  s32=$(summary_value "$f32" worst_slack_ps); t32=$(summary_value "$f32" tns_ps)
  a32=$(summary_value "$f32" area_um2); c32=$(summary_value "$f32" mapped_cell_count)
  d64=$(summary_value "$f64" critical_path_delay_ps); m64=$(summary_value "$f64" fmax_mhz)
  s64=$(summary_value "$f64" worst_slack_ps); t64=$(summary_value "$f64" tns_ps)
  a64=$(summary_value "$f64" area_um2); c64=$(summary_value "$f64" mapped_cell_count)

  status=BASELINE
  if [[ -s "$history" ]]; then
    local prev
    prev=$(awk -F '\t' '$4 == "BASELINE" || $4 == "ACCEPTED" {v=$6 " " $12} END {print v}' "$history")
    local p32 p64
    read -r p32 p64 <<< "$prev"
    status=$(awk -v v="$verification" -v n32="$m32" -v n64="$m64" -v p32="$p32" -v p64="$p64" 'BEGIN {
      if (v != "PASS") print "REJECTED";
      else if ((n32 >= p32 * 1.01 || n64 >= p64 * 1.01) && n32 >= p32 * 0.99 && n64 >= p64 * 0.99) print "ACCEPTED";
      else print "NO_GAIN";
    }')
  elif [[ "$verification" != PASS ]]; then
    status=REJECTED
  fi

  mkdir -p "$(dirname "$history")"
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$(sanitize "$iteration")" "$(sanitize "$change")" "$verification" "$status" \
    "$d32" "$m32" "$s32" "$t32" "$a32" "$c32" \
    "$d64" "$m64" "$s64" "$t64" "$a64" "$c64" >> "$history"

  if [[ "$status" == BASELINE || "$status" == ACCEPTED ]]; then
    mkdir -p "$best_root"
    for unit in "${units[@]}"; do
      rm -rf "$best_root/$unit"
      cp -a "$trial_root/$unit" "$best_root/$unit"
    done
  fi
  render_report
  printf 'iteration=%s status=%s fp32_fmax_mhz=%s fp64_fmax_mhz=%s\n' "$iteration" "$status" "$m32" "$m64"
}

case "$command" in
  run)
    fp_source_hash=$(check_generated)
    [[ "$iteration" != *$'\t'* && "$iteration" != *$'\n'* ]] || { echo 'invalid FP_PPA_ITERATION' >&2; exit 2; }
    [[ ! -e "$trial_root" ]] || { echo "iteration already exists: $iteration" >&2; exit 2; }
    mkdir -p "$trial_root"
    pids=()
    for i in "${!units[@]}"; do run_unit "$i" > "$trial_root/${units[$i]}.log" 2>&1 & pids+=("$!"); done
    failed=0
    for pid in "${pids[@]}"; do wait "$pid" || failed=1; done
    if ((failed)); then
      archive_evidence
      echo "FP lane PPA failed; inspect $trial_root" >&2
      exit 1
    fi
    archive_evidence
    record_trial
    ;;
  summary) render_report ;;
  *) echo "usage: $0 {run|summary}" >&2; exit 2 ;;
esac
