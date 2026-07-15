package aec

import chisel3._
import chisel3.util._

/** Arbitrates four scheduler partitions onto the single resident-memory LSU
  * and routes the tagged instruction completion back to its owner. */
class AecLocalMemoryFabric(val ports: Int = 4) extends Module {
  require(ports >= 1)
  private val ownerWidth = log2Ceil(ports) max 1
  val io = IO(new Bundle {
    val requests = Flipped(Vec(ports, Decoupled(new AecTaggedLocalMemoryRequest)))
    val completions = Vec(ports, Decoupled(new AecBackendCompletion))
    val clearSmem = Input(Bool())
    val clearBusy = Output(Bool())
    val preload = Flipped(Decoupled(new Bundle {
      val pmem = Bool()
      val address = UInt(16.W)
      val data = UInt(128.W)
      val mask = UInt(16.W)
    }))
  })

  val lsu = Module(new AecLocalLsu)
  lsu.io.clearSmem := io.clearSmem
  io.clearBusy := lsu.io.clearBusy
  lsu.io.preload <> io.preload

  val rr = RegInit(0.U(ownerWidth.W))
  val pendingValid = RegInit(false.B)
  val pendingOwner = Reg(UInt(ownerWidth.W))
  val pending = Reg(new AecTaggedLocalMemoryRequest)
  val ownerValid = RegInit(false.B)
  val owner = Reg(UInt(ownerWidth.W))
  val ownerTag = Reg(new AecInstructionTag)

  val requestValid = VecInit(io.requests.map(_.valid)).asUInt
  val rotated = (Cat(requestValid, requestValid) >> rr)(ports - 1, 0)
  val selected = (rr + PriorityEncoder(rotated))(ownerWidth - 1, 0)
  val canCapture = !pendingValid && !ownerValid && requestValid.orR

  for (i <- 0 until ports) {
    io.requests(i).ready := canCapture && selected === i.U
    io.completions(i).valid := ownerValid && owner === i.U && lsu.io.done.valid
    io.completions(i).bits.tag := ownerTag
    io.completions(i).bits.data := lsu.io.done.bits.loadData
    io.completions(i).bits.predicateData := 0.U
    io.completions(i).bits.error := lsu.io.done.bits.error
  }

  when (canCapture) {
    pendingValid := true.B
    pendingOwner := selected
    pending := Mux1H((0 until ports).map(i => (selected === i.U) -> io.requests(i).bits))
    rr := selected + 1.U
  }

  lsu.io.start.valid := pendingValid
  lsu.io.start.bits := pending.request
  when (lsu.io.start.fire) {
    pendingValid := false.B
    ownerValid := true.B
    owner := pendingOwner
    ownerTag := pending.tag
  }

  lsu.io.done.ready := ownerValid &&
    MuxLookup(owner, false.B, (0 until ports).map(i => i.U -> io.completions(i).ready))
  when (lsu.io.done.fire) { ownerValid := false.B }
}
