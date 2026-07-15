package aec

import chisel3._
import chisel3.util._

/** Synchronous two-read/one-write GPR interface for one two-warp partition. */
class AecRegReadRequest extends Bundle {
  val warpLocal = UInt(1.W); val lane = UInt(5.W)
  val rs1 = UInt(8.W); val rs2 = UInt(8.W); val tag = UInt(8.W)
}

class AecRegReadResponse extends Bundle {
  val data1 = UInt(32.W); val data2 = UInt(32.W); val tag = UInt(8.W)
}

/**
  * One scheduler partition's 2R1W GPR and predicate storage.  A validity map
  * implements the architectural zero state without requiring SRAM data reset.
  */
class AecRegBank extends Module {
  val io = IO(new Bundle {
    val read = Flipped(Decoupled(new AecRegReadRequest))
    val response = Decoupled(new AecRegReadResponse)
    val writeValid = Input(Bool()); val writeWarpLocal = Input(UInt(1.W))
    val writeLane = Input(UInt(5.W)); val writeReg = Input(UInt(8.W)); val writeData = Input(UInt(32.W))
    val predWriteValid = Input(Bool()); val predWarpLocal = Input(UInt(1.W))
    val predLane = Input(UInt(5.W)); val predIndex = Input(UInt(3.W)); val predData = Input(Bool())
    val predReadWarpLocal = Input(UInt(1.W)); val predReadIndex = Input(UInt(3.W)); val predMask = Output(UInt(32.W))
    val clear = Input(Bool())
  })

  val wordsPerWarp = AecFrontendConfig.Lanes * AecFrontendConfig.Registers
  // The native SRAM is 1RW. Duplicate the data array to provide the two
  // architectural read ports; writes update both copies in lockstep.
  val gpr0 = Module(new AecBankedSram32(wordsPerWarp * 2))
  val gpr1 = Module(new AecBankedSram32(wordsPerWarp * 2))
  val gprValid = RegInit(0.U((wordsPerWarp * 2).W))
  val predicates = RegInit(VecInit(Seq.fill(2)(VecInit(Seq.fill(32)(VecInit(Seq.fill(8)(false.B)))))))
  def address(warp: UInt, lane: UInt, reg: UInt): UInt = Cat(warp, lane, reg)

  val pending = RegInit(false.B); val pendingTag = Reg(UInt(8.W))
  val pendingValid0 = RegInit(false.B); val pendingValid1 = RegInit(false.B)
  val readAddress0 = address(io.read.bits.warpLocal, io.read.bits.lane, io.read.bits.rs1)
  val readAddress1 = address(io.read.bits.warpLocal, io.read.bits.lane, io.read.bits.rs2)
  val writeAddress = address(io.writeWarpLocal, io.writeLane, io.writeReg)
  val doWrite = io.writeValid && !io.clear
  gpr0.io.en := io.read.fire || doWrite
  gpr0.io.readEn := io.read.fire
  gpr0.io.writeEn := doWrite
  gpr0.io.address := Mux(doWrite, writeAddress, readAddress0)
  gpr0.io.writeData := io.writeData
  gpr1.io.en := io.read.fire || doWrite
  gpr1.io.readEn := io.read.fire
  gpr1.io.writeEn := doWrite
  gpr1.io.address := Mux(doWrite, writeAddress, readAddress1)
  gpr1.io.writeData := io.writeData
  when (io.read.fire) {
    pending := true.B; pendingTag := io.read.bits.tag
    pendingValid0 := gprValid(address(io.read.bits.warpLocal, io.read.bits.lane, io.read.bits.rs1))
    pendingValid1 := gprValid(address(io.read.bits.warpLocal, io.read.bits.lane, io.read.bits.rs2))
  }
  // Keep one explicit synchronous-read transaction in flight.  Accepting a
  // replacement request in the response cycle overwrites the tag before the
  // frontend can consume it, which breaks the final-lane transition.
  io.read.ready := !pending
  io.response.valid := pending
  io.response.bits.data1 := Mux(pendingValid0, gpr0.io.readData, 0.U)
  io.response.bits.data2 := Mux(pendingValid1, gpr1.io.readData, 0.U)
  io.response.bits.tag := pendingTag
  when (io.response.fire) { pending := false.B }

  when (io.clear) {
    gprValid := 0.U
    for (warp <- 0 until 2; lane <- 0 until 32; pred <- 0 until 8) { predicates(warp)(lane)(pred) := false.B }
  }.elsewhen (io.writeValid) {
    gprValid := gprValid | (1.U((wordsPerWarp * 2).W) << address(io.writeWarpLocal, io.writeLane, io.writeReg))
  }
  when (io.predWriteValid && !io.clear) { predicates(io.predWarpLocal)(io.predLane)(io.predIndex) := io.predData }
  io.predMask := VecInit((0 until 32).map(lane => predicates(io.predReadWarpLocal)(lane)(io.predReadIndex))).asUInt
}
