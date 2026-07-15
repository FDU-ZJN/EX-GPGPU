package aec

import chisel3._
import chisel3.util._
import aec.exec._
import aec.int.AecEightLaneIntUnit
import aec.fp.{AecFp32Unit, AecFp64Unit, AecSfuWarpUnit}

/** Official testbench interface.  Execution-unit ports are internal only. */
class AecEvalTop extends Module {
  val io = IO(new Bundle {
    val load_valid = Input(Bool()); val load_ready = Output(Bool())
    val load_target = Input(UInt(3.W)); val load_addr = Input(UInt(32.W))
    val load_data = Input(UInt(128.W)); val load_strb = Input(UInt(16.W))
    val launch_valid = Input(Bool()); val launch_ready = Output(Bool())
    val grid_x = Input(UInt(32.W)); val grid_y = Input(UInt(32.W)); val grid_z = Input(UInt(32.W))
    val block_x = Input(UInt(32.W)); val block_y = Input(UInt(32.W)); val block_z = Input(UInt(32.W))
    val program_instructions = Input(UInt(32.W))
    val result_valid = Output(Bool()); val result_ready = Input(Bool())
    val result_status = Output(UInt(3.W)); val result_cycles = Output(UInt(64.W))
    val read_valid = Input(Bool()); val read_ready = Output(Bool()); val read_addr = Input(UInt(32.W))
    val read_data_valid = Output(Bool()); val read_data = Output(UInt(128.W))
    val mem_req_valid = Output(Bool()); val mem_req_ready = Input(Bool())
    val mem_req_write = Output(Bool()); val mem_req_addr = Output(UInt(32.W))
    val mem_req_wdata = Output(UInt(1024.W)); val mem_req_wstrb = Output(UInt(128.W)); val mem_req_tag = Output(UInt(4.W))
    val mem_rsp_valid = Input(Bool()); val mem_rsp_ready = Output(Bool()); val mem_rsp_rdata = Input(UInt(1024.W))
    val mem_rsp_tag = Input(UInt(4.W)); val mem_rsp_error = Input(Bool())
    // Simulation-only architectural retirement monitor.  These signals are
    // intentionally outside the contest-facing adapter unless debug is used.
    val debug_commit_valid = Output(Vec(4, Bool()))
    val debug_commit_cta_x = Output(Vec(4, UInt(32.W)))
    val debug_commit_cta_y = Output(Vec(4, UInt(32.W)))
    val debug_commit_cta_z = Output(Vec(4, UInt(32.W)))
    val debug_commit_warp = Output(Vec(4, UInt(3.W)))
    val debug_commit_pc = Output(Vec(4, UInt(32.W)))
    val debug_commit_instruction = Output(Vec(4, UInt(128.W)))
    val debug_commit_execute_mask = Output(Vec(4, UInt(32.W)))
    val debug_commit_dest = Output(Vec(4, UInt(8.W)))
    val debug_commit_lane_mask = Output(Vec(4, UInt(32.W)))
    val debug_commit_data = Output(Vec(4, UInt(1024.W)))
    val debug_commit_predicate_valid = Output(Vec(4, Bool()))
    val debug_commit_predicate = Output(Vec(4, UInt(3.W)))
    val debug_commit_predicate_data = Output(Vec(4, UInt(32.W)))
  })

  // One synchronous SRAM read port per scheduler. Program writes are mirrored
  // to all four replicas before launch.
  val imem = Seq.fill(4)(Module(new AecInstructionSram))
  val running = RegInit(false.B)
  val loadError = RegInit(false.B)
  val resultValid = RegInit(false.B)
  val resultStatus = RegInit(0.U(3.W))
  val cycles = RegInit(0.U(64.W))
  val launchThreads = RegInit(0.U(32.W))
  val launchGridX = RegInit(0.U(32.W)); val launchGridY = RegInit(0.U(32.W)); val launchGridZ = RegInit(0.U(32.W))
  val launchBlockX = RegInit(0.U(32.W)); val launchBlockY = RegInit(0.U(32.W)); val launchBlockZ = RegInit(0.U(32.W))
  val ctaX = RegInit(0.U(32.W)); val ctaY = RegInit(0.U(32.W)); val ctaZ = RegInit(0.U(32.W))
  val restartCta = RegInit(false.B)
  // A registered trap gives the simulator one full cycle to emit a useful
  // dynamic diagnostic before Verilator stops on the assertion.
  val unsupportedTrap = RegInit(false.B)
  val unsupportedAssert = RegInit(false.B)
  val unsupportedPc = RegInit(0.U(32.W))
  val unsupportedWarp = RegInit(0.U(3.W))
  val unsupportedOpcode = RegInit(0.U(16.W))
  val unsupportedDtype = RegInit(0.U(4.W))
  val pc = RegInit(VecInit(Seq.fill(8)(0.U(32.W))))
  val warpState = RegInit(VecInit(Seq.fill(8)(0.U(3.W)))) // 0 idle, 1 runnable, 2 blocked, 3 done
  val activeMask = RegInit(VecInit(Seq.fill(8)(0.U(32.W))))
  val callDepth = RegInit(VecInit(Seq.fill(8)(0.U(6.W))))
  val callStack = Reg(Vec(8, Vec(32, UInt(32.W))))
  val rr = RegInit(VecInit(Seq.fill(4)(false.B)))
  val barrier = Module(new AecCtaBarrier)
  val external = Module(new AecExternalMemoryEngine)
  val localLsu = Module(new AecLocalLsu)
  localLsu.io.clearSmem := false.B
  localLsu.io.preload.valid := false.B
  localLsu.io.preload.bits := 0.U.asTypeOf(localLsu.io.preload.bits)

  // Loading is intentionally allowed only before launch.  The fixed local
  // apertures make an invalid preload visible at launch instead of silently
  // truncating a testcase image.
  val localLoadTarget = io.load_target === 2.U || io.load_target === 3.U
  io.load_ready := !running && !resultValid && (!localLoadTarget || localLsu.io.preload.ready)
  val loadFire = io.load_valid && io.load_ready
  for (port <- 0 until 4) {
    imem(port).io.writeEn := loadFire && io.load_target === 0.U &&
      io.load_addr < AecFrontendConfig.ImemWords.U && io.load_strb === "hffff".U
    imem(port).io.writeAddress := io.load_addr(9, 0)
    imem(port).io.writeData := io.load_data
    imem(port).io.readEn := false.B
    imem(port).io.readAddress := 0.U
  }
  when (loadFire) {
    when (io.load_target === 0.U) {
      when (io.load_addr >= AecFrontendConfig.ImemWords.U || io.load_strb =/= "hffff".U) { loadError := true.B }
        .otherwise { }
    }.elsewhen (io.load_target === 2.U || io.load_target === 3.U) {
      when (io.load_addr(31, 16).orR) { loadError := true.B }
        .otherwise {
          localLsu.io.preload.valid := true.B
          localLsu.io.preload.bits.pmem := io.load_target === 2.U
          localLsu.io.preload.bits.address := io.load_addr(15, 0)
          localLsu.io.preload.bits.data := io.load_data
          localLsu.io.preload.bits.mask := io.load_strb
        }
    }.elsewhen (io.load_target =/= 1.U) { loadError := true.B }
  }

