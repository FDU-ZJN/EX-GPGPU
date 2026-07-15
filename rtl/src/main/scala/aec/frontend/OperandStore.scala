package aec

import chisel3._
import chisel3.util._

/** Partition-local operand capture. The register-bank response has one wide
  * write port and a narrow slot selector instead of six top-level enables. */
class AecOperandStore extends Module {
  val io = IO(new Bundle {
    val capture = Flipped(Valid(new Bundle {
      val slot = UInt(3.W)
      val data = Vec(32, UInt(32.W))
    }))
    val a = Output(Vec(32, UInt(32.W)))
    val b = Output(Vec(32, UInt(32.W)))
    val c = Output(Vec(32, UInt(32.W)))
    val aHi = Output(Vec(32, UInt(32.W)))
    val bHi = Output(Vec(32, UInt(32.W)))
    val cHi = Output(Vec(32, UInt(32.W)))
  })

  val operands = Reg(Vec(6, Vec(32, UInt(32.W))))
  when (io.capture.valid) { operands(io.capture.bits.slot) := io.capture.bits.data }
  io.a := operands(0); io.b := operands(1); io.c := operands(2)
  io.aHi := operands(3); io.bHi := operands(4); io.cHi := operands(5)
}
