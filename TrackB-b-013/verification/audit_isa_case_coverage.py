#!/usr/bin/env python3
"""Mechanically audit canonical AEC ISA encoding coverage in ISA_CASES.txt."""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

from cmodel.core import aec_isa as I


ROOT = Path(__file__).resolve().parents[1]
TEST_ROOT = ROOT / "testcases"


def labels(values: set[tuple], names: list[dict[int, str] | None]) -> list[str]:
    result = []
    for value in sorted(values):
        parts = []
        for item, mapping in zip(value, names):
            parts.append(mapping.get(item, str(item)) if mapping is not None else str(item))
        result.append("/".join(parts))
    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", help="optional JSON report path")
    args = parser.parse_args()

    cases = [line.strip() for line in (TEST_ROOT / "ISA_CASES.txt").read_text().splitlines()
             if line.strip() and not line.lstrip().startswith("#")]
    opcodes: set[int] = set()
    legal_types: set[tuple[int, int]] = set()
    conversions: set[tuple[int, int, int]] = set()
    compares: set[tuple[int, int, int]] = set()
    atomics: set[tuple[int, int, int]] = set()
    shuffles: set[tuple[int, int]] = set()
    votes: set[tuple[int, int]] = set()
    loads: set[tuple[int, int]] = set()
    stores: set[tuple[int, int]] = set()
    ldc_types: set[int] = set()
    mbar_scopes: set[int] = set()
    sfu_modes: set[tuple[int, int]] = set()
    special_registers: set[int] = set()
    statuses: set[str] = set()

    cvt_ops = {I.OP_CVTFF, I.OP_CVTFI, I.OP_CVTIF, I.OP_CVTII}
    sfu_ops = {I.OP_RCP, I.OP_RSQ, I.OP_SIN, I.OP_COS, I.OP_EXP, I.OP_LOG, I.OP_SQRT}
    for relative in cases:
        directory = TEST_ROOT / relative
        manifest = (directory / "case.yaml").read_text()
        match = re.search(r"(?m)^\s{2}status:\s*(\S+)\s*$", manifest)
        if match:
            statuses.add(match.group(1))
        for instruction in I.read_binary(str(directory / "program.bin")):
            fields = I.decode_instr(instruction)
            opcode = fields["opcode"]
            if opcode not in I.OPCODE_NAMES:
                continue
            ctrl = I.decode_pred_ctrl(fields["pred_ctrl"])
            opcodes.add(opcode)
            legal_types.add((opcode, ctrl["dtype"]))
            if opcode in cvt_ops:
                conversions.add((opcode, ctrl["dtype"], (fields["pred_ctrl"] >> 10) & 0xF))
            if opcode in (I.OP_CMP, I.OP_CMPP):
                compares.add((opcode, ctrl["dtype"], ctrl["subop"]))
            if opcode == I.OP_ATOM:
                atomics.add((ctrl["dtype"], ctrl["ext"], ctrl["subop"]))
            if opcode == I.OP_SHUF:
                shuffles.add((ctrl["dtype"], ctrl["subop"]))
            if opcode == I.OP_VOTE:
                votes.add((ctrl["subop"], ctrl["ext"]))
            if opcode == I.OP_LD:
                loads.add((ctrl["dtype"], ctrl["ext"]))
            if opcode == I.OP_ST:
                stores.add((ctrl["dtype"], ctrl["ext"]))
            if opcode == I.OP_LDC:
                ldc_types.add(ctrl["dtype"])
            if opcode == I.OP_MBAR:
                mbar_scopes.add(ctrl["ext"])
            if opcode in sfu_ops:
                sfu_modes.add((opcode, ctrl["subop"]))
            if opcode == I.OP_CPY and fields["src1"] in I.SPREG_NAMES:
                special_registers.add(fields["src1"])

    expected_opcodes = set(I.OPCODE_NAMES)
    expected_types = {(opcode, dtype) for opcode, types in I.LEGAL_TYPES.items() for dtype in types}
    fp = {I.TYPE_F16, I.TYPE_BF16, I.TYPE_F32, I.TYPE_F64}
    integer = {I.TYPE_U8, I.TYPE_S8, I.TYPE_U32, I.TYPE_S32}
    expected_conversions = (
        {(I.OP_CVTFF, dst, src) for dst in fp for src in fp}
        | {(I.OP_CVTFI, dst, src) for dst in integer for src in fp}
        | {(I.OP_CVTIF, dst, src) for dst in fp for src in integer}
        | {(I.OP_CVTII, dst, src) for dst in integer for src in integer}
    )
    expected_compares = {(opcode, dtype, mode)
                         for opcode in (I.OP_CMP, I.OP_CMPP)
                         for dtype in (I.TYPE_U32, I.TYPE_S32, I.TYPE_F32)
                         for mode in I.CMP_NAMES}
    expected_atomics = {(dtype, space, subop)
                        for dtype in (I.TYPE_U32, I.TYPE_S32)
                        for space in (I.SPACE_GMEM, I.SPACE_SMEM)
                        for subop in I.ATOM_NAMES}
    expected_shuffles = {(dtype, mode)
                         for dtype in (I.TYPE_U32, I.TYPE_S32, I.TYPE_F32)
                         for mode in I.SHUF_MODE_NAMES}
    expected_votes = {(mode, destination) for mode in I.VOTE_MODE_NAMES for destination in (0, 1)}
    expected_loads = {(dtype, space) for dtype in I.LEGAL_TYPES[I.OP_LD] for space in range(5)}
    expected_stores = {(dtype, space) for dtype in I.LEGAL_TYPES[I.OP_ST]
                       for space in (I.SPACE_GMEM, I.SPACE_SMEM, I.SPACE_LMEM)}
    expected_ldc = set(I.LEGAL_TYPES[I.OP_LDC])
    expected_mbar = {I.MBAR_CT, I.MBAR_SYS}
    expected_sfu = {
        (I.OP_RCP, I.SFU_APPROX), (I.OP_RCP, I.SFU_FULL),
        (I.OP_RSQ, I.SFU_APPROX), (I.OP_RSQ, I.SFU_FULL),
        (I.OP_SQRT, I.SFU_APPROX), (I.OP_SQRT, I.SFU_FULL),
        (I.OP_SIN, 0), (I.OP_COS, 0), (I.OP_EXP, 0), (I.OP_LOG, 0),
    }
    expected_specials = set(I.SPREG_NAMES)

    missing = {
        "opcodes": labels({(x,) for x in expected_opcodes - opcodes}, [I.OPCODE_NAMES]),
        "legal_types": labels(expected_types - legal_types, [I.OPCODE_NAMES, I.TYPE_NAMES]),
        "conversions": labels(expected_conversions - conversions,
                              [I.OPCODE_NAMES, I.TYPE_NAMES, I.TYPE_NAMES]),
        "compares": labels(expected_compares - compares, [I.OPCODE_NAMES, I.TYPE_NAMES, I.CMP_NAMES]),
        "atomics": labels(expected_atomics - atomics, [I.TYPE_NAMES, I.SPACE_NAMES, I.ATOM_NAMES]),
        "shuffles": labels(expected_shuffles - shuffles, [I.TYPE_NAMES, I.SHUF_MODE_NAMES]),
        "votes": labels(expected_votes - votes, [I.VOTE_MODE_NAMES, {0: "gpr", 1: "predicate"}]),
        "loads": labels(expected_loads - loads, [I.TYPE_NAMES, I.SPACE_NAMES]),
        "stores": labels(expected_stores - stores, [I.TYPE_NAMES, I.SPACE_NAMES]),
        "ldc_types": labels({(x,) for x in expected_ldc - ldc_types}, [I.TYPE_NAMES]),
        "mbar_scopes": labels({(x,) for x in expected_mbar - mbar_scopes},
                              [{I.MBAR_CT: "ct", I.MBAR_SYS: "sys"}]),
        "sfu_modes": labels(expected_sfu - sfu_modes,
                            [I.OPCODE_NAMES, {I.SFU_APPROX: "approx", I.SFU_FULL: "full"}]),
        "special_registers": [I.SPREG_NAMES[x] for x in sorted(expected_specials - special_registers)],
        "statuses": sorted({"done", "invalid", "fail", "timeout"} - statuses),
    }
    report = {
        "suite_cases": len(cases),
        "covered": {
            "opcodes": len(opcodes), "legal_types": len(expected_types & legal_types),
            "conversions": len(expected_conversions & conversions),
            "compares": len(expected_compares & compares),
            "atomics": len(expected_atomics & atomics),
            "shuffles": len(expected_shuffles & shuffles),
            "votes": len(expected_votes & votes), "loads": len(expected_loads & loads),
            "stores": len(expected_stores & stores), "ldc_types": len(expected_ldc & ldc_types),
            "mbar_scopes": len(expected_mbar & mbar_scopes),
            "sfu_modes": len(expected_sfu & sfu_modes),
            "special_registers": len(expected_specials & special_registers),
            "statuses": len({"done", "invalid", "fail", "timeout"} & statuses),
        },
        "required": {
            "opcodes": len(expected_opcodes), "legal_types": len(expected_types),
            "conversions": len(expected_conversions), "compares": len(expected_compares),
            "atomics": len(expected_atomics), "shuffles": len(expected_shuffles),
            "votes": len(expected_votes), "loads": len(expected_loads),
            "stores": len(expected_stores), "ldc_types": len(expected_ldc),
            "mbar_scopes": len(expected_mbar), "sfu_modes": len(expected_sfu),
            "special_registers": len(expected_specials), "statuses": 4,
        },
        "missing": missing,
    }
    if args.output:
        output = Path(args.output)
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    return 1 if any(missing.values()) else 0


if __name__ == "__main__":
    raise SystemExit(main())
