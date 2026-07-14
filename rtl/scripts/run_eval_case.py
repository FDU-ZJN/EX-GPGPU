#!/usr/bin/env python3
"""Execute and verify an AEC testcase using the functional RTL interface."""
from __future__ import annotations

import argparse
import json
import math
import struct
import subprocess
from pathlib import Path

from cmodel.runner import derive_capacities, load_yaml


def dump_name(address: int) -> str:
    return f"gmem_{address:016x}.bin"


def compare_memory(actual: bytes, expected: bytes, policy: str, tolerance: float) -> str | None:
    if len(actual) != len(expected):
        return f"size mismatch: actual={len(actual)} expected={len(expected)}"
    if policy == "exact":
        for offset, (got, want) in enumerate(zip(actual, expected)):
            if got != want:
                return f"byte mismatch at +0x{offset:x}: actual=0x{got:02x} expected=0x{want:02x}"
        return None
    if policy == "relative":
        if len(actual) % 4:
            return "relative comparison requires a whole number of FP32 words"
        for offset in range(0, len(actual), 4):
            got = struct.unpack_from("<f", actual, offset)[0]
            want = struct.unpack_from("<f", expected, offset)[0]
            if math.isnan(got) and math.isnan(want):
                continue
            if math.isinf(want):
                matches = got == want
            elif want == 0.0:
                matches = abs(got) <= tolerance
            else:
                matches = abs(got - want) / abs(want) <= tolerance
            if not matches:
                return (f"FP32 mismatch at word {offset // 4} (+0x{offset:x}): "
                        f"actual={got!r} expected={want!r} relative_tolerance={tolerance}")
        return None
    return f"unsupported comparison policy {policy!r}"


p = argparse.ArgumentParser()
p.add_argument("--case", required=True)
p.add_argument("--output", required=True)
p.add_argument("--max-cycles", type=int, help="override the case cycle limit")
p.add_argument("--trace", help="write architectural commit events as JSONL")
p.add_argument("--build-dir", help="reuse a Verilator build directory")
p.add_argument("--realtime-diff", help="repo root for the in-process CModel API")
args = p.parse_args()

case = Path(args.case).resolve()
out = Path(args.output).resolve()
out.mkdir(parents=True, exist_ok=True)
manifest = load_yaml(case)
capacities = derive_capacities(case, manifest)
repo = Path(__file__).resolve().parents[2]
build = Path(args.build_dir).resolve() if args.build_dir else repo / "build" / "rtl_eval"
runner = build / "aec_eval_runner"
if not runner.is_file():
    subprocess.run(["make", "-C", str(repo / "rtl"), "eval-runner", f"EVAL_BUILD_DIR={build}"], check=True)

program = case.parent / manifest["program"]
program_bytes = program.read_bytes()
if len(program_bytes) % 16:
    raise SystemExit(f"program image is not 16-byte aligned: {program}")
launch = manifest["launch"]
instructions = launch.get("program_instructions", len(program_bytes) // 16)
limit = args.max_cycles if args.max_cycles is not None else manifest.get("max_cycles", 100000)
cmd = [str(runner), str(program), str(instructions),
       *(str(v) for v in launch["grid"]), *(str(v) for v in launch["block"]),
       str(limit), str(out)]
for target, name in ((1, "gmem"), (2, "pmem"), (3, "cmem")):
    cmd += ["--capacity", str(target), str(capacities[name])]

target_map = {"gmem": 1, "pmem": 2, "cmem": 3}
for image in manifest.get("memory_init", []):
    target = image.get("target", "gmem")
    if target not in target_map:
        raise SystemExit(f"unsupported initialization target {target!r}")
    path = case.parent / image["file"]
    if not path.is_file():
        raise SystemExit(f"missing initialization image {path}")
    cmd += ["--init", str(target_map[target]), hex(image["address"]), str(path)]

expected = manifest.get("expected", {})
for dump in expected.get("memory", []):
    if dump.get("target", "gmem") == "gmem":
        cmd += ["--dump", hex(dump["address"]), str(dump["size"])]
if args.trace:
    trace = Path(args.trace).resolve()
    trace.parent.mkdir(parents=True, exist_ok=True)
    cmd += ["--trace", str(trace)]
if args.realtime_diff:
    cmd += ["--realtime-diff", str(Path(args.realtime_diff).resolve())]
subprocess.run(cmd, check=False)

result_path = out / "result.json"
result = json.loads(result_path.read_text()) if result_path.is_file() else {"status": "runner_error"}
failures: list[str] = []
want_status = expected.get("status", "done")
if result.get("status") != want_status:
    failures.append(f"status mismatch: actual={result.get('status', 'missing')} expected={want_status}")

policy = expected.get("comparison", "exact")
tolerance = float(expected.get("relative_tolerance", expected.get("absolute_tolerance", 0.0)))
for dump in expected.get("memory", []):
    target = dump.get("target", "gmem")
    actual_path = out / (dump_name(dump["address"]) if target == "gmem" else f"{target}_{dump['address']:016x}.bin")
    expected_path = case.parent / dump["file"]
    if target != "gmem":
        shadow = bytearray(capacities[target])
        for image in manifest.get("memory_init", []):
            if image.get("target", "gmem") == target:
                payload = (case.parent / image["file"]).read_bytes()
                shadow[image["address"]:image["address"] + len(payload)] = payload
        actual_path.write_bytes(shadow[dump["address"]:dump["address"] + dump["size"]])
    if not actual_path.is_file():
        failures.append(f"missing GMEM dump 0x{dump['address']:08x} (execution did not reach readable completion)")
        continue
    mismatch = compare_memory(actual_path.read_bytes(), expected_path.read_bytes(), policy, tolerance)
    if mismatch:
        failures.append(f"GMEM 0x{dump['address']:08x}: {mismatch}")

result["expected_status"] = want_status
result["comparison"] = policy
result["passed"] = not failures
result["failures"] = failures
result_path.write_text(json.dumps(result, indent=2) + "\n")
if failures:
    print("RTL verification FAILED:", *[f"  - {failure}" for failure in failures], sep="\n")
    raise SystemExit(1)
print(f"RTL verification PASSED: {manifest.get('case_id', case.parent.name)} ({result.get('cycles', 0)} cycles)")
