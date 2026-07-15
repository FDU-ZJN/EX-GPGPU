package aec

import chisel3._
import chisel3.util._

class AecGmemInstructionRequest extends Bundle {
  val space = Bool()
  val ctaThreadBase = UInt(20.W)
  val warp = UInt(3.W)
  val load = Bool()
  val width64 = Bool()
  val mask = UInt(32.W)
  val address = Vec(32, UInt(32.W))
  val storeData = Vec(32, UInt(32.W))
  val atomic = Bool()
  val atomicOp = UInt(3.W)
  val signed = Bool()
  val compareData = Vec(32, UInt(32.W))
}

class AecGmemInstructionResult extends Bundle {
  val loadData = Vec(32, UInt(64.W))
  val error = Bool()
}

class AecGmemStoreCommit extends Bundle {
  val address = UInt(32.W)
  val data = UInt(1024.W)
  val strb = UInt(128.W)
}

class AecGmemLoadAddressBank(val firstLane: Int, val lanes: Int = 4) extends Module {
  val io = IO(new Bundle {
    val capture = Input(Bool())
    val space = Input(Bool())
    val ctaThreadBase = Input(UInt(20.W))
    val warp = Input(UInt(3.W))
    val offset = Input(Vec(lanes, UInt(32.W)))
    val translated = Output(Vec(lanes, UInt(32.W)))
    val savedOffset = Output(Vec(lanes, UInt(32.W)))
  })
  val translated = Reg(Vec(lanes, UInt(32.W)))
  val savedOffset = Reg(Vec(lanes, UInt(32.W)))
  when (io.capture) {
    for (i <- 0 until lanes) {
      val lane = firstLane + i
      val globalThread = io.ctaThreadBase +& Cat(io.warp, lane.U(5.W))
      translated(i) := Mux(io.space,
        ((globalThread << 12) +& io.offset(i))(31, 0), io.offset(i))
      savedOffset(i) := io.offset(i)
    }
  }
  io.translated := translated
  io.savedOffset := savedOffset
}

class AecGmemLoadResultBank(val lanes: Int = 4) extends Module {
  val io = IO(new Bundle {
    val clear = Input(Bool())
    val write = Input(Bool())
    val lane = Input(UInt(log2Ceil(lanes).W))
    val mask = Input(UInt(64.W))
    val data = Input(UInt(64.W))
    val result = Output(Vec(lanes, UInt(64.W)))
  })
  val result = Reg(Vec(lanes, UInt(64.W)))
  when (io.clear) {
    result.foreach(_ := 0.U)
  }.elsewhen (io.write) {
    result(io.lane) := (result(io.lane) & ~io.mask) | (io.data & io.mask)
  }
  io.result := result
}

class AecGmemLoadResponseBank(val words: Int = 4) extends Module {
  val io = IO(new Bundle {
    val capture = Input(Bool())
    val data = Input(UInt((words * 32).W))
    val word = Output(Vec(words, UInt(32.W)))
  })
  val data = Reg(UInt((words * 32).W))
  when (io.capture) { data := io.data }
  io.word := VecInit((0 until words).map(i => data(i * 32 + 31, i * 32)))
}

