package aec

import chisel3._
import chisel3.util._

class AecGmemLineWord extends Module {
  val io = IO(new Bundle {
    val clear = Input(Bool())
    val mergeLow = Input(Bool())
    val mergeLowData = Input(UInt(32.W))
    val mergeLowStrb = Input(UInt(4.W))
    val mergeHigh = Input(Bool())
    val mergeHighData = Input(UInt(32.W))
    val mergeHighStrb = Input(UInt(4.W))
    val atomicWrite = Input(Bool())
    val atomicData = Input(UInt(32.W))
    val word = Output(UInt(32.W))
    val strb = Output(UInt(4.W))
  })

  val word = Reg(UInt(32.W))
  val strb = Reg(UInt(4.W))
  when (io.clear) {
    word := 0.U
    strb := 0.U
  }
  when (io.mergeLow) {
    word := word | io.mergeLowData
    strb := strb | io.mergeLowStrb
  }
  when (io.mergeHigh) {
    word := word | io.mergeHighData
    strb := strb | io.mergeHighStrb
  }
  when (io.atomicWrite) {
    word := io.atomicData
    strb := "hf".U
  }
  io.word := word
  io.strb := strb
}

/** Serialized store/atomic line assembly and precise preflight engine.
  * Ordinary loads are handled by AecGmemLoadPipeline and never enter this
  * control cone.
  */
