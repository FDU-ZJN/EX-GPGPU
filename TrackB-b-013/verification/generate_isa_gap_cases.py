#!/usr/bin/env python3
"""Generate end-to-end CModel/RTL cases for ISA gaps in the public suite.

The expected images below are deliberately computed from simple architectural
rules instead of by invoking the CModel.  The realtime differential runner then
checks every RTL retirement against the CModel in addition to checking these
independent final images.
"""
from __future__ import annotations

import struct
from pathlib import Path

from cmodel.core import aec_isa as I


ROOT = Path(__file__).resolve().parents[1]
CASES = ROOT / "Track-B" / "testcases" / "tests" / "aec_cases" / "extended"
ISA_CASE_LIST = ROOT / "Track-B" / "testcases" / "ISA_CASES.txt"


def u32_words(values: list[int]) -> bytes:
    return b"".join(struct.pack("<I", value & 0xFFFF_FFFF) for value in values)


def emit_case(
    name: str,
    case_id: str,
    assembly: list[str],
    program: list[int],
    expected: bytes | None,
    *,
    grid: tuple[int, int, int] = (1, 1, 1),
    block: int | tuple[int, int, int] = 32,
    init: bytes | None = None,
    memory_images: dict[str, bytes] | None = None,
    status: str = "done",
    max_cycles: int = 20_000,
) -> None:
    directory = CASES / name
    directory.mkdir(parents=True, exist_ok=True)
    images = dict(memory_images or {})
    if init is not None:
        images["gmem"] = init
    if images:
        (directory / "input").mkdir(exist_ok=True)
        for target, payload in images.items():
            (directory / "input" / f"{target}_00000000.bin").write_bytes(payload)
    if expected is not None:
        (directory / "expected").mkdir(exist_ok=True)
        (directory / "expected" / "gmem_00000000.bin").write_bytes(expected)

    (directory / "program.aec").write_text("\n".join(assembly) + "\n")
    I.write_binary(str(directory / "program.bin"), program)
    (directory / "program.hex").write_text(
        "\n".join(I.instr_to_hex(instruction) for instruction in program) + "\n"
    )
    memory_init = ["memory_init: []"]
    if images:
        memory_init = ["memory_init:"]
        for target in sorted(images):
            memory_init += [
                f"  - target: {target}",
                "    address: 0x00000000",
                f"    file: input/{target}_00000000.bin",
            ]
    block_xyz = (block, 1, 1) if isinstance(block, int) else block
    expected_lines = ["expected:", f"  status: {status}"]
    if expected is not None:
        expected_lines += [
            "  memory:",
            "    - address: 0x00000000",
            f"      size: {len(expected)}",
            "      file: expected/gmem_00000000.bin",
            "  comparison: exact",
        ]
    manifest = f"""case_id: {case_id}
category: extended_isa_gap
program: program.bin
launch:
  grid: [{grid[0]}, {grid[1]}, {grid[2]}]
  block: [{block_xyz[0]}, {block_xyz[1]}, {block_xyz[2]}]
  program_instructions: {len(program)}
{chr(10).join(memory_init)}
{chr(10).join(expected_lines)}
max_cycles: {max_cycles}
"""
    (directory / "case.yaml").write_text(manifest)


def scalar_output_setup(
    assembly: list[str], program: list[int], *, base: int = 0x100
) -> None:
    assembly += [f"LOADI R50, 0x{base:x}", "LOADI R51, 4"]
    program += [I.make_loadi(50, base), I.make_loadi(51, 4)]


def scalar_output(
    assembly: list[str], program: list[int], register: int, words: list[int]
) -> None:
    for index in range(len(words)):
        assembly.append(f"ST.gmem.u32 [R50], R{register + index}")
        program.append(I.make_st(I.TYPE_U32, I.SPACE_GMEM, 50, register + index))
        assembly.append("ADD.u32 R50, R50, R51")
        program.append(I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 50, 50, 51))


def typed_words(dtype: int, value: float | int) -> list[int]:
    if dtype in (I.TYPE_U32, I.TYPE_B32):
        return [int(value) & 0xFFFF_FFFF]
    if dtype == I.TYPE_S32:
        return [int(value) & 0xFFFF_FFFF]
    if dtype == I.TYPE_U8:
        return [int(value) & 0xFF]
    if dtype == I.TYPE_S8:
        byte = int(value) & 0xFF
        return [byte | (0xFFFF_FF00 if byte & 0x80 else 0)]
    if dtype == I.TYPE_F16:
        return [struct.unpack("<H", struct.pack("<e", float(value)))[0]]
    if dtype == I.TYPE_BF16:
        f32 = struct.unpack("<I", struct.pack("<f", float(value)))[0]
        return [(f32 >> 16) & 0xFFFF]
    if dtype == I.TYPE_F32:
        return [struct.unpack("<I", struct.pack("<f", float(value)))[0]]
    if dtype in (I.TYPE_F64, I.TYPE_B64):
        bits = struct.unpack("<Q", struct.pack("<d", float(value)))[0]
        return [bits & 0xFFFF_FFFF, bits >> 32]
    raise ValueError(f"unsupported test dtype {dtype}")


def load_typed(
    assembly: list[str], program: list[int], register: int, dtype: int, value: float | int
) -> None:
    words = typed_words(dtype, value)
    if len(words) == 2:
        immediate = words[0] | (words[1] << 32)
        assembly.append(f"LOADI64 R{register}, 0x{immediate:016x}")
        program.append(I.make_loadi64(register, immediate))
    else:
        assembly.append(f"LOADI R{register}, 0x{words[0]:08x}")
        program.append(I.make_loadi(register, words[0]))


def append_lane_record_stores(
    assembly: list[str], program: list[int], registers: list[int], *, base: int, stride: int
) -> None:
    """Append address setup and one 32-bit store per record field."""
    assembly += [
        f"LOADI R40, {stride}",
        "MUL.u32 R41, R1, R40",
        f"LOADI R42, 0x{base:x}",
        "ADD.u32 R43, R42, R41",
        "LOADI R44, 4",
    ]
    program += [
        I.make_loadi(40, stride),
        I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 41, 1, 40),
        I.make_loadi(42, base),
        I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 43, 42, 41),
        I.make_loadi(44, 4),
    ]
    for index, register in enumerate(registers):
        assembly.append(f"ST.gmem.u32 [R43], R{register}")
        program.append(I.make_st(I.TYPE_U32, I.SPACE_GMEM, 43, register))
        if index + 1 != len(registers):
            assembly.append("ADD.u32 R43, R43, R44")
            program.append(I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 43, 43, 44))


