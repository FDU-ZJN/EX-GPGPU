package aec

import chisel3._

/** Central source/destination-use classification for dependency tracking.
  * Keeping this separate from backend selection prevents unused encoded fields
  * from creating false RAW hazards once a warp has several ROB entries.
  */
object AecInstructionTraits {
  def usesSrc0(d: AecDecodedInstruction): Bool = {
    val specialCpy = d.opcode === AecOpcode.cpy && d.src1Raw(15, 8).orR
    !(d.opcode === AecOpcode.loadi || d.opcode === AecOpcode.loadi64 ||
      d.opcode === AecOpcode.rdtsc || d.opcode === AecOpcode.vote || specialCpy)
  }

  def usesSrc1(d: AecDecodedInstruction): Bool = {
    d.opcode === AecOpcode.add || d.opcode === AecOpcode.sub ||
    d.opcode === AecOpcode.mul || d.opcode === AecOpcode.mad ||
    d.opcode === AecOpcode.fma || d.opcode === AecOpcode.min ||
    d.opcode === AecOpcode.max || d.opcode === AecOpcode.andOp ||
    d.opcode === AecOpcode.orOp || d.opcode === AecOpcode.xorOp ||
    d.opcode === AecOpcode.shl || d.opcode === AecOpcode.shr ||
    d.opcode === AecOpcode.bins || d.opcode === AecOpcode.cmp ||
    d.opcode === AecOpcode.cmpp || d.opcode === AecOpcode.sel ||
    d.opcode === AecOpcode.pick || d.opcode === AecOpcode.st ||
    d.opcode === AecOpcode.atom || d.opcode === AecOpcode.div
  }

  def usesSrc2(d: AecDecodedInstruction): Bool = {
    d.opcode === AecOpcode.mad || d.opcode === AecOpcode.fma ||
    d.opcode === AecOpcode.sel || d.opcode === AecOpcode.pick ||
    (d.opcode === AecOpcode.atom && d.subop === 7.U)
  }

  def usesGuardPredicate(d: AecDecodedInstruction): Bool =
    d.predEn || d.opcode === AecOpcode.vote

  def sourcePredicate(d: AecDecodedInstruction): UInt =
    Mux(d.opcode === AecOpcode.vote, d.src1(2, 0), d.predicate)
}
