package aec

import chisel3._
import chisel3.util._

/**
  * Serialized architectural local-memory engine.
  *
  * SMEM/CMEM/PMEM and the per-thread LMEM aperture are resident arrays.  One
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
  // Valid bits give launch-clear semantics without bulk-writing the SRAM.
  val smemValid = RegInit(0.U(AecFrontendConfig.SmemWords.W))
  val lmemWords = AecFrontendConfig.Warps * AecFrontendConfig.Lanes * 1024
  val lmem = Module(new AecBankedSram32(lmemWords))
  // A per-word generation tag implements launch clear without creating a
  // quarter-megabit reset vector (which also maps cleanly to SRAM wrappers).
  val lmemGeneration = RegInit(0.U(8.W))
  val lmemTag = Module(new AecBankedSram32(lmemWords / 4))
  val cmem = Module(new AecBankedSram32(AecFrontendConfig.LocalWords))
  val pmem = Module(new AecBankedSram32(AecFrontendConfig.LocalWords))
  val cmemValid = RegInit(0.U(AecFrontendConfig.LocalWords.W))
  val pmemValid = RegInit(0.U(AecFrontendConfig.LocalWords.W))
  val idle :: precheck :: check :: readAccess :: readLo :: writeLo :: atomicExec :: finish :: preloadRead :: preloadWrite :: scrubTags :: Nil = Enum(11)
  val state = RegInit(idle)
  val held = Reg(io.start.bits.cloneType)
  val lane = RegInit(0.U(5.W)); val bytePart = RegInit(0.U(4.W))
  val data = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val failed = RegInit(false.B)
  val preloadHeld = Reg(io.preload.bits.cloneType)
  val preloadByte = RegInit(0.U(4.W))
  val scrubAddress = RegInit(0.U(16.W))

  def selected(mask: UInt, after: UInt): UInt = {
    val consumed = (1.U(33.W) << after) - 1.U
    PriorityEncoder((Cat(0.U(1.W), mask) & ~consumed)(31, 0))
  }
  val bytes = Mux(held.width64, 8.U(4.W), 4.U(4.W))
  val currentAddress = held.address(lane)
  val fastWord = !held.width64 && currentAddress(1, 0) === 0.U
  val localLimit = Mux(held.space === AecMemorySpace.lmem, 4096.U, 65536.U)
  val inRange = currentAddress <= (localLimit - bytes)
  val wordAddress = (currentAddress + bytePart)(15, 2)
  val byteOffset = (currentAddress + bytePart)(1, 0)
  val lmemAddress = Cat(held.warp, lane, wordAddress(9, 0))
  val lmemTagAddress = lmemAddress(17, 2)
  val lmemTagShift = lmemAddress(1, 0) << 3
  val selectedLmemTag = (lmemTag.io.readData >> lmemTagShift)(7, 0)
  val mergedLmemTag = (lmemTag.io.readData & ~(255.U(32.W) << lmemTagShift)) |
    (lmemGeneration << lmemTagShift)
  val smemWord = Mux(smemValid(wordAddress), smem.io.readData, 0.U)
  val lmemWord = Mux(selectedLmemTag === lmemGeneration, lmem.io.readData, 0.U)
  val source = Mux(held.space === AecMemorySpace.smem, smemWord,
    Mux(held.space === AecMemorySpace.lmem, lmemWord,
      Mux(held.space === AecMemorySpace.cmem,
        Mux(cmemValid(wordAddress), cmem.io.readData, 0.U),
        Mux(pmemValid(wordAddress), pmem.io.readData, 0.U))))
  val replacementByte = (held.storeData(lane) >> (bytePart << 3))(7, 0)
  val mergedWord = Mux(fastWord, held.storeData(lane)(31, 0),
    (source & ~(255.U(32.W) << (byteOffset << 3))) | (replacementByte << (byteOffset << 3)))

  io.start.ready := state === idle
  io.done.valid := state === finish
  io.done.bits.loadData := data
  io.done.bits.error := failed
  io.preload.ready := state === idle
  io.clearBusy := state === scrubTags

  val localRead = state === readAccess
  val preloadByteAddress = preloadHeld.address +& preloadByte
  val preloadAddress = preloadByteAddress(15, 2)
  val preloadOld = Mux(preloadHeld.pmem,
    Mux(pmemValid(preloadAddress), pmem.io.readData, 0.U),
    Mux(cmemValid(preloadAddress), cmem.io.readData, 0.U))
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
  lmem.io.en := localRead && held.space === AecMemorySpace.lmem
  lmem.io.readEn := lmem.io.en
  lmem.io.writeEn := false.B
  lmem.io.address := lmemAddress
  lmem.io.writeData := mergedWord
  lmemTag.io.en := (localRead && held.space === AecMemorySpace.lmem) || state === scrubTags
  lmemTag.io.readEn := lmemTag.io.en
  lmemTag.io.writeEn := state === scrubTags
  lmemTag.io.address := Mux(state === scrubTags, scrubAddress, lmemTagAddress)
  lmemTag.io.writeData := Mux(state === scrubTags, 0.U, mergedLmemTag)
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

  when (io.clearSmem) {
    smemValid := 0.U
    when (lmemGeneration === 255.U) {
      lmemGeneration := 0.U; scrubAddress := 0.U; state := scrubTags
    }.otherwise { lmemGeneration := lmemGeneration + 1.U }
  }
  when (state === scrubTags) {
    lmemTag.io.en := true.B; lmemTag.io.readEn := false.B; lmemTag.io.writeEn := true.B
    when (scrubAddress === 65535.U) { state := idle }
      .otherwise { scrubAddress := scrubAddress + 1.U }
  }

  when (io.preload.fire) {
    preloadHeld := io.preload.bits
    preloadByte := 0.U
    state := preloadRead
  }
  when (state === preloadRead) { state := preloadWrite }
  when (state === preloadWrite) {
    when (preloadHeld.pmem && preloadEnabled) {
      pmem.io.en := true.B; pmem.io.readEn := false.B; pmem.io.writeEn := true.B
      pmemValid := pmemValid | (1.U(AecFrontendConfig.LocalWords.W) << preloadAddress)
    }.elsewhen (preloadEnabled) {
      cmem.io.en := true.B; cmem.io.readEn := false.B; cmem.io.writeEn := true.B
      cmemValid := cmemValid | (1.U(AecFrontendConfig.LocalWords.W) << preloadAddress)
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
    when (!inRange || (held.atomic && (currentAddress(1, 0) =/= 0.U || held.space =/= AecMemorySpace.smem)) ||
      held.space === AecMemorySpace.cmem || held.space === AecMemorySpace.pmem) {
      failed := true.B; state := finish
    }.otherwise {
      val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
      when (remaining.orR) { lane := PriorityEncoder(remaining) }
        .otherwise { lane := PriorityEncoder(held.mask); bytePart := 0.U; state := readAccess }
    }
  }
  when (state === check) {
    when (!inRange || (!held.load && (held.space === AecMemorySpace.cmem || held.space === AecMemorySpace.pmem))) {
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
      smemValid := smemValid | (1.U(AecFrontendConfig.SmemWords.W) << wordAddress)
    }.elsewhen (held.space === AecMemorySpace.lmem) {
      lmem.io.en := true.B; lmem.io.readEn := false.B; lmem.io.writeEn := true.B
      lmemTag.io.en := true.B; lmemTag.io.readEn := false.B; lmemTag.io.writeEn := true.B
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
      0.U -> (old + update),
      1.U -> Mux(held.signed, Mux(oldS < updateS, old, update), Mux(old < update, old, update)),
      2.U -> Mux(held.signed, Mux(oldS > updateS, old, update), Mux(old > update, old, update)),
      3.U -> update, 4.U -> (old & update), 5.U -> (old | update), 6.U -> (old ^ update),
      7.U -> Mux(old === held.compareData(lane), update, old)))
    data(lane) := Cat(0.U(32.W), old)
    smem.io.en := true.B; smem.io.readEn := false.B; smem.io.writeEn := true.B
    smem.io.writeData := next
    smemValid := smemValid | (1.U(AecFrontendConfig.SmemWords.W) << wordAddress)
    val remaining = (Cat(0.U(1.W), held.mask) & ~((1.U(33.W) << (lane +& 1.U)) - 1.U))(31, 0)
    when (remaining.orR) { lane := PriorityEncoder(remaining); state := readAccess }.otherwise { state := finish }
  }
  when (io.done.fire) { state := idle }
}
