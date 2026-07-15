#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

required=(
  README.md
  TrackB-b-013/spec.md
  rtl/Makefile
  rtl/build.sbt
  rtl/sv/aec_eval_top.sv
  rtl/sv/asap7_sram_wrappers.sv
  rtl/sv/asap7_sram/srambank_64x4x32_6t122.v
  rtl/sv/asap7_sram/srambank_128x4x32_6t122.v
  rtl/sv/asap7_sram/srambank_256x4x32_6t122.v
  rtl/sv/asap7_sram/srambank_64x4x64_6t122.v
  rtl/scripts/verify_sram_models.sh
  rtl/sv/generated/eval_core/AecEvalCore.sv
  rtl/files.f
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
  evidence/final_public36/summary.json
)

failed=0

allowed_top=(.git .gitignore README.md TrackB-b-013 rtl cmodel scripts reports evidence)
while IFS= read -r entry; do
  allowed=0
  for expected in "${allowed_top[@]}"; do
    [[ "$entry" == "$expected" ]] && allowed=1
  done
  if (( ! allowed )); then
    echo "unexpected top-level entry: $entry" >&2
    failed=1
  fi
done < <(find . -maxdepth 1 -mindepth 1 -printf '%f\n' | sort)
for path in "${required[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "missing required submission file: $path" >&2
    failed=1
  fi
done

while IFS= read -r path; do
  echo "prohibited generated file exists in submission tree: $path" >&2
  failed=1
done < <(find rtl cmodel scripts reports evidence -type f \
  \( -name '*.o' -o -name '*.a' -o -name '*.so' -o -name '*.vcd' -o -name '*.fst' \
     -o -name '*.fir' -o -name '*.anno.json' -o -name 'mapped.json' \
     -o -name 'mapped_netlist.v' \) -print | sort)

if ! cmp -s rtl/sv/asap7_sram_wrappers.sv TrackB-b-013/sram/asap7_sram_wrappers.sv; then
  echo "rtl/sv/asap7_sram_wrappers.sv differs from the supplied TrackB-b-013 wrapper" >&2
  failed=1
fi

if ! rtl/scripts/verify_sram_models.sh; then
  failed=1
fi

if ! grep -qx 'sv/generated/eval_core/AecEvalCore.sv' rtl/files.f ||
   grep -q 'generated/eval/AecEvalTop.sv' rtl/files.f; then
  echo "rtl/files.f does not select the current generated AecEvalCore" >&2
  failed=1
fi

for script in scripts/build.sh scripts/run_cmodel.sh scripts/run_rtl.sh scripts/run_tests.sh scripts/run_ppa.sh rtl/scripts/verify_sram_models.sh; do
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
  .gitignore README.md TrackB-b-013 rtl cmodel scripts reports evidence)
for path in "${candidates[@]}"; do
  case "$path" in
    local/*|output/*|build/*|.toolchain-src/*|*/__pycache__/*|*/.sbt-global/*|rtl/target/*|rtl/test_run_dir/*|rtl/.*_obj/*|*.o|*.a|*.so|*.vcd|*.fst|*.fir|*.anno.json|*mapped.json|*mapped_netlist.v)
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
