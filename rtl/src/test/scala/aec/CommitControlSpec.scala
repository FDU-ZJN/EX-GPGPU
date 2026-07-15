package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CommitControlSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AecCommitSelector"

  private def setHead(dut: AecCommitSelector, index: Int, valid: Boolean,
                      warp: Int, writeHi: Boolean): Unit = {
    val head = dut.io.heads(index)
    head.valid.poke(valid.B)
    head.bits.tag.warp.poke(warp.U)
    head.bits.tag.epoch.poke(0.U)
    head.bits.tag.sequence.poke(0.U)
    head.bits.tag.robIndex.poke(0.U)
    head.bits.tag.pc.poke(0.U)
    head.bits.laneMask.poke(1.U)
    head.bits.dest.poke(0.U)
    head.bits.writesGpr.poke(true.B)
    head.bits.writeHi.poke(writeHi.B)
    head.bits.writesPredicate.poke(false.B)
    head.bits.predicate.poke(0.U)
    head.bits.serializing.poke(false.B)
    head.bits.predicateData.poke(0.U)
    head.bits.error.poke(false.B)
  }

  it should "lock a paired write to one warp and pop only after the high half" in {
    test(new AecCommitSelector) { dut =>
      dut.io.ready.poke(true.B)
      setHead(dut, 0, valid = true, warp = 0, writeHi = true)
      setHead(dut, 1, valid = true, warp = 1, writeHi = false)

      dut.io.select.expect(false.B)
      dut.io.finalCycle.expect(false.B)
      dut.io.pop(0).expect(false.B); dut.io.pop(1).expect(false.B)
      dut.clock.step()

      dut.io.select.expect(false.B)
      dut.io.pairHigh.expect(true.B)
      dut.io.finalCycle.expect(true.B)
      dut.io.pop(0).expect(true.B); dut.io.pop(1).expect(false.B)
      dut.clock.step()

      dut.io.select.expect(true.B)
      dut.io.finalCycle.expect(true.B)
      dut.io.pop(0).expect(false.B); dut.io.pop(1).expect(true.B)
    }
  }
}
