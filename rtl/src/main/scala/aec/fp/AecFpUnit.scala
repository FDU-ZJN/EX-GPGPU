package aec.fp

import chisel3._
import chisel3.util._
import hardfloat._
import FPUv2.FMA
import fudian.FPToFP

/** Metadata carried through the Ventus-style elastic f32 pipeline. */
class AecFpPipeCtrl extends Bundle {
  /** Monotonic issue tag used only inside the unit to restore Decoupled
    * response order when different arithmetic pipes have different latency. */
  val seq = UInt(6.W)
  val dest = UInt(8.W)
  // The f32 pipe also executes f16/bf16 requests, so the response must retain
  // the architectural format for its final RNE conversion.
  val dtype = UInt(4.W)
  // fudian's FMA overflow shortcut can report NaN for a finite overflow.
  // Carry enough request context to repair that result at retirement.
  val finite_fma = Bool()
  val fma_sign = Bool()
}

/** Architectural floating point request/response types.
  * dtype: 0=f16, 1=bf16, 2=f32, 3=f64.  All operations use RNE.
  */
class AecFpRequest extends Bundle {
  val op = UInt(7.W)
  // ISA type encodings: f32=8, f64=9, f16=10, bf16=11.
  val dtype = UInt(4.W)
  val a = UInt(64.W); val b = UInt(64.W); val c = UInt(64.W)
  val dest = UInt(8.W)
}
class AecFpResponse extends Bundle {
  val result = UInt(64.W)
  val predicate_result = Bool()
  val dest = UInt(8.W)
  val error = Bool(); val exception_flags = UInt(5.W)
}

object AecFpOp {
  val add = 1.U(7.W); val sub = 2.U(7.W); val mul = 3.U(7.W)
  val mad = 4.U(7.W); val fma = 5.U(7.W); val div = 6.U(7.W)
  val neg = 7.U(7.W); val abs = 8.U(7.W)
  val min = 9.U(7.W); val max = 10.U(7.W)
  // Compare relation is part of the operation encoding; no separate mode
  // signal needs to cross the warp/FPUnit boundary.
  val cmpBase = 32.U(7.W); val cmppBase = 40.U(7.W)
  val cvtff = 80.U(7.W); val cvtfi = 81.U(7.W); val cvtif = 82.U(7.W)
  val rcp = 112.U(7.W); val rsq = 113.U(7.W); val sin = 114.U(7.W)
  val cos = 115.U(7.W); val exp = 116.U(7.W); val log = 117.U(7.W); val sqrt = 118.U(7.W)
}

/** One FP64 FMA backend per lane.  Narrow formats are widened before issue and
  * rounded back only at retirement. */
