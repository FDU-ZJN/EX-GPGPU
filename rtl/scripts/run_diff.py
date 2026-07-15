#!/usr/bin/env python3
"""Run retirement-by-retirement CModel/RTL comparison inside the simulator."""
from __future__ import annotations

import argparse
import json
import subprocess
from pathlib import Path

from cmodel.runner import load_yaml


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--case", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--max-cycles", type=int)
    parser.add_argument("--build-dir", help="reuse a Verilator build directory")
    args = parser.parse_args()

    repo = Path(__file__).resolve().parents[2]
    case = Path(args.case).resolve()
    output = Path(args.output).resolve()
    rtl_out = output / "rtl"
    output.mkdir(parents=True, exist_ok=True)
    trace = rtl_out / "commit_trace.jsonl"
    build_dir = Path(args.build_dir).resolve() if args.build_dir else repo / "rtl" / ".eval_obj"
    command = [str(repo / "scripts/run_rtl.sh"), "--case", str(case), "--output", str(rtl_out),
               "--trace", str(trace), "--build-dir", str(build_dir),
               "--realtime-diff", str(repo)]
    if args.max_cycles is not None:
        command += ["--max-cycles", str(args.max_cycles)]
    completed = subprocess.run(command, text=True, capture_output=True)
    log = completed.stdout + completed.stderr
    (output / "realtime.log").write_text(log)
    result_path = rtl_out / "result.json"
    result = json.loads(result_path.read_text()) if result_path.is_file() else {"status": "runner_error"}
    passed = completed.returncode == 0 and result.get("passed", False)
    failure = None if passed else {
        "kind": "realtime",
        "returncode": completed.returncode,
        "status": result.get("status"),
        "detail": result.get("detail") or result.get("failures") or log.strip().splitlines()[-10:],
    }
    manifest = load_yaml(case)
    summary = {
        "case": manifest.get("case_id", case.parent.name),
        "mode": "in_process_realtime",
        "passed": passed,
        "result": result,
        "failures": [] if passed else [failure],
        "artifacts": {"trace": str(trace), "log": str(output / "realtime.log"),
                      "vcd": str(rtl_out / "run.vcd")},
    }
    (output / "diff.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
