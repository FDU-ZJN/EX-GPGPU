# Verification

## Required flows

```bash
scripts/build.sh
scripts/run_cmodel.sh --case <case.yaml> --output <dir>
scripts/run_rtl.sh --case <case.yaml> --output <dir>
scripts/run_tests.sh --suite public --output <dir>
scripts/run_ppa.sh --output <dir> --asap7-root <asap7sc7p5t_28>
```

All generated artifacts are written under `build/` or the caller-selected
output directory.

## Realtime differential test

`scripts/run_diff.sh` embeds the Python CModel through the C++ API in the
Verilator process. Retirement queues are independent per `(CTA x/y/z, warp)`
so legal scheduler interleaving does not create false mismatches. At every RTL
retirement it checks PC, the complete 128-bit instruction, execute mask, and
reported per-lane GPR or predicate values. The simulator stops on the first
difference.

At completion it also checks RTL versus CModel result status, absence of
unmatched CModel retirement events, and every byte of the authoritative 1 MiB
GMEM vector. Manifest verification then checks expected status and each
published GMEM dump using the declared exact or floating-point policy. RDTSC
absolute values are intentionally excluded from exact comparison per
`spec.md`; downstream architectural effects and final GMEM remain checked.

The fail-fast full suite is:

```bash
scripts/run_realtime_diff_tests.sh \
  --suite all \
  --max-cycles 10000 \
  --output /tmp/aec-realtime
```

The recorded run used one shared Verilator build and passed all 36 discovered
public-package cases. Its compact summary is
`evidence/public_realtime_summary.json`. A status string of `fail` is a valid
expected EXEC_ERROR result for a negative testcase; testcase success is the
separate `passed` verdict.

## Additional checks

The following were run after the SRAM/vector/coalescer optimization:

- Verilator `eval-lint` passed without RTL warnings.
- Chisel `SpecBugFixSpec` passed 8/8, including four-way barrier arrival and
  a 64-bit load crossing a 128-byte line.
- Public RTL regression passed 36/36 with each manifest's native cycle budget.
  Representative cycles: ABI smoke 159, ADD 406, LD 286, ST 282, ATOM 372,
  DIV 574, RCP 853, GEMM 936.
- Python CModel unit tests passed 14/14.
- `git diff --check` passed.

Use `scripts/check_submission.sh` to validate entry points, parse every shell
and Python script, reject caches/local checkouts/build products from the
candidate archive, and enforce the required report structure.

## Coverage boundary

The public package is not exhaustive specification coverage. RTL/CModel
differential agreement can miss a semantic error shared by both models. Pair
high-word debug visibility and some omitted-write cases are observed indirectly
through later architectural behavior and final GMEM. These constraints are
also listed in `reports/LIMITATIONS.md`.
