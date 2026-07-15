#!/usr/bin/env bash
set -euo pipefail

if (($#)); then
  echo "usage: $0" >&2
  exit 2
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
jobs="$(nproc)"

# Build the functional model and the exact contest-facing Verilator runner
# used by run_rtl.sh. Build products stay under build/, never beside sources.
make -C "$root/cmodel" -j "$jobs" all
make -C "$root/rtl" -j "$jobs" eval-runner EVAL_BUILD_DIR="$root/build/rtl_eval"
