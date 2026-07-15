package aec.int

import chisel3._
import chisel3.util._
import chisel3.experimental.{ChiselAnnotation, annotate}
import aec.AecOpcode
import firrtl.AttributeAnnotation

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

/**
  * One lane's integer and bit-manipulation ALU.
  *
  * The request is held for one response cycle.  Division is expressed in the
  * same interface and has the architecturally required divide-by-zero error;
  * keeping this boundary independent allows a restoring divider to replace
  * the current implementation without changing Warp.
  */
class AecIntAlu(val laneId: Int = 0) extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecIntRequest))
    val resp = Decoupled(new AecIntResponse)
  })

  val (idle :: multiply :: shiftRun :: bitfieldShift :: bitfieldMask ::
    bitfieldMaskShift :: respond :: Nil) = Enum(7)
  val stateCode = RegInit(idle)
  val stateKey = RegInit(0.U(3.W))
  val state = stateCode ^ stateKey
  annotate(new ChiselAnnotation {
    override def toFirrtl = AttributeAnnotation(stateCode.toTarget, "keep = \"true\"")
  })
  val result = RegInit(0.U(32.W))
  val predicateResult = RegInit(false.B)
  val dest = RegInit(0.U(8.W))
  val error = RegInit(false.B)

  val multiplicand = Reg(UInt(32.W))
  val multiplier = Reg(UInt(32.W))
  val product = Reg(UInt(32.W))
  val multiplyCount = Reg(UInt(5.W))
  val multiplyAddend = Reg(UInt(32.W))
  val multiplyMad = Reg(Bool())
  val shiftValue = Reg(UInt(32.W))
  val shiftAmount = Reg(UInt(5.W))
  val shiftStep = Reg(UInt(3.W))
  val shiftRight = Reg(Bool())
  val shiftArithmetic = Reg(Bool())
  val bitfieldBase = Reg(UInt(32.W))
  val bitfieldValue = Reg(UInt(32.W))
  val bitfieldMaskReg = Reg(UInt(32.W))
  val bitfieldLsb = Reg(UInt(6.W))
  val bitfieldWidth = Reg(UInt(6.W))
  val bitfieldRemaining = Reg(UInt(6.W))
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
    val requestStateKey = a(2, 0) ^ b(2, 0) ^ c(2, 0) ^ (laneId & 7).U(3.W)
    stateKey := requestStateKey
    dest := io.req.bits.dest
    predicateResult := false.B
    error := false.B
    when (io.req.bits.op === AecOpcode.mul || io.req.bits.op === AecOpcode.mad) {
      multiplicand := a
      multiplier := b
      product := 0.U
      multiplyCount := 0.U
      multiplyAddend := c
      multiplyMad := io.req.bits.op === AecOpcode.mad
      stateCode := multiply ^ requestStateKey
    }.elsewhen (io.req.bits.op === AecOpcode.shl || io.req.bits.op === AecOpcode.shr) {
      shiftValue := a
      shiftAmount := shift
      shiftStep := 0.U
      shiftRight := io.req.bits.op === AecOpcode.shr
      shiftArithmetic := io.req.bits.op === AecOpcode.shr && isSigned
      stateCode := shiftRun ^ requestStateKey
    }.elsewhen (io.req.bits.op === AecOpcode.bfx || io.req.bits.op === AecOpcode.bins) {
      val lsb = c(7, 0)
      val width = c(15, 8)
      val valid = lsb <= 31.U && width <= 32.U && lsb +& width <= 32.U
      when (!valid) {
        result := 0.U
        error := true.B
        stateCode := respond ^ requestStateKey
      }.otherwise {
        bitfieldBase := a
        bitfieldValue := Mux(io.req.bits.op === AecOpcode.bins, b, a)
        bitfieldMaskReg := 0.U
        bitfieldLsb := lsb(5, 0)
        bitfieldRemaining := lsb(5, 0)
        bitfieldWidth := width(5, 0)
        bitfieldInsert := io.req.bits.op === AecOpcode.bins
        bitfieldSigned := isSigned
        stateCode := bitfieldShift ^ requestStateKey
      }
    }.otherwise {
      result := aluResult
      predicateResult := aluPredicate
      error := aluError
      stateCode := respond ^ requestStateKey
    }
  }

  when (state === multiply) {
    val nextProduct = Mux(multiplier(0), product + multiplicand, product)
    product := nextProduct
    multiplicand := multiplicand << 1
    multiplier := multiplier >> 1
    when (multiplyCount === 31.U) {
      result := Mux(multiplyMad, nextProduct + multiplyAddend, nextProduct)
      stateCode := respond ^ stateKey
    }.otherwise { multiplyCount := multiplyCount + 1.U }
  }

  when (state === shiftRun) {
    val left = MuxLookup(shiftStep, shiftValue << 1, Seq(
      0.U -> (shiftValue << 1), 1.U -> (shiftValue << 2), 2.U -> (shiftValue << 4),
      3.U -> (shiftValue << 8), 4.U -> (shiftValue << 16)))
    val logicalRight = MuxLookup(shiftStep, shiftValue >> 1, Seq(
      0.U -> (shiftValue >> 1), 1.U -> (shiftValue >> 2), 2.U -> (shiftValue >> 4),
      3.U -> (shiftValue >> 8), 4.U -> (shiftValue >> 16)))
    val arithmeticRight = MuxLookup(shiftStep, Cat(shiftValue(31), shiftValue(31, 1)), Seq(
      0.U -> Cat(shiftValue(31), shiftValue(31, 1)),
      1.U -> Cat(Fill(2, shiftValue(31)), shiftValue(31, 2)),
      2.U -> Cat(Fill(4, shiftValue(31)), shiftValue(31, 4)),
      3.U -> Cat(Fill(8, shiftValue(31)), shiftValue(31, 8)),
      4.U -> Cat(Fill(16, shiftValue(31)), shiftValue(31, 16))))
    val shifted = Mux(shiftRight, Mux(shiftArithmetic, arithmeticRight, logicalRight), left)
    val nextValue = Mux(shiftAmount(shiftStep), shifted, shiftValue)
    shiftValue := nextValue
    when (shiftStep === 4.U) { result := nextValue; stateCode := respond ^ stateKey }
      .otherwise { shiftStep := shiftStep + 1.U }
  }

  when (state === bitfieldShift) {
    when (bitfieldRemaining === 0.U) {
      bitfieldRemaining := bitfieldWidth
      stateCode := bitfieldMask ^ stateKey
    }.otherwise {
      bitfieldValue := Mux(bitfieldInsert, bitfieldValue << 1, bitfieldValue >> 1)
      bitfieldRemaining := bitfieldRemaining - 1.U
    }
  }
  when (state === bitfieldMask) {
    when (bitfieldRemaining === 0.U) {
      when (bitfieldInsert) {
        bitfieldRemaining := bitfieldLsb
        stateCode := bitfieldMaskShift ^ stateKey
      }.otherwise {
        val extracted = bitfieldValue & bitfieldMaskReg
        val signBit = (extracted & ((bitfieldMaskReg + 1.U) >> 1)).orR
        result := Mux(bitfieldSigned && signBit, extracted | ~bitfieldMaskReg, extracted)
        stateCode := respond ^ stateKey
      }
    }.otherwise {
      bitfieldMaskReg := (bitfieldMaskReg << 1) | 1.U
      bitfieldRemaining := bitfieldRemaining - 1.U
    }
  }
  when (state === bitfieldMaskShift) {
    when (bitfieldRemaining === 0.U) {
      result := (bitfieldBase & ~bitfieldMaskReg) | (bitfieldValue & bitfieldMaskReg)
      stateCode := respond ^ stateKey
    }.otherwise {
      bitfieldMaskReg := bitfieldMaskReg << 1
      bitfieldRemaining := bitfieldRemaining - 1.U
    }
  }

  when (io.resp.fire) { stateCode := idle ^ stateKey }
}
