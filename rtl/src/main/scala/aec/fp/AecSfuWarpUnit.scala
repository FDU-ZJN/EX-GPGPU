package aec.fp

import chisel3._
import chisel3.util._
import aec.exec._

/** Resource-serial execution of one 32-lane DIV/SFU instruction. */
class AecSfuWarpUnit(val physicalLanes: Int = 1) extends Module {
  require(physicalLanes > 0 && isPow2(physicalLanes) && 32 % physicalLanes == 0)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new AecExecRequest))
    val mode = Input(UInt(3.W))
    val resp = Decoupled(new AecExecResponse)
  })

  val lanes = Seq.fill(physicalLanes)(Module(new AESSFU))
  val idle :: capture :: issue :: waitLanes :: output :: Nil = Enum(5)
  val state = RegInit(idle)
  val requestBuffer = Module(new AecWarpRequestBuffer)
  requestBuffer.io.in := io.req.bits
  val held = requestBuffer.io.out
  val heldMode = Reg(UInt(3.W))
  val group = RegInit(0.U(log2Ceil(32 / physicalLanes).W))
  val results = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val errors = RegInit(0.U(32.W))
  val flags = RegInit(VecInit(Seq.fill(32)(0.U(5.W))))
  val writeMask = RegInit(0.U(32.W))
  val base = group * physicalLanes.U
  val allReady = lanes.map(_.io.req.ready).reduce(_ && _)
  val allValid = lanes.map(_.io.resp.valid).reduce(_ && _)

  val armCapture = state === idle && io.req.valid
  requestBuffer.io.arm := armCapture
  requestBuffer.io.capture := io.req.fire
  io.req.ready := state === capture
  io.resp.valid := state === output
  io.resp.bits.result := VecInit((0 until 32).map(i => Mux(writeMask(i), results(i), 0.U)))
  io.resp.bits.predicateMask := 0.U
  io.resp.bits.errorMask := errors
  io.resp.bits.exceptionFlags := VecInit((0 until 32).map(i => Mux(writeMask(i), flags(i), 0.U)))
  io.resp.bits.activeMask := held.activeMask
  io.resp.bits.dest := held.dest

  for (i <- 0 until physicalLanes) {
    val lane = base + i.U
    lanes(i).io.req.valid := state === issue && allReady
    lanes(i).io.req.bits.op := held.op
    lanes(i).io.req.bits.dtype := held.dtype
    lanes(i).io.req.bits.mode := heldMode
    lanes(i).io.req.bits.a := held.a(lane)
    lanes(i).io.req.bits.b := held.b(lane)
    lanes(i).io.req.bits.dest := held.dest
    lanes(i).io.resp.ready := state === waitLanes && allValid
  }

  when (armCapture) { state := capture }
  when (io.req.fire) {
    heldMode := io.mode
    group := 0.U
    errors := 0.U
    writeMask := 0.U
    state := Mux(io.req.bits.activeMask.orR, issue, output)
  }
  when (state === issue && allReady) { state := waitLanes }
  when (state === waitLanes && allValid) {
    val completedMask = VecInit((0 until physicalLanes).map(i => held.activeMask(base + i.U))).asUInt << base
    val errorGroup = VecInit((0 until physicalLanes).map(i =>
      held.activeMask(base + i.U) && lanes(i).io.resp.bits.error)).asUInt << base
    for (i <- 0 until physicalLanes) {
      val lane = base + i.U
      when (held.activeMask(lane)) {
        results(lane) := lanes(i).io.resp.bits.result
        flags(lane) := lanes(i).io.resp.bits.exceptionFlags
      }
    }
    writeMask := writeMask | completedMask
    errors := errors | errorGroup
    val consumed = (1.U(33.W) << (base + physicalLanes.U)) - 1.U
    val remaining = (Cat(0.U(1.W), held.activeMask) & ~consumed)(31, 0)
    when (!remaining.orR) { state := output }
      .otherwise { group := PriorityEncoder(remaining) >> log2Ceil(physicalLanes); state := issue }
  }
  when (io.resp.fire) { state := idle }
}
