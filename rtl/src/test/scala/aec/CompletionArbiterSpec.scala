package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CompletionArbiterSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AecCompletionArbiter"

  it should "hold a completion under backpressure and pipeline replacement" in {
    test(new AecCompletionArbiter(4)) { dut =>
      dut.io.out.ready.poke(false.B)
      for (source <- 0 until 4) {
        dut.io.in(source).valid.poke(false.B)
        dut.io.in(source).bits.tag.warp.poke(0.U)
        dut.io.in(source).bits.tag.epoch.poke(0.U)
        dut.io.in(source).bits.tag.sequence.poke(0.U)
        dut.io.in(source).bits.tag.robIndex.poke(0.U)
        dut.io.in(source).bits.tag.pc.poke(0.U)
        dut.io.in(source).bits.data.foreach(_.poke(0.U))
        dut.io.in(source).bits.predicateData.poke(0.U)
        dut.io.in(source).bits.error.poke(false.B)
      }

      dut.io.in(2).valid.poke(true.B)
      dut.io.in(2).bits.tag.sequence.poke(12.U)
      dut.io.in(2).bits.data(0).poke("haa".U)
      dut.io.in(2).ready.expect(false.B)
      dut.clock.step()
      dut.io.in(2).ready.expect(true.B)
      dut.clock.step()
      dut.io.in(2).valid.poke(false.B)

      dut.io.out.valid.expect(true.B)
      dut.io.out.bits.tag.sequence.expect(12.U)
      dut.io.out.bits.data(0).expect("haa".U)
      dut.clock.step(2)
      dut.io.out.bits.tag.sequence.expect(12.U)
      dut.io.out.bits.data(0).expect("haa".U)

      dut.io.in(1).valid.poke(true.B)
      dut.io.in(1).bits.tag.sequence.poke(21.U)
      dut.io.in(1).bits.data(0).poke("hbb".U)
      dut.io.out.ready.poke(true.B)
      dut.io.in(1).ready.expect(false.B)
      dut.clock.step()
      dut.io.in(1).ready.expect(true.B)
      dut.clock.step()
      dut.io.in(1).valid.poke(false.B)

      dut.io.out.valid.expect(true.B)
      dut.io.out.bits.tag.sequence.expect(21.U)
      dut.io.out.bits.data(0).expect("hbb".U)
      dut.clock.step()
      dut.io.out.valid.expect(false.B)
    }
  }
}
