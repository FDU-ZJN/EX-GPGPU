package aec.exec

import chisel3._
import chisel3.util._

/** Common warp-facing execution port shared by FP32, FP64 and integer units. */
class AecExecRequest extends Bundle {
  val op = UInt(16.W)
  val dtype = UInt(4.W)
  val activeMask = UInt(32.W)
  val a = Vec(32, UInt(64.W))
  val b = Vec(32, UInt(64.W))
  val c = Vec(32, UInt(64.W))
  val dest = UInt(8.W)
  val predicateSelect = UInt(3.W)
  val predicateValues = UInt(32.W)
}

class AecExecResponse extends Bundle {
  val result = Vec(32, UInt(64.W))
  val predicateMask = UInt(32.W)
  val errorMask = UInt(32.W)
  val exceptionFlags = Vec(32, UInt(5.W))
  val activeMask = UInt(32.W)
  val dest = UInt(8.W)
}

/** One architectural lane's local result/flag register bank. */
class AecResultLaneBank extends Module {
  val io = IO(new Bundle {
    val write = Input(Bool())
    val writeResult = Input(UInt(64.W))
    val writeFlags = Input(UInt(5.W))
    val result = Output(UInt(64.W))
    val flags = Output(UInt(5.W))
  })

  val result = RegInit(0.U(64.W))
  val flags = RegInit(0.U(5.W))
  val pending = RegNext(io.write, false.B)
  val stagedResult = RegNext(io.writeResult)
  val stagedFlags = RegNext(io.writeFlags)
  when (pending) {
    result := stagedResult
    flags := stagedFlags
  }
  io.result := result
  io.flags := flags
}

/** Two-phase warp request capture with lane-local write enables. */
class AecWarpRequestBuffer extends Module {
  val io = IO(new Bundle {
    val in = Input(new AecExecRequest)
    val arm = Input(Bool())
    val capture = Input(Bool())
    val out = Output(new AecExecRequest)
  })

  private val operandBankWidth = 16
  private val banksPerOperand = 64 / operandBankWidth
  val operandCapture = RegInit(VecInit(Seq.fill(32)(VecInit(Seq.fill(3 * banksPerOperand)(false.B)))))
  operandCapture.foreach(_.foreach(dontTouch(_)))
  val maskCapture = RegInit(VecInit(Seq.fill(32)(false.B)))
  maskCapture.foreach(dontTouch(_))
  val a = Reg(Vec(32, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val b = Reg(Vec(32, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val c = Reg(Vec(32, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val active = Reg(Vec(32, Bool()))
  val predicates = Reg(Vec(32, Bool()))
  val op = Reg(UInt(16.W))
  val dtype = Reg(UInt(4.W))
  val dest = Reg(UInt(8.W))
  val predicateSelect = Reg(UInt(3.W))

  for (i <- 0 until 32) {
    for (bank <- 0 until banksPerOperand) {
      val hi = (bank + 1) * operandBankWidth - 1
      val lo = bank * operandBankWidth
      when (operandCapture(i)(bank)) { a(i)(bank) := io.in.a(i)(hi, lo) }
      when (operandCapture(i)(banksPerOperand + bank)) { b(i)(bank) := io.in.b(i)(hi, lo) }
      when (operandCapture(i)(2 * banksPerOperand + bank)) { c(i)(bank) := io.in.c(i)(hi, lo) }
    }
    when (maskCapture(i)) {
      active(i) := io.in.activeMask(i)
      predicates(i) := io.in.predicateValues(i)
    }
    when (io.arm) {
      operandCapture(i) := VecInit(Seq.fill(3 * banksPerOperand)(true.B))
      maskCapture(i) := true.B
    }
    when (io.capture) {
      operandCapture(i) := VecInit(Seq.fill(3 * banksPerOperand)(false.B))
      maskCapture(i) := false.B
    }
  }
  when (io.capture) {
    op := io.in.op
    dtype := io.in.dtype
    dest := io.in.dest
    predicateSelect := io.in.predicateSelect
  }

  io.out.op := op
  io.out.dtype := dtype
  io.out.dest := dest
  io.out.predicateSelect := predicateSelect
  for (i <- 0 until 32) {
    io.out.a(i) := Cat(a(i).reverse)
    io.out.b(i) := Cat(b(i).reverse)
    io.out.c(i) := Cat(c(i).reverse)
  }
  io.out.activeMask := Cat(active.reverse)
  io.out.predicateValues := Cat(predicates.reverse)
}

/**
  * Front-end metadata which deliberately does not enter an arithmetic pipe.
  * A backend only transforms lane data; the retire unit owns architectural
  * state and uses this context to commit (or discard) the response atomically.
  */
class AecExecutionContext extends Bundle {
  val warp = UInt(3.W)
  val pc = UInt(32.W)
  val sequence = UInt(8.W)
  val executeMask = UInt(32.W)
  val dest = UInt(8.W)
  val writeHi = Bool()
  val writesPredicate = Bool()
  val predicate = UInt(3.W)
}
