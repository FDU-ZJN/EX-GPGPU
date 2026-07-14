package aec

import chisel3._
import chisel3.util._

/** One full-warp vector source read from a lane-banked register file. */
class AecRegReadRequest extends Bundle {
  val warpLocal = UInt(1.W); val reg = UInt(8.W); val tag = UInt(3.W)
}

class AecRegReadResponse extends Bundle {
  val data = Vec(32, UInt(32.W)); val tag = UInt(3.W)
}

/**
  * One scheduler partition's GPR and predicate storage.
  *
  * Each lane owns one 512x32 SRAM: row={warpLocal,reg}. A source read therefore
  * returns all 32 lanes in one macro cycle, while predicated writeback drives
  * the native write enable independently for every lane bank.
  */
class AecRegBank extends Module {
  val io = IO(new Bundle {
    val read = Flipped(Decoupled(new AecRegReadRequest))
    val response = Decoupled(new AecRegReadResponse)
    val writeValid = Input(Bool()); val writeWarpLocal = Input(UInt(1.W))
    val writeReg = Input(UInt(8.W)); val writeData = Input(Vec(32, UInt(32.W)))
    val writeMask = Input(UInt(32.W))
    val predWriteValid = Input(Bool()); val predWarpLocal = Input(UInt(1.W))
    val predIndex = Input(UInt(3.W)); val predData = Input(UInt(32.W)); val predWriteMask = Input(UInt(32.W))
    val predReadWarpLocal = Input(UInt(1.W)); val predReadIndex = Input(UInt(3.W)); val predMask = Output(UInt(32.W))
    val clear = Input(Bool())
  })

  val gpr = Seq.fill(32)(Module(new AecSram512x32))
  val gprValid = RegInit(VecInit(Seq.fill(32)(0.U(512.W))))
  val predicates = RegInit(VecInit(Seq.fill(2)(VecInit(Seq.fill(32)(VecInit(Seq.fill(8)(false.B)))))))
  val pending = RegInit(false.B); val pendingTag = Reg(UInt(3.W))
  val pendingValid = Reg(Vec(32, Bool()))
  val readRow = Cat(io.read.bits.warpLocal, io.read.bits.reg)
  val writeRow = Cat(io.writeWarpLocal, io.writeReg)
  val doWrite = io.writeValid && !io.clear

  for (lane <- 0 until 32) {
    val macroLane = gpr(lane)
    macroLane.io.clk := clock
    macroLane.io.en := io.read.fire || (doWrite && io.writeMask(lane))
    macroLane.io.read_en := io.read.fire
    macroLane.io.write_en := doWrite && io.writeMask(lane)
    macroLane.io.addr := Mux(doWrite, writeRow, readRow)
    macroLane.io.write_data := io.writeData(lane)
  }

  io.read.ready := !pending && !doWrite
  io.response.valid := pending
  io.response.bits.tag := pendingTag
  for (lane <- 0 until 32) {
    io.response.bits.data(lane) := Mux(pendingValid(lane), gpr(lane).io.read_data, 0.U)
  }
  when (io.read.fire) {
    pending := true.B; pendingTag := io.read.bits.tag
    for (lane <- 0 until 32) { pendingValid(lane) := gprValid(lane)(readRow) }
  }
  when (io.response.fire) { pending := false.B }

  when (io.clear) {
    for (lane <- 0 until 32) { gprValid(lane) := 0.U }
    for (warp <- 0 until 2; lane <- 0 until 32; pred <- 0 until 8) { predicates(warp)(lane)(pred) := false.B }
  }.elsewhen (doWrite) {
    for (lane <- 0 until 32) {
      when (io.writeMask(lane)) { gprValid(lane) := gprValid(lane) | (1.U(512.W) << writeRow) }
    }
  }
  when (io.predWriteValid && !io.clear) {
    for (lane <- 0 until 32) {
      when (io.predWriteMask(lane)) { predicates(io.predWarpLocal)(lane)(io.predIndex) := io.predData(lane) }
    }
  }
  io.predMask := VecInit((0 until 32).map(lane => predicates(io.predReadWarpLocal)(lane)(io.predReadIndex))).asUInt
}