/** Ordinary-load-only coalescer and return scatter pipeline. */
class AecGmemLoadPipeline(activeLanes: Int = 32) extends Module {
  require(activeLanes >= 1 && activeLanes <= 32)
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new AecGmemInstructionRequest))
    val lineOut = Decoupled(new AecLineRequest)
    val lineComplete = Flipped(Decoupled(new AecLineCompletion))
    val done = Decoupled(new AecGmemInstructionResult)
  })

  val shadow = Reg(new AecGmemInstructionRequest)
  shadow := io.start.bits
  val capturePending = RegInit(false.B)
  val finalizePending = RegInit(false.B)
  val active = RegInit(false.B)
  val doneValid = RegInit(false.B)
  val abort = RegInit(false.B)
  val error = RegInit(false.B)
  val heldSpace = Reg(Bool())
  val heldCtaThreadBase = Reg(UInt(20.W))
  val heldWarp = Reg(UInt(3.W))
  val heldWidth64 = Reg(Bool())
  val heldMask = Reg(UInt(32.W))

  val addressBanks = (0 until 8).map(bank =>
    Module(new AecGmemLoadAddressBank(bank * 4)))
  for ((bank, bankIndex) <- addressBanks.zipWithIndex) {
    bank.io.capture := capturePending
    bank.io.space := shadow.space
    bank.io.ctaThreadBase := shadow.ctaThreadBase
    bank.io.warp := shadow.warp
    bank.io.offset := VecInit((0 until 4).map(i => shadow.address(bankIndex * 4 + i)))
  }
  val heldAddress = VecInit(addressBanks.flatMap(_.io.translated))
  val heldOffset = VecInit(addressBanks.flatMap(_.io.savedOffset))

  val resultBanks = Seq.fill(8)(Module(new AecGmemLoadResultBank))
  val clearResults = io.start.fire
  resultBanks.foreach { bank =>
    bank.io.clear := clearResults
    bank.io.write := false.B
    bank.io.lane := 0.U
    bank.io.mask := 0.U
    bank.io.data := 0.U
  }
  io.done.bits.loadData := VecInit(resultBanks.flatMap(_.io.result))
  io.done.bits.error := error
  io.done.valid := doneValid

  val pendingParts = RegInit(0.U(64.W))
  val slotValid = RegInit(VecInit(Seq.fill(16)(false.B)))
  val slotGroup = Reg(Vec(16, UInt(64.W)))
  val slotLine = Reg(Vec(16, UInt(32.W)))
  val issueValid = RegInit(false.B)
  val issueLine = Reg(UInt(32.W))
  val issueToken = Reg(UInt(4.W))

  val responseValid = RegInit(false.B)
  val responseParts = Reg(UInt(64.W))
  val responseBanks = Seq.fill(8)(Module(new AecGmemLoadResponseBank))
  responseBanks.zipWithIndex.foreach { case (bank, i) =>
    bank.io.capture := io.lineComplete.fire && !io.lineComplete.bits.error && !abort
    bank.io.data := io.lineComplete.bits.rdata(i * 128 + 127, i * 128)
  }
  val responseWords = VecInit(responseBanks.flatMap(_.io.word))

  def accessBytes(width64: Bool): UInt = Mux(width64, 8.U(4.W), 4.U(4.W))
  def firstByteCount(address: UInt, bytes: UInt): UInt = {
    val room = 128.U(8.W) - address(6, 0)
    Mux(room >= bytes, bytes, room(3, 0))
  }

  val heldBytes = accessBytes(heldWidth64)
  val firstPendingPart = PriorityEncoder(pendingParts)
  val firstPendingLane = firstPendingPart(5, 1)
  val firstPendingSecond = firstPendingPart(0)
  val firstPendingBase = heldAddress(firstPendingLane) & "hffffff80".U
  val firstPendingLine = Mux(firstPendingSecond,
    firstPendingBase + 128.U, firstPendingBase)
  val partLines = VecInit((0 until 64).map { part =>
    val base = heldAddress(part / 2) & "hffffff80".U
    if ((part & 1) == 1) base + 128.U else base
  })
  val nextGroup = VecInit((0 until 64).map { part =>
    val laneActive = if (part / 2 < activeLanes) pendingParts(part) else false.B
    laneActive && partLines(part) === firstPendingLine
  }).asUInt
  val freeSlots = VecInit(slotValid.map(v => !v)).asUInt
  val hasFreeSlot = freeSlots.orR
  val freeToken = PriorityEncoder(freeSlots)

  io.start.ready := !active && !capturePending && !finalizePending && !doneValid
  when (io.start.fire) {
    capturePending := true.B
    abort := false.B
    error := false.B
    issueValid := false.B
    responseValid := false.B
    slotValid.foreach(_ := false.B)
  }
  when (capturePending) {
    capturePending := false.B
    finalizePending := true.B
    heldSpace := shadow.space
    heldCtaThreadBase := shadow.ctaThreadBase
    heldWarp := shadow.warp
    heldWidth64 := shadow.width64
    heldMask := shadow.mask
  }
  when (finalizePending) {
    val bytes = accessBytes(heldWidth64)
    val parts = VecInit((0 until 32).flatMap { lane =>
      val first = firstByteCount(heldAddress(lane), bytes)
      val laneActive = if (lane < activeLanes) heldMask(lane) else false.B
      Seq(laneActive, laneActive && first =/= bytes)
    }).asUInt
    val badLmem = heldSpace && VecInit((0 until activeLanes).map { lane =>
      val globalThread = heldCtaThreadBase +& Cat(heldWarp, lane.U(5.W))
      heldMask(lane) && (globalThread >= (1 << 20).U ||
        heldOffset(lane) +& bytes > 4096.U)
    }).asUInt.orR
    pendingParts := parts
    finalizePending := false.B
    active := parts.orR && !badLmem
    error := badLmem
    doneValid := !parts.orR || badLmem
  }

  val issueReady = !issueValid || io.lineOut.ready
  val generate = active && !abort && pendingParts.orR && hasFreeSlot
  when (issueReady) {
    issueValid := generate
    when (generate) {
      issueLine := firstPendingLine
      issueToken := freeToken
      slotValid(freeToken) := true.B
      slotGroup(freeToken) := nextGroup
      slotLine(freeToken) := firstPendingLine
      pendingParts := pendingParts & ~nextGroup
    }
  }

  io.lineOut.valid := issueValid
  io.lineOut.bits.space := heldSpace
  io.lineOut.bits.warp := heldWarp
  io.lineOut.bits.write := false.B
  io.lineOut.bits.address := issueLine
  io.lineOut.bits.wdata := 0.U
  io.lineOut.bits.wstrb := 0.U
  io.lineOut.bits.lastForInstruction := false.B
  io.lineOut.bits.cacheable := true.B
  io.lineOut.bits.token := issueToken

  io.lineComplete.ready := active && !responseValid &&
    slotValid(io.lineComplete.bits.token)
  when (io.lineComplete.fire) {
    val token = io.lineComplete.bits.token
    val remaining = slotValid.asUInt & ~UIntToOH(token, 16)
    slotValid(token) := false.B
    when (io.lineComplete.bits.error || abort) {
      when (io.lineComplete.bits.error) {
        abort := true.B
        error := true.B
        pendingParts := 0.U
      }
      when (!remaining.orR && !issueValid) {
        active := false.B
        doneValid := true.B
      }
    }.otherwise {
      responseParts := slotGroup(token)
      responseValid := true.B
    }
  }

  val scatterPart = PriorityEncoder(responseParts)
  val scatterLane = scatterPart(5, 1)
  val scatterSecond = scatterPart(0)
  val scatterAddress = heldAddress(scatterLane)
  val scatterFirstBytes = firstByteCount(scatterAddress, heldBytes)
  val scatterPartBytes = Mux(scatterSecond,
    heldBytes - scatterFirstBytes, scatterFirstBytes)
  val scatterOffset = Mux(scatterSecond, 0.U(7.W), scatterAddress(6, 0))
  val scatterWord = scatterOffset(6, 2)
  val scatterWord0 = responseWords(scatterWord)
  val scatterWord1 = Mux(scatterWord === 31.U, 0.U, responseWords(scatterWord + 1.U))
  val scatterWord2 = Mux(scatterWord >= 30.U, 0.U, responseWords(scatterWord + 2.U))
  val scatterWindow = Cat(scatterWord2, scatterWord1, scatterWord0) >>
    (scatterOffset(1, 0) << 3)
  val valueMask = ((1.U(65.W) << (scatterPartBytes << 3)) - 1.U)(63, 0)
  val destShift = Mux(scatterSecond, scatterFirstBytes << 3, 0.U)
  val incoming = ((scatterWindow(63, 0) & valueMask) << destShift)(63, 0)
  val placedMask = (valueMask << destShift)(63, 0)
  val nextParts = responseParts & ~UIntToOH(scatterPart, 64)
  for ((bank, bankIndex) <- resultBanks.zipWithIndex) {
    bank.io.write := responseValid && scatterLane(4, 2) === bankIndex.U
    bank.io.lane := scatterLane(1, 0)
    bank.io.mask := placedMask
    bank.io.data := incoming
  }
  when (responseValid) {
    responseParts := nextParts
    when (!nextParts.orR) {
      responseValid := false.B
      when (!pendingParts.orR && !slotValid.asUInt.orR && !issueValid) {
        active := false.B
        doneValid := true.B
      }
    }
  }

  when (io.done.fire) { doneValid := false.B }
}

