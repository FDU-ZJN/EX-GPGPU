package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FrontendFabricSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AecLaunchValidator"

  private def pokeLaunch(dut: AecLaunchValidator, grid: (Int, Int, Int),
                         block: (Int, Int, Int), instructions: Int,
                         loadError: Boolean = false): Unit = {
    dut.io.request.bits.gridX.poke(grid._1.U)
    dut.io.request.bits.gridY.poke(grid._2.U)
    dut.io.request.bits.gridZ.poke(grid._3.U)
    dut.io.request.bits.blockX.poke(block._1.U)
    dut.io.request.bits.blockY.poke(block._2.U)
    dut.io.request.bits.blockZ.poke(block._3.U)
    dut.io.request.bits.programInstructions.poke(instructions.U)
    dut.io.request.bits.loadError.poke(loadError.B)
  }

  it should "accept valid geometry and reject invalid or oversized launches" in {
    test(new AecLaunchValidator) { dut =>
      dut.io.request.valid.poke(false.B)
      dut.io.result.ready.poke(false.B)

      def submit(grid: (Int, Int, Int), block: (Int, Int, Int),
                 instructions: Int, expected: Boolean,
                 loadError: Boolean = false): Unit = {
        pokeLaunch(dut, grid, block, instructions, loadError)
        dut.io.request.valid.poke(true.B)
        dut.io.request.ready.expect(true.B)
        dut.clock.step()
        dut.io.request.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.result.valid.peek().litToBoolean && cycles < 10) {
          dut.clock.step()
          cycles += 1
        }
        assert(cycles < 10, "launch validation did not complete")
        dut.io.result.bits.accepted.expect(expected.B)
        dut.io.result.valid.expect(true.B)
        dut.clock.step(2)
        dut.io.result.valid.expect(true.B)
        dut.io.result.ready.poke(true.B)
        dut.clock.step()
        dut.io.result.ready.poke(false.B)
        dut.io.idle.expect(true.B)
      }

      submit((2, 3, 4), (8, 4, 2), 64, expected = true)
      dut.io.result.bits.threads.expect(64.U)
      submit((1, 1, 1), (17, 16, 1), 1, expected = false)
      submit((1, 1, 1), (8, 4, 1), 0, expected = false)
      submit((1, 1, 1), (8, 4, 1), 1, expected = false, loadError = true)
    }
  }

  behavior of "AecCoordinateFabric"

  it should "route a lane stream to its owner and hold it under backpressure" in {
    test(new AecCoordinateFabric) { dut =>
      dut.io.blockX.poke(8.U); dut.io.blockY.poke(4.U); dut.io.blockZ.poke(2.U)
      dut.io.gridX.poke(3.U); dut.io.gridY.poke(5.U); dut.io.gridZ.poke(7.U)
      dut.io.ctaX.poke(1.U); dut.io.ctaY.poke(2.U); dut.io.ctaZ.poke(3.U)
      for (i <- 0 until 4) {
        dut.io.requests(i).valid.poke(false.B)
        dut.io.requests(i).bits.special.poke(0.U)
        dut.io.requests(i).bits.linearLane.poke(0.U)
        dut.io.requests(i).bits.startLane.poke(0.U)
        dut.io.responses(i).ready.poke(false.B)
      }

      dut.io.requests(2).bits.special.poke("h0104".U)
      dut.io.requests(2).bits.linearLane.poke(29.U)
      dut.io.requests(2).bits.startLane.poke(29.U)
      dut.io.requests(2).valid.poke(true.B)
      dut.io.requests(2).ready.expect(true.B)
      dut.clock.step()
      dut.io.requests(2).valid.poke(false.B)

      for (i <- Seq(0, 1, 3)) dut.io.responses(i).valid.expect(false.B)
      dut.io.responses(2).valid.expect(true.B)
      dut.io.responses(2).bits.lane.expect(29.U)
      dut.io.responses(2).bits.data.expect(29.U)
      dut.io.responses(2).bits.last.expect(false.B)
      dut.clock.step(3)
      dut.io.responses(2).bits.lane.expect(29.U)
      dut.io.responses(2).bits.data.expect(29.U)

      dut.io.responses(2).ready.poke(true.B)
      dut.clock.step()
      dut.io.responses(2).bits.lane.expect(30.U)
      dut.io.responses(2).bits.data.expect(30.U)
      dut.io.responses(2).bits.last.expect(false.B)
      dut.clock.step()
      dut.io.responses(2).bits.lane.expect(31.U)
      dut.io.responses(2).bits.data.expect(31.U)
      dut.io.responses(2).bits.last.expect(true.B)
      dut.clock.step()
      dut.io.responses(2).valid.expect(false.B)
    }
  }

  behavior of "AecLocalMemoryFabric"

  private def pokeLocalRequest(dut: AecLocalMemoryFabric, port: Int,
                               warp: Int, sequence: Int): Unit = {
    val bits = dut.io.requests(port).bits
    bits.tag.warp.poke(warp.U); bits.tag.epoch.poke(3.U)
    bits.tag.sequence.poke(sequence.U); bits.tag.robIndex.poke(1.U); bits.tag.pc.poke(16.U)
    bits.request.warp.poke(warp.U); bits.request.space.poke(AecMemorySpace.smem)
    bits.request.load.poke(true.B); bits.request.width64.poke(false.B)
    bits.request.mask.poke(0.U); bits.request.atomic.poke(false.B)
    bits.request.atomicOp.poke(0.U); bits.request.signed.poke(false.B)
    for (lane <- 0 until 32) {
      bits.request.address(lane).poke(0.U)
      bits.request.storeData(lane).poke(0.U)
      bits.request.compareData(lane).poke(0.U)
    }
  }

  it should "round-robin requests and preserve completion ownership under backpressure" in {
    test(new AecLocalMemoryFabric) { dut =>
      dut.io.clearSmem.poke(false.B)
      dut.io.preload.valid.poke(false.B)
      dut.io.preload.bits.pmem.poke(false.B); dut.io.preload.bits.address.poke(0.U)
      dut.io.preload.bits.data.poke(0.U); dut.io.preload.bits.mask.poke(0.U)
      for (i <- 0 until 4) {
        dut.io.requests(i).valid.poke(false.B)
        dut.io.completions(i).ready.poke(false.B)
        pokeLocalRequest(dut, i, i * 2, 10 + i)
      }

      dut.io.requests(0).valid.poke(true.B)
      dut.io.requests(2).valid.poke(true.B)
      dut.io.requests(0).ready.expect(true.B)
      dut.io.requests(2).ready.expect(false.B)
      dut.clock.step()
      dut.io.requests(0).valid.poke(false.B)

      var cycles = 0
      while (!dut.io.completions(0).valid.peek().litToBoolean && cycles < 8) {
        dut.clock.step(); cycles += 1
      }
      assert(cycles < 8, "first local completion did not arrive")
      dut.io.completions(0).bits.tag.sequence.expect(10.U)
      dut.io.completions(0).bits.error.expect(false.B)
      dut.io.completions(2).valid.expect(false.B)
      dut.clock.step(3)
      dut.io.completions(0).valid.expect(true.B)
      dut.io.requests(2).ready.expect(false.B)

      dut.io.completions(0).ready.poke(true.B)
      dut.clock.step()
      dut.io.completions(0).ready.poke(false.B)
      dut.io.requests(2).ready.expect(true.B)
      dut.clock.step()
      dut.io.requests(2).valid.poke(false.B)
      cycles = 0
      while (!dut.io.completions(2).valid.peek().litToBoolean && cycles < 8) {
        dut.clock.step(); cycles += 1
      }
      assert(cycles < 8, "second local completion did not arrive")
      dut.io.completions(2).bits.tag.sequence.expect(12.U)
      dut.io.completions(2).bits.error.expect(false.B)
    }
  }

  behavior of "AecExternalMemoryFabric"

  private def pokeLine(dut: AecExternalMemoryFabric, port: Int,
                       warp: Int, address: BigInt): Unit = {
    val bits = dut.io.lines(port).bits
    bits.space.poke(false.B); bits.warp.poke(warp.U); bits.write.poke(false.B)
    bits.address.poke(address.U); bits.wdata.poke(0.U); bits.wstrb.poke(0.U)
    bits.lastForInstruction.poke(true.B)
  }

  it should "arbitrate requesters and keep the external request stable while stalled" in {
    test(new AecExternalMemoryFabric) { dut =>
      dut.io.memReqReady.poke(false.B)
      dut.io.memRspValid.poke(false.B); dut.io.memRspRdata.poke(0.U)
      dut.io.memRspTag.poke(0.U); dut.io.memRspError.poke(false.B)
      for (i <- 0 until 4) {
        dut.io.lines(i).valid.poke(false.B)
        pokeLine(dut, i, i * 2, BigInt(0x1000 + i * 0x100))
        dut.io.completions(i).ready.poke(false.B)
        dut.io.atomic(i).poke(false.B)
        dut.io.instructionDone(i).poke(false.B)
      }

      dut.io.lines(0).valid.poke(true.B)
      dut.io.lines(2).valid.poke(true.B)
      dut.io.lines(0).ready.expect(true.B)
      dut.io.lines(2).ready.expect(false.B)
      dut.clock.step()
      dut.io.lines(0).valid.poke(false.B)
      dut.io.lines(2).ready.expect(true.B)
      dut.clock.step()
      dut.io.lines(2).valid.poke(false.B)

      var cycles = 0
      while (!dut.io.memReqValid.peek().litToBoolean && cycles < 5) {
        dut.clock.step(); cycles += 1
      }
      assert(cycles < 5, "external request did not reach the memory interface")
      dut.io.memReqAddr.expect("h1000".U)
      val firstTag = dut.io.memReqTag.peek().litValue
      dut.clock.step(3)
      dut.io.memReqValid.expect(true.B)
      dut.io.memReqAddr.expect("h1000".U)
      dut.io.memReqTag.expect(firstTag.U)

      dut.io.memReqReady.poke(true.B)
      dut.clock.step()
      cycles = 0
      while ((!dut.io.memReqValid.peek().litToBoolean ||
              dut.io.memReqAddr.peek().litValue != 0x1200) && cycles < 5) {
        dut.clock.step(); cycles += 1
      }
      assert(cycles < 5, "second requester was not serviced")
      dut.io.memReqAddr.expect("h1200".U)
      dut.clock.step()

      dut.io.memRspTag.poke(firstTag.U)
      dut.io.memRspRdata.poke("h55aa".U)
      dut.io.memRspValid.poke(true.B)
      dut.io.completions(0).valid.expect(true.B)
      dut.io.completions(0).bits.warp.expect(0.U)
      dut.io.completions(0).bits.rdata.expect("h55aa".U)
      dut.io.completions(2).valid.expect(false.B)
      dut.clock.step(2)
      dut.io.completions(0).valid.expect(true.B)
      dut.io.completions(0).ready.poke(true.B)
      dut.clock.step()
      dut.io.memRspValid.poke(false.B)
    }
  }
}
