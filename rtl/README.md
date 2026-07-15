# AEC GPGPU RTL

The Chisel source in `src/main/scala/aec/fp` is the source of truth and uses
the vendored Berkeley HardFloat 1.5 sources in `src/main/scala/hardfloat`.
With the reference toolchain, generate the checked-in SystemVerilog with:

```sh
sbt "runMain aec.fp.Generate"
```

The generated integration tops are `AecFp32Unit`, `AecFp64Unit`, and
`AecIntUnit`. Each has one warp-level Decoupled request/response interface:
the request carries a 32-bit active mask and 32 lane operands, and the
response carries 32 lane results plus predicate, error, and exception masks.
All architectural operations use round-to-nearest-even for floating point.

The floating-point datapath is also emitted as two specialized tops:
`AecFp32Unit` uses an f32 FMA backend and accepts f32/f16/bf16 requests;
`AecFp64Unit` uses the f64 backend, while `AecIntUnit` provides the matching
integer execution port. The scalar pipes are private implementation details;
the specialized RTL is generated under `sv/generated/fp32/`, `sv/generated/fp64/`,
and `sv/generated/int/` and linted independently so their helper module names do
not collide.

Run the split differential streams independently:

```sh
make -C rtl fp32-diff COUNT=1000 SEED=20260713 BACKPRESSURE=45
make -C rtl fp64-diff COUNT=1000 SEED=20260713 BACKPRESSURE=45
```

The fp32 stream consumes f16/bf16/f32 rows; the fp64 stream consumes f64 rows.

## Development targets

`make -C rtl build`, `generate`, `lint`, `synth`, `diff`, and `test` provide
the complete local flow.  `diff` generates a new vector file from
`cmodel/core/values.py`, drives it through the Verilated generated RTL, and
compares bit patterns.  It is reproducible and scalable:

```sh
make -C rtl diff COUNT=1000 SEED=20260713
```

`BACKPRESSURE` controls the percentage of random cycles in which the response
channel is stalled (default 35).  The Verilator harness continuously issues
mixed requests, keeps an independent expected FIFO, and therefore checks both
bit patterns and in-order retirement rather than only one-operation-at-a-time
behaviour:

```sh
make -C rtl diff COUNT=1000 SEED=20260713 BACKPRESSURE=45
```

## Yosys PPA reports

`make -C rtl ppa` writes synthesis reports to `rtl/reports/yosys/` and is part
of `make test`.  Without `ASAP7_ROOT` it produces only a clearly labelled
generic CMOS structural proxy.  For formal PPA, point the flow at the ASAP7
checkout; the five NLDM archives are extracted independently for ABC and
OpenSTA:

```sh
make -C rtl ppa ASAP7_ROOT=/path/to/asap7sc7p5t_28 PERIOD_PS=500
```

The contest-facing entry point is `scripts/run_ppa.sh --output <dir>`.  Use
`--top` and `--rtl-sources` for the spec `aec_eval_top` submission, and pass
`--activity-vcd <simulation.vcd>` to enable the OpenSTA power report.  Without
activity, timing and area are still reported, but `ppa_valid=false` because
the spec-defined power metric is unavailable.

With the default `PPA_STRICT=1`, missing libraries, incomplete mapping, failed
linking, or invalid timing results return failure.  `PPA_STRICT=0` retains
diagnostic artifacts but never labels an invalid run as formal PPA.

## Pipeline organisation

The f16, bf16, f32 and f64 ADD/SUB/MUL/FMA paths are separate parameterized
fudian/FPUv2 pipelines.  Each request carries a six-bit internal issue tag;
the top-level issue queue releases only the completed tag at its head, so a
short operation can never bypass an older DIV/SQRT.  The f32 and f64
HardFloat DIV/SQRT engines are multi-cycle and their pulse-style completion is
captured in a holding register before it reaches the Decoupled response port.

The imported sources are derived from THU-DSP-LAB/fpuv2 (including its fudian
submodule); AEC-specific changes are limited to metadata transport, canonical
interface adaptation, and the FMA overflow-sign fix in `fudian`.

The required scripts in `../scripts/` build the CModel and contest-facing RTL.
The generated-vector format is data-driven, so CI may provide a persistent
vector file with `rtl/scripts/run_fp_diff.sh --vectors`.

## AEC contest-facing core

`src/main/scala/aec/frontend/EvalTop.scala` provides the contest-facing core.
The initial implementation was an eight-warp high-performance design. After
the PPA runtime and synthesis-scale limitation became clear, the submission
uses one round-robin scheduler and two resident warp slots. Up to eight
architectural CTA warps are supported by pair rebinding. The core contains a
two-warp register bank and scoreboard, two four-entry ROBs, CTA barrier state,
local memory, a pipelined GMEM LSU, a 64 KiB line cache, and a 16-tag external
memory engine. Integer, FP32/FP64, conversion, collective, DIV/SFU, local LSU,
and GMEM/atomic paths share ordered retirement. `AecEvalCore` is adapted to
the required active-low-reset `aec_eval_top` by `sv/aec_eval_top.sv`.

```sh
make -C rtl eval-generate
make -C rtl eval-lint
```

The local Verilator harness optionally embeds the CModel and compares
retirements in real time. It is testbench-only and is not instantiated in the
judged hierarchy.
