package aec

import chisel3._
import chisel3.util.Valid

/**
  * Per-warp, per-lane GPR/predicate dependency tracker, owned by one execution
  * partition.  A busy entry is a 32-bit lane mask rather than one bit: a
  * predicated producer only blocks consumers (and later writers) in lanes it
  * will actually update.
  */
class AecScoreboard extends Module {
  val io = IO(new Bundle {
    val sourceWarp = Input(UInt(3.W)); val source0 = Input(UInt(8.W)); val source1 = Input(UInt(8.W)); val source2 = Input(UInt(8.W))
    val source0Used = Input(Bool()); val source1Used = Input(Bool()); val source2Used = Input(Bool())
    val source0Pair = Input(Bool()); val source1Pair = Input(Bool()); val source2Pair = Input(Bool())
    val sourceMask = Input(UInt(32.W))
    val sourcePredicateUsed = Input(Bool()); val sourcePredicate = Input(UInt(3.W)); val sourcePredicateMask = Input(UInt(32.W))
    val sourcesReady = Output(Bool())
    val reserve = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W); val laneMask = UInt(32.W) }))
    val release = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W); val laneMask = UInt(32.W) }))
    val destinationFree = Output(Bool())
  })
  val gprBusy = RegInit(VecInit(Seq.fill(8)(VecInit(Seq.fill(256)(0.U(32.W))))))
  val predBusy = RegInit(VecInit(Seq.fill(8)(VecInit(Seq.fill(8)(0.U(32.W))))))
  def gprMask(warp: UInt, reg: UInt): UInt = gprBusy(warp)(reg)
  def maskFree(busy: UInt, lanes: UInt): Bool = !(busy & lanes).orR
  def sourceReady(reg: UInt, pair: Bool): Bool =
    maskFree(gprMask(io.sourceWarp, reg), io.sourceMask) &&
      (!pair || maskFree(gprMask(io.sourceWarp, reg + 1.U), io.sourceMask))
  val predicateReady = !io.sourcePredicateUsed ||
    maskFree(predBusy(io.sourceWarp)(io.sourcePredicate), io.sourcePredicateMask)
  io.sourcesReady := (!io.source0Used || sourceReady(io.source0, io.source0Pair)) &&
    (!io.source1Used || sourceReady(io.source1, io.source1Pair)) &&
    (!io.source2Used || sourceReady(io.source2, io.source2Pair)) && predicateReady
  io.destinationFree := Mux(io.reserve.bits.predicate,
    maskFree(predBusy(io.reserve.bits.warp)(io.reserve.bits.pred), io.reserve.bits.laneMask),
    maskFree(gprMask(io.reserve.bits.warp, io.reserve.bits.dest), io.reserve.bits.laneMask) &&
      Mux(io.reserve.bits.destHi, maskFree(gprMask(io.reserve.bits.warp, io.reserve.bits.dest + 1.U), io.reserve.bits.laneMask), true.B))
  when (io.reserve.valid && io.destinationFree) {
    when (io.reserve.bits.predicate) { predBusy(io.reserve.bits.warp)(io.reserve.bits.pred) := predBusy(io.reserve.bits.warp)(io.reserve.bits.pred) | io.reserve.bits.laneMask }
      .otherwise {
        gprBusy(io.reserve.bits.warp)(io.reserve.bits.dest) := gprMask(io.reserve.bits.warp, io.reserve.bits.dest) | io.reserve.bits.laneMask
        when (io.reserve.bits.destHi) { gprBusy(io.reserve.bits.warp)(io.reserve.bits.dest + 1.U) := gprMask(io.reserve.bits.warp, io.reserve.bits.dest + 1.U) | io.reserve.bits.laneMask }
      }
  }
  when (io.release.valid) {
    when (io.release.bits.predicate) { predBusy(io.release.bits.warp)(io.release.bits.pred) := predBusy(io.release.bits.warp)(io.release.bits.pred) & ~io.release.bits.laneMask }
      .otherwise {
        gprBusy(io.release.bits.warp)(io.release.bits.dest) := gprMask(io.release.bits.warp, io.release.bits.dest) & ~io.release.bits.laneMask
        when (io.release.bits.destHi) { gprBusy(io.release.bits.warp)(io.release.bits.dest + 1.U) := gprMask(io.release.bits.warp, io.release.bits.dest + 1.U) & ~io.release.bits.laneMask }
      }
  }
  assert(!(io.reserve.valid && !io.destinationFree), "scoreboard destination must be free before reserve")
}
