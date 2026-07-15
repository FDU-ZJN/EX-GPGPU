# SystemVerilog sources

This directory is the single SystemVerilog source root used by the build:

- `generated/`: checked-in Chisel outputs; Chisel generators write here.
- `aec_eval_top.sv`: contest ABI and active-low reset adapter.
- `asap7_sram_wrappers.sv`: submission-local copy of the official port adapters.
- `asap7_sram/`: the four locked official native behavioral Verilog views.

Every Verilator functional build compiles only the vendored official views.
`rtl/scripts/verify_sram_models.sh` checks their normalized-file hashes before
the runner or top-level lint is built; there is no locally implemented fallback.
The native behavior is synchronous 1RW access on the rising edge, write
priority, held read data without a read, no reset, and uninitialized storage.

The PPA flow requires `ASAP7_SRAM_ROOT`, verifies it against
`TrackB-b-013/sram/ASAP7_SRAM_LOCK.sha256`, preserves the native cells as blackboxes
in Yosys, loads their Liberty into OpenSTA, and adds area from the locked LEF.
