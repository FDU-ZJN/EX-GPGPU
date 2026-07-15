#!/usr/bin/env bash
set -euo pipefail

# Map independent RTLIL modules with separate single-threaded ABC processes.
# Berkeley ABC itself has no -j option, so process-level module parallelism is
# the only safe way to use multiple CPUs without changing logic boundaries.

mode=${1:-}
if [[ "$mode" == --worker ]]; then
  [[ $# -eq 6 ]] || exit 2
  input=$2
  output=$3
  abc_script=$4
  yosys_bin=$5
  log=$6
  "$yosys_bin" -Q -p "read_rtlil $input; abc -script $abc_script; clean; write_rtlil $output" > "$log" 2>&1
  exit
fi

if [[ $# -ne 6 ]]; then
  echo "usage: $0 <pre-abc.il> <modules.txt> <abc.script> <output-dir> <jobs> <yosys>" >&2
  exit 2
fi

pre_abc=$1
modules=$2
abc_script=$3
out=$4
jobs=$5
yosys_bin=$6
[[ "$jobs" =~ ^[1-9][0-9]*$ ]] || { echo "jobs must be a positive integer" >&2; exit 2; }

mkdir -p "$out/input" "$out/mapped" "$out/log"
find "$out/input" "$out/mapped" "$out/log" -maxdepth 1 -type f -delete
manifest="$out/modules.manifest"
extract_script="$out/extract_modules.ys"
: > "$manifest"
{
  echo "read_rtlil $pre_abc"
  index=0
  while IFS= read -r module; do
    [[ -n "$module" ]] || continue
    [[ "$module" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] || {
      echo "unsupported module name for parallel ABC: $module" >&2
      exit 2
    }
    id=$(printf '%04d' "$index")
    echo "$id $module" >> "$manifest"
    echo "select -clear"
    echo "select $module"
    echo "write_rtlil -selected $out/input/$id.il"
    index=$((index + 1))
  done < "$modules"
} > "$extract_script"

[[ -s "$manifest" ]] || { echo "no modules selected for parallel ABC" >&2; exit 1; }
"$yosys_bin" -Q -s "$extract_script" > "$out/extract_modules.log" 2>&1

export runner=$0 abc_script yosys_bin out
cut -d' ' -f1 "$manifest" | xargs -r -P "$jobs" -n 1 bash -c \
  'exec "$runner" --worker "$out/input/$1.il" "$out/mapped/$1.il" "$abc_script" "$yosys_bin" "$out/log/$1.log"' _

expected=$(wc -l < "$manifest")
actual=$(find "$out/mapped" -maxdepth 1 -name '*.il' -type f | wc -l)
[[ "$actual" -eq "$expected" ]] || {
  echo "parallel ABC produced $actual of $expected mapped modules" >&2
  exit 1
}
