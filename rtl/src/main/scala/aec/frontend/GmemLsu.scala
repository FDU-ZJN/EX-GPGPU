package aec

import chisel3._
import chisel3.util._

/** Warp GMEM LSU with 128-byte line coalescing and precise store preflight. */
class AecGmemLsu(activeLanes: Int = 32) extends Module {
  require(activeLanes >= 1 && activeLanes <= 32)
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new Bundle {
      val space = Bool(); val ctaThreadBase = UInt(20.W)
      val warp = UInt(3.W); val load = Bool(); val width64 = Bool(); val mask = UInt(32.W)
      val address = Vec(32, UInt(32.W)); val storeData = Vec(32, UInt(32.W))
      val atomic = Bool(); val atomicOp = UInt(3.W); val signed = Bool()
      val compareData = Vec(32, UInt(32.W))
    }))
    val lineOut = Decoupled(new AecLineRequest)
    val lineComplete = Flipped(Decoupled(new Bundle {
      val space = Bool(); val warp = UInt(3.W); val tag = UInt(4.W); val write = Bool()
      val lastForInstruction = Bool(); val rdata = UInt(1024.W); val error = Bool()
    }))
    val done = Decoupled(new Bundle { val loadData = Vec(32, UInt(64.W)); val error = Bool() })
    val storeCommit = Valid(new Bundle { val address = UInt(32.W); val data = UInt(1024.W); val strb = UInt(128.W) })
  })

  val idle :: request :: waitResponse :: finished :: Nil = Enum(4)
  val state = RegInit(idle)
  val held = Reg(io.start.bits.cloneType)
  val pendingParts = RegInit(0.U(64.W))
  val preflight = RegInit(false.B)
  val atomicWrite = RegInit(false.B)
  val atomicLineData = Reg(UInt(1024.W))
  val atomicLineStrb = Reg(UInt(128.W))
  val data = RegInit(VecInit(Seq.fill(32)(0.U(64.W))))
  val error = RegInit(false.B)

  def accessBytes(width64: Bool, load: Bool, atomic: Bool): UInt = Mux(width64 && load && !atomic, 8.U(4.W), 4.U(4.W))
  def firstByteCount(address: UInt, bytes: UInt): UInt = {
    val room = 128.U(8.W) - address(6, 0)
    Mux(room >= bytes, bytes, room(3, 0))
  }
  val heldBytes = accessBytes(held.width64, held.load, held.atomic)
  val startBytes = accessBytes(io.start.bits.width64, io.start.bits.load, io.start.bits.atomic)
  def translatedAddress(space: Bool, ctaThreadBase: UInt, warp: UInt, lane: Int, offset: UInt): UInt = {
    val globalThread = ctaThreadBase +& Cat(warp, lane.U(5.W))
    Mux(space, ((globalThread << 12) +& offset)(31, 0), offset)
  }
  val heldAddress = VecInit((0 until 32).map(lane =>
    translatedAddress(held.space, held.ctaThreadBase, held.warp, lane, held.address(lane))))
  val startAddress = VecInit((0 until 32).map(lane =>
    translatedAddress(io.start.bits.space, io.start.bits.ctaThreadBase, io.start.bits.warp, lane, io.start.bits.address(lane))))
  val initialParts = VecInit((0 until 32).flatMap { lane =>
    val first = firstByteCount(heldAddress(lane), heldBytes)
    val active = if (lane < activeLanes) held.mask(lane) else false.B
    Seq(active, active && first =/= heldBytes)
  }).asUInt
  val startParts = VecInit((0 until 32).flatMap { lane =>
    val first = firstByteCount(startAddress(lane), startBytes)
    val active = if (lane < activeLanes) io.start.bits.mask(lane) else false.B
    Seq(active, active && first =/= startBytes)
  }).asUInt

  val selectedPart = PriorityEncoder(pendingParts)
  val selectedLane = selectedPart(5, 1)
  val selectedSecond = selectedPart(0)
  val selectedBase = heldAddress(selectedLane) & "hffffff80".U
  val selectedLine = Mux(selectedSecond, selectedBase + 128.U, selectedBase)

  val group = Wire(Vec(64, Bool()))
  for (lane <- 0 until 32) {
    val base = heldAddress(lane) & "hffffff80".U
    group(lane * 2) := (if (lane < activeLanes) pendingParts(lane * 2) && base === selectedLine else false.B)
    group(lane * 2 + 1) := (if (lane < activeLanes) pendingParts(lane * 2 + 1) && base + 128.U === selectedLine else false.B)
  }
  val groupMask = group.asUInt
  val consumedMask = groupMask

  val partData = for (lane <- 0 until activeLanes; part <- 0 until 2) yield {
    val idx = lane * 2 + part
    val first = firstByteCount(heldAddress(lane), heldBytes)
    val bytes = if (part == 0) first else heldBytes - first
    val offset = if (part == 0) heldAddress(lane)(6, 0) else 0.U(7.W)
    val strb = (((1.U(129.W) << bytes) - 1.U)(127, 0) << offset) & Fill(128, group(idx))
    val shiftedValue = if (part == 0) held.storeData(lane) else held.storeData(lane) >> (first << 3)
    val bitMask = FillInterleaved(8, strb)
    (shiftedValue << (offset << 3)) & bitMask
  }
  val partStrb = for (lane <- 0 until activeLanes; part <- 0 until 2) yield {
    val idx = lane * 2 + part
    val first = firstByteCount(heldAddress(lane), heldBytes)
    val bytes = if (part == 0) first else heldBytes - first
    val offset = if (part == 0) heldAddress(lane)(6, 0) else 0.U(7.W)
    (((1.U(129.W) << bytes) - 1.U)(127, 0) << offset) & Fill(128, group(idx))
  }
  def treeOr(values: Seq[UInt]): UInt = if (values.size == 1) values.head else {
    val (left, right) = values.splitAt(values.size / 2); treeOr(left) | treeOr(right)
  }
  val aggregateData = treeOr(partData)
  val aggregateStrb = treeOr(partStrb)

  val requestData = Mux(held.atomic && atomicWrite, atomicLineData, aggregateData)
  val requestStrb = Mux(held.atomic && atomicWrite, atomicLineStrb, aggregateStrb)

  io.start.ready := state === idle
  io.lineOut.valid := state === request
  io.lineOut.bits.space := held.space
  io.lineOut.bits.warp := held.warp
  io.lineOut.bits.write := Mux(held.atomic, atomicWrite, !held.load && !preflight)
  io.lineOut.bits.address := selectedLine
  io.lineOut.bits.wdata := requestData
  io.lineOut.bits.wstrb := requestStrb
  io.lineOut.bits.lastForInstruction := false.B
  io.lineComplete.ready := state === waitResponse
  io.done.valid := state === finished
  io.done.bits.loadData := data
  io.done.bits.error := error
  io.storeCommit.valid := io.lineComplete.fire && io.lineComplete.bits.write && !io.lineComplete.bits.error
  io.storeCommit.bits.address := selectedLine
  io.storeCommit.bits.data := requestData
  io.storeCommit.bits.strb := requestStrb

  when (io.start.fire) {
    held := io.start.bits
    pendingParts := startParts
    preflight := !io.start.bits.load
    atomicWrite := false.B; atomicLineData := 0.U; atomicLineStrb := 0.U
    data := VecInit(Seq.fill(32)(0.U(64.W)))
    error := false.B
    val badAtomic = io.start.bits.atomic && (io.start.bits.space || VecInit((0 until activeLanes).map(i =>
      io.start.bits.mask(i) && io.start.bits.address(i)(1, 0) =/= 0.U)).asUInt.orR
    )
    val badLmem = io.start.bits.space && VecInit((0 until activeLanes).map(i => {
      val globalThread = io.start.bits.ctaThreadBase +& Cat(io.start.bits.warp, i.U(5.W))
      io.start.bits.mask(i) && (globalThread >= (1 << 20).U ||
        io.start.bits.address(i) +& startBytes > 4096.U)
    })).asUInt.orR
    error := badAtomic || badLmem
    state := Mux(!io.start.bits.mask.orR || badAtomic || badLmem, finished, request)
  }
  when (state === request && io.lineOut.fire) { state := waitResponse }
  when (io.lineComplete.fire) {
    when (io.lineComplete.bits.error) {
      error := true.B; state := finished
    }.elsewhen (held.atomic && preflight) {
      val remaining = pendingParts & ~groupMask
      when (remaining.orR) { pendingParts := remaining; state := request }
        .otherwise { pendingParts := initialParts; preflight := false.B; state := request }
    }.elsewhen (held.atomic && !atomicWrite) {
      var updatedLine = io.lineComplete.bits.rdata
      var successfulStrb = 0.U(128.W)
      for (lane <- 0 until activeLanes) {
        val offset = heldAddress(lane)(6, 0)
        val shift = offset << 3
        val old = (updatedLine >> shift)(31, 0)
        val update = held.storeData(lane)
        val oldS = old.asSInt; val updateS = update.asSInt
        val next = MuxLookup(held.atomicOp, old + update, Seq(
          AecAtomicOp.add -> (old + update),
          AecAtomicOp.max -> Mux(held.signed, Mux(oldS > updateS, old, update), Mux(old > update, old, update)),
          AecAtomicOp.min -> Mux(held.signed, Mux(oldS < updateS, old, update), Mux(old < update, old, update)),
          AecAtomicOp.xchg -> update, AecAtomicOp.andOp -> (old & update),
          AecAtomicOp.orOp -> (old | update), AecAtomicOp.xorOp -> (old ^ update),
          AecAtomicOp.cas -> Mux(old === held.compareData(lane), update, old)))
        val wordMask = "hffffffff".U(1024.W) << shift
        val casSuccess = old === held.compareData(lane)
        val writesLane = group(lane * 2) && (held.atomicOp =/= AecAtomicOp.cas || casSuccess)
        val laneStrb = "hf".U(128.W) << offset
        when (group(lane * 2)) { data(lane) := old }
        updatedLine = Mux(writesLane, (updatedLine & ~wordMask) | (next << shift), updatedLine)
        successfulStrb = successfulStrb | Mux(writesLane, laneStrb, 0.U)
      }
      atomicLineData := updatedLine
      atomicLineStrb := successfulStrb
      when (successfulStrb.orR) {
        atomicWrite := true.B; state := request
      }.otherwise {
        val remaining = pendingParts & ~groupMask
        when (remaining.orR) { pendingParts := remaining; state := request }
          .otherwise { state := finished }
      }
    }.otherwise {
      when (held.load) {
        for (lane <- 0 until activeLanes; part <- 0 until 2) {
          val idx = lane * 2 + part
          val first = firstByteCount(heldAddress(lane), heldBytes)
          val bytes = if (part == 0) first else heldBytes - first
          val sourceOffset = if (part == 0) heldAddress(lane)(6, 0) else 0.U(7.W)
          val destShift = if (part == 0) 0.U(7.W) else first << 3
          val valueMask = ((1.U(65.W) << (bytes << 3)) - 1.U)(63, 0)
          val incoming = ((io.lineComplete.bits.rdata >> (sourceOffset << 3))(63, 0) & valueMask) << destShift
          val placedMask = valueMask << destShift
          when (group(idx)) { data(lane) := (data(lane) & ~placedMask) | incoming }
        }
      }
      val remaining = pendingParts & ~consumedMask
      when (remaining.orR) {
        pendingParts := remaining; atomicWrite := false.B; state := request
      }.elsewhen (preflight) {
        pendingParts := initialParts; preflight := false.B; atomicWrite := false.B; state := request
      }.otherwise { state := finished }
    }
  }
  when (io.done.fire) { state := idle }
}
