package aec

import chisel3._
import chisel3.util._

/** CTA barrier with required-set semantics. */
class AecCtaBarrier extends Module {
  val io = IO(new Bundle { val activeWarps = Input(UInt(8.W)); val arrive = Input(Valid(UInt(3.W))); val completed = Input(UInt(8.W)); val release = Output(UInt(8.W)); val duplicate = Output(Bool()) })
  val inGeneration = RegInit(false.B); val required = RegInit(0.U(8.W)); val arrived = RegInit(0.U(8.W))
  val duplicate = WireDefault(false.B); val release = WireDefault(0.U(8.W))
  when (io.arrive.valid) {
    val bit = UIntToOH(io.arrive.bits, 8); val startRequired = io.activeWarps & ~io.completed
    when (!inGeneration) { required := startRequired; arrived := bit; inGeneration := true.B; when (startRequired === bit) { release := bit; inGeneration := false.B; arrived := 0.U } }
      .elsewhen ((arrived & bit).orR) { duplicate := true.B }
      .otherwise { val next = arrived | bit; arrived := next; when ((next & required) === required) { release := required; arrived := 0.U; inGeneration := false.B } }
  }
  io.release := release; io.duplicate := duplicate
}

/** Four round-robin selectors; each owns its fixed pair of warps. */
class AecWarpSchedulers extends Module {
  val io = IO(new Bundle { val runnable = Input(UInt(8.W)); val accept = Input(UInt(4.W)); val valid = Output(UInt(4.W)); val warp = Output(Vec(4, UInt(3.W))) })
  val preferHigh = RegInit(VecInit(Seq.fill(4)(false.B))); val valid = Wire(Vec(4, Bool()))
  for (p <- 0 until 4) {
    val lo = p * 2; val hi = lo + 1; valid(p) := io.runnable(lo) || io.runnable(hi)
    io.warp(p) := Mux(preferHigh(p), Mux(io.runnable(hi), hi.U, lo.U), Mux(io.runnable(lo), lo.U, hi.U))
    when (io.accept(p) && valid(p)) { preferHigh(p) := !preferHigh(p) }
  }
  io.valid := valid.asUInt
}
