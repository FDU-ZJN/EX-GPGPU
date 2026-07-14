package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class WarpLatencyHidingSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AecWarpRob"

  private def clearCompletion(dut: AecWarpRob): Unit = {
    dut.io.completion.valid.poke(false.B)
    dut.io.completion.bits.tag.warp.poke(0.U)
    dut.io.completion.bits.tag.epoch.poke(0.U)
    dut.io.completion.bits.tag.sequence.poke(0.U)
    dut.io.completion.bits.tag.robIndex.poke(0.U)
    dut.io.completion.bits.tag.pc.poke(0.U)
    dut.io.completion.bits.predicateData.poke(0.U)
    dut.io.completion.bits.error.poke(false.B)
    for (lane <- 0 until 32) dut.io.completion.bits.data(lane).poke(0.U)
  }

  private def allocate(dut: AecWarpRob, pc: Int, dest: Int): (BigInt, BigInt) = {
    dut.io.allocate.bits.epoch.poke(3.U)
    dut.io.allocate.bits.pc.poke(pc.U)
    dut.io.allocate.bits.instruction.poke((BigInt(pc) << 112).U)
    dut.io.allocate.bits.laneMask.poke("hffffffff".U)
    dut.io.allocate.bits.dest.poke(dest.U)
    dut.io.allocate.bits.writesGpr.poke(true.B)
    dut.io.allocate.bits.writeHi.poke(false.B)
    dut.io.allocate.bits.writesPredicate.poke(false.B)
    dut.io.allocate.bits.predicate.poke(0.U)
    dut.io.allocate.bits.serializing.poke(false.B)
    dut.io.allocate.valid.poke(true.B)
    while (!dut.io.allocate.ready.peek().litToBoolean) dut.clock.step()
    val seq = dut.io.allocatedTag.sequence.peek().litValue
    val index = dut.io.allocatedTag.robIndex.peek().litValue
    dut.clock.step()
    dut.io.allocate.valid.poke(false.B)
    (seq, index)
  }

  private def complete(dut: AecWarpRob, pc: Int, seq: BigInt, index: BigInt, value: Int): Unit = {
    dut.io.completion.bits.tag.warp.poke(0.U)
    dut.io.completion.bits.tag.epoch.poke(3.U)
    dut.io.completion.bits.tag.sequence.poke(seq.U)
    dut.io.completion.bits.tag.robIndex.poke(index.U)
    dut.io.completion.bits.tag.pc.poke(pc.U)
    dut.io.completion.bits.predicateData.poke(0.U)
    dut.io.completion.bits.error.poke(false.B)
    for (lane <- 0 until 32) dut.io.completion.bits.data(lane).poke((value + lane).U)
    dut.io.completion.valid.poke(true.B)
    dut.clock.step()
    dut.io.completion.valid.poke(false.B)
  }

  it should "accept out-of-order completion and expose only the oldest ready entry" in {
    test(new AecWarpRob(0)) { dut =>
      dut.io.allocate.valid.poke(false.B)
      dut.io.pop.poke(false.B)
      dut.io.flush.poke(false.B)
      clearCompletion(dut)
      val first = allocate(dut, 10, 4)
      val second = allocate(dut, 11, 5)

      complete(dut, 11, second._1, second._2, 200)
      dut.io.head.valid.expect(false.B)
      complete(dut, 10, first._1, first._2, 100)
      dut.io.head.valid.expect(true.B)
      dut.io.head.bits.tag.pc.expect(10.U)
      dut.io.head.bits.data(7).expect(107.U)

      dut.io.pop.poke(true.B); dut.clock.step(); dut.io.pop.poke(false.B)
      dut.io.head.valid.expect(true.B)
      dut.io.head.bits.tag.pc.expect(11.U)
      dut.io.head.bits.data(7).expect(207.U)
    }
  }

  it should "drop stale epoch completion without making the head ready" in {
    test(new AecWarpRob(0)) { dut =>
      dut.io.allocate.valid.poke(false.B); dut.io.pop.poke(false.B); dut.io.flush.poke(false.B)
      clearCompletion(dut)
      val tag = allocate(dut, 20, 8)
      dut.io.completion.bits.tag.warp.poke(0.U)
      dut.io.completion.bits.tag.epoch.poke(2.U)
      dut.io.completion.bits.tag.sequence.poke(tag._1.U)
      dut.io.completion.bits.tag.robIndex.poke(tag._2.U)
      dut.io.completion.bits.tag.pc.poke(20.U)
      dut.io.completion.valid.poke(true.B)
      dut.io.staleCompletion.expect(true.B)
      dut.clock.step(); dut.io.completion.valid.poke(false.B)
      dut.io.head.valid.expect(false.B)
    }
  }

  it should "apply source-use masks without creating false RAW dependencies" in {
    test(new AecScoreboard) { dut =>
      dut.io.reserve.valid.poke(false.B); dut.io.release.valid.poke(false.B)
      dut.io.sourceWarp.poke(0.U)
      dut.io.source0.poke(5.U); dut.io.source1.poke(0.U); dut.io.source2.poke(0.U)
      dut.io.source0Pair.poke(false.B); dut.io.source1Pair.poke(false.B); dut.io.source2Pair.poke(false.B)
      dut.io.source0Used.poke(false.B); dut.io.source1Used.poke(false.B); dut.io.source2Used.poke(false.B)
      dut.io.sourcePredicateUsed.poke(false.B); dut.io.sourcePredicate.poke(0.U)
      dut.io.reserve.bits.warp.poke(0.U); dut.io.reserve.bits.dest.poke(5.U)
      dut.io.reserve.bits.destHi.poke(false.B); dut.io.reserve.bits.predicate.poke(false.B); dut.io.reserve.bits.pred.poke(0.U)
      dut.io.release.bits.warp.poke(0.U); dut.io.release.bits.dest.poke(5.U)
      dut.io.release.bits.destHi.poke(false.B); dut.io.release.bits.predicate.poke(false.B); dut.io.release.bits.pred.poke(0.U)
      dut.io.reserve.valid.poke(true.B); dut.clock.step(); dut.io.reserve.valid.poke(false.B)

      dut.io.source0Used.poke(false.B); dut.io.sourcesReady.expect(true.B)
      dut.io.source0Used.poke(true.B); dut.io.sourcesReady.expect(false.B)
      dut.io.release.valid.poke(true.B); dut.clock.step(); dut.io.release.valid.poke(false.B)
      dut.io.sourcesReady.expect(true.B)
    }
  }
}