def fp_special_arithmetic() -> None:
    assembly = [
        "# Canonical NaN, signed zero, subnormal, compare, and FP-to-int edges.",
        "CPY.u32 R1, %laneid",
        "LOADI R10, 0x7fc12345",
        "LOADI R11, 0x3f800000",
        "LOADI R12, 0x7f800000",
        "LOADI R13, 0x80000000",
        "LOADI R14, 0x00000000",
        "LOADI R15, 0x00000001",
        "ADD.f32 R20, R10, R11",
        "MUL.f32 R21, R12, R14",
        "MIN.f32 R22, R10, R11",
        "MAX.f32 R23, R13, R14",
        "ADD.f32 R24, R15, R15",
        "CMP.f32.ne R25, R10, R11",
        "CVTFI.s32.f32 R26, R10",
        "CVTFI.s32.f32 R27, R12",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID),
        I.make_loadi(10, 0x7FC1_2345),
        I.make_loadi(11, 0x3F80_0000),
        I.make_loadi(12, 0x7F80_0000),
        I.make_loadi(13, 0x8000_0000),
        I.make_loadi(14, 0),
        I.make_loadi(15, 1),
        I.make_alu_3reg(I.OP_ADD, I.TYPE_F32, 20, 10, 11),
        I.make_alu_3reg(I.OP_MUL, I.TYPE_F32, 21, 12, 14),
        I.make_alu_3reg(I.OP_MIN, I.TYPE_F32, 22, 10, 11),
        I.make_alu_3reg(I.OP_MAX, I.TYPE_F32, 23, 13, 14),
        I.make_alu_3reg(I.OP_ADD, I.TYPE_F32, 24, 15, 15),
        I.make_cmp(I.TYPE_F32, I.CMP_NE, 25, 10, 11),
        I.make_cvt(I.OP_CVTFI, I.TYPE_S32, I.TYPE_F32, 26, 10),
        I.make_cvt(I.OP_CVTFI, I.TYPE_S32, I.TYPE_F32, 27, 12),
    ]
    record = [0x7FC0_0000, 0x7FC0_0000, 0x3F80_0000, 0, 2, 1, 0, 0x7FFF_FFFF]
    append_lane_record_stores(assembly, program, list(range(20, 28)), base=0x100, stride=32)
    assembly.append("HALT")
    program.append(I.make_halt())
    expected = bytearray(0x500)
    for lane in range(32):
        expected[0x100 + lane * 32 : 0x100 + (lane + 1) * 32] = u32_words(record)
    emit_case("fp_special_arithmetic", "EXT.FP.SPECIAL.ARITH", assembly, program, bytes(expected))


def sfu_special_values() -> None:
    assembly = [
        "# SFU special-value rules are exact even though normal results use ULP bounds.",
        "CPY.u32 R1, %laneid",
        "LOADI R10, 0x00000000",
        "LOADI R11, 0x80000000",
        "LOADI R12, 0xbf800000",
        "LOADI R13, 0x7f800000",
        "LOADI R14, 0xff800000",
        "RCP.full.f32 R20, R10",
        "RCP.full.f32 R21, R11",
        "RSQ.full.f32 R22, R12",
        "SQRT.full.f32 R23, R11",
        "SQRT.full.f32 R24, R12",
        "SIN.f32 R25, R13",
        "LOG.f32 R26, R10",
        "EXP.f32 R27, R14",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID),
        I.make_loadi(10, 0), I.make_loadi(11, 0x8000_0000),
        I.make_loadi(12, 0xBF80_0000), I.make_loadi(13, 0x7F80_0000),
        I.make_loadi(14, 0xFF80_0000),
        I.make_sfu(I.OP_RCP, I.SFU_FULL, 20, 10),
        I.make_sfu(I.OP_RCP, I.SFU_FULL, 21, 11),
        I.make_sfu(I.OP_RSQ, I.SFU_FULL, 22, 12),
        I.make_sfu(I.OP_SQRT, I.SFU_FULL, 23, 11),
        I.make_sfu(I.OP_SQRT, I.SFU_FULL, 24, 12),
        I.make_sfu(I.OP_SIN, 0, 25, 13),
        I.make_sfu(I.OP_LOG, 0, 26, 10),
        I.make_sfu(I.OP_EXP, 0, 27, 14),
    ]
    record = [0x7F80_0000, 0xFF80_0000, 0x7FC0_0000, 0x8000_0000,
              0x7FC0_0000, 0x7FC0_0000, 0xFF80_0000, 0]
    append_lane_record_stores(assembly, program, list(range(20, 28)), base=0x100, stride=32)
    assembly.append("HALT")
    program.append(I.make_halt())
    expected = bytearray(0x500)
    for lane in range(32):
        expected[0x100 + lane * 32 : 0x100 + (lane + 1) * 32] = u32_words(record)
    emit_case("sfu_special_values", "EXT.SFU.SPECIAL", assembly, program, bytes(expected), max_cycles=80_000)


def atomic_contention() -> None:
    assembly = [
        "# All lanes contend on one GMEM word and one SMEM word.",
        "CPY.u32 R1, %laneid",
        "LOADI R2, 0",
        "LOADI R3, 1",
        "ATOM.gmem.add.u32 R10, [R2], R3",
        "ATOM.smem.add.u32 R11, [R2], R3",
        "LD.smem.u32 R12, [R2]",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID),
        I.make_loadi(2, 0), I.make_loadi(3, 1),
        I.make_atom(I.ATOM_ADD, I.TYPE_U32, I.SPACE_GMEM, 10, 2, 3),
        I.make_atom(I.ATOM_ADD, I.TYPE_U32, I.SPACE_SMEM, 11, 2, 3),
        I.make_ld(I.TYPE_U32, I.SPACE_SMEM, 12, 2),
    ]
    append_lane_record_stores(assembly, program, [10, 11, 12], base=0x100, stride=12)
    assembly.append("HALT")
    program.append(I.make_halt())
    expected = bytearray(0x300)
    expected[0:4] = struct.pack("<I", 32)
    for lane in range(32):
        expected[0x100 + lane * 12 : 0x100 + (lane + 1) * 12] = u32_words([lane, lane, 32])
    emit_case("atomic_contention", "EXT.ATOM.CONTENTION", assembly, program, bytes(expected), max_cycles=80_000)


