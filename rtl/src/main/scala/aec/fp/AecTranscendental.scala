package aec.fp

import chisel3._
import chisel3.util._
import aec.AecOpcode

class AecTransRequest extends Bundle {
  val op = UInt(16.W)
  val in = UInt(32.W)
}

class AecQ34PackRequest extends Bundle {
  val value = SInt(48.W)
  val scale = SInt(12.W)
}

/** Area-oriented, multi-cycle conversion from signed Q34 to IEEE-754 f32. */
class AecQ34ToF32 extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecQ34PackRequest))
    val resp = Decoupled(UInt(32.W))
  })

  val idle :: normalize :: roundValue :: subnormal :: finish :: Nil = Enum(5)
  val state = RegInit(idle)
  val negative = RegInit(false.B)
  val work = RegInit(0.U(48.W))
  val exponent = RegInit(0.S(13.W))
  val guard = RegInit(false.B)
  val sticky = RegInit(false.B)
  val significand = RegInit(0.U(24.W))
  val subnormalRemaining = RegInit(0.U(5.W))
  val result = RegInit(0.U(32.W))

  io.req.ready := state === idle
  io.resp.valid := state === finish
  io.resp.bits := result

  when (io.req.fire) {
    val isNegative = io.req.bits.value < 0.S
    negative := isNegative
    work := Mux(isNegative, -io.req.bits.value, io.req.bits.value).asUInt
    // A one in bit 23 of the unshifted Q34 value has this biased exponent.
    exponent := 116.S + io.req.bits.scale
    guard := false.B
    sticky := false.B
    state := normalize
  }

  when (state === normalize) {
    when (!work.orR) {
      result := Cat(negative, 0.U(31.W))
      state := finish
    }.elsewhen (work(47, 24).orR) {
      sticky := sticky || guard
      guard := work(0)
      work := work >> 1
      exponent := exponent + 1.S
    }.elsewhen (!work(23)) {
      work := work << 1
      exponent := exponent - 1.S
    }.otherwise {
      state := roundValue
    }
  }

  when (state === roundValue) {
    val rounded = Cat(0.U(1.W), work(23, 0)) + (guard && (sticky || work(0)))
    val carry = rounded(24)
    val roundedSignificand = Mux(carry, rounded(24, 1), rounded(23, 0))
    val roundedExponent = exponent + carry.asUInt.zext
    when (roundedExponent >= 255.S) {
      result := Cat(negative, "h7f800000".U(31.W))
      state := finish
    }.elsewhen (roundedExponent <= 0.S) {
      when (roundedExponent < (-23).S) {
        result := Cat(negative, 0.U(31.W))
        state := finish
      }.otherwise {
        significand := roundedSignificand
        subnormalRemaining := (1.S - roundedExponent).asUInt
        state := subnormal
      }
    }.otherwise {
      result := Cat(negative, roundedExponent.asUInt(7, 0), roundedSignificand(22, 0))
      state := finish
    }
  }

  when (state === subnormal) {
    when (subnormalRemaining === 0.U) {
      result := Cat(negative, 0.U(8.W), significand(22, 0))
      state := finish
    }.otherwise {
      significand := significand >> 1
      subnormalRemaining := subnormalRemaining - 1.U
    }
  }

  when (io.resp.fire) { state := idle }
}

/** Resource-serial signed 48x48 multiplier. */
class AecTransMultiplier extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new Bundle {
      val a = SInt(48.W)
      val b = SInt(48.W)
    }))
    val resp = Decoupled(SInt(96.W))
  })

  val busy = RegInit(false.B)
  val valid = RegInit(false.B)
  val negative = Reg(Bool())
  val multiplicand = Reg(UInt(96.W))
  val multiplierBits = Reg(UInt(48.W))
  val accumulator = Reg(UInt(96.W))
  val count = Reg(UInt(6.W))
  val product = Reg(SInt(96.W))

  io.req.ready := !busy && !valid
  io.resp.valid := valid
  io.resp.bits := product
  when (io.req.fire) {
    val absA = Mux(io.req.bits.a < 0.S, (-io.req.bits.a).asUInt, io.req.bits.a.asUInt)
    val absB = Mux(io.req.bits.b < 0.S, (-io.req.bits.b).asUInt, io.req.bits.b.asUInt)
    negative := io.req.bits.a(47) ^ io.req.bits.b(47)
    multiplicand := Cat(0.U(48.W), absA)
    multiplierBits := absB
    accumulator := 0.U
    count := 0.U
    busy := true.B
  }
  when (busy) {
    val nextAccumulator = Mux(multiplierBits(0), accumulator + multiplicand, accumulator)
    when (count === 47.U) {
      product := Mux(negative, -nextAccumulator.asSInt, nextAccumulator.asSInt)
      busy := false.B
      valid := true.B
    }.otherwise {
      accumulator := nextAccumulator
      multiplicand := multiplicand << 1
      multiplierBits := multiplierBits >> 1
      count := count + 1.U
    }
  }
  when (io.resp.fire) { valid := false.B }
}

