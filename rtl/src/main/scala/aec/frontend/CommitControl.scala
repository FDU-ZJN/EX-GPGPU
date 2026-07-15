package aec

import chisel3._
import chisel3.util._

/** Selects and retires one of the two warp ROB heads owned by a scheduler
  * partition. A paired 64-bit write remains locked to the same warp until its
  * high half retires. */
class AecCommitSelector extends Module {
  val io = IO(new Bundle {
    val heads = Input(Vec(2, Valid(new AecRobHead)))
    val select = Output(Bool())
    val head = Output(new AecRobHead)
    val valid = Output(Bool())
    val ready = Input(Bool())
    val finalCycle = Output(Bool())
    val pairHigh = Output(Bool())
    val pop = Output(Vec(2, Bool()))
  })

  val rr = RegInit(false.B)
  val pairHigh = RegInit(false.B)
  val lockedWarp = Reg(Bool())
  val selected = Mux(pairHigh, lockedWarp,
    Mux(rr, Mux(io.heads(1).valid, true.B, false.B),
      Mux(io.heads(0).valid, false.B, true.B)))
  val head = Mux(selected, io.heads(1).bits, io.heads(0).bits)
  val valid = Mux(selected, io.heads(1).valid, io.heads(0).valid)
  val accepted = valid && io.ready
  val finalCycle = accepted && (!head.writeHi || pairHigh)

  io.select := selected
  io.head := head
  io.valid := valid
  io.finalCycle := finalCycle
  io.pairHigh := pairHigh
  io.pop := VecInit(Seq.fill(2)(false.B))

  when (accepted && head.writeHi && !pairHigh && !head.error) {
    pairHigh := true.B
    lockedWarp := selected
  }.elsewhen (finalCycle) {
    pairHigh := false.B
    rr := !selected
    when (!head.error) { io.pop(selected) := true.B }
  }
}
