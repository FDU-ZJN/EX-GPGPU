package aec

import chisel3._

/** AEC instruction encodings shared by execution units and the frontend. */
object AecOpcode {
  val add = "h0001".U(16.W); val sub = "h0002".U(16.W); val mul = "h0003".U(16.W)
  val mad = "h0004".U(16.W); val fma = "h0005".U(16.W); val div = "h0006".U(16.W)
  val neg = "h0007".U(16.W); val abs = "h0008".U(16.W); val min = "h0009".U(16.W); val max = "h000a".U(16.W)
  val andOp = "h0010".U(16.W); val orOp = "h0011".U(16.W); val xorOp = "h0012".U(16.W); val notOp = "h0013".U(16.W)
  val shl = "h0014".U(16.W); val shr = "h0015".U(16.W); val bfx = "h0016".U(16.W); val bins = "h0017".U(16.W)
  val popc = "h0018".U(16.W); val flo = "h0019".U(16.W)
  val cmp = "h0020".U(16.W); val cmpp = "h0021".U(16.W)
  val sel = "h0022".U(16.W); val pick = "h0023".U(16.W)
  val ld = "h0030".U(16.W); val st = "h0031".U(16.W)
  val ldc = "h0032".U(16.W); val atom = "h0033".U(16.W)
  val br = "h0040".U(16.W); val brx = "h0041".U(16.W); val call = "h0043".U(16.W)
  val ret = "h0044".U(16.W); val halt = "h0045".U(16.W)
  val syncCt = "h0047".U(16.W); val mbar = "h0049".U(16.W)
  val cvtff = "h0050".U(16.W); val cvtfi = "h0051".U(16.W)
  val cvtif = "h0052".U(16.W); val cvtii = "h0053".U(16.W)
  val cpy = "h0054".U(16.W); val loadi = "h0055".U(16.W); val loadi64 = "h0056".U(16.W)
  val shuf = "h0057".U(16.W); val vote = "h0058".U(16.W); val mtch = "h0059".U(16.W)
  val rcp = "h0070".U(16.W); val rsq = "h0071".U(16.W); val sin = "h0072".U(16.W)
  val cos = "h0073".U(16.W); val exp = "h0074".U(16.W); val log = "h0075".U(16.W); val sqrt = "h0076".U(16.W)
  val rdtsc = "h0080".U(16.W)
}