class AecGmemStoreAtomicUnit(activeLanes: Int = 32) extends Module {
  require(activeLanes >= 1 && activeLanes <= 32)
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new AecGmemInstructionRequest))
    val lineOut = Decoupled(new AecLineRequest)
    val lineComplete = Flipped(Decoupled(new AecLineCompletion))
    val done = Decoupled(new AecGmemInstructionResult)
    val storeCommit = Valid(new AecGmemStoreCommit)
  })

  val (idle :: capture :: chooseLine :: scanParts :: drainPart :: request :: waitResponse ::
    atomicUpdate :: atomicDrain :: finished :: Nil) = Enum(10)
  val state = RegInit(idle)
  val inputShadow = Reg(io.start.bits.cloneType)
  val held = Reg(io.start.bits.cloneType)
  val heldAddressBytes = Reg(Vec(32, Vec(4, UInt(8.W))))
  val heldStoreBytes = Reg(Vec(32, Vec(4, UInt(8.W))))
  val heldCompareBytes = Reg(Vec(32, Vec(4, UInt(8.W))))
  val pendingParts = RegInit(0.U(64.W))
  val allParts = RegInit(0.U(64.W))
  val currentGroup = RegInit(0.U(64.W))
  val scanIndex = RegInit(0.U(6.W))
  val workValid = RegInit(false.B)
  val workMatch = RegInit(false.B)
  val workIndex = RegInit(0.U(6.W))
  val workWord = RegInit(0.U(5.W))
  val workLowData = RegInit(0.U(32.W))
  val workHighData = RegInit(0.U(32.W))
  val workLowByteMask = RegInit(0.U(4.W))
  val workHighByteMask = RegInit(0.U(4.W))
  val lineAddress = RegInit(0.U(32.W))
  val lineWordStores = Seq.fill(32)(Module(new AecGmemLineWord))
  for (word <- 0 until 32) {
    val store = lineWordStores(word).io
    store.clear := false.B
    store.mergeLow := false.B
    store.mergeLowData := 0.U
    store.mergeLowStrb := 0.U
    store.mergeHigh := false.B
    store.mergeHighData := 0.U
    store.mergeHighStrb := 0.U
    store.atomicWrite := false.B
    store.atomicData := 0.U
  }
  val lineWords = VecInit(lineWordStores.map(_.io.word))
  val lineStrb = VecInit(lineWordStores.map(_.io.strb))
  val preflight = RegInit(false.B)
  val atomicWrite = RegInit(false.B)
  val atomicPendingLanes = RegInit(0.U(32.W))
  val data = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val error = RegInit(false.B)
  def firstByteCount(address: UInt, bytes: UInt): UInt = {
    val room = 128.U(8.W) - address(6, 0)
    Mux(room >= bytes, bytes, room(3, 0))
  }

  def translatedAddress(space: Bool, ctaThreadBase: UInt, warp: UInt, lane: Int, offset: UInt): UInt = {
    val globalThread = ctaThreadBase +& Cat(warp, lane.U(5.W))
    Mux(space, ((globalThread << 12) +& offset)(31, 0), offset)
  }

  val heldBytes = 4.U(4.W)
  // Capture translated addresses once. Recomputing all 32 LMEM translations
  // from shared control registers made those controls high-fanout timing roots.
  val heldAddress = VecInit(heldAddressBytes.map(bytes => Cat(bytes.reverse)))
  val heldStoreData = VecInit(heldStoreBytes.map(bytes => Cat(bytes.reverse)))
  val heldCompareData = VecInit(heldCompareBytes.map(bytes => Cat(bytes.reverse)))
  val capturedAddress = VecInit((0 until 32).map(lane =>
    translatedAddress(inputShadow.space, inputShadow.ctaThreadBase, inputShadow.warp,
      lane, inputShadow.address(lane))))
  val capturedParts = VecInit((0 until 32).flatMap { lane =>
    val first = firstByteCount(capturedAddress(lane), 4.U)
    val active = if (lane < activeLanes) inputShadow.mask(lane) else false.B
    Seq(active, active && first =/= 4.U)
  }).asUInt

  val firstPendingPart = PriorityEncoder(pendingParts)
  val firstPendingLane = firstPendingPart(5, 1)
  val firstPendingSecond = firstPendingPart(0)
  val firstPendingBase = heldAddress(firstPendingLane) & "hffffff80".U
  val firstPendingLine = Mux(firstPendingSecond, firstPendingBase + 128.U, firstPendingBase)

  val scanLane = scanIndex(5, 1)
  val scanSecond = scanIndex(0)
  val scanAddress = heldAddress(scanLane)
  val scanFirstBytes = firstByteCount(scanAddress, heldBytes)
  val scanPartBytes = Mux(scanSecond, heldBytes - scanFirstBytes, scanFirstBytes)
  val scanOffset = Mux(scanSecond, 0.U(7.W), scanAddress(6, 0))
  val scanPartLine = Mux(scanSecond,
    (scanAddress & "hffffff80".U) + 128.U, scanAddress & "hffffff80".U)
  val scanPartActive = pendingParts(scanIndex)
  val scanMatch = scanPartActive && scanPartLine === lineAddress
  // A store part is at most four bytes. Insert it into at most two adjacent
  // 32-bit words rather than creating a 1024-bit barrel shifter per lane.
  val scanSource = Mux(scanSecond,
    heldStoreData(scanLane) >> (scanFirstBytes << 3), heldStoreData(scanLane))
  val scanWord = scanOffset(6, 2)
  val scanByte = scanOffset(1, 0)
  val scanShifted = Cat(0.U(32.W), scanSource) << (scanByte << 3)
  val scanRawByteMask = ((1.U(9.W) << scanPartBytes) - 1.U)(7, 0)
  val scanPlacedByteMask = (scanRawByteMask << scanByte)(7, 0)
  val scanLowByteMask = scanPlacedByteMask(3, 0)
  val scanHighByteMask = scanPlacedByteMask(7, 4)
  val scanLowDataMask = FillInterleaved(8, scanLowByteMask)
  val scanHighDataMask = FillInterleaved(8, scanHighByteMask)

  val requestData = Cat(lineWords.reverse)
  val requestStrb = Cat(lineStrb.reverse)

  io.start.ready := state === idle
  io.lineOut.valid := state === request
  io.lineOut.bits.space := held.space
  io.lineOut.bits.warp := held.warp
  io.lineOut.bits.write := Mux(held.atomic, atomicWrite, !preflight)
  io.lineOut.bits.address := lineAddress
  io.lineOut.bits.wdata := requestData
  io.lineOut.bits.wstrb := requestStrb
  io.lineOut.bits.lastForInstruction := false.B
  io.lineOut.bits.cacheable := false.B
  io.lineOut.bits.token := 0.U
  val atomicReadResponse = state === waitResponse && held.atomic && !preflight && !atomicWrite
  io.lineComplete.ready := (state === waitResponse && !atomicReadResponse) || state === atomicDrain
  io.done.valid := state === finished
  io.done.bits.loadData := data
  io.done.bits.error := error
  io.storeCommit.valid := io.lineComplete.fire && io.lineComplete.bits.write && !io.lineComplete.bits.error
  io.storeCommit.bits.address := lineAddress
  io.storeCommit.bits.data := requestData
  io.storeCommit.bits.strb := requestStrb

  inputShadow := io.start.bits
  for (lane <- 0 until 32) {
    for (byte <- 0 until 4) {
      when (state === capture) {
        heldAddressBytes(lane)(byte) := capturedAddress(lane)(byte * 8 + 7, byte * 8)
      }
      when (io.start.fire) {
        heldStoreBytes(lane)(byte) := io.start.bits.storeData(lane)(byte * 8 + 7, byte * 8)
      }
      when (io.start.fire && io.start.bits.atomic && io.start.bits.atomicOp === AecAtomicOp.cas) {
        heldCompareBytes(lane)(byte) := io.start.bits.compareData(lane)(byte * 8 + 7, byte * 8)
      }
    }
  }

  when (io.start.fire) {
    state := capture
  }

  when (state === capture) {
    held.space := inputShadow.space
    held.ctaThreadBase := inputShadow.ctaThreadBase
    held.warp := inputShadow.warp
    held.mask := inputShadow.mask
    held.atomic := inputShadow.atomic
    held.atomicOp := inputShadow.atomicOp
    held.signed := inputShadow.signed
    pendingParts := capturedParts
    allParts := capturedParts
    currentGroup := 0.U
    preflight := true.B
    atomicWrite := false.B
    atomicPendingLanes := 0.U
    error := false.B
    val badAtomic = inputShadow.atomic && (inputShadow.space ||
      VecInit((0 until activeLanes).map(i =>
        inputShadow.mask(i) && inputShadow.address(i)(1, 0) =/= 0.U)).asUInt.orR)
    val badLmem = inputShadow.space && VecInit((0 until activeLanes).map(i => {
      val globalThread = inputShadow.ctaThreadBase +& Cat(inputShadow.warp, i.U(5.W))
      inputShadow.mask(i) && (globalThread >= (1 << 20).U ||
        inputShadow.address(i) +& 4.U > 4096.U)
    })).asUInt.orR
    error := badAtomic || badLmem
    state := Mux(!capturedParts.orR || badAtomic || badLmem, finished, chooseLine)
  }

  when (state === chooseLine) {
    lineAddress := firstPendingLine
    scanIndex := 0.U
    currentGroup := 0.U
    workValid := false.B
    for (word <- 0 until 32) { lineWordStores(word).io.clear := true.B }
    state := scanParts
  }

  when (state === scanParts) {
    workValid := true.B
    workMatch := scanMatch
    workIndex := scanIndex
    workWord := scanWord
    workLowData := scanShifted(31, 0) & scanLowDataMask
    workHighData := scanShifted(63, 32) & scanHighDataMask
    workLowByteMask := scanLowByteMask
    workHighByteMask := scanHighByteMask
    when (scanIndex === (activeLanes * 2 - 1).U) {
      state := drainPart
    }.otherwise {
      scanIndex := scanIndex + 1.U
    }
  }

  val applyPart = (state === scanParts || state === drainPart) && workValid && workMatch
  when (applyPart) {
    currentGroup := currentGroup | UIntToOH(workIndex, 64)
    when (!held.atomic) {
      for (word <- 0 until 32) {
        when (workWord === word.U) {
          lineWordStores(word).io.mergeLow := true.B
          lineWordStores(word).io.mergeLowData := workLowData
          lineWordStores(word).io.mergeLowStrb := workLowByteMask
        }
        when (workHighByteMask.orR && workWord =/= 31.U && workWord + 1.U === word.U) {
          lineWordStores(word).io.mergeHigh := true.B
          lineWordStores(word).io.mergeHighData := workHighData
          lineWordStores(word).io.mergeHighStrb := workHighByteMask
        }
      }
    }
  }

  when (state === drainPart) {
    workValid := false.B
    state := request
  }

  when (state === request && io.lineOut.fire) { state := waitResponse }

  // Keep the cache completion queued while atomic lanes are updated. The
  // Decoupled source holds rdata stable under backpressure, avoiding a
  // 1024-bit response register and the old 1088-fanout response-write enable.
  when (atomicReadResponse && io.lineComplete.valid) {
    when (io.lineComplete.bits.error) {
      error := true.B
      state := atomicDrain
    }.otherwise {
      atomicPendingLanes := VecInit((0 until 32).map(lane => currentGroup(lane * 2))).asUInt
      state := atomicUpdate
    }
  }

  when (io.lineComplete.fire) {
    when (state === atomicDrain) {
      when (error) {
        state := finished
      }.elsewhen (atomicWrite) {
        state := request
      }.otherwise {
        val remaining = pendingParts & ~currentGroup
        when (remaining.orR) {
          pendingParts := remaining
          state := chooseLine
        }.otherwise {
          state := finished
        }
      }
    }.elsewhen (io.lineComplete.bits.error) {
      error := true.B
      state := finished
    }.elsewhen (held.atomic && preflight) {
      val remaining = pendingParts & ~currentGroup
      when (remaining.orR) {
        pendingParts := remaining
        state := chooseLine
      }.otherwise {
        pendingParts := allParts
        preflight := false.B
        state := chooseLine
      }
    }.elsewhen (held.atomic) {
      val remaining = pendingParts & ~currentGroup
      atomicWrite := false.B
      when (remaining.orR) {
        pendingParts := remaining
        state := chooseLine
      }.otherwise {
        state := finished
      }
    }.otherwise {
      val remaining = pendingParts & ~currentGroup
      when (remaining.orR) {
        pendingParts := remaining
        state := chooseLine
      }.elsewhen (preflight) {
        pendingParts := allParts
        preflight := false.B
        state := chooseLine
      }.otherwise {
        state := finished
      }
    }
  }

  val atomicLane = PriorityEncoder(atomicPendingLanes)
  val atomicWord = heldAddress(atomicLane)(6, 2)
  val atomicResponseWords = VecInit((0 until 32).map(word =>
    io.lineComplete.bits.rdata(word * 32 + 31, word * 32)))
  val atomicOld = Mux(lineStrb(atomicWord).orR,
    lineWords(atomicWord), atomicResponseWords(atomicWord))
  val atomicUpdateValue = heldStoreData(atomicLane)
  val atomicOldS = atomicOld.asSInt
  val atomicUpdateS = atomicUpdateValue.asSInt
  val atomicNext = MuxLookup(held.atomicOp, atomicOld + atomicUpdateValue, Seq(
    AecAtomicOp.add -> (atomicOld + atomicUpdateValue),
    AecAtomicOp.max -> Mux(held.signed,
      Mux(atomicOldS > atomicUpdateS, atomicOld, atomicUpdateValue),
      Mux(atomicOld > atomicUpdateValue, atomicOld, atomicUpdateValue)),
    AecAtomicOp.min -> Mux(held.signed,
      Mux(atomicOldS < atomicUpdateS, atomicOld, atomicUpdateValue),
      Mux(atomicOld < atomicUpdateValue, atomicOld, atomicUpdateValue)),
    AecAtomicOp.xchg -> atomicUpdateValue,
    AecAtomicOp.andOp -> (atomicOld & atomicUpdateValue),
    AecAtomicOp.orOp -> (atomicOld | atomicUpdateValue),
    AecAtomicOp.xorOp -> (atomicOld ^ atomicUpdateValue),
    AecAtomicOp.cas -> Mux(atomicOld === heldCompareData(atomicLane), atomicUpdateValue, atomicOld)))
  val atomicWritesLane = held.atomicOp =/= AecAtomicOp.cas ||
    atomicOld === heldCompareData(atomicLane)
  val nextAtomicLanes = atomicPendingLanes & ~UIntToOH(atomicLane, 32)
  val atomicHasWrites = lineStrb.asUInt.orR || atomicWritesLane

  when (state === atomicUpdate) {
    data(atomicLane) := atomicOld
    when (atomicWritesLane) {
      for (word <- 0 until 32) {
        when (atomicWord === word.U) {
          lineWordStores(word).io.atomicWrite := true.B
          lineWordStores(word).io.atomicData := atomicNext
        }
      }
    }
    atomicPendingLanes := nextAtomicLanes
    when (!nextAtomicLanes.orR) {
      atomicWrite := atomicHasWrites
      state := atomicDrain
    }
  }

  when (io.done.fire) { state := idle }
}
