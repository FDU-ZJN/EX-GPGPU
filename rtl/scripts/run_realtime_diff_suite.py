#!/usr/bin/env python3
"""Run testcase realtime diffs serially and stop at the first failure."""
from __future__ import annotations

import argparse
import json
import shlex
import subprocess
import sys
from pathlib import Path


def public_cases(test_root: Path) -> list[Path]:
    case_list = test_root / "PUBLIC_CASES.txt"
    cases = []
    for raw_line in case_list.read_text().splitlines():
        line = raw_line.strip()
        if line and not line.startswith("#"):
            cases.append(test_root / line / "case.yaml")
    return cases


def all_cases(test_root: Path) -> list[Path]:
    return sorted((test_root / "tests" / "aec_cases").rglob("case.yaml"))


def case_name(case: Path, test_root: Path) -> str:
    return case.parent.relative_to(test_root).as_posix()


def write_summary(path: Path, summary: dict) -> None:
    temporary = path.with_suffix(".json.tmp")
    temporary.write_text(json.dumps(summary, indent=2) + "\n")
    temporary.replace(path)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Run in-simulator CModel/RTL difftest and stop on the first failing testcase."
    )
    parser.add_argument("--output", required=True, help="suite artifact directory")
    parser.add_argument("--suite", choices=("all", "public"), default="all",
                        help="discover every case.yaml (default) or use PUBLIC_CASES.txt")
    parser.add_argument("--start-at", help="skip cases before this case path (useful for resuming)")
    parser.add_argument("--max-cycles", type=int, help="override every testcase cycle limit")
    parser.add_argument("--build-dir", help="reuse a Verilator build directory")
    parser.add_argument("--list-only", action="store_true", help="print selected cases without building")
    args = parser.parse_args()

    repo = Path(__file__).resolve().parents[2]
    test_root = repo / "Track-B" / "testcases"
    output = Path(args.output).resolve()
    cases = all_cases(test_root) if args.suite == "all" else public_cases(test_root)

    missing = [case for case in cases if not case.is_file()]
    if missing:
        print(f"missing testcase manifest: {missing[0]}", file=sys.stderr)
        return 2

    names = [case_name(case, test_root) for case in cases]
    if args.start_at:
        requested = args.start_at.removesuffix("/case.yaml").rstrip("/")
        try:
            start = names.index(requested)
        except ValueError:
            print(f"--start-at does not match a selected testcase: {args.start_at}", file=sys.stderr)
            return 2
        cases = cases[start:]
        names = names[start:]

    if args.list_only:
        print("\n".join(names))
        return 0
    if not cases:
        print("no testcases selected", file=sys.stderr)
        return 2

    output.mkdir(parents=True, exist_ok=True)
    build_dir = Path(args.build_dir).resolve() if args.build_dir else output / ".eval_obj"
    summary_path = output / "summary.json"
    summary = {
        "suite": args.suite,
        "fail_fast": True,
        "total": len(cases),
        "passed": 0,
        "failed": 0,
        "remaining": len(cases),
        "current": None,
        "first_failure": None,
    }
    write_summary(summary_path, summary)

    build_command = ["make", "-C", str(repo / "rtl"), "eval-runner",
                     f"EVAL_BUILD_DIR={build_dir}"]
    print(f"Building realtime difftest runner: {shlex.join(build_command)}", flush=True)
    build = subprocess.run(build_command)
    if build.returncode:
        summary["failed"] = 1
        summary["first_failure"] = {
            "stage": "build", "returncode": build.returncode,
            "command": shlex.join(build_command),
        }
        write_summary(summary_path, summary)
        print(f"FAIL-FAST: runner build failed; summary: {summary_path}", file=sys.stderr)
        return build.returncode

    for index, (case, name) in enumerate(zip(cases, names), start=1):
        case_output = output / "cases" / case.parent.relative_to(test_root)
        command = [str(repo / "scripts" / "run_diff.sh"),
                   "--case", str(case), "--output", str(case_output),
                   "--build-dir", str(build_dir)]
        if args.max_cycles is not None:
            command += ["--max-cycles", str(args.max_cycles)]
        summary["current"] = name
        write_summary(summary_path, summary)
        print(f"\n[{index}/{len(cases)}] REALTIME DIFF {name}", flush=True)
        completed = subprocess.run(command)
        if completed.returncode:
            diff_path = case_output / "diff.json"
            diff = json.loads(diff_path.read_text()) if diff_path.is_file() else None
            reproduce = [str(repo / "scripts" / "run_diff.sh"), "--case", str(case),
                         "--output", str(case_output), "--build-dir", str(build_dir)]
            if args.max_cycles is not None:
                reproduce += ["--max-cycles", str(args.max_cycles)]
            failure = {
                "stage": "difftest",
                "case": name,
                "returncode": completed.returncode,
                "artifacts": str(case_output),
                "diff": diff,
                "reproduce": shlex.join(reproduce),
            }
            summary["failed"] = 1
            summary["remaining"] = len(cases) - index
            summary["first_failure"] = failure
            write_summary(summary_path, summary)
            print(f"\nFAIL-FAST at {name}", file=sys.stderr)
            print(f"Artifacts: {case_output}", file=sys.stderr)
            print(f"Reproduce: {failure['reproduce']}", file=sys.stderr)
            print(f"Suite summary: {summary_path}", file=sys.stderr)
            return completed.returncode

        summary["passed"] = index
        summary["remaining"] = len(cases) - index
        summary["current"] = None
        write_summary(summary_path, summary)

    print(f"\nPASS: all {len(cases)} realtime difftests passed", flush=True)
    print(f"Suite summary: {summary_path}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
