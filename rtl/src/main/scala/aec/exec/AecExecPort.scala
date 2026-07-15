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
    val writePredicate = Input(Bool())
    val writeError = Input(Bool())
    val result = Output(UInt(64.W))
    val flags = Output(UInt(5.W))
    val predicate = Output(Bool())
    val error = Output(Bool())
  })

  val result = RegInit(0.U(64.W))
  val flags = RegInit(0.U(5.W))
  val predicate = RegInit(false.B)
  val error = RegInit(false.B)
  val pending = RegNext(io.write, false.B)
  val stagedResult = RegNext(io.writeResult)
  val stagedFlags = RegNext(io.writeFlags)
  val stagedPredicate = RegNext(io.writePredicate)
  val stagedError = RegNext(io.writeError)
  when (pending) {
    result := stagedResult
    flags := stagedFlags
    predicate := stagedPredicate
    error := stagedError
  }
  io.result := result
  io.flags := flags
  io.predicate := predicate
  io.error := error
}

/** Four-lane physical capture bank. Keeping this as a real module boundary
  * limits each capture token to one cluster instead of one flattened 6-Kbit
  * request register. */
class AecWarpRequestLaneBank extends Module {
  val io = IO(new Bundle {
    val inA = Input(Vec(4, UInt(64.W)))
    val inB = Input(Vec(4, UInt(64.W)))
    val inC = Input(Vec(4, UInt(64.W)))
    val inActive = Input(UInt(4.W))
    val inPredicates = Input(UInt(4.W))
    val arm = Input(Bool())
    val outA = Output(Vec(4, UInt(64.W)))
    val outB = Output(Vec(4, UInt(64.W)))
    val outC = Output(Vec(4, UInt(64.W)))
    val outActive = Output(UInt(4.W))
    val outPredicates = Output(UInt(4.W))
  })

  private val operandBankWidth = 16
  private val banksPerOperand = 64 / operandBankWidth
  val operandCapture = RegInit(VecInit(Seq.fill(4)(VecInit(Seq.fill(3 * banksPerOperand)(false.B)))))
  operandCapture.foreach(_.foreach(dontTouch(_)))
  val maskCapture = RegInit(VecInit(Seq.fill(4)(false.B)))
  maskCapture.foreach(dontTouch(_))
  val a = Reg(Vec(4, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val b = Reg(Vec(4, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val c = Reg(Vec(4, Vec(banksPerOperand, UInt(operandBankWidth.W))))
  val active = Reg(Vec(4, Bool()))
  val predicates = Reg(Vec(4, Bool()))

  for (i <- 0 until 4) {
    for (bank <- 0 until banksPerOperand) {
      val hi = (bank + 1) * operandBankWidth - 1
      val lo = bank * operandBankWidth
      when (operandCapture(i)(bank)) { a(i)(bank) := io.inA(i)(hi, lo) }
      when (operandCapture(i)(banksPerOperand + bank)) { b(i)(bank) := io.inB(i)(hi, lo) }
      when (operandCapture(i)(2 * banksPerOperand + bank)) { c(i)(bank) := io.inC(i)(hi, lo) }
    }
    when (maskCapture(i)) {
      active(i) := io.inActive(i)
      predicates(i) := io.inPredicates(i)
    }
    when (io.arm) {
      operandCapture(i) := VecInit(Seq.fill(3 * banksPerOperand)(true.B))
      maskCapture(i) := true.B
    }.otherwise {
      operandCapture(i) := VecInit(Seq.fill(3 * banksPerOperand)(false.B))
      maskCapture(i) := false.B
    }
    io.outA(i) := Cat(a(i).reverse)
    io.outB(i) := Cat(b(i).reverse)
    io.outC(i) := Cat(c(i).reverse)
  }
  io.outActive := Cat(active.reverse)
  io.outPredicates := Cat(predicates.reverse)
}

/** Two-phase warp request capture with eight independent physical banks. */
class AecWarpRequestBuffer extends Module {
  val io = IO(new Bundle {
    val in = Input(new AecExecRequest)
    val arm = Input(Vec(8, Bool()))
    val capture = Input(Bool())
    val out = Output(new AecExecRequest)
  })

  val laneBanks = Seq.fill(8)(Module(new AecWarpRequestLaneBank))
  for (cluster <- 0 until 8) {
    val base = cluster * 4
    laneBanks(cluster).io.arm := io.arm(cluster)
    for (lane <- 0 until 4) {
      laneBanks(cluster).io.inA(lane) := io.in.a(base + lane)
      laneBanks(cluster).io.inB(lane) := io.in.b(base + lane)
      laneBanks(cluster).io.inC(lane) := io.in.c(base + lane)
      io.out.a(base + lane) := laneBanks(cluster).io.outA(lane)
      io.out.b(base + lane) := laneBanks(cluster).io.outB(lane)
      io.out.c(base + lane) := laneBanks(cluster).io.outC(lane)
    }
    laneBanks(cluster).io.inActive := io.in.activeMask(4 * cluster + 3, 4 * cluster)
    laneBanks(cluster).io.inPredicates := io.in.predicateValues(4 * cluster + 3, 4 * cluster)
  }

  val op = Reg(UInt(16.W))
  val dtype = Reg(UInt(4.W))
  val dest = Reg(UInt(8.W))
  val predicateSelect = Reg(UInt(3.W))
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
  io.out.activeMask := Cat(laneBanks.reverse.map(_.io.outActive))
  io.out.predicateValues := Cat(laneBanks.reverse.map(_.io.outPredicates))
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
