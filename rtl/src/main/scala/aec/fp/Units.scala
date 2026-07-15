package aec.fp

/** Named integration points used by the AEC decoder.  The arithmetic is
  * centralized in AecFpUnit so these units share the same request contract. */
class AecFpAddSub extends AecFpUnit
class AecFpMul extends AecFpUnit
class AecFpMulAdd extends AecFpUnit
class AecFpMad extends AecFpUnit
class AecFpDiv extends AecFpUnit
class AecFpConvert extends AecFpUnit
class AecFpCompare extends AecFpUnit
class AecFpSfu extends AecFpUnit
class AecFp32 extends AecFp32Unit
class AecFp64 extends AecFp64Unit
