#!/usr/bin/env python3
"""Generate deterministic DIV/SFU vectors from Python integer and libm semantics."""
from __future__ import annotations

import argparse
import math
import random
import struct
from pathlib import Path

OP_DIV = 0x0006
OP_RCP, OP_RSQ, OP_SIN, OP_COS = 0x0070, 0x0071, 0x0072, 0x0073
OP_EXP, OP_LOG, OP_SQRT = 0x0074, 0x0075, 0x0076
U32, S32, F32, F64 = 2, 3, 8, 9

def f32_bits(value: float) -> int:
    return struct.unpack('<I', struct.pack('<f', value))[0]

def f64_bits(value: float) -> int:
    return struct.unpack('<Q', struct.pack('<d', value))[0]

def trunc_div(a: int, b: int) -> int:
    return abs(a) // abs(b) * (-1 if (a < 0) != (b < 0) else 1)

def emit(out, op: int, dtype: int, mode: int, a: int, b: int,
         expected: int, error: bool, ulps: int) -> None:
    out.write(f'{op:04x} {dtype:x} {mode:x} {a:016x} {b:016x} '
              f'{expected:016x} {int(error)} {ulps}\n')

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('--count', type=int, default=100)
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    rng = random.Random(args.seed)
    with args.output.open('w', encoding='ascii') as out:
        out.write(f'# AEC SFU golden seed={args.seed} count={args.count}\n')
        directed_int = [(31, 3), (0xffffffff, 2), (0x80000000, 0xffffffff), (7, 0)]
        for dtype in (U32, S32):
            for a, b in directed_int:
                error = b == 0
                if error: expected = 0
                elif dtype == U32: expected = a // b
                else:
                    sa = a if a < 0x80000000 else a - 0x100000000
                    sb = b if b < 0x80000000 else b - 0x100000000
                    expected = trunc_div(sa, sb) & 0xffffffff
                emit(out, OP_DIV, dtype, 0, a, b, expected, error, 0)
            for _ in range(args.count):
                a, b = rng.getrandbits(32), rng.getrandbits(32) or 1
                if dtype == U32: expected = a // b
                else:
                    sa = a if a < 0x80000000 else a - 0x100000000
                    sb = b if b < 0x80000000 else b - 0x100000000
                    expected = trunc_div(sa, sb) & 0xffffffff
                emit(out, OP_DIV, dtype, 0, a, b, expected, False, 0)

        for dtype in (F32, F64):
            if dtype == F32:
                directed_fp = [(0x00000000, 0x00000000, 0x7fc00000),
                               (0x7f800000, 0x7f800000, 0x7fc00000),
                               (0x3f800000, 0x00000000, 0x7f800000),
                               (0x80000000, 0x3f800000, 0x80000000),
                               (0x7fc12345, 0x3f800000, 0x7fc00000),
                               (0x00000001, 0x40000000, 0x00000000),
                               (0x00800000, 0x40000000, 0x00400000),
                               (0x3f800000, 0x40400000, 0x3eaaaaab)]
            else:
                directed_fp = [(0x0000000000000000, 0x0000000000000000, 0x7ff8000000000000),
                               (0x7ff0000000000000, 0x7ff0000000000000, 0x7ff8000000000000),
                               (0x3ff0000000000000, 0x0000000000000000, 0x7ff0000000000000),
                               (0x8000000000000000, 0x3ff0000000000000, 0x8000000000000000),
                               (0x7ff8123456789abc, 0x3ff0000000000000, 0x7ff8000000000000),
                               (0x0000000000000001, 0x4000000000000000, 0x0000000000000000),
                               (0x0010000000000000, 0x4000000000000000, 0x0008000000000000),
                               (0x3ff0000000000000, 0x4008000000000000, 0x3fd5555555555555)]
            for ab, bb, expected in directed_fp:
                emit(out, OP_DIV, dtype, 0, ab, bb, expected, False, 0)
            for _ in range(args.count):
                a = rng.uniform(-1.0e4, 1.0e4)
                b = rng.uniform(0.125, 1.0e4) * (-1 if rng.randrange(2) else 1)
                if dtype == F32:
                    ab, bb = f32_bits(a), f32_bits(b)
                    value = struct.unpack('<f', struct.pack('<I', ab))[0] / struct.unpack('<f', struct.pack('<I', bb))[0]
                    expected = f32_bits(value)
                else:
                    ab, bb, expected = f64_bits(a), f64_bits(b), f64_bits(a / b)
                emit(out, OP_DIV, dtype, 0, ab, bb, expected, False, 0)

        unary = (OP_RCP, OP_RSQ, OP_SIN, OP_COS, OP_EXP, OP_LOG, OP_SQRT)
        for op in unary:
            directed = {
                OP_RCP: ((0x00000000,0x7f800000),(0x80000000,0xff800000),(0x7f800000,0x00000000),(0xff800000,0x80000000),(0x7fc12345,0x7fc00000)),
                OP_RSQ: ((0x00000000,0x7f800000),(0x80000000,0xff800000),(0x7f800000,0x00000000),(0xbf800000,0x7fc00000),(0x7fc12345,0x7fc00000)),
                OP_SQRT: ((0x00000000,0x00000000),(0x80000000,0x80000000),(0x7f800000,0x7f800000),(0xbf800000,0x7fc00000),(0x7fc12345,0x7fc00000)),
                OP_SIN: ((0x00000000,0x00000000),(0x80000000,0x80000000),(0x7f800000,0x7fc00000),(0x7fc12345,0x7fc00000)),
                OP_COS: ((0x00000000,0x3f800000),(0x80000000,0x3f800000),(0x7f800000,0x7fc00000),(0x7fc12345,0x7fc00000)),
                OP_EXP: ((0x7f800000,0x7f800000),(0xff800000,0x00000000),(0x7fc12345,0x7fc00000)),
                OP_LOG: ((0x00000000,0xff800000),(0x80000000,0xff800000),(0x7f800000,0x7f800000),(0xbf800000,0x7fc00000),(0x7fc12345,0x7fc00000)),
            }[op]
            for xb, expected in directed:
                emit(out, op, F32, 1 if op in (OP_RCP, OP_RSQ, OP_SQRT) else 0,
                     xb, 0, expected, False, 0)
            for _ in range(args.count):
                if op in (OP_RSQ, OP_LOG, OP_SQRT): x = rng.uniform(0.01, 64.0)
                elif op == OP_EXP: x = rng.uniform(-10.0, 10.0)
                elif op in (OP_SIN, OP_COS): x = rng.uniform(-100.0, 100.0)
                else: x = rng.uniform(-64.0, 64.0) or 1.0
                xb = f32_bits(x)
                xf = struct.unpack('<f', struct.pack('<I', xb))[0]
                value = {OP_RCP: lambda: 1.0 / xf, OP_RSQ: lambda: 1.0 / math.sqrt(xf),
                         OP_SIN: lambda: math.sin(xf), OP_COS: lambda: math.cos(xf),
                         OP_EXP: lambda: 2.0 ** xf, OP_LOG: lambda: math.log2(xf),
                         OP_SQRT: lambda: math.sqrt(xf)}[op]()
                emit(out, op, F32, 1 if op in (OP_RCP, OP_RSQ, OP_SQRT) else 0,
                     xb, 0, f32_bits(value), False, 4)

if __name__ == '__main__':
    main()
