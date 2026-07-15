# Front-end source layout

- `EvalTop.scala`: contest I/O, program loading, launch state and the current
  fetch/decode/operand-collect/INT-dispatch/writeback orchestration.
- `FrontendTypes.scala`: fixed geometry, memory-space constants and cross-stage
  issue/writeback records.
- `RegisterFile.scala`: two-warp 2R1W GPR/predicate partition.
- `Scoreboard.scala`: per-warp register and predicate dependency tracking.
- `Control.scala`: CTA barrier and two-warp scheduler helpers.
- `MemoryEngine.scala`: 16-tag external-memory protocol adapter.
- `GmemPipeline.scala`: banked address generation, line coalescing, token
  routing, and load-result placement.
- `GmemLsu.scala`: precise store/atomic preflight and replay.
- `LineCache.scala`: 64 KiB direct-mapped load cache with registered queues.
- `WarpRob.scala`: two resident warp slots, each with four ordered entries.

All files intentionally use package `aec`: moving a Scala source into this
directory must not change the generated core module name (`AecEvalCore`).
