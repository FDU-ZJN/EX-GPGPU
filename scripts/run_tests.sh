#!/usr/bin/env bash
set -euo pipefail

model="rtl"
args=()
while (($#)); do
  case "$1" in
    --model) model="$2"; shift 2 ;;
    *) args+=("$1"); shift ;;
  esac
done
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
case "$model" in
  rtl) PYTHONPATH="$repo_root" python3 "$repo_root/rtl/scripts/run_eval_suite.py" "${args[@]}" ;;
  cmodel) exec "$repo_root/cmodel/scripts/run_tests.sh" "${args[@]}" ;;
  *) echo "usage: $0 --suite public --output DIR [--model rtl|cmodel]" >&2; exit 2 ;;
esac
