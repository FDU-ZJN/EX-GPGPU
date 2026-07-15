package aec

import chisel3._
import chisel3.util._

/** Exact unsigned 8-bit div/mod with a 1..256 divisor. */
class AecUnsignedDivider8 extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val numerator = Input(UInt(8.W))
    val divisor = Input(UInt(9.W))
    val busy = Output(Bool())
    val done = Output(Bool())
    val quotient = Output(UInt(8.W))
    val remainder = Output(UInt(8.W))
  })

  val busy = RegInit(false.B)
  val dividend = Reg(UInt(8.W))
  val divisor = Reg(UInt(9.W))
  val quotient = Reg(UInt(8.W))
  val remainder = Reg(UInt(9.W))
  val count = RegInit(0.U(3.W))
  val resultQuotient = Reg(UInt(8.W))
  val resultRemainder = Reg(UInt(8.W))
  val done = RegInit(false.B)

  io.busy := busy
  io.done := done
  io.quotient := resultQuotient
  io.remainder := resultRemainder
  done := false.B

  when (io.start && !busy) {
    assert(io.divisor =/= 0.U, "coordinate divider divisor must be nonzero")
    dividend := io.numerator
    divisor := io.divisor
    quotient := 0.U
    remainder := 0.U
    count := 0.U
    busy := true.B
  }.elsewhen (busy) {
    val trial = Cat(remainder(7, 0), dividend(7))
    val subtract = trial >= divisor
    val nextRemainder = Mux(subtract, trial - divisor, trial)
    val nextQuotient = Cat(quotient(6, 0), subtract)
    dividend := Cat(dividend(6, 0), 0.U(1.W))
    quotient := nextQuotient
    remainder := nextRemainder
    when (count === 7.U) {
      resultQuotient := nextQuotient
      resultRemainder := nextRemainder(7, 0)
      busy := false.B
      done := true.B
    }.otherwise {
      count := count + 1.U
    }
  }
}
