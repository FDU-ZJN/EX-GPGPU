package aec

import chisel3._
import chisel3.util._
import aec.int.AecEightLaneIntUnit
import aec.fp.{AecFp32Unit, AecFp64Unit, AecSfuWarpUnit}
import aec.exec.{AecExecRequest, AecWarpRequestBuffer}

class AecClusterControl extends Bundle {
  val kind = UInt(2.W)
  val intControl = UInt(4.W)
  val dtype = UInt(4.W)
  val immExt = UInt(32.W)
  val src2Imm = UInt(32.W)
  val subop = UInt(3.W)
}

class AecClusterOperandSelect extends Module {
  val io = IO(new Bundle {
    val control = Input(new AecClusterControl)
    val operandA = Input(Vec(4, UInt(32.W)))
    val operandB = Input(Vec(4, UInt(32.W)))
    val operandC = Input(Vec(4, UInt(32.W)))
    val operandAHi = Input(Vec(4, UInt(32.W)))
    val operandBHi = Input(Vec(4, UInt(32.W)))
    val operandCHi = Input(Vec(4, UInt(32.W)))
    val outA = Output(Vec(4, UInt(64.W)))
    val outB = Output(Vec(4, UInt(64.W)))
    val outC = Output(Vec(4, UInt(64.W)))
  })

  for (lane <- 0 until 4) {
    val copySource = io.operandA(lane)
    val copyValue = MuxLookup(io.control.dtype, copySource, Seq(
      4.U -> Cat(0.U(24.W), copySource(7, 0)),
      5.U -> Cat(Fill(24, copySource(7)), copySource(7, 0)),
      10.U -> Cat(0.U(16.W), copySource(15, 0)),
      11.U -> Cat(0.U(16.W), copySource(15, 0))))
    val integerA = Mux(io.control.intControl === 1.U, io.control.immExt,
      Mux(io.control.intControl === 2.U, copyValue, io.operandA(lane)))
    val integerB = Mux(io.control.intControl === 1.U || io.control.intControl === 2.U ||
      io.control.intControl === 3.U, 0.U, io.operandB(lane))
    val integerC = Mux(io.control.intControl === 3.U, io.control.src2Imm,
      Mux(io.control.intControl === 4.U, io.control.immExt,
        Mux(io.control.intControl === 5.U || io.control.intControl === 6.U,
          io.control.subop, io.operandC(lane))))
    val fpOperands = io.control.kind =/= 0.U
    io.outA(lane) := Cat(io.operandAHi(lane),
      Mux(fpOperands, io.operandA(lane), integerA))
    io.outB(lane) := Cat(io.operandBHi(lane),
      Mux(fpOperands, io.operandB(lane), integerB))
    io.outC(lane) := Cat(io.operandCHi(lane),
      Mux(io.control.kind === 3.U, 0.U,
        Mux(io.control.kind === 1.U || io.control.kind === 2.U,
          io.operandC(lane), integerC)))
  }
}

/** Partition-local compute cluster.
  *
  * Keeping operand selection, backend tags and the wide completion mux behind
  * one repeated module boundary prevents AecEvalCore from becoming the single
  * ABC mapping bottleneck. Full-warp operands never leave their owning
  * scheduler partition through any global interconnect.
  */
class AecPartitionBackend extends Module {
  val io = IO(new Bundle {
    val dispatch = Input(Bool())
    val instruction = Input(new AecDecodedInstruction)
    val tag = Input(new AecInstructionTag)
    val executeMask = Input(UInt(32.W))
    val predicateMask = Input(UInt(32.W))
    val operandA = Input(Vec(32, UInt(32.W)))
    val operandB = Input(Vec(32, UInt(32.W)))
    val operandC = Input(Vec(32, UInt(32.W)))
    val operandAHi = Input(Vec(32, UInt(32.W)))
    val operandBHi = Input(Vec(32, UInt(32.W)))
    val operandCHi = Input(Vec(32, UInt(32.W)))
    val accepted = Output(Bool())
    val completion = Vec(4, Decoupled(new AecBackendCompletion))
  })

  // The backend owns the sole full-warp operand collector.  Integrated
  // execution units consume this stable payload directly instead of each
  // retaining another 6-Kbit operand copy.
  val intUnit = Module(new AecEightLaneIntUnit(16, useInternalRequestBuffer = false))
  val fp32Unit = Module(new AecFp32Unit(16, useInternalRequestBuffer = false))
  val fp64Unit = Module(new AecFp64Unit(8, useInternalRequestBuffer = false))
  val sfuUnit = Module(new AecSfuWarpUnit(8, useInternalRequestBuffer = false))
  val requestBuffer = Module(new AecWarpRequestBuffer)

  val intTag = Reg(new AecInstructionTag)
  val fp32Tag = Reg(new AecInstructionTag)
  val fp64Tag = Reg(new AecInstructionTag)
  val sfuTag = Reg(new AecInstructionTag)

