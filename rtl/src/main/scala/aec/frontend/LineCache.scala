package aec

import chisel3._
import chisel3.util._

class AecLoadLineDescriptor extends Bundle {
  val space = Bool()
  val warp = UInt(3.W)
  val address = UInt(32.W)
  val lastForInstruction = Bool()
  val cacheable = Bool()
  val token = UInt(4.W)
}

/** 64 KiB direct-mapped load cache with an explicit SRAM-result stage.
  *
  * Load misses queue only narrow descriptors. Store/atomic bypass traffic has
  * one dedicated wide holding register, and all completions cross a registered
  * queue before reaching the LSU.
  */
class AecLineCache(val useSramData: Boolean = true) extends Module {
  private val lines = 512
  private val indexBits = log2Ceil(lines)
  private val tagWidth = 1 + 32 - 7 - indexBits

  val io = IO(new Bundle {
    val cpuRequest = Flipped(Decoupled(new AecLineRequest))
    val cpuCompletion = Decoupled(new AecLineCompletion)
    val memoryRequest = Decoupled(new AecLineRequest)
    val memoryCompletion = Flipped(Decoupled(new AecLineCompletion))
  })

  def index(address: UInt): UInt = address(7 + indexBits - 1, 7)
  def tag(space: Bool, address: UInt): UInt = Cat(space, address(31, 7 + indexBits))

  val initializedLines = Reg(Vec(16, UInt(32.W)))
  val initializedGroups = RegInit(0.U(16.W))

  // L1 tracks the request whose synchronous SRAM outputs are currently
  // available. L2 captures both metadata and line data before hit/miss logic.
  val lookupPending = RegInit(false.B)
  val lookupReq = Reg(new AecLineRequest)
  val lookupInitialized = Reg(Bool())
  val resultValid = RegInit(false.B)
  val resultReq = Reg(new AecLineRequest)
  val resultInitialized = Reg(Bool())
  val resultMetadata = Reg(UInt(32.W))
  val resultLine = Reg(UInt(1024.W))

  val loadMissQ = Module(new Queue(new AecLoadLineDescriptor, 4,
    pipe = false, flow = false))
  val bypassValid = RegInit(false.B)
  val bypassReq = Reg(new AecLineRequest)

  // A load descriptor reconstructs constant-zero write payload only at the
  // final registered memory boundary. The four-entry queue is no longer wide.
  io.memoryRequest.valid := bypassValid || loadMissQ.io.deq.valid
  io.memoryRequest.bits := bypassReq
  when (!bypassValid) {
    io.memoryRequest.bits.space := loadMissQ.io.deq.bits.space
    io.memoryRequest.bits.warp := loadMissQ.io.deq.bits.warp
    io.memoryRequest.bits.write := false.B
    io.memoryRequest.bits.address := loadMissQ.io.deq.bits.address
    io.memoryRequest.bits.wdata := 0.U
    io.memoryRequest.bits.wstrb := 0.U
    io.memoryRequest.bits.lastForInstruction := loadMissQ.io.deq.bits.lastForInstruction
    io.memoryRequest.bits.cacheable := loadMissQ.io.deq.bits.cacheable
    io.memoryRequest.bits.token := loadMissQ.io.deq.bits.token
  }
  loadMissQ.io.deq.ready := io.memoryRequest.ready && !bypassValid
  when (bypassValid && io.memoryRequest.ready) { bypassValid := false.B }

  val completionQ = Module(new Queue(new AecLineCompletion, 2,
    pipe = false, flow = false))
  io.cpuCompletion <> completionQ.io.deq

  val resultIndex = index(resultReq.address)
  val resultTag = tag(resultReq.space, resultReq.address)
  val resultHit = resultValid && resultInitialized && resultMetadata(tagWidth) &&
    resultMetadata(tagWidth - 1, 0) === resultTag
  val resultMiss = resultValid && !resultHit

  // valid expresses source availability only. Neither enqueue valid depends
  // on its corresponding ready signal.
  loadMissQ.io.enq.valid := resultMiss
  loadMissQ.io.enq.bits.space := resultReq.space
  loadMissQ.io.enq.bits.warp := resultReq.warp
  loadMissQ.io.enq.bits.address := resultReq.address
  loadMissQ.io.enq.bits.lastForInstruction := resultReq.lastForInstruction
  loadMissQ.io.enq.bits.cacheable := resultReq.cacheable
  loadMissQ.io.enq.bits.token := resultReq.token

  val resultConsumed = (resultHit && completionQ.io.enq.ready) ||
    (resultMiss && loadMissQ.io.enq.ready)
  val resultReady = !resultValid || resultConsumed
  val lookupCanShift = !lookupPending || resultReady

  // Cache hits take priority for one cycle. External responses remain held by
  // Decoupled until the completion queue can accept them.
  val externalCanAdvance = !resultHit && (!lookupPending || resultReady)
  completionQ.io.enq.valid := resultHit ||
    (io.memoryCompletion.valid && externalCanAdvance)
  completionQ.io.enq.bits := io.memoryCompletion.bits
  when (resultHit) {
    completionQ.io.enq.bits.space := resultReq.space
    completionQ.io.enq.bits.warp := resultReq.warp
    completionQ.io.enq.bits.tag := 0.U
    completionQ.io.enq.bits.write := false.B
    completionQ.io.enq.bits.lastForInstruction := resultReq.lastForInstruction
    completionQ.io.enq.bits.rdata := resultLine
    completionQ.io.enq.bits.error := false.B
    completionQ.io.enq.bits.address := resultReq.address
    completionQ.io.enq.bits.cacheable := resultReq.cacheable
    completionQ.io.enq.bits.token := resultReq.token
  }

