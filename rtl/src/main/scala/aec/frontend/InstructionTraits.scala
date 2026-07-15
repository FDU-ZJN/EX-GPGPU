package aec

import chisel3._

/** Central source/destination-use classification for dependency tracking.
  * Keeping this separate from backend selection prevents unused encoded fields
  * from creating false RAW hazards once a warp has several ROB entries.
  */
object AecInstructionTraits {
  def integerOpcode(op: UInt): Bool =
    op === AecOpcode.add || op === AecOpcode.sub || op === AecOpcode.mul ||
    op === AecOpcode.mad || op === AecOpcode.neg || op === AecOpcode.abs ||
    op === AecOpcode.min || op === AecOpcode.max || op === AecOpcode.andOp ||
    op === AecOpcode.orOp || op === AecOpcode.xorOp || op === AecOpcode.notOp ||
    op === AecOpcode.shl || op === AecOpcode.shr || op === AecOpcode.bfx ||
    op === AecOpcode.bins || op === AecOpcode.popc || op === AecOpcode.flo ||
    op === AecOpcode.cmp || op === AecOpcode.cmpp || op === AecOpcode.sel ||
    op === AecOpcode.pick || op === AecOpcode.cpy || op === AecOpcode.loadi

  def fpOpcode(op: UInt): Bool =
    op === AecOpcode.add || op === AecOpcode.sub || op === AecOpcode.mul ||
    op === AecOpcode.mad || op === AecOpcode.fma || op === AecOpcode.neg ||
    op === AecOpcode.abs || op === AecOpcode.min || op === AecOpcode.max ||
    op === AecOpcode.cmp || op === AecOpcode.cmpp

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

  def usesSourcePredicate(d: AecDecodedInstruction): Bool =
    d.predEn || d.opcode === AecOpcode.vote || d.opcode === AecOpcode.sel

  def sourcePredicate(d: AecDecodedInstruction): UInt =
    Mux(d.opcode === AecOpcode.vote, d.src1(2, 0), d.predicate)

  private def pairType(d: AecDecodedInstruction): Bool =
    d.dtype === 1.U || d.dtype === 9.U

  private def conversion(d: AecDecodedInstruction): Bool =
    d.opcode === AecOpcode.cvtff || d.opcode === AecOpcode.cvtfi ||
      d.opcode === AecOpcode.cvtif || d.opcode === AecOpcode.cvtii

  def source0Pair(d: AecDecodedInstruction): Bool =
    Mux(conversion(d), d.raw(109, 106) === 9.U,
      pairType(d) && d.opcode =/= AecOpcode.ld)

  def source1Pair(d: AecDecodedInstruction): Bool =
    pairType(d) && !conversion(d)

  def source2Pair(d: AecDecodedInstruction): Bool =
    pairType(d) && !conversion(d)

  def needsPairRead(d: AecDecodedInstruction): Bool =
    (usesSrc0(d) && source0Pair(d)) ||
      (usesSrc1(d) && source1Pair(d)) ||
      (usesSrc2(d) && source2Pair(d))
}
