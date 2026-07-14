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

  val lanes = Seq.fill(lanesPerCycle)(Module(new AecIntAlu))
  val requestStages = Seq.fill(lanesPerCycle)(Module(new AecIntRequestStage))
  val requestBuffer = Module(new AecWarpRequestBuffer)
  requestBuffer.io.in := io.req.bits
  val held = requestBuffer.io.out
  val groups = 32 / lanesPerCycle
  val group = RegInit(0.U(log2Ceil(groups max 2).W))
  val state = RegInit(1.U(8.W))
  val stateIdle = state(0)
  val stateCapture = state(1)
  val stateIssue = state(2)
  val stateIssueFanout = state(3)
  val stateWait = state(4)
  val stateRetire = state(5)
  val stateCommit = state(6)
  val stateOut = state(7)
  val resultBanks = Seq.fill(32)(Module(new AecResultLaneBank))
  val retireClusters = (lanesPerCycle + 3) / 4
  val retireWrite = RegInit(VecInit(Seq.fill(groups * retireClusters)(false.B)))
  retireWrite.foreach(dontTouch(_))
  val issueWrite = RegInit(VecInit(Seq.fill(retireClusters)(false.B)))
  issueWrite.foreach(dontTouch(_))
  val predicates = RegInit(0.U(32.W))
  val errors = RegInit(0.U(32.W))
  val writeMask = RegInit(0.U(32.W))
  val laneOp = Reg(Vec(lanesPerCycle, UInt(16.W)))
  val laneDtype = Reg(Vec(lanesPerCycle, UInt(4.W)))
  val laneDest = Reg(Vec(lanesPerCycle, UInt(8.W)))
  laneOp.foreach(dontTouch(_))
  laneDtype.foreach(dontTouch(_))
  laneDest.foreach(dontTouch(_))

  val armCapture = stateIdle && io.req.valid
  requestBuffer.io.arm := armCapture
  requestBuffer.io.capture := io.req.fire
  io.req.ready := stateCapture
  io.resp.valid := stateOut
  io.resp.bits.result := VecInit((0 until 32).map(i => Mux(writeMask(i), resultBanks(i).io.result, 0.U)))
  io.resp.bits.predicateMask := predicates
  io.resp.bits.errorMask := errors
  io.resp.bits.exceptionFlags := VecInit(Seq.fill(32)(0.U(5.W)))
  io.resp.bits.activeMask := held.activeMask
  io.resp.bits.dest := held.dest

  val base = group * lanesPerCycle.U
  val allReady = requestStages.map(_.io.in.ready).reduce(_ && _)
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
    requestStages(i).io.in.valid := issueWrite(i / 4)
    requestStages(i).io.in.bits.op := laneOp(i) ^ i.U(16.W)
    requestStages(i).io.in.bits.dtype := laneDtype(i) ^ i.U(4.W)
    requestStages(i).io.in.bits.a := held.a(laneIndex)(31, 0)
    requestStages(i).io.in.bits.b := held.b(laneIndex)(31, 0)
    requestStages(i).io.in.bits.c := held.c(laneIndex)(31, 0)
    requestStages(i).io.in.bits.dest := laneDest(i) ^ i.U(8.W)
    requestStages(i).io.in.bits.selectPredicate := held.predicateValues(laneIndex)
    lanes(i).io.req <> requestStages(i).io.out
    lanes(i).io.resp.ready := stateWait && allValid
  }
  for (g <- 0 until groups; cluster <- 0 until retireClusters) {
    retireWrite(g * retireClusters + cluster) :=
      stateWait && allValid && group === g.U
  }
  for (cluster <- 0 until retireClusters) {
    issueWrite(cluster) := stateIssue && allReady
  }
  for (g <- 0 until groups; i <- 0 until lanesPerCycle) {
    val architecturalLane = g * lanesPerCycle + i
    resultBanks(architecturalLane).io.write := retireWrite(g * retireClusters + i / 4)
    resultBanks(architecturalLane).io.writeResult := Cat(0.U(32.W), lanes(i).io.resp.bits.result)
    resultBanks(architecturalLane).io.writeFlags := 0.U
  }

  when (armCapture) { state := "b0000010".U }
  when (io.req.fire) {
    for (i <- 0 until lanesPerCycle) {
      // Lane encoding prevents synthesis from merging physically local banks.
      laneOp(i) := io.req.bits.op ^ i.U(16.W)
      laneDtype(i) := io.req.bits.dtype ^ i.U(4.W)
      laneDest(i) := io.req.bits.dest ^ i.U(8.W)
    }
    group := 0.U
    predicates := 0.U
    errors := 0.U
    writeMask := 0.U
    state := Mux(io.req.bits.activeMask.orR, "b00000100".U, "b10000000".U)
  }
  when (stateIssue && allReady) {
    state := "b00001000".U
  }
  when (stateIssueFanout) {
    state := "b00010000".U
  }
  when (stateWait && allValid) {
    predicates := predicates | groupPredicateBits
    errors := errors | groupErrorBits
    state := "b00100000".U
  }
  when (stateRetire) {
    state := "b01000000".U
  }
  when (stateCommit) {
    val groupMask = ((((1.U(33.W) << lanesPerCycle) - 1.U) << base)(31, 0))
    writeMask := writeMask | (held.activeMask & groupMask)
    when (group === (groups - 1).U) {
      state := "b10000000".U
    }.otherwise {
      group := group + 1.U
      state := "b00000100".U
    }
  }
  when (io.resp.fire) {
    state := "b00000001".U
  }
}
