package aec

import chisel3._
import chisel3.util._

/** One full-warp vector source read from a lane-banked register file. */
class AecRegReadRequest extends Bundle {
  val warp = UInt(3.W); val reg = UInt(8.W); val tag = UInt(3.W)
}

class AecRegReadResponse extends Bundle {
  val data = Vec(32, UInt(32.W)); val tag = UInt(3.W)
}

class AecRowInitializedGroup extends Module {
  val io = IO(new Bundle {
    val write = Input(Bool())
    val initialized = Input(Bool())
    val bit = Input(UInt(5.W))
    val data = Output(UInt(32.W))
  })
  val data = Reg(UInt(32.W))
  val pending = RegInit(false.B)
  val bit = Reg(UInt(5.W))
  when (io.write) {
    pending := true.B
    bit := io.bit
  }
  when (pending) {
    pending := false.B
    data := Mux(io.initialized, data, 0.U) | UIntToOH(bit, 32)
  }
  io.data := data
}

class AecRowInitializedBank extends Module {
  val io = IO(new Bundle {
    val write = Input(Bool())
    val valid = Input(UInt(8.W))
    val group = Input(UInt(3.W))
    val bit = Input(UInt(5.W))
    val data = Output(UInt(32.W))
  })
  val groups = Seq.fill(8)(Module(new AecRowInitializedGroup))
  for (group <- 0 until 8) {
    groups(group).io.write := io.write && io.group === group.U
    groups(group).io.initialized := io.valid(group)
    groups(group).io.bit := io.bit
  }
  io.data := VecInit(groups.map(_.io.data))(io.group)
}

/**
  * One scheduler's architectural GPR and predicate storage.
  *
  * Each lane owns a 2048x32 bank built from two locked 1024x32 SRAMs. Rows are
  * addressed by {architecturalWarp,reg}. Lane validity is packed into a single
  * 2048x32 SRAM instead of 65536 resettable flops.
  */
class AecRegBank extends Module {
  val io = IO(new Bundle {
    val read = Flipped(Decoupled(new AecRegReadRequest))
    val response = Decoupled(new AecRegReadResponse)
    val writeValid = Input(Bool()); val writeReady = Output(Bool()); val writeWarp = Input(UInt(3.W))
    val writeReg = Input(UInt(8.W)); val writeData = Input(Vec(32, UInt(32.W)))
    val writeMask = Input(UInt(32.W))
    val predWriteValid = Input(Bool()); val predWarp = Input(UInt(3.W))
    val predIndex = Input(UInt(3.W)); val predData = Input(UInt(32.W)); val predWriteMask = Input(UInt(32.W))
    val predReadWarp = Input(UInt(3.W)); val predReadIndex = Input(UInt(3.W)); val predMask = Output(UInt(32.W))
    val clear = Input(Bool())
  })

  val gpr = Seq.fill(32)(Module(new AecBankedSram32(2048)))
  val validMasks = Module(new AecBankedSram32(2048))
  // Keep reset/clear off the 2048 row bits. Eight banks each own eight groups,
  // limiting metadata selection and write decode to a local 8-way structure.
  val rowInitialized = Seq.fill(8)(Module(new AecRowInitializedBank))
  val validGroups = RegInit(VecInit(Seq.fill(8)(0.U(8.W))))
  // Predicate rows are indexed by {warp,predicate}; their payload is one bit
  // per lane.  Only the compact row-valid vector is reset.
  val predicateRows = Reg(Vec(8, Vec(8, UInt(32.W))))
  val predicateValid = RegInit(VecInit(Seq.fill(8)(0.U(8.W))))
  val pending = RegInit(false.B); val pendingTag = Reg(UInt(3.W))
  val pendingRowValid = Reg(Bool())
  val validWritePending = RegInit(false.B)
  val validWriteRow = Reg(UInt(11.W))
  val validWriteMask = Reg(UInt(32.W))
  val validWriteInitialized = Reg(Bool())
  val writeIssuePending = RegInit(false.B)
  val writeWarp = Reg(UInt(3.W))
  val writeReg = Reg(UInt(8.W))
  val writeMask = Reg(UInt(32.W))
  val writeData = RegNext(io.writeData)
  val rowInitCommitPending = RegInit(false.B)
  val rowInitCommitGroup = Reg(UInt(6.W))
  val readRow = Cat(io.read.bits.warp, io.read.bits.reg)
  val writeRow = Cat(writeWarp, writeReg)
  def rowIsInitialized(row: UInt): Bool = {
    val bank = row(10, 8)
    val group = row(7, 5)
    validGroups(bank)(group) && VecInit(rowInitialized.map(_.io.data))(bank)(row(4, 0))
  }
  io.writeReady := !writeIssuePending && !validWritePending && !rowInitCommitPending && !io.clear
  val acceptWrite = io.writeValid && io.writeReady
  val doWrite = writeIssuePending
  val fullMaskWrite = doWrite && writeMask.andR
  val partialMaskWrite = doWrite && !writeMask.andR

