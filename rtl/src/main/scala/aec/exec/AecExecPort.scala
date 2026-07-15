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

/** Two-phase warp request capture with lane-local write enables. */
class AecWarpRequestBuffer extends Module {
  val io = IO(new Bundle {
    val in = Input(new AecExecRequest)
    val arm = Input(Bool())
    val capture = Input(Bool())
    val out = Output(new AecExecRequest)
  })

  val operandCapture = RegInit(VecInit(Seq.fill(32)(VecInit(Seq.fill(12)(false.B)))))
  operandCapture.foreach(_.foreach(dontTouch(_)))
  val maskCapture = RegInit(VecInit(Seq.fill(32)(false.B)))
  maskCapture.foreach(dontTouch(_))
  val a = Reg(Vec(32, Vec(4, UInt(16.W))))
  val b = Reg(Vec(32, Vec(4, UInt(16.W))))
  val c = Reg(Vec(32, Vec(4, UInt(16.W))))
  val active = Reg(Vec(32, Bool()))
  val predicates = Reg(Vec(32, Bool()))
  val op = Reg(UInt(16.W))
  val dtype = Reg(UInt(4.W))
  val dest = Reg(UInt(8.W))
  val predicateSelect = Reg(UInt(3.W))

  for (i <- 0 until 32) {
    for (chunk <- 0 until 4) {
      val hi = (chunk + 1) * 16 - 1
      val lo = chunk * 16
      when (operandCapture(i)(chunk)) { a(i)(chunk) := io.in.a(i)(hi, lo) }
      when (operandCapture(i)(4 + chunk)) { b(i)(chunk) := io.in.b(i)(hi, lo) }
      when (operandCapture(i)(8 + chunk)) { c(i)(chunk) := io.in.c(i)(hi, lo) }
    }
    when (maskCapture(i)) {
      active(i) := io.in.activeMask(i)
      predicates(i) := io.in.predicateValues(i)
    }
    when (io.arm) {
      operandCapture(i) := VecInit(Seq.fill(12)(true.B))
      maskCapture(i) := true.B
    }
    when (io.capture) {
      operandCapture(i) := VecInit(Seq.fill(12)(false.B))
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
