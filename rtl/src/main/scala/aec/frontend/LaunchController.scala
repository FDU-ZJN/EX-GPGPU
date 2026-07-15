package aec

import chisel3._
import chisel3.util._

/** Multi-cycle launch geometry validation. Wide products are isolated from
  * the runtime warp and backend control paths. */
class AecLaunchValidator extends Module {
  val io = IO(new Bundle {
    val request = Flipped(Decoupled(new AecLaunchRequest))
    val result = Decoupled(new AecLaunchResult)
    val idle = Output(Bool())
  })

  val idle :: blockXY :: blockXYZ :: gridXY :: gridXYZ :: gridThreads :: finished :: Nil = Enum(7)
  val state = RegInit(idle)
  val held = Reg(new AecLaunchRequest)
  val bad = RegInit(false.B)
  val threads = Reg(UInt(32.W))
  val product = Reg(UInt(42.W))

  io.idle := state === idle
  io.request.ready := state === idle
  io.result.valid := state === finished
  io.result.bits.accepted := !bad
  io.result.bits.threads := threads
  io.result.bits.gridX := held.gridX; io.result.bits.gridY := held.gridY; io.result.bits.gridZ := held.gridZ
  io.result.bits.blockX := held.blockX; io.result.bits.blockY := held.blockY; io.result.bits.blockZ := held.blockZ

  when (io.request.fire) {
    held := io.request.bits
    bad := io.request.bits.loadError || io.request.bits.programInstructions === 0.U ||
      io.request.bits.programInstructions > AecFrontendConfig.ImemWords.U ||
      io.request.bits.blockX === 0.U || io.request.bits.blockY === 0.U || io.request.bits.blockZ === 0.U ||
      io.request.bits.blockX > 256.U || io.request.bits.blockY > 256.U || io.request.bits.blockZ > 256.U ||
      io.request.bits.gridX === 0.U || io.request.bits.gridY === 0.U || io.request.bits.gridZ === 0.U ||
      io.request.bits.gridX > (1 << 20).U || io.request.bits.gridY > (1 << 20).U ||
      io.request.bits.gridZ > (1 << 20).U
    state := blockXY
  }
  when (state === blockXY) {
    product := held.blockX(8, 0) * held.blockY(8, 0)
    state := blockXYZ
  }
  when (state === blockXYZ) {
    val checked = product(17, 0) * held.blockZ(8, 0)
    threads := checked
    when (checked === 0.U || checked > 256.U) { bad := true.B }
    state := gridXY
  }
  when (state === gridXY) {
    val checked = held.gridX(20, 0) * held.gridY(20, 0)
    product := checked
    when (checked > (1 << 20).U) { bad := true.B }
    state := gridXYZ
  }
  when (state === gridXYZ) {
    val checked = product(20, 0) * held.gridZ(20, 0)
    product := checked
    when (checked > (1 << 20).U) { bad := true.B }
    state := gridThreads
  }
  when (state === gridThreads) {
    val checked = product(20, 0) * threads(8, 0)
    when (checked > (1 << 20).U) { bad := true.B }
    state := finished
  }
  when (io.result.fire) { state := idle }
}
