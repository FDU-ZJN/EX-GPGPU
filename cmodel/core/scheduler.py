"""Deterministic CTA/warp scheduling helpers."""

from __future__ import annotations

from .state import CtaState, WarpState


def next_runnable_warp(
    ctas: list[CtaState], cta_cursor: int,
) -> tuple[tuple[CtaState, WarpState] | None, int]:
    """Select the next runnable warp and return the next global cursor."""
    for cta_offset in range(len(ctas)):
        cta_index = (cta_cursor + cta_offset) % len(ctas)
        cta = ctas[cta_index]
        for warp_offset in range(len(cta.warps)):
            index = (cta.scheduler_cursor + warp_offset) % len(cta.warps)
            warp = cta.warps[index]
            if warp.runnable:
                cta.scheduler_cursor = (index + 1) % len(cta.warps)
                return (cta, warp), (cta_index + 1) % len(ctas)
    return None, cta_cursor
