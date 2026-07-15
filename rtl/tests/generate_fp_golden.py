#!/usr/bin/env python3
"""Generate randomized bit-exact AEC FP vectors from the Python CModel."""
from __future__ import annotations

import argparse
import random
from pathlib import Path

from cmodel.core import aec_isa as I
from cmodel.core import values as V

# This stream is for AecFpUnit only.  DIV/SQRT belong to AESSFU and are kept
# out of this golden file until that unit has its own differential harness.
OPS = (I.OP_ADD, I.OP_SUB, I.OP_MUL, I.OP_FMA,
       I.OP_CMP, I.OP_CMPP, I.OP_NEG, I.OP_ABS)
DTYPES = (I.TYPE_F16, I.TYPE_BF16, I.TYPE_F32, I.TYPE_F64)

# Compare vectors deliberately include the cases that tend to expose a
# relation-encoding or NaN handling mistake.  They are emitted in addition to
# the requested random count, once for each relation and compare operation.
DIRECTED_COMPARE_VALUES = {
    I.TYPE_F16:  (0x0000, 0x8000, 0x3c00, 0xbc00, 0x7e00),
    I.TYPE_BF16: (0x0000, 0x8000, 0x3f80, 0xbf80, 0x7fc0),
    I.TYPE_F32:  (0x00000000, 0x80000000, 0x3f800000, 0xbf800000, 0x7fc00000),
    I.TYPE_F64:  (0x0000000000000000, 0x8000000000000000,
                  0x3ff0000000000000, 0xbff0000000000000,
                  0x7ff8000000000000),
}

def finite_bits(dtype: int, rng: random.Random, positive: bool = False) -> int:
    sign = 0 if positive else rng.randrange(2)
    if dtype == I.TYPE_F16:
        return (sign << 15) | (rng.randrange(1, 31) << 10) | rng.randrange(1 << 10)
    if dtype == I.TYPE_BF16:
        return (sign << 15) | (rng.randrange(1, 255) << 7) | rng.randrange(1 << 7)
    if dtype == I.TYPE_F32:
        return (sign << 31) | (rng.randrange(1, 255) << 23) | rng.randrange(1 << 23)
    return (sign << 63) | (rng.randrange(1, 2047) << 52) | rng.randrange(1 << 52)

def write_row(out, op: int, dtype: int, mode: int, a: int, b: int, c: int, result: int, pred: bool) -> None:
    out.write(f"{op:04x} {dtype:x} {mode:x} {a:016x} {b:016x} {c:016x} {result:016x} {int(pred):x}\n")

def golden(op: int, dtype: int, mode: int, a_bits: int, b_bits: int, c_bits: int) -> tuple[int, bool]:
    a, b, c = (V.fp_unpack(a_bits, dtype), V.fp_unpack(b_bits, dtype), V.fp_unpack(c_bits, dtype))
    if op == I.OP_ADD: return V.fp_pack(V.fp_binary(a, b, 'add', dtype), dtype), False
    if op == I.OP_SUB: return V.fp_pack(V.fp_binary(a, b, 'sub', dtype), dtype), False
    if op == I.OP_MUL: return V.fp_pack(V.fp_binary(a, b, 'mul', dtype), dtype), False
    if op == I.OP_FMA: return V.fp_pack(V.fp_fma(a, b, c, dtype), dtype), False
    if op == I.OP_NEG or op == I.OP_ABS:
        sign = 1 << ({I.TYPE_F16: 15, I.TYPE_BF16: 15,
                      I.TYPE_F32: 31, I.TYPE_F64: 63}[dtype])
        return (a_bits ^ sign) if op == I.OP_NEG else (a_bits & ~sign), False
    pred = V.fp_compare(a, b, mode)
    return int(pred), pred

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('--count', type=int, default=200, help='vectors per enabled operation')
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.count < 1: parser.error('--count must be positive')
    rng = random.Random(args.seed)
    with args.output.open('w', encoding='ascii') as out:
        out.write(f'# AEC CModel golden vectors; seed={args.seed}; count={args.count}\n')
        for op in OPS:
            for dtype in DTYPES:
                # BF16 FMA is deliberately excluded: this unit widens it
                # through f32, while the current datapath has no BF16 FMA
                # retirement contract.
                if op == I.OP_FMA and dtype == I.TYPE_BF16: continue
                if op in (I.OP_CMP, I.OP_CMPP):
                    values = DIRECTED_COMPARE_VALUES[dtype]
                    for mode in range(6):
                        a, b = values[mode % len(values)], values[(mode + 1) % len(values)]
                        result, pred = golden(op, dtype, mode, a, b, 0)
                        write_row(out, op, dtype, mode, a, b, 0, result,
                                  pred if op == I.OP_CMPP else False)
                for _ in range(args.count):
                    a = finite_bits(dtype, rng)
                    b = finite_bits(dtype, rng)
                    c = finite_bits(dtype, rng)
                    mode = rng.randrange(6) if op in (I.OP_CMP, I.OP_CMPP) else 0
                    result, pred = golden(op, dtype, mode, a, b, c)
                    write_row(out, op, dtype, mode, a, b, c, result, pred if op == I.OP_CMPP else False)

if __name__ == '__main__': main()
