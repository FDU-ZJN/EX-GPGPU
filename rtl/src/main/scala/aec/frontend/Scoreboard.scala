package aec

import chisel3._
import chisel3.util._

/** Per-warp GPR/predicate dependency tracker, owned by one execution partition. */
class AecScoreboard extends Module {
  val io = IO(new Bundle {
    val sourceWarp = Input(UInt(3.W)); val source0 = Input(UInt(8.W)); val source1 = Input(UInt(8.W)); val source2 = Input(UInt(8.W))
    val source0Used = Input(Bool()); val source1Used = Input(Bool()); val source2Used = Input(Bool())
    val source0Pair = Input(Bool()); val source1Pair = Input(Bool()); val source2Pair = Input(Bool())
    val sourcePredicateUsed = Input(Bool()); val sourcePredicate = Input(UInt(3.W))
    val sourcesReady = Output(Bool())
    val reserve = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W) }))
    val release = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W) }))
    val destinationFree = Output(Bool())
  })
  // The scheduler admits one even/odd resident pair at a time and changes the
  // pair only after both ROBs drain.  Architectural warp bit 0 is therefore
  // the complete physical scoreboard slot identifier.
  private val bankCount = 16
  private val bankWidth = 16
  val gprBusy = RegInit(VecInit(Seq.fill(2)(VecInit(Seq.fill(bankCount)(0.U(bankWidth.W))))))
  val predBusy = RegInit(VecInit(Seq.fill(2)(0.U(8.W))))
  def slot(warp: UInt): UInt = warp(0)
  def bankOf(reg: UInt): UInt = reg(7, 4)
  def bitOf(reg: UInt): UInt = reg(3, 0)
  def gprBit(warp: UInt, reg: UInt): Bool = gprBusy(slot(warp))(bankOf(reg))(bitOf(reg))
  def sourceReady(reg: UInt, pair: Bool): Bool = !gprBit(io.sourceWarp, reg) && (!pair || !gprBit(io.sourceWarp, reg + 1.U))
  io.sourcesReady := (!io.source0Used || sourceReady(io.source0, io.source0Pair)) &&
    (!io.source1Used || sourceReady(io.source1, io.source1Pair)) &&
    (!io.source2Used || sourceReady(io.source2, io.source2Pair)) &&
    (!io.sourcePredicateUsed || !predBusy(slot(io.sourceWarp))(io.sourcePredicate))
  io.destinationFree := Mux(io.reserve.bits.predicate, !predBusy(slot(io.reserve.bits.warp))(io.reserve.bits.pred), !gprBit(io.reserve.bits.warp, io.reserve.bits.dest) && Mux(io.reserve.bits.destHi, !gprBit(io.reserve.bits.warp, io.reserve.bits.dest + 1.U), true.B))
  val reserveHigh = io.reserve.bits.dest + 1.U
  val releaseHigh = io.release.bits.dest + 1.U
  for (physicalSlot <- 0 until 2; bank <- 0 until bankCount) {
    val reserveSlot = slot(io.reserve.bits.warp) === physicalSlot.U
    val releaseSlot = slot(io.release.bits.warp) === physicalSlot.U
    val setMask = Mux(io.reserve.valid && !io.reserve.bits.predicate && reserveSlot &&
      bankOf(io.reserve.bits.dest) === bank.U, UIntToOH(bitOf(io.reserve.bits.dest), bankWidth), 0.U) |
      Mux(io.reserve.valid && !io.reserve.bits.predicate && io.reserve.bits.destHi && reserveSlot &&
        bankOf(reserveHigh) === bank.U, UIntToOH(bitOf(reserveHigh), bankWidth), 0.U)
    val clearMask = Mux(io.release.valid && !io.release.bits.predicate && releaseSlot &&
      bankOf(io.release.bits.dest) === bank.U, UIntToOH(bitOf(io.release.bits.dest), bankWidth), 0.U) |
      Mux(io.release.valid && !io.release.bits.predicate && io.release.bits.destHi && releaseSlot &&
        bankOf(releaseHigh) === bank.U, UIntToOH(bitOf(releaseHigh), bankWidth), 0.U)
    when (setMask.orR || clearMask.orR) {
      gprBusy(physicalSlot)(bank) := (gprBusy(physicalSlot)(bank) & ~clearMask) | setMask
    }
  }
  for (physicalSlot <- 0 until 2) {
    val setMask = Mux(io.reserve.valid && io.reserve.bits.predicate &&
      slot(io.reserve.bits.warp) === physicalSlot.U, UIntToOH(io.reserve.bits.pred, 8), 0.U)
    val clearMask = Mux(io.release.valid && io.release.bits.predicate &&
      slot(io.release.bits.warp) === physicalSlot.U, UIntToOH(io.release.bits.pred, 8), 0.U)
    when (setMask.orR || clearMask.orR) {
      predBusy(physicalSlot) := (predBusy(physicalSlot) & ~clearMask) | setMask
    }
  }
  assert(!(io.reserve.valid && !io.destinationFree), "scoreboard destination must be free before reserve")
  assert(!(io.reserve.valid && io.reserve.bits.destHi && io.reserve.bits.dest === 255.U),
    "paired destination must not wrap register 255")
}
