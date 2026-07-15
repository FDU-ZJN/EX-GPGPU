#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
count=${COUNT:-200}
seed=${SEED:-1}
backpressure=${BACKPRESSURE:-35}
unit=${UNIT:-fp32}
vectors=
while (($#)); do
  case "$1" in
    --count) count=$2; shift 2 ;;
  --seed) seed=$2; shift 2 ;;
    --backpressure) backpressure=$2; shift 2 ;;
    --unit) unit=$2; shift 2 ;;
    --vectors) vectors=$2; shift 2 ;;
    *) echo "usage: $0 [--count N] [--seed N] [--backpressure PCT] [--unit fp32|fp64] [--vectors FILE]" >&2; exit 2 ;;
  esac
done
if [[ -z $vectors ]]; then
  vectors=$(mktemp "${TMPDIR:-/tmp}/aec-fp-vectors.XXXXXX")
  trap 'rm -f "$vectors"' EXIT
  PYTHONPATH="$root/.." python3 "$root/tests/generate_fp_golden.py" --count "$count" --seed "$seed" --output "$vectors"
fi
case "$unit" in
  fp32)
    top=AecFp32Unit; source="$root/sv/generated/fp32/AecFp32Unit.sv"; obj="$root/.fp32_diff_obj"; define=FP32_UNIT ;;
  fp64)
    top=AecFp64Unit; source="$root/sv/generated/fp64/AecFp64Unit.sv"; obj="$root/.fp64_diff_obj"; define=FP64_UNIT ;;
  *) echo "bad unit: $unit" >&2; exit 2 ;;
esac
flags=()
if [[ -n $define ]]; then flags+=("-CFLAGS" "-D$define"); fi
verilator --cc --exe --build --top-module "$top" "$source" "$root/tests/fp_diff.cpp" \
  -Mdir "$obj" -o fp_diff "${flags[@]}"
"$obj/fp_diff" "$vectors" --seed "$seed" --backpressure "$backpressure"
