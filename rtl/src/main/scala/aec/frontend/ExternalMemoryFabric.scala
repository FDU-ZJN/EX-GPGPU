package aec

import chisel3._
import chisel3.util._

/** Shared external-memory arbitration, atomic ownership and response routing
  * for the four scheduler-partition GMEM coalescers. */
class AecExternalMemoryFabric(val ports: Int = 4) extends Module {
  require(ports >= 1)
  private val ownerWidth = log2Ceil(ports) max 1
  val io = IO(new Bundle {
    val lines = Flipped(Vec(ports, Decoupled(new AecLineRequest)))
    val completions = Vec(ports, Decoupled(new AecLineCompletion))
    val atomic = Input(Vec(ports, Bool()))
    val instructionDone = Input(Vec(ports, Bool()))

    val memReqValid = Output(Bool()); val memReqReady = Input(Bool())
    val memReqSpace = Output(Bool()); val memReqWrite = Output(Bool())
    val memReqAddr = Output(UInt(32.W)); val memReqWdata = Output(UInt(1024.W))
    val memReqWstrb = Output(UInt(128.W)); val memReqTag = Output(UInt(4.W))
    val memRspValid = Input(Bool()); val memRspReady = Output(Bool())
    val memRspRdata = Input(UInt(1024.W)); val memRspTag = Input(UInt(4.W))
    val memRspError = Input(Bool())
    val outstanding = Output(UInt(5.W))
  })

  val engine = Module(new AecExternalMemoryEngine)
  val atomicLock = RegInit(false.B)
  val atomicOwner = RegInit(0.U(ownerWidth.W))
  val requestMask = VecInit(io.lines.map(_.valid)).asUInt
  val lmemMask = VecInit(io.lines.map(port => port.valid && port.bits.space)).asUInt
  val lockedMask = requestMask & UIntToOH(atomicOwner, ports)
  val eligible = Mux(atomicLock, lockedMask | lmemMask, requestMask)
  val rr = RegInit(0.U(ownerWidth.W))
  val pendingValid = RegInit(false.B)
  val pending = Reg(new AecLineRequest)
  val rotated = (Cat(eligible, eligible) >> rr)(ports - 1, 0)
  val selected = (rr + PriorityEncoder(rotated))(ownerWidth - 1, 0)
  val pendingReady = !pendingValid || engine.io.lineIn.ready
  val capture = pendingReady && eligible.orR

  engine.io.lineIn.valid := pendingValid
  engine.io.lineIn.bits := pending
  when (engine.io.lineIn.fire) { pendingValid := false.B }
  when (capture) {
    pendingValid := true.B
    pending := Mux1H((0 until ports).map(i => (selected === i.U) -> io.lines(i).bits))
    rr := selected + 1.U
  }

  for (i <- 0 until ports) {
    io.lines(i).ready := pendingReady && eligible.orR && selected === i.U
    io.completions(i).valid := engine.io.lineComplete.valid &&
      (if (ports == 1) true.B else engine.io.lineComplete.bits.warp(2, 1) === i.U)
    io.completions(i).bits := engine.io.lineComplete.bits
    when (atomicLock && atomicOwner === i.U && io.instructionDone(i)) {
      atomicLock := false.B
    }
  }
  val selectedAtomic = Mux1H((0 until ports).map(i => (selected === i.U) -> io.atomic(i)))
  when (capture && !atomicLock && selectedAtomic) {
    atomicLock := true.B
    atomicOwner := selected
  }

  engine.io.lineComplete.ready := (if (ports == 1) io.completions(0).ready else
    MuxLookup(engine.io.lineComplete.bits.warp(2, 1), false.B,
      (0 until ports).map(i => i.U -> io.completions(i).ready)))
  engine.io.memReqReady := io.memReqReady
  engine.io.memRspValid := io.memRspValid
  engine.io.memRspRdata := io.memRspRdata
  engine.io.memRspTag := io.memRspTag
  engine.io.memRspError := io.memRspError
  io.memReqValid := engine.io.memReqValid
  io.memReqSpace := engine.io.memReqSpace
  io.memReqWrite := engine.io.memReqWrite
  io.memReqAddr := engine.io.memReqAddr
  io.memReqWdata := engine.io.memReqWdata
  io.memReqWstrb := engine.io.memReqWstrb
  io.memReqTag := engine.io.memReqTag
  io.memRspReady := engine.io.memRspReady
  io.outstanding := engine.io.outstanding
}
