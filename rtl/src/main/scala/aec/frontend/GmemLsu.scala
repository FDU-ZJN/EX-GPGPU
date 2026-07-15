package aec

import chisel3._
import chisel3.util._

/**
  * Conservative warp memory unit for 32-bit GMEM accesses.
  *
  * It deliberately serializes participating lanes.  That is not a throughput
  * optimization, but it gives each warp precise program-order side effects and
  * handles an unaligned word as one or two protocol line operations.  The
  * external engine remains responsible for tags and the 16-request limit.
  */
class AecGmemLsu extends Module {
  val io = IO(new Bundle {
    val start = Flipped(Decoupled(new Bundle {
      val warp = UInt(3.W); val load = Bool(); val mask = UInt(32.W)
      val address = Vec(32, UInt(32.W)); val storeData = Vec(32, UInt(32.W))
      val atomic = Bool(); val atomicOp = UInt(3.W); val signed = Bool()
      val compareData = Vec(32, UInt(32.W))
    }))
    val lineOut = Decoupled(new AecLineRequest)
    val lineComplete = Flipped(Decoupled(new Bundle {
      val warp = UInt(3.W); val tag = UInt(4.W); val write = Bool()
      val lastForInstruction = Bool(); val rdata = UInt(1024.W); val error = Bool()
    }))
    val done = Decoupled(new Bundle { val loadData = Vec(32, UInt(32.W)); val error = Bool() })
    // Confirmed stores feed the small post-result readback shadow in EvalTop.
    val storeCommit = Valid(new Bundle { val address = UInt(32.W); val data = UInt(1024.W); val strb = UInt(128.W) })
  })

  val idle :: request :: waitResponse :: finished :: Nil = Enum(4)
  val state = RegInit(idle)
  val held = Reg(io.start.bits.cloneType)
  val lane = RegInit(0.U(5.W))
  val secondPart = RegInit(false.B)
  // A store first issues read-only transactions for every touched line part.
  // Under the deterministic service contract, successful preflight makes the
  // following identical writes address-error-free and prevents partial store.
  val preflight = RegInit(false.B)
  val atomicWrite = RegInit(false.B)
  val atomicValue = RegInit(0.U(32.W))
  val data = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  val error = RegInit(false.B)

  val currentAddress = held.address(lane)
  val byteOffset = currentAddress(6, 0)
  val firstBytes = Mux(byteOffset <= 124.U, 4.U(3.W), (128.U - byteOffset)(2, 0))
  val partBytes = Mux(secondPart, 4.U(3.W) - firstBytes, firstBytes)
  val partOffset = Mux(secondPart, 0.U(7.W), byteOffset)
  val partShift = partOffset << 3
  val destinationShift = Mux(secondPart, firstBytes << 3, 0.U(5.W))
  val byteMask = ((1.U(129.W) << partBytes) - 1.U)(127, 0)
  val wordMask = ((1.U(33.W) << (partBytes << 3)) - 1.U)(31, 0)
  val partValue = Mux(held.atomic, atomicValue,
    Mux(secondPart, held.storeData(lane) >> (firstBytes << 3), held.storeData(lane)))

  io.start.ready := state === idle
  io.lineOut.valid := state === request
  io.lineOut.bits.warp := held.warp
  io.lineOut.bits.write := Mux(held.atomic, atomicWrite, !held.load && !preflight)
  io.lineOut.bits.address := Mux(secondPart, (currentAddress & "hffffff80".U) + 128.U, currentAddress & "hffffff80".U)
  io.lineOut.bits.wdata := partValue << partShift
  io.lineOut.bits.wstrb := Mux(held.atomic, "hf".U(128.W) << partOffset, byteMask << partOffset)
  io.lineOut.bits.lastForInstruction := false.B
  io.lineComplete.ready := state === waitResponse
  io.done.valid := state === finished
  io.done.bits.loadData := data
  io.done.bits.error := error
  io.storeCommit.valid := io.lineComplete.fire && !held.load && !preflight && (!held.atomic || atomicWrite) && !io.lineComplete.bits.error
  io.storeCommit.bits.address := io.lineOut.bits.address // replaced below by held request address
  io.storeCommit.bits.data := partValue << partShift
  io.storeCommit.bits.strb := byteMask << partOffset

  // The request payload must survive until its completion; derive the line
  // address from the held lane/part instead of relying on a combinational port.
  io.storeCommit.bits.address := Mux(secondPart, (currentAddress & "hffffff80".U) + 128.U, currentAddress & "hffffff80".U)

  when (io.start.fire) {
    held := io.start.bits
    lane := 0.U
    secondPart := false.B
    preflight := !io.start.bits.load
    atomicWrite := false.B
    data := VecInit(Seq.fill(32)(0.U(32.W)))
    error := false.B
    val badAtomic = io.start.bits.atomic && VecInit((0 until 32).map(i => io.start.bits.mask(i) && io.start.bits.address(i)(1, 0) =/= 0.U)).asUInt.orR
    error := badAtomic
    state := Mux(!io.start.bits.mask.orR || badAtomic, finished, request)
  }
  when (state === request && io.lineOut.fire) { state := waitResponse }
  when (io.lineComplete.fire) {
    when (io.lineComplete.bits.error) {
      error := true.B
      state := finished
    }.otherwise {
    when (held.atomic && !preflight && !atomicWrite) {
      val old = (io.lineComplete.bits.rdata >> partShift)(31, 0)
      val update = held.storeData(lane)
      val oldS = old.asSInt; val updateS = update.asSInt
      atomicValue := MuxLookup(held.atomicOp, old + update, Seq(
        0.U -> (old + update),
        1.U -> Mux(held.signed, Mux(oldS < updateS, old, update), Mux(old < update, old, update)),
        2.U -> Mux(held.signed, Mux(oldS > updateS, old, update), Mux(old > update, old, update)),
        3.U -> update, 4.U -> (old & update), 5.U -> (old | update), 6.U -> (old ^ update),
        7.U -> Mux(old === held.compareData(lane), update, old)))
      data(lane) := old
      atomicWrite := true.B
      state := request
    }.otherwise {
    when (held.load) {
      val incoming = ((io.lineComplete.bits.rdata >> partShift)(31, 0) & wordMask) << destinationShift
      val placedMask = wordMask << destinationShift
      data(lane) := (data(lane) & ~placedMask) | incoming
    }
    val needsSecond = !held.atomic && !secondPart && firstBytes =/= 4.U
    when (needsSecond) {
      secondPart := true.B
      state := request
    }.otherwise {
      secondPart := false.B
      atomicWrite := false.B
      // Keep the high carry bit while forming the consumed-lane mask.  With a
      // 32-bit literal, shifting lane 31 by one truncates to zero and turns
      // the subtraction into all ones, causing the LSU to wrap to lane 0.
      val consumed = (1.U(33.W) << (lane +& 1.U)) - 1.U
      val remainingMask = (Cat(0.U(1.W), held.mask) & ~consumed)(31, 0)
      when (remainingMask.orR) {
        lane := PriorityEncoder(remainingMask)
        state := request
      }.elsewhen (preflight) {
        // All store addresses are valid.  Replay in ascending lane order with
        // side effects enabled.
        lane := PriorityEncoder(held.mask)
        secondPart := false.B
        preflight := false.B
        state := request
      }.otherwise {
        state := finished
      }
    }
    }
    }
  }
  when (io.done.fire) { state := idle }
}
