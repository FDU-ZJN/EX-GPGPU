package aec.fp

import chisel3._
import chisel3.util._
import hardfloat._
import FPUv2.FMA
import fudian.FPToFP

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

  val held = Reg(new AecFpRequest)
  val busy = RegInit(false.B)
  val pipe = Module(new FMA(8, 24, new AecFpPipeCtrl))
  val issueQ = Module(new Queue(UInt(6.W), entries = 16, pipe = true))
  val issueSeq = RegInit(0.U(6.W))

  val reqPipe = io.req.bits.op === AecFpOp.add || io.req.bits.op === AecFpOp.sub ||
    io.req.bits.op === AecFpOp.mul || io.req.bits.op === AecFpOp.fma
  val f16Up = Seq.fill(3)(Module(new FPToFP(5, 11, 8, 24)))
  val reqLow = Seq(io.req.bits.a(15, 0), io.req.bits.b(15, 0), io.req.bits.c(15, 0))
  f16Up.zip(reqLow).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  def reqOperand32(i: Int): UInt = {
    val f32 = Seq(io.req.bits.a(31, 0), io.req.bits.b(31, 0), io.req.bits.c(31, 0))(i)
    MuxLookup(io.req.bits.dtype, f32, Seq(
      10.U -> f16Up(i).io.result, 11.U -> Cat(reqLow(i), 0.U(16.W))))
  }
  val pipeOp = MuxLookup(io.req.bits.op, 0.U(3.W), Seq(
    AecFpOp.add -> FPUv2.utils.FPUOps.FN_FADD(2, 0),
    AecFpOp.sub -> FPUv2.utils.FPUOps.FN_FSUB(2, 0),
    AecFpOp.mul -> FPUv2.utils.FPUOps.FN_FMUL(2, 0),
    AecFpOp.fma -> FPUv2.utils.FPUOps.FN_FMADD(2, 0)))
  val ctrl = pipe.io.in.bits.ctrl.get.asInstanceOf[AecFpPipeCtrl]
  pipe.io.in.bits.op := pipeOp
  pipe.io.in.bits.a := reqOperand32(0)
  pipe.io.in.bits.b := reqOperand32(1)
  pipe.io.in.bits.c := reqOperand32(2)
  pipe.io.in.bits.rm := 0.U
  ctrl.seq := issueSeq; ctrl.dest := io.req.bits.dest; ctrl.dtype := io.req.bits.dtype
  ctrl.finite_fma := io.req.bits.op === AecFpOp.fma &&
    reqOperand32(0)(30, 23) =/= 255.U && reqOperand32(1)(30, 23) =/= 255.U && reqOperand32(2)(30, 23) =/= 255.U
  ctrl.fma_sign := reqOperand32(0)(31) ^ reqOperand32(1)(31)
  pipe.io.in.valid := io.req.valid && !busy && reqPipe && issueQ.io.enq.ready
  val pipeReady = pipe.io.in.ready && issueQ.io.enq.ready
  io.req.ready := !busy && Mux(reqPipe, pipeReady, true.B)
  issueQ.io.enq.valid := io.req.fire; issueQ.io.enq.bits := issueSeq
  when (io.req.fire) { issueSeq := issueSeq + 1.U }
  when (io.req.fire && !reqPipe) { held := io.req.bits; busy := true.B }

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
  val oldResult = Mux(held.op >= AecFpOp.cmpBase,
    Cat(0.U(31.W), cmpTrue), unaryResult)
  val downF16 = Module(new FPToFP(8, 24, 5, 11))
  // FPToFP does not support equal exponent widths with a precision-only
  // change, so use the same exact f32->f64->bf16 route as the 64-bit unit.
  val bf16Wide = Module(new FPToFP(8, 24, 11, 53))
  val downBf16 = Module(new FPToFP(11, 53, 8, 8))
  val pipeRaw = pipe.io.out.bits.result
  val pipeNaN = pipeRaw(30, 23) === 255.U && pipeRaw(22, 0).orR
  val pipeFixed = Mux(pipeNaN && ctrl.finite_fma, Cat(ctrl.fma_sign, "hff".U(8.W), 0.U(23.W)), pipeRaw)
  downF16.io.in := pipeFixed; downF16.io.rm := 0.U
  bf16Wide.io.in := pipeFixed; bf16Wide.io.rm := 0.U
  downBf16.io.in := bf16Wide.io.result; downBf16.io.rm := 0.U
  val pipeResult = MuxLookup(ctrl.dtype, Cat(0.U(32.W), pipeFixed), Seq(
    10.U -> Mux(pipeNaN, "h0000000000007e00".U(64.W), Cat(0.U(48.W), downF16.io.result)),
    11.U -> Mux(pipeNaN, "h0000000000007fc0".U(64.W), Cat(0.U(48.W), downBf16.io.result))))
  val pipeHead = pipe.io.out.valid && issueQ.io.deq.valid && pipe.io.out.bits.ctrl.get.asInstanceOf[AecFpPipeCtrl].seq === issueQ.io.deq.bits
  val oldHead = busy && issueQ.io.deq.valid
  io.resp.valid := pipeHead || oldHead
  issueQ.io.deq.ready := io.resp.fire; pipe.io.out.ready := io.resp.ready && pipeHead
  when (io.resp.fire && oldHead) { busy := false.B }
  io.resp.bits.result := Mux(pipeHead, pipeResult, oldResult)
  io.resp.bits.predicate_result := Mux(pipeHead, false.B, held.op >= AecFpOp.cmppBase && cmpTrue)
  io.resp.bits.dest := Mux(pipeHead, ctrl.dest, held.dest)
  io.resp.bits.error := Mux(pipeHead, false.B,
    !((held.op >= AecFpOp.cmpBase && held.op < AecFpOp.cmpBase + 6.U) ||
      (held.op >= AecFpOp.cmppBase && held.op < AecFpOp.cmppBase + 6.U) ||
      held.op === AecFpOp.neg || held.op === AecFpOp.abs))
  io.resp.bits.exception_flags := Mux(pipeHead, pipe.io.out.bits.fflags, 0.U)
}
