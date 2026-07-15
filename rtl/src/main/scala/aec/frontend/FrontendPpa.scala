package aec

import chisel3._
import chisel3.util._

/** Representative frontend timing partition with real storage and dependency
  * logic. Execution backends are replaced by the request/completion IO boundary.
  */
class AecFrontendPartitionPpaTop extends Module {
  val io = IO(new Bundle {
    val instruction = Input(UInt(128.W))
    val issueValid = Input(Bool())
    val issueWarp = Input(UInt(3.W))
    val issueEpoch = Input(UInt(8.W))
    val issuePc = Input(UInt(32.W))
    val activeMask = Input(UInt(32.W))

    val completion = Input(Valid(new AecBackendCompletion))
    val commitWarpLocal = Input(UInt(1.W))
    val commitPop = Input(Bool())
    val flush = Input(Bool())

    val regResponseReady = Input(Bool())
    val issueReady = Output(Bool())
    val backendRequestValid = Output(Bool())
    val backendOpcode = Output(UInt(16.W))
    val backendDtype = Output(UInt(4.W))
    val backendExecuteMask = Output(UInt(32.W))
    val backendOperands = Output(Vec(32, UInt(32.W)))
    val commitValid = Output(Bool())
    val commitData = Output(Vec(32, UInt(64.W)))

    val runnable = Input(UInt(8.W))
    val schedulerAccept = Input(UInt(4.W))
    val schedulerValid = Output(UInt(4.W))
    val schedulerWarp = Output(Vec(4, UInt(3.W)))
    val barrierActive = Input(UInt(8.W))
    val barrierCompleted = Input(UInt(8.W))
    val barrierArrive = Input(Vec(4, Valid(UInt(3.W))))
    val barrierRelease = Output(UInt(8.W))
    val barrierDuplicate = Output(Bool())
  })

  val decoded = AecDecode(io.instruction)
  val bank = Module(new AecRegBank)
  val scoreboard = Module(new AecScoreboard)
  val robs = Seq.fill(2)(Module(new AecWarpRob))
  val resultStore = Module(new AecPartitionResultStore)
  val schedulers = Module(new AecWarpSchedulers)
  val barrier = Module(new AecCtaBarrier)

  val decodedPair = decoded.dtype === 1.U || decoded.dtype === 9.U
  val writesPredicate = decoded.opcode === AecOpcode.cmpp ||
    (decoded.opcode === AecOpcode.vote && decoded.ext === 1.U)
  val writesGpr = !writesPredicate && decoded.opcode =/= AecOpcode.st
  val selectedRob = Mux(io.issueWarp(0), robs(1).io.allocate.ready, robs(0).io.allocate.ready)

  scoreboard.io.sourceWarp := io.issueWarp
  scoreboard.io.source0 := decoded.src1
  scoreboard.io.source1 := decoded.src2
  scoreboard.io.source2 := Mux(decoded.opcode === AecOpcode.atom && decoded.subop === 7.U,
    decoded.src2Imm(23, 16), decoded.src3)
  scoreboard.io.source0Used := AecInstructionTraits.usesSrc0(decoded)
  scoreboard.io.source1Used := AecInstructionTraits.usesSrc1(decoded)
  scoreboard.io.source2Used := AecInstructionTraits.usesSrc2(decoded)
  scoreboard.io.source0Pair := AecInstructionTraits.source0Pair(decoded)
  scoreboard.io.source1Pair := AecInstructionTraits.source1Pair(decoded)
  scoreboard.io.source2Pair := AecInstructionTraits.source2Pair(decoded)
  scoreboard.io.sourcePredicateUsed := AecInstructionTraits.usesSourcePredicate(decoded)
  scoreboard.io.sourcePredicate := AecInstructionTraits.sourcePredicate(decoded)
  scoreboard.io.reserve.valid := io.issueValid && selectedRob && scoreboard.io.sourcesReady &&
    scoreboard.io.destinationFree && (writesGpr || writesPredicate)
  scoreboard.io.reserve.bits.warp := io.issueWarp
  scoreboard.io.reserve.bits.dest := decoded.dest
  scoreboard.io.reserve.bits.destHi := decodedPair || decoded.opcode === AecOpcode.loadi64
  scoreboard.io.reserve.bits.predicate := writesPredicate
  scoreboard.io.reserve.bits.pred := decoded.dest(2, 0)

