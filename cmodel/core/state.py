"""Architectural state containers used by the execution pipeline."""

from __future__ import annotations

from dataclasses import dataclass, field


WARP_SIZE = 32
GPRS_PER_THREAD = 256
PREDS_PER_THREAD = 8


@dataclass
class ThreadState:
    """Register and predicate state for one logical lane."""

    gprs: list[int] = field(default_factory=lambda: [0] * GPRS_PER_THREAD)
    predicates: list[bool] = field(default_factory=lambda: [False] * PREDS_PER_THREAD)
    lmem: bytearray = field(default_factory=lambda: bytearray(4096))


@dataclass
class WarpState:
    """SIMT state shared by the lanes scheduled as one warp."""

    active_mask: int
    lanes: list[ThreadState] = field(default_factory=lambda: [ThreadState() for _ in range(WARP_SIZE)])
    pc: int = 0
    call_stack: list[int] = field(default_factory=list)
    completed: bool = False
    waiting_generation: int | None = None

    @property
    def runnable(self) -> bool:
        return not self.completed and self.waiting_generation is None


@dataclass
class CtaState:
    """CTA state, including barrier and local scheduler bookkeeping."""

    coord: tuple[int, int, int]
    warps: list[WarpState]
    barrier_generation: int = 0
    barrier_required_mask: int | None = None
    barrier_arrived_mask: int = 0
    scheduler_cursor: int = 0
    smem: bytearray = field(default_factory=lambda: bytearray(65536))

    @property
    def completed(self) -> bool:
        return all(warp.completed for warp in self.warps)
