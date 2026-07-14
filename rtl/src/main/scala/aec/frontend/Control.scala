package aec

import chisel3._
import chisel3.util._

/** CTA barrier with required-set semantics. */
class AecCtaBarrier extends Module {
  val io = IO(new Bundle { val activeWarps = Input(UInt(8.W)); val arrive = Input(Vec(4, Valid(UInt(3.W)))); val completed = Input(UInt(8.W)); val release = Output(UInt(8.W)); val duplicate = Output(Bool()) })
  val inGeneration = RegInit(false.B); val required = RegInit(0.U(8.W)); val arrived = RegInit(0.U(8.W))
  val duplicate = WireDefault(false.B); val release = WireDefault(0.U(8.W))
  val arriveMask = VecInit((0 until 4).map(i => Mux(io.arrive(i).valid, UIntToOH(io.arrive(i).bits, 8), 0.U(8.W)))).reduce(_ | _)
  val validCount = PopCount(io.arrive.map(_.valid))
  val distinctCount = PopCount(arriveMask)
  when (arriveMask.orR) {
    val startRequired = io.activeWarps & ~io.completed
    val repeatedInBatch = distinctCount =/= validCount
    when (!inGeneration) {
      val next = arriveMask & startRequired
      required := startRequired; arrived := next; inGeneration := true.B
      duplicate := repeatedInBatch || (arriveMask & ~startRequired).orR
      when ((next & startRequired) === startRequired) { release := startRequired; inGeneration := false.B; arrived := 0.U }
    }.otherwise {
      val repeated = (arrived & arriveMask).orR || repeatedInBatch
      val next = arrived | (arriveMask & required)
      duplicate := repeated || (arriveMask & ~required).orR
      when (!repeated) {
        arrived := next
        when ((next & required) === required) { release := required; arrived := 0.U; inGeneration := false.B }
      }
    }
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
