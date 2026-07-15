package aec

import chisel3._

/** Fully unpacked AEC instruction.  Validation is intentionally separate from
  * unpacking: a malformed instruction still has a stable representation for
  * the retire unit to turn into INVALID without any side effect. */
class AecDecodedInstruction extends Bundle {
  val raw = UInt(128.W)
  val opcode = UInt(16.W)
  val predicate = UInt(3.W)
  val dtype = UInt(4.W)
  val reservedCtrl = Bool()
  val subop = UInt(3.W)
  val ext = UInt(3.W)
  val predNeg = Bool()
  val predEn = Bool()
  val destRaw = UInt(16.W)
  val src1Raw = UInt(16.W)
  val src2Imm = UInt(32.W)
  val immExt = UInt(32.W)
  val dest = UInt(8.W)
  val src1 = UInt(8.W)
  val src2 = UInt(8.W)
  val src3 = UInt(8.W)
}

object AecDecode {
  def apply(instruction: UInt): AecDecodedInstruction = {
    val decoded = Wire(new AecDecodedInstruction)
    decoded.raw := instruction
    decoded.opcode := instruction(127, 112)
    val ctrl = instruction(111, 96)
    decoded.predicate := ctrl(2, 0)
    decoded.dtype := ctrl(6, 3)
    decoded.reservedCtrl := ctrl(7)
    decoded.subop := ctrl(10, 8)
    decoded.ext := ctrl(13, 11)
    decoded.predNeg := ctrl(14)
    decoded.predEn := ctrl(15)
    decoded.destRaw := instruction(95, 80)
    decoded.src1Raw := instruction(79, 64)
    decoded.src2Imm := instruction(63, 32)
    decoded.immExt := instruction(31, 0)
    decoded.dest := instruction(87, 80)
    decoded.src1 := instruction(71, 64)
    decoded.src2 := instruction(39, 32)
    // ImmExt is a 16-bit operand field in the ternary form.  As with Src2,
    // the register index occupies its low byte and the remaining bits are MBZ.
    decoded.src3 := instruction(7, 0)
    decoded
  }
}
