#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

required=(
  README.md
  rtl/Makefile
  rtl/build.sbt
  rtl/sv/aec_eval_top.sv
  rtl/sv/asap7_sram_wrappers.sv
  rtl/sv/generated/eval/AecEvalTop.sv
  rtl/tests/aec_eval_runner.cpp
  cmodel/Makefile
  cmodel/aec_cmodel_api.cpp
  cmodel/aec_cmodel_api.h
  scripts/build.sh
  scripts/run_cmodel.sh
  scripts/run_rtl.sh
  scripts/run_tests.sh
  scripts/run_ppa.sh
  reports/DESIGN.md
  reports/VERIFICATION.md
  reports/PPA.md
  reports/LIMITATIONS.md
  evidence/public_realtime_summary.json
)

failed=0
for path in "${required[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "missing required submission file: $path" >&2
    failed=1
  fi
done

if ! cmp -s rtl/sv/asap7_sram_wrappers.sv Track-B/sram/asap7_sram_wrappers.sv; then
  echo "rtl/sv/asap7_sram_wrappers.sv differs from the supplied Track-B wrapper" >&2
  failed=1
fi

for script in scripts/build.sh scripts/run_cmodel.sh scripts/run_rtl.sh scripts/run_tests.sh scripts/run_ppa.sh scripts/run_diff.sh scripts/run_realtime_diff_tests.sh; do
  if [[ ! -x "$script" ]]; then
    echo "entry point is not executable: $script" >&2
    failed=1
  fi
done

while IFS= read -r script; do
  if ! bash -n "$script"; then
    failed=1
  fi
done < <(find scripts cmodel/scripts rtl/scripts -type f -name '*.sh' -print | sort)

if ! python3 - <<'PY'
import ast
from pathlib import Path

for directory in (Path("cmodel"), Path("rtl/scripts")):
    for path in directory.rglob("*.py"):
        ast.parse(path.read_text(), filename=str(path))
PY
then
  failed=1
fi

# Inspect exactly the files that would be packaged: tracked files plus
# non-ignored participant files. This works before or after git add.
mapfile -d '' candidates < <(git ls-files -z --cached --others --exclude-standard -- \
  .gitignore README.md Makefile Track-B rtl cmodel scripts reports evidence)
for path in "${candidates[@]}"; do
  case "$path" in
    local/*|output/*|build/*|.toolchain-src/*|*/__pycache__/*|rtl/target/*|rtl/test_run_dir/*|rtl/.*_obj/*|*.o|*.a|*.so|*.vcd|*.fst|*.fir|*.anno.json)
      echo "generated/local file would enter submission: $path" >&2
      failed=1
      ;;
  esac
  if [[ -f "$path" ]] && (( $(stat -c %s "$path") > 52428800 )); then
    echo "file larger than 50 MiB requires explicit review: $path" >&2
    failed=1
  fi
done

if ((failed)); then
  echo "submission check FAILED" >&2
  exit 1
fi

echo "submission check PASSED (${#candidates[@]} candidate files)"
