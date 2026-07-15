package aec.int

import chisel3._
import chisel3.util._
import aec.exec._

/**
  * A configurable physical integer lane group executes a 32-lane warp.
  *
  * The input/output contract remains warp-wide so the scheduler and retire
  * logic never need to know the implementation width.  Inactive lanes are
  * harmlessly evaluated but their data, predicate and error bits are masked
  * before being accumulated.
  */
class AecEightLaneIntUnit(val lanesPerCycle: Int = 16) extends Module {
  require(lanesPerCycle > 0 && 32 % lanesPerCycle == 0)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val resp = Decoupled(new AecExecResponse)
  })

  val lanes = Seq.tabulate(lanesPerCycle)(i => Module(new AecIntAlu(i)))
  val requestBuffer = Module(new AecWarpRequestBuffer)
  requestBuffer.io.in := io.req.bits
  val held = requestBuffer.io.out
  val groups = 32 / lanesPerCycle
  val group = RegInit(0.U(log2Ceil(groups max 2).W))
  val stateIdle :: stateCapture :: stateIssue :: stateWait :: stateOut :: Nil = Enum(5)
  val state = RegInit(stateIdle)
  val results = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val predicates = RegInit(0.U(32.W))
  val errors = RegInit(0.U(32.W))
  val writeMask = RegInit(0.U(32.W))
  val laneOp = Reg(Vec(lanesPerCycle, UInt(16.W)))
  val laneDtype = Reg(Vec(lanesPerCycle, UInt(4.W)))
  val laneDest = Reg(Vec(lanesPerCycle, UInt(8.W)))
  val laneIssueCode = Reg(Vec(lanesPerCycle, Bool()))
  val laneWaitCode = Reg(Vec(lanesPerCycle, Bool()))
  laneOp.foreach(dontTouch(_))
  laneDtype.foreach(dontTouch(_))
  laneDest.foreach(dontTouch(_))

  val armCapture = state === stateIdle && io.req.valid
  requestBuffer.io.arm := armCapture
  requestBuffer.io.capture := io.req.fire
  io.req.ready := state === stateCapture
  io.resp.valid := state === stateOut
  io.resp.bits.result := VecInit((0 until 32).map(i => Mux(writeMask(i), results(i), 0.U)))
  io.resp.bits.predicateMask := predicates
  io.resp.bits.errorMask := errors
  io.resp.bits.exceptionFlags := VecInit(Seq.fill(32)(0.U(5.W)))
  io.resp.bits.activeMask := held.activeMask
  io.resp.bits.dest := held.dest

  val base = group * lanesPerCycle.U
  val allReady = lanes.map(_.io.req.ready).reduce(_ && _)
  val allValid = lanes.map(_.io.resp.valid).reduce(_ && _)
  val groupPredicateBits = (0 until lanesPerCycle).map { i =>
    val laneIndex = base + i.U
    Mux(held.activeMask(laneIndex) && lanes(i).io.resp.bits.predicateResult,
      (1.U(32.W) << laneIndex)(31, 0), 0.U(32.W))
  }.reduce(_ | _)
  val groupErrorBits = (0 until lanesPerCycle).map { i =>
    val laneIndex = base + i.U
    Mux(held.activeMask(laneIndex) && lanes(i).io.resp.bits.error,
      (1.U(32.W) << laneIndex)(31, 0), 0.U(32.W))
  }.reduce(_ | _)
  for (i <- 0 until lanesPerCycle) {
    val laneIndex = base + i.U
    val controlKey = held.a(i)(0)
    val laneIssue = laneIssueCode(i) ^ controlKey
    val laneWait = laneWaitCode(i) ^ controlKey
    lanes(i).io.req.valid := laneIssue
    lanes(i).io.req.bits.op := laneOp(i) ^ i.U(16.W)
    lanes(i).io.req.bits.dtype := laneDtype(i) ^ i.U(4.W)
    lanes(i).io.req.bits.a := held.a(laneIndex)(31, 0)
    lanes(i).io.req.bits.b := held.b(laneIndex)(31, 0)
    lanes(i).io.req.bits.c := held.c(laneIndex)(31, 0)
    lanes(i).io.req.bits.dest := laneDest(i) ^ i.U(8.W)
    lanes(i).io.req.bits.selectPredicate := held.predicateValues(laneIndex)
    lanes(i).io.resp.ready := laneWait && allValid
  }

  when (armCapture) { state := stateCapture }
  when (io.req.fire) {
    for (i <- 0 until lanesPerCycle) {
      // Lane encoding prevents synthesis from merging physically local banks.
      laneOp(i) := io.req.bits.op ^ i.U(16.W)
      laneDtype(i) := io.req.bits.dtype ^ i.U(4.W)
      laneDest(i) := io.req.bits.dest ^ i.U(8.W)
      laneIssueCode(i) := true.B ^ io.req.bits.a(i)(0)
      laneWaitCode(i) := false.B ^ io.req.bits.a(i)(0)
    }
    group := 0.U
    predicates := 0.U
    errors := 0.U
    writeMask := 0.U
    state := Mux(io.req.bits.activeMask.orR, stateIssue, stateOut)
  }
  when (state === stateIssue && allReady) {
    for (i <- 0 until lanesPerCycle) {
      laneIssueCode(i) := false.B ^ held.a(i)(0)
      laneWaitCode(i) := true.B ^ held.a(i)(0)
    }
    state := stateWait
  }
  when (state === stateWait && allValid) {
    for (i <- 0 until lanesPerCycle) {
      val laneIndex = base + i.U
      results(laneIndex) := Cat(0.U(32.W), lanes(i).io.resp.bits.result)
    }
    val groupMask = ((((1.U(33.W) << lanesPerCycle) - 1.U) << base)(31, 0))
    writeMask := writeMask | (held.activeMask & groupMask)
    predicates := predicates | groupPredicateBits
    errors := errors | groupErrorBits
    when (group === (groups - 1).U) {
      for (i <- 0 until lanesPerCycle) {
        laneWaitCode(i) := false.B ^ held.a(i)(0)
      }
      state := stateOut
    }.otherwise {
      for (i <- 0 until lanesPerCycle) {
        laneIssueCode(i) := true.B ^ held.a(i)(0)
        laneWaitCode(i) := false.B ^ held.a(i)(0)
      }
      group := group + 1.U
      state := stateIssue
    }
  }
  when (io.resp.fire) {
    state := stateIdle
  }
}
