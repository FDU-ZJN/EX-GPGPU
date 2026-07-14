package aec

import aec.fp._
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

/** Throughput contract for a physical FP lane.  Arithmetic and simple
  * operations may have different latency, but an unstalled lane must accept
  * one mixed ordinary operation every cycle.
  */
class FpInitiationIntervalSpec extends AnyFlatSpec with ChiselScalatestTester {
  private val mixedOps = Seq(1, 7, 3, 32, 5, 8, 9, 10, 40, 2)

  private def drive32(dut: AecFp32PipeUnit, index: Int): Unit = {
    dut.io.req.bits.op.poke(mixedOps(index % mixedOps.size).U)
    dut.io.req.bits.dtype.poke(8.U)
    dut.io.req.bits.a.poke("h000000003f800000".U)
    dut.io.req.bits.b.poke("h0000000040000000".U)
    dut.io.req.bits.c.poke("h000000003f000000".U)
    dut.io.req.bits.dest.poke((index & 0xff).U)
  }

  private def drive64(dut: AecFp64PipeUnit, index: Int): Unit = {
    dut.io.req.bits.op.poke(mixedOps(index % mixedOps.size).U)
    dut.io.req.bits.dtype.poke(9.U)
    dut.io.req.bits.a.poke("h3ff0000000000000".U)
    dut.io.req.bits.b.poke("h4000000000000000".U)
    dut.io.req.bits.c.poke("h3fe0000000000000".U)
    dut.io.req.bits.dest.poke((index & 0xff).U)
  }

  behavior of "AecFp32PipeUnit"
  it should "accept a mixed ordinary-operation stream with II=1" in {
    test(new AecFp32PipeUnit) { dut =>
      dut.io.req.valid.poke(false.B); dut.io.resp.ready.poke(true.B)
      dut.clock.step(2)
      dut.io.req.valid.poke(true.B)
      var sent = 0; var responses = 0; var cycles = 0; var stalls = 0
      while (sent < 256 && cycles < 1024) {
        drive32(dut, sent)
        if (dut.io.req.ready.peek().litToBoolean) sent += 1 else stalls += 1
        if (dut.io.resp.valid.peek().litToBoolean) responses += 1
        dut.clock.step(); cycles += 1
      }
      dut.io.req.valid.poke(false.B)
      while (responses < 256 && cycles < 1536) {
        if (dut.io.resp.valid.peek().litToBoolean) responses += 1
        dut.clock.step(); cycles += 1
      }
      assert(sent == 256, s"FP32 accepted only $sent/256 requests")
      assert(stalls == 0, s"FP32 inserted $stalls request stalls in $cycles cycles")
      assert(responses == 256, s"FP32 retired only $responses/256 requests")
    }
  }

  behavior of "AecFp64PipeUnit"
  it should "accept a mixed ordinary-operation stream with II=1" in {
    test(new AecFp64PipeUnit(false)) { dut =>
      dut.io.req.valid.poke(false.B); dut.io.resp.ready.poke(true.B)
      dut.clock.step(2)
      dut.io.req.valid.poke(true.B)
      var sent = 0; var responses = 0; var cycles = 0; var stalls = 0
      while (sent < 256 && cycles < 1024) {
        drive64(dut, sent)
        if (dut.io.req.ready.peek().litToBoolean) sent += 1 else stalls += 1
        if (dut.io.resp.valid.peek().litToBoolean) responses += 1
        dut.clock.step(); cycles += 1
      }
      dut.io.req.valid.poke(false.B)
      while (responses < 256 && cycles < 1536) {
        if (dut.io.resp.valid.peek().litToBoolean) responses += 1
        dut.clock.step(); cycles += 1
      }
      assert(sent == 256, s"FP64 accepted only $sent/256 requests")
      assert(stalls == 0, s"FP64 inserted $stalls request stalls in $cycles cycles")
      assert(responses == 256, s"FP64 retired only $responses/256 requests")
    }
  }
}