  val totalThreads = io.block_x * io.block_y * io.block_z
  val launchBad = totalThreads === 0.U || totalThreads > 256.U || io.program_instructions === 0.U || io.program_instructions > AecFrontendConfig.ImemWords.U || loadError
  io.launch_ready := !running && !resultValid
  when (io.launch_valid && io.launch_ready) {
    cycles := 0.U
    unsupportedTrap := false.B
    unsupportedAssert := false.B
    when (launchBad) { resultValid := true.B; resultStatus := 1.U }
      .otherwise {
        running := true.B
        launchThreads := totalThreads; launchGridX := io.grid_x; launchGridY := io.grid_y; launchGridZ := io.grid_z
        launchBlockX := io.block_x; launchBlockY := io.block_y; launchBlockZ := io.block_z
        ctaX := 0.U; ctaY := 0.U; ctaZ := 0.U
        for (w <- 0 until 8) {
          val remaining = totalThreads - (w * 32).U
          activeMask(w) := Mux(remaining >= 32.U, "hffffffff".U, Mux(remaining === 0.U, 0.U, (1.U(33.W) << remaining(5, 0))(31, 0) - 1.U))
          pc(w) := 0.U
          callDepth(w) := 0.U
          warpState(w) := Mux(totalThreads > (w * 32).U, 1.U, 3.U)
        }
      }
  }
  when (restartCta) {
    restartCta := false.B
    for (w <- 0 until 8) {
      val remaining = launchThreads - (w * 32).U
      activeMask(w) := Mux(remaining >= 32.U, "hffffffff".U, Mux(remaining === 0.U, 0.U, (1.U(33.W) << remaining(5, 0))(31, 0) - 1.U))
      pc(w) := 0.U; callDepth(w) := 0.U
      warpState(w) := Mux(launchThreads > (w * 32).U, 1.U, 3.U)
    }
  }
  when ((io.launch_valid && io.launch_ready && !launchBad) || restartCta) { localLsu.io.clearSmem := true.B }
  when (running) { cycles := cycles + 1.U }

  // Each scheduler owns a two-warp register-file partition and an eight-lane
  // integer cluster.  A 32-lane instruction is collected from the synchronous
  // 2R1W bank, issued as four physical lane groups, then committed one lane per
  // cycle.  This is deliberately conservative, but all architectural reads
  // precede writeback and every RAW/WAW hazard is tracked by the scoreboard.
  val regBanks = Seq.fill(4)(Module(new AecRegBank))
  val scoreboards = Seq.fill(4)(Module(new AecScoreboard))
  // Four partitions: 4x16 INT32, 4x16 FP32, and 4x2 FP64 lanes.
  val intUnits = Seq.fill(4)(Module(new AecEightLaneIntUnit(16)))
  // FP32/F16/BF16 execution is a real backend, not a decode placeholder.
  // FP64 is added with pair retirement in the next datapath stage.
  val fp32Units = Seq.fill(4)(Module(new AecFp32Unit(16)))
  val fp64Units = Seq.fill(4)(Module(new AecFp64Unit(2)))
  val sfuUnits = Seq.fill(4)(Module(new AecSfuWarpUnit(1)))
  val cvtUnits = Seq.fill(4)(Module(new AecConvertLane))
  val gmemLsus = Seq.fill(4)(Module(new AecGmemLsu))
  val pipeIdle :: pipeReadAB :: pipeReadC :: pipeReadAHi :: pipeReadBHi :: pipeReadCHi :: pipeDispatch :: pipeWait :: pipeMemStart :: pipeMemWait :: pipeCvt :: pipeWrite :: Nil = Enum(12)
  val pipeState = Seq.fill(4)(RegInit(pipeIdle))
  val held = Seq.fill(4)(Reg(new AecDecodedInstruction))
  val heldWarp = Seq.fill(4)(Reg(UInt(3.W)))
  val heldExecute = Seq.fill(4)(Reg(UInt(32.W)))
  // Some collectives retire to a subset of the executing lanes.  Keep that
  // mask separate from the instruction guard/active mask used for sampling.
  val heldCommit = Seq.fill(4)(Reg(UInt(32.W)))
  val readLane = Seq.fill(4)(RegInit(0.U(5.W)))
  val writeLane = Seq.fill(4)(RegInit(0.U(5.W)))
  val operandA = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val operandB = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val operandC = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val operandAHi = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val operandBHi = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val operandCHi = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val writeData = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val writeHiData = Seq.fill(4)(RegInit(VecInit(Seq.fill(32)(0.U(32.W)))))
  val writePredicates = Seq.fill(4)(RegInit(0.U(32.W)))
  val writeHiPhase = Seq.fill(4)(RegInit(false.B))
  val cvtLane = Seq.fill(4)(RegInit(0.U(5.W)))
  val localRequests = Wire(Vec(4, new AecLocalMemoryRequest))
  val localRequestValid = Wire(Vec(4, Bool()))
  val syncArriveValid = Wire(Vec(4, Bool()))
  val syncArriveWarp = Wire(Vec(4, UInt(3.W)))

  for (s <- 0 until 4) {
    val commit = pipeState(s) === pipeWrite && writeLane(s) === 31.U &&
      (!((held(s).dtype === 1.U || held(s).dtype === 9.U || held(s).opcode === AecOpcode.loadi64)) || writeHiPhase(s))
    io.debug_commit_valid(s) := commit
    io.debug_commit_cta_x(s) := ctaX
    io.debug_commit_cta_y(s) := ctaY
    io.debug_commit_cta_z(s) := ctaZ
    io.debug_commit_warp(s) := heldWarp(s)
    io.debug_commit_pc(s) := pc(heldWarp(s))
    io.debug_commit_instruction(s) := held(s).raw
    io.debug_commit_execute_mask(s) := heldExecute(s)
    io.debug_commit_dest(s) := held(s).dest
    io.debug_commit_lane_mask(s) := heldCommit(s)
    io.debug_commit_data(s) := Cat(writeData(s).reverse)
    io.debug_commit_predicate_valid(s) := commit && (held(s).opcode === AecOpcode.cmpp || (held(s).opcode === AecOpcode.vote && held(s).ext === 1.U))
    io.debug_commit_predicate(s) := held(s).dest(2, 0)
    io.debug_commit_predicate_data(s) := writePredicates(s)
  }

