package aec

import chisel3._
import chisel3.util.Valid

/** Per-warp GPR/predicate dependency tracker, owned by one execution partition. */
class AecScoreboard extends Module {
  val io = IO(new Bundle {
    val sourceWarp = Input(UInt(3.W)); val source0 = Input(UInt(8.W)); val source1 = Input(UInt(8.W)); val source2 = Input(UInt(8.W))
    val source0Pair = Input(Bool()); val source1Pair = Input(Bool()); val source2Pair = Input(Bool())
    val sourcesReady = Output(Bool())
    val reserve = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W) }))
    val release = Input(Valid(new Bundle { val warp = UInt(3.W); val dest = UInt(8.W); val destHi = Bool(); val predicate = Bool(); val pred = UInt(3.W) }))
    val destinationFree = Output(Bool())
  })
  val gprBusy = RegInit(VecInit(Seq.fill(8)(0.U(256.W))))
  val predBusy = RegInit(VecInit(Seq.fill(8)(0.U(8.W))))
  def gprBit(warp: UInt, reg: UInt): Bool = gprBusy(warp)(reg)
  def sourceReady(reg: UInt, pair: Bool): Bool = !gprBit(io.sourceWarp, reg) && (!pair || !gprBit(io.sourceWarp, reg + 1.U))
  io.sourcesReady := sourceReady(io.source0, io.source0Pair) && sourceReady(io.source1, io.source1Pair) && sourceReady(io.source2, io.source2Pair)
  io.destinationFree := Mux(io.reserve.bits.predicate, !predBusy(io.reserve.bits.warp)(io.reserve.bits.pred), !gprBit(io.reserve.bits.warp, io.reserve.bits.dest) && Mux(io.reserve.bits.destHi, !gprBit(io.reserve.bits.warp, io.reserve.bits.dest + 1.U), true.B))
  when (io.reserve.valid && io.destinationFree) {
    when (io.reserve.bits.predicate) { predBusy(io.reserve.bits.warp) := predBusy(io.reserve.bits.warp) | (1.U(8.W) << io.reserve.bits.pred) }
      .otherwise { gprBusy(io.reserve.bits.warp) := gprBusy(io.reserve.bits.warp) | (1.U(256.W) << io.reserve.bits.dest); when (io.reserve.bits.destHi) { gprBusy(io.reserve.bits.warp) := gprBusy(io.reserve.bits.warp) | (3.U(256.W) << io.reserve.bits.dest) } }
  }
  when (io.release.valid) {
    when (io.release.bits.predicate) { predBusy(io.release.bits.warp) := predBusy(io.release.bits.warp) & ~(1.U(8.W) << io.release.bits.pred) }
      .otherwise { gprBusy(io.release.bits.warp) := gprBusy(io.release.bits.warp) & ~(1.U(256.W) << io.release.bits.dest); when (io.release.bits.destHi) { gprBusy(io.release.bits.warp) := gprBusy(io.release.bits.warp) & ~(3.U(256.W) << io.release.bits.dest) } }
  }
}
