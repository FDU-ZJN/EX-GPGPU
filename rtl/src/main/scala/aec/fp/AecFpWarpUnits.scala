package aec.fp

import chisel3._
import chisel3.util._
import aec.exec._
import aec.int.AecIntAlu

/** Shared warp-facing scheduler for one scalar FP backend. */
trait AecWarpPipeScheduler { this: Module =>
  def laneMaskBit(index: UInt): UInt = 1.U(32.W) << index
}

class AecFp32Unit(val lanesPerCycle: Int = 16,
    val useInternalRequestBuffer: Boolean = true) extends Module with AecWarpPipeScheduler {
  require(lanesPerCycle > 0 && 32 % lanesPerCycle == 0)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val resp = Decoupled(new AecExecResponse)
  })
  val pipes = Seq.fill(lanesPerCycle)(Module(new AecFp32PipeUnit(warpIntegrated = true)))
  val groups = 32 / lanesPerCycle
  val requestStages = Seq.fill(lanesPerCycle)(Module(new AecFpWarpRequestStage(groups)))
  val held = Wire(new AecExecRequest)
  val requestBuffer = if (useInternalRequestBuffer) Some(Module(new AecWarpRequestBuffer)) else None
  if (useInternalRequestBuffer) {
    requestBuffer.get.io.in := io.req.bits
    held := requestBuffer.get.io.out
  } else {
    held := io.req.bits
  }
  val capturePending = RegInit(false.B)
  val group = RegInit(0.U(log2Ceil((32 / lanesPerCycle) max 2).W)); val outValid = RegInit(false.B)
  val running = RegInit(false.B)
  val groupIssued = RegInit(false.B)
  val commitPending = RegInit(false.B)
  val resultBanks = Seq.fill(32)(Module(new AecResultLaneBank))
  val allReady = requestStages.map(_.io.inReady).reduce(_ && _)
  val allValid = pipes.map(_.io.resp.valid).reduce(_ && _)

  val armPending = RegInit(false.B)
  val armCapture = if (useInternalRequestBuffer)
    !armPending && !capturePending && !running && !outValid && io.req.valid else false.B
  if (useInternalRequestBuffer) {
    val armClusters = RegInit(VecInit(Seq.fill(8)(false.B)))
    armClusters.foreach(_ := armCapture)
    armClusters.foreach(dontTouch(_))
    requestBuffer.get.io.arm := armClusters
    requestBuffer.get.io.capture := io.req.fire
  }
  io.req.ready := (if (useInternalRequestBuffer) capturePending else !running && !outValid)
  io.resp.valid := outValid
  io.resp.bits.result := VecInit(resultBanks.map(_.io.result))
  io.resp.bits.predicateMask := VecInit(resultBanks.map(_.io.predicate)).asUInt
  io.resp.bits.errorMask := VecInit(resultBanks.map(_.io.error)).asUInt
  io.resp.bits.exceptionFlags := VecInit(resultBanks.map(_.io.flags))
  io.resp.bits.activeMask := held.activeMask; io.resp.bits.dest := held.dest
  for (i <- 0 until lanesPerCycle) {
    requestStages(i).io.inValid := running && !groupIssued && !outValid && group < groups.U && allReady
    requestStages(i).io.group := group
    for (g <- 0 until groups) {
      val lane = g * lanesPerCycle + i
      requestStages(i).io.data(g).op := held.op(6, 0)
      requestStages(i).io.data(g).dtype := held.dtype
      requestStages(i).io.data(g).a := held.a(lane)
      requestStages(i).io.data(g).b := held.b(lane)
      requestStages(i).io.data(g).c := held.c(lane)
      requestStages(i).io.data(g).dest := held.dest
    }
    pipes(i).io.req <> requestStages(i).io.out
    pipes(i).io.resp.ready := !outValid && allValid
  }
  for (g <- 0 until groups; i <- 0 until lanesPerCycle) {
    val architecturalLane = g * lanesPerCycle + i
    resultBanks(architecturalLane).io.write := running && !outValid && allValid && group === g.U
    resultBanks(architecturalLane).io.writeResult := Mux(held.activeMask(architecturalLane), pipes(i).io.resp.bits.result, 0.U)
    resultBanks(architecturalLane).io.writeFlags := Mux(held.activeMask(architecturalLane), pipes(i).io.resp.bits.exception_flags, 0.U)
    resultBanks(architecturalLane).io.writePredicate := held.activeMask(architecturalLane) && pipes(i).io.resp.bits.predicate_result
    resultBanks(architecturalLane).io.writeError := held.activeMask(architecturalLane) && pipes(i).io.resp.bits.error
  }
  if (useInternalRequestBuffer) {
    armPending := armCapture
    when (armPending) { capturePending := true.B }
  }
  when (io.req.fire) {
    capturePending := false.B; group := 0.U
    groupIssued := false.B
    commitPending := false.B
    running := true.B
    outValid := false.B
  }
  when (running && !groupIssued && !commitPending && allReady) { groupIssued := true.B }
  when (running && groupIssued && !commitPending && allValid) {
    commitPending := true.B
  }
  when (commitPending) {
    groupIssued := false.B
    commitPending := false.B
    when (group === (groups - 1).U) { outValid := true.B; running := false.B; group := 0.U }.otherwise { group := group + 1.U }
  }
  when (io.resp.fire) {
    outValid := false.B
  }
}

