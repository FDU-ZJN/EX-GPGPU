package aec

import chisel3._
import chisel3.util._

/**
  * Serialized architectural local-memory engine.
  *
  * SMEM/CMEM/PMEM are resident arrays. LMEM uses the external line service. One
  * lane is completed at a time; that
  * keeps an instruction atomic with respect to range failures and makes the
  * required pre-instruction read / post-instruction write ordering explicit.
  */
class AecLocalLsu extends Module {
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new AecLocalMemoryRequest))
    val done = Decoupled(new Bundle { val loadData = Vec(32, UInt(64.W)); val error = Bool() })
    val clearSmem = Input(Bool())
    val clearBusy = Output(Bool())
    val preload = Flipped(Decoupled(new Bundle {
      val pmem = Bool(); val address = UInt(16.W)
      val data = UInt(128.W); val mask = UInt(16.W)
    }))
  })

  // Use byte-addressed words.  The sequencer performs a byte update for
  // misaligned accesses, so there is no dependence on host endianness.
  val smem = Module(new AecBankedSram32(AecFrontendConfig.SmemWords))
  val smemValid = Module(new AecPackedValidSram(AecFrontendConfig.SmemWords))
  val cmem = Module(new AecBankedSram32(AecFrontendConfig.LocalWords))
  val pmem = Module(new AecBankedSram32(AecFrontendConfig.LocalWords))
  val cmemValid = Module(new AecPackedValidSram(AecFrontendConfig.LocalWords))
  val pmemValid = Module(new AecPackedValidSram(AecFrontendConfig.LocalWords))
  val cmemCapacity = RegInit(0.U(17.W)); val pmemCapacity = RegInit(0.U(17.W))
  val idle :: precheck :: check :: readAccess :: readLo :: writeLo :: atomicExec :: finish :: preloadRead :: preloadWrite :: Nil = Enum(10)
  val state = RegInit(idle)
  val held = Reg(io.start.bits.cloneType)
  val lane = RegInit(0.U(5.W)); val bytePart = RegInit(0.U(4.W))
  val data = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val failed = RegInit(false.B)
  val preloadHeld = Reg(io.preload.bits.cloneType)
  val preloadByte = RegInit(0.U(4.W))

  def selected(mask: UInt, after: UInt): UInt = {
    val consumed = (1.U(33.W) << after) - 1.U
    PriorityEncoder((Cat(0.U(1.W), mask) & ~consumed)(31, 0))
  }
  val bytes = Mux(held.width64, 8.U(4.W), 4.U(4.W))
  val currentAddress = held.address(lane)
  val fastWord = !held.width64 && currentAddress(1, 0) === 0.U
  val localLimit = Mux(held.space === AecMemorySpace.smem, 65536.U(17.W),
    Mux(held.space === AecMemorySpace.cmem, cmemCapacity, pmemCapacity))
  val inRange = (currentAddress +& bytes) <= localLimit
  val wordAddress = (currentAddress + bytePart)(15, 2)
  val byteOffset = (currentAddress + bytePart)(1, 0)
  val smemWord = Mux(smemValid.io.valid, smem.io.readData, 0.U)
  val source = Mux(held.space === AecMemorySpace.smem, smemWord,
    Mux(held.space === AecMemorySpace.cmem,
      Mux(cmemValid.io.valid, cmem.io.readData, 0.U),
      Mux(pmemValid.io.valid, pmem.io.readData, 0.U)))
  val replacementByte = (held.storeData(lane) >> (bytePart << 3))(7, 0)
  val mergedWord = Mux(fastWord, held.storeData(lane)(31, 0),
    (source & ~(255.U(32.W) << (byteOffset << 3))) | (replacementByte << (byteOffset << 3)))

  io.start.ready := state === idle
  io.done.valid := state === finish
  io.done.bits.loadData := data
  io.done.bits.error := failed
  io.preload.ready := state === idle
  io.clearBusy := false.B

  val localRead = state === readAccess
  val preloadByteAddress = preloadHeld.address +& preloadByte
  val preloadAddress = preloadByteAddress(15, 2)
  val preloadOld = Mux(preloadHeld.pmem,
    Mux(pmemValid.io.valid, pmem.io.readData, 0.U),
    Mux(cmemValid.io.valid, cmem.io.readData, 0.U))
  val preloadData = (preloadHeld.data >> (preloadByte << 3))(7, 0)
  val preloadEnabled = preloadHeld.mask(preloadByte)
  val preloadShift = preloadByteAddress(1, 0) << 3
  val preloadBitMask = 255.U(32.W) << preloadShift
  val preloadMerged = (preloadOld & ~preloadBitMask) | (preloadData << preloadShift)

  smem.io.en := localRead && held.space === AecMemorySpace.smem
  smem.io.readEn := smem.io.en
  smem.io.writeEn := false.B
  smem.io.address := wordAddress
  smem.io.writeData := mergedWord
  cmem.io.en := (localRead && held.space === AecMemorySpace.cmem) || (state === preloadRead && !preloadHeld.pmem)
  cmem.io.readEn := cmem.io.en
  cmem.io.writeEn := false.B
  cmem.io.address := Mux(state === preloadRead || state === preloadWrite, preloadAddress, wordAddress)
  cmem.io.writeData := preloadMerged
  pmem.io.en := (localRead && held.space === AecMemorySpace.pmem) || (state === preloadRead && preloadHeld.pmem)
  pmem.io.readEn := pmem.io.en
  pmem.io.writeEn := false.B
  pmem.io.address := Mux(state === preloadRead || state === preloadWrite, preloadAddress, wordAddress)
  pmem.io.writeData := preloadMerged

  smemValid.io.clear := io.clearSmem
  smemValid.io.readEn := localRead && held.space === AecMemorySpace.smem
  smemValid.io.readAddress := wordAddress
  smemValid.io.writeEn := state === writeLo && held.space === AecMemorySpace.smem ||
    state === atomicExec && held.space === AecMemorySpace.smem &&
      (held.atomicOp =/= AecAtomicOp.cas || source === held.compareData(lane))
  smemValid.io.writeAddress := wordAddress
  cmemValid.io.clear := false.B
  cmemValid.io.readEn := localRead && held.space === AecMemorySpace.cmem || state === preloadRead && !preloadHeld.pmem
  cmemValid.io.readAddress := Mux(state === preloadRead, preloadAddress, wordAddress)
  cmemValid.io.writeEn := state === preloadWrite && !preloadHeld.pmem && preloadEnabled
  cmemValid.io.writeAddress := preloadAddress
  pmemValid.io.clear := false.B
  pmemValid.io.readEn := localRead && held.space === AecMemorySpace.pmem || state === preloadRead && preloadHeld.pmem
  pmemValid.io.readAddress := Mux(state === preloadRead, preloadAddress, wordAddress)
  pmemValid.io.writeEn := state === preloadWrite && preloadHeld.pmem && preloadEnabled
  pmemValid.io.writeAddress := preloadAddress

  when (io.preload.fire) {
    preloadHeld := io.preload.bits
    preloadByte := 0.U
    state := preloadRead
  }
  when (state === preloadRead) { state := preloadWrite }
  when (state === preloadWrite) {
    when (preloadHeld.pmem && preloadEnabled) {
      pmem.io.en := true.B; pmem.io.readEn := false.B; pmem.io.writeEn := true.B
      when (preloadByteAddress +& 1.U > pmemCapacity) { pmemCapacity := preloadByteAddress +& 1.U }
    }.elsewhen (preloadEnabled) {
      cmem.io.en := true.B; cmem.io.readEn := false.B; cmem.io.writeEn := true.B
      when (preloadByteAddress +& 1.U > cmemCapacity) { cmemCapacity := preloadByteAddress +& 1.U }
    }
    when (preloadByte === 15.U) { state := idle }
      .otherwise { preloadByte := preloadByte + 1.U; state := preloadRead }
  }

  when (io.start.fire) {
    held := io.start.bits; lane := PriorityEncoder(io.start.bits.mask); bytePart := 0.U
    data := VecInit(Seq.fill(32)(0.U)); failed := false.B
    // Stores first scan every executing lane.  Only a fully valid warp may
    // enter the byte-write phase, so a late lane error cannot partially commit.
    state := Mux(io.start.bits.mask.orR, Mux(io.start.bits.load && !io.start.bits.atomic, check, precheck), finish)
  }
  when (state === precheck) {
    when (!inRange || held.space === AecMemorySpace.lmem || (held.atomic && (currentAddress(1, 0) =/= 0.U || held.space =/= AecMemorySpace.smem)) ||
      held.space === AecMemorySpace.cmem || held.space === AecMemorySpace.pmem) {
      failed := true.B; state := finish
    }.otherwise {
      val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
      when (remaining.orR) { lane := PriorityEncoder(remaining) }
        .otherwise { lane := PriorityEncoder(held.mask); bytePart := 0.U; state := readAccess }
    }
  }
  when (state === check) {
    when (!inRange || held.space === AecMemorySpace.lmem || (!held.load && (held.space === AecMemorySpace.cmem || held.space === AecMemorySpace.pmem))) {
      failed := true.B; state := finish
    }.otherwise { state := readAccess }
  }
  when (state === readAccess) {
    state := Mux(held.load && !held.atomic, readLo, Mux(held.atomic, atomicExec, writeLo))
  }
  when (state === readLo) {
    data(lane) := Mux(fastWord, Cat(0.U(32.W), source),
      data(lane) | (((source >> (byteOffset << 3))(7, 0)).asUInt << (bytePart << 3)))
    when (fastWord || bytePart + 1.U === bytes) {
      val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
      when (remaining.orR) { lane := PriorityEncoder(remaining); bytePart := 0.U; state := check }
        .otherwise { state := finish }
    }.otherwise { bytePart := bytePart + 1.U; state := readAccess }
  }
  when (state === writeLo) {
    when (held.space === AecMemorySpace.smem) {
      smem.io.en := true.B; smem.io.readEn := false.B; smem.io.writeEn := true.B
    }
    when (fastWord || bytePart + 1.U === bytes) {
      val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
      when (remaining.orR) { lane := PriorityEncoder(remaining); bytePart := 0.U; state := readAccess }
        .otherwise { state := finish }
    }.otherwise { bytePart := bytePart + 1.U; state := readAccess }
  }
  when (state === atomicExec) {
    val old = source
    val update = held.storeData(lane)(31, 0)
    val oldS = old.asSInt; val updateS = update.asSInt
    val next = MuxLookup(held.atomicOp, old + update, Seq(
      AecAtomicOp.add -> (old + update),
      AecAtomicOp.max -> Mux(held.signed, Mux(oldS > updateS, old, update), Mux(old > update, old, update)),
      AecAtomicOp.min -> Mux(held.signed, Mux(oldS < updateS, old, update), Mux(old < update, old, update)),
      AecAtomicOp.xchg -> update, AecAtomicOp.andOp -> (old & update),
      AecAtomicOp.orOp -> (old | update), AecAtomicOp.xorOp -> (old ^ update),
      AecAtomicOp.cas -> Mux(old === held.compareData(lane), update, old)))
    val casSuccess = old === held.compareData(lane)
    val writesAtomic = held.atomicOp =/= AecAtomicOp.cas || casSuccess
    data(lane) := Cat(0.U(32.W), old)
    smem.io.en := writesAtomic; smem.io.readEn := false.B; smem.io.writeEn := writesAtomic
    smem.io.writeData := next
    val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
    when (remaining.orR) { lane := PriorityEncoder(remaining); state := readAccess }.otherwise { state := finish }
  }
  when (io.done.fire) { state := idle }
}
