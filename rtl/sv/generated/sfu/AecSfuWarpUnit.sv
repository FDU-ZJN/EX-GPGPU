module AecIntDivider(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_dividend,
  input  [31:0] io_req_bits_divisor,
  input         io_req_bits_signed,
  input         io_resp_ready,
  output        io_resp_valid,
  output [31:0] io_resp_bits_quotient,
  output        io_resp_bits_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[AecIntDivider.scala 31:22]
  reg [31:0] divisor; // @[AecIntDivider.scala 32:20]
  reg [31:0] dividend; // @[AecIntDivider.scala 33:21]
  reg [32:0] remainder; // @[AecIntDivider.scala 34:26]
  reg [31:0] quotient; // @[AecIntDivider.scala 35:25]
  reg  quotientNegative; // @[AecIntDivider.scala 36:33]
  reg [5:0] count; // @[AecIntDivider.scala 37:22]
  reg [31:0] result; // @[AecIntDivider.scala 38:23]
  reg  error; // @[AecIntDivider.scala 39:22]
  wire  dividendNegative = io_req_bits_signed & io_req_bits_dividend[31]; // @[AecIntDivider.scala 46:45]
  wire  divisorNegative = io_req_bits_signed & io_req_bits_divisor[31]; // @[AecIntDivider.scala 47:44]
  wire [31:0] _dividendMagnitude_T_1 = 32'h0 - io_req_bits_dividend; // @[AecIntDivider.scala 48:49]
  wire [31:0] _divisorMagnitude_T_1 = 32'h0 - io_req_bits_divisor; // @[AecIntDivider.scala 49:47]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _error_T = io_req_bits_divisor == 32'h0; // @[AecIntDivider.scala 58:34]
  wire [31:0] _GEN_0 = _error_T ? 32'h0 : result; // @[AecIntDivider.scala 59:40 60:14 38:23]
  wire [1:0] _GEN_1 = _error_T ? 2'h2 : 2'h1; // @[AecIntDivider.scala 59:40 61:13 63:13]
  wire [31:0] _GEN_9 = _T ? _GEN_0 : result; // @[AecIntDivider.scala 51:22 38:23]
  wire [1:0] _GEN_10 = _T ? _GEN_1 : state; // @[AecIntDivider.scala 31:22 51:22]
  wire [32:0] shiftedRemainder = {remainder[31:0],dividend[31]}; // @[Cat.scala 33:92]
  wire [32:0] _subtract_T = {1'h0,divisor}; // @[Cat.scala 33:92]
  wire  subtract = shiftedRemainder >= _subtract_T; // @[AecIntDivider.scala 69:37]
  wire [32:0] _GEN_21 = {{1'd0}, divisor}; // @[AecIntDivider.scala 70:56]
  wire [32:0] _nextRemainder_T_1 = shiftedRemainder - _GEN_21; // @[AecIntDivider.scala 70:56]
  wire [31:0] nextQuotient = {quotient[30:0],subtract}; // @[Cat.scala 33:92]
  wire [31:0] _dividend_T_1 = {dividend[30:0],1'h0}; // @[Cat.scala 33:92]
  wire [5:0] _count_T_1 = count - 6'h1; // @[AecIntDivider.scala 75:20]
  wire [31:0] _result_T_1 = 32'h0 - nextQuotient; // @[AecIntDivider.scala 77:39]
  wire  _T_4 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign io_req_ready = state == 2'h0; // @[AecIntDivider.scala 41:25]
  assign io_resp_valid = state == 2'h2; // @[AecIntDivider.scala 42:26]
  assign io_resp_bits_quotient = result; // @[AecIntDivider.scala 43:25]
  assign io_resp_bits_error = error; // @[AecIntDivider.scala 44:22]
  always @(posedge clock) begin
    if (reset) begin // @[AecIntDivider.scala 31:22]
      state <= 2'h0; // @[AecIntDivider.scala 31:22]
    end else if (_T_4) begin // @[AecIntDivider.scala 82:23]
      state <= 2'h0; // @[AecIntDivider.scala 83:11]
    end else if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      if (count == 6'h1) begin // @[AecIntDivider.scala 76:26]
        state <= 2'h2; // @[AecIntDivider.scala 78:13]
      end else begin
        state <= _GEN_10;
      end
    end else begin
      state <= _GEN_10;
    end
    if (_T) begin // @[AecIntDivider.scala 51:22]
      if (divisorNegative) begin // @[AecIntDivider.scala 49:29]
        divisor <= _divisorMagnitude_T_1;
      end else begin
        divisor <= io_req_bits_divisor;
      end
    end
    if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      dividend <= _dividend_T_1; // @[AecIntDivider.scala 73:14]
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      if (dividendNegative) begin // @[AecIntDivider.scala 48:30]
        dividend <= _dividendMagnitude_T_1;
      end else begin
        dividend <= io_req_bits_dividend;
      end
    end
    if (reset) begin // @[AecIntDivider.scala 34:26]
      remainder <= 33'h0; // @[AecIntDivider.scala 34:26]
    end else if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      if (subtract) begin // @[AecIntDivider.scala 70:28]
        remainder <= _nextRemainder_T_1;
      end else begin
        remainder <= shiftedRemainder;
      end
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      remainder <= 33'h0; // @[AecIntDivider.scala 54:15]
    end
    if (reset) begin // @[AecIntDivider.scala 35:25]
      quotient <= 32'h0; // @[AecIntDivider.scala 35:25]
    end else if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      quotient <= nextQuotient; // @[AecIntDivider.scala 74:14]
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      quotient <= 32'h0; // @[AecIntDivider.scala 55:14]
    end
    if (reset) begin // @[AecIntDivider.scala 36:33]
      quotientNegative <= 1'h0; // @[AecIntDivider.scala 36:33]
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      quotientNegative <= dividendNegative ^ divisorNegative; // @[AecIntDivider.scala 56:22]
    end
    if (reset) begin // @[AecIntDivider.scala 37:22]
      count <= 6'h0; // @[AecIntDivider.scala 37:22]
    end else if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      count <= _count_T_1; // @[AecIntDivider.scala 75:11]
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      count <= 6'h20; // @[AecIntDivider.scala 57:11]
    end
    if (reset) begin // @[AecIntDivider.scala 38:23]
      result <= 32'h0; // @[AecIntDivider.scala 38:23]
    end else if (state == 2'h1) begin // @[AecIntDivider.scala 67:28]
      if (count == 6'h1) begin // @[AecIntDivider.scala 76:26]
        if (quotientNegative) begin // @[AecIntDivider.scala 77:20]
          result <= _result_T_1;
        end else begin
          result <= nextQuotient;
        end
      end else begin
        result <= _GEN_9;
      end
    end else begin
      result <= _GEN_9;
    end
    if (reset) begin // @[AecIntDivider.scala 39:22]
      error <= 1'h0; // @[AecIntDivider.scala 39:22]
    end else if (_T_4) begin // @[AecIntDivider.scala 82:23]
      error <= 1'h0; // @[AecIntDivider.scala 84:11]
    end else if (_T) begin // @[AecIntDivider.scala 51:22]
      error <= io_req_bits_divisor == 32'h0; // @[AecIntDivider.scala 58:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  divisor = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  dividend = _RAND_2[31:0];
  _RAND_3 = {2{`RANDOM}};
  remainder = _RAND_3[32:0];
  _RAND_4 = {1{`RANDOM}};
  quotient = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  quotientNegative = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  count = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  result = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  error = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RoundAnyRawFNToRecFN_ie8_is24_oe11_os53(
  input         io_invalidExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [24:0] io_in_sig,
  output [64:0] io_out
);
  wire [11:0] _GEN_0 = {{2{io_in_sExp[9]}},io_in_sExp}; // @[RoundAnyRawFNToRecFN.scala 104:25]
  wire [12:0] _sAdjustedExp_T = $signed(_GEN_0) + 12'sh700; // @[RoundAnyRawFNToRecFN.scala 104:25]
  wire [12:0] sAdjustedExp = {1'b0,$signed(_sAdjustedExp_T[11:0])}; // @[RoundAnyRawFNToRecFN.scala 106:31]
  wire [55:0] adjustedSig = {io_in_sig, 31'h0}; // @[RoundAnyRawFNToRecFN.scala 114:22]
  wire [12:0] _common_expOut_T_1 = {{1'd0}, sAdjustedExp[11:0]}; // @[RoundAnyRawFNToRecFN.scala 136:55]
  wire [11:0] common_expOut = _common_expOut_T_1[11:0]; // @[RoundAnyRawFNToRecFN.scala 136:55]
  wire [51:0] common_fractOut = adjustedSig[53:2]; // @[RoundAnyRawFNToRecFN.scala 140:28]
  wire  isNaNOut = io_invalidExc | io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 235:34]
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; // @[RoundAnyRawFNToRecFN.scala 250:22]
  wire [11:0] _expOut_T_1 = io_in_isZero ? 12'he00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 253:18]
  wire [11:0] _expOut_T_2 = ~_expOut_T_1; // @[RoundAnyRawFNToRecFN.scala 253:14]
  wire [11:0] _expOut_T_3 = common_expOut & _expOut_T_2; // @[RoundAnyRawFNToRecFN.scala 252:24]
  wire [11:0] _expOut_T_11 = io_in_isInf ? 12'h200 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 265:18]
  wire [11:0] _expOut_T_12 = ~_expOut_T_11; // @[RoundAnyRawFNToRecFN.scala 265:14]
  wire [11:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; // @[RoundAnyRawFNToRecFN.scala 264:17]
  wire [11:0] _expOut_T_18 = io_in_isInf ? 12'hc00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 277:16]
  wire [11:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; // @[RoundAnyRawFNToRecFN.scala 276:15]
  wire [11:0] _expOut_T_20 = isNaNOut ? 12'he00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 278:16]
  wire [11:0] expOut = _expOut_T_19 | _expOut_T_20; // @[RoundAnyRawFNToRecFN.scala 277:73]
  wire [51:0] _fractOut_T_2 = isNaNOut ? 52'h8000000000000 : 52'h0; // @[RoundAnyRawFNToRecFN.scala 281:16]
  wire [51:0] fractOut = isNaNOut | io_in_isZero ? _fractOut_T_2 : common_fractOut; // @[RoundAnyRawFNToRecFN.scala 280:12]
  wire [12:0] _io_out_T = {signOut,expOut}; // @[RoundAnyRawFNToRecFN.scala 286:23]
  assign io_out = {_io_out_T,fractOut}; // @[RoundAnyRawFNToRecFN.scala 286:33]
endmodule
module RecFNToRecFN(
  input  [32:0] io_in,
  output [64:0] io_out
);
  wire  roundAnyRawFNToRecFN_io_invalidExc; // @[RecFNToRecFN.scala 72:19]
  wire  roundAnyRawFNToRecFN_io_in_isNaN; // @[RecFNToRecFN.scala 72:19]
  wire  roundAnyRawFNToRecFN_io_in_isInf; // @[RecFNToRecFN.scala 72:19]
  wire  roundAnyRawFNToRecFN_io_in_isZero; // @[RecFNToRecFN.scala 72:19]
  wire  roundAnyRawFNToRecFN_io_in_sign; // @[RecFNToRecFN.scala 72:19]
  wire [9:0] roundAnyRawFNToRecFN_io_in_sExp; // @[RecFNToRecFN.scala 72:19]
  wire [24:0] roundAnyRawFNToRecFN_io_in_sig; // @[RecFNToRecFN.scala 72:19]
  wire [64:0] roundAnyRawFNToRecFN_io_out; // @[RecFNToRecFN.scala 72:19]
  wire [8:0] rawIn_exp = io_in[31:23]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawIn_isZero = rawIn_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawIn_isSpecial = rawIn_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawIn__isNaN = rawIn_isSpecial & rawIn_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  _rawIn_out_sig_T = ~rawIn_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [1:0] _rawIn_out_sig_T_1 = {1'h0,_rawIn_out_sig_T}; // @[rawFloatFromRecFN.scala 61:32]
  wire [24:0] rawIn__sig = {1'h0,_rawIn_out_sig_T,io_in[22:0]}; // @[rawFloatFromRecFN.scala 61:44]
  RoundAnyRawFNToRecFN_ie8_is24_oe11_os53 roundAnyRawFNToRecFN ( // @[RecFNToRecFN.scala 72:19]
    .io_invalidExc(roundAnyRawFNToRecFN_io_invalidExc),
    .io_in_isNaN(roundAnyRawFNToRecFN_io_in_isNaN),
    .io_in_isInf(roundAnyRawFNToRecFN_io_in_isInf),
    .io_in_isZero(roundAnyRawFNToRecFN_io_in_isZero),
    .io_in_sign(roundAnyRawFNToRecFN_io_in_sign),
    .io_in_sExp(roundAnyRawFNToRecFN_io_in_sExp),
    .io_in_sig(roundAnyRawFNToRecFN_io_in_sig),
    .io_out(roundAnyRawFNToRecFN_io_out)
  );
  assign io_out = roundAnyRawFNToRecFN_io_out; // @[RecFNToRecFN.scala 85:27]
  assign roundAnyRawFNToRecFN_io_invalidExc = rawIn__isNaN & ~rawIn__sig[22]; // @[common.scala 82:46]
  assign roundAnyRawFNToRecFN_io_in_isNaN = rawIn_isSpecial & rawIn_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  assign roundAnyRawFNToRecFN_io_in_isInf = rawIn_isSpecial & ~rawIn_exp[6]; // @[rawFloatFromRecFN.scala 57:33]
  assign roundAnyRawFNToRecFN_io_in_isZero = rawIn_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  assign roundAnyRawFNToRecFN_io_in_sign = io_in[32]; // @[rawFloatFromRecFN.scala 59:25]
  assign roundAnyRawFNToRecFN_io_in_sExp = {1'b0,$signed(rawIn_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  assign roundAnyRawFNToRecFN_io_in_sig = {_rawIn_out_sig_T_1,io_in[22:0]}; // @[rawFloatFromRecFN.scala 61:44]
endmodule
module DivSqrtRawFN_small_e11_s53(
  input         clock,
  input         reset,
  output        io_inReady,
  input         io_inValid,
  input         io_sqrtOp,
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [12:0] io_a_sExp,
  input  [53:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [12:0] io_b_sExp,
  input  [53:0] io_b_sig,
  output        io_rawOutValid_div,
  output        io_rawOutValid_sqrt,
  output        io_invalidExc,
  output        io_infiniteExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [12:0] io_rawOut_sExp,
  output [55:0] io_rawOut_sig
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] cycleNum; // @[DivSqrtRecFN_small.scala 224:33]
  reg  inReady; // @[DivSqrtRecFN_small.scala 225:33]
  reg  rawOutValid; // @[DivSqrtRecFN_small.scala 226:33]
  reg  sqrtOp_Z; // @[DivSqrtRecFN_small.scala 228:29]
  reg  majorExc_Z; // @[DivSqrtRecFN_small.scala 229:29]
  reg  isNaN_Z; // @[DivSqrtRecFN_small.scala 231:29]
  reg  isInf_Z; // @[DivSqrtRecFN_small.scala 232:29]
  reg  isZero_Z; // @[DivSqrtRecFN_small.scala 233:29]
  reg  sign_Z; // @[DivSqrtRecFN_small.scala 234:29]
  reg [12:0] sExp_Z; // @[DivSqrtRecFN_small.scala 235:29]
  reg [52:0] fractB_Z; // @[DivSqrtRecFN_small.scala 236:29]
  reg [54:0] rem_Z; // @[DivSqrtRecFN_small.scala 243:29]
  reg  notZeroRem_Z; // @[DivSqrtRecFN_small.scala 244:29]
  reg [54:0] sigX_Z; // @[DivSqrtRecFN_small.scala 245:29]
  wire  notSigNaNIn_invalidExc_S_div = io_a_isZero & io_b_isZero | io_a_isInf & io_b_isInf; // @[DivSqrtRecFN_small.scala 254:42]
  wire  _notSigNaNIn_invalidExc_S_sqrt_T = ~io_a_isNaN; // @[DivSqrtRecFN_small.scala 256:9]
  wire  notSigNaNIn_invalidExc_S_sqrt = ~io_a_isNaN & ~io_a_isZero & io_a_sign; // @[DivSqrtRecFN_small.scala 256:43]
  wire  _majorExc_S_T_2 = io_a_isNaN & ~io_a_sig[51]; // @[common.scala 82:46]
  wire  _majorExc_S_T_3 = _majorExc_S_T_2 | notSigNaNIn_invalidExc_S_sqrt; // @[DivSqrtRecFN_small.scala 259:38]
  wire  _majorExc_S_T_9 = io_b_isNaN & ~io_b_sig[51]; // @[common.scala 82:46]
  wire  _majorExc_S_T_11 = _majorExc_S_T_2 | _majorExc_S_T_9 | notSigNaNIn_invalidExc_S_div; // @[DivSqrtRecFN_small.scala 260:66]
  wire  _majorExc_S_T_15 = _notSigNaNIn_invalidExc_S_sqrt_T & ~io_a_isInf & io_b_isZero; // @[DivSqrtRecFN_small.scala 262:51]
  wire  _majorExc_S_T_16 = _majorExc_S_T_11 | _majorExc_S_T_15; // @[DivSqrtRecFN_small.scala 261:46]
  wire  _isNaN_S_T = io_a_isNaN | notSigNaNIn_invalidExc_S_sqrt; // @[DivSqrtRecFN_small.scala 266:26]
  wire  _isNaN_S_T_2 = io_a_isNaN | io_b_isNaN | notSigNaNIn_invalidExc_S_div; // @[DivSqrtRecFN_small.scala 267:42]
  wire  _sign_S_T = ~io_sqrtOp; // @[DivSqrtRecFN_small.scala 271:33]
  wire  sign_S = io_a_sign ^ ~io_sqrtOp & io_b_sign; // @[DivSqrtRecFN_small.scala 271:30]
  wire  specialCaseA_S = io_a_isNaN | io_a_isInf | io_a_isZero; // @[DivSqrtRecFN_small.scala 273:55]
  wire  specialCaseB_S = io_b_isNaN | io_b_isInf | io_b_isZero; // @[DivSqrtRecFN_small.scala 274:55]
  wire  _normalCase_S_div_T = ~specialCaseA_S; // @[DivSqrtRecFN_small.scala 275:28]
  wire  normalCase_S_div = ~specialCaseA_S & ~specialCaseB_S; // @[DivSqrtRecFN_small.scala 275:45]
  wire  normalCase_S_sqrt = _normalCase_S_div_T & ~io_a_sign; // @[DivSqrtRecFN_small.scala 276:46]
  wire  normalCase_S = io_sqrtOp ? normalCase_S_sqrt : normalCase_S_div; // @[DivSqrtRecFN_small.scala 277:27]
  wire [10:0] _sExpQuot_S_div_T_2 = ~io_b_sExp[10:0]; // @[DivSqrtRecFN_small.scala 281:40]
  wire [11:0] _sExpQuot_S_div_T_4 = {io_b_sExp[11],_sExpQuot_S_div_T_2}; // @[DivSqrtRecFN_small.scala 281:71]
  wire [12:0] _GEN_15 = {{1{_sExpQuot_S_div_T_4[11]}},_sExpQuot_S_div_T_4}; // @[DivSqrtRecFN_small.scala 280:21]
  wire [13:0] sExpQuot_S_div = $signed(io_a_sExp) + $signed(_GEN_15); // @[DivSqrtRecFN_small.scala 280:21]
  wire [3:0] _sSatExpQuot_S_div_T_2 = 14'she00 <= $signed(sExpQuot_S_div) ? 4'h6 : sExpQuot_S_div[12:9]; // @[DivSqrtRecFN_small.scala 284:16]
  wire [12:0] sSatExpQuot_S_div = {_sSatExpQuot_S_div_T_2,sExpQuot_S_div[8:0]}; // @[DivSqrtRecFN_small.scala 289:11]
  wire  _evenSqrt_S_T_1 = ~io_a_sExp[0]; // @[DivSqrtRecFN_small.scala 291:35]
  wire  evenSqrt_S = io_sqrtOp & ~io_a_sExp[0]; // @[DivSqrtRecFN_small.scala 291:32]
  wire  oddSqrt_S = io_sqrtOp & io_a_sExp[0]; // @[DivSqrtRecFN_small.scala 292:32]
  wire  idle = cycleNum == 6'h0; // @[DivSqrtRecFN_small.scala 296:25]
  wire  entering = inReady & io_inValid; // @[DivSqrtRecFN_small.scala 297:28]
  wire  entering_normalCase = entering & normalCase_S; // @[DivSqrtRecFN_small.scala 298:40]
  wire  skipCycle2 = cycleNum == 6'h3 & sigX_Z[54]; // @[DivSqrtRecFN_small.scala 301:39]
  wire  _inReady_T_1 = entering & ~normalCase_S; // @[DivSqrtRecFN_small.scala 305:26]
  wire [5:0] _inReady_T_17 = cycleNum - 6'h1; // @[DivSqrtRecFN_small.scala 313:56]
  wire  _inReady_T_18 = _inReady_T_17 <= 6'h1; // @[DivSqrtRecFN_small.scala 317:38]
  wire  _inReady_T_19 = ~entering & ~skipCycle2 & _inReady_T_18; // @[DivSqrtRecFN_small.scala 313:16]
  wire  _inReady_T_20 = _inReady_T_1 | _inReady_T_19; // @[DivSqrtRecFN_small.scala 312:15]
  wire  _inReady_T_23 = _inReady_T_20 | skipCycle2; // @[DivSqrtRecFN_small.scala 313:95]
  wire  _rawOutValid_T_18 = _inReady_T_17 == 6'h1; // @[DivSqrtRecFN_small.scala 318:42]
  wire  _rawOutValid_T_19 = ~entering & ~skipCycle2 & _rawOutValid_T_18; // @[DivSqrtRecFN_small.scala 313:16]
  wire  _rawOutValid_T_20 = _inReady_T_1 | _rawOutValid_T_19; // @[DivSqrtRecFN_small.scala 312:15]
  wire  _rawOutValid_T_23 = _rawOutValid_T_20 | skipCycle2; // @[DivSqrtRecFN_small.scala 313:95]
  wire [5:0] _cycleNum_T_4 = io_a_sExp[0] ? 6'h35 : 6'h36; // @[DivSqrtRecFN_small.scala 308:24]
  wire [5:0] _cycleNum_T_5 = io_sqrtOp ? _cycleNum_T_4 : 6'h37; // @[DivSqrtRecFN_small.scala 307:20]
  wire [5:0] _cycleNum_T_6 = entering_normalCase ? _cycleNum_T_5 : 6'h0; // @[DivSqrtRecFN_small.scala 306:16]
  wire [5:0] _GEN_16 = {{5'd0}, _inReady_T_1}; // @[DivSqrtRecFN_small.scala 305:57]
  wire [5:0] _cycleNum_T_7 = _GEN_16 | _cycleNum_T_6; // @[DivSqrtRecFN_small.scala 305:57]
  wire [5:0] _cycleNum_T_14 = ~entering & ~skipCycle2 ? _inReady_T_17 : 6'h0; // @[DivSqrtRecFN_small.scala 313:16]
  wire [5:0] _cycleNum_T_15 = _cycleNum_T_7 | _cycleNum_T_14; // @[DivSqrtRecFN_small.scala 312:15]
  wire [5:0] _GEN_17 = {{5'd0}, skipCycle2}; // @[DivSqrtRecFN_small.scala 313:95]
  wire [5:0] _cycleNum_T_17 = _cycleNum_T_15 | _GEN_17; // @[DivSqrtRecFN_small.scala 313:95]
  wire  _GEN_0 = ~idle | entering ? _inReady_T_23 : inReady; // @[DivSqrtRecFN_small.scala 303:31 317:17 225:33]
  wire [11:0] _sExp_Z_T = io_a_sExp[12:1]; // @[DivSqrtRecFN_small.scala 335:29]
  wire [12:0] _sExp_Z_T_1 = $signed(_sExp_Z_T) + 12'sh400; // @[DivSqrtRecFN_small.scala 335:34]
  wire  _T_2 = ~inReady; // @[DivSqrtRecFN_small.scala 340:23]
  wire  _T_3 = ~inReady & sqrtOp_Z; // @[DivSqrtRecFN_small.scala 340:33]
  wire  _fractB_Z_T_1 = inReady & _sign_S_T; // @[DivSqrtRecFN_small.scala 342:25]
  wire [52:0] _fractB_Z_T_3 = {io_b_sig[51:0], 1'h0}; // @[DivSqrtRecFN_small.scala 342:90]
  wire [52:0] _fractB_Z_T_4 = inReady & _sign_S_T ? _fractB_Z_T_3 : 53'h0; // @[DivSqrtRecFN_small.scala 342:16]
  wire  _fractB_Z_T_5 = inReady & io_sqrtOp; // @[DivSqrtRecFN_small.scala 343:25]
  wire [51:0] _fractB_Z_T_8 = inReady & io_sqrtOp & io_a_sExp[0] ? 52'h8000000000000 : 52'h0; // @[DivSqrtRecFN_small.scala 343:16]
  wire [52:0] _GEN_18 = {{1'd0}, _fractB_Z_T_8}; // @[DivSqrtRecFN_small.scala 342:100]
  wire [52:0] _fractB_Z_T_9 = _fractB_Z_T_4 | _GEN_18; // @[DivSqrtRecFN_small.scala 342:100]
  wire [52:0] _fractB_Z_T_14 = _fractB_Z_T_5 & _evenSqrt_S_T_1 ? 53'h10000000000000 : 53'h0; // @[DivSqrtRecFN_small.scala 344:16]
  wire [52:0] _fractB_Z_T_15 = _fractB_Z_T_9 | _fractB_Z_T_14; // @[DivSqrtRecFN_small.scala 343:100]
  wire [51:0] _fractB_Z_T_25 = _T_2 ? fractB_Z[52:1] : 52'h0; // @[DivSqrtRecFN_small.scala 346:16]
  wire [52:0] _GEN_19 = {{1'd0}, _fractB_Z_T_25}; // @[DivSqrtRecFN_small.scala 345:100]
  wire [52:0] _fractB_Z_T_26 = _fractB_Z_T_15 | _GEN_19; // @[DivSqrtRecFN_small.scala 345:100]
  wire [54:0] _rem_T_2 = {io_a_sig, 1'h0}; // @[DivSqrtRecFN_small.scala 352:47]
  wire [54:0] _rem_T_3 = inReady & ~oddSqrt_S ? _rem_T_2 : 55'h0; // @[DivSqrtRecFN_small.scala 352:12]
  wire  _rem_T_4 = inReady & oddSqrt_S; // @[DivSqrtRecFN_small.scala 353:21]
  wire [1:0] _rem_T_7 = io_a_sig[52:51] - 2'h1; // @[DivSqrtRecFN_small.scala 354:56]
  wire [53:0] _rem_T_9 = {io_a_sig[50:0], 3'h0}; // @[DivSqrtRecFN_small.scala 355:44]
  wire [55:0] _rem_T_10 = {_rem_T_7,_rem_T_9}; // @[Cat.scala 33:92]
  wire [55:0] _rem_T_11 = inReady & oddSqrt_S ? _rem_T_10 : 56'h0; // @[DivSqrtRecFN_small.scala 353:12]
  wire [55:0] _GEN_20 = {{1'd0}, _rem_T_3}; // @[DivSqrtRecFN_small.scala 352:57]
  wire [55:0] _rem_T_12 = _GEN_20 | _rem_T_11; // @[DivSqrtRecFN_small.scala 352:57]
  wire [55:0] _rem_T_14 = {rem_Z, 1'h0}; // @[DivSqrtRecFN_small.scala 359:29]
  wire [55:0] _rem_T_15 = _T_2 ? _rem_T_14 : 56'h0; // @[DivSqrtRecFN_small.scala 359:12]
  wire [55:0] rem = _rem_T_12 | _rem_T_15; // @[DivSqrtRecFN_small.scala 358:11]
  wire [63:0] _bitMask_T = 64'h1 << cycleNum; // @[DivSqrtRecFN_small.scala 360:23]
  wire [61:0] bitMask = _bitMask_T[63:2]; // @[DivSqrtRecFN_small.scala 360:34]
  wire [54:0] _trialTerm_T_2 = {io_b_sig, 1'h0}; // @[DivSqrtRecFN_small.scala 362:48]
  wire [54:0] _trialTerm_T_3 = _fractB_Z_T_1 ? _trialTerm_T_2 : 55'h0; // @[DivSqrtRecFN_small.scala 362:12]
  wire [53:0] _trialTerm_T_5 = inReady & evenSqrt_S ? 54'h20000000000000 : 54'h0; // @[DivSqrtRecFN_small.scala 363:12]
  wire [54:0] _GEN_21 = {{1'd0}, _trialTerm_T_5}; // @[DivSqrtRecFN_small.scala 362:74]
  wire [54:0] _trialTerm_T_6 = _trialTerm_T_3 | _GEN_21; // @[DivSqrtRecFN_small.scala 362:74]
  wire [54:0] _trialTerm_T_8 = _rem_T_4 ? 55'h50000000000000 : 55'h0; // @[DivSqrtRecFN_small.scala 364:12]
  wire [54:0] _trialTerm_T_9 = _trialTerm_T_6 | _trialTerm_T_8; // @[DivSqrtRecFN_small.scala 363:74]
  wire [52:0] _trialTerm_T_11 = _T_2 ? fractB_Z : 53'h0; // @[DivSqrtRecFN_small.scala 365:12]
  wire [54:0] _GEN_22 = {{2'd0}, _trialTerm_T_11}; // @[DivSqrtRecFN_small.scala 364:74]
  wire [54:0] _trialTerm_T_12 = _trialTerm_T_9 | _GEN_22; // @[DivSqrtRecFN_small.scala 364:74]
  wire  _trialTerm_T_14 = ~sqrtOp_Z; // @[DivSqrtRecFN_small.scala 366:26]
  wire [53:0] _trialTerm_T_17 = _T_2 & ~sqrtOp_Z ? 54'h20000000000000 : 54'h0; // @[DivSqrtRecFN_small.scala 366:12]
  wire [54:0] _GEN_23 = {{1'd0}, _trialTerm_T_17}; // @[DivSqrtRecFN_small.scala 365:74]
  wire [54:0] _trialTerm_T_18 = _trialTerm_T_12 | _GEN_23; // @[DivSqrtRecFN_small.scala 365:74]
  wire [55:0] _trialTerm_T_21 = {sigX_Z, 1'h0}; // @[DivSqrtRecFN_small.scala 367:44]
  wire [55:0] _trialTerm_T_22 = _T_3 ? _trialTerm_T_21 : 56'h0; // @[DivSqrtRecFN_small.scala 367:12]
  wire [55:0] _GEN_24 = {{1'd0}, _trialTerm_T_18}; // @[DivSqrtRecFN_small.scala 366:74]
  wire [55:0] trialTerm = _GEN_24 | _trialTerm_T_22; // @[DivSqrtRecFN_small.scala 366:74]
  wire [56:0] _trialRem_T = {1'b0,$signed(rem)}; // @[DivSqrtRecFN_small.scala 368:24]
  wire [56:0] _trialRem_T_1 = {1'b0,$signed(trialTerm)}; // @[DivSqrtRecFN_small.scala 368:42]
  wire [57:0] trialRem = $signed(_trialRem_T) - $signed(_trialRem_T_1); // @[DivSqrtRecFN_small.scala 368:29]
  wire  newBit = 58'sh0 <= $signed(trialRem); // @[DivSqrtRecFN_small.scala 369:23]
  wire [57:0] _nextRem_Z_T = $signed(_trialRem_T) - $signed(_trialRem_T_1); // @[DivSqrtRecFN_small.scala 371:42]
  wire [57:0] _nextRem_Z_T_1 = newBit ? _nextRem_Z_T : {{2'd0}, rem}; // @[DivSqrtRecFN_small.scala 371:24]
  wire [54:0] nextRem_Z = _nextRem_Z_T_1[54:0]; // @[DivSqrtRecFN_small.scala 371:54]
  wire [54:0] _sigX_Z_T_2 = {newBit, 54'h0}; // @[DivSqrtRecFN_small.scala 394:50]
  wire [54:0] _sigX_Z_T_3 = _fractB_Z_T_1 ? _sigX_Z_T_2 : 55'h0; // @[DivSqrtRecFN_small.scala 394:16]
  wire [53:0] _sigX_Z_T_5 = _fractB_Z_T_5 ? 54'h20000000000000 : 54'h0; // @[DivSqrtRecFN_small.scala 395:16]
  wire [54:0] _GEN_30 = {{1'd0}, _sigX_Z_T_5}; // @[DivSqrtRecFN_small.scala 394:74]
  wire [54:0] _sigX_Z_T_6 = _sigX_Z_T_3 | _GEN_30; // @[DivSqrtRecFN_small.scala 394:74]
  wire [52:0] _sigX_Z_T_8 = {newBit, 52'h0}; // @[DivSqrtRecFN_small.scala 396:50]
  wire [52:0] _sigX_Z_T_9 = _rem_T_4 ? _sigX_Z_T_8 : 53'h0; // @[DivSqrtRecFN_small.scala 396:16]
  wire [54:0] _GEN_31 = {{2'd0}, _sigX_Z_T_9}; // @[DivSqrtRecFN_small.scala 395:74]
  wire [54:0] _sigX_Z_T_10 = _sigX_Z_T_6 | _GEN_31; // @[DivSqrtRecFN_small.scala 395:74]
  wire [54:0] _sigX_Z_T_12 = _T_2 ? sigX_Z : 55'h0; // @[DivSqrtRecFN_small.scala 397:16]
  wire [54:0] _sigX_Z_T_13 = _sigX_Z_T_10 | _sigX_Z_T_12; // @[DivSqrtRecFN_small.scala 396:74]
  wire [61:0] _sigX_Z_T_16 = _T_2 & newBit ? bitMask : 62'h0; // @[DivSqrtRecFN_small.scala 398:16]
  wire [61:0] _GEN_32 = {{7'd0}, _sigX_Z_T_13}; // @[DivSqrtRecFN_small.scala 397:74]
  wire [61:0] _sigX_Z_T_17 = _GEN_32 | _sigX_Z_T_16; // @[DivSqrtRecFN_small.scala 397:74]
  wire [61:0] _GEN_14 = entering | _T_2 ? _sigX_Z_T_17 : {{7'd0}, sigX_Z}; // @[DivSqrtRecFN_small.scala 390:34 393:16 245:29]
  wire [55:0] _GEN_33 = {{55'd0}, notZeroRem_Z}; // @[DivSqrtRecFN_small.scala 414:35]
  assign io_inReady = inReady; // @[DivSqrtRecFN_small.scala 322:16]
  assign io_rawOutValid_div = rawOutValid & _trialTerm_T_14; // @[DivSqrtRecFN_small.scala 404:40]
  assign io_rawOutValid_sqrt = rawOutValid & sqrtOp_Z; // @[DivSqrtRecFN_small.scala 405:40]
  assign io_invalidExc = majorExc_Z & isNaN_Z; // @[DivSqrtRecFN_small.scala 407:36]
  assign io_infiniteExc = majorExc_Z & ~isNaN_Z; // @[DivSqrtRecFN_small.scala 408:36]
  assign io_rawOut_isNaN = isNaN_Z; // @[DivSqrtRecFN_small.scala 409:22]
  assign io_rawOut_isInf = isInf_Z; // @[DivSqrtRecFN_small.scala 410:22]
  assign io_rawOut_isZero = isZero_Z; // @[DivSqrtRecFN_small.scala 411:22]
  assign io_rawOut_sign = sign_Z; // @[DivSqrtRecFN_small.scala 412:22]
  assign io_rawOut_sExp = sExp_Z; // @[DivSqrtRecFN_small.scala 413:22]
  assign io_rawOut_sig = _trialTerm_T_21 | _GEN_33; // @[DivSqrtRecFN_small.scala 414:35]
  always @(posedge clock) begin
    if (reset) begin // @[DivSqrtRecFN_small.scala 224:33]
      cycleNum <= 6'h0; // @[DivSqrtRecFN_small.scala 224:33]
    end else if (~idle | entering) begin // @[DivSqrtRecFN_small.scala 303:31]
      cycleNum <= _cycleNum_T_17; // @[DivSqrtRecFN_small.scala 319:18]
    end
    inReady <= reset | _GEN_0; // @[DivSqrtRecFN_small.scala 225:{33,33}]
    if (reset) begin // @[DivSqrtRecFN_small.scala 226:33]
      rawOutValid <= 1'h0; // @[DivSqrtRecFN_small.scala 226:33]
    end else if (~idle | entering) begin // @[DivSqrtRecFN_small.scala 303:31]
      rawOutValid <= _rawOutValid_T_23; // @[DivSqrtRecFN_small.scala 318:21]
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      sqrtOp_Z <= io_sqrtOp; // @[DivSqrtRecFN_small.scala 327:20]
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      if (io_sqrtOp) begin // @[DivSqrtRecFN_small.scala 258:12]
        majorExc_Z <= _majorExc_S_T_3;
      end else begin
        majorExc_Z <= _majorExc_S_T_16;
      end
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      if (io_sqrtOp) begin // @[DivSqrtRecFN_small.scala 265:12]
        isNaN_Z <= _isNaN_S_T;
      end else begin
        isNaN_Z <= _isNaN_S_T_2;
      end
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      if (io_sqrtOp) begin // @[DivSqrtRecFN_small.scala 269:23]
        isInf_Z <= io_a_isInf;
      end else begin
        isInf_Z <= io_a_isInf | io_b_isZero;
      end
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      if (io_sqrtOp) begin // @[DivSqrtRecFN_small.scala 270:23]
        isZero_Z <= io_a_isZero;
      end else begin
        isZero_Z <= io_a_isZero | io_b_isInf;
      end
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      sign_Z <= sign_S; // @[DivSqrtRecFN_small.scala 332:20]
    end
    if (entering) begin // @[DivSqrtRecFN_small.scala 326:21]
      if (io_sqrtOp) begin // @[DivSqrtRecFN_small.scala 334:16]
        sExp_Z <= _sExp_Z_T_1;
      end else begin
        sExp_Z <= sSatExpQuot_S_div;
      end
    end
    if (entering | ~inReady & sqrtOp_Z) begin // @[DivSqrtRecFN_small.scala 340:46]
      fractB_Z <= _fractB_Z_T_26; // @[DivSqrtRecFN_small.scala 341:18]
    end
    if (entering | _T_2) begin // @[DivSqrtRecFN_small.scala 390:34]
      rem_Z <= nextRem_Z; // @[DivSqrtRecFN_small.scala 392:15]
    end
    if (entering | _T_2) begin // @[DivSqrtRecFN_small.scala 390:34]
      if (inReady | newBit) begin // @[DivSqrtRecFN_small.scala 380:31]
        notZeroRem_Z <= $signed(trialRem) != 58'sh0;
      end
    end
    sigX_Z <= _GEN_14[54:0];
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cycleNum = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  inReady = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rawOutValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sqrtOp_Z = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  majorExc_Z = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  isNaN_Z = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  isInf_Z = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  isZero_Z = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sign_Z = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sExp_Z = _RAND_9[12:0];
  _RAND_10 = {2{`RANDOM}};
  fractB_Z = _RAND_10[52:0];
  _RAND_11 = {2{`RANDOM}};
  rem_Z = _RAND_11[54:0];
  _RAND_12 = {1{`RANDOM}};
  notZeroRem_Z = _RAND_12[0:0];
  _RAND_13 = {2{`RANDOM}};
  sigX_Z = _RAND_13[54:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DivSqrtRecFMToRaw_small_e11_s53(
  input         clock,
  input         reset,
  output        io_inReady,
  input         io_inValid,
  input         io_sqrtOp,
  input  [64:0] io_a,
  input  [64:0] io_b,
  output        io_rawOutValid_div,
  output        io_rawOutValid_sqrt,
  output        io_invalidExc,
  output        io_infiniteExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [12:0] io_rawOut_sExp,
  output [55:0] io_rawOut_sig
);
  wire  divSqrtRawFN__clock; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__reset; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_inReady; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_inValid; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_sqrtOp; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_a_isNaN; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_a_isInf; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_a_isZero; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_a_sign; // @[DivSqrtRecFN_small.scala 446:15]
  wire [12:0] divSqrtRawFN__io_a_sExp; // @[DivSqrtRecFN_small.scala 446:15]
  wire [53:0] divSqrtRawFN__io_a_sig; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_b_isNaN; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_b_isInf; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_b_isZero; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_b_sign; // @[DivSqrtRecFN_small.scala 446:15]
  wire [12:0] divSqrtRawFN__io_b_sExp; // @[DivSqrtRecFN_small.scala 446:15]
  wire [53:0] divSqrtRawFN__io_b_sig; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOutValid_div; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOutValid_sqrt; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_invalidExc; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_infiniteExc; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOut_isNaN; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOut_isInf; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOut_isZero; // @[DivSqrtRecFN_small.scala 446:15]
  wire  divSqrtRawFN__io_rawOut_sign; // @[DivSqrtRecFN_small.scala 446:15]
  wire [12:0] divSqrtRawFN__io_rawOut_sExp; // @[DivSqrtRecFN_small.scala 446:15]
  wire [55:0] divSqrtRawFN__io_rawOut_sig; // @[DivSqrtRecFN_small.scala 446:15]
  wire [11:0] divSqrtRawFN_io_a_exp = io_a[63:52]; // @[rawFloatFromRecFN.scala 51:21]
  wire  divSqrtRawFN_io_a_isZero = divSqrtRawFN_io_a_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  divSqrtRawFN_io_a_isSpecial = divSqrtRawFN_io_a_exp[11:10] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  _divSqrtRawFN_io_a_out_sig_T = ~divSqrtRawFN_io_a_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [1:0] _divSqrtRawFN_io_a_out_sig_T_1 = {1'h0,_divSqrtRawFN_io_a_out_sig_T}; // @[rawFloatFromRecFN.scala 61:32]
  wire [11:0] divSqrtRawFN_io_b_exp = io_b[63:52]; // @[rawFloatFromRecFN.scala 51:21]
  wire  divSqrtRawFN_io_b_isZero = divSqrtRawFN_io_b_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  divSqrtRawFN_io_b_isSpecial = divSqrtRawFN_io_b_exp[11:10] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  _divSqrtRawFN_io_b_out_sig_T = ~divSqrtRawFN_io_b_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [1:0] _divSqrtRawFN_io_b_out_sig_T_1 = {1'h0,_divSqrtRawFN_io_b_out_sig_T}; // @[rawFloatFromRecFN.scala 61:32]
  DivSqrtRawFN_small_e11_s53 divSqrtRawFN_ ( // @[DivSqrtRecFN_small.scala 446:15]
    .clock(divSqrtRawFN__clock),
    .reset(divSqrtRawFN__reset),
    .io_inReady(divSqrtRawFN__io_inReady),
    .io_inValid(divSqrtRawFN__io_inValid),
    .io_sqrtOp(divSqrtRawFN__io_sqrtOp),
    .io_a_isNaN(divSqrtRawFN__io_a_isNaN),
    .io_a_isInf(divSqrtRawFN__io_a_isInf),
    .io_a_isZero(divSqrtRawFN__io_a_isZero),
    .io_a_sign(divSqrtRawFN__io_a_sign),
    .io_a_sExp(divSqrtRawFN__io_a_sExp),
    .io_a_sig(divSqrtRawFN__io_a_sig),
    .io_b_isNaN(divSqrtRawFN__io_b_isNaN),
    .io_b_isInf(divSqrtRawFN__io_b_isInf),
    .io_b_isZero(divSqrtRawFN__io_b_isZero),
    .io_b_sign(divSqrtRawFN__io_b_sign),
    .io_b_sExp(divSqrtRawFN__io_b_sExp),
    .io_b_sig(divSqrtRawFN__io_b_sig),
    .io_rawOutValid_div(divSqrtRawFN__io_rawOutValid_div),
    .io_rawOutValid_sqrt(divSqrtRawFN__io_rawOutValid_sqrt),
    .io_invalidExc(divSqrtRawFN__io_invalidExc),
    .io_infiniteExc(divSqrtRawFN__io_infiniteExc),
    .io_rawOut_isNaN(divSqrtRawFN__io_rawOut_isNaN),
    .io_rawOut_isInf(divSqrtRawFN__io_rawOut_isInf),
    .io_rawOut_isZero(divSqrtRawFN__io_rawOut_isZero),
    .io_rawOut_sign(divSqrtRawFN__io_rawOut_sign),
    .io_rawOut_sExp(divSqrtRawFN__io_rawOut_sExp),
    .io_rawOut_sig(divSqrtRawFN__io_rawOut_sig)
  );
  assign io_inReady = divSqrtRawFN__io_inReady; // @[DivSqrtRecFN_small.scala 448:16]
  assign io_rawOutValid_div = divSqrtRawFN__io_rawOutValid_div; // @[DivSqrtRecFN_small.scala 455:25]
  assign io_rawOutValid_sqrt = divSqrtRawFN__io_rawOutValid_sqrt; // @[DivSqrtRecFN_small.scala 456:25]
  assign io_invalidExc = divSqrtRawFN__io_invalidExc; // @[DivSqrtRecFN_small.scala 458:25]
  assign io_infiniteExc = divSqrtRawFN__io_infiniteExc; // @[DivSqrtRecFN_small.scala 459:25]
  assign io_rawOut_isNaN = divSqrtRawFN__io_rawOut_isNaN; // @[DivSqrtRecFN_small.scala 460:25]
  assign io_rawOut_isInf = divSqrtRawFN__io_rawOut_isInf; // @[DivSqrtRecFN_small.scala 460:25]
  assign io_rawOut_isZero = divSqrtRawFN__io_rawOut_isZero; // @[DivSqrtRecFN_small.scala 460:25]
  assign io_rawOut_sign = divSqrtRawFN__io_rawOut_sign; // @[DivSqrtRecFN_small.scala 460:25]
  assign io_rawOut_sExp = divSqrtRawFN__io_rawOut_sExp; // @[DivSqrtRecFN_small.scala 460:25]
  assign io_rawOut_sig = divSqrtRawFN__io_rawOut_sig; // @[DivSqrtRecFN_small.scala 460:25]
  assign divSqrtRawFN__clock = clock;
  assign divSqrtRawFN__reset = reset;
  assign divSqrtRawFN__io_inValid = io_inValid; // @[DivSqrtRecFN_small.scala 449:34]
  assign divSqrtRawFN__io_sqrtOp = io_sqrtOp; // @[DivSqrtRecFN_small.scala 450:34]
  assign divSqrtRawFN__io_a_isNaN = divSqrtRawFN_io_a_isSpecial & divSqrtRawFN_io_a_exp[9]; // @[rawFloatFromRecFN.scala 56:33]
  assign divSqrtRawFN__io_a_isInf = divSqrtRawFN_io_a_isSpecial & ~divSqrtRawFN_io_a_exp[9]; // @[rawFloatFromRecFN.scala 57:33]
  assign divSqrtRawFN__io_a_isZero = divSqrtRawFN_io_a_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  assign divSqrtRawFN__io_a_sign = io_a[64]; // @[rawFloatFromRecFN.scala 59:25]
  assign divSqrtRawFN__io_a_sExp = {1'b0,$signed(divSqrtRawFN_io_a_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  assign divSqrtRawFN__io_a_sig = {_divSqrtRawFN_io_a_out_sig_T_1,io_a[51:0]}; // @[rawFloatFromRecFN.scala 61:44]
  assign divSqrtRawFN__io_b_isNaN = divSqrtRawFN_io_b_isSpecial & divSqrtRawFN_io_b_exp[9]; // @[rawFloatFromRecFN.scala 56:33]
  assign divSqrtRawFN__io_b_isInf = divSqrtRawFN_io_b_isSpecial & ~divSqrtRawFN_io_b_exp[9]; // @[rawFloatFromRecFN.scala 57:33]
  assign divSqrtRawFN__io_b_isZero = divSqrtRawFN_io_b_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  assign divSqrtRawFN__io_b_sign = io_b[64]; // @[rawFloatFromRecFN.scala 59:25]
  assign divSqrtRawFN__io_b_sExp = {1'b0,$signed(divSqrtRawFN_io_b_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  assign divSqrtRawFN__io_b_sig = {_divSqrtRawFN_io_b_out_sig_T_1,io_b[51:0]}; // @[rawFloatFromRecFN.scala 61:44]
endmodule
module RoundAnyRawFNToRecFN_ie11_is55_oe8_os24(
  input         io_invalidExc,
  input         io_infiniteExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [12:0] io_in_sExp,
  input  [55:0] io_in_sig,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags
);
  wire [13:0] sAdjustedExp = $signed(io_in_sExp) - 13'sh700; // @[RoundAnyRawFNToRecFN.scala 110:24]
  wire  _adjustedSig_T_2 = |io_in_sig[29:0]; // @[RoundAnyRawFNToRecFN.scala 117:60]
  wire [26:0] adjustedSig = {io_in_sig[55:30],_adjustedSig_T_2}; // @[RoundAnyRawFNToRecFN.scala 116:66]
  wire  doShiftSigDown1 = adjustedSig[26]; // @[RoundAnyRawFNToRecFN.scala 120:57]
  wire [8:0] _roundMask_T_1 = ~sAdjustedExp[8:0]; // @[primitives.scala 52:21]
  wire  roundMask_msb = _roundMask_T_1[8]; // @[primitives.scala 58:25]
  wire [7:0] roundMask_lsbs = _roundMask_T_1[7:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_1 = roundMask_lsbs[7]; // @[primitives.scala 58:25]
  wire [6:0] roundMask_lsbs_1 = roundMask_lsbs[6:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_2 = roundMask_lsbs_1[6]; // @[primitives.scala 58:25]
  wire [5:0] roundMask_lsbs_2 = roundMask_lsbs_1[5:0]; // @[primitives.scala 59:26]
  wire [64:0] roundMask_shift = 65'sh10000000000000000 >>> roundMask_lsbs_2; // @[primitives.scala 76:56]
  wire [15:0] _GEN_0 = {{8'd0}, roundMask_shift[57:50]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_5 = _GEN_0 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_7 = {roundMask_shift[49:42], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_9 = _roundMask_core_T_7 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_10 = _roundMask_core_T_5 | _roundMask_core_T_9; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_1 = {{4'd0}, _roundMask_core_T_10[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_15 = _GEN_1 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_17 = {_roundMask_core_T_10[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_19 = _roundMask_core_T_17 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_20 = _roundMask_core_T_15 | _roundMask_core_T_19; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_2 = {{2'd0}, _roundMask_core_T_20[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_25 = _GEN_2 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_27 = {_roundMask_core_T_20[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_29 = _roundMask_core_T_27 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_30 = _roundMask_core_T_25 | _roundMask_core_T_29; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_3 = {{1'd0}, _roundMask_core_T_30[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_35 = _GEN_3 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_37 = {_roundMask_core_T_30[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_39 = _roundMask_core_T_37 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_40 = _roundMask_core_T_35 | _roundMask_core_T_39; // @[Bitwise.scala 108:39]
  wire [21:0] roundMask_core = {_roundMask_core_T_40,roundMask_shift[58],roundMask_shift[59],roundMask_shift[60],
    roundMask_shift[61],roundMask_shift[62],roundMask_shift[63]}; // @[Cat.scala 33:92]
  wire [21:0] _roundMask_T_2 = ~roundMask_core; // @[primitives.scala 73:32]
  wire [21:0] _roundMask_T_3 = roundMask_msb_2 ? 22'h0 : _roundMask_T_2; // @[primitives.scala 73:21]
  wire [21:0] _roundMask_T_4 = ~_roundMask_T_3; // @[primitives.scala 73:17]
  wire [24:0] _roundMask_T_5 = {_roundMask_T_4,3'h7}; // @[primitives.scala 68:58]
  wire [2:0] roundMask_core_1 = {roundMask_shift[0],roundMask_shift[1],roundMask_shift[2]}; // @[Cat.scala 33:92]
  wire [2:0] _roundMask_T_6 = roundMask_msb_2 ? roundMask_core_1 : 3'h0; // @[primitives.scala 62:24]
  wire [24:0] _roundMask_T_7 = roundMask_msb_1 ? _roundMask_T_5 : {{22'd0}, _roundMask_T_6}; // @[primitives.scala 67:24]
  wire [24:0] _roundMask_T_8 = roundMask_msb ? _roundMask_T_7 : 25'h0; // @[primitives.scala 62:24]
  wire [24:0] _GEN_4 = {{24'd0}, doShiftSigDown1}; // @[RoundAnyRawFNToRecFN.scala 159:23]
  wire [24:0] _roundMask_T_9 = _roundMask_T_8 | _GEN_4; // @[RoundAnyRawFNToRecFN.scala 159:23]
  wire [26:0] roundMask = {_roundMask_T_9,2'h3}; // @[RoundAnyRawFNToRecFN.scala 159:42]
  wire [27:0] _shiftedRoundMask_T = {1'h0,_roundMask_T_9,2'h3}; // @[RoundAnyRawFNToRecFN.scala 162:41]
  wire [26:0] shiftedRoundMask = _shiftedRoundMask_T[27:1]; // @[RoundAnyRawFNToRecFN.scala 162:53]
  wire [26:0] _roundPosMask_T = ~shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 163:28]
  wire [26:0] roundPosMask = _roundPosMask_T & roundMask; // @[RoundAnyRawFNToRecFN.scala 163:46]
  wire [26:0] _roundPosBit_T = adjustedSig & roundPosMask; // @[RoundAnyRawFNToRecFN.scala 164:40]
  wire  roundPosBit = |_roundPosBit_T; // @[RoundAnyRawFNToRecFN.scala 164:56]
  wire [26:0] _anyRoundExtra_T = adjustedSig & shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 165:42]
  wire  anyRoundExtra = |_anyRoundExtra_T; // @[RoundAnyRawFNToRecFN.scala 165:62]
  wire  anyRound = roundPosBit | anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 166:36]
  wire [26:0] _roundedSig_T = adjustedSig | roundMask; // @[RoundAnyRawFNToRecFN.scala 174:32]
  wire [25:0] _roundedSig_T_2 = _roundedSig_T[26:2] + 25'h1; // @[RoundAnyRawFNToRecFN.scala 174:49]
  wire  _roundedSig_T_4 = ~anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 176:30]
  wire [25:0] _roundedSig_T_7 = roundPosBit & _roundedSig_T_4 ? roundMask[26:1] : 26'h0; // @[RoundAnyRawFNToRecFN.scala 175:25]
  wire [25:0] _roundedSig_T_8 = ~_roundedSig_T_7; // @[RoundAnyRawFNToRecFN.scala 175:21]
  wire [25:0] _roundedSig_T_9 = _roundedSig_T_2 & _roundedSig_T_8; // @[RoundAnyRawFNToRecFN.scala 174:57]
  wire [26:0] _roundedSig_T_10 = ~roundMask; // @[RoundAnyRawFNToRecFN.scala 180:32]
  wire [26:0] _roundedSig_T_11 = adjustedSig & _roundedSig_T_10; // @[RoundAnyRawFNToRecFN.scala 180:30]
  wire [25:0] _roundedSig_T_16 = {{1'd0}, _roundedSig_T_11[26:2]}; // @[RoundAnyRawFNToRecFN.scala 180:47]
  wire [25:0] roundedSig = roundPosBit ? _roundedSig_T_9 : _roundedSig_T_16; // @[RoundAnyRawFNToRecFN.scala 173:16]
  wire [2:0] _sRoundedExp_T_1 = {1'b0,$signed(roundedSig[25:24])}; // @[RoundAnyRawFNToRecFN.scala 185:76]
  wire [13:0] _GEN_5 = {{11{_sRoundedExp_T_1[2]}},_sRoundedExp_T_1}; // @[RoundAnyRawFNToRecFN.scala 185:40]
  wire [14:0] sRoundedExp = $signed(sAdjustedExp) + $signed(_GEN_5); // @[RoundAnyRawFNToRecFN.scala 185:40]
  wire [8:0] common_expOut = sRoundedExp[8:0]; // @[RoundAnyRawFNToRecFN.scala 187:37]
  wire [22:0] common_fractOut = doShiftSigDown1 ? roundedSig[23:1] : roundedSig[22:0]; // @[RoundAnyRawFNToRecFN.scala 189:16]
  wire [7:0] _common_overflow_T = sRoundedExp[14:7]; // @[RoundAnyRawFNToRecFN.scala 196:30]
  wire  common_overflow = $signed(_common_overflow_T) >= 8'sh3; // @[RoundAnyRawFNToRecFN.scala 196:50]
  wire  common_totalUnderflow = $signed(sRoundedExp) < 15'sh6b; // @[RoundAnyRawFNToRecFN.scala 200:31]
  wire [5:0] _common_underflow_T = sAdjustedExp[13:8]; // @[RoundAnyRawFNToRecFN.scala 220:49]
  wire  _common_underflow_T_5 = doShiftSigDown1 ? roundMask[3] : roundMask[2]; // @[RoundAnyRawFNToRecFN.scala 221:30]
  wire  _common_underflow_T_6 = anyRound & $signed(_common_underflow_T) <= 6'sh0 & _common_underflow_T_5; // @[RoundAnyRawFNToRecFN.scala 220:72]
  wire  common_underflow = common_totalUnderflow | _common_underflow_T_6; // @[RoundAnyRawFNToRecFN.scala 217:40]
  wire  common_inexact = common_totalUnderflow | anyRound; // @[RoundAnyRawFNToRecFN.scala 230:49]
  wire  isNaNOut = io_invalidExc | io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 235:34]
  wire  notNaN_isSpecialInfOut = io_infiniteExc | io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 236:49]
  wire  commonCase = ~isNaNOut & ~notNaN_isSpecialInfOut & ~io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 237:61]
  wire  overflow = commonCase & common_overflow; // @[RoundAnyRawFNToRecFN.scala 238:32]
  wire  underflow = commonCase & common_underflow; // @[RoundAnyRawFNToRecFN.scala 239:32]
  wire  inexact = overflow | commonCase & common_inexact; // @[RoundAnyRawFNToRecFN.scala 240:28]
  wire  notNaN_isInfOut = notNaN_isSpecialInfOut | overflow; // @[RoundAnyRawFNToRecFN.scala 248:32]
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; // @[RoundAnyRawFNToRecFN.scala 250:22]
  wire [8:0] _expOut_T_1 = io_in_isZero | common_totalUnderflow ? 9'h1c0 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 253:18]
  wire [8:0] _expOut_T_2 = ~_expOut_T_1; // @[RoundAnyRawFNToRecFN.scala 253:14]
  wire [8:0] _expOut_T_3 = common_expOut & _expOut_T_2; // @[RoundAnyRawFNToRecFN.scala 252:24]
  wire [8:0] _expOut_T_11 = notNaN_isInfOut ? 9'h40 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 265:18]
  wire [8:0] _expOut_T_12 = ~_expOut_T_11; // @[RoundAnyRawFNToRecFN.scala 265:14]
  wire [8:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; // @[RoundAnyRawFNToRecFN.scala 264:17]
  wire [8:0] _expOut_T_18 = notNaN_isInfOut ? 9'h180 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 277:16]
  wire [8:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; // @[RoundAnyRawFNToRecFN.scala 276:15]
  wire [8:0] _expOut_T_20 = isNaNOut ? 9'h1c0 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 278:16]
  wire [8:0] expOut = _expOut_T_19 | _expOut_T_20; // @[RoundAnyRawFNToRecFN.scala 277:73]
  wire [22:0] _fractOut_T_2 = isNaNOut ? 23'h400000 : 23'h0; // @[RoundAnyRawFNToRecFN.scala 281:16]
  wire [22:0] fractOut = isNaNOut | io_in_isZero | common_totalUnderflow ? _fractOut_T_2 : common_fractOut; // @[RoundAnyRawFNToRecFN.scala 280:12]
  wire [9:0] _io_out_T = {signOut,expOut}; // @[RoundAnyRawFNToRecFN.scala 286:23]
  wire [3:0] _io_exceptionFlags_T_2 = {io_invalidExc,io_infiniteExc,overflow,underflow}; // @[RoundAnyRawFNToRecFN.scala 288:53]
  assign io_out = {_io_out_T,fractOut}; // @[RoundAnyRawFNToRecFN.scala 286:33]
  assign io_exceptionFlags = {_io_exceptionFlags_T_2,inexact}; // @[RoundAnyRawFNToRecFN.scala 288:66]
endmodule
module RoundAnyRawFNToRecFN_ie11_is55_oe11_os53(
  input         io_invalidExc,
  input         io_infiniteExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [12:0] io_in_sExp,
  input  [55:0] io_in_sig,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);
  wire  doShiftSigDown1 = io_in_sig[55]; // @[RoundAnyRawFNToRecFN.scala 120:57]
  wire [11:0] _roundMask_T_1 = ~io_in_sExp[11:0]; // @[primitives.scala 52:21]
  wire  roundMask_msb = _roundMask_T_1[11]; // @[primitives.scala 58:25]
  wire [10:0] roundMask_lsbs = _roundMask_T_1[10:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_1 = roundMask_lsbs[10]; // @[primitives.scala 58:25]
  wire [9:0] roundMask_lsbs_1 = roundMask_lsbs[9:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_2 = roundMask_lsbs_1[9]; // @[primitives.scala 58:25]
  wire [8:0] roundMask_lsbs_2 = roundMask_lsbs_1[8:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_3 = roundMask_lsbs_2[8]; // @[primitives.scala 58:25]
  wire [7:0] roundMask_lsbs_3 = roundMask_lsbs_2[7:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_4 = roundMask_lsbs_3[7]; // @[primitives.scala 58:25]
  wire [6:0] roundMask_lsbs_4 = roundMask_lsbs_3[6:0]; // @[primitives.scala 59:26]
  wire  roundMask_msb_5 = roundMask_lsbs_4[6]; // @[primitives.scala 58:25]
  wire [5:0] roundMask_lsbs_5 = roundMask_lsbs_4[5:0]; // @[primitives.scala 59:26]
  wire [64:0] roundMask_shift = 65'sh10000000000000000 >>> roundMask_lsbs_5; // @[primitives.scala 76:56]
  wire [31:0] _GEN_0 = {{16'd0}, roundMask_shift[44:29]}; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_5 = _GEN_0 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_7 = {roundMask_shift[28:13], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _roundMask_core_T_9 = _roundMask_core_T_7 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _roundMask_core_T_10 = _roundMask_core_T_5 | _roundMask_core_T_9; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_1 = {{8'd0}, _roundMask_core_T_10[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_15 = _GEN_1 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_17 = {_roundMask_core_T_10[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _roundMask_core_T_19 = _roundMask_core_T_17 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _roundMask_core_T_20 = _roundMask_core_T_15 | _roundMask_core_T_19; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_2 = {{4'd0}, _roundMask_core_T_20[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_25 = _GEN_2 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_27 = {_roundMask_core_T_20[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _roundMask_core_T_29 = _roundMask_core_T_27 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _roundMask_core_T_30 = _roundMask_core_T_25 | _roundMask_core_T_29; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_3 = {{2'd0}, _roundMask_core_T_30[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_35 = _GEN_3 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_37 = {_roundMask_core_T_30[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _roundMask_core_T_39 = _roundMask_core_T_37 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _roundMask_core_T_40 = _roundMask_core_T_35 | _roundMask_core_T_39; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_4 = {{1'd0}, _roundMask_core_T_40[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_45 = _GEN_4 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _roundMask_core_T_47 = {_roundMask_core_T_40[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _roundMask_core_T_49 = _roundMask_core_T_47 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _roundMask_core_T_50 = _roundMask_core_T_45 | _roundMask_core_T_49; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_5 = {{8'd0}, roundMask_shift[60:53]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_56 = _GEN_5 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_58 = {roundMask_shift[52:45], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_60 = _roundMask_core_T_58 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_61 = _roundMask_core_T_56 | _roundMask_core_T_60; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_6 = {{4'd0}, _roundMask_core_T_61[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_66 = _GEN_6 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_68 = {_roundMask_core_T_61[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_70 = _roundMask_core_T_68 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_71 = _roundMask_core_T_66 | _roundMask_core_T_70; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_7 = {{2'd0}, _roundMask_core_T_71[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_76 = _GEN_7 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_78 = {_roundMask_core_T_71[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_80 = _roundMask_core_T_78 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_81 = _roundMask_core_T_76 | _roundMask_core_T_80; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_8 = {{1'd0}, _roundMask_core_T_81[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_86 = _GEN_8 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_core_T_88 = {_roundMask_core_T_81[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_core_T_90 = _roundMask_core_T_88 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_core_T_91 = _roundMask_core_T_86 | _roundMask_core_T_90; // @[Bitwise.scala 108:39]
  wire [50:0] roundMask_core = {_roundMask_core_T_50,_roundMask_core_T_91,roundMask_shift[61],roundMask_shift[62],
    roundMask_shift[63]}; // @[Cat.scala 33:92]
  wire [50:0] _roundMask_T_2 = ~roundMask_core; // @[primitives.scala 73:32]
  wire [50:0] _roundMask_T_3 = roundMask_msb_5 ? 51'h0 : _roundMask_T_2; // @[primitives.scala 73:21]
  wire [50:0] _roundMask_T_4 = ~_roundMask_T_3; // @[primitives.scala 73:17]
  wire [50:0] _roundMask_T_5 = ~_roundMask_T_4; // @[primitives.scala 73:32]
  wire [50:0] _roundMask_T_6 = roundMask_msb_4 ? 51'h0 : _roundMask_T_5; // @[primitives.scala 73:21]
  wire [50:0] _roundMask_T_7 = ~_roundMask_T_6; // @[primitives.scala 73:17]
  wire [50:0] _roundMask_T_8 = ~_roundMask_T_7; // @[primitives.scala 73:32]
  wire [50:0] _roundMask_T_9 = roundMask_msb_3 ? 51'h0 : _roundMask_T_8; // @[primitives.scala 73:21]
  wire [50:0] _roundMask_T_10 = ~_roundMask_T_9; // @[primitives.scala 73:17]
  wire [50:0] _roundMask_T_11 = ~_roundMask_T_10; // @[primitives.scala 73:32]
  wire [50:0] _roundMask_T_12 = roundMask_msb_2 ? 51'h0 : _roundMask_T_11; // @[primitives.scala 73:21]
  wire [50:0] _roundMask_T_13 = ~_roundMask_T_12; // @[primitives.scala 73:17]
  wire [53:0] _roundMask_T_14 = {_roundMask_T_13,3'h7}; // @[primitives.scala 68:58]
  wire [2:0] roundMask_core_1 = {roundMask_shift[0],roundMask_shift[1],roundMask_shift[2]}; // @[Cat.scala 33:92]
  wire [2:0] _roundMask_T_15 = roundMask_msb_5 ? roundMask_core_1 : 3'h0; // @[primitives.scala 62:24]
  wire [2:0] _roundMask_T_16 = roundMask_msb_4 ? _roundMask_T_15 : 3'h0; // @[primitives.scala 62:24]
  wire [2:0] _roundMask_T_17 = roundMask_msb_3 ? _roundMask_T_16 : 3'h0; // @[primitives.scala 62:24]
  wire [2:0] _roundMask_T_18 = roundMask_msb_2 ? _roundMask_T_17 : 3'h0; // @[primitives.scala 62:24]
  wire [53:0] _roundMask_T_19 = roundMask_msb_1 ? _roundMask_T_14 : {{51'd0}, _roundMask_T_18}; // @[primitives.scala 67:24]
  wire [53:0] _roundMask_T_20 = roundMask_msb ? _roundMask_T_19 : 54'h0; // @[primitives.scala 62:24]
  wire [53:0] _GEN_9 = {{53'd0}, doShiftSigDown1}; // @[RoundAnyRawFNToRecFN.scala 159:23]
  wire [53:0] _roundMask_T_21 = _roundMask_T_20 | _GEN_9; // @[RoundAnyRawFNToRecFN.scala 159:23]
  wire [55:0] roundMask = {_roundMask_T_21,2'h3}; // @[RoundAnyRawFNToRecFN.scala 159:42]
  wire [56:0] _shiftedRoundMask_T = {1'h0,_roundMask_T_21,2'h3}; // @[RoundAnyRawFNToRecFN.scala 162:41]
  wire [55:0] shiftedRoundMask = _shiftedRoundMask_T[56:1]; // @[RoundAnyRawFNToRecFN.scala 162:53]
  wire [55:0] _roundPosMask_T = ~shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 163:28]
  wire [55:0] roundPosMask = _roundPosMask_T & roundMask; // @[RoundAnyRawFNToRecFN.scala 163:46]
  wire [55:0] _roundPosBit_T = io_in_sig & roundPosMask; // @[RoundAnyRawFNToRecFN.scala 164:40]
  wire  roundPosBit = |_roundPosBit_T; // @[RoundAnyRawFNToRecFN.scala 164:56]
  wire [55:0] _anyRoundExtra_T = io_in_sig & shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 165:42]
  wire  anyRoundExtra = |_anyRoundExtra_T; // @[RoundAnyRawFNToRecFN.scala 165:62]
  wire  anyRound = roundPosBit | anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 166:36]
  wire [55:0] _roundedSig_T = io_in_sig | roundMask; // @[RoundAnyRawFNToRecFN.scala 174:32]
  wire [54:0] _roundedSig_T_2 = _roundedSig_T[55:2] + 54'h1; // @[RoundAnyRawFNToRecFN.scala 174:49]
  wire  _roundedSig_T_4 = ~anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 176:30]
  wire [54:0] _roundedSig_T_7 = roundPosBit & _roundedSig_T_4 ? roundMask[55:1] : 55'h0; // @[RoundAnyRawFNToRecFN.scala 175:25]
  wire [54:0] _roundedSig_T_8 = ~_roundedSig_T_7; // @[RoundAnyRawFNToRecFN.scala 175:21]
  wire [54:0] _roundedSig_T_9 = _roundedSig_T_2 & _roundedSig_T_8; // @[RoundAnyRawFNToRecFN.scala 174:57]
  wire [55:0] _roundedSig_T_10 = ~roundMask; // @[RoundAnyRawFNToRecFN.scala 180:32]
  wire [55:0] _roundedSig_T_11 = io_in_sig & _roundedSig_T_10; // @[RoundAnyRawFNToRecFN.scala 180:30]
  wire [54:0] _roundedSig_T_16 = {{1'd0}, _roundedSig_T_11[55:2]}; // @[RoundAnyRawFNToRecFN.scala 180:47]
  wire [54:0] roundedSig = roundPosBit ? _roundedSig_T_9 : _roundedSig_T_16; // @[RoundAnyRawFNToRecFN.scala 173:16]
  wire [2:0] _sRoundedExp_T_1 = {1'b0,$signed(roundedSig[54:53])}; // @[RoundAnyRawFNToRecFN.scala 185:76]
  wire [12:0] _GEN_10 = {{10{_sRoundedExp_T_1[2]}},_sRoundedExp_T_1}; // @[RoundAnyRawFNToRecFN.scala 185:40]
  wire [13:0] sRoundedExp = $signed(io_in_sExp) + $signed(_GEN_10); // @[RoundAnyRawFNToRecFN.scala 185:40]
  wire [11:0] common_expOut = sRoundedExp[11:0]; // @[RoundAnyRawFNToRecFN.scala 187:37]
  wire [51:0] common_fractOut = doShiftSigDown1 ? roundedSig[52:1] : roundedSig[51:0]; // @[RoundAnyRawFNToRecFN.scala 189:16]
  wire [3:0] _common_overflow_T = sRoundedExp[13:10]; // @[RoundAnyRawFNToRecFN.scala 196:30]
  wire  common_overflow = $signed(_common_overflow_T) >= 4'sh3; // @[RoundAnyRawFNToRecFN.scala 196:50]
  wire  common_totalUnderflow = $signed(sRoundedExp) < 14'sh3ce; // @[RoundAnyRawFNToRecFN.scala 200:31]
  wire [1:0] _common_underflow_T = io_in_sExp[12:11]; // @[RoundAnyRawFNToRecFN.scala 220:49]
  wire  _common_underflow_T_5 = doShiftSigDown1 ? roundMask[3] : roundMask[2]; // @[RoundAnyRawFNToRecFN.scala 221:30]
  wire  _common_underflow_T_6 = anyRound & $signed(_common_underflow_T) <= 2'sh0 & _common_underflow_T_5; // @[RoundAnyRawFNToRecFN.scala 220:72]
  wire  common_underflow = common_totalUnderflow | _common_underflow_T_6; // @[RoundAnyRawFNToRecFN.scala 217:40]
  wire  common_inexact = common_totalUnderflow | anyRound; // @[RoundAnyRawFNToRecFN.scala 230:49]
  wire  isNaNOut = io_invalidExc | io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 235:34]
  wire  notNaN_isSpecialInfOut = io_infiniteExc | io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 236:49]
  wire  commonCase = ~isNaNOut & ~notNaN_isSpecialInfOut & ~io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 237:61]
  wire  overflow = commonCase & common_overflow; // @[RoundAnyRawFNToRecFN.scala 238:32]
  wire  underflow = commonCase & common_underflow; // @[RoundAnyRawFNToRecFN.scala 239:32]
  wire  inexact = overflow | commonCase & common_inexact; // @[RoundAnyRawFNToRecFN.scala 240:28]
  wire  notNaN_isInfOut = notNaN_isSpecialInfOut | overflow; // @[RoundAnyRawFNToRecFN.scala 248:32]
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; // @[RoundAnyRawFNToRecFN.scala 250:22]
  wire [11:0] _expOut_T_1 = io_in_isZero | common_totalUnderflow ? 12'he00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 253:18]
  wire [11:0] _expOut_T_2 = ~_expOut_T_1; // @[RoundAnyRawFNToRecFN.scala 253:14]
  wire [11:0] _expOut_T_3 = common_expOut & _expOut_T_2; // @[RoundAnyRawFNToRecFN.scala 252:24]
  wire [11:0] _expOut_T_11 = notNaN_isInfOut ? 12'h200 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 265:18]
  wire [11:0] _expOut_T_12 = ~_expOut_T_11; // @[RoundAnyRawFNToRecFN.scala 265:14]
  wire [11:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; // @[RoundAnyRawFNToRecFN.scala 264:17]
  wire [11:0] _expOut_T_18 = notNaN_isInfOut ? 12'hc00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 277:16]
  wire [11:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; // @[RoundAnyRawFNToRecFN.scala 276:15]
  wire [11:0] _expOut_T_20 = isNaNOut ? 12'he00 : 12'h0; // @[RoundAnyRawFNToRecFN.scala 278:16]
  wire [11:0] expOut = _expOut_T_19 | _expOut_T_20; // @[RoundAnyRawFNToRecFN.scala 277:73]
  wire [51:0] _fractOut_T_2 = isNaNOut ? 52'h8000000000000 : 52'h0; // @[RoundAnyRawFNToRecFN.scala 281:16]
  wire [51:0] fractOut = isNaNOut | io_in_isZero | common_totalUnderflow ? _fractOut_T_2 : common_fractOut; // @[RoundAnyRawFNToRecFN.scala 280:12]
  wire [12:0] _io_out_T = {signOut,expOut}; // @[RoundAnyRawFNToRecFN.scala 286:23]
  wire [3:0] _io_exceptionFlags_T_2 = {io_invalidExc,io_infiniteExc,overflow,underflow}; // @[RoundAnyRawFNToRecFN.scala 288:53]
  assign io_out = {_io_out_T,fractOut}; // @[RoundAnyRawFNToRecFN.scala 286:33]
  assign io_exceptionFlags = {_io_exceptionFlags_T_2,inexact}; // @[RoundAnyRawFNToRecFN.scala 288:66]
endmodule
module RoundRawFNToRecFN_e11_s53(
  input         io_invalidExc,
  input         io_infiniteExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [12:0] io_in_sExp,
  input  [55:0] io_in_sig,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);
  wire  roundAnyRawFNToRecFN_io_invalidExc; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire  roundAnyRawFNToRecFN_io_infiniteExc; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire  roundAnyRawFNToRecFN_io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire  roundAnyRawFNToRecFN_io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire  roundAnyRawFNToRecFN_io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire  roundAnyRawFNToRecFN_io_in_sign; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire [12:0] roundAnyRawFNToRecFN_io_in_sExp; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire [55:0] roundAnyRawFNToRecFN_io_in_sig; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire [64:0] roundAnyRawFNToRecFN_io_out; // @[RoundAnyRawFNToRecFN.scala 310:15]
  wire [4:0] roundAnyRawFNToRecFN_io_exceptionFlags; // @[RoundAnyRawFNToRecFN.scala 310:15]
  RoundAnyRawFNToRecFN_ie11_is55_oe11_os53 roundAnyRawFNToRecFN ( // @[RoundAnyRawFNToRecFN.scala 310:15]
    .io_invalidExc(roundAnyRawFNToRecFN_io_invalidExc),
    .io_infiniteExc(roundAnyRawFNToRecFN_io_infiniteExc),
    .io_in_isNaN(roundAnyRawFNToRecFN_io_in_isNaN),
    .io_in_isInf(roundAnyRawFNToRecFN_io_in_isInf),
    .io_in_isZero(roundAnyRawFNToRecFN_io_in_isZero),
    .io_in_sign(roundAnyRawFNToRecFN_io_in_sign),
    .io_in_sExp(roundAnyRawFNToRecFN_io_in_sExp),
    .io_in_sig(roundAnyRawFNToRecFN_io_in_sig),
    .io_out(roundAnyRawFNToRecFN_io_out),
    .io_exceptionFlags(roundAnyRawFNToRecFN_io_exceptionFlags)
  );
  assign io_out = roundAnyRawFNToRecFN_io_out; // @[RoundAnyRawFNToRecFN.scala 318:23]
  assign io_exceptionFlags = roundAnyRawFNToRecFN_io_exceptionFlags; // @[RoundAnyRawFNToRecFN.scala 319:23]
  assign roundAnyRawFNToRecFN_io_invalidExc = io_invalidExc; // @[RoundAnyRawFNToRecFN.scala 313:44]
  assign roundAnyRawFNToRecFN_io_infiniteExc = io_infiniteExc; // @[RoundAnyRawFNToRecFN.scala 314:44]
  assign roundAnyRawFNToRecFN_io_in_isNaN = io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 315:44]
  assign roundAnyRawFNToRecFN_io_in_isInf = io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 315:44]
  assign roundAnyRawFNToRecFN_io_in_isZero = io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 315:44]
  assign roundAnyRawFNToRecFN_io_in_sign = io_in_sign; // @[RoundAnyRawFNToRecFN.scala 315:44]
  assign roundAnyRawFNToRecFN_io_in_sExp = io_in_sExp; // @[RoundAnyRawFNToRecFN.scala 315:44]
  assign roundAnyRawFNToRecFN_io_in_sig = io_in_sig; // @[RoundAnyRawFNToRecFN.scala 315:44]
endmodule
module AecTransMultiplier(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [47:0] io_req_bits_a,
  input  [47:0] io_req_bits_b,
  input         io_resp_ready,
  output        io_resp_valid,
  output [95:0] io_resp_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [95:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [95:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [95:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  busy; // @[AecTranscendental.scala 22:21]
  reg  valid; // @[AecTranscendental.scala 23:22]
  reg  negative; // @[AecTranscendental.scala 24:21]
  reg [95:0] multiplicand; // @[AecTranscendental.scala 25:25]
  reg [47:0] multiplierBits; // @[AecTranscendental.scala 26:27]
  reg [95:0] accumulator; // @[AecTranscendental.scala 27:24]
  reg [5:0] count; // @[AecTranscendental.scala 28:18]
  reg [95:0] product; // @[AecTranscendental.scala 29:20]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [47:0] _absA_T_4 = 48'sh0 - $signed(io_req_bits_a); // @[AecTranscendental.scala 35:58]
  wire [47:0] absA = $signed(io_req_bits_a) < 48'sh0 ? _absA_T_4 : io_req_bits_a; // @[AecTranscendental.scala 35:19]
  wire [47:0] _absB_T_4 = 48'sh0 - $signed(io_req_bits_b); // @[AecTranscendental.scala 36:58]
  wire [47:0] absB = $signed(io_req_bits_b) < 48'sh0 ? _absB_T_4 : io_req_bits_b; // @[AecTranscendental.scala 36:19]
  wire [95:0] _multiplicand_T = {48'h0,absA}; // @[Cat.scala 33:92]
  wire [95:0] _GEN_1 = _T ? _multiplicand_T : multiplicand; // @[AecTranscendental.scala 34:22 38:18 25:25]
  wire [47:0] _GEN_2 = _T ? absB : multiplierBits; // @[AecTranscendental.scala 34:22 39:20 26:27]
  wire [95:0] _GEN_3 = _T ? 96'h0 : accumulator; // @[AecTranscendental.scala 34:22 40:17 27:24]
  wire [5:0] _GEN_4 = _T ? 6'h0 : count; // @[AecTranscendental.scala 34:22 41:11 28:18]
  wire  _GEN_5 = _T | busy; // @[AecTranscendental.scala 34:22 42:10 22:21]
  wire [95:0] _nextAccumulator_T_2 = accumulator + multiplicand; // @[AecTranscendental.scala 45:62]
  wire [95:0] _product_T = multiplierBits[0] ? _nextAccumulator_T_2 : accumulator; // @[AecTranscendental.scala 47:49]
  wire [95:0] _product_T_3 = 96'sh0 - $signed(_product_T); // @[AecTranscendental.scala 47:32]
  wire [96:0] _multiplicand_T_1 = {multiplicand, 1'h0}; // @[AecTranscendental.scala 52:36]
  wire [5:0] _count_T_1 = count + 6'h1; // @[AecTranscendental.scala 54:22]
  wire  _GEN_8 = count == 6'h2f | valid; // @[AecTranscendental.scala 46:27 49:13 23:22]
  wire [96:0] _GEN_10 = count == 6'h2f ? {{1'd0}, _GEN_1} : _multiplicand_T_1; // @[AecTranscendental.scala 46:27 52:20]
  wire [96:0] _GEN_17 = busy ? _GEN_10 : {{1'd0}, _GEN_1}; // @[AecTranscendental.scala 44:15]
  wire  _T_2 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign io_req_ready = ~busy & ~valid; // @[AecTranscendental.scala 31:25]
  assign io_resp_valid = valid; // @[AecTranscendental.scala 32:17]
  assign io_resp_bits = product; // @[AecTranscendental.scala 33:16]
  always @(posedge clock) begin
    if (reset) begin // @[AecTranscendental.scala 22:21]
      busy <= 1'h0; // @[AecTranscendental.scala 22:21]
    end else if (busy) begin // @[AecTranscendental.scala 44:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 46:27]
        busy <= 1'h0; // @[AecTranscendental.scala 48:12]
      end else begin
        busy <= _GEN_5;
      end
    end else begin
      busy <= _GEN_5;
    end
    if (reset) begin // @[AecTranscendental.scala 23:22]
      valid <= 1'h0; // @[AecTranscendental.scala 23:22]
    end else if (_T_2) begin // @[AecTranscendental.scala 57:23]
      valid <= 1'h0; // @[AecTranscendental.scala 57:31]
    end else if (busy) begin // @[AecTranscendental.scala 44:15]
      valid <= _GEN_8;
    end
    if (_T) begin // @[AecTranscendental.scala 34:22]
      negative <= io_req_bits_a[47] ^ io_req_bits_b[47]; // @[AecTranscendental.scala 37:14]
    end
    multiplicand <= _GEN_17[95:0];
    if (busy) begin // @[AecTranscendental.scala 44:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 46:27]
        multiplierBits <= _GEN_2;
      end else begin
        multiplierBits <= {{1'd0}, multiplierBits[47:1]}; // @[AecTranscendental.scala 53:22]
      end
    end else begin
      multiplierBits <= _GEN_2;
    end
    if (busy) begin // @[AecTranscendental.scala 44:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 46:27]
        accumulator <= _GEN_3;
      end else if (multiplierBits[0]) begin // @[AecTranscendental.scala 45:30]
        accumulator <= _nextAccumulator_T_2;
      end
    end else begin
      accumulator <= _GEN_3;
    end
    if (busy) begin // @[AecTranscendental.scala 44:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 46:27]
        count <= _GEN_4;
      end else begin
        count <= _count_T_1; // @[AecTranscendental.scala 54:13]
      end
    end else begin
      count <= _GEN_4;
    end
    if (busy) begin // @[AecTranscendental.scala 44:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 46:27]
        if (negative) begin // @[AecTranscendental.scala 47:21]
          product <= _product_T_3;
        end else begin
          product <= _product_T;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  busy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  negative = _RAND_2[0:0];
  _RAND_3 = {3{`RANDOM}};
  multiplicand = _RAND_3[95:0];
  _RAND_4 = {2{`RANDOM}};
  multiplierBits = _RAND_4[47:0];
  _RAND_5 = {3{`RANDOM}};
  accumulator = _RAND_5[95:0];
  _RAND_6 = {1{`RANDOM}};
  count = _RAND_6[5:0];
  _RAND_7 = {3{`RANDOM}};
  product = _RAND_7[95:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecTranscendental(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [15:0] io_req_bits_op,
  input  [31:0] io_req_bits_in,
  input         io_resp_ready,
  output        io_resp_valid,
  output [31:0] io_resp_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire  multiplier_clock; // @[AecTranscendental.scala 91:26]
  wire  multiplier_reset; // @[AecTranscendental.scala 91:26]
  wire  multiplier_io_req_ready; // @[AecTranscendental.scala 91:26]
  wire  multiplier_io_req_valid; // @[AecTranscendental.scala 91:26]
  wire [47:0] multiplier_io_req_bits_a; // @[AecTranscendental.scala 91:26]
  wire [47:0] multiplier_io_req_bits_b; // @[AecTranscendental.scala 91:26]
  wire  multiplier_io_resp_ready; // @[AecTranscendental.scala 91:26]
  wire  multiplier_io_resp_valid; // @[AecTranscendental.scala 91:26]
  wire [95:0] multiplier_io_resp_bits; // @[AecTranscendental.scala 91:26]
  reg [4:0] state; // @[AecTranscendental.scala 74:22]
  reg [15:0] op; // @[AecTranscendental.scala 75:15]
  reg [47:0] x; // @[AecTranscendental.scala 76:14]
  reg [47:0] term; // @[AecTranscendental.scala 77:17]
  reg [47:0] argument2; // @[AecTranscendental.scala 78:22]
  reg [47:0] accumulator; // @[AecTranscendental.scala 79:24]
  reg [47:0] auxiliary; // @[AecTranscendental.scala 80:22]
  reg [11:0] exponentScale; // @[AecTranscendental.scala 81:26]
  reg [3:0] step; // @[AecTranscendental.scala 82:21]
  reg [1:0] quadrant; // @[AecTranscendental.scala 83:21]
  reg  polynomialCos; // @[AecTranscendental.scala 84:26]
  reg  negateResult; // @[AecTranscendental.scala 85:25]
  reg [31:0] result; // @[AecTranscendental.scala 86:23]
  wire  _multiplyState_T = state == 5'h1; // @[AecTranscendental.scala 92:29]
  wire  _multiplyState_T_1 = state == 5'h2; // @[AecTranscendental.scala 92:52]
  wire  _multiplyState_T_3 = state == 5'h3; // @[AecTranscendental.scala 92:76]
  wire  _multiplyState_T_5 = state == 5'h4; // @[AecTranscendental.scala 92:96]
  wire  _multiplyState_T_7 = state == 5'h5; // @[AecTranscendental.scala 93:11]
  wire  _multiplyState_T_8 = state == 5'h1 | state == 5'h2 | state == 5'h3 | state == 5'h4 | _multiplyState_T_7; // @[AecTranscendental.scala 92:105]
  wire  _multiplyState_T_9 = state == 5'h6; // @[AecTranscendental.scala 93:34]
  wire  _multiplyState_T_11 = state == 5'h7; // @[AecTranscendental.scala 93:60]
  wire  _multiplyState_T_13 = state == 5'h8; // @[AecTranscendental.scala 93:82]
  wire  _multiplyState_T_15 = state == 5'h9; // @[AecTranscendental.scala 94:11]
  wire  _multiplyState_T_16 = _multiplyState_T_8 | state == 5'h6 | state == 5'h7 | state == 5'h8 | _multiplyState_T_15; // @[AecTranscendental.scala 93:99]
  wire  _multiplyState_T_17 = state == 5'ha; // @[AecTranscendental.scala 94:40]
  wire  _multiplyState_T_19 = state == 5'hb; // @[AecTranscendental.scala 94:58]
  wire  _multiplyState_T_21 = state == 5'hd; // @[AecTranscendental.scala 94:81]
  wire  _multiplyState_T_23 = state == 5'hc; // @[AecTranscendental.scala 95:11]
  wire  _multiplyState_T_24 = _multiplyState_T_16 | state == 5'ha | state == 5'hb | state == 5'hd | _multiplyState_T_23; // @[AecTranscendental.scala 94:96]
  wire  _multiplyState_T_25 = state == 5'he; // @[AecTranscendental.scala 95:30]
  wire  _multiplyState_T_27 = state == 5'hf; // @[AecTranscendental.scala 95:52]
  wire [95:0] _multiplyResult_T = multiplier_io_resp_bits; // @[AecTranscendental.scala 100:48]
  wire [47:0] multiplyResult = _multiplyResult_T[81:34]; // @[AecTranscendental.scala 100:66]
  wire  inputSign = io_req_bits_in[31]; // @[AecTranscendental.scala 103:33]
  wire [7:0] inputExponent = io_req_bits_in[30:23]; // @[AecTranscendental.scala 104:37]
  wire [22:0] inputFraction = io_req_bits_in[22:0]; // @[AecTranscendental.scala 105:37]
  wire  _inputSignificand_T = |inputExponent; // @[AecTranscendental.scala 106:44]
  wire [23:0] inputSignificand = {_inputSignificand_T,inputFraction}; // @[Cat.scala 33:92]
  wire [8:0] _unbiased_T = {1'b0,$signed(inputExponent)}; // @[AecTranscendental.scala 107:32]
  wire [8:0] unbiased = $signed(_unbiased_T) - 9'sh7f; // @[AecTranscendental.scala 107:37]
  wire [8:0] shift = $signed(unbiased) + 9'shb; // @[AecTranscendental.scala 108:24]
  wire [8:0] _inputMagnitude_T = $signed(unbiased) + 9'shb; // @[AecTranscendental.scala 111:87]
  wire [534:0] _GEN_8 = {{511'd0}, inputSignificand}; // @[AecTranscendental.scala 111:78]
  wire [534:0] _inputMagnitude_T_1 = _GEN_8 << _inputMagnitude_T; // @[AecTranscendental.scala 111:78]
  wire [8:0] _inputMagnitude_T_5 = 9'sh0 - $signed(shift); // @[AecTranscendental.scala 112:99]
  wire [23:0] _inputMagnitude_T_6 = inputSignificand >> _inputMagnitude_T_5; // @[AecTranscendental.scala 112:87]
  wire [47:0] _GEN_0 = $signed(shift) >= 9'sh18 ? 48'h7fffffffffff : 48'h0; // @[AecTranscendental.scala 113:33 109:35 113:50]
  wire [47:0] _GEN_1 = $signed(shift) < 9'sh0 & $signed(shift) > -9'sh20 ? {{24'd0}, _inputMagnitude_T_6} : _GEN_0; // @[AecTranscendental.scala 112:{50,67}]
  wire [534:0] _GEN_2 = $signed(shift) >= 9'sh0 & $signed(shift) < 9'sh18 ? _inputMagnitude_T_1 : {{487'd0}, _GEN_1}; // @[AecTranscendental.scala 111:{41,58}]
  wire [534:0] _GEN_3 = _inputSignificand_T ? _GEN_2 : 535'h0; // @[AecTranscendental.scala 110:28 109:35]
  wire [47:0] _inputQ_T = _GEN_3[47:0]; // @[AecTranscendental.scala 115:47]
  wire [47:0] _inputQ_T_3 = 48'sh0 - $signed(_inputQ_T); // @[AecTranscendental.scala 115:31]
  wire [47:0] inputQ = inputSign ? $signed(_inputQ_T_3) : $signed(_inputQ_T); // @[AecTranscendental.scala 115:19]
  wire  _inputZero_T_1 = inputFraction == 23'h0; // @[AecTranscendental.scala 116:58]
  wire  inputZero = inputExponent == 8'h0 & inputFraction == 23'h0; // @[AecTranscendental.scala 116:41]
  wire  _inputInf_T = &inputExponent; // @[AecTranscendental.scala 117:32]
  wire  inputInf = &inputExponent & _inputZero_T_1; // @[AecTranscendental.scala 117:37]
  wire  inputNaN = _inputInf_T & |inputFraction; // @[AecTranscendental.scala 118:37]
  wire  _T_8 = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _T_9 = io_req_bits_op == 16'h72; // @[AecTranscendental.scala 153:40]
  wire  _T_10 = io_req_bits_op == 16'h73; // @[AecTranscendental.scala 153:76]
  wire  _T_11 = io_req_bits_op == 16'h72 | io_req_bits_op == 16'h73; // @[AecTranscendental.scala 153:58]
  wire  _T_14 = io_req_bits_op == 16'h75; // @[AecTranscendental.scala 154:23]
  wire  _T_17 = io_req_bits_op == 16'h75 & inputSign & ~inputZero; // @[AecTranscendental.scala 154:54]
  wire  _T_18 = inputNaN | (io_req_bits_op == 16'h72 | io_req_bits_op == 16'h73) & inputInf | _T_17; // @[AecTranscendental.scala 153:108]
  wire  _T_23 = io_req_bits_op == 16'h74; // @[AecTranscendental.scala 160:32]
  wire [30:0] _result_T = inputSign ? 31'h0 : 31'h7f800000; // @[AecTranscendental.scala 161:20]
  wire [13:0] _exponentScale_T = inputQ[47:34]; // @[AecTranscendental.scala 169:32]
  wire [47:0] _term_T_1 = {$signed(_exponentScale_T), 34'h0}; // @[AecTranscendental.scala 170:39]
  wire [47:0] _term_T_4 = $signed(inputQ) - $signed(_term_T_1); // @[AecTranscendental.scala 170:22]
  wire [35:0] mantissa = {1'h0,_inputSignificand_T,inputFraction,11'h0}; // @[AecTranscendental.scala 173:71]
  wire [47:0] _GEN_181 = {{12{mantissa[35]}},mantissa}; // @[AecTranscendental.scala 174:28]
  wire  halve = $signed(_GEN_181) > 48'sh5a82799a0; // @[AecTranscendental.scala 174:28]
  wire [34:0] _term_T_5 = mantissa[35:1]; // @[AecTranscendental.scala 175:35]
  wire [35:0] _term_T_6 = halve ? $signed({{1{_term_T_5[34]}},_term_T_5}) : $signed(mantissa); // @[AecTranscendental.scala 175:18]
  wire [1:0] _exponentScale_T_1 = {1'b0,$signed(halve)}; // @[AecTranscendental.scala 176:48]
  wire [8:0] _GEN_182 = {{7{_exponentScale_T_1[1]}},_exponentScale_T_1}; // @[AecTranscendental.scala 176:33]
  wire [8:0] _exponentScale_T_4 = $signed(unbiased) + $signed(_GEN_182); // @[AecTranscendental.scala 176:33]
  wire [47:0] _GEN_183 = {{12{_term_T_6[35]}},_term_T_6}; // @[AecTranscendental.scala 177:70]
  wire [47:0] _accumulator_T_4 = $signed(_GEN_183) + 48'sh400000000; // @[AecTranscendental.scala 177:70]
  wire [44:0] _accumulator_T_5 = _accumulator_T_4[47:3]; // @[AecTranscendental.scala 177:80]
  wire [47:0] _GEN_184 = {{3{_accumulator_T_5[44]}},_accumulator_T_5}; // @[AecTranscendental.scala 177:30]
  wire [47:0] _accumulator_T_8 = 48'sh300000000 - $signed(_GEN_184); // @[AecTranscendental.scala 177:30]
  wire [13:0] _GEN_4 = _T_23 ? $signed(_exponentScale_T) : $signed({{5{_exponentScale_T_4[8]}},_exponentScale_T_4}); // @[AecTranscendental.scala 168:51 169:21 176:21]
  wire [47:0] _GEN_5 = _T_23 ? $signed(_term_T_4) : $signed({{12{_term_T_6[35]}},_term_T_6}); // @[AecTranscendental.scala 168:51 170:12 175:12]
  wire [4:0] _GEN_6 = _T_23 ? 5'h7 : 5'h8; // @[AecTranscendental.scala 168:51 171:13 179:13]
  wire [47:0] _GEN_7 = _T_23 ? $signed(accumulator) : $signed(_accumulator_T_8); // @[AecTranscendental.scala 168:51 177:19 79:24]
  wire [4:0] _GEN_9 = _T_11 ? 5'h1 : _GEN_6; // @[AecTranscendental.scala 166:87 167:13]
  wire [13:0] _GEN_10 = _T_11 ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_4); // @[AecTranscendental.scala 166:87 81:26]
  wire [47:0] _GEN_11 = _T_11 ? $signed(term) : $signed(_GEN_5); // @[AecTranscendental.scala 166:87 77:17]
  wire [47:0] _GEN_12 = _T_11 ? $signed(accumulator) : $signed(_GEN_7); // @[AecTranscendental.scala 166:87 79:24]
  wire [31:0] _GEN_14 = _T_14 & inputInf ? 32'h7f800000 : result; // @[AecTranscendental.scala 164:63 165:14 86:23]
  wire [4:0] _GEN_15 = _T_14 & inputInf ? 5'h10 : _GEN_9; // @[AecTranscendental.scala 164:63 165:38]
  wire [13:0] _GEN_16 = _T_14 & inputInf ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_10); // @[AecTranscendental.scala 164:63 81:26]
  wire [47:0] _GEN_17 = _T_14 & inputInf ? $signed(term) : $signed(_GEN_11); // @[AecTranscendental.scala 164:63 77:17]
  wire [47:0] _GEN_18 = _T_14 & inputInf ? $signed(accumulator) : $signed(_GEN_12); // @[AecTranscendental.scala 164:63 79:24]
  wire [31:0] _GEN_20 = _T_14 & inputZero ? 32'hff800000 : _GEN_14; // @[AecTranscendental.scala 162:64 163:14]
  wire [4:0] _GEN_21 = _T_14 & inputZero ? 5'h10 : _GEN_15; // @[AecTranscendental.scala 162:64 163:38]
  wire [13:0] _GEN_22 = _T_14 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_16); // @[AecTranscendental.scala 162:64 81:26]
  wire [47:0] _GEN_23 = _T_14 & inputZero ? $signed(term) : $signed(_GEN_17); // @[AecTranscendental.scala 162:64 77:17]
  wire [47:0] _GEN_24 = _T_14 & inputZero ? $signed(accumulator) : $signed(_GEN_18); // @[AecTranscendental.scala 162:64 79:24]
  wire [31:0] _GEN_26 = io_req_bits_op == 16'h74 & inputInf ? {{1'd0}, _result_T} : _GEN_20; // @[AecTranscendental.scala 160:63 161:14]
  wire [4:0] _GEN_27 = io_req_bits_op == 16'h74 & inputInf ? 5'h10 : _GEN_21; // @[AecTranscendental.scala 160:63 161:59]
  wire [13:0] _GEN_28 = io_req_bits_op == 16'h74 & inputInf ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(
    _GEN_22); // @[AecTranscendental.scala 160:63 81:26]
  wire [47:0] _GEN_29 = io_req_bits_op == 16'h74 & inputInf ? $signed(term) : $signed(_GEN_23); // @[AecTranscendental.scala 160:63 77:17]
  wire [47:0] _GEN_30 = io_req_bits_op == 16'h74 & inputInf ? $signed(accumulator) : $signed(_GEN_24); // @[AecTranscendental.scala 160:63 79:24]
  wire [31:0] _GEN_32 = _T_10 & inputZero ? 32'h3f800000 : _GEN_26; // @[AecTranscendental.scala 158:64 159:14]
  wire [4:0] _GEN_33 = _T_10 & inputZero ? 5'h10 : _GEN_27; // @[AecTranscendental.scala 158:64 159:38]
  wire [13:0] _GEN_34 = _T_10 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_28); // @[AecTranscendental.scala 158:64 81:26]
  wire [47:0] _GEN_35 = _T_10 & inputZero ? $signed(term) : $signed(_GEN_29); // @[AecTranscendental.scala 158:64 77:17]
  wire [47:0] _GEN_36 = _T_10 & inputZero ? $signed(accumulator) : $signed(_GEN_30); // @[AecTranscendental.scala 158:64 79:24]
  wire [31:0] _GEN_38 = _T_9 & inputZero ? io_req_bits_in : _GEN_32; // @[AecTranscendental.scala 156:64 157:14]
  wire [4:0] _GEN_39 = _T_9 & inputZero ? 5'h10 : _GEN_33; // @[AecTranscendental.scala 156:64 157:39]
  wire [13:0] _GEN_40 = _T_9 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_34); // @[AecTranscendental.scala 156:64 81:26]
  wire [47:0] _GEN_41 = _T_9 & inputZero ? $signed(term) : $signed(_GEN_35); // @[AecTranscendental.scala 156:64 77:17]
  wire [47:0] _GEN_42 = _T_9 & inputZero ? $signed(accumulator) : $signed(_GEN_36); // @[AecTranscendental.scala 156:64 79:24]
  wire [31:0] _GEN_44 = _T_18 ? 32'h7fc00000 : _GEN_38; // @[AecTranscendental.scala 154:70 155:14]
  wire [4:0] _GEN_45 = _T_18 ? 5'h10 : _GEN_39; // @[AecTranscendental.scala 154:70 155:37]
  wire [13:0] _GEN_46 = _T_18 ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_40); // @[AecTranscendental.scala 154:70 81:26]
  wire [47:0] _GEN_47 = _T_18 ? $signed(term) : $signed(_GEN_41); // @[AecTranscendental.scala 154:70 77:17]
  wire [47:0] _GEN_48 = _T_18 ? $signed(accumulator) : $signed(_GEN_42); // @[AecTranscendental.scala 154:70 79:24]
  wire [3:0] _GEN_52 = _T_8 ? 4'h0 : step; // @[AecTranscendental.scala 149:22 82:21]
  wire [31:0] _GEN_53 = _T_8 ? _GEN_44 : result; // @[AecTranscendental.scala 149:22 86:23]
  wire [4:0] _GEN_54 = _T_8 ? _GEN_45 : state; // @[AecTranscendental.scala 149:22 74:22]
  wire [13:0] _GEN_55 = _T_8 ? $signed(_GEN_46) : $signed({{2{exponentScale[11]}},exponentScale}); // @[AecTranscendental.scala 149:22 81:26]
  wire [47:0] _GEN_57 = _T_8 ? $signed(_GEN_48) : $signed(accumulator); // @[AecTranscendental.scala 149:22 79:24]
  wire [47:0] _signedQuadrant_T_3 = $signed(multiplyResult) + 48'sh200000000; // @[AecTranscendental.scala 186:23]
  wire [13:0] _signedQuadrant_T_4 = _signedQuadrant_T_3[47:34]; // @[AecTranscendental.scala 186:33]
  wire [47:0] _signedQuadrant_T_7 = 48'sh0 - $signed(multiplyResult); // @[AecTranscendental.scala 186:42]
  wire [47:0] _signedQuadrant_T_10 = $signed(_signedQuadrant_T_7) + 48'sh200000000; // @[AecTranscendental.scala 186:58]
  wire [13:0] _signedQuadrant_T_11 = _signedQuadrant_T_10[47:34]; // @[AecTranscendental.scala 186:68]
  wire [13:0] _signedQuadrant_T_14 = 14'sh0 - $signed(_signedQuadrant_T_11); // @[AecTranscendental.scala 186:39]
  wire [13:0] signedQuadrant = $signed(multiplyResult) >= 48'sh0 ? $signed(_signedQuadrant_T_4) : $signed(
    _signedQuadrant_T_14); // @[AecTranscendental.scala 185:29]
  wire [13:0] _quadrant_T = $signed(multiplyResult) >= 48'sh0 ? $signed(_signedQuadrant_T_4) : $signed(
    _signedQuadrant_T_14); // @[AecTranscendental.scala 187:32]
  wire [47:0] _auxiliary_T = {$signed(signedQuadrant), 34'h0}; // @[AecTranscendental.scala 188:33]
  wire [47:0] _GEN_58 = _multiplyState_T & multiplier_io_resp_valid ? $signed(x) : $signed(48'sh0); // @[AecTranscendental.scala 183:47 184:15 89:30]
  wire [47:0] _GEN_59 = _multiplyState_T & multiplier_io_resp_valid ? $signed(48'sh28be60db9) : $signed(48'sh0); // @[AecTranscendental.scala 183:47 184:31 90:30]
  wire [4:0] _GEN_62 = _multiplyState_T & multiplier_io_resp_valid ? 5'h2 : _GEN_54; // @[AecTranscendental.scala 183:47 189:11]
  wire [47:0] _term_T_9 = $signed(x) - $signed(multiplyResult); // @[AecTranscendental.scala 193:15]
  wire  odd = quadrant[0]; // @[AecTranscendental.scala 194:23]
  wire  _polynomialCos_T = op == 16'h72; // @[AecTranscendental.scala 195:29]
  wire [47:0] _GEN_63 = _multiplyState_T_1 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_58); // @[AecTranscendental.scala 191:48 192:15]
  wire [47:0] _GEN_64 = _multiplyState_T_1 & multiplier_io_resp_valid ? $signed(48'sh6487ed511) : $signed(_GEN_59); // @[AecTranscendental.scala 191:48 192:39]
  wire [4:0] _GEN_68 = _multiplyState_T_1 & multiplier_io_resp_valid ? 5'h3 : _GEN_62; // @[AecTranscendental.scala 191:48 197:11]
  wire [47:0] _accumulator_T_9 = polynomialCos ? $signed(-48'sh127e) : $signed(-48'sh1ae); // @[AecTranscendental.scala 202:23]
  wire [47:0] _GEN_69 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_63); // @[AecTranscendental.scala 199:44 200:15]
  wire [47:0] _GEN_70 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_64); // @[AecTranscendental.scala 199:44 200:34]
  wire [47:0] _GEN_72 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(_accumulator_T_9) : $signed(_GEN_57); // @[AecTranscendental.scala 199:44 202:17]
  wire [3:0] _GEN_73 = _multiplyState_T_3 & multiplier_io_resp_valid ? 4'h0 : _GEN_52; // @[AecTranscendental.scala 199:44 203:10]
  wire [4:0] _GEN_74 = _multiplyState_T_3 & multiplier_io_resp_valid ? 5'h4 : _GEN_68; // @[AecTranscendental.scala 199:44 204:11]
  wire  _T_40 = step < 4'h4; // @[AecTranscendental.scala 206:32]
  wire [47:0] _sinCoefficient_T_1 = 4'h0 == step ? $signed(48'shb8ef) : $signed(48'sh0); // @[Mux.scala 81:58]
  wire [47:0] _sinCoefficient_T_3 = 4'h1 == step ? $signed(-48'sh340340) : $signed(_sinCoefficient_T_1); // @[Mux.scala 81:58]
  wire [47:0] _sinCoefficient_T_5 = 4'h2 == step ? $signed(48'sh8888889) : $signed(_sinCoefficient_T_3); // @[Mux.scala 81:58]
  wire [47:0] sinCoefficient = 4'h3 == step ? $signed(-48'shaaaaaaab) : $signed(_sinCoefficient_T_5); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_1 = 4'h0 == step ? $signed(48'sh68068) : $signed(48'sh0); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_3 = 4'h1 == step ? $signed(-48'sh16c16c1) : $signed(_cosCoefficient_T_1); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_5 = 4'h2 == step ? $signed(48'sh2aaaaaab) : $signed(_cosCoefficient_T_3); // @[Mux.scala 81:58]
  wire [47:0] cosCoefficient = 4'h3 == step ? $signed(-48'sh200000000) : $signed(_cosCoefficient_T_5); // @[Mux.scala 81:58]
  wire [47:0] _accumulator_T_10 = polynomialCos ? $signed(cosCoefficient) : $signed(sinCoefficient); // @[AecTranscendental.scala 212:40]
  wire [47:0] _accumulator_T_13 = $signed(multiplyResult) + $signed(_accumulator_T_10); // @[AecTranscendental.scala 212:35]
  wire [3:0] _step_T_1 = step + 4'h1; // @[AecTranscendental.scala 213:73]
  wire [4:0] _GEN_75 = step == 4'h3 ? 5'h5 : _GEN_74; // @[AecTranscendental.scala 213:{25,33}]
  wire [3:0] _GEN_76 = step == 4'h3 ? _GEN_73 : _step_T_1; // @[AecTranscendental.scala 213:{25,65}]
  wire [47:0] _GEN_77 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(argument2) : $signed(
    _GEN_69); // @[AecTranscendental.scala 206:56 207:15]
  wire [47:0] _GEN_78 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(
    _GEN_70); // @[AecTranscendental.scala 206:56 207:39]
  wire [47:0] _GEN_79 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(_accumulator_T_13) :
    $signed(_GEN_72); // @[AecTranscendental.scala 206:56 212:17]
  wire [4:0] _GEN_80 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? _GEN_75 : _GEN_74; // @[AecTranscendental.scala 206:56]
  wire [3:0] _GEN_81 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? _GEN_76 : _GEN_73; // @[AecTranscendental.scala 206:56]
  wire [47:0] inner = 48'sh400000000 + $signed(multiplyResult); // @[AecTranscendental.scala 217:24]
  wire [47:0] _result_T_3 = 48'sh0 - $signed(inner); // @[AecTranscendental.scala 219:43]
  wire [47:0] result_bounded = negateResult ? $signed(_result_T_3) : $signed(inner); // @[AecTranscendental.scala 219:28]
  wire  result_negative = $signed(result_bounded) < 48'sh0; // @[AecTranscendental.scala 122:28]
  wire [47:0] _result_magnitude_T_2 = 48'sh0 - $signed(result_bounded); // @[AecTranscendental.scala 123:35]
  wire [47:0] result_magnitude = result_negative ? $signed(_result_magnitude_T_2) : $signed(result_bounded); // @[AecTranscendental.scala 123:54]
  wire [31:0] _GEN_185 = {{16'd0}, result_magnitude[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_4 = _GEN_185 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_6 = {result_magnitude[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_8 = _result_leading_T_6 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_9 = _result_leading_T_4 | _result_leading_T_8; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_186 = {{8'd0}, _result_leading_T_9[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_14 = _GEN_186 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_16 = {_result_leading_T_9[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_18 = _result_leading_T_16 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_19 = _result_leading_T_14 | _result_leading_T_18; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_187 = {{4'd0}, _result_leading_T_19[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_24 = _GEN_187 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_26 = {_result_leading_T_19[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_28 = _result_leading_T_26 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_29 = _result_leading_T_24 | _result_leading_T_28; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_188 = {{2'd0}, _result_leading_T_29[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_34 = _GEN_188 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_36 = {_result_leading_T_29[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_38 = _result_leading_T_36 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_39 = _result_leading_T_34 | _result_leading_T_38; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_189 = {{1'd0}, _result_leading_T_39[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_44 = _GEN_189 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_46 = {_result_leading_T_39[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_48 = _result_leading_T_46 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_49 = _result_leading_T_44 | _result_leading_T_48; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_190 = {{8'd0}, result_magnitude[47:40]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_54 = _GEN_190 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_56 = {result_magnitude[39:32], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_58 = _result_leading_T_56 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_59 = _result_leading_T_54 | _result_leading_T_58; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_191 = {{4'd0}, _result_leading_T_59[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_64 = _GEN_191 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_66 = {_result_leading_T_59[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_68 = _result_leading_T_66 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_69 = _result_leading_T_64 | _result_leading_T_68; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_192 = {{2'd0}, _result_leading_T_69[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_74 = _GEN_192 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_76 = {_result_leading_T_69[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_78 = _result_leading_T_76 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_79 = _result_leading_T_74 | _result_leading_T_78; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_193 = {{1'd0}, _result_leading_T_79[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_84 = _GEN_193 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_86 = {_result_leading_T_79[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_88 = _result_leading_T_86 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_89 = _result_leading_T_84 | _result_leading_T_88; // @[Bitwise.scala 108:39]
  wire [47:0] _result_leading_T_90 = {_result_leading_T_49,_result_leading_T_89}; // @[Cat.scala 33:92]
  wire [5:0] _result_leading_T_139 = _result_leading_T_90[46] ? 6'h2e : 6'h2f; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_140 = _result_leading_T_90[45] ? 6'h2d : _result_leading_T_139; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_141 = _result_leading_T_90[44] ? 6'h2c : _result_leading_T_140; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_142 = _result_leading_T_90[43] ? 6'h2b : _result_leading_T_141; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_143 = _result_leading_T_90[42] ? 6'h2a : _result_leading_T_142; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_144 = _result_leading_T_90[41] ? 6'h29 : _result_leading_T_143; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_145 = _result_leading_T_90[40] ? 6'h28 : _result_leading_T_144; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_146 = _result_leading_T_90[39] ? 6'h27 : _result_leading_T_145; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_147 = _result_leading_T_90[38] ? 6'h26 : _result_leading_T_146; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_148 = _result_leading_T_90[37] ? 6'h25 : _result_leading_T_147; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_149 = _result_leading_T_90[36] ? 6'h24 : _result_leading_T_148; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_150 = _result_leading_T_90[35] ? 6'h23 : _result_leading_T_149; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_151 = _result_leading_T_90[34] ? 6'h22 : _result_leading_T_150; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_152 = _result_leading_T_90[33] ? 6'h21 : _result_leading_T_151; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_153 = _result_leading_T_90[32] ? 6'h20 : _result_leading_T_152; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_154 = _result_leading_T_90[31] ? 6'h1f : _result_leading_T_153; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_155 = _result_leading_T_90[30] ? 6'h1e : _result_leading_T_154; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_156 = _result_leading_T_90[29] ? 6'h1d : _result_leading_T_155; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_157 = _result_leading_T_90[28] ? 6'h1c : _result_leading_T_156; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_158 = _result_leading_T_90[27] ? 6'h1b : _result_leading_T_157; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_159 = _result_leading_T_90[26] ? 6'h1a : _result_leading_T_158; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_160 = _result_leading_T_90[25] ? 6'h19 : _result_leading_T_159; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_161 = _result_leading_T_90[24] ? 6'h18 : _result_leading_T_160; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_162 = _result_leading_T_90[23] ? 6'h17 : _result_leading_T_161; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_163 = _result_leading_T_90[22] ? 6'h16 : _result_leading_T_162; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_164 = _result_leading_T_90[21] ? 6'h15 : _result_leading_T_163; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_165 = _result_leading_T_90[20] ? 6'h14 : _result_leading_T_164; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_166 = _result_leading_T_90[19] ? 6'h13 : _result_leading_T_165; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_167 = _result_leading_T_90[18] ? 6'h12 : _result_leading_T_166; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_168 = _result_leading_T_90[17] ? 6'h11 : _result_leading_T_167; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_169 = _result_leading_T_90[16] ? 6'h10 : _result_leading_T_168; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_170 = _result_leading_T_90[15] ? 6'hf : _result_leading_T_169; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_171 = _result_leading_T_90[14] ? 6'he : _result_leading_T_170; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_172 = _result_leading_T_90[13] ? 6'hd : _result_leading_T_171; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_173 = _result_leading_T_90[12] ? 6'hc : _result_leading_T_172; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_174 = _result_leading_T_90[11] ? 6'hb : _result_leading_T_173; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_175 = _result_leading_T_90[10] ? 6'ha : _result_leading_T_174; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_176 = _result_leading_T_90[9] ? 6'h9 : _result_leading_T_175; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_177 = _result_leading_T_90[8] ? 6'h8 : _result_leading_T_176; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_178 = _result_leading_T_90[7] ? 6'h7 : _result_leading_T_177; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_179 = _result_leading_T_90[6] ? 6'h6 : _result_leading_T_178; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_180 = _result_leading_T_90[5] ? 6'h5 : _result_leading_T_179; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_181 = _result_leading_T_90[4] ? 6'h4 : _result_leading_T_180; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_182 = _result_leading_T_90[3] ? 6'h3 : _result_leading_T_181; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_183 = _result_leading_T_90[2] ? 6'h2 : _result_leading_T_182; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_184 = _result_leading_T_90[1] ? 6'h1 : _result_leading_T_183; // @[Mux.scala 47:70]
  wire [5:0] result_leading = _result_leading_T_90[0] ? 6'h0 : _result_leading_T_184; // @[Mux.scala 47:70]
  wire [5:0] result_msb = 6'h2f - result_leading; // @[AecTranscendental.scala 125:20]
  wire  _result_right_T = result_msb > 6'h17; // @[AecTranscendental.scala 126:25]
  wire [5:0] _result_right_T_2 = result_msb - 6'h17; // @[AecTranscendental.scala 126:37]
  wire [5:0] result_right = result_msb > 6'h17 ? _result_right_T_2 : 6'h0; // @[AecTranscendental.scala 126:20]
  wire [5:0] _result_left_T_2 = 6'h17 - result_msb; // @[AecTranscendental.scala 127:37]
  wire [5:0] result_left = result_msb < 6'h17 ? _result_left_T_2 : 6'h0; // @[AecTranscendental.scala 127:19]
  wire [47:0] _result_normalized_T_1 = result_magnitude >> result_right; // @[AecTranscendental.scala 128:48]
  wire [110:0] _GEN_13 = {{63'd0}, result_magnitude}; // @[AecTranscendental.scala 128:68]
  wire [110:0] _result_normalized_T_2 = _GEN_13 << result_left; // @[AecTranscendental.scala 128:68]
  wire [110:0] result_normalized = _result_right_T ? {{63'd0}, _result_normalized_T_1} : _result_normalized_T_2; // @[AecTranscendental.scala 128:25]
  wire [5:0] _result_guard_T_2 = result_right - 6'h1; // @[AecTranscendental.scala 129:53]
  wire [47:0] _result_guard_T_3 = result_magnitude >> _result_guard_T_2; // @[AecTranscendental.scala 129:43]
  wire  result_guard = |result_right & _result_guard_T_3[0]; // @[AecTranscendental.scala 129:20]
  wire [110:0] _result_stickyMask_T_3 = 111'h1 << _result_guard_T_2; // @[AecTranscendental.scala 130:50]
  wire [110:0] _result_stickyMask_T_5 = _result_stickyMask_T_3 - 111'h1; // @[AecTranscendental.scala 130:68]
  wire [110:0] result_stickyMask = result_right > 6'h1 ? _result_stickyMask_T_5 : 111'h0; // @[AecTranscendental.scala 130:25]
  wire [110:0] _GEN_194 = {{63'd0}, result_magnitude}; // @[AecTranscendental.scala 131:29]
  wire [110:0] _result_sticky_T = _GEN_194 & result_stickyMask; // @[AecTranscendental.scala 131:29]
  wire  result_sticky = |_result_sticky_T; // @[AecTranscendental.scala 131:43]
  wire  _result_rounded_T_3 = result_guard & (result_sticky | result_normalized[0]); // @[AecTranscendental.scala 132:46]
  wire [24:0] _GEN_195 = {{24'd0}, _result_rounded_T_3}; // @[AecTranscendental.scala 132:37]
  wire [24:0] result_rounded = result_normalized[24:0] + _GEN_195; // @[AecTranscendental.scala 132:37]
  wire  result_carry = result_rounded[24]; // @[AecTranscendental.scala 133:24]
  wire [23:0] result_significand24 = result_carry ? result_rounded[24:1] : result_rounded[23:0]; // @[AecTranscendental.scala 134:28]
  wire [11:0] _result_biased_T_1 = {6'h0,result_msb}; // @[AecTranscendental.scala 135:37]
  wire [11:0] _result_biased_T_4 = $signed(_result_biased_T_1) - 12'sh22; // @[AecTranscendental.scala 135:44]
  wire [11:0] _result_biased_T_7 = $signed(_result_biased_T_4) + 12'sh7f; // @[AecTranscendental.scala 135:56]
  wire [12:0] _result_biased_T_8 = {{1{_result_biased_T_7[11]}},_result_biased_T_7}; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_10 = _result_biased_T_8[11:0]; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_12 = {11'h0,result_carry}; // @[AecTranscendental.scala 135:102]
  wire [11:0] result_biased = $signed(_result_biased_T_10) + $signed(_result_biased_T_12); // @[AecTranscendental.scala 135:78]
  wire [11:0] _result_normal_T = $signed(_result_biased_T_10) + $signed(_result_biased_T_12); // @[AecTranscendental.scala 136:39]
  wire [31:0] result_normal = {result_negative,_result_normal_T[7:0],result_significand24[22:0]}; // @[Cat.scala 33:92]
  wire [11:0] result_subShift = 12'sh1 - $signed(result_biased); // @[AecTranscendental.scala 137:35]
  wire [23:0] _result_subnormal_T = result_significand24 >> result_subShift; // @[AecTranscendental.scala 138:59]
  wire [32:0] result_subnormal = {result_negative,8'h0,_result_subnormal_T}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_7 = {result_negative,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_9 = {result_negative,31'h7f800000}; // @[Cat.scala 33:92]
  wire [32:0] _result_T_13 = $signed(result_biased) < -12'sh17 ? {{1'd0}, _result_T_7} : result_subnormal; // @[AecTranscendental.scala 141:31]
  wire [32:0] _result_T_14 = $signed(result_biased) <= 12'sh0 ? _result_T_13 : {{1'd0}, result_normal}; // @[AecTranscendental.scala 141:12]
  wire [32:0] _result_T_15 = $signed(result_biased) >= 12'shff ? {{1'd0}, _result_T_9} : _result_T_14; // @[AecTranscendental.scala 140:10]
  wire [32:0] _result_T_16 = ~(|result_magnitude) ? {{1'd0}, _result_T_7} : _result_T_15; // @[AecTranscendental.scala 139:8]
  wire [32:0] _GEN_82 = polynomialCos ? _result_T_16 : {{1'd0}, _GEN_53}; // @[AecTranscendental.scala 218:26 219:14]
  wire [4:0] _GEN_83 = polynomialCos ? 5'h10 : 5'h6; // @[AecTranscendental.scala 218:26 219:66 221:35]
  wire [47:0] _GEN_84 = polynomialCos ? $signed(_GEN_79) : $signed(inner); // @[AecTranscendental.scala 218:26 221:19]
  wire [47:0] _GEN_85 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_77); // @[AecTranscendental.scala 215:47 216:15]
  wire [47:0] _GEN_86 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_78); // @[AecTranscendental.scala 215:47 216:39]
  wire [32:0] _GEN_87 = _multiplyState_T_7 & multiplier_io_resp_valid ? _GEN_82 : {{1'd0}, _GEN_53}; // @[AecTranscendental.scala 215:47]
  wire [4:0] _GEN_88 = _multiplyState_T_7 & multiplier_io_resp_valid ? _GEN_83 : _GEN_80; // @[AecTranscendental.scala 215:47]
  wire [47:0] _GEN_89 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(_GEN_84) : $signed(_GEN_79); // @[AecTranscendental.scala 215:47]
  wire [47:0] result_bounded_1 = negateResult ? $signed(_signedQuadrant_T_7) : $signed(multiplyResult); // @[AecTranscendental.scala 226:26]
  wire  result_negative_1 = $signed(result_bounded_1) < 48'sh0; // @[AecTranscendental.scala 122:28]
  wire [47:0] _result_magnitude_T_6 = 48'sh0 - $signed(result_bounded_1); // @[AecTranscendental.scala 123:35]
  wire [47:0] result_magnitude_1 = result_negative_1 ? $signed(_result_magnitude_T_6) : $signed(result_bounded_1); // @[AecTranscendental.scala 123:54]
  wire [31:0] _GEN_196 = {{16'd0}, result_magnitude_1[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_189 = _GEN_196 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_191 = {result_magnitude_1[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_193 = _result_leading_T_191 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_194 = _result_leading_T_189 | _result_leading_T_193; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_197 = {{8'd0}, _result_leading_T_194[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_199 = _GEN_197 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_201 = {_result_leading_T_194[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_203 = _result_leading_T_201 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_204 = _result_leading_T_199 | _result_leading_T_203; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_198 = {{4'd0}, _result_leading_T_204[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_209 = _GEN_198 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_211 = {_result_leading_T_204[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_213 = _result_leading_T_211 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_214 = _result_leading_T_209 | _result_leading_T_213; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_199 = {{2'd0}, _result_leading_T_214[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_219 = _GEN_199 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_221 = {_result_leading_T_214[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_223 = _result_leading_T_221 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_224 = _result_leading_T_219 | _result_leading_T_223; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_200 = {{1'd0}, _result_leading_T_224[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_229 = _GEN_200 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_231 = {_result_leading_T_224[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_233 = _result_leading_T_231 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_234 = _result_leading_T_229 | _result_leading_T_233; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_201 = {{8'd0}, result_magnitude_1[47:40]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_239 = _GEN_201 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_241 = {result_magnitude_1[39:32], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_243 = _result_leading_T_241 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_244 = _result_leading_T_239 | _result_leading_T_243; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_202 = {{4'd0}, _result_leading_T_244[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_249 = _GEN_202 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_251 = {_result_leading_T_244[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_253 = _result_leading_T_251 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_254 = _result_leading_T_249 | _result_leading_T_253; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_203 = {{2'd0}, _result_leading_T_254[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_259 = _GEN_203 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_261 = {_result_leading_T_254[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_263 = _result_leading_T_261 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_264 = _result_leading_T_259 | _result_leading_T_263; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_204 = {{1'd0}, _result_leading_T_264[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_269 = _GEN_204 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_271 = {_result_leading_T_264[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_273 = _result_leading_T_271 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_274 = _result_leading_T_269 | _result_leading_T_273; // @[Bitwise.scala 108:39]
  wire [47:0] _result_leading_T_275 = {_result_leading_T_234,_result_leading_T_274}; // @[Cat.scala 33:92]
  wire [5:0] _result_leading_T_324 = _result_leading_T_275[46] ? 6'h2e : 6'h2f; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_325 = _result_leading_T_275[45] ? 6'h2d : _result_leading_T_324; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_326 = _result_leading_T_275[44] ? 6'h2c : _result_leading_T_325; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_327 = _result_leading_T_275[43] ? 6'h2b : _result_leading_T_326; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_328 = _result_leading_T_275[42] ? 6'h2a : _result_leading_T_327; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_329 = _result_leading_T_275[41] ? 6'h29 : _result_leading_T_328; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_330 = _result_leading_T_275[40] ? 6'h28 : _result_leading_T_329; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_331 = _result_leading_T_275[39] ? 6'h27 : _result_leading_T_330; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_332 = _result_leading_T_275[38] ? 6'h26 : _result_leading_T_331; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_333 = _result_leading_T_275[37] ? 6'h25 : _result_leading_T_332; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_334 = _result_leading_T_275[36] ? 6'h24 : _result_leading_T_333; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_335 = _result_leading_T_275[35] ? 6'h23 : _result_leading_T_334; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_336 = _result_leading_T_275[34] ? 6'h22 : _result_leading_T_335; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_337 = _result_leading_T_275[33] ? 6'h21 : _result_leading_T_336; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_338 = _result_leading_T_275[32] ? 6'h20 : _result_leading_T_337; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_339 = _result_leading_T_275[31] ? 6'h1f : _result_leading_T_338; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_340 = _result_leading_T_275[30] ? 6'h1e : _result_leading_T_339; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_341 = _result_leading_T_275[29] ? 6'h1d : _result_leading_T_340; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_342 = _result_leading_T_275[28] ? 6'h1c : _result_leading_T_341; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_343 = _result_leading_T_275[27] ? 6'h1b : _result_leading_T_342; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_344 = _result_leading_T_275[26] ? 6'h1a : _result_leading_T_343; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_345 = _result_leading_T_275[25] ? 6'h19 : _result_leading_T_344; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_346 = _result_leading_T_275[24] ? 6'h18 : _result_leading_T_345; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_347 = _result_leading_T_275[23] ? 6'h17 : _result_leading_T_346; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_348 = _result_leading_T_275[22] ? 6'h16 : _result_leading_T_347; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_349 = _result_leading_T_275[21] ? 6'h15 : _result_leading_T_348; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_350 = _result_leading_T_275[20] ? 6'h14 : _result_leading_T_349; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_351 = _result_leading_T_275[19] ? 6'h13 : _result_leading_T_350; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_352 = _result_leading_T_275[18] ? 6'h12 : _result_leading_T_351; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_353 = _result_leading_T_275[17] ? 6'h11 : _result_leading_T_352; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_354 = _result_leading_T_275[16] ? 6'h10 : _result_leading_T_353; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_355 = _result_leading_T_275[15] ? 6'hf : _result_leading_T_354; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_356 = _result_leading_T_275[14] ? 6'he : _result_leading_T_355; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_357 = _result_leading_T_275[13] ? 6'hd : _result_leading_T_356; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_358 = _result_leading_T_275[12] ? 6'hc : _result_leading_T_357; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_359 = _result_leading_T_275[11] ? 6'hb : _result_leading_T_358; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_360 = _result_leading_T_275[10] ? 6'ha : _result_leading_T_359; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_361 = _result_leading_T_275[9] ? 6'h9 : _result_leading_T_360; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_362 = _result_leading_T_275[8] ? 6'h8 : _result_leading_T_361; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_363 = _result_leading_T_275[7] ? 6'h7 : _result_leading_T_362; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_364 = _result_leading_T_275[6] ? 6'h6 : _result_leading_T_363; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_365 = _result_leading_T_275[5] ? 6'h5 : _result_leading_T_364; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_366 = _result_leading_T_275[4] ? 6'h4 : _result_leading_T_365; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_367 = _result_leading_T_275[3] ? 6'h3 : _result_leading_T_366; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_368 = _result_leading_T_275[2] ? 6'h2 : _result_leading_T_367; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_369 = _result_leading_T_275[1] ? 6'h1 : _result_leading_T_368; // @[Mux.scala 47:70]
  wire [5:0] result_leading_1 = _result_leading_T_275[0] ? 6'h0 : _result_leading_T_369; // @[Mux.scala 47:70]
  wire [5:0] result_msb_1 = 6'h2f - result_leading_1; // @[AecTranscendental.scala 125:20]
  wire  _result_right_T_3 = result_msb_1 > 6'h17; // @[AecTranscendental.scala 126:25]
  wire [5:0] _result_right_T_5 = result_msb_1 - 6'h17; // @[AecTranscendental.scala 126:37]
  wire [5:0] result_right_1 = result_msb_1 > 6'h17 ? _result_right_T_5 : 6'h0; // @[AecTranscendental.scala 126:20]
  wire [5:0] _result_left_T_5 = 6'h17 - result_msb_1; // @[AecTranscendental.scala 127:37]
  wire [5:0] result_left_1 = result_msb_1 < 6'h17 ? _result_left_T_5 : 6'h0; // @[AecTranscendental.scala 127:19]
  wire [47:0] _result_normalized_T_4 = result_magnitude_1 >> result_right_1; // @[AecTranscendental.scala 128:48]
  wire [110:0] _GEN_19 = {{63'd0}, result_magnitude_1}; // @[AecTranscendental.scala 128:68]
  wire [110:0] _result_normalized_T_5 = _GEN_19 << result_left_1; // @[AecTranscendental.scala 128:68]
  wire [110:0] result_normalized_1 = _result_right_T_3 ? {{63'd0}, _result_normalized_T_4} : _result_normalized_T_5; // @[AecTranscendental.scala 128:25]
  wire [5:0] _result_guard_T_7 = result_right_1 - 6'h1; // @[AecTranscendental.scala 129:53]
  wire [47:0] _result_guard_T_8 = result_magnitude_1 >> _result_guard_T_7; // @[AecTranscendental.scala 129:43]
  wire  result_guard_1 = |result_right_1 & _result_guard_T_8[0]; // @[AecTranscendental.scala 129:20]
  wire [110:0] _result_stickyMask_T_9 = 111'h1 << _result_guard_T_7; // @[AecTranscendental.scala 130:50]
  wire [110:0] _result_stickyMask_T_11 = _result_stickyMask_T_9 - 111'h1; // @[AecTranscendental.scala 130:68]
  wire [110:0] result_stickyMask_1 = result_right_1 > 6'h1 ? _result_stickyMask_T_11 : 111'h0; // @[AecTranscendental.scala 130:25]
  wire [110:0] _GEN_205 = {{63'd0}, result_magnitude_1}; // @[AecTranscendental.scala 131:29]
  wire [110:0] _result_sticky_T_1 = _GEN_205 & result_stickyMask_1; // @[AecTranscendental.scala 131:29]
  wire  result_sticky_1 = |_result_sticky_T_1; // @[AecTranscendental.scala 131:43]
  wire  _result_rounded_T_8 = result_guard_1 & (result_sticky_1 | result_normalized_1[0]); // @[AecTranscendental.scala 132:46]
  wire [24:0] _GEN_206 = {{24'd0}, _result_rounded_T_8}; // @[AecTranscendental.scala 132:37]
  wire [24:0] result_rounded_1 = result_normalized_1[24:0] + _GEN_206; // @[AecTranscendental.scala 132:37]
  wire  result_carry_1 = result_rounded_1[24]; // @[AecTranscendental.scala 133:24]
  wire [23:0] result_significand24_1 = result_carry_1 ? result_rounded_1[24:1] : result_rounded_1[23:0]; // @[AecTranscendental.scala 134:28]
  wire [11:0] _result_biased_T_16 = {6'h0,result_msb_1}; // @[AecTranscendental.scala 135:37]
  wire [11:0] _result_biased_T_19 = $signed(_result_biased_T_16) - 12'sh22; // @[AecTranscendental.scala 135:44]
  wire [11:0] _result_biased_T_22 = $signed(_result_biased_T_19) + 12'sh7f; // @[AecTranscendental.scala 135:56]
  wire [12:0] _result_biased_T_23 = {{1{_result_biased_T_22[11]}},_result_biased_T_22}; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_25 = _result_biased_T_23[11:0]; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_27 = {11'h0,result_carry_1}; // @[AecTranscendental.scala 135:102]
  wire [11:0] result_biased_1 = $signed(_result_biased_T_25) + $signed(_result_biased_T_27); // @[AecTranscendental.scala 135:78]
  wire [11:0] _result_normal_T_3 = $signed(_result_biased_T_25) + $signed(_result_biased_T_27); // @[AecTranscendental.scala 136:39]
  wire [31:0] result_normal_1 = {result_negative_1,_result_normal_T_3[7:0],result_significand24_1[22:0]}; // @[Cat.scala 33:92]
  wire [11:0] result_subShift_1 = 12'sh1 - $signed(result_biased_1); // @[AecTranscendental.scala 137:35]
  wire [23:0] _result_subnormal_T_1 = result_significand24_1 >> result_subShift_1; // @[AecTranscendental.scala 138:59]
  wire [32:0] result_subnormal_1 = {result_negative_1,8'h0,_result_subnormal_T_1}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_23 = {result_negative_1,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_25 = {result_negative_1,31'h7f800000}; // @[Cat.scala 33:92]
  wire [32:0] _result_T_29 = $signed(result_biased_1) < -12'sh17 ? {{1'd0}, _result_T_23} : result_subnormal_1; // @[AecTranscendental.scala 141:31]
  wire [32:0] _result_T_30 = $signed(result_biased_1) <= 12'sh0 ? _result_T_29 : {{1'd0}, result_normal_1}; // @[AecTranscendental.scala 141:12]
  wire [32:0] _result_T_31 = $signed(result_biased_1) >= 12'shff ? {{1'd0}, _result_T_25} : _result_T_30; // @[AecTranscendental.scala 140:10]
  wire [32:0] _result_T_32 = ~(|result_magnitude_1) ? {{1'd0}, _result_T_23} : _result_T_31; // @[AecTranscendental.scala 139:8]
  wire [47:0] _GEN_90 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_85); // @[AecTranscendental.scala 224:50 225:15]
  wire [47:0] _GEN_91 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_86); // @[AecTranscendental.scala 224:50 225:34]
  wire [32:0] _GEN_92 = _multiplyState_T_9 & multiplier_io_resp_valid ? _result_T_32 : _GEN_87; // @[AecTranscendental.scala 224:50 226:12]
  wire [4:0] _GEN_93 = _multiplyState_T_9 & multiplier_io_resp_valid ? 5'h10 : _GEN_88; // @[AecTranscendental.scala 224:50 226:82]
  wire [47:0] _GEN_94 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_90); // @[AecTranscendental.scala 229:46 230:15]
  wire [47:0] _GEN_95 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(48'sh2c5c85fdf) : $signed(_GEN_91); // @[AecTranscendental.scala 229:46 230:34]
  wire [47:0] _GEN_97 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(48'sh127e) : $signed(_GEN_89); // @[AecTranscendental.scala 229:46 232:17]
  wire [3:0] _GEN_98 = _multiplyState_T_11 & multiplier_io_resp_valid ? 4'h4 : _GEN_81; // @[AecTranscendental.scala 229:46 237:10]
  wire [4:0] _GEN_99 = _multiplyState_T_11 & multiplier_io_resp_valid ? 5'h4 : _GEN_93; // @[AecTranscendental.scala 229:46 234:11]
  wire [47:0] _coefficient_T_1 = 4'h4 == step ? $signed(48'shb8ef) : $signed(48'sh400000000); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_3 = 4'h5 == step ? $signed(48'sh68068) : $signed(_coefficient_T_1); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_5 = 4'h6 == step ? $signed(48'sh340340) : $signed(_coefficient_T_3); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_7 = 4'h7 == step ? $signed(48'sh16c16c1) : $signed(_coefficient_T_5); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_9 = 4'h8 == step ? $signed(48'sh8888889) : $signed(_coefficient_T_7); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_11 = 4'h9 == step ? $signed(48'sh2aaaaaab) : $signed(_coefficient_T_9); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_13 = 4'ha == step ? $signed(48'shaaaaaaab) : $signed(_coefficient_T_11); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_15 = 4'hb == step ? $signed(48'sh200000000) : $signed(_coefficient_T_13); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_17 = 4'hc == step ? $signed(48'sh400000000) : $signed(_coefficient_T_15); // @[Mux.scala 81:58]
  wire [47:0] coefficient = 4'hd == step ? $signed(48'sh400000000) : $signed(_coefficient_T_17); // @[Mux.scala 81:58]
  wire [47:0] _accumulator_T_16 = $signed(coefficient) + $signed(multiplyResult); // @[AecTranscendental.scala 245:32]
  wire  result_negative_2 = $signed(_accumulator_T_16) < 48'sh0; // @[AecTranscendental.scala 122:28]
  wire [47:0] _result_magnitude_T_10 = 48'sh0 - $signed(_accumulator_T_16); // @[AecTranscendental.scala 123:35]
  wire [47:0] result_magnitude_2 = result_negative_2 ? $signed(_result_magnitude_T_10) : $signed(_accumulator_T_16); // @[AecTranscendental.scala 123:54]
  wire [31:0] _GEN_207 = {{16'd0}, result_magnitude_2[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_374 = _GEN_207 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_376 = {result_magnitude_2[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_378 = _result_leading_T_376 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_379 = _result_leading_T_374 | _result_leading_T_378; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_208 = {{8'd0}, _result_leading_T_379[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_384 = _GEN_208 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_386 = {_result_leading_T_379[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_388 = _result_leading_T_386 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_389 = _result_leading_T_384 | _result_leading_T_388; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_209 = {{4'd0}, _result_leading_T_389[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_394 = _GEN_209 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_396 = {_result_leading_T_389[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_398 = _result_leading_T_396 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_399 = _result_leading_T_394 | _result_leading_T_398; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_210 = {{2'd0}, _result_leading_T_399[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_404 = _GEN_210 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_406 = {_result_leading_T_399[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_408 = _result_leading_T_406 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_409 = _result_leading_T_404 | _result_leading_T_408; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_211 = {{1'd0}, _result_leading_T_409[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_414 = _GEN_211 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_416 = {_result_leading_T_409[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_418 = _result_leading_T_416 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_419 = _result_leading_T_414 | _result_leading_T_418; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_212 = {{8'd0}, result_magnitude_2[47:40]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_424 = _GEN_212 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_426 = {result_magnitude_2[39:32], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_428 = _result_leading_T_426 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_429 = _result_leading_T_424 | _result_leading_T_428; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_213 = {{4'd0}, _result_leading_T_429[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_434 = _GEN_213 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_436 = {_result_leading_T_429[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_438 = _result_leading_T_436 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_439 = _result_leading_T_434 | _result_leading_T_438; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_214 = {{2'd0}, _result_leading_T_439[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_444 = _GEN_214 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_446 = {_result_leading_T_439[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_448 = _result_leading_T_446 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_449 = _result_leading_T_444 | _result_leading_T_448; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_215 = {{1'd0}, _result_leading_T_449[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_454 = _GEN_215 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_456 = {_result_leading_T_449[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_458 = _result_leading_T_456 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_459 = _result_leading_T_454 | _result_leading_T_458; // @[Bitwise.scala 108:39]
  wire [47:0] _result_leading_T_460 = {_result_leading_T_419,_result_leading_T_459}; // @[Cat.scala 33:92]
  wire [5:0] _result_leading_T_509 = _result_leading_T_460[46] ? 6'h2e : 6'h2f; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_510 = _result_leading_T_460[45] ? 6'h2d : _result_leading_T_509; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_511 = _result_leading_T_460[44] ? 6'h2c : _result_leading_T_510; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_512 = _result_leading_T_460[43] ? 6'h2b : _result_leading_T_511; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_513 = _result_leading_T_460[42] ? 6'h2a : _result_leading_T_512; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_514 = _result_leading_T_460[41] ? 6'h29 : _result_leading_T_513; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_515 = _result_leading_T_460[40] ? 6'h28 : _result_leading_T_514; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_516 = _result_leading_T_460[39] ? 6'h27 : _result_leading_T_515; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_517 = _result_leading_T_460[38] ? 6'h26 : _result_leading_T_516; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_518 = _result_leading_T_460[37] ? 6'h25 : _result_leading_T_517; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_519 = _result_leading_T_460[36] ? 6'h24 : _result_leading_T_518; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_520 = _result_leading_T_460[35] ? 6'h23 : _result_leading_T_519; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_521 = _result_leading_T_460[34] ? 6'h22 : _result_leading_T_520; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_522 = _result_leading_T_460[33] ? 6'h21 : _result_leading_T_521; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_523 = _result_leading_T_460[32] ? 6'h20 : _result_leading_T_522; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_524 = _result_leading_T_460[31] ? 6'h1f : _result_leading_T_523; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_525 = _result_leading_T_460[30] ? 6'h1e : _result_leading_T_524; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_526 = _result_leading_T_460[29] ? 6'h1d : _result_leading_T_525; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_527 = _result_leading_T_460[28] ? 6'h1c : _result_leading_T_526; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_528 = _result_leading_T_460[27] ? 6'h1b : _result_leading_T_527; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_529 = _result_leading_T_460[26] ? 6'h1a : _result_leading_T_528; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_530 = _result_leading_T_460[25] ? 6'h19 : _result_leading_T_529; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_531 = _result_leading_T_460[24] ? 6'h18 : _result_leading_T_530; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_532 = _result_leading_T_460[23] ? 6'h17 : _result_leading_T_531; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_533 = _result_leading_T_460[22] ? 6'h16 : _result_leading_T_532; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_534 = _result_leading_T_460[21] ? 6'h15 : _result_leading_T_533; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_535 = _result_leading_T_460[20] ? 6'h14 : _result_leading_T_534; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_536 = _result_leading_T_460[19] ? 6'h13 : _result_leading_T_535; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_537 = _result_leading_T_460[18] ? 6'h12 : _result_leading_T_536; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_538 = _result_leading_T_460[17] ? 6'h11 : _result_leading_T_537; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_539 = _result_leading_T_460[16] ? 6'h10 : _result_leading_T_538; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_540 = _result_leading_T_460[15] ? 6'hf : _result_leading_T_539; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_541 = _result_leading_T_460[14] ? 6'he : _result_leading_T_540; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_542 = _result_leading_T_460[13] ? 6'hd : _result_leading_T_541; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_543 = _result_leading_T_460[12] ? 6'hc : _result_leading_T_542; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_544 = _result_leading_T_460[11] ? 6'hb : _result_leading_T_543; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_545 = _result_leading_T_460[10] ? 6'ha : _result_leading_T_544; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_546 = _result_leading_T_460[9] ? 6'h9 : _result_leading_T_545; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_547 = _result_leading_T_460[8] ? 6'h8 : _result_leading_T_546; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_548 = _result_leading_T_460[7] ? 6'h7 : _result_leading_T_547; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_549 = _result_leading_T_460[6] ? 6'h6 : _result_leading_T_548; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_550 = _result_leading_T_460[5] ? 6'h5 : _result_leading_T_549; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_551 = _result_leading_T_460[4] ? 6'h4 : _result_leading_T_550; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_552 = _result_leading_T_460[3] ? 6'h3 : _result_leading_T_551; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_553 = _result_leading_T_460[2] ? 6'h2 : _result_leading_T_552; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_554 = _result_leading_T_460[1] ? 6'h1 : _result_leading_T_553; // @[Mux.scala 47:70]
  wire [5:0] result_leading_2 = _result_leading_T_460[0] ? 6'h0 : _result_leading_T_554; // @[Mux.scala 47:70]
  wire [5:0] result_msb_2 = 6'h2f - result_leading_2; // @[AecTranscendental.scala 125:20]
  wire  _result_right_T_6 = result_msb_2 > 6'h17; // @[AecTranscendental.scala 126:25]
  wire [5:0] _result_right_T_8 = result_msb_2 - 6'h17; // @[AecTranscendental.scala 126:37]
  wire [5:0] result_right_2 = result_msb_2 > 6'h17 ? _result_right_T_8 : 6'h0; // @[AecTranscendental.scala 126:20]
  wire [5:0] _result_left_T_8 = 6'h17 - result_msb_2; // @[AecTranscendental.scala 127:37]
  wire [5:0] result_left_2 = result_msb_2 < 6'h17 ? _result_left_T_8 : 6'h0; // @[AecTranscendental.scala 127:19]
  wire [47:0] _result_normalized_T_7 = result_magnitude_2 >> result_right_2; // @[AecTranscendental.scala 128:48]
  wire [110:0] _GEN_25 = {{63'd0}, result_magnitude_2}; // @[AecTranscendental.scala 128:68]
  wire [110:0] _result_normalized_T_8 = _GEN_25 << result_left_2; // @[AecTranscendental.scala 128:68]
  wire [110:0] result_normalized_2 = _result_right_T_6 ? {{63'd0}, _result_normalized_T_7} : _result_normalized_T_8; // @[AecTranscendental.scala 128:25]
  wire [5:0] _result_guard_T_12 = result_right_2 - 6'h1; // @[AecTranscendental.scala 129:53]
  wire [47:0] _result_guard_T_13 = result_magnitude_2 >> _result_guard_T_12; // @[AecTranscendental.scala 129:43]
  wire  result_guard_2 = |result_right_2 & _result_guard_T_13[0]; // @[AecTranscendental.scala 129:20]
  wire [110:0] _result_stickyMask_T_15 = 111'h1 << _result_guard_T_12; // @[AecTranscendental.scala 130:50]
  wire [110:0] _result_stickyMask_T_17 = _result_stickyMask_T_15 - 111'h1; // @[AecTranscendental.scala 130:68]
  wire [110:0] result_stickyMask_2 = result_right_2 > 6'h1 ? _result_stickyMask_T_17 : 111'h0; // @[AecTranscendental.scala 130:25]
  wire [110:0] _GEN_216 = {{63'd0}, result_magnitude_2}; // @[AecTranscendental.scala 131:29]
  wire [110:0] _result_sticky_T_2 = _GEN_216 & result_stickyMask_2; // @[AecTranscendental.scala 131:29]
  wire  result_sticky_2 = |_result_sticky_T_2; // @[AecTranscendental.scala 131:43]
  wire  _result_rounded_T_13 = result_guard_2 & (result_sticky_2 | result_normalized_2[0]); // @[AecTranscendental.scala 132:46]
  wire [24:0] _GEN_217 = {{24'd0}, _result_rounded_T_13}; // @[AecTranscendental.scala 132:37]
  wire [24:0] result_rounded_2 = result_normalized_2[24:0] + _GEN_217; // @[AecTranscendental.scala 132:37]
  wire  result_carry_2 = result_rounded_2[24]; // @[AecTranscendental.scala 133:24]
  wire [23:0] result_significand24_2 = result_carry_2 ? result_rounded_2[24:1] : result_rounded_2[23:0]; // @[AecTranscendental.scala 134:28]
  wire [11:0] _result_biased_T_31 = {6'h0,result_msb_2}; // @[AecTranscendental.scala 135:37]
  wire [11:0] _result_biased_T_34 = $signed(_result_biased_T_31) - 12'sh22; // @[AecTranscendental.scala 135:44]
  wire [11:0] _result_biased_T_37 = $signed(_result_biased_T_34) + 12'sh7f; // @[AecTranscendental.scala 135:56]
  wire [11:0] _result_biased_T_40 = $signed(_result_biased_T_37) + $signed(exponentScale); // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_42 = {11'h0,result_carry_2}; // @[AecTranscendental.scala 135:102]
  wire [11:0] result_biased_2 = $signed(_result_biased_T_40) + $signed(_result_biased_T_42); // @[AecTranscendental.scala 135:78]
  wire [11:0] _result_normal_T_6 = $signed(_result_biased_T_40) + $signed(_result_biased_T_42); // @[AecTranscendental.scala 136:39]
  wire [31:0] result_normal_2 = {result_negative_2,_result_normal_T_6[7:0],result_significand24_2[22:0]}; // @[Cat.scala 33:92]
  wire [11:0] result_subShift_2 = 12'sh1 - $signed(result_biased_2); // @[AecTranscendental.scala 137:35]
  wire [23:0] _result_subnormal_T_2 = result_significand24_2 >> result_subShift_2; // @[AecTranscendental.scala 138:59]
  wire [32:0] result_subnormal_2 = {result_negative_2,8'h0,_result_subnormal_T_2}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_38 = {result_negative_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_40 = {result_negative_2,31'h7f800000}; // @[Cat.scala 33:92]
  wire [32:0] _result_T_44 = $signed(result_biased_2) < -12'sh17 ? {{1'd0}, _result_T_38} : result_subnormal_2; // @[AecTranscendental.scala 141:31]
  wire [32:0] _result_T_45 = $signed(result_biased_2) <= 12'sh0 ? _result_T_44 : {{1'd0}, result_normal_2}; // @[AecTranscendental.scala 141:12]
  wire [32:0] _result_T_46 = $signed(result_biased_2) >= 12'shff ? {{1'd0}, _result_T_40} : _result_T_45; // @[AecTranscendental.scala 140:10]
  wire [32:0] _result_T_47 = ~(|result_magnitude_2) ? {{1'd0}, _result_T_38} : _result_T_46; // @[AecTranscendental.scala 139:8]
  wire [32:0] _GEN_101 = step == 4'hd ? _result_T_47 : _GEN_92; // @[AecTranscendental.scala 246:{26,35}]
  wire [4:0] _GEN_102 = step == 4'hd ? 5'h10 : _GEN_99; // @[AecTranscendental.scala 246:{26,98}]
  wire [3:0] _GEN_103 = step == 4'hd ? _GEN_98 : _step_T_1; // @[AecTranscendental.scala 246:26 247:25]
  wire [47:0] _GEN_104 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_94)
    ; // @[AecTranscendental.scala 239:57 240:15]
  wire [47:0] _GEN_105 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(
    _GEN_95); // @[AecTranscendental.scala 239:57 240:34]
  wire [32:0] _GEN_107 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? _GEN_101 : _GEN_92; // @[AecTranscendental.scala 239:57]
  wire [4:0] _GEN_108 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? _GEN_102 : _GEN_99; // @[AecTranscendental.scala 239:57]
  wire [3:0] _GEN_109 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? _GEN_103 : _GEN_98; // @[AecTranscendental.scala 239:57]
  wire [47:0] denominator = $signed(term) + 48'sh400000000; // @[AecTranscendental.scala 250:26]
  wire [47:0] _multiplyA_T_1 = _T_40 ? $signed(argument2) : $signed(term); // @[AecTranscendental.scala 256:23]
  wire [47:0] _multiplyA_T_4 = $signed(term) - 48'sh400000000; // @[AecTranscendental.scala 264:35]
  wire [47:0] _GEN_110 = 5'hf == state ? $signed(auxiliary) : $signed(_GEN_104); // @[AecTranscendental.scala 251:18 269:31]
  wire [47:0] _GEN_111 = 5'hf == state ? $signed(48'shb8aa3b296) : $signed(_GEN_105); // @[AecTranscendental.scala 251:18 269:55]
  wire [47:0] _GEN_112 = 5'he == state ? $signed(auxiliary) : $signed(_GEN_110); // @[AecTranscendental.scala 251:18 268:31]
  wire [47:0] _GEN_113 = 5'he == state ? $signed(accumulator) : $signed(_GEN_111); // @[AecTranscendental.scala 251:18 268:55]
  wire [47:0] _GEN_114 = 5'hc == state ? $signed(term) : $signed(_GEN_112); // @[AecTranscendental.scala 251:18 267:28]
  wire [47:0] _GEN_115 = 5'hc == state ? $signed(argument2) : $signed(_GEN_113); // @[AecTranscendental.scala 251:18 267:47]
  wire [47:0] _GEN_116 = 5'hd == state ? $signed(argument2) : $signed(_GEN_114); // @[AecTranscendental.scala 251:18 266:33]
  wire [47:0] _GEN_117 = 5'hd == state ? $signed(accumulator) : $signed(_GEN_115); // @[AecTranscendental.scala 251:18 266:57]
  wire [47:0] _GEN_118 = 5'hb == state ? $signed(term) : $signed(_GEN_116); // @[AecTranscendental.scala 251:18 265:32]
  wire [47:0] _GEN_119 = 5'hb == state ? $signed(term) : $signed(_GEN_117); // @[AecTranscendental.scala 251:18 265:51]
  wire [47:0] _GEN_120 = 5'ha == state ? $signed(_multiplyA_T_4) : $signed(_GEN_118); // @[AecTranscendental.scala 251:18 264:27]
  wire [47:0] _GEN_121 = 5'ha == state ? $signed(accumulator) : $signed(_GEN_119); // @[AecTranscendental.scala 251:18 264:55]
  wire [47:0] _GEN_122 = 5'h9 == state ? $signed(accumulator) : $signed(_GEN_120); // @[AecTranscendental.scala 251:18 263:38]
  wire [47:0] _GEN_123 = 5'h9 == state ? $signed(auxiliary) : $signed(_GEN_121); // @[AecTranscendental.scala 251:18 263:64]
  wire [47:0] _GEN_124 = 5'h8 == state ? $signed(denominator) : $signed(_GEN_122); // @[AecTranscendental.scala 251:18 262:35]
  wire [47:0] _GEN_125 = 5'h8 == state ? $signed(accumulator) : $signed(_GEN_123); // @[AecTranscendental.scala 251:18 262:61]
  wire [47:0] _GEN_126 = 5'h7 == state ? $signed(term) : $signed(_GEN_124); // @[AecTranscendental.scala 251:18 261:31]
  wire [47:0] _GEN_127 = 5'h7 == state ? $signed(48'sh2c5c85fdf) : $signed(_GEN_125); // @[AecTranscendental.scala 251:18 261:50]
  wire [47:0] _GEN_128 = 5'h6 == state ? $signed(term) : $signed(_GEN_126); // @[AecTranscendental.scala 251:18 260:35]
  wire [47:0] _GEN_129 = 5'h6 == state ? $signed(accumulator) : $signed(_GEN_127); // @[AecTranscendental.scala 251:18 260:54]
  wire [47:0] _GEN_130 = 5'h5 == state ? $signed(argument2) : $signed(_GEN_128); // @[AecTranscendental.scala 251:18 259:32]
  wire [47:0] _GEN_131 = 5'h5 == state ? $signed(accumulator) : $signed(_GEN_129); // @[AecTranscendental.scala 251:18 259:56]
  wire [47:0] _GEN_132 = 5'h4 == state ? $signed(_multiplyA_T_1) : $signed(_GEN_130); // @[AecTranscendental.scala 251:18 256:17]
  wire [47:0] _GEN_133 = 5'h4 == state ? $signed(accumulator) : $signed(_GEN_131); // @[AecTranscendental.scala 251:18 257:17]
  wire [47:0] _GEN_134 = 5'h3 == state ? $signed(term) : $signed(_GEN_132); // @[AecTranscendental.scala 251:18 254:29]
  wire [47:0] _GEN_135 = 5'h3 == state ? $signed(term) : $signed(_GEN_133); // @[AecTranscendental.scala 251:18 254:48]
  wire [47:0] _GEN_136 = 5'h2 == state ? $signed(auxiliary) : $signed(_GEN_134); // @[AecTranscendental.scala 251:18 253:33]
  wire [47:0] _GEN_137 = 5'h2 == state ? $signed(48'sh6487ed511) : $signed(_GEN_135); // @[AecTranscendental.scala 251:18 253:57]
  wire [47:0] _GEN_138 = 5'h1 == state ? $signed(x) : $signed(_GEN_136); // @[AecTranscendental.scala 251:18 252:32]
  wire [47:0] _GEN_139 = 5'h1 == state ? $signed(48'sh28be60db9) : $signed(_GEN_137); // @[AecTranscendental.scala 251:18 252:48]
  wire [47:0] _auxiliary_T_3 = 48'sh800000000 - $signed(multiplyResult); // @[AecTranscendental.scala 273:25]
  wire [47:0] _GEN_140 = _multiplyState_T_13 & multiplier_io_resp_valid ? $signed(denominator) : $signed(_GEN_138); // @[AecTranscendental.scala 271:50 272:15]
  wire [47:0] _GEN_141 = _multiplyState_T_13 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_139); // @[AecTranscendental.scala 271:50 272:41]
  wire [4:0] _GEN_143 = _multiplyState_T_13 & multiplier_io_resp_valid ? 5'h9 : _GEN_108; // @[AecTranscendental.scala 271:50 274:11]
  wire [4:0] _GEN_144 = step == 4'h2 ? 5'ha : 5'h8; // @[AecTranscendental.scala 279:{25,33,81}]
  wire [3:0] _GEN_145 = step == 4'h2 ? _GEN_109 : _step_T_1; // @[AecTranscendental.scala 279:{25,60}]
  wire [47:0] _GEN_146 = _multiplyState_T_15 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_140); // @[AecTranscendental.scala 276:53 277:15]
  wire [47:0] _GEN_147 = _multiplyState_T_15 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_141); // @[AecTranscendental.scala 276:53 277:41]
  wire [4:0] _GEN_149 = _multiplyState_T_15 & multiplier_io_resp_valid ? _GEN_144 : _GEN_143; // @[AecTranscendental.scala 276:53]
  wire [3:0] _GEN_150 = _multiplyState_T_15 & multiplier_io_resp_valid ? _GEN_145 : _GEN_109; // @[AecTranscendental.scala 276:53]
  wire [47:0] _GEN_151 = _multiplyState_T_17 & multiplier_io_resp_valid ? $signed(_multiplyA_T_4) : $signed(_GEN_146); // @[AecTranscendental.scala 281:42 282:15]
  wire [47:0] _GEN_152 = _multiplyState_T_17 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_147); // @[AecTranscendental.scala 281:42 282:43]
  wire [4:0] _GEN_154 = _multiplyState_T_17 & multiplier_io_resp_valid ? 5'hb : _GEN_149; // @[AecTranscendental.scala 281:42 284:11]
  wire [47:0] _GEN_155 = _multiplyState_T_19 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_151); // @[AecTranscendental.scala 286:47 287:15]
  wire [47:0] _GEN_156 = _multiplyState_T_19 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_152); // @[AecTranscendental.scala 286:47 287:34]
  wire [3:0] _GEN_159 = _multiplyState_T_19 & multiplier_io_resp_valid ? 4'h0 : _GEN_150; // @[AecTranscendental.scala 286:47 290:10]
  wire [4:0] _GEN_160 = _multiplyState_T_19 & multiplier_io_resp_valid ? 5'hd : _GEN_154; // @[AecTranscendental.scala 286:47 291:11]
  wire [47:0] _coefficient_T_20 = 4'h0 == step ? $signed(48'sh5d1745d1) : $signed(48'sh155555555); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_22 = 4'h1 == step ? $signed(48'sh71c71c72) : $signed(_coefficient_T_20); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_24 = 4'h2 == step ? $signed(48'sh92492492) : $signed(_coefficient_T_22); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_26 = 4'h3 == step ? $signed(48'shcccccccd) : $signed(_coefficient_T_24); // @[Mux.scala 81:58]
  wire [47:0] coefficient_1 = 4'h4 == step ? $signed(48'sh155555555) : $signed(_coefficient_T_26); // @[Mux.scala 81:58]
  wire [47:0] _accumulator_T_19 = $signed(coefficient_1) + $signed(multiplyResult); // @[AecTranscendental.scala 297:32]
  wire [4:0] _GEN_161 = step == 4'h4 ? 5'hc : _GEN_160; // @[AecTranscendental.scala 298:{25,33}]
  wire [47:0] _GEN_163 = _multiplyState_T_21 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_155); // @[AecTranscendental.scala 293:48 294:15]
  wire [47:0] _GEN_164 = _multiplyState_T_21 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_156); // @[AecTranscendental.scala 293:48 294:39]
  wire [4:0] _GEN_166 = _multiplyState_T_21 & multiplier_io_resp_valid ? _GEN_161 : _GEN_160; // @[AecTranscendental.scala 293:48]
  wire [47:0] _GEN_168 = _multiplyState_T_23 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_163); // @[AecTranscendental.scala 300:43 301:15]
  wire [47:0] _GEN_169 = _multiplyState_T_23 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_164); // @[AecTranscendental.scala 300:43 301:34]
  wire [4:0] _GEN_171 = _multiplyState_T_23 & multiplier_io_resp_valid ? 5'he : _GEN_166; // @[AecTranscendental.scala 300:43 303:11]
  wire [47:0] _auxiliary_T_6 = $signed(term) + $signed(multiplyResult); // @[AecTranscendental.scala 307:23]
  wire [47:0] _GEN_172 = _multiplyState_T_25 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_168); // @[AecTranscendental.scala 305:46 306:15]
  wire [47:0] _GEN_173 = _multiplyState_T_25 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_169); // @[AecTranscendental.scala 305:46 306:39]
  wire [45:0] _result_T_48 = {$signed(exponentScale), 34'h0}; // @[AecTranscendental.scala 312:38]
  wire [47:0] _GEN_218 = {{2{_result_T_48[45]}},_result_T_48}; // @[AecTranscendental.scala 312:44]
  wire [47:0] result_bounded_3 = $signed(_GEN_218) + $signed(multiplyResult); // @[AecTranscendental.scala 312:44]
  wire  result_negative_3 = $signed(result_bounded_3) < 48'sh0; // @[AecTranscendental.scala 122:28]
  wire [47:0] _result_magnitude_T_14 = 48'sh0 - $signed(result_bounded_3); // @[AecTranscendental.scala 123:35]
  wire [47:0] result_magnitude_3 = result_negative_3 ? $signed(_result_magnitude_T_14) : $signed(result_bounded_3); // @[AecTranscendental.scala 123:54]
  wire [31:0] _GEN_219 = {{16'd0}, result_magnitude_3[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_559 = _GEN_219 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_561 = {result_magnitude_3[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_563 = _result_leading_T_561 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_564 = _result_leading_T_559 | _result_leading_T_563; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_220 = {{8'd0}, _result_leading_T_564[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_569 = _GEN_220 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_571 = {_result_leading_T_564[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_573 = _result_leading_T_571 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_574 = _result_leading_T_569 | _result_leading_T_573; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_221 = {{4'd0}, _result_leading_T_574[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_579 = _GEN_221 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_581 = {_result_leading_T_574[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_583 = _result_leading_T_581 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_584 = _result_leading_T_579 | _result_leading_T_583; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_222 = {{2'd0}, _result_leading_T_584[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_589 = _GEN_222 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_591 = {_result_leading_T_584[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_593 = _result_leading_T_591 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_594 = _result_leading_T_589 | _result_leading_T_593; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_223 = {{1'd0}, _result_leading_T_594[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_599 = _GEN_223 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _result_leading_T_601 = {_result_leading_T_594[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _result_leading_T_603 = _result_leading_T_601 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _result_leading_T_604 = _result_leading_T_599 | _result_leading_T_603; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_224 = {{8'd0}, result_magnitude_3[47:40]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_609 = _GEN_224 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_611 = {result_magnitude_3[39:32], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_613 = _result_leading_T_611 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_614 = _result_leading_T_609 | _result_leading_T_613; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_225 = {{4'd0}, _result_leading_T_614[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_619 = _GEN_225 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_621 = {_result_leading_T_614[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_623 = _result_leading_T_621 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_624 = _result_leading_T_619 | _result_leading_T_623; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_226 = {{2'd0}, _result_leading_T_624[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_629 = _GEN_226 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_631 = {_result_leading_T_624[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_633 = _result_leading_T_631 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_634 = _result_leading_T_629 | _result_leading_T_633; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_227 = {{1'd0}, _result_leading_T_634[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_639 = _GEN_227 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _result_leading_T_641 = {_result_leading_T_634[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _result_leading_T_643 = _result_leading_T_641 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _result_leading_T_644 = _result_leading_T_639 | _result_leading_T_643; // @[Bitwise.scala 108:39]
  wire [47:0] _result_leading_T_645 = {_result_leading_T_604,_result_leading_T_644}; // @[Cat.scala 33:92]
  wire [5:0] _result_leading_T_694 = _result_leading_T_645[46] ? 6'h2e : 6'h2f; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_695 = _result_leading_T_645[45] ? 6'h2d : _result_leading_T_694; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_696 = _result_leading_T_645[44] ? 6'h2c : _result_leading_T_695; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_697 = _result_leading_T_645[43] ? 6'h2b : _result_leading_T_696; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_698 = _result_leading_T_645[42] ? 6'h2a : _result_leading_T_697; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_699 = _result_leading_T_645[41] ? 6'h29 : _result_leading_T_698; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_700 = _result_leading_T_645[40] ? 6'h28 : _result_leading_T_699; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_701 = _result_leading_T_645[39] ? 6'h27 : _result_leading_T_700; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_702 = _result_leading_T_645[38] ? 6'h26 : _result_leading_T_701; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_703 = _result_leading_T_645[37] ? 6'h25 : _result_leading_T_702; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_704 = _result_leading_T_645[36] ? 6'h24 : _result_leading_T_703; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_705 = _result_leading_T_645[35] ? 6'h23 : _result_leading_T_704; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_706 = _result_leading_T_645[34] ? 6'h22 : _result_leading_T_705; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_707 = _result_leading_T_645[33] ? 6'h21 : _result_leading_T_706; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_708 = _result_leading_T_645[32] ? 6'h20 : _result_leading_T_707; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_709 = _result_leading_T_645[31] ? 6'h1f : _result_leading_T_708; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_710 = _result_leading_T_645[30] ? 6'h1e : _result_leading_T_709; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_711 = _result_leading_T_645[29] ? 6'h1d : _result_leading_T_710; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_712 = _result_leading_T_645[28] ? 6'h1c : _result_leading_T_711; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_713 = _result_leading_T_645[27] ? 6'h1b : _result_leading_T_712; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_714 = _result_leading_T_645[26] ? 6'h1a : _result_leading_T_713; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_715 = _result_leading_T_645[25] ? 6'h19 : _result_leading_T_714; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_716 = _result_leading_T_645[24] ? 6'h18 : _result_leading_T_715; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_717 = _result_leading_T_645[23] ? 6'h17 : _result_leading_T_716; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_718 = _result_leading_T_645[22] ? 6'h16 : _result_leading_T_717; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_719 = _result_leading_T_645[21] ? 6'h15 : _result_leading_T_718; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_720 = _result_leading_T_645[20] ? 6'h14 : _result_leading_T_719; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_721 = _result_leading_T_645[19] ? 6'h13 : _result_leading_T_720; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_722 = _result_leading_T_645[18] ? 6'h12 : _result_leading_T_721; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_723 = _result_leading_T_645[17] ? 6'h11 : _result_leading_T_722; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_724 = _result_leading_T_645[16] ? 6'h10 : _result_leading_T_723; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_725 = _result_leading_T_645[15] ? 6'hf : _result_leading_T_724; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_726 = _result_leading_T_645[14] ? 6'he : _result_leading_T_725; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_727 = _result_leading_T_645[13] ? 6'hd : _result_leading_T_726; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_728 = _result_leading_T_645[12] ? 6'hc : _result_leading_T_727; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_729 = _result_leading_T_645[11] ? 6'hb : _result_leading_T_728; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_730 = _result_leading_T_645[10] ? 6'ha : _result_leading_T_729; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_731 = _result_leading_T_645[9] ? 6'h9 : _result_leading_T_730; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_732 = _result_leading_T_645[8] ? 6'h8 : _result_leading_T_731; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_733 = _result_leading_T_645[7] ? 6'h7 : _result_leading_T_732; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_734 = _result_leading_T_645[6] ? 6'h6 : _result_leading_T_733; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_735 = _result_leading_T_645[5] ? 6'h5 : _result_leading_T_734; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_736 = _result_leading_T_645[4] ? 6'h4 : _result_leading_T_735; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_737 = _result_leading_T_645[3] ? 6'h3 : _result_leading_T_736; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_738 = _result_leading_T_645[2] ? 6'h2 : _result_leading_T_737; // @[Mux.scala 47:70]
  wire [5:0] _result_leading_T_739 = _result_leading_T_645[1] ? 6'h1 : _result_leading_T_738; // @[Mux.scala 47:70]
  wire [5:0] result_leading_3 = _result_leading_T_645[0] ? 6'h0 : _result_leading_T_739; // @[Mux.scala 47:70]
  wire [5:0] result_msb_3 = 6'h2f - result_leading_3; // @[AecTranscendental.scala 125:20]
  wire  _result_right_T_9 = result_msb_3 > 6'h17; // @[AecTranscendental.scala 126:25]
  wire [5:0] _result_right_T_11 = result_msb_3 - 6'h17; // @[AecTranscendental.scala 126:37]
  wire [5:0] result_right_3 = result_msb_3 > 6'h17 ? _result_right_T_11 : 6'h0; // @[AecTranscendental.scala 126:20]
  wire [5:0] _result_left_T_11 = 6'h17 - result_msb_3; // @[AecTranscendental.scala 127:37]
  wire [5:0] result_left_3 = result_msb_3 < 6'h17 ? _result_left_T_11 : 6'h0; // @[AecTranscendental.scala 127:19]
  wire [47:0] _result_normalized_T_10 = result_magnitude_3 >> result_right_3; // @[AecTranscendental.scala 128:48]
  wire [110:0] _GEN_31 = {{63'd0}, result_magnitude_3}; // @[AecTranscendental.scala 128:68]
  wire [110:0] _result_normalized_T_11 = _GEN_31 << result_left_3; // @[AecTranscendental.scala 128:68]
  wire [110:0] result_normalized_3 = _result_right_T_9 ? {{63'd0}, _result_normalized_T_10} : _result_normalized_T_11; // @[AecTranscendental.scala 128:25]
  wire [5:0] _result_guard_T_17 = result_right_3 - 6'h1; // @[AecTranscendental.scala 129:53]
  wire [47:0] _result_guard_T_18 = result_magnitude_3 >> _result_guard_T_17; // @[AecTranscendental.scala 129:43]
  wire  result_guard_3 = |result_right_3 & _result_guard_T_18[0]; // @[AecTranscendental.scala 129:20]
  wire [110:0] _result_stickyMask_T_21 = 111'h1 << _result_guard_T_17; // @[AecTranscendental.scala 130:50]
  wire [110:0] _result_stickyMask_T_23 = _result_stickyMask_T_21 - 111'h1; // @[AecTranscendental.scala 130:68]
  wire [110:0] result_stickyMask_3 = result_right_3 > 6'h1 ? _result_stickyMask_T_23 : 111'h0; // @[AecTranscendental.scala 130:25]
  wire [110:0] _GEN_228 = {{63'd0}, result_magnitude_3}; // @[AecTranscendental.scala 131:29]
  wire [110:0] _result_sticky_T_3 = _GEN_228 & result_stickyMask_3; // @[AecTranscendental.scala 131:29]
  wire  result_sticky_3 = |_result_sticky_T_3; // @[AecTranscendental.scala 131:43]
  wire  _result_rounded_T_18 = result_guard_3 & (result_sticky_3 | result_normalized_3[0]); // @[AecTranscendental.scala 132:46]
  wire [24:0] _GEN_229 = {{24'd0}, _result_rounded_T_18}; // @[AecTranscendental.scala 132:37]
  wire [24:0] result_rounded_3 = result_normalized_3[24:0] + _GEN_229; // @[AecTranscendental.scala 132:37]
  wire  result_carry_3 = result_rounded_3[24]; // @[AecTranscendental.scala 133:24]
  wire [23:0] result_significand24_3 = result_carry_3 ? result_rounded_3[24:1] : result_rounded_3[23:0]; // @[AecTranscendental.scala 134:28]
  wire [11:0] _result_biased_T_46 = {6'h0,result_msb_3}; // @[AecTranscendental.scala 135:37]
  wire [11:0] _result_biased_T_49 = $signed(_result_biased_T_46) - 12'sh22; // @[AecTranscendental.scala 135:44]
  wire [11:0] _result_biased_T_52 = $signed(_result_biased_T_49) + 12'sh7f; // @[AecTranscendental.scala 135:56]
  wire [12:0] _result_biased_T_53 = {{1{_result_biased_T_52[11]}},_result_biased_T_52}; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_55 = _result_biased_T_53[11:0]; // @[AecTranscendental.scala 135:70]
  wire [11:0] _result_biased_T_57 = {11'h0,result_carry_3}; // @[AecTranscendental.scala 135:102]
  wire [11:0] result_biased_3 = $signed(_result_biased_T_55) + $signed(_result_biased_T_57); // @[AecTranscendental.scala 135:78]
  wire [11:0] _result_normal_T_9 = $signed(_result_biased_T_55) + $signed(_result_biased_T_57); // @[AecTranscendental.scala 136:39]
  wire [31:0] result_normal_3 = {result_negative_3,_result_normal_T_9[7:0],result_significand24_3[22:0]}; // @[Cat.scala 33:92]
  wire [11:0] result_subShift_3 = 12'sh1 - $signed(result_biased_3); // @[AecTranscendental.scala 137:35]
  wire [23:0] _result_subnormal_T_3 = result_significand24_3 >> result_subShift_3; // @[AecTranscendental.scala 138:59]
  wire [32:0] result_subnormal_3 = {result_negative_3,8'h0,_result_subnormal_T_3}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_54 = {result_negative_3,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _result_T_56 = {result_negative_3,31'h7f800000}; // @[Cat.scala 33:92]
  wire [32:0] _result_T_60 = $signed(result_biased_3) < -12'sh17 ? {{1'd0}, _result_T_54} : result_subnormal_3; // @[AecTranscendental.scala 141:31]
  wire [32:0] _result_T_61 = $signed(result_biased_3) <= 12'sh0 ? _result_T_60 : {{1'd0}, result_normal_3}; // @[AecTranscendental.scala 141:12]
  wire [32:0] _result_T_62 = $signed(result_biased_3) >= 12'shff ? {{1'd0}, _result_T_56} : _result_T_61; // @[AecTranscendental.scala 140:10]
  wire [32:0] _result_T_63 = ~(|result_magnitude_3) ? {{1'd0}, _result_T_54} : _result_T_62; // @[AecTranscendental.scala 139:8]
  wire [32:0] _GEN_178 = _multiplyState_T_27 & multiplier_io_resp_valid ? _result_T_63 : _GEN_107; // @[AecTranscendental.scala 310:46 312:12]
  wire  _T_88 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [32:0] _GEN_231 = reset ? 33'h0 : _GEN_178; // @[AecTranscendental.scala 86:{23,23}]
  AecTransMultiplier multiplier ( // @[AecTranscendental.scala 91:26]
    .clock(multiplier_clock),
    .reset(multiplier_reset),
    .io_req_ready(multiplier_io_req_ready),
    .io_req_valid(multiplier_io_req_valid),
    .io_req_bits_a(multiplier_io_req_bits_a),
    .io_req_bits_b(multiplier_io_req_bits_b),
    .io_resp_ready(multiplier_io_resp_ready),
    .io_resp_valid(multiplier_io_resp_valid),
    .io_resp_bits(multiplier_io_resp_bits)
  );
  assign io_req_ready = state == 5'h0; // @[AecTranscendental.scala 144:25]
  assign io_resp_valid = state == 5'h10; // @[AecTranscendental.scala 145:26]
  assign io_resp_bits = result; // @[AecTranscendental.scala 146:16]
  assign multiplier_clock = clock;
  assign multiplier_reset = reset;
  assign multiplier_io_req_valid = _multiplyState_T_24 | state == 5'he | state == 5'hf; // @[AecTranscendental.scala 95:43]
  assign multiplier_io_req_bits_a = _multiplyState_T_27 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(
    _GEN_172); // @[AecTranscendental.scala 310:46 311:15]
  assign multiplier_io_req_bits_b = _multiplyState_T_27 & multiplier_io_resp_valid ? $signed(48'shb8aa3b296) : $signed(
    _GEN_173); // @[AecTranscendental.scala 310:46 311:39]
  assign multiplier_io_resp_ready = _multiplyState_T_24 | state == 5'he | state == 5'hf; // @[AecTranscendental.scala 95:43]
  always @(posedge clock) begin
    if (reset) begin // @[AecTranscendental.scala 74:22]
      state <= 5'h0; // @[AecTranscendental.scala 74:22]
    end else if (_T_88) begin // @[AecTranscendental.scala 316:23]
      state <= 5'h0; // @[AecTranscendental.scala 316:31]
    end else if (_multiplyState_T_27 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 310:46]
      state <= 5'h10; // @[AecTranscendental.scala 313:11]
    end else if (_multiplyState_T_25 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 305:46]
      state <= 5'hf; // @[AecTranscendental.scala 308:11]
    end else begin
      state <= _GEN_171;
    end
    if (_T_8) begin // @[AecTranscendental.scala 149:22]
      op <= io_req_bits_op; // @[AecTranscendental.scala 150:8]
    end
    if (_T_8) begin // @[AecTranscendental.scala 149:22]
      if (inputSign) begin // @[AecTranscendental.scala 115:19]
        x <= _inputQ_T_3;
      end else begin
        x <= _inputQ_T;
      end
    end
    if (_multiplyState_T_17 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 281:42]
      term <= multiplyResult; // @[AecTranscendental.scala 283:10]
    end else if (_multiplyState_T_11 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 229:46]
      term <= multiplyResult; // @[AecTranscendental.scala 231:10]
    end else if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 191:48]
      term <= _term_T_9; // @[AecTranscendental.scala 193:10]
    end else if (_T_8) begin // @[AecTranscendental.scala 149:22]
      term <= _GEN_47;
    end
    if (_multiplyState_T_19 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 286:47]
      argument2 <= multiplyResult; // @[AecTranscendental.scala 288:15]
    end else if (_multiplyState_T_3 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 199:44]
      argument2 <= multiplyResult; // @[AecTranscendental.scala 201:15]
    end
    if (_multiplyState_T_21 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 293:48]
      accumulator <= _accumulator_T_19; // @[AecTranscendental.scala 297:17]
    end else if (_multiplyState_T_19 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 286:47]
      accumulator <= 48'sh4ec4ec4f; // @[AecTranscendental.scala 289:17]
    end else if (_multiplyState_T_15 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 276:53]
      accumulator <= multiplyResult; // @[AecTranscendental.scala 278:17]
    end else if (_multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 239:57]
      accumulator <= _accumulator_T_16; // @[AecTranscendental.scala 245:17]
    end else begin
      accumulator <= _GEN_97;
    end
    if (_multiplyState_T_25 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 305:46]
      auxiliary <= _auxiliary_T_6; // @[AecTranscendental.scala 307:15]
    end else if (_multiplyState_T_23 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 300:43]
      auxiliary <= multiplyResult; // @[AecTranscendental.scala 302:15]
    end else if (_multiplyState_T_13 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 271:50]
      auxiliary <= _auxiliary_T_3; // @[AecTranscendental.scala 273:15]
    end else if (_multiplyState_T & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 183:47]
      auxiliary <= _auxiliary_T; // @[AecTranscendental.scala 188:15]
    end
    exponentScale <= _GEN_55[11:0];
    if (reset) begin // @[AecTranscendental.scala 82:21]
      step <= 4'h0; // @[AecTranscendental.scala 82:21]
    end else if (_multiplyState_T_21 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 293:48]
      if (step == 4'h4) begin // @[AecTranscendental.scala 298:25]
        step <= _GEN_159;
      end else begin
        step <= _step_T_1; // @[AecTranscendental.scala 298:61]
      end
    end else begin
      step <= _GEN_159;
    end
    if (_multiplyState_T & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 183:47]
      quadrant <= _quadrant_T[1:0]; // @[AecTranscendental.scala 187:14]
    end
    if (_multiplyState_T_11 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 229:46]
      polynomialCos <= 1'h0; // @[AecTranscendental.scala 235:19]
    end else if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 191:48]
      if (op == 16'h72) begin // @[AecTranscendental.scala 195:25]
        polynomialCos <= odd;
      end else begin
        polynomialCos <= ~odd;
      end
    end
    if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 191:48]
      if (_polynomialCos_T) begin // @[AecTranscendental.scala 196:24]
        negateResult <= quadrant[1];
      end else begin
        negateResult <= quadrant[1] ^ odd;
      end
    end
    result <= _GEN_231[31:0]; // @[AecTranscendental.scala 86:{23,23}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  op = _RAND_1[15:0];
  _RAND_2 = {2{`RANDOM}};
  x = _RAND_2[47:0];
  _RAND_3 = {2{`RANDOM}};
  term = _RAND_3[47:0];
  _RAND_4 = {2{`RANDOM}};
  argument2 = _RAND_4[47:0];
  _RAND_5 = {2{`RANDOM}};
  accumulator = _RAND_5[47:0];
  _RAND_6 = {2{`RANDOM}};
  auxiliary = _RAND_6[47:0];
  _RAND_7 = {1{`RANDOM}};
  exponentScale = _RAND_7[11:0];
  _RAND_8 = {1{`RANDOM}};
  step = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  quadrant = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  polynomialCos = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  negateResult = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  result = _RAND_12[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AESSFU(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [15:0] io_req_bits_op,
  input  [3:0]  io_req_bits_dtype,
  input  [63:0] io_req_bits_a,
  input  [63:0] io_req_bits_b,
  input         io_resp_ready,
  output        io_resp_valid,
  output [63:0] io_resp_bits_result,
  output        io_resp_bits_error,
  output [4:0]  io_resp_bits_exceptionFlags
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire  intDiv_clock; // @[AESSFU.scala 41:22]
  wire  intDiv_reset; // @[AESSFU.scala 41:22]
  wire  intDiv_io_req_ready; // @[AESSFU.scala 41:22]
  wire  intDiv_io_req_valid; // @[AESSFU.scala 41:22]
  wire [31:0] intDiv_io_req_bits_dividend; // @[AESSFU.scala 41:22]
  wire [31:0] intDiv_io_req_bits_divisor; // @[AESSFU.scala 41:22]
  wire  intDiv_io_req_bits_signed; // @[AESSFU.scala 41:22]
  wire  intDiv_io_resp_ready; // @[AESSFU.scala 41:22]
  wire  intDiv_io_resp_valid; // @[AESSFU.scala 41:22]
  wire [31:0] intDiv_io_resp_bits_quotient; // @[AESSFU.scala 41:22]
  wire  intDiv_io_resp_bits_error; // @[AESSFU.scala 41:22]
  wire [32:0] widenA_io_in; // @[AESSFU.scala 60:22]
  wire [64:0] widenA_io_out; // @[AESSFU.scala 60:22]
  wire [32:0] widenB_io_in; // @[AESSFU.scala 61:22]
  wire [64:0] widenB_io_out; // @[AESSFU.scala 61:22]
  wire  divSqrt_clock; // @[AESSFU.scala 69:23]
  wire  divSqrt_reset; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_inReady; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_inValid; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_sqrtOp; // @[AESSFU.scala 69:23]
  wire [64:0] divSqrt_io_a; // @[AESSFU.scala 69:23]
  wire [64:0] divSqrt_io_b; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOutValid_div; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOutValid_sqrt; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_invalidExc; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_infiniteExc; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOut_isNaN; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOut_isInf; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOut_isZero; // @[AESSFU.scala 69:23]
  wire  divSqrt_io_rawOut_sign; // @[AESSFU.scala 69:23]
  wire [12:0] divSqrt_io_rawOut_sExp; // @[AESSFU.scala 69:23]
  wire [55:0] divSqrt_io_rawOut_sig; // @[AESSFU.scala 69:23]
  wire  round32_io_invalidExc; // @[AESSFU.scala 77:23]
  wire  round32_io_infiniteExc; // @[AESSFU.scala 77:23]
  wire  round32_io_in_isNaN; // @[AESSFU.scala 77:23]
  wire  round32_io_in_isInf; // @[AESSFU.scala 77:23]
  wire  round32_io_in_isZero; // @[AESSFU.scala 77:23]
  wire  round32_io_in_sign; // @[AESSFU.scala 77:23]
  wire [12:0] round32_io_in_sExp; // @[AESSFU.scala 77:23]
  wire [55:0] round32_io_in_sig; // @[AESSFU.scala 77:23]
  wire [32:0] round32_io_out; // @[AESSFU.scala 77:23]
  wire [4:0] round32_io_exceptionFlags; // @[AESSFU.scala 77:23]
  wire  round64_io_invalidExc; // @[AESSFU.scala 84:23]
  wire  round64_io_infiniteExc; // @[AESSFU.scala 84:23]
  wire  round64_io_in_isNaN; // @[AESSFU.scala 84:23]
  wire  round64_io_in_isInf; // @[AESSFU.scala 84:23]
  wire  round64_io_in_isZero; // @[AESSFU.scala 84:23]
  wire  round64_io_in_sign; // @[AESSFU.scala 84:23]
  wire [12:0] round64_io_in_sExp; // @[AESSFU.scala 84:23]
  wire [55:0] round64_io_in_sig; // @[AESSFU.scala 84:23]
  wire [64:0] round64_io_out; // @[AESSFU.scala 84:23]
  wire [4:0] round64_io_exceptionFlags; // @[AESSFU.scala 84:23]
  wire  trans_clock; // @[AESSFU.scala 91:21]
  wire  trans_reset; // @[AESSFU.scala 91:21]
  wire  trans_io_req_ready; // @[AESSFU.scala 91:21]
  wire  trans_io_req_valid; // @[AESSFU.scala 91:21]
  wire [15:0] trans_io_req_bits_op; // @[AESSFU.scala 91:21]
  wire [31:0] trans_io_req_bits_in; // @[AESSFU.scala 91:21]
  wire  trans_io_resp_ready; // @[AESSFU.scala 91:21]
  wire  trans_io_resp_valid; // @[AESSFU.scala 91:21]
  wire [31:0] trans_io_resp_bits; // @[AESSFU.scala 91:21]
  reg [3:0] state; // @[AESSFU.scala 34:22]
  reg [15:0] held_op; // @[AESSFU.scala 35:17]
  reg [3:0] held_dtype; // @[AESSFU.scala 35:17]
  reg [63:0] held_a; // @[AESSFU.scala 35:17]
  reg [63:0] held_b; // @[AESSFU.scala 35:17]
  reg [63:0] result; // @[AESSFU.scala 36:23]
  reg [4:0] flags; // @[AESSFU.scala 37:22]
  reg  error; // @[AESSFU.scala 38:22]
  reg [31:0] rsqRoot; // @[AESSFU.scala 39:20]
  wire  _intDiv_io_req_valid_T = state == 4'h1; // @[AESSFU.scala 45:32]
  wire  isRcp = held_op == 16'h70; // @[AESSFU.scala 51:23]
  wire  isRsq = held_op == 16'h71; // @[AESSFU.scala 52:23]
  wire  _isSqrt_T_1 = state == 4'h3; // @[AESSFU.scala 53:62]
  wire  isSqrt = held_op == 16'h76 | isRsq & state == 4'h3; // @[AESSFU.scala 53:43]
  wire  _useRsqDivision_T = state == 4'h5; // @[AESSFU.scala 54:30]
  wire  _useRsqDivision_T_1 = state == 4'h6; // @[AESSFU.scala 54:55]
  wire  useRsqDivision = state == 4'h5 | state == 4'h6; // @[AESSFU.scala 54:46]
  wire [31:0] fp32A = isRcp | useRsqDivision ? 32'h3f800000 : held_a[31:0]; // @[AESSFU.scala 55:18]
  wire [31:0] _fp32B_T_2 = useRsqDivision ? rsqRoot : held_b[31:0]; // @[AESSFU.scala 56:44]
  wire [31:0] fp32B = isRcp ? held_a[31:0] : _fp32B_T_2; // @[AESSFU.scala 56:18]
  wire  widenA_io_in_rawIn_sign = fp32A[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] widenA_io_in_rawIn_expIn = fp32A[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] widenA_io_in_rawIn_fractIn = fp32A[22:0]; // @[rawFloatFromFN.scala 46:21]
  wire  widenA_io_in_rawIn_isZeroExpIn = widenA_io_in_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 48:30]
  wire  widenA_io_in_rawIn_isZeroFractIn = widenA_io_in_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 49:34]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_23 = widenA_io_in_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_24 = widenA_io_in_rawIn_fractIn[2] ? 5'h14 :
    _widenA_io_in_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_25 = widenA_io_in_rawIn_fractIn[3] ? 5'h13 :
    _widenA_io_in_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_26 = widenA_io_in_rawIn_fractIn[4] ? 5'h12 :
    _widenA_io_in_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_27 = widenA_io_in_rawIn_fractIn[5] ? 5'h11 :
    _widenA_io_in_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_28 = widenA_io_in_rawIn_fractIn[6] ? 5'h10 :
    _widenA_io_in_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_29 = widenA_io_in_rawIn_fractIn[7] ? 5'hf :
    _widenA_io_in_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_30 = widenA_io_in_rawIn_fractIn[8] ? 5'he :
    _widenA_io_in_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_31 = widenA_io_in_rawIn_fractIn[9] ? 5'hd :
    _widenA_io_in_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_32 = widenA_io_in_rawIn_fractIn[10] ? 5'hc :
    _widenA_io_in_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_33 = widenA_io_in_rawIn_fractIn[11] ? 5'hb :
    _widenA_io_in_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_34 = widenA_io_in_rawIn_fractIn[12] ? 5'ha :
    _widenA_io_in_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_35 = widenA_io_in_rawIn_fractIn[13] ? 5'h9 :
    _widenA_io_in_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_36 = widenA_io_in_rawIn_fractIn[14] ? 5'h8 :
    _widenA_io_in_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_37 = widenA_io_in_rawIn_fractIn[15] ? 5'h7 :
    _widenA_io_in_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_38 = widenA_io_in_rawIn_fractIn[16] ? 5'h6 :
    _widenA_io_in_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_39 = widenA_io_in_rawIn_fractIn[17] ? 5'h5 :
    _widenA_io_in_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_40 = widenA_io_in_rawIn_fractIn[18] ? 5'h4 :
    _widenA_io_in_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_41 = widenA_io_in_rawIn_fractIn[19] ? 5'h3 :
    _widenA_io_in_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_42 = widenA_io_in_rawIn_fractIn[20] ? 5'h2 :
    _widenA_io_in_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _widenA_io_in_rawIn_normDist_T_43 = widenA_io_in_rawIn_fractIn[21] ? 5'h1 :
    _widenA_io_in_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] widenA_io_in_rawIn_normDist = widenA_io_in_rawIn_fractIn[22] ? 5'h0 : _widenA_io_in_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_0 = {{31'd0}, widenA_io_in_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _widenA_io_in_rawIn_subnormFract_T = _GEN_0 << widenA_io_in_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] widenA_io_in_rawIn_subnormFract = {_widenA_io_in_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_35 = {{4'd0}, widenA_io_in_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _widenA_io_in_rawIn_adjustedExp_T = _GEN_35 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _widenA_io_in_rawIn_adjustedExp_T_1 = widenA_io_in_rawIn_isZeroExpIn ? _widenA_io_in_rawIn_adjustedExp_T :
    {{1'd0}, widenA_io_in_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _widenA_io_in_rawIn_adjustedExp_T_2 = widenA_io_in_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_36 = {{6'd0}, _widenA_io_in_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _widenA_io_in_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_36; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_37 = {{1'd0}, _widenA_io_in_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] widenA_io_in_rawIn_adjustedExp = _widenA_io_in_rawIn_adjustedExp_T_1 + _GEN_37; // @[rawFloatFromFN.scala 57:9]
  wire  widenA_io_in_rawIn_isZero = widenA_io_in_rawIn_isZeroExpIn & widenA_io_in_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  widenA_io_in_rawIn_isSpecial = widenA_io_in_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  widenA_io_in_rawIn__isNaN = widenA_io_in_rawIn_isSpecial & ~widenA_io_in_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] widenA_io_in_rawIn__sExp = {1'b0,$signed(widenA_io_in_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _widenA_io_in_rawIn_out_sig_T = ~widenA_io_in_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _widenA_io_in_rawIn_out_sig_T_2 = widenA_io_in_rawIn_isZeroExpIn ? widenA_io_in_rawIn_subnormFract :
    widenA_io_in_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] widenA_io_in_rawIn__sig = {1'h0,_widenA_io_in_rawIn_out_sig_T,_widenA_io_in_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _widenA_io_in_T_1 = widenA_io_in_rawIn_isZero ? 3'h0 : widenA_io_in_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_38 = {{2'd0}, widenA_io_in_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _widenA_io_in_T_3 = _widenA_io_in_T_1 | _GEN_38; // @[recFNFromFN.scala 48:76]
  wire [9:0] _widenA_io_in_T_6 = {widenA_io_in_rawIn_sign,_widenA_io_in_T_3,widenA_io_in_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire  widenB_io_in_rawIn_sign = fp32B[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] widenB_io_in_rawIn_expIn = fp32B[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] widenB_io_in_rawIn_fractIn = fp32B[22:0]; // @[rawFloatFromFN.scala 46:21]
  wire  widenB_io_in_rawIn_isZeroExpIn = widenB_io_in_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 48:30]
  wire  widenB_io_in_rawIn_isZeroFractIn = widenB_io_in_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 49:34]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_23 = widenB_io_in_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_24 = widenB_io_in_rawIn_fractIn[2] ? 5'h14 :
    _widenB_io_in_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_25 = widenB_io_in_rawIn_fractIn[3] ? 5'h13 :
    _widenB_io_in_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_26 = widenB_io_in_rawIn_fractIn[4] ? 5'h12 :
    _widenB_io_in_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_27 = widenB_io_in_rawIn_fractIn[5] ? 5'h11 :
    _widenB_io_in_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_28 = widenB_io_in_rawIn_fractIn[6] ? 5'h10 :
    _widenB_io_in_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_29 = widenB_io_in_rawIn_fractIn[7] ? 5'hf :
    _widenB_io_in_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_30 = widenB_io_in_rawIn_fractIn[8] ? 5'he :
    _widenB_io_in_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_31 = widenB_io_in_rawIn_fractIn[9] ? 5'hd :
    _widenB_io_in_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_32 = widenB_io_in_rawIn_fractIn[10] ? 5'hc :
    _widenB_io_in_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_33 = widenB_io_in_rawIn_fractIn[11] ? 5'hb :
    _widenB_io_in_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_34 = widenB_io_in_rawIn_fractIn[12] ? 5'ha :
    _widenB_io_in_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_35 = widenB_io_in_rawIn_fractIn[13] ? 5'h9 :
    _widenB_io_in_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_36 = widenB_io_in_rawIn_fractIn[14] ? 5'h8 :
    _widenB_io_in_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_37 = widenB_io_in_rawIn_fractIn[15] ? 5'h7 :
    _widenB_io_in_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_38 = widenB_io_in_rawIn_fractIn[16] ? 5'h6 :
    _widenB_io_in_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_39 = widenB_io_in_rawIn_fractIn[17] ? 5'h5 :
    _widenB_io_in_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_40 = widenB_io_in_rawIn_fractIn[18] ? 5'h4 :
    _widenB_io_in_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_41 = widenB_io_in_rawIn_fractIn[19] ? 5'h3 :
    _widenB_io_in_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_42 = widenB_io_in_rawIn_fractIn[20] ? 5'h2 :
    _widenB_io_in_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _widenB_io_in_rawIn_normDist_T_43 = widenB_io_in_rawIn_fractIn[21] ? 5'h1 :
    _widenB_io_in_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] widenB_io_in_rawIn_normDist = widenB_io_in_rawIn_fractIn[22] ? 5'h0 : _widenB_io_in_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_1 = {{31'd0}, widenB_io_in_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _widenB_io_in_rawIn_subnormFract_T = _GEN_1 << widenB_io_in_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] widenB_io_in_rawIn_subnormFract = {_widenB_io_in_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_39 = {{4'd0}, widenB_io_in_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _widenB_io_in_rawIn_adjustedExp_T = _GEN_39 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _widenB_io_in_rawIn_adjustedExp_T_1 = widenB_io_in_rawIn_isZeroExpIn ? _widenB_io_in_rawIn_adjustedExp_T :
    {{1'd0}, widenB_io_in_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _widenB_io_in_rawIn_adjustedExp_T_2 = widenB_io_in_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_40 = {{6'd0}, _widenB_io_in_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _widenB_io_in_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_40; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_41 = {{1'd0}, _widenB_io_in_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] widenB_io_in_rawIn_adjustedExp = _widenB_io_in_rawIn_adjustedExp_T_1 + _GEN_41; // @[rawFloatFromFN.scala 57:9]
  wire  widenB_io_in_rawIn_isZero = widenB_io_in_rawIn_isZeroExpIn & widenB_io_in_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  widenB_io_in_rawIn_isSpecial = widenB_io_in_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  widenB_io_in_rawIn__isNaN = widenB_io_in_rawIn_isSpecial & ~widenB_io_in_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] widenB_io_in_rawIn__sExp = {1'b0,$signed(widenB_io_in_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _widenB_io_in_rawIn_out_sig_T = ~widenB_io_in_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _widenB_io_in_rawIn_out_sig_T_2 = widenB_io_in_rawIn_isZeroExpIn ? widenB_io_in_rawIn_subnormFract :
    widenB_io_in_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] widenB_io_in_rawIn__sig = {1'h0,_widenB_io_in_rawIn_out_sig_T,_widenB_io_in_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _widenB_io_in_T_1 = widenB_io_in_rawIn_isZero ? 3'h0 : widenB_io_in_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_42 = {{2'd0}, widenB_io_in_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _widenB_io_in_T_3 = _widenB_io_in_T_1 | _GEN_42; // @[recFNFromFN.scala 48:76]
  wire [9:0] _widenB_io_in_T_6 = {widenB_io_in_rawIn_sign,_widenB_io_in_T_3,widenB_io_in_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire  _divSqrt_io_inValid_T_1 = held_dtype == 4'h8; // @[AESSFU.scala 70:59]
  wire  _divSqrt_io_inValid_T_2 = held_dtype == 4'h9; // @[AESSFU.scala 70:81]
  wire  _divSqrt_io_inValid_T_7 = _useRsqDivision_T & _divSqrt_io_inValid_T_1; // @[AESSFU.scala 71:28]
  wire  divSqrt_io_a_rawIn_sign = held_a[63]; // @[rawFloatFromFN.scala 44:18]
  wire [10:0] divSqrt_io_a_rawIn_expIn = held_a[62:52]; // @[rawFloatFromFN.scala 45:19]
  wire [51:0] divSqrt_io_a_rawIn_fractIn = held_a[51:0]; // @[rawFloatFromFN.scala 46:21]
  wire  divSqrt_io_a_rawIn_isZeroExpIn = divSqrt_io_a_rawIn_expIn == 11'h0; // @[rawFloatFromFN.scala 48:30]
  wire  divSqrt_io_a_rawIn_isZeroFractIn = divSqrt_io_a_rawIn_fractIn == 52'h0; // @[rawFloatFromFN.scala 49:34]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_52 = divSqrt_io_a_rawIn_fractIn[1] ? 6'h32 : 6'h33; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_53 = divSqrt_io_a_rawIn_fractIn[2] ? 6'h31 :
    _divSqrt_io_a_rawIn_normDist_T_52; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_54 = divSqrt_io_a_rawIn_fractIn[3] ? 6'h30 :
    _divSqrt_io_a_rawIn_normDist_T_53; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_55 = divSqrt_io_a_rawIn_fractIn[4] ? 6'h2f :
    _divSqrt_io_a_rawIn_normDist_T_54; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_56 = divSqrt_io_a_rawIn_fractIn[5] ? 6'h2e :
    _divSqrt_io_a_rawIn_normDist_T_55; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_57 = divSqrt_io_a_rawIn_fractIn[6] ? 6'h2d :
    _divSqrt_io_a_rawIn_normDist_T_56; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_58 = divSqrt_io_a_rawIn_fractIn[7] ? 6'h2c :
    _divSqrt_io_a_rawIn_normDist_T_57; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_59 = divSqrt_io_a_rawIn_fractIn[8] ? 6'h2b :
    _divSqrt_io_a_rawIn_normDist_T_58; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_60 = divSqrt_io_a_rawIn_fractIn[9] ? 6'h2a :
    _divSqrt_io_a_rawIn_normDist_T_59; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_61 = divSqrt_io_a_rawIn_fractIn[10] ? 6'h29 :
    _divSqrt_io_a_rawIn_normDist_T_60; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_62 = divSqrt_io_a_rawIn_fractIn[11] ? 6'h28 :
    _divSqrt_io_a_rawIn_normDist_T_61; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_63 = divSqrt_io_a_rawIn_fractIn[12] ? 6'h27 :
    _divSqrt_io_a_rawIn_normDist_T_62; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_64 = divSqrt_io_a_rawIn_fractIn[13] ? 6'h26 :
    _divSqrt_io_a_rawIn_normDist_T_63; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_65 = divSqrt_io_a_rawIn_fractIn[14] ? 6'h25 :
    _divSqrt_io_a_rawIn_normDist_T_64; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_66 = divSqrt_io_a_rawIn_fractIn[15] ? 6'h24 :
    _divSqrt_io_a_rawIn_normDist_T_65; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_67 = divSqrt_io_a_rawIn_fractIn[16] ? 6'h23 :
    _divSqrt_io_a_rawIn_normDist_T_66; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_68 = divSqrt_io_a_rawIn_fractIn[17] ? 6'h22 :
    _divSqrt_io_a_rawIn_normDist_T_67; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_69 = divSqrt_io_a_rawIn_fractIn[18] ? 6'h21 :
    _divSqrt_io_a_rawIn_normDist_T_68; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_70 = divSqrt_io_a_rawIn_fractIn[19] ? 6'h20 :
    _divSqrt_io_a_rawIn_normDist_T_69; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_71 = divSqrt_io_a_rawIn_fractIn[20] ? 6'h1f :
    _divSqrt_io_a_rawIn_normDist_T_70; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_72 = divSqrt_io_a_rawIn_fractIn[21] ? 6'h1e :
    _divSqrt_io_a_rawIn_normDist_T_71; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_73 = divSqrt_io_a_rawIn_fractIn[22] ? 6'h1d :
    _divSqrt_io_a_rawIn_normDist_T_72; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_74 = divSqrt_io_a_rawIn_fractIn[23] ? 6'h1c :
    _divSqrt_io_a_rawIn_normDist_T_73; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_75 = divSqrt_io_a_rawIn_fractIn[24] ? 6'h1b :
    _divSqrt_io_a_rawIn_normDist_T_74; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_76 = divSqrt_io_a_rawIn_fractIn[25] ? 6'h1a :
    _divSqrt_io_a_rawIn_normDist_T_75; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_77 = divSqrt_io_a_rawIn_fractIn[26] ? 6'h19 :
    _divSqrt_io_a_rawIn_normDist_T_76; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_78 = divSqrt_io_a_rawIn_fractIn[27] ? 6'h18 :
    _divSqrt_io_a_rawIn_normDist_T_77; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_79 = divSqrt_io_a_rawIn_fractIn[28] ? 6'h17 :
    _divSqrt_io_a_rawIn_normDist_T_78; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_80 = divSqrt_io_a_rawIn_fractIn[29] ? 6'h16 :
    _divSqrt_io_a_rawIn_normDist_T_79; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_81 = divSqrt_io_a_rawIn_fractIn[30] ? 6'h15 :
    _divSqrt_io_a_rawIn_normDist_T_80; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_82 = divSqrt_io_a_rawIn_fractIn[31] ? 6'h14 :
    _divSqrt_io_a_rawIn_normDist_T_81; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_83 = divSqrt_io_a_rawIn_fractIn[32] ? 6'h13 :
    _divSqrt_io_a_rawIn_normDist_T_82; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_84 = divSqrt_io_a_rawIn_fractIn[33] ? 6'h12 :
    _divSqrt_io_a_rawIn_normDist_T_83; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_85 = divSqrt_io_a_rawIn_fractIn[34] ? 6'h11 :
    _divSqrt_io_a_rawIn_normDist_T_84; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_86 = divSqrt_io_a_rawIn_fractIn[35] ? 6'h10 :
    _divSqrt_io_a_rawIn_normDist_T_85; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_87 = divSqrt_io_a_rawIn_fractIn[36] ? 6'hf :
    _divSqrt_io_a_rawIn_normDist_T_86; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_88 = divSqrt_io_a_rawIn_fractIn[37] ? 6'he :
    _divSqrt_io_a_rawIn_normDist_T_87; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_89 = divSqrt_io_a_rawIn_fractIn[38] ? 6'hd :
    _divSqrt_io_a_rawIn_normDist_T_88; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_90 = divSqrt_io_a_rawIn_fractIn[39] ? 6'hc :
    _divSqrt_io_a_rawIn_normDist_T_89; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_91 = divSqrt_io_a_rawIn_fractIn[40] ? 6'hb :
    _divSqrt_io_a_rawIn_normDist_T_90; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_92 = divSqrt_io_a_rawIn_fractIn[41] ? 6'ha :
    _divSqrt_io_a_rawIn_normDist_T_91; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_93 = divSqrt_io_a_rawIn_fractIn[42] ? 6'h9 :
    _divSqrt_io_a_rawIn_normDist_T_92; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_94 = divSqrt_io_a_rawIn_fractIn[43] ? 6'h8 :
    _divSqrt_io_a_rawIn_normDist_T_93; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_95 = divSqrt_io_a_rawIn_fractIn[44] ? 6'h7 :
    _divSqrt_io_a_rawIn_normDist_T_94; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_96 = divSqrt_io_a_rawIn_fractIn[45] ? 6'h6 :
    _divSqrt_io_a_rawIn_normDist_T_95; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_97 = divSqrt_io_a_rawIn_fractIn[46] ? 6'h5 :
    _divSqrt_io_a_rawIn_normDist_T_96; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_98 = divSqrt_io_a_rawIn_fractIn[47] ? 6'h4 :
    _divSqrt_io_a_rawIn_normDist_T_97; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_99 = divSqrt_io_a_rawIn_fractIn[48] ? 6'h3 :
    _divSqrt_io_a_rawIn_normDist_T_98; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_100 = divSqrt_io_a_rawIn_fractIn[49] ? 6'h2 :
    _divSqrt_io_a_rawIn_normDist_T_99; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_a_rawIn_normDist_T_101 = divSqrt_io_a_rawIn_fractIn[50] ? 6'h1 :
    _divSqrt_io_a_rawIn_normDist_T_100; // @[Mux.scala 47:70]
  wire [5:0] divSqrt_io_a_rawIn_normDist = divSqrt_io_a_rawIn_fractIn[51] ? 6'h0 : _divSqrt_io_a_rawIn_normDist_T_101; // @[Mux.scala 47:70]
  wire [114:0] _GEN_2 = {{63'd0}, divSqrt_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _divSqrt_io_a_rawIn_subnormFract_T = _GEN_2 << divSqrt_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] divSqrt_io_a_rawIn_subnormFract = {_divSqrt_io_a_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_43 = {{6'd0}, divSqrt_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _divSqrt_io_a_rawIn_adjustedExp_T = _GEN_43 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _divSqrt_io_a_rawIn_adjustedExp_T_1 = divSqrt_io_a_rawIn_isZeroExpIn ? _divSqrt_io_a_rawIn_adjustedExp_T
     : {{1'd0}, divSqrt_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _divSqrt_io_a_rawIn_adjustedExp_T_2 = divSqrt_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_44 = {{9'd0}, _divSqrt_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _divSqrt_io_a_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_44; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_45 = {{1'd0}, _divSqrt_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] divSqrt_io_a_rawIn_adjustedExp = _divSqrt_io_a_rawIn_adjustedExp_T_1 + _GEN_45; // @[rawFloatFromFN.scala 57:9]
  wire  divSqrt_io_a_rawIn_isZero = divSqrt_io_a_rawIn_isZeroExpIn & divSqrt_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  divSqrt_io_a_rawIn_isSpecial = divSqrt_io_a_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  divSqrt_io_a_rawIn__isNaN = divSqrt_io_a_rawIn_isSpecial & ~divSqrt_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] divSqrt_io_a_rawIn__sExp = {1'b0,$signed(divSqrt_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _divSqrt_io_a_rawIn_out_sig_T = ~divSqrt_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _divSqrt_io_a_rawIn_out_sig_T_2 = divSqrt_io_a_rawIn_isZeroExpIn ? divSqrt_io_a_rawIn_subnormFract :
    divSqrt_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] divSqrt_io_a_rawIn__sig = {1'h0,_divSqrt_io_a_rawIn_out_sig_T,_divSqrt_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _divSqrt_io_a_T_2 = divSqrt_io_a_rawIn_isZero ? 3'h0 : divSqrt_io_a_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_46 = {{2'd0}, divSqrt_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _divSqrt_io_a_T_4 = _divSqrt_io_a_T_2 | _GEN_46; // @[recFNFromFN.scala 48:76]
  wire [64:0] _divSqrt_io_a_T_9 = {divSqrt_io_a_rawIn_sign,_divSqrt_io_a_T_4,divSqrt_io_a_rawIn__sExp[8:0],
    divSqrt_io_a_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  wire  divSqrt_io_b_rawIn_sign = held_b[63]; // @[rawFloatFromFN.scala 44:18]
  wire [10:0] divSqrt_io_b_rawIn_expIn = held_b[62:52]; // @[rawFloatFromFN.scala 45:19]
  wire [51:0] divSqrt_io_b_rawIn_fractIn = held_b[51:0]; // @[rawFloatFromFN.scala 46:21]
  wire  divSqrt_io_b_rawIn_isZeroExpIn = divSqrt_io_b_rawIn_expIn == 11'h0; // @[rawFloatFromFN.scala 48:30]
  wire  divSqrt_io_b_rawIn_isZeroFractIn = divSqrt_io_b_rawIn_fractIn == 52'h0; // @[rawFloatFromFN.scala 49:34]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_52 = divSqrt_io_b_rawIn_fractIn[1] ? 6'h32 : 6'h33; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_53 = divSqrt_io_b_rawIn_fractIn[2] ? 6'h31 :
    _divSqrt_io_b_rawIn_normDist_T_52; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_54 = divSqrt_io_b_rawIn_fractIn[3] ? 6'h30 :
    _divSqrt_io_b_rawIn_normDist_T_53; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_55 = divSqrt_io_b_rawIn_fractIn[4] ? 6'h2f :
    _divSqrt_io_b_rawIn_normDist_T_54; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_56 = divSqrt_io_b_rawIn_fractIn[5] ? 6'h2e :
    _divSqrt_io_b_rawIn_normDist_T_55; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_57 = divSqrt_io_b_rawIn_fractIn[6] ? 6'h2d :
    _divSqrt_io_b_rawIn_normDist_T_56; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_58 = divSqrt_io_b_rawIn_fractIn[7] ? 6'h2c :
    _divSqrt_io_b_rawIn_normDist_T_57; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_59 = divSqrt_io_b_rawIn_fractIn[8] ? 6'h2b :
    _divSqrt_io_b_rawIn_normDist_T_58; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_60 = divSqrt_io_b_rawIn_fractIn[9] ? 6'h2a :
    _divSqrt_io_b_rawIn_normDist_T_59; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_61 = divSqrt_io_b_rawIn_fractIn[10] ? 6'h29 :
    _divSqrt_io_b_rawIn_normDist_T_60; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_62 = divSqrt_io_b_rawIn_fractIn[11] ? 6'h28 :
    _divSqrt_io_b_rawIn_normDist_T_61; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_63 = divSqrt_io_b_rawIn_fractIn[12] ? 6'h27 :
    _divSqrt_io_b_rawIn_normDist_T_62; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_64 = divSqrt_io_b_rawIn_fractIn[13] ? 6'h26 :
    _divSqrt_io_b_rawIn_normDist_T_63; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_65 = divSqrt_io_b_rawIn_fractIn[14] ? 6'h25 :
    _divSqrt_io_b_rawIn_normDist_T_64; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_66 = divSqrt_io_b_rawIn_fractIn[15] ? 6'h24 :
    _divSqrt_io_b_rawIn_normDist_T_65; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_67 = divSqrt_io_b_rawIn_fractIn[16] ? 6'h23 :
    _divSqrt_io_b_rawIn_normDist_T_66; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_68 = divSqrt_io_b_rawIn_fractIn[17] ? 6'h22 :
    _divSqrt_io_b_rawIn_normDist_T_67; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_69 = divSqrt_io_b_rawIn_fractIn[18] ? 6'h21 :
    _divSqrt_io_b_rawIn_normDist_T_68; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_70 = divSqrt_io_b_rawIn_fractIn[19] ? 6'h20 :
    _divSqrt_io_b_rawIn_normDist_T_69; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_71 = divSqrt_io_b_rawIn_fractIn[20] ? 6'h1f :
    _divSqrt_io_b_rawIn_normDist_T_70; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_72 = divSqrt_io_b_rawIn_fractIn[21] ? 6'h1e :
    _divSqrt_io_b_rawIn_normDist_T_71; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_73 = divSqrt_io_b_rawIn_fractIn[22] ? 6'h1d :
    _divSqrt_io_b_rawIn_normDist_T_72; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_74 = divSqrt_io_b_rawIn_fractIn[23] ? 6'h1c :
    _divSqrt_io_b_rawIn_normDist_T_73; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_75 = divSqrt_io_b_rawIn_fractIn[24] ? 6'h1b :
    _divSqrt_io_b_rawIn_normDist_T_74; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_76 = divSqrt_io_b_rawIn_fractIn[25] ? 6'h1a :
    _divSqrt_io_b_rawIn_normDist_T_75; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_77 = divSqrt_io_b_rawIn_fractIn[26] ? 6'h19 :
    _divSqrt_io_b_rawIn_normDist_T_76; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_78 = divSqrt_io_b_rawIn_fractIn[27] ? 6'h18 :
    _divSqrt_io_b_rawIn_normDist_T_77; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_79 = divSqrt_io_b_rawIn_fractIn[28] ? 6'h17 :
    _divSqrt_io_b_rawIn_normDist_T_78; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_80 = divSqrt_io_b_rawIn_fractIn[29] ? 6'h16 :
    _divSqrt_io_b_rawIn_normDist_T_79; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_81 = divSqrt_io_b_rawIn_fractIn[30] ? 6'h15 :
    _divSqrt_io_b_rawIn_normDist_T_80; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_82 = divSqrt_io_b_rawIn_fractIn[31] ? 6'h14 :
    _divSqrt_io_b_rawIn_normDist_T_81; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_83 = divSqrt_io_b_rawIn_fractIn[32] ? 6'h13 :
    _divSqrt_io_b_rawIn_normDist_T_82; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_84 = divSqrt_io_b_rawIn_fractIn[33] ? 6'h12 :
    _divSqrt_io_b_rawIn_normDist_T_83; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_85 = divSqrt_io_b_rawIn_fractIn[34] ? 6'h11 :
    _divSqrt_io_b_rawIn_normDist_T_84; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_86 = divSqrt_io_b_rawIn_fractIn[35] ? 6'h10 :
    _divSqrt_io_b_rawIn_normDist_T_85; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_87 = divSqrt_io_b_rawIn_fractIn[36] ? 6'hf :
    _divSqrt_io_b_rawIn_normDist_T_86; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_88 = divSqrt_io_b_rawIn_fractIn[37] ? 6'he :
    _divSqrt_io_b_rawIn_normDist_T_87; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_89 = divSqrt_io_b_rawIn_fractIn[38] ? 6'hd :
    _divSqrt_io_b_rawIn_normDist_T_88; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_90 = divSqrt_io_b_rawIn_fractIn[39] ? 6'hc :
    _divSqrt_io_b_rawIn_normDist_T_89; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_91 = divSqrt_io_b_rawIn_fractIn[40] ? 6'hb :
    _divSqrt_io_b_rawIn_normDist_T_90; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_92 = divSqrt_io_b_rawIn_fractIn[41] ? 6'ha :
    _divSqrt_io_b_rawIn_normDist_T_91; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_93 = divSqrt_io_b_rawIn_fractIn[42] ? 6'h9 :
    _divSqrt_io_b_rawIn_normDist_T_92; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_94 = divSqrt_io_b_rawIn_fractIn[43] ? 6'h8 :
    _divSqrt_io_b_rawIn_normDist_T_93; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_95 = divSqrt_io_b_rawIn_fractIn[44] ? 6'h7 :
    _divSqrt_io_b_rawIn_normDist_T_94; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_96 = divSqrt_io_b_rawIn_fractIn[45] ? 6'h6 :
    _divSqrt_io_b_rawIn_normDist_T_95; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_97 = divSqrt_io_b_rawIn_fractIn[46] ? 6'h5 :
    _divSqrt_io_b_rawIn_normDist_T_96; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_98 = divSqrt_io_b_rawIn_fractIn[47] ? 6'h4 :
    _divSqrt_io_b_rawIn_normDist_T_97; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_99 = divSqrt_io_b_rawIn_fractIn[48] ? 6'h3 :
    _divSqrt_io_b_rawIn_normDist_T_98; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_100 = divSqrt_io_b_rawIn_fractIn[49] ? 6'h2 :
    _divSqrt_io_b_rawIn_normDist_T_99; // @[Mux.scala 47:70]
  wire [5:0] _divSqrt_io_b_rawIn_normDist_T_101 = divSqrt_io_b_rawIn_fractIn[50] ? 6'h1 :
    _divSqrt_io_b_rawIn_normDist_T_100; // @[Mux.scala 47:70]
  wire [5:0] divSqrt_io_b_rawIn_normDist = divSqrt_io_b_rawIn_fractIn[51] ? 6'h0 : _divSqrt_io_b_rawIn_normDist_T_101; // @[Mux.scala 47:70]
  wire [114:0] _GEN_3 = {{63'd0}, divSqrt_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _divSqrt_io_b_rawIn_subnormFract_T = _GEN_3 << divSqrt_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] divSqrt_io_b_rawIn_subnormFract = {_divSqrt_io_b_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_47 = {{6'd0}, divSqrt_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _divSqrt_io_b_rawIn_adjustedExp_T = _GEN_47 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _divSqrt_io_b_rawIn_adjustedExp_T_1 = divSqrt_io_b_rawIn_isZeroExpIn ? _divSqrt_io_b_rawIn_adjustedExp_T
     : {{1'd0}, divSqrt_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _divSqrt_io_b_rawIn_adjustedExp_T_2 = divSqrt_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_48 = {{9'd0}, _divSqrt_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _divSqrt_io_b_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_48; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_49 = {{1'd0}, _divSqrt_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] divSqrt_io_b_rawIn_adjustedExp = _divSqrt_io_b_rawIn_adjustedExp_T_1 + _GEN_49; // @[rawFloatFromFN.scala 57:9]
  wire  divSqrt_io_b_rawIn_isZero = divSqrt_io_b_rawIn_isZeroExpIn & divSqrt_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  divSqrt_io_b_rawIn_isSpecial = divSqrt_io_b_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  divSqrt_io_b_rawIn__isNaN = divSqrt_io_b_rawIn_isSpecial & ~divSqrt_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] divSqrt_io_b_rawIn__sExp = {1'b0,$signed(divSqrt_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _divSqrt_io_b_rawIn_out_sig_T = ~divSqrt_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _divSqrt_io_b_rawIn_out_sig_T_2 = divSqrt_io_b_rawIn_isZeroExpIn ? divSqrt_io_b_rawIn_subnormFract :
    divSqrt_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] divSqrt_io_b_rawIn__sig = {1'h0,_divSqrt_io_b_rawIn_out_sig_T,_divSqrt_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _divSqrt_io_b_T_2 = divSqrt_io_b_rawIn_isZero ? 3'h0 : divSqrt_io_b_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_50 = {{2'd0}, divSqrt_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _divSqrt_io_b_T_4 = _divSqrt_io_b_T_2 | _GEN_50; // @[recFNFromFN.scala 48:76]
  wire [64:0] _divSqrt_io_b_T_9 = {divSqrt_io_b_rawIn_sign,_divSqrt_io_b_T_4,divSqrt_io_b_rawIn__sExp[8:0],
    divSqrt_io_b_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  wire  _trans_io_req_valid_T = state == 4'h7; // @[AESSFU.scala 92:31]
  wire  _requestIsInt_T = io_req_bits_op == 16'h6; // @[AESSFU.scala 97:37]
  wire  requestIsInt = io_req_bits_op == 16'h6 & (io_req_bits_dtype == 4'h2 | io_req_bits_dtype == 4'h3); // @[AESSFU.scala 97:55]
  wire  _requestIsFpCore_T_5 = io_req_bits_op == 16'h70; // @[AESSFU.scala 99:20]
  wire  _requestIsFpCore_T_6 = _requestIsInt_T & (io_req_bits_dtype == 4'h8 | io_req_bits_dtype == 4'h9) |
    _requestIsFpCore_T_5; // @[AESSFU.scala 98:120]
  wire  requestIsFpCore = _requestIsFpCore_T_6 | io_req_bits_op == 16'h71 | io_req_bits_op == 16'h76; // @[AESSFU.scala 99:74]
  wire  _requestIsTrans_T_3 = io_req_bits_op == 16'h74; // @[AESSFU.scala 101:20]
  wire  _requestIsTrans_T_4 = io_req_bits_op == 16'h72 | io_req_bits_op == 16'h73 | _requestIsTrans_T_3; // @[AESSFU.scala 100:93]
  wire  requestIsTrans = _requestIsTrans_T_4 | io_req_bits_op == 16'h75; // @[AESSFU.scala 101:38]
  wire  _io_req_ready_T_2 = requestIsInt ? intDiv_io_req_ready : requestIsFpCore | requestIsTrans; // @[AESSFU.scala 105:40]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _state_T = requestIsFpCore ? 4'h3 : 4'h7; // @[AESSFU.scala 111:45]
  wire [3:0] _state_T_1 = requestIsInt ? 4'h1 : _state_T; // @[AESSFU.scala 111:17]
  wire [63:0] _GEN_6 = _T ? 64'h0 : result; // @[AESSFU.scala 106:22 108:12 36:23]
  wire [4:0] _GEN_7 = _T ? 5'h0 : flags; // @[AESSFU.scala 106:22 109:11 37:22]
  wire [3:0] _GEN_9 = _T ? _state_T_1 : state; // @[AESSFU.scala 106:22 111:11 34:22]
  wire [3:0] _GEN_10 = _intDiv_io_req_valid_T & intDiv_io_req_ready ? 4'h2 : _GEN_9; // @[AESSFU.scala 114:{52,60}]
  wire [3:0] _GEN_11 = divSqrt_io_inReady ? 4'h4 : _GEN_10; // @[AESSFU.scala 117:{31,39}]
  wire [3:0] _GEN_12 = _isSqrt_T_1 ? _GEN_11 : _GEN_10; // @[AESSFU.scala 116:28]
  wire [3:0] _GEN_13 = _useRsqDivision_T & divSqrt_io_inReady ? 4'h6 : _GEN_12; // @[AESSFU.scala 119:{54,62}]
  wire  _T_6 = intDiv_io_resp_ready & intDiv_io_resp_valid; // @[Decoupled.scala 51:35]
  wire [63:0] _result_T = {32'h0,intDiv_io_resp_bits_quotient}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_14 = _T_6 ? _result_T : _GEN_6; // @[AESSFU.scala 121:30 122:12]
  wire [3:0] _GEN_16 = _T_6 ? 4'h9 : _GEN_13; // @[AESSFU.scala 121:30 124:11]
  wire  _T_7 = state == 4'h4; // @[AESSFU.scala 126:15]
  wire  _T_10 = divSqrt_io_rawOutValid_div | divSqrt_io_rawOutValid_sqrt; // @[AESSFU.scala 126:79]
  wire [8:0] value_rawIn_exp = round32_io_out[31:23]; // @[rawFloatFromRecFN.scala 51:21]
  wire  value_rawIn_isZero = value_rawIn_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  value_rawIn_isSpecial = value_rawIn_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  value_rawIn__isNaN = value_rawIn_isSpecial & value_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  value_rawIn__isInf = value_rawIn_isSpecial & ~value_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 57:33]
  wire  value_rawIn__sign = round32_io_out[32]; // @[rawFloatFromRecFN.scala 59:25]
  wire [9:0] value_rawIn__sExp = {1'b0,$signed(value_rawIn_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _value_rawIn_out_sig_T = ~value_rawIn_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [24:0] value_rawIn__sig = {1'h0,_value_rawIn_out_sig_T,round32_io_out[22:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire  value_isSubnormal = $signed(value_rawIn__sExp) < 10'sh82; // @[fNFromRecFN.scala 51:38]
  wire [4:0] value_denormShiftDist = 5'h1 - value_rawIn__sExp[4:0]; // @[fNFromRecFN.scala 52:35]
  wire [23:0] _value_denormFract_T_1 = value_rawIn__sig[24:1] >> value_denormShiftDist; // @[fNFromRecFN.scala 53:42]
  wire [22:0] value_denormFract = _value_denormFract_T_1[22:0]; // @[fNFromRecFN.scala 53:60]
  wire [7:0] _value_expOut_T_2 = value_rawIn__sExp[7:0] - 8'h81; // @[fNFromRecFN.scala 58:45]
  wire [7:0] _value_expOut_T_3 = value_isSubnormal ? 8'h0 : _value_expOut_T_2; // @[fNFromRecFN.scala 56:16]
  wire  _value_expOut_T_4 = value_rawIn__isNaN | value_rawIn__isInf; // @[fNFromRecFN.scala 60:44]
  wire [7:0] _value_expOut_T_6 = _value_expOut_T_4 ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] value_expOut = _value_expOut_T_3 | _value_expOut_T_6; // @[fNFromRecFN.scala 60:15]
  wire [22:0] _value_fractOut_T_1 = value_rawIn__isInf ? 23'h0 : value_rawIn__sig[22:0]; // @[fNFromRecFN.scala 64:20]
  wire [22:0] value_fractOut = value_isSubnormal ? value_denormFract : _value_fractOut_T_1; // @[fNFromRecFN.scala 62:16]
  wire [31:0] _value_T = {value_rawIn__sign,value_expOut,value_fractOut}; // @[Cat.scala 33:92]
  wire [31:0] value = &_value_T[30:23] & |_value_T[22:0] ? 32'h7fc00000 : _value_T; // @[AESSFU.scala 102:44]
  wire [63:0] _result_T_1 = {32'h0,value}; // @[Cat.scala 33:92]
  wire [3:0] _GEN_18 = isRsq ? 4'h5 : 4'h9; // @[AESSFU.scala 128:38 130:13 134:13]
  wire [63:0] _GEN_19 = isRsq ? _GEN_14 : _result_T_1; // @[AESSFU.scala 128:38 132:14]
  wire [4:0] _GEN_20 = isRsq ? _GEN_7 : round32_io_exceptionFlags; // @[AESSFU.scala 128:38 133:13]
  wire [3:0] _GEN_22 = state == 4'h4 & _divSqrt_io_inValid_T_1 & (divSqrt_io_rawOutValid_div |
    divSqrt_io_rawOutValid_sqrt) ? _GEN_18 : _GEN_16; // @[AESSFU.scala 126:112]
  wire [63:0] _GEN_23 = state == 4'h4 & _divSqrt_io_inValid_T_1 & (divSqrt_io_rawOutValid_div |
    divSqrt_io_rawOutValid_sqrt) ? _GEN_19 : _GEN_14; // @[AESSFU.scala 126:112]
  wire [3:0] _GEN_27 = _useRsqDivision_T_1 & divSqrt_io_rawOutValid_div ? 4'h9 : _GEN_22; // @[AESSFU.scala 137:61 140:11]
  wire [11:0] result_rawIn_exp_1 = round64_io_out[63:52]; // @[rawFloatFromRecFN.scala 51:21]
  wire  result_rawIn_isZero_1 = result_rawIn_exp_1[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  result_rawIn_isSpecial_1 = result_rawIn_exp_1[11:10] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  result_rawIn_1_isNaN = result_rawIn_isSpecial_1 & result_rawIn_exp_1[9]; // @[rawFloatFromRecFN.scala 56:33]
  wire  result_rawIn_1_isInf = result_rawIn_isSpecial_1 & ~result_rawIn_exp_1[9]; // @[rawFloatFromRecFN.scala 57:33]
  wire  result_rawIn_1_sign = round64_io_out[64]; // @[rawFloatFromRecFN.scala 59:25]
  wire [12:0] result_rawIn_1_sExp = {1'b0,$signed(result_rawIn_exp_1)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _result_rawIn_out_sig_T_4 = ~result_rawIn_isZero_1; // @[rawFloatFromRecFN.scala 61:35]
  wire [53:0] result_rawIn_1_sig = {1'h0,_result_rawIn_out_sig_T_4,round64_io_out[51:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire  result_isSubnormal_1 = $signed(result_rawIn_1_sExp) < 13'sh402; // @[fNFromRecFN.scala 51:38]
  wire [5:0] result_denormShiftDist_1 = 6'h1 - result_rawIn_1_sExp[5:0]; // @[fNFromRecFN.scala 52:35]
  wire [52:0] _result_denormFract_T_3 = result_rawIn_1_sig[53:1] >> result_denormShiftDist_1; // @[fNFromRecFN.scala 53:42]
  wire [51:0] result_denormFract_1 = _result_denormFract_T_3[51:0]; // @[fNFromRecFN.scala 53:60]
  wire [10:0] _result_expOut_T_9 = result_rawIn_1_sExp[10:0] - 11'h401; // @[fNFromRecFN.scala 58:45]
  wire [10:0] _result_expOut_T_10 = result_isSubnormal_1 ? 11'h0 : _result_expOut_T_9; // @[fNFromRecFN.scala 56:16]
  wire  _result_expOut_T_11 = result_rawIn_1_isNaN | result_rawIn_1_isInf; // @[fNFromRecFN.scala 60:44]
  wire [10:0] _result_expOut_T_13 = _result_expOut_T_11 ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [10:0] result_expOut_1 = _result_expOut_T_10 | _result_expOut_T_13; // @[fNFromRecFN.scala 60:15]
  wire [51:0] _result_fractOut_T_3 = result_rawIn_1_isInf ? 52'h0 : result_rawIn_1_sig[51:0]; // @[fNFromRecFN.scala 64:20]
  wire [51:0] result_fractOut_1 = result_isSubnormal_1 ? result_denormFract_1 : _result_fractOut_T_3; // @[fNFromRecFN.scala 62:16]
  wire [63:0] _result_T_10 = {result_rawIn_1_sign,result_expOut_1,result_fractOut_1}; // @[Cat.scala 33:92]
  wire [3:0] _GEN_30 = _T_7 & _divSqrt_io_inValid_T_2 & _T_10 ? 4'h9 : _GEN_27; // @[AESSFU.scala 142:112 145:11]
  wire  _T_22 = trans_io_resp_ready & trans_io_resp_valid; // @[Decoupled.scala 51:35]
  wire [63:0] _result_T_17 = {32'h0,trans_io_resp_bits}; // @[Cat.scala 33:92]
  wire  _T_23 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  AecIntDivider intDiv ( // @[AESSFU.scala 41:22]
    .clock(intDiv_clock),
    .reset(intDiv_reset),
    .io_req_ready(intDiv_io_req_ready),
    .io_req_valid(intDiv_io_req_valid),
    .io_req_bits_dividend(intDiv_io_req_bits_dividend),
    .io_req_bits_divisor(intDiv_io_req_bits_divisor),
    .io_req_bits_signed(intDiv_io_req_bits_signed),
    .io_resp_ready(intDiv_io_resp_ready),
    .io_resp_valid(intDiv_io_resp_valid),
    .io_resp_bits_quotient(intDiv_io_resp_bits_quotient),
    .io_resp_bits_error(intDiv_io_resp_bits_error)
  );
  RecFNToRecFN widenA ( // @[AESSFU.scala 60:22]
    .io_in(widenA_io_in),
    .io_out(widenA_io_out)
  );
  RecFNToRecFN widenB ( // @[AESSFU.scala 61:22]
    .io_in(widenB_io_in),
    .io_out(widenB_io_out)
  );
  DivSqrtRecFMToRaw_small_e11_s53 divSqrt ( // @[AESSFU.scala 69:23]
    .clock(divSqrt_clock),
    .reset(divSqrt_reset),
    .io_inReady(divSqrt_io_inReady),
    .io_inValid(divSqrt_io_inValid),
    .io_sqrtOp(divSqrt_io_sqrtOp),
    .io_a(divSqrt_io_a),
    .io_b(divSqrt_io_b),
    .io_rawOutValid_div(divSqrt_io_rawOutValid_div),
    .io_rawOutValid_sqrt(divSqrt_io_rawOutValid_sqrt),
    .io_invalidExc(divSqrt_io_invalidExc),
    .io_infiniteExc(divSqrt_io_infiniteExc),
    .io_rawOut_isNaN(divSqrt_io_rawOut_isNaN),
    .io_rawOut_isInf(divSqrt_io_rawOut_isInf),
    .io_rawOut_isZero(divSqrt_io_rawOut_isZero),
    .io_rawOut_sign(divSqrt_io_rawOut_sign),
    .io_rawOut_sExp(divSqrt_io_rawOut_sExp),
    .io_rawOut_sig(divSqrt_io_rawOut_sig)
  );
  RoundAnyRawFNToRecFN_ie11_is55_oe8_os24 round32 ( // @[AESSFU.scala 77:23]
    .io_invalidExc(round32_io_invalidExc),
    .io_infiniteExc(round32_io_infiniteExc),
    .io_in_isNaN(round32_io_in_isNaN),
    .io_in_isInf(round32_io_in_isInf),
    .io_in_isZero(round32_io_in_isZero),
    .io_in_sign(round32_io_in_sign),
    .io_in_sExp(round32_io_in_sExp),
    .io_in_sig(round32_io_in_sig),
    .io_out(round32_io_out),
    .io_exceptionFlags(round32_io_exceptionFlags)
  );
  RoundRawFNToRecFN_e11_s53 round64 ( // @[AESSFU.scala 84:23]
    .io_invalidExc(round64_io_invalidExc),
    .io_infiniteExc(round64_io_infiniteExc),
    .io_in_isNaN(round64_io_in_isNaN),
    .io_in_isInf(round64_io_in_isInf),
    .io_in_isZero(round64_io_in_isZero),
    .io_in_sign(round64_io_in_sign),
    .io_in_sExp(round64_io_in_sExp),
    .io_in_sig(round64_io_in_sig),
    .io_out(round64_io_out),
    .io_exceptionFlags(round64_io_exceptionFlags)
  );
  AecTranscendental trans ( // @[AESSFU.scala 91:21]
    .clock(trans_clock),
    .reset(trans_reset),
    .io_req_ready(trans_io_req_ready),
    .io_req_valid(trans_io_req_valid),
    .io_req_bits_op(trans_io_req_bits_op),
    .io_req_bits_in(trans_io_req_bits_in),
    .io_resp_ready(trans_io_resp_ready),
    .io_resp_valid(trans_io_resp_valid),
    .io_resp_bits(trans_io_resp_bits)
  );
  assign io_req_ready = state == 4'h0 & _io_req_ready_T_2; // @[AESSFU.scala 105:34]
  assign io_resp_valid = state == 4'h9; // @[AESSFU.scala 153:26]
  assign io_resp_bits_result = result; // @[AESSFU.scala 154:23]
  assign io_resp_bits_error = error; // @[AESSFU.scala 156:22]
  assign io_resp_bits_exceptionFlags = flags; // @[AESSFU.scala 157:31]
  assign intDiv_clock = clock;
  assign intDiv_reset = reset;
  assign intDiv_io_req_valid = state == 4'h1; // @[AESSFU.scala 45:32]
  assign intDiv_io_req_bits_dividend = held_a[31:0]; // @[AESSFU.scala 46:40]
  assign intDiv_io_req_bits_divisor = held_b[31:0]; // @[AESSFU.scala 47:39]
  assign intDiv_io_req_bits_signed = held_dtype == 4'h3; // @[AESSFU.scala 48:43]
  assign intDiv_io_resp_ready = state == 4'h2; // @[AESSFU.scala 49:33]
  assign widenA_io_in = {_widenA_io_in_T_6,widenA_io_in_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign widenB_io_in = {_widenB_io_in_T_6,widenB_io_in_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign divSqrt_clock = clock;
  assign divSqrt_reset = reset;
  assign divSqrt_io_inValid = _isSqrt_T_1 & (held_dtype == 4'h8 | held_dtype == 4'h9) | _divSqrt_io_inValid_T_7; // @[AESSFU.scala 70:91]
  assign divSqrt_io_sqrtOp = isSqrt & ~useRsqDivision; // @[AESSFU.scala 72:31]
  assign divSqrt_io_a = _divSqrt_io_inValid_T_1 ? widenA_io_out : _divSqrt_io_a_T_9; // @[AESSFU.scala 73:22]
  assign divSqrt_io_b = _divSqrt_io_inValid_T_1 ? widenB_io_out : _divSqrt_io_b_T_9; // @[AESSFU.scala 74:22]
  assign round32_io_invalidExc = divSqrt_io_invalidExc; // @[AESSFU.scala 78:25]
  assign round32_io_infiniteExc = divSqrt_io_infiniteExc; // @[AESSFU.scala 79:26]
  assign round32_io_in_isNaN = divSqrt_io_rawOut_isNaN; // @[AESSFU.scala 80:17]
  assign round32_io_in_isInf = divSqrt_io_rawOut_isInf; // @[AESSFU.scala 80:17]
  assign round32_io_in_isZero = divSqrt_io_rawOut_isZero; // @[AESSFU.scala 80:17]
  assign round32_io_in_sign = divSqrt_io_rawOut_sign; // @[AESSFU.scala 80:17]
  assign round32_io_in_sExp = divSqrt_io_rawOut_sExp; // @[AESSFU.scala 80:17]
  assign round32_io_in_sig = divSqrt_io_rawOut_sig; // @[AESSFU.scala 80:17]
  assign round64_io_invalidExc = divSqrt_io_invalidExc; // @[AESSFU.scala 85:25]
  assign round64_io_infiniteExc = divSqrt_io_infiniteExc; // @[AESSFU.scala 86:26]
  assign round64_io_in_isNaN = divSqrt_io_rawOut_isNaN; // @[AESSFU.scala 87:17]
  assign round64_io_in_isInf = divSqrt_io_rawOut_isInf; // @[AESSFU.scala 87:17]
  assign round64_io_in_isZero = divSqrt_io_rawOut_isZero; // @[AESSFU.scala 87:17]
  assign round64_io_in_sign = divSqrt_io_rawOut_sign; // @[AESSFU.scala 87:17]
  assign round64_io_in_sExp = divSqrt_io_rawOut_sExp; // @[AESSFU.scala 87:17]
  assign round64_io_in_sig = divSqrt_io_rawOut_sig; // @[AESSFU.scala 87:17]
  assign trans_clock = clock;
  assign trans_reset = reset;
  assign trans_io_req_valid = state == 4'h7; // @[AESSFU.scala 92:31]
  assign trans_io_req_bits_op = held_op; // @[AESSFU.scala 94:24]
  assign trans_io_req_bits_in = held_a[31:0]; // @[AESSFU.scala 93:33]
  assign trans_io_resp_ready = state == 4'h8; // @[AESSFU.scala 95:32]
  always @(posedge clock) begin
    if (reset) begin // @[AESSFU.scala 34:22]
      state <= 4'h0; // @[AESSFU.scala 34:22]
    end else if (_T_23) begin // @[AESSFU.scala 158:23]
      state <= 4'h0; // @[AESSFU.scala 158:31]
    end else if (_T_22) begin // @[AESSFU.scala 148:29]
      state <= 4'h9; // @[AESSFU.scala 150:11]
    end else if (_trans_io_req_valid_T & trans_io_req_ready) begin // @[AESSFU.scala 147:53]
      state <= 4'h8; // @[AESSFU.scala 147:61]
    end else begin
      state <= _GEN_30;
    end
    if (_T) begin // @[AESSFU.scala 106:22]
      held_op <= io_req_bits_op; // @[AESSFU.scala 107:10]
    end
    if (_T) begin // @[AESSFU.scala 106:22]
      held_dtype <= io_req_bits_dtype; // @[AESSFU.scala 107:10]
    end
    if (_T) begin // @[AESSFU.scala 106:22]
      held_a <= io_req_bits_a; // @[AESSFU.scala 107:10]
    end
    if (_T) begin // @[AESSFU.scala 106:22]
      held_b <= io_req_bits_b; // @[AESSFU.scala 107:10]
    end
    if (reset) begin // @[AESSFU.scala 36:23]
      result <= 64'h0; // @[AESSFU.scala 36:23]
    end else if (_T_22) begin // @[AESSFU.scala 148:29]
      result <= _result_T_17; // @[AESSFU.scala 149:12]
    end else if (_T_7 & _divSqrt_io_inValid_T_2 & _T_10) begin // @[AESSFU.scala 142:112]
      if (&_result_T_10[62:52] & |_result_T_10[51:0]) begin // @[AESSFU.scala 103:44]
        result <= 64'h7ff8000000000000;
      end else begin
        result <= _result_T_10;
      end
    end else if (_useRsqDivision_T_1 & divSqrt_io_rawOutValid_div) begin // @[AESSFU.scala 137:61]
      result <= _result_T_1; // @[AESSFU.scala 138:12]
    end else begin
      result <= _GEN_23;
    end
    if (reset) begin // @[AESSFU.scala 37:22]
      flags <= 5'h0; // @[AESSFU.scala 37:22]
    end else if (_T_7 & _divSqrt_io_inValid_T_2 & _T_10) begin // @[AESSFU.scala 142:112]
      flags <= round64_io_exceptionFlags; // @[AESSFU.scala 144:11]
    end else if (_useRsqDivision_T_1 & divSqrt_io_rawOutValid_div) begin // @[AESSFU.scala 137:61]
      flags <= round32_io_exceptionFlags; // @[AESSFU.scala 139:11]
    end else if (state == 4'h4 & _divSqrt_io_inValid_T_1 & (divSqrt_io_rawOutValid_div | divSqrt_io_rawOutValid_sqrt)
      ) begin // @[AESSFU.scala 126:112]
      flags <= _GEN_20;
    end else begin
      flags <= _GEN_7;
    end
    if (reset) begin // @[AESSFU.scala 38:22]
      error <= 1'h0; // @[AESSFU.scala 38:22]
    end else if (_T_6) begin // @[AESSFU.scala 121:30]
      error <= intDiv_io_resp_bits_error; // @[AESSFU.scala 123:11]
    end else if (_T) begin // @[AESSFU.scala 106:22]
      error <= 1'h0; // @[AESSFU.scala 110:11]
    end
    if (state == 4'h4 & _divSqrt_io_inValid_T_1 & (divSqrt_io_rawOutValid_div | divSqrt_io_rawOutValid_sqrt)) begin // @[AESSFU.scala 126:112]
      if (isRsq) begin // @[AESSFU.scala 128:38]
        if (&_value_T[30:23] & |_value_T[22:0]) begin // @[AESSFU.scala 102:44]
          rsqRoot <= 32'h7fc00000;
        end else begin
          rsqRoot <= _value_T;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  held_op = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  held_dtype = _RAND_2[3:0];
  _RAND_3 = {2{`RANDOM}};
  held_a = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  held_b = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  result = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  flags = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  error = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rsqRoot = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecWarpRequestBuffer(
  input         clock,
  input         reset,
  input  [15:0] io_in_op,
  input  [3:0]  io_in_dtype,
  input  [31:0] io_in_activeMask,
  input  [63:0] io_in_a_0,
  input  [63:0] io_in_a_1,
  input  [63:0] io_in_a_2,
  input  [63:0] io_in_a_3,
  input  [63:0] io_in_a_4,
  input  [63:0] io_in_a_5,
  input  [63:0] io_in_a_6,
  input  [63:0] io_in_a_7,
  input  [63:0] io_in_a_8,
  input  [63:0] io_in_a_9,
  input  [63:0] io_in_a_10,
  input  [63:0] io_in_a_11,
  input  [63:0] io_in_a_12,
  input  [63:0] io_in_a_13,
  input  [63:0] io_in_a_14,
  input  [63:0] io_in_a_15,
  input  [63:0] io_in_a_16,
  input  [63:0] io_in_a_17,
  input  [63:0] io_in_a_18,
  input  [63:0] io_in_a_19,
  input  [63:0] io_in_a_20,
  input  [63:0] io_in_a_21,
  input  [63:0] io_in_a_22,
  input  [63:0] io_in_a_23,
  input  [63:0] io_in_a_24,
  input  [63:0] io_in_a_25,
  input  [63:0] io_in_a_26,
  input  [63:0] io_in_a_27,
  input  [63:0] io_in_a_28,
  input  [63:0] io_in_a_29,
  input  [63:0] io_in_a_30,
  input  [63:0] io_in_a_31,
  input  [63:0] io_in_b_0,
  input  [63:0] io_in_b_1,
  input  [63:0] io_in_b_2,
  input  [63:0] io_in_b_3,
  input  [63:0] io_in_b_4,
  input  [63:0] io_in_b_5,
  input  [63:0] io_in_b_6,
  input  [63:0] io_in_b_7,
  input  [63:0] io_in_b_8,
  input  [63:0] io_in_b_9,
  input  [63:0] io_in_b_10,
  input  [63:0] io_in_b_11,
  input  [63:0] io_in_b_12,
  input  [63:0] io_in_b_13,
  input  [63:0] io_in_b_14,
  input  [63:0] io_in_b_15,
  input  [63:0] io_in_b_16,
  input  [63:0] io_in_b_17,
  input  [63:0] io_in_b_18,
  input  [63:0] io_in_b_19,
  input  [63:0] io_in_b_20,
  input  [63:0] io_in_b_21,
  input  [63:0] io_in_b_22,
  input  [63:0] io_in_b_23,
  input  [63:0] io_in_b_24,
  input  [63:0] io_in_b_25,
  input  [63:0] io_in_b_26,
  input  [63:0] io_in_b_27,
  input  [63:0] io_in_b_28,
  input  [63:0] io_in_b_29,
  input  [63:0] io_in_b_30,
  input  [63:0] io_in_b_31,
  input  [7:0]  io_in_dest,
  input         io_arm_0,
  input         io_arm_1,
  input         io_arm_2,
  input         io_arm_3,
  input         io_arm_4,
  input         io_arm_5,
  input         io_arm_6,
  input         io_arm_7,
  input         io_capture,
  output [15:0] io_out_op,
  output [3:0]  io_out_dtype,
  output [31:0] io_out_activeMask,
  output [63:0] io_out_a_0,
  output [63:0] io_out_a_1,
  output [63:0] io_out_a_2,
  output [63:0] io_out_a_3,
  output [63:0] io_out_a_4,
  output [63:0] io_out_a_5,
  output [63:0] io_out_a_6,
  output [63:0] io_out_a_7,
  output [63:0] io_out_a_8,
  output [63:0] io_out_a_9,
  output [63:0] io_out_a_10,
  output [63:0] io_out_a_11,
  output [63:0] io_out_a_12,
  output [63:0] io_out_a_13,
  output [63:0] io_out_a_14,
  output [63:0] io_out_a_15,
  output [63:0] io_out_a_16,
  output [63:0] io_out_a_17,
  output [63:0] io_out_a_18,
  output [63:0] io_out_a_19,
  output [63:0] io_out_a_20,
  output [63:0] io_out_a_21,
  output [63:0] io_out_a_22,
  output [63:0] io_out_a_23,
  output [63:0] io_out_a_24,
  output [63:0] io_out_a_25,
  output [63:0] io_out_a_26,
  output [63:0] io_out_a_27,
  output [63:0] io_out_a_28,
  output [63:0] io_out_a_29,
  output [63:0] io_out_a_30,
  output [63:0] io_out_a_31,
  output [63:0] io_out_b_0,
  output [63:0] io_out_b_1,
  output [63:0] io_out_b_2,
  output [63:0] io_out_b_3,
  output [63:0] io_out_b_4,
  output [63:0] io_out_b_5,
  output [63:0] io_out_b_6,
  output [63:0] io_out_b_7,
  output [63:0] io_out_b_8,
  output [63:0] io_out_b_9,
  output [63:0] io_out_b_10,
  output [63:0] io_out_b_11,
  output [63:0] io_out_b_12,
  output [63:0] io_out_b_13,
  output [63:0] io_out_b_14,
  output [63:0] io_out_b_15,
  output [63:0] io_out_b_16,
  output [63:0] io_out_b_17,
  output [63:0] io_out_b_18,
  output [63:0] io_out_b_19,
  output [63:0] io_out_b_20,
  output [63:0] io_out_b_21,
  output [63:0] io_out_b_22,
  output [63:0] io_out_b_23,
  output [63:0] io_out_b_24,
  output [63:0] io_out_b_25,
  output [63:0] io_out_b_26,
  output [63:0] io_out_b_27,
  output [63:0] io_out_b_28,
  output [63:0] io_out_b_29,
  output [63:0] io_out_b_30,
  output [63:0] io_out_b_31,
  output [7:0]  io_out_dest
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
  reg [31:0] _RAND_228;
  reg [31:0] _RAND_229;
  reg [31:0] _RAND_230;
  reg [31:0] _RAND_231;
  reg [31:0] _RAND_232;
  reg [31:0] _RAND_233;
  reg [31:0] _RAND_234;
  reg [31:0] _RAND_235;
  reg [31:0] _RAND_236;
  reg [31:0] _RAND_237;
  reg [31:0] _RAND_238;
  reg [31:0] _RAND_239;
  reg [31:0] _RAND_240;
  reg [31:0] _RAND_241;
  reg [31:0] _RAND_242;
  reg [31:0] _RAND_243;
  reg [31:0] _RAND_244;
  reg [31:0] _RAND_245;
  reg [31:0] _RAND_246;
  reg [31:0] _RAND_247;
  reg [31:0] _RAND_248;
  reg [31:0] _RAND_249;
  reg [31:0] _RAND_250;
  reg [31:0] _RAND_251;
  reg [31:0] _RAND_252;
  reg [31:0] _RAND_253;
  reg [31:0] _RAND_254;
  reg [31:0] _RAND_255;
  reg [31:0] _RAND_256;
  reg [31:0] _RAND_257;
  reg [31:0] _RAND_258;
  reg [31:0] _RAND_259;
  reg [31:0] _RAND_260;
  reg [31:0] _RAND_261;
  reg [31:0] _RAND_262;
  reg [31:0] _RAND_263;
  reg [31:0] _RAND_264;
  reg [31:0] _RAND_265;
  reg [31:0] _RAND_266;
  reg [31:0] _RAND_267;
  reg [31:0] _RAND_268;
  reg [31:0] _RAND_269;
  reg [31:0] _RAND_270;
  reg [31:0] _RAND_271;
  reg [31:0] _RAND_272;
  reg [31:0] _RAND_273;
  reg [31:0] _RAND_274;
  reg [31:0] _RAND_275;
  reg [31:0] _RAND_276;
  reg [31:0] _RAND_277;
  reg [31:0] _RAND_278;
  reg [31:0] _RAND_279;
  reg [31:0] _RAND_280;
  reg [31:0] _RAND_281;
  reg [31:0] _RAND_282;
  reg [31:0] _RAND_283;
  reg [31:0] _RAND_284;
  reg [31:0] _RAND_285;
  reg [31:0] _RAND_286;
  reg [31:0] _RAND_287;
  reg [31:0] _RAND_288;
  reg [31:0] _RAND_289;
  reg [31:0] _RAND_290;
  reg [31:0] _RAND_291;
  reg [31:0] _RAND_292;
  reg [31:0] _RAND_293;
  reg [31:0] _RAND_294;
  reg [31:0] _RAND_295;
  reg [31:0] _RAND_296;
  reg [31:0] _RAND_297;
  reg [31:0] _RAND_298;
  reg [31:0] _RAND_299;
  reg [31:0] _RAND_300;
  reg [31:0] _RAND_301;
  reg [31:0] _RAND_302;
  reg [31:0] _RAND_303;
  reg [31:0] _RAND_304;
  reg [31:0] _RAND_305;
  reg [31:0] _RAND_306;
  reg [31:0] _RAND_307;
  reg [31:0] _RAND_308;
  reg [31:0] _RAND_309;
  reg [31:0] _RAND_310;
  reg [31:0] _RAND_311;
  reg [31:0] _RAND_312;
  reg [31:0] _RAND_313;
  reg [31:0] _RAND_314;
  reg [31:0] _RAND_315;
  reg [31:0] _RAND_316;
  reg [31:0] _RAND_317;
  reg [31:0] _RAND_318;
  reg [31:0] _RAND_319;
  reg [31:0] _RAND_320;
  reg [31:0] _RAND_321;
  reg [31:0] _RAND_322;
  reg [31:0] _RAND_323;
  reg [31:0] _RAND_324;
  reg [31:0] _RAND_325;
  reg [31:0] _RAND_326;
  reg [31:0] _RAND_327;
  reg [31:0] _RAND_328;
  reg [31:0] _RAND_329;
  reg [31:0] _RAND_330;
  reg [31:0] _RAND_331;
  reg [31:0] _RAND_332;
  reg [31:0] _RAND_333;
  reg [31:0] _RAND_334;
  reg [31:0] _RAND_335;
  reg [31:0] _RAND_336;
  reg [31:0] _RAND_337;
  reg [31:0] _RAND_338;
  reg [31:0] _RAND_339;
  reg [31:0] _RAND_340;
  reg [31:0] _RAND_341;
  reg [31:0] _RAND_342;
  reg [31:0] _RAND_343;
  reg [31:0] _RAND_344;
  reg [31:0] _RAND_345;
  reg [31:0] _RAND_346;
  reg [31:0] _RAND_347;
  reg [31:0] _RAND_348;
  reg [31:0] _RAND_349;
  reg [31:0] _RAND_350;
  reg [31:0] _RAND_351;
  reg [31:0] _RAND_352;
  reg [31:0] _RAND_353;
  reg [31:0] _RAND_354;
  reg [31:0] _RAND_355;
  reg [31:0] _RAND_356;
  reg [31:0] _RAND_357;
  reg [31:0] _RAND_358;
  reg [31:0] _RAND_359;
  reg [31:0] _RAND_360;
  reg [31:0] _RAND_361;
  reg [31:0] _RAND_362;
  reg [31:0] _RAND_363;
  reg [31:0] _RAND_364;
  reg [31:0] _RAND_365;
  reg [31:0] _RAND_366;
  reg [31:0] _RAND_367;
  reg [31:0] _RAND_368;
  reg [31:0] _RAND_369;
  reg [31:0] _RAND_370;
  reg [31:0] _RAND_371;
  reg [31:0] _RAND_372;
  reg [31:0] _RAND_373;
  reg [31:0] _RAND_374;
  reg [31:0] _RAND_375;
  reg [31:0] _RAND_376;
  reg [31:0] _RAND_377;
  reg [31:0] _RAND_378;
  reg [31:0] _RAND_379;
  reg [31:0] _RAND_380;
  reg [31:0] _RAND_381;
  reg [31:0] _RAND_382;
  reg [31:0] _RAND_383;
  reg [31:0] _RAND_384;
  reg [31:0] _RAND_385;
  reg [31:0] _RAND_386;
  reg [31:0] _RAND_387;
  reg [31:0] _RAND_388;
  reg [31:0] _RAND_389;
  reg [31:0] _RAND_390;
  reg [31:0] _RAND_391;
  reg [31:0] _RAND_392;
  reg [31:0] _RAND_393;
  reg [31:0] _RAND_394;
  reg [31:0] _RAND_395;
  reg [31:0] _RAND_396;
  reg [31:0] _RAND_397;
  reg [31:0] _RAND_398;
  reg [31:0] _RAND_399;
  reg [31:0] _RAND_400;
  reg [31:0] _RAND_401;
  reg [31:0] _RAND_402;
  reg [31:0] _RAND_403;
  reg [31:0] _RAND_404;
  reg [31:0] _RAND_405;
  reg [31:0] _RAND_406;
  reg [31:0] _RAND_407;
  reg [31:0] _RAND_408;
  reg [31:0] _RAND_409;
  reg [31:0] _RAND_410;
  reg [31:0] _RAND_411;
  reg [31:0] _RAND_412;
  reg [31:0] _RAND_413;
  reg [31:0] _RAND_414;
  reg [31:0] _RAND_415;
  reg [31:0] _RAND_416;
  reg [31:0] _RAND_417;
  reg [31:0] _RAND_418;
  reg [31:0] _RAND_419;
  reg [31:0] _RAND_420;
  reg [31:0] _RAND_421;
  reg [31:0] _RAND_422;
  reg [31:0] _RAND_423;
  reg [31:0] _RAND_424;
  reg [31:0] _RAND_425;
  reg [31:0] _RAND_426;
  reg [31:0] _RAND_427;
  reg [31:0] _RAND_428;
  reg [31:0] _RAND_429;
  reg [31:0] _RAND_430;
  reg [31:0] _RAND_431;
  reg [31:0] _RAND_432;
  reg [31:0] _RAND_433;
  reg [31:0] _RAND_434;
  reg [31:0] _RAND_435;
  reg [31:0] _RAND_436;
  reg [31:0] _RAND_437;
  reg [31:0] _RAND_438;
  reg [31:0] _RAND_439;
  reg [31:0] _RAND_440;
  reg [31:0] _RAND_441;
  reg [31:0] _RAND_442;
  reg [31:0] _RAND_443;
  reg [31:0] _RAND_444;
  reg [31:0] _RAND_445;
  reg [31:0] _RAND_446;
  reg [31:0] _RAND_447;
  reg [31:0] _RAND_448;
  reg [31:0] _RAND_449;
  reg [31:0] _RAND_450;
  reg [31:0] _RAND_451;
  reg [31:0] _RAND_452;
  reg [31:0] _RAND_453;
  reg [31:0] _RAND_454;
  reg [31:0] _RAND_455;
  reg [31:0] _RAND_456;
  reg [31:0] _RAND_457;
  reg [31:0] _RAND_458;
  reg [31:0] _RAND_459;
  reg [31:0] _RAND_460;
  reg [31:0] _RAND_461;
  reg [31:0] _RAND_462;
  reg [31:0] _RAND_463;
  reg [31:0] _RAND_464;
  reg [31:0] _RAND_465;
  reg [31:0] _RAND_466;
  reg [31:0] _RAND_467;
  reg [31:0] _RAND_468;
  reg [31:0] _RAND_469;
  reg [31:0] _RAND_470;
  reg [31:0] _RAND_471;
  reg [31:0] _RAND_472;
  reg [31:0] _RAND_473;
  reg [31:0] _RAND_474;
  reg [31:0] _RAND_475;
  reg [31:0] _RAND_476;
  reg [31:0] _RAND_477;
  reg [31:0] _RAND_478;
  reg [31:0] _RAND_479;
  reg [31:0] _RAND_480;
  reg [31:0] _RAND_481;
  reg [31:0] _RAND_482;
  reg [31:0] _RAND_483;
  reg [31:0] _RAND_484;
  reg [31:0] _RAND_485;
  reg [31:0] _RAND_486;
  reg [31:0] _RAND_487;
  reg [31:0] _RAND_488;
  reg [31:0] _RAND_489;
  reg [31:0] _RAND_490;
  reg [31:0] _RAND_491;
  reg [31:0] _RAND_492;
  reg [31:0] _RAND_493;
  reg [31:0] _RAND_494;
  reg [31:0] _RAND_495;
  reg [31:0] _RAND_496;
  reg [31:0] _RAND_497;
  reg [31:0] _RAND_498;
  reg [31:0] _RAND_499;
  reg [31:0] _RAND_500;
  reg [31:0] _RAND_501;
  reg [31:0] _RAND_502;
  reg [31:0] _RAND_503;
  reg [31:0] _RAND_504;
  reg [31:0] _RAND_505;
  reg [31:0] _RAND_506;
  reg [31:0] _RAND_507;
  reg [31:0] _RAND_508;
  reg [31:0] _RAND_509;
  reg [31:0] _RAND_510;
  reg [31:0] _RAND_511;
  reg [31:0] _RAND_512;
  reg [31:0] _RAND_513;
  reg [31:0] _RAND_514;
  reg [31:0] _RAND_515;
  reg [31:0] _RAND_516;
  reg [31:0] _RAND_517;
  reg [31:0] _RAND_518;
  reg [31:0] _RAND_519;
  reg [31:0] _RAND_520;
  reg [31:0] _RAND_521;
  reg [31:0] _RAND_522;
  reg [31:0] _RAND_523;
  reg [31:0] _RAND_524;
  reg [31:0] _RAND_525;
  reg [31:0] _RAND_526;
  reg [31:0] _RAND_527;
  reg [31:0] _RAND_528;
  reg [31:0] _RAND_529;
  reg [31:0] _RAND_530;
  reg [31:0] _RAND_531;
  reg [31:0] _RAND_532;
  reg [31:0] _RAND_533;
  reg [31:0] _RAND_534;
  reg [31:0] _RAND_535;
  reg [31:0] _RAND_536;
  reg [31:0] _RAND_537;
  reg [31:0] _RAND_538;
  reg [31:0] _RAND_539;
  reg [31:0] _RAND_540;
  reg [31:0] _RAND_541;
  reg [31:0] _RAND_542;
  reg [31:0] _RAND_543;
  reg [31:0] _RAND_544;
  reg [31:0] _RAND_545;
  reg [31:0] _RAND_546;
  reg [31:0] _RAND_547;
  reg [31:0] _RAND_548;
  reg [31:0] _RAND_549;
  reg [31:0] _RAND_550;
  reg [31:0] _RAND_551;
  reg [31:0] _RAND_552;
  reg [31:0] _RAND_553;
  reg [31:0] _RAND_554;
  reg [31:0] _RAND_555;
  reg [31:0] _RAND_556;
  reg [31:0] _RAND_557;
  reg [31:0] _RAND_558;
  reg [31:0] _RAND_559;
  reg [31:0] _RAND_560;
  reg [31:0] _RAND_561;
  reg [31:0] _RAND_562;
  reg [31:0] _RAND_563;
  reg [31:0] _RAND_564;
  reg [31:0] _RAND_565;
  reg [31:0] _RAND_566;
  reg [31:0] _RAND_567;
  reg [31:0] _RAND_568;
  reg [31:0] _RAND_569;
  reg [31:0] _RAND_570;
  reg [31:0] _RAND_571;
  reg [31:0] _RAND_572;
  reg [31:0] _RAND_573;
  reg [31:0] _RAND_574;
  reg [31:0] _RAND_575;
  reg [31:0] _RAND_576;
  reg [31:0] _RAND_577;
  reg [31:0] _RAND_578;
  reg [31:0] _RAND_579;
  reg [31:0] _RAND_580;
  reg [31:0] _RAND_581;
  reg [31:0] _RAND_582;
  reg [31:0] _RAND_583;
  reg [31:0] _RAND_584;
  reg [31:0] _RAND_585;
  reg [31:0] _RAND_586;
  reg [31:0] _RAND_587;
  reg [31:0] _RAND_588;
  reg [31:0] _RAND_589;
  reg [31:0] _RAND_590;
  reg [31:0] _RAND_591;
  reg [31:0] _RAND_592;
  reg [31:0] _RAND_593;
  reg [31:0] _RAND_594;
  reg [31:0] _RAND_595;
  reg [31:0] _RAND_596;
  reg [31:0] _RAND_597;
  reg [31:0] _RAND_598;
  reg [31:0] _RAND_599;
  reg [31:0] _RAND_600;
  reg [31:0] _RAND_601;
  reg [31:0] _RAND_602;
  reg [31:0] _RAND_603;
  reg [31:0] _RAND_604;
  reg [31:0] _RAND_605;
  reg [31:0] _RAND_606;
  reg [31:0] _RAND_607;
  reg [31:0] _RAND_608;
  reg [31:0] _RAND_609;
  reg [31:0] _RAND_610;
  reg [31:0] _RAND_611;
  reg [31:0] _RAND_612;
  reg [31:0] _RAND_613;
  reg [31:0] _RAND_614;
  reg [31:0] _RAND_615;
  reg [31:0] _RAND_616;
  reg [31:0] _RAND_617;
  reg [31:0] _RAND_618;
  reg [31:0] _RAND_619;
  reg [31:0] _RAND_620;
  reg [31:0] _RAND_621;
  reg [31:0] _RAND_622;
  reg [31:0] _RAND_623;
  reg [31:0] _RAND_624;
  reg [31:0] _RAND_625;
  reg [31:0] _RAND_626;
  reg [31:0] _RAND_627;
  reg [31:0] _RAND_628;
  reg [31:0] _RAND_629;
  reg [31:0] _RAND_630;
  reg [31:0] _RAND_631;
  reg [31:0] _RAND_632;
  reg [31:0] _RAND_633;
  reg [31:0] _RAND_634;
  reg [31:0] _RAND_635;
  reg [31:0] _RAND_636;
  reg [31:0] _RAND_637;
  reg [31:0] _RAND_638;
  reg [31:0] _RAND_639;
  reg [31:0] _RAND_640;
  reg [31:0] _RAND_641;
  reg [31:0] _RAND_642;
  reg [31:0] _RAND_643;
  reg [31:0] _RAND_644;
  reg [31:0] _RAND_645;
  reg [31:0] _RAND_646;
  reg [31:0] _RAND_647;
  reg [31:0] _RAND_648;
  reg [31:0] _RAND_649;
  reg [31:0] _RAND_650;
  reg [31:0] _RAND_651;
  reg [31:0] _RAND_652;
  reg [31:0] _RAND_653;
  reg [31:0] _RAND_654;
  reg [31:0] _RAND_655;
  reg [31:0] _RAND_656;
  reg [31:0] _RAND_657;
  reg [31:0] _RAND_658;
  reg [31:0] _RAND_659;
  reg [31:0] _RAND_660;
  reg [31:0] _RAND_661;
  reg [31:0] _RAND_662;
  reg [31:0] _RAND_663;
  reg [31:0] _RAND_664;
  reg [31:0] _RAND_665;
  reg [31:0] _RAND_666;
  reg [31:0] _RAND_667;
  reg [31:0] _RAND_668;
  reg [31:0] _RAND_669;
  reg [31:0] _RAND_670;
  reg [31:0] _RAND_671;
  reg [31:0] _RAND_672;
  reg [31:0] _RAND_673;
  reg [31:0] _RAND_674;
  reg [31:0] _RAND_675;
  reg [31:0] _RAND_676;
  reg [31:0] _RAND_677;
  reg [31:0] _RAND_678;
  reg [31:0] _RAND_679;
  reg [31:0] _RAND_680;
  reg [31:0] _RAND_681;
  reg [31:0] _RAND_682;
  reg [31:0] _RAND_683;
  reg [31:0] _RAND_684;
  reg [31:0] _RAND_685;
  reg [31:0] _RAND_686;
  reg [31:0] _RAND_687;
  reg [31:0] _RAND_688;
  reg [31:0] _RAND_689;
  reg [31:0] _RAND_690;
  reg [31:0] _RAND_691;
  reg [31:0] _RAND_692;
  reg [31:0] _RAND_693;
  reg [31:0] _RAND_694;
  reg [31:0] _RAND_695;
  reg [31:0] _RAND_696;
  reg [31:0] _RAND_697;
  reg [31:0] _RAND_698;
  reg [31:0] _RAND_699;
  reg [31:0] _RAND_700;
  reg [31:0] _RAND_701;
  reg [31:0] _RAND_702;
  reg [31:0] _RAND_703;
  reg [31:0] _RAND_704;
  reg [31:0] _RAND_705;
  reg [31:0] _RAND_706;
`endif // RANDOMIZE_REG_INIT
  reg  operandCapture_0_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_0_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_1_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_2_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_3_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_4_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_5_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_6_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_7_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_8_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_9_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_10_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_11_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_12_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_13_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_14_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_15_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_16_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_17_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_18_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_19_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_20_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_21_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_22_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_23_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_24_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_25_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_26_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_27_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_28_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_29_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_30_11; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_0; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_1; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_2; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_3; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_4; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_5; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_6; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_7; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_8; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_9; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_10; // @[AecExecPort.scala 74:31]
  reg  operandCapture_31_11; // @[AecExecPort.scala 74:31]
  reg  maskCapture_0; // @[AecExecPort.scala 76:28]
  reg  maskCapture_1; // @[AecExecPort.scala 76:28]
  reg  maskCapture_2; // @[AecExecPort.scala 76:28]
  reg  maskCapture_3; // @[AecExecPort.scala 76:28]
  reg  maskCapture_4; // @[AecExecPort.scala 76:28]
  reg  maskCapture_5; // @[AecExecPort.scala 76:28]
  reg  maskCapture_6; // @[AecExecPort.scala 76:28]
  reg  maskCapture_7; // @[AecExecPort.scala 76:28]
  reg  maskCapture_8; // @[AecExecPort.scala 76:28]
  reg  maskCapture_9; // @[AecExecPort.scala 76:28]
  reg  maskCapture_10; // @[AecExecPort.scala 76:28]
  reg  maskCapture_11; // @[AecExecPort.scala 76:28]
  reg  maskCapture_12; // @[AecExecPort.scala 76:28]
  reg  maskCapture_13; // @[AecExecPort.scala 76:28]
  reg  maskCapture_14; // @[AecExecPort.scala 76:28]
  reg  maskCapture_15; // @[AecExecPort.scala 76:28]
  reg  maskCapture_16; // @[AecExecPort.scala 76:28]
  reg  maskCapture_17; // @[AecExecPort.scala 76:28]
  reg  maskCapture_18; // @[AecExecPort.scala 76:28]
  reg  maskCapture_19; // @[AecExecPort.scala 76:28]
  reg  maskCapture_20; // @[AecExecPort.scala 76:28]
  reg  maskCapture_21; // @[AecExecPort.scala 76:28]
  reg  maskCapture_22; // @[AecExecPort.scala 76:28]
  reg  maskCapture_23; // @[AecExecPort.scala 76:28]
  reg  maskCapture_24; // @[AecExecPort.scala 76:28]
  reg  maskCapture_25; // @[AecExecPort.scala 76:28]
  reg  maskCapture_26; // @[AecExecPort.scala 76:28]
  reg  maskCapture_27; // @[AecExecPort.scala 76:28]
  reg  maskCapture_28; // @[AecExecPort.scala 76:28]
  reg  maskCapture_29; // @[AecExecPort.scala 76:28]
  reg  maskCapture_30; // @[AecExecPort.scala 76:28]
  reg  maskCapture_31; // @[AecExecPort.scala 76:28]
  reg [15:0] a_0_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_0_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_0_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_0_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_1_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_1_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_1_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_1_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_2_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_2_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_2_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_2_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_3_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_3_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_3_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_3_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_4_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_4_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_4_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_4_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_5_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_5_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_5_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_5_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_6_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_6_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_6_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_6_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_7_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_7_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_7_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_7_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_8_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_8_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_8_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_8_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_9_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_9_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_9_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_9_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_10_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_10_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_10_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_10_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_11_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_11_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_11_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_11_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_12_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_12_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_12_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_12_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_13_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_13_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_13_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_13_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_14_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_14_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_14_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_14_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_15_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_15_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_15_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_15_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_16_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_16_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_16_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_16_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_17_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_17_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_17_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_17_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_18_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_18_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_18_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_18_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_19_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_19_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_19_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_19_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_20_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_20_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_20_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_20_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_21_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_21_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_21_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_21_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_22_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_22_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_22_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_22_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_23_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_23_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_23_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_23_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_24_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_24_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_24_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_24_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_25_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_25_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_25_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_25_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_26_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_26_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_26_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_26_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_27_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_27_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_27_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_27_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_28_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_28_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_28_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_28_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_29_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_29_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_29_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_29_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_30_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_30_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_30_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_30_3; // @[AecExecPort.scala 78:14]
  reg [15:0] a_31_0; // @[AecExecPort.scala 78:14]
  reg [15:0] a_31_1; // @[AecExecPort.scala 78:14]
  reg [15:0] a_31_2; // @[AecExecPort.scala 78:14]
  reg [15:0] a_31_3; // @[AecExecPort.scala 78:14]
  reg [15:0] b_0_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_0_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_0_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_0_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_1_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_1_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_1_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_1_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_2_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_2_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_2_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_2_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_3_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_3_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_3_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_3_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_4_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_4_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_4_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_4_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_5_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_5_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_5_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_5_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_6_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_6_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_6_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_6_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_7_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_7_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_7_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_7_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_8_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_8_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_8_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_8_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_9_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_9_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_9_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_9_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_10_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_10_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_10_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_10_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_11_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_11_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_11_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_11_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_12_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_12_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_12_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_12_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_13_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_13_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_13_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_13_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_14_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_14_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_14_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_14_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_15_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_15_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_15_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_15_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_16_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_16_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_16_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_16_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_17_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_17_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_17_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_17_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_18_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_18_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_18_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_18_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_19_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_19_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_19_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_19_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_20_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_20_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_20_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_20_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_21_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_21_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_21_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_21_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_22_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_22_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_22_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_22_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_23_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_23_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_23_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_23_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_24_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_24_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_24_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_24_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_25_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_25_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_25_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_25_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_26_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_26_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_26_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_26_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_27_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_27_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_27_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_27_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_28_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_28_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_28_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_28_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_29_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_29_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_29_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_29_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_30_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_30_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_30_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_30_3; // @[AecExecPort.scala 79:14]
  reg [15:0] b_31_0; // @[AecExecPort.scala 79:14]
  reg [15:0] b_31_1; // @[AecExecPort.scala 79:14]
  reg [15:0] b_31_2; // @[AecExecPort.scala 79:14]
  reg [15:0] b_31_3; // @[AecExecPort.scala 79:14]
  reg  active_0; // @[AecExecPort.scala 81:19]
  reg  active_1; // @[AecExecPort.scala 81:19]
  reg  active_2; // @[AecExecPort.scala 81:19]
  reg  active_3; // @[AecExecPort.scala 81:19]
  reg  active_4; // @[AecExecPort.scala 81:19]
  reg  active_5; // @[AecExecPort.scala 81:19]
  reg  active_6; // @[AecExecPort.scala 81:19]
  reg  active_7; // @[AecExecPort.scala 81:19]
  reg  active_8; // @[AecExecPort.scala 81:19]
  reg  active_9; // @[AecExecPort.scala 81:19]
  reg  active_10; // @[AecExecPort.scala 81:19]
  reg  active_11; // @[AecExecPort.scala 81:19]
  reg  active_12; // @[AecExecPort.scala 81:19]
  reg  active_13; // @[AecExecPort.scala 81:19]
  reg  active_14; // @[AecExecPort.scala 81:19]
  reg  active_15; // @[AecExecPort.scala 81:19]
  reg  active_16; // @[AecExecPort.scala 81:19]
  reg  active_17; // @[AecExecPort.scala 81:19]
  reg  active_18; // @[AecExecPort.scala 81:19]
  reg  active_19; // @[AecExecPort.scala 81:19]
  reg  active_20; // @[AecExecPort.scala 81:19]
  reg  active_21; // @[AecExecPort.scala 81:19]
  reg  active_22; // @[AecExecPort.scala 81:19]
  reg  active_23; // @[AecExecPort.scala 81:19]
  reg  active_24; // @[AecExecPort.scala 81:19]
  reg  active_25; // @[AecExecPort.scala 81:19]
  reg  active_26; // @[AecExecPort.scala 81:19]
  reg  active_27; // @[AecExecPort.scala 81:19]
  reg  active_28; // @[AecExecPort.scala 81:19]
  reg  active_29; // @[AecExecPort.scala 81:19]
  reg  active_30; // @[AecExecPort.scala 81:19]
  reg  active_31; // @[AecExecPort.scala 81:19]
  reg [15:0] op; // @[AecExecPort.scala 83:15]
  reg [3:0] dtype; // @[AecExecPort.scala 84:18]
  reg [7:0] dest; // @[AecExecPort.scala 85:17]
  wire [31:0] io_out_a_0_lo = {a_0_1,a_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_0_hi = {a_0_3,a_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_0_lo = {b_0_1,b_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_0_hi = {b_0_3,b_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_1_lo = {a_1_1,a_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_1_hi = {a_1_3,a_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_1_lo = {b_1_1,b_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_1_hi = {b_1_3,b_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_2_lo = {a_2_1,a_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_2_hi = {a_2_3,a_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_2_lo = {b_2_1,b_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_2_hi = {b_2_3,b_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_3_lo = {a_3_1,a_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_3_hi = {a_3_3,a_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_3_lo = {b_3_1,b_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_3_hi = {b_3_3,b_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_4_lo = {a_4_1,a_4_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_4_hi = {a_4_3,a_4_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_4_lo = {b_4_1,b_4_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_4_hi = {b_4_3,b_4_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_5_lo = {a_5_1,a_5_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_5_hi = {a_5_3,a_5_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_5_lo = {b_5_1,b_5_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_5_hi = {b_5_3,b_5_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_6_lo = {a_6_1,a_6_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_6_hi = {a_6_3,a_6_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_6_lo = {b_6_1,b_6_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_6_hi = {b_6_3,b_6_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_7_lo = {a_7_1,a_7_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_7_hi = {a_7_3,a_7_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_7_lo = {b_7_1,b_7_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_7_hi = {b_7_3,b_7_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_8_lo = {a_8_1,a_8_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_8_hi = {a_8_3,a_8_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_8_lo = {b_8_1,b_8_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_8_hi = {b_8_3,b_8_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_9_lo = {a_9_1,a_9_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_9_hi = {a_9_3,a_9_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_9_lo = {b_9_1,b_9_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_9_hi = {b_9_3,b_9_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_10_lo = {a_10_1,a_10_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_10_hi = {a_10_3,a_10_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_10_lo = {b_10_1,b_10_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_10_hi = {b_10_3,b_10_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_11_lo = {a_11_1,a_11_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_11_hi = {a_11_3,a_11_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_11_lo = {b_11_1,b_11_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_11_hi = {b_11_3,b_11_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_12_lo = {a_12_1,a_12_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_12_hi = {a_12_3,a_12_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_12_lo = {b_12_1,b_12_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_12_hi = {b_12_3,b_12_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_13_lo = {a_13_1,a_13_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_13_hi = {a_13_3,a_13_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_13_lo = {b_13_1,b_13_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_13_hi = {b_13_3,b_13_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_14_lo = {a_14_1,a_14_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_14_hi = {a_14_3,a_14_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_14_lo = {b_14_1,b_14_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_14_hi = {b_14_3,b_14_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_15_lo = {a_15_1,a_15_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_15_hi = {a_15_3,a_15_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_15_lo = {b_15_1,b_15_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_15_hi = {b_15_3,b_15_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_16_lo = {a_16_1,a_16_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_16_hi = {a_16_3,a_16_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_16_lo = {b_16_1,b_16_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_16_hi = {b_16_3,b_16_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_17_lo = {a_17_1,a_17_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_17_hi = {a_17_3,a_17_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_17_lo = {b_17_1,b_17_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_17_hi = {b_17_3,b_17_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_18_lo = {a_18_1,a_18_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_18_hi = {a_18_3,a_18_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_18_lo = {b_18_1,b_18_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_18_hi = {b_18_3,b_18_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_19_lo = {a_19_1,a_19_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_19_hi = {a_19_3,a_19_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_19_lo = {b_19_1,b_19_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_19_hi = {b_19_3,b_19_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_20_lo = {a_20_1,a_20_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_20_hi = {a_20_3,a_20_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_20_lo = {b_20_1,b_20_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_20_hi = {b_20_3,b_20_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_21_lo = {a_21_1,a_21_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_21_hi = {a_21_3,a_21_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_21_lo = {b_21_1,b_21_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_21_hi = {b_21_3,b_21_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_22_lo = {a_22_1,a_22_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_22_hi = {a_22_3,a_22_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_22_lo = {b_22_1,b_22_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_22_hi = {b_22_3,b_22_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_23_lo = {a_23_1,a_23_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_23_hi = {a_23_3,a_23_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_23_lo = {b_23_1,b_23_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_23_hi = {b_23_3,b_23_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_24_lo = {a_24_1,a_24_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_24_hi = {a_24_3,a_24_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_24_lo = {b_24_1,b_24_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_24_hi = {b_24_3,b_24_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_25_lo = {a_25_1,a_25_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_25_hi = {a_25_3,a_25_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_25_lo = {b_25_1,b_25_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_25_hi = {b_25_3,b_25_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_26_lo = {a_26_1,a_26_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_26_hi = {a_26_3,a_26_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_26_lo = {b_26_1,b_26_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_26_hi = {b_26_3,b_26_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_27_lo = {a_27_1,a_27_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_27_hi = {a_27_3,a_27_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_27_lo = {b_27_1,b_27_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_27_hi = {b_27_3,b_27_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_28_lo = {a_28_1,a_28_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_28_hi = {a_28_3,a_28_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_28_lo = {b_28_1,b_28_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_28_hi = {b_28_3,b_28_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_29_lo = {a_29_1,a_29_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_29_hi = {a_29_3,a_29_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_29_lo = {b_29_1,b_29_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_29_hi = {b_29_3,b_29_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_30_lo = {a_30_1,a_30_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_30_hi = {a_30_3,a_30_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_30_lo = {b_30_1,b_30_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_30_hi = {b_30_3,b_30_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_31_lo = {a_31_1,a_31_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_31_hi = {a_31_3,a_31_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_31_lo = {b_31_1,b_31_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_31_hi = {b_31_3,b_31_2}; // @[Cat.scala 33:92]
  wire [7:0] io_out_activeMask_lo_lo = {active_7,active_6,active_5,active_4,active_3,active_2,active_1,active_0}; // @[Cat.scala 33:92]
  wire [15:0] io_out_activeMask_lo = {active_15,active_14,active_13,active_12,active_11,active_10,active_9,active_8,
    io_out_activeMask_lo_lo}; // @[Cat.scala 33:92]
  wire [7:0] io_out_activeMask_hi_lo = {active_23,active_22,active_21,active_20,active_19,active_18,active_17,active_16}
    ; // @[Cat.scala 33:92]
  wire [15:0] io_out_activeMask_hi = {active_31,active_30,active_29,active_28,active_27,active_26,active_25,active_24,
    io_out_activeMask_hi_lo}; // @[Cat.scala 33:92]
  assign io_out_op = op; // @[AecExecPort.scala 115:13]
  assign io_out_dtype = dtype; // @[AecExecPort.scala 116:16]
  assign io_out_activeMask = {io_out_activeMask_hi,io_out_activeMask_lo}; // @[Cat.scala 33:92]
  assign io_out_a_0 = {io_out_a_0_hi,io_out_a_0_lo}; // @[Cat.scala 33:92]
  assign io_out_a_1 = {io_out_a_1_hi,io_out_a_1_lo}; // @[Cat.scala 33:92]
  assign io_out_a_2 = {io_out_a_2_hi,io_out_a_2_lo}; // @[Cat.scala 33:92]
  assign io_out_a_3 = {io_out_a_3_hi,io_out_a_3_lo}; // @[Cat.scala 33:92]
  assign io_out_a_4 = {io_out_a_4_hi,io_out_a_4_lo}; // @[Cat.scala 33:92]
  assign io_out_a_5 = {io_out_a_5_hi,io_out_a_5_lo}; // @[Cat.scala 33:92]
  assign io_out_a_6 = {io_out_a_6_hi,io_out_a_6_lo}; // @[Cat.scala 33:92]
  assign io_out_a_7 = {io_out_a_7_hi,io_out_a_7_lo}; // @[Cat.scala 33:92]
  assign io_out_a_8 = {io_out_a_8_hi,io_out_a_8_lo}; // @[Cat.scala 33:92]
  assign io_out_a_9 = {io_out_a_9_hi,io_out_a_9_lo}; // @[Cat.scala 33:92]
  assign io_out_a_10 = {io_out_a_10_hi,io_out_a_10_lo}; // @[Cat.scala 33:92]
  assign io_out_a_11 = {io_out_a_11_hi,io_out_a_11_lo}; // @[Cat.scala 33:92]
  assign io_out_a_12 = {io_out_a_12_hi,io_out_a_12_lo}; // @[Cat.scala 33:92]
  assign io_out_a_13 = {io_out_a_13_hi,io_out_a_13_lo}; // @[Cat.scala 33:92]
  assign io_out_a_14 = {io_out_a_14_hi,io_out_a_14_lo}; // @[Cat.scala 33:92]
  assign io_out_a_15 = {io_out_a_15_hi,io_out_a_15_lo}; // @[Cat.scala 33:92]
  assign io_out_a_16 = {io_out_a_16_hi,io_out_a_16_lo}; // @[Cat.scala 33:92]
  assign io_out_a_17 = {io_out_a_17_hi,io_out_a_17_lo}; // @[Cat.scala 33:92]
  assign io_out_a_18 = {io_out_a_18_hi,io_out_a_18_lo}; // @[Cat.scala 33:92]
  assign io_out_a_19 = {io_out_a_19_hi,io_out_a_19_lo}; // @[Cat.scala 33:92]
  assign io_out_a_20 = {io_out_a_20_hi,io_out_a_20_lo}; // @[Cat.scala 33:92]
  assign io_out_a_21 = {io_out_a_21_hi,io_out_a_21_lo}; // @[Cat.scala 33:92]
  assign io_out_a_22 = {io_out_a_22_hi,io_out_a_22_lo}; // @[Cat.scala 33:92]
  assign io_out_a_23 = {io_out_a_23_hi,io_out_a_23_lo}; // @[Cat.scala 33:92]
  assign io_out_a_24 = {io_out_a_24_hi,io_out_a_24_lo}; // @[Cat.scala 33:92]
  assign io_out_a_25 = {io_out_a_25_hi,io_out_a_25_lo}; // @[Cat.scala 33:92]
  assign io_out_a_26 = {io_out_a_26_hi,io_out_a_26_lo}; // @[Cat.scala 33:92]
  assign io_out_a_27 = {io_out_a_27_hi,io_out_a_27_lo}; // @[Cat.scala 33:92]
  assign io_out_a_28 = {io_out_a_28_hi,io_out_a_28_lo}; // @[Cat.scala 33:92]
  assign io_out_a_29 = {io_out_a_29_hi,io_out_a_29_lo}; // @[Cat.scala 33:92]
  assign io_out_a_30 = {io_out_a_30_hi,io_out_a_30_lo}; // @[Cat.scala 33:92]
  assign io_out_a_31 = {io_out_a_31_hi,io_out_a_31_lo}; // @[Cat.scala 33:92]
  assign io_out_b_0 = {io_out_b_0_hi,io_out_b_0_lo}; // @[Cat.scala 33:92]
  assign io_out_b_1 = {io_out_b_1_hi,io_out_b_1_lo}; // @[Cat.scala 33:92]
  assign io_out_b_2 = {io_out_b_2_hi,io_out_b_2_lo}; // @[Cat.scala 33:92]
  assign io_out_b_3 = {io_out_b_3_hi,io_out_b_3_lo}; // @[Cat.scala 33:92]
  assign io_out_b_4 = {io_out_b_4_hi,io_out_b_4_lo}; // @[Cat.scala 33:92]
  assign io_out_b_5 = {io_out_b_5_hi,io_out_b_5_lo}; // @[Cat.scala 33:92]
  assign io_out_b_6 = {io_out_b_6_hi,io_out_b_6_lo}; // @[Cat.scala 33:92]
  assign io_out_b_7 = {io_out_b_7_hi,io_out_b_7_lo}; // @[Cat.scala 33:92]
  assign io_out_b_8 = {io_out_b_8_hi,io_out_b_8_lo}; // @[Cat.scala 33:92]
  assign io_out_b_9 = {io_out_b_9_hi,io_out_b_9_lo}; // @[Cat.scala 33:92]
  assign io_out_b_10 = {io_out_b_10_hi,io_out_b_10_lo}; // @[Cat.scala 33:92]
  assign io_out_b_11 = {io_out_b_11_hi,io_out_b_11_lo}; // @[Cat.scala 33:92]
  assign io_out_b_12 = {io_out_b_12_hi,io_out_b_12_lo}; // @[Cat.scala 33:92]
  assign io_out_b_13 = {io_out_b_13_hi,io_out_b_13_lo}; // @[Cat.scala 33:92]
  assign io_out_b_14 = {io_out_b_14_hi,io_out_b_14_lo}; // @[Cat.scala 33:92]
  assign io_out_b_15 = {io_out_b_15_hi,io_out_b_15_lo}; // @[Cat.scala 33:92]
  assign io_out_b_16 = {io_out_b_16_hi,io_out_b_16_lo}; // @[Cat.scala 33:92]
  assign io_out_b_17 = {io_out_b_17_hi,io_out_b_17_lo}; // @[Cat.scala 33:92]
  assign io_out_b_18 = {io_out_b_18_hi,io_out_b_18_lo}; // @[Cat.scala 33:92]
  assign io_out_b_19 = {io_out_b_19_hi,io_out_b_19_lo}; // @[Cat.scala 33:92]
  assign io_out_b_20 = {io_out_b_20_hi,io_out_b_20_lo}; // @[Cat.scala 33:92]
  assign io_out_b_21 = {io_out_b_21_hi,io_out_b_21_lo}; // @[Cat.scala 33:92]
  assign io_out_b_22 = {io_out_b_22_hi,io_out_b_22_lo}; // @[Cat.scala 33:92]
  assign io_out_b_23 = {io_out_b_23_hi,io_out_b_23_lo}; // @[Cat.scala 33:92]
  assign io_out_b_24 = {io_out_b_24_hi,io_out_b_24_lo}; // @[Cat.scala 33:92]
  assign io_out_b_25 = {io_out_b_25_hi,io_out_b_25_lo}; // @[Cat.scala 33:92]
  assign io_out_b_26 = {io_out_b_26_hi,io_out_b_26_lo}; // @[Cat.scala 33:92]
  assign io_out_b_27 = {io_out_b_27_hi,io_out_b_27_lo}; // @[Cat.scala 33:92]
  assign io_out_b_28 = {io_out_b_28_hi,io_out_b_28_lo}; // @[Cat.scala 33:92]
  assign io_out_b_29 = {io_out_b_29_hi,io_out_b_29_lo}; // @[Cat.scala 33:92]
  assign io_out_b_30 = {io_out_b_30_hi,io_out_b_30_lo}; // @[Cat.scala 33:92]
  assign io_out_b_31 = {io_out_b_31_hi,io_out_b_31_lo}; // @[Cat.scala 33:92]
  assign io_out_dest = dest; // @[AecExecPort.scala 117:15]
  always @(posedge clock) begin
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_0 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_1 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_2 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_3 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_4 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_5 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_6 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_7 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_8 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_9 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_10 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_0_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_0_11 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_0 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_1 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_2 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_3 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_4 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_5 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_6 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_7 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_8 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_9 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_10 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_1_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_1_11 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_0 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_1 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_2 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_3 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_4 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_5 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_6 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_7 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_8 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_9 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_10 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_2_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_2_11 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_0 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_1 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_2 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_3 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_4 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_5 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_6 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_7 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_8 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_9 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_10 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_3_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_3_11 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_0 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_1 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_2 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_3 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_4 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_5 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_6 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_7 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_8 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_9 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_10 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_4_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_4_11 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_0 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_1 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_2 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_3 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_4 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_5 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_6 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_7 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_8 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_9 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_10 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_5_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_5_11 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_0 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_1 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_2 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_3 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_4 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_5 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_6 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_7 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_8 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_9 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_10 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_6_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_6_11 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_0 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_1 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_2 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_3 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_4 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_5 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_6 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_7 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_8 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_9 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_10 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_7_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_7_11 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_0 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_1 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_2 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_3 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_4 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_5 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_6 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_7 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_8 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_9 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_10 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_8_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_8_11 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_0 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_1 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_2 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_3 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_4 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_5 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_6 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_7 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_8 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_9 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_10 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_9_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_9_11 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_0 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_1 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_2 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_3 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_4 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_5 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_6 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_7 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_8 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_9 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_10 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_10_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_10_11 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_0 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_1 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_2 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_3 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_4 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_5 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_6 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_7 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_8 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_9 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_10 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_11_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_11_11 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_0 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_1 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_2 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_3 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_4 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_5 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_6 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_7 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_8 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_9 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_10 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_12_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_12_11 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_0 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_1 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_2 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_3 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_4 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_5 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_6 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_7 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_8 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_9 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_10 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_13_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_13_11 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_0 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_1 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_2 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_3 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_4 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_5 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_6 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_7 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_8 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_9 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_10 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_14_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_14_11 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_0 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_1 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_2 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_3 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_4 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_5 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_6 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_7 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_8 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_9 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_10 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_15_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_15_11 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_0 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_1 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_2 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_3 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_4 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_5 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_6 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_7 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_8 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_9 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_10 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_16_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_16_11 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_0 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_1 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_2 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_3 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_4 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_5 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_6 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_7 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_8 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_9 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_10 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_17_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_17_11 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_0 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_1 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_2 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_3 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_4 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_5 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_6 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_7 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_8 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_9 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_10 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_18_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_18_11 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_0 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_1 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_2 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_3 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_4 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_5 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_6 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_7 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_8 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_9 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_10 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_19_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_19_11 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_0 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_1 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_2 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_3 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_4 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_5 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_6 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_7 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_8 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_9 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_10 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_20_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_20_11 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_0 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_1 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_2 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_3 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_4 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_5 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_6 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_7 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_8 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_9 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_10 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_21_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_21_11 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_0 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_1 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_2 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_3 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_4 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_5 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_6 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_7 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_8 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_9 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_10 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_22_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_22_11 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_0 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_1 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_2 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_3 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_4 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_5 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_6 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_7 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_8 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_9 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_10 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_23_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_23_11 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_0 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_1 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_2 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_3 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_4 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_5 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_6 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_7 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_8 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_9 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_10 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_24_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_24_11 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_0 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_1 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_2 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_3 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_4 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_5 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_6 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_7 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_8 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_9 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_10 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_25_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_25_11 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_0 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_1 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_2 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_3 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_4 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_5 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_6 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_7 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_8 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_9 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_10 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_26_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_26_11 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_0 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_1 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_2 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_3 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_4 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_5 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_6 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_7 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_8 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_9 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_10 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_27_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_27_11 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_0 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_1 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_2 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_3 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_4 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_5 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_6 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_7 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_8 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_9 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_10 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_28_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_28_11 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_0 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_1 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_2 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_3 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_4 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_5 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_6 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_7 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_8 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_9 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_10 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_29_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_29_11 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_0 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_1 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_2 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_3 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_4 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_5 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_6 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_7 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_8 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_9 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_10 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_30_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_30_11 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_0 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_0 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_1 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_1 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_2 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_2 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_3 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_3 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_4 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_4 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_5 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_5 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_6 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_6 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_7 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_7 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_8 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_8 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_9 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_9 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_10 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_10 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 74:31]
      operandCapture_31_11 <= 1'h0; // @[AecExecPort.scala 74:31]
    end else begin
      operandCapture_31_11 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_0 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_0 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_1 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_1 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_2 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_2 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_3 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_3 <= io_arm_0;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_4 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_4 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_5 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_5 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_6 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_6 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_7 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_7 <= io_arm_1;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_8 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_8 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_9 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_9 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_10 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_10 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_11 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_11 <= io_arm_2;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_12 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_12 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_13 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_13 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_14 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_14 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_15 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_15 <= io_arm_3;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_16 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_16 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_17 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_17 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_18 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_18 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_19 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_19 <= io_arm_4;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_20 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_20 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_21 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_21 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_22 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_22 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_23 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_23 <= io_arm_5;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_24 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_24 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_25 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_25 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_26 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_26 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_27 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_27 <= io_arm_6;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_28 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_28 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_29 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_29 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_30 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_30 <= io_arm_7;
    end
    if (reset) begin // @[AecExecPort.scala 76:28]
      maskCapture_31 <= 1'h0; // @[AecExecPort.scala 76:28]
    end else begin
      maskCapture_31 <= io_arm_7;
    end
    if (operandCapture_0_0) begin // @[AecExecPort.scala 92:38]
      a_0_0 <= io_in_a_0[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_0_1) begin // @[AecExecPort.scala 92:38]
      a_0_1 <= io_in_a_0[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_0_2) begin // @[AecExecPort.scala 92:38]
      a_0_2 <= io_in_a_0[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_0_3) begin // @[AecExecPort.scala 92:38]
      a_0_3 <= io_in_a_0[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_1_0) begin // @[AecExecPort.scala 92:38]
      a_1_0 <= io_in_a_1[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_1_1) begin // @[AecExecPort.scala 92:38]
      a_1_1 <= io_in_a_1[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_1_2) begin // @[AecExecPort.scala 92:38]
      a_1_2 <= io_in_a_1[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_1_3) begin // @[AecExecPort.scala 92:38]
      a_1_3 <= io_in_a_1[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_2_0) begin // @[AecExecPort.scala 92:38]
      a_2_0 <= io_in_a_2[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_2_1) begin // @[AecExecPort.scala 92:38]
      a_2_1 <= io_in_a_2[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_2_2) begin // @[AecExecPort.scala 92:38]
      a_2_2 <= io_in_a_2[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_2_3) begin // @[AecExecPort.scala 92:38]
      a_2_3 <= io_in_a_2[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_3_0) begin // @[AecExecPort.scala 92:38]
      a_3_0 <= io_in_a_3[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_3_1) begin // @[AecExecPort.scala 92:38]
      a_3_1 <= io_in_a_3[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_3_2) begin // @[AecExecPort.scala 92:38]
      a_3_2 <= io_in_a_3[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_3_3) begin // @[AecExecPort.scala 92:38]
      a_3_3 <= io_in_a_3[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_4_0) begin // @[AecExecPort.scala 92:38]
      a_4_0 <= io_in_a_4[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_4_1) begin // @[AecExecPort.scala 92:38]
      a_4_1 <= io_in_a_4[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_4_2) begin // @[AecExecPort.scala 92:38]
      a_4_2 <= io_in_a_4[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_4_3) begin // @[AecExecPort.scala 92:38]
      a_4_3 <= io_in_a_4[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_5_0) begin // @[AecExecPort.scala 92:38]
      a_5_0 <= io_in_a_5[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_5_1) begin // @[AecExecPort.scala 92:38]
      a_5_1 <= io_in_a_5[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_5_2) begin // @[AecExecPort.scala 92:38]
      a_5_2 <= io_in_a_5[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_5_3) begin // @[AecExecPort.scala 92:38]
      a_5_3 <= io_in_a_5[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_6_0) begin // @[AecExecPort.scala 92:38]
      a_6_0 <= io_in_a_6[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_6_1) begin // @[AecExecPort.scala 92:38]
      a_6_1 <= io_in_a_6[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_6_2) begin // @[AecExecPort.scala 92:38]
      a_6_2 <= io_in_a_6[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_6_3) begin // @[AecExecPort.scala 92:38]
      a_6_3 <= io_in_a_6[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_7_0) begin // @[AecExecPort.scala 92:38]
      a_7_0 <= io_in_a_7[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_7_1) begin // @[AecExecPort.scala 92:38]
      a_7_1 <= io_in_a_7[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_7_2) begin // @[AecExecPort.scala 92:38]
      a_7_2 <= io_in_a_7[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_7_3) begin // @[AecExecPort.scala 92:38]
      a_7_3 <= io_in_a_7[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_8_0) begin // @[AecExecPort.scala 92:38]
      a_8_0 <= io_in_a_8[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_8_1) begin // @[AecExecPort.scala 92:38]
      a_8_1 <= io_in_a_8[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_8_2) begin // @[AecExecPort.scala 92:38]
      a_8_2 <= io_in_a_8[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_8_3) begin // @[AecExecPort.scala 92:38]
      a_8_3 <= io_in_a_8[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_9_0) begin // @[AecExecPort.scala 92:38]
      a_9_0 <= io_in_a_9[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_9_1) begin // @[AecExecPort.scala 92:38]
      a_9_1 <= io_in_a_9[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_9_2) begin // @[AecExecPort.scala 92:38]
      a_9_2 <= io_in_a_9[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_9_3) begin // @[AecExecPort.scala 92:38]
      a_9_3 <= io_in_a_9[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_10_0) begin // @[AecExecPort.scala 92:38]
      a_10_0 <= io_in_a_10[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_10_1) begin // @[AecExecPort.scala 92:38]
      a_10_1 <= io_in_a_10[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_10_2) begin // @[AecExecPort.scala 92:38]
      a_10_2 <= io_in_a_10[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_10_3) begin // @[AecExecPort.scala 92:38]
      a_10_3 <= io_in_a_10[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_11_0) begin // @[AecExecPort.scala 92:38]
      a_11_0 <= io_in_a_11[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_11_1) begin // @[AecExecPort.scala 92:38]
      a_11_1 <= io_in_a_11[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_11_2) begin // @[AecExecPort.scala 92:38]
      a_11_2 <= io_in_a_11[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_11_3) begin // @[AecExecPort.scala 92:38]
      a_11_3 <= io_in_a_11[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_12_0) begin // @[AecExecPort.scala 92:38]
      a_12_0 <= io_in_a_12[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_12_1) begin // @[AecExecPort.scala 92:38]
      a_12_1 <= io_in_a_12[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_12_2) begin // @[AecExecPort.scala 92:38]
      a_12_2 <= io_in_a_12[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_12_3) begin // @[AecExecPort.scala 92:38]
      a_12_3 <= io_in_a_12[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_13_0) begin // @[AecExecPort.scala 92:38]
      a_13_0 <= io_in_a_13[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_13_1) begin // @[AecExecPort.scala 92:38]
      a_13_1 <= io_in_a_13[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_13_2) begin // @[AecExecPort.scala 92:38]
      a_13_2 <= io_in_a_13[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_13_3) begin // @[AecExecPort.scala 92:38]
      a_13_3 <= io_in_a_13[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_14_0) begin // @[AecExecPort.scala 92:38]
      a_14_0 <= io_in_a_14[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_14_1) begin // @[AecExecPort.scala 92:38]
      a_14_1 <= io_in_a_14[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_14_2) begin // @[AecExecPort.scala 92:38]
      a_14_2 <= io_in_a_14[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_14_3) begin // @[AecExecPort.scala 92:38]
      a_14_3 <= io_in_a_14[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_15_0) begin // @[AecExecPort.scala 92:38]
      a_15_0 <= io_in_a_15[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_15_1) begin // @[AecExecPort.scala 92:38]
      a_15_1 <= io_in_a_15[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_15_2) begin // @[AecExecPort.scala 92:38]
      a_15_2 <= io_in_a_15[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_15_3) begin // @[AecExecPort.scala 92:38]
      a_15_3 <= io_in_a_15[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_16_0) begin // @[AecExecPort.scala 92:38]
      a_16_0 <= io_in_a_16[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_16_1) begin // @[AecExecPort.scala 92:38]
      a_16_1 <= io_in_a_16[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_16_2) begin // @[AecExecPort.scala 92:38]
      a_16_2 <= io_in_a_16[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_16_3) begin // @[AecExecPort.scala 92:38]
      a_16_3 <= io_in_a_16[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_17_0) begin // @[AecExecPort.scala 92:38]
      a_17_0 <= io_in_a_17[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_17_1) begin // @[AecExecPort.scala 92:38]
      a_17_1 <= io_in_a_17[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_17_2) begin // @[AecExecPort.scala 92:38]
      a_17_2 <= io_in_a_17[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_17_3) begin // @[AecExecPort.scala 92:38]
      a_17_3 <= io_in_a_17[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_18_0) begin // @[AecExecPort.scala 92:38]
      a_18_0 <= io_in_a_18[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_18_1) begin // @[AecExecPort.scala 92:38]
      a_18_1 <= io_in_a_18[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_18_2) begin // @[AecExecPort.scala 92:38]
      a_18_2 <= io_in_a_18[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_18_3) begin // @[AecExecPort.scala 92:38]
      a_18_3 <= io_in_a_18[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_19_0) begin // @[AecExecPort.scala 92:38]
      a_19_0 <= io_in_a_19[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_19_1) begin // @[AecExecPort.scala 92:38]
      a_19_1 <= io_in_a_19[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_19_2) begin // @[AecExecPort.scala 92:38]
      a_19_2 <= io_in_a_19[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_19_3) begin // @[AecExecPort.scala 92:38]
      a_19_3 <= io_in_a_19[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_20_0) begin // @[AecExecPort.scala 92:38]
      a_20_0 <= io_in_a_20[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_20_1) begin // @[AecExecPort.scala 92:38]
      a_20_1 <= io_in_a_20[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_20_2) begin // @[AecExecPort.scala 92:38]
      a_20_2 <= io_in_a_20[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_20_3) begin // @[AecExecPort.scala 92:38]
      a_20_3 <= io_in_a_20[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_21_0) begin // @[AecExecPort.scala 92:38]
      a_21_0 <= io_in_a_21[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_21_1) begin // @[AecExecPort.scala 92:38]
      a_21_1 <= io_in_a_21[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_21_2) begin // @[AecExecPort.scala 92:38]
      a_21_2 <= io_in_a_21[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_21_3) begin // @[AecExecPort.scala 92:38]
      a_21_3 <= io_in_a_21[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_22_0) begin // @[AecExecPort.scala 92:38]
      a_22_0 <= io_in_a_22[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_22_1) begin // @[AecExecPort.scala 92:38]
      a_22_1 <= io_in_a_22[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_22_2) begin // @[AecExecPort.scala 92:38]
      a_22_2 <= io_in_a_22[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_22_3) begin // @[AecExecPort.scala 92:38]
      a_22_3 <= io_in_a_22[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_23_0) begin // @[AecExecPort.scala 92:38]
      a_23_0 <= io_in_a_23[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_23_1) begin // @[AecExecPort.scala 92:38]
      a_23_1 <= io_in_a_23[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_23_2) begin // @[AecExecPort.scala 92:38]
      a_23_2 <= io_in_a_23[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_23_3) begin // @[AecExecPort.scala 92:38]
      a_23_3 <= io_in_a_23[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_24_0) begin // @[AecExecPort.scala 92:38]
      a_24_0 <= io_in_a_24[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_24_1) begin // @[AecExecPort.scala 92:38]
      a_24_1 <= io_in_a_24[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_24_2) begin // @[AecExecPort.scala 92:38]
      a_24_2 <= io_in_a_24[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_24_3) begin // @[AecExecPort.scala 92:38]
      a_24_3 <= io_in_a_24[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_25_0) begin // @[AecExecPort.scala 92:38]
      a_25_0 <= io_in_a_25[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_25_1) begin // @[AecExecPort.scala 92:38]
      a_25_1 <= io_in_a_25[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_25_2) begin // @[AecExecPort.scala 92:38]
      a_25_2 <= io_in_a_25[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_25_3) begin // @[AecExecPort.scala 92:38]
      a_25_3 <= io_in_a_25[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_26_0) begin // @[AecExecPort.scala 92:38]
      a_26_0 <= io_in_a_26[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_26_1) begin // @[AecExecPort.scala 92:38]
      a_26_1 <= io_in_a_26[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_26_2) begin // @[AecExecPort.scala 92:38]
      a_26_2 <= io_in_a_26[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_26_3) begin // @[AecExecPort.scala 92:38]
      a_26_3 <= io_in_a_26[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_27_0) begin // @[AecExecPort.scala 92:38]
      a_27_0 <= io_in_a_27[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_27_1) begin // @[AecExecPort.scala 92:38]
      a_27_1 <= io_in_a_27[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_27_2) begin // @[AecExecPort.scala 92:38]
      a_27_2 <= io_in_a_27[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_27_3) begin // @[AecExecPort.scala 92:38]
      a_27_3 <= io_in_a_27[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_28_0) begin // @[AecExecPort.scala 92:38]
      a_28_0 <= io_in_a_28[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_28_1) begin // @[AecExecPort.scala 92:38]
      a_28_1 <= io_in_a_28[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_28_2) begin // @[AecExecPort.scala 92:38]
      a_28_2 <= io_in_a_28[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_28_3) begin // @[AecExecPort.scala 92:38]
      a_28_3 <= io_in_a_28[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_29_0) begin // @[AecExecPort.scala 92:38]
      a_29_0 <= io_in_a_29[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_29_1) begin // @[AecExecPort.scala 92:38]
      a_29_1 <= io_in_a_29[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_29_2) begin // @[AecExecPort.scala 92:38]
      a_29_2 <= io_in_a_29[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_29_3) begin // @[AecExecPort.scala 92:38]
      a_29_3 <= io_in_a_29[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_30_0) begin // @[AecExecPort.scala 92:38]
      a_30_0 <= io_in_a_30[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_30_1) begin // @[AecExecPort.scala 92:38]
      a_30_1 <= io_in_a_30[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_30_2) begin // @[AecExecPort.scala 92:38]
      a_30_2 <= io_in_a_30[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_30_3) begin // @[AecExecPort.scala 92:38]
      a_30_3 <= io_in_a_30[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_31_0) begin // @[AecExecPort.scala 92:38]
      a_31_0 <= io_in_a_31[15:0]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_31_1) begin // @[AecExecPort.scala 92:38]
      a_31_1 <= io_in_a_31[31:16]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_31_2) begin // @[AecExecPort.scala 92:38]
      a_31_2 <= io_in_a_31[47:32]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_31_3) begin // @[AecExecPort.scala 92:38]
      a_31_3 <= io_in_a_31[63:48]; // @[AecExecPort.scala 92:51]
    end
    if (operandCapture_0_4) begin // @[AecExecPort.scala 93:56]
      b_0_0 <= io_in_b_0[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_0_5) begin // @[AecExecPort.scala 93:56]
      b_0_1 <= io_in_b_0[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_0_6) begin // @[AecExecPort.scala 93:56]
      b_0_2 <= io_in_b_0[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_0_7) begin // @[AecExecPort.scala 93:56]
      b_0_3 <= io_in_b_0[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_1_4) begin // @[AecExecPort.scala 93:56]
      b_1_0 <= io_in_b_1[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_1_5) begin // @[AecExecPort.scala 93:56]
      b_1_1 <= io_in_b_1[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_1_6) begin // @[AecExecPort.scala 93:56]
      b_1_2 <= io_in_b_1[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_1_7) begin // @[AecExecPort.scala 93:56]
      b_1_3 <= io_in_b_1[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_2_4) begin // @[AecExecPort.scala 93:56]
      b_2_0 <= io_in_b_2[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_2_5) begin // @[AecExecPort.scala 93:56]
      b_2_1 <= io_in_b_2[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_2_6) begin // @[AecExecPort.scala 93:56]
      b_2_2 <= io_in_b_2[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_2_7) begin // @[AecExecPort.scala 93:56]
      b_2_3 <= io_in_b_2[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_3_4) begin // @[AecExecPort.scala 93:56]
      b_3_0 <= io_in_b_3[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_3_5) begin // @[AecExecPort.scala 93:56]
      b_3_1 <= io_in_b_3[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_3_6) begin // @[AecExecPort.scala 93:56]
      b_3_2 <= io_in_b_3[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_3_7) begin // @[AecExecPort.scala 93:56]
      b_3_3 <= io_in_b_3[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_4_4) begin // @[AecExecPort.scala 93:56]
      b_4_0 <= io_in_b_4[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_4_5) begin // @[AecExecPort.scala 93:56]
      b_4_1 <= io_in_b_4[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_4_6) begin // @[AecExecPort.scala 93:56]
      b_4_2 <= io_in_b_4[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_4_7) begin // @[AecExecPort.scala 93:56]
      b_4_3 <= io_in_b_4[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_5_4) begin // @[AecExecPort.scala 93:56]
      b_5_0 <= io_in_b_5[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_5_5) begin // @[AecExecPort.scala 93:56]
      b_5_1 <= io_in_b_5[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_5_6) begin // @[AecExecPort.scala 93:56]
      b_5_2 <= io_in_b_5[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_5_7) begin // @[AecExecPort.scala 93:56]
      b_5_3 <= io_in_b_5[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_6_4) begin // @[AecExecPort.scala 93:56]
      b_6_0 <= io_in_b_6[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_6_5) begin // @[AecExecPort.scala 93:56]
      b_6_1 <= io_in_b_6[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_6_6) begin // @[AecExecPort.scala 93:56]
      b_6_2 <= io_in_b_6[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_6_7) begin // @[AecExecPort.scala 93:56]
      b_6_3 <= io_in_b_6[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_7_4) begin // @[AecExecPort.scala 93:56]
      b_7_0 <= io_in_b_7[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_7_5) begin // @[AecExecPort.scala 93:56]
      b_7_1 <= io_in_b_7[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_7_6) begin // @[AecExecPort.scala 93:56]
      b_7_2 <= io_in_b_7[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_7_7) begin // @[AecExecPort.scala 93:56]
      b_7_3 <= io_in_b_7[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_8_4) begin // @[AecExecPort.scala 93:56]
      b_8_0 <= io_in_b_8[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_8_5) begin // @[AecExecPort.scala 93:56]
      b_8_1 <= io_in_b_8[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_8_6) begin // @[AecExecPort.scala 93:56]
      b_8_2 <= io_in_b_8[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_8_7) begin // @[AecExecPort.scala 93:56]
      b_8_3 <= io_in_b_8[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_9_4) begin // @[AecExecPort.scala 93:56]
      b_9_0 <= io_in_b_9[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_9_5) begin // @[AecExecPort.scala 93:56]
      b_9_1 <= io_in_b_9[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_9_6) begin // @[AecExecPort.scala 93:56]
      b_9_2 <= io_in_b_9[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_9_7) begin // @[AecExecPort.scala 93:56]
      b_9_3 <= io_in_b_9[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_10_4) begin // @[AecExecPort.scala 93:56]
      b_10_0 <= io_in_b_10[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_10_5) begin // @[AecExecPort.scala 93:56]
      b_10_1 <= io_in_b_10[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_10_6) begin // @[AecExecPort.scala 93:56]
      b_10_2 <= io_in_b_10[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_10_7) begin // @[AecExecPort.scala 93:56]
      b_10_3 <= io_in_b_10[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_11_4) begin // @[AecExecPort.scala 93:56]
      b_11_0 <= io_in_b_11[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_11_5) begin // @[AecExecPort.scala 93:56]
      b_11_1 <= io_in_b_11[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_11_6) begin // @[AecExecPort.scala 93:56]
      b_11_2 <= io_in_b_11[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_11_7) begin // @[AecExecPort.scala 93:56]
      b_11_3 <= io_in_b_11[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_12_4) begin // @[AecExecPort.scala 93:56]
      b_12_0 <= io_in_b_12[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_12_5) begin // @[AecExecPort.scala 93:56]
      b_12_1 <= io_in_b_12[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_12_6) begin // @[AecExecPort.scala 93:56]
      b_12_2 <= io_in_b_12[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_12_7) begin // @[AecExecPort.scala 93:56]
      b_12_3 <= io_in_b_12[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_13_4) begin // @[AecExecPort.scala 93:56]
      b_13_0 <= io_in_b_13[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_13_5) begin // @[AecExecPort.scala 93:56]
      b_13_1 <= io_in_b_13[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_13_6) begin // @[AecExecPort.scala 93:56]
      b_13_2 <= io_in_b_13[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_13_7) begin // @[AecExecPort.scala 93:56]
      b_13_3 <= io_in_b_13[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_14_4) begin // @[AecExecPort.scala 93:56]
      b_14_0 <= io_in_b_14[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_14_5) begin // @[AecExecPort.scala 93:56]
      b_14_1 <= io_in_b_14[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_14_6) begin // @[AecExecPort.scala 93:56]
      b_14_2 <= io_in_b_14[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_14_7) begin // @[AecExecPort.scala 93:56]
      b_14_3 <= io_in_b_14[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_15_4) begin // @[AecExecPort.scala 93:56]
      b_15_0 <= io_in_b_15[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_15_5) begin // @[AecExecPort.scala 93:56]
      b_15_1 <= io_in_b_15[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_15_6) begin // @[AecExecPort.scala 93:56]
      b_15_2 <= io_in_b_15[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_15_7) begin // @[AecExecPort.scala 93:56]
      b_15_3 <= io_in_b_15[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_16_4) begin // @[AecExecPort.scala 93:56]
      b_16_0 <= io_in_b_16[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_16_5) begin // @[AecExecPort.scala 93:56]
      b_16_1 <= io_in_b_16[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_16_6) begin // @[AecExecPort.scala 93:56]
      b_16_2 <= io_in_b_16[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_16_7) begin // @[AecExecPort.scala 93:56]
      b_16_3 <= io_in_b_16[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_17_4) begin // @[AecExecPort.scala 93:56]
      b_17_0 <= io_in_b_17[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_17_5) begin // @[AecExecPort.scala 93:56]
      b_17_1 <= io_in_b_17[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_17_6) begin // @[AecExecPort.scala 93:56]
      b_17_2 <= io_in_b_17[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_17_7) begin // @[AecExecPort.scala 93:56]
      b_17_3 <= io_in_b_17[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_18_4) begin // @[AecExecPort.scala 93:56]
      b_18_0 <= io_in_b_18[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_18_5) begin // @[AecExecPort.scala 93:56]
      b_18_1 <= io_in_b_18[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_18_6) begin // @[AecExecPort.scala 93:56]
      b_18_2 <= io_in_b_18[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_18_7) begin // @[AecExecPort.scala 93:56]
      b_18_3 <= io_in_b_18[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_19_4) begin // @[AecExecPort.scala 93:56]
      b_19_0 <= io_in_b_19[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_19_5) begin // @[AecExecPort.scala 93:56]
      b_19_1 <= io_in_b_19[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_19_6) begin // @[AecExecPort.scala 93:56]
      b_19_2 <= io_in_b_19[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_19_7) begin // @[AecExecPort.scala 93:56]
      b_19_3 <= io_in_b_19[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_20_4) begin // @[AecExecPort.scala 93:56]
      b_20_0 <= io_in_b_20[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_20_5) begin // @[AecExecPort.scala 93:56]
      b_20_1 <= io_in_b_20[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_20_6) begin // @[AecExecPort.scala 93:56]
      b_20_2 <= io_in_b_20[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_20_7) begin // @[AecExecPort.scala 93:56]
      b_20_3 <= io_in_b_20[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_21_4) begin // @[AecExecPort.scala 93:56]
      b_21_0 <= io_in_b_21[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_21_5) begin // @[AecExecPort.scala 93:56]
      b_21_1 <= io_in_b_21[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_21_6) begin // @[AecExecPort.scala 93:56]
      b_21_2 <= io_in_b_21[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_21_7) begin // @[AecExecPort.scala 93:56]
      b_21_3 <= io_in_b_21[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_22_4) begin // @[AecExecPort.scala 93:56]
      b_22_0 <= io_in_b_22[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_22_5) begin // @[AecExecPort.scala 93:56]
      b_22_1 <= io_in_b_22[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_22_6) begin // @[AecExecPort.scala 93:56]
      b_22_2 <= io_in_b_22[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_22_7) begin // @[AecExecPort.scala 93:56]
      b_22_3 <= io_in_b_22[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_23_4) begin // @[AecExecPort.scala 93:56]
      b_23_0 <= io_in_b_23[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_23_5) begin // @[AecExecPort.scala 93:56]
      b_23_1 <= io_in_b_23[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_23_6) begin // @[AecExecPort.scala 93:56]
      b_23_2 <= io_in_b_23[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_23_7) begin // @[AecExecPort.scala 93:56]
      b_23_3 <= io_in_b_23[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_24_4) begin // @[AecExecPort.scala 93:56]
      b_24_0 <= io_in_b_24[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_24_5) begin // @[AecExecPort.scala 93:56]
      b_24_1 <= io_in_b_24[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_24_6) begin // @[AecExecPort.scala 93:56]
      b_24_2 <= io_in_b_24[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_24_7) begin // @[AecExecPort.scala 93:56]
      b_24_3 <= io_in_b_24[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_25_4) begin // @[AecExecPort.scala 93:56]
      b_25_0 <= io_in_b_25[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_25_5) begin // @[AecExecPort.scala 93:56]
      b_25_1 <= io_in_b_25[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_25_6) begin // @[AecExecPort.scala 93:56]
      b_25_2 <= io_in_b_25[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_25_7) begin // @[AecExecPort.scala 93:56]
      b_25_3 <= io_in_b_25[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_26_4) begin // @[AecExecPort.scala 93:56]
      b_26_0 <= io_in_b_26[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_26_5) begin // @[AecExecPort.scala 93:56]
      b_26_1 <= io_in_b_26[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_26_6) begin // @[AecExecPort.scala 93:56]
      b_26_2 <= io_in_b_26[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_26_7) begin // @[AecExecPort.scala 93:56]
      b_26_3 <= io_in_b_26[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_27_4) begin // @[AecExecPort.scala 93:56]
      b_27_0 <= io_in_b_27[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_27_5) begin // @[AecExecPort.scala 93:56]
      b_27_1 <= io_in_b_27[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_27_6) begin // @[AecExecPort.scala 93:56]
      b_27_2 <= io_in_b_27[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_27_7) begin // @[AecExecPort.scala 93:56]
      b_27_3 <= io_in_b_27[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_28_4) begin // @[AecExecPort.scala 93:56]
      b_28_0 <= io_in_b_28[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_28_5) begin // @[AecExecPort.scala 93:56]
      b_28_1 <= io_in_b_28[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_28_6) begin // @[AecExecPort.scala 93:56]
      b_28_2 <= io_in_b_28[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_28_7) begin // @[AecExecPort.scala 93:56]
      b_28_3 <= io_in_b_28[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_29_4) begin // @[AecExecPort.scala 93:56]
      b_29_0 <= io_in_b_29[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_29_5) begin // @[AecExecPort.scala 93:56]
      b_29_1 <= io_in_b_29[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_29_6) begin // @[AecExecPort.scala 93:56]
      b_29_2 <= io_in_b_29[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_29_7) begin // @[AecExecPort.scala 93:56]
      b_29_3 <= io_in_b_29[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_30_4) begin // @[AecExecPort.scala 93:56]
      b_30_0 <= io_in_b_30[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_30_5) begin // @[AecExecPort.scala 93:56]
      b_30_1 <= io_in_b_30[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_30_6) begin // @[AecExecPort.scala 93:56]
      b_30_2 <= io_in_b_30[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_30_7) begin // @[AecExecPort.scala 93:56]
      b_30_3 <= io_in_b_30[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_31_4) begin // @[AecExecPort.scala 93:56]
      b_31_0 <= io_in_b_31[15:0]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_31_5) begin // @[AecExecPort.scala 93:56]
      b_31_1 <= io_in_b_31[31:16]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_31_6) begin // @[AecExecPort.scala 93:56]
      b_31_2 <= io_in_b_31[47:32]; // @[AecExecPort.scala 93:69]
    end
    if (operandCapture_31_7) begin // @[AecExecPort.scala 93:56]
      b_31_3 <= io_in_b_31[63:48]; // @[AecExecPort.scala 93:69]
    end
    if (maskCapture_0) begin // @[AecExecPort.scala 96:27]
      active_0 <= io_in_activeMask[0]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_1) begin // @[AecExecPort.scala 96:27]
      active_1 <= io_in_activeMask[1]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_2) begin // @[AecExecPort.scala 96:27]
      active_2 <= io_in_activeMask[2]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_3) begin // @[AecExecPort.scala 96:27]
      active_3 <= io_in_activeMask[3]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_4) begin // @[AecExecPort.scala 96:27]
      active_4 <= io_in_activeMask[4]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_5) begin // @[AecExecPort.scala 96:27]
      active_5 <= io_in_activeMask[5]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_6) begin // @[AecExecPort.scala 96:27]
      active_6 <= io_in_activeMask[6]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_7) begin // @[AecExecPort.scala 96:27]
      active_7 <= io_in_activeMask[7]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_8) begin // @[AecExecPort.scala 96:27]
      active_8 <= io_in_activeMask[8]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_9) begin // @[AecExecPort.scala 96:27]
      active_9 <= io_in_activeMask[9]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_10) begin // @[AecExecPort.scala 96:27]
      active_10 <= io_in_activeMask[10]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_11) begin // @[AecExecPort.scala 96:27]
      active_11 <= io_in_activeMask[11]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_12) begin // @[AecExecPort.scala 96:27]
      active_12 <= io_in_activeMask[12]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_13) begin // @[AecExecPort.scala 96:27]
      active_13 <= io_in_activeMask[13]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_14) begin // @[AecExecPort.scala 96:27]
      active_14 <= io_in_activeMask[14]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_15) begin // @[AecExecPort.scala 96:27]
      active_15 <= io_in_activeMask[15]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_16) begin // @[AecExecPort.scala 96:27]
      active_16 <= io_in_activeMask[16]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_17) begin // @[AecExecPort.scala 96:27]
      active_17 <= io_in_activeMask[17]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_18) begin // @[AecExecPort.scala 96:27]
      active_18 <= io_in_activeMask[18]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_19) begin // @[AecExecPort.scala 96:27]
      active_19 <= io_in_activeMask[19]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_20) begin // @[AecExecPort.scala 96:27]
      active_20 <= io_in_activeMask[20]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_21) begin // @[AecExecPort.scala 96:27]
      active_21 <= io_in_activeMask[21]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_22) begin // @[AecExecPort.scala 96:27]
      active_22 <= io_in_activeMask[22]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_23) begin // @[AecExecPort.scala 96:27]
      active_23 <= io_in_activeMask[23]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_24) begin // @[AecExecPort.scala 96:27]
      active_24 <= io_in_activeMask[24]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_25) begin // @[AecExecPort.scala 96:27]
      active_25 <= io_in_activeMask[25]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_26) begin // @[AecExecPort.scala 96:27]
      active_26 <= io_in_activeMask[26]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_27) begin // @[AecExecPort.scala 96:27]
      active_27 <= io_in_activeMask[27]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_28) begin // @[AecExecPort.scala 96:27]
      active_28 <= io_in_activeMask[28]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_29) begin // @[AecExecPort.scala 96:27]
      active_29 <= io_in_activeMask[29]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_30) begin // @[AecExecPort.scala 96:27]
      active_30 <= io_in_activeMask[30]; // @[AecExecPort.scala 97:17]
    end
    if (maskCapture_31) begin // @[AecExecPort.scala 96:27]
      active_31 <= io_in_activeMask[31]; // @[AecExecPort.scala 97:17]
    end
    if (io_capture) begin // @[AecExecPort.scala 108:21]
      op <= io_in_op; // @[AecExecPort.scala 109:8]
    end
    if (io_capture) begin // @[AecExecPort.scala 108:21]
      dtype <= io_in_dtype; // @[AecExecPort.scala 110:11]
    end
    if (io_capture) begin // @[AecExecPort.scala 108:21]
      dest <= io_in_dest; // @[AecExecPort.scala 111:10]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  operandCapture_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  operandCapture_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  operandCapture_0_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  operandCapture_0_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  operandCapture_0_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  operandCapture_0_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  operandCapture_0_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  operandCapture_0_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  operandCapture_0_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  operandCapture_0_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  operandCapture_0_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  operandCapture_0_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  operandCapture_1_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  operandCapture_1_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  operandCapture_1_2 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  operandCapture_1_3 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  operandCapture_1_4 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  operandCapture_1_5 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  operandCapture_1_6 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  operandCapture_1_7 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  operandCapture_1_8 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  operandCapture_1_9 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  operandCapture_1_10 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  operandCapture_1_11 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  operandCapture_2_0 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  operandCapture_2_1 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  operandCapture_2_2 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  operandCapture_2_3 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  operandCapture_2_4 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  operandCapture_2_5 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  operandCapture_2_6 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  operandCapture_2_7 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  operandCapture_2_8 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  operandCapture_2_9 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  operandCapture_2_10 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  operandCapture_2_11 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  operandCapture_3_0 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  operandCapture_3_1 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  operandCapture_3_2 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  operandCapture_3_3 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  operandCapture_3_4 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  operandCapture_3_5 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  operandCapture_3_6 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  operandCapture_3_7 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  operandCapture_3_8 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  operandCapture_3_9 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  operandCapture_3_10 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  operandCapture_3_11 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  operandCapture_4_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  operandCapture_4_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  operandCapture_4_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  operandCapture_4_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  operandCapture_4_4 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  operandCapture_4_5 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  operandCapture_4_6 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  operandCapture_4_7 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  operandCapture_4_8 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  operandCapture_4_9 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  operandCapture_4_10 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  operandCapture_4_11 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  operandCapture_5_0 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  operandCapture_5_1 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  operandCapture_5_2 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  operandCapture_5_3 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  operandCapture_5_4 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  operandCapture_5_5 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  operandCapture_5_6 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  operandCapture_5_7 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  operandCapture_5_8 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  operandCapture_5_9 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  operandCapture_5_10 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  operandCapture_5_11 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  operandCapture_6_0 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  operandCapture_6_1 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  operandCapture_6_2 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  operandCapture_6_3 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  operandCapture_6_4 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  operandCapture_6_5 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  operandCapture_6_6 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  operandCapture_6_7 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  operandCapture_6_8 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  operandCapture_6_9 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  operandCapture_6_10 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  operandCapture_6_11 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  operandCapture_7_0 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  operandCapture_7_1 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  operandCapture_7_2 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  operandCapture_7_3 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  operandCapture_7_4 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  operandCapture_7_5 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  operandCapture_7_6 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  operandCapture_7_7 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  operandCapture_7_8 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  operandCapture_7_9 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  operandCapture_7_10 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  operandCapture_7_11 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  operandCapture_8_0 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  operandCapture_8_1 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  operandCapture_8_2 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  operandCapture_8_3 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  operandCapture_8_4 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  operandCapture_8_5 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  operandCapture_8_6 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  operandCapture_8_7 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  operandCapture_8_8 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  operandCapture_8_9 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  operandCapture_8_10 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  operandCapture_8_11 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  operandCapture_9_0 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  operandCapture_9_1 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  operandCapture_9_2 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  operandCapture_9_3 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  operandCapture_9_4 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  operandCapture_9_5 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  operandCapture_9_6 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  operandCapture_9_7 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  operandCapture_9_8 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  operandCapture_9_9 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  operandCapture_9_10 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  operandCapture_9_11 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  operandCapture_10_0 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  operandCapture_10_1 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  operandCapture_10_2 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  operandCapture_10_3 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  operandCapture_10_4 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  operandCapture_10_5 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  operandCapture_10_6 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  operandCapture_10_7 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  operandCapture_10_8 = _RAND_128[0:0];
  _RAND_129 = {1{`RANDOM}};
  operandCapture_10_9 = _RAND_129[0:0];
  _RAND_130 = {1{`RANDOM}};
  operandCapture_10_10 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  operandCapture_10_11 = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  operandCapture_11_0 = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  operandCapture_11_1 = _RAND_133[0:0];
  _RAND_134 = {1{`RANDOM}};
  operandCapture_11_2 = _RAND_134[0:0];
  _RAND_135 = {1{`RANDOM}};
  operandCapture_11_3 = _RAND_135[0:0];
  _RAND_136 = {1{`RANDOM}};
  operandCapture_11_4 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  operandCapture_11_5 = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  operandCapture_11_6 = _RAND_138[0:0];
  _RAND_139 = {1{`RANDOM}};
  operandCapture_11_7 = _RAND_139[0:0];
  _RAND_140 = {1{`RANDOM}};
  operandCapture_11_8 = _RAND_140[0:0];
  _RAND_141 = {1{`RANDOM}};
  operandCapture_11_9 = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  operandCapture_11_10 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  operandCapture_11_11 = _RAND_143[0:0];
  _RAND_144 = {1{`RANDOM}};
  operandCapture_12_0 = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  operandCapture_12_1 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  operandCapture_12_2 = _RAND_146[0:0];
  _RAND_147 = {1{`RANDOM}};
  operandCapture_12_3 = _RAND_147[0:0];
  _RAND_148 = {1{`RANDOM}};
  operandCapture_12_4 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  operandCapture_12_5 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  operandCapture_12_6 = _RAND_150[0:0];
  _RAND_151 = {1{`RANDOM}};
  operandCapture_12_7 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  operandCapture_12_8 = _RAND_152[0:0];
  _RAND_153 = {1{`RANDOM}};
  operandCapture_12_9 = _RAND_153[0:0];
  _RAND_154 = {1{`RANDOM}};
  operandCapture_12_10 = _RAND_154[0:0];
  _RAND_155 = {1{`RANDOM}};
  operandCapture_12_11 = _RAND_155[0:0];
  _RAND_156 = {1{`RANDOM}};
  operandCapture_13_0 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  operandCapture_13_1 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  operandCapture_13_2 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  operandCapture_13_3 = _RAND_159[0:0];
  _RAND_160 = {1{`RANDOM}};
  operandCapture_13_4 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  operandCapture_13_5 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  operandCapture_13_6 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  operandCapture_13_7 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  operandCapture_13_8 = _RAND_164[0:0];
  _RAND_165 = {1{`RANDOM}};
  operandCapture_13_9 = _RAND_165[0:0];
  _RAND_166 = {1{`RANDOM}};
  operandCapture_13_10 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  operandCapture_13_11 = _RAND_167[0:0];
  _RAND_168 = {1{`RANDOM}};
  operandCapture_14_0 = _RAND_168[0:0];
  _RAND_169 = {1{`RANDOM}};
  operandCapture_14_1 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  operandCapture_14_2 = _RAND_170[0:0];
  _RAND_171 = {1{`RANDOM}};
  operandCapture_14_3 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  operandCapture_14_4 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  operandCapture_14_5 = _RAND_173[0:0];
  _RAND_174 = {1{`RANDOM}};
  operandCapture_14_6 = _RAND_174[0:0];
  _RAND_175 = {1{`RANDOM}};
  operandCapture_14_7 = _RAND_175[0:0];
  _RAND_176 = {1{`RANDOM}};
  operandCapture_14_8 = _RAND_176[0:0];
  _RAND_177 = {1{`RANDOM}};
  operandCapture_14_9 = _RAND_177[0:0];
  _RAND_178 = {1{`RANDOM}};
  operandCapture_14_10 = _RAND_178[0:0];
  _RAND_179 = {1{`RANDOM}};
  operandCapture_14_11 = _RAND_179[0:0];
  _RAND_180 = {1{`RANDOM}};
  operandCapture_15_0 = _RAND_180[0:0];
  _RAND_181 = {1{`RANDOM}};
  operandCapture_15_1 = _RAND_181[0:0];
  _RAND_182 = {1{`RANDOM}};
  operandCapture_15_2 = _RAND_182[0:0];
  _RAND_183 = {1{`RANDOM}};
  operandCapture_15_3 = _RAND_183[0:0];
  _RAND_184 = {1{`RANDOM}};
  operandCapture_15_4 = _RAND_184[0:0];
  _RAND_185 = {1{`RANDOM}};
  operandCapture_15_5 = _RAND_185[0:0];
  _RAND_186 = {1{`RANDOM}};
  operandCapture_15_6 = _RAND_186[0:0];
  _RAND_187 = {1{`RANDOM}};
  operandCapture_15_7 = _RAND_187[0:0];
  _RAND_188 = {1{`RANDOM}};
  operandCapture_15_8 = _RAND_188[0:0];
  _RAND_189 = {1{`RANDOM}};
  operandCapture_15_9 = _RAND_189[0:0];
  _RAND_190 = {1{`RANDOM}};
  operandCapture_15_10 = _RAND_190[0:0];
  _RAND_191 = {1{`RANDOM}};
  operandCapture_15_11 = _RAND_191[0:0];
  _RAND_192 = {1{`RANDOM}};
  operandCapture_16_0 = _RAND_192[0:0];
  _RAND_193 = {1{`RANDOM}};
  operandCapture_16_1 = _RAND_193[0:0];
  _RAND_194 = {1{`RANDOM}};
  operandCapture_16_2 = _RAND_194[0:0];
  _RAND_195 = {1{`RANDOM}};
  operandCapture_16_3 = _RAND_195[0:0];
  _RAND_196 = {1{`RANDOM}};
  operandCapture_16_4 = _RAND_196[0:0];
  _RAND_197 = {1{`RANDOM}};
  operandCapture_16_5 = _RAND_197[0:0];
  _RAND_198 = {1{`RANDOM}};
  operandCapture_16_6 = _RAND_198[0:0];
  _RAND_199 = {1{`RANDOM}};
  operandCapture_16_7 = _RAND_199[0:0];
  _RAND_200 = {1{`RANDOM}};
  operandCapture_16_8 = _RAND_200[0:0];
  _RAND_201 = {1{`RANDOM}};
  operandCapture_16_9 = _RAND_201[0:0];
  _RAND_202 = {1{`RANDOM}};
  operandCapture_16_10 = _RAND_202[0:0];
  _RAND_203 = {1{`RANDOM}};
  operandCapture_16_11 = _RAND_203[0:0];
  _RAND_204 = {1{`RANDOM}};
  operandCapture_17_0 = _RAND_204[0:0];
  _RAND_205 = {1{`RANDOM}};
  operandCapture_17_1 = _RAND_205[0:0];
  _RAND_206 = {1{`RANDOM}};
  operandCapture_17_2 = _RAND_206[0:0];
  _RAND_207 = {1{`RANDOM}};
  operandCapture_17_3 = _RAND_207[0:0];
  _RAND_208 = {1{`RANDOM}};
  operandCapture_17_4 = _RAND_208[0:0];
  _RAND_209 = {1{`RANDOM}};
  operandCapture_17_5 = _RAND_209[0:0];
  _RAND_210 = {1{`RANDOM}};
  operandCapture_17_6 = _RAND_210[0:0];
  _RAND_211 = {1{`RANDOM}};
  operandCapture_17_7 = _RAND_211[0:0];
  _RAND_212 = {1{`RANDOM}};
  operandCapture_17_8 = _RAND_212[0:0];
  _RAND_213 = {1{`RANDOM}};
  operandCapture_17_9 = _RAND_213[0:0];
  _RAND_214 = {1{`RANDOM}};
  operandCapture_17_10 = _RAND_214[0:0];
  _RAND_215 = {1{`RANDOM}};
  operandCapture_17_11 = _RAND_215[0:0];
  _RAND_216 = {1{`RANDOM}};
  operandCapture_18_0 = _RAND_216[0:0];
  _RAND_217 = {1{`RANDOM}};
  operandCapture_18_1 = _RAND_217[0:0];
  _RAND_218 = {1{`RANDOM}};
  operandCapture_18_2 = _RAND_218[0:0];
  _RAND_219 = {1{`RANDOM}};
  operandCapture_18_3 = _RAND_219[0:0];
  _RAND_220 = {1{`RANDOM}};
  operandCapture_18_4 = _RAND_220[0:0];
  _RAND_221 = {1{`RANDOM}};
  operandCapture_18_5 = _RAND_221[0:0];
  _RAND_222 = {1{`RANDOM}};
  operandCapture_18_6 = _RAND_222[0:0];
  _RAND_223 = {1{`RANDOM}};
  operandCapture_18_7 = _RAND_223[0:0];
  _RAND_224 = {1{`RANDOM}};
  operandCapture_18_8 = _RAND_224[0:0];
  _RAND_225 = {1{`RANDOM}};
  operandCapture_18_9 = _RAND_225[0:0];
  _RAND_226 = {1{`RANDOM}};
  operandCapture_18_10 = _RAND_226[0:0];
  _RAND_227 = {1{`RANDOM}};
  operandCapture_18_11 = _RAND_227[0:0];
  _RAND_228 = {1{`RANDOM}};
  operandCapture_19_0 = _RAND_228[0:0];
  _RAND_229 = {1{`RANDOM}};
  operandCapture_19_1 = _RAND_229[0:0];
  _RAND_230 = {1{`RANDOM}};
  operandCapture_19_2 = _RAND_230[0:0];
  _RAND_231 = {1{`RANDOM}};
  operandCapture_19_3 = _RAND_231[0:0];
  _RAND_232 = {1{`RANDOM}};
  operandCapture_19_4 = _RAND_232[0:0];
  _RAND_233 = {1{`RANDOM}};
  operandCapture_19_5 = _RAND_233[0:0];
  _RAND_234 = {1{`RANDOM}};
  operandCapture_19_6 = _RAND_234[0:0];
  _RAND_235 = {1{`RANDOM}};
  operandCapture_19_7 = _RAND_235[0:0];
  _RAND_236 = {1{`RANDOM}};
  operandCapture_19_8 = _RAND_236[0:0];
  _RAND_237 = {1{`RANDOM}};
  operandCapture_19_9 = _RAND_237[0:0];
  _RAND_238 = {1{`RANDOM}};
  operandCapture_19_10 = _RAND_238[0:0];
  _RAND_239 = {1{`RANDOM}};
  operandCapture_19_11 = _RAND_239[0:0];
  _RAND_240 = {1{`RANDOM}};
  operandCapture_20_0 = _RAND_240[0:0];
  _RAND_241 = {1{`RANDOM}};
  operandCapture_20_1 = _RAND_241[0:0];
  _RAND_242 = {1{`RANDOM}};
  operandCapture_20_2 = _RAND_242[0:0];
  _RAND_243 = {1{`RANDOM}};
  operandCapture_20_3 = _RAND_243[0:0];
  _RAND_244 = {1{`RANDOM}};
  operandCapture_20_4 = _RAND_244[0:0];
  _RAND_245 = {1{`RANDOM}};
  operandCapture_20_5 = _RAND_245[0:0];
  _RAND_246 = {1{`RANDOM}};
  operandCapture_20_6 = _RAND_246[0:0];
  _RAND_247 = {1{`RANDOM}};
  operandCapture_20_7 = _RAND_247[0:0];
  _RAND_248 = {1{`RANDOM}};
  operandCapture_20_8 = _RAND_248[0:0];
  _RAND_249 = {1{`RANDOM}};
  operandCapture_20_9 = _RAND_249[0:0];
  _RAND_250 = {1{`RANDOM}};
  operandCapture_20_10 = _RAND_250[0:0];
  _RAND_251 = {1{`RANDOM}};
  operandCapture_20_11 = _RAND_251[0:0];
  _RAND_252 = {1{`RANDOM}};
  operandCapture_21_0 = _RAND_252[0:0];
  _RAND_253 = {1{`RANDOM}};
  operandCapture_21_1 = _RAND_253[0:0];
  _RAND_254 = {1{`RANDOM}};
  operandCapture_21_2 = _RAND_254[0:0];
  _RAND_255 = {1{`RANDOM}};
  operandCapture_21_3 = _RAND_255[0:0];
  _RAND_256 = {1{`RANDOM}};
  operandCapture_21_4 = _RAND_256[0:0];
  _RAND_257 = {1{`RANDOM}};
  operandCapture_21_5 = _RAND_257[0:0];
  _RAND_258 = {1{`RANDOM}};
  operandCapture_21_6 = _RAND_258[0:0];
  _RAND_259 = {1{`RANDOM}};
  operandCapture_21_7 = _RAND_259[0:0];
  _RAND_260 = {1{`RANDOM}};
  operandCapture_21_8 = _RAND_260[0:0];
  _RAND_261 = {1{`RANDOM}};
  operandCapture_21_9 = _RAND_261[0:0];
  _RAND_262 = {1{`RANDOM}};
  operandCapture_21_10 = _RAND_262[0:0];
  _RAND_263 = {1{`RANDOM}};
  operandCapture_21_11 = _RAND_263[0:0];
  _RAND_264 = {1{`RANDOM}};
  operandCapture_22_0 = _RAND_264[0:0];
  _RAND_265 = {1{`RANDOM}};
  operandCapture_22_1 = _RAND_265[0:0];
  _RAND_266 = {1{`RANDOM}};
  operandCapture_22_2 = _RAND_266[0:0];
  _RAND_267 = {1{`RANDOM}};
  operandCapture_22_3 = _RAND_267[0:0];
  _RAND_268 = {1{`RANDOM}};
  operandCapture_22_4 = _RAND_268[0:0];
  _RAND_269 = {1{`RANDOM}};
  operandCapture_22_5 = _RAND_269[0:0];
  _RAND_270 = {1{`RANDOM}};
  operandCapture_22_6 = _RAND_270[0:0];
  _RAND_271 = {1{`RANDOM}};
  operandCapture_22_7 = _RAND_271[0:0];
  _RAND_272 = {1{`RANDOM}};
  operandCapture_22_8 = _RAND_272[0:0];
  _RAND_273 = {1{`RANDOM}};
  operandCapture_22_9 = _RAND_273[0:0];
  _RAND_274 = {1{`RANDOM}};
  operandCapture_22_10 = _RAND_274[0:0];
  _RAND_275 = {1{`RANDOM}};
  operandCapture_22_11 = _RAND_275[0:0];
  _RAND_276 = {1{`RANDOM}};
  operandCapture_23_0 = _RAND_276[0:0];
  _RAND_277 = {1{`RANDOM}};
  operandCapture_23_1 = _RAND_277[0:0];
  _RAND_278 = {1{`RANDOM}};
  operandCapture_23_2 = _RAND_278[0:0];
  _RAND_279 = {1{`RANDOM}};
  operandCapture_23_3 = _RAND_279[0:0];
  _RAND_280 = {1{`RANDOM}};
  operandCapture_23_4 = _RAND_280[0:0];
  _RAND_281 = {1{`RANDOM}};
  operandCapture_23_5 = _RAND_281[0:0];
  _RAND_282 = {1{`RANDOM}};
  operandCapture_23_6 = _RAND_282[0:0];
  _RAND_283 = {1{`RANDOM}};
  operandCapture_23_7 = _RAND_283[0:0];
  _RAND_284 = {1{`RANDOM}};
  operandCapture_23_8 = _RAND_284[0:0];
  _RAND_285 = {1{`RANDOM}};
  operandCapture_23_9 = _RAND_285[0:0];
  _RAND_286 = {1{`RANDOM}};
  operandCapture_23_10 = _RAND_286[0:0];
  _RAND_287 = {1{`RANDOM}};
  operandCapture_23_11 = _RAND_287[0:0];
  _RAND_288 = {1{`RANDOM}};
  operandCapture_24_0 = _RAND_288[0:0];
  _RAND_289 = {1{`RANDOM}};
  operandCapture_24_1 = _RAND_289[0:0];
  _RAND_290 = {1{`RANDOM}};
  operandCapture_24_2 = _RAND_290[0:0];
  _RAND_291 = {1{`RANDOM}};
  operandCapture_24_3 = _RAND_291[0:0];
  _RAND_292 = {1{`RANDOM}};
  operandCapture_24_4 = _RAND_292[0:0];
  _RAND_293 = {1{`RANDOM}};
  operandCapture_24_5 = _RAND_293[0:0];
  _RAND_294 = {1{`RANDOM}};
  operandCapture_24_6 = _RAND_294[0:0];
  _RAND_295 = {1{`RANDOM}};
  operandCapture_24_7 = _RAND_295[0:0];
  _RAND_296 = {1{`RANDOM}};
  operandCapture_24_8 = _RAND_296[0:0];
  _RAND_297 = {1{`RANDOM}};
  operandCapture_24_9 = _RAND_297[0:0];
  _RAND_298 = {1{`RANDOM}};
  operandCapture_24_10 = _RAND_298[0:0];
  _RAND_299 = {1{`RANDOM}};
  operandCapture_24_11 = _RAND_299[0:0];
  _RAND_300 = {1{`RANDOM}};
  operandCapture_25_0 = _RAND_300[0:0];
  _RAND_301 = {1{`RANDOM}};
  operandCapture_25_1 = _RAND_301[0:0];
  _RAND_302 = {1{`RANDOM}};
  operandCapture_25_2 = _RAND_302[0:0];
  _RAND_303 = {1{`RANDOM}};
  operandCapture_25_3 = _RAND_303[0:0];
  _RAND_304 = {1{`RANDOM}};
  operandCapture_25_4 = _RAND_304[0:0];
  _RAND_305 = {1{`RANDOM}};
  operandCapture_25_5 = _RAND_305[0:0];
  _RAND_306 = {1{`RANDOM}};
  operandCapture_25_6 = _RAND_306[0:0];
  _RAND_307 = {1{`RANDOM}};
  operandCapture_25_7 = _RAND_307[0:0];
  _RAND_308 = {1{`RANDOM}};
  operandCapture_25_8 = _RAND_308[0:0];
  _RAND_309 = {1{`RANDOM}};
  operandCapture_25_9 = _RAND_309[0:0];
  _RAND_310 = {1{`RANDOM}};
  operandCapture_25_10 = _RAND_310[0:0];
  _RAND_311 = {1{`RANDOM}};
  operandCapture_25_11 = _RAND_311[0:0];
  _RAND_312 = {1{`RANDOM}};
  operandCapture_26_0 = _RAND_312[0:0];
  _RAND_313 = {1{`RANDOM}};
  operandCapture_26_1 = _RAND_313[0:0];
  _RAND_314 = {1{`RANDOM}};
  operandCapture_26_2 = _RAND_314[0:0];
  _RAND_315 = {1{`RANDOM}};
  operandCapture_26_3 = _RAND_315[0:0];
  _RAND_316 = {1{`RANDOM}};
  operandCapture_26_4 = _RAND_316[0:0];
  _RAND_317 = {1{`RANDOM}};
  operandCapture_26_5 = _RAND_317[0:0];
  _RAND_318 = {1{`RANDOM}};
  operandCapture_26_6 = _RAND_318[0:0];
  _RAND_319 = {1{`RANDOM}};
  operandCapture_26_7 = _RAND_319[0:0];
  _RAND_320 = {1{`RANDOM}};
  operandCapture_26_8 = _RAND_320[0:0];
  _RAND_321 = {1{`RANDOM}};
  operandCapture_26_9 = _RAND_321[0:0];
  _RAND_322 = {1{`RANDOM}};
  operandCapture_26_10 = _RAND_322[0:0];
  _RAND_323 = {1{`RANDOM}};
  operandCapture_26_11 = _RAND_323[0:0];
  _RAND_324 = {1{`RANDOM}};
  operandCapture_27_0 = _RAND_324[0:0];
  _RAND_325 = {1{`RANDOM}};
  operandCapture_27_1 = _RAND_325[0:0];
  _RAND_326 = {1{`RANDOM}};
  operandCapture_27_2 = _RAND_326[0:0];
  _RAND_327 = {1{`RANDOM}};
  operandCapture_27_3 = _RAND_327[0:0];
  _RAND_328 = {1{`RANDOM}};
  operandCapture_27_4 = _RAND_328[0:0];
  _RAND_329 = {1{`RANDOM}};
  operandCapture_27_5 = _RAND_329[0:0];
  _RAND_330 = {1{`RANDOM}};
  operandCapture_27_6 = _RAND_330[0:0];
  _RAND_331 = {1{`RANDOM}};
  operandCapture_27_7 = _RAND_331[0:0];
  _RAND_332 = {1{`RANDOM}};
  operandCapture_27_8 = _RAND_332[0:0];
  _RAND_333 = {1{`RANDOM}};
  operandCapture_27_9 = _RAND_333[0:0];
  _RAND_334 = {1{`RANDOM}};
  operandCapture_27_10 = _RAND_334[0:0];
  _RAND_335 = {1{`RANDOM}};
  operandCapture_27_11 = _RAND_335[0:0];
  _RAND_336 = {1{`RANDOM}};
  operandCapture_28_0 = _RAND_336[0:0];
  _RAND_337 = {1{`RANDOM}};
  operandCapture_28_1 = _RAND_337[0:0];
  _RAND_338 = {1{`RANDOM}};
  operandCapture_28_2 = _RAND_338[0:0];
  _RAND_339 = {1{`RANDOM}};
  operandCapture_28_3 = _RAND_339[0:0];
  _RAND_340 = {1{`RANDOM}};
  operandCapture_28_4 = _RAND_340[0:0];
  _RAND_341 = {1{`RANDOM}};
  operandCapture_28_5 = _RAND_341[0:0];
  _RAND_342 = {1{`RANDOM}};
  operandCapture_28_6 = _RAND_342[0:0];
  _RAND_343 = {1{`RANDOM}};
  operandCapture_28_7 = _RAND_343[0:0];
  _RAND_344 = {1{`RANDOM}};
  operandCapture_28_8 = _RAND_344[0:0];
  _RAND_345 = {1{`RANDOM}};
  operandCapture_28_9 = _RAND_345[0:0];
  _RAND_346 = {1{`RANDOM}};
  operandCapture_28_10 = _RAND_346[0:0];
  _RAND_347 = {1{`RANDOM}};
  operandCapture_28_11 = _RAND_347[0:0];
  _RAND_348 = {1{`RANDOM}};
  operandCapture_29_0 = _RAND_348[0:0];
  _RAND_349 = {1{`RANDOM}};
  operandCapture_29_1 = _RAND_349[0:0];
  _RAND_350 = {1{`RANDOM}};
  operandCapture_29_2 = _RAND_350[0:0];
  _RAND_351 = {1{`RANDOM}};
  operandCapture_29_3 = _RAND_351[0:0];
  _RAND_352 = {1{`RANDOM}};
  operandCapture_29_4 = _RAND_352[0:0];
  _RAND_353 = {1{`RANDOM}};
  operandCapture_29_5 = _RAND_353[0:0];
  _RAND_354 = {1{`RANDOM}};
  operandCapture_29_6 = _RAND_354[0:0];
  _RAND_355 = {1{`RANDOM}};
  operandCapture_29_7 = _RAND_355[0:0];
  _RAND_356 = {1{`RANDOM}};
  operandCapture_29_8 = _RAND_356[0:0];
  _RAND_357 = {1{`RANDOM}};
  operandCapture_29_9 = _RAND_357[0:0];
  _RAND_358 = {1{`RANDOM}};
  operandCapture_29_10 = _RAND_358[0:0];
  _RAND_359 = {1{`RANDOM}};
  operandCapture_29_11 = _RAND_359[0:0];
  _RAND_360 = {1{`RANDOM}};
  operandCapture_30_0 = _RAND_360[0:0];
  _RAND_361 = {1{`RANDOM}};
  operandCapture_30_1 = _RAND_361[0:0];
  _RAND_362 = {1{`RANDOM}};
  operandCapture_30_2 = _RAND_362[0:0];
  _RAND_363 = {1{`RANDOM}};
  operandCapture_30_3 = _RAND_363[0:0];
  _RAND_364 = {1{`RANDOM}};
  operandCapture_30_4 = _RAND_364[0:0];
  _RAND_365 = {1{`RANDOM}};
  operandCapture_30_5 = _RAND_365[0:0];
  _RAND_366 = {1{`RANDOM}};
  operandCapture_30_6 = _RAND_366[0:0];
  _RAND_367 = {1{`RANDOM}};
  operandCapture_30_7 = _RAND_367[0:0];
  _RAND_368 = {1{`RANDOM}};
  operandCapture_30_8 = _RAND_368[0:0];
  _RAND_369 = {1{`RANDOM}};
  operandCapture_30_9 = _RAND_369[0:0];
  _RAND_370 = {1{`RANDOM}};
  operandCapture_30_10 = _RAND_370[0:0];
  _RAND_371 = {1{`RANDOM}};
  operandCapture_30_11 = _RAND_371[0:0];
  _RAND_372 = {1{`RANDOM}};
  operandCapture_31_0 = _RAND_372[0:0];
  _RAND_373 = {1{`RANDOM}};
  operandCapture_31_1 = _RAND_373[0:0];
  _RAND_374 = {1{`RANDOM}};
  operandCapture_31_2 = _RAND_374[0:0];
  _RAND_375 = {1{`RANDOM}};
  operandCapture_31_3 = _RAND_375[0:0];
  _RAND_376 = {1{`RANDOM}};
  operandCapture_31_4 = _RAND_376[0:0];
  _RAND_377 = {1{`RANDOM}};
  operandCapture_31_5 = _RAND_377[0:0];
  _RAND_378 = {1{`RANDOM}};
  operandCapture_31_6 = _RAND_378[0:0];
  _RAND_379 = {1{`RANDOM}};
  operandCapture_31_7 = _RAND_379[0:0];
  _RAND_380 = {1{`RANDOM}};
  operandCapture_31_8 = _RAND_380[0:0];
  _RAND_381 = {1{`RANDOM}};
  operandCapture_31_9 = _RAND_381[0:0];
  _RAND_382 = {1{`RANDOM}};
  operandCapture_31_10 = _RAND_382[0:0];
  _RAND_383 = {1{`RANDOM}};
  operandCapture_31_11 = _RAND_383[0:0];
  _RAND_384 = {1{`RANDOM}};
  maskCapture_0 = _RAND_384[0:0];
  _RAND_385 = {1{`RANDOM}};
  maskCapture_1 = _RAND_385[0:0];
  _RAND_386 = {1{`RANDOM}};
  maskCapture_2 = _RAND_386[0:0];
  _RAND_387 = {1{`RANDOM}};
  maskCapture_3 = _RAND_387[0:0];
  _RAND_388 = {1{`RANDOM}};
  maskCapture_4 = _RAND_388[0:0];
  _RAND_389 = {1{`RANDOM}};
  maskCapture_5 = _RAND_389[0:0];
  _RAND_390 = {1{`RANDOM}};
  maskCapture_6 = _RAND_390[0:0];
  _RAND_391 = {1{`RANDOM}};
  maskCapture_7 = _RAND_391[0:0];
  _RAND_392 = {1{`RANDOM}};
  maskCapture_8 = _RAND_392[0:0];
  _RAND_393 = {1{`RANDOM}};
  maskCapture_9 = _RAND_393[0:0];
  _RAND_394 = {1{`RANDOM}};
  maskCapture_10 = _RAND_394[0:0];
  _RAND_395 = {1{`RANDOM}};
  maskCapture_11 = _RAND_395[0:0];
  _RAND_396 = {1{`RANDOM}};
  maskCapture_12 = _RAND_396[0:0];
  _RAND_397 = {1{`RANDOM}};
  maskCapture_13 = _RAND_397[0:0];
  _RAND_398 = {1{`RANDOM}};
  maskCapture_14 = _RAND_398[0:0];
  _RAND_399 = {1{`RANDOM}};
  maskCapture_15 = _RAND_399[0:0];
  _RAND_400 = {1{`RANDOM}};
  maskCapture_16 = _RAND_400[0:0];
  _RAND_401 = {1{`RANDOM}};
  maskCapture_17 = _RAND_401[0:0];
  _RAND_402 = {1{`RANDOM}};
  maskCapture_18 = _RAND_402[0:0];
  _RAND_403 = {1{`RANDOM}};
  maskCapture_19 = _RAND_403[0:0];
  _RAND_404 = {1{`RANDOM}};
  maskCapture_20 = _RAND_404[0:0];
  _RAND_405 = {1{`RANDOM}};
  maskCapture_21 = _RAND_405[0:0];
  _RAND_406 = {1{`RANDOM}};
  maskCapture_22 = _RAND_406[0:0];
  _RAND_407 = {1{`RANDOM}};
  maskCapture_23 = _RAND_407[0:0];
  _RAND_408 = {1{`RANDOM}};
  maskCapture_24 = _RAND_408[0:0];
  _RAND_409 = {1{`RANDOM}};
  maskCapture_25 = _RAND_409[0:0];
  _RAND_410 = {1{`RANDOM}};
  maskCapture_26 = _RAND_410[0:0];
  _RAND_411 = {1{`RANDOM}};
  maskCapture_27 = _RAND_411[0:0];
  _RAND_412 = {1{`RANDOM}};
  maskCapture_28 = _RAND_412[0:0];
  _RAND_413 = {1{`RANDOM}};
  maskCapture_29 = _RAND_413[0:0];
  _RAND_414 = {1{`RANDOM}};
  maskCapture_30 = _RAND_414[0:0];
  _RAND_415 = {1{`RANDOM}};
  maskCapture_31 = _RAND_415[0:0];
  _RAND_416 = {1{`RANDOM}};
  a_0_0 = _RAND_416[15:0];
  _RAND_417 = {1{`RANDOM}};
  a_0_1 = _RAND_417[15:0];
  _RAND_418 = {1{`RANDOM}};
  a_0_2 = _RAND_418[15:0];
  _RAND_419 = {1{`RANDOM}};
  a_0_3 = _RAND_419[15:0];
  _RAND_420 = {1{`RANDOM}};
  a_1_0 = _RAND_420[15:0];
  _RAND_421 = {1{`RANDOM}};
  a_1_1 = _RAND_421[15:0];
  _RAND_422 = {1{`RANDOM}};
  a_1_2 = _RAND_422[15:0];
  _RAND_423 = {1{`RANDOM}};
  a_1_3 = _RAND_423[15:0];
  _RAND_424 = {1{`RANDOM}};
  a_2_0 = _RAND_424[15:0];
  _RAND_425 = {1{`RANDOM}};
  a_2_1 = _RAND_425[15:0];
  _RAND_426 = {1{`RANDOM}};
  a_2_2 = _RAND_426[15:0];
  _RAND_427 = {1{`RANDOM}};
  a_2_3 = _RAND_427[15:0];
  _RAND_428 = {1{`RANDOM}};
  a_3_0 = _RAND_428[15:0];
  _RAND_429 = {1{`RANDOM}};
  a_3_1 = _RAND_429[15:0];
  _RAND_430 = {1{`RANDOM}};
  a_3_2 = _RAND_430[15:0];
  _RAND_431 = {1{`RANDOM}};
  a_3_3 = _RAND_431[15:0];
  _RAND_432 = {1{`RANDOM}};
  a_4_0 = _RAND_432[15:0];
  _RAND_433 = {1{`RANDOM}};
  a_4_1 = _RAND_433[15:0];
  _RAND_434 = {1{`RANDOM}};
  a_4_2 = _RAND_434[15:0];
  _RAND_435 = {1{`RANDOM}};
  a_4_3 = _RAND_435[15:0];
  _RAND_436 = {1{`RANDOM}};
  a_5_0 = _RAND_436[15:0];
  _RAND_437 = {1{`RANDOM}};
  a_5_1 = _RAND_437[15:0];
  _RAND_438 = {1{`RANDOM}};
  a_5_2 = _RAND_438[15:0];
  _RAND_439 = {1{`RANDOM}};
  a_5_3 = _RAND_439[15:0];
  _RAND_440 = {1{`RANDOM}};
  a_6_0 = _RAND_440[15:0];
  _RAND_441 = {1{`RANDOM}};
  a_6_1 = _RAND_441[15:0];
  _RAND_442 = {1{`RANDOM}};
  a_6_2 = _RAND_442[15:0];
  _RAND_443 = {1{`RANDOM}};
  a_6_3 = _RAND_443[15:0];
  _RAND_444 = {1{`RANDOM}};
  a_7_0 = _RAND_444[15:0];
  _RAND_445 = {1{`RANDOM}};
  a_7_1 = _RAND_445[15:0];
  _RAND_446 = {1{`RANDOM}};
  a_7_2 = _RAND_446[15:0];
  _RAND_447 = {1{`RANDOM}};
  a_7_3 = _RAND_447[15:0];
  _RAND_448 = {1{`RANDOM}};
  a_8_0 = _RAND_448[15:0];
  _RAND_449 = {1{`RANDOM}};
  a_8_1 = _RAND_449[15:0];
  _RAND_450 = {1{`RANDOM}};
  a_8_2 = _RAND_450[15:0];
  _RAND_451 = {1{`RANDOM}};
  a_8_3 = _RAND_451[15:0];
  _RAND_452 = {1{`RANDOM}};
  a_9_0 = _RAND_452[15:0];
  _RAND_453 = {1{`RANDOM}};
  a_9_1 = _RAND_453[15:0];
  _RAND_454 = {1{`RANDOM}};
  a_9_2 = _RAND_454[15:0];
  _RAND_455 = {1{`RANDOM}};
  a_9_3 = _RAND_455[15:0];
  _RAND_456 = {1{`RANDOM}};
  a_10_0 = _RAND_456[15:0];
  _RAND_457 = {1{`RANDOM}};
  a_10_1 = _RAND_457[15:0];
  _RAND_458 = {1{`RANDOM}};
  a_10_2 = _RAND_458[15:0];
  _RAND_459 = {1{`RANDOM}};
  a_10_3 = _RAND_459[15:0];
  _RAND_460 = {1{`RANDOM}};
  a_11_0 = _RAND_460[15:0];
  _RAND_461 = {1{`RANDOM}};
  a_11_1 = _RAND_461[15:0];
  _RAND_462 = {1{`RANDOM}};
  a_11_2 = _RAND_462[15:0];
  _RAND_463 = {1{`RANDOM}};
  a_11_3 = _RAND_463[15:0];
  _RAND_464 = {1{`RANDOM}};
  a_12_0 = _RAND_464[15:0];
  _RAND_465 = {1{`RANDOM}};
  a_12_1 = _RAND_465[15:0];
  _RAND_466 = {1{`RANDOM}};
  a_12_2 = _RAND_466[15:0];
  _RAND_467 = {1{`RANDOM}};
  a_12_3 = _RAND_467[15:0];
  _RAND_468 = {1{`RANDOM}};
  a_13_0 = _RAND_468[15:0];
  _RAND_469 = {1{`RANDOM}};
  a_13_1 = _RAND_469[15:0];
  _RAND_470 = {1{`RANDOM}};
  a_13_2 = _RAND_470[15:0];
  _RAND_471 = {1{`RANDOM}};
  a_13_3 = _RAND_471[15:0];
  _RAND_472 = {1{`RANDOM}};
  a_14_0 = _RAND_472[15:0];
  _RAND_473 = {1{`RANDOM}};
  a_14_1 = _RAND_473[15:0];
  _RAND_474 = {1{`RANDOM}};
  a_14_2 = _RAND_474[15:0];
  _RAND_475 = {1{`RANDOM}};
  a_14_3 = _RAND_475[15:0];
  _RAND_476 = {1{`RANDOM}};
  a_15_0 = _RAND_476[15:0];
  _RAND_477 = {1{`RANDOM}};
  a_15_1 = _RAND_477[15:0];
  _RAND_478 = {1{`RANDOM}};
  a_15_2 = _RAND_478[15:0];
  _RAND_479 = {1{`RANDOM}};
  a_15_3 = _RAND_479[15:0];
  _RAND_480 = {1{`RANDOM}};
  a_16_0 = _RAND_480[15:0];
  _RAND_481 = {1{`RANDOM}};
  a_16_1 = _RAND_481[15:0];
  _RAND_482 = {1{`RANDOM}};
  a_16_2 = _RAND_482[15:0];
  _RAND_483 = {1{`RANDOM}};
  a_16_3 = _RAND_483[15:0];
  _RAND_484 = {1{`RANDOM}};
  a_17_0 = _RAND_484[15:0];
  _RAND_485 = {1{`RANDOM}};
  a_17_1 = _RAND_485[15:0];
  _RAND_486 = {1{`RANDOM}};
  a_17_2 = _RAND_486[15:0];
  _RAND_487 = {1{`RANDOM}};
  a_17_3 = _RAND_487[15:0];
  _RAND_488 = {1{`RANDOM}};
  a_18_0 = _RAND_488[15:0];
  _RAND_489 = {1{`RANDOM}};
  a_18_1 = _RAND_489[15:0];
  _RAND_490 = {1{`RANDOM}};
  a_18_2 = _RAND_490[15:0];
  _RAND_491 = {1{`RANDOM}};
  a_18_3 = _RAND_491[15:0];
  _RAND_492 = {1{`RANDOM}};
  a_19_0 = _RAND_492[15:0];
  _RAND_493 = {1{`RANDOM}};
  a_19_1 = _RAND_493[15:0];
  _RAND_494 = {1{`RANDOM}};
  a_19_2 = _RAND_494[15:0];
  _RAND_495 = {1{`RANDOM}};
  a_19_3 = _RAND_495[15:0];
  _RAND_496 = {1{`RANDOM}};
  a_20_0 = _RAND_496[15:0];
  _RAND_497 = {1{`RANDOM}};
  a_20_1 = _RAND_497[15:0];
  _RAND_498 = {1{`RANDOM}};
  a_20_2 = _RAND_498[15:0];
  _RAND_499 = {1{`RANDOM}};
  a_20_3 = _RAND_499[15:0];
  _RAND_500 = {1{`RANDOM}};
  a_21_0 = _RAND_500[15:0];
  _RAND_501 = {1{`RANDOM}};
  a_21_1 = _RAND_501[15:0];
  _RAND_502 = {1{`RANDOM}};
  a_21_2 = _RAND_502[15:0];
  _RAND_503 = {1{`RANDOM}};
  a_21_3 = _RAND_503[15:0];
  _RAND_504 = {1{`RANDOM}};
  a_22_0 = _RAND_504[15:0];
  _RAND_505 = {1{`RANDOM}};
  a_22_1 = _RAND_505[15:0];
  _RAND_506 = {1{`RANDOM}};
  a_22_2 = _RAND_506[15:0];
  _RAND_507 = {1{`RANDOM}};
  a_22_3 = _RAND_507[15:0];
  _RAND_508 = {1{`RANDOM}};
  a_23_0 = _RAND_508[15:0];
  _RAND_509 = {1{`RANDOM}};
  a_23_1 = _RAND_509[15:0];
  _RAND_510 = {1{`RANDOM}};
  a_23_2 = _RAND_510[15:0];
  _RAND_511 = {1{`RANDOM}};
  a_23_3 = _RAND_511[15:0];
  _RAND_512 = {1{`RANDOM}};
  a_24_0 = _RAND_512[15:0];
  _RAND_513 = {1{`RANDOM}};
  a_24_1 = _RAND_513[15:0];
  _RAND_514 = {1{`RANDOM}};
  a_24_2 = _RAND_514[15:0];
  _RAND_515 = {1{`RANDOM}};
  a_24_3 = _RAND_515[15:0];
  _RAND_516 = {1{`RANDOM}};
  a_25_0 = _RAND_516[15:0];
  _RAND_517 = {1{`RANDOM}};
  a_25_1 = _RAND_517[15:0];
  _RAND_518 = {1{`RANDOM}};
  a_25_2 = _RAND_518[15:0];
  _RAND_519 = {1{`RANDOM}};
  a_25_3 = _RAND_519[15:0];
  _RAND_520 = {1{`RANDOM}};
  a_26_0 = _RAND_520[15:0];
  _RAND_521 = {1{`RANDOM}};
  a_26_1 = _RAND_521[15:0];
  _RAND_522 = {1{`RANDOM}};
  a_26_2 = _RAND_522[15:0];
  _RAND_523 = {1{`RANDOM}};
  a_26_3 = _RAND_523[15:0];
  _RAND_524 = {1{`RANDOM}};
  a_27_0 = _RAND_524[15:0];
  _RAND_525 = {1{`RANDOM}};
  a_27_1 = _RAND_525[15:0];
  _RAND_526 = {1{`RANDOM}};
  a_27_2 = _RAND_526[15:0];
  _RAND_527 = {1{`RANDOM}};
  a_27_3 = _RAND_527[15:0];
  _RAND_528 = {1{`RANDOM}};
  a_28_0 = _RAND_528[15:0];
  _RAND_529 = {1{`RANDOM}};
  a_28_1 = _RAND_529[15:0];
  _RAND_530 = {1{`RANDOM}};
  a_28_2 = _RAND_530[15:0];
  _RAND_531 = {1{`RANDOM}};
  a_28_3 = _RAND_531[15:0];
  _RAND_532 = {1{`RANDOM}};
  a_29_0 = _RAND_532[15:0];
  _RAND_533 = {1{`RANDOM}};
  a_29_1 = _RAND_533[15:0];
  _RAND_534 = {1{`RANDOM}};
  a_29_2 = _RAND_534[15:0];
  _RAND_535 = {1{`RANDOM}};
  a_29_3 = _RAND_535[15:0];
  _RAND_536 = {1{`RANDOM}};
  a_30_0 = _RAND_536[15:0];
  _RAND_537 = {1{`RANDOM}};
  a_30_1 = _RAND_537[15:0];
  _RAND_538 = {1{`RANDOM}};
  a_30_2 = _RAND_538[15:0];
  _RAND_539 = {1{`RANDOM}};
  a_30_3 = _RAND_539[15:0];
  _RAND_540 = {1{`RANDOM}};
  a_31_0 = _RAND_540[15:0];
  _RAND_541 = {1{`RANDOM}};
  a_31_1 = _RAND_541[15:0];
  _RAND_542 = {1{`RANDOM}};
  a_31_2 = _RAND_542[15:0];
  _RAND_543 = {1{`RANDOM}};
  a_31_3 = _RAND_543[15:0];
  _RAND_544 = {1{`RANDOM}};
  b_0_0 = _RAND_544[15:0];
  _RAND_545 = {1{`RANDOM}};
  b_0_1 = _RAND_545[15:0];
  _RAND_546 = {1{`RANDOM}};
  b_0_2 = _RAND_546[15:0];
  _RAND_547 = {1{`RANDOM}};
  b_0_3 = _RAND_547[15:0];
  _RAND_548 = {1{`RANDOM}};
  b_1_0 = _RAND_548[15:0];
  _RAND_549 = {1{`RANDOM}};
  b_1_1 = _RAND_549[15:0];
  _RAND_550 = {1{`RANDOM}};
  b_1_2 = _RAND_550[15:0];
  _RAND_551 = {1{`RANDOM}};
  b_1_3 = _RAND_551[15:0];
  _RAND_552 = {1{`RANDOM}};
  b_2_0 = _RAND_552[15:0];
  _RAND_553 = {1{`RANDOM}};
  b_2_1 = _RAND_553[15:0];
  _RAND_554 = {1{`RANDOM}};
  b_2_2 = _RAND_554[15:0];
  _RAND_555 = {1{`RANDOM}};
  b_2_3 = _RAND_555[15:0];
  _RAND_556 = {1{`RANDOM}};
  b_3_0 = _RAND_556[15:0];
  _RAND_557 = {1{`RANDOM}};
  b_3_1 = _RAND_557[15:0];
  _RAND_558 = {1{`RANDOM}};
  b_3_2 = _RAND_558[15:0];
  _RAND_559 = {1{`RANDOM}};
  b_3_3 = _RAND_559[15:0];
  _RAND_560 = {1{`RANDOM}};
  b_4_0 = _RAND_560[15:0];
  _RAND_561 = {1{`RANDOM}};
  b_4_1 = _RAND_561[15:0];
  _RAND_562 = {1{`RANDOM}};
  b_4_2 = _RAND_562[15:0];
  _RAND_563 = {1{`RANDOM}};
  b_4_3 = _RAND_563[15:0];
  _RAND_564 = {1{`RANDOM}};
  b_5_0 = _RAND_564[15:0];
  _RAND_565 = {1{`RANDOM}};
  b_5_1 = _RAND_565[15:0];
  _RAND_566 = {1{`RANDOM}};
  b_5_2 = _RAND_566[15:0];
  _RAND_567 = {1{`RANDOM}};
  b_5_3 = _RAND_567[15:0];
  _RAND_568 = {1{`RANDOM}};
  b_6_0 = _RAND_568[15:0];
  _RAND_569 = {1{`RANDOM}};
  b_6_1 = _RAND_569[15:0];
  _RAND_570 = {1{`RANDOM}};
  b_6_2 = _RAND_570[15:0];
  _RAND_571 = {1{`RANDOM}};
  b_6_3 = _RAND_571[15:0];
  _RAND_572 = {1{`RANDOM}};
  b_7_0 = _RAND_572[15:0];
  _RAND_573 = {1{`RANDOM}};
  b_7_1 = _RAND_573[15:0];
  _RAND_574 = {1{`RANDOM}};
  b_7_2 = _RAND_574[15:0];
  _RAND_575 = {1{`RANDOM}};
  b_7_3 = _RAND_575[15:0];
  _RAND_576 = {1{`RANDOM}};
  b_8_0 = _RAND_576[15:0];
  _RAND_577 = {1{`RANDOM}};
  b_8_1 = _RAND_577[15:0];
  _RAND_578 = {1{`RANDOM}};
  b_8_2 = _RAND_578[15:0];
  _RAND_579 = {1{`RANDOM}};
  b_8_3 = _RAND_579[15:0];
  _RAND_580 = {1{`RANDOM}};
  b_9_0 = _RAND_580[15:0];
  _RAND_581 = {1{`RANDOM}};
  b_9_1 = _RAND_581[15:0];
  _RAND_582 = {1{`RANDOM}};
  b_9_2 = _RAND_582[15:0];
  _RAND_583 = {1{`RANDOM}};
  b_9_3 = _RAND_583[15:0];
  _RAND_584 = {1{`RANDOM}};
  b_10_0 = _RAND_584[15:0];
  _RAND_585 = {1{`RANDOM}};
  b_10_1 = _RAND_585[15:0];
  _RAND_586 = {1{`RANDOM}};
  b_10_2 = _RAND_586[15:0];
  _RAND_587 = {1{`RANDOM}};
  b_10_3 = _RAND_587[15:0];
  _RAND_588 = {1{`RANDOM}};
  b_11_0 = _RAND_588[15:0];
  _RAND_589 = {1{`RANDOM}};
  b_11_1 = _RAND_589[15:0];
  _RAND_590 = {1{`RANDOM}};
  b_11_2 = _RAND_590[15:0];
  _RAND_591 = {1{`RANDOM}};
  b_11_3 = _RAND_591[15:0];
  _RAND_592 = {1{`RANDOM}};
  b_12_0 = _RAND_592[15:0];
  _RAND_593 = {1{`RANDOM}};
  b_12_1 = _RAND_593[15:0];
  _RAND_594 = {1{`RANDOM}};
  b_12_2 = _RAND_594[15:0];
  _RAND_595 = {1{`RANDOM}};
  b_12_3 = _RAND_595[15:0];
  _RAND_596 = {1{`RANDOM}};
  b_13_0 = _RAND_596[15:0];
  _RAND_597 = {1{`RANDOM}};
  b_13_1 = _RAND_597[15:0];
  _RAND_598 = {1{`RANDOM}};
  b_13_2 = _RAND_598[15:0];
  _RAND_599 = {1{`RANDOM}};
  b_13_3 = _RAND_599[15:0];
  _RAND_600 = {1{`RANDOM}};
  b_14_0 = _RAND_600[15:0];
  _RAND_601 = {1{`RANDOM}};
  b_14_1 = _RAND_601[15:0];
  _RAND_602 = {1{`RANDOM}};
  b_14_2 = _RAND_602[15:0];
  _RAND_603 = {1{`RANDOM}};
  b_14_3 = _RAND_603[15:0];
  _RAND_604 = {1{`RANDOM}};
  b_15_0 = _RAND_604[15:0];
  _RAND_605 = {1{`RANDOM}};
  b_15_1 = _RAND_605[15:0];
  _RAND_606 = {1{`RANDOM}};
  b_15_2 = _RAND_606[15:0];
  _RAND_607 = {1{`RANDOM}};
  b_15_3 = _RAND_607[15:0];
  _RAND_608 = {1{`RANDOM}};
  b_16_0 = _RAND_608[15:0];
  _RAND_609 = {1{`RANDOM}};
  b_16_1 = _RAND_609[15:0];
  _RAND_610 = {1{`RANDOM}};
  b_16_2 = _RAND_610[15:0];
  _RAND_611 = {1{`RANDOM}};
  b_16_3 = _RAND_611[15:0];
  _RAND_612 = {1{`RANDOM}};
  b_17_0 = _RAND_612[15:0];
  _RAND_613 = {1{`RANDOM}};
  b_17_1 = _RAND_613[15:0];
  _RAND_614 = {1{`RANDOM}};
  b_17_2 = _RAND_614[15:0];
  _RAND_615 = {1{`RANDOM}};
  b_17_3 = _RAND_615[15:0];
  _RAND_616 = {1{`RANDOM}};
  b_18_0 = _RAND_616[15:0];
  _RAND_617 = {1{`RANDOM}};
  b_18_1 = _RAND_617[15:0];
  _RAND_618 = {1{`RANDOM}};
  b_18_2 = _RAND_618[15:0];
  _RAND_619 = {1{`RANDOM}};
  b_18_3 = _RAND_619[15:0];
  _RAND_620 = {1{`RANDOM}};
  b_19_0 = _RAND_620[15:0];
  _RAND_621 = {1{`RANDOM}};
  b_19_1 = _RAND_621[15:0];
  _RAND_622 = {1{`RANDOM}};
  b_19_2 = _RAND_622[15:0];
  _RAND_623 = {1{`RANDOM}};
  b_19_3 = _RAND_623[15:0];
  _RAND_624 = {1{`RANDOM}};
  b_20_0 = _RAND_624[15:0];
  _RAND_625 = {1{`RANDOM}};
  b_20_1 = _RAND_625[15:0];
  _RAND_626 = {1{`RANDOM}};
  b_20_2 = _RAND_626[15:0];
  _RAND_627 = {1{`RANDOM}};
  b_20_3 = _RAND_627[15:0];
  _RAND_628 = {1{`RANDOM}};
  b_21_0 = _RAND_628[15:0];
  _RAND_629 = {1{`RANDOM}};
  b_21_1 = _RAND_629[15:0];
  _RAND_630 = {1{`RANDOM}};
  b_21_2 = _RAND_630[15:0];
  _RAND_631 = {1{`RANDOM}};
  b_21_3 = _RAND_631[15:0];
  _RAND_632 = {1{`RANDOM}};
  b_22_0 = _RAND_632[15:0];
  _RAND_633 = {1{`RANDOM}};
  b_22_1 = _RAND_633[15:0];
  _RAND_634 = {1{`RANDOM}};
  b_22_2 = _RAND_634[15:0];
  _RAND_635 = {1{`RANDOM}};
  b_22_3 = _RAND_635[15:0];
  _RAND_636 = {1{`RANDOM}};
  b_23_0 = _RAND_636[15:0];
  _RAND_637 = {1{`RANDOM}};
  b_23_1 = _RAND_637[15:0];
  _RAND_638 = {1{`RANDOM}};
  b_23_2 = _RAND_638[15:0];
  _RAND_639 = {1{`RANDOM}};
  b_23_3 = _RAND_639[15:0];
  _RAND_640 = {1{`RANDOM}};
  b_24_0 = _RAND_640[15:0];
  _RAND_641 = {1{`RANDOM}};
  b_24_1 = _RAND_641[15:0];
  _RAND_642 = {1{`RANDOM}};
  b_24_2 = _RAND_642[15:0];
  _RAND_643 = {1{`RANDOM}};
  b_24_3 = _RAND_643[15:0];
  _RAND_644 = {1{`RANDOM}};
  b_25_0 = _RAND_644[15:0];
  _RAND_645 = {1{`RANDOM}};
  b_25_1 = _RAND_645[15:0];
  _RAND_646 = {1{`RANDOM}};
  b_25_2 = _RAND_646[15:0];
  _RAND_647 = {1{`RANDOM}};
  b_25_3 = _RAND_647[15:0];
  _RAND_648 = {1{`RANDOM}};
  b_26_0 = _RAND_648[15:0];
  _RAND_649 = {1{`RANDOM}};
  b_26_1 = _RAND_649[15:0];
  _RAND_650 = {1{`RANDOM}};
  b_26_2 = _RAND_650[15:0];
  _RAND_651 = {1{`RANDOM}};
  b_26_3 = _RAND_651[15:0];
  _RAND_652 = {1{`RANDOM}};
  b_27_0 = _RAND_652[15:0];
  _RAND_653 = {1{`RANDOM}};
  b_27_1 = _RAND_653[15:0];
  _RAND_654 = {1{`RANDOM}};
  b_27_2 = _RAND_654[15:0];
  _RAND_655 = {1{`RANDOM}};
  b_27_3 = _RAND_655[15:0];
  _RAND_656 = {1{`RANDOM}};
  b_28_0 = _RAND_656[15:0];
  _RAND_657 = {1{`RANDOM}};
  b_28_1 = _RAND_657[15:0];
  _RAND_658 = {1{`RANDOM}};
  b_28_2 = _RAND_658[15:0];
  _RAND_659 = {1{`RANDOM}};
  b_28_3 = _RAND_659[15:0];
  _RAND_660 = {1{`RANDOM}};
  b_29_0 = _RAND_660[15:0];
  _RAND_661 = {1{`RANDOM}};
  b_29_1 = _RAND_661[15:0];
  _RAND_662 = {1{`RANDOM}};
  b_29_2 = _RAND_662[15:0];
  _RAND_663 = {1{`RANDOM}};
  b_29_3 = _RAND_663[15:0];
  _RAND_664 = {1{`RANDOM}};
  b_30_0 = _RAND_664[15:0];
  _RAND_665 = {1{`RANDOM}};
  b_30_1 = _RAND_665[15:0];
  _RAND_666 = {1{`RANDOM}};
  b_30_2 = _RAND_666[15:0];
  _RAND_667 = {1{`RANDOM}};
  b_30_3 = _RAND_667[15:0];
  _RAND_668 = {1{`RANDOM}};
  b_31_0 = _RAND_668[15:0];
  _RAND_669 = {1{`RANDOM}};
  b_31_1 = _RAND_669[15:0];
  _RAND_670 = {1{`RANDOM}};
  b_31_2 = _RAND_670[15:0];
  _RAND_671 = {1{`RANDOM}};
  b_31_3 = _RAND_671[15:0];
  _RAND_672 = {1{`RANDOM}};
  active_0 = _RAND_672[0:0];
  _RAND_673 = {1{`RANDOM}};
  active_1 = _RAND_673[0:0];
  _RAND_674 = {1{`RANDOM}};
  active_2 = _RAND_674[0:0];
  _RAND_675 = {1{`RANDOM}};
  active_3 = _RAND_675[0:0];
  _RAND_676 = {1{`RANDOM}};
  active_4 = _RAND_676[0:0];
  _RAND_677 = {1{`RANDOM}};
  active_5 = _RAND_677[0:0];
  _RAND_678 = {1{`RANDOM}};
  active_6 = _RAND_678[0:0];
  _RAND_679 = {1{`RANDOM}};
  active_7 = _RAND_679[0:0];
  _RAND_680 = {1{`RANDOM}};
  active_8 = _RAND_680[0:0];
  _RAND_681 = {1{`RANDOM}};
  active_9 = _RAND_681[0:0];
  _RAND_682 = {1{`RANDOM}};
  active_10 = _RAND_682[0:0];
  _RAND_683 = {1{`RANDOM}};
  active_11 = _RAND_683[0:0];
  _RAND_684 = {1{`RANDOM}};
  active_12 = _RAND_684[0:0];
  _RAND_685 = {1{`RANDOM}};
  active_13 = _RAND_685[0:0];
  _RAND_686 = {1{`RANDOM}};
  active_14 = _RAND_686[0:0];
  _RAND_687 = {1{`RANDOM}};
  active_15 = _RAND_687[0:0];
  _RAND_688 = {1{`RANDOM}};
  active_16 = _RAND_688[0:0];
  _RAND_689 = {1{`RANDOM}};
  active_17 = _RAND_689[0:0];
  _RAND_690 = {1{`RANDOM}};
  active_18 = _RAND_690[0:0];
  _RAND_691 = {1{`RANDOM}};
  active_19 = _RAND_691[0:0];
  _RAND_692 = {1{`RANDOM}};
  active_20 = _RAND_692[0:0];
  _RAND_693 = {1{`RANDOM}};
  active_21 = _RAND_693[0:0];
  _RAND_694 = {1{`RANDOM}};
  active_22 = _RAND_694[0:0];
  _RAND_695 = {1{`RANDOM}};
  active_23 = _RAND_695[0:0];
  _RAND_696 = {1{`RANDOM}};
  active_24 = _RAND_696[0:0];
  _RAND_697 = {1{`RANDOM}};
  active_25 = _RAND_697[0:0];
  _RAND_698 = {1{`RANDOM}};
  active_26 = _RAND_698[0:0];
  _RAND_699 = {1{`RANDOM}};
  active_27 = _RAND_699[0:0];
  _RAND_700 = {1{`RANDOM}};
  active_28 = _RAND_700[0:0];
  _RAND_701 = {1{`RANDOM}};
  active_29 = _RAND_701[0:0];
  _RAND_702 = {1{`RANDOM}};
  active_30 = _RAND_702[0:0];
  _RAND_703 = {1{`RANDOM}};
  active_31 = _RAND_703[0:0];
  _RAND_704 = {1{`RANDOM}};
  op = _RAND_704[15:0];
  _RAND_705 = {1{`RANDOM}};
  dtype = _RAND_705[3:0];
  _RAND_706 = {1{`RANDOM}};
  dest = _RAND_706[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecSfuWarpUnit(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [15:0] io_req_bits_op,
  input  [3:0]  io_req_bits_dtype,
  input  [31:0] io_req_bits_activeMask,
  input  [63:0] io_req_bits_a_0,
  input  [63:0] io_req_bits_a_1,
  input  [63:0] io_req_bits_a_2,
  input  [63:0] io_req_bits_a_3,
  input  [63:0] io_req_bits_a_4,
  input  [63:0] io_req_bits_a_5,
  input  [63:0] io_req_bits_a_6,
  input  [63:0] io_req_bits_a_7,
  input  [63:0] io_req_bits_a_8,
  input  [63:0] io_req_bits_a_9,
  input  [63:0] io_req_bits_a_10,
  input  [63:0] io_req_bits_a_11,
  input  [63:0] io_req_bits_a_12,
  input  [63:0] io_req_bits_a_13,
  input  [63:0] io_req_bits_a_14,
  input  [63:0] io_req_bits_a_15,
  input  [63:0] io_req_bits_a_16,
  input  [63:0] io_req_bits_a_17,
  input  [63:0] io_req_bits_a_18,
  input  [63:0] io_req_bits_a_19,
  input  [63:0] io_req_bits_a_20,
  input  [63:0] io_req_bits_a_21,
  input  [63:0] io_req_bits_a_22,
  input  [63:0] io_req_bits_a_23,
  input  [63:0] io_req_bits_a_24,
  input  [63:0] io_req_bits_a_25,
  input  [63:0] io_req_bits_a_26,
  input  [63:0] io_req_bits_a_27,
  input  [63:0] io_req_bits_a_28,
  input  [63:0] io_req_bits_a_29,
  input  [63:0] io_req_bits_a_30,
  input  [63:0] io_req_bits_a_31,
  input  [63:0] io_req_bits_b_0,
  input  [63:0] io_req_bits_b_1,
  input  [63:0] io_req_bits_b_2,
  input  [63:0] io_req_bits_b_3,
  input  [63:0] io_req_bits_b_4,
  input  [63:0] io_req_bits_b_5,
  input  [63:0] io_req_bits_b_6,
  input  [63:0] io_req_bits_b_7,
  input  [63:0] io_req_bits_b_8,
  input  [63:0] io_req_bits_b_9,
  input  [63:0] io_req_bits_b_10,
  input  [63:0] io_req_bits_b_11,
  input  [63:0] io_req_bits_b_12,
  input  [63:0] io_req_bits_b_13,
  input  [63:0] io_req_bits_b_14,
  input  [63:0] io_req_bits_b_15,
  input  [63:0] io_req_bits_b_16,
  input  [63:0] io_req_bits_b_17,
  input  [63:0] io_req_bits_b_18,
  input  [63:0] io_req_bits_b_19,
  input  [63:0] io_req_bits_b_20,
  input  [63:0] io_req_bits_b_21,
  input  [63:0] io_req_bits_b_22,
  input  [63:0] io_req_bits_b_23,
  input  [63:0] io_req_bits_b_24,
  input  [63:0] io_req_bits_b_25,
  input  [63:0] io_req_bits_b_26,
  input  [63:0] io_req_bits_b_27,
  input  [63:0] io_req_bits_b_28,
  input  [63:0] io_req_bits_b_29,
  input  [63:0] io_req_bits_b_30,
  input  [63:0] io_req_bits_b_31,
  input  [63:0] io_req_bits_c_0,
  input  [63:0] io_req_bits_c_1,
  input  [63:0] io_req_bits_c_2,
  input  [63:0] io_req_bits_c_3,
  input  [63:0] io_req_bits_c_4,
  input  [63:0] io_req_bits_c_5,
  input  [63:0] io_req_bits_c_6,
  input  [63:0] io_req_bits_c_7,
  input  [63:0] io_req_bits_c_8,
  input  [63:0] io_req_bits_c_9,
  input  [63:0] io_req_bits_c_10,
  input  [63:0] io_req_bits_c_11,
  input  [63:0] io_req_bits_c_12,
  input  [63:0] io_req_bits_c_13,
  input  [63:0] io_req_bits_c_14,
  input  [63:0] io_req_bits_c_15,
  input  [63:0] io_req_bits_c_16,
  input  [63:0] io_req_bits_c_17,
  input  [63:0] io_req_bits_c_18,
  input  [63:0] io_req_bits_c_19,
  input  [63:0] io_req_bits_c_20,
  input  [63:0] io_req_bits_c_21,
  input  [63:0] io_req_bits_c_22,
  input  [63:0] io_req_bits_c_23,
  input  [63:0] io_req_bits_c_24,
  input  [63:0] io_req_bits_c_25,
  input  [63:0] io_req_bits_c_26,
  input  [63:0] io_req_bits_c_27,
  input  [63:0] io_req_bits_c_28,
  input  [63:0] io_req_bits_c_29,
  input  [63:0] io_req_bits_c_30,
  input  [63:0] io_req_bits_c_31,
  input  [7:0]  io_req_bits_dest,
  input  [2:0]  io_req_bits_predicateSelect,
  input  [31:0] io_req_bits_predicateValues,
  input  [2:0]  io_mode,
  input         io_resp_ready,
  output        io_resp_valid,
  output [63:0] io_resp_bits_result_0,
  output [63:0] io_resp_bits_result_1,
  output [63:0] io_resp_bits_result_2,
  output [63:0] io_resp_bits_result_3,
  output [63:0] io_resp_bits_result_4,
  output [63:0] io_resp_bits_result_5,
  output [63:0] io_resp_bits_result_6,
  output [63:0] io_resp_bits_result_7,
  output [63:0] io_resp_bits_result_8,
  output [63:0] io_resp_bits_result_9,
  output [63:0] io_resp_bits_result_10,
  output [63:0] io_resp_bits_result_11,
  output [63:0] io_resp_bits_result_12,
  output [63:0] io_resp_bits_result_13,
  output [63:0] io_resp_bits_result_14,
  output [63:0] io_resp_bits_result_15,
  output [63:0] io_resp_bits_result_16,
  output [63:0] io_resp_bits_result_17,
  output [63:0] io_resp_bits_result_18,
  output [63:0] io_resp_bits_result_19,
  output [63:0] io_resp_bits_result_20,
  output [63:0] io_resp_bits_result_21,
  output [63:0] io_resp_bits_result_22,
  output [63:0] io_resp_bits_result_23,
  output [63:0] io_resp_bits_result_24,
  output [63:0] io_resp_bits_result_25,
  output [63:0] io_resp_bits_result_26,
  output [63:0] io_resp_bits_result_27,
  output [63:0] io_resp_bits_result_28,
  output [63:0] io_resp_bits_result_29,
  output [63:0] io_resp_bits_result_30,
  output [63:0] io_resp_bits_result_31,
  output [31:0] io_resp_bits_predicateMask,
  output [31:0] io_resp_bits_errorMask,
  output [4:0]  io_resp_bits_exceptionFlags_0,
  output [4:0]  io_resp_bits_exceptionFlags_1,
  output [4:0]  io_resp_bits_exceptionFlags_2,
  output [4:0]  io_resp_bits_exceptionFlags_3,
  output [4:0]  io_resp_bits_exceptionFlags_4,
  output [4:0]  io_resp_bits_exceptionFlags_5,
  output [4:0]  io_resp_bits_exceptionFlags_6,
  output [4:0]  io_resp_bits_exceptionFlags_7,
  output [4:0]  io_resp_bits_exceptionFlags_8,
  output [4:0]  io_resp_bits_exceptionFlags_9,
  output [4:0]  io_resp_bits_exceptionFlags_10,
  output [4:0]  io_resp_bits_exceptionFlags_11,
  output [4:0]  io_resp_bits_exceptionFlags_12,
  output [4:0]  io_resp_bits_exceptionFlags_13,
  output [4:0]  io_resp_bits_exceptionFlags_14,
  output [4:0]  io_resp_bits_exceptionFlags_15,
  output [4:0]  io_resp_bits_exceptionFlags_16,
  output [4:0]  io_resp_bits_exceptionFlags_17,
  output [4:0]  io_resp_bits_exceptionFlags_18,
  output [4:0]  io_resp_bits_exceptionFlags_19,
  output [4:0]  io_resp_bits_exceptionFlags_20,
  output [4:0]  io_resp_bits_exceptionFlags_21,
  output [4:0]  io_resp_bits_exceptionFlags_22,
  output [4:0]  io_resp_bits_exceptionFlags_23,
  output [4:0]  io_resp_bits_exceptionFlags_24,
  output [4:0]  io_resp_bits_exceptionFlags_25,
  output [4:0]  io_resp_bits_exceptionFlags_26,
  output [4:0]  io_resp_bits_exceptionFlags_27,
  output [4:0]  io_resp_bits_exceptionFlags_28,
  output [4:0]  io_resp_bits_exceptionFlags_29,
  output [4:0]  io_resp_bits_exceptionFlags_30,
  output [4:0]  io_resp_bits_exceptionFlags_31,
  output [31:0] io_resp_bits_activeMask,
  output [7:0]  io_resp_bits_dest
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
`endif // RANDOMIZE_REG_INIT
  wire  lanes_0_clock; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_reset; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_io_req_valid; // @[AecSfuWarpUnit.scala 16:45]
  wire [15:0] lanes_0_io_req_bits_op; // @[AecSfuWarpUnit.scala 16:45]
  wire [3:0] lanes_0_io_req_bits_dtype; // @[AecSfuWarpUnit.scala 16:45]
  wire [63:0] lanes_0_io_req_bits_a; // @[AecSfuWarpUnit.scala 16:45]
  wire [63:0] lanes_0_io_req_bits_b; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_io_resp_ready; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 16:45]
  wire [63:0] lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 16:45]
  wire  lanes_0_io_resp_bits_error; // @[AecSfuWarpUnit.scala 16:45]
  wire [4:0] lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 16:45]
  wire  requestBuffer_clock; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_reset; // @[AecSfuWarpUnit.scala 19:29]
  wire [15:0] requestBuffer_io_in_op; // @[AecSfuWarpUnit.scala 19:29]
  wire [3:0] requestBuffer_io_in_dtype; // @[AecSfuWarpUnit.scala 19:29]
  wire [31:0] requestBuffer_io_in_activeMask; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_0; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_1; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_2; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_3; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_4; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_5; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_6; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_7; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_8; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_9; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_10; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_11; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_12; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_13; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_14; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_15; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_16; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_17; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_18; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_19; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_20; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_21; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_22; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_23; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_24; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_25; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_26; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_27; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_28; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_29; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_30; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_a_31; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_0; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_1; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_2; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_3; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_4; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_5; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_6; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_7; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_8; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_9; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_10; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_11; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_12; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_13; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_14; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_15; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_16; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_17; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_18; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_19; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_20; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_21; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_22; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_23; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_24; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_25; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_26; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_27; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_28; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_29; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_30; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_in_b_31; // @[AecSfuWarpUnit.scala 19:29]
  wire [7:0] requestBuffer_io_in_dest; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_0; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_1; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_2; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_3; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_4; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_5; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_6; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_arm_7; // @[AecSfuWarpUnit.scala 19:29]
  wire  requestBuffer_io_capture; // @[AecSfuWarpUnit.scala 19:29]
  wire [15:0] requestBuffer_io_out_op; // @[AecSfuWarpUnit.scala 19:29]
  wire [3:0] requestBuffer_io_out_dtype; // @[AecSfuWarpUnit.scala 19:29]
  wire [31:0] requestBuffer_io_out_activeMask; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_0; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_1; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_2; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_3; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_4; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_5; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_6; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_7; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_8; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_9; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_10; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_11; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_12; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_13; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_14; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_15; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_16; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_17; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_18; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_19; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_20; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_21; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_22; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_23; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_24; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_25; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_26; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_27; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_28; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_29; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_30; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_a_31; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_0; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_1; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_2; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_3; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_4; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_5; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_6; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_7; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_8; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_9; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_10; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_11; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_12; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_13; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_14; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_15; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_16; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_17; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_18; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_19; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_20; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_21; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_22; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_23; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_24; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_25; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_26; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_27; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_28; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_29; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_30; // @[AecSfuWarpUnit.scala 19:29]
  wire [63:0] requestBuffer_io_out_b_31; // @[AecSfuWarpUnit.scala 19:29]
  wire [7:0] requestBuffer_io_out_dest; // @[AecSfuWarpUnit.scala 19:29]
  reg [2:0] state; // @[AecSfuWarpUnit.scala 18:22]
  reg [4:0] group; // @[AecSfuWarpUnit.scala 23:22]
  reg [63:0] results_0; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_1; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_2; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_3; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_4; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_5; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_6; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_7; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_8; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_9; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_10; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_11; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_12; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_13; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_14; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_15; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_16; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_17; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_18; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_19; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_20; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_21; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_22; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_23; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_24; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_25; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_26; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_27; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_28; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_29; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_30; // @[AecSfuWarpUnit.scala 24:24]
  reg [63:0] results_31; // @[AecSfuWarpUnit.scala 24:24]
  reg [31:0] errors; // @[AecSfuWarpUnit.scala 25:23]
  reg [4:0] flags_0; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_1; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_2; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_3; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_4; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_5; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_6; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_7; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_8; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_9; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_10; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_11; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_12; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_13; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_14; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_15; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_16; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_17; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_18; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_19; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_20; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_21; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_22; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_23; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_24; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_25; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_26; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_27; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_28; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_29; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_30; // @[AecSfuWarpUnit.scala 26:22]
  reg [4:0] flags_31; // @[AecSfuWarpUnit.scala 26:22]
  reg [31:0] writeMask; // @[AecSfuWarpUnit.scala 27:26]
  wire [5:0] base = group * 1'h1; // @[AecSfuWarpUnit.scala 28:20]
  wire  armCapture = state == 3'h0 & io_req_valid; // @[AecSfuWarpUnit.scala 32:35]
  reg  armClusters_0; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_1; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_2; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_3; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_4; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_5; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_6; // @[AecSfuWarpUnit.scala 33:28]
  reg  armClusters_7; // @[AecSfuWarpUnit.scala 33:28]
  wire  _requestBuffer_io_capture_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [6:0] _lane_T = {{1'd0}, base}; // @[AecSfuWarpUnit.scala 48:21]
  wire [5:0] lane = _lane_T[5:0]; // @[AecSfuWarpUnit.scala 48:21]
  wire  _lanes_0_io_req_valid_T_1 = state == 3'h3 & lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 49:46]
  wire [63:0] _GEN_0 = requestBuffer_io_out_a_0; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_1 = 5'h1 == lane[4:0] ? requestBuffer_io_out_a_1 : _GEN_0; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_2 = 5'h2 == lane[4:0] ? requestBuffer_io_out_a_2 : _GEN_1; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_3 = 5'h3 == lane[4:0] ? requestBuffer_io_out_a_3 : _GEN_2; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_4 = 5'h4 == lane[4:0] ? requestBuffer_io_out_a_4 : _GEN_3; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_5 = 5'h5 == lane[4:0] ? requestBuffer_io_out_a_5 : _GEN_4; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_6 = 5'h6 == lane[4:0] ? requestBuffer_io_out_a_6 : _GEN_5; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_7 = 5'h7 == lane[4:0] ? requestBuffer_io_out_a_7 : _GEN_6; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_8 = 5'h8 == lane[4:0] ? requestBuffer_io_out_a_8 : _GEN_7; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_9 = 5'h9 == lane[4:0] ? requestBuffer_io_out_a_9 : _GEN_8; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_10 = 5'ha == lane[4:0] ? requestBuffer_io_out_a_10 : _GEN_9; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_11 = 5'hb == lane[4:0] ? requestBuffer_io_out_a_11 : _GEN_10; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_12 = 5'hc == lane[4:0] ? requestBuffer_io_out_a_12 : _GEN_11; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_13 = 5'hd == lane[4:0] ? requestBuffer_io_out_a_13 : _GEN_12; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_14 = 5'he == lane[4:0] ? requestBuffer_io_out_a_14 : _GEN_13; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_15 = 5'hf == lane[4:0] ? requestBuffer_io_out_a_15 : _GEN_14; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_16 = 5'h10 == lane[4:0] ? requestBuffer_io_out_a_16 : _GEN_15; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_17 = 5'h11 == lane[4:0] ? requestBuffer_io_out_a_17 : _GEN_16; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_18 = 5'h12 == lane[4:0] ? requestBuffer_io_out_a_18 : _GEN_17; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_19 = 5'h13 == lane[4:0] ? requestBuffer_io_out_a_19 : _GEN_18; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_20 = 5'h14 == lane[4:0] ? requestBuffer_io_out_a_20 : _GEN_19; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_21 = 5'h15 == lane[4:0] ? requestBuffer_io_out_a_21 : _GEN_20; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_22 = 5'h16 == lane[4:0] ? requestBuffer_io_out_a_22 : _GEN_21; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_23 = 5'h17 == lane[4:0] ? requestBuffer_io_out_a_23 : _GEN_22; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_24 = 5'h18 == lane[4:0] ? requestBuffer_io_out_a_24 : _GEN_23; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_25 = 5'h19 == lane[4:0] ? requestBuffer_io_out_a_25 : _GEN_24; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_26 = 5'h1a == lane[4:0] ? requestBuffer_io_out_a_26 : _GEN_25; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_27 = 5'h1b == lane[4:0] ? requestBuffer_io_out_a_27 : _GEN_26; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_28 = 5'h1c == lane[4:0] ? requestBuffer_io_out_a_28 : _GEN_27; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_29 = 5'h1d == lane[4:0] ? requestBuffer_io_out_a_29 : _GEN_28; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_30 = 5'h1e == lane[4:0] ? requestBuffer_io_out_a_30 : _GEN_29; // @[AecSfuWarpUnit.scala 53:{28,28}]
  wire [63:0] _GEN_32 = requestBuffer_io_out_b_0; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_33 = 5'h1 == lane[4:0] ? requestBuffer_io_out_b_1 : _GEN_32; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_34 = 5'h2 == lane[4:0] ? requestBuffer_io_out_b_2 : _GEN_33; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_35 = 5'h3 == lane[4:0] ? requestBuffer_io_out_b_3 : _GEN_34; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_36 = 5'h4 == lane[4:0] ? requestBuffer_io_out_b_4 : _GEN_35; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_37 = 5'h5 == lane[4:0] ? requestBuffer_io_out_b_5 : _GEN_36; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_38 = 5'h6 == lane[4:0] ? requestBuffer_io_out_b_6 : _GEN_37; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_39 = 5'h7 == lane[4:0] ? requestBuffer_io_out_b_7 : _GEN_38; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_40 = 5'h8 == lane[4:0] ? requestBuffer_io_out_b_8 : _GEN_39; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_41 = 5'h9 == lane[4:0] ? requestBuffer_io_out_b_9 : _GEN_40; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_42 = 5'ha == lane[4:0] ? requestBuffer_io_out_b_10 : _GEN_41; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_43 = 5'hb == lane[4:0] ? requestBuffer_io_out_b_11 : _GEN_42; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_44 = 5'hc == lane[4:0] ? requestBuffer_io_out_b_12 : _GEN_43; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_45 = 5'hd == lane[4:0] ? requestBuffer_io_out_b_13 : _GEN_44; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_46 = 5'he == lane[4:0] ? requestBuffer_io_out_b_14 : _GEN_45; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_47 = 5'hf == lane[4:0] ? requestBuffer_io_out_b_15 : _GEN_46; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_48 = 5'h10 == lane[4:0] ? requestBuffer_io_out_b_16 : _GEN_47; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_49 = 5'h11 == lane[4:0] ? requestBuffer_io_out_b_17 : _GEN_48; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_50 = 5'h12 == lane[4:0] ? requestBuffer_io_out_b_18 : _GEN_49; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_51 = 5'h13 == lane[4:0] ? requestBuffer_io_out_b_19 : _GEN_50; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_52 = 5'h14 == lane[4:0] ? requestBuffer_io_out_b_20 : _GEN_51; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_53 = 5'h15 == lane[4:0] ? requestBuffer_io_out_b_21 : _GEN_52; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_54 = 5'h16 == lane[4:0] ? requestBuffer_io_out_b_22 : _GEN_53; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_55 = 5'h17 == lane[4:0] ? requestBuffer_io_out_b_23 : _GEN_54; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_56 = 5'h18 == lane[4:0] ? requestBuffer_io_out_b_24 : _GEN_55; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_57 = 5'h19 == lane[4:0] ? requestBuffer_io_out_b_25 : _GEN_56; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_58 = 5'h1a == lane[4:0] ? requestBuffer_io_out_b_26 : _GEN_57; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_59 = 5'h1b == lane[4:0] ? requestBuffer_io_out_b_27 : _GEN_58; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_60 = 5'h1c == lane[4:0] ? requestBuffer_io_out_b_28 : _GEN_59; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_61 = 5'h1d == lane[4:0] ? requestBuffer_io_out_b_29 : _GEN_60; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire [63:0] _GEN_62 = 5'h1e == lane[4:0] ? requestBuffer_io_out_b_30 : _GEN_61; // @[AecSfuWarpUnit.scala 54:{28,28}]
  wire  _lanes_0_io_resp_ready_T_1 = state == 3'h4 & lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 56:51]
  wire [2:0] _GEN_64 = armCapture ? 3'h1 : state; // @[AecSfuWarpUnit.scala 59:21 18:22 59:29]
  wire [2:0] _GEN_65 = state == 3'h1 ? 3'h2 : _GEN_64; // @[AecSfuWarpUnit.scala 60:{24,32}]
  wire [2:0] _state_T_1 = |io_req_bits_activeMask ? 3'h3 : 3'h5; // @[AecSfuWarpUnit.scala 66:17]
  wire [4:0] _GEN_67 = _requestBuffer_io_capture_T ? 5'h0 : group; // @[AecSfuWarpUnit.scala 61:22 63:11 23:22]
  wire [31:0] _GEN_68 = _requestBuffer_io_capture_T ? 32'h0 : errors; // @[AecSfuWarpUnit.scala 61:22 64:12 25:23]
  wire [31:0] _GEN_69 = _requestBuffer_io_capture_T ? 32'h0 : writeMask; // @[AecSfuWarpUnit.scala 61:22 65:15 27:26]
  wire [2:0] _GEN_70 = _requestBuffer_io_capture_T ? _state_T_1 : _GEN_65; // @[AecSfuWarpUnit.scala 61:22 66:11]
  wire [31:0] _completedMask_T_2 = requestBuffer_io_out_activeMask >> lane; // @[AecSfuWarpUnit.scala 70:81]
  wire [63:0] _GEN_31 = {{63'd0}, _completedMask_T_2[0]}; // @[AecSfuWarpUnit.scala 70:103]
  wire [63:0] completedMask = _GEN_31 << base; // @[AecSfuWarpUnit.scala 70:103]
  wire  _errorGroup_T_4 = _completedMask_T_2[0] & lanes_0_io_resp_bits_error; // @[AecSfuWarpUnit.scala 72:35]
  wire [63:0] _GEN_63 = {{63'd0}, _errorGroup_T_4}; // @[AecSfuWarpUnit.scala 72:75]
  wire [63:0] errorGroup = _GEN_63 << base; // @[AecSfuWarpUnit.scala 72:75]
  wire [63:0] _results_T_136 = lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 76:{23,23}]
  wire [4:0] _flags_T_137 = lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 77:{21,21}]
  wire [63:0] _GEN_271 = {{32'd0}, writeMask}; // @[AecSfuWarpUnit.scala 80:28]
  wire [63:0] _writeMask_T = _GEN_271 | completedMask; // @[AecSfuWarpUnit.scala 80:28]
  wire [63:0] _GEN_272 = {{32'd0}, errors}; // @[AecSfuWarpUnit.scala 81:22]
  wire [63:0] _errors_T = _GEN_272 | errorGroup; // @[AecSfuWarpUnit.scala 81:22]
  wire [5:0] _consumed_T_1 = base + 6'h1; // @[AecSfuWarpUnit.scala 82:40]
  wire [95:0] _consumed_T_2 = 96'h1 << _consumed_T_1; // @[AecSfuWarpUnit.scala 82:31]
  wire [95:0] consumed = _consumed_T_2 - 96'h1; // @[AecSfuWarpUnit.scala 82:60]
  wire [32:0] _remaining_T = {1'h0,requestBuffer_io_out_activeMask}; // @[Cat.scala 33:92]
  wire [95:0] _remaining_T_1 = ~consumed; // @[AecSfuWarpUnit.scala 83:55]
  wire [95:0] _GEN_273 = {{63'd0}, _remaining_T}; // @[AecSfuWarpUnit.scala 83:53]
  wire [95:0] _remaining_T_2 = _GEN_273 & _remaining_T_1; // @[AecSfuWarpUnit.scala 83:53]
  wire [31:0] remaining = _remaining_T_2[31:0]; // @[AecSfuWarpUnit.scala 83:65]
  wire [4:0] _group_T_32 = remaining[30] ? 5'h1e : 5'h1f; // @[Mux.scala 47:70]
  wire [4:0] _group_T_33 = remaining[29] ? 5'h1d : _group_T_32; // @[Mux.scala 47:70]
  wire [4:0] _group_T_34 = remaining[28] ? 5'h1c : _group_T_33; // @[Mux.scala 47:70]
  wire [4:0] _group_T_35 = remaining[27] ? 5'h1b : _group_T_34; // @[Mux.scala 47:70]
  wire [4:0] _group_T_36 = remaining[26] ? 5'h1a : _group_T_35; // @[Mux.scala 47:70]
  wire [4:0] _group_T_37 = remaining[25] ? 5'h19 : _group_T_36; // @[Mux.scala 47:70]
  wire [4:0] _group_T_38 = remaining[24] ? 5'h18 : _group_T_37; // @[Mux.scala 47:70]
  wire [4:0] _group_T_39 = remaining[23] ? 5'h17 : _group_T_38; // @[Mux.scala 47:70]
  wire [4:0] _group_T_40 = remaining[22] ? 5'h16 : _group_T_39; // @[Mux.scala 47:70]
  wire [4:0] _group_T_41 = remaining[21] ? 5'h15 : _group_T_40; // @[Mux.scala 47:70]
  wire [4:0] _group_T_42 = remaining[20] ? 5'h14 : _group_T_41; // @[Mux.scala 47:70]
  wire [4:0] _group_T_43 = remaining[19] ? 5'h13 : _group_T_42; // @[Mux.scala 47:70]
  wire [4:0] _group_T_44 = remaining[18] ? 5'h12 : _group_T_43; // @[Mux.scala 47:70]
  wire [4:0] _group_T_45 = remaining[17] ? 5'h11 : _group_T_44; // @[Mux.scala 47:70]
  wire [4:0] _group_T_46 = remaining[16] ? 5'h10 : _group_T_45; // @[Mux.scala 47:70]
  wire [4:0] _group_T_47 = remaining[15] ? 5'hf : _group_T_46; // @[Mux.scala 47:70]
  wire [4:0] _group_T_48 = remaining[14] ? 5'he : _group_T_47; // @[Mux.scala 47:70]
  wire [4:0] _group_T_49 = remaining[13] ? 5'hd : _group_T_48; // @[Mux.scala 47:70]
  wire [4:0] _group_T_50 = remaining[12] ? 5'hc : _group_T_49; // @[Mux.scala 47:70]
  wire [4:0] _group_T_51 = remaining[11] ? 5'hb : _group_T_50; // @[Mux.scala 47:70]
  wire [4:0] _group_T_52 = remaining[10] ? 5'ha : _group_T_51; // @[Mux.scala 47:70]
  wire [4:0] _group_T_53 = remaining[9] ? 5'h9 : _group_T_52; // @[Mux.scala 47:70]
  wire [4:0] _group_T_54 = remaining[8] ? 5'h8 : _group_T_53; // @[Mux.scala 47:70]
  wire [4:0] _group_T_55 = remaining[7] ? 5'h7 : _group_T_54; // @[Mux.scala 47:70]
  wire [4:0] _group_T_56 = remaining[6] ? 5'h6 : _group_T_55; // @[Mux.scala 47:70]
  wire [4:0] _group_T_57 = remaining[5] ? 5'h5 : _group_T_56; // @[Mux.scala 47:70]
  wire [4:0] _group_T_58 = remaining[4] ? 5'h4 : _group_T_57; // @[Mux.scala 47:70]
  wire [4:0] _group_T_59 = remaining[3] ? 5'h3 : _group_T_58; // @[Mux.scala 47:70]
  wire [4:0] _group_T_60 = remaining[2] ? 5'h2 : _group_T_59; // @[Mux.scala 47:70]
  wire [4:0] _group_T_61 = remaining[1] ? 5'h1 : _group_T_60; // @[Mux.scala 47:70]
  wire [63:0] _GEN_266 = _lanes_0_io_resp_ready_T_1 ? _writeMask_T : {{32'd0}, _GEN_69}; // @[AecSfuWarpUnit.scala 69:42 80:15]
  wire [63:0] _GEN_267 = _lanes_0_io_resp_ready_T_1 ? _errors_T : {{32'd0}, _GEN_68}; // @[AecSfuWarpUnit.scala 69:42 81:12]
  wire  _T_140 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [63:0] _GEN_274 = reset ? 64'h0 : _GEN_267; // @[AecSfuWarpUnit.scala 25:{23,23}]
  wire [63:0] _GEN_275 = reset ? 64'h0 : _GEN_266; // @[AecSfuWarpUnit.scala 27:{26,26}]
  AESSFU lanes_0 ( // @[AecSfuWarpUnit.scala 16:45]
    .clock(lanes_0_clock),
    .reset(lanes_0_reset),
    .io_req_ready(lanes_0_io_req_ready),
    .io_req_valid(lanes_0_io_req_valid),
    .io_req_bits_op(lanes_0_io_req_bits_op),
    .io_req_bits_dtype(lanes_0_io_req_bits_dtype),
    .io_req_bits_a(lanes_0_io_req_bits_a),
    .io_req_bits_b(lanes_0_io_req_bits_b),
    .io_resp_ready(lanes_0_io_resp_ready),
    .io_resp_valid(lanes_0_io_resp_valid),
    .io_resp_bits_result(lanes_0_io_resp_bits_result),
    .io_resp_bits_error(lanes_0_io_resp_bits_error),
    .io_resp_bits_exceptionFlags(lanes_0_io_resp_bits_exceptionFlags)
  );
  AecWarpRequestBuffer requestBuffer ( // @[AecSfuWarpUnit.scala 19:29]
    .clock(requestBuffer_clock),
    .reset(requestBuffer_reset),
    .io_in_op(requestBuffer_io_in_op),
    .io_in_dtype(requestBuffer_io_in_dtype),
    .io_in_activeMask(requestBuffer_io_in_activeMask),
    .io_in_a_0(requestBuffer_io_in_a_0),
    .io_in_a_1(requestBuffer_io_in_a_1),
    .io_in_a_2(requestBuffer_io_in_a_2),
    .io_in_a_3(requestBuffer_io_in_a_3),
    .io_in_a_4(requestBuffer_io_in_a_4),
    .io_in_a_5(requestBuffer_io_in_a_5),
    .io_in_a_6(requestBuffer_io_in_a_6),
    .io_in_a_7(requestBuffer_io_in_a_7),
    .io_in_a_8(requestBuffer_io_in_a_8),
    .io_in_a_9(requestBuffer_io_in_a_9),
    .io_in_a_10(requestBuffer_io_in_a_10),
    .io_in_a_11(requestBuffer_io_in_a_11),
    .io_in_a_12(requestBuffer_io_in_a_12),
    .io_in_a_13(requestBuffer_io_in_a_13),
    .io_in_a_14(requestBuffer_io_in_a_14),
    .io_in_a_15(requestBuffer_io_in_a_15),
    .io_in_a_16(requestBuffer_io_in_a_16),
    .io_in_a_17(requestBuffer_io_in_a_17),
    .io_in_a_18(requestBuffer_io_in_a_18),
    .io_in_a_19(requestBuffer_io_in_a_19),
    .io_in_a_20(requestBuffer_io_in_a_20),
    .io_in_a_21(requestBuffer_io_in_a_21),
    .io_in_a_22(requestBuffer_io_in_a_22),
    .io_in_a_23(requestBuffer_io_in_a_23),
    .io_in_a_24(requestBuffer_io_in_a_24),
    .io_in_a_25(requestBuffer_io_in_a_25),
    .io_in_a_26(requestBuffer_io_in_a_26),
    .io_in_a_27(requestBuffer_io_in_a_27),
    .io_in_a_28(requestBuffer_io_in_a_28),
    .io_in_a_29(requestBuffer_io_in_a_29),
    .io_in_a_30(requestBuffer_io_in_a_30),
    .io_in_a_31(requestBuffer_io_in_a_31),
    .io_in_b_0(requestBuffer_io_in_b_0),
    .io_in_b_1(requestBuffer_io_in_b_1),
    .io_in_b_2(requestBuffer_io_in_b_2),
    .io_in_b_3(requestBuffer_io_in_b_3),
    .io_in_b_4(requestBuffer_io_in_b_4),
    .io_in_b_5(requestBuffer_io_in_b_5),
    .io_in_b_6(requestBuffer_io_in_b_6),
    .io_in_b_7(requestBuffer_io_in_b_7),
    .io_in_b_8(requestBuffer_io_in_b_8),
    .io_in_b_9(requestBuffer_io_in_b_9),
    .io_in_b_10(requestBuffer_io_in_b_10),
    .io_in_b_11(requestBuffer_io_in_b_11),
    .io_in_b_12(requestBuffer_io_in_b_12),
    .io_in_b_13(requestBuffer_io_in_b_13),
    .io_in_b_14(requestBuffer_io_in_b_14),
    .io_in_b_15(requestBuffer_io_in_b_15),
    .io_in_b_16(requestBuffer_io_in_b_16),
    .io_in_b_17(requestBuffer_io_in_b_17),
    .io_in_b_18(requestBuffer_io_in_b_18),
    .io_in_b_19(requestBuffer_io_in_b_19),
    .io_in_b_20(requestBuffer_io_in_b_20),
    .io_in_b_21(requestBuffer_io_in_b_21),
    .io_in_b_22(requestBuffer_io_in_b_22),
    .io_in_b_23(requestBuffer_io_in_b_23),
    .io_in_b_24(requestBuffer_io_in_b_24),
    .io_in_b_25(requestBuffer_io_in_b_25),
    .io_in_b_26(requestBuffer_io_in_b_26),
    .io_in_b_27(requestBuffer_io_in_b_27),
    .io_in_b_28(requestBuffer_io_in_b_28),
    .io_in_b_29(requestBuffer_io_in_b_29),
    .io_in_b_30(requestBuffer_io_in_b_30),
    .io_in_b_31(requestBuffer_io_in_b_31),
    .io_in_dest(requestBuffer_io_in_dest),
    .io_arm_0(requestBuffer_io_arm_0),
    .io_arm_1(requestBuffer_io_arm_1),
    .io_arm_2(requestBuffer_io_arm_2),
    .io_arm_3(requestBuffer_io_arm_3),
    .io_arm_4(requestBuffer_io_arm_4),
    .io_arm_5(requestBuffer_io_arm_5),
    .io_arm_6(requestBuffer_io_arm_6),
    .io_arm_7(requestBuffer_io_arm_7),
    .io_capture(requestBuffer_io_capture),
    .io_out_op(requestBuffer_io_out_op),
    .io_out_dtype(requestBuffer_io_out_dtype),
    .io_out_activeMask(requestBuffer_io_out_activeMask),
    .io_out_a_0(requestBuffer_io_out_a_0),
    .io_out_a_1(requestBuffer_io_out_a_1),
    .io_out_a_2(requestBuffer_io_out_a_2),
    .io_out_a_3(requestBuffer_io_out_a_3),
    .io_out_a_4(requestBuffer_io_out_a_4),
    .io_out_a_5(requestBuffer_io_out_a_5),
    .io_out_a_6(requestBuffer_io_out_a_6),
    .io_out_a_7(requestBuffer_io_out_a_7),
    .io_out_a_8(requestBuffer_io_out_a_8),
    .io_out_a_9(requestBuffer_io_out_a_9),
    .io_out_a_10(requestBuffer_io_out_a_10),
    .io_out_a_11(requestBuffer_io_out_a_11),
    .io_out_a_12(requestBuffer_io_out_a_12),
    .io_out_a_13(requestBuffer_io_out_a_13),
    .io_out_a_14(requestBuffer_io_out_a_14),
    .io_out_a_15(requestBuffer_io_out_a_15),
    .io_out_a_16(requestBuffer_io_out_a_16),
    .io_out_a_17(requestBuffer_io_out_a_17),
    .io_out_a_18(requestBuffer_io_out_a_18),
    .io_out_a_19(requestBuffer_io_out_a_19),
    .io_out_a_20(requestBuffer_io_out_a_20),
    .io_out_a_21(requestBuffer_io_out_a_21),
    .io_out_a_22(requestBuffer_io_out_a_22),
    .io_out_a_23(requestBuffer_io_out_a_23),
    .io_out_a_24(requestBuffer_io_out_a_24),
    .io_out_a_25(requestBuffer_io_out_a_25),
    .io_out_a_26(requestBuffer_io_out_a_26),
    .io_out_a_27(requestBuffer_io_out_a_27),
    .io_out_a_28(requestBuffer_io_out_a_28),
    .io_out_a_29(requestBuffer_io_out_a_29),
    .io_out_a_30(requestBuffer_io_out_a_30),
    .io_out_a_31(requestBuffer_io_out_a_31),
    .io_out_b_0(requestBuffer_io_out_b_0),
    .io_out_b_1(requestBuffer_io_out_b_1),
    .io_out_b_2(requestBuffer_io_out_b_2),
    .io_out_b_3(requestBuffer_io_out_b_3),
    .io_out_b_4(requestBuffer_io_out_b_4),
    .io_out_b_5(requestBuffer_io_out_b_5),
    .io_out_b_6(requestBuffer_io_out_b_6),
    .io_out_b_7(requestBuffer_io_out_b_7),
    .io_out_b_8(requestBuffer_io_out_b_8),
    .io_out_b_9(requestBuffer_io_out_b_9),
    .io_out_b_10(requestBuffer_io_out_b_10),
    .io_out_b_11(requestBuffer_io_out_b_11),
    .io_out_b_12(requestBuffer_io_out_b_12),
    .io_out_b_13(requestBuffer_io_out_b_13),
    .io_out_b_14(requestBuffer_io_out_b_14),
    .io_out_b_15(requestBuffer_io_out_b_15),
    .io_out_b_16(requestBuffer_io_out_b_16),
    .io_out_b_17(requestBuffer_io_out_b_17),
    .io_out_b_18(requestBuffer_io_out_b_18),
    .io_out_b_19(requestBuffer_io_out_b_19),
    .io_out_b_20(requestBuffer_io_out_b_20),
    .io_out_b_21(requestBuffer_io_out_b_21),
    .io_out_b_22(requestBuffer_io_out_b_22),
    .io_out_b_23(requestBuffer_io_out_b_23),
    .io_out_b_24(requestBuffer_io_out_b_24),
    .io_out_b_25(requestBuffer_io_out_b_25),
    .io_out_b_26(requestBuffer_io_out_b_26),
    .io_out_b_27(requestBuffer_io_out_b_27),
    .io_out_b_28(requestBuffer_io_out_b_28),
    .io_out_b_29(requestBuffer_io_out_b_29),
    .io_out_b_30(requestBuffer_io_out_b_30),
    .io_out_b_31(requestBuffer_io_out_b_31),
    .io_out_dest(requestBuffer_io_out_dest)
  );
  assign io_req_ready = state == 3'h2; // @[AecSfuWarpUnit.scala 38:25]
  assign io_resp_valid = state == 3'h5; // @[AecSfuWarpUnit.scala 39:26]
  assign io_resp_bits_result_0 = writeMask[0] ? results_0 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_1 = writeMask[1] ? results_1 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_2 = writeMask[2] ? results_2 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_3 = writeMask[3] ? results_3 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_4 = writeMask[4] ? results_4 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_5 = writeMask[5] ? results_5 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_6 = writeMask[6] ? results_6 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_7 = writeMask[7] ? results_7 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_8 = writeMask[8] ? results_8 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_9 = writeMask[9] ? results_9 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_10 = writeMask[10] ? results_10 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_11 = writeMask[11] ? results_11 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_12 = writeMask[12] ? results_12 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_13 = writeMask[13] ? results_13 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_14 = writeMask[14] ? results_14 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_15 = writeMask[15] ? results_15 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_16 = writeMask[16] ? results_16 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_17 = writeMask[17] ? results_17 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_18 = writeMask[18] ? results_18 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_19 = writeMask[19] ? results_19 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_20 = writeMask[20] ? results_20 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_21 = writeMask[21] ? results_21 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_22 = writeMask[22] ? results_22 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_23 = writeMask[23] ? results_23 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_24 = writeMask[24] ? results_24 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_25 = writeMask[25] ? results_25 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_26 = writeMask[26] ? results_26 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_27 = writeMask[27] ? results_27 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_28 = writeMask[28] ? results_28 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_29 = writeMask[29] ? results_29 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_30 = writeMask[30] ? results_30 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_result_31 = writeMask[31] ? results_31 : 64'h0; // @[AecSfuWarpUnit.scala 40:59]
  assign io_resp_bits_predicateMask = 32'h0; // @[AecSfuWarpUnit.scala 41:30]
  assign io_resp_bits_errorMask = errors; // @[AecSfuWarpUnit.scala 42:26]
  assign io_resp_bits_exceptionFlags_0 = writeMask[0] ? flags_0 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_1 = writeMask[1] ? flags_1 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_2 = writeMask[2] ? flags_2 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_3 = writeMask[3] ? flags_3 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_4 = writeMask[4] ? flags_4 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_5 = writeMask[5] ? flags_5 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_6 = writeMask[6] ? flags_6 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_7 = writeMask[7] ? flags_7 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_8 = writeMask[8] ? flags_8 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_9 = writeMask[9] ? flags_9 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_10 = writeMask[10] ? flags_10 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_11 = writeMask[11] ? flags_11 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_12 = writeMask[12] ? flags_12 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_13 = writeMask[13] ? flags_13 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_14 = writeMask[14] ? flags_14 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_15 = writeMask[15] ? flags_15 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_16 = writeMask[16] ? flags_16 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_17 = writeMask[17] ? flags_17 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_18 = writeMask[18] ? flags_18 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_19 = writeMask[19] ? flags_19 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_20 = writeMask[20] ? flags_20 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_21 = writeMask[21] ? flags_21 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_22 = writeMask[22] ? flags_22 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_23 = writeMask[23] ? flags_23 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_24 = writeMask[24] ? flags_24 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_25 = writeMask[25] ? flags_25 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_26 = writeMask[26] ? flags_26 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_27 = writeMask[27] ? flags_27 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_28 = writeMask[28] ? flags_28 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_29 = writeMask[29] ? flags_29 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_30 = writeMask[30] ? flags_30 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_exceptionFlags_31 = writeMask[31] ? flags_31 : 5'h0; // @[AecSfuWarpUnit.scala 43:67]
  assign io_resp_bits_activeMask = requestBuffer_io_out_activeMask; // @[AecSfuWarpUnit.scala 44:27]
  assign io_resp_bits_dest = requestBuffer_io_out_dest; // @[AecSfuWarpUnit.scala 45:21]
  assign lanes_0_clock = clock;
  assign lanes_0_reset = reset;
  assign lanes_0_io_req_valid = state == 3'h3 & lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 49:46]
  assign lanes_0_io_req_bits_op = requestBuffer_io_out_op; // @[AecSfuWarpUnit.scala 50:29]
  assign lanes_0_io_req_bits_dtype = requestBuffer_io_out_dtype; // @[AecSfuWarpUnit.scala 51:32]
  assign lanes_0_io_req_bits_a = 5'h1f == lane[4:0] ? requestBuffer_io_out_a_31 : _GEN_30; // @[AecSfuWarpUnit.scala 53:{28,28}]
  assign lanes_0_io_req_bits_b = 5'h1f == lane[4:0] ? requestBuffer_io_out_b_31 : _GEN_62; // @[AecSfuWarpUnit.scala 54:{28,28}]
  assign lanes_0_io_resp_ready = state == 3'h4 & lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 56:51]
  assign requestBuffer_clock = clock;
  assign requestBuffer_reset = reset;
  assign requestBuffer_io_in_op = io_req_bits_op; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_dtype = io_req_bits_dtype; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_activeMask = io_req_bits_activeMask; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_0 = io_req_bits_a_0; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_1 = io_req_bits_a_1; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_2 = io_req_bits_a_2; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_3 = io_req_bits_a_3; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_4 = io_req_bits_a_4; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_5 = io_req_bits_a_5; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_6 = io_req_bits_a_6; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_7 = io_req_bits_a_7; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_8 = io_req_bits_a_8; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_9 = io_req_bits_a_9; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_10 = io_req_bits_a_10; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_11 = io_req_bits_a_11; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_12 = io_req_bits_a_12; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_13 = io_req_bits_a_13; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_14 = io_req_bits_a_14; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_15 = io_req_bits_a_15; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_16 = io_req_bits_a_16; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_17 = io_req_bits_a_17; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_18 = io_req_bits_a_18; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_19 = io_req_bits_a_19; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_20 = io_req_bits_a_20; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_21 = io_req_bits_a_21; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_22 = io_req_bits_a_22; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_23 = io_req_bits_a_23; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_24 = io_req_bits_a_24; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_25 = io_req_bits_a_25; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_26 = io_req_bits_a_26; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_27 = io_req_bits_a_27; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_28 = io_req_bits_a_28; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_29 = io_req_bits_a_29; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_30 = io_req_bits_a_30; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_a_31 = io_req_bits_a_31; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_0 = io_req_bits_b_0; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_1 = io_req_bits_b_1; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_2 = io_req_bits_b_2; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_3 = io_req_bits_b_3; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_4 = io_req_bits_b_4; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_5 = io_req_bits_b_5; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_6 = io_req_bits_b_6; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_7 = io_req_bits_b_7; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_8 = io_req_bits_b_8; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_9 = io_req_bits_b_9; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_10 = io_req_bits_b_10; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_11 = io_req_bits_b_11; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_12 = io_req_bits_b_12; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_13 = io_req_bits_b_13; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_14 = io_req_bits_b_14; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_15 = io_req_bits_b_15; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_16 = io_req_bits_b_16; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_17 = io_req_bits_b_17; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_18 = io_req_bits_b_18; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_19 = io_req_bits_b_19; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_20 = io_req_bits_b_20; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_21 = io_req_bits_b_21; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_22 = io_req_bits_b_22; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_23 = io_req_bits_b_23; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_24 = io_req_bits_b_24; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_25 = io_req_bits_b_25; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_26 = io_req_bits_b_26; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_27 = io_req_bits_b_27; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_28 = io_req_bits_b_28; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_29 = io_req_bits_b_29; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_30 = io_req_bits_b_30; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_b_31 = io_req_bits_b_31; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_in_dest = io_req_bits_dest; // @[AecSfuWarpUnit.scala 20:23]
  assign requestBuffer_io_arm_0 = armClusters_0; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_1 = armClusters_1; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_2 = armClusters_2; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_3 = armClusters_3; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_4 = armClusters_4; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_5 = armClusters_5; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_6 = armClusters_6; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_arm_7 = armClusters_7; // @[AecSfuWarpUnit.scala 36:24]
  assign requestBuffer_io_capture = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  always @(posedge clock) begin
    if (reset) begin // @[AecSfuWarpUnit.scala 18:22]
      state <= 3'h0; // @[AecSfuWarpUnit.scala 18:22]
    end else if (_T_140) begin // @[AecSfuWarpUnit.scala 87:23]
      state <= 3'h0; // @[AecSfuWarpUnit.scala 87:31]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (~(|remaining)) begin // @[AecSfuWarpUnit.scala 84:27]
        state <= 3'h5; // @[AecSfuWarpUnit.scala 84:35]
      end else begin
        state <= 3'h3; // @[AecSfuWarpUnit.scala 85:90]
      end
    end else if (_lanes_0_io_req_valid_T_1) begin // @[AecSfuWarpUnit.scala 68:38]
      state <= 3'h4; // @[AecSfuWarpUnit.scala 68:46]
    end else begin
      state <= _GEN_70;
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 23:22]
      group <= 5'h0; // @[AecSfuWarpUnit.scala 23:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (~(|remaining)) begin // @[AecSfuWarpUnit.scala 84:27]
        group <= _GEN_67;
      end else if (remaining[0]) begin // @[Mux.scala 47:70]
        group <= 5'h0;
      end else begin
        group <= _group_T_61;
      end
    end else begin
      group <= _GEN_67;
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_0 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h0 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_0 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_1 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_1 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_2 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h2 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_2 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_3 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h3 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_3 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_4 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h4 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_4 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_5 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h5 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_5 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_6 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h6 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_6 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_7 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h7 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_7 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_8 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h8 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_8 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_9 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h9 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_9 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_10 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'ha == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_10 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_11 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hb == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_11 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_12 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hc == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_12 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_13 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hd == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_13 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_14 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'he == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_14 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_15 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hf == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_15 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_16 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h10 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_16 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_17 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h11 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_17 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_18 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h12 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_18 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_19 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h13 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_19 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_20 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h14 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_20 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_21 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h15 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_21 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_22 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h16 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_22 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_23 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h17 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_23 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_24 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h18 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_24 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_25 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h19 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_25 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_26 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1a == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_26 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_27 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1b == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_27 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_28 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1c == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_28 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_29 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1d == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_29 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_30 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1e == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_30 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 24:24]
      results_31 <= 64'h0; // @[AecSfuWarpUnit.scala 24:24]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1f == lane[4:0]) begin // @[AecSfuWarpUnit.scala 76:23]
          results_31 <= _results_T_136; // @[AecSfuWarpUnit.scala 76:23]
        end
      end
    end
    errors <= _GEN_274[31:0]; // @[AecSfuWarpUnit.scala 25:{23,23}]
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_0 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h0 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_0 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_1 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_1 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_2 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h2 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_2 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_3 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h3 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_3 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_4 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h4 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_4 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_5 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h5 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_5 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_6 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h6 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_6 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_7 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h7 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_7 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_8 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h8 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_8 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_9 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h9 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_9 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_10 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'ha == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_10 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_11 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hb == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_11 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_12 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hc == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_12 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_13 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hd == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_13 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_14 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'he == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_14 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_15 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'hf == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_15 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_16 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h10 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_16 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_17 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h11 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_17 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_18 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h12 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_18 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_19 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h13 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_19 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_20 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h14 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_20 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_21 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h15 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_21 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_22 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h16 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_22 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_23 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h17 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_23 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_24 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h18 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_24 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_25 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h19 == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_25 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_26 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1a == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_26 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_27 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1b == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_27 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_28 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1c == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_28 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_29 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1d == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_29 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_30 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1e == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_30 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 26:22]
      flags_31 <= 5'h0; // @[AecSfuWarpUnit.scala 26:22]
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 69:42]
      if (_completedMask_T_2[0]) begin // @[AecSfuWarpUnit.scala 75:36]
        if (5'h1f == lane[4:0]) begin // @[AecSfuWarpUnit.scala 77:21]
          flags_31 <= _flags_T_137; // @[AecSfuWarpUnit.scala 77:21]
        end
      end
    end
    writeMask <= _GEN_275[31:0]; // @[AecSfuWarpUnit.scala 27:{26,26}]
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_0 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_0 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_1 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_1 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_2 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_2 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_3 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_3 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_4 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_4 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_5 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_5 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_6 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_6 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 33:28]
      armClusters_7 <= 1'h0; // @[AecSfuWarpUnit.scala 33:28]
    end else begin
      armClusters_7 <= armCapture; // @[AecSfuWarpUnit.scala 34:25]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  group = _RAND_1[4:0];
  _RAND_2 = {2{`RANDOM}};
  results_0 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  results_1 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  results_2 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  results_3 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  results_4 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  results_5 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  results_6 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  results_7 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  results_8 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  results_9 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  results_10 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  results_11 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  results_12 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  results_13 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  results_14 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  results_15 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  results_16 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  results_17 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  results_18 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  results_19 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  results_20 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  results_21 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  results_22 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  results_23 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  results_24 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  results_25 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  results_26 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  results_27 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  results_28 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  results_29 = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  results_30 = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  results_31 = _RAND_33[63:0];
  _RAND_34 = {1{`RANDOM}};
  errors = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  flags_0 = _RAND_35[4:0];
  _RAND_36 = {1{`RANDOM}};
  flags_1 = _RAND_36[4:0];
  _RAND_37 = {1{`RANDOM}};
  flags_2 = _RAND_37[4:0];
  _RAND_38 = {1{`RANDOM}};
  flags_3 = _RAND_38[4:0];
  _RAND_39 = {1{`RANDOM}};
  flags_4 = _RAND_39[4:0];
  _RAND_40 = {1{`RANDOM}};
  flags_5 = _RAND_40[4:0];
  _RAND_41 = {1{`RANDOM}};
  flags_6 = _RAND_41[4:0];
  _RAND_42 = {1{`RANDOM}};
  flags_7 = _RAND_42[4:0];
  _RAND_43 = {1{`RANDOM}};
  flags_8 = _RAND_43[4:0];
  _RAND_44 = {1{`RANDOM}};
  flags_9 = _RAND_44[4:0];
  _RAND_45 = {1{`RANDOM}};
  flags_10 = _RAND_45[4:0];
  _RAND_46 = {1{`RANDOM}};
  flags_11 = _RAND_46[4:0];
  _RAND_47 = {1{`RANDOM}};
  flags_12 = _RAND_47[4:0];
  _RAND_48 = {1{`RANDOM}};
  flags_13 = _RAND_48[4:0];
  _RAND_49 = {1{`RANDOM}};
  flags_14 = _RAND_49[4:0];
  _RAND_50 = {1{`RANDOM}};
  flags_15 = _RAND_50[4:0];
  _RAND_51 = {1{`RANDOM}};
  flags_16 = _RAND_51[4:0];
  _RAND_52 = {1{`RANDOM}};
  flags_17 = _RAND_52[4:0];
  _RAND_53 = {1{`RANDOM}};
  flags_18 = _RAND_53[4:0];
  _RAND_54 = {1{`RANDOM}};
  flags_19 = _RAND_54[4:0];
  _RAND_55 = {1{`RANDOM}};
  flags_20 = _RAND_55[4:0];
  _RAND_56 = {1{`RANDOM}};
  flags_21 = _RAND_56[4:0];
  _RAND_57 = {1{`RANDOM}};
  flags_22 = _RAND_57[4:0];
  _RAND_58 = {1{`RANDOM}};
  flags_23 = _RAND_58[4:0];
  _RAND_59 = {1{`RANDOM}};
  flags_24 = _RAND_59[4:0];
  _RAND_60 = {1{`RANDOM}};
  flags_25 = _RAND_60[4:0];
  _RAND_61 = {1{`RANDOM}};
  flags_26 = _RAND_61[4:0];
  _RAND_62 = {1{`RANDOM}};
  flags_27 = _RAND_62[4:0];
  _RAND_63 = {1{`RANDOM}};
  flags_28 = _RAND_63[4:0];
  _RAND_64 = {1{`RANDOM}};
  flags_29 = _RAND_64[4:0];
  _RAND_65 = {1{`RANDOM}};
  flags_30 = _RAND_65[4:0];
  _RAND_66 = {1{`RANDOM}};
  flags_31 = _RAND_66[4:0];
  _RAND_67 = {1{`RANDOM}};
  writeMask = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  armClusters_0 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  armClusters_1 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  armClusters_2 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  armClusters_3 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  armClusters_4 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  armClusters_5 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  armClusters_6 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  armClusters_7 = _RAND_75[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
