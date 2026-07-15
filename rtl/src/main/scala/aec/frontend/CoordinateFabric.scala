package aec

import chisel3._
import chisel3.util._

/** Shared special-register coordinate generator. Requests are instruction
  * descriptors; responses stream one lane per cycle back to the owner. */
class AecCoordinateFabric(val ports: Int = 4) extends Module {
  require(ports >= 1)
  private val ownerWidth = log2Ceil(ports) max 1
  val io = IO(new Bundle {
    val requests = Flipped(Vec(ports, Decoupled(new AecCoordinateRequest)))
    val responses = Vec(ports, Decoupled(new AecCoordinateResponse))
    val blockX = Input(UInt(32.W)); val blockY = Input(UInt(32.W)); val blockZ = Input(UInt(32.W))
    val gridX = Input(UInt(32.W)); val gridY = Input(UInt(32.W)); val gridZ = Input(UInt(32.W))
    val ctaX = Input(UInt(32.W)); val ctaY = Input(UInt(32.W)); val ctaZ = Input(UInt(32.W))
  })

  val idle :: divideX :: startY :: divideY :: emit :: Nil = Enum(5)
  val state = RegInit(idle)
  val owner = Reg(UInt(ownerWidth.W))
  val special = Reg(UInt(16.W))
  val lane = Reg(UInt(5.W))
  val x = Reg(UInt(8.W)); val y = Reg(UInt(8.W)); val z = Reg(UInt(8.W))
  val quotientX = Reg(UInt(8.W))
  val needsDivide = Reg(Bool())
  val divider = Module(new AecUnsignedDivider8)
  divider.io.start := false.B
  divider.io.numerator := 0.U
  divider.io.divisor := 1.U

  val requestMask = VecInit(io.requests.map(_.valid)).asUInt
  val selected = PriorityEncoder(requestMask)
  for (i <- 0 until ports) {
    io.requests(i).ready := state === idle && requestMask.orR && selected === i.U
    io.responses(i).valid := state === emit && owner === i.U
    io.responses(i).bits.lane := lane
    io.responses(i).bits.data := MuxLookup(special, 0.U, Seq(
      "h0100".U -> x, "h0101".U -> io.blockX, "h0102".U -> io.ctaX, "h0103".U -> io.gridX,
      "h0104".U -> lane,
      "h0110".U -> y, "h0111".U -> io.blockY, "h0112".U -> io.ctaY, "h0113".U -> io.gridY,
      "h0120".U -> z, "h0121".U -> io.blockZ, "h0122".U -> io.ctaZ, "h0123".U -> io.gridZ))
    io.responses(i).bits.last := lane === 31.U
  }

  when (state === idle && requestMask.orR) {
    val request = Mux1H((0 until ports).map(i => (selected === i.U) -> io.requests(i).bits))
    val divide = request.special === "h0100".U || request.special === "h0110".U ||
      request.special === "h0120".U
    owner := selected
    special := request.special
    lane := request.startLane
    needsDivide := divide
    when (divide) {
      divider.io.start := true.B
      divider.io.numerator := request.linearLane
      divider.io.divisor := io.blockX(8, 0)
      state := divideX
    }.otherwise {
      x := 0.U; y := 0.U; z := 0.U
      state := emit
    }
  }
  when (state === divideX && divider.io.done) {
    x := divider.io.remainder
    quotientX := divider.io.quotient
    state := startY
  }
  when (state === startY) {
    divider.io.start := true.B
    divider.io.numerator := quotientX
    divider.io.divisor := io.blockY(8, 0)
    state := divideY
  }
  when (state === divideY && divider.io.done) {
    y := divider.io.remainder
    z := divider.io.quotient
    state := emit
  }
  val responseReady = MuxLookup(owner, false.B,
    (0 until ports).map(i => i.U -> io.responses(i).ready))
  when (state === emit && responseReady) {
    when (lane === 31.U) {
      state := idle
    }.otherwise {
      val wrapX = x + 1.U === io.blockX
      val wrapY = y + 1.U === io.blockY
      lane := lane + 1.U
      when (needsDivide) {
        x := Mux(wrapX, 0.U, x + 1.U)
        when (wrapX) {
          y := Mux(wrapY, 0.U, y + 1.U)
          when (wrapY) { z := z + 1.U }
        }
      }
    }
  }
}
