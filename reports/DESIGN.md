# Design

## Architecture

`aec_eval_top` implements the AEC functional interface defined by
`Track-B/spec.md`. The SystemVerilog adapter in
`rtl/sv/aec_eval_top.sv` preserves the contest ABI and instantiates
the Chisel-generated `AecEvalTop`. The separate simulation-only
`aec_eval_debug_top` exposes commit signals to the local Verilator harness;
those signals are absent from the judged `aec_eval_top` port list.

The core keeps one resident CTA with up to eight warps. Four scheduler
partitions each arbitrate two warps. Each partition has a register-bank view,
destination scoreboard, operand collection state machine, vector execution
ports, and retirement path. Instructions retire at warp granularity; predicate
guards form an execute mask from the pre-instruction predicate state.

Each resident warp owns a four-entry ROB. Issue reserves the true GPR/predicate
dependencies and advances the fetch PC; a backend captures a sideband tag and
releases the partition frontend as soon as its request is accepted. INT, FP,
SFU and load completions may therefore arrive out of order, while a per-
partition arbiter commits only a ready ROB head. Register pairs lock two commit
cycles. Epoch matching discards completions left behind by abort or CTA reset.
Branches, barriers, stores and atomics remain serializing and wait for the
older ROB state to drain.

The validator checks canonical opcode/type/control/MBZ encodings before any
backend or control-flow side effect. Register pairs reserve and release both
GPRs. Dynamic execution errors terminate with `EXEC_ERROR`; malformed
encodings terminate with `INVALID`.

## Execution units

Integer operations use four eight-lane groups and aggregate lane result,
predicate, and error masks. FP16/BF16/FP32 and FP64 operations use vector
wrappers around pipelined scalar units. Conversion is lane-serialized to keep
width, signedness, truncation, saturation, NaN, and infinity handling explicit.
DIV and SFU requests use the multi-cycle warp SFU engine. SHUF, VOTE, MTCH and
RDTSC are handled as collective operations using the instruction-start mask.

## Memory system

GMEM and LMEM are owned by two independent backing stores in the external
service. Every 128-byte tagged request carries `mem_req_space` (`0=GMEM`,
`1=LMEM`). A one-entry request holding register reserves the tag before
presenting the request and keeps space/write/address/data/strobe/tag stable
under backpressure. Completion routing recovers space and warp ownership from
the tag table; the DUT does not maintain a full mirror of either space.

LMEM addresses follow the QA x-fastest mapping. The CTA-linear thread base is
combined with `warp*32+lane`, multiplied by 4096, and added to the thread-local
offset. Accesses crossing the 4 KiB per-thread boundary fail before any line
request. The runner uses a sparse LMEM line map, clears it for each launch, and
keeps it independent from artifact-derived GMEM storage.

The external LSU coalesces warp accesses by 128-byte line. Stores first issue
side-effect-free preflight reads for every touched line, then replay writes only
after all accesses succeed. Atomics apply active lanes in ascending order to a
coalesced GMEM line read-modify-write. ATOM encodes ADD/MAX/MIN/XCHG/AND/OR/XOR/
CAS as 0 through 7; failed CAS lanes produce no write strobe and an all-failed
line skips its write request. SMEM/CMEM/PMEM are implemented by the local LSU;
stores precheck all executing lanes before the write phase. CMEM/PMEM preload
ports apply byte strobes and track the enabled-byte high-water capacity.

Resident arrays use locked Track-B SRAM wrappers. IMEM uses four 1024x32 slices
per 128-bit row and is replicated once per scheduler read port. Each GPR
partition uses 32 lane-local 512x32 banks, so one source read returns a complete
warp and predicated vector writeback drives lane write enables independently.
SMEM, CMEM and PMEM use depth banking. Internal LMEM data and generation-tag
SRAMs have been removed. The single-port resident-memory sequencer performs
explicit read-modify-write cycles for byte stores and masked CMEM/PMEM preload
beats; it never asserts native `read` and `write` together. SMEM launch-zero
behavior is provided by valid metadata because the native macros have no reset.

## Generation and third-party sources

The judged generated RTL is reproduced by:

```bash
make -C rtl eval-generate
```

The source tree vendors Berkeley HardFloat 1.5 under
`rtl/src/main/scala/hardfloat/` with its license, and floating-point sources
derived from THU-DSP-LAB FPUv2/Fudian under `rtl/src/main/scala/FPUv2/` and
`rtl/src/main/scala/fudian/`. AEC-specific wrappers, metadata transport,
validation, scheduling, memory, and retirement logic live under
`rtl/src/main/scala/aec/`. The external `local/` development checkouts are not
build dependencies and are excluded from submission.

## Main tradeoffs

Correctness is prioritized over throughput in the LSU, atomic engine and
conversion path. This gives precise no-side-effect error behavior and simple
deterministic ordering, at the cost of lane-serialized latency. A single wide
operand collector is retained per partition; backend wait latency is hidden,
but a busy same-class backend can still create head-of-line frontend pressure.
Generated RTL
is checked in for evaluator reproducibility, while Chisel remains the source of
truth.
