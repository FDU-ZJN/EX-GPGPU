"""Validation utilities kept separate from the functional execution core."""

from .instruction import validate_control, validate_data

__all__ = ["validate_control", "validate_data"]