class AecGmemDoneMuxBank(val lanes: Int = 4) extends Module {
  val io = IO(new Bundle {
    val selectLoad = Input(Bool())
    val load = Input(Vec(lanes, UInt(64.W)))
    val store = Input(Vec(lanes, UInt(64.W)))
    val out = Output(Vec(lanes, UInt(64.W)))
  })
  io.out := Mux(io.selectLoad, io.load, io.store)
}

/** Thin instruction router. The two engines never share state or wide control. */
class AecGmemPipeline(activeLanes: Int = 32) extends Module {
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new AecGmemInstructionRequest))
    val lineOut = Decoupled(new AecLineRequest)
    val lineComplete = Flipped(Decoupled(new AecLineCompletion))
    val done = Decoupled(new AecGmemInstructionResult)
    val storeCommit = Valid(new AecGmemStoreCommit)
  })

  val load = Module(new AecGmemLoadPipeline(activeLanes))
  val store = Module(new AecGmemStoreAtomicUnit(activeLanes))
  val busy = RegInit(false.B)
  val ownerLoad = RegInit(false.B)
  val selectLoad = io.start.bits.load && !io.start.bits.atomic

  load.io.start.bits := io.start.bits
  store.io.start.bits := io.start.bits
  store.io.start.bits.load := false.B
  load.io.start.valid := io.start.valid && !busy && selectLoad
  store.io.start.valid := io.start.valid && !busy && !selectLoad
  io.start.ready := !busy && Mux(selectLoad, load.io.start.ready, store.io.start.ready)
  when (io.start.fire) {
    busy := true.B
    ownerLoad := selectLoad
  }

  io.lineOut.valid := Mux(ownerLoad, load.io.lineOut.valid, store.io.lineOut.valid)
  io.lineOut.bits.space := Mux(ownerLoad, load.io.lineOut.bits.space, store.io.lineOut.bits.space)
  io.lineOut.bits.warp := Mux(ownerLoad, load.io.lineOut.bits.warp, store.io.lineOut.bits.warp)
  io.lineOut.bits.write := Mux(ownerLoad, false.B, store.io.lineOut.bits.write)
  io.lineOut.bits.address := Mux(ownerLoad, load.io.lineOut.bits.address, store.io.lineOut.bits.address)
  // Load requests are cacheable and these fields are ignored on that path.
  io.lineOut.bits.wdata := store.io.lineOut.bits.wdata
  io.lineOut.bits.wstrb := store.io.lineOut.bits.wstrb
  io.lineOut.bits.lastForInstruction := false.B
  io.lineOut.bits.cacheable := ownerLoad
  io.lineOut.bits.token := Mux(ownerLoad, load.io.lineOut.bits.token, 0.U)
  load.io.lineOut.ready := io.lineOut.ready && ownerLoad
  store.io.lineOut.ready := io.lineOut.ready && !ownerLoad

  load.io.lineComplete.valid := io.lineComplete.valid && ownerLoad
  store.io.lineComplete.valid := io.lineComplete.valid && !ownerLoad
  load.io.lineComplete.bits := io.lineComplete.bits
  store.io.lineComplete.bits := io.lineComplete.bits
  io.lineComplete.ready := Mux(ownerLoad,
    load.io.lineComplete.ready, store.io.lineComplete.ready)

  io.done.valid := Mux(ownerLoad, load.io.done.valid, store.io.done.valid)
  val doneBanks = (0 until 8).map(_ => Module(new AecGmemDoneMuxBank))
  doneBanks.zipWithIndex.foreach { case (bank, i) =>
    bank.io.selectLoad := ownerLoad
    bank.io.load := VecInit((0 until 4).map(j => load.io.done.bits.loadData(i * 4 + j)))
    bank.io.store := VecInit((0 until 4).map(j => store.io.done.bits.loadData(i * 4 + j)))
  }
  io.done.bits.loadData := VecInit(doneBanks.flatMap(_.io.out))
  io.done.bits.error := Mux(ownerLoad, load.io.done.bits.error, store.io.done.bits.error)
  load.io.done.ready := io.done.ready && ownerLoad
  store.io.done.ready := io.done.ready && !ownerLoad
  when (io.done.fire) { busy := false.B }

  io.storeCommit := store.io.storeCommit
}