  when (acceptWrite) {
    writeIssuePending := true.B
    writeWarp := io.writeWarp
    writeReg := io.writeReg
    writeMask := io.writeMask
  }
  when (doWrite) { writeIssuePending := false.B }

  for (lane <- 0 until 32) {
    val macroLane = gpr(lane)
    macroLane.io.en := io.read.fire || (doWrite && writeMask(lane))
    macroLane.io.readEn := io.read.fire
    macroLane.io.writeEn := doWrite && writeMask(lane)
    macroLane.io.address := Mux(doWrite, writeRow, readRow)
    macroLane.io.writeData := writeData(lane)
  }

  validMasks.io.en := io.read.fire || partialMaskWrite || fullMaskWrite || validWritePending
  validMasks.io.readEn := io.read.fire || partialMaskWrite
  validMasks.io.writeEn := fullMaskWrite || validWritePending
  validMasks.io.address := Mux(validWritePending, validWriteRow, Mux(doWrite, writeRow, readRow))
  validMasks.io.writeData := Mux(validWritePending,
    Mux(validWriteInitialized, validMasks.io.readData, 0.U) | validWriteMask,
    writeMask)

  io.read.ready := !pending && !doWrite && !validWritePending && !rowInitCommitPending
  io.response.valid := pending
  io.response.bits.tag := pendingTag
  for (lane <- 0 until 32) {
    io.response.bits.data(lane) := Mux(pendingRowValid && validMasks.io.readData(lane),
      gpr(lane).io.readData, 0.U)
  }
  when (io.read.fire) {
    pending := true.B
    pendingTag := io.read.bits.tag
    pendingRowValid := rowIsInitialized(readRow)
  }
  when (io.response.fire) { pending := false.B }

  when (partialMaskWrite) {
    validWritePending := true.B
    validWriteRow := writeRow
    validWriteMask := writeMask
    validWriteInitialized := rowIsInitialized(writeRow)
  }
  when (validWritePending) {
    validWritePending := false.B
    rowInitCommitPending := true.B
    rowInitCommitGroup := validWriteRow(10, 5)
  }
  when (fullMaskWrite) {
    rowInitCommitPending := true.B
    rowInitCommitGroup := writeRow(10, 5)
  }
  when (rowInitCommitPending) {
    rowInitCommitPending := false.B
    val bank = rowInitCommitGroup(5, 3)
    validGroups(bank) := validGroups(bank) | UIntToOH(rowInitCommitGroup(2, 0), 8)
  }
  for (bank <- 0 until 8) {
    val selectedGroup = Mux(validWritePending, validWriteRow(7, 5), writeRow(7, 5))
    rowInitialized(bank).io.write :=
      (validWritePending && validWriteRow(10, 8) === bank.U) ||
        (fullMaskWrite && writeRow(10, 8) === bank.U)
    rowInitialized(bank).io.valid := validGroups(bank)
    rowInitialized(bank).io.group := selectedGroup
    rowInitialized(bank).io.bit := Mux(validWritePending, validWriteRow(4, 0), writeRow(4, 0))
  }

  when (io.clear) {
    validGroups := VecInit(Seq.fill(8)(0.U(8.W)))
    predicateValid := VecInit(Seq.fill(8)(0.U(8.W)))
    validWritePending := false.B
    writeIssuePending := false.B
    rowInitCommitPending := false.B
  }
  when (io.predWriteValid && !io.clear) {
    val prior = Mux(predicateValid(io.predWarp)(io.predIndex),
      predicateRows(io.predWarp)(io.predIndex), 0.U)
    predicateRows(io.predWarp)(io.predIndex) :=
      (prior & ~io.predWriteMask) | (io.predData & io.predWriteMask)
    predicateValid(io.predWarp) := predicateValid(io.predWarp) | UIntToOH(io.predIndex, 8)
  }
  io.predMask := Mux(predicateValid(io.predReadWarp)(io.predReadIndex),
    predicateRows(io.predReadWarp)(io.predReadIndex), 0.U)
}
