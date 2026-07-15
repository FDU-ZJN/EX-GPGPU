package aec.int

import chisel3._
import chisel3.util._
import aec.AecOpcode

/** Lane-local request for the integer/logical execution unit. */
class AecIntRequest extends Bundle {
  val op = UInt(16.W)
  val dtype = UInt(4.W)
  val a = UInt(32.W)
  val b = UInt(32.W)
  val c = UInt(32.W)
  val dest = UInt(8.W)
  val selectPredicate = Bool()
}

class AecIntResponse extends Bundle {
  val result = UInt(32.W)
  val predicateResult = Bool()
  val dest = UInt(8.W)
  val error = Bool()
}

/** Elastic lane-local request register with an unconditionally sampled payload. */
class AecIntRequestStage extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new AecIntRequest))
    val out = Decoupled(new AecIntRequest)
  })

  val data = RegNext(io.in.bits)
  val valid = RegInit(false.B)
  io.in.ready := !valid || io.out.ready
  io.out.valid := valid
  io.out.bits := data
  when (io.in.ready) { valid := io.in.valid }
}

/** Two-stage lane-local architectural-group selection for a physical lane. */
class AecIntWarpRequestStage(val groups: Int) extends Module {
  require(groups > 0)
  val io = IO(new Bundle {
    val inValid = Input(Bool())
    val inReady = Output(Bool())
    val group = Input(UInt(log2Ceil(groups max 2).W))
    val data = Input(Vec(groups, new AecIntRequest))
    val out = Decoupled(new AecIntRequest)
  })

  val selectValid = RegInit(false.B)
  val selectedGroup = Reg(UInt(log2Ceil(groups max 2).W))
  val dataValid = RegInit(false.B)
  val data = Reg(new AecIntRequest)
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
}

/**
  * One lane's integer and bit-manipulation ALU.
  *
  * The request is held for one response cycle.  Division is expressed in the
  * same interface and has the architecturally required divide-by-zero error;
  * keeping this boundary independent allows a restoring divider to replace
  * the current implementation without changing Warp.
  */
