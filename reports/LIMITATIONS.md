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

- GMEM loads/stores and atomics are intentionally serialized by lane; stores
  add a complete preflight phase. This is functionally conservative but reduces
  memory throughput.
- Conversion and several multi-cycle functions favor small shared resources
  over maximum lane throughput.
- The runner uses a deterministic 1 MiB GMEM backing vector. Hidden evaluation
  may provide different legal memory contents through the same fixed ABI.

## PPA evidence

The checked historical PPA material in `reports/PPA.md` describes the flow and
an execution-unit development measurement. It is not a valid final score for
the full `aec_eval_top`. A formal submission measurement must use the locked
ASAP7 RVT TT NLDM libraries, the full judged hierarchy, a valid activity VCD,
and the exact command recorded by `scripts/run_ppa.sh`. Local library extracts,
mapped netlists and large waveforms are intentionally excluded from the source
archive and should be retained as external evidence for the final run.

## Compliance

- The contest-facing RTL ports and result status encoding are unchanged.
- GMEM is owned by the harness; no full GMEM mirror is included in the judged
  core.
- Testcase IDs, filenames, hashes and fixed expected outputs are not used by
  RTL or CModel execution.
- Locked SRAM wrappers under `Track-B/sram/` are unmodified.
- The build and evaluation flows require no network access once the documented
  JDK, SBT/Scala dependencies, Verilator, compiler and Python development files
  are present.
