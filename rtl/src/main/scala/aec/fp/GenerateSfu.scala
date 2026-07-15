package aec.fp

/** Standalone generation entry point for the judged DIV/SFU hierarchy. */
object GenerateSfu extends App {
  (new chisel3.stage.ChiselStage).emitSystemVerilog(
    new AecSfuWarpUnit(1),
    Array("--target-dir", "sv/generated/sfu")
  )
}
