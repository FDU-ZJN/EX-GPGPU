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
    val mem_req_space = Output(Bool()); val mem_req_write = Output(Bool()); val mem_req_addr = Output(UInt(32.W))
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
  val abortPending = RegInit(false.B)
  val abortStatus = RegInit(2.U(3.W))
  val softReset = WireDefault(resultValid && io.result_ready)
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
  val warpEpoch = RegInit(VecInit(Seq.fill(8)(0.U(8.W))))
  val warpState = RegInit(VecInit(Seq.fill(8)(0.U(3.W)))) // 0 idle, 1 runnable, 2 blocked, 3 done
  val activeMask = RegInit(VecInit(Seq.fill(8)(0.U(32.W))))
  val callDepth = RegInit(VecInit(Seq.fill(8)(0.U(6.W))))
  val callStack = Reg(Vec(8, Vec(32, UInt(32.W))))
  val rr = RegInit(VecInit(Seq.fill(4)(false.B)))
  val barrier = withReset(reset.asBool || softReset) { Module(new AecCtaBarrier) }
  val external = withReset(reset.asBool || softReset) { Module(new AecExternalMemoryEngine) }
  val localLsu = withReset(reset.asBool || softReset) { Module(new AecLocalLsu) }
  localLsu.io.clearSmem := false.B
  localLsu.io.preload.valid := false.B
  localLsu.io.preload.bits := 0.U.asTypeOf(localLsu.io.preload.bits)

  // Loading is intentionally allowed only before launch.  The fixed local
  // apertures make an invalid preload visible at launch instead of silently
  // truncating a testcase image.
  val localLoadTarget = io.load_target === 2.U || io.load_target === 3.U
  io.load_ready := !running && !resultValid && (!localLoadTarget || localLsu.io.preload.ready)
  val loadFire = io.load_valid && io.load_ready
  val localLoadOutOfRange = VecInit((0 until 16).map(i => io.load_strb(i) &&
    (io.load_addr +& i.U) >= 65536.U)).asUInt.orR
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
      when (io.load_addr(31, 16).orR || localLoadOutOfRange) { loadError := true.B }
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
  val gridCtasWide = io.grid_x * io.grid_y * io.grid_z
  val gridThreadsWide = gridCtasWide * totalThreads
  val launchBad = totalThreads === 0.U || totalThreads > 256.U || io.grid_x === 0.U || io.grid_y === 0.U || io.grid_z === 0.U ||
    gridThreadsWide > (1 << 20).U || io.program_instructions === 0.U || io.program_instructions > AecFrontendConfig.ImemWords.U || loadError
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
          warpEpoch(w) := 0.U
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
      warpEpoch(w) := warpEpoch(w) + 1.U
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
  val regBanks = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecRegBank) })
  val scoreboards = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecScoreboard) })
  // Four partitions: 4x16 INT32, 4x16 FP32, and 4x2 FP64 lanes.
  val intUnits = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecEightLaneIntUnit(16)) })
  // FP32/F16/BF16 execution is a real backend, not a decode placeholder.
  // FP64 is added with pair retirement in the next datapath stage.
  val fp32Units = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecFp32Unit(16)) })
  val fp64Units = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecFp64Unit(2)) })
  val sfuUnits = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecSfuWarpUnit(4)) })
  val cvtUnits = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecConvertLane) })
  val gmemLsus = Seq.fill(4)(withReset(reset.asBool || softReset) { Module(new AecGmemLsu) })
  val robs = Seq.tabulate(8)(w => withReset(reset.asBool || softReset || restartCta) { Module(new AecWarpRob(w)) })
  for (rob <- robs) {
    rob.io.allocate.valid := false.B
    rob.io.allocate.bits := 0.U.asTypeOf(rob.io.allocate.bits)
    rob.io.completion.valid := false.B
    rob.io.completion.bits := 0.U.asTypeOf(rob.io.completion.bits)
    rob.io.pop := false.B
    rob.io.flush := false.B
  }
  val pipeIdle :: pipeReadA :: pipeReadB :: pipeReadC :: pipeReadAHi :: pipeReadBHi :: pipeReadCHi :: pipeDispatch :: pipeWait :: pipeMemStart :: pipeMemWait :: pipeCvt :: pipeMatch :: pipeWrite :: Nil = Enum(14)
  val pipeState = Seq.fill(4)(RegInit(pipeIdle))
  val held = Seq.fill(4)(Reg(new AecDecodedInstruction))
  val heldWarp = Seq.fill(4)(Reg(UInt(3.W)))
  val heldTag = Seq.fill(4)(Reg(new AecInstructionTag))
  val intTag = Seq.fill(4)(Reg(new AecInstructionTag))
  val fp32Tag = Seq.fill(4)(Reg(new AecInstructionTag))
  val fp64Tag = Seq.fill(4)(Reg(new AecInstructionTag))
  val sfuTag = Seq.fill(4)(Reg(new AecInstructionTag))
  val gmemTag = Seq.fill(4)(Reg(new AecInstructionTag))
  val gmemAtomic = RegInit(VecInit(Seq.fill(4)(false.B)))
  val localTag = Seq.fill(4)(Reg(new AecInstructionTag))
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
  val matchLane = Seq.fill(4)(RegInit(0.U(5.W)))
  val localRequests = Wire(Vec(4, new AecLocalMemoryRequest))
  val localRequestValid = Wire(Vec(4, Bool()))
  val syncArriveValid = Wire(Vec(4, Bool()))
  val syncArriveWarp = Wire(Vec(4, UInt(3.W)))
  val coordRequest = Wire(Vec(4, Bool()))
  val completionCandidates = Wire(Vec(4, Vec(7, Valid(new AecRobCompletion))))
  val completionGrant = Wire(Vec(4, UInt(3.W)))
  val completionAny = Wire(Vec(4, Bool()))
  for (s <- 0 until 4; source <- 0 until 7) {
    completionCandidates(s)(source).valid := false.B
    completionCandidates(s)(source).bits := 0.U.asTypeOf(completionCandidates(s)(source).bits)
  }
  for (s <- 0 until 4) {
    completionAny(s) := completionCandidates(s).map(_.valid).reduce(_ || _)
    completionGrant(s) := PriorityEncoder(VecInit(completionCandidates(s).map(_.valid)).asUInt)
  }

  // One in-order architectural commit port per partition.  A 64-bit result
  // locks the selected warp for its high-word cycle so the register pair is
  // never observed half-retired.
  val commitRr = RegInit(VecInit(Seq.fill(4)(false.B)))
  val commitPairHigh = RegInit(VecInit(Seq.fill(4)(false.B)))
  val commitLockedWarp = Reg(Vec(4, UInt(1.W)))
  val commitSelect = Wire(Vec(4, UInt(1.W)))
  val commitHead = Wire(Vec(4, new AecRobHead))
  val commitValid = Wire(Vec(4, Bool()))
  val commitFinal = Wire(Vec(4, Bool()))

  for (s <- 0 until 4) {
    val loReady = robs(s * 2).io.head.valid
    val hiReady = robs(s * 2 + 1).io.head.valid
    val selectedLocal = Mux(commitRr(s), Mux(hiReady, 1.U, 0.U), Mux(loReady, 0.U, 1.U))
    commitSelect(s) := Mux(commitPairHigh(s), commitLockedWarp(s), selectedLocal)
    commitHead(s) := Mux(commitSelect(s) === 0.U, robs(s * 2).io.head.bits, robs(s * 2 + 1).io.head.bits)
    commitValid(s) := Mux(commitSelect(s) === 0.U, loReady, hiReady)
    commitFinal(s) := commitValid(s) && (!commitHead(s).writeHi || commitPairHigh(s))

    when (commitValid(s) && commitHead(s).writeHi && !commitPairHigh(s) && !commitHead(s).error) {
      commitPairHigh(s) := true.B
      commitLockedWarp(s) := commitSelect(s)
    }.elsewhen (commitFinal(s)) {
      commitPairHigh(s) := false.B
      commitRr(s) := !commitSelect(s)
      when (commitSelect(s) === 0.U) { robs(s * 2).io.pop := !commitHead(s).error }
        .otherwise { robs(s * 2 + 1).io.pop := !commitHead(s).error }
      when (commitHead(s).serializing && !commitHead(s).error) {
        warpState(commitHead(s).tag.warp) := 1.U
      }
      when (commitHead(s).error) {
        running := false.B
        abortPending := true.B
        abortStatus := 2.U
        for (w <- 0 until 8) {
          warpEpoch(w) := warpEpoch(w) + 1.U
          robs(w).io.flush := true.B
        }
      }
    }

    // Preserve the existing architectural trace contract: side-effect-only
    // stores retire internally but do not create a register retirement event.
    io.debug_commit_valid(s) := commitFinal(s) && !commitHead(s).error &&
      (commitHead(s).writesGpr || commitHead(s).writesPredicate)
    io.debug_commit_cta_x(s) := ctaX
    io.debug_commit_cta_y(s) := ctaY
    io.debug_commit_cta_z(s) := ctaZ
    io.debug_commit_warp(s) := commitHead(s).tag.warp
    io.debug_commit_pc(s) := commitHead(s).tag.pc
    io.debug_commit_instruction(s) := commitHead(s).instruction
    io.debug_commit_execute_mask(s) := commitHead(s).laneMask
    io.debug_commit_dest(s) := commitHead(s).dest
    io.debug_commit_lane_mask(s) := commitHead(s).laneMask
    io.debug_commit_data(s) := Cat(commitHead(s).data.map(_(31, 0)).reverse)
    io.debug_commit_predicate_valid(s) := commitFinal(s) && commitHead(s).writesPredicate && !commitHead(s).error
    io.debug_commit_predicate(s) := commitHead(s).predicate
    io.debug_commit_predicate_data(s) := commitHead(s).predicateData
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
    val fetchRequest = running && !localLsu.io.clearBusy && selectedValid(s) && !fetchPending(s)
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
    val heldExternalMemory = heldMemory && (held(s).ext === AecMemorySpace.gmem || held(s).ext === AecMemorySpace.lmem)
    val heldLocalMemory = heldMemory && held(s).ext =/= AecMemorySpace.gmem && held(s).ext =/= AecMemorySpace.lmem
    val lsu = gmemLsus(s)
    syncArriveValid(s) := false.B
    syncArriveWarp(s) := issueWarp
    coordRequest(s) := false.B

    bank.io.clear := (io.launch_valid && io.launch_ready && !launchBad) || restartCta
    bank.io.read.valid := pipeState(s) === pipeReadA || pipeState(s) === pipeReadB || pipeState(s) === pipeReadC || pipeState(s) === pipeReadAHi || pipeState(s) === pipeReadBHi || pipeState(s) === pipeReadCHi
    bank.io.read.bits.warpLocal := heldWarp(s)(0)
    bank.io.read.bits.reg := MuxLookup(pipeState(s), held(s).src1, Seq(
      pipeReadB -> held(s).src2,
      pipeReadC -> Mux(heldAtomicCas, held(s).src2Imm(23, 16), held(s).src3),
      pipeReadAHi -> (held(s).src1 + 1.U),
      pipeReadBHi -> (held(s).src2 + 1.U),
      pipeReadCHi -> (held(s).src3 + 1.U)))
    bank.io.read.bits.tag := pipeState(s)(2, 0)
    bank.io.response.ready := true.B
    bank.io.writeValid := commitValid(s) && commitHead(s).writesGpr && !commitHead(s).error
    bank.io.writeWarpLocal := commitHead(s).tag.warp(0)
    bank.io.writeReg := Mux(commitHead(s).writeHi && commitPairHigh(s), commitHead(s).dest + 1.U, commitHead(s).dest)
    bank.io.writeData := VecInit(commitHead(s).data.map(lane =>
      Mux(commitHead(s).writeHi && commitPairHigh(s), lane(63, 32), lane(31, 0))))
    bank.io.writeMask := commitHead(s).laneMask
    bank.io.predWriteValid := commitValid(s) && commitHead(s).writesPredicate && !commitHead(s).error
    bank.io.predWarpLocal := commitHead(s).tag.warp(0)
    bank.io.predIndex := commitHead(s).predicate
    bank.io.predData := commitHead(s).predicateData
    bank.io.predWriteMask := commitHead(s).laneMask
    bank.io.predReadWarpLocal := Mux(pipeState(s) === pipeIdle, issueWarp(0), heldWarp(s)(0))
    bank.io.predReadIndex := Mux(pipeState(s) === pipeIdle, decoded.predicate,
      Mux(held(s).opcode === AecOpcode.vote, held(s).src1(2, 0), held(s).predicate))

    score.io.sourceWarp := issueWarp
    score.io.source0 := decoded.src1
    score.io.source1 := decoded.src2
    score.io.source2 := Mux(decoded.opcode === AecOpcode.atom && decoded.subop === 7.U, decoded.src2Imm(23, 16), decoded.src3)
    score.io.source0Used := AecInstructionTraits.usesSrc0(decoded)
    score.io.source1Used := AecInstructionTraits.usesSrc1(decoded)
    score.io.source2Used := AecInstructionTraits.usesSrc2(decoded)
    score.io.sourcePredicateUsed := AecInstructionTraits.usesGuardPredicate(decoded)
    score.io.sourcePredicate := AecInstructionTraits.sourcePredicate(decoded)
    val decodedPair = decoded.dtype === 1.U || decoded.dtype === 9.U
    val decodedCvt = decoded.opcode === AecOpcode.cvtff || decoded.opcode === AecOpcode.cvtfi || decoded.opcode === AecOpcode.cvtif || decoded.opcode === AecOpcode.cvtii
    val decodedCvtSrcPair = decoded.raw(109, 106) === 9.U
    score.io.source0Pair := Mux(decodedCvt, decodedCvtSrcPair, decodedPair)
    score.io.source1Pair := decodedPair && !decodedCvt
    score.io.source2Pair := decodedPair && !decodedCvt
    // A GPR source is only consumed by lanes that will execute this
    // instruction.  Predicate selection, however, must be stable for every
    // active lane before it can safely form that execution mask.
    val guardMask = Mux(decoded.predEn,
      Mux(decoded.predNeg, ~bank.io.predMask, bank.io.predMask), "hffffffff".U)
    val executeMask = activeMask(issueWarp) & guardMask
    score.io.sourceMask := executeMask
    score.io.sourcePredicateMask := activeMask(issueWarp)
    score.io.reserve.valid := false.B
    score.io.reserve.bits.warp := issueWarp
    score.io.reserve.bits.dest := decoded.dest
    score.io.reserve.bits.destHi := decodedPair || decoded.opcode === AecOpcode.loadi64
    score.io.reserve.bits.predicate := decoded.opcode === AecOpcode.cmpp || (decoded.opcode === AecOpcode.vote && decoded.ext === 1.U)
    score.io.reserve.bits.pred := decoded.dest(2, 0)
    score.io.release.valid := commitFinal(s) && !commitHead(s).error &&
      (commitHead(s).writesGpr || commitHead(s).writesPredicate)
    score.io.release.bits.warp := commitHead(s).tag.warp
    score.io.release.bits.dest := commitHead(s).dest
    score.io.release.bits.destHi := commitHead(s).writeHi
    score.io.release.bits.predicate := commitHead(s).writesPredicate
    score.io.release.bits.pred := commitHead(s).predicate
    // SHUF writes only participating lanes, so reserving its full execute
    // mask would create a false WAW dependency for excluded lanes.
    score.io.reserve.bits.laneMask := Mux(decoded.opcode === AecOpcode.shuf, executeMask & decoded.immExt, executeMask)
    score.io.release.bits.laneMask := commitHead(s).laneMask

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
    completionCandidates(s)(0).valid := unit.io.resp.valid
    completionCandidates(s)(0).bits.tag := intTag(s)
    completionCandidates(s)(0).bits.data := unit.io.resp.bits.result
    completionCandidates(s)(0).bits.predicateData := unit.io.resp.bits.predicateMask
    completionCandidates(s)(0).bits.error := unit.io.resp.bits.errorMask.orR
    unit.io.resp.ready := completionAny(s) && completionGrant(s) === 0.U
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
    completionCandidates(s)(1).valid := fp32.io.resp.valid
    completionCandidates(s)(1).bits.tag := fp32Tag(s)
    completionCandidates(s)(1).bits.data := fp32.io.resp.bits.result
    completionCandidates(s)(1).bits.predicateData := fp32.io.resp.bits.predicateMask
    completionCandidates(s)(1).bits.error := fp32.io.resp.bits.errorMask.orR
    fp32.io.resp.ready := completionAny(s) && completionGrant(s) === 1.U
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
    completionCandidates(s)(2).valid := fp64.io.resp.valid
    completionCandidates(s)(2).bits.tag := fp64Tag(s)
    completionCandidates(s)(2).bits.data := fp64.io.resp.bits.result
    completionCandidates(s)(2).bits.predicateData := fp64.io.resp.bits.predicateMask
    completionCandidates(s)(2).bits.error := fp64.io.resp.bits.errorMask.orR
    fp64.io.resp.ready := completionAny(s) && completionGrant(s) === 2.U
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
    completionCandidates(s)(3).valid := sfu.io.resp.valid
    completionCandidates(s)(3).bits.tag := sfuTag(s)
    completionCandidates(s)(3).bits.data := sfu.io.resp.bits.result
    completionCandidates(s)(3).bits.predicateData := sfu.io.resp.bits.predicateMask
    completionCandidates(s)(3).bits.error := sfu.io.resp.bits.errorMask.orR
    sfu.io.resp.ready := completionAny(s) && completionGrant(s) === 3.U
    cvt.io.kind := MuxLookup(held(s).opcode, 0.U, Seq(AecOpcode.cvtff -> 0.U, AecOpcode.cvtfi -> 1.U, AecOpcode.cvtif -> 2.U, AecOpcode.cvtii -> 3.U))
    cvt.io.dstType := held(s).dtype; cvt.io.srcType := heldCvtSrc
    cvt.io.in := Cat(operandAHi(s)(cvtLane(s)), operandA(s)(cvtLane(s)))

    val ctaLinearWide = ctaX +& launchGridX * (ctaY +& launchGridY * ctaZ)
    val ctaThreadBaseWide = ctaLinearWide * launchThreads
    lsu.io.start.valid := pipeState(s) === pipeMemStart && heldExternalMemory
    lsu.io.start.bits.space := held(s).ext === AecMemorySpace.lmem
    lsu.io.start.bits.ctaThreadBase := ctaThreadBaseWide(19, 0)
    lsu.io.start.bits.warp := heldWarp(s)
    lsu.io.start.bits.load := !heldStore && !heldAtomic
    lsu.io.start.bits.width64 := held(s).dtype === 1.U
    lsu.io.start.bits.atomic := heldAtomic
    lsu.io.start.bits.atomicOp := held(s).subop
    lsu.io.start.bits.signed := held(s).dtype === 3.U
    lsu.io.start.bits.mask := heldExecute(s)
    for (lane <- 0 until 32) {
      lsu.io.start.bits.address(lane) := operandA(s)(lane)
      lsu.io.start.bits.storeData(lane) := operandB(s)(lane)
      lsu.io.start.bits.compareData(lane) := operandC(s)(lane)
    }
    completionCandidates(s)(4).valid := lsu.io.done.valid
    completionCandidates(s)(4).bits.tag := gmemTag(s)
    completionCandidates(s)(4).bits.data := lsu.io.done.bits.loadData
    completionCandidates(s)(4).bits.predicateData := 0.U
    completionCandidates(s)(4).bits.error := lsu.io.done.bits.error
    lsu.io.done.ready := completionAny(s) && completionGrant(s) === 4.U
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
      (decoded.ext === AecMemorySpace.gmem || decoded.ext === AecMemorySpace.lmem) && encodingValid &&
      (decoded.dtype === 0.U || decoded.dtype === 2.U || decoded.dtype === 3.U || decoded.dtype === 8.U ||
        (decoded.opcode === AecOpcode.ld && decoded.dtype === 1.U))
    val legalLocalMemory = (decoded.opcode === AecOpcode.ld || decoded.opcode === AecOpcode.st || decoded.opcode === AecOpcode.ldc) && encodingValid &&
      (decoded.opcode === AecOpcode.ldc || decoded.ext === AecMemorySpace.smem || decoded.ext === AecMemorySpace.cmem || decoded.ext === AecMemorySpace.pmem)
    val legalCollective = encodingValid && (decoded.opcode === AecOpcode.shuf || decoded.opcode === AecOpcode.vote || decoded.opcode === AecOpcode.mtch || decoded.opcode === AecOpcode.rdtsc)
    val legalCvt = encodingValid && (decoded.opcode === AecOpcode.cvtff || decoded.opcode === AecOpcode.cvtfi || decoded.opcode === AecOpcode.cvtif || decoded.opcode === AecOpcode.cvtii)
    val legalAtom = encodingValid && decoded.opcode === AecOpcode.atom
    val legalSfu = encodingValid && (decoded.opcode === AecOpcode.div || decoded.opcode === AecOpcode.rcp ||
      decoded.opcode === AecOpcode.rsq || decoded.opcode === AecOpcode.sin || decoded.opcode === AecOpcode.cos ||
      decoded.opcode === AecOpcode.exp || decoded.opcode === AecOpcode.log || decoded.opcode === AecOpcode.sqrt)
    val decodedStore = decoded.opcode === AecOpcode.st
    val decodedAtomic = decoded.opcode === AecOpcode.atom
    val decodedSerializing = decodedStore || decodedAtomic
    val decodedWritesPredicate = decoded.opcode === AecOpcode.cmpp ||
      (decoded.opcode === AecOpcode.vote && decoded.ext === 1.U)
    val decodedPairDestination = decoded.dtype === 1.U || decoded.dtype === 9.U || decoded.opcode === AecOpcode.loadi64
    val decodedControl = decoded.opcode === AecOpcode.br || decoded.opcode === AecOpcode.brx ||
      decoded.opcode === AecOpcode.call || decoded.opcode === AecOpcode.ret ||
      decoded.opcode === AecOpcode.syncCt || decoded.opcode === AecOpcode.mbar || decoded.opcode === AecOpcode.halt
    val issueRobReady = Mux(issueWarp(0), robs(s * 2 + 1).io.allocate.ready, robs(s * 2).io.allocate.ready)
    val issueRobEmpty = Mux(issueWarp(0), robs(s * 2 + 1).io.empty, robs(s * 2).io.empty)
    val issueAllocatedTag = Mux(issueWarp(0), robs(s * 2 + 1).io.allocatedTag, robs(s * 2).io.allocatedTag)
    val canStart = issueValid && (legalInteger || legalFp32 || legalFp64 || legalGmem || legalLocalMemory || legalCollective || legalCvt || legalAtom || legalSfu || (decoded.opcode === AecOpcode.loadi64 && encodingValid)) && score.io.sourcesReady &&
      (decodedStore || score.io.destinationFree) && issueRobReady && (!decodedSerializing || issueRobEmpty)
    val activePred = activeMask(issueWarp) & bank.io.predMask
    val uniformTrue = activePred === activeMask(issueWarp)
    val uniformFalse = activePred === 0.U
    when (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.br) {
      pc(issueWarp) := decoded.immExt; rr(s) := !rr(s)
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.brx) {
      when (uniformTrue || uniformFalse) { pc(issueWarp) := Mux(uniformTrue, decoded.immExt, pc(issueWarp) + 1.U); rr(s) := !rr(s) }
        .otherwise { running := false.B; abortPending := true.B; abortStatus := 2.U }
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.call) {
      when (callDepth(issueWarp) === 32.U) { running := false.B; abortPending := true.B; abortStatus := 2.U }
        .otherwise { callStack(issueWarp)(callDepth(issueWarp)) := pc(issueWarp) + 1.U; callDepth(issueWarp) := callDepth(issueWarp) + 1.U; pc(issueWarp) := decoded.immExt; rr(s) := !rr(s) }
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.ret) {
      when (callDepth(issueWarp) === 0.U) { running := false.B; abortPending := true.B; abortStatus := 2.U }
        .otherwise { callDepth(issueWarp) := callDepth(issueWarp) - 1.U; pc(issueWarp) := callStack(issueWarp)(callDepth(issueWarp) - 1.U); rr(s) := !rr(s) }
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.syncCt) {
      syncArriveValid(s) := true.B; syncArriveWarp(s) := issueWarp; warpState(issueWarp) := 2.U
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.mbar) {
      // Every LSU is instruction-serial, therefore all earlier accesses from
      // this warp have committed before MBAR is decoded.
      pc(issueWarp) := pc(issueWarp) + 1.U; rr(s) := !rr(s)
    }.elsewhen (issueValid && issueRobEmpty && encodingValid && decoded.opcode === AecOpcode.halt) {
      warpState(issueWarp) := 3.U
      rr(s) := !rr(s)
    }.elsewhen (canStart) {
      when (executeMask === 0.U) {
        pc(issueWarp) := pc(issueWarp) + 1.U
        rr(s) := !rr(s)
      }.otherwise {
        score.io.reserve.valid := !decodedStore
        robs(s * 2).io.allocate.valid := !issueWarp(0)
        robs(s * 2 + 1).io.allocate.valid := issueWarp(0)
        for (r <- Seq(robs(s * 2), robs(s * 2 + 1))) {
          r.io.allocate.bits.epoch := warpEpoch(issueWarp)
          r.io.allocate.bits.pc := pc(issueWarp)
          r.io.allocate.bits.instruction := decoded.raw
          r.io.allocate.bits.laneMask := Mux(decoded.opcode === AecOpcode.shuf, executeMask & decoded.immExt, executeMask)
          r.io.allocate.bits.dest := decoded.dest
          r.io.allocate.bits.writesGpr := !decodedStore && !decodedWritesPredicate
          r.io.allocate.bits.writeHi := decodedPairDestination
          r.io.allocate.bits.writesPredicate := decodedWritesPredicate
          r.io.allocate.bits.predicate := decoded.dest(2, 0)
          r.io.allocate.bits.serializing := decodedSerializing
        }
        held(s) := decoded
        heldWarp(s) := issueWarp
        heldTag(s) := issueAllocatedTag
        heldExecute(s) := executeMask
        heldCommit(s) := Mux(decoded.opcode === AecOpcode.shuf, executeMask & decoded.immExt, executeMask)
        readLane(s) := 0.U
        pipeState(s) := pipeReadA
        pc(issueWarp) := pc(issueWarp) + 1.U
        warpState(issueWarp) := Mux(decodedSerializing, 2.U, 1.U)
        rr(s) := !rr(s)
      }
    }.elsewhen (issueValid && issueRobEmpty && !encodingValid) {
      // Malformed encodings are architecturally INVALID and have no side
      // effects.  This is intentionally ahead of every backend selection.
      printf(p"AEC invalid encoding: pc=${pc(issueWarp)} warp=${issueWarp} opcode=0x${Hexadecimal(decoded.opcode)} ctrl=0x${Hexadecimal(decoded.raw(111, 96))} dest=0x${Hexadecimal(decoded.destRaw)} src1=0x${Hexadecimal(decoded.src1Raw)} src2=0x${Hexadecimal(decoded.src2Imm)} ext=0x${Hexadecimal(decoded.immExt)}\\n")
      running := false.B
      abortPending := true.B
      abortStatus := 1.U
    }.elsewhen (issueValid && !decodedControl && !(legalInteger || legalFp32 || legalFp64 || legalGmem || legalLocalMemory || legalCollective || legalCvt || legalAtom || legalSfu || (decoded.opcode === AecOpcode.loadi64 && encodingValid))) {
      // Any other legal instruction reaching an unconnected backend is also a
      // hard integration failure.  It must never be reported as INVALID.
      unsupportedTrap := true.B
      unsupportedPc := pc(issueWarp); unsupportedWarp := issueWarp
      unsupportedOpcode := decoded.opcode; unsupportedDtype := decoded.dtype
    }

    when (bank.io.response.fire && pipeState(s) === pipeReadA) {
      for (lane <- 0 until 32) { operandA(s)(lane) := bank.io.response.bits.data(lane) }
      pipeState(s) := pipeReadB
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadB) {
      for (lane <- 0 until 32) { operandB(s)(lane) := bank.io.response.bits.data(lane) }
      pipeState(s) := pipeReadC
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadC) {
      for (lane <- 0 until 32) { operandC(s)(lane) := bank.io.response.bits.data(lane) }
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
          matchLane(s) := 0.U; pipeState(s) := pipeMatch
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
    when (bank.io.response.fire && pipeState(s) === pipeReadAHi) {
      for (lane <- 0 until 32) { operandAHi(s)(lane) := bank.io.response.bits.data(lane) }
      pipeState(s) := pipeReadBHi
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadBHi) {
      for (lane <- 0 until 32) { operandBHi(s)(lane) := bank.io.response.bits.data(lane) }
      pipeState(s) := pipeReadCHi
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadCHi) {
      for (lane <- 0 until 32) { operandCHi(s)(lane) := bank.io.response.bits.data(lane) }
        when (held(s).opcode === AecOpcode.cpy) {
          for (lane <- 0 until 32) {
            writeData(s)(lane) := operandA(s)(lane)
            writeHiData(s)(lane) := operandAHi(s)(lane)
          }
          writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite
        }.otherwise { pipeState(s) := Mux(heldCvt, pipeCvt, pipeDispatch); cvtLane(s) := 0.U }
    }
    when (unit.io.req.fire) { intTag(s) := heldTag(s); pipeState(s) := pipeIdle }
    when (fp32.io.req.fire) { fp32Tag(s) := heldTag(s); pipeState(s) := pipeIdle }
    when (fp64.io.req.fire) { fp64Tag(s) := heldTag(s); pipeState(s) := pipeIdle }
    when (sfu.io.req.fire) { sfuTag(s) := heldTag(s); pipeState(s) := pipeIdle }
    when (pipeState(s) === pipeCvt) {
      coordRequest(s) := heldSpecialCpy
      when (!heldSpecialCpy) {
        writeData(s)(cvtLane(s)) := cvt.io.out(31, 0)
        writeHiData(s)(cvtLane(s)) := cvt.io.out(63, 32)
        when (cvtLane(s) === 31.U) { writeLane(s) := 0.U; writeHiPhase(s) := false.B; pipeState(s) := pipeWrite }
          .otherwise { cvtLane(s) := cvtLane(s) + 1.U }
      }
    }
    when (pipeState(s) === pipeMatch) {
      writeData(s)(matchLane(s)) := VecInit((0 until 32).map(other =>
        heldExecute(s)(other) && operandA(s)(other) === operandA(s)(matchLane(s)))).asUInt
      when (matchLane(s) === 31.U) { writeHiPhase(s) := false.B; pipeState(s) := pipeWrite }
        .otherwise { matchLane(s) := matchLane(s) + 1.U }
    }
    when (lsu.io.start.fire) {
      val issuingRobCount = Mux(heldWarp(s)(0), robs(s * 2 + 1).io.count, robs(s * 2).io.count)
      assert(!heldStore && !heldAtomic || issuingRobCount === 1.U,
        "store/atomic side effects require a sole serializing ROB entry")
      gmemTag(s) := heldTag(s)
      gmemAtomic(s) := heldAtomic
      pipeState(s) := pipeIdle
    }

    completionCandidates(s)(5).valid := pipeState(s) === pipeWrite
    completionCandidates(s)(5).bits.tag := heldTag(s)
    completionCandidates(s)(5).bits.data := VecInit((0 until 32).map(lane => Cat(writeHiData(s)(lane), writeData(s)(lane))))
    completionCandidates(s)(5).bits.predicateData := writePredicates(s)
    completionCandidates(s)(5).bits.error := false.B
    when (pipeState(s) === pipeWrite && completionAny(s) && completionGrant(s) === 5.U) {
      writeHiPhase(s) := false.B
      pipeState(s) := pipeIdle
    }
  }

  // One shared, registered coordinate unit replaces four copies of dynamic
  // divide/modulo logic. Special CPY lanes are serialized through this unit;
  // ordinary conversion lanes remain independent.
  val coordBusy = RegInit(false.B)
  val coordOwner = Reg(UInt(2.W))
  val coordLinear = Reg(UInt(8.W))
  val coordSelect = PriorityEncoder(coordRequest.asUInt)
  when (!coordBusy && coordRequest.asUInt.orR) {
    coordBusy := true.B; coordOwner := coordSelect
    coordLinear := Mux1H((0 until 4).map(i => (coordSelect === i.U) ->
      ((heldWarp(i) << 5) + cvtLane(i))))
  }
  val coordBlockX = launchBlockX(7, 0)
  val coordBlockY = launchBlockY(7, 0)
  val coordBlockXIs256 = launchBlockX === 256.U
  val coordBlockYIs256 = launchBlockY === 256.U
  val coordQuotX = Mux(coordBlockXIs256, 0.U, coordLinear / coordBlockX)
  val coordX = Mux(coordBlockXIs256, coordLinear, coordLinear % coordBlockX)
  val coordY = Mux(coordBlockYIs256, coordQuotX, coordQuotX % coordBlockY)
  val coordZ = Mux(coordBlockYIs256, 0.U, coordQuotX / coordBlockY)
  when (coordBusy) {
    for (s <- 0 until 4) {
      when (coordOwner === s.U) {
        val special = MuxLookup(held(s).src1Raw, 0.U(32.W), Seq(
          "h0100".U -> coordX, "h0101".U -> launchBlockX, "h0102".U -> ctaX, "h0103".U -> launchGridX,
          "h0104".U -> cvtLane(s),
          "h0110".U -> coordY, "h0111".U -> launchBlockY, "h0112".U -> ctaY, "h0113".U -> launchGridY,
          "h0120".U -> coordZ, "h0121".U -> launchBlockZ, "h0122".U -> ctaZ, "h0123".U -> launchGridZ))
        writeData(s)(cvtLane(s)) := special; writeHiData(s)(cvtLane(s)) := 0.U
        when (cvtLane(s) === 31.U) { writeHiPhase(s) := false.B; pipeState(s) := pipeWrite }
          .otherwise { cvtLane(s) := cvtLane(s) + 1.U }
      }
    }
    coordBusy := false.B
  }

  // The resident memory arrays are shared by all four scheduler partitions.
  // Arbitration is deliberately conservative: a local operation is an
  // instruction-level transaction, so no second partition can observe a
  // partially completed misaligned store.
  val localRr = RegInit(0.U(2.W))
  val localOwner = RegInit(0.U(2.W))
  val localOwnerValid = RegInit(false.B)
  val localRotated = (Cat(localRequestValid.asUInt, localRequestValid.asUInt) >> localRr)(3, 0)
  val localSelect = (localRr + PriorityEncoder(localRotated))(1, 0)
  localLsu.io.start.valid := localRequestValid.asUInt.orR
  localLsu.io.start.bits := Mux1H((0 until 4).map(i => (localSelect === i.U) -> localRequests(i)))
  when (localLsu.io.start.fire) {
    localRr := localSelect + 1.U
    localOwner := localSelect
    localOwnerValid := true.B
    for (s <- 0 until 4) {
      when (localSelect === s.U) {
        val issuingRobCount = Mux(heldWarp(s)(0), robs(s * 2 + 1).io.count, robs(s * 2).io.count)
        assert(!(held(s).opcode === AecOpcode.st || held(s).opcode === AecOpcode.atom) || issuingRobCount === 1.U,
          "local store/atomic side effects require a sole serializing ROB entry")
        localTag(s) := heldTag(s)
        pipeState(s) := pipeIdle
      }
    }
  }
  for (s <- 0 until 4) {
    completionCandidates(s)(6).valid := localOwnerValid && localOwner === s.U && localLsu.io.done.valid
    completionCandidates(s)(6).bits.tag := localTag(s)
    completionCandidates(s)(6).bits.data := localLsu.io.done.bits.loadData
    completionCandidates(s)(6).bits.predicateData := 0.U
    completionCandidates(s)(6).bits.error := localLsu.io.done.bits.error
  }
  localLsu.io.done.ready := localOwnerValid && completionAny(localOwner) && completionGrant(localOwner) === 6.U
  when (localLsu.io.done.fire) { localOwnerValid := false.B }

  for (s <- 0 until 4) {
    val selectedCompletion = completionCandidates(s)(completionGrant(s)).bits
    when (completionAny(s)) {
      when (selectedCompletion.tag.warp(0)) {
        robs(s * 2 + 1).io.completion.valid := true.B
        robs(s * 2 + 1).io.completion.bits := selectedCompletion
      }.otherwise {
        robs(s * 2).io.completion.valid := true.B
        robs(s * 2).io.completion.bits := selectedCompletion
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
  for (s <- 0 until 4) {
    barrier.io.arrive(s).valid := syncArriveValid(s)
    barrier.io.arrive(s).bits := syncArriveWarp(s)
    when (syncArriveValid(s)) {
      assert(Mux(syncArriveWarp(s)(0), robs(s * 2 + 1).io.empty, robs(s * 2).io.empty),
        "barrier arrival requires all older ROB entries to retire")
    }
  }
  when (barrier.io.duplicate) { running := false.B; abortPending := true.B; abortStatus := 2.U }
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
  val lmemRequests = VecInit(gmemLsus.map(lsu => lsu.io.lineOut.valid && lsu.io.lineOut.bits.space)).asUInt
  val lockedRequests = lsuRequests & UIntToOH(atomicOwner, 4)
  val eligibleLsuRequests = Mux(atomicLock, lockedRequests | lmemRequests, lsuRequests)
  val externalRr = RegInit(0.U(2.W))
  val lsuRotated = (Cat(eligibleLsuRequests, eligibleLsuRequests) >> externalRr)(3, 0)
  val lsuSelect = (externalRr + PriorityEncoder(lsuRotated))(1, 0)
  external.io.lineIn.valid := eligibleLsuRequests.orR
  external.io.lineIn.bits := Mux1H((0 until 4).map(i => (lsuSelect === i.U) -> gmemLsus(i).io.lineOut.bits))
  for (s <- 0 until 4) {
    gmemLsus(s).io.lineOut.ready := external.io.lineIn.ready && external.io.lineIn.valid && lsuSelect === s.U
    gmemLsus(s).io.lineComplete.valid := external.io.lineComplete.valid && external.io.lineComplete.bits.warp(2, 1) === s.U
    gmemLsus(s).io.lineComplete.bits := external.io.lineComplete.bits
  }
  val selectedAtomic = Mux1H((0 until 4).map(i => (lsuSelect === i.U) -> gmemAtomic(i)))
  when (external.io.lineIn.fire && !atomicLock && selectedAtomic) {
    atomicLock := true.B
    atomicOwner := lsuSelect
  }
  when (external.io.lineIn.fire) { externalRr := lsuSelect + 1.U }
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
  io.mem_req_space := external.io.memReqSpace
  io.mem_req_write := external.io.memReqWrite
  io.mem_req_addr := external.io.memReqAddr
  io.mem_req_wdata := external.io.memReqWdata
  io.mem_req_wstrb := external.io.memReqWstrb
  io.mem_req_tag := external.io.memReqTag
  io.mem_rsp_ready := external.io.memRspReady

  val allDone = VecInit((0 until 8).map(w => warpState(w) === 3.U)).asUInt.andR
  when (abortPending && external.io.outstanding === 0.U && !resultValid) {
    abortPending := false.B
    resultValid := true.B
    resultStatus := abortStatus
  }
  when (running && !restartCta && allDone && external.io.outstanding === 0.U) {
    assert(robs.map(_.io.empty).reduce(_ && _), "CTA completion requires empty ROBs")
    when (ctaX + 1.U < launchGridX) { ctaX := ctaX + 1.U; restartCta := true.B }
      .elsewhen (ctaY + 1.U < launchGridY) { ctaX := 0.U; ctaY := ctaY + 1.U; restartCta := true.B }
      .elsewhen (ctaZ + 1.U < launchGridZ) { ctaX := 0.U; ctaY := 0.U; ctaZ := ctaZ + 1.U; restartCta := true.B }
      .otherwise { running := false.B; resultValid := true.B; resultStatus := 0.U }
  }
  io.result_valid := resultValid
  io.result_status := resultStatus
  io.result_cycles := cycles
  when (resultValid && io.result_ready) {
    resultValid := false.B; loadError := false.B; abortPending := false.B
    restartCta := false.B; unsupportedTrap := false.B; unsupportedAssert := false.B
    atomicLock := false.B; coordBusy := false.B
    for (s <- 0 until 4) { pipeState(s) := pipeIdle; fetchPending(s) := false.B }
  }

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
