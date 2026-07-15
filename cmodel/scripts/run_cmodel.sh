#!/usr/bin/env bash
set -euo pipefail

case_file=""
output=""
trace=""
while (($#)); do
  case "$1" in
    --case) case_file="$2"; shift 2 ;;
    --output) output="$2"; shift 2 ;;
    --trace) trace="$2"; shift 2 ;;
    *) echo "usage: $0 --case CASE.YAML --output DIR" >&2; exit 2 ;;
  esac
done
if [[ -z "$case_file" || -z "$output" ]]; then
  echo "usage: $0 --case CASE.YAML --output DIR" >&2
  exit 2
fi

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PYTHONPATH="$REPO_ROOT" python3 -c \
  'from cmodel.runner import run_case; import sys; run_case(sys.argv[1], sys.argv[2], sys.argv[3] or None)' \
  "$case_file" "$output" "$trace"