def memory_predication_and_alignment() -> None:
    assembly = [
        "# Predicate-false invalid addresses must not fault; normal LD may be misaligned.",
        "CPY.u32 R1, %laneid",
        "LOADI R2, 16",
        "CMPP.lt.u32 P1, R1, R2",
        "LOADI R3, 4",
        "MUL.u32 R4, R1, R3",
        "LOADI R5, 0xfffffffc",
        "@P1 CPY.u32 R5, R4",
        "LOADI R10, 0xdeadbeef",
        "@P1 LD.gmem.u32 R10, [R5]",
        "LOADI R6, 3",
        "MUL.u32 R7, R1, R6",
        "LOADI R8, 1",
        "ADD.u32 R7, R7, R8",
        "LD.gmem.u32 R11, [R7]",
        "ST.lmem.u32 [R2], R1",
        "LD.lmem.u32 R12, [R2]",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID),
        I.make_loadi(2, 16),
        I.make_cmpp(I.TYPE_U32, I.CMP_LT, 1, 1, 2),
        I.make_loadi(3, 4),
        I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 4, 1, 3),
        I.make_loadi(5, 0xFFFF_FFFC),
        I.make_cpy(I.TYPE_U32, 5, 4, pred_idx=1, pred_en=1),
        I.make_loadi(10, 0xDEAD_BEEF),
        I.make_ld(I.TYPE_U32, I.SPACE_GMEM, 10, 5, pred_idx=1, pred_en=1),
        I.make_loadi(6, 3),
        I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 7, 1, 6),
        I.make_loadi(8, 1),
        I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 7, 7, 8),
        I.make_ld(I.TYPE_U32, I.SPACE_GMEM, 11, 7),
        I.make_st(I.TYPE_U32, I.SPACE_LMEM, 2, 1),
        I.make_ld(I.TYPE_U32, I.SPACE_LMEM, 12, 2),
    ]
    append_lane_record_stores(assembly, program, [10, 11, 12], base=0x100, stride=12)
    assembly.append("HALT")
    program.append(I.make_halt())
    init = bytes(range(128))
    expected = bytearray(0x300)
    expected[:128] = init
    for lane in range(32):
        pred = int.from_bytes(init[lane * 4 : lane * 4 + 4], "little") if lane < 16 else 0xDEAD_BEEF
        address = lane * 3 + 1
        misaligned = int.from_bytes(init[address : address + 4], "little")
        expected[0x100 + lane * 12 : 0x100 + (lane + 1) * 12] = u32_words([pred, misaligned, lane])
    emit_case("memory_predication_alignment", "EXT.MEM.PRED.ALIGN", assembly, program,
              bytes(expected), init=init, max_cycles=80_000)


def collective_partial_warp() -> None:
    participants = (1 << 20) - 1
    assembly = [
        "# Partial-warp SHUF boundary fallback, VOTE, and MTCH equivalence masks.",
        "CPY.u32 R1, %laneid",
        "LOADI R2, 1",
        "AND.u32 R3, R1, R2",
        "LOADI R4, 0",
        "CMPP.eq.u32 P1, R3, R4",
        f"SHUF.up.u32 R10, R1, 1, 0x{participants:08x}",
        f"SHUF.down.u32 R11, R1, 1, 0x{participants:08x}",
        f"SHUF.bfly.u32 R12, R1, 1, 0x{participants:08x}",
        "VOTE.all R13, P1",
        "VOTE.any R14, P1",
        "VOTE.uni R15, P1",
        "MTCH.any R16, R3",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID),
        I.make_loadi(2, 1),
        I.make_alu_3reg(I.OP_AND, I.TYPE_U32, 3, 1, 2),
        I.make_loadi(4, 0),
        I.make_cmpp(I.TYPE_U32, I.CMP_EQ, 1, 3, 4),
        I.make_shuf(I.SHUF_UP, I.TYPE_U32, 10, 1, 1, participants),
        I.make_shuf(I.SHUF_DOWN, I.TYPE_U32, 11, 1, 1, participants),
        I.make_shuf(I.SHUF_BFLY, I.TYPE_U32, 12, 1, 1, participants),
        I.make_vote(I.VOTE_ALL, False, 13, 1),
        I.make_vote(I.VOTE_ANY, False, 14, 1),
        I.make_vote(I.VOTE_UNI, False, 15, 1),
        I.make_mtch(16, 3),
    ]
    append_lane_record_stores(assembly, program, list(range(10, 17)), base=0x100, stride=28)
    assembly.append("HALT")
    program.append(I.make_halt())
    expected = bytearray(0x400)
    even_mask = sum(1 << lane for lane in range(0, 20, 2))
    odd_mask = sum(1 << lane for lane in range(1, 20, 2))
    for lane in range(20):
        record = [lane - 1 if lane else lane,
                  lane + 1 if lane < 19 else lane,
                  lane ^ 1,
                  0, 1, 0,
                  even_mask if lane % 2 == 0 else odd_mask]
        expected[0x100 + lane * 28 : 0x100 + (lane + 1) * 28] = u32_words(record)
    emit_case("collective_partial_warp", "EXT.COLLECTIVE.PARTIAL", assembly, program,
              bytes(expected), block=20, max_cycles=40_000)


def missing_opcodes() -> None:
    """Exercise every opcode that is absent from the public and original gap cases."""
    assembly: list[str] = ["# Every formerly absent opcode, with independent exact results."]
    program: list[int] = []
    scalar_output_setup(assembly, program)
    load_typed(assembly, program, 10, I.TYPE_U32, 7)
    load_typed(assembly, program, 11, I.TYPE_U32, 3)
    load_typed(assembly, program, 12, I.TYPE_S32, -5)
    load_typed(assembly, program, 13, I.TYPE_B32, 0x0F0F00FF)
    load_typed(assembly, program, 14, I.TYPE_B32, 0x3333FF00)
    load_typed(assembly, program, 15, I.TYPE_B32, 0xFFFF0000)
    load_typed(assembly, program, 16, I.TYPE_B32, 0x5A)
    instructions = [
        ("SUB.u32 R20, R10, R11", I.make_alu_3reg(I.OP_SUB, I.TYPE_U32, 20, 10, 11), [4]),
        ("NEG.s32 R20, R12", I.make_alu_2reg(I.OP_NEG, I.TYPE_S32, 20, 12), [5]),
        ("ABS.s32 R20, R12", I.make_alu_2reg(I.OP_ABS, I.TYPE_S32, 20, 12), [5]),
        ("OR.b32 R20, R13, R14", I.make_alu_3reg(I.OP_OR, I.TYPE_B32, 20, 13, 14), [0x3F3F_FFFF]),
        ("XOR.b32 R20, R13, R14", I.make_alu_3reg(I.OP_XOR, I.TYPE_B32, 20, 13, 14), [0x3C3C_FFFF]),
        ("NOT.b32 R20, R13", I.make_alu_2reg(I.OP_NOT, I.TYPE_B32, 20, 13), [0xF0F0_FF00]),
        ("BINS.b32 R20, R15, R16, 8, 8", I.make_bins(I.TYPE_B32, 20, 15, 16, 8, 8), [0xFFFF_5A00]),
        ("FLO.b32 R20, R0", I.make_alu_2reg(I.OP_FLO, I.TYPE_B32, 20, 0), [0xFFFF_FFFF]),
    ]
    expected_words: list[int] = []
    for text, instruction, words in instructions:
        assembly.append(text); program.append(instruction)
        scalar_output(assembly, program, 20, words); expected_words += words
    load_typed(assembly, program, 17, I.TYPE_B32, 0x80000001)
    assembly.append("FLO.u32 R20, R17"); program.append(I.make_alu_2reg(I.OP_FLO, I.TYPE_U32, 20, 17))
    scalar_output(assembly, program, 20, [31]); expected_words.append(31)
    assembly.append("PICK.u32 R20, R13, R14"); program.append(I.make_pick(I.TYPE_U32, 20, 13, 14))
    scalar_output(assembly, program, 20, [0x0F0F00FF]); expected_words.append(0x0F0F00FF)
    load_typed(assembly, program, 17, I.TYPE_U32, 0xF0000001)
    assembly.append("PICK.s32 R20, R17, R14"); program.append(I.make_pick(I.TYPE_S32, 20, 17, 14))
    scalar_output(assembly, program, 20, [0x3333FF00]); expected_words.append(0x3333FF00)
    target = len(program) + 2
    assembly += ["BR br_taken", "LOADI R20, 0xdeadbeef", "br_taken: LOADI R20, 0x12345678"]
    program += [I.make_br(target), I.make_loadi(20, 0xDEADBEEF), I.make_loadi(20, 0x12345678)]
    scalar_output(assembly, program, 20, [0x12345678]); expected_words.append(0x12345678)
    load_typed(assembly, program, 17, I.TYPE_U32, 0x80)
    assembly.append("CVTII.s8.u32 R20, R17")
    program.append(I.make_cvt(I.OP_CVTII, I.TYPE_S8, I.TYPE_U32, 20, 17))
    scalar_output(assembly, program, 20, [0xFFFFFF80]); expected_words.append(0xFFFFFF80)
    load_typed(assembly, program, 17, I.TYPE_F32, 0.0)
    assembly.append("COS.f32 R20, R17"); program.append(I.make_sfu(I.OP_COS, 0, 20, 17))
    scalar_output(assembly, program, 20, typed_words(I.TYPE_F32, 1.0)); expected_words += typed_words(I.TYPE_F32, 1.0)
    assembly.append("HALT"); program.append(I.make_halt())
    emit_case("opcode_completion", "EXT.ISA.OPCODE.COMPLETION", assembly, program,
              bytes(0x100) + u32_words(expected_words), block=1, max_cycles=80_000)


