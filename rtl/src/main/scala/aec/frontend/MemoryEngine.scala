package aec

import chisel3._
import chisel3.util._

/** A coalesced, 128-byte external-memory line request. */
class AecLineRequest extends Bundle {
  val space = Bool(); val warp = UInt(3.W); val write = Bool(); val address = UInt(32.W)
  val wdata = UInt(1024.W); val wstrb = UInt(128.W); val lastForInstruction = Bool()
  val cacheable = Bool()
  // Internal LSU identity. The external service still uses its independent
  // 4-bit mem_req_tag allocated below.
  val token = UInt(4.W)
}

class AecLineCompletion extends Bundle {
  val space = Bool(); val warp = UInt(3.W); val tag = UInt(4.W); val write = Bool()
  val lastForInstruction = Bool(); val rdata = UInt(1024.W); val error = Bool()
  val address = UInt(32.W); val cacheable = Bool(); val token = UInt(4.W)
}

class AecTaggedLineDescriptor extends Bundle {
  val tag = UInt(4.W)
  val space = Bool()
  val write = Bool()
  val address = UInt(32.W)
}

/**
  * Single-issue, 16-tag adapter for the contest external-memory protocol.
  * Coalescing and load-data placement remain in the future LSU stage.
  */
class AecExternalMemoryEngine extends Module {
  val io = IO(new Bundle {
    val lineIn = Flipped(Decoupled(new AecLineRequest))
    val lineComplete = Decoupled(new AecLineCompletion)
    val memReqValid = Output(Bool()); val memReqReady = Input(Bool()); val memReqWrite = Output(Bool()); val memReqAddr = Output(UInt(32.W))
    val memReqSpace = Output(Bool()); val memReqWdata = Output(UInt(1024.W)); val memReqWstrb = Output(UInt(128.W)); val memReqTag = Output(UInt(4.W))
    val memRspValid = Input(Bool()); val memRspReady = Output(Bool()); val memRspRdata = Input(UInt(1024.W)); val memRspTag = Input(UInt(4.W)); val memRspError = Input(Bool())
    val outstanding = Output(UInt(5.W))
  })
  val valid = RegInit(VecInit(Seq.fill(AecFrontendConfig.Outstanding)(false.B)))
  val space = Reg(Vec(AecFrontendConfig.Outstanding, Bool())); val warp = Reg(Vec(AecFrontendConfig.Outstanding, UInt(3.W)))
  val write = Reg(Vec(AecFrontendConfig.Outstanding, Bool())); val last = Reg(Vec(AecFrontendConfig.Outstanding, Bool()))
  val address = Reg(Vec(AecFrontendConfig.Outstanding, UInt(32.W)))
  val cacheable = Reg(Vec(AecFrontendConfig.Outstanding, Bool()))
  val token = Reg(Vec(AecFrontendConfig.Outstanding, UInt(4.W)))
  val free = VecInit((0 until AecFrontendConfig.Outstanding).map(i => !valid(i))).asUInt
  val hasFree = free.orR; val tag = PriorityEncoder(free)
  // Only metadata is queued. Ordinary loads never consume 1024-bit wdata or
  // 128-bit wstrb storage; serialized stores use one dedicated payload slot.
  val requestQ = Module(new Queue(new AecTaggedLineDescriptor, 2, pipe = false, flow = false))
  val storePayloadValid = RegInit(false.B)
  val storeWdata = Reg(UInt(1024.W))
  val storeWstrb = Reg(UInt(128.W))
  val storeSlotFree = !io.lineIn.bits.write || !storePayloadValid
  requestQ.io.enq.valid := io.lineIn.valid && hasFree && storeSlotFree
  requestQ.io.enq.bits.tag := tag
  requestQ.io.enq.bits.space := io.lineIn.bits.space
  requestQ.io.enq.bits.write := io.lineIn.bits.write
  requestQ.io.enq.bits.address := io.lineIn.bits.address
  io.lineIn.ready := requestQ.io.enq.ready && hasFree && storeSlotFree
  when (io.lineIn.fire) {
    valid(tag) := true.B
    space(tag) := io.lineIn.bits.space
    warp(tag) := io.lineIn.bits.warp
    write(tag) := io.lineIn.bits.write
    last(tag) := io.lineIn.bits.lastForInstruction
    address(tag) := io.lineIn.bits.address
    cacheable(tag) := io.lineIn.bits.cacheable
    token(tag) := io.lineIn.bits.token
    when (io.lineIn.bits.write) {
      storePayloadValid := true.B
      storeWdata := io.lineIn.bits.wdata
      storeWstrb := io.lineIn.bits.wstrb
    }
  }
  io.memReqValid := requestQ.io.deq.valid
  io.memReqSpace := requestQ.io.deq.bits.space
  io.memReqWrite := requestQ.io.deq.bits.write
  io.memReqAddr := requestQ.io.deq.bits.address
  io.memReqWdata := Mux(requestQ.io.deq.bits.write, storeWdata, 0.U)
  io.memReqWstrb := Mux(requestQ.io.deq.bits.write, storeWstrb, 0.U)
  io.memReqTag := requestQ.io.deq.bits.tag
  requestQ.io.deq.ready := io.memReqReady
  when (requestQ.io.deq.fire && requestQ.io.deq.bits.write) {
    storePayloadValid := false.B
  }
  io.lineComplete.valid := io.memRspValid && valid(io.memRspTag)
  io.lineComplete.bits.space := space(io.memRspTag); io.lineComplete.bits.warp := warp(io.memRspTag); io.lineComplete.bits.tag := io.memRspTag; io.lineComplete.bits.write := write(io.memRspTag)
  io.lineComplete.bits.lastForInstruction := last(io.memRspTag); io.lineComplete.bits.rdata := io.memRspRdata; io.lineComplete.bits.error := io.memRspError
  io.lineComplete.bits.address := address(io.memRspTag)
  io.lineComplete.bits.cacheable := cacheable(io.memRspTag)
  io.lineComplete.bits.token := token(io.memRspTag)
  io.memRspReady := io.lineComplete.ready && valid(io.memRspTag)
  when (io.lineComplete.fire) { valid(io.memRspTag) := false.B }
  io.outstanding := PopCount(valid)

  val wasStalled = RegNext(io.memReqValid && !io.memReqReady, false.B)
  val previousPayload = RegNext(Cat(io.memReqSpace, io.memReqWrite, io.memReqAddr,
    io.memReqWdata, io.memReqWstrb, io.memReqTag))
  when (wasStalled) {
    assert(io.memReqValid && Cat(io.memReqSpace, io.memReqWrite, io.memReqAddr,
      io.memReqWdata, io.memReqWstrb, io.memReqTag) === previousPayload,
      "external request payload changed under backpressure")
  }
}
