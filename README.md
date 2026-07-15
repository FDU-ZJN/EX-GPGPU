# ZGPGPU

FDU ZGPGPU AEC GPGPU implementation. The submission contains synthesizable
Chisel/SystemVerilog RTL, a Python functional model with a C++ embedding API,
the contest entry scripts, design/verification/PPA reports, and compact
reproducibility evidence.

The interface and ISA contract are [Track-B/spec.md](Track-B/spec.md). The
contest-facing RTL module is `aec_eval_top`; its port list and status encoding
are unchanged from the specification.

## Quick start

```bash
scripts/build.sh
scripts/run_tests.sh --suite public --output /tmp/zgpgpu-public
```

`scripts/build.sh` builds both the CModel C++ API and the Verilated
contest-facing RTL runner. It uses `nproc` for Make parallelism and writes
products under `build/`. The required single-model entry points are:

```bash
scripts/run_cmodel.sh --case Track-B/testcases/tests/aec_cases/abi/c0_smoke/case.yaml --output /tmp/cmodel-smoke
scripts/run_rtl.sh --case Track-B/testcases/tests/aec_cases/abi/c0_smoke/case.yaml --output /tmp/rtl-smoke
scripts/run_ppa.sh --output /tmp/ppa \
  --asap7-root /path/to/asap7sc7p5t_28 \
  --asap7-sram-root /path/to/asap7_sram_0p0
```

Every command keeps generated logs, dumps, waveforms, and build objects in the
selected output directory or `build/`; source directories remain clean.

## CModel/Chisel differential debug

Run the same testcase through the functional CModel and the Verilated Chisel
top, then compare architectural commits and final GMEM:

```bash
scripts/run_diff.sh \
  --case Track-B/testcases/tests/aec_cases/add/c1_normal_simt/case.yaml \
  --output /tmp/aec-add-diff
```

The command exits non-zero on a difference and writes `diff.json`, separate
model logs and outputs, JSONL commit traces, and the RTL `run.vcd` under the
selected output directory. Commit comparison is performed independently per
CTA/warp, so harmless scheduler timing differences do not affect alignment.

Run every discovered AEC testcase serially with the same realtime comparison:

```bash
scripts/run_realtime_diff_tests.sh --suite all --output /tmp/aec-realtime-suite
```

The suite stops at the first failing retirement, status, or GMEM comparison.
It records the failing case, its artifact directory, and an exact reproduction
command in `summary.json`. Use `--suite public` for `PUBLIC_CASES.txt`, or
`--start-at tests/aec_cases/<category>/<case>` to resume at a testcase. Pass
`--build-dir <dir>` to reuse an existing Verilator runner build.

## Source of truth and regeneration

AEC RTL sources are under `rtl/src/main/scala/aec/`. The checked-in judged RTL
is reproducibly generated with:

```bash
make -C rtl eval-generate
```

`rtl/sv/generated/eval/AecEvalTop.sv` is wrapped only for the specified active-low
reset and ABI by `rtl/sv/aec_eval_top.sv`. The simulation harness
and embedded CModel API are outside the judged hierarchy.

## Submission contents

```text
rtl/       Chisel source plus the consolidated sv/ SystemVerilog source root
cmodel/    Python model and C++ embedding API
scripts/   required build/run/test/PPA entry points and submission checks
reports/   DESIGN, VERIFICATION, PPA and LIMITATIONS reports
evidence/  compact checked results; large generated artifacts stay external
Track-B/   locked specification, SRAM wrappers and public testcase package
```

Run `scripts/check_submission.sh` before packaging. To create a clean archive
from tracked plus non-ignored participant files:

```bash
scripts/package_submission.sh --output /tmp/zgpgpu-submission.tar.gz
```

Third-party RTL incorporated into `rtl/src/main/scala` is declared in
[reports/DESIGN.md](reports/DESIGN.md). Known verification and PPA boundaries
are recorded in [reports/LIMITATIONS.md](reports/LIMITATIONS.md).