  // If an SRAM result is waiting, a fill is accepted only when L2 can capture
  // that result on this edge. This preserves the single-port macro output.
  io.memoryCompletion.ready := externalCanAdvance && completionQ.io.enq.ready
  val externalFire = io.memoryCompletion.fire
  val fill = externalFire && !io.memoryCompletion.bits.error &&
    io.memoryCompletion.bits.cacheable && !io.memoryCompletion.bits.write
  val invalidate = externalFire && !io.memoryCompletion.bits.error &&
    io.memoryCompletion.bits.write
  val fillIndex = index(io.memoryCompletion.bits.address)
  val fillTag = tag(io.memoryCompletion.bits.space, io.memoryCompletion.bits.address)
  val fillGroup = fillIndex(8, 5)
  val fillInitialized = initializedGroups(fillGroup) &&
    initializedLines(fillGroup)(fillIndex(4, 0))

  val requestIndex = index(io.cpuRequest.bits.address)
  val requestGroup = requestIndex(8, 5)
  val requestInitialized = initializedGroups(requestGroup) &&
    initializedLines(requestGroup)(requestIndex(4, 0))
  val cacheableLoad = io.cpuRequest.bits.cacheable && !io.cpuRequest.bits.write
  // A presented external response owns the single SRAM port. Using valid
  // rather than tagHit keeps macro output data out of this admission control.
  val lookupAcceptReady = lookupCanShift && !io.memoryCompletion.valid
  val bypassAcceptReady = !bypassValid
  io.cpuRequest.ready := Mux(cacheableLoad, lookupAcceptReady, bypassAcceptReady)
  val lookupAccept = io.cpuRequest.valid && cacheableLoad && lookupAcceptReady
  val bypassAccept = io.cpuRequest.valid && !cacheableLoad && bypassAcceptReady

  when (bypassAccept) {
    bypassValid := true.B
    bypassReq := io.cpuRequest.bits
  }

  val metadataRead = Wire(UInt(32.W))
  val cachedLine = Wire(UInt(1024.W))
  if (useSramData) {
    val metadata = Module(new AecSram512x32)
    metadata.io.clk := clock
    metadata.io.en := lookupAccept || fill || invalidate
    metadata.io.read_en := lookupAccept
    metadata.io.write_en := fill || invalidate
    metadata.io.addr := Mux(fill || invalidate, fillIndex, requestIndex)
    metadata.io.write_data := Mux(fill, Cat(1.U(1.W), fillTag), 0.U)
    metadataRead := metadata.io.read_data

    val dataBanks = Seq.fill(32)(Module(new AecSram512x32))
    for ((bank, word) <- dataBanks.zipWithIndex) {
      bank.io.clk := clock
      bank.io.en := lookupAccept || fill
      bank.io.read_en := lookupAccept
      bank.io.write_en := fill
      bank.io.addr := Mux(fill, fillIndex, requestIndex)
      bank.io.write_data := io.memoryCompletion.bits.rdata(word * 32 + 31, word * 32)
    }
    cachedLine := Cat(dataBanks.reverse.map(_.io.read_data))
  } else {
    val metadata = Reg(Vec(lines, UInt((tagWidth + 1).W)))
    val metadataValid = RegInit(0.U(lines.W))
    val readIndex = RegEnable(requestIndex, lookupAccept)
    when (fill) {
      metadata(fillIndex) := Cat(1.U(1.W), fillTag)
      metadataValid := metadataValid | UIntToOH(fillIndex, lines)
    }
    when (invalidate) {
      metadata(fillIndex) := 0.U
      metadataValid := metadataValid & ~UIntToOH(fillIndex, lines)
    }
    metadataRead := Mux(metadataValid(readIndex), metadata(readIndex), 0.U)

    val data = Reg(Vec(lines, UInt(1024.W)))
    val readData = RegEnable(data(requestIndex), lookupAccept)
    when (fill) { data(fillIndex) := io.memoryCompletion.bits.rdata }
    cachedLine := readData
  }

  // Capture the prior SRAM output before issuing a replacement lookup. No
  // metadataRead/cachedLine bit participates in lookup admission or SRAM en.
  when (resultReady) {
    resultValid := lookupPending
    when (lookupPending) {
      resultReq := lookupReq
      resultInitialized := lookupInitialized
      resultMetadata := metadataRead
      resultLine := cachedLine
    }
  }
  when (lookupCanShift) {
    lookupPending := lookupAccept
    when (lookupAccept) {
      lookupReq := io.cpuRequest.bits
      lookupInitialized := requestInitialized
    }
  }

  when (fill) {
    val prior = Mux(initializedGroups(fillGroup), initializedLines(fillGroup), 0.U)
    initializedLines(fillGroup) := prior | UIntToOH(fillIndex(4, 0), 32)
    initializedGroups := initializedGroups | UIntToOH(fillGroup, 16)
  }
  when (invalidate && fillInitialized) {
    initializedLines(fillGroup) := initializedLines(fillGroup) &
      ~UIntToOH(fillIndex(4, 0), 32)
  }
}
