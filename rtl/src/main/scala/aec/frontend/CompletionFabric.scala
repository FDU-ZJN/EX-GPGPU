package aec

import chisel3._
import chisel3.util._

class AecCompletionLaneStage(val sources: Int) extends Module {
  require(sources > 0)
  val io = IO(new Bundle {
    val capture = Input(Bool())
    val select = Input(UInt(log2Ceil(sources max 2).W))
    val in = Input(Vec(sources, UInt(64.W)))
    val out = Output(UInt(64.W))
  })

  private val paddedSources = 1 << log2Ceil(sources max 2)
  private val padded = io.in ++ Seq.fill(paddedSources - sources)(io.in.head)
  private def balancedMux(level: Seq[UInt], bit: Int): UInt = {
    if (level.size == 1) level.head
    else balancedMux(level.grouped(2).map(pair => Mux(io.select(bit), pair(1), pair(0))).toSeq, bit + 1)
  }
  val data = Reg(UInt(64.W))
  when (io.capture) { data := balancedMux(padded, 0) }
  io.out := data
}

/** Registered arbitration boundary for the wide backend completion payload.
  * Four scheduler partitions instantiate the same module definition, so the
  * wide mux is mapped once instead of being expanded in AecEvalTop. */
class AecCompletionArbiter(val sources: Int = 7) extends Module {
  require(sources > 0)
  val io = IO(new Bundle {
    val in = Flipped(Vec(sources, Decoupled(new AecBackendCompletion)))
    val out = Decoupled(new AecBackendCompletion)
  })

  val valid = VecInit(io.in.map(_.valid)).asUInt
  val selectedSource = Reg(UInt(log2Ceil(sources max 2).W))
  val selected = io.in(selectedSource).bits
  val outputValid = RegInit(false.B)
  val selectionPending = RegInit(false.B)
  val outputReady = !outputValid || io.out.ready
  val arm = !selectionPending && outputReady && valid.orR
  val capture = selectionPending && outputReady
  val clusterGrant = Reg(Vec(4, UInt(log2Ceil(sources max 2).W)))
  val lanes = Seq.fill(32)(Module(new AecCompletionLaneStage(sources)))
  val tag = RegEnable(selected.tag, capture)
  val predicateData = RegEnable(selected.predicateData, capture)
  val error = RegEnable(selected.error, capture)
  when (arm) {
    val grant = PriorityEncoder(valid)
    selectedSource := grant
    clusterGrant.foreach(_ := grant)
    selectionPending := true.B
  }
  when (capture) { selectionPending := false.B }
  when (outputReady) { outputValid := capture }
  for (i <- 0 until sources) {
    io.in(i).ready := capture && selectedSource === i.U
  }
  for (lane <- 0 until 32) {
    lanes(lane).io.capture := capture
    lanes(lane).io.select := clusterGrant(lane / 8)
    for (source <- 0 until sources) {
      lanes(lane).io.in(source) := io.in(source).bits.data(lane)
    }
    io.out.bits.data(lane) := lanes(lane).io.out
  }
  io.out.valid := outputValid
  io.out.bits.tag := tag
  io.out.bits.predicateData := predicateData
  io.out.bits.error := error
}

class AecResultStoreLane extends Module {
  val io = IO(new Bundle {
    val write = Input(Bool())
    val writeData = Input(UInt(64.W))
    val data = Output(UInt(64.W))
  })
  val data = Reg(UInt(64.W))
  when (io.write) { data := io.writeData }
  io.data := data
}

class AecResultStoreEntry extends Module {
  val io = IO(new Bundle {
    val write = Input(Bool())
    val writeData = Input(Vec(32, UInt(64.W)))
    val data = Output(Vec(32, UInt(64.W)))
  })
  val lanes = Seq.fill(32)(Module(new AecResultStoreLane))
  for (lane <- 0 until 32) {
    lanes(lane).io.write := io.write
    lanes(lane).io.writeData := io.writeData(lane)
    io.data(lane) := lanes(lane).io.data
  }
}

class AecResultStoreReadLane(val entries: Int) extends Module {
  val io = IO(new Bundle {
    val index = Input(UInt(log2Ceil(entries).W))
    val data = Input(Vec(entries, UInt(64.W)))
    val out = Output(UInt(64.W))
  })
  io.out := io.data(io.index)
}

/** Eight result slots for the two resident warps owned by one scheduler
  * partition.  The ROB retains ordering metadata while this module owns the
  * only copy of each 32-lane result payload. */
class AecPartitionResultStore extends Module {
  private val entries = 8
  val io = IO(new Bundle {
    val write = Flipped(Valid(new AecBackendCompletion))
    val readWarpLocal = Input(Bool())
    val readRobIndex = Input(UInt(2.W))
    val readData = Output(Vec(32, UInt(64.W)))
  })

  val data = Seq.fill(entries)(Module(new AecResultStoreEntry))
  val writeIndex = Cat(io.write.bits.tag.warp(0), io.write.bits.tag.robIndex)
  val readIndex = Cat(io.readWarpLocal, io.readRobIndex)
  val writeOH = UIntToOH(writeIndex, entries) & Fill(entries, io.write.valid)
  for (entry <- 0 until entries) {
    data(entry).io.write := writeOH(entry)
    data(entry).io.writeData := io.write.bits.data
  }
  val readLanes = Seq.fill(32)(Module(new AecResultStoreReadLane(entries)))
  for (lane <- 0 until 32) {
    readLanes(lane).io.index := readIndex
    for (entry <- 0 until entries) {
      readLanes(lane).io.data(entry) := data(entry).io.data(lane)
    }
    io.readData(lane) := readLanes(lane).io.out
  }
}

class AecWritebackLaneScratch extends Module with RequireAsyncReset {
  val io = IO(new Bundle {
    val writeLow = Input(Bool())
    val lowIn = Input(UInt(32.W))
    val writeHigh = Input(Bool())
    val highIn = Input(UInt(32.W))
    val low = Output(UInt(32.W))
    val high = Output(UInt(32.W))
  })

  val low = RegInit(0.U(32.W))
  val high = RegInit(0.U(32.W))
  when (io.writeLow) { low := io.lowIn }
  when (io.writeHigh) { high := io.highIn }
  io.low := low
  io.high := high
}
