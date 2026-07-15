package aec.int

import chisel3._
import chisel3.util._

class AecIntDivRequest extends Bundle {
  val dividend = UInt(32.W)
  val divisor = UInt(32.W)
  val signed = Bool()
}

class AecIntDivResponse extends Bundle {
  val quotient = UInt(32.W)
  val error = Bool()
}

/**
  * Timing-oriented radix-2 restoring divider.
  *
  * This follows the multi-cycle organization used by Ventus IntDivMod, but
  * keeps only the AEC quotient path and uses an explicit 6-bit counter so the
  * full 32-iteration case cannot wrap to zero.
  */
class AecIntDivider extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecIntDivRequest))
    val resp = Decoupled(new AecIntDivResponse)
  })

  val idle :: iterate :: finish :: Nil = Enum(3)
  val state = RegInit(idle)
  val divisor = Reg(UInt(32.W))
  val dividend = Reg(UInt(32.W))
  val remainder = RegInit(0.U(33.W))
  val quotient = RegInit(0.U(32.W))
  val quotientNegative = RegInit(false.B)
  val count = RegInit(0.U(6.W))
  val result = RegInit(0.U(32.W))
  val error = RegInit(false.B)

  io.req.ready := state === idle
  io.resp.valid := state === finish
  io.resp.bits.quotient := result
  io.resp.bits.error := error

  val dividendNegative = io.req.bits.signed && io.req.bits.dividend(31)
  val divisorNegative = io.req.bits.signed && io.req.bits.divisor(31)
  val dividendMagnitude = Mux(dividendNegative, -io.req.bits.dividend, io.req.bits.dividend)
  val divisorMagnitude = Mux(divisorNegative, -io.req.bits.divisor, io.req.bits.divisor)

  when (io.req.fire) {
    dividend := dividendMagnitude
    divisor := divisorMagnitude
    remainder := 0.U
    quotient := 0.U
    quotientNegative := dividendNegative ^ divisorNegative
    count := 32.U
    error := io.req.bits.divisor === 0.U
    when (io.req.bits.divisor === 0.U) {
      result := 0.U
      state := finish
    }.otherwise {
      state := iterate
    }
  }

  when (state === iterate) {
    val shiftedRemainder = Cat(remainder(31, 0), dividend(31))
    val subtract = shiftedRemainder >= Cat(0.U(1.W), divisor)
    val nextRemainder = Mux(subtract, shiftedRemainder - divisor, shiftedRemainder)
    val nextQuotient = Cat(quotient(30, 0), subtract)
    remainder := nextRemainder
    dividend := Cat(dividend(30, 0), 0.U(1.W))
    quotient := nextQuotient
    count := count - 1.U
    when (count === 1.U) {
      result := Mux(quotientNegative, -nextQuotient, nextQuotient)
      state := finish
    }
  }

  when (io.resp.fire) {
    state := idle
    error := false.B
  }
}

