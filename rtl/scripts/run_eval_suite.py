#!/usr/bin/env python3
"""Run the public RTL suite and collect manifest-level verification failures."""
from __future__ import annotations

import argparse
import json
import subprocess
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument("--suite", required=True, choices=["public"])
p.add_argument("--output", required=True)
args = p.parse_args()

repo = Path(__file__).resolve().parents[2]
tests = repo / "TrackB-b-013/testcases"
out_root = Path(args.output).resolve()
out_root.mkdir(parents=True, exist_ok=True)
cases = [line.strip() for line in (tests / "PUBLIC_CASES.txt").read_text().splitlines() if line.strip()]
failures = []
for rel in cases:
    case = tests / rel / "case.yaml"
    out = out_root / rel.replace("/", "_")
    cp = subprocess.run([str(repo / "scripts/run_rtl.sh"), "--case", str(case), "--output", str(out)], text=True, capture_output=True)
    result_path = out / "result.json"
    result = json.loads(result_path.read_text()) if result_path.is_file() else {}
    if cp.returncode or not result.get("passed", False):
        failures.append({"case": rel, "returncode": cp.returncode,
                         "failures": result.get("failures", ["runner terminated before result.json"]),
                         "log": (cp.stderr or cp.stdout).strip()})

summary = {"suite": args.suite, "total": len(cases), "passed": len(cases) - len(failures),
           "failed": len(failures), "failures": failures}
(out_root / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
print(json.dumps(summary, indent=2))
raise SystemExit(1 if failures else 0)
