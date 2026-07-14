package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class QaComplianceSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Track-2 external-memory QA"

  it should "hold every request payload stable while the service applies backpressure" in {
    test(new AecExternalMemoryEngine) { dut =>
      dut.io.lineIn.valid.poke(false.B)
      dut.io.lineComplete.ready.poke(true.B)
      dut.io.memReqReady.poke(false.B)
      dut.io.memRspValid.poke(false.B)
      dut.io.memRspTag.poke(0.U); dut.io.memRspRdata.poke(0.U); dut.io.memRspError.poke(false.B)

      dut.io.lineIn.bits.space.poke(true.B)
      dut.io.lineIn.bits.warp.poke(5.U)
      dut.io.lineIn.bits.write.poke(true.B)
      dut.io.lineIn.bits.address.poke("h12345680".U)
      dut.io.lineIn.bits.wdata.poke((BigInt(1) << 1023).U)
      dut.io.lineIn.bits.wstrb.poke("h80000000000000000000000000000001".U)
      dut.io.lineIn.bits.lastForInstruction.poke(true.B)
      dut.io.lineIn.valid.poke(true.B)
      dut.clock.step()
      dut.io.lineIn.valid.poke(false.B)

      for (_ <- 0 until 4) {
        dut.io.memReqValid.expect(true.B)
        dut.io.memReqSpace.expect(true.B)
        dut.io.memReqWrite.expect(true.B)
        dut.io.memReqAddr.expect("h12345680".U)
        dut.io.memReqWdata.expect((BigInt(1) << 1023).U)
        dut.io.memReqWstrb.expect("h80000000000000000000000000000001".U)
        dut.io.memReqTag.expect(0.U)
        dut.io.outstanding.expect(1.U)
        dut.clock.step()
      }
      dut.io.memReqReady.poke(true.B)
      dut.clock.step()
      dut.io.memReqValid.expect(false.B)
      dut.io.outstanding.expect(1.U)

      dut.io.memRspValid.poke(true.B); dut.io.memRspTag.poke(0.U)
      dut.io.lineComplete.valid.expect(true.B)
      dut.io.lineComplete.bits.space.expect(true.B)
      dut.io.lineComplete.bits.warp.expect(5.U)
      dut.clock.step()
      dut.io.outstanding.expect(0.U)
    }
  }

  it should "map adjacent LMEM lanes to distinct 4 KiB regions and reject thread-local overflow" in {
    test(new AecGmemLsu(2)) { dut =>
      dut.io.start.valid.poke(false.B); dut.io.lineOut.ready.poke(true.B)
      dut.io.lineComplete.valid.poke(false.B); dut.io.done.ready.poke(true.B)

      def setStart(offset0: Int, offset1: Int, mask: Int): Unit = {
        dut.io.start.bits.space.poke(true.B); dut.io.start.bits.ctaThreadBase.poke(30.U)
        dut.io.start.bits.warp.poke(1.U); dut.io.start.bits.load.poke(true.B)
        dut.io.start.bits.width64.poke(false.B); dut.io.start.bits.mask.poke(mask.U)
        dut.io.start.bits.atomic.poke(false.B); dut.io.start.bits.atomicOp.poke(0.U)
        dut.io.start.bits.signed.poke(false.B)
        for (lane <- 0 until 32) {
          dut.io.start.bits.address(lane).poke((if (lane == 0) offset0 else if (lane == 1) offset1 else 0).U)
          dut.io.start.bits.storeData(lane).poke(0.U); dut.io.start.bits.compareData(lane).poke(0.U)
        }
      }
      def completeRead(): Unit = {
        dut.io.lineComplete.bits.space.poke(true.B); dut.io.lineComplete.bits.warp.poke(1.U)
        dut.io.lineComplete.bits.tag.poke(0.U); dut.io.lineComplete.bits.write.poke(false.B)
        dut.io.lineComplete.bits.lastForInstruction.poke(false.B); dut.io.lineComplete.bits.rdata.poke(0.U)
        dut.io.lineComplete.bits.error.poke(false.B); dut.io.lineComplete.valid.poke(true.B)
        dut.clock.step(); dut.io.lineComplete.valid.poke(false.B)
      }

      setStart(124, 124, 3); dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
      dut.io.lineOut.valid.expect(true.B); dut.io.lineOut.bits.space.expect(true.B)
      dut.io.lineOut.bits.address.expect((62 * 4096).U); dut.clock.step(); completeRead()
      dut.io.lineOut.valid.expect(true.B); dut.io.lineOut.bits.address.expect((63 * 4096).U)
      dut.clock.step(); completeRead()
      dut.io.done.valid.expect(true.B); dut.io.done.bits.error.expect(false.B)
      dut.clock.step()

      setStart(4093, 0, 1); dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
      dut.io.done.valid.expect(true.B); dut.io.done.bits.error.expect(true.B)
      dut.io.lineOut.valid.expect(false.B)
    }
  }

  behavior of "Track-2 atomic QA"

  private def initializeAtomic(dut: AecGmemLsu, op: Int, signed: Boolean,
                               compare0: Long, compare1: Long, update0: Long, update1: Long): Unit = {
    dut.io.start.bits.space.poke(false.B); dut.io.start.bits.ctaThreadBase.poke(0.U)
    dut.io.start.bits.warp.poke(0.U); dut.io.start.bits.load.poke(false.B)
    dut.io.start.bits.width64.poke(false.B); dut.io.start.bits.mask.poke(3.U)
    dut.io.start.bits.atomic.poke(true.B); dut.io.start.bits.atomicOp.poke(op.U)
    dut.io.start.bits.signed.poke(signed.B)
    for (lane <- 0 until 32) {
      dut.io.start.bits.address(lane).poke((lane * 4).U)
      dut.io.start.bits.storeData(lane).poke((if (lane == 0) update0 else if (lane == 1) update1 else 0).U)
      dut.io.start.bits.compareData(lane).poke((if (lane == 0) compare0 else if (lane == 1) compare1 else 0).U)
    }
  }

  private def respond(dut: AecGmemLsu, line: BigInt, write: Boolean = false): Unit = {
    dut.io.lineComplete.bits.space.poke(false.B); dut.io.lineComplete.bits.warp.poke(0.U)
    dut.io.lineComplete.bits.tag.poke(0.U); dut.io.lineComplete.bits.write.poke(write.B)
    dut.io.lineComplete.bits.lastForInstruction.poke(false.B); dut.io.lineComplete.bits.rdata.poke(line.U)
    dut.io.lineComplete.bits.error.poke(false.B); dut.io.lineComplete.valid.poke(true.B)
    dut.clock.step(); dut.io.lineComplete.valid.poke(false.B)
  }

  private def waitForLineRequest(dut: AecGmemLsu, limit: Int = 40): Unit = {
    var cycles = 0
    while (!dut.io.lineOut.valid.peek().litToBoolean && cycles < limit) {
      dut.clock.step()
      cycles += 1
    }
    assert(cycles < limit, "timed out waiting for GMEM line request")
  }

  private def waitForDone(dut: AecGmemLsu, limit: Int = 40): Unit = {
    var cycles = 0
    while (!dut.io.done.valid.peek().litToBoolean && cycles < limit) {
      dut.clock.step()
      cycles += 1
    }
    assert(cycles < limit, "timed out waiting for GMEM completion")
  }

  it should "encode MAX as 1 and MIN as 2 for signed and unsigned words" in {
    def run(op: Int, signed: Boolean): (Long, Long) = {
      var result = (0L, 0L)
      test(new AecGmemLsu(2)) { dut =>
        dut.io.start.valid.poke(false.B); dut.io.lineOut.ready.poke(true.B)
        dut.io.lineComplete.valid.poke(false.B); dut.io.done.ready.poke(true.B)
        initializeAtomic(dut, op, signed, 0, 0, 1, 1)
        dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
        dut.clock.step(); respond(dut, 0) // preflight
        dut.clock.step()
        val input = BigInt("0000000180000000", 16)
        respond(dut, input) // RMW read
        waitForLineRequest(dut)
        dut.io.lineOut.valid.expect(true.B); dut.io.lineOut.bits.write.expect(true.B)
        val words = dut.io.lineOut.bits.wdata.peek().litValue
        result = ((words & 0xffffffffL).longValue, ((words >> 32) & 0xffffffffL).longValue)
      }
      result
    }
    assert(run(AecAtomicOp.max.litValue.toInt, signed = false) == (0x80000000L, 1L))
    assert(run(AecAtomicOp.min.litValue.toInt, signed = false) == (1L, 1L))
    assert(run(AecAtomicOp.max.litValue.toInt, signed = true) == (1L, 1L))
    assert(run(AecAtomicOp.min.litValue.toInt, signed = true) == (0x80000000L, 1L))
  }

  it should "suppress failed CAS writes and strobe only successful lanes" in {
    test(new AecGmemLsu(2)) { dut =>
      dut.io.start.valid.poke(false.B); dut.io.lineOut.ready.poke(true.B)
      dut.io.lineComplete.valid.poke(false.B); dut.io.done.ready.poke(true.B)

      def begin(compare0: Long, compare1: Long): Unit = {
        initializeAtomic(dut, AecAtomicOp.cas.litValue.toInt, signed = false, compare0, compare1, 9, 10)
        dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
        dut.clock.step(); respond(dut, 2L | (3L << 32)) // preflight
        dut.clock.step(); respond(dut, 2L | (3L << 32)) // RMW read
      }

      begin(2, 99)
      waitForLineRequest(dut)
      dut.io.lineOut.valid.expect(true.B); dut.io.lineOut.bits.write.expect(true.B)
      dut.io.lineOut.bits.wstrb.expect("hf".U)
      dut.io.lineOut.bits.wdata.expect((9L | (3L << 32)).U)
      dut.clock.step(); respond(dut, 0, write = true)
      dut.io.done.valid.expect(true.B); dut.clock.step()

      begin(98, 99)
      waitForDone(dut)
      dut.io.done.valid.expect(true.B)
      dut.io.lineOut.valid.expect(false.B)
      dut.io.done.bits.loadData(0).expect(2.U); dut.io.done.bits.loadData(1).expect(3.U)
    }
  }

  it should "apply same-word atomic lanes in ascending lane order" in {
    test(new AecGmemLsu(2)) { dut =>
      dut.io.start.valid.poke(false.B); dut.io.lineOut.ready.poke(true.B)
      dut.io.lineComplete.valid.poke(false.B); dut.io.done.ready.poke(true.B)
      initializeAtomic(dut, AecAtomicOp.add.litValue.toInt, signed = false, 0, 0, 1, 2)
      dut.io.start.bits.address(1).poke(0.U)
      dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
      dut.clock.step(); respond(dut, 5) // preflight
      dut.clock.step(); respond(dut, 5) // RMW read
      waitForLineRequest(dut)
      dut.io.lineOut.bits.write.expect(true.B)
      assert((dut.io.lineOut.bits.wdata.peek().litValue & 0xffffffffL) == 8)
      dut.io.lineOut.bits.wstrb.expect("hf".U)
      dut.clock.step(); respond(dut, 0, write = true)
      dut.io.done.bits.loadData(0).expect(5.U)
      dut.io.done.bits.loadData(1).expect(6.U)
    }
  }

  behavior of "Track-2 resident-memory capacity QA"

  it should "treat zero capacity as out of bounds and sparse preload holes as addressable" in {
    test(new AecLocalLsu) { dut =>
      dut.io.start.valid.poke(false.B); dut.io.done.ready.poke(true.B)
      dut.io.clearSmem.poke(false.B); dut.io.preload.valid.poke(false.B)

      def load(address: Int): Boolean = {
        dut.io.start.bits.warp.poke(0.U); dut.io.start.bits.space.poke(AecMemorySpace.cmem)
        dut.io.start.bits.load.poke(true.B); dut.io.start.bits.width64.poke(false.B)
        dut.io.start.bits.mask.poke(1.U); dut.io.start.bits.atomic.poke(false.B)
        dut.io.start.bits.atomicOp.poke(0.U); dut.io.start.bits.signed.poke(false.B)
        for (lane <- 0 until 32) {
          dut.io.start.bits.address(lane).poke((if (lane == 0) address else 0).U)
          dut.io.start.bits.storeData(lane).poke(0.U); dut.io.start.bits.compareData(lane).poke(0.U)
        }
        dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.done.valid.peek().litToBoolean && cycles < 50) { dut.clock.step(); cycles += 1 }
        assert(cycles < 50)
        val failed = dut.io.done.bits.error.peek().litToBoolean
        dut.clock.step(); failed
      }

      assert(load(0))
      dut.io.preload.bits.pmem.poke(false.B); dut.io.preload.bits.address.poke(0x100.U)
      dut.io.preload.bits.data.poke("haa".U); dut.io.preload.bits.mask.poke(1.U)
      dut.io.preload.valid.poke(true.B); dut.clock.step(); dut.io.preload.valid.poke(false.B)
      while (!dut.io.preload.ready.peek().litToBoolean) dut.clock.step()
      assert(!load(0x80))
      assert(load(0xfe))
    }
  }
}
