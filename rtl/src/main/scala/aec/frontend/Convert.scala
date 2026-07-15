package aec

import chisel3._
import chisel3.util._
import hardfloat._
import fudian.FPToFP

/** One-lane, combinational AEC conversion adapter.  Narrow FP formats first
  * widen exactly to f64 and are rounded only at the selected destination. */
class AecConvertLane extends Module {
  val io = IO(new Bundle {
    val kind = Input(UInt(2.W)) // 0=FF, 1=FI, 2=IF, 3=II
    val dstType = Input(UInt(4.W)); val srcType = Input(UInt(4.W)); val in = Input(UInt(64.W))
    val out = Output(UInt(64.W))
  })
  val f16Up = Module(new FPToFP(5, 11, 11, 53)); val bf16Up = Module(new FPToFP(8, 8, 11, 53)); val f32Up = Module(new FPToFP(8, 24, 11, 53))
  f16Up.io.in := io.in(15, 0); bf16Up.io.in := io.in(15, 0); f32Up.io.in := io.in(31, 0)
  f16Up.io.rm := 0.U; bf16Up.io.rm := 0.U; f32Up.io.rm := 0.U
  val fp64 = MuxLookup(io.srcType, io.in, Seq(10.U -> f16Up.io.result, 11.U -> bf16Up.io.result, 8.U -> f32Up.io.result, 9.U -> io.in))
  val down16 = Module(new FPToFP(11, 53, 5, 11)); val downBf16 = Module(new FPToFP(11, 53, 8, 8)); val down32 = Module(new FPToFP(11, 53, 8, 24))
  down16.io.in := fp64; downBf16.io.in := fp64; down32.io.in := fp64
  down16.io.rm := 0.U; downBf16.io.rm := 0.U; down32.io.rm := 0.U
  val fpOut = MuxLookup(io.dstType, fp64, Seq(10.U -> Cat(0.U(48.W), down16.io.result), 11.U -> Cat(0.U(48.W), downBf16.io.result), 8.U -> Cat(0.U(32.W), down32.io.result), 9.U -> fp64))

  val i2f = Module(new INToRecFN(32, 11, 53))
  val intInput = Mux(io.srcType === 4.U, Cat(0.U(24.W), io.in(7, 0)),
    Mux(io.srcType === 5.U, Cat(Fill(24, io.in(7)), io.in(7, 0)), io.in(31, 0)))
  i2f.io.in := intInput; i2f.io.signedIn := io.srcType === 3.U || io.srcType === 5.U
  i2f.io.roundingMode := 0.U; i2f.io.detectTininess := 0.U
  val intFp64 = fNFromRecFN(11, 53, i2f.io.out)
  val intDown16 = Module(new FPToFP(11, 53, 5, 11)); val intDownBf16 = Module(new FPToFP(11, 53, 8, 8)); val intDown32 = Module(new FPToFP(11, 53, 8, 24))
  intDown16.io.in := intFp64; intDownBf16.io.in := intFp64; intDown32.io.in := intFp64
  intDown16.io.rm := 0.U; intDownBf16.io.rm := 0.U; intDown32.io.rm := 0.U
  val intFpOut = MuxLookup(io.dstType, intFp64, Seq(10.U -> Cat(0.U(48.W), intDown16.io.result), 11.U -> Cat(0.U(48.W), intDownBf16.io.result), 8.U -> Cat(0.U(32.W), intDown32.io.result), 9.U -> intFp64))

  val f2i = Module(new RecFNToIN(11, 53, 32))
  f2i.io.in := recFNFromFN(11, 53, fp64); f2i.io.roundingMode := 1.U // round-to-zero
  f2i.io.signedOut := io.dstType === 3.U || io.dstType === 5.U
  val f2i8 = Module(new RecFNToIN(11, 53, 8))
  f2i8.io.in := recFNFromFN(11, 53, fp64); f2i8.io.roundingMode := 1.U
  f2i8.io.signedOut := io.dstType === 5.U
  val sign = fp64(63); val expAll = fp64(62, 52).andR; val fracAny = fp64(51, 0).orR
  val isNan = expAll && fracAny; val isInf = expAll && !fracAny
  val unsignedMax = Mux(io.dstType === 4.U, 255.U(32.W), "hffffffff".U)
  val signedMax = Mux(io.dstType === 5.U, 127.U(32.W), "h7fffffff".U)
  val signedMin = Mux(io.dstType === 5.U, "hffffff80".U(32.W), "h80000000".U)
  val f2iRaw = Mux(isNan, 0.U, Mux(isInf, Mux(sign, Mux(io.dstType === 2.U || io.dstType === 4.U, 0.U, signedMin), Mux(io.dstType === 2.U || io.dstType === 4.U, unsignedMax, signedMax)), f2i.io.out))
  val narrowRaw = Mux(isNan, 0.U(8.W), f2i8.io.out)
  val f2iOut = Mux(io.dstType === 4.U, Cat(0.U(24.W), narrowRaw), Mux(io.dstType === 5.U, Cat(Fill(24, narrowRaw(7)), narrowRaw), f2iRaw))
  val iiOut = MuxLookup(io.dstType, io.in(31, 0), Seq(
    4.U -> Cat(0.U(24.W), io.in(7, 0)),
    5.U -> Cat(Fill(24, io.in(7)), io.in(7, 0)),
    2.U -> Mux(io.srcType === 5.U, Cat(Fill(24, io.in(7)), io.in(7, 0)),
      Mux(io.srcType === 4.U, Cat(0.U(24.W), io.in(7, 0)), io.in(31, 0))),
    3.U -> Mux(io.srcType === 5.U, Cat(Fill(24, io.in(7)), io.in(7, 0)),
      Mux(io.srcType === 4.U, Cat(0.U(24.W), io.in(7, 0)), io.in(31, 0)))))
  io.out := MuxLookup(io.kind, fpOut, Seq(0.U -> fpOut, 1.U -> f2iOut, 2.U -> intFpOut, 3.U -> iiOut))
}
