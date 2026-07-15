package aec

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import aec.int.{AecEightLaneIntUnit, AecIntAlu}

class DecodeValidatorHarness extends Module {
  val io = IO(new Bundle {
    val instruction = Input(UInt(128.W)); val program = Input(UInt(32.W))
    val src3 = Output(UInt(8.W)); val valid = Output(Bool())
  })
  val d = AecDecode(io.instruction)
  io.src3 := d.src3
  io.valid := AecValidator.valid(d, io.program)
}

class InstructionTraitsHarness extends Module {
  val io = IO(new Bundle {
    val instruction = Input(UInt(128.W))
    val predicateUsed = Output(Bool())
    val predicate = Output(UInt(3.W))
    val source0Pair = Output(Bool())
    val source1Pair = Output(Bool())
    val source2Pair = Output(Bool())
    val needsPairRead = Output(Bool())
  })
  val decoded = AecDecode(io.instruction)
  io.predicateUsed := AecInstructionTraits.usesSourcePredicate(decoded)
  io.predicate := AecInstructionTraits.sourcePredicate(decoded)
  io.source0Pair := AecInstructionTraits.source0Pair(decoded)
  io.source1Pair := AecInstructionTraits.source1Pair(decoded)
  io.source2Pair := AecInstructionTraits.source2Pair(decoded)
  io.needsPairRead := AecInstructionTraits.needsPairRead(decoded)
}

class SpecBugFixSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "AEC canonical decode and validation"

  private def insn(op: Int, ctrl: Int = 0, dest: Int = 0, src1: Int = 0,
                   src2: Long = 0, imm: Long = 0): BigInt =
    (BigInt(op) << 112) | (BigInt(ctrl) << 96) | (BigInt(dest) << 80) |
      (BigInt(src1) << 64) | (BigInt(src2) << 32) | BigInt(imm)

  it should "decode the low ImmExt byte as src3 and accept SEL P7" in {
    test(new DecodeValidatorHarness) { dut =>
      dut.io.program.poke(16.U)
      dut.io.instruction.poke(insn(0x0004, 2 << 3, 1, 2, 3, 0x7b).U)
      dut.io.src3.expect(0x7b.U)
      dut.io.valid.expect(true.B)
      dut.io.instruction.poke(insn(0x0022, (8 << 3) | 7, 1, 2, 3, 0).U)
      dut.io.valid.expect(true.B)
    }
  }

  it should "reject MBZ violations including malformed HALT and ternary src3" in {
    test(new DecodeValidatorHarness) { dut =>
      dut.io.program.poke(16.U)
      dut.io.instruction.poke(insn(0x0045, 15 << 3, imm = 1).U)
      dut.io.valid.expect(false.B)
      dut.io.instruction.poke(insn(0x0004, 2 << 3, 1, 2, 3, 0x100).U)
      dut.io.valid.expect(false.B)
    }
  }

  it should "track SEL predicates and keep B64 load addresses scalar" in {
    test(new InstructionTraitsHarness) { dut =>
      dut.io.instruction.poke(insn(0x0022, (8 << 3) | 7, 20, 10, 11).U)
      dut.io.predicateUsed.expect(true.B)
      dut.io.predicate.expect(7.U)
      dut.io.needsPairRead.expect(false.B)

      dut.io.instruction.poke(insn(0x0030, 1 << 3, 20, 10).U)
      dut.io.source0Pair.expect(false.B)
      dut.io.source1Pair.expect(true.B)
      dut.io.source2Pair.expect(true.B)
      dut.io.needsPairRead.expect(false.B)

      dut.io.instruction.poke(insn(0x0005, 9 << 3, 20, 10, 12, 14).U)
      dut.io.source0Pair.expect(true.B)
      dut.io.source1Pair.expect(true.B)
      dut.io.source2Pair.expect(true.B)
      dut.io.needsPairRead.expect(true.B)
    }
  }

  behavior of "AEC fixed execution semantics"

  it should "return the most-significant set bit for FLO" in {
    test(new AecIntAlu) { dut =>
      dut.io.resp.ready.poke(true.B); dut.io.req.valid.poke(true.B)
      dut.io.req.bits.op.poke(AecOpcode.flo); dut.io.req.bits.dtype.poke(2.U)
      dut.io.req.bits.a.poke("h80000001".U); dut.io.req.bits.b.poke(0.U); dut.io.req.bits.c.poke(0.U)
      dut.io.req.bits.dest.poke(1.U); dut.io.req.bits.selectPredicate.poke(false.B)
      dut.clock.step(); dut.io.req.valid.poke(false.B)
      dut.io.resp.bits.result.expect(31.U)
    }
  }

  it should "execute multi-cycle multiply, shift and bitfield operations" in {
    test(new AecIntAlu) { dut =>
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(true.B)

      def run(op: UInt, a: Long, b: Long, c: Long = 0, signed: Boolean = false): (Long, Boolean) = {
        while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
        dut.io.req.bits.op.poke(op)
        dut.io.req.bits.dtype.poke((if (signed) 3 else 2).U)
        dut.io.req.bits.a.poke((a & 0xffffffffL).U)
        dut.io.req.bits.b.poke((b & 0xffffffffL).U)
        dut.io.req.bits.c.poke((c & 0xffffffffL).U)
        dut.io.req.bits.dest.poke(5.U)
        dut.io.req.bits.selectPredicate.poke(false.B)
        dut.io.req.valid.poke(true.B)
        dut.clock.step()
        dut.io.req.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.resp.valid.peek().litToBoolean && cycles < 100) {
          dut.clock.step(); cycles += 1
        }
        assert(cycles < 100)
        val value = dut.io.resp.bits.result.peek().litValue.longValue & 0xffffffffL
        val error = dut.io.resp.bits.error.peek().litToBoolean
        dut.clock.step()
        (value, error)
      }

      assert(run(AecOpcode.mul, 0xffffffffL, 3)._1 == 0xfffffffdL)
      assert(run(AecOpcode.mad, 7, 9, 5)._1 == 68L)
      assert(run(AecOpcode.shl, 1, 31)._1 == 0x80000000L)
      assert(run(AecOpcode.shr, 0x80000000L, 4, signed = true)._1 == 0xf8000000L)
      assert(run(AecOpcode.bfx, 0xf0L, 0, (4L << 8) | 4)._1 == 15L)
      assert(run(AecOpcode.bfx, 0x80L, 0, (8L << 8), signed = true)._1 == 0xffffff80L)
      assert(run(AecOpcode.bins, 0xffff0000L, 5, (4L << 8) | 4)._1 == 0xffff0050L)
      assert(run(AecOpcode.bfx, 0, 0, (8L << 8) | 30)._2)
    }
  }

  it should "preserve shared INT work state across randomized long operations" in {
    test(new AecIntAlu) { dut =>
      dut.clock.setTimeout(20000)
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(false.B)
      val random = new scala.util.Random(0x51a7)
      val mask32 = 0xffffffffL

      def u32(value: Long): Long = value & mask32
      def signed(value: Long): Long = value.toInt.toLong
      def run(op: UInt, a: Long, b: Long, c: Long, isSigned: Boolean): (Long, Boolean) = {
        while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
        dut.io.req.bits.op.poke(op)
        dut.io.req.bits.dtype.poke((if (isSigned) 3 else 2).U)
        dut.io.req.bits.a.poke(u32(a).U)
        dut.io.req.bits.b.poke(u32(b).U)
        dut.io.req.bits.c.poke(u32(c).U)
        dut.io.req.bits.dest.poke(11.U)
        dut.io.req.bits.selectPredicate.poke(false.B)
        dut.io.req.valid.poke(true.B)
        dut.clock.step()
        dut.io.req.valid.poke(false.B)
        var cycles = 0
        while (!dut.io.resp.valid.peek().litToBoolean && cycles < 150) { dut.clock.step(); cycles += 1 }
        assert(cycles < 150)
        val value = dut.io.resp.bits.result.peek().litValue.longValue & mask32
        val error = dut.io.resp.bits.error.peek().litToBoolean
        dut.clock.step(2)
        dut.io.resp.valid.expect(true.B)
        dut.io.resp.ready.poke(true.B)
        dut.clock.step()
        dut.io.resp.ready.poke(false.B)
        (value, error)
      }

      for (_ <- 0 until 64) {
        val a = random.nextInt().toLong & mask32
        val b = random.nextInt().toLong & mask32
        val c = random.nextInt().toLong & mask32
        random.nextInt(6) match {
          case 0 =>
            val (value, error) = run(AecOpcode.mul, a, b, 0, isSigned = false)
            assert(!error && value == u32(a * b))
          case 1 =>
            val (value, error) = run(AecOpcode.mad, a, b, c, isSigned = false)
            assert(!error && value == u32(a * b + c))
          case 2 =>
            val amount = random.nextInt(32)
            val (value, error) = run(AecOpcode.shl, a, amount, 0, isSigned = false)
            assert(!error && value == u32(a << amount))
          case 3 =>
            val amount = random.nextInt(32)
            val arithmetic = random.nextBoolean()
            val expected = if (arithmetic) u32(signed(a) >> amount) else a >>> amount
            val (value, error) = run(AecOpcode.shr, a, amount, 0, arithmetic)
            assert(!error && value == expected)
          case 4 =>
            val lsb = random.nextInt(32)
            val width = random.nextInt(33 - lsb)
            val fieldMask = if (width == 32) mask32 else if (width == 0) 0L else (1L << width) - 1L
            val arithmetic = random.nextBoolean()
            val raw = (a >>> lsb) & fieldMask
            val expected = if (arithmetic && width > 0 && ((raw >>> (width - 1)) & 1L) != 0L)
              u32(raw | ~fieldMask) else raw
            val control = (width.toLong << 8) | lsb.toLong
            val (value, error) = run(AecOpcode.bfx, a, 0, control, arithmetic)
            assert(!error && value == expected)
          case 5 =>
            val lsb = random.nextInt(32)
            val width = random.nextInt(33 - lsb)
            val lowMask = if (width == 32) mask32 else if (width == 0) 0L else (1L << width) - 1L
            val fieldMask = u32(lowMask << lsb)
            val expected = u32((a & ~fieldMask) | ((b & lowMask) << lsb))
            val control = (width.toLong << 8) | lsb.toLong
            val (value, error) = run(AecOpcode.bins, a, b, control, isSigned = false)
            assert(!error && value == expected)
        }
      }
    }
  }

  it should "retire both physical INT lane groups in parallel" in {
    test(new AecEightLaneIntUnit) { dut =>
      dut.io.req.valid.poke(false.B)
      dut.io.resp.ready.poke(false.B)
      dut.clock.step()

      dut.io.req.bits.op.poke(AecOpcode.add)
      dut.io.req.bits.dtype.poke(2.U)
      dut.io.req.bits.activeMask.poke("hffffffff".U)
      dut.io.req.bits.dest.poke(9.U)
      dut.io.req.bits.predicateSelect.poke(0.U)
      dut.io.req.bits.predicateValues.poke(0.U)
      for (lane <- 0 until 32) {
        dut.io.req.bits.a(lane).poke(lane.U)
        dut.io.req.bits.b(lane).poke(1000.U)
        dut.io.req.bits.c(lane).poke(0.U)
      }
      dut.io.req.valid.poke(true.B)
      while (!dut.io.req.ready.peek().litToBoolean) dut.clock.step()
      dut.clock.step()
      dut.io.req.valid.poke(false.B)

      var cycles = 0
      while (!dut.io.resp.valid.peek().litToBoolean && cycles < 200) {
        dut.clock.step()
        cycles += 1
      }
      assert(cycles < 200)
      dut.io.resp.bits.activeMask.expect("hffffffff".U)
      dut.io.resp.bits.dest.expect(9.U)
      for (lane <- 0 until 32) {
        dut.io.resp.bits.result(lane).expect((1000 + lane).U)
      }
      dut.io.resp.ready.poke(true.B)
      dut.clock.step()
    }
  }

  it should "extend narrow sources and clamp narrow FP-to-int destinations" in {
    test(new AecConvertLane) { dut =>
      dut.io.kind.poke(1.U); dut.io.dstType.poke(4.U); dut.io.srcType.poke(8.U)
      dut.io.in.poke("h0000000043960000".U) // 300.0f -> u8 max
      dut.io.out.expect(255.U)
      dut.io.in.poke("h00000000bf800000".U) // -1.0f -> unsigned min
      dut.io.out.expect(0.U)
      dut.io.kind.poke(3.U); dut.io.dstType.poke(2.U); dut.io.srcType.poke(4.U)
      dut.io.in.poke("h00000000deadbe80".U)
      dut.io.out.expect(128.U)
      dut.io.kind.poke(2.U); dut.io.dstType.poke(8.U); dut.io.srcType.poke(5.U)
      dut.io.in.poke(0x80.U)
      dut.io.out.expect("h00000000c3000000".U) // sign-extended -128 -> f32
    }
  }

  behavior of "AEC barrier and GMEM boundary handling"

  it should "accept all four simultaneous scheduler barrier arrivals" in {
    test(new AecCtaBarrier) { dut =>
      dut.io.activeWarps.poke("hff".U); dut.io.completed.poke(0.U)
      for (i <- 0 until 4) {
        dut.io.arrive(i).valid.poke(true.B)
        dut.io.arrive(i).bits.poke((i * 2).U)
      }
      dut.io.release.expect(0.U)
      dut.clock.step()
      for (i <- 0 until 4) { dut.io.arrive(i).bits.poke((i * 2 + 1).U) }
      dut.io.release.expect("hff".U)
      dut.io.duplicate.expect(false.B)
    }
  }

  it should "assemble a 64-bit GMEM load across a 128-byte line" in {
    test(new AecGmemPipeline(1)) { dut =>
      dut.io.start.valid.poke(false.B); dut.io.lineOut.ready.poke(true.B)
      dut.io.lineComplete.valid.poke(false.B); dut.io.done.ready.poke(true.B)
      dut.io.start.bits.warp.poke(0.U); dut.io.start.bits.load.poke(true.B)
      dut.io.start.bits.width64.poke(true.B); dut.io.start.bits.mask.poke(1.U)
      dut.io.start.bits.atomic.poke(false.B); dut.io.start.bits.atomicOp.poke(0.U)
      dut.io.start.bits.signed.poke(false.B)
      for (lane <- 0 until 32) {
        dut.io.start.bits.address(lane).poke((if (lane == 0) 125 else 0).U)
        dut.io.start.bits.storeData(lane).poke(0.U)
        dut.io.start.bits.compareData(lane).poke(0.U)
      }
      dut.io.start.valid.poke(true.B); dut.clock.step(); dut.io.start.valid.poke(false.B)

      var waitCycles = 0
      while (!dut.io.lineOut.valid.peek().litToBoolean && waitCycles < 20) { dut.clock.step(); waitCycles += 1 }
      assert(waitCycles < 20, "first coalesced line request did not issue")
      dut.io.lineOut.bits.address.expect(0.U)
      val firstToken = dut.io.lineOut.bits.token.peek().litValue
      dut.clock.step()
      dut.io.lineOut.valid.expect(true.B)
      dut.io.lineOut.bits.address.expect(128.U)
      val secondToken = dut.io.lineOut.bits.token.peek().litValue
      val first = (1 to 3).zipWithIndex.foldLeft(BigInt(0)) { case (v, (b, i)) => v | (BigInt(b) << (8 * (125 + i))) }
      dut.io.lineComplete.bits.warp.poke(0.U); dut.io.lineComplete.bits.tag.poke(0.U)
      dut.io.lineComplete.bits.space.poke(false.B)
      dut.io.lineComplete.bits.write.poke(false.B); dut.io.lineComplete.bits.lastForInstruction.poke(false.B)
      dut.io.lineComplete.bits.error.poke(false.B); dut.io.lineComplete.bits.rdata.poke(first.U)
      dut.io.lineComplete.bits.address.poke(0.U); dut.io.lineComplete.bits.cacheable.poke(true.B)
      dut.io.lineComplete.bits.token.poke(firstToken.U)
      dut.io.lineComplete.valid.poke(true.B); dut.clock.step(); dut.io.lineComplete.valid.poke(false.B)
      val second = (4 to 8).zipWithIndex.foldLeft(BigInt(0)) { case (v, (b, i)) => v | (BigInt(b) << (8 * i)) }
      dut.io.lineComplete.bits.rdata.poke(second.U); dut.io.lineComplete.bits.address.poke(128.U)
      dut.io.lineComplete.bits.token.poke(secondToken.U); dut.io.lineComplete.valid.poke(true.B)
      while (!dut.io.lineComplete.ready.peek().litToBoolean) dut.clock.step()
      dut.clock.step(); dut.io.lineComplete.valid.poke(false.B)
      waitCycles = 0
      while (!dut.io.done.valid.peek().litToBoolean && waitCycles < 20) { dut.clock.step(); waitCycles += 1 }
      assert(waitCycles < 20, "cross-line GMEM load did not complete after response scatter")
      dut.io.done.valid.expect(true.B)
      dut.io.done.bits.loadData(0).expect("h0807060504030201".U)
      dut.io.done.bits.error.expect(false.B)
    }
  }
}
