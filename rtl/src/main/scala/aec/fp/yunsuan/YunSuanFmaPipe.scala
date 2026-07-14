/*
 * AEC Decoupled adapter for OpenXiangShan/YunSuan FloatFMA commit
 * 447cd17b1637f998daeb6be3efcd4890f48cb2b9.
 * Licensed under the Mulan Permissive Software License, Version 2.
 */
package aec.fp.yunsuan

import aec.fp.AecFpOp
import chisel3._
import chisel3.util._

class YunSuanFmaRequest extends Bundle {
  val op = UInt(7.W)
  val a = UInt(64.W)
  val b = UInt(64.W)
  val c = UInt(64.W)
  val format = UInt(2.W)
  val seq = UInt(6.W)
  val dest = UInt(8.W)
  val dtype = UInt(4.W)
}

class YunSuanFmaResponse extends Bundle {
  val result = UInt(64.W)
  val fflags = UInt(5.W)
  val seq = UInt(6.W)
  val dest = UInt(8.W)
  val dtype = UInt(4.W)
}

/** Credit-protected wrapper around YunSuan's fixed three-stage pipeline.
  * The arithmetic core itself cannot stall.  Every accepted request reserves
  * a completion slot before `fire`, so downstream backpressure can never
  * overwrite an in-flight result.  With an unstalled output it accepts and
  * produces one operation every cycle.
  */
class YunSuanFmaPipe(val fixedFormat: Int) extends Module {
  require(fixedFormat == 2 || fixedFormat == 3)
  val io = IO(new Bundle {
    val req = Flipped(Decoupled(new YunSuanFmaRequest))
    val resp = Decoupled(new YunSuanFmaResponse)
  })

  private val completionDepth = 8
  val core = Module(new FloatFMA(Some(fixedFormat)))
  val completionQ = Module(new Queue(new YunSuanFmaResponse, completionDepth, pipe = true))
  val outstanding = RegInit(0.U(log2Ceil(completionDepth + 1).W))
  val canReserve = outstanding < completionDepth.U

  io.req.ready := canReserve
  val fire = io.req.fire
  val synthAdd = io.req.bits.op === AecFpOp.add || io.req.bits.op === AecFpOp.sub
  val signMask = if (fixedFormat == 3) "h8000000000000000".U(64.W) else "h0000000080000000".U(64.W)
  val one = if (fixedFormat == 3) "h3ff0000000000000".U(64.W) else "h000000003f800000".U(64.W)
  val addend = Mux(io.req.bits.op === AecFpOp.sub, io.req.bits.b ^ signMask, io.req.bits.b)

  // Advance every arithmetic stage every cycle.  Upstream YunSuan uses one
  // shared `fire` as the enable for hundreds of RegEnable payload bits; in the
  // contest's logic-only flow that becomes a multi-hundred-fF data-mux net and
  // dominates timing.  Bubble results are discarded by valid0/1/2, so an
  // always-advancing pipeline preserves semantics and true II=1 while removing
  // the shared enable from the mapped datapath.
  core.io.fire := true.B
  core.io.fp_a := io.req.bits.a
  core.io.fp_b := Mux(synthAdd, one, io.req.bits.b)
  core.io.fp_c := Mux(synthAdd, addend, io.req.bits.c)
  core.io.round_mode := 0.U
  core.io.fp_format := fixedFormat.U
  core.io.op_code := Mux(io.req.bits.op === AecFpOp.mul, FmaOpCode.fmul, FmaOpCode.fmacc)
  core.io.fp_aIsFpCanonicalNAN := false.B
  core.io.fp_bIsFpCanonicalNAN := false.B
  core.io.fp_cIsFpCanonicalNAN := false.B

  val valid0 = RegNext(fire, false.B)
  val valid1 = RegNext(valid0, false.B)
  val valid2 = RegNext(valid1, false.B)
  val meta0 = RegEnable(io.req.bits, fire)
  val meta1 = RegEnable(meta0, valid0)
  val meta2 = RegEnable(meta1, valid1)

  completionQ.io.enq.valid := valid2
  completionQ.io.enq.bits.result := core.io.fp_result
  completionQ.io.enq.bits.fflags := core.io.fflags
  completionQ.io.enq.bits.seq := meta2.seq
  completionQ.io.enq.bits.dest := meta2.dest
  completionQ.io.enq.bits.dtype := meta2.dtype
  // The outstanding credit invariant guarantees enq.ready here.  Keep the
  // invariant covered by simulation tests rather than a synthesizable
  // assertion: Yosys lowers the latter to an unmapped $check cell that the
  // locked OpenSTA flow cannot parse.

  io.resp <> completionQ.io.deq
  when (fire =/= io.resp.fire) {
    outstanding := Mux(fire, outstanding + 1.U, outstanding - 1.U)
  }
}
