package aec.fp

import chisel3._
import chisel3.util._
import aec.exec._

/** Resource-serial execution of one 32-lane DIV/SFU instruction. */
class AecSfuWarpUnit(val physicalLanes: Int = 1,
    val useInternalRequestBuffer: Boolean = true) extends Module {
  require(physicalLanes > 0 && isPow2(physicalLanes) && 32 % physicalLanes == 0)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val mode = Input(UInt(3.W))
    val resp = Decoupled(new AecExecResponse)
  })

  val lanes = Seq.fill(physicalLanes)(Module(new AESSFU))
  val idle :: arm :: capture :: issue :: waitLanes :: retire :: output :: Nil = Enum(7)
  val state = RegInit(idle)
  val held = Wire(new AecExecRequest)
  val requestBuffer = if (useInternalRequestBuffer) Some(Module(new AecWarpRequestBuffer)) else None
  if (useInternalRequestBuffer) {
    requestBuffer.get.io.in := io.req.bits
    held := requestBuffer.get.io.out
  } else {
    held := io.req.bits
  }
  val heldMode = Reg(UInt(3.W))
  val groups = 32 / physicalLanes
  val groupWidth = log2Ceil(groups)
  val laneGroupWidth = log2Ceil(groups max physicalLanes)
  val group = RegInit(0.U(groupWidth.W))
  val laneGroup = Reg(Vec(physicalLanes, UInt(laneGroupWidth.W)))
  laneGroup.foreach(dontTouch(_))
  val results = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val errors = RegInit(0.U(32.W))
  val flags = RegInit(VecInit(Seq.fill(32)(0.U(5.W))))
  val writeMask = RegInit(0.U(32.W))
  val base = group * physicalLanes.U
  val allReady = lanes.map(_.io.req.ready).reduce(_ && _)
  val allValid = lanes.map(_.io.resp.valid).reduce(_ && _)
  val retireClusters = (physicalLanes + 3) / 4
  val retireWrite = RegInit(VecInit(Seq.fill(groups * retireClusters)(false.B)))
  retireWrite.foreach(dontTouch(_))

  val armCapture = if (useInternalRequestBuffer) state === idle && io.req.valid else false.B
  if (useInternalRequestBuffer) {
    val armClusters = RegInit(VecInit(Seq.fill(8)(false.B)))
    armClusters.foreach(_ := armCapture)
    armClusters.foreach(dontTouch(_))
    requestBuffer.get.io.arm := armClusters
    requestBuffer.get.io.capture := io.req.fire
  }
  io.req.ready := (if (useInternalRequestBuffer) state === capture else state === idle)
  io.resp.valid := state === output
  io.resp.bits.result := VecInit((0 until 32).map(i => Mux(writeMask(i), results(i), 0.U)))
  io.resp.bits.predicateMask := 0.U
  io.resp.bits.errorMask := errors
  io.resp.bits.exceptionFlags := VecInit((0 until 32).map(i => Mux(writeMask(i), flags(i), 0.U)))
  io.resp.bits.activeMask := held.activeMask
  io.resp.bits.dest := held.dest

  for (i <- 0 until physicalLanes) {
    val lane = MuxLookup(laneGroup(i), i.U(5.W), (0 until groups).map(g =>
      (g.U(laneGroupWidth.W) ^ i.U(laneGroupWidth.W)) -> (g * physicalLanes + i).U(5.W)))
    lanes(i).io.req.valid := state === issue && allReady
    lanes(i).io.req.bits.op := held.op
    lanes(i).io.req.bits.dtype := held.dtype
    lanes(i).io.req.bits.mode := heldMode
    lanes(i).io.req.bits.a := held.a(lane)
    lanes(i).io.req.bits.b := held.b(lane)
    lanes(i).io.req.bits.dest := held.dest
    lanes(i).io.resp.ready := state === waitLanes && allValid
  }
  for (g <- 0 until groups; cluster <- 0 until retireClusters) {
    retireWrite(g * retireClusters + cluster) :=
      state === waitLanes && allValid && group === g.U
  }
  for (g <- 0 until groups; i <- 0 until physicalLanes) {
    val architecturalLane = g * physicalLanes + i
    when (retireWrite(g * retireClusters + i / 4) && held.activeMask(architecturalLane)) {
      results(architecturalLane) := lanes(i).io.resp.bits.result
      flags(architecturalLane) := lanes(i).io.resp.bits.exceptionFlags
    }
  }

  if (useInternalRequestBuffer) {
    when (armCapture) { state := arm }
    when (state === arm) { state := capture }
  }
  when (io.req.fire) {
    heldMode := io.mode
    group := 0.U
    for (i <- 0 until physicalLanes) { laneGroup(i) := i.U }
    errors := 0.U
    writeMask := 0.U
    state := Mux(io.req.bits.activeMask.orR, issue, output)
  }
  when (state === issue && allReady) { state := waitLanes }
  when (state === waitLanes && allValid) {
    val completedMask = VecInit((0 until physicalLanes).map(i => held.activeMask(base + i.U))).asUInt << base
    val errorGroup = VecInit((0 until physicalLanes).map(i =>
      held.activeMask(base + i.U) && lanes(i).io.resp.bits.error)).asUInt << base
    writeMask := writeMask | completedMask
    errors := errors | errorGroup
    state := retire
  }
  when (state === retire) {
    val consumed = (1.U(33.W) << (base + physicalLanes.U)) - 1.U
    val remaining = (Cat(0.U(1.W), held.activeMask) & ~consumed)(31, 0)
    when (!remaining.orR) { state := output }
      .otherwise {
        val nextGroup = PriorityEncoder(remaining) >> log2Ceil(physicalLanes)
        group := nextGroup
        for (i <- 0 until physicalLanes) {
          laneGroup(i) := nextGroup.pad(laneGroupWidth) ^ i.U
        }
        state := issue
      }
  }
  when (io.resp.fire) { state := idle }
}
