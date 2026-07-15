package aec

import chisel3._
import chisel3.util._

/** Four-entry, in-order retirement queue for one resident warp.
  *
  * Allocation and completion are independent.  Completion is accepted only
  * when all identity fields still match, so a response from an earlier epoch
  * can be drained without changing architectural state.
  */
class AecWarpRob(depth: Int = 4) extends Module {
  require(depth == 4, "the frontend tag currently exposes a two-bit ROB index")

  val io = IO(new Bundle {
    val warpId = Input(UInt(3.W))
    val allocate = Flipped(Decoupled(new AecRobAllocate))
    val allocatedTag = Output(new AecInstructionTag)
    val completion = Flipped(Valid(new AecRobCompletion))
    val head = Valid(new AecRobHead)
    val pop = Input(Bool())
    val flush = Input(Bool())
    val empty = Output(Bool())
    val full = Output(Bool())
    val count = Output(UInt(3.W))
    val staleCompletion = Output(Bool())
    val completionAccepted = Output(Bool())
  })

  val valid = RegInit(VecInit(Seq.fill(depth)(false.B)))
  val ready = RegInit(VecInit(Seq.fill(depth)(false.B)))
  val sequence = Reg(Vec(depth, UInt(6.W)))
  val epoch = Reg(Vec(depth, UInt(8.W)))
  val pc = Reg(Vec(depth, UInt(32.W)))
  val laneMask = Reg(Vec(depth, UInt(32.W)))
  val dest = Reg(Vec(depth, UInt(8.W)))
  val writesGpr = Reg(Vec(depth, Bool()))
  val writeHi = Reg(Vec(depth, Bool()))
  val writesPredicate = Reg(Vec(depth, Bool()))
  val predicate = Reg(Vec(depth, UInt(3.W)))
  val serializing = Reg(Vec(depth, Bool()))
  val error = Reg(Vec(depth, Bool()))
  val predicateData = Reg(Vec(depth, UInt(32.W)))

  val headPtr = RegInit(0.U(2.W))
  val tailPtr = RegInit(0.U(2.W))
  val entryCount = RegInit(0.U(3.W))
  val nextSequence = RegInit(0.U(6.W))

  io.empty := entryCount === 0.U
  io.full := entryCount === depth.U
  io.count := entryCount
  io.allocate.ready := !io.full && !io.flush
  io.allocatedTag.warp := io.warpId
  io.allocatedTag.epoch := io.allocate.bits.epoch
  io.allocatedTag.sequence := nextSequence
  io.allocatedTag.robIndex := tailPtr
  io.allocatedTag.pc := io.allocate.bits.pc

  val completionIndex = io.completion.bits.tag.robIndex
  val completionMatches = io.completion.valid &&
    io.completion.bits.tag.warp === io.warpId &&
    valid(completionIndex) &&
    epoch(completionIndex) === io.completion.bits.tag.epoch &&
    sequence(completionIndex) === io.completion.bits.tag.sequence &&
    pc(completionIndex) === io.completion.bits.tag.pc
  io.staleCompletion := io.completion.valid && !completionMatches
  io.completionAccepted := completionMatches

  io.head.valid := valid(headPtr) && ready(headPtr)
  io.head.bits.tag.warp := io.warpId
  io.head.bits.tag.epoch := epoch(headPtr)
  io.head.bits.tag.sequence := sequence(headPtr)
  io.head.bits.tag.robIndex := headPtr
  io.head.bits.tag.pc := pc(headPtr)
  io.head.bits.laneMask := laneMask(headPtr)
  io.head.bits.dest := dest(headPtr)
  io.head.bits.writesGpr := writesGpr(headPtr)
  io.head.bits.writeHi := writeHi(headPtr)
  io.head.bits.writesPredicate := writesPredicate(headPtr)
  io.head.bits.predicate := predicate(headPtr)
  io.head.bits.serializing := serializing(headPtr)
  io.head.bits.predicateData := predicateData(headPtr)
  io.head.bits.error := error(headPtr)

  val doAllocate = io.allocate.fire
  val doPop = io.pop && io.head.valid

  when (doAllocate) {
    valid(tailPtr) := true.B
    ready(tailPtr) := false.B
    sequence(tailPtr) := nextSequence
    epoch(tailPtr) := io.allocate.bits.epoch
    pc(tailPtr) := io.allocate.bits.pc
    laneMask(tailPtr) := io.allocate.bits.laneMask
    dest(tailPtr) := io.allocate.bits.dest
    writesGpr(tailPtr) := io.allocate.bits.writesGpr
    writeHi(tailPtr) := io.allocate.bits.writeHi
    writesPredicate(tailPtr) := io.allocate.bits.writesPredicate
    predicate(tailPtr) := io.allocate.bits.predicate
    serializing(tailPtr) := io.allocate.bits.serializing
    error(tailPtr) := false.B
    predicateData(tailPtr) := 0.U
    tailPtr := tailPtr + 1.U
    nextSequence := nextSequence + 1.U
  }

  when (completionMatches) {
    predicateData(completionIndex) := io.completion.bits.predicateData
    error(completionIndex) := io.completion.bits.error
    ready(completionIndex) := true.B
  }

  when (doPop) {
    valid(headPtr) := false.B
    ready(headPtr) := false.B
    headPtr := headPtr + 1.U
  }

  when (doAllocate =/= doPop) {
    entryCount := Mux(doAllocate, entryCount + 1.U, entryCount - 1.U)
  }

  when (io.flush) {
    valid := VecInit(Seq.fill(depth)(false.B))
    ready := VecInit(Seq.fill(depth)(false.B))
    headPtr := 0.U
    tailPtr := 0.U
    entryCount := 0.U
  }

  assert(!(io.pop && !io.head.valid), "ROB pop requires a ready head")
  assert(entryCount <= depth.U, "ROB count overflow")
}