def arithmetic_type_matrix() -> None:
    assembly: list[str] = ["# Every legal arithmetic opcode/type combination using exact values."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program)

    def emit_result(text: str, instruction: int, dtype: int, value: float | int) -> None:
        words = typed_words(dtype, value)
        assembly.append(text); program.append(instruction)
        scalar_output(assembly, program, 20, words); expected_words.extend(words)

    binary = [(I.OP_ADD, "ADD", 8), (I.OP_SUB, "SUB", 4), (I.OP_MUL, "MUL", 12)]
    arithmetic_types = [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32, I.TYPE_F16, I.TYPE_BF16, I.TYPE_F64]
    for opcode, name, result in binary:
        for dtype in arithmetic_types:
            load_typed(assembly, program, 10, dtype, 6)
            load_typed(assembly, program, 12, dtype, 2)
            suffix = I.TYPE_NAMES[dtype]
            emit_result(f"{name}{suffix} R20, R10, R12",
                        I.make_alu_3reg(opcode, dtype, 20, 10, 12), dtype, result)
    for dtype in [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]:
        load_typed(assembly, program, 10, dtype, 6); load_typed(assembly, program, 12, dtype, 2)
        load_typed(assembly, program, 14, dtype, 1)
        emit_result(f"MAD{I.TYPE_NAMES[dtype]} R20, R10, R12, R14",
                    I.make_mad(I.OP_MAD, dtype, 20, 10, 12, 14), dtype, 13)
    for dtype in [I.TYPE_F32, I.TYPE_F16, I.TYPE_BF16, I.TYPE_F64]:
        load_typed(assembly, program, 10, dtype, 6); load_typed(assembly, program, 12, dtype, 2)
        load_typed(assembly, program, 14, dtype, 1)
        emit_result(f"FMA{I.TYPE_NAMES[dtype]} R20, R10, R12, R14",
                    I.make_mad(I.OP_FMA, dtype, 20, 10, 12, 14), dtype, 13)
    for dtype in [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32, I.TYPE_F64]:
        load_typed(assembly, program, 10, dtype, 6); load_typed(assembly, program, 12, dtype, 2)
        emit_result(f"DIV{I.TYPE_NAMES[dtype]} R20, R10, R12",
                    I.make_div(I.OP_DIV, dtype, 20, 10, 12), dtype, 3)
    for opcode, name in [(I.OP_NEG, "NEG"), (I.OP_ABS, "ABS")]:
        for dtype in [I.TYPE_S32, I.TYPE_F32, I.TYPE_F16, I.TYPE_BF16, I.TYPE_F64]:
            load_typed(assembly, program, 10, dtype, -6)
            result = 6
            emit_result(f"{name}{I.TYPE_NAMES[dtype]} R20, R10",
                        I.make_alu_2reg(opcode, dtype, 20, 10), dtype, result)
    for opcode, name, result in [(I.OP_MIN, "MIN", 2), (I.OP_MAX, "MAX", 6)]:
        for dtype in [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]:
            load_typed(assembly, program, 10, dtype, 6); load_typed(assembly, program, 12, dtype, 2)
            emit_result(f"{name}{I.TYPE_NAMES[dtype]} R20, R10, R12",
                        I.make_alu_3reg(opcode, dtype, 20, 10, 12), dtype, result)
    assembly.append("HALT"); program.append(I.make_halt())
    emit_case("arithmetic_type_matrix", "EXT.ISA.ARITH.TYPE.MATRIX", assembly, program,
              bytes(0x100) + u32_words(expected_words), block=1, max_cycles=300_000)


def conversion_and_copy_matrix() -> None:
    assembly: list[str] = ["# Complete legal CVT and CPY type matrices for exactly representable value 2."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program)
    fp = [I.TYPE_F16, I.TYPE_BF16, I.TYPE_F32, I.TYPE_F64]
    integer = [I.TYPE_U8, I.TYPE_S8, I.TYPE_U32, I.TYPE_S32]
    matrices = [
        (I.OP_CVTFF, "CVTFF", fp, fp),
        (I.OP_CVTFI, "CVTFI", integer, fp),
        (I.OP_CVTIF, "CVTIF", fp, integer),
        (I.OP_CVTII, "CVTII", integer, integer),
    ]
    for opcode, name, destinations, sources in matrices:
        for source in sources:
            load_typed(assembly, program, 10, source, 2)
            for destination in destinations:
                assembly.append(f"{name}{I.TYPE_NAMES[destination]}{I.TYPE_NAMES[source]} R20, R10")
                program.append(I.make_cvt(opcode, destination, source, 20, 10))
                words = typed_words(destination, 2)
                scalar_output(assembly, program, 20, words); expected_words += words
    copy_types = [I.TYPE_B32, I.TYPE_B64, I.TYPE_U32, I.TYPE_S32, I.TYPE_U8, I.TYPE_S8,
                  I.TYPE_F32, I.TYPE_F64, I.TYPE_F16, I.TYPE_BF16]
    for dtype in copy_types:
        load_typed(assembly, program, 10, dtype, 2)
        assembly.append(f"CPY{I.TYPE_NAMES[dtype]} R20, R10")
        program.append(I.make_cpy(dtype, 20, 10))
        words = typed_words(dtype, 2)
        scalar_output(assembly, program, 20, words); expected_words += words
    assembly.append("HALT"); program.append(I.make_halt())
    emit_case("conversion_copy_matrix", "EXT.ISA.CVT.CPY.MATRIX", assembly, program,
              bytes(0x100) + u32_words(expected_words), block=1, max_cycles=400_000)


