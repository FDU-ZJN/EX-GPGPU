"""
AEC 128-bit ISA Instruction Encodings

Full instruction set architecture definition for the AEC GPGPU processor.
128-bit fixed-length instructions with standardized field layout.

Field Layout (128-bit):
  [127:112] Opcode      (16-bit major opcode)
  [111:96]  Pred/Ctrl   (16-bit: predicate, type, subop, space/scope)
  [95:80]   Dest        (16-bit: destination GPR or predicate)
  [79:64]   Src1        (16-bit: source GPR, address GPR, or special selector)
  [63:32]   Src2/Imm32  (32-bit: source GPR, packed fields, or immediate)
  [31:0]    ImmExt      (32-bit: branch target, third source, mask, or immediate)

Binary file format (little-endian):
  w0 = bits[31:0], w1 = bits[63:32], w2 = bits[95:64], w3 = bits[127:96]
  Each word is stored as little-endian u32.
  Hex representation is MSB-first: w3,w2,w1,w0.

Based on AEC Precise ISA Specification v1.0.
Type codes verified against public testcase binaries (assembler encoding).
"""

# ===========================================================================
# 128-bit Instruction Field Layout
# ===========================================================================
# Bit ranges for each field within the 128-bit instruction word.
FIELD_OPCODE     = slice(127, 111)   # [127:112] 16-bit opcode
FIELD_PRED_CTRL  = slice(111,  95)   # [111:96]  16-bit Pred/Ctrl
FIELD_DEST       = slice( 95,  79)   # [95:80]   16-bit destination
FIELD_SRC1       = slice( 79,  63)   # [79:64]   16-bit source 1
FIELD_SRC2_IMM32 = slice( 63,  31)   # [63:32]   32-bit source 2 / immediate
FIELD_IMMEXT     = slice( 31,  -1)   # [31:0]    32-bit extension immediate


# ===========================================================================
# Pred/Ctrl sub-fields [111:96]
# ===========================================================================
PRED_CTRL_PRED_IDX  = slice( 2, -1)   # [2:0]   instruction predicate index
PRED_CTRL_TYPE      = slice( 6,  2)    # [6:3]   data type (4-bit)
# bit 7 reserved, must be 0
PRED_CTRL_SUBOP     = slice(10,  7)    # [10:8]  instruction-family subop (3-bit)
PRED_CTRL_EXT       = slice(13, 10)    # [13:11] memory space / scope / ext (3-bit)
PRED_CTRL_PRED_NEG  = 14              # [14]    predicate negate
PRED_CTRL_PRED_EN   = 15              # [15]    predicate enable


# ===========================================================================
# Major Opcodes [127:112]
# ===========================================================================
# Arithmetic
OP_ADD  = 0x0001
OP_SUB  = 0x0002
OP_MUL  = 0x0003
OP_MAD  = 0x0004
OP_FMA  = 0x0005
OP_DIV  = 0x0006
OP_NEG  = 0x0007
OP_ABS  = 0x0008
OP_MIN  = 0x0009
OP_MAX  = 0x000A

# Logic / Bitwise
OP_AND  = 0x0010
OP_OR   = 0x0011
OP_XOR  = 0x0012
OP_NOT  = 0x0013
OP_SHL  = 0x0014
OP_SHR  = 0x0015
OP_BFX  = 0x0016
OP_BINS = 0x0017
OP_POPC = 0x0018
OP_FLO  = 0x0019

# Comparison / Predicate / Select
OP_CMP   = 0x0020
OP_CMPP  = 0x0021
OP_SEL   = 0x0022
OP_PICK  = 0x0023

# Memory
OP_LD   = 0x0030
OP_ST   = 0x0031
OP_LDC  = 0x0032
OP_ATOM = 0x0033

# Control
OP_BR      = 0x0040
OP_BRX     = 0x0041
OP_CALL    = 0x0043
OP_RET     = 0x0044
OP_HALT    = 0x0045
OP_SYNC_CT = 0x0047
OP_MBAR    = 0x0049

# Conversion
OP_CVTFF = 0x0050
OP_CVTFI = 0x0051
OP_CVTIF = 0x0052
OP_CVTII = 0x0053
OP_CPY   = 0x0054

# Move / Immediate
OP_LOADI   = 0x0055
OP_LOADI64 = 0x0056

# Warp Primitives
OP_SHUF = 0x0057
OP_VOTE = 0x0058
OP_MTCH = 0x0059

# SFU (Special Function Unit)
OP_RCP  = 0x0070
OP_RSQ  = 0x0071
OP_SIN  = 0x0072
OP_COS  = 0x0073
OP_EXP  = 0x0074
OP_LOG  = 0x0075
OP_SQRT = 0x0076

# System
OP_RDTSC = 0x0080


# ===========================================================================
# Data Types [6:3] in Pred/Ctrl
# ===========================================================================
# These codes match both the ISA specification (Section 4) and the
# public testcase binaries. The type field occupies bits [6:3] of the
# Pred/Ctrl word; the extracted value is (pred_ctrl >> 3) & 0xF.
TYPE_B32  = 0x0   # 32-bit bit pattern (untyped)
TYPE_B64  = 0x1   # 64-bit bit pattern (register pair)
TYPE_U32  = 0x2   # 32-bit unsigned integer
TYPE_S32  = 0x3   # two's-complement signed integer
TYPE_U8   = 0x4   # unsigned 8-bit (in low bits, zero-extended)
TYPE_S8   = 0x5   # signed 8-bit (in low bits, sign-extended)
# 0x6..0x7 reserved (illegal)
TYPE_F32  = 0x8   # IEEE 754 binary32
TYPE_F64  = 0x9   # IEEE 754 binary64 (register pair)
TYPE_F16  = 0xA   # IEEE 754 binary16
TYPE_BF16 = 0xB   # bfloat16
# 0xC..0xE reserved (illegal)
TYPE_NONE = 0xF   # untyped / control / system

