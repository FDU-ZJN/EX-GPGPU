# Per-lane scoreboard parameters

`AecScoreboard` tracks a 32-bit busy mask for each `{warp, GPR}` and
`{warp, predicate}` entry.  Bit *n* corresponds to lane *n*; a `1` means that
the lane has a pending producer and cannot be read or overwritten by a
dependent instruction.

`EvalTop` supplies the following lane-mask parameters for every scoreboard
operation:

| Parameter | Width | Meaning |
| --- | --- | --- |
| `sourceMask` | 32 | Lanes that will consume each GPR source.  A RAW hazard exists only when it intersects the source register's busy mask. |
| `sourcePredicateMask` | 32 | Active lanes whose predicate guard must be stable before forming `sourceMask`. |
| `reserve.laneMask` | 32 | Lanes written by the newly issued instruction; it is ORed into the destination busy mask after a WAW check. |
| `release.laneMask` | 32 | Lanes that actually commit at writeback; only these bits are cleared. |

For normal instructions, the reserve mask is the decoded execution mask.  For
`SHUF`, it is `executeMask & immExt`, matching the subset recorded in
`heldCommit`.  64-bit destinations apply the same mask to both GPR halves.
Predicate destinations use identical mask semantics.
