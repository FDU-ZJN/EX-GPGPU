# ASAP7 Compute Unit Timing Assessment

## Scope and methodology

The four current warp-facing compute units were independently synthesized and
timed at a 2,000 ps target period (500 MHz):

| Unit | Top | Physical lanes |
|---|---|---:|
| INT32 | `AecEightLaneIntUnit` | 16 |
| FP32 | `AecFp32Unit` | 16 |
| FP64 | `AecFp64Unit` | 2 |
| DIV/SFU | `AecSfuWarpUnit` | 1 |

The flow used Yosys `0.64+308` (`78e05dfb0`), ABC, OpenSTA `3.1.0`,
and ASAP7 7.5-track RVT TT NLDM libraries. The five AO, INVBUF, OA, SEQ,
and SIMPLE Liberty archives were loaded separately. Timing uses ideal clocks
and has no extracted wire parasitics. No switching VCD was supplied, so power
and complete PPA validity are false while the timing reports are valid.

## Results

| Unit | Area (um2) | Cells | Critical path (ps) | Fmax (MHz) | 500 MHz |
|---|---:|---:|---:|---:|---|
| INT32 | 11,376.38 | 135,012 | 218,528.80 | 4.58 | Fail |
| FP32 | 25,582.78 | 308,265 | 219,876.31 | 4.55 | Fail |
| FP64 | 12,628.15 | 141,548 | 403,784.66 | 2.48 | Fail |
| DIV/SFU | 7,377.54 | 82,529 | 279,662.97 | 3.58 | Fail |

These Fmax values are not the intrinsic arithmetic-core frequencies. Every
reported worst path is a warp request/control path with only a few logic
levels followed by an extremely overloaded minimum-drive inverter:

| Unit | Worst observed load (fF) | Dominant single-cell delay (ps) |
|---|---:|---:|
| INT32 | 2,377 | 205,865 |
| FP32 | 2,346 | 206,984 |
| FP64 | 4,653 | 391,333 |
| DIV/SFU | 3,122 | 267,096 |

The RTL captures a complete `AecExecRequest` in one edge and also clears wide
result/flag arrays in one state transition. Synthesis shares the capture and
clear predicates across thousands of register data muxes. ABC does not repair
the fanout created when these networks are reconnected across register
boundaries, so OpenSTA exposes multi-pF loads on minimum-drive cells. A normal
physical-design flow would insert buffer trees, but relying only on that is
not sufficient for a defensible 500 MHz target.

## Optimization plan

### P0: Warp wrapper control distribution

1. Replace each monolithic `held := io.req.bits` with 32 lane banks. Register
   and preserve local capture strobes per lane and per operand so one control
   net drives at most 64 data bits. Add a capture state because latency is not
   constrained.
2. Stop clearing all 32 result and exception entries on every request and
   response. Track a valid/write mask and overwrite only retired lanes.
3. Replicate the state decode locally at each bank with `dontTouch` or an
   explicit hierarchy so synthesis cannot merge all local enables back into a
   single high-fanout net.
4. Add a fanout-aware physical stage, preferably OpenROAD `repair_design`,
   before signoff STA. Enforce max fanout and max transition constraints and
   use the post-repair netlist for timing.

This work is mandatory before arithmetic datapath timing can be measured
meaningfully. The first acceptance criterion is that no data/control pin sees
more than the chosen fanout limit and no slew exceeds the characterized table.

### P1: Reduce physical parallelism

Because throughput and latency are not objectives, configure INT32 and FP32
to one physical lane and retain one FP64 and one SFU lane. This removes 15
duplicated INT/FP32 datapaths and makes operand/result selection local. It
also reduces the number of destinations driven by ready/valid/state control.

### P2: Datapath-specific timing

- INT32: make multiply iterative and split variable shift into 8/4/2/1 stages
  or a multi-cycle shifter. Register compare/select results before retirement.
- FP32: retain one FMA and add registers between exponent alignment,
  significand multiply/add, leading-zero normalization, and final rounding.
- FP64: use one lane and similarly isolate alignment, 53-bit significand
  arithmetic, normalization, and rounding. Avoid a same-cycle format-select
  mux after rounding.
- DIV/SFU: the 53-bit DIV/SQRT core is already iterative. Replace the remaining
  combinational 48x48 Q34 multiplier with a shift-add or 16x16 chunked
  multi-cycle multiplier, and make leading-zero/packing an iterative step.

### P3: Re-evaluation gates

1. Re-run unit differential tests after every pipeline or multi-cycle change.
2. Re-run ASAP7 timing with 2,000 ps, then 1,800 ps to retain margin for clock
   uncertainty and routed interconnect.
3. Require positive setup slack, bounded transition/fanout, no unconstrained
   endpoints, and post-route rather than logic-only STA before claiming
   500 MHz.

Detailed reports and mapped netlists are under `rtl/reports/ppa_units/`.
