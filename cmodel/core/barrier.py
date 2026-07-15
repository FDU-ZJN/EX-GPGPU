"""CTA barrier state transitions."""

from __future__ import annotations

from .errors import ExecutionError
from .state import CtaState, WarpState


def arrive_cta_barrier(cta: CtaState, warp: WarpState) -> None:
    """Record one warp's arrival and release the generation when complete."""
    warp_index = cta.warps.index(warp)
    warp_bit = 1 << warp_index
    if cta.barrier_required_mask is None:
        cta.barrier_required_mask = sum(
            1 << index for index, candidate in enumerate(cta.warps) if not candidate.completed
        )
    if not cta.barrier_required_mask & warp_bit or cta.barrier_arrived_mask & warp_bit:
        raise ExecutionError(f"SYNC.CT at PC {warp.pc} repeats barrier generation {cta.barrier_generation}")

    cta.barrier_arrived_mask |= warp_bit
    warp.waiting_generation = cta.barrier_generation
    if cta.barrier_arrived_mask != cta.barrier_required_mask:
        return

    for index, candidate in enumerate(cta.warps):
        if cta.barrier_required_mask & (1 << index):
            candidate.waiting_generation = None
            candidate.pc += 1
    cta.barrier_generation += 1
    cta.barrier_required_mask = None
    cta.barrier_arrived_mask = 0
