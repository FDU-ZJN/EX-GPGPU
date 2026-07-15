#!/usr/bin/env bash
set -euo pipefail

case_file=""
output=""
max_cycles=""
trace=""
build_dir=""
realtime_diff=""
while (($#)); do
  case "$1" in
    --case) case_file="$2"; shift 2 ;;
    --output) output="$2"; shift 2 ;;
    --max-cycles) max_cycles="$2"; shift 2 ;;
    --trace) trace="$2"; shift 2 ;;
    --build-dir) build_dir="$2"; shift 2 ;;
    --realtime-diff) realtime_diff="$2"; shift 2 ;;
    *) echo "usage: $0 --case CASE.YAML --output DIR [--max-cycles N] [--trace FILE] [--build-dir DIR] [--realtime-diff REPO]" >&2; exit 2 ;;
  esac
done
[[ -n "$case_file" && -n "$output" ]] || { echo "usage: $0 --case CASE.YAML --output DIR" >&2; exit 2; }
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
args=(--case "$case_file" --output "$output")
[[ -n "$max_cycles" ]] && args+=(--max-cycles "$max_cycles")
[[ -n "$trace" ]] && args+=(--trace "$trace")
[[ -n "$build_dir" ]] && args+=(--build-dir "$build_dir")
[[ -n "$realtime_diff" ]] && args+=(--realtime-diff "$realtime_diff")
PYTHONPATH="$repo_root" python3 "$repo_root/rtl/scripts/run_eval_case.py" "${args[@]}"
