#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
PYTHONPATH="$repo_root" exec python3 "$repo_root/rtl/scripts/run_diff.py" "$@"
