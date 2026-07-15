"""Bit-pattern helpers for the AEC scalar data types.

The interpreter keeps registers as u32 words.  This module is deliberately
standard-library-only and centralises all narrowing and FP special-value
rules, so instruction handlers cannot accidentally leak host representations.
"""
from __future__ import annotations

import decimal
import math
import struct

from . import aec_isa as I

U32 = 0xFFFF_FFFF
CANON_NAN = {I.TYPE_F16: 0x7E00, I.TYPE_BF16: 0x7FC0,
             I.TYPE_F32: 0x7FC00000, I.TYPE_F64: 0x7FF8000000000000}


def u32(value: int) -> int:
    return value & U32


def s32(value: int) -> int:
    value &= U32
    return value if value < 0x80000000 else value - (1 << 32)


def pair_get(regs: list[int], base: int) -> int:
    return regs[base] | (regs[base + 1] << 32)


def pair_put(regs: list[int], base: int, value: int) -> None:
    regs[base] = value & U32
    regs[base + 1] = (value >> 32) & U32


def _f32_from_bits(bits: int) -> float:
    return struct.unpack('<f', struct.pack('<I', bits & U32))[0]


def _f32_bits(value: float) -> int:
    try: return struct.unpack('<I', struct.pack('<f', value))[0]
    except OverflowError: return 0x7f800000 if value > 0 else 0xff800000


def _f64_from_bits(bits: int) -> float:
    return struct.unpack('<d', struct.pack('<Q', bits & ((1 << 64) - 1)))[0]


def _f64_bits(value: float) -> int:
    return struct.unpack('<Q', struct.pack('<d', value))[0]


def _f16_from_bits(bits: int) -> float:
    return struct.unpack('<e', struct.pack('<H', bits & 0xffff))[0]


def _f16_bits(value: float) -> int:
    try: return struct.unpack('<H', struct.pack('<e', value))[0]
    except OverflowError: return 0x7c00 if value > 0 else 0xfc00


def bf16_to_float(bits: int) -> float:
    return _f32_from_bits((bits & 0xffff) << 16)


def float_to_bf16(value: float) -> int:
    """RNE f32-to-bf16, including canonicalisation done by callers."""
    word = _f32_bits(value)
    # Addition implements ties-to-even in the retained low bit.
    return ((word + 0x7fff + ((word >> 16) & 1)) >> 16) & 0xffff


def fp_read(regs: list[int], base: int, dtype: int) -> float:
    if dtype == I.TYPE_F16:
        return _f16_from_bits(regs[base])
    if dtype == I.TYPE_BF16:
        return bf16_to_float(regs[base])
    if dtype == I.TYPE_F32:
        return _f32_from_bits(regs[base])
    if dtype == I.TYPE_F64:
        return _f64_from_bits(pair_get(regs, base))
    raise ValueError(f'not FP type: {dtype}')


def fp_pack(value: float, dtype: int) -> int:
    if math.isnan(value):
        return CANON_NAN[dtype]
    if dtype == I.TYPE_F16:
        return _f16_bits(value)
    if dtype == I.TYPE_BF16:
        return float_to_bf16(value)
    if dtype == I.TYPE_F32:
        return _f32_bits(value)
    if dtype == I.TYPE_F64:
        return _f64_bits(value)
    raise ValueError(f'not FP type: {dtype}')


def fp_unpack(bits: int, dtype: int) -> float:
    if dtype == I.TYPE_F16: return _f16_from_bits(bits)
    if dtype == I.TYPE_BF16: return bf16_to_float(bits)
    if dtype == I.TYPE_F32: return _f32_from_bits(bits)
    if dtype == I.TYPE_F64: return _f64_from_bits(bits)
    raise ValueError(f'not FP type: {dtype}')


def fp_write(regs: list[int], base: int, dtype: int, value: float) -> None:
    bits = fp_pack(value, dtype)
    if dtype == I.TYPE_F64:
        pair_put(regs, base, bits)
    else:
        regs[base] = bits


def fp_binary(a: float, b: float, op: str, dtype: int) -> float:
    if math.isnan(a) or math.isnan(b):
        return fp_unpack(fp_pack(float('nan'), dtype), dtype)
    if op == 'add': result = a + b
    elif op == 'sub': result = a - b
    elif op == 'mul': result = a * b
    elif op == 'div': result = a / b
    else: raise ValueError(op)
    return fp_unpack(fp_pack(result, dtype), dtype)


def fp_fma(a: float, b: float, c: float, dtype: int) -> float:
    """One-rounding FMA using exact Decimal inputs and generous precision."""
    if any(math.isnan(x) for x in (a, b, c)):
        return fp_unpack(fp_pack(float('nan'), dtype), dtype)
    if any(math.isinf(x) for x in (a, b, c)):
        return fp_unpack(fp_pack(a * b + c, dtype), dtype)
    with decimal.localcontext() as ctx:
        ctx.prec = 800
        result = decimal.Decimal.from_float(a) * decimal.Decimal.from_float(b) + decimal.Decimal.from_float(c)
        try:
            rounded = float(result)
        except OverflowError:
            rounded = math.copysign(math.inf, float(result.copy_sign(decimal.Decimal(1))))
    return fp_unpack(fp_pack(rounded, dtype), dtype)


def fp_compare(a: float, b: float, subop: int) -> bool:
    if math.isnan(a) or math.isnan(b):
        return subop == I.CMP_NE
    return (a == b, a != b, a < b, a <= b, a > b, a >= b)[subop]


def fp_minmax(a: float, b: float, want_max: bool) -> float:
    if math.isnan(a): return b if not math.isnan(b) else float('nan')
    if math.isnan(b): return a
    if a == b == 0.0:
        return 0.0 if want_max else -0.0
    return max(a, b) if want_max else min(a, b)


def narrow_int(value: int, dtype: int) -> int:
    if dtype == I.TYPE_U8: return value & 0xff
    if dtype == I.TYPE_S8:
        value &= 0xff
        return value if value < 0x80 else value | 0xffffff00
    return u32(value)


def int_read(word: int, dtype: int) -> int:
    if dtype == I.TYPE_U8: return word & 0xff
    if dtype == I.TYPE_S8:
        value = word & 0xff
        return value if value < 0x80 else value - 0x100
    return s32(word) if dtype == I.TYPE_S32 else u32(word)
