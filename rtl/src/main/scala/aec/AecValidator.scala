package aec

import chisel3._

/** Canonical AEC encoding validation.  Every accepted case below mirrors one
  * row of spec section 5.4; bits not named by that row are checked MBZ. */
object AecValidator {
  private def oneOf(x: UInt, values: Seq[UInt]): Bool = values.map(x === _).reduce(_ || _)
  private def u(values: Int*): Seq[UInt] = values.map(_.U(4.W))

  private val fp = u(8, 9, 10, 11)
  private val ints = u(2, 3)
  private val cvtInts = u(2, 3, 4, 5)

  def isExcluded(d: AecDecodedInstruction): Bool = false.B

  def valid(d: AecDecodedInstruction, programInstructions: UInt): Bool = {
    val guardG = d.predEn || (!d.predNeg && d.predicate === 0.U)
    val guardN = !d.predEn && !d.predNeg && d.predicate === 0.U
    val guardSel = !d.predEn && !d.predNeg // predicate field selects P0..P7
    val guardR = d.predEn && !d.predNeg
    val ctrl0 = !d.reservedCtrl && d.subop === 0.U && d.ext === 0.U

    val destR = d.destRaw(15, 8) === 0.U
    val src1R = d.src1Raw(15, 8) === 0.U
    val src2R = d.src2Imm(31, 8) === 0.U
    val src3R = d.immExt(31, 8) === 0.U
    val destP = d.destRaw(15, 3) === 0.U
    val src1P = d.src1Raw(15, 3) === 0.U
    val noTail = d.src2Imm === 0.U && d.immExt === 0.U
    val pairD = d.dest =/= 255.U
    val pairA = d.src1 =/= 255.U
    val pairB = d.src2 =/= 255.U
    val pairC = d.src3 =/= 255.U

    val add3 = oneOf(d.opcode, Seq(AecOpcode.add, AecOpcode.sub, AecOpcode.mul))
    val add3Type = oneOf(d.dtype, ints ++ fp)
    val add3Pair = d.dtype =/= 9.U || (pairD && pairA && pairB)
    val add3Ok = add3 && guardG && ctrl0 && add3Type && destR && src1R && src2R && d.immExt === 0.U && add3Pair

    val madOk = d.opcode === AecOpcode.mad && guardG && ctrl0 && oneOf(d.dtype, u(2, 3, 8)) &&
      destR && src1R && src2R && src3R
    val fmaOk = d.opcode === AecOpcode.fma && guardG && ctrl0 && oneOf(d.dtype, fp) &&
      destR && src1R && src2R && src3R && (d.dtype =/= 9.U || (pairD && pairA && pairB && pairC))
    val divOk = d.opcode === AecOpcode.div && guardG && ctrl0 && oneOf(d.dtype, u(2, 3, 8, 9)) &&
      destR && src1R && src2R && d.immExt === 0.U && (d.dtype =/= 9.U || (pairD && pairA && pairB))

    val negAbs = d.opcode === AecOpcode.neg || d.opcode === AecOpcode.abs
    val negAbsOk = negAbs && guardG && ctrl0 && oneOf(d.dtype, u(3, 8, 9, 10, 11)) &&
      destR && src1R && noTail && (d.dtype =/= 9.U || (pairD && pairA))
    val minMax = d.opcode === AecOpcode.min || d.opcode === AecOpcode.max
    val minMaxOk = minMax && guardG && ctrl0 && oneOf(d.dtype, u(2, 3, 8)) && destR && src1R && src2R && d.immExt === 0.U

    val bitBinary = oneOf(d.opcode, Seq(AecOpcode.andOp, AecOpcode.orOp, AecOpcode.xorOp))
    val bitBinaryOk = bitBinary && guardG && ctrl0 && oneOf(d.dtype, u(0, 2)) && destR && src1R && src2R && d.immExt === 0.U
    val bitUnary = oneOf(d.opcode, Seq(AecOpcode.notOp, AecOpcode.popc, AecOpcode.flo))
    val bitUnaryOk = bitUnary && guardG && ctrl0 && oneOf(d.dtype, u(0, 2)) && destR && src1R && noTail
    val shift = d.opcode === AecOpcode.shl || d.opcode === AecOpcode.shr
    val shiftOk = shift && guardG && ctrl0 && oneOf(d.dtype, ints) && destR && src1R && src2R && d.immExt === 0.U
    val bfxOk = d.opcode === AecOpcode.bfx && guardG && ctrl0 && oneOf(d.dtype, ints) &&
      destR && src1R && d.src2Imm(31, 16) === 0.U && d.immExt === 0.U
    val binsOk = d.opcode === AecOpcode.bins && guardG && ctrl0 && oneOf(d.dtype, u(0, 2)) &&
      destR && src1R && src2R && d.immExt(31, 16) === 0.U

    val cmp = d.opcode === AecOpcode.cmp || d.opcode === AecOpcode.cmpp
    val cmpDest = Mux(d.opcode === AecOpcode.cmpp, destP, destR)
    val cmpOk = cmp && guardG && !d.reservedCtrl && d.subop <= 5.U && d.ext === 0.U &&
      oneOf(d.dtype, u(2, 3, 8)) && cmpDest && src1R && src2R && d.immExt === 0.U
    val select = d.opcode === AecOpcode.sel || d.opcode === AecOpcode.pick
    val selectGuard = Mux(d.opcode === AecOpcode.sel, guardSel, guardG)
    val selectOk = select && selectGuard && ctrl0 && oneOf(d.dtype, u(2, 3, 8)) && destR && src1R && src2R && d.immExt === 0.U

    val ld = d.opcode === AecOpcode.ld
    val ldOk = ld && guardG && !d.reservedCtrl && d.subop === 0.U && d.ext <= 4.U &&
      oneOf(d.dtype, u(0, 1, 2, 3, 8)) && destR && src1R && noTail && (d.dtype =/= 1.U || pairD)
    val stOk = d.opcode === AecOpcode.st && guardG && !d.reservedCtrl && d.subop === 0.U &&
      oneOf(d.ext, Seq(0.U, 1.U, 3.U)) && oneOf(d.dtype, u(0, 2, 3, 8)) && d.destRaw === 0.U && src1R && src2R && d.immExt === 0.U
    val ldcOk = d.opcode === AecOpcode.ldc && guardG && !d.reservedCtrl && d.subop === 0.U && d.ext === 2.U &&
      oneOf(d.dtype, u(0, 2, 8)) && destR && src1R && noTail
    val atomRegs = Mux(d.subop === 7.U,
      d.src2Imm(31, 24) === 0.U && d.src2Imm(15, 8) === 0.U,
      d.src2Imm(31, 8) === 0.U)
    val atomOk = d.opcode === AecOpcode.atom && guardG && !d.reservedCtrl && d.subop <= 7.U &&
      (d.ext === 0.U || d.ext === 1.U) && oneOf(d.dtype, ints) && destR && src1R && atomRegs && d.immExt === 0.U

    val branch = d.opcode === AecOpcode.br || d.opcode === AecOpcode.brx || d.opcode === AecOpcode.call
    val branchGuard = Mux(d.opcode === AecOpcode.brx, guardR, guardN)
    val branchOk = branch && branchGuard && !d.reservedCtrl && d.dtype === 15.U && d.subop === 0.U && d.ext === 0.U &&
      d.destRaw === 0.U && d.src1Raw === 0.U && d.src2Imm === 0.U && d.immExt < programInstructions
    val simpleControl = d.opcode === AecOpcode.ret || d.opcode === AecOpcode.halt || d.opcode === AecOpcode.syncCt
    val simpleControlOk = simpleControl && guardN && !d.reservedCtrl && d.dtype === 15.U && d.subop === 0.U && d.ext === 0.U &&
      d.destRaw === 0.U && d.src1Raw === 0.U && noTail
    val mbarOk = d.opcode === AecOpcode.mbar && guardN && !d.reservedCtrl && d.dtype === 15.U && d.subop === 0.U &&
      (d.ext === 0.U || d.ext === 2.U) && d.destRaw === 0.U && d.src1Raw === 0.U && noTail

    val cvt = oneOf(d.opcode, Seq(AecOpcode.cvtff, AecOpcode.cvtfi, AecOpcode.cvtif, AecOpcode.cvtii))
    val srcType = d.raw(109, 106)
    val dstFp = oneOf(d.dtype, fp); val dstInt = oneOf(d.dtype, cvtInts)
    val srcFp = oneOf(srcType, fp); val srcInt = oneOf(srcType, cvtInts)
    val cvtKinds = Mux(d.opcode === AecOpcode.cvtff, dstFp && srcFp,
      Mux(d.opcode === AecOpcode.cvtfi, dstInt && srcFp,
        Mux(d.opcode === AecOpcode.cvtif, dstFp && srcInt, dstInt && srcInt)))
    val cvtOk = cvt && guardG && !d.reservedCtrl && d.raw(105, 103) === 0.U && destR && src1R && noTail && cvtKinds &&
      (d.dtype =/= 9.U || pairD) && (srcType =/= 9.U || pairA)

    val special = oneOf(d.src1Raw, Seq("h0100".U, "h0101".U, "h0102".U, "h0103".U, "h0104".U,
      "h0110".U, "h0111".U, "h0112".U, "h0113".U, "h0120".U, "h0121".U, "h0122".U, "h0123".U))
    val cpyTypes = oneOf(d.dtype, u(0, 1, 2, 3, 4, 5, 8, 9, 10, 11))
    val cpySource = src1R || (d.dtype === 2.U && special)
    val cpyPair = (d.dtype =/= 1.U && d.dtype =/= 9.U) || (pairD && pairA && src1R)
    val cpyOk = d.opcode === AecOpcode.cpy && guardG && ctrl0 && cpyTypes && destR && cpySource && cpyPair && noTail
    val loadiOk = d.opcode === AecOpcode.loadi && guardG && ctrl0 && d.dtype === 15.U && destR && d.src1Raw === 0.U && d.src2Imm === 0.U
    val loadi64Ok = d.opcode === AecOpcode.loadi64 && guardG && ctrl0 && d.dtype === 15.U && destR && pairD && d.src1Raw === 0.U

    val shufOk = d.opcode === AecOpcode.shuf && guardN && !d.reservedCtrl && d.subop <= 3.U && d.ext === 0.U &&
      oneOf(d.dtype, u(2, 3, 8)) && destR && src1R && d.src2Imm(31, 5) === 0.U
    val voteOk = d.opcode === AecOpcode.vote && guardN && !d.reservedCtrl && d.dtype === 15.U && d.subop <= 2.U && d.ext <= 1.U &&
      Mux(d.ext === 1.U, destP, destR) && src1P && noTail
    val mtchOk = d.opcode === AecOpcode.mtch && guardN && ctrl0 && d.dtype === 15.U && destR && src1R && noTail

    val sfuUnary = oneOf(d.opcode, Seq(AecOpcode.rcp, AecOpcode.rsq, AecOpcode.sqrt))
    val sfuUnaryOk = sfuUnary && guardG && !d.reservedCtrl && d.dtype === 8.U && d.subop <= 1.U && d.ext === 0.U && destR && src1R && noTail
    val sfuSimple = oneOf(d.opcode, Seq(AecOpcode.sin, AecOpcode.cos, AecOpcode.exp, AecOpcode.log))
    val sfuSimpleOk = sfuSimple && guardG && ctrl0 && d.dtype === 8.U && destR && src1R && noTail
    val rdtscOk = d.opcode === AecOpcode.rdtsc && guardG && ctrl0 && d.dtype === 15.U && destR && d.src1Raw === 0.U && noTail

    !d.reservedCtrl && (add3Ok || madOk || fmaOk || divOk || negAbsOk || minMaxOk || bitBinaryOk || bitUnaryOk ||
      shiftOk || bfxOk || binsOk || cmpOk || selectOk || ldOk || stOk || ldcOk || atomOk || branchOk ||
      simpleControlOk || mbarOk || cvtOk || cpyOk || loadiOk || loadi64Ok || shufOk || voteOk || mtchOk ||
      sfuUnaryOk || sfuSimpleOk || rdtscOk)
  }
}
