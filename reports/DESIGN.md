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

GMEM is owned by the external harness, as required by the interface. The DUT
issues 128-byte tagged requests through a 16-tag memory engine; it does not
maintain a full GMEM mirror. The local runner creates requested dumps directly
from its authoritative backing vector after completing the result handshake.

The conservative GMEM LSU serializes participating lanes. Stores first issue
side-effect-free preflight reads for every touched line, then replay writes only
after all accesses succeed. Atomics execute as serialized read-modify-write
transactions in ascending lane order. SMEM/LMEM/CMEM/PMEM are implemented by
the local LSU; stores precheck all executing lanes before the write phase.
CMEM/PMEM preload ports apply byte strobes.

All resident data arrays use the locked Track-B `aec_sram_1024x32` wrapper
(`srambank_256x4x32_6t122`). IMEM uses four 32-bit slices per 128-bit row and
is replicated once per scheduler read port. Each GPR partition keeps two
identical SRAM copies for its two reads and broadcasts every write to both.
SMEM, LMEM, the LMEM generation tags, CMEM and PMEM use depth banking. The
single-port local-memory sequencer performs explicit read-modify-write cycles
for byte stores and masked CMEM/PMEM preload beats; it never asserts native
`read` and `write` together. Architectural launch-zero behavior is provided by
valid/generation metadata because the native macros have no reset.

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
deterministic ordering, at the cost of lane-serialized latency. Generated RTL
is checked in for evaluator reproducibility, while Chisel remains the source of
truth.