/** Resource-serial Q34 transcendental engine with one shared multiplier. */
class AecTranscendental extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecTransRequest))
    val resp = Decoupled(UInt(32.W))
  })

  private val Q = 34
  private def q(value: Double): SInt = math.rint(value * (1L << Q).toDouble).toLong.S(48.W)
  private def s48(value: SInt): SInt = { val out = Wire(SInt(48.W)); out := value; out }

  val (idle :: trigScale :: trigReduce :: square :: poly :: trigFinal :: trigSinFinal ::
    expStart :: logNewtonMul :: logNewtonUpdate :: logZ :: logSquare :: logZ3 ::
    logCombine :: logScale :: logFinal :: packStart :: packWait :: finish :: Nil) = Enum(19)
  val state = RegInit(idle)
  val op = Reg(UInt(16.W))
  val x = Reg(SInt(48.W))
  val term = Reg(SInt(48.W))
  val argument2 = Reg(SInt(48.W))
  val accumulator = Reg(SInt(48.W))
  val auxiliary = Reg(SInt(48.W))
  val exponentScale = Reg(SInt(12.W))
  val step = RegInit(0.U(4.W))
  val quadrant = Reg(UInt(2.W))
  val polynomialCos = Reg(Bool())
  val negateResult = Reg(Bool())
  val result = RegInit(0.U(32.W))
  val packValue = Reg(SInt(48.W))
  val packScale = Reg(SInt(12.W))

  // The only fixed-point multiplier in the complete transcendental unit.
  val multiplyA = WireDefault(0.S(48.W))
  val multiplyB = WireDefault(0.S(48.W))
  val multiplier = Module(new AecTransMultiplier)
  val multiplyState = state === trigScale || state === trigReduce || state === square || state === poly ||
    state === trigFinal || state === trigSinFinal || state === expStart || state === logNewtonMul ||
    state === logNewtonUpdate || state === logZ || state === logSquare || state === logCombine ||
    state === logZ3 || state === logScale || state === logFinal
  multiplier.io.req.valid := multiplyState
  multiplier.io.req.bits.a := multiplyA
  multiplier.io.req.bits.b := multiplyB
  multiplier.io.resp.ready := multiplyState
  val multiplyResult = multiplier.io.resp.bits.asUInt(Q + 47, Q).asSInt
  val multiplyValid = multiplier.io.resp.valid

  val inputSign = io.req.bits.in(31)
  val inputExponent = io.req.bits.in(30, 23)
  val inputFraction = io.req.bits.in(22, 0)
  val inputSignificand = Cat(inputExponent.orR, inputFraction)
  val unbiased = inputExponent.zext - 127.S
  val shift = unbiased + (Q - 23).S
  val inputMagnitude = WireDefault(0.U(48.W))
  when (inputExponent.orR) {
    when (shift >= 0.S && shift < 24.S) { inputMagnitude := inputSignificand << shift.asUInt }
      .elsewhen (shift < 0.S && shift > (-32).S) { inputMagnitude := inputSignificand >> (-shift).asUInt }
      .elsewhen (shift >= 24.S) { inputMagnitude := "h7fffffffffff".U }
  }
  val inputQ = Mux(inputSign, -inputMagnitude.asSInt, inputMagnitude.asSInt)
  val inputZero = inputExponent === 0.U && inputFraction === 0.U
  val inputInf = inputExponent.andR && inputFraction === 0.U
  val inputNaN = inputExponent.andR && inputFraction.orR

  val packer = Module(new AecQ34ToF32)
  packer.io.req.valid := state === packStart
  packer.io.req.bits.value := packValue
  packer.io.req.bits.scale := packScale
  packer.io.resp.ready := state === packWait

  def startPack(value: SInt, scale: SInt = 0.S(12.W)): Unit = {
    packValue := s48(value)
    packScale := scale
    state := packStart
  }

  io.req.ready := state === idle
  io.resp.valid := state === finish
  io.resp.bits := result

  when (state === packStart && packer.io.req.ready) { state := packWait }
  when (packer.io.resp.fire) {
    result := packer.io.resp.bits
    state := finish
  }

  val canonicalNaN = "h7fc00000".U(32.W)
  when (io.req.fire) {
    op := io.req.bits.op
    x := inputQ
    step := 0.U
    when (inputNaN || ((io.req.bits.op === AecOpcode.sin || io.req.bits.op === AecOpcode.cos) && inputInf) ||
      (io.req.bits.op === AecOpcode.log && inputSign && !inputZero)) {
      result := canonicalNaN; state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.sin && inputZero) {
      result := io.req.bits.in; state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.cos && inputZero) {
      result := "h3f800000".U; state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.exp && inputInf) {
      result := Mux(inputSign, 0.U, "h7f800000".U); state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.log && inputZero) {
      result := "hff800000".U; state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.log && inputInf) {
      result := "h7f800000".U; state := finish
    }.elsewhen (io.req.bits.op === AecOpcode.sin || io.req.bits.op === AecOpcode.cos) {
      state := trigScale
    }.elsewhen (io.req.bits.op === AecOpcode.exp) {
      exponentScale := (inputQ >> Q).asSInt
      term := inputQ - ((inputQ >> Q) << Q)
      state := expStart
    }.otherwise {
      val mantissa = Cat(0.U(1.W), inputSignificand, 0.U((Q - 23).W)).asSInt
      val halve = mantissa > q(math.sqrt(2.0))
      term := Mux(halve, mantissa >> 1, mantissa)
      exponentScale := unbiased + halve.asUInt.zext
      accumulator := q(0.75) - ((Mux(halve, mantissa >> 1, mantissa) + q(1.0)) >> 3)
      step := 0.U
      state := logNewtonMul
    }
  }

  when (state === trigScale && multiplyValid) {
    multiplyA := x; multiplyB := q(2.0 / math.Pi)
    val signedQuadrant = Mux(multiplyResult >= 0.S,
      (multiplyResult + q(0.5)) >> Q, -((-multiplyResult + q(0.5)) >> Q))
    quadrant := signedQuadrant.asUInt(1, 0)
    auxiliary := signedQuadrant << Q
    state := trigReduce
  }
  when (state === trigReduce && multiplyValid) {
    multiplyA := auxiliary; multiplyB := q(math.Pi / 2.0)
    term := x - multiplyResult
    val odd = quadrant(0)
    polynomialCos := Mux(op === AecOpcode.sin, odd, !odd)
    negateResult := Mux(op === AecOpcode.sin, quadrant(1), quadrant(1) ^ quadrant(0))
    state := square
  }
  when (state === square && multiplyValid) {
    multiplyA := term; multiplyB := term
    argument2 := multiplyResult
    accumulator := Mux(polynomialCos, q(-1.0 / 3628800.0), q(-1.0 / 39916800.0))
    step := 0.U
    state := poly
  }
  when (state === poly && step < 4.U && multiplyValid) {
    multiplyA := argument2; multiplyB := accumulator
    val sinCoefficient = MuxLookup(step, q(0.0), Seq(0.U -> q(1.0 / 362880.0), 1.U -> q(-1.0 / 5040.0),
      2.U -> q(1.0 / 120.0), 3.U -> q(-1.0 / 6.0)))
    val cosCoefficient = MuxLookup(step, q(0.0), Seq(0.U -> q(1.0 / 40320.0), 1.U -> q(-1.0 / 720.0),
      2.U -> q(1.0 / 24.0), 3.U -> q(-1.0 / 2.0)))
    accumulator := multiplyResult + Mux(polynomialCos, cosCoefficient, sinCoefficient)
    when (step === 3.U) { state := trigFinal }.otherwise { step := step + 1.U }
  }
  when (state === trigFinal && multiplyValid) {
    multiplyA := argument2; multiplyB := accumulator
    val inner = q(1.0) + multiplyResult
    when (polynomialCos) {
      startPack(Mux(negateResult, -inner, inner))
    }.otherwise {
      accumulator := inner; state := trigSinFinal
    }
  }
  when (state === trigSinFinal && multiplyValid) {
    multiplyA := term; multiplyB := accumulator
    startPack(Mux(negateResult, -multiplyResult, multiplyResult))
  }

  when (state === expStart && multiplyValid) {
    multiplyA := term; multiplyB := q(math.log(2.0))
    term := multiplyResult
    accumulator := q(1.0 / 3628800.0)
    step := 0.U
    state := poly
    polynomialCos := false.B
    // step values 4..13 distinguish EXP from the trigonometric polynomial.
    step := 4.U
  }
  when (state === poly && step >= 4.U && multiplyValid) {
    multiplyA := term; multiplyB := accumulator
    val coefficient = MuxLookup(step, q(1.0), Seq(
      4.U -> q(1.0 / 362880.0), 5.U -> q(1.0 / 40320.0), 6.U -> q(1.0 / 5040.0),
      7.U -> q(1.0 / 720.0), 8.U -> q(1.0 / 120.0), 9.U -> q(1.0 / 24.0),
      10.U -> q(1.0 / 6.0), 11.U -> q(1.0 / 2.0), 12.U -> q(1.0), 13.U -> q(1.0)))
    accumulator := coefficient + multiplyResult
    when (step === 13.U) { startPack(coefficient + multiplyResult, exponentScale) }
      .otherwise { step := step + 1.U }
  }

  val denominator = term + q(1.0)
  switch (state) {
    is (trigScale) { multiplyA := x; multiplyB := q(2.0 / math.Pi) }
    is (trigReduce) { multiplyA := auxiliary; multiplyB := q(math.Pi / 2.0) }
    is (square) { multiplyA := term; multiplyB := term }
    is (poly) {
      multiplyA := Mux(step < 4.U, argument2, term)
      multiplyB := accumulator
    }
    is (trigFinal) { multiplyA := argument2; multiplyB := accumulator }
    is (trigSinFinal) { multiplyA := term; multiplyB := accumulator }
    is (expStart) { multiplyA := term; multiplyB := q(math.log(2.0)) }
    is (logNewtonMul) { multiplyA := denominator; multiplyB := accumulator }
    is (logNewtonUpdate) { multiplyA := accumulator; multiplyB := auxiliary }
    is (logZ) { multiplyA := term - q(1.0); multiplyB := accumulator }
    is (logSquare) { multiplyA := term; multiplyB := term }
    is (logCombine) { multiplyA := argument2; multiplyB := accumulator }
    is (logZ3) { multiplyA := term; multiplyB := argument2 }
    is (logScale) { multiplyA := auxiliary; multiplyB := accumulator }
    is (logFinal) { multiplyA := auxiliary; multiplyB := q(2.0 / math.log(2.0)) }
  }
  when (state === logNewtonMul && multiplyValid) {
    multiplyA := denominator; multiplyB := accumulator
    auxiliary := q(2.0) - multiplyResult
    state := logNewtonUpdate
  }
  when (state === logNewtonUpdate && multiplyValid) {
    multiplyA := accumulator; multiplyB := auxiliary
    accumulator := multiplyResult
    when (step === 2.U) { state := logZ }.otherwise { step := step + 1.U; state := logNewtonMul }
  }
  when (state === logZ && multiplyValid) {
    multiplyA := term - q(1.0); multiplyB := accumulator
    term := multiplyResult
    state := logSquare
  }
  when (state === logSquare && multiplyValid) {
    multiplyA := term; multiplyB := term
    argument2 := multiplyResult
    accumulator := q(1.0 / 13.0)
    step := 0.U
    state := logCombine
  }
  when (state === logCombine && multiplyValid) {
    multiplyA := argument2; multiplyB := accumulator
    val coefficient = MuxLookup(step, q(1.0 / 3.0), Seq(0.U -> q(1.0 / 11.0), 1.U -> q(1.0 / 9.0),
      2.U -> q(1.0 / 7.0), 3.U -> q(1.0 / 5.0), 4.U -> q(1.0 / 3.0)))
    accumulator := coefficient + multiplyResult
    when (step === 4.U) { state := logZ3 }.otherwise { step := step + 1.U }
  }
  when (state === logZ3 && multiplyValid) {
    multiplyA := term; multiplyB := argument2
    auxiliary := multiplyResult
    state := logScale
  }
  when (state === logScale && multiplyValid) {
    multiplyA := auxiliary; multiplyB := accumulator
    auxiliary := term + multiplyResult
    state := logFinal
  }
  when (state === logFinal && multiplyValid) {
    multiplyA := auxiliary; multiplyB := q(2.0 / math.log(2.0))
    startPack((exponentScale << Q) + multiplyResult)
  }

  when (io.resp.fire) { state := idle }
}