def logic_compare_collective_matrix() -> None:
    assembly: list[str] = ["# Legal logic, compare/select, SHUF types, and predicate VOTE destination."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program)

    def emit(text: str, instruction: int, value: int) -> None:
        assembly.append(text); program.append(instruction)
        scalar_output(assembly, program, 20, [value]); expected_words.append(value)

    for dtype in [I.TYPE_B32, I.TYPE_U32]:
        load_typed(assembly, program, 10, dtype, 0x0F0F00FF)
        load_typed(assembly, program, 11, dtype, 0x3333FF00)
        for opcode, name, value in [
            (I.OP_AND, "AND", 0x03030000), (I.OP_OR, "OR", 0x3F3FFFFF),
            (I.OP_XOR, "XOR", 0x3C3CFFFF),
        ]:
            emit(f"{name}{I.TYPE_NAMES[dtype]} R20, R10, R11",
                 I.make_alu_3reg(opcode, dtype, 20, 10, 11), value)
        emit(f"NOT{I.TYPE_NAMES[dtype]} R20, R10",
             I.make_alu_2reg(I.OP_NOT, dtype, 20, 10), 0xF0F0FF00)
        emit(f"BINS{I.TYPE_NAMES[dtype]} R20, R10, R11, 8, 8",
             I.make_bins(dtype, 20, 10, 11, 8, 8), 0x0F0F00FF)
        emit(f"POPC{I.TYPE_NAMES[dtype]} R20, R10",
             I.make_alu_2reg(I.OP_POPC, dtype, 20, 10), 16)
        emit(f"FLO{I.TYPE_NAMES[dtype]} R20, R10",
             I.make_alu_2reg(I.OP_FLO, dtype, 20, 10), 27)
    for dtype in [I.TYPE_U32, I.TYPE_S32]:
        load_typed(assembly, program, 10, dtype, -16 if dtype == I.TYPE_S32 else 0x80000000)
        load_typed(assembly, program, 11, dtype, 4)
        shl = 0xFFFFFF00 if dtype == I.TYPE_S32 else 0
        emit(f"SHL{I.TYPE_NAMES[dtype]} R20, R10, R11",
             I.make_alu_3reg(I.OP_SHL, dtype, 20, 10, 11), shl)
        shift = 0xFFFFFFFF if dtype == I.TYPE_S32 else 0x08000000
        emit(f"SHR{I.TYPE_NAMES[dtype]} R20, R10, R11",
             I.make_alu_3reg(I.OP_SHR, dtype, 20, 10, 11), shift)
        load_typed(assembly, program, 10, dtype, 0x000000F0)
        bfx = 0xFFFFFFFF if dtype == I.TYPE_S32 else 0x0000000F
        emit(f"BFX{I.TYPE_NAMES[dtype]} R20, R10, 4, 4",
             I.make_bfx(dtype, 20, 10, 4, 4), bfx)
    compare_types = [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]
    modes = [(I.CMP_EQ, "eq", 0), (I.CMP_NE, "ne", 1), (I.CMP_LT, "lt", 1),
             (I.CMP_LE, "le", 1), (I.CMP_GT, "gt", 0), (I.CMP_GE, "ge", 0)]
    for dtype in compare_types:
        load_typed(assembly, program, 10, dtype, 1); load_typed(assembly, program, 11, dtype, 2)
        for mode, name, value in modes:
            emit(f"CMP{I.TYPE_NAMES[dtype]}.{name} R20, R10, R11",
                 I.make_cmp(dtype, mode, 20, 10, 11), value)
            assembly += [f"CMPP{I.TYPE_NAMES[dtype]}.{name} P1, R10, R11", "LOADI R20, 0",
                         "@P1 LOADI R20, 1"]
            program += [I.make_cmpp(dtype, mode, 1, 10, 11), I.make_loadi(20, 0),
                        I.make_loadi(20, 1, pred_idx=1, pred_en=1)]
            scalar_output(assembly, program, 20, [value]); expected_words.append(value)
        assembly.append(f"CMPP{I.TYPE_NAMES[dtype]}.lt P1, R10, R11")
        program.append(I.make_cmpp(dtype, I.CMP_LT, 1, 10, 11))
        assembly.append(f"SEL{I.TYPE_NAMES[dtype]} R20, R10, R11, P1")
        program.append(I.make_sel(dtype, 20, 10, 11, 1))
        scalar_output(assembly, program, 20, typed_words(dtype, 1)); expected_words += typed_words(dtype, 1)
        assembly.append(f"PICK{I.TYPE_NAMES[dtype]} R20, R10, R11")
        program.append(I.make_pick(dtype, 20, 10, 11))
        scalar_output(assembly, program, 20, typed_words(dtype, 1)); expected_words += typed_words(dtype, 1)
    for dtype in [I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]:
        load_typed(assembly, program, 10, dtype, 2)
        for mode, mode_name in I.SHUF_MODE_NAMES.items():
            assembly.append(f"SHUF.{mode_name}{I.TYPE_NAMES[dtype]} R20, R10, 0, 1")
            program.append(I.make_shuf(mode, dtype, 20, 10, 0, 1))
            words = typed_words(dtype, 2)
            scalar_output(assembly, program, 20, words); expected_words += words
    load_typed(assembly, program, 10, I.TYPE_U32, 1)
    assembly.append("CMPP.eq.u32 P1, R10, R10")
    program.append(I.make_cmpp(I.TYPE_U32, I.CMP_EQ, 1, 10, 10))
    for mode, mode_name in I.VOTE_MODE_NAMES.items():
        assembly.append(f"VOTE.{mode_name} R20, P1")
        program.append(I.make_vote(mode, False, 20, 1))
        scalar_output(assembly, program, 20, [1]); expected_words.append(1)
        assembly += [f"VOTE.{mode_name} P2, P1", "LOADI R20, 0", "@P2 LOADI R20, 1"]
        program += [I.make_vote(mode, True, 2, 1), I.make_loadi(20, 0),
                    I.make_loadi(20, 1, pred_idx=2, pred_en=1)]
        scalar_output(assembly, program, 20, [1]); expected_words.append(1)
    assembly.append("HALT"); program.append(I.make_halt())
    emit_case("logic_compare_collective_matrix", "EXT.ISA.LOGIC.CMP.COLL.MATRIX",
              assembly, program, bytes(0x100) + u32_words(expected_words), block=1,
              max_cycles=400_000)