class AecIntAlu extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecIntRequest))
    val resp = Decoupled(new AecIntResponse)
  })

  val (idle :: multiply :: shiftRun :: bitfieldShift :: bitfieldMask ::
    bitfieldMaskShift :: respond :: Nil) = Enum(7)
  val state = RegInit(idle)
  val result = RegInit(0.U(32.W))
  val predicateResult = RegInit(false.B)
  val dest = RegInit(0.U(8.W))
  val error = RegInit(false.B)

  // Long-latency operations are mutually exclusive, so they share a compact
  // work bank instead of retaining separate multiplier, shifter and bitfield
  // datapaths.
  val workValue = Reg(UInt(32.W))
  val workAux = Reg(UInt(32.W))
  val workAccum = Reg(UInt(32.W))
  val workCount = Reg(UInt(6.W))
  val multiplyAddend = Reg(UInt(32.W))
  val multiplyMad = Reg(Bool())
  val shiftRight = Reg(Bool())
  val shiftArithmetic = Reg(Bool())
  val bitfieldLsb = Reg(UInt(6.W))
  val bitfieldWidth = Reg(UInt(6.W))
  val bitfieldInsert = Reg(Bool())
  val bitfieldSigned = Reg(Bool())

  io.req.ready := state === idle
  io.resp.valid := state === respond
  io.resp.bits.result := result
  io.resp.bits.predicateResult := predicateResult
  io.resp.bits.dest := dest
  io.resp.bits.error := error

  val isSigned = io.req.bits.dtype === 3.U
  val aS = io.req.bits.a.asSInt
  val bS = io.req.bits.b.asSInt
  val a = io.req.bits.a
  val b = io.req.bits.b
  val c = io.req.bits.c
  val shift = b(4, 0)
  val isCmp = io.req.bits.op === AecOpcode.cmp
  val isCmmP = io.req.bits.op === AecOpcode.cmpp
  val relation = c(2, 0)

  val cmpEq = a === b
  val cmpLt = Mux(isSigned, aS < bS, a < b)
  val cmpGt = Mux(isSigned, aS > bS, a > b)
  val cmpResult = MuxLookup(relation, false.B, Seq(
    0.U -> cmpEq, 1.U -> !cmpEq, 2.U -> cmpLt,
    3.U -> (cmpLt || cmpEq), 4.U -> cmpGt, 5.U -> (cmpGt || cmpEq)))

  val aluResult = WireDefault(0.U(32.W))
  val aluPredicate = WireDefault(false.B)
  val aluError = WireDefault(false.B)
  when (isCmp || isCmmP) {
    aluResult := cmpResult.asUInt
    aluPredicate := cmpResult
  }.elsewhen (io.req.bits.op === AecOpcode.add) {
    aluResult := a + b
  }.elsewhen (io.req.bits.op === AecOpcode.sub) {
    aluResult := a - b
  }.elsewhen (io.req.bits.op === AecOpcode.mul || io.req.bits.op === AecOpcode.mad) {
    aluResult := 0.U
  }.elsewhen (io.req.bits.op === AecOpcode.div) {
    // DIV is deliberately not an execution-unit feature in this submission.
    // The frontend turns its legal encoding into a diagnostic assertion before
    // dispatch; retain this defensive error in case of an integration bypass.
    aluError := true.B
  }.elsewhen (io.req.bits.op === AecOpcode.neg) {
    aluResult := (-aS).asUInt
  }.elsewhen (io.req.bits.op === AecOpcode.abs) {
    aluResult := Mux(aS < 0.S, (-aS).asUInt, a)
  }.elsewhen (io.req.bits.op === AecOpcode.min) {
    aluResult := Mux(isSigned, Mux(aS < bS, a, b), Mux(a < b, a, b))
  }.elsewhen (io.req.bits.op === AecOpcode.max) {
    aluResult := Mux(isSigned, Mux(aS > bS, a, b), Mux(a > b, a, b))
  }.elsewhen (io.req.bits.op === AecOpcode.andOp) {
    aluResult := a & b
  }.elsewhen (io.req.bits.op === AecOpcode.orOp) {
    aluResult := a | b
  }.elsewhen (io.req.bits.op === AecOpcode.xorOp) {
    aluResult := a ^ b
  }.elsewhen (io.req.bits.op === AecOpcode.notOp) {
    aluResult := ~a
  }.elsewhen (io.req.bits.op === AecOpcode.shl || io.req.bits.op === AecOpcode.shr ||
    io.req.bits.op === AecOpcode.bfx || io.req.bits.op === AecOpcode.bins) {
    aluResult := 0.U
  }.elsewhen (io.req.bits.op === AecOpcode.popc) {
    aluResult := PopCount(a)
  }.elsewhen (io.req.bits.op === AecOpcode.flo) {
    // PriorityEncoder selects the least-significant set bit.  Reverse the
    // input so the selected position is the architectural MSB index.
    aluResult := 31.U - PriorityEncoder(Reverse(a))
    when (a === 0.U) { aluResult := "hffffffff".U }
  }.elsewhen (io.req.bits.op === AecOpcode.sel) {
    aluResult := Mux(io.req.bits.selectPredicate, a, b)
  }.elsewhen (io.req.bits.op === AecOpcode.pick) {
    aluResult := Mux(a(31), b, a)
  }.otherwise {
    aluError := true.B
  }

  when (io.req.fire) {
    dest := io.req.bits.dest
    predicateResult := false.B
    error := false.B
    when (io.req.bits.op === AecOpcode.mul || io.req.bits.op === AecOpcode.mad) {
      workValue := a
      workAux := b
      workAccum := 0.U
      workCount := 0.U
      multiplyAddend := c
      multiplyMad := io.req.bits.op === AecOpcode.mad
      state := multiply
    }.elsewhen (io.req.bits.op === AecOpcode.shl || io.req.bits.op === AecOpcode.shr) {
      workValue := a
      workCount := Cat(0.U(1.W), shift)
      shiftRight := io.req.bits.op === AecOpcode.shr
      shiftArithmetic := io.req.bits.op === AecOpcode.shr && isSigned
      state := shiftRun
    }.elsewhen (io.req.bits.op === AecOpcode.bfx || io.req.bits.op === AecOpcode.bins) {
      val lsb = c(7, 0)
      val width = c(15, 8)
      val valid = lsb <= 31.U && width <= 32.U && lsb +& width <= 32.U
      when (!valid) {
        result := 0.U
        error := true.B
        state := respond
      }.otherwise {
        workAccum := a
        workValue := Mux(io.req.bits.op === AecOpcode.bins, b, a)
        workAux := 0.U
        bitfieldLsb := lsb(5, 0)
        workCount := lsb(5, 0)
        bitfieldWidth := width(5, 0)
        bitfieldInsert := io.req.bits.op === AecOpcode.bins
        bitfieldSigned := isSigned
        state := bitfieldShift
      }
    }.otherwise {
      result := aluResult
      predicateResult := aluPredicate
      error := aluError
      state := respond
    }
  }

  when (state === multiply) {
    val nextProduct = Mux(workAux(0), workAccum + workValue, workAccum)
    workAccum := nextProduct
    workValue := workValue << 1
    workAux := workAux >> 1
    when (workCount === 31.U) {
      result := Mux(multiplyMad, nextProduct + multiplyAddend, nextProduct)
      state := respond
    }.otherwise { workCount := workCount + 1.U }
  }

  when (state === shiftRun) {
    val right = Mux(shiftArithmetic,
      Cat(workValue(31), workValue(31, 1)), Cat(0.U(1.W), workValue(31, 1)))
    val nextValue = Mux(shiftRight, right, Cat(workValue(30, 0), 0.U(1.W)))
    when (workCount === 0.U) {
      result := workValue
      state := respond
    }.otherwise {
      workValue := nextValue
      workCount := workCount - 1.U
      when (workCount === 1.U) {
        result := nextValue
        state := respond
      }
    }
  }

  when (state === bitfieldShift) {
    when (workCount === 0.U) {
      workCount := bitfieldWidth
      state := bitfieldMask
    }.otherwise {
      workValue := Mux(bitfieldInsert, workValue << 1, workValue >> 1)
      workCount := workCount - 1.U
    }
  }
  when (state === bitfieldMask) {
    when (workCount === 0.U) {
      when (bitfieldInsert) {
        workCount := bitfieldLsb
        state := bitfieldMaskShift
      }.otherwise {
        val extracted = workValue & workAux
        val signBit = (extracted & ((workAux + 1.U) >> 1)).orR
        result := Mux(bitfieldSigned && signBit, extracted | ~workAux, extracted)
        state := respond
      }
    }.otherwise {
      workAux := (workAux << 1) | 1.U
      workCount := workCount - 1.U
    }
  }
  when (state === bitfieldMaskShift) {
    when (workCount === 0.U) {
      result := (workAccum & ~workAux) | (workValue & workAux)
      state := respond
    }.otherwise {
      workAux := workAux << 1
      workCount := workCount - 1.U
    }
  }

  when (io.resp.fire) { state := idle }
}
