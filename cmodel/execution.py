"""CModel execution entry points: load test programs, create a GPU, and run."""

from __future__ import annotations

from pathlib import Path

from .core import AecExecutionModel, ExecutionStatus, LaunchConfig, RunResult
from .core import aec_isa
from .core.errors import ExecutionError, InvalidInstructionError, UnsupportedInstructionError


def load_program(program_path: str | Path) -> list[int]:
    """Load a testcase `program.bin` into decoded 128-bit instruction words."""
    return aec_isa.read_binary(str(program_path))


def create_gpu(
    program_path: str | Path,
    grid: tuple[int, int, int],
    block: tuple[int, int, int],
    *,
    program_instructions: int | None = None,
    gmem: bytearray | None = None,
    cmem: bytearray | None = None,
    pmem: bytearray | None = None,
    trace=None,
) -> AecExecutionModel:
    """Load one testcase program and instantiate its functional GPU model."""
    program = load_program(program_path)
    instruction_count = len(program) if program_instructions is None else program_instructions
    return AecExecutionModel(program, LaunchConfig(grid, block, instruction_count), gmem, cmem, pmem, trace)


def run_program(
    program_path: str | Path,
    grid: tuple[int, int, int],
    block: tuple[int, int, int],
    max_steps: int,
    *,
    program_instructions: int | None = None,
    gmem: bytearray | None = None,
    cmem: bytearray | None = None,
    pmem: bytearray | None = None,
) -> tuple[AecExecutionModel, RunResult]:
    """Create a GPU from a testcase binary and execute it to completion/budget."""
    gpu = create_gpu(
        program_path, grid, block,
        program_instructions=program_instructions,
        gmem=gmem,
        cmem=cmem,
        pmem=pmem,
    )
    return gpu, gpu.run(max_steps)


__all__ = [
    "AecExecutionModel",
    "ExecutionError",
    "ExecutionStatus",
    "InvalidInstructionError",
    "LaunchConfig",
    "RunResult",
    "UnsupportedInstructionError",
    "create_gpu",
    "load_program",
    "run_program",
]
