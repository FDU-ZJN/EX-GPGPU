#!/usr/bin/env bash
set -euo pipefail

suite=""
output=""
while (($#)); do
  case "$1" in
    --suite) suite="$2"; shift 2 ;;
    --output) output="$2"; shift 2 ;;
    *) echo "usage: $0 --suite public --output DIR" >&2; exit 2 ;;
  esac
done
if [[ "$suite" != public || -z "$output" ]]; then
  echo "usage: $0 --suite public --output DIR" >&2
  exit 2
fi

CMODEL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO_ROOT="$(cd "$CMODEL_ROOT/.." && pwd)"
PYTHONPATH="$REPO_ROOT" python3 - "$output" <<'PY'
import json, math, struct, subprocess, sys
from pathlib import Path
from cmodel.runner import load_yaml

repo = Path(__file__).resolve().parent
if repo.name == "<stdin>":
    repo = Path.cwd()
while not (repo / "TrackB-b-013/testcases/PUBLIC_CASES.txt").exists() and repo != repo.parent:
    repo = repo.parent
root = repo / "TrackB-b-013/testcases"
out_root = Path(sys.argv[1])
out_root.mkdir(parents=True, exist_ok=True)
failures = []
cases = [x.strip() for x in (root / "PUBLIC_CASES.txt").read_text().splitlines() if x.strip()]
runner = repo / "cmodel/scripts/run_cmodel.sh"

def relative_f32_match(got, want, tolerance):
    if len(got) != len(want) or len(got) % 4:
        return False
    for offset in range(0, len(got), 4):
        actual = struct.unpack_from('<f', got, offset)[0]
        expected = struct.unpack_from('<f', want, offset)[0]
        if math.isnan(expected):
            if not math.isnan(actual): return False
        elif math.isinf(expected):
            if actual != expected: return False
        elif expected == 0.0:
            if abs(actual) > tolerance: return False
        elif abs(actual - expected) / abs(expected) > tolerance:
            return False
    return True

for rel in cases:
    case = root / rel
    manifest = load_yaml(case / "case.yaml")
    out = out_root / rel.replace("/", "_")
    cp = subprocess.run([str(runner), "--case", str(case / "case.yaml"), "--output", str(out)], text=True, capture_output=True)
    if cp.returncode:
        failures.append({"case": rel, "reason": "runner", "detail": cp.stderr.strip() or cp.stdout.strip()})
        continue
    result = json.loads((out / "result.json").read_text())
    expected = manifest["expected"]
    if result["status"] != expected["status"]:
        failures.append({"case": rel, "reason": "status", "got": result["status"], "expected": expected["status"]})
        continue
    for mem in expected.get("memory", []):
        got = out / f"gmem_{mem['address']:016x}.bin"
        want = case / mem["file"]
        matched = got.exists() and (got.read_bytes() == want.read_bytes() if expected.get("comparison", "exact") == "exact" else relative_f32_match(got.read_bytes(), want.read_bytes(), expected.get("relative_tolerance", 0.0)))
        if not matched:
            failures.append({"case": rel, "reason": "memory", "file": mem["file"]})

failed_cases = {f["case"] for f in failures}
summary = {"suite": "public", "total": len(cases), "passed": len(cases) - len(failed_cases), "failed": len(failed_cases), "failures": failures}
(out_root / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
print(json.dumps(summary, indent=2))
raise SystemExit(1 if failures else 0)
PY