def atomic_subop_matrix() -> None:
    assembly = ["# Every legal ATOM type, space, and subop combination."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program, base=0x200)
    init_values: list[int] = []
    gmem = bytearray(0x400)
    gmem_index = 0
    for space, space_name in [(I.SPACE_GMEM, "gmem"), (I.SPACE_SMEM, "smem")]:
        for dtype in [I.TYPE_U32, I.TYPE_S32]:
            for op, name in I.ATOM_NAMES.items():
                initial = -2 if dtype == I.TYPE_S32 and op in (I.ATOM_MIN, I.ATOM_MAX) else 10
                update = (-5 if dtype == I.TYPE_S32 and op == I.ATOM_MIN else 3)
                address = (gmem_index if space == I.SPACE_GMEM else op + 8 * (dtype == I.TYPE_S32)) * 4
                load_typed(assembly, program, 10, I.TYPE_U32, address)
                if space == I.SPACE_GMEM:
                    init_values.append(initial & 0xFFFF_FFFF)
                    struct.pack_into("<I", gmem, address, initial & 0xFFFF_FFFF)
                    gmem_index += 1
                else:
                    load_typed(assembly, program, 13, I.TYPE_U32, initial)
                    assembly.append("ST.smem.u32 [R10], R13")
                    program.append(I.make_st(I.TYPE_U32, I.SPACE_SMEM, 10, 13))
                load_typed(assembly, program, 11, dtype, update)
                if op == I.ATOM_CAS:
                    load_typed(assembly, program, 12, dtype, initial)
                    assembly.append(f"ATOM.{space_name}.{name}{I.TYPE_NAMES[dtype]} R20, [R10], R12, R11")
                    program.append(I.make_atom(op, dtype, space, 20, 10, 11, 12))
                else:
                    assembly.append(f"ATOM.{space_name}.{name}{I.TYPE_NAMES[dtype]} R20, [R10], R11")
                    program.append(I.make_atom(op, dtype, space, 20, 10, 11))
                old = initial & 0xFFFF_FFFF
                scalar_output(assembly, program, 20, [old]); expected_words.append(old)
                if space == I.SPACE_GMEM:
                    if op == I.ATOM_ADD: final = (initial + update) & 0xFFFF_FFFF
                    elif op == I.ATOM_MAX: final = max(initial, update) & 0xFFFF_FFFF
                    elif op == I.ATOM_MIN: final = min(initial, update) & 0xFFFF_FFFF
                    elif op == I.ATOM_XCHG: final = update & 0xFFFF_FFFF
                    elif op == I.ATOM_AND: final = initial & update
                    elif op == I.ATOM_OR: final = initial | update
                    elif op == I.ATOM_XOR: final = initial ^ update
                    else: final = update & 0xFFFF_FFFF
                    struct.pack_into("<I", gmem, address, final)
    assembly.append("HALT"); program.append(I.make_halt())
    for index, value in enumerate(expected_words): struct.pack_into("<I", gmem, 0x200 + index * 4, value)
    initial = u32_words(init_values)
    emit_case("atomic_subop_matrix", "EXT.ISA.ATOM.SUBOP.MATRIX", assembly, program,
              bytes(gmem), block=1, init=initial, max_cycles=200_000)


