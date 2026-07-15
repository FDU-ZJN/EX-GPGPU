package aec

import chisel3._

/** Shared geometry and fixed external memory-space encodings. */
object AecFrontendConfig {
  final val Warps = 8; final val Lanes = 32; final val Registers = 256; final val Predicates = 8
  final val Schedulers = 4; final val ImemWords = 1024; final val LocalWords = 16384
  final val SmemWords = 16384; final val Outstanding = 16
}
object AecMemorySpace { val gmem = 0.U(3.W); val smem = 1.U(3.W); val cmem = 2.U(3.W); val lmem = 3.U(3.W); val pmem = 4.U(3.W) }
object AecFrontendOpcode {
  val ld = AecOpcode.ld; val st = AecOpcode.st; val ldc = AecOpcode.ldc; val atom = AecOpcode.atom
  val syncCt = AecOpcode.syncCt; val mbar = AecOpcode.mbar; val cvtff = AecOpcode.cvtff; val cvtfi = AecOpcode.cvtfi
  val cvtif = AecOpcode.cvtif; val cvtii = AecOpcode.cvtii; val shuf = AecOpcode.shuf; val vote = AecOpcode.vote
  val mtch = AecOpcode.mtch; val rdtsc = AecOpcode.rdtsc
}

class AecLocalMemoryRequest extends Bundle {
  val warp = UInt(3.W); val space = UInt(3.W); val load = Bool(); val width64 = Bool()
  val mask = UInt(32.W); val address = Vec(32, UInt(32.W)); val storeData = Vec(32, UInt(64.W))
  val atomic = Bool(); val atomicOp = UInt(3.W); val signed = Bool()
  val compareData = Vec(32, UInt(32.W))
}

/** Backend-independent issue and retirement records. */
class AecIssuePacket extends Bundle {
  val warp = UInt(3.W); val pc = UInt(32.W); val instruction = UInt(128.W); val activeMask = UInt(32.W); val executeMask = UInt(32.W)
  val opcode = UInt(16.W); val dtype = UInt(4.W); val subop = UInt(3.W); val ext = UInt(3.W)
  val instructionPredicate = UInt(3.W); val predicateEnabled = Bool(); val predicateNegated = Bool()
  val dest = UInt(8.W); val src1 = UInt(8.W); val src2 = UInt(8.W); val src3 = UInt(8.W); val src2Imm = UInt(32.W); val immExt = UInt(32.W)
  val isMemory = Bool(); val isControl = Bool()
}
class AecWritebackPacket extends Bundle {
  val warp = UInt(3.W); val laneMask = UInt(32.W); val dest = UInt(8.W); val data = Vec(32, UInt(32.W))
  val writeHi = Bool(); val hiData = Vec(32, UInt(32.W)); val predicateWrite = Bool(); val predicate = UInt(3.W)
  val predicateData = UInt(32.W); val error = Bool()
}
