# Repository Guidelines

## Project Structure & Module Organization

`Track-B/` is the GPGPU RTL design challenge and reference package.
Read `Track-B/spec.md` for the AEC ISA and interface contract and
`Track-B/scoring.md` for evaluation criteria. The locked ASAP7 SRAM wrappers and
checksums are in `Track-B/sram/`. Public inputs, manifests, AEC programs,
generated binaries, and expected memory dumps are under
`Track-B/testcases/tests/aec_cases/`; `PUBLIC_CASES.txt` is the authoritative
case list. A participant implementation should add `rtl/`, `cmodel/`,
`scripts/`, `reports/`, and `evidence/` at the submission root as described in
README.

## Build, Test, and Development Commands

The specification defines these required entry points once an implementation is
present:

```bash
scripts/build.sh
scripts/run_cmodel.sh --case <case.yaml> --output <output-dir>
scripts/run_rtl.sh --case <case.yaml> --output <output-dir>
scripts/run_tests.sh --suite public --output <output-dir>
scripts/run_ppa.sh --output <output-dir>
```

Use the first command to build both models, the next two for single-case
comparison, and `run_tests.sh` for public regression. Keep generated logs,
dumps, and synthesis results in the selected output directory, not beside
source files.

## Development Environment

Use the official toolchain baseline for evaluation:

| Tool | Baseline |
|---|---|
| Verilator | 5.049 devel, `v5.048-179-gc878a7e73` |
| Yosys | 0.64+308, commit `78e05dfb0` |
| OpenSTA | `v2.2.0-2121-g66c29303` |
| GCC/G++ | 13.3.0 |
| Python | 3.12.3 |
| ASAP7 | PDK 1.7, 7.5-track v28, RVT TT NLDM |
| ASAP7 SRAM | `asap7_sram_0p0` |

The official sources are Verilator, Yosys, OpenSTA, and ASAP7 on GitHub.
Higher compatible versions are acceptable for development, but final scoring
uses the locked libraries and versions above. Do not depend on network access
or unpinned package downloads during evaluation.

## Coding Style & Naming Conventions

Use synthesizable SystemVerilog for judged RTL and keep testbench-only behavior
out of the judged hierarchy. Use clear lower_snake_case file and signal names,
UpperCamelCase for module/type names, and consistent clock/reset naming. Keep
CModel and RTL behavior aligned with the precise ISA, including memory spaces,
warp/CTA execution, barriers, and error behavior. Preserve the supplied SRAM
wrappers and timing/area/power views unchanged.

## Testing Guidelines

Each case directory uses `case.yaml`, `program.bin`/`program.hex`, optional
`input/`, and `expected/` artifacts. Add focused cases under the matching
`<category>/<case-name>/` path and update manifests when appropriate. Validate
both CModel and RTL with the same launch parameters and memory images; compare
the required result files and GMEM dumps, including boundary and partial-warp
behavior.

## Commit & Pull Request Guidelines

Git history is unavailable in this checkout, so follow concise,
imperative commit subjects (for example, `Add warp barrier handling`). PRs
should explain the architectural change, list commands and public cases run,
include relevant logs or screenshots for waveform/PPA changes, and document any
third-party or generated sources. Do not commit build caches, waveform dumps,
large packages, undeclared IP, or generated RTL without its reproducible source
and command.

## Security & Reproducibility

Never special-case testcase IDs, filenames, hashes, or fixed outputs. Keep
dependencies vendored or tied to the official environment, record versions and
generation commands, and ensure a clean checkout can reproduce every result.
