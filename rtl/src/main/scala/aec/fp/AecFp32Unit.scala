package aec.fp

import chisel3._
import chisel3.util._
import hardfloat._
import fudian.FPToFP
import aec.fp.yunsuan.YunSuanFmaPipe

/**
  * 32-bit floating-point execution unit.
  *
  * f32 is the native pipeline format. f16 and bf16 operands are widened to
  * f32 before issue and rounded back at retirement. f64 requests are accepted
  * only to produce the normal architectural error response; they belong to
  * AecFp64Unit.
  */
class AecFp32PipeUnit extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecFpRequest))
    val resp = Decoupled(new AecFpResponse)
  })

  val pipe = Module(new YunSuanFmaPipe(2))
  val issueQ = Module(new Queue(UInt(6.W), entries = 16, pipe = true))
  val simpleQ = Module(new Queue(new AecFpTaggedRequest, entries = 8, pipe = false))
  val issueSeq = RegInit(0.U(6.W))

  val reqPipe = io.req.bits.op === AecFpOp.add || io.req.bits.op === AecFpOp.sub ||
    io.req.bits.op === AecFpOp.mul || io.req.bits.op === AecFpOp.fma
  val arithmeticReq = io.req.bits
  val f16Up = Seq.fill(3)(Module(new FPToFP(5, 11, 8, 24)))
  val reqLow = Seq(arithmeticReq.a(15, 0), arithmeticReq.b(15, 0), arithmeticReq.c(15, 0))
  f16Up.zip(reqLow).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  def reqOperand32(i: Int): UInt = {
    val f32 = Seq(arithmeticReq.a(31, 0), arithmeticReq.b(31, 0), arithmeticReq.c(31, 0))(i)
    MuxLookup(arithmeticReq.dtype, f32, Seq(
      10.U -> f16Up(i).io.result, 11.U -> Cat(reqLow(i), 0.U(16.W))))
  }
  pipe.io.req.bits.op := arithmeticReq.op
  pipe.io.req.bits.a := Cat(0.U(32.W), reqOperand32(0))
  pipe.io.req.bits.b := Cat(0.U(32.W), reqOperand32(1))
  pipe.io.req.bits.c := Cat(0.U(32.W), reqOperand32(2))
  pipe.io.req.bits.format := 2.U
  pipe.io.req.bits.seq := issueSeq
  pipe.io.req.bits.dest := arithmeticReq.dest
  pipe.io.req.bits.dtype := arithmeticReq.dtype
  pipe.io.req.valid := io.req.valid && reqPipe && issueQ.io.enq.ready
  io.req.ready := issueQ.io.enq.ready && Mux(reqPipe, pipe.io.req.ready, simpleQ.io.enq.ready)
  issueQ.io.enq.valid := io.req.fire; issueQ.io.enq.bits := issueSeq
  simpleQ.io.enq.valid := io.req.valid && !reqPipe && issueQ.io.enq.ready
  simpleQ.io.enq.bits.seq := issueSeq
  simpleQ.io.enq.bits.req := io.req.bits
  when (io.req.fire) { issueSeq := issueSeq + 1.U }

  val held = simpleQ.io.deq.bits.req

  val isF16 = held.dtype === 10.U
  val isBF16 = held.dtype === 11.U
  val isF32 = held.dtype === 8.U
  val heldF16 = Seq(held.a(15, 0), held.b(15, 0))
  val heldF16Cmp = Module(new CompareRecFN(5, 11))
  heldF16Cmp.io.a := recFNFromFN(5, 11, heldF16(0))
  heldF16Cmp.io.b := recFNFromFN(5, 11, heldF16(1))
  heldF16Cmp.io.signaling := false.B
  val heldUp = Seq.fill(2)(Module(new FPToFP(5, 11, 8, 24)))
  heldUp.zip(heldF16).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  val heldA32 = MuxLookup(held.dtype, held.a(31, 0), Seq(10.U -> heldUp(0).io.result, 11.U -> Cat(held.a(15, 0), 0.U(16.W))))
  val heldB32 = MuxLookup(held.dtype, held.b(31, 0), Seq(10.U -> heldUp(1).io.result, 11.U -> Cat(held.b(15, 0), 0.U(16.W))))
  val cmp32 = Module(new CompareRecFN(8, 24))
  cmp32.io.a := recFNFromFN(8, 24, heldA32); cmp32.io.b := recFNFromFN(8, 24, heldB32); cmp32.io.signaling := false.B
  val cmpMode = Mux(held.op >= AecFpOp.cmppBase, held.op - AecFpOp.cmppBase, held.op - AecFpOp.cmpBase)
  val eq = Mux(isF16, heldF16Cmp.io.eq, cmp32.io.eq)
  val lt = Mux(isF16, heldF16Cmp.io.lt, cmp32.io.lt)
  val gt = Mux(isF16, heldF16Cmp.io.gt, cmp32.io.gt)
  val cmpTrue = MuxLookup(cmpMode, false.B, Seq(
    0.U -> eq, 1.U -> !eq, 2.U -> lt, 3.U -> (lt || eq), 4.U -> gt, 5.U -> (gt || eq)))
  // NEG/ABS are sign-bit operations, not conversions.  Using heldA32 here
  // was incorrect for f16/bf16: the widened f32 encoding has a different
  // exponent/fraction layout, so truncating it produced unrelated values.
  val narrowUnary = Mux(held.op === AecFpOp.abs, held.a(15, 0) & "h7fff".U(16.W),
    Mux(held.op === AecFpOp.neg, held.a(15, 0) ^ "h8000".U(16.W), held.a(15, 0)))
  val wideUnary = Mux(held.op === AecFpOp.abs, held.a(31, 0) & "h7fffffff".U(32.W),
    Mux(held.op === AecFpOp.neg, held.a(31, 0) ^ "h80000000".U(32.W), held.a(31, 0)))
  val unaryResult = Mux(isF16 || isBF16, Cat(0.U(48.W), narrowUnary),
    Cat(0.U(32.W), wideUnary))
  val isCmp = held.op >= AecFpOp.cmpBase && held.op < AecFpOp.cmpBase + 6.U
  val isCmpP = held.op >= AecFpOp.cmppBase && held.op < AecFpOp.cmppBase + 6.U
  val isMinMax = held.op === AecFpOp.min || held.op === AecFpOp.max
  val rawA16 = held.a(15, 0); val rawB16 = held.b(15, 0)
  val aNaN16 = Mux(isF16, rawA16(14, 10).andR && rawA16(9, 0).orR,
    rawA16(14, 7).andR && rawA16(6, 0).orR)
  val bNaN16 = Mux(isF16, rawB16(14, 10).andR && rawB16(9, 0).orR,
    rawB16(14, 7).andR && rawB16(6, 0).orR)
  val bothZero16 = rawA16(14, 0) === 0.U && rawB16(14, 0) === 0.U
  val min16 = Mux(bothZero16, Cat(rawA16(15) | rawB16(15), 0.U(15.W)), Mux(lt, rawA16, rawB16))
  val max16 = Mux(bothZero16, Cat(rawA16(15) & rawB16(15), 0.U(15.W)), Mux(gt, rawA16, rawB16))
  val canonical16 = Mux(isF16, "h7e00".U(16.W), "h7fc0".U(16.W))
  val minMax16 = Mux(aNaN16 && bNaN16, canonical16,
    Mux(aNaN16, rawB16, Mux(bNaN16, rawA16, Mux(held.op === AecFpOp.min, min16, max16))))
  val rawA32 = held.a(31, 0); val rawB32 = held.b(31, 0)
  val aNaN32 = rawA32(30, 23).andR && rawA32(22, 0).orR
  val bNaN32 = rawB32(30, 23).andR && rawB32(22, 0).orR
  val bothZero32 = rawA32(30, 0) === 0.U && rawB32(30, 0) === 0.U
  val min32 = Mux(bothZero32, Cat(rawA32(31) | rawB32(31), 0.U(31.W)), Mux(lt, rawA32, rawB32))
  val max32 = Mux(bothZero32, Cat(rawA32(31) & rawB32(31), 0.U(31.W)), Mux(gt, rawA32, rawB32))
  val minMax32 = Mux(aNaN32 && bNaN32, "h7fc00000".U(32.W),
    Mux(aNaN32, rawB32, Mux(bNaN32, rawA32, Mux(held.op === AecFpOp.min, min32, max32))))
  val minMaxResult = Mux(isF16 || isBF16, Cat(0.U(48.W), minMax16), Cat(0.U(32.W), minMax32))
  val oldResult = Mux(isCmp || isCmpP, Cat(0.U(63.W), cmpTrue),
    Mux(isMinMax, minMaxResult, unaryResult))
  val downF16 = Module(new FPToFP(8, 24, 5, 11))
  // FPToFP does not support equal exponent widths with a precision-only
  // change, so use the same exact f32->f64->bf16 route as the 64-bit unit.
  val bf16Wide = Module(new FPToFP(8, 24, 11, 53))
  val downBf16 = Module(new FPToFP(11, 53, 8, 8))
  val pipeRaw = pipe.io.resp.bits.result(31, 0)
  val pipeNaN = pipeRaw(30, 23) === 255.U && pipeRaw(22, 0).orR
  val pipeFixed = pipeRaw
  downF16.io.in := pipeFixed; downF16.io.rm := 0.U
  bf16Wide.io.in := pipeFixed; bf16Wide.io.rm := 0.U
  downBf16.io.in := bf16Wide.io.result; downBf16.io.rm := 0.U
  val pipeResult = MuxLookup(pipe.io.resp.bits.dtype, Cat(0.U(32.W), pipeFixed), Seq(
    10.U -> Mux(pipeNaN, "h0000000000007e00".U(64.W), Cat(0.U(48.W), downF16.io.result)),
    11.U -> Mux(pipeNaN, "h0000000000007fc0".U(64.W), Cat(0.U(48.W), downBf16.io.result))))
  val pipeHead = pipe.io.resp.valid && issueQ.io.deq.valid && pipe.io.resp.bits.seq === issueQ.io.deq.bits
  val oldHead = simpleQ.io.deq.valid && issueQ.io.deq.valid && simpleQ.io.deq.bits.seq === issueQ.io.deq.bits
  io.resp.valid := pipeHead || oldHead
  issueQ.io.deq.ready := io.resp.fire; pipe.io.resp.ready := io.resp.ready && pipeHead
  simpleQ.io.deq.ready := io.resp.ready && oldHead
  io.resp.bits.result := Mux(pipeHead, pipeResult, oldResult)
  io.resp.bits.predicate_result := Mux(pipeHead, false.B, isCmpP && cmpTrue)
  io.resp.bits.dest := Mux(pipeHead, pipe.io.resp.bits.dest, held.dest)
  io.resp.bits.error := Mux(pipeHead, false.B,
    !((isCmp || isCmpP || isMinMax) || held.op === AecFpOp.neg || held.op === AecFpOp.abs))
  io.resp.bits.exception_flags := Mux(pipeHead, pipe.io.resp.bits.fflags, 0.U)
}
