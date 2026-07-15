#!/usr/bin/env bash
set -euo pipefail

case_file=""
output=""
max_cycles=""
build_dir=""
while (($#)); do
  case "$1" in
    --case) case_file="$2"; shift 2 ;;
    --output) output="$2"; shift 2 ;;
    --max-cycles) max_cycles="$2"; shift 2 ;;
    --build-dir) build_dir="$2"; shift 2 ;;
    *) echo "usage: $0 --case CASE.YAML --output DIR [--max-cycles N] [--build-dir DIR]" >&2; exit 2 ;;
  esac
done
[[ -n "$case_file" && -n "$output" ]] || { echo "usage: $0 --case CASE.YAML --output DIR" >&2; exit 2; }
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
args=(--case "$case_file" --output "$output")
[[ -n "$max_cycles" ]] && args+=(--max-cycles "$max_cycles")
[[ -n "$build_dir" ]] && args+=(--build-dir "$build_dir")
PYTHONPATH="$repo_root" python3 "$repo_root/rtl/scripts/run_eval_case.py" "${args[@]}"
