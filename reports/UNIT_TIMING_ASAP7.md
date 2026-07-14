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

## Baseline results

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

## Optimized results

The warp request buffer now uses lane-local 16-bit operand banks, result arrays
use write masks instead of full-array clears, INT multiply/shift/bitfield
operations are multi-cycle, and physical-lane metadata is locally encoded so
Yosys cannot merge every copy back into one register. The physical widths
remain INT32=16, FP32=16, FP64=2, and SFU=1.

| Unit | Area (um2) | Cells | Critical path (ps) | Fmax (MHz) | Improvement |
|---|---:|---:|---:|---:|---:|
| INT32 | 9,062.46 | 101,912 | 19,444.38 | 51.43 | 11.2x |
| FP32 | 25,188.29 | 303,899 | 22,353.18 | 44.74 | 9.8x |
| FP64 | 12,911.23 | 143,260 | 13,494.99 | 74.10 | 29.9x |
| DIV/SFU | 7,495.78 | 82,292 | 9,075.66 | 110.18 | 30.8x |

All four still fail 500 MHz. INT32 and FP32 remain dominated by shared wrapper
control nets: their worst mapped x1 drivers see approximately 1.0-1.1 pF and
feed another 0.45-0.51 pF stage. FP64 spends about 10.5 ns in a 272 fF/138 fF
control decode before entering the arithmetic cone. SFU no longer has a
single catastrophic request-capture load; its 9.1 ns path is a long mix of
control, iterative arithmetic, normalization, and packing logic.

Adding ABC `buffer` after mapping was evaluated and rejected. With the five
Liberty files loaded separately ABC did not detect a usable buffer gate early
enough, selected minimum-drive inverters, and degraded INT32 from 19.4 ns to
48.7 ns. A real fanout repair stage must therefore use a unified characterized
library or a physical synthesis tool such as OpenROAD, followed by timing on
the repaired netlist. The unsuccessful flow change is not retained.

## 100 MHz timing closure

The next optimization pass retained all 16/16/2/1 physical lanes and did not
serialize retirement. Each architectural result lane has a local result/flag
bank with a one-bit pending write control. At the end of a physical group all
16 INT32 lanes, all 16 FP32 lanes, both FP64 lanes, or the SFU lane write in
parallel. The 32-bank GPR interface can therefore consume the complete group;
no lane-by-lane writeback FSM was introduced.

The request side now registers group selection locally per physical FP lane,
then selects the statically connected architectural-lane operand bank in a
second elastic stage. FP64 elaboration removes the unused narrow-format
widening converters from its native-only pipes. Inside the shared FPUv2 FMA,
synchronized one-entry elastic queues register the selected add operands and
FMA product metadata before the alignment stage. These queues use replacement
on dequeue, so the pipe retains one-request-per-cycle capacity per lane even
though arithmetic latency increases by one cycle.

The final run used a 10,000 ps constraint and hierarchical mapping
(`PPA_FLATTEN=0`) so the local lane-bank and pipeline boundaries remain
visible. All four units have positive setup slack and zero TNS:

| Unit | Area (um2) | Cells | Critical path (ps) | Slack at 10 ns (ps) | Fmax (MHz) | 100 MHz |
|---|---:|---:|---:|---:|---:|---|
| INT32 | 12,424.23 | 126,757 | 8,678.04 | 1,305.11 | 115.23 | Pass |
| FP32 | 34,797.18 | 400,774 | 3,856.05 | 6,113.88 | 259.33 | Pass |
| FP64 | 14,602.34 | 154,889 | 8,604.27 | 1,365.61 | 116.22 | Pass |
| DIV/SFU | 6,933.31 | 73,320 | 8,262.13 | 1,716.53 | 121.03 | Pass |

FP64 improved from 10,424.45 ps (95.93 MHz) to 8,604.27 ps after the internal
FMA register boundary. FP32 also benefits from the shared FMA change. These
are pre-layout NLDM results with ideal clocks and no extracted interconnect;
they establish synthesis-level 100 MHz closure, not signoff timing. No
switching VCD was supplied, so power remains invalid and `ppa_valid` remains
false even though timing and area are valid.

## Verification

- `SpecBugFixSpec`: 8/8 passed, including 32 active INT lanes and parallel
  retirement of both 16-lane physical groups.
- FP32 differential: 4,636 vectors, 0 failures, 35% random backpressure.
- FP64 differential: 1,612 vectors, 0 failures, 35% random backpressure.
- SFU differential: 3,355 vectors, 0 failures, 35% random backpressure.
- INT32 Verilator lint: passed with Verilator 5.049 devel
  (`v5.048-179-gc878a7e73`).

Final reports and mapped netlists are under
`rtl/reports/ppa_100mhz_final2/{int,fp32,fp64,sfu}/`. The earlier reports under
`rtl/reports/ppa_optimized_encoded/` and `rtl/reports/ppa_final/` are retained
as optimization history. A future 500 MHz attempt still requires additional
arithmetic retiming plus placed buffer-tree and interconnect-aware analysis;
the current work claims only the requested greater-than-100 MHz target.
