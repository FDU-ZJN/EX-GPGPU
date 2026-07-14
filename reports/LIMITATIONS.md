# Limitations and compliance notes

## Functional verification

- The 36/36 result covers the complete currently published testcase package,
  not every legal operand, encoding, launch shape, or error combination in the
  ISA.
- CModel/RTL differential testing is not an independent formal proof; a shared
  semantic mistake can agree in both implementations.
- The current debug commit ABI carries the low destination payload directly.
  Pair high-word correctness is primarily checked by subsequent instructions
  and final GMEM rather than a separate high-word retirement payload.
- Online writeback checking follows the RTL-reported lane commit mask. Final
  status, remaining retirement events, downstream behavior, manifest dumps and
  full GMEM comparison provide additional coverage, but a completely latent
  omitted write is not independently observable.
- RDTSC values are model-local timing values. In accordance with `spec.md`, the
  realtime checker does not require exact CModel/RTL timestamp equality.

## Performance and implementation

- GMEM loads/stores are coalesced by 128-byte line and stores retain a complete
  preflight phase for precise errors. Requests from different coalesced lines
  within one warp instruction are still issued conservatively rather than all
  being outstanding at once.
- Each warp has a depth-4 ROB and backend wait time is hidden across sibling
  warps and independent same-warp instructions. Each partition intentionally
  retains one wide operand collector and one instruction per backend, so a
  busy same-class backend can still create head-of-line issue pressure.
- Conversion and several multi-cycle functions favor small shared resources
  over maximum lane throughput.
- GMEM/CMEM/PMEM capacities are derived from the maximum end of their init and
  expected artifacts; no artifact means zero capacity. Expected artifacts
  extend a range but never initialize it. Expected-only CMEM/PMEM extension is
  rejected because the published launch/load ABI has no capacity-announcement
  channel; CMEM/PMEM remain limited to 64 KiB.
- The external read ABI carries a 128-byte line address but no byte-use mask or
  GMEM capacity input. Consequently, a read wholly inside the rounded final
  service line cannot distinguish bytes below the exact capacity from tail
  bytes above it. The runner returns zero for such tail bytes and enforces the
  exact capacity on every strobed write byte. An official capacity/read-mask
  signal would be required for exact tail-read errors.

## PPA evidence

The checked historical PPA material in `reports/PPA.md` describes the flow and
an execution-unit development measurement. It is not a valid final score for
the full `aec_eval_top`. A formal submission measurement must use the locked
ASAP7 RVT TT NLDM libraries, the full judged hierarchy, a valid activity VCD,
and the exact command recorded by `scripts/run_ppa.sh`. Local library extracts,
mapped netlists and large waveforms are intentionally excluded from the source
archive and should be retained as external evidence for the final run.

## Compliance

- The QA-required `mem_req_space` request-payload port is present in judged and
  debug wrappers; result status encoding is unchanged.
- GMEM and LMEM are owned by independent harness stores; no full mirror is
  included in the judged core.
- Testcase IDs, filenames, hashes and fixed expected outputs are not used by
  RTL or CModel execution.
- Locked SRAM wrappers under `Track-B/sram/` are unmodified.
- The build and evaluation flows require no network access once the documented
  JDK, SBT/Scala dependencies, Verilator, compiler and Python development files
  are present.
