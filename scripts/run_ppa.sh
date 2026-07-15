#!/usr/bin/env bash
set -euo pipefail

# Contest-facing PPA entry point. The RTL flow owns synthesis and STA so the
# same generated judged RTL is used by both make and the required CLI.
root=$(cd "$(dirname "$0")/.." && pwd)
output="reports/ppa"
period=${PERIOD_PS:-1000}
asap7_root=${ASAP7_ROOT:-}
asap7_sram_root=${ASAP7_SRAM_ROOT:-}
strict=${PPA_STRICT:-1}
top=${PPA_TOP:-aec_eval_top}
rtl_sources=${RTL_SOURCES:-rtl/sv/generated/eval/AecEvalTop.sv rtl/sv/aec_eval_top.sv rtl/sv/asap7_sram_wrappers.sv}
activity_vcd=${ACTIVITY_VCD:-}
activity_scope=${ACTIVITY_SCOPE:-$top}
sta=${STA:-sta}
yosys=${YOSYS:-yosys}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --output) [[ $# -ge 2 ]] || { echo "--output requires a directory" >&2; exit 2; }; output=$2; shift 2;;
    --period-ps) [[ $# -ge 2 ]] || { echo "--period-ps requires a value" >&2; exit 2; }; period=$2; shift 2;;
    --asap7-root) [[ $# -ge 2 ]] || { echo "--asap7-root requires a directory" >&2; exit 2; }; asap7_root=$2; shift 2;;
    --asap7-sram-root) [[ $# -ge 2 ]] || { echo "--asap7-sram-root requires a directory" >&2; exit 2; }; asap7_sram_root=$2; shift 2;;
    --top) [[ $# -ge 2 ]] || { echo "--top requires a module" >&2; exit 2; }; top=$2; shift 2;;
    --rtl-sources) [[ $# -ge 2 ]] || { echo "--rtl-sources requires a list" >&2; exit 2; }; rtl_sources=$2; shift 2;;
    --activity-vcd) [[ $# -ge 2 ]] || { echo "--activity-vcd requires a file" >&2; exit 2; }; activity_vcd=$2; shift 2;;
    --strict) strict=1; shift;;
    --non-strict) strict=0; shift;;
    -h|--help) sed -n '1,32p' "$0"; exit 0;;
    *) echo "unknown option: $1" >&2; exit 2;;
  esac
done

[[ "$output" = /* ]] || output="$root/$output"
[[ -n "$asap7_root" ]] || {
  echo "ASAP7_ROOT is required for the spec-defined PPA flow; proxy reports are not PPA." >&2
  exit 2
}
[[ -n "$asap7_sram_root" ]] || {
  echo "ASAP7_SRAM_ROOT is required for the locked Track-B SRAM views." >&2
  exit 2
}

exec env OUT_DIR="$output" PERIOD_PS="$period" ASAP7_ROOT="$asap7_root" ASAP7_SRAM_ROOT="$asap7_sram_root" \
  PPA_TOP="$top" RTL_SOURCES="$rtl_sources" ACTIVITY_VCD="$activity_vcd" ACTIVITY_SCOPE="$activity_scope" \
  PPA_STRICT="$strict" STA="$sta" YOSYS="$yosys" \
  "$root/rtl/scripts/report_yosys_ppa.sh"
