"""Exceptions raised by the AEC execution pipeline."""


class UnsupportedInstructionError(RuntimeError):
    """A legal AEC opcode outside the implemented model scope."""


class InvalidInstructionError(RuntimeError):
    """An instruction that violates static AEC encoding rules."""


class ExecutionError(RuntimeError):
    """A dynamic AEC execution error with no instruction-side commit."""
