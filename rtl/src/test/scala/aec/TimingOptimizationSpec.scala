package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class TimingOptimizationSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Timing-oriented multicycle units"

  it should "produce exact 8-bit quotient and remainder for every coordinate divisor" in {
    test(new AecUnsignedDivider8) { dut =>
      dut.io.start.poke(false.B)
      for (divisor <- 1 to 256; numerator <- 0 to 255) {
        dut.io.numerator.poke(numerator.U)
        dut.io.divisor.poke(divisor.U)
        dut.io.start.poke(true.B)
        dut.clock.step()
        dut.io.start.poke(false.B)
        var cycles = 0
        while (!dut.io.done.peek().litToBoolean && cycles < 10) {
          dut.clock.step()
          cycles += 1
        }
        assert(cycles < 10, s"divider timed out for $numerator / $divisor")
        dut.io.quotient.expect((numerator / divisor).U)
        dut.io.remainder.expect((numerator % divisor).U)
      }
    }
  }
}
