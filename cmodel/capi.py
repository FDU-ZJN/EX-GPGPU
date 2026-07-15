"""In-process API used by the C++ RTL differential runner.

The C++ side embeds CPython and calls this module directly; no subprocess or
trace-file polling is involved.  Events are returned grouped by stable
(CTA, warp) identity so RTL scheduler timing does not affect comparison.
"""
from __future__ import annotations

import io
import json

from .core import AecExecutionModel, LaunchConfig
from .core.aec_isa import read_binary


def build_reference(program_path: str, program_instructions: int,
                    grid: tuple[int, int, int], block: tuple[int, int, int],
                    max_steps: int, memory_init: list[tuple[int, int, bytes]],
                    gmem_bytes: int) -> dict:
    images = {1: bytearray(gmem_bytes), 2: bytearray(), 3: bytearray()}
    for target, address, payload in memory_init:
        memory = images[target]
        end = address + len(payload)
        if end > len(memory):
            memory.extend(b"\0" * (end - len(memory)))
        memory[address:end] = payload

    trace = io.StringIO()
    model = AecExecutionModel(
        read_binary(program_path), LaunchConfig(tuple(grid), tuple(block), program_instructions),
        gmem=images[1], pmem=images[2], cmem=images[3], trace=trace)
    result = model.run(max_steps)
    events: dict[tuple[int, int, int, int], list[dict]] = {}
    for line in trace.getvalue().splitlines():
        event = json.loads(line)
        key = (*event["cta"], event["warp"])
        events.setdefault(key, []).append(event)
    return {
        "status": str(result.status).replace("exec_error", "fail"),
        "detail": result.error_detail or "",
        "events": events,
        "gmem": bytes(images[1]),
    }
