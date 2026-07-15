"""Static encoding validation for the currently implemented instruction set."""

from __future__ import annotations

from typing import Any

from ..core import aec_isa
from ..core.errors import InvalidInstructionError


def validate_data(model: Any, fields: dict[str, int], pc: int) -> None:
    """Validate an implemented data instruction before execution."""
    opcode = fields["opcode"]
    ctrl = aec_isa.decode_pred_ctrl(fields["pred_ctrl"])
    if ctrl["bit7_reserved"] or (not ctrl["pred_en"] and (ctrl["pred_neg"] or ctrl["pred_idx"])):
        raise InvalidInstructionError(f"instruction at PC {pc} has invalid predicate control")
    if fields["dest"] > 0xFF:
        raise InvalidInstructionError(f"instruction at PC {pc} has invalid destination register")

    if opcode == aec_isa.OP_LOADI:
        if (ctrl["dtype"], ctrl["subop"], ctrl["ext"]) != (aec_isa.TYPE_NONE, 0, 0):
            raise InvalidInstructionError(f"LOADI at PC {pc} has invalid control fields")
        if fields["src1"] or fields["src2_imm32"]:
            raise InvalidInstructionError(f"LOADI at PC {pc} has non-zero unused fields")
        return

    if opcode == aec_isa.OP_CPY:
        if (ctrl["dtype"], ctrl["subop"], ctrl["ext"]) != (aec_isa.TYPE_U32, 0, 0):
            raise InvalidInstructionError(f"CPY at PC {pc} has unsupported type or control fields")
        if fields["src2_imm32"] or fields["imm_ext"]:
            raise InvalidInstructionError(f"CPY at PC {pc} has non-zero unused fields")
        if fields["src1"] > 0xFF and fields["src1"] not in aec_isa.SPREG_NAMES:
            raise InvalidInstructionError(f"CPY at PC {pc} has invalid source register")
        return

    if opcode in (aec_isa.OP_ADD, aec_isa.OP_MUL, aec_isa.OP_SHL):
        if (ctrl["dtype"], ctrl["subop"], ctrl["ext"]) != (aec_isa.TYPE_U32, 0, 0):
            raise InvalidInstructionError(f"integer instruction at PC {pc} has invalid type or control fields")
        if fields["src1"] > 0xFF or fields["src2_imm32"] > 0xFF or fields["imm_ext"]:
            raise InvalidInstructionError(f"integer instruction at PC {pc} has invalid register payload")
        return

    if (ctrl["dtype"], ctrl["subop"], ctrl["ext"]) != (aec_isa.TYPE_U32, 0, aec_isa.SPACE_GMEM):
        raise InvalidInstructionError(f"ST at PC {pc} has invalid type, space, or control fields")
    if fields["dest"] or fields["src1"] > 0xFF or fields["src2_imm32"] > 0xFF or fields["imm_ext"]:
        raise InvalidInstructionError(f"ST at PC {pc} has invalid payload")


def validate_control(model: Any, fields: dict[str, int], pc: int) -> None:
    """Validate a control instruction and its branch target."""
    opcode = fields["opcode"]
    ctrl = aec_isa.decode_pred_ctrl(fields["pred_ctrl"])
    payload_is_zero = fields["dest"] == 0 and fields["src1"] == 0 and fields["src2_imm32"] == 0

    if ctrl["bit7_reserved"] or ctrl["dtype"] != aec_isa.TYPE_NONE:
        raise InvalidInstructionError(f"control instruction at PC {pc} has invalid type/reserved bits")
    if ctrl["subop"] != 0:
        raise InvalidInstructionError(f"control instruction at PC {pc} has non-zero subop")

    if opcode == aec_isa.OP_BRX:
        if not ctrl["pred_en"] or ctrl["pred_neg"] or not payload_is_zero:
            raise InvalidInstructionError(f"BRX at PC {pc} has invalid predicate or payload")
    elif ctrl["pred_en"] or ctrl["pred_neg"] or ctrl["pred_idx"] or not payload_is_zero:
        raise InvalidInstructionError(f"control instruction at PC {pc} has forbidden guard or payload")

    if opcode == aec_isa.OP_MBAR:
        if ctrl["ext"] not in (aec_isa.MBAR_CT, aec_isa.MBAR_SYS) or fields["imm_ext"] != 0:
            raise InvalidInstructionError(f"MBAR at PC {pc} has invalid scope or payload")
    else:
        if ctrl["ext"] != 0:
            raise InvalidInstructionError(f"control instruction at PC {pc} has invalid extension")
        if opcode in (aec_isa.OP_BR, aec_isa.OP_BRX, aec_isa.OP_CALL):
            if not 0 <= fields["imm_ext"] < model.launch.program_instructions:
                raise InvalidInstructionError(f"branch target at PC {pc} is outside the program range")
        elif fields["imm_ext"] != 0:
            raise InvalidInstructionError(f"control instruction at PC {pc} has non-zero immediate")
