package aec.fp
import chisel3.stage.ChiselStage
import aec.int.AecEightLaneIntUnit
object Generate extends App {
  // These are the backend-facing warp units: one Decoupled request/response
  // per unit, with a 32-lane operand/result bundle.  The scalar pipes are
  // implementation details and are not emitted as integration tops.
  (new ChiselStage).emitSystemVerilog(new AecFp32Unit, Array("--target-dir", "sv/generated/fp32"))
  (new ChiselStage).emitSystemVerilog(new AecFp64Unit, Array("--target-dir", "sv/generated/fp64"))
  (new ChiselStage).emitSystemVerilog(new AecEightLaneIntUnit, Array("--target-dir", "sv/generated/int"))
}