# Legal type matrix per opcode family
LEGAL_TYPES = {
    OP_ADD:  [TYPE_U32, TYPE_S32, TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_SUB:  [TYPE_U32, TYPE_S32, TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_MUL:  [TYPE_U32, TYPE_S32, TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_MAD:  [TYPE_U32, TYPE_S32, TYPE_F32],
    OP_FMA:  [TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_DIV:  [TYPE_U32, TYPE_S32, TYPE_F32, TYPE_F64],
    OP_NEG:  [TYPE_S32, TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_ABS:  [TYPE_S32, TYPE_F32, TYPE_F16, TYPE_BF16, TYPE_F64],
    OP_MIN:  [TYPE_U32, TYPE_S32, TYPE_F32],
    OP_MAX:  [TYPE_U32, TYPE_S32, TYPE_F32],

    OP_AND:  [TYPE_B32, TYPE_U32],
    OP_OR:   [TYPE_B32, TYPE_U32],
    OP_XOR:  [TYPE_B32, TYPE_U32],
    OP_NOT:  [TYPE_B32, TYPE_U32],
    OP_SHL:  [TYPE_U32, TYPE_S32],
    OP_SHR:  [TYPE_U32, TYPE_S32],
    OP_BFX:  [TYPE_U32, TYPE_S32],
    OP_BINS: [TYPE_B32, TYPE_U32],
    OP_POPC: [TYPE_B32, TYPE_U32],
    OP_FLO:  [TYPE_B32, TYPE_U32],

    OP_CMP:  [TYPE_U32, TYPE_S32, TYPE_F32],
    OP_CMPP: [TYPE_U32, TYPE_S32, TYPE_F32],
    OP_SEL:  [TYPE_U32, TYPE_S32, TYPE_F32],
    OP_PICK: [TYPE_U32, TYPE_S32, TYPE_F32],

    OP_LD:   [TYPE_B32, TYPE_B64, TYPE_U32, TYPE_S32, TYPE_F32],
    OP_ST:   [TYPE_B32, TYPE_U32, TYPE_S32, TYPE_F32],
    OP_LDC:  [TYPE_B32, TYPE_U32, TYPE_F32],
    OP_ATOM: [TYPE_U32, TYPE_S32],

    OP_SHUF: [TYPE_U32, TYPE_S32, TYPE_F32],
}

# Type name string mapping
TYPE_NAMES = {
    TYPE_B32:  ".b32",
    TYPE_B64:  ".b64",
    TYPE_U32:  ".u32",
    TYPE_S32:  ".s32",
    TYPE_U8:   ".u8",
    TYPE_S8:   ".s8",
    TYPE_F32:  ".f32",
    TYPE_F64:  ".f64",
    TYPE_F16:  ".f16",
    TYPE_BF16: ".bf16",
    TYPE_NONE: ".none",
}


# ===========================================================================
# Memory Spaces [13:11] in Pred/Ctrl
# ===========================================================================
SPACE_GMEM = 0  # Global memory (grid-scope, read/write)
SPACE_SMEM = 1  # Shared memory (CTA-scope, read/write)
SPACE_CMEM = 2  # Constant memory (grid-scope, read-only)
SPACE_LMEM = 3  # Local memory (thread-scope, read/write)
SPACE_PMEM = 4  # Parameter memory (kernel-scope, read-only)

SPACE_NAMES = {
    SPACE_GMEM: ".gmem",
    SPACE_SMEM: ".smem",
    SPACE_CMEM: ".cmem",
    SPACE_LMEM: ".lmem",
    SPACE_PMEM: ".pmem",
}


# ===========================================================================
# Compare Subop [10:8] — CMP / CMPP
# ===========================================================================
CMP_EQ = 0  # equal
CMP_NE = 1  # not equal
CMP_LT = 2  # less than
CMP_LE = 3  # less than or equal
CMP_GT = 4  # greater than
CMP_GE = 5  # greater than or equal

CMP_NAMES = {
    CMP_EQ: "eq",
    CMP_NE: "ne",
    CMP_LT: "lt",
    CMP_LE: "le",
    CMP_GT: "gt",
    CMP_GE: "ge",
}


# ===========================================================================
# Atomic Subop [10:8] — ATOM
# ===========================================================================
ATOM_ADD  = 0  # atomic add (modulo 2^32)
ATOM_MAX  = 1  # atomic maximum
ATOM_MIN  = 2  # atomic minimum
ATOM_XCHG = 3  # atomic exchange
ATOM_AND  = 4  # atomic bitwise AND
ATOM_OR   = 5  # atomic bitwise OR
ATOM_XOR  = 6  # atomic bitwise XOR
ATOM_CAS  = 7  # atomic compare-and-swap

ATOM_NAMES = {
    ATOM_ADD:  "add",
    ATOM_MAX:  "max",
    ATOM_MIN:  "min",
    ATOM_XCHG: "xchg",
    ATOM_AND:  "and",
    ATOM_OR:   "or",
    ATOM_XOR:  "xor",
    ATOM_CAS:  "cas",
}


# ===========================================================================
# SHUF Mode [10:8] — SHUF
# ===========================================================================
SHUF_IDX  = 0  # src_lane = val
SHUF_UP   = 1  # src_lane = lane_id - val
SHUF_DOWN = 2  # src_lane = lane_id + val
SHUF_BFLY = 3  # src_lane = lane_id XOR val

SHUF_MODE_NAMES = {
    SHUF_IDX:  "idx",
    SHUF_UP:   "up",
    SHUF_DOWN: "down",
    SHUF_BFLY: "bfly",
}


# ===========================================================================
# VOTE Mode [10:8] and Dest Kind [11] — VOTE
# ===========================================================================
VOTE_ALL = 0  # all participants have true predicate
VOTE_ANY = 1  # at least one participant has true predicate
VOTE_UNI = 2  # all participants have same predicate value

VOTE_DEST_GPR = 0  # write result to GPR (0 or 1)
VOTE_DEST_PRED = 1  # write result to predicate (false or true)

VOTE_MODE_NAMES = {
    VOTE_ALL: "all",
    VOTE_ANY: "any",
    VOTE_UNI: "uni",
}


# ===========================================================================
# MBAR Scope [13:11] — MBAR
# ===========================================================================
MBAR_CT  = 0  # CTA-scope memory barrier
MBAR_SYS = 2  # System-scope memory barrier (GMEM)


# ===========================================================================
# SFU Precision Mode [10:8] — RCP / RSQ / SQRT
# ===========================================================================
SFU_APPROX = 0  # relative error <= 2^-12
SFU_FULL   = 1  # <= 4 ULP


# ===========================================================================
# Special Register Selectors (Src1 field, or 0x0100+ encoding)
# ===========================================================================
SPREG_TID_X    = 0x0100   # %tid.x / %tid
SPREG_NTID_X   = 0x0101   # %ntid.x / %ntid (blockDim.x)
SPREG_CTAID_X  = 0x0102   # %ctaid.x / %ctaid
SPREG_NCTAID_X = 0x0103   # %nctaid.x / %nctaid (gridDim.x)
SPREG_LANEID   = 0x0104   # %laneid

# Y-dimension
SPREG_TID_Y    = 0x0110
SPREG_NTID_Y   = 0x0111
SPREG_CTAID_Y  = 0x0112
SPREG_NCTAID_Y = 0x0113

# Z-dimension
SPREG_TID_Z    = 0x0120
SPREG_NTID_Z   = 0x0121
SPREG_CTAID_Z  = 0x0122
SPREG_NCTAID_Z = 0x0123

SPREG_NAMES = {
    SPREG_TID_X:    "%tid.x",
    SPREG_NTID_X:   "%ntid.x",
    SPREG_CTAID_X:  "%ctaid.x",
    SPREG_NCTAID_X: "%nctaid.x",
    SPREG_LANEID:   "%laneid",
    SPREG_TID_Y:    "%tid.y",
    SPREG_NTID_Y:   "%ntid.y",
    SPREG_CTAID_Y:  "%ctaid.y",
    SPREG_NCTAID_Y: "%nctaid.y",
    SPREG_TID_Z:    "%tid.z",
    SPREG_NTID_Z:   "%ntid.z",
    SPREG_CTAID_Z:  "%ctaid.z",
    SPREG_NCTAID_Z: "%nctaid.z",
}


# ===========================================================================
# Predicate / Guard helpers
# ===========================================================================

def execute_lane(active_lane: bool, pred_en: int, pred_val: bool,
                 pred_neg: int) -> bool:
    """Determine whether a lane executes the current instruction.

    execute_lane = active_lane && (!pred_en || (P[pred] XOR pred_neg))
    """
    if not active_lane:
        return False
    if not pred_en:
        return True
    return pred_val ^ bool(pred_neg)


# ===========================================================================
# Instruction Encode / Decode
# ===========================================================================

def encode_instr(
    opcode: int,
    pred_ctrl: int = 0,
    dest: int = 0,
    src1: int = 0,
    src2_imm32: int = 0,
    imm_ext: int = 0,
) -> int:
    """Encode a 128-bit AEC instruction from its logical fields.

    Args:
        opcode:      16-bit opcode [127:112].
        pred_ctrl:   16-bit Pred/Ctrl word [111:96] — use build_pred_ctrl().
        dest:        Destination GPR (low 8 bits used) or predicate index.
        src1:        Source-1 GPR (low 8 bits used) or special selector.
        src2_imm32:  Source-2 GPR, packed fields, or 32-bit immediate.
        imm_ext:     32-bit extension (branch target, third source, mask, etc.).

    Returns:
        128-bit encoded instruction as a Python int.
    """
    return (
        ((opcode      & 0xFFFF) << 112)
        | ((pred_ctrl  & 0xFFFF) << 96)
        | ((dest       & 0xFFFF) << 80)
        | ((src1       & 0xFFFF) << 64)
        | ((src2_imm32 & 0xFFFFFFFF) << 32)
        | (imm_ext     & 0xFFFFFFFF)
    )


def decode_instr(instr: int) -> dict:
    """Decode a 128-bit AEC instruction into its logical fields.

    Returns a dictionary with keys:
        opcode, pred_ctrl, dest, src1, src2_imm32, imm_ext
    """
    return {
        "opcode":      (instr >> 112) & 0xFFFF,
        "pred_ctrl":   (instr >> 96)  & 0xFFFF,
        "dest":        (instr >> 80)  & 0xFFFF,
        "src1":        (instr >> 64)  & 0xFFFF,
        "src2_imm32":  (instr >> 32)  & 0xFFFFFFFF,
        "imm_ext":     instr          & 0xFFFFFFFF,
    }


def build_pred_ctrl(
    pred_idx: int = 0,
    dtype: int = TYPE_NONE,
    subop: int = 0,
    ext: int = 0,
    pred_en: int = 0,
    pred_neg: int = 0,
) -> int:
    """Build the 16-bit Pred/Ctrl word [111:96].

    Args:
        pred_idx: Predicate index [2:0] — source predicate for guard or select.
        dtype:    Data type [6:3] — see TYPE_* constants.
        subop:    Instruction-family sub-operation [10:8].
        ext:      Memory space, scope, or family extension [13:11].
        pred_en:  Enable predicate guard (1) or not (0).
        pred_neg: Negate predicate condition (1) or not (0).

    Returns:
        16-bit Pred/Ctrl value.
    """
    assert 0 <= dtype <= 0xF, f"dtype {dtype} out of range"
    assert 0 <= subop <= 0x7, f"subop {subop} out of range"
    assert 0 <= ext <= 0x7, f"ext {ext} out of range"
    return (
        ((pred_en  & 0x1) << 15)
        | ((pred_neg & 0x1) << 14)
        | ((ext      & 0x7) << 11)
        | ((subop    & 0x7) << 8)
        | ((dtype    & 0xF) << 3)   # bit 7 is reserved=0, folded here
        | (pred_idx  & 0x7)
    )


def decode_pred_ctrl(pred_ctrl: int) -> dict:
    """Decode a 16-bit Pred/Ctrl word into sub-fields.

    Returns a dictionary with keys:
        pred_idx, dtype, subop, ext, pred_en, pred_neg, bit7_reserved
    """
    return {
        "pred_idx":      pred_ctrl & 0x7,
        "dtype":        (pred_ctrl >> 3) & 0xF,
        "bit7_reserved": (pred_ctrl >> 7) & 0x1,
        "subop":        (pred_ctrl >> 8) & 0x7,
        "ext":          (pred_ctrl >> 11) & 0x7,
        "pred_neg":     (pred_ctrl >> 14) & 0x1,
        "pred_en":      (pred_ctrl >> 15) & 0x1,
    }


# ===========================================================================
# Field extraction helpers
# ===========================================================================

def get_dest_reg(dest: int) -> int:
    """Extract the destination GPR index (low 8 bits)."""
    return dest & 0xFF


def get_src_reg(src1: int) -> int:
    """Extract the source GPR index (low 8 bits) — returns raw field value
    which may also encode a special register selector >= 0x100."""
    return src1 & 0xFFFF


def get_src2_reg(src2: int) -> int:
    """Extract the Src2 GPR index from the low 16 bits."""
    return src2 & 0xFFFF


def get_src3_reg(imm_ext: int) -> int:
    """Extract the third source GPR index from ImmExt low 16 bits."""
    return imm_ext & 0xFFFF


def get_bfx_lsb(src2: int) -> int:
    """Extract BFX lsb from Src2[7:0]."""
    return src2 & 0xFF


def get_bfx_width(src2: int) -> int:
    """Extract BFX width from Src2[15:8]."""
    return (src2 >> 8) & 0xFF


def get_bins_lsb(imm_ext: int) -> int:
    """Extract BINS lsb from ImmExt[7:0]."""
    return imm_ext & 0xFF


def get_bins_width(imm_ext: int) -> int:
    """Extract BINS width from ImmExt[15:8]."""
    return (imm_ext >> 8) & 0xFF


def get_shuf_val(src2: int) -> int:
    """Extract SHUF val from Src2[4:0]."""
    return src2 & 0x1F


def get_atom_cmp_reg(src2: int) -> int:
    """Extract ATOM.CAS compare register from Src2[31:16]."""
    return (src2 >> 16) & 0xFFFF


def get_atom_upd_reg(src2: int) -> int:
    """Extract ATOM update register from Src2[15:0]."""
    return src2 & 0xFFFF


# ===========================================================================
# Instruction-to-binary helpers (practical builders)
# ===========================================================================

def make_alu_3reg(opcode: int, dtype: int,
                  rd: int, rs1: int, rs2: int,
                  pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build OP Rd, Rs1, Rs2 (e.g., ADD, SUB, MUL, MIN, MAX, AND, OR, XOR, SHL, SHR)."""
    return encode_instr(
        opcode=opcode,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs1, src2_imm32=rs2,
    )


def make_alu_2reg(opcode: int, dtype: int,
                  rd: int, rs: int,
                  pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build OP Rd, Rs (e.g., NEG, ABS, NOT, POPC, FLO)."""
    return encode_instr(
        opcode=opcode,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs,
    )


def make_mad(opcode: int, dtype: int,
             rd: int, rs1: int, rs2: int, rs3: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build OP Rd, Rs1, Rs2, Rs3 (MAD, FMA)."""
    return encode_instr(
        opcode=opcode,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs1, src2_imm32=rs2, imm_ext=rs3,
    )


def make_div(opcode: int, dtype: int,
             rd: int, rs1: int, rs2: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build DIV Rd, Rs1, Rs2."""
    return make_alu_3reg(opcode, dtype, rd, rs1, rs2, pred_idx, pred_en, pred_neg)


def make_bfx(dtype: int, rd: int, rs: int, lsb: int, width: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build BFX Rd, Rs, lsb, width."""
    src2 = (width << 8) | (lsb & 0xFF)
    return encode_instr(
        opcode=OP_BFX,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs, src2_imm32=src2,
    )


def make_bins(dtype: int, rd: int, base: int, insert: int,
              lsb: int, width: int,
              pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build BINS Rd, base, insert, lsb, width."""
    imm_ext = (width << 8) | (lsb & 0xFF)
    return encode_instr(
        opcode=OP_BINS,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=base, src2_imm32=insert, imm_ext=imm_ext,
    )


def make_cmp(dtype: int, cmp_op: int,
             rd: int, rs1: int, rs2: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build CMP.cond Rd, Rs1, Rs2 (writes 0 or 1 to GPR)."""
    return encode_instr(
        opcode=OP_CMP,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   subop=cmp_op, pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs1, src2_imm32=rs2,
    )


def make_cmpp(dtype: int, cmp_op: int,
              pd: int, rs1: int, rs2: int,
              pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build CMPP.cond Pd, Rs1, Rs2 (writes false/true to predicate)."""
    return encode_instr(
        opcode=OP_CMPP,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   subop=cmp_op, pred_en=pred_en, pred_neg=pred_neg),
        dest=pd, src1=rs1, src2_imm32=rs2,
    )


def make_sel(dtype: int,
             rd: int, rs1: int, rs2: int, pn: int) -> int:
    """Build SEL Rd, Rs1, Rs2, Pn (no predicate guard allowed)."""
    return encode_instr(
        opcode=OP_SEL,
        pred_ctrl=build_pred_ctrl(pred_idx=pn, dtype=dtype),
        dest=rd, src1=rs1, src2_imm32=rs2,
    )


def make_pick(dtype: int,
              rd: int, rs1: int, rs2: int,
              pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build PICK Rd, Rs1, Rs2."""
    return make_alu_3reg(OP_PICK, dtype, rd, rs1, rs2, pred_idx, pred_en, pred_neg)


def make_ld(dtype: int, space: int,
            rd: int, ra: int,
            pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build LD.space Rd, [Ra]."""
    return encode_instr(
        opcode=OP_LD,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   ext=space, pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=ra,
    )


def make_st(dtype: int, space: int,
            ra: int, rs: int,
            pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build ST.space [Ra], Rs."""
    return encode_instr(
        opcode=OP_ST,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   ext=space, pred_en=pred_en, pred_neg=pred_neg),
        dest=0, src1=ra, src2_imm32=rs,
    )


def make_ldc(dtype: int,
             rd: int, ra: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build LDC Rd, [Ra] (always .cmem)."""
    return encode_instr(
        opcode=OP_LDC,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   ext=SPACE_CMEM,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=ra,
    )


def make_atom(atom_op: int, dtype: int, space: int,
              rd: int, ra: int, rs_update: int, rs_cmp: int = 0,
              pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build ATOM.op Rd, [Ra], Rs (non-CAS) or ATOM.cas Rd, [Ra], Rcmp, Rupdate (CAS)."""
    if atom_op == ATOM_CAS:
        src2 = (rs_cmp << 16) | (rs_update & 0xFFFF)
    else:
        src2 = rs_update & 0xFFFF
    return encode_instr(
        opcode=OP_ATOM,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   subop=atom_op, ext=space,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=ra, src2_imm32=src2,
    )


def make_br(target_pc: int) -> int:
    """Build BR label (unconditional)."""
    return encode_instr(
        opcode=OP_BR,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
        imm_ext=target_pc,
    )


def make_brx(pred_idx: int, target_pc: int) -> int:
    """Build BRX Pn, label (conditional, must be uniform)."""
    return encode_instr(
        opcode=OP_BRX,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=TYPE_NONE,
                                   pred_en=1),
        imm_ext=target_pc,
    )


def make_call(target_pc: int) -> int:
    """Build CALL label."""
    return encode_instr(
        opcode=OP_CALL,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
        imm_ext=target_pc,
    )


def make_ret() -> int:
    """Build RET."""
    return encode_instr(
        opcode=OP_RET,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
    )


def make_halt() -> int:
    """Build HALT (uniform, completes current warp)."""
    return encode_instr(
        opcode=OP_HALT,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
    )


def make_sync_ct() -> int:
    """Build SYNC.CT (CTA barrier, no predicate guard)."""
    return encode_instr(
        opcode=OP_SYNC_CT,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
    )


def make_mbar(scope: int) -> int:
    """Build MBAR.scope."""
    return encode_instr(
        opcode=OP_MBAR,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE, ext=scope),
    )


def build_cvt_pred_ctrl(
    dst_type: int,
    src_type: int,
    pred_idx: int = 0,
    pred_en: int = 0,
    pred_neg: int = 0,
) -> int:
    """Build the 16-bit Pred/Ctrl word for CVT instructions.

    CVT layout differs from standard Pred/Ctrl:
      [15]    = pred_en
      [14]    = pred_neg
      [13:10] = source type (4-bit)
      [9:7]   = 0 (reserved)
      [6:3]   = destination type (4-bit)
      [2:0]   = predicate index
    """
    assert 0 <= dst_type <= 0xF
    assert 0 <= src_type <= 0xF
    return (
        ((pred_en  & 0x1) << 15)
        | ((pred_neg & 0x1) << 14)
        | ((src_type & 0xF) << 10)
        | ((dst_type & 0xF) << 3)
        | (pred_idx  & 0x7)
    )


def make_cvt(opcode: int, dst_type: int, src_type: int,
             rd: int, rs: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build CVT*.dst.src Rd, Rs."""
    pred_ctrl = build_cvt_pred_ctrl(
        dst_type=dst_type, src_type=src_type,
        pred_idx=pred_idx, pred_en=pred_en, pred_neg=pred_neg,
    )
    return encode_instr(opcode=opcode, pred_ctrl=pred_ctrl, dest=rd, src1=rs)


def make_cpy(dtype: int, rd: int, rs_or_special: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build CPY Rd, Rs/%special."""
    return encode_instr(
        opcode=OP_CPY,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=dtype,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs_or_special,
    )


def make_loadi(rd: int, imm32: int,
               pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build LOADI Rd, imm32."""
    return encode_instr(
        opcode=OP_LOADI,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=TYPE_NONE,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, imm_ext=imm32,
    )


def make_loadi64(rd: int, imm64: int,
                 pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build LOADI64 Rd, imm64 (writes pair {R[rd+1], R[rd]})."""
    return encode_instr(
        opcode=OP_LOADI64,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=TYPE_NONE,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src2_imm32=(imm64 >> 32) & 0xFFFFFFFF, imm_ext=imm64 & 0xFFFFFFFF,
    )


def make_shuf(mode: int, dtype: int,
              rd: int, rs: int, val: int, mask: int) -> int:
    """Build SHUF.mode Rd, Rs, val, mask (no predicate guard)."""
    return encode_instr(
        opcode=OP_SHUF,
        pred_ctrl=build_pred_ctrl(dtype=dtype, subop=mode),
        dest=rd, src1=rs, src2_imm32=val & 0x1F, imm_ext=mask,
    )


def make_vote(mode: int, dest_is_pred: bool,
              rd_or_pd: int, pn: int) -> int:
    """Build VOTE.mode Rd/Pd, Pn (no predicate guard)."""
    ext = VOTE_DEST_PRED if dest_is_pred else VOTE_DEST_GPR
    return encode_instr(
        opcode=OP_VOTE,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE, subop=mode, ext=ext),
        dest=rd_or_pd, src1=pn & 0x7,
    )


def make_mtch(rd: int, rs: int) -> int:
    """Build MTCH.any Rd, Rs (no predicate guard)."""
    return encode_instr(
        opcode=OP_MTCH,
        pred_ctrl=build_pred_ctrl(dtype=TYPE_NONE),
        dest=rd, src1=rs,
    )


def make_sfu(opcode: int, mode: int,
             rd: int, rs: int,
             pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build SFU instruction (RCP, RSQ, SQRT with approx/full; SIN/COS/EXP/LOG with mode=0)."""
    return encode_instr(
        opcode=opcode,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=TYPE_F32,
                                   subop=mode, pred_en=pred_en, pred_neg=pred_neg),
        dest=rd, src1=rs,
    )


def make_rdtsc(rd: int,
               pred_idx: int = 0, pred_en: int = 0, pred_neg: int = 0) -> int:
    """Build RDTSC Rd (writes 32-bit cycle counter)."""
    return encode_instr(
        opcode=OP_RDTSC,
        pred_ctrl=build_pred_ctrl(pred_idx=pred_idx, dtype=TYPE_NONE,
                                   pred_en=pred_en, pred_neg=pred_neg),
        dest=rd,
    )


# ===========================================================================
# Opcode metadata
# ===========================================================================

OPCODE_NAMES = {
    OP_ADD:  "ADD",   OP_SUB:  "SUB",   OP_MUL:  "MUL",   OP_MAD:  "MAD",
    OP_FMA:  "FMA",   OP_DIV:  "DIV",   OP_NEG:  "NEG",   OP_ABS:  "ABS",
    OP_MIN:  "MIN",   OP_MAX:  "MAX",
    OP_AND:  "AND",   OP_OR:   "OR",    OP_XOR:  "XOR",   OP_NOT:  "NOT",
    OP_SHL:  "SHL",   OP_SHR:  "SHR",   OP_BFX:  "BFX",   OP_BINS: "BINS",
    OP_POPC: "POPC",  OP_FLO:  "FLO",
    OP_CMP:  "CMP",   OP_CMPP: "CMPP",  OP_SEL:  "SEL",   OP_PICK: "PICK",
    OP_LD:   "LD",    OP_ST:   "ST",    OP_LDC:  "LDC",   OP_ATOM: "ATOM",
    OP_BR:   "BR",    OP_BRX:  "BRX",   OP_CALL: "CALL",  OP_RET:  "RET",
    OP_HALT: "HALT",  OP_SYNC_CT: "SYNC.CT", OP_MBAR: "MBAR",
    OP_CVTFF: "CVTFF", OP_CVTFI: "CVTFI", OP_CVTIF: "CVTIF", OP_CVTII: "CVTII",
    OP_CPY:  "CPY",
    OP_LOADI: "LOADI", OP_LOADI64: "LOADI64",
    OP_SHUF: "SHUF",  OP_VOTE: "VOTE",  OP_MTCH: "MTCH",
    OP_RCP:  "RCP",   OP_RSQ:  "RSQ",   OP_SIN:  "SIN",   OP_COS:  "COS",
    OP_EXP:  "EXP",   OP_LOG:  "LOG",   OP_SQRT: "SQRT",
    OP_RDTSC: "RDTSC",
}

# Opcode categories for validation and scheduling
OPCODE_CATEGORY = {
    OP_ADD: "ALU", OP_SUB: "ALU", OP_MUL: "ALU", OP_MAD: "ALU",
    OP_FMA: "ALU", OP_DIV: "ALU", OP_NEG: "ALU", OP_ABS: "ALU",
    OP_MIN: "ALU", OP_MAX: "ALU",
    OP_AND: "ALU", OP_OR: "ALU", OP_XOR: "ALU", OP_NOT: "ALU",
    OP_SHL: "ALU", OP_SHR: "ALU", OP_BFX: "ALU", OP_BINS: "ALU",
    OP_POPC: "ALU", OP_FLO: "ALU",
    OP_CMP: "ALU", OP_CMPP: "ALU", OP_SEL: "ALU", OP_PICK: "ALU",
    OP_LD: "MEM", OP_ST: "MEM", OP_LDC: "MEM", OP_ATOM: "MEM",
    OP_BR: "CTRL", OP_BRX: "CTRL", OP_CALL: "CTRL", OP_RET: "CTRL",
    OP_HALT: "CTRL", OP_SYNC_CT: "CTRL", OP_MBAR: "CTRL",
    OP_CVTFF: "ALU", OP_CVTFI: "ALU", OP_CVTIF: "ALU", OP_CVTII: "ALU",
    OP_CPY: "ALU",
    OP_LOADI: "ALU", OP_LOADI64: "ALU",
    OP_SHUF: "ALU", OP_VOTE: "ALU", OP_MTCH: "ALU",
    OP_RCP: "SFU", OP_RSQ: "SFU", OP_SIN: "SFU", OP_COS: "SFU",
    OP_EXP: "SFU", OP_LOG: "SFU", OP_SQRT: "SFU",
    OP_RDTSC: "SYS",
}

# Instructions that disallow generic predicate guard
NO_GUARD_OPCODES = {
    OP_BR, OP_CALL, OP_RET, OP_HALT,
    OP_SYNC_CT, OP_MBAR,
    OP_SHUF, OP_VOTE, OP_MTCH,
}

# Instructions requiring uniform execution across active lanes
UNIFORM_OPCODES = {
    OP_BR, OP_BRX, OP_CALL, OP_RET, OP_HALT, OP_SYNC_CT,
}


# ===========================================================================
# Binary I/O helpers
# ===========================================================================

import struct


def instr_to_bytes(instr: int) -> bytes:
    """Pack a 128-bit instruction into 16 little-endian bytes (w0..w3)."""
    w0 = (instr >> 0)  & 0xFFFFFFFF
    w1 = (instr >> 32) & 0xFFFFFFFF
    w2 = (instr >> 64) & 0xFFFFFFFF
    w3 = (instr >> 96) & 0xFFFFFFFF
    return struct.pack("<IIII", w0, w1, w2, w3)


def bytes_to_instr(data: bytes) -> int:
    """Unpack 16 little-endian bytes into a 128-bit instruction."""
    w0, w1, w2, w3 = struct.unpack("<IIII", data[:16])
    return (w3 << 96) | (w2 << 64) | (w1 << 32) | w0


def instr_to_hex(instr: int) -> str:
    """Format a 128-bit instruction as MSB-first hex string (w3,w2,w1,w0)."""
    return f"{instr:032x}"


def hex_to_instr(hex_str: str) -> int:
    """Parse a MSB-first hex string into a 128-bit instruction."""
    return int(hex_str.strip(), 16)


def read_binary(path: str) -> list[int]:
    """Read an AEC binary file (program.bin) into a list of 128-bit instructions."""
    with open(path, "rb") as f:
        data = f.read()
    assert len(data) % 16 == 0, f"Binary size {len(data)} not multiple of 16"
    return [bytes_to_instr(data[i:i+16]) for i in range(0, len(data), 16)]


def write_binary(path: str, instrs: list[int]) -> None:
    """Write a list of 128-bit instructions to an AEC binary file."""
    with open(path, "wb") as f:
        for instr in instrs:
            f.write(instr_to_bytes(instr))


# ===========================================================================
# Quick self-test (runs on import only if executed directly)
# ===========================================================================

if __name__ == "__main__":
    # Verify a few known encodings from public testcases
    tests = []

    # CPY.u32 R1, %laneid
    instr = make_cpy(TYPE_U32, 1, SPREG_LANEID)
    tests.append(("CPY.u32 R1, %laneid", "00540010000101040000000000000000", instr))

    # LOADI R2, 10
    instr = make_loadi(2, 10)
    tests.append(("LOADI R2, 10", "0055007800020000000000000000000a", instr))

    # ADD.u32 R3, R1, R2
    instr = make_alu_3reg(OP_ADD, TYPE_U32, 3, 1, 2)
    tests.append(("ADD.u32 R3, R1, R2", "00010010000300010000000200000000", instr))

    # LOADI R4, 3
    instr = make_loadi(4, 3)
    tests.append(("LOADI R4, 3", "00550078000400000000000000000003", instr))

    # MUL.u32 R5, R1, R4
    instr = make_alu_3reg(OP_MUL, TYPE_U32, 5, 1, 4)
    tests.append(("MUL.u32 R5, R1, R4", "00030010000500010000000400000000", instr))

    # ADD.u32 R6, R3, R5
    instr = make_alu_3reg(OP_ADD, TYPE_U32, 6, 3, 5)
    tests.append(("ADD.u32 R6, R3, R5", "00010010000600030000000500000000", instr))

    # LOADI R7, 2
    instr = make_loadi(7, 2)
    tests.append(("LOADI R7, 2", "00550078000700000000000000000002", instr))

    # SHL.u32 R8, R1, R7
    instr = make_alu_3reg(OP_SHL, TYPE_U32, 8, 1, 7)
    tests.append(("SHL.u32 R8, R1, R7", "00140010000800010000000700000000", instr))

    # LOADI R9, 0x100
    instr = make_loadi(9, 0x100)
    tests.append(("LOADI R9, 0x100", "00550078000900000000000000000100", instr))

    # ADD.u32 R10, R9, R8
    instr = make_alu_3reg(OP_ADD, TYPE_U32, 10, 9, 8)
    tests.append(("ADD.u32 R10, R9, R8", "00010010000a00090000000800000000", instr))

    # ST.gmem.u32 [R10], R6
    instr = make_st(TYPE_U32, SPACE_GMEM, 10, 6)
    tests.append(("ST.gmem.u32 [R10], R6", "003100100000000a0000000600000000", instr))

    # HALT
    instr = make_halt()
    tests.append(("HALT", "00450078000000000000000000000000", instr))

    # CMPP.eq.u32 P1, R2, R2
    instr = make_cmpp(TYPE_U32, CMP_EQ, 1, 2, 2)
    tests.append(("CMPP.eq.u32 P1, R2, R2", "00210010000100020000000200000000", instr))

    # BRX P1, 5
    instr = make_brx(1, 5)
    tests.append(("BRX P1, 5", "00418079000000000000000000000005", instr))

    # CALL 9
    instr = make_call(9)
    tests.append(("CALL 9", "00430078000000000000000000000009", instr))

    # FMA.f32 R4, R2, R3, R9
    instr = make_mad(OP_FMA, TYPE_F32, 4, 2, 3, 9)
    tests.append(("FMA.f32 R4, R2, R3, R9", "00050040000400020000000300000009", instr))

    # LD.gmem.u32 R4, [R3]
    instr = make_ld(TYPE_U32, SPACE_GMEM, 4, 3)
    tests.append(("LD.gmem.u32 R4, [R3]", "00300010000400030000000000000000", instr))

    # LDC.cmem.u32 R4, [R3]
    instr = make_ldc(TYPE_U32, 4, 3)
    tests.append(("LDC.cmem.u32 R4, [R3]", "00321010000400030000000000000000", instr))

    # ATOM.gmem.add.u32 R5, [R3], R4
    instr = make_atom(ATOM_ADD, TYPE_U32, SPACE_GMEM, 5, 3, 4)
    tests.append(("ATOM.gmem.add.u32 R5, [R3], R4", "00330010000500030000000400000000", instr))

    # SHUF.idx.u32 R8, R1, 0, 0xffffffff
    instr = make_shuf(SHUF_IDX, TYPE_U32, 8, 1, 0, 0xFFFFFFFF)
    tests.append(("SHUF.idx.u32 R8, R1, 0, 0xffffffff", "005700100008000100000000ffffffff", instr))

    # VOTE.any R8, P1
    instr = make_vote(VOTE_ANY, False, 8, 1)
    tests.append(("VOTE.any R8, P1", "00580178000800010000000000000000", instr))

    # MTCH.any R8, R4
    instr = make_mtch(8, 4)
    tests.append(("MTCH.any R8, R4", "00590078000800040000000000000000", instr))

    # RCP.full.f32 R8, R4
    instr = make_sfu(OP_RCP, SFU_FULL, 8, 4)
    tests.append(("RCP.full.f32 R8, R4", "00700140000800040000000000000000", instr))

    # RDTSC R4
    instr = make_rdtsc(4)
    tests.append(("RDTSC R4", "00800078000400000000000000000000", instr))

    # BFX.u32 R4, R2, 4, 8
    instr = make_bfx(TYPE_U32, 4, 2, 4, 8)
    tests.append(("BFX.u32 R4, R2, 4, 8", "00160010000400020000080400000000", instr))

    # POPC.b32 R4, R1
    instr = make_alu_2reg(OP_POPC, TYPE_B32, 4, 1)
    tests.append(("POPC.b32 R4, R1", "00180000000400010000000000000000", instr))

    # CMP.lt.u32 R4, R1, R2
    instr = make_cmp(TYPE_U32, CMP_LT, 4, 1, 2)
    tests.append(("CMP.lt.u32 R4, R1, R2", "00200210000400010000000200000000", instr))

    # SEL.u32 R4, R1, R2, P0
    instr = make_sel(TYPE_U32, 4, 1, 2, 0)
    tests.append(("SEL.u32 R4, R1, R2, P0", "00220010000400010000000200000000", instr))

    # LOADI64
    instr = make_loadi64(10, 0xDEADBEEF00000042)
    # Expected from spec: Dest=10, Src2=0xDEADBEEF, ImmExt=0x00000042
    expected = "00560078000a0000deadbeef00000042"
    tests.append(("LOADI64 R10, ...", expected, instr))

    # DIV.u32 R4, R1, R2
    instr = make_div(OP_DIV, TYPE_U32, 4, 1, 2)
    tests.append(("DIV.u32 R4, R1, R2", "00060010000400010000000200000000", instr))

    # CVTIF.f32.u32 R4, R1
    instr = make_cvt(OP_CVTIF, TYPE_F32, TYPE_U32, 4, 1)
    tests.append(("CVTIF.f32.u32 R4, R1", "00520840000400010000000000000000", instr))

    # CVTFF.f16.f32 R8, R4
    instr = make_cvt(OP_CVTFF, TYPE_F16, TYPE_F32, 8, 4)
    tests.append(("CVTFF.f16.f32 R8, R4", "00502050000800040000000000000000", instr))

    # CMP.le.u32 R8, R4, R5
    instr = make_cmp(TYPE_U32, CMP_LE, 8, 4, 5)
    tests.append(("CMP.le.u32 R8, R4, R5", "00200310000800040000000500000000", instr))

    all_pass = True
    for name, expected, actual in tests:
        actual_hex = instr_to_hex(actual)
        match = "✓" if actual_hex == expected else "✗"
        if actual_hex != expected:
            all_pass = False
            print(f"  {match} {name}")
            print(f"       expected: {expected}")
            print(f"       actual:   {actual_hex}")
        else:
            print(f"  {match} {name}")

    print(f"\n  {'ALL TESTS PASSED' if all_pass else 'SOME TESTS FAILED'}")