def memory_type_space_matrix() -> None:
    assembly = ["# All legal load/store types and memory spaces, plus line crossing."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program, base=0x300)
    images = {
        "gmem": bytes(range(256)),
        "cmem": bytes((0x40 + index) & 0xFF for index in range(64)),
        "pmem": bytes((0x80 + index) & 0xFF for index in range(64)),
    }

    def emit_load(text: str, instruction: int, words: list[int]) -> None:
        assembly.append(text); program.append(instruction)
        scalar_output(assembly, program, 20, words); expected_words.extend(words)

    load_types = [I.TYPE_B32, I.TYPE_B64, I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]
    for space, space_name, payload in [
        (I.SPACE_GMEM, "gmem", images["gmem"]),
        (I.SPACE_CMEM, "cmem", images["cmem"]),
        (I.SPACE_PMEM, "pmem", images["pmem"]),
    ]:
        load_typed(assembly, program, 10, I.TYPE_U32, 0)
        for dtype in load_types:
            width = 8 if dtype == I.TYPE_B64 else 4
            words = list(struct.unpack("<" + "I" * (width // 4), payload[:width]))
            emit_load(f"LD.{space_name}{I.TYPE_NAMES[dtype]} R20, [R10]",
                      I.make_ld(dtype, space, 20, 10), words)
    for dtype in [I.TYPE_B32, I.TYPE_U32, I.TYPE_F32]:
        words = [struct.unpack_from("<I", images["cmem"], 0)[0]]
        emit_load(f"LDC.cmem{I.TYPE_NAMES[dtype]} R20, [R10]",
                  I.make_ldc(dtype, 20, 10), words)
    for space, name in [(I.SPACE_SMEM, "smem"), (I.SPACE_LMEM, "lmem")]:
        for index, dtype in enumerate([I.TYPE_B32, I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]):
            value = 0x10203040 + index
            load_typed(assembly, program, 10, I.TYPE_U32, index * 4)
            load_typed(assembly, program, 11, I.TYPE_U32, value)
            assembly += [f"ST.{name}{I.TYPE_NAMES[dtype]} [R10], R11",
                         f"LD.{name}{I.TYPE_NAMES[dtype]} R20, [R10]"]
            program += [I.make_st(dtype, space, 10, 11), I.make_ld(dtype, space, 20, 10)]
            scalar_output(assembly, program, 20, [value]); expected_words.append(value)
        load_typed(assembly, program, 10, I.TYPE_U32, 0x40)
        load_typed(assembly, program, 11, I.TYPE_U32, 0x11223344)
        load_typed(assembly, program, 12, I.TYPE_U32, 0x55667788)
        assembly += [f"ST.{name}.u32 [R10], R11", "LOADI R13, 4", "ADD.u32 R14, R10, R13",
                     f"ST.{name}.u32 [R14], R12", f"LD.{name}.b64 R20, [R10]"]
        program += [I.make_st(I.TYPE_U32, space, 10, 11), I.make_loadi(13, 4),
                    I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 14, 10, 13),
                    I.make_st(I.TYPE_U32, space, 14, 12), I.make_ld(I.TYPE_B64, space, 20, 10)]
        scalar_output(assembly, program, 20, [0x11223344, 0x55667788])
        expected_words += [0x11223344, 0x55667788]
    gmem_writes: list[tuple[int, int]] = []
    for index, dtype in enumerate([I.TYPE_B32, I.TYPE_U32, I.TYPE_S32, I.TYPE_F32]):
        address = 0x120 + index * 4; value = 0x89ABC000 + index
        load_typed(assembly, program, 10, I.TYPE_U32, address)
        load_typed(assembly, program, 11, I.TYPE_U32, value)
        assembly += [f"ST.gmem{I.TYPE_NAMES[dtype]} [R10], R11",
                     f"LD.gmem{I.TYPE_NAMES[dtype]} R20, [R10]"]
        program += [I.make_st(dtype, I.SPACE_GMEM, 10, 11), I.make_ld(dtype, I.SPACE_GMEM, 20, 10)]
        scalar_output(assembly, program, 20, [value]); expected_words.append(value)
        gmem_writes.append((address, value))
    load_typed(assembly, program, 10, I.TYPE_U32, 127)
    cross = [int.from_bytes(images["gmem"][127:131], "little")]
    emit_load("LD.gmem.u32 R20, [R10]", I.make_ld(I.TYPE_U32, I.SPACE_GMEM, 20, 10), cross)
    load_typed(assembly, program, 10, I.TYPE_U32, 125)
    load_typed(assembly, program, 11, I.TYPE_U32, 0xA1B2C3D4)
    assembly += ["ST.gmem.u32 [R10], R11", "LD.gmem.u32 R20, [R10]"]
    program += [I.make_st(I.TYPE_U32, I.SPACE_GMEM, 10, 11),
                I.make_ld(I.TYPE_U32, I.SPACE_GMEM, 20, 10)]
    scalar_output(assembly, program, 20, [0xA1B2C3D4]); expected_words.append(0xA1B2C3D4)
    assembly.append("HALT"); program.append(I.make_halt())
    expected = bytearray(0x500); expected[:256] = images["gmem"]
    expected[125:129] = struct.pack("<I", 0xA1B2C3D4)
    for address, value in gmem_writes:
        expected[address:address + 4] = struct.pack("<I", value)
    expected[0x300:0x300 + 4 * len(expected_words)] = u32_words(expected_words)
    emit_case("memory_type_space_matrix", "EXT.ISA.MEM.TYPE.SPACE.MATRIX", assembly,
              program, bytes(expected), block=1, memory_images=images, max_cycles=30_000)


def special_register_dimensions() -> None:
    assembly = ["# All x/y/z special registers over nontrivial grid and block dimensions."]
    program: list[int] = []
    selectors = [
        I.SPREG_TID_X, I.SPREG_NTID_X, I.SPREG_CTAID_X, I.SPREG_NCTAID_X,
        I.SPREG_LANEID, I.SPREG_TID_Y, I.SPREG_NTID_Y, I.SPREG_CTAID_Y,
        I.SPREG_NCTAID_Y, I.SPREG_TID_Z, I.SPREG_NTID_Z, I.SPREG_CTAID_Z,
        I.SPREG_NCTAID_Z,
    ]
    for index, selector in enumerate(selectors):
        assembly.append(f"CPY.u32 R{10 + index}, {I.SPREG_NAMES[selector]}")
        program.append(I.make_cpy(I.TYPE_U32, 10 + index, selector))
    # thread_linear = tid.x + 2 * (tid.y + 2 * tid.z)
    assembly += ["MUL.u32 R30, R16, R19", "ADD.u32 R30, R15, R30",
                 "MUL.u32 R30, R11, R30", "ADD.u32 R30, R10, R30"]
    program += [I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 30, 16, 19),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 30, 15, 30),
                I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 30, 11, 30),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 30, 10, 30)]
    # cta_linear = ctaid.x + 2 * (ctaid.y + 2 * ctaid.z)
    assembly += ["MUL.u32 R31, R18, R21", "ADD.u32 R31, R17, R31",
                 "MUL.u32 R31, R13, R31", "ADD.u32 R31, R12, R31",
                 "LOADI R32, 8", "MUL.u32 R31, R31, R32", "ADD.u32 R31, R31, R30",
                 "LOADI R33, 52", "MUL.u32 R31, R31, R33", "LOADI R34, 0x100",
                 "ADD.u32 R31, R31, R34", "LOADI R35, 4"]
    program += [I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 31, 18, 21),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 17, 31),
                I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 31, 13, 31),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 12, 31), I.make_loadi(32, 8),
                I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 31, 31, 32),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 31, 30), I.make_loadi(33, 52),
                I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 31, 31, 33), I.make_loadi(34, 0x100),
                I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 31, 34), I.make_loadi(35, 4)]
    for index in range(len(selectors)):
        assembly.append(f"ST.gmem.u32 [R31], R{10 + index}")
        program.append(I.make_st(I.TYPE_U32, I.SPACE_GMEM, 31, 10 + index))
        if index + 1 != len(selectors):
            assembly.append("ADD.u32 R31, R31, R35")
            program.append(I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 31, 35))
    assembly.append("HALT"); program.append(I.make_halt())
    expected = bytearray(0xE00)
    for cz in range(2):
        for cy in range(2):
            for cx in range(2):
                cta = cx + 2 * (cy + 2 * cz)
                for tz in range(2):
                    for ty in range(2):
                        for tx in range(2):
                            thread = tx + 2 * (ty + 2 * tz)
                            record = [tx, 2, cx, 2, thread, ty, 2, cy, 2, tz, 2, cz, 2]
                            start = 0x100 + (cta * 8 + thread) * 52
                            expected[start:start + 52] = u32_words(record)
    emit_case("special_register_dimensions", "EXT.ISA.SPECIAL.XYZ", assembly, program,
              bytes(expected), grid=(2, 2, 2), block=(2, 2, 2), max_cycles=30_000)


def system_mbar_rdtsc() -> None:
    assembly = [
        "# MBAR scopes plus same-warp RDTSC uniformity and monotonicity.",
        "CPY.u32 R1, %laneid", "RDTSC R10", "MBAR.ct", "MBAR.sys", "RDTSC R11",
        "CMP.le.u32 R20, R10, R11", "MTCH.any R21, R10", "LOADI R30, 8",
        "MUL.u32 R31, R1, R30", "LOADI R32, 0x100", "ADD.u32 R31, R31, R32",
        "ST.gmem.u32 [R31], R20", "LOADI R33, 4", "ADD.u32 R31, R31, R33",
        "ST.gmem.u32 [R31], R21", "HALT",
    ]
    program = [
        I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID), I.make_rdtsc(10),
        I.make_mbar(I.MBAR_CT), I.make_mbar(I.MBAR_SYS), I.make_rdtsc(11),
        I.make_cmp(I.TYPE_U32, I.CMP_LE, 20, 10, 11), I.make_mtch(21, 10),
        I.make_loadi(30, 8), I.make_alu_3reg(I.OP_MUL, I.TYPE_U32, 31, 1, 30),
        I.make_loadi(32, 0x100), I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 31, 32),
        I.make_st(I.TYPE_U32, I.SPACE_GMEM, 31, 20), I.make_loadi(33, 4),
        I.make_alu_3reg(I.OP_ADD, I.TYPE_U32, 31, 31, 33),
        I.make_st(I.TYPE_U32, I.SPACE_GMEM, 31, 21), I.make_halt(),
    ]
    expected = bytearray(0x200)
    for lane in range(32):
        expected[0x100 + lane * 8:0x108 + lane * 8] = u32_words([1, 0xFFFF_FFFF])
    emit_case("system_mbar_rdtsc", "EXT.ISA.SYSTEM.MBAR.RDTSC", assembly, program,
              bytes(expected), block=32, max_cycles=80_000)


