package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import aec.fp.{AESSFU, AecSfuWarpUnit}
import aec.int.AecIntDivider

class SfuSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {
  behavior of "AecIntDivider"

  it should "implement signed and unsigned AEC quotient semantics" in {
    test(new AecIntDivider) { dut =>
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(true.B)

      def divide(a: Long, b: Long, signed: Boolean): (Long, Boolean) = {
        while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
        dut.io.req.bits.dividend.poke((a & 0xffffffffL).U)
        dut.io.req.bits.divisor.poke((b & 0xffffffffL).U)
        dut.io.req.bits.signed.poke(signed.B)
        dut.io.req.valid.poke(true.B)
        dut.clock.step()
        dut.io.req.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.resp.valid.peek().litToBoolean && cycles < 40) { dut.clock.step(); cycles += 1 }
        cycles should be < 40
        val result = dut.io.resp.bits.quotient.peek().litValue.longValue & 0xffffffffL
        val error = dut.io.resp.bits.error.peek().litToBoolean
        dut.clock.step()
        (result, error)
      }

      divide(31, 3, signed = false) shouldBe (10L, false)
      divide(0xffffffffL, 2, signed = false) shouldBe (0x7fffffffL, false)
      divide(-31, 3, signed = true) shouldBe ((-10L) & 0xffffffffL, false)
      divide(0x80000000L, 0xffffffffL, signed = true) shouldBe (0x80000000L, false)
      divide(7, 0, signed = false)._2 shouldBe true
    }
  }

  behavior of "AESSFU"

  it should "execute scalar FP divide, reciprocal, sqrt and transcendental operations" in {
    test(new AESSFU) { dut =>
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(true.B)

      def bits(x: Float): Long = java.lang.Float.floatToRawIntBits(x).toLong & 0xffffffffL
      def run(op: UInt, a: Float, b: Float = 0.0f, dtype: Int = 8): Long = {
        while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
        dut.io.req.bits.op.poke(op)
        dut.io.req.bits.dtype.poke(dtype.U)
        dut.io.req.bits.mode.poke(1.U)
        dut.io.req.bits.a.poke(bits(a).U)
        dut.io.req.bits.b.poke(bits(b).U)
        dut.io.req.bits.dest.poke(3.U)
        dut.io.req.valid.poke(true.B)
        dut.clock.step()
        dut.io.req.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.resp.valid.peek().litToBoolean && cycles < 160) { dut.clock.step(); cycles += 1 }
        cycles should be < 160
        dut.io.resp.bits.error.expect(false.B)
        val out = dut.io.resp.bits.result.peek().litValue.longValue & 0xffffffffL
        dut.clock.step()
        out
      }

      run(AecOpcode.div, 7.0f, 2.0f) shouldBe bits(3.5f)
      run(AecOpcode.rcp, 4.0f) shouldBe bits(0.25f)
      run(AecOpcode.sqrt, 9.0f) shouldBe bits(3.0f)
      java.lang.Float.intBitsToFloat(run(AecOpcode.sin, 0.5f).toInt) shouldBe (math.sin(0.5).toFloat +- 2.0e-5f)
      java.lang.Float.intBitsToFloat(run(AecOpcode.exp, 3.0f).toInt) shouldBe (8.0f +- 2.0e-4f)
      java.lang.Float.intBitsToFloat(run(AecOpcode.log, 8.0f).toInt) shouldBe (3.0f +- 2.0e-4f)
    }
  }

  behavior of "AecSfuWarpUnit"

  it should "sequence all 32 lanes through two physical divider lanes" in {
    test(new AecSfuWarpUnit(2)) { dut =>
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(true.B)
      dut.io.mode.poke(0.U)
      while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
      dut.io.req.bits.op.poke(AecOpcode.div)
      dut.io.req.bits.dtype.poke(2.U)
      dut.io.req.bits.activeMask.poke("hffffffff".U)
      dut.io.req.bits.dest.poke(4.U)
      dut.io.req.bits.predicateSelect.poke(0.U)
      dut.io.req.bits.predicateValues.poke(0.U)
      for (lane <- 0 until 32) {
        dut.io.req.bits.a(lane).poke((lane * 9 + 1).U)
        dut.io.req.bits.b(lane).poke(3.U)
        dut.io.req.bits.c(lane).poke(0.U)
      }
      dut.io.req.valid.poke(true.B)
      dut.clock.step()
      dut.io.req.valid.poke(false.B)
      var cycles = 0
      while (!dut.io.resp.valid.peek().litToBoolean && cycles < 700) { dut.clock.step(); cycles += 1 }
      cycles should be < 700
      dut.io.resp.bits.errorMask.expect(0.U)
      for (lane <- 0 until 32) dut.io.resp.bits.result(lane).expect(((lane * 9 + 1) / 3).U)
    }
  }
}
