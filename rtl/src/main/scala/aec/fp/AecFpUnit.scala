package aec.fp

import chisel3._
import chisel3.util._
import chisel3.experimental.{annotate, ChiselAnnotation}
import firrtl.AttributeAnnotation
import hardfloat._
import fudian.FPToFP
import aec.fp.yunsuan.YunSuanFmaPipe

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

/** A request tagged at issue so independently pipelined operation classes can
  * complete out of order while the lane still retires in architectural order.
  */
class AecFpTaggedRequest extends Bundle {
  val seq = UInt(6.W)
  val req = new AecFpRequest
}

/** Elastic lane-local request register with an unconditionally sampled payload. */
class AecFpWarpRequestStage(val groups: Int, val selectorChunkWidth: Int = 1) extends Module {
  require(groups > 0)
  require(selectorChunkWidth > 0)
  val io = IO(new Bundle {
    val inValid = Input(Bool())
    val inReady = Output(Bool())
    val group = Input(UInt(log2Ceil(groups max 2).W))
    val data = Input(Vec(groups, new AecFpRequest))
    val out = Decoupled(new AecFpRequest)
  })

  if (groups <= 4) {
    val dataValid = RegInit(false.B)
    val data = Reg(new AecFpRequest)
    val selectValid = RegInit(false.B)
    val selectedGroup = Reg(UInt(log2Ceil(groups max 2).W))
    val dataReady = !dataValid || io.out.ready
    val selectReady = !selectValid || dataReady

    io.inReady := selectReady
    io.out.valid := dataValid
    io.out.bits := data
    when (dataReady) {
      dataValid := selectValid
      when (selectValid) { data := io.data(selectedGroup) }
    }
    when (selectReady) {
      selectValid := io.inValid
      when (io.inValid) { selectedGroup := io.group }
    }
  } else {
    require(groups % 4 == 0)
    val banks = groups / 4
    val requestWidth = 7 + 4 + 3 * 64 + 8
    // Replicate selectors per payload chunk so synthesis cannot merge them
    // into one warp-wide high-fanout mux control.  FP64 uses 16-bit chunks to
    // balance selector fanout against the register and mux duplication caused
    // by the original one-selector-per-bit implementation.
    val chunkWidth = selectorChunkWidth
    val chunks = (requestWidth + chunkWidth - 1) / chunkWidth
    val encodedSelectorWidth = 8
    def selectorCode(id: Int, value: Int): UInt =
      (((id + 1) * 37 + value * (2 * id + 3) * 19 + value * value * 11) & 0xff).U(encodedSelectorWidth.W)
    def encodeSelector(value: UInt, id: Int, choices: Int): UInt =
      MuxLookup(value, selectorCode(id, 0),
        (0 until choices).map(v => v.U -> selectorCode(id, v)))
    val selectValid = RegInit(false.B)
    // Keep a physically independent low selector for each payload chunk.
    // Without the keep attributes Yosys merges equivalent registers and the
    // resulting selector drives the full 211-bit request payload.
    val lowSelect = Reg(Vec(banks, Vec(chunks, UInt(encodedSelectorWidth.W))))
    lowSelect.foreach(_.foreach { selector =>
      dontTouch(selector)
      annotate(new ChiselAnnotation {
        override def toFirrtl = AttributeAnnotation(selector.toTarget, "keep = \"true\"")
      })
    })
    val highSelect = Reg(Vec(chunks, UInt(encodedSelectorWidth.W)))
    highSelect.foreach { selector =>
      dontTouch(selector)
      annotate(new ChiselAnnotation {
        override def toFirrtl = AttributeAnnotation(selector.toTarget, "keep = \"true\"")
      })
    }
    val selectedBank = Reg(Vec(chunks, UInt(encodedSelectorWidth.W)))
    selectedBank.foreach { selector =>
      dontTouch(selector)
      annotate(new ChiselAnnotation {
        override def toFirrtl = AttributeAnnotation(selector.toTarget, "keep = \"true\"")
      })
    }
    val bankData = Reg(Vec(banks, new AecFpRequest))
    val outputValid = RegInit(false.B)
    val outputReady = !outputValid || io.out.ready
    val selectReady = !selectValid || outputReady

    io.inReady := selectReady
    io.out.valid := outputValid
    val outputChunks = (0 until chunks).map { chunk =>
      val lo = chunk * chunkWidth
      val hi = math.min(requestWidth, lo + chunkWidth) - 1
      val selectorId = banks * chunks + chunk
      MuxLookup(selectedBank(chunk), bankData.head.asUInt(hi, lo),
        (0 until banks).map(bank => selectorCode(selectorId, bank) -> bankData(bank).asUInt(hi, lo)))
    }
    io.out.bits := Cat(outputChunks.reverse).asTypeOf(new AecFpRequest)

    // First register and replicate the narrow select.  Each copy drives only
    // one four-way payload bank, avoiding a warp-level group bit with hundreds
    // of data-mux loads.  Both stages support simultaneous replacement, so
    // this is a latency cut rather than a throughput cut.
    when (outputReady) {
      outputValid := selectValid
      when (selectValid) {
        selectedBank.zip(highSelect).foreach { case (selected, high) => selected := high }
      }
    }
    // The warp payload and registered low selectors remain stable while this
    // stage is blocked.  Sampling each bank every cycle removes outputReady
    // from the write enable of the complete 844-bit bank array.
    for (bank <- 0 until banks) {
      val selectedChunks = (0 until chunks).map { chunk =>
        val lo = chunk * chunkWidth
        val hi = math.min(requestWidth, lo + chunkWidth) - 1
        val selectorId = bank * chunks + chunk
        MuxLookup(lowSelect(bank)(chunk), io.data(bank * 4).asUInt(hi, lo),
          (0 until 4).map(index => selectorCode(selectorId, index) ->
            io.data(bank * 4 + index).asUInt(hi, lo)))
      }
      bankData(bank) := Cat(selectedChunks.reverse).asTypeOf(new AecFpRequest)
    }
    when (selectReady) {
      selectValid := io.inValid
      when (io.inValid) {
        for (bank <- 0 until banks; chunk <- 0 until chunks) {
          lowSelect(bank)(chunk) := encodeSelector(io.group(1, 0), bank * chunks + chunk, 4)
        }
        for (chunk <- 0 until chunks) {
          highSelect(chunk) := encodeSelector(io.group(log2Ceil(groups) - 1, 2),
            banks * chunks + chunk, banks)
        }
      }
    }
  }
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
class AecFp64PipeUnit(val acceptNarrow: Boolean = true,
    val warpIntegrated: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecFpRequest))
    val resp = Decoupled(new AecFpResponse)
  })

  val reqPipe =
    (io.req.bits.op === AecFpOp.add || io.req.bits.op === AecFpOp.sub ||
      io.req.bits.op === AecFpOp.mul || io.req.bits.op === AecFpOp.fma)
  val f64Pipe = Module(new YunSuanFmaPipe(3, if (warpIntegrated) 1 else 8))

  val arithmeticReq = io.req.bits
  // Exact widening converters, including subnormals and NaN classification.
  val f16Up = Seq.fill(3)(Module(new FPToFP(5, 11, 11, 53)))
  val bf16Up = Seq.fill(3)(Module(new FPToFP(8, 8, 11, 53)))
  val f32Up = Seq.fill(3)(Module(new FPToFP(8, 24, 11, 53)))
  val reqLowOperands = Seq(arithmeticReq.a(15, 0), arithmeticReq.b(15, 0), arithmeticReq.c(15, 0))
  f16Up.zip(reqLowOperands).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  bf16Up.zip(reqLowOperands).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  f32Up.zip(Seq(arithmeticReq.a(31, 0), arithmeticReq.b(31, 0), arithmeticReq.c(31, 0))).foreach { case (cvt, in) => cvt.io.in := in; cvt.io.rm := 0.U }
  def reqOperand64(index: Int): UInt = {
    val native = Seq(arithmeticReq.a, arithmeticReq.b, arithmeticReq.c)(index)
    if (acceptNarrow) {
      MuxLookup(arithmeticReq.dtype, native, Seq(
        10.U -> f16Up(index).io.result, 11.U -> bf16Up(index).io.result,
        8.U -> f32Up(index).io.result, 9.U -> native))
    } else native
  }
  val reqDtypeSupported = if (acceptNarrow) true.B else io.req.bits.dtype === 9.U
  f64Pipe.io.req.bits.op := arithmeticReq.op
  f64Pipe.io.req.bits.a := reqOperand64(0)
  f64Pipe.io.req.bits.b := reqOperand64(1)
  f64Pipe.io.req.bits.c := reqOperand64(2)
  f64Pipe.io.req.bits.format := 3.U
  val pipeSeq = Wire(UInt(6.W))
  f64Pipe.io.req.bits.seq := pipeSeq
  f64Pipe.io.req.bits.dest := arithmeticReq.dest
  f64Pipe.io.req.bits.dtype := arithmeticReq.dtype
  val held = Wire(new AecFpRequest)
  val f64AtHead = Wire(Bool())
  val oldAtHead = Wire(Bool())
  val integratedSimpleCapture = WireDefault(false.B)
  val integratedSimpleResp = if (warpIntegrated) Some(Reg(new AecFpResponse)) else None

  if (warpIntegrated) {
    val busy = RegInit(false.B)
    val pipePending = RegInit(false.B)
    pipeSeq := 0.U
    held := io.req.bits
    f64Pipe.io.req.valid := io.req.valid && reqPipe && reqDtypeSupported && !busy
    io.req.ready := reqDtypeSupported && !busy && Mux(reqPipe, f64Pipe.io.req.ready, true.B)
    f64AtHead := busy && pipePending && f64Pipe.io.resp.valid
    oldAtHead := busy && !pipePending
    integratedSimpleCapture := io.req.fire && !reqPipe
    when (io.req.fire) {
      busy := true.B
      pipePending := reqPipe
    }
    when (io.resp.fire) { busy := false.B }
  } else {
    val issueQ = Module(new Queue(UInt(6.W), entries = 16, pipe = false))
    val simpleQ = Module(new Queue(new AecFpTaggedRequest, entries = 4, pipe = false))
    val issueSeq = RegInit(0.U(6.W))
    pipeSeq := issueSeq
    f64Pipe.io.req.valid := io.req.valid && reqPipe && reqDtypeSupported && issueQ.io.enq.ready
    val selectedReady = Mux(reqPipe, f64Pipe.io.req.ready, simpleQ.io.enq.ready)
    io.req.ready := reqDtypeSupported && issueQ.io.enq.ready && selectedReady
    issueQ.io.enq.valid := io.req.fire
    issueQ.io.enq.bits := issueSeq
    simpleQ.io.enq.valid := io.req.valid && !reqPipe && reqDtypeSupported && issueQ.io.enq.ready
    simpleQ.io.enq.bits.seq := issueSeq
    simpleQ.io.enq.bits.req := io.req.bits
    when (io.req.fire) { issueSeq := issueSeq + 1.U }
    held := simpleQ.io.deq.bits.req
    f64AtHead := f64Pipe.io.resp.valid && issueQ.io.deq.valid && f64Pipe.io.resp.bits.seq === issueQ.io.deq.bits
    oldAtHead := simpleQ.io.deq.valid && issueQ.io.deq.valid && simpleQ.io.deq.bits.seq === issueQ.io.deq.bits
    issueQ.io.deq.ready := io.resp.fire
    simpleQ.io.deq.ready := io.resp.ready && oldAtHead
  }

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
  val pipeRespValid = f64AtHead
  io.resp.valid := pipeRespValid || oldAtHead
  f64Pipe.io.resp.ready := io.resp.ready && f64AtHead
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
  val pipeF64Raw = f64Pipe.io.resp.bits.result
  val pipeF64NaNRaw = pipeF64Raw(62,52) === 2047.U && pipeF64Raw(51,0).orR
  val pipeF64Fixed = pipeF64Raw
  f64DownF16.io.in := pipeF64Fixed; f64DownF16.io.rm := 0.U
  f64DownBf16.io.in := pipeF64Fixed; f64DownBf16.io.rm := 0.U
  f64DownF32.io.in := pipeF64Fixed; f64DownF32.io.rm := 0.U
  val pipeF64NaN = pipeF64Fixed(62,52) === 2047.U && pipeF64Fixed(51,0).orR
  val pipeResult = MuxLookup(f64Pipe.io.resp.bits.dtype, pipeF64Fixed, Seq(
    10.U -> Mux(pipeF64NaN, "h0000000000007e00".U(64.W), Cat(0.U(48.W), f64DownF16.io.result)),
    11.U -> Mux(pipeF64NaN, "h0000000000007fc0".U(64.W), Cat(0.U(48.W), f64DownBf16.io.result)),
    8.U -> Mux(pipeF64NaN, "h000000007fc00000".U(64.W), Cat(0.U(32.W), f64DownF32.io.result))))
  val pipeFlags = f64Pipe.io.resp.bits.fflags
  val oldPredicate = Mux(isCmpP, cmpTrue, false.B)
  val oldError = !((isCmp || isCmpP || isMinMax) || held.op === AecFpOp.neg || held.op === AecFpOp.abs)
  if (warpIntegrated) {
    when (integratedSimpleCapture) {
      integratedSimpleResp.get.result := oldResult
      integratedSimpleResp.get.predicate_result := oldPredicate
      integratedSimpleResp.get.dest := held.dest
      integratedSimpleResp.get.error := oldError
      integratedSimpleResp.get.exception_flags := 0.U
    }
    io.resp.bits.result := Mux(pipeRespValid, pipeResult, integratedSimpleResp.get.result)
    io.resp.bits.predicate_result := Mux(pipeRespValid, false.B, integratedSimpleResp.get.predicate_result)
    io.resp.bits.dest := Mux(pipeRespValid, f64Pipe.io.resp.bits.dest, integratedSimpleResp.get.dest)
    io.resp.bits.error := Mux(pipeRespValid, false.B, integratedSimpleResp.get.error)
    io.resp.bits.exception_flags := Mux(pipeRespValid, pipeFlags, integratedSimpleResp.get.exception_flags)
  } else {
    io.resp.bits.result := Mux(pipeRespValid, pipeResult, oldResult)
    io.resp.bits.predicate_result := Mux(pipeRespValid, false.B, oldPredicate)
    io.resp.bits.dest := Mux(pipeRespValid, f64Pipe.io.resp.bits.dest, held.dest)
    io.resp.bits.error := Mux(pipeRespValid, false.B, oldError)
    io.resp.bits.exception_flags := Mux(pipeRespValid, pipeFlags, 0.U)
  }
}

/** Backward-compatible top name used by the original FP differential flow. */
class AecFpUnit extends AecFp64PipeUnit(true)
