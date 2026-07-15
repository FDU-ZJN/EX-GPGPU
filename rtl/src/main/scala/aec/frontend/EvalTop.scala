package aec

import chisel3._
import chisel3.util._
import aec.exec._

class AecDecodePacket extends Bundle {
  val instruction = new AecDecodedInstruction
  val encodingValid = Bool()
  val backendClass = UInt(4.W)
  val supported = Bool()
  val control = Bool()
  val serializing = Bool()
  val writesPredicate = Bool()
  val pairDestination = Bool()
  val store = Bool()
  val sourceUsed = Vec(3, Bool())
  val sourcePair = Vec(3, Bool())
  val sourcePredicateUsed = Bool()
  val sourcePredicate = UInt(3.W)
}

class AecPredecoder extends Module {
  val io = IO(new Bundle {
    val raw = Input(UInt(128.W))
    val programInstructions = Input(UInt(32.W))
    val packet = Output(new AecDecodePacket)
  })
  val d = AecDecode(io.raw)
  val encodingValid = AecValidator.valid(d, io.programInstructions)
  val legalInteger = AecInstructionTraits.integerOpcode(d.opcode) && encodingValid &&
    ((d.opcode === AecOpcode.loadi && d.dtype === 15.U) || d.opcode === AecOpcode.cpy ||
      ((d.opcode === AecOpcode.sel || d.opcode === AecOpcode.pick) && d.dtype === 8.U) ||
      (d.opcode =/= AecOpcode.loadi && d.opcode =/= AecOpcode.cpy &&
        (d.dtype === 0.U || d.dtype === 2.U || d.dtype === 3.U)))
  val legalFp32 = AecInstructionTraits.fpOpcode(d.opcode) && encodingValid &&
    (d.dtype === 8.U || d.dtype === 10.U || d.dtype === 11.U)
  val legalFp64 = AecInstructionTraits.fpOpcode(d.opcode) && encodingValid && d.dtype === 9.U
  val legalGmem = (d.opcode === AecOpcode.ld || d.opcode === AecOpcode.st) &&
    (d.ext === AecMemorySpace.gmem || d.ext === AecMemorySpace.lmem) && encodingValid &&
    (d.dtype === 0.U || d.dtype === 2.U || d.dtype === 3.U || d.dtype === 8.U ||
      (d.opcode === AecOpcode.ld && d.dtype === 1.U))
  val legalLocalMemory = (d.opcode === AecOpcode.ld || d.opcode === AecOpcode.st ||
    d.opcode === AecOpcode.ldc) && encodingValid &&
    (d.opcode === AecOpcode.ldc || d.ext === AecMemorySpace.smem ||
      d.ext === AecMemorySpace.cmem || d.ext === AecMemorySpace.pmem)
  val legalCollective = encodingValid && (d.opcode === AecOpcode.shuf ||
    d.opcode === AecOpcode.vote || d.opcode === AecOpcode.mtch || d.opcode === AecOpcode.rdtsc)
  val legalCvt = encodingValid && (d.opcode === AecOpcode.cvtff || d.opcode === AecOpcode.cvtfi ||
    d.opcode === AecOpcode.cvtif || d.opcode === AecOpcode.cvtii)
  val legalAtom = encodingValid && d.opcode === AecOpcode.atom
  val legalSfu = encodingValid && (d.opcode === AecOpcode.div || d.opcode === AecOpcode.rcp ||
    d.opcode === AecOpcode.rsq || d.opcode === AecOpcode.sin || d.opcode === AecOpcode.cos ||
    d.opcode === AecOpcode.exp || d.opcode === AecOpcode.log || d.opcode === AecOpcode.sqrt)
  val legalLoadi64 = encodingValid && d.opcode === AecOpcode.loadi64
  io.packet.instruction := d
  io.packet.encodingValid := encodingValid
  io.packet.supported := legalInteger || legalFp32 || legalFp64 || legalGmem || legalLocalMemory ||
    legalCollective || legalCvt || legalAtom || legalSfu || legalLoadi64
  io.packet.backendClass := Mux(legalFp32, 1.U, Mux(legalFp64, 2.U, Mux(legalSfu, 3.U,
    Mux(legalGmem, 4.U, Mux(legalLocalMemory, 5.U, Mux(legalCvt, 6.U, Mux(legalCollective, 7.U, 0.U)))))))
  io.packet.control := d.opcode === AecOpcode.br || d.opcode === AecOpcode.brx ||
    d.opcode === AecOpcode.call || d.opcode === AecOpcode.ret || d.opcode === AecOpcode.syncCt ||
    d.opcode === AecOpcode.mbar || d.opcode === AecOpcode.halt
  io.packet.store := d.opcode === AecOpcode.st
  io.packet.serializing := io.packet.store || d.opcode === AecOpcode.atom
  io.packet.writesPredicate := d.opcode === AecOpcode.cmpp ||
    (d.opcode === AecOpcode.vote && d.ext === 1.U)
  io.packet.pairDestination := d.dtype === 1.U || d.dtype === 9.U || d.opcode === AecOpcode.loadi64
  io.packet.sourceUsed(0) := AecInstructionTraits.usesSrc0(d)
  io.packet.sourceUsed(1) := AecInstructionTraits.usesSrc1(d)
  io.packet.sourceUsed(2) := AecInstructionTraits.usesSrc2(d)
  io.packet.sourcePair(0) := AecInstructionTraits.source0Pair(d)
  io.packet.sourcePair(1) := AecInstructionTraits.source1Pair(d)
  io.packet.sourcePair(2) := AecInstructionTraits.source2Pair(d)
  io.packet.sourcePredicateUsed := AecInstructionTraits.usesSourcePredicate(d)
  io.packet.sourcePredicate := AecInstructionTraits.sourcePredicate(d)
}

