# SystemVerilog sources

This directory is the single SystemVerilog source root used by the build:

- `generated/`: checked-in Chisel outputs; Chisel generators write here.
- `aec_eval_top.sv`: contest ABI and simulation-debug adapters.
- `asap7_sram_wrappers.sv`: submission-local copy of the Track-B port adapters.
- `asap7_sram_sim.sv`: local functional fallback for the four native macros.

The fallback SRAM model is used only when `ASAP7_SRAM_ROOT` is unset. It has
the native synchronous 1RW behavior: access on the rising edge, one-cycle read,
write priority, held read data without a read, no reset, and uninitialized
storage. It contains no timing, power, or physical information.

When `ASAP7_SRAM_ROOT` is set, Verilator compiles the four locked functional
views from `$ASAP7_SRAM_ROOT/generated/verilog/` instead of the fallback. The
PPA flow always requires `ASAP7_SRAM_ROOT`, verifies it against
`Track-B/sram/ASAP7_SRAM_LOCK.sha256`, preserves the native cells as blackboxes
in Yosys, loads their Liberty into OpenSTA, and adds area from the locked LEF.
