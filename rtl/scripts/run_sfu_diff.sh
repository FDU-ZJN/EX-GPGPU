#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
count=${COUNT:-100}
seed=${SEED:-1}
backpressure=${BACKPRESSURE:-35}
vectors=$(mktemp "${TMPDIR:-/tmp}/aec-sfu-vectors.XXXXXX")
trap 'rm -f "$vectors"' EXIT

PYTHONPATH="$root/.." python3 "$root/tests/generate_sfu_golden.py" \
  --count "$count" --seed "$seed" --output "$vectors"

verilator_bin=${VERILATOR:-$(command -v verilator || true)}
if [[ -z $verilator_bin && -x /root/.local/gpgpu-toolchain/bin/verilator ]]; then
  verilator_bin=/root/.local/gpgpu-toolchain/bin/verilator
fi
[[ -n $verilator_bin ]] || { echo "verilator not found" >&2; exit 2; }

obj="$root/.sfu_diff_obj"
"$verilator_bin" --cc --exe --build -j 4 --Wno-WIDTHEXPAND --top-module AecSfuWarpUnit \
  "$root/sv/generated/sfu/AecSfuWarpUnit.sv" "$root/tests/sfu_diff.cpp" \
  -Mdir "$obj" -o sfu_diff
"$obj/sfu_diff" "$vectors" --seed "$seed" --backpressure "$backpressure"
