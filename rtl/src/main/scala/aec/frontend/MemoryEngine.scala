package aec

import chisel3._
import chisel3.util._

/** A coalesced, 128-byte external-memory line request. */
class AecLineRequest extends Bundle {
  val warp = UInt(3.W); val write = Bool(); val address = UInt(32.W)
  val wdata = UInt(1024.W); val wstrb = UInt(128.W); val lastForInstruction = Bool()
}

/**
  * Single-issue, 16-tag adapter for the contest external-memory protocol.
  * Coalescing and load-data placement remain in the future LSU stage.
  */
class AecExternalMemoryEngine extends Module {
  val io = IO(new Bundle {
    val lineIn = Flipped(Decoupled(new AecLineRequest))
    val lineComplete = Decoupled(new Bundle { val warp = UInt(3.W); val tag = UInt(4.W); val write = Bool(); val lastForInstruction = Bool(); val rdata = UInt(1024.W); val error = Bool() })
    val memReqValid = Output(Bool()); val memReqReady = Input(Bool()); val memReqWrite = Output(Bool()); val memReqAddr = Output(UInt(32.W))
    val memReqWdata = Output(UInt(1024.W)); val memReqWstrb = Output(UInt(128.W)); val memReqTag = Output(UInt(4.W))
    val memRspValid = Input(Bool()); val memRspReady = Output(Bool()); val memRspRdata = Input(UInt(1024.W)); val memRspTag = Input(UInt(4.W)); val memRspError = Input(Bool())
    val outstanding = Output(UInt(5.W))
  })
  val valid = RegInit(VecInit(Seq.fill(AecFrontendConfig.Outstanding)(false.B)))
  val warp = Reg(Vec(AecFrontendConfig.Outstanding, UInt(3.W))); val write = Reg(Vec(AecFrontendConfig.Outstanding, Bool())); val last = Reg(Vec(AecFrontendConfig.Outstanding, Bool()))
  val free = VecInit((0 until AecFrontendConfig.Outstanding).map(i => !valid(i))).asUInt
  val hasFree = free.orR; val tag = PriorityEncoder(free)
  io.lineIn.ready := hasFree && io.memReqReady
  io.memReqValid := io.lineIn.valid && hasFree
  io.memReqWrite := io.lineIn.bits.write; io.memReqAddr := io.lineIn.bits.address; io.memReqWdata := io.lineIn.bits.wdata; io.memReqWstrb := io.lineIn.bits.wstrb; io.memReqTag := tag
  when (io.lineIn.fire) { valid(tag) := true.B; warp(tag) := io.lineIn.bits.warp; write(tag) := io.lineIn.bits.write; last(tag) := io.lineIn.bits.lastForInstruction }
  io.lineComplete.valid := io.memRspValid && valid(io.memRspTag)
  io.lineComplete.bits.warp := warp(io.memRspTag); io.lineComplete.bits.tag := io.memRspTag; io.lineComplete.bits.write := write(io.memRspTag)
  io.lineComplete.bits.lastForInstruction := last(io.memRspTag); io.lineComplete.bits.rdata := io.memRspRdata; io.lineComplete.bits.error := io.memRspError
  io.memRspReady := io.lineComplete.ready && valid(io.memRspTag)
  when (io.lineComplete.fire) { valid(io.memRspTag) := false.B }
  io.outstanding := PopCount(valid)
}
