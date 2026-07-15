"""Core AEC execution engine.

This is the implementation layer.  Use :mod:`cmodel.execution` or the
package-level exports for the stable public API.
"""

from .gpu import (
    AecExecutionModel,
    ExecutionStatus,
    LaunchConfig,
    RunResult,
    lmem_external_address,
)

__all__ = ["AecExecutionModel", "ExecutionStatus", "LaunchConfig", "RunResult", "lmem_external_address"]