/** Official testbench interface.  Execution-unit ports are internal only. */
class AecEvalCore extends Module with RequireAsyncReset {
  private val schedulerCount = 1
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
  })

  // A single scheduler owns the only instruction SRAM read port.
  val imem = Seq.fill(schedulerCount)(Module(new AecInstructionSram))
  val predecoder = Seq.fill(schedulerCount)(Module(new AecPredecoder))
  val running = RegInit(false.B)
  val loadError = RegInit(false.B)
  val resultValid = RegInit(false.B)
  val resultStatus = RegInit(0.U(3.W))
  val abortPending = RegInit(false.B)
  val abortStatus = RegInit(2.U(3.W))
  val softReset = RegNext(resultValid && io.result_ready, false.B)
  // Replicate the lifecycle reset at hierarchy boundaries.  The global pulse
  // now drives eight small registers instead of every state element in four
  // scheduler partitions and both memory fabrics.
  val partitionSoftReset = RegInit(VecInit(Seq.fill(schedulerCount)(false.B)))
  val fabricSoftReset = RegInit(VecInit(Seq.fill(4)(false.B)))
  partitionSoftReset := VecInit(Seq.fill(schedulerCount)(softReset))
  fabricSoftReset := VecInit(Seq.fill(4)(softReset))
  val lifecycleResetBusy = softReset || partitionSoftReset.asUInt.orR || fabricSoftReset.asUInt.orR
  val cycles = RegInit(0.U(64.W))
  val launchThreads = RegInit(0.U(32.W))
  val launchGridX = RegInit(0.U(32.W)); val launchGridY = RegInit(0.U(32.W)); val launchGridZ = RegInit(0.U(32.W))
  val launchBlockX = RegInit(0.U(32.W)); val launchBlockY = RegInit(0.U(32.W)); val launchBlockZ = RegInit(0.U(32.W))
  val ctaX = RegInit(0.U(32.W)); val ctaY = RegInit(0.U(32.W)); val ctaZ = RegInit(0.U(32.W))
  val ctaThreadBase = RegInit(0.U(20.W))
  val restartCta = RegInit(false.B)
  val launchValidator = withReset((reset.asBool || softReset).asAsyncReset) { Module(new AecLaunchValidator) }
  val launchStart = WireDefault(false.B)
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
  val rr = RegInit(VecInit(Seq.fill(schedulerCount)(false.B)))
  // Two physical ROB/GPR scheduling slots are rebound to one even-aligned pair
  // of architectural warps at a time.
  val residentPair = RegInit(0.U(2.W))
  val residentWarpId = RegInit(VecInit(0.U(3.W), 1.U(3.W)))
  val barrier = withReset((reset.asBool || fabricSoftReset(0)).asAsyncReset) { Module(new AecCtaBarrier) }
  val externalMemory = withReset((reset.asBool || fabricSoftReset(1)).asAsyncReset) { Module(new AecExternalMemoryEngine) }
  val lineCache = withReset((reset.asBool || fabricSoftReset(1)).asAsyncReset) { Module(new AecLineCache) }
  val localMemory = withReset((reset.asBool || fabricSoftReset(2)).asAsyncReset) { Module(new AecLocalLsu) }
  localMemory.io.clearSmem := false.B
  localMemory.io.preload.valid := false.B
  localMemory.io.preload.bits := 0.U.asTypeOf(localMemory.io.preload.bits)

  // Loading is intentionally allowed only before launch.  The fixed local
  // apertures make an invalid preload visible at launch instead of silently
  // truncating a testcase image.
  val localLoadTarget = io.load_target === 2.U || io.load_target === 3.U
  io.load_ready := !running && !resultValid && !lifecycleResetBusy && launchValidator.io.idle &&
    (!localLoadTarget || localMemory.io.preload.ready)
  val loadFire = io.load_valid && io.load_ready
  val localLoadOutOfRange = VecInit((0 until 16).map(i => io.load_strb(i) &&
    (io.load_addr +& i.U) >= 65536.U)).asUInt.orR
  for (port <- 0 until schedulerCount) {
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
          localMemory.io.preload.valid := true.B
          localMemory.io.preload.bits.pmem := io.load_target === 2.U
          localMemory.io.preload.bits.address := io.load_addr(15, 0)
          localMemory.io.preload.bits.data := io.load_data
          localMemory.io.preload.bits.mask := io.load_strb
        }
    }.elsewhen (io.load_target =/= 1.U) { loadError := true.B }
  }

  launchValidator.io.request.valid := io.launch_valid && !running && !resultValid && !lifecycleResetBusy
  launchValidator.io.request.bits.gridX := io.grid_x
  launchValidator.io.request.bits.gridY := io.grid_y
  launchValidator.io.request.bits.gridZ := io.grid_z
  launchValidator.io.request.bits.blockX := io.block_x
  launchValidator.io.request.bits.blockY := io.block_y
  launchValidator.io.request.bits.blockZ := io.block_z
  launchValidator.io.request.bits.programInstructions := io.program_instructions
  launchValidator.io.request.bits.loadError := loadError
  launchValidator.io.result.ready := true.B
  io.launch_ready := !running && !resultValid && !lifecycleResetBusy && launchValidator.io.request.ready
  when (launchValidator.io.request.fire) {
    cycles := 0.U
    unsupportedTrap := false.B
    unsupportedAssert := false.B
  }
  when (launchValidator.io.result.fire) {
    val launch = launchValidator.io.result.bits
    when (!launch.accepted) {
      resultValid := true.B
      resultStatus := 1.U
    }.otherwise {
      running := true.B
      launchStart := true.B
      launchThreads := launch.threads
      launchGridX := launch.gridX; launchGridY := launch.gridY; launchGridZ := launch.gridZ
      launchBlockX := launch.blockX; launchBlockY := launch.blockY; launchBlockZ := launch.blockZ
      ctaX := 0.U; ctaY := 0.U; ctaZ := 0.U; ctaThreadBase := 0.U
      residentPair := 0.U
      residentWarpId(0) := 0.U
      residentWarpId(1) := 1.U
      for (w <- 0 until 8) {
        val remaining = launch.threads - (w * 32).U
        activeMask(w) := Mux(remaining >= 32.U, "hffffffff".U, Mux(remaining === 0.U, 0.U, (1.U(33.W) << remaining(5, 0))(31, 0) - 1.U))
        pc(w) := 0.U
        warpEpoch(w) := 0.U
        callDepth(w) := 0.U
        warpState(w) := Mux(launch.threads > (w * 32).U, 1.U, 3.U)
      }
    }
  }
  when (restartCta) {
    restartCta := false.B
    residentPair := 0.U
    residentWarpId(0) := 0.U
    residentWarpId(1) := 1.U
    for (w <- 0 until 8) {
      val remaining = launchThreads - (w * 32).U
      activeMask(w) := Mux(remaining >= 32.U, "hffffffff".U, Mux(remaining === 0.U, 0.U, (1.U(33.W) << remaining(5, 0))(31, 0) - 1.U))
      pc(w) := 0.U; callDepth(w) := 0.U
      warpEpoch(w) := warpEpoch(w) + 1.U
      warpState(w) := Mux(launchThreads > (w * 32).U, 1.U, 3.U)
    }
  }
  when (launchStart || restartCta) { localMemory.io.clearSmem := true.B }
  when (running) { cycles := cycles + 1.U }

  // Each scheduler owns a two-warp register-file partition and an eight-lane
  // integer cluster.  A 32-lane instruction is collected from the synchronous
  // 2R1W bank, issued as four physical lane groups, then committed one lane per
  // cycle.  This is deliberately conservative, but all architectural reads
  // precede writeback and every RAW/WAW hazard is tracked by the scoreboard.
  val partitionClear = RegInit(VecInit(Seq.fill(schedulerCount)(false.B)))
  partitionClear := VecInit(Seq.fill(schedulerCount)(launchStart || restartCta))
  val partitionCtaThreadBase = RegInit(VecInit(Seq.fill(schedulerCount)(0.U(20.W))))
  when (launchStart) {
    partitionCtaThreadBase := VecInit(Seq.fill(schedulerCount)(0.U(20.W)))
  }.elsewhen (restartCta) {
    partitionCtaThreadBase := VecInit(Seq.fill(schedulerCount)(ctaThreadBase))
  }
  val regBanks = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecRegBank)
  })
  val scoreboards = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecScoreboard)
  })
  // The repeated backend module owns all wide operand selection and compute
  // completion arbitration.  EvalTop only carries partition-local payloads to
  // this boundary instead of mapping four copies of the mux fabric itself.
  val partitionBackends = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecPartitionBackend)
  })
  val cvtUnits = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecConvertLane)
  })
  val gmemLsus = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecGmemPipeline)
  })
  val robs = (0 until 2).map(_ => withReset((reset.asBool || partitionSoftReset(0)).asAsyncReset) {
    Module(new AecWarpRob)
  })
  for ((rob, slot) <- robs.zipWithIndex) {
    rob.io.warpId := residentWarpId(slot)
    rob.io.allocate.valid := false.B
    rob.io.allocate.bits := 0.U.asTypeOf(rob.io.allocate.bits)
    rob.io.completion.valid := false.B
    rob.io.completion.bits := 0.U.asTypeOf(rob.io.completion.bits)
    rob.io.pop := false.B
    rob.io.flush := false.B
    when (partitionClear(0)) { rob.io.flush := true.B }
  }
  val pipeIdle :: pipeReadA :: pipeReadB :: pipeReadC :: pipeReadAHi :: pipeReadBHi :: pipeReadCHi :: pipeDispatch :: pipeWait :: pipeMemStart :: pipeMemWait :: pipeCvt :: pipeCoord :: pipeMatch :: pipeWrite :: Nil = Enum(15)
  val pipeState = Seq.fill(schedulerCount)(RegInit(pipeIdle))
  val held = Seq.fill(schedulerCount)(Reg(new AecDecodedInstruction))
  val heldWarp = Seq.fill(schedulerCount)(Reg(UInt(3.W)))
  val heldTag = Seq.fill(schedulerCount)(Reg(new AecInstructionTag))
  val gmemTag = Seq.fill(schedulerCount)(Reg(new AecInstructionTag))
  val localTag = Reg(new AecInstructionTag)
  val heldExecute = Seq.fill(schedulerCount)(Reg(UInt(32.W)))
  // Some collectives retire to a subset of the executing lanes.  Keep that
  // mask separate from the instruction guard/active mask used for sampling.
  val operandStores = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecOperandStore)
  })
  val operandA = operandStores.map(_.io.a)
  val operandB = operandStores.map(_.io.b)
  val operandC = operandStores.map(_.io.c)
  val operandAHi = operandStores.map(_.io.aHi)
  val operandBHi = operandStores.map(_.io.bHi)
  val operandCHi = operandStores.map(_.io.cHi)
  val writeScratch = Seq.fill(schedulerCount)(Seq.fill(32)(Module(new AecWritebackLaneScratch)))
  for (s <- 0 until schedulerCount; lane <- 0 until 32) {
    writeScratch(s)(lane).io.writeLow := false.B
    writeScratch(s)(lane).io.lowIn := 0.U
    writeScratch(s)(lane).io.writeHigh := false.B
    writeScratch(s)(lane).io.highIn := 0.U
  }
  val writeData = writeScratch.map(lanes => VecInit(lanes.map(_.io.low)))
  val writeHiData = writeScratch.map(lanes => VecInit(lanes.map(_.io.high)))
  val writePredicates = Seq.fill(schedulerCount)(RegInit(0.U(32.W)))
  val cvtLane = Seq.fill(schedulerCount)(RegInit(0.U(5.W)))
  val matchLane = Seq.fill(schedulerCount)(RegInit(0.U(5.W)))
  val localRequests = Wire(Vec(schedulerCount, new AecLocalMemoryRequest))
  val localRequestValid = Wire(Vec(schedulerCount, Bool()))
  val syncArriveValid = Wire(Vec(schedulerCount, Bool()))
  val syncArriveWarp = Wire(Vec(schedulerCount, UInt(3.W)))
  val coordRequest = Wire(Vec(schedulerCount, Bool()))
  val coordinate = withReset((reset.asBool || fabricSoftReset(3)).asAsyncReset) { Module(new AecCoordinateFabric(1)) }
  private val completionSources = 7
  val completionCandidates = Wire(Vec(schedulerCount, Vec(completionSources, Valid(new AecBackendCompletion))))
  val completionArbiters = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecCompletionArbiter(completionSources))
  })
  val resultStores = Seq.fill(schedulerCount)(Module(new AecPartitionResultStore))
  for (s <- 0 until schedulerCount; source <- 0 until completionSources) {
    completionCandidates(s)(source).valid := false.B
    completionCandidates(s)(source).bits := 0.U.asTypeOf(completionCandidates(s)(source).bits)
    completionArbiters(s).io.in(source).valid := completionCandidates(s)(source).valid
    completionArbiters(s).io.in(source).bits := completionCandidates(s)(source).bits
  }
  for (s <- 0 until schedulerCount) {
    predecoder(s).io.raw := imem(s).io.readData
    predecoder(s).io.programInstructions := io.program_instructions
    completionArbiters(s).io.out.ready := true.B
    resultStores(s).io.write.valid := false.B
    resultStores(s).io.write.bits := completionArbiters(s).io.out.bits
  }

  // One in-order architectural commit port per partition.  A 64-bit result
  // locks the selected warp for its high-word cycle so the register pair is
  // never observed half-retired.
  val commitSelectors = (0 until schedulerCount).map(s => withReset((reset.asBool || partitionSoftReset(s)).asAsyncReset) {
    Module(new AecCommitSelector)
  })
  val commitSelect = Wire(Vec(schedulerCount, UInt(1.W)))
  val commitHead = Wire(Vec(schedulerCount, new AecRobHead))
  val commitData = Wire(Vec(schedulerCount, Vec(32, UInt(64.W))))
  val commitValid = Wire(Vec(schedulerCount, Bool()))
  val commitFinal = Wire(Vec(schedulerCount, Bool()))
  val commitPairHigh = Wire(Vec(schedulerCount, Bool()))

  for (s <- 0 until schedulerCount) {
    commitSelectors(s).io.heads(0) := robs(s * 2).io.head
    commitSelectors(s).io.heads(1) := robs(s * 2 + 1).io.head
    commitSelect(s) := commitSelectors(s).io.select
    commitHead(s) := commitSelectors(s).io.head
    commitSelectors(s).io.ready := commitSelectors(s).io.head.error ||
      !commitSelectors(s).io.head.writesGpr || regBanks(s).io.writeReady
    commitValid(s) := commitSelectors(s).io.valid && commitSelectors(s).io.ready
    commitFinal(s) := commitSelectors(s).io.finalCycle
    commitPairHigh(s) := commitSelectors(s).io.pairHigh
    robs(s * 2).io.pop := commitSelectors(s).io.pop(0)
    robs(s * 2 + 1).io.pop := commitSelectors(s).io.pop(1)
    resultStores(s).io.readWarpLocal := commitSelect(s)
    resultStores(s).io.readRobIndex := commitHead(s).tag.robIndex
    commitData(s) := resultStores(s).io.readData

    when (commitFinal(s)) {
      when (commitHead(s).serializing && !commitHead(s).error) {
        warpState(commitHead(s).tag.warp) := 1.U
      }
      when (commitHead(s).error) {
        running := false.B
        abortPending := true.B
        abortStatus := 2.U
        for (w <- 0 until 8) { warpEpoch(w) := warpEpoch(w) + 1.U }
        for (rob <- robs) { rob.io.flush := true.B }
      }
    }

  }

  // One scheduler selects between the two currently resident architectural
  // warps. Other warp pairs remain parked in the architectural context table.
  val selected = Wire(Vec(schedulerCount, UInt(3.W)))
  val selectedValid = Wire(Vec(schedulerCount, Bool()))
  val fetchPending = Seq.fill(schedulerCount)(RegInit(false.B))
  val fetchWarp = Seq.fill(schedulerCount)(Reg(UInt(3.W)))
  val decodeValid = Seq.fill(schedulerCount)(RegInit(false.B))
  val decodeWarp = Seq.fill(schedulerCount)(Reg(UInt(3.W)))
  val decodePacket = Seq.fill(schedulerCount)(Reg(new AecDecodePacket))
  for (s <- 0 until schedulerCount) {
    val lo = residentWarpId(0); val hi = residentWarpId(1)
    val partitionFree = pipeState(s) === pipeIdle && !decodeValid(s)
    val loRun = warpState(lo) === 1.U && partitionFree
    val hiRun = warpState(hi) === 1.U && partitionFree
    selectedValid(s) := loRun || hiRun
    selected(s) := Mux(rr(s), Mux(hiRun, hi, lo), Mux(loRun, lo, hi))
    val fetchRequest = running && !localMemory.io.clearBusy && !partitionClear(s) &&
      selectedValid(s) && !fetchPending(s) && !decodeValid(s)
    imem(s).io.readEn := fetchRequest
    imem(s).io.readAddress := pc(selected(s))(9, 0)
    when (fetchRequest) { fetchPending(s) := true.B; fetchWarp(s) := selected(s) }
    when (fetchPending(s) && pipeState(s) === pipeIdle && !decodeValid(s)) {
      fetchPending(s) := false.B
      decodeValid(s) := true.B
      decodeWarp(s) := fetchWarp(s)
      decodePacket(s) := predecoder(s).io.packet
    }
    when (!running) { fetchPending(s) := false.B; decodeValid(s) := false.B }
  }

  val residentPairRunnable = warpState(residentWarpId(0)) === 1.U ||
    warpState(residentWarpId(1)) === 1.U
  val runnablePairs = VecInit((0 until 4).map(pair =>
    warpState(pair * 2) === 1.U || warpState(pair * 2 + 1) === 1.U)).asUInt
  val currentPair = residentPair
  val rotatedPairs = (Cat(runnablePairs, runnablePairs) >> currentPair)(3, 0)
  val nextPair = (currentPair + PriorityEncoder(rotatedPairs))(1, 0)
  val residentDrained = pipeState(0) === pipeIdle && !fetchPending(0) && !decodeValid(0) &&
    robs(0).io.empty && robs(1).io.empty
  when (running && residentDrained && !residentPairRunnable && runnablePairs.orR) {
    residentPair := nextPair
    residentWarpId(0) := Cat(nextPair, 0.U(1.W))
    residentWarpId(1) := Cat(nextPair, 1.U(1.W))
  }

  // Default all of the bank, scoreboard and execution-unit ports.  The
  // register bank is reset-valid rather than data-reset, which is the same
  // externally visible zero-state and remains compatible with SRAM macros.
  for (s <- 0 until schedulerCount) {
    val bank = regBanks(s)
    val score = scoreboards(s)
    val backend = partitionBackends(s)
    val cvt = cvtUnits(s)
    val issueWarp = decodeWarp(s)
    val issueValid = decodeValid(s) && pipeState(s) === pipeIdle && running
    val packet = decodePacket(s)
    val decoded = packet.instruction
    val heldIsCmpp = held(s).opcode === AecOpcode.cmpp
    val heldWritesPred = heldIsCmpp || (held(s).opcode === AecOpcode.vote && held(s).ext === 1.U)
    val heldLoadi64 = held(s).opcode === AecOpcode.loadi64
    val heldCvt = held(s).opcode === AecOpcode.cvtff || held(s).opcode === AecOpcode.cvtfi || held(s).opcode === AecOpcode.cvtif || held(s).opcode === AecOpcode.cvtii
    val heldCvtSrc = held(s).raw(109, 106)
    val heldAtomic = held(s).opcode === AecOpcode.atom
    val heldAtomicCas = heldAtomic && held(s).subop === 7.U
    val heldSpecialCpy = held(s).opcode === AecOpcode.cpy && held(s).src1Raw(15, 8).orR
    val heldNeedsPairRead = AecInstructionTraits.needsPairRead(held(s))
    val heldMemory = held(s).opcode === AecOpcode.ld || held(s).opcode === AecOpcode.st || held(s).opcode === AecOpcode.ldc || heldAtomic
    val heldStore = held(s).opcode === AecOpcode.st
    val heldExternalMemory = heldMemory && (held(s).ext === AecMemorySpace.gmem || held(s).ext === AecMemorySpace.lmem)
    val heldLocalMemory = heldMemory && held(s).ext =/= AecMemorySpace.gmem && held(s).ext =/= AecMemorySpace.lmem
    val lsu = gmemLsus(s)
    syncArriveValid(s) := false.B
    syncArriveWarp(s) := issueWarp
    coordRequest(s) := false.B

    bank.io.clear := partitionClear(s)
    bank.io.read.valid := pipeState(s) === pipeReadA || pipeState(s) === pipeReadB || pipeState(s) === pipeReadC || pipeState(s) === pipeReadAHi || pipeState(s) === pipeReadBHi || pipeState(s) === pipeReadCHi
    bank.io.read.bits.warp := heldWarp(s)
    bank.io.read.bits.reg := MuxLookup(pipeState(s), held(s).src1, Seq(
      pipeReadB -> held(s).src2,
      pipeReadC -> Mux(heldAtomicCas, held(s).src2Imm(23, 16), held(s).src3),
      pipeReadAHi -> (held(s).src1 + 1.U),
      pipeReadBHi -> (held(s).src2 + 1.U),
      pipeReadCHi -> (held(s).src3 + 1.U)))
    bank.io.read.bits.tag := pipeState(s)(2, 0)
    bank.io.response.ready := true.B
    bank.io.writeValid := commitValid(s) && commitHead(s).writesGpr && !commitHead(s).error
    bank.io.writeWarp := commitHead(s).tag.warp
    bank.io.writeReg := Mux(commitHead(s).writeHi && commitPairHigh(s), commitHead(s).dest + 1.U, commitHead(s).dest)
    bank.io.writeData := VecInit(commitData(s).map(lane =>
      Mux(commitHead(s).writeHi && commitPairHigh(s), lane(63, 32), lane(31, 0))))
    bank.io.writeMask := commitHead(s).laneMask
    bank.io.predWriteValid := commitValid(s) && commitHead(s).writesPredicate && !commitHead(s).error
    bank.io.predWarp := commitHead(s).tag.warp
    bank.io.predIndex := commitHead(s).predicate
    bank.io.predData := commitHead(s).predicateData
    bank.io.predWriteMask := commitHead(s).laneMask
    bank.io.predReadWarp := Mux(pipeState(s) === pipeIdle, issueWarp, heldWarp(s))
    bank.io.predReadIndex := Mux(pipeState(s) === pipeIdle, decoded.predicate,
      Mux(held(s).opcode === AecOpcode.vote, held(s).src1(2, 0), held(s).predicate))

    score.io.sourceWarp := issueWarp
    score.io.source0 := decoded.src1
    score.io.source1 := decoded.src2
    score.io.source2 := Mux(decoded.opcode === AecOpcode.atom && decoded.subop === 7.U, decoded.src2Imm(23, 16), decoded.src3)
    score.io.source0Used := packet.sourceUsed(0)
    score.io.source1Used := packet.sourceUsed(1)
    score.io.source2Used := packet.sourceUsed(2)
    score.io.sourcePredicateUsed := packet.sourcePredicateUsed
    score.io.sourcePredicate := packet.sourcePredicate
    score.io.source0Pair := packet.sourcePair(0)
    score.io.source1Pair := packet.sourcePair(1)
    score.io.source2Pair := packet.sourcePair(2)
    score.io.reserve.valid := false.B
    score.io.reserve.bits.warp := issueWarp
    score.io.reserve.bits.dest := decoded.dest
    score.io.reserve.bits.destHi := packet.pairDestination
    score.io.reserve.bits.predicate := packet.writesPredicate
    score.io.reserve.bits.pred := decoded.dest(2, 0)
    score.io.release.valid := commitFinal(s) && !commitHead(s).error &&
      (commitHead(s).writesGpr || commitHead(s).writesPredicate)
    score.io.release.bits.warp := commitHead(s).tag.warp
    score.io.release.bits.dest := commitHead(s).dest
    score.io.release.bits.destHi := commitHead(s).writeHi
    score.io.release.bits.predicate := commitHead(s).writesPredicate
    score.io.release.bits.pred := commitHead(s).predicate

    backend.io.dispatch := pipeState(s) === pipeDispatch
    backend.io.instruction := held(s)
    backend.io.tag := heldTag(s)
    backend.io.executeMask := heldExecute(s)
    backend.io.predicateMask := bank.io.predMask
    backend.io.operandA := operandA(s)
    backend.io.operandB := operandB(s)
    backend.io.operandC := operandC(s)
    backend.io.operandAHi := operandAHi(s)
    backend.io.operandBHi := operandBHi(s)
    backend.io.operandCHi := operandCHi(s)
    for (source <- 0 until 4) {
      completionCandidates(s)(source).valid := backend.io.completion(source).valid
      completionCandidates(s)(source).bits := backend.io.completion(source).bits
      backend.io.completion(source).ready := completionArbiters(s).io.in(source).ready
    }
    cvt.io.kind := MuxLookup(held(s).opcode, 0.U, Seq(AecOpcode.cvtff -> 0.U, AecOpcode.cvtfi -> 1.U, AecOpcode.cvtif -> 2.U, AecOpcode.cvtii -> 3.U))
    cvt.io.dstType := held(s).dtype; cvt.io.srcType := heldCvtSrc
    cvt.io.in := Cat(operandAHi(s)(cvtLane(s)), operandA(s)(cvtLane(s)))

    lsu.io.start.valid := pipeState(s) === pipeMemStart && heldExternalMemory
    lsu.io.start.bits.space := held(s).ext === AecMemorySpace.lmem
    lsu.io.start.bits.ctaThreadBase := partitionCtaThreadBase(s)
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
    lsu.io.done.ready := completionArbiters(s).io.in(4).ready
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
    val encodingValid = packet.encodingValid
    val issueRobReady = Mux(issueWarp(0), robs(s * 2 + 1).io.allocate.ready, robs(s * 2).io.allocate.ready)
    val issueRobEmpty = Mux(issueWarp(0), robs(s * 2 + 1).io.empty, robs(s * 2).io.empty)
    val issueAllocatedTag = Mux(issueWarp(0), robs(s * 2 + 1).io.allocatedTag, robs(s * 2).io.allocatedTag)
    val canStart = issueValid && packet.supported && score.io.sourcesReady &&
      (packet.store || score.io.destinationFree) && issueRobReady && (!packet.serializing || issueRobEmpty)
    val consumeControl = issueValid && issueRobEmpty && encodingValid && packet.control
    val consumeInvalid = issueValid && issueRobEmpty && !encodingValid
    val consumeUnsupported = issueValid && issueRobEmpty && encodingValid &&
      !packet.control && !packet.supported
    when (consumeControl || canStart || consumeInvalid || consumeUnsupported) { decodeValid(s) := false.B }
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
        score.io.reserve.valid := !packet.store
        robs(s * 2).io.allocate.valid := !issueWarp(0)
        robs(s * 2 + 1).io.allocate.valid := issueWarp(0)
        for (r <- Seq(robs(s * 2), robs(s * 2 + 1))) {
          r.io.allocate.bits.epoch := warpEpoch(issueWarp)
          r.io.allocate.bits.pc := pc(issueWarp)
          r.io.allocate.bits.laneMask := Mux(decoded.opcode === AecOpcode.shuf, executeMask & decoded.immExt, executeMask)
          r.io.allocate.bits.dest := decoded.dest
          r.io.allocate.bits.writesGpr := !packet.store && !packet.writesPredicate
          r.io.allocate.bits.writeHi := packet.pairDestination
          r.io.allocate.bits.writesPredicate := packet.writesPredicate
          r.io.allocate.bits.predicate := decoded.dest(2, 0)
          r.io.allocate.bits.serializing := packet.serializing
        }
        held(s) := decoded
        heldWarp(s) := issueWarp
        heldTag(s) := issueAllocatedTag
        heldExecute(s) := executeMask
        pipeState(s) := pipeReadA
        pc(issueWarp) := pc(issueWarp) + 1.U
        warpState(issueWarp) := Mux(packet.serializing, 2.U, 1.U)
        rr(s) := !rr(s)
      }
    }.elsewhen (issueValid && issueRobEmpty && !encodingValid) {
      // Malformed encodings are architecturally INVALID and have no side
      // effects.  This is intentionally ahead of every backend selection.
      printf(p"AEC invalid encoding: pc=${pc(issueWarp)} warp=${issueWarp} opcode=0x${Hexadecimal(decoded.opcode)} ctrl=0x${Hexadecimal(decoded.raw(111, 96))} dest=0x${Hexadecimal(decoded.destRaw)} src1=0x${Hexadecimal(decoded.src1Raw)} src2=0x${Hexadecimal(decoded.src2Imm)} ext=0x${Hexadecimal(decoded.immExt)}\\n")
      running := false.B
      abortPending := true.B
      abortStatus := 1.U
    }.elsewhen (consumeUnsupported) {
      // Any other legal instruction reaching an unconnected backend is also a
      // hard integration failure.  It must never be reported as INVALID.
      unsupportedTrap := true.B
      unsupportedPc := pc(issueWarp); unsupportedWarp := issueWarp
      unsupportedOpcode := decoded.opcode; unsupportedDtype := decoded.dtype
    }

    operandStores(s).io.capture.valid := bank.io.response.fire
    operandStores(s).io.capture.bits.slot := MuxLookup(pipeState(s), 0.U, Seq(
      pipeReadA -> 0.U, pipeReadB -> 1.U, pipeReadC -> 2.U,
      pipeReadAHi -> 3.U, pipeReadBHi -> 4.U, pipeReadCHi -> 5.U))
    operandStores(s).io.capture.bits.data := bank.io.response.bits.data

    when (bank.io.response.fire && pipeState(s) === pipeReadA) {
      pipeState(s) := pipeReadB
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadB) {
      pipeState(s) := pipeReadC
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadC) {
        when (held(s).opcode === AecOpcode.shuf) {
          val participants = heldExecute(s) & held(s).immExt
          val shufValue = held(s).src2Imm(4, 0)
          for (lane <- 0 until 32) {
            val source = MuxLookup(held(s).subop, shufValue, Seq(
              0.U -> shufValue,
              1.U -> (lane.U(6.W) - shufValue),
              2.U -> (lane.U(6.W) + shufValue),
              3.U -> (lane.U(6.W) ^ shufValue)))
            val sourceInRange = source < 32.U && participants(source(4, 0))
            writeScratch(s)(lane).io.writeLow := true.B
            writeScratch(s)(lane).io.lowIn := Mux(participants(lane),
              Mux(sourceInRange, operandA(s)(source(4, 0)), operandA(s)(lane)), 0.U)
          }
          pipeState(s) := pipeWrite
        }.elsewhen (held(s).opcode === AecOpcode.vote) {
          val active = heldExecute(s)
          val voteAll = ((~active) | bank.io.predMask).andR
          val voteAny = (active & bank.io.predMask).orR
          val voteUni = !(active & bank.io.predMask).orR || !((active & ~bank.io.predMask).orR)
          val voteResult = MuxLookup(held(s).subop, voteAll, Seq(0.U -> voteAll, 1.U -> voteAny, 2.U -> voteUni))
          for (lane <- 0 until 32) {
            writeScratch(s)(lane).io.writeLow := true.B
            writeScratch(s)(lane).io.lowIn := voteResult
          }
          writePredicates(s) := Fill(32, voteResult)
          pipeState(s) := pipeWrite
        }.elsewhen (held(s).opcode === AecOpcode.mtch) {
          matchLane(s) := 0.U; pipeState(s) := pipeMatch
        }.elsewhen (held(s).opcode === AecOpcode.rdtsc) {
          for (lane <- 0 until 32) {
            writeScratch(s)(lane).io.writeLow := true.B
            writeScratch(s)(lane).io.lowIn := cycles(31, 0)
          }
          pipeState(s) := pipeWrite
        }.elsewhen (heldLoadi64) {
          for (lane <- 0 until 32) {
            writeScratch(s)(lane).io.writeLow := true.B
            writeScratch(s)(lane).io.lowIn := held(s).immExt
            writeScratch(s)(lane).io.writeHigh := true.B
            writeScratch(s)(lane).io.highIn := held(s).src2Imm
          }
          pipeState(s) := pipeWrite
        }.elsewhen (heldNeedsPairRead) {
          pipeState(s) := pipeReadAHi
        }.otherwise {
          pipeState(s) := Mux(heldCvt, pipeCvt,
            Mux(heldSpecialCpy, pipeCoord, Mux(heldMemory, pipeMemStart, pipeDispatch)))
          when (heldCvt || heldSpecialCpy) { cvtLane(s) := 0.U }
        }
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadAHi) {
      pipeState(s) := pipeReadBHi
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadBHi) {
      pipeState(s) := pipeReadCHi
    }
    when (bank.io.response.fire && pipeState(s) === pipeReadCHi) {
        when (held(s).opcode === AecOpcode.cpy) {
          for (lane <- 0 until 32) {
            writeScratch(s)(lane).io.writeLow := true.B
            writeScratch(s)(lane).io.lowIn := operandA(s)(lane)
            writeScratch(s)(lane).io.writeHigh := true.B
            writeScratch(s)(lane).io.highIn := operandAHi(s)(lane)
          }
          pipeState(s) := pipeWrite
        }.otherwise {
          pipeState(s) := Mux(heldCvt, pipeCvt, Mux(heldMemory, pipeMemStart, pipeDispatch))
          cvtLane(s) := 0.U
        }
    }
    when (backend.io.accepted) { pipeState(s) := pipeIdle }
    when (pipeState(s) === pipeCvt) {
      for (lane <- 0 until 32) {
        when (cvtLane(s) === lane.U) {
          writeScratch(s)(lane).io.writeLow := true.B
          writeScratch(s)(lane).io.lowIn := cvt.io.out(31, 0)
          writeScratch(s)(lane).io.writeHigh := true.B
          writeScratch(s)(lane).io.highIn := cvt.io.out(63, 32)
        }
      }
      when (cvtLane(s) === 31.U) { pipeState(s) := pipeWrite }
        .otherwise { cvtLane(s) := cvtLane(s) + 1.U }
    }
    when (pipeState(s) === pipeCoord) {
      coordRequest(s) := true.B
    }
    when (pipeState(s) === pipeMatch) {
      val matchResult = VecInit((0 until 32).map(other =>
        heldExecute(s)(other) && operandA(s)(other) === operandA(s)(matchLane(s)))).asUInt
      for (lane <- 0 until 32) {
        when (matchLane(s) === lane.U) {
          writeScratch(s)(lane).io.writeLow := true.B
          writeScratch(s)(lane).io.lowIn := matchResult
        }
      }
      when (matchLane(s) === 31.U) { pipeState(s) := pipeWrite }
        .otherwise { matchLane(s) := matchLane(s) + 1.U }
    }
    when (lsu.io.start.fire) {
      val issuingRobCount = Mux(heldWarp(s)(0), robs(s * 2 + 1).io.count, robs(s * 2).io.count)
      assert(!heldStore && !heldAtomic || issuingRobCount === 1.U,
        "store/atomic side effects require a sole serializing ROB entry")
      gmemTag(s) := heldTag(s)
      pipeState(s) := pipeIdle
    }

    completionCandidates(s)(5).valid := pipeState(s) === pipeWrite
    completionCandidates(s)(5).bits.tag := heldTag(s)
    completionCandidates(s)(5).bits.data := VecInit((0 until 32).map(lane => Cat(writeHiData(s)(lane), writeData(s)(lane))))
    completionCandidates(s)(5).bits.predicateData := writePredicates(s)
    completionCandidates(s)(5).bits.error := false.B
    when (pipeState(s) === pipeWrite && completionArbiters(s).io.in(5).ready) {
      pipeState(s) := pipeIdle
    }
  }

  coordinate.io.blockX := launchBlockX; coordinate.io.blockY := launchBlockY; coordinate.io.blockZ := launchBlockZ
  coordinate.io.gridX := launchGridX; coordinate.io.gridY := launchGridY; coordinate.io.gridZ := launchGridZ
  coordinate.io.ctaX := ctaX; coordinate.io.ctaY := ctaY; coordinate.io.ctaZ := ctaZ
  for (s <- 0 until schedulerCount) {
    coordinate.io.requests(s).valid := coordRequest(s)
    coordinate.io.requests(s).bits.special := held(s).src1Raw
    coordinate.io.requests(s).bits.linearLane := ((heldWarp(s) << 5) + cvtLane(s))(7, 0)
    coordinate.io.requests(s).bits.startLane := cvtLane(s)
    coordinate.io.responses(s).ready := true.B
    when (coordinate.io.responses(s).fire) {
      val lane = coordinate.io.responses(s).bits.lane
      for (target <- 0 until 32) {
        when (lane === target.U) {
          writeScratch(s)(target).io.writeLow := true.B
          writeScratch(s)(target).io.lowIn := coordinate.io.responses(s).bits.data
          writeScratch(s)(target).io.writeHigh := true.B
          writeScratch(s)(target).io.highIn := 0.U
        }
      }
      cvtLane(s) := lane + 1.U
      when (coordinate.io.responses(s).bits.last) { pipeState(s) := pipeWrite }
    }
  }

  // With one scheduler the resident-memory LSU is connected directly; no
  // request owner or four-way completion routing remains.
  localMemory.io.start.valid := localRequestValid(0)
  localMemory.io.start.bits := localRequests(0)
  when (localMemory.io.start.fire) {
    val issuingRobCount = Mux(heldWarp(0)(0), robs(1).io.count, robs(0).io.count)
    assert(!(held(0).opcode === AecOpcode.st || held(0).opcode === AecOpcode.atom) || issuingRobCount === 1.U,
      "local store/atomic side effects require a sole serializing ROB entry")
    localTag := heldTag(0)
    pipeState(0) := pipeIdle
  }
  completionCandidates(0)(6).valid := localMemory.io.done.valid
  completionCandidates(0)(6).bits.tag := localTag
  completionCandidates(0)(6).bits.data := localMemory.io.done.bits.loadData
  completionCandidates(0)(6).bits.predicateData := 0.U
  completionCandidates(0)(6).bits.error := localMemory.io.done.bits.error
  localMemory.io.done.ready := completionArbiters(0).io.in(6).ready

  for (s <- 0 until schedulerCount) {
    val completion = completionArbiters(s).io.out
    val narrowCompletion = Wire(new AecRobCompletion)
    narrowCompletion.tag := completion.bits.tag
    narrowCompletion.predicateData := completion.bits.predicateData
    narrowCompletion.error := completion.bits.error
    when (completion.valid) {
      when (completion.bits.tag.warp(0)) {
        robs(s * 2 + 1).io.completion.valid := true.B
        robs(s * 2 + 1).io.completion.bits := narrowCompletion
      }.otherwise {
        robs(s * 2).io.completion.valid := true.B
        robs(s * 2).io.completion.bits := narrowCompletion
      }
    }
    val completionAccepted = Mux(completion.bits.tag.warp(0),
      robs(s * 2 + 1).io.completionAccepted, robs(s * 2).io.completionAccepted)
    resultStores(s).io.write.valid := completion.valid && completionAccepted
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
  for (s <- 0 until schedulerCount) {
    barrier.io.arrive(s).valid := syncArriveValid(s)
    barrier.io.arrive(s).bits := syncArriveWarp(s)
    when (syncArriveValid(s)) {
      assert(Mux(syncArriveWarp(s)(0), robs(s * 2 + 1).io.empty, robs(s * 2).io.empty),
        "barrier arrival requires all older ROB entries to retire")
    }
  }
  for (s <- schedulerCount until 4) {
    barrier.io.arrive(s).valid := false.B
    barrier.io.arrive(s).bits := 0.U
  }
  when (barrier.io.duplicate) { running := false.B; abortPending := true.B; abortStatus := 2.U }
  when (barrier.io.release.orR) {
    for (w <- 0 until 8) {
      when (barrier.io.release(w)) { pc(w) := pc(w) + 1.U; warpState(w) := 1.U }
    }
  }
  lineCache.io.cpuRequest <> gmemLsus(0).io.lineOut
  gmemLsus(0).io.lineComplete <> lineCache.io.cpuCompletion
  externalMemory.io.lineIn <> lineCache.io.memoryRequest
  lineCache.io.memoryCompletion <> externalMemory.io.lineComplete
  externalMemory.io.memReqReady := io.mem_req_ready
  externalMemory.io.memRspValid := io.mem_rsp_valid
  externalMemory.io.memRspRdata := io.mem_rsp_rdata
  externalMemory.io.memRspTag := io.mem_rsp_tag
  externalMemory.io.memRspError := io.mem_rsp_error
  io.mem_req_valid := externalMemory.io.memReqValid
  io.mem_req_space := externalMemory.io.memReqSpace
  io.mem_req_write := externalMemory.io.memReqWrite
  io.mem_req_addr := externalMemory.io.memReqAddr
  io.mem_req_wdata := externalMemory.io.memReqWdata
  io.mem_req_wstrb := externalMemory.io.memReqWstrb
  io.mem_req_tag := externalMemory.io.memReqTag
  io.mem_rsp_ready := externalMemory.io.memRspReady

  val allDone = VecInit((0 until 8).map(w => warpState(w) === 3.U)).asUInt.andR
  when (abortPending && externalMemory.io.outstanding === 0.U && !resultValid) {
    abortPending := false.B
    resultValid := true.B
    resultStatus := abortStatus
  }
  when (running && !restartCta && allDone && externalMemory.io.outstanding === 0.U) {
    assert(robs.map(_.io.empty).reduce(_ && _), "CTA completion requires empty ROBs")
    when (ctaX + 1.U < launchGridX) {
        ctaX := ctaX + 1.U; ctaThreadBase := ctaThreadBase + launchThreads; restartCta := true.B
      }
      .elsewhen (ctaY + 1.U < launchGridY) {
        ctaX := 0.U; ctaY := ctaY + 1.U; ctaThreadBase := ctaThreadBase + launchThreads; restartCta := true.B
      }
      .elsewhen (ctaZ + 1.U < launchGridZ) {
        ctaX := 0.U; ctaY := 0.U; ctaZ := ctaZ + 1.U; ctaThreadBase := ctaThreadBase + launchThreads; restartCta := true.B
      }
      .otherwise { running := false.B; resultValid := true.B; resultStatus := 0.U }
  }
  io.result_valid := resultValid
  io.result_status := resultStatus
  io.result_cycles := cycles
  when (resultValid && io.result_ready) {
    resultValid := false.B; loadError := false.B; abortPending := false.B
    restartCta := false.B; unsupportedTrap := false.B; unsupportedAssert := false.B
    for (s <- 0 until schedulerCount) { pipeState(s) := pipeIdle; fetchPending(s) := false.B; decodeValid(s) := false.B }
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
  val stage = new chisel3.stage.ChiselStage
  stage.emitSystemVerilog(new AecEvalCore, Array("--target-dir", "sv/generated/eval_core"))
}