class AecFp64Unit(val lanesPerCycle: Int = 8,
    val useInternalRequestBuffer: Boolean = true) extends Module with AecWarpPipeScheduler {
  require(lanesPerCycle > 0 && 32 % lanesPerCycle == 0)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val resp = Decoupled(new AecExecResponse)
  })
  val pipes = Seq.fill(lanesPerCycle)(Module(new AecFp64PipeUnit(false, warpIntegrated = true)))
  val groups = 32 / lanesPerCycle
  val requestStages = Seq.fill(lanesPerCycle)(Module(new AecFpWarpRequestStage(groups)))
  val held = Wire(new AecExecRequest)
  val requestBuffer = if (useInternalRequestBuffer) Some(Module(new AecWarpRequestBuffer)) else None
  if (useInternalRequestBuffer) {
    requestBuffer.get.io.in := io.req.bits
    held := requestBuffer.get.io.out
  } else {
    held := io.req.bits
  }
  val capturePending = RegInit(false.B)
  val group = RegInit(0.U(log2Ceil((32 / lanesPerCycle) max 2).W)); val outValid = RegInit(false.B)
  val running = RegInit(false.B)
  val groupIssued = RegInit(false.B)
  val commitPending = RegInit(false.B)
  val resultBanks = Seq.fill(32)(Module(new AecResultLaneBank))
  val allReady = requestStages.map(_.io.inReady).reduce(_ && _); val allValid = pipes.map(_.io.resp.valid).reduce(_ && _)
  val armPending = RegInit(false.B)
  val armCapture = if (useInternalRequestBuffer)
    !armPending && !capturePending && !running && !outValid && io.req.valid else false.B
  if (useInternalRequestBuffer) {
    val armClusters = RegInit(VecInit(Seq.fill(8)(false.B)))
    armClusters.foreach(_ := armCapture)
    armClusters.foreach(dontTouch(_))
    requestBuffer.get.io.arm := armClusters
    requestBuffer.get.io.capture := io.req.fire
  }
  io.req.ready := (if (useInternalRequestBuffer) capturePending else !running && !outValid)
  io.resp.valid := outValid
  io.resp.bits.result := VecInit(resultBanks.map(_.io.result))
  io.resp.bits.predicateMask := VecInit(resultBanks.map(_.io.predicate)).asUInt
  io.resp.bits.errorMask := VecInit(resultBanks.map(_.io.error)).asUInt
  io.resp.bits.exceptionFlags := VecInit(resultBanks.map(_.io.flags))
  io.resp.bits.activeMask := held.activeMask; io.resp.bits.dest := held.dest
  for (i <- 0 until lanesPerCycle) {
    requestStages(i).io.inValid := running && !groupIssued && !outValid && group < groups.U && allReady
    requestStages(i).io.group := group
    for (g <- 0 until groups) {
      val lane = g * lanesPerCycle + i
      requestStages(i).io.data(g).op := held.op(6, 0)
      requestStages(i).io.data(g).dtype := held.dtype
      requestStages(i).io.data(g).a := held.a(lane)
      requestStages(i).io.data(g).b := held.b(lane)
      requestStages(i).io.data(g).c := held.c(lane)
      requestStages(i).io.data(g).dest := held.dest
    }
    pipes(i).io.req <> requestStages(i).io.out
    pipes(i).io.resp.ready := !outValid && allValid
  }
  for (g <- 0 until groups; i <- 0 until lanesPerCycle) {
    val architecturalLane = g * lanesPerCycle + i
    resultBanks(architecturalLane).io.write := running && !outValid && allValid && group === g.U
    resultBanks(architecturalLane).io.writeResult := Mux(held.activeMask(architecturalLane), pipes(i).io.resp.bits.result, 0.U)
    resultBanks(architecturalLane).io.writeFlags := Mux(held.activeMask(architecturalLane), pipes(i).io.resp.bits.exception_flags, 0.U)
    resultBanks(architecturalLane).io.writePredicate := held.activeMask(architecturalLane) && pipes(i).io.resp.bits.predicate_result
    resultBanks(architecturalLane).io.writeError := held.activeMask(architecturalLane) && pipes(i).io.resp.bits.error
  }
  if (useInternalRequestBuffer) {
    armPending := armCapture
    when (armPending) { capturePending := true.B }
  }
  when (io.req.fire) {
    capturePending := false.B; group := 0.U
    groupIssued := false.B
    commitPending := false.B
    running := true.B
    outValid := false.B
  }
  when (running && !groupIssued && !commitPending && allReady) { groupIssued := true.B }
  when (running && groupIssued && !commitPending && allValid) {
    commitPending := true.B
  }
  when (commitPending) {
    groupIssued := false.B
    commitPending := false.B
    when (group === (groups - 1).U) { outValid := true.B; running := false.B; group := 0.U }.otherwise { group := group + 1.U }
  }
  when (io.resp.fire) {
    outValid := false.B
  }
}

