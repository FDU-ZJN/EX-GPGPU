package aec.fp

import chisel3._
import chisel3.util._
import hardfloat._
import aec.AecOpcode
import aec.int.AecIntDivider

class AecSfuLaneRequest extends Bundle {
  val op = UInt(16.W)
  val dtype = UInt(4.W)
  val mode = UInt(3.W)
  val a = UInt(64.W)
  val b = UInt(64.W)
  val dest = UInt(8.W)
}

class AecSfuLaneResponse extends Bundle {
  val result = UInt(64.W)
  val dest = UInt(8.W)
  val error = Bool()
  val exceptionFlags = UInt(5.W)
}

/** Scalar multi-cycle DIV/SFU lane. */
class AESSFU extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecSfuLaneRequest))
    val resp = Decoupled(new AecSfuLaneResponse)
  })

  val (idle :: intStart :: intWait :: fpStart :: fpWait :: rsqDivStart :: rsqDivWait ::
    transStart :: transWait :: finish :: Nil) = Enum(10)
  val state = RegInit(idle)
  val held = Reg(new AecSfuLaneRequest)
  val result = RegInit(0.U(64.W))
  val flags = RegInit(0.U(5.W))
  val error = RegInit(false.B)
  val rsqRoot = Reg(UInt(32.W))

  val intDiv = Module(new AecIntDivider)
  // Start the divider from the lane-local request bank.  This register cut
  // keeps request decode and the wide divider initialization mux out of the
  // same timing path.
  intDiv.io.req.valid := state === intStart
  intDiv.io.req.bits.dividend := held.a(31, 0)
  intDiv.io.req.bits.divisor := held.b(31, 0)
  intDiv.io.req.bits.signed := held.dtype === 3.U
  intDiv.io.resp.ready := state === intWait

  val isRcp = held.op === AecOpcode.rcp
  val isRsq = held.op === AecOpcode.rsq
  val isSqrt = held.op === AecOpcode.sqrt || (isRsq && state === fpStart)
  val useRsqDivision = state === rsqDivStart || state === rsqDivWait
  val fp32A = Mux(isRcp || useRsqDivision, "h3f800000".U(32.W), held.a(31, 0))
  val fp32B = Mux(isRcp, held.a(31, 0), Mux(useRsqDivision, rsqRoot, held.b(31, 0)))

  // Widen f32 operands exactly, then use one 53-bit iterative DIV/SQRT core
  // for both precisions.  Precision-specific rounding happens from rawOut.
  val widenA = Module(new RecFNToRecFN(8, 24, 11, 53))
  val widenB = Module(new RecFNToRecFN(8, 24, 11, 53))
  widenA.io.in := recFNFromFN(8, 24, fp32A)
  widenB.io.in := recFNFromFN(8, 24, fp32B)
  widenA.io.roundingMode := 0.U
  widenB.io.roundingMode := 0.U
  widenA.io.detectTininess := false.B
  widenB.io.detectTininess := false.B

  val divSqrt = Module(new DivSqrtRecFNToRaw_small(11, 53, 0))
  divSqrt.io.inValid := (state === fpStart && (held.dtype === 8.U || held.dtype === 9.U)) ||
    (state === rsqDivStart && held.dtype === 8.U)
  divSqrt.io.sqrtOp := isSqrt && !useRsqDivision
  divSqrt.io.a := Mux(held.dtype === 8.U, widenA.io.out, recFNFromFN(11, 53, held.a))
  divSqrt.io.b := Mux(held.dtype === 8.U, widenB.io.out, recFNFromFN(11, 53, held.b))
  divSqrt.io.roundingMode := 0.U

  val round32 = Module(new RoundAnyRawFNToRecFN(11, 55, 8, 24, 0))
  round32.io.invalidExc := divSqrt.io.invalidExc
  round32.io.infiniteExc := divSqrt.io.infiniteExc
  round32.io.in := divSqrt.io.rawOut
  round32.io.roundingMode := divSqrt.io.roundingModeOut
  round32.io.detectTininess := false.B

  val round64 = Module(new RoundRawFNToRecFN(11, 53, 0))
  round64.io.invalidExc := divSqrt.io.invalidExc
  round64.io.infiniteExc := divSqrt.io.infiniteExc
  round64.io.in := divSqrt.io.rawOut
  round64.io.roundingMode := divSqrt.io.roundingModeOut
  round64.io.detectTininess := false.B

  val trans = Module(new AecTranscendental)
  trans.io.req.valid := state === transStart
  trans.io.req.bits.in := held.a(31, 0)
  trans.io.req.bits.op := held.op
  trans.io.resp.ready := state === transWait

  val requestIsInt = io.req.bits.op === AecOpcode.div && (io.req.bits.dtype === 2.U || io.req.bits.dtype === 3.U)
  val requestIsFpCore = (io.req.bits.op === AecOpcode.div && (io.req.bits.dtype === 8.U || io.req.bits.dtype === 9.U)) ||
    io.req.bits.op === AecOpcode.rcp || io.req.bits.op === AecOpcode.rsq || io.req.bits.op === AecOpcode.sqrt
  val requestIsTrans = io.req.bits.op === AecOpcode.sin || io.req.bits.op === AecOpcode.cos ||
    io.req.bits.op === AecOpcode.exp || io.req.bits.op === AecOpcode.log
  def canonicalF32(value: UInt): UInt = Mux(value(30, 23).andR && value(22, 0).orR, "h7fc00000".U, value)
  def canonicalF64(value: UInt): UInt = Mux(value(62, 52).andR && value(51, 0).orR, "h7ff8000000000000".U, value)

  io.req.ready := state === idle && Mux(requestIsInt, intDiv.io.req.ready, requestIsFpCore || requestIsTrans)
  when (io.req.fire) {
    held := io.req.bits
    result := 0.U
    flags := 0.U
    error := false.B
    state := Mux(requestIsInt, intStart, Mux(requestIsFpCore, fpStart, transStart))
  }

  when (state === intStart && intDiv.io.req.ready) { state := intWait }

  when (state === fpStart) {
    when (divSqrt.io.inReady) { state := fpWait }
  }
  when (state === rsqDivStart && divSqrt.io.inReady) { state := rsqDivWait }

  when (intDiv.io.resp.fire) {
    result := Cat(0.U(32.W), intDiv.io.resp.bits.quotient)
    error := intDiv.io.resp.bits.error
    state := finish
  }
  when (state === fpWait && held.dtype === 8.U && (divSqrt.io.rawOutValid_div || divSqrt.io.rawOutValid_sqrt)) {
    val value = canonicalF32(fNFromRecFN(8, 24, round32.io.out))
    when (held.op === AecOpcode.rsq) {
      rsqRoot := value
      state := rsqDivStart
    }.otherwise {
      result := Cat(0.U(32.W), value)
      flags := round32.io.exceptionFlags
      state := finish
    }
  }
  when (state === rsqDivWait && divSqrt.io.rawOutValid_div) {
    result := Cat(0.U(32.W), canonicalF32(fNFromRecFN(8, 24, round32.io.out)))
    flags := round32.io.exceptionFlags
    state := finish
  }
  when (state === fpWait && held.dtype === 9.U && (divSqrt.io.rawOutValid_div || divSqrt.io.rawOutValid_sqrt)) {
    result := canonicalF64(fNFromRecFN(11, 53, round64.io.out))
    flags := round64.io.exceptionFlags
    state := finish
  }
  when (state === transStart && trans.io.req.ready) { state := transWait }
  when (trans.io.resp.fire) {
    result := Cat(0.U(32.W), trans.io.resp.bits)
    state := finish
  }

  io.resp.valid := state === finish
  io.resp.bits.result := result
  io.resp.bits.dest := held.dest
  io.resp.bits.error := error
  io.resp.bits.exceptionFlags := flags
  when (io.resp.fire) { state := idle }
}
