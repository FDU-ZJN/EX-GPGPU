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
  val requestStages = Seq.fill(lanesPerCycle)(Module(new AecIntWarpRequestStage(32 / lanesPerCycle)))
  val requestBuffer = Module(new AecWarpRequestBuffer)
  requestBuffer.io.in := io.req.bits
  val held = requestBuffer.io.out
  val groups = 32 / lanesPerCycle
  val group = RegInit(0.U(log2Ceil(groups max 2).W))
  val state = RegInit(1.U(10.W))
  val stateIdle = state(0)
  val stateArm = state(1)
  val stateCapture = state(2)
  val stateIssue = state(3)
  val stateIssueFanout = state(4)
  val stateWait = state(5)
  val stateWaitFanout = state(6)
  val stateRetire = state(7)
  val stateCommit = state(8)
  val stateOut = state(9)
  val resultBanks = Seq.fill(32)(Module(new AecResultLaneBank))
  val retireClusters = (lanesPerCycle + 3) / 4
  val retireWrite = RegInit(VecInit(Seq.fill(groups * retireClusters)(false.B)))
  retireWrite.foreach(dontTouch(_))
  val issueWrite = RegInit(VecInit(Seq.fill(retireClusters)(false.B)))
  issueWrite.foreach(dontTouch(_))
  val responseReady = RegInit(VecInit(Seq.fill(retireClusters)(false.B)))
  responseReady.foreach(dontTouch(_))
  val laneOp = Reg(Vec(lanesPerCycle, UInt(16.W)))
  val laneDtype = Reg(Vec(lanesPerCycle, UInt(4.W)))
  val laneDest = Reg(Vec(lanesPerCycle, UInt(8.W)))
  laneOp.foreach(dontTouch(_))
  laneDtype.foreach(dontTouch(_))
  laneDest.foreach(dontTouch(_))

  val armCapture = stateIdle && io.req.valid
  val armClusters = RegInit(VecInit(Seq.fill(8)(false.B)))
  armClusters.foreach(_ := armCapture)
  armClusters.foreach(dontTouch(_))
  requestBuffer.io.arm := armClusters
  requestBuffer.io.capture := io.req.fire
  io.req.ready := stateCapture
  io.resp.valid := stateOut
  io.resp.bits.result := VecInit(resultBanks.map(_.io.result))
  io.resp.bits.predicateMask := VecInit(resultBanks.map(_.io.predicate)).asUInt
  io.resp.bits.errorMask := VecInit(resultBanks.map(_.io.error)).asUInt
  io.resp.bits.exceptionFlags := VecInit(Seq.fill(32)(0.U(5.W)))
  io.resp.bits.activeMask := held.activeMask
  io.resp.bits.dest := held.dest

  val base = group * lanesPerCycle.U
  val allReady = requestStages.map(_.io.inReady).reduce(_ && _)
  val allValid = lanes.map(_.io.resp.valid).reduce(_ && _)
  for (i <- 0 until lanesPerCycle) {
    requestStages(i).io.inValid := issueWrite(i / 4)
    requestStages(i).io.group := group
    for (g <- 0 until groups) {
      val laneIndex = g * lanesPerCycle + i
      requestStages(i).io.data(g).op := laneOp(i) ^ i.U(16.W)
      requestStages(i).io.data(g).dtype := laneDtype(i) ^ i.U(4.W)
      requestStages(i).io.data(g).a := held.a(laneIndex)(31, 0)
      requestStages(i).io.data(g).b := held.b(laneIndex)(31, 0)
      requestStages(i).io.data(g).c := held.c(laneIndex)(31, 0)
      requestStages(i).io.data(g).dest := laneDest(i) ^ i.U(8.W)
      requestStages(i).io.data(g).selectPredicate := held.predicateValues(laneIndex)
    }
    lanes(i).io.req <> requestStages(i).io.out
    lanes(i).io.resp.ready := responseReady(i / 4)
  }
  for (g <- 0 until groups; cluster <- 0 until retireClusters) {
    retireWrite(g * retireClusters + cluster) :=
      stateWait && allValid && group === g.U
  }
  for (cluster <- 0 until retireClusters) {
    issueWrite(cluster) := stateIssue && allReady
    responseReady(cluster) := stateWait && allValid
  }
  for (g <- 0 until groups; i <- 0 until lanesPerCycle) {
    val architecturalLane = g * lanesPerCycle + i
    resultBanks(architecturalLane).io.write := retireWrite(g * retireClusters + i / 4)
    resultBanks(architecturalLane).io.writeResult := Mux(held.activeMask(architecturalLane),
      Cat(0.U(32.W), lanes(i).io.resp.bits.result), 0.U)
    resultBanks(architecturalLane).io.writeFlags := 0.U
    resultBanks(architecturalLane).io.writePredicate := held.activeMask(architecturalLane) && lanes(i).io.resp.bits.predicateResult
    resultBanks(architecturalLane).io.writeError := held.activeMask(architecturalLane) && lanes(i).io.resp.bits.error
  }

  when (armCapture) { state := "b000000010".U }
  when (stateArm) { state := "b000000100".U }
  when (io.req.fire) {
    for (i <- 0 until lanesPerCycle) {
      // Lane encoding prevents synthesis from merging physically local banks.
      laneOp(i) := io.req.bits.op ^ i.U(16.W)
      laneDtype(i) := io.req.bits.dtype ^ i.U(4.W)
      laneDest(i) := io.req.bits.dest ^ i.U(8.W)
    }
    group := 0.U
    state := "b0000001000".U
  }
  when (stateIssue && allReady) {
    state := "b0000010000".U
  }
  when (stateIssueFanout) {
    state := "b0000100000".U
  }
  when (stateWait && allValid) {
    state := "b0001000000".U
  }
  when (stateWaitFanout) {
    state := "b0010000000".U
  }
  when (stateRetire) {
    state := "b0100000000".U
  }
  when (stateCommit) {
    when (group === (groups - 1).U) {
      state := "b1000000000".U
    }.otherwise {
      group := group + 1.U
      state := "b0000001000".U
    }
  }
  when (io.resp.fire) {
    state := "b0000000001".U
  }
}