def sfu_mode_matrix() -> None:
    assembly = ["# Every legal SFU precision mode with exact special/simple values."]
    program: list[int] = []
    expected_words: list[int] = []
    scalar_output_setup(assembly, program)

    def emit(opcode: int, name: str, mode: int, source: float, result: float) -> None:
        load_typed(assembly, program, 10, I.TYPE_F32, source)
        mode_name = ".approx" if mode == I.SFU_APPROX else ".full"
        if opcode in (I.OP_SIN, I.OP_COS, I.OP_EXP, I.OP_LOG): mode_name = ""
        assembly.append(f"{name}{mode_name}.f32 R20, R10")
        program.append(I.make_sfu(opcode, mode, 20, 10))
        words = typed_words(I.TYPE_F32, result)
        scalar_output(assembly, program, 20, words); expected_words.extend(words)

    for mode in [I.SFU_APPROX, I.SFU_FULL]:
        emit(I.OP_RCP, "RCP", mode, 0.0, float("inf"))
        emit(I.OP_RSQ, "RSQ", mode, 0.0, float("inf"))
        emit(I.OP_SQRT, "SQRT", mode, -0.0, -0.0)
    emit(I.OP_SIN, "SIN", 0, 0.0, 0.0)
    emit(I.OP_COS, "COS", 0, 0.0, 1.0)
    emit(I.OP_EXP, "EXP", 0, 0.0, 1.0)
    emit(I.OP_LOG, "LOG", 0, 1.0, 0.0)
    assembly.append("HALT"); program.append(I.make_halt())
    emit_case("sfu_mode_matrix", "EXT.ISA.SFU.MODE.MATRIX", assembly, program,
              bytes(0x100) + u32_words(expected_words), block=1, max_cycles=100_000)


def status_and_error_cases() -> None:
    cases: list[tuple[str, str, list[str], list[int], str, int, int]] = []
    cases.append(("invalid_unknown_opcode", "EXT.ISA.INVALID.OPCODE", [".word unknown opcode"],
                  [I.encode_instr(0xFFFF)], "invalid", 1, 1000))
    reserved = I.encode_instr(I.OP_ADD, I.build_pred_ctrl(dtype=I.TYPE_U32) | 0x80,
                              dest=1, src1=1, src2_imm32=1)
    cases.append(("invalid_reserved_bit", "EXT.ISA.INVALID.RESERVED", ["ADD.u32 with bit7=1"],
                  [reserved], "invalid", 1, 1000))
    guarded_shuf = I.encode_instr(I.OP_SHUF,
        I.build_pred_ctrl(dtype=I.TYPE_U32, subop=I.SHUF_IDX, pred_en=1), dest=1,
        src1=1, src2_imm32=0, imm_ext=1)
    cases.append(("invalid_guarded_collective", "EXT.ISA.INVALID.GUARDED.COLLECTIVE",
                  ["@P0 SHUF.idx.u32 R1, R1, 0, 1"], [guarded_shuf], "invalid", 1, 1000))
    cases.append(("invalid_store_cmem", "EXT.ISA.INVALID.STORE.CMEM",
                  ["ST.cmem.u32 [R0], R0"], [I.make_st(I.TYPE_U32, I.SPACE_CMEM, 0, 0)],
                  "invalid", 1, 1000))
    cases.append(("fail_divide_zero", "EXT.ISA.FAIL.DIV.ZERO",
                  ["LOADI R1, 1", "LOADI R2, 0", "DIV.u32 R3, R1, R2"],
                  [I.make_loadi(1, 1), I.make_loadi(2, 0), I.make_div(I.OP_DIV, I.TYPE_U32, 3, 1, 2)],
                  "fail", 1, 1000))
    cases.append(("fail_bfx_range", "EXT.ISA.FAIL.BFX.RANGE",
                  ["LOADI R1, 1", "BFX.u32 R2, R1, 31, 2"],
                  [I.make_loadi(1, 1), I.make_bfx(I.TYPE_U32, 2, 1, 31, 2)], "fail", 1, 1000))
    cases.append(("fail_atomic_misaligned", "EXT.ISA.FAIL.ATOM.ALIGN",
                  ["LOADI R1, 1", "ATOM.gmem.add.u32 R2, [R1], R0"],
                  [I.make_loadi(1, 1), I.make_atom(I.ATOM_ADD, I.TYPE_U32, I.SPACE_GMEM, 2, 1, 0)],
                  "fail", 1, 1000))
    mixed = [I.make_cpy(I.TYPE_U32, 1, I.SPREG_LANEID), I.make_loadi(2, 16),
             I.make_cmpp(I.TYPE_U32, I.CMP_LT, 1, 1, 2), I.make_brx(1, 5),
             I.make_halt(), I.make_halt()]
    cases.append(("fail_brx_nonuniform", "EXT.ISA.FAIL.BRX.NONUNIFORM",
                  ["CPY R1,%laneid", "LOADI R2,16", "CMPP.lt P1,R1,R2", "BRX P1,target",
                   "HALT", "target: HALT"], mixed, "fail", 32, 2000))
    cases.append(("fail_ret_underflow", "EXT.ISA.FAIL.RET.UNDERFLOW", ["RET"],
                  [I.make_ret()], "fail", 1, 1000))
    cases.append(("fail_call_overflow", "EXT.ISA.FAIL.CALL.OVERFLOW", ["loop: CALL loop"],
                  [I.make_call(0)], "fail", 1, 2000))
    deadlock = [I.make_cpy(I.TYPE_U32, 1, I.SPREG_TID_X), I.make_loadi(2, 32),
                I.make_cmpp(I.TYPE_U32, I.CMP_LT, 1, 1, 2), I.make_brx(1, 5),
                I.make_halt(), I.make_sync_ct(), I.make_halt()]
    cases.append(("timeout_barrier_deadlock", "EXT.ISA.TIMEOUT.BARRIER",
                  ["# Warp 0 waits at SYNC.CT while warp 1 completes.", "CPY R1,%tid", "LOADI R2,32",
                   "CMPP.lt P1,R1,R2", "BRX P1,barrier", "HALT", "barrier: SYNC.CT", "HALT"],
                  deadlock, "timeout", 64, 200))
    for name, case_id, assembly, program, status, block, max_cycles in cases:
        emit_case(name, case_id, assembly, program, None, status=status, block=block,
                  max_cycles=max_cycles)


def main() -> None:
    fp_special_arithmetic()
    sfu_special_values()
    atomic_contention()
    memory_predication_and_alignment()
    collective_partial_warp()
    missing_opcodes()
    arithmetic_type_matrix()
    conversion_and_copy_matrix()
    logic_compare_collective_matrix()
    atomic_subop_matrix()
    memory_type_space_matrix()
    special_register_dimensions()
    system_mbar_rdtsc()
    sfu_mode_matrix()
    status_and_error_cases()
    test_root = ROOT / "Track-B" / "testcases"
    public_paths = [line.strip() for line in (test_root / "PUBLIC_CASES.txt").read_text().splitlines()
                    if line.strip() and not line.lstrip().startswith("#")]
    extended_paths = [path.parent.relative_to(test_root).as_posix()
                      for path in CASES.glob("*/case.yaml")]
    case_paths = public_paths + sorted(set(extended_paths) - set(public_paths))
    ISA_CASE_LIST.write_text("\n".join(case_paths) + "\n")
    print(f"generated {len(extended_paths)} extended ISA cases under {CASES}")
    print(f"ISA suite contains {len(case_paths)} public + extended cases")
    print(f"wrote ISA suite list to {ISA_CASE_LIST}")


if __name__ == "__main__":
    main()
