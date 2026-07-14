# Per-lane scoreboard evaluation

## Decision

Do not merge the implementation in `new/` into the current design.  Its
dependency semantics are useful for workloads that issue multiple producers
to disjoint predicated lanes of the same architectural register, but the
public workload cycle count does not exercise or benefit from that condition.
The measured performance gain is zero while the storage and dependency-lookup
cost increase substantially.

## Correctness review

The proposed lane masks correctly narrow RAW and WAW hazards when:

- GPR source masks use the lanes that execute the instruction;
- predicate-source hazards use the full active mask before forming that
  execution mask;
- SHUF reserves only `executeMask & immExt`;
- 64-bit destinations reserve and release both halves; and
- writeback releases exactly the committed lane mask.

The implementation in `new/Scoreboard.scala` is not safe as written.  If a
release and a disjoint reserve address the same GPR or predicate in one cycle,
the later release assignment overwrites the reserve assignment.  A corrected
prototype combined the update as `(busy & ~releaseMask) | reserveMask` and
passed a focused Chisel test for disjoint RAW/WAW and simultaneous replacement.

## Hardware cost

The current four scoreboards contain 8,448 dependency bits in total.  The
proposal stores a 32-bit mask for every entry:

| Implementation | Total dependency state | Relative |
| --- | ---: | ---: |
| Current register-granular scoreboard | 8,448 bits | 1x |
| Corrected two-local-warp prototype | 67,584 bits | 8x |
| `new/` eight-warp-per-partition version | 270,336 bits | 32x |

The prototype already removed the fourfold over-allocation in `new/` because
each scheduler partition owns only two warps.  Even then, the remaining 8x
state increase adds wide asynchronous indexed reads and mask intersections to
the issue path.  That is contrary to the 250 MHz timing and area objective.

## Cycle comparison

Both versions were run in the `gpu` Podman container against all 36 public
cases.  The candidate run additionally enabled in-process CModel comparison.

| Metric | Current | Corrected per-lane prototype | Change |
| --- | ---: | ---: | ---: |
| Passing cases | 36/36 | 36/36 | 0 |
| Total cycles | 16,130 | 16,130 | 0 (0.00%) |
| Minimum case cycles | 74 | 74 | 0 |
| Maximum case cycles | 1,081 | 1,081 | 0 |
| Per-case differences | - | 0/36 | 0 |

Representative cases were also identical: `gemm_naive` 967 cycles, `vadd`
470 cycles, `histogram` 375 cycles, `rcp` 884 cycles, and `sqrt` 874 cycles.

The compact results are retained under:

- `evidence/scoreboard_baseline_public/`
- `evidence/scoreboard_per_lane_public/`

## Follow-up direction

If lane-granular dependency tracking becomes necessary for a measured private
workload, compare source and destination masks against the small set of live
ROB entries instead of allocating a 32-bit mask for all 256 GPRs.  That keeps
storage proportional to outstanding instructions and should be evaluated with
a focused alternating-predicate benchmark before integration.
