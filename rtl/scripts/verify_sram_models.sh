#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
model_dir="$root/sv/asap7_sram"

declare -A expected=(
  [srambank_64x4x32_6t122.v]=097409acd1afbf401cb3fdeb223b84991945f388a0f06fa9834a0462bfc5db6c
  [srambank_128x4x32_6t122.v]=88a86e3173e29cd66dd8a6c62216d0f0d5025868952406fc18f700aeb3ff9ada
  [srambank_256x4x32_6t122.v]=e538901e1d8f7ffe075eccaa01d0aeee5ca113638bbbfb8c368976d3881f4a50
  [srambank_64x4x64_6t122.v]=c2f7275e150707f29430be083e78208f128570e501b3ca857cf9305f3b10d711
)

for file in "${!expected[@]}"; do
  path="$model_dir/$file"
  [[ -f "$path" ]] || { echo "missing locked SRAM behavioral model: $path" >&2; exit 1; }
  actual="$(sha256sum "$path" | awk '{print $1}')"
  [[ "$actual" == "${expected[$file]}" ]] || {
    echo "locked SRAM behavioral model checksum mismatch: $path" >&2
    echo "expected ${expected[$file]}" >&2
    echo "actual   $actual" >&2
    exit 1
  }
done

echo "locked SRAM behavioral models verified (${#expected[@]} files)"