class AecFp64PipeUnit(val acceptNarrow: Boolean = true) extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecFpRequest))
    val resp = Decoupled(new AecFpResponse)
  })

  val held = Reg(new AecFpRequest)
  val busy = RegInit(false.B)
  val reqPipe =
    (io.req.bits.op === AecFpOp.add || io.req.bits.op === AecFpOp.sub ||
      io.req.bits.op === AecFpOp.mul || io.req.bits.op === AecFpOp.fma)
  val f64Pipe = Module(new FMA(11, 53, new AecFpPipeCtrl))
  val issueQ = Module(new Queue(UInt(6.W), entries = 32, pipe = true))
  val issueSeq = RegInit(0.U(6.W))

  val pipeOp = MuxLookup(io.req.bits.op, 0.U(3.W), Seq(
    AecFpOp.add -> FPUv2.utils.FPUOps.FN_FADD(2, 0),
    AecFpOp.sub -> FPUv2.utils.FPUOps.FN_FSUB(2, 0),
    AecFpOp.mul -> FPUv2.utils.FPUOps.FN_FMUL(2, 0),
    AecFpOp.fma -> FPUv2.utils.FPUOps.FN_FMADD(2, 0)))
  // Exact widening converters, including subnormals and NaN classification.
  val f16Up = Seq.fill(3)(Module(new FPToFP(5, 11, 11, 53)))
  val bf16Up = Seq.fill(3)(Module(new FPToFP(8, 8, 11, 53)))
  val f32Up = Seq.fill(3)(Module(new FPToFP(8, 24, 11, 53)))
  val reqLowOperands = Seq(io.req.bits.a(15, 0), io.req.bits.b(15, 0), io.req.bits.c(15, 0))
  f16Up.zip(reqLowOperands).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  bf16Up.zip(reqLowOperands).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  f32Up.zip(Seq(io.req.bits.a(31, 0), io.req.bits.b(31, 0), io.req.bits.c(31, 0))).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  def reqOperand64(index: Int): UInt = {
    val fp32 = Seq(io.req.bits.a(31, 0), io.req.bits.b(31, 0), io.req.bits.c(31, 0))(index)
    MuxLookup(io.req.bits.dtype, io.req.bits.a, Seq(
      10.U -> f16Up(index).io.result, 11.U -> bf16Up(index).io.result,
      8.U -> f32Up(index).io.result, 9.U -> Seq(io.req.bits.a, io.req.bits.b, io.req.bits.c)(index)))
  }
  def connectPipe(pipe: FMA): Unit = {
    val ctrl = pipe.io.in.bits.ctrl.get.asInstanceOf[AecFpPipeCtrl]
    pipe.io.in.bits.op := pipeOp
    pipe.io.in.bits.a := reqOperand64(0)
    pipe.io.in.bits.b := reqOperand64(1)
    pipe.io.in.bits.c := reqOperand64(2)
    pipe.io.in.bits.rm := 0.U // AEC is fixed RNE.
    ctrl.seq := issueSeq
    ctrl.dest := io.req.bits.dest
    ctrl.dtype := io.req.bits.dtype
    ctrl.finite_fma := io.req.bits.op === AecFpOp.fma &&
      reqOperand64(0)(62,52) =/= 2047.U && reqOperand64(1)(62,52) =/= 2047.U && reqOperand64(2)(62,52) =/= 2047.U
    ctrl.fma_sign := reqOperand64(0)(63) ^ reqOperand64(1)(63)
    pipe.io.in.valid := io.req.valid && !busy && reqPipe && issueQ.io.enq.ready
  }
  connectPipe(f64Pipe)
  val selectedPipeReady = MuxLookup(io.req.bits.dtype, false.B, Seq(
    10.U -> f64Pipe.io.in.ready, 11.U -> f64Pipe.io.in.ready,
    8.U -> f64Pipe.io.in.ready, 9.U -> f64Pipe.io.in.ready))
  val reqDtypeSupported = if (acceptNarrow) true.B else io.req.bits.dtype === 9.U
  io.req.ready := !busy && reqDtypeSupported && Mux(reqPipe, selectedPipeReady && issueQ.io.enq.ready, true.B)
  issueQ.io.enq.valid := io.req.fire
  issueQ.io.enq.bits := issueSeq
  when (io.req.fire) { issueSeq := issueSeq + 1.U }
  when (io.req.fire && !reqPipe) { held := io.req.bits; busy := true.B }

  val rm = 0.U(3.W)
  val isF16 = held.dtype === 10.U; val isBF16 = held.dtype === 11.U
  val isF32 = held.dtype === 8.U; val isF64 = held.dtype === 9.U
  def bitsFor(x: UInt, dt: UInt): UInt = MuxLookup(dt, x(31,0), Seq(
    10.U -> x(15,0), 11.U -> Cat(x(15,0), 0.U(16.W)), 8.U -> x(31,0), 9.U -> x(63,0)))
  def rec(x: UInt, e: Int, s: Int): UInt = recFNFromFN(e, s, x)

  val cmp16 = Module(new CompareRecFN(5, 11)); val cmp32 = Module(new CompareRecFN(8, 24)); val cmp64 = Module(new CompareRecFN(11, 53))

  val isAdd = held.op === AecFpOp.add || held.op === AecFpOp.sub
  val isMul = held.op === AecFpOp.mul
  val isFma = held.op === AecFpOp.fma
  cmp16.io.a := rec(bitsFor(held.a, held.dtype), 5, 11); cmp16.io.b := rec(bitsFor(held.b, held.dtype), 5, 11); cmp16.io.signaling := false.B
  cmp32.io.a := rec(bitsFor(held.a, held.dtype), 8, 24); cmp32.io.b := rec(bitsFor(held.b, held.dtype), 8, 24); cmp32.io.signaling := false.B
  cmp64.io.a := rec(held.a, 11, 53); cmp64.io.b := rec(held.b, 11, 53); cmp64.io.signaling := false.B
  val oldRespValid = busy
  val f64Ctrl = f64Pipe.io.out.bits.ctrl.get.asInstanceOf[AecFpPipeCtrl]
  val f64AtHead = f64Pipe.io.out.valid && issueQ.io.deq.valid && f64Ctrl.seq === issueQ.io.deq.bits
  val oldAtHead = oldRespValid && issueQ.io.deq.valid
  val pipeRespValid = f64AtHead
  io.resp.valid := pipeRespValid || oldAtHead
  issueQ.io.deq.ready := io.resp.fire
  f64Pipe.io.out.ready := io.resp.ready && f64AtHead
  when (io.resp.fire && oldAtHead) { busy := false.B }
  val isCmp = held.op >= AecFpOp.cmpBase && held.op < (AecFpOp.cmpBase + 6.U)
  val isCmpP = held.op >= AecFpOp.cmppBase && held.op < (AecFpOp.cmppBase + 6.U)
  val cmpMode = Mux(isCmpP, held.op - AecFpOp.cmppBase, held.op - AecFpOp.cmpBase)
  val cmpTrue = MuxLookup(cmpMode, false.B, Seq(
    0.U -> MuxLookup(held.dtype, cmp32.io.eq, Seq(10.U -> cmp16.io.eq, 11.U -> cmp32.io.eq, 9.U -> cmp64.io.eq)),
    1.U -> MuxLookup(held.dtype, !(cmp32.io.eq), Seq(10.U -> !(cmp16.io.eq), 11.U -> !(cmp32.io.eq), 9.U -> !(cmp64.io.eq))),
    2.U -> MuxLookup(held.dtype, cmp32.io.lt, Seq(10.U -> cmp16.io.lt, 11.U -> cmp32.io.lt, 9.U -> cmp64.io.lt)),
    3.U -> MuxLookup(held.dtype, cmp32.io.lt || cmp32.io.eq, Seq(10.U -> (cmp16.io.lt || cmp16.io.eq), 11.U -> (cmp32.io.lt || cmp32.io.eq), 9.U -> (cmp64.io.lt || cmp64.io.eq))),
    4.U -> MuxLookup(held.dtype, cmp32.io.gt, Seq(10.U -> cmp16.io.gt, 11.U -> cmp32.io.gt, 9.U -> cmp64.io.gt)),
    5.U -> MuxLookup(held.dtype, cmp32.io.gt || cmp32.io.eq, Seq(10.U -> (cmp16.io.gt || cmp16.io.eq), 11.U -> (cmp32.io.gt || cmp32.io.eq), 9.U -> (cmp64.io.gt || cmp64.io.eq)))))
  val a32 = held.a(31, 0); val b32 = held.b(31, 0)
  val aNaN32 = a32(30, 23).andR && a32(22, 0).orR
  val bNaN32 = b32(30, 23).andR && b32(22, 0).orR
  val bothZero32 = a32(30, 0) === 0.U && b32(30, 0) === 0.U
  val minNumeric32 = Mux(bothZero32, Cat(a32(31) | b32(31), 0.U(31.W)), Mux(cmp32.io.lt, a32, b32))
  val maxNumeric32 = Mux(bothZero32, Cat(a32(31) & b32(31), 0.U(31.W)), Mux(cmp32.io.gt, a32, b32))
  val minMax32 = Mux(aNaN32 && bNaN32, "h7fc00000".U,
    Mux(aNaN32, b32, Mux(bNaN32, a32, Mux(held.op === AecFpOp.min, minNumeric32, maxNumeric32))))
  val unarySign = Mux(isF64, (1.U(64.W) << 63), Mux(isF32, (1.U(64.W) << 31), (1.U(64.W) << 15)))
  val unaryRaw = Mux(held.op === AecFpOp.abs, held.a & ~unarySign, Mux(held.op === AecFpOp.neg, held.a ^ unarySign, held.a))
  val unary = Mux(isF64, unaryRaw, Mux(isF32, Cat(0.U(32.W), unaryRaw(31,0)), Cat(0.U(48.W), unaryRaw(15,0))))
  val isMinMax = held.op === AecFpOp.min || held.op === AecFpOp.max
  val oldResult = Mux(isCmp || isCmpP, Cat(0.U(63.W), cmpTrue),
    Mux(isMinMax, Cat(0.U(32.W), minMax32), unary))
  val f64DownF16 = Module(new FPToFP(11, 53, 5, 11))
  val f64DownBf16 = Module(new FPToFP(11, 53, 8, 8))
  val f64DownF32 = Module(new FPToFP(11, 53, 8, 24))
  val pipeF64Raw = f64Pipe.io.out.bits.result
  val pipeF64NaNRaw = pipeF64Raw(62,52) === 2047.U && pipeF64Raw(51,0).orR
  val pipeF64Fixed = Mux(pipeF64NaNRaw && f64Ctrl.finite_fma,
    Cat(f64Ctrl.fma_sign, "h7ff".U(11.W), 0.U(52.W)), pipeF64Raw)
  f64DownF16.io.in := pipeF64Fixed; f64DownF16.io.rm := 0.U
  f64DownBf16.io.in := pipeF64Fixed; f64DownBf16.io.rm := 0.U
  f64DownF32.io.in := pipeF64Fixed; f64DownF32.io.rm := 0.U
  val pipeF64NaN = pipeF64Fixed(62,52) === 2047.U && pipeF64Fixed(51,0).orR
  val pipeResult = MuxLookup(f64Ctrl.dtype, pipeF64Fixed, Seq(
    10.U -> Mux(pipeF64NaN, "h0000000000007e00".U(64.W), Cat(0.U(48.W), f64DownF16.io.result)),
    11.U -> Mux(pipeF64NaN, "h0000000000007fc0".U(64.W), Cat(0.U(48.W), f64DownBf16.io.result)),
    8.U -> Mux(pipeF64NaN, "h000000007fc00000".U(64.W), Cat(0.U(32.W), f64DownF32.io.result))))
  val pipeCtrl = f64Ctrl
  val f64Flags = Mux(pipeF64NaNRaw && f64Ctrl.finite_fma, "b00101".U, f64Pipe.io.out.bits.fflags)
  val pipeFlags = f64Flags
  io.resp.bits.result := Mux(pipeRespValid, pipeResult, oldResult)
  io.resp.bits.predicate_result := Mux(pipeRespValid, false.B, Mux(isCmpP, cmpTrue, false.B))
  io.resp.bits.dest := Mux(pipeRespValid, pipeCtrl.dest, held.dest)
  io.resp.bits.error := Mux(pipeRespValid, false.B,
    !((isCmp || isCmpP || isMinMax) || held.op === AecFpOp.neg || held.op === AecFpOp.abs))
  io.resp.bits.exception_flags := Mux(pipeRespValid, pipeFlags,
    0.U)
}

/** Backward-compatible top name used by the original FP differential flow. */
class AecFpUnit extends AecFp64PipeUnit(true)
