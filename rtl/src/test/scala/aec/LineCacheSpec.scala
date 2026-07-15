package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class LineCacheSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AecLineCache"

  it should "register miss, fill and hit results before forwarding them" in {
    test(new AecLineCache(useSramData = false)) { dut =>
      dut.io.cpuRequest.valid.poke(false.B)
      dut.io.cpuCompletion.ready.poke(true.B)
      dut.io.memoryRequest.ready.poke(true.B)
      dut.io.memoryCompletion.valid.poke(false.B)
      dut.clock.step()

      val address = 0x1000L
      val line = BigInt("0123456789abcdef" * 16, 16)
      dut.io.cpuRequest.valid.poke(true.B)
      dut.io.cpuRequest.bits.space.poke(false.B)
      dut.io.cpuRequest.bits.warp.poke(0.U)
      dut.io.cpuRequest.bits.write.poke(false.B)
      dut.io.cpuRequest.bits.address.poke(address.U)
      dut.io.cpuRequest.bits.wdata.poke(0.U)
      dut.io.cpuRequest.bits.wstrb.poke(0.U)
      dut.io.cpuRequest.bits.lastForInstruction.poke(true.B)
      dut.io.cpuRequest.bits.cacheable.poke(true.B)
      dut.io.cpuRequest.bits.token.poke(3.U)
      dut.io.cpuRequest.ready.expect(true.B)
      dut.io.memoryRequest.valid.expect(false.B)
      dut.clock.step()
      dut.io.cpuRequest.valid.poke(false.B)
      var waitCycles = 0
      while (!dut.io.memoryRequest.valid.peek().litToBoolean && waitCycles < 5) {
        dut.clock.step()
        waitCycles += 1
      }
      assert(waitCycles < 5, "registered cold miss did not reach memory request")
      dut.clock.step()

      dut.io.memoryCompletion.valid.poke(true.B)
      dut.io.memoryCompletion.bits.space.poke(false.B)
      dut.io.memoryCompletion.bits.warp.poke(0.U)
      dut.io.memoryCompletion.bits.tag.poke(0.U)
      dut.io.memoryCompletion.bits.write.poke(false.B)
      dut.io.memoryCompletion.bits.lastForInstruction.poke(true.B)
      dut.io.memoryCompletion.bits.rdata.poke(line.U)
      dut.io.memoryCompletion.bits.error.poke(false.B)
      dut.io.memoryCompletion.bits.address.poke(address.U)
      dut.io.memoryCompletion.bits.cacheable.poke(true.B)
      dut.io.memoryCompletion.bits.token.poke(3.U)
      // The cache-to-LSU boundary is registered: an external response must
      // never appear combinationally at cpuCompletion.
      dut.io.cpuCompletion.valid.expect(false.B)
      dut.clock.step()
      dut.io.memoryCompletion.valid.poke(false.B)
      dut.io.cpuCompletion.valid.expect(true.B)
      dut.io.cpuCompletion.bits.rdata.expect(line.U)
      dut.io.cpuCompletion.bits.token.expect(3.U)
      dut.clock.step()

      dut.io.cpuRequest.valid.poke(true.B)
      dut.io.cpuRequest.ready.expect(true.B)
      dut.io.memoryRequest.valid.expect(false.B)
      dut.clock.step()
      dut.io.cpuRequest.valid.poke(false.B)
      waitCycles = 0
      while (!dut.io.cpuCompletion.valid.peek().litToBoolean && waitCycles < 5) {
        dut.io.memoryRequest.valid.expect(false.B)
        dut.clock.step()
        waitCycles += 1
      }
      assert(waitCycles < 5, "registered cache hit did not complete")
      dut.io.cpuCompletion.valid.expect(true.B)
      dut.io.cpuCompletion.bits.rdata.expect(line.U)
      dut.io.cpuCompletion.bits.token.expect(3.U)
      dut.clock.step()
    }
  }
}