  def integerOpcode(op: UInt): Bool =
    op === AecOpcode.add || op === AecOpcode.sub || op === AecOpcode.mul ||
    op === AecOpcode.mad || op === AecOpcode.neg ||
    op === AecOpcode.abs || op === AecOpcode.min || op === AecOpcode.max ||
    op === AecOpcode.andOp || op === AecOpcode.orOp || op === AecOpcode.xorOp ||
    op === AecOpcode.notOp || op === AecOpcode.shl || op === AecOpcode.shr ||
    op === AecOpcode.bfx || op === AecOpcode.bins || op === AecOpcode.popc ||
    op === AecOpcode.flo || op === AecOpcode.cmp || op === AecOpcode.cmpp ||
    op === AecOpcode.sel || op === AecOpcode.pick || op === AecOpcode.cpy ||
    op === AecOpcode.loadi

  def fp32Opcode(op: UInt): Bool =
    op === AecOpcode.add || op === AecOpcode.sub || op === AecOpcode.mul ||
    op === AecOpcode.mad || op === AecOpcode.fma || op === AecOpcode.neg ||
    op === AecOpcode.abs || op === AecOpcode.min || op === AecOpcode.max ||
    op === AecOpcode.cmp || op === AecOpcode.cmpp

  // Four independent scheduler selections.  A warp is only runnable when its
  // partition has no instruction in operand collection, execution or retire.
  val selected = Wire(Vec(4, UInt(3.W)))
  val selectedValid = Wire(Vec(4, Bool()))
  val fetchPending = Seq.fill(4)(RegInit(false.B))
  val fetchWarp = Seq.fill(4)(Reg(UInt(3.W)))
  for (s <- 0 until 4) {
    val lo = (s * 2).U(3.W); val hi = (s * 2 + 1).U(3.W)
    val partitionFree = pipeState(s) === pipeIdle
    val loRun = warpState(s * 2) === 1.U && partitionFree; val hiRun = warpState(s * 2 + 1) === 1.U && partitionFree
    selectedValid(s) := loRun || hiRun
    selected(s) := Mux(rr(s), Mux(hiRun, hi, lo), Mux(loRun, lo, hi))
    val fetchRequest = running && selectedValid(s) && !fetchPending(s)
    imem(s).io.readEn := fetchRequest
    imem(s).io.readAddress := pc(selected(s))(9, 0)
    when (fetchRequest) { fetchPending(s) := true.B; fetchWarp(s) := selected(s) }
    when (fetchPending(s) && pipeState(s) === pipeIdle) { fetchPending(s) := false.B }
    when (!running) { fetchPending(s) := false.B }
  }

