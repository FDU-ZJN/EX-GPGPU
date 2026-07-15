package aec

import chisel3._
import chisel3.util._

/** Black-box declaration for the locked Track-B 1024x32 SRAM wrapper. */
class AecSram1024x32 extends BlackBox {
  override def desiredName: String = "aec_sram_1024x32"
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val en = Input(Bool())
    val read_en = Input(Bool())
    val write_en = Input(Bool())
    val addr = Input(UInt(10.W))
    val write_data = Input(UInt(32.W))
    val read_data = Output(UInt(32.W))
  })
}

/** Black-box declaration for the locked Track-B 512x32 SRAM wrapper. */
class AecSram512x32 extends BlackBox {
  override def desiredName: String = "aec_sram_512x32"
  val io = IO(new Bundle {
    val clk = Input(Clock()); val en = Input(Bool())
    val read_en = Input(Bool()); val write_en = Input(Bool())
    val addr = Input(UInt(9.W)); val write_data = Input(UInt(32.W))
    val read_data = Output(UInt(32.W))
  })
}

/**
  * Synchronous single-read/write-port memory composed only from the locked
  * Track-B 1024x32 macro. Depth must be a power-of-two multiple of 1024.
  *
  * The selected bank is registered alongside a read request so readData has
  * exactly the native macro's one-cycle latency. A read and write in the same
  * cycle is deliberately rejected by construction at each call site.
  */
class AecBankedSram32(depth: Int) extends Module {
  require(depth >= 1024 && depth % 1024 == 0)
  require(isPow2(depth))
  private val banks = depth / 1024
  private val bankBits = log2Ceil(banks)

  val io = IO(new Bundle {
    val en = Input(Bool())
    val readEn = Input(Bool())
    val writeEn = Input(Bool())
    val address = Input(UInt(log2Ceil(depth).W))
    val writeData = Input(UInt(32.W))
    val readData = Output(UInt(32.W))
  })

  val macroBanks = Seq.fill(banks)(Module(new AecSram1024x32))
  val selected = if (banks == 1) 0.U else io.address(log2Ceil(depth) - 1, 10)
  val selectedRead = if (banks == 1) 0.U else RegEnable(selected, io.en && io.readEn)

  for ((bank, index) <- macroBanks.zipWithIndex) {
    val hit = if (banks == 1) true.B else selected === index.U
    bank.io.clk := clock
    bank.io.en := io.en && hit
    bank.io.read_en := io.readEn && hit
    bank.io.write_en := io.writeEn && hit
    bank.io.addr := io.address(9, 0)
    bank.io.write_data := io.writeData
  }
  io.readData := Mux1H((0 until banks).map(i => (selectedRead === i.U) -> macroBanks(i).io.read_data))
}

/** Packed validity storage for a 16K-word resident memory.
  *
  * One SRAM row holds the valid bits for 32 adjacent data words.  The small
  * rowInitialized vector makes an unread SRAM row architecturally zero after
  * reset or clear, without bulk-writing the macro.
  */
class AecPackedValidSram(depth: Int) extends Module {
  require(depth == 16384)

  val io = IO(new Bundle {
    val clear = Input(Bool())
    val readEn = Input(Bool())
    val readAddress = Input(UInt(log2Ceil(depth).W))
    val valid = Output(Bool())
    val writeEn = Input(Bool())
    val writeAddress = Input(UInt(log2Ceil(depth).W))
  })

  val validRows = Module(new AecSram1024x32)
  val rowInitialized = RegInit(0.U((depth / 32).W))
  val readRow = RegEnable(io.readAddress(log2Ceil(depth) - 1, 5), io.readEn)
  val readBit = RegEnable(io.readAddress(4, 0), io.readEn)
  val writeRow = io.writeAddress(log2Ceil(depth) - 1, 5)
  val writeBit = io.writeAddress(4, 0)
  val priorRow = Mux(rowInitialized(readRow), validRows.io.read_data, 0.U)

  validRows.io.clk := clock
  validRows.io.en := io.readEn || io.writeEn
  validRows.io.read_en := io.readEn
  validRows.io.write_en := io.writeEn
  validRows.io.addr := Mux(io.writeEn, writeRow, io.readAddress(log2Ceil(depth) - 1, 5))
  validRows.io.write_data := priorRow | UIntToOH(writeBit, 32)

  io.valid := rowInitialized(readRow) && validRows.io.read_data(readBit)

  when (io.writeEn) {
    assert(readRow === writeRow, "valid update must follow a read of the same row")
    rowInitialized := rowInitialized | UIntToOH(writeRow, depth / 32)
  }
  when (io.clear) { rowInitialized := 0.U }
}

/** 1024-entry, 128-bit IMEM made from four parallel 1024x32 macros. */
class AecInstructionSram extends Module {
  val io = IO(new Bundle {
    val readEn = Input(Bool())
    val readAddress = Input(UInt(10.W))
    val readData = Output(UInt(128.W))
    val writeEn = Input(Bool())
    val writeAddress = Input(UInt(10.W))
    val writeData = Input(UInt(128.W))
  })
  val slices = Seq.fill(4)(Module(new AecBankedSram32(1024)))
  for ((slice, word) <- slices.zipWithIndex) {
    slice.io.en := io.readEn || io.writeEn
    slice.io.readEn := io.readEn
    slice.io.writeEn := io.writeEn
    slice.io.address := Mux(io.writeEn, io.writeAddress, io.readAddress)
    slice.io.writeData := io.writeData(32 * word + 31, 32 * word)
  }
  io.readData := Cat(slices.reverse.map(_.io.readData))
}