  val commitHead = Mux(io.commitWarpLocal.asBool, robs(1).io.head.bits, robs(0).io.head.bits)
  val commitHeadValid = Mux(io.commitWarpLocal.asBool, robs(1).io.head.valid, robs(0).io.head.valid)
  val doCommit = io.commitPop && commitHeadValid && (!commitHead.writesGpr || bank.io.writeReady)
  resultStore.io.readWarpLocal := io.commitWarpLocal.asBool
  resultStore.io.readRobIndex := commitHead.tag.robIndex
  val commitData = resultStore.io.readData
  scoreboard.io.release.valid := doCommit && (commitHead.writesGpr || commitHead.writesPredicate)
  scoreboard.io.release.bits.warp := commitHead.tag.warp
  scoreboard.io.release.bits.dest := commitHead.dest
  scoreboard.io.release.bits.destHi := commitHead.writeHi
  scoreboard.io.release.bits.predicate := commitHead.writesPredicate
  scoreboard.io.release.bits.pred := commitHead.predicate

  val canIssue = io.issueValid && selectedRob && scoreboard.io.sourcesReady &&
    Mux(writesGpr || writesPredicate, scoreboard.io.destinationFree, true.B)
  io.issueReady := canIssue && bank.io.read.ready
  io.backendRequestValid := bank.io.response.valid
  io.backendOpcode := decoded.opcode
  io.backendDtype := decoded.dtype
  io.backendExecuteMask := io.activeMask
  io.backendOperands := bank.io.response.bits.data

  bank.io.read.valid := canIssue
  bank.io.read.bits.warp := io.issueWarp
  bank.io.read.bits.reg := decoded.src1
  bank.io.read.bits.tag := 0.U
  bank.io.response.ready := io.regResponseReady
  bank.io.writeValid := doCommit && commitHead.writesGpr
  bank.io.writeWarp := commitHead.tag.warp
  bank.io.writeReg := commitHead.dest
  bank.io.writeData := VecInit(commitData.map(_(31, 0)))
  bank.io.writeMask := commitHead.laneMask
  bank.io.predWriteValid := doCommit && commitHead.writesPredicate
  bank.io.predWarp := commitHead.tag.warp
  bank.io.predIndex := commitHead.predicate
  bank.io.predData := commitHead.predicateData
  bank.io.predWriteMask := commitHead.laneMask
  bank.io.predReadWarp := io.issueWarp
  bank.io.predReadIndex := decoded.predicate
  bank.io.clear := io.flush

  for (local <- 0 until 2) {
    val rob = robs(local)
    rob.io.warpId := local.U
    rob.io.allocate.valid := canIssue && io.issueWarp(0) === local.U
    rob.io.allocate.bits.epoch := io.issueEpoch
    rob.io.allocate.bits.pc := io.issuePc
    rob.io.allocate.bits.laneMask := io.activeMask
    rob.io.allocate.bits.dest := decoded.dest
    rob.io.allocate.bits.writesGpr := writesGpr
    rob.io.allocate.bits.writeHi := decodedPair || decoded.opcode === AecOpcode.loadi64
    rob.io.allocate.bits.writesPredicate := writesPredicate
    rob.io.allocate.bits.predicate := decoded.dest(2, 0)
    rob.io.allocate.bits.serializing := decoded.opcode === AecOpcode.st || decoded.opcode === AecOpcode.atom
    rob.io.completion.valid := io.completion.valid && io.completion.bits.tag.warp(0) === local.U
    rob.io.completion.bits.tag := io.completion.bits.tag
    rob.io.completion.bits.predicateData := io.completion.bits.predicateData
    rob.io.completion.bits.error := io.completion.bits.error
    rob.io.pop := doCommit && io.commitWarpLocal === local.U
    rob.io.flush := io.flush
  }
  val completionAccepted = Mux(io.completion.bits.tag.warp(0),
    robs(1).io.completionAccepted, robs(0).io.completionAccepted)
  resultStore.io.write.valid := io.completion.valid && completionAccepted
  resultStore.io.write.bits := io.completion.bits

  io.commitValid := commitHeadValid
  io.commitData := commitData

  schedulers.io.runnable := io.runnable
  schedulers.io.accept := io.schedulerAccept
  io.schedulerValid := schedulers.io.valid
  io.schedulerWarp := schedulers.io.warp
  barrier.io.activeWarps := io.barrierActive
  barrier.io.completed := io.barrierCompleted
  barrier.io.arrive := io.barrierArrive
  io.barrierRelease := barrier.io.release
  io.barrierDuplicate := barrier.io.duplicate
}

object GenerateFrontendPartitionPpa extends App {
  (new chisel3.stage.ChiselStage).emitSystemVerilog(
    new AecFrontendPartitionPpaTop,
    Array("--target-dir", "sv/generated/frontend_partition_ppa"))
}