  // Default all of the bank, scoreboard and execution-unit ports.  The
  // register bank is reset-valid rather than data-reset, which is the same
  // externally visible zero-state and remains compatible with SRAM macros.
  for (s <- 0 until 4) {
    val bank = regBanks(s)
    val score = scoreboards(s)
    val unit = intUnits(s)
    val fp32 = fp32Units(s)
    val fp64 = fp64Units(s)
    val sfu = sfuUnits(s)
    val cvt = cvtUnits(s)
    val issueWarp = fetchWarp(s)
    val issueValid = fetchPending(s) && pipeState(s) === pipeIdle && running
    val fetch = imem(s).io.readData
    val decoded = AecDecode(fetch)
    val heldIsCmpp = held(s).opcode === AecOpcode.cmpp
    val heldWritesPred = heldIsCmpp || (held(s).opcode === AecOpcode.vote && held(s).ext === 1.U)
    val heldIsBfx = held(s).opcode === AecOpcode.bfx
    val heldIsBins = held(s).opcode === AecOpcode.bins
    val heldMove = held(s).opcode === AecOpcode.cpy || held(s).opcode === AecOpcode.loadi
    val heldLoadi64 = held(s).opcode === AecOpcode.loadi64
    val heldPair = held(s).dtype === 1.U || held(s).dtype === 9.U || heldLoadi64
    val heldCvt = held(s).opcode === AecOpcode.cvtff || held(s).opcode === AecOpcode.cvtfi || held(s).opcode === AecOpcode.cvtif || held(s).opcode === AecOpcode.cvtii
    val heldCvtSrc = held(s).raw(109, 106)
    val heldAtomic = held(s).opcode === AecOpcode.atom
    val heldAtomicCas = heldAtomic && held(s).subop === 7.U
    val heldSpecialCpy = held(s).opcode === AecOpcode.cpy && held(s).src1Raw(15, 8).orR
    val heldSfu = held(s).opcode === AecOpcode.div || held(s).opcode === AecOpcode.rcp ||
      held(s).opcode === AecOpcode.rsq || held(s).opcode === AecOpcode.sin || held(s).opcode === AecOpcode.cos ||
      held(s).opcode === AecOpcode.exp || held(s).opcode === AecOpcode.log || held(s).opcode === AecOpcode.sqrt
    val heldNeedsPairRead = heldPair || (heldCvt && heldCvtSrc === 9.U)
    val heldMemory = held(s).opcode === AecOpcode.ld || held(s).opcode === AecOpcode.st || held(s).opcode === AecOpcode.ldc || heldAtomic
    val heldStore = held(s).opcode === AecOpcode.st
    val heldGmem = heldMemory && held(s).ext === AecMemorySpace.gmem
    val heldLocalMemory = heldMemory && held(s).ext =/= AecMemorySpace.gmem
    val lsu = gmemLsus(s)
    syncArriveValid(s) := false.B
    syncArriveWarp(s) := issueWarp

    bank.io.clear := (io.launch_valid && io.launch_ready && !launchBad) || restartCta
    bank.io.read.valid := pipeState(s) === pipeReadAB || pipeState(s) === pipeReadC || pipeState(s) === pipeReadAHi || pipeState(s) === pipeReadBHi || pipeState(s) === pipeReadCHi
    bank.io.read.bits.warpLocal := heldWarp(s)(0)
    bank.io.read.bits.lane := readLane(s)
    bank.io.read.bits.rs1 := MuxLookup(pipeState(s), held(s).src1, Seq(
      pipeReadC -> Mux(heldAtomicCas, held(s).src2Imm(23, 16), held(s).src3),
      pipeReadAHi -> (held(s).src1 + 1.U),
      pipeReadBHi -> (held(s).src2 + 1.U),
      pipeReadCHi -> (held(s).src3 + 1.U)))
    bank.io.read.bits.rs2 := MuxLookup(pipeState(s), held(s).src2, Seq(
      pipeReadC -> Mux(heldAtomicCas, held(s).src2Imm(23, 16), held(s).src3),
      pipeReadAHi -> (held(s).src1 + 1.U),
      pipeReadBHi -> (held(s).src2 + 1.U),
      pipeReadCHi -> (held(s).src3 + 1.U)))
    bank.io.read.bits.tag := readLane(s)
    bank.io.response.ready := true.B
    bank.io.writeValid := pipeState(s) === pipeWrite && heldCommit(s)(writeLane(s)) && !heldWritesPred
    bank.io.writeWarpLocal := heldWarp(s)(0)
    bank.io.writeLane := writeLane(s)
    bank.io.writeReg := Mux(heldPair && writeHiPhase(s), held(s).dest + 1.U, held(s).dest)
    bank.io.writeData := Mux(heldPair && writeHiPhase(s), writeHiData(s)(writeLane(s)), writeData(s)(writeLane(s)))
    bank.io.predWriteValid := pipeState(s) === pipeWrite && heldCommit(s)(writeLane(s)) && heldWritesPred
    bank.io.predWarpLocal := heldWarp(s)(0)
    bank.io.predLane := writeLane(s)
    bank.io.predIndex := held(s).dest(2, 0)
    bank.io.predData := writePredicates(s)(writeLane(s))
    bank.io.predReadWarpLocal := Mux(pipeState(s) === pipeIdle, issueWarp(0), heldWarp(s)(0))
    bank.io.predReadIndex := Mux(pipeState(s) === pipeIdle, decoded.predicate,
      Mux(held(s).opcode === AecOpcode.vote, held(s).src1(2, 0), held(s).predicate))

    score.io.sourceWarp := issueWarp
    score.io.source0 := decoded.src1
    score.io.source1 := decoded.src2
    score.io.source2 := Mux(decoded.opcode === AecOpcode.atom && decoded.subop === 7.U, decoded.src2Imm(23, 16), decoded.src3)
    val decodedPair = decoded.dtype === 1.U || decoded.dtype === 9.U
    val decodedCvt = decoded.opcode === AecOpcode.cvtff || decoded.opcode === AecOpcode.cvtfi || decoded.opcode === AecOpcode.cvtif || decoded.opcode === AecOpcode.cvtii
    val decodedCvtSrcPair = decoded.raw(109, 106) === 9.U
    score.io.source0Pair := Mux(decodedCvt, decodedCvtSrcPair, decodedPair)
    score.io.source1Pair := decodedPair && !decodedCvt
    score.io.source2Pair := decodedPair && !decodedCvt
    score.io.reserve.valid := false.B
    score.io.reserve.bits.warp := issueWarp
    score.io.reserve.bits.dest := decoded.dest
    score.io.reserve.bits.destHi := decodedPair || decoded.opcode === AecOpcode.loadi64
    score.io.reserve.bits.predicate := decoded.opcode === AecOpcode.cmpp || (decoded.opcode === AecOpcode.vote && decoded.ext === 1.U)
    score.io.reserve.bits.pred := decoded.dest(2, 0)
    score.io.release.valid := pipeState(s) === pipeWrite && writeLane(s) === 31.U && (!heldPair || writeHiPhase(s))
    score.io.release.bits.warp := heldWarp(s)
    score.io.release.bits.dest := held(s).dest
    score.io.release.bits.destHi := heldPair
    score.io.release.bits.predicate := heldWritesPred
    score.io.release.bits.pred := held(s).dest(2, 0)

    val heldFp32 = fp32Opcode(held(s).opcode) &&
      (held(s).dtype === 8.U || held(s).dtype === 10.U || held(s).dtype === 11.U)
    val heldFp64 = fp32Opcode(held(s).opcode) && held(s).dtype === 9.U
    unit.io.req.valid := pipeState(s) === pipeDispatch && !heldFp32 && !heldFp64 && !heldSfu
    unit.io.req.bits.op := Mux(heldMove, AecOpcode.add, held(s).opcode)
    unit.io.req.bits.dtype := Mux(heldMove, 2.U, held(s).dtype)
    unit.io.req.bits.activeMask := heldExecute(s)
    unit.io.req.bits.dest := held(s).dest
    unit.io.req.bits.predicateSelect := held(s).predicate
    unit.io.req.bits.predicateValues := bank.io.predMask
    for (lane <- 0 until 32) {
      val copySource = operandA(s)(lane)
      val copyValue = MuxLookup(held(s).dtype, copySource, Seq(
        4.U -> Cat(0.U(24.W), copySource(7, 0)),
        5.U -> Cat(Fill(24, copySource(7)), copySource(7, 0)),
        10.U -> Cat(0.U(16.W), copySource(15, 0)),
        11.U -> Cat(0.U(16.W), copySource(15, 0))))
      unit.io.req.bits.a(lane) := Mux(held(s).opcode === AecOpcode.loadi, held(s).immExt,
        Mux(held(s).opcode === AecOpcode.cpy, copyValue, operandA(s)(lane)))
      unit.io.req.bits.b(lane) := Mux(heldMove || heldIsBfx, 0.U, operandB(s)(lane))
      unit.io.req.bits.c(lane) := Mux(heldIsBfx, held(s).src2Imm,
        Mux(heldIsBins, held(s).immExt,
          Mux(heldIsCmpp || held(s).opcode === AecOpcode.cmp, held(s).subop, operandC(s)(lane))))
    }
    unit.io.resp.ready := pipeState(s) === pipeWait
    fp32.io.req.valid := pipeState(s) === pipeDispatch && heldFp32
    fp32.io.req.bits.op := Mux(held(s).opcode === AecOpcode.cmp,
      aec.fp.AecFpOp.cmpBase + held(s).subop,
      Mux(held(s).opcode === AecOpcode.cmpp, aec.fp.AecFpOp.cmppBase + held(s).subop, held(s).opcode))
    fp32.io.req.bits.dtype := held(s).dtype
    fp32.io.req.bits.activeMask := heldExecute(s)
    fp32.io.req.bits.dest := held(s).dest
    fp32.io.req.bits.predicateSelect := held(s).predicate
    fp32.io.req.bits.predicateValues := bank.io.predMask
    for (lane <- 0 until 32) {
      fp32.io.req.bits.a(lane) := operandA(s)(lane)
      fp32.io.req.bits.b(lane) := operandB(s)(lane)
      fp32.io.req.bits.c(lane) := operandC(s)(lane)
    }
    fp32.io.resp.ready := pipeState(s) === pipeWait
    fp64.io.req.valid := pipeState(s) === pipeDispatch && heldFp64
    fp64.io.req.bits.op := Mux(held(s).opcode === AecOpcode.cmp,
      aec.fp.AecFpOp.cmpBase + held(s).subop,
      Mux(held(s).opcode === AecOpcode.cmpp, aec.fp.AecFpOp.cmppBase + held(s).subop, held(s).opcode))
    fp64.io.req.bits.dtype := held(s).dtype
    fp64.io.req.bits.activeMask := heldExecute(s)
    fp64.io.req.bits.dest := held(s).dest
    fp64.io.req.bits.predicateSelect := held(s).predicate
    fp64.io.req.bits.predicateValues := bank.io.predMask
    for (lane <- 0 until 32) {
      fp64.io.req.bits.a(lane) := Cat(operandAHi(s)(lane), operandA(s)(lane))
      fp64.io.req.bits.b(lane) := Cat(operandBHi(s)(lane), operandB(s)(lane))
      fp64.io.req.bits.c(lane) := Cat(operandCHi(s)(lane), operandC(s)(lane))
    }
    fp64.io.resp.ready := pipeState(s) === pipeWait
    sfu.io.req.valid := pipeState(s) === pipeDispatch && heldSfu
    sfu.io.req.bits.op := held(s).opcode
    sfu.io.req.bits.dtype := held(s).dtype
    sfu.io.req.bits.activeMask := heldExecute(s)
    sfu.io.req.bits.dest := held(s).dest
    sfu.io.req.bits.predicateSelect := held(s).predicate
    sfu.io.req.bits.predicateValues := bank.io.predMask
    sfu.io.mode := held(s).subop
    for (lane <- 0 until 32) {
      sfu.io.req.bits.a(lane) := Cat(operandAHi(s)(lane), operandA(s)(lane))
      sfu.io.req.bits.b(lane) := Cat(operandBHi(s)(lane), operandB(s)(lane))
      sfu.io.req.bits.c(lane) := 0.U
    }
    sfu.io.resp.ready := pipeState(s) === pipeWait
    cvt.io.kind := MuxLookup(held(s).opcode, 0.U, Seq(AecOpcode.cvtff -> 0.U, AecOpcode.cvtfi -> 1.U, AecOpcode.cvtif -> 2.U, AecOpcode.cvtii -> 3.U))
    cvt.io.dstType := held(s).dtype; cvt.io.srcType := heldCvtSrc
    cvt.io.in := Cat(operandAHi(s)(cvtLane(s)), operandA(s)(cvtLane(s)))

    lsu.io.start.valid := pipeState(s) === pipeMemStart && heldGmem
    lsu.io.start.bits.warp := heldWarp(s)
    lsu.io.start.bits.load := !heldStore && !heldAtomic
    lsu.io.start.bits.atomic := heldAtomic
    lsu.io.start.bits.atomicOp := held(s).subop
    lsu.io.start.bits.signed := held(s).dtype === 3.U
    lsu.io.start.bits.mask := heldExecute(s)
    for (lane <- 0 until 32) {
      lsu.io.start.bits.address(lane) := operandA(s)(lane)
      lsu.io.start.bits.storeData(lane) := operandB(s)(lane)
      lsu.io.start.bits.compareData(lane) := operandC(s)(lane)
    }
    lsu.io.done.ready := pipeState(s) === pipeMemWait
    localRequestValid(s) := pipeState(s) === pipeMemStart && heldLocalMemory
    localRequests(s).warp := heldWarp(s)
    localRequests(s).space := held(s).ext
    localRequests(s).load := !heldStore && !heldAtomic
    localRequests(s).atomic := heldAtomic
    localRequests(s).atomicOp := held(s).subop
    localRequests(s).signed := held(s).dtype === 3.U
    localRequests(s).width64 := held(s).dtype === 1.U
    localRequests(s).mask := heldExecute(s)
    for (lane <- 0 until 32) {
      localRequests(s).address(lane) := operandA(s)(lane)
      localRequests(s).storeData(lane) := Cat(operandBHi(s)(lane), operandB(s)(lane))
      localRequests(s).compareData(lane) := operandC(s)(lane)
    }

    // Fetch/decode/dispatch.  The predicate mask is read before the issue
    // packet is captured, so a predicate write cannot affect its own guard.
    val guardMask = Mux(decoded.predEn,
      Mux(decoded.predNeg, ~bank.io.predMask, bank.io.predMask), "hffffffff".U)
    val executeMask = activeMask(issueWarp) & guardMask
    val encodingValid = AecValidator.valid(decoded, io.program_instructions)
    val legalInteger = integerOpcode(decoded.opcode) && encodingValid &&
      ((decoded.opcode === AecOpcode.loadi && decoded.dtype === 15.U) ||
       (decoded.opcode === AecOpcode.cpy) ||
       ((decoded.opcode === AecOpcode.sel || decoded.opcode === AecOpcode.pick) && decoded.dtype === 8.U) ||
       (decoded.opcode =/= AecOpcode.loadi && decoded.opcode =/= AecOpcode.cpy &&
         (decoded.dtype === 0.U || decoded.dtype === 2.U || decoded.dtype === 3.U)))
    val legalFp32 = fp32Opcode(decoded.opcode) && encodingValid &&
      (decoded.dtype === 8.U || decoded.dtype === 10.U || decoded.dtype === 11.U)
    val legalFp64 = fp32Opcode(decoded.opcode) && encodingValid && decoded.dtype === 9.U
    val legalGmem = (decoded.opcode === AecOpcode.ld || decoded.opcode === AecOpcode.st) &&
      decoded.ext === AecMemorySpace.gmem && encodingValid &&
      (decoded.dtype === 0.U || decoded.dtype === 2.U || decoded.dtype === 3.U || decoded.dtype === 8.U)
    val legalLocalMemory = (decoded.opcode === AecOpcode.ld || decoded.opcode === AecOpcode.st || decoded.opcode === AecOpcode.ldc) && encodingValid &&
      (decoded.opcode === AecOpcode.ldc || decoded.ext === AecMemorySpace.smem || decoded.ext === AecMemorySpace.lmem || decoded.ext === AecMemorySpace.cmem || decoded.ext === AecMemorySpace.pmem)
    val legalCollective = encodingValid && (decoded.opcode === AecOpcode.shuf || decoded.opcode === AecOpcode.vote || decoded.opcode === AecOpcode.mtch || decoded.opcode === AecOpcode.rdtsc)
    val legalCvt = encodingValid && (decoded.opcode === AecOpcode.cvtff || decoded.opcode === AecOpcode.cvtfi || decoded.opcode === AecOpcode.cvtif || decoded.opcode === AecOpcode.cvtii)
    val legalAtom = encodingValid && decoded.opcode === AecOpcode.atom
    val legalSfu = encodingValid && (decoded.opcode === AecOpcode.div || decoded.opcode === AecOpcode.rcp ||
      decoded.opcode === AecOpcode.rsq || decoded.opcode === AecOpcode.sin || decoded.opcode === AecOpcode.cos ||
      decoded.opcode === AecOpcode.exp || decoded.opcode === AecOpcode.log || decoded.opcode === AecOpcode.sqrt)
    val decodedStore = decoded.opcode === AecOpcode.st
    val canStart = issueValid && (legalInteger || legalFp32 || legalFp64 || legalGmem || legalLocalMemory || legalCollective || legalCvt || legalAtom || legalSfu || (decoded.opcode === AecOpcode.loadi64 && encodingValid)) && score.io.sourcesReady &&
      (decodedStore || score.io.destinationFree)
    val activePred = activeMask(issueWarp) & bank.io.predMask
    val uniformTrue = activePred === activeMask(issueWarp)
    val uniformFalse = activePred === 0.U
    when (issueValid && encodingValid && decoded.opcode === AecOpcode.br) {
      pc(issueWarp) := decoded.immExt; rr(s) := !rr(s)
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.brx) {
      when (uniformTrue || uniformFalse) { pc(issueWarp) := Mux(uniformTrue, decoded.immExt, pc(issueWarp) + 1.U); rr(s) := !rr(s) }
        .otherwise { running := false.B; resultValid := true.B; resultStatus := 2.U }
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.call) {
      when (callDepth(issueWarp) === 32.U) { running := false.B; resultValid := true.B; resultStatus := 2.U }
        .otherwise { callStack(issueWarp)(callDepth(issueWarp)) := pc(issueWarp) + 1.U; callDepth(issueWarp) := callDepth(issueWarp) + 1.U; pc(issueWarp) := decoded.immExt; rr(s) := !rr(s) }
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.ret) {
      when (callDepth(issueWarp) === 0.U) { running := false.B; resultValid := true.B; resultStatus := 2.U }
        .otherwise { callDepth(issueWarp) := callDepth(issueWarp) - 1.U; pc(issueWarp) := callStack(issueWarp)(callDepth(issueWarp) - 1.U); rr(s) := !rr(s) }
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.syncCt) {
      syncArriveValid(s) := true.B; syncArriveWarp(s) := issueWarp; warpState(issueWarp) := 2.U
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.mbar) {
      // Every LSU is instruction-serial, therefore all earlier accesses from
      // this warp have committed before MBAR is decoded.
      pc(issueWarp) := pc(issueWarp) + 1.U; rr(s) := !rr(s)
    }.elsewhen (issueValid && encodingValid && decoded.opcode === AecOpcode.halt) {
      warpState(issueWarp) := 3.U
      rr(s) := !rr(s)
    }.elsewhen (canStart) {
      when (executeMask === 0.U) {
        pc(issueWarp) := pc(issueWarp) + 1.U
        rr(s) := !rr(s)
      }.otherwise {
        score.io.reserve.valid := !decodedStore
        held(s) := decoded
        heldWarp(s) := issueWarp
        heldExecute(s) := executeMask
        heldCommit(s) := executeMask
        readLane(s) := 0.U
        pipeState(s) := pipeReadAB
        warpState(issueWarp) := 2.U
      }
    }.elsewhen (issueValid && !encodingValid) {
      // Malformed encodings are architecturally INVALID and have no side
      // effects.  This is intentionally ahead of every backend selection.
      printf(p"AEC invalid encoding: pc=${pc(issueWarp)} warp=${issueWarp} opcode=0x${Hexadecimal(decoded.opcode)} ctrl=0x${Hexadecimal(decoded.raw(111, 96))} dest=0x${Hexadecimal(decoded.destRaw)} src1=0x${Hexadecimal(decoded.src1Raw)} src2=0x${Hexadecimal(decoded.src2Imm)} ext=0x${Hexadecimal(decoded.immExt)}\\n")
      running := false.B
      resultValid := true.B
      resultStatus := 1.U
    }.elsewhen (issueValid && !(legalInteger || legalFp32 || legalFp64 || legalGmem || legalLocalMemory || legalCollective || legalCvt || legalAtom || legalSfu || (decoded.opcode === AecOpcode.loadi64 && encodingValid))) {
      // Any other legal instruction reaching an unconnected backend is also a
      // hard integration failure.  It must never be reported as INVALID.
      unsupportedTrap := true.B
      unsupportedPc := pc(issueWarp); unsupportedWarp := issueWarp
      unsupportedOpcode := decoded.opcode; unsupportedDtype := decoded.dtype
    }

    when (bank.io.read.fire) { readLane(s) := readLane(s) + 1.U }
    when (bank.io.response.fire && pipeState(s) === pipeReadAB) {
      operandA(s)(bank.io.response.bits.tag) := bank.io.response.bits.data1
      operandB(s)(bank.io.response.bits.tag) := bank.io.response.bits.data2
      when (bank.io.response.bits.tag === 31.U) {
        readLane(s) := 0.U
        pipeState(s) := pipeReadC
      }
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadC) {
      operandC(s)(bank.io.response.bits.tag) := bank.io.response.bits.data1
      when (bank.io.response.bits.tag === 31.U) {
        when (held(s).opcode === AecOpcode.shuf) {
          val participants = heldExecute(s) & held(s).immExt
          heldCommit(s) := participants
          val shufValue = held(s).src2Imm(4, 0)
          for (lane <- 0 until 32) {
            val source = MuxLookup(held(s).subop, shufValue, Seq(
              0.U -> shufValue,
              1.U -> (lane.U(6.W) - shufValue),
              2.U -> (lane.U(6.W) + shufValue),
              3.U -> (lane.U(6.W) ^ shufValue)))
            val sourceInRange = source < 32.U && participants(source(4, 0))
            writeData(s)(lane) := Mux(participants(lane), Mux(sourceInRange, operandA(s)(source(4, 0)), operandA(s)(lane)), 0.U)
          }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.elsewhen (held(s).opcode === AecOpcode.vote) {
          val active = heldExecute(s)
          val voteAll = ((~active) | bank.io.predMask).andR
          val voteAny = (active & bank.io.predMask).orR
          val voteUni = !(active & bank.io.predMask).orR || !((active & ~bank.io.predMask).orR)
          val voteResult = MuxLookup(held(s).subop, voteAll, Seq(0.U -> voteAll, 1.U -> voteAny, 2.U -> voteUni))
          for (lane <- 0 until 32) { writeData(s)(lane) := voteResult }
          writePredicates(s) := Fill(32, voteResult)
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.elsewhen (held(s).opcode === AecOpcode.mtch) {
          for (lane <- 0 until 32) {
            val matchBits = VecInit((0 until 32).map(other => heldExecute(s)(other) && operandA(s)(other) === operandA(s)(lane))).asUInt
            writeData(s)(lane) := matchBits
          }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.elsewhen (held(s).opcode === AecOpcode.rdtsc) {
          for (lane <- 0 until 32) { writeData(s)(lane) := cycles(31, 0) }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.elsewhen (heldLoadi64) {
          for (lane <- 0 until 32) {
            writeData(s)(lane) := held(s).immExt
            writeHiData(s)(lane) := held(s).src2Imm
          }
          writeLane(s) := 0.U
          writeHiPhase(s) := false.B
          pipeState(s) := pipeWrite
        }.elsewhen (heldNeedsPairRead) {
          readLane(s) := 0.U
          pipeState(s) := pipeReadAHi
        }.otherwise {
          pipeState(s) := Mux(heldCvt || heldSpecialCpy, pipeCvt, Mux(heldMemory, pipeMemStart, pipeDispatch))
          when (heldCvt || heldSpecialCpy) { cvtLane(s) := 0.U }
        }
      }
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadAHi) {
      operandAHi(s)(bank.io.response.bits.tag) := bank.io.response.bits.data1
      when (bank.io.response.bits.tag === 31.U) { readLane(s) := 0.U; pipeState(s) := pipeReadBHi }
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadBHi) {
      operandBHi(s)(bank.io.response.bits.tag) := bank.io.response.bits.data1
      when (bank.io.response.bits.tag === 31.U) { readLane(s) := 0.U; pipeState(s) := pipeReadCHi }
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadCHi) {
      operandCHi(s)(bank.io.response.bits.tag) := bank.io.response.bits.data1
      when (bank.io.response.bits.tag === 31.U) {
        when (held(s).opcode === AecOpcode.cpy) {
          for (lane <- 0 until 32) {
            writeData(s)(lane) := operandA(s)(lane)
            writeHiData(s)(lane) := operandAHi(s)(lane)
          }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.otherwise { pipeState(s) := Mux(heldCvt, pipeCvt, pipeDispatch); cvtLane(s) := 0.U }
      }
    }
    when (unit.io.req.fire || fp32.io.req.fire || fp64.io.req.fire || sfu.io.req.fire) { pipeState(s) := pipeWait }
    when (pipeState(s) === pipeCvt) {
      val linearTid = (heldWarp(s) << 5) + cvtLane(s)
      val tidX = linearTid % launchBlockX
      val tidY = (linearTid / launchBlockX) % launchBlockY
      val tidZ = linearTid / (launchBlockX * launchBlockY)
      val special = MuxLookup(held(s).src1Raw, 0.U(32.W), Seq(
        "h0100".U -> tidX, "h0101".U -> launchBlockX, "h0102".U -> ctaX, "h0103".U -> launchGridX,
        "h0104".U -> cvtLane(s),
        "h0110".U -> tidY, "h0111".U -> launchBlockY, "h0112".U -> ctaY, "h0113".U -> launchGridY,
        "h0120".U -> tidZ, "h0121".U -> launchBlockZ, "h0122".U -> ctaZ, "h0123".U -> launchGridZ))
      writeData(s)(cvtLane(s)) := Mux(heldSpecialCpy, special, cvt.io.out(31, 0))
      writeHiData(s)(cvtLane(s)) := Mux(heldSpecialCpy, 0.U, cvt.io.out(63, 32))
      when (cvtLane(s) === 31.U) { writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite }
        .otherwise { cvtLane(s) := cvtLane(s) + 1.U }
    }
    when (unit.io.resp.fire) {
      when (unit.io.resp.bits.errorMask.orR) {
        running := false.B
        resultValid := true.B
        resultStatus := 2.U
      }.otherwise {
        for (lane <- 0 until 32) { writeData(s)(lane) := unit.io.resp.bits.result(lane)(31, 0) }
        writePredicates(s) := unit.io.resp.bits.predicateMask
        writeLane(s) := 0.U
        writeHiPhase(s) := false.B
        pipeState(s) := pipeWrite
      }
    }
    when (fp32.io.resp.fire) {
      when (fp32.io.resp.bits.errorMask.orR) {
        running := false.B
        resultValid := true.B
        resultStatus := 2.U
      }.otherwise {
        for (lane <- 0 until 32) { writeData(s)(lane) := fp32.io.resp.bits.result(lane)(31, 0) }
        writePredicates(s) := fp32.io.resp.bits.predicateMask
        writeLane(s) := 0.U
        writeHiPhase(s) := false.B
        pipeState(s) := pipeWrite
      }
    }
    when (fp64.io.resp.fire) {
      when (fp64.io.resp.bits.errorMask.orR) {
        running := false.B
        resultValid := true.B
        resultStatus := 2.U
      }.otherwise {
        for (lane <- 0 until 32) {
          writeData(s)(lane) := fp64.io.resp.bits.result(lane)(31, 0)
          writeHiData(s)(lane) := fp64.io.resp.bits.result(lane)(63, 32)
        }
        writePredicates(s) := fp64.io.resp.bits.predicateMask
        writeLane(s) := 0.U
        writeHiPhase(s) := false.B
        pipeState(s) := pipeWrite
      }
    }
    when (sfu.io.resp.fire) {
      when (sfu.io.resp.bits.errorMask.orR) {
        running := false.B
        resultValid := true.B
        resultStatus := 2.U
      }.otherwise {
        for (lane <- 0 until 32) {
          writeData(s)(lane) := sfu.io.resp.bits.result(lane)(31, 0)
          writeHiData(s)(lane) := sfu.io.resp.bits.result(lane)(63, 32)
        }
        writeLane(s) := 0.U
        writeHiPhase(s) := false.B
        pipeState(s) := pipeWrite
      }
    }
    when (lsu.io.start.fire) { pipeState(s) := pipeMemWait }
    when (lsu.io.done.fire) {
      when (lsu.io.done.bits.error) {
        running := false.B
        resultValid := true.B
        resultStatus := 2.U
        }.elsewhen (heldStore) {
        pc(heldWarp(s)) := pc(heldWarp(s)) + 1.U
        warpState(heldWarp(s)) := 1.U
        rr(s) := !rr(s)
        pipeState(s) := pipeIdle
      }.otherwise {
        for (lane <- 0 until 32) { writeData(s)(lane) := lsu.io.done.bits.loadData(lane) }
        writeLane(s) := 0.U
        writeHiPhase(s) := false.B
        pipeState(s) := pipeWrite
      }
    }
    when (pipeState(s) === pipeWrite && writeLane(s) === 31.U && heldPair && !writeHiPhase(s)) {
      writeLane(s) := 0.U
      writeHiPhase(s) := true.B
    }.elsewhen (pipeState(s) === pipeWrite && writeLane(s) === 31.U) {
      pc(heldWarp(s)) := pc(heldWarp(s)) + 1.U
      warpState(heldWarp(s)) := 1.U
      rr(s) := !rr(s)
      writeHiPhase(s) := false.B
      pipeState(s) := pipeIdle
    }.elsewhen (pipeState(s) === pipeWrite) {
      writeLane(s) := writeLane(s) + 1.U
    }
  }

  // The resident memory arrays are shared by all four scheduler partitions.
  // Arbitration is deliberately conservative: a local operation is an
  // instruction-level transaction, so no second partition can observe a
  // partially completed misaligned store.
  val localSelect = PriorityEncoder(localRequestValid.asUInt)
  localLsu.io.start.valid := localRequestValid.asUInt.orR
  localLsu.io.start.bits := Mux1H((0 until 4).map(i => (localSelect === i.U) -> localRequests(i)))
  when (localLsu.io.start.fire) {
    for (s <- 0 until 4) { when (localSelect === s.U) { pipeState(s) := pipeMemWait } }
  }
  val localWait = VecInit((0 until 4).map(i => pipeState(i) === pipeMemWait &&
    (held(i).opcode === AecOpcode.ld || held(i).opcode === AecOpcode.st || held(i).opcode === AecOpcode.ldc || held(i).opcode === AecOpcode.atom) &&
    held(i).ext =/= AecMemorySpace.gmem)).asUInt
  localLsu.io.done.ready := localWait.orR
  when (localLsu.io.done.fire) {
    val owner = PriorityEncoder(localWait)
    for (s <- 0 until 4) {
      when (owner === s.U) {
      when (localLsu.io.done.bits.error) {
          running := false.B; resultValid := true.B; resultStatus := 2.U
        }.elsewhen (held(s).opcode === AecOpcode.st) {
          pc(heldWarp(s)) := pc(heldWarp(s)) + 1.U
          warpState(heldWarp(s)) := 1.U; rr(s) := !rr(s); pipeState(s) := pipeIdle
        }.otherwise {
          for (lane <- 0 until 32) {
            writeData(s)(lane) := localLsu.io.done.bits.loadData(lane)(31, 0)
            writeHiData(s)(lane) := localLsu.io.done.bits.loadData(lane)(63, 32)
          }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }
      }
    }
  }

  when (unsupportedTrap) {
    printf(p"AEC unsupported legal instruction: pc=${unsupportedPc} warp=${unsupportedWarp} opcode=0x${Hexadecimal(unsupportedOpcode)} dtype=${unsupportedDtype}\\n")
    // Delay the assertion one edge so the diagnostic above is guaranteed to
    // reach the simulator log even in simulators that prioritize assertions.
    unsupportedAssert := true.B
  }
  assert(!unsupportedAssert, "AEC legal instruction is unsupported")

  barrier.io.activeWarps := VecInit((0 until 8).map(w => activeMask(w).orR)).asUInt
  barrier.io.completed := VecInit((0 until 8).map(w => warpState(w) === 3.U)).asUInt
  val syncSelect = PriorityEncoder(syncArriveValid.asUInt)
  barrier.io.arrive.valid := syncArriveValid.asUInt.orR
  barrier.io.arrive.bits := Mux1H((0 until 4).map(i => (syncSelect === i.U) -> syncArriveWarp(i)))
  when (barrier.io.duplicate) { running := false.B; resultValid := true.B; resultStatus := 2.U }
  when (barrier.io.release.orR) {
    for (w <- 0 until 8) {
      when (barrier.io.release(w)) { pc(w) := pc(w) + 1.U; warpState(w) := 1.U }
    }
  }
  // Once an atomic issues its first external transaction, retain exclusive
  // ownership through its read/modify/write sequence.  This serializes atomic
  // operations across all warp partitions while leaving ordinary LSU traffic
  // on the existing arbiter.
  val atomicLock = RegInit(false.B)
  val atomicOwner = RegInit(0.U(2.W))
  val lsuRequests = VecInit(gmemLsus.map(_.io.lineOut.valid)).asUInt
  val lockedRequests = lsuRequests & UIntToOH(atomicOwner, 4)
  val eligibleLsuRequests = Mux(atomicLock, lockedRequests, lsuRequests)
  val lsuSelect = PriorityEncoder(eligibleLsuRequests)
  external.io.lineIn.valid := eligibleLsuRequests.orR
  external.io.lineIn.bits := Mux1H((0 until 4).map(i => (lsuSelect === i.U) -> gmemLsus(i).io.lineOut.bits))
  for (s <- 0 until 4) {
    gmemLsus(s).io.lineOut.ready := external.io.lineIn.ready && external.io.lineIn.valid && lsuSelect === s.U
    gmemLsus(s).io.lineComplete.valid := external.io.lineComplete.valid && external.io.lineComplete.bits.warp(2, 1) === s.U
    gmemLsus(s).io.lineComplete.bits := external.io.lineComplete.bits
  }
  val selectedAtomic = Mux1H((0 until 4).map(i => (lsuSelect === i.U) -> (held(i).opcode === AecOpcode.atom)))
  when (external.io.lineIn.fire && !atomicLock && selectedAtomic) {
    atomicLock := true.B
    atomicOwner := lsuSelect
  }
  for (s <- 0 until 4) {
    when (atomicLock && atomicOwner === s.U && gmemLsus(s).io.done.fire) { atomicLock := false.B }
  }
  external.io.lineComplete.ready := MuxLookup(external.io.lineComplete.bits.warp(2, 1), false.B,
    (0 until 4).map(i => i.U -> gmemLsus(i).io.lineComplete.ready))
  external.io.memReqReady := io.mem_req_ready
  external.io.memRspValid := io.mem_rsp_valid
  external.io.memRspRdata := io.mem_rsp_rdata
  external.io.memRspTag := io.mem_rsp_tag
  external.io.memRspError := io.mem_rsp_error
  io.mem_req_valid := external.io.memReqValid
  io.mem_req_write := external.io.memReqWrite
  io.mem_req_addr := external.io.memReqAddr
  io.mem_req_wdata := external.io.memReqWdata
  io.mem_req_wstrb := external.io.memReqWstrb
  io.mem_req_tag := external.io.memReqTag
  io.mem_rsp_ready := external.io.memRspReady

  val allDone = VecInit((0 until 8).map(w => warpState(w) === 3.U)).asUInt.andR
  when (running && allDone && external.io.outstanding === 0.U) {
    when (ctaX + 1.U < launchGridX) { ctaX := ctaX + 1.U; restartCta := true.B }
      .elsewhen (ctaY + 1.U < launchGridY) { ctaX := 0.U; ctaY := ctaY + 1.U; restartCta := true.B }
      .elsewhen (ctaZ + 1.U < launchGridZ) { ctaX := 0.U; ctaY := 0.U; ctaZ := ctaZ + 1.U; restartCta := true.B }
      .otherwise { running := false.B; resultValid := true.B; resultStatus := 0.U }
  }
  io.result_valid := resultValid
  io.result_status := resultStatus
  io.result_cycles := cycles
  when (resultValid && io.result_ready) { resultValid := false.B; loadError := false.B }

  // GMEM is owned by the external harness memory model.  The ABI readback
  // pins remain present, but correctness runners dump that authoritative
  // backing store after completing the result handshake; no incomplete GMEM
  // mirror is synthesized into the core.
  io.read_ready := false.B
  io.read_data_valid := false.B
  io.read_data := 0.U
}

object GenerateEvalTop extends App {
  (new chisel3.stage.ChiselStage).emitSystemVerilog(new AecEvalTop, Array("--target-dir", "sv/generated/eval"))
}