/** Integer unit with the same warp-vector port as both floating-point units. */
class AecIntUnit extends Module with AecWarpPipeScheduler {
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val resp = Decoupled(new AecExecResponse)
  })
  val pipe = Module(new AecIntAlu)
  val held = Reg(new AecExecRequest)
  val pending = RegInit(0.U(32.W)); val inflight = RegInit(false.B); val outValid = RegInit(false.B)
  val results = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val predicates = RegInit(0.U(32.W)); val errors = RegInit(0.U(32.W))
  val flags = RegInit(VecInit(Seq.fill(32)(0.U(5.W))))
  val lane = PriorityEncoder(pending); val laneBit = laneMaskBit(lane)
  val inflightLane = Reg(UInt(5.W))
  io.req.ready := !pending.orR && !inflight && !outValid
  io.resp.valid := outValid
  io.resp.bits.result := results; io.resp.bits.predicateMask := predicates
  io.resp.bits.errorMask := errors; io.resp.bits.exceptionFlags := flags
  io.resp.bits.activeMask := held.activeMask; io.resp.bits.dest := held.dest
  pipe.io.req.valid := pending.orR && !inflight && !outValid
  pipe.io.req.bits.op := held.op; pipe.io.req.bits.dtype := held.dtype
  pipe.io.req.bits.a := held.a(lane)(31, 0); pipe.io.req.bits.b := held.b(lane)(31, 0)
  pipe.io.req.bits.c := held.c(lane)(31, 0); pipe.io.req.bits.dest := held.dest
  pipe.io.req.bits.selectPredicate := held.predicateValues(lane)
  pipe.io.resp.ready := inflight && !outValid
  when (io.req.fire) { held := io.req.bits; pending := io.req.bits.activeMask }
  when (pipe.io.req.fire) { pending := pending & ~laneBit; inflightLane := lane; inflight := true.B }
  when (pipe.io.resp.fire) {
    val responseBit = laneMaskBit(inflightLane)
    results(inflightLane) := Cat(0.U(32.W), pipe.io.resp.bits.result)
    when (pipe.io.resp.bits.predicateResult) { predicates := predicates | responseBit }
    when (pipe.io.resp.bits.error) { errors := errors | responseBit }
    inflight := false.B; when (pending === 0.U) { outValid := true.B }
  }
  when (io.resp.fire) { outValid := false.B; predicates := 0.U; errors := 0.U }
}