  val held = io.instruction
  val heldIsCmpp = held.opcode === AecOpcode.cmpp
  val heldIsBfx = held.opcode === AecOpcode.bfx
  val heldIsBins = held.opcode === AecOpcode.bins
  val heldMove = held.opcode === AecOpcode.cpy || held.opcode === AecOpcode.loadi
  val heldFp32 = AecInstructionTraits.fpOpcode(held.opcode) &&
    (held.dtype === 8.U || held.dtype === 10.U || held.dtype === 11.U)
  val heldFp64 = AecInstructionTraits.fpOpcode(held.opcode) && held.dtype === 9.U
  val heldSfu = held.opcode === AecOpcode.div || held.opcode === AecOpcode.rcp ||
    held.opcode === AecOpcode.rsq || held.opcode === AecOpcode.sin ||
    held.opcode === AecOpcode.cos || held.opcode === AecOpcode.exp ||
    held.opcode === AecOpcode.log || held.opcode === AecOpcode.sqrt
  val decodedKind = Mux(heldFp32, 1.U, Mux(heldFp64, 2.U, Mux(heldSfu, 3.U, 0.U)))
  val clusterControl = Reg(Vec(8, new AecClusterControl))
  val decodedIntControl = Mux(held.opcode === AecOpcode.loadi, 1.U,
    Mux(held.opcode === AecOpcode.cpy, 2.U,
      Mux(held.opcode === AecOpcode.bfx, 3.U,
        Mux(held.opcode === AecOpcode.bins, 4.U,
          Mux(held.opcode === AecOpcode.cmp, 5.U,
            Mux(held.opcode === AecOpcode.cmpp, 6.U, 0.U))))))

  val selectedFpOp = Mux(held.opcode === AecOpcode.cmp,
    aec.fp.AecFpOp.cmpBase + held.subop,
    Mux(held.opcode === AecOpcode.cmpp, aec.fp.AecFpOp.cmppBase + held.subop, held.opcode))
  val collectorInput = Wire(new AecExecRequest)
  collectorInput.op := Mux(heldFp32 || heldFp64, selectedFpOp,
    Mux(heldMove, AecOpcode.add, held.opcode))
  collectorInput.dtype := Mux(heldMove && !heldFp32 && !heldFp64, 2.U, held.dtype)
  collectorInput.activeMask := io.executeMask
  collectorInput.dest := held.dest
  collectorInput.predicateSelect := held.predicate
  collectorInput.predicateValues := io.predicateMask
  val operandSelect = Seq.fill(8)(Module(new AecClusterOperandSelect))
  for (cluster <- 0 until 8) {
    val select = operandSelect(cluster).io
    select.control := clusterControl(cluster)
    for (lane <- 0 until 4) {
      val globalLane = cluster * 4 + lane
      select.operandA(lane) := io.operandA(globalLane)
      select.operandB(lane) := io.operandB(globalLane)
      select.operandC(lane) := io.operandC(globalLane)
      select.operandAHi(lane) := io.operandAHi(globalLane)
      select.operandBHi(lane) := io.operandBHi(globalLane)
      select.operandCHi(lane) := io.operandCHi(globalLane)
      collectorInput.a(globalLane) := select.outA(lane)
      collectorInput.b(globalLane) := select.outB(lane)
      collectorInput.c(globalLane) := select.outC(lane)
    }
  }

  requestBuffer.io.in := collectorInput
  val collectorBusy = RegInit(false.B)
  val collectorArmPending = RegInit(false.B)
  val collectorKind = Reg(UInt(2.W))
  val collectorMode = Reg(UInt(3.W))
  val collectorArm = io.dispatch && !collectorBusy && !collectorArmPending
  when (collectorArm) {
    for (cluster <- 0 until 8) {
      clusterControl(cluster).kind := decodedKind
      clusterControl(cluster).intControl := decodedIntControl
      clusterControl(cluster).dtype := held.dtype
      clusterControl(cluster).immExt := held.immExt
      clusterControl(cluster).src2Imm := held.src2Imm
      clusterControl(cluster).subop := held.subop
    }
  }
  val armClusters = RegInit(VecInit(Seq.fill(8)(false.B)))
  armClusters.foreach(_ := collectorArm)
  armClusters.foreach(dontTouch(_))
  requestBuffer.io.arm := armClusters
  requestBuffer.io.capture := collectorArmPending
  collectorArmPending := collectorArm
  when (collectorArmPending) {
    collectorBusy := true.B
    collectorKind := clusterControl(0).kind
    collectorMode := held.subop
  }

  val sharedRequest = requestBuffer.io.out
  intUnit.io.req.bits := sharedRequest
  fp32Unit.io.req.bits := sharedRequest
  fp64Unit.io.req.bits := sharedRequest
  sfuUnit.io.req.bits := sharedRequest
  intUnit.io.req.valid := collectorBusy && collectorKind === 0.U
  fp32Unit.io.req.valid := collectorBusy && collectorKind === 1.U
  fp64Unit.io.req.valid := collectorBusy && collectorKind === 2.U
  sfuUnit.io.req.valid := collectorBusy && collectorKind === 3.U
  sfuUnit.io.mode := collectorMode

  val requestFires = Seq(intUnit.io.req.fire, fp32Unit.io.req.fire,
    fp64Unit.io.req.fire, sfuUnit.io.req.fire)
  io.accepted := requestFires.reduce(_ || _)
  when (intUnit.io.req.fire) { intTag := io.tag }
  when (fp32Unit.io.req.fire) { fp32Tag := io.tag }
  when (fp64Unit.io.req.fire) { fp64Tag := io.tag }
  when (sfuUnit.io.req.fire) { sfuTag := io.tag }

  val responses = Seq(intUnit.io.resp, fp32Unit.io.resp, fp64Unit.io.resp, sfuUnit.io.resp)
  val tags = Seq(intTag, fp32Tag, fp64Tag, sfuTag)
  for (i <- responses.indices) {
    io.completion(i).valid := responses(i).valid
    io.completion(i).bits.tag := tags(i)
    io.completion(i).bits.data := responses(i).bits.result
    io.completion(i).bits.predicateData := responses(i).bits.predicateMask
    io.completion(i).bits.error := responses(i).bits.errorMask.orR
    responses(i).ready := io.completion(i).ready
  }
  when (responses.map(_.fire).reduce(_ || _)) { collectorBusy := false.B }
}
