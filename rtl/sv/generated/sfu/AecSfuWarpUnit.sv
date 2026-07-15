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
  reg  busy; // @[AecTranscendental.scala 113:21]
  reg  valid; // @[AecTranscendental.scala 114:22]
  reg  negative; // @[AecTranscendental.scala 115:21]
  reg [95:0] multiplicand; // @[AecTranscendental.scala 116:25]
  reg [47:0] multiplierBits; // @[AecTranscendental.scala 117:27]
  reg [95:0] accumulator; // @[AecTranscendental.scala 118:24]
  reg [5:0] count; // @[AecTranscendental.scala 119:18]
  reg [95:0] product; // @[AecTranscendental.scala 120:20]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [47:0] _absA_T_4 = 48'sh0 - $signed(io_req_bits_a); // @[AecTranscendental.scala 126:58]
  wire [47:0] absA = $signed(io_req_bits_a) < 48'sh0 ? _absA_T_4 : io_req_bits_a; // @[AecTranscendental.scala 126:19]
  wire [47:0] _absB_T_4 = 48'sh0 - $signed(io_req_bits_b); // @[AecTranscendental.scala 127:58]
  wire [47:0] absB = $signed(io_req_bits_b) < 48'sh0 ? _absB_T_4 : io_req_bits_b; // @[AecTranscendental.scala 127:19]
  wire [95:0] _multiplicand_T = {48'h0,absA}; // @[Cat.scala 33:92]
  wire [95:0] _GEN_1 = _T ? _multiplicand_T : multiplicand; // @[AecTranscendental.scala 125:22 129:18 116:25]
  wire [47:0] _GEN_2 = _T ? absB : multiplierBits; // @[AecTranscendental.scala 125:22 130:20 117:27]
  wire [95:0] _GEN_3 = _T ? 96'h0 : accumulator; // @[AecTranscendental.scala 125:22 131:17 118:24]
  wire [5:0] _GEN_4 = _T ? 6'h0 : count; // @[AecTranscendental.scala 125:22 132:11 119:18]
  wire  _GEN_5 = _T | busy; // @[AecTranscendental.scala 125:22 133:10 113:21]
  wire [95:0] _nextAccumulator_T_2 = accumulator + multiplicand; // @[AecTranscendental.scala 136:62]
  wire [95:0] _product_T = multiplierBits[0] ? _nextAccumulator_T_2 : accumulator; // @[AecTranscendental.scala 138:49]
  wire [95:0] _product_T_3 = 96'sh0 - $signed(_product_T); // @[AecTranscendental.scala 138:32]
  wire [96:0] _multiplicand_T_1 = {multiplicand, 1'h0}; // @[AecTranscendental.scala 143:36]
  wire [5:0] _count_T_1 = count + 6'h1; // @[AecTranscendental.scala 145:22]
  wire  _GEN_8 = count == 6'h2f | valid; // @[AecTranscendental.scala 137:27 140:13 114:22]
  wire [96:0] _GEN_10 = count == 6'h2f ? {{1'd0}, _GEN_1} : _multiplicand_T_1; // @[AecTranscendental.scala 137:27 143:20]
  wire [96:0] _GEN_17 = busy ? _GEN_10 : {{1'd0}, _GEN_1}; // @[AecTranscendental.scala 135:15]
  wire  _T_2 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign io_req_ready = ~busy & ~valid; // @[AecTranscendental.scala 122:25]
  assign io_resp_valid = valid; // @[AecTranscendental.scala 123:17]
  assign io_resp_bits = product; // @[AecTranscendental.scala 124:16]
  always @(posedge clock) begin
    if (reset) begin // @[AecTranscendental.scala 113:21]
      busy <= 1'h0; // @[AecTranscendental.scala 113:21]
    end else if (busy) begin // @[AecTranscendental.scala 135:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 137:27]
        busy <= 1'h0; // @[AecTranscendental.scala 139:12]
      end else begin
        busy <= _GEN_5;
      end
    end else begin
      busy <= _GEN_5;
    end
    if (reset) begin // @[AecTranscendental.scala 114:22]
      valid <= 1'h0; // @[AecTranscendental.scala 114:22]
    end else if (_T_2) begin // @[AecTranscendental.scala 148:23]
      valid <= 1'h0; // @[AecTranscendental.scala 148:31]
    end else if (busy) begin // @[AecTranscendental.scala 135:15]
      valid <= _GEN_8;
    end
    if (_T) begin // @[AecTranscendental.scala 125:22]
      negative <= io_req_bits_a[47] ^ io_req_bits_b[47]; // @[AecTranscendental.scala 128:14]
    end
    multiplicand <= _GEN_17[95:0];
    if (busy) begin // @[AecTranscendental.scala 135:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 137:27]
        multiplierBits <= _GEN_2;
      end else begin
        multiplierBits <= {{1'd0}, multiplierBits[47:1]}; // @[AecTranscendental.scala 144:22]
      end
    end else begin
      multiplierBits <= _GEN_2;
    end
    if (busy) begin // @[AecTranscendental.scala 135:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 137:27]
        accumulator <= _GEN_3;
      end else if (multiplierBits[0]) begin // @[AecTranscendental.scala 136:30]
        accumulator <= _nextAccumulator_T_2;
      end
    end else begin
      accumulator <= _GEN_3;
    end
    if (busy) begin // @[AecTranscendental.scala 135:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 137:27]
        count <= _GEN_4;
      end else begin
        count <= _count_T_1; // @[AecTranscendental.scala 145:13]
      end
    end else begin
      count <= _GEN_4;
    end
    if (busy) begin // @[AecTranscendental.scala 135:15]
      if (count == 6'h2f) begin // @[AecTranscendental.scala 137:27]
        if (negative) begin // @[AecTranscendental.scala 138:21]
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
module AecQ34ToF32(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [47:0] io_req_bits_value,
  input  [11:0] io_req_bits_scale,
  input         io_resp_ready,
  output        io_resp_valid,
  output [31:0] io_resp_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[AecTranscendental.scala 25:22]
  reg  negative; // @[AecTranscendental.scala 26:25]
  reg [47:0] work; // @[AecTranscendental.scala 27:21]
  reg [12:0] exponent; // @[AecTranscendental.scala 28:25]
  reg  guard; // @[AecTranscendental.scala 29:22]
  reg  sticky; // @[AecTranscendental.scala 30:23]
  reg [23:0] significand; // @[AecTranscendental.scala 31:28]
  reg [4:0] subnormalRemaining; // @[AecTranscendental.scala 32:35]
  reg [31:0] result; // @[AecTranscendental.scala 33:23]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  isNegative = $signed(io_req_bits_value) < 48'sh0; // @[AecTranscendental.scala 40:40]
  wire [47:0] _work_T_2 = 48'sh0 - $signed(io_req_bits_value); // @[AecTranscendental.scala 42:29]
  wire [47:0] _work_T_4 = isNegative ? $signed(_work_T_2) : $signed(io_req_bits_value); // @[AecTranscendental.scala 42:68]
  wire [11:0] _exponent_T_2 = 12'sh74 + $signed(io_req_bits_scale); // @[AecTranscendental.scala 44:23]
  wire [47:0] _GEN_1 = _T ? _work_T_4 : work; // @[AecTranscendental.scala 39:22 42:10 27:21]
  wire [12:0] _GEN_2 = _T ? $signed({{1{_exponent_T_2[11]}},_exponent_T_2}) : $signed(exponent); // @[AecTranscendental.scala 39:22 44:14 28:25]
  wire  _GEN_3 = _T ? 1'h0 : guard; // @[AecTranscendental.scala 39:22 45:11 29:22]
  wire  _GEN_4 = _T ? 1'h0 : sticky; // @[AecTranscendental.scala 39:22 46:12 30:23]
  wire [2:0] _GEN_5 = _T ? 3'h1 : state; // @[AecTranscendental.scala 39:22 47:11 25:22]
  wire [31:0] _result_T = {negative,31'h0}; // @[Cat.scala 33:92]
  wire [12:0] _exponent_T_5 = $signed(exponent) + 13'sh1; // @[AecTranscendental.scala 58:28]
  wire [48:0] _work_T_6 = {work, 1'h0}; // @[AecTranscendental.scala 60:20]
  wire [12:0] _exponent_T_8 = $signed(exponent) - 13'sh1; // @[AecTranscendental.scala 61:28]
  wire [48:0] _GEN_6 = ~work[23] ? _work_T_6 : {{1'd0}, _GEN_1}; // @[AecTranscendental.scala 59:28 60:12]
  wire [12:0] _GEN_7 = ~work[23] ? $signed(_exponent_T_8) : $signed(_GEN_2); // @[AecTranscendental.scala 59:28 61:16]
  wire [2:0] _GEN_8 = ~work[23] ? _GEN_5 : 3'h2; // @[AecTranscendental.scala 59:28 63:13]
  wire [48:0] _GEN_11 = |work[47:24] ? {{2'd0}, work[47:1]} : _GEN_6; // @[AecTranscendental.scala 54:35 57:12]
  wire [2:0] _GEN_13 = |work[47:24] ? _GEN_5 : _GEN_8; // @[AecTranscendental.scala 54:35]
  wire [31:0] _GEN_14 = ~(|work) ? _result_T : result; // @[AecTranscendental.scala 51:22 52:14 33:23]
  wire [2:0] _GEN_15 = ~(|work) ? 3'h4 : _GEN_13; // @[AecTranscendental.scala 51:22 53:13]
  wire [48:0] _GEN_18 = ~(|work) ? {{1'd0}, _GEN_1} : _GEN_11; // @[AecTranscendental.scala 51:22]
  wire [31:0] _GEN_20 = state == 3'h1 ? _GEN_14 : result; // @[AecTranscendental.scala 33:23 50:30]
  wire [2:0] _GEN_21 = state == 3'h1 ? _GEN_15 : _GEN_5; // @[AecTranscendental.scala 50:30]
  wire [48:0] _GEN_24 = state == 3'h1 ? _GEN_18 : {{1'd0}, _GEN_1}; // @[AecTranscendental.scala 50:30]
  wire [24:0] _rounded_T_1 = {1'h0,work[23:0]}; // @[Cat.scala 33:92]
  wire  _rounded_T_4 = guard & (sticky | work[0]); // @[AecTranscendental.scala 68:55]
  wire [24:0] _GEN_51 = {{24'd0}, _rounded_T_4}; // @[AecTranscendental.scala 68:46]
  wire [24:0] rounded = _rounded_T_1 + _GEN_51; // @[AecTranscendental.scala 68:46]
  wire  carry = rounded[24]; // @[AecTranscendental.scala 69:24]
  wire [23:0] roundedSignificand = carry ? rounded[24:1] : rounded[23:0]; // @[AecTranscendental.scala 70:33]
  wire [1:0] _roundedExponent_T = {1'b0,$signed(carry)}; // @[AecTranscendental.scala 71:51]
  wire [12:0] _GEN_52 = {{11{_roundedExponent_T[1]}},_roundedExponent_T}; // @[AecTranscendental.scala 71:36]
  wire [12:0] roundedExponent = $signed(exponent) + $signed(_GEN_52); // @[AecTranscendental.scala 71:36]
  wire [31:0] _result_T_1 = {negative,31'h7f800000}; // @[Cat.scala 33:92]
  wire [12:0] _subnormalRemaining_T_3 = 13'sh1 - $signed(roundedExponent); // @[AecTranscendental.scala 81:55]
  wire [31:0] _GEN_26 = $signed(roundedExponent) < -13'sh17 ? _result_T : _GEN_20; // @[AecTranscendental.scala 76:40 77:16]
  wire [2:0] _GEN_27 = $signed(roundedExponent) < -13'sh17 ? 3'h4 : 3'h3; // @[AecTranscendental.scala 76:40 78:15 82:15]
  wire [23:0] _GEN_28 = $signed(roundedExponent) < -13'sh17 ? significand : roundedSignificand; // @[AecTranscendental.scala 31:28 76:40 80:21]
  wire [12:0] _GEN_29 = $signed(roundedExponent) < -13'sh17 ? {{8'd0}, subnormalRemaining} : _subnormalRemaining_T_3; // @[AecTranscendental.scala 32:35 76:40 81:28]
  wire [12:0] _result_T_3 = $signed(exponent) + $signed(_GEN_52); // @[AecTranscendental.scala 85:47]
  wire [31:0] _result_T_6 = {negative,_result_T_3[7:0],roundedSignificand[22:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_30 = $signed(roundedExponent) <= 13'sh0 ? _GEN_26 : _result_T_6; // @[AecTranscendental.scala 75:41 85:14]
  wire [2:0] _GEN_31 = $signed(roundedExponent) <= 13'sh0 ? _GEN_27 : 3'h4; // @[AecTranscendental.scala 75:41 86:13]
  wire [23:0] _GEN_32 = $signed(roundedExponent) <= 13'sh0 ? _GEN_28 : significand; // @[AecTranscendental.scala 31:28 75:41]
  wire [12:0] _GEN_33 = $signed(roundedExponent) <= 13'sh0 ? _GEN_29 : {{8'd0}, subnormalRemaining}; // @[AecTranscendental.scala 32:35 75:41]
  wire [31:0] _GEN_34 = $signed(roundedExponent) >= 13'shff ? _result_T_1 : _GEN_30; // @[AecTranscendental.scala 72:37 73:14]
  wire [2:0] _GEN_35 = $signed(roundedExponent) >= 13'shff ? 3'h4 : _GEN_31; // @[AecTranscendental.scala 72:37 74:13]
  wire [23:0] _GEN_36 = $signed(roundedExponent) >= 13'shff ? significand : _GEN_32; // @[AecTranscendental.scala 31:28 72:37]
  wire [12:0] _GEN_37 = $signed(roundedExponent) >= 13'shff ? {{8'd0}, subnormalRemaining} : _GEN_33; // @[AecTranscendental.scala 32:35 72:37]
  wire [31:0] _GEN_38 = state == 3'h2 ? _GEN_34 : _GEN_20; // @[AecTranscendental.scala 67:31]
  wire [2:0] _GEN_39 = state == 3'h2 ? _GEN_35 : _GEN_21; // @[AecTranscendental.scala 67:31]
  wire [23:0] _GEN_40 = state == 3'h2 ? _GEN_36 : significand; // @[AecTranscendental.scala 31:28 67:31]
  wire [12:0] _GEN_41 = state == 3'h2 ? _GEN_37 : {{8'd0}, subnormalRemaining}; // @[AecTranscendental.scala 67:31 32:35]
  wire [31:0] _result_T_8 = {negative,8'h0,significand[22:0]}; // @[Cat.scala 33:92]
  wire [4:0] _subnormalRemaining_T_5 = subnormalRemaining - 5'h1; // @[AecTranscendental.scala 96:48]
  wire [12:0] _GEN_45 = subnormalRemaining == 5'h0 ? _GEN_41 : {{8'd0}, _subnormalRemaining_T_5}; // @[AecTranscendental.scala 91:39 96:26]
  wire [12:0] _GEN_49 = state == 3'h3 ? _GEN_45 : _GEN_41; // @[AecTranscendental.scala 90:30]
  wire  _T_14 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [48:0] _GEN_53 = reset ? 49'h0 : _GEN_24; // @[AecTranscendental.scala 27:{21,21}]
  wire [12:0] _GEN_54 = reset ? 13'h0 : _GEN_49; // @[AecTranscendental.scala 32:{35,35}]
  assign io_req_ready = state == 3'h0; // @[AecTranscendental.scala 35:25]
  assign io_resp_valid = state == 3'h4; // @[AecTranscendental.scala 36:26]
  assign io_resp_bits = result; // @[AecTranscendental.scala 37:16]
  always @(posedge clock) begin
    if (reset) begin // @[AecTranscendental.scala 25:22]
      state <= 3'h0; // @[AecTranscendental.scala 25:22]
    end else if (_T_14) begin // @[AecTranscendental.scala 100:23]
      state <= 3'h0; // @[AecTranscendental.scala 100:31]
    end else if (state == 3'h3) begin // @[AecTranscendental.scala 90:30]
      if (subnormalRemaining == 5'h0) begin // @[AecTranscendental.scala 91:39]
        state <= 3'h4; // @[AecTranscendental.scala 93:13]
      end else begin
        state <= _GEN_39;
      end
    end else begin
      state <= _GEN_39;
    end
    if (reset) begin // @[AecTranscendental.scala 26:25]
      negative <= 1'h0; // @[AecTranscendental.scala 26:25]
    end else if (_T) begin // @[AecTranscendental.scala 39:22]
      negative <= isNegative; // @[AecTranscendental.scala 41:14]
    end
    work <= _GEN_53[47:0]; // @[AecTranscendental.scala 27:{21,21}]
    if (reset) begin // @[AecTranscendental.scala 28:25]
      exponent <= 13'sh0; // @[AecTranscendental.scala 28:25]
    end else if (state == 3'h1) begin // @[AecTranscendental.scala 50:30]
      if (~(|work)) begin // @[AecTranscendental.scala 51:22]
        exponent <= _GEN_2;
      end else if (|work[47:24]) begin // @[AecTranscendental.scala 54:35]
        exponent <= _exponent_T_5; // @[AecTranscendental.scala 58:16]
      end else begin
        exponent <= _GEN_7;
      end
    end else begin
      exponent <= _GEN_2;
    end
    if (reset) begin // @[AecTranscendental.scala 29:22]
      guard <= 1'h0; // @[AecTranscendental.scala 29:22]
    end else if (state == 3'h1) begin // @[AecTranscendental.scala 50:30]
      if (~(|work)) begin // @[AecTranscendental.scala 51:22]
        guard <= _GEN_3;
      end else if (|work[47:24]) begin // @[AecTranscendental.scala 54:35]
        guard <= work[0]; // @[AecTranscendental.scala 56:13]
      end else begin
        guard <= _GEN_3;
      end
    end else begin
      guard <= _GEN_3;
    end
    if (reset) begin // @[AecTranscendental.scala 30:23]
      sticky <= 1'h0; // @[AecTranscendental.scala 30:23]
    end else if (state == 3'h1) begin // @[AecTranscendental.scala 50:30]
      if (~(|work)) begin // @[AecTranscendental.scala 51:22]
        sticky <= _GEN_4;
      end else if (|work[47:24]) begin // @[AecTranscendental.scala 54:35]
        sticky <= sticky | guard; // @[AecTranscendental.scala 55:14]
      end else begin
        sticky <= _GEN_4;
      end
    end else begin
      sticky <= _GEN_4;
    end
    if (reset) begin // @[AecTranscendental.scala 31:28]
      significand <= 24'h0; // @[AecTranscendental.scala 31:28]
    end else if (state == 3'h3) begin // @[AecTranscendental.scala 90:30]
      if (subnormalRemaining == 5'h0) begin // @[AecTranscendental.scala 91:39]
        significand <= _GEN_40;
      end else begin
        significand <= {{1'd0}, significand[23:1]}; // @[AecTranscendental.scala 95:19]
      end
    end else begin
      significand <= _GEN_40;
    end
    subnormalRemaining <= _GEN_54[4:0]; // @[AecTranscendental.scala 32:{35,35}]
    if (reset) begin // @[AecTranscendental.scala 33:23]
      result <= 32'h0; // @[AecTranscendental.scala 33:23]
    end else if (state == 3'h3) begin // @[AecTranscendental.scala 90:30]
      if (subnormalRemaining == 5'h0) begin // @[AecTranscendental.scala 91:39]
        result <= _result_T_8; // @[AecTranscendental.scala 92:14]
      end else begin
        result <= _GEN_38;
      end
    end else begin
      result <= _GEN_38;
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
  negative = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  work = _RAND_2[47:0];
  _RAND_3 = {1{`RANDOM}};
  exponent = _RAND_3[12:0];
  _RAND_4 = {1{`RANDOM}};
  guard = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sticky = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  significand = _RAND_6[23:0];
  _RAND_7 = {1{`RANDOM}};
  subnormalRemaining = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  result = _RAND_8[31:0];
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
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  multiplier_clock; // @[AecTranscendental.scala 184:26]
  wire  multiplier_reset; // @[AecTranscendental.scala 184:26]
  wire  multiplier_io_req_ready; // @[AecTranscendental.scala 184:26]
  wire  multiplier_io_req_valid; // @[AecTranscendental.scala 184:26]
  wire [47:0] multiplier_io_req_bits_a; // @[AecTranscendental.scala 184:26]
  wire [47:0] multiplier_io_req_bits_b; // @[AecTranscendental.scala 184:26]
  wire  multiplier_io_resp_ready; // @[AecTranscendental.scala 184:26]
  wire  multiplier_io_resp_valid; // @[AecTranscendental.scala 184:26]
  wire [95:0] multiplier_io_resp_bits; // @[AecTranscendental.scala 184:26]
  wire  packer_clock; // @[AecTranscendental.scala 213:22]
  wire  packer_reset; // @[AecTranscendental.scala 213:22]
  wire  packer_io_req_ready; // @[AecTranscendental.scala 213:22]
  wire  packer_io_req_valid; // @[AecTranscendental.scala 213:22]
  wire [47:0] packer_io_req_bits_value; // @[AecTranscendental.scala 213:22]
  wire [11:0] packer_io_req_bits_scale; // @[AecTranscendental.scala 213:22]
  wire  packer_io_resp_ready; // @[AecTranscendental.scala 213:22]
  wire  packer_io_resp_valid; // @[AecTranscendental.scala 213:22]
  wire [31:0] packer_io_resp_bits; // @[AecTranscendental.scala 213:22]
  reg [4:0] state; // @[AecTranscendental.scala 165:22]
  reg [15:0] op; // @[AecTranscendental.scala 166:15]
  reg [47:0] x; // @[AecTranscendental.scala 167:14]
  reg [47:0] term; // @[AecTranscendental.scala 168:17]
  reg [47:0] argument2; // @[AecTranscendental.scala 169:22]
  reg [47:0] accumulator; // @[AecTranscendental.scala 170:24]
  reg [47:0] auxiliary; // @[AecTranscendental.scala 171:22]
  reg [11:0] exponentScale; // @[AecTranscendental.scala 172:26]
  reg [3:0] step; // @[AecTranscendental.scala 173:21]
  reg [1:0] quadrant; // @[AecTranscendental.scala 174:21]
  reg  polynomialCos; // @[AecTranscendental.scala 175:26]
  reg  negateResult; // @[AecTranscendental.scala 176:25]
  reg [31:0] result; // @[AecTranscendental.scala 177:23]
  reg [47:0] packValue; // @[AecTranscendental.scala 178:22]
  reg [11:0] packScale; // @[AecTranscendental.scala 179:22]
  wire  _multiplyState_T = state == 5'h1; // @[AecTranscendental.scala 185:29]
  wire  _multiplyState_T_1 = state == 5'h2; // @[AecTranscendental.scala 185:52]
  wire  _multiplyState_T_3 = state == 5'h3; // @[AecTranscendental.scala 185:76]
  wire  _multiplyState_T_5 = state == 5'h4; // @[AecTranscendental.scala 185:96]
  wire  _multiplyState_T_7 = state == 5'h5; // @[AecTranscendental.scala 186:11]
  wire  _multiplyState_T_8 = state == 5'h1 | state == 5'h2 | state == 5'h3 | state == 5'h4 | _multiplyState_T_7; // @[AecTranscendental.scala 185:105]
  wire  _multiplyState_T_9 = state == 5'h6; // @[AecTranscendental.scala 186:34]
  wire  _multiplyState_T_11 = state == 5'h7; // @[AecTranscendental.scala 186:60]
  wire  _multiplyState_T_13 = state == 5'h8; // @[AecTranscendental.scala 186:82]
  wire  _multiplyState_T_15 = state == 5'h9; // @[AecTranscendental.scala 187:11]
  wire  _multiplyState_T_16 = _multiplyState_T_8 | state == 5'h6 | state == 5'h7 | state == 5'h8 | _multiplyState_T_15; // @[AecTranscendental.scala 186:99]
  wire  _multiplyState_T_17 = state == 5'ha; // @[AecTranscendental.scala 187:40]
  wire  _multiplyState_T_19 = state == 5'hb; // @[AecTranscendental.scala 187:58]
  wire  _multiplyState_T_21 = state == 5'hd; // @[AecTranscendental.scala 187:81]
  wire  _multiplyState_T_23 = state == 5'hc; // @[AecTranscendental.scala 188:11]
  wire  _multiplyState_T_24 = _multiplyState_T_16 | state == 5'ha | state == 5'hb | state == 5'hd | _multiplyState_T_23; // @[AecTranscendental.scala 187:96]
  wire  _multiplyState_T_25 = state == 5'he; // @[AecTranscendental.scala 188:30]
  wire  _multiplyState_T_27 = state == 5'hf; // @[AecTranscendental.scala 188:52]
  wire [95:0] _multiplyResult_T = multiplier_io_resp_bits; // @[AecTranscendental.scala 193:48]
  wire [47:0] multiplyResult = _multiplyResult_T[81:34]; // @[AecTranscendental.scala 193:66]
  wire  inputSign = io_req_bits_in[31]; // @[AecTranscendental.scala 196:33]
  wire [7:0] inputExponent = io_req_bits_in[30:23]; // @[AecTranscendental.scala 197:37]
  wire [22:0] inputFraction = io_req_bits_in[22:0]; // @[AecTranscendental.scala 198:37]
  wire  _inputSignificand_T = |inputExponent; // @[AecTranscendental.scala 199:44]
  wire [23:0] inputSignificand = {_inputSignificand_T,inputFraction}; // @[Cat.scala 33:92]
  wire [8:0] _unbiased_T = {1'b0,$signed(inputExponent)}; // @[AecTranscendental.scala 200:32]
  wire [8:0] unbiased = $signed(_unbiased_T) - 9'sh7f; // @[AecTranscendental.scala 200:37]
  wire [8:0] shift = $signed(unbiased) + 9'shb; // @[AecTranscendental.scala 201:24]
  wire [8:0] _inputMagnitude_T = $signed(unbiased) + 9'shb; // @[AecTranscendental.scala 204:87]
  wire [534:0] _GEN_11 = {{511'd0}, inputSignificand}; // @[AecTranscendental.scala 204:78]
  wire [534:0] _inputMagnitude_T_1 = _GEN_11 << _inputMagnitude_T; // @[AecTranscendental.scala 204:78]
  wire [8:0] _inputMagnitude_T_5 = 9'sh0 - $signed(shift); // @[AecTranscendental.scala 205:99]
  wire [23:0] _inputMagnitude_T_6 = inputSignificand >> _inputMagnitude_T_5; // @[AecTranscendental.scala 205:87]
  wire [47:0] _GEN_0 = $signed(shift) >= 9'sh18 ? 48'h7fffffffffff : 48'h0; // @[AecTranscendental.scala 206:33 202:35 206:50]
  wire [47:0] _GEN_1 = $signed(shift) < 9'sh0 & $signed(shift) > -9'sh20 ? {{24'd0}, _inputMagnitude_T_6} : _GEN_0; // @[AecTranscendental.scala 205:{50,67}]
  wire [534:0] _GEN_2 = $signed(shift) >= 9'sh0 & $signed(shift) < 9'sh18 ? _inputMagnitude_T_1 : {{487'd0}, _GEN_1}; // @[AecTranscendental.scala 204:{41,58}]
  wire [534:0] _GEN_3 = _inputSignificand_T ? _GEN_2 : 535'h0; // @[AecTranscendental.scala 203:28 202:35]
  wire [47:0] _inputQ_T = _GEN_3[47:0]; // @[AecTranscendental.scala 208:47]
  wire [47:0] _inputQ_T_3 = 48'sh0 - $signed(_inputQ_T); // @[AecTranscendental.scala 208:31]
  wire [47:0] inputQ = inputSign ? $signed(_inputQ_T_3) : $signed(_inputQ_T); // @[AecTranscendental.scala 208:19]
  wire  _inputZero_T_1 = inputFraction == 23'h0; // @[AecTranscendental.scala 209:58]
  wire  inputZero = inputExponent == 8'h0 & inputFraction == 23'h0; // @[AecTranscendental.scala 209:41]
  wire  _inputInf_T = &inputExponent; // @[AecTranscendental.scala 210:32]
  wire  inputInf = &inputExponent & _inputZero_T_1; // @[AecTranscendental.scala 210:37]
  wire  inputNaN = _inputInf_T & |inputFraction; // @[AecTranscendental.scala 211:37]
  wire  _packer_io_req_valid_T = state == 5'h10; // @[AecTranscendental.scala 214:32]
  wire [4:0] _GEN_4 = _packer_io_req_valid_T & packer_io_req_ready ? 5'h11 : state; // @[AecTranscendental.scala 165:22 229:{53,61}]
  wire  _T_10 = packer_io_resp_ready & packer_io_resp_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _GEN_5 = _T_10 ? packer_io_resp_bits : result; // @[AecTranscendental.scala 230:30 231:12 177:23]
  wire [4:0] _GEN_6 = _T_10 ? 5'h12 : _GEN_4; // @[AecTranscendental.scala 230:30 232:11]
  wire  _T_11 = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _T_12 = io_req_bits_op == 16'h72; // @[AecTranscendental.scala 240:40]
  wire  _T_13 = io_req_bits_op == 16'h73; // @[AecTranscendental.scala 240:76]
  wire  _T_14 = io_req_bits_op == 16'h72 | io_req_bits_op == 16'h73; // @[AecTranscendental.scala 240:58]
  wire  _T_17 = io_req_bits_op == 16'h75; // @[AecTranscendental.scala 241:23]
  wire  _T_20 = io_req_bits_op == 16'h75 & inputSign & ~inputZero; // @[AecTranscendental.scala 241:54]
  wire  _T_21 = inputNaN | (io_req_bits_op == 16'h72 | io_req_bits_op == 16'h73) & inputInf | _T_20; // @[AecTranscendental.scala 240:108]
  wire  _T_26 = io_req_bits_op == 16'h74; // @[AecTranscendental.scala 247:32]
  wire [30:0] _result_T = inputSign ? 31'h0 : 31'h7f800000; // @[AecTranscendental.scala 248:20]
  wire [13:0] _exponentScale_T = inputQ[47:34]; // @[AecTranscendental.scala 256:32]
  wire [47:0] _term_T_1 = {$signed(_exponentScale_T), 34'h0}; // @[AecTranscendental.scala 257:39]
  wire [47:0] _term_T_4 = $signed(inputQ) - $signed(_term_T_1); // @[AecTranscendental.scala 257:22]
  wire [35:0] mantissa = {1'h0,_inputSignificand_T,inputFraction,11'h0}; // @[AecTranscendental.scala 260:71]
  wire [47:0] _GEN_190 = {{12{mantissa[35]}},mantissa}; // @[AecTranscendental.scala 261:28]
  wire  halve = $signed(_GEN_190) > 48'sh5a82799a0; // @[AecTranscendental.scala 261:28]
  wire [34:0] _term_T_5 = mantissa[35:1]; // @[AecTranscendental.scala 262:35]
  wire [35:0] _term_T_6 = halve ? $signed({{1{_term_T_5[34]}},_term_T_5}) : $signed(mantissa); // @[AecTranscendental.scala 262:18]
  wire [1:0] _exponentScale_T_1 = {1'b0,$signed(halve)}; // @[AecTranscendental.scala 263:48]
  wire [8:0] _GEN_191 = {{7{_exponentScale_T_1[1]}},_exponentScale_T_1}; // @[AecTranscendental.scala 263:33]
  wire [8:0] _exponentScale_T_4 = $signed(unbiased) + $signed(_GEN_191); // @[AecTranscendental.scala 263:33]
  wire [47:0] _GEN_192 = {{12{_term_T_6[35]}},_term_T_6}; // @[AecTranscendental.scala 264:70]
  wire [47:0] _accumulator_T_4 = $signed(_GEN_192) + 48'sh400000000; // @[AecTranscendental.scala 264:70]
  wire [44:0] _accumulator_T_5 = _accumulator_T_4[47:3]; // @[AecTranscendental.scala 264:80]
  wire [47:0] _GEN_193 = {{3{_accumulator_T_5[44]}},_accumulator_T_5}; // @[AecTranscendental.scala 264:30]
  wire [47:0] _accumulator_T_8 = 48'sh300000000 - $signed(_GEN_193); // @[AecTranscendental.scala 264:30]
  wire [13:0] _GEN_7 = _T_26 ? $signed(_exponentScale_T) : $signed({{5{_exponentScale_T_4[8]}},_exponentScale_T_4}); // @[AecTranscendental.scala 255:51 256:21 263:21]
  wire [47:0] _GEN_8 = _T_26 ? $signed(_term_T_4) : $signed({{12{_term_T_6[35]}},_term_T_6}); // @[AecTranscendental.scala 255:51 257:12 262:12]
  wire [4:0] _GEN_9 = _T_26 ? 5'h7 : 5'h8; // @[AecTranscendental.scala 255:51 258:13 266:13]
  wire [47:0] _GEN_10 = _T_26 ? $signed(accumulator) : $signed(_accumulator_T_8); // @[AecTranscendental.scala 170:24 255:51 264:19]
  wire [4:0] _GEN_12 = _T_14 ? 5'h1 : _GEN_9; // @[AecTranscendental.scala 253:87 254:13]
  wire [13:0] _GEN_13 = _T_14 ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_7); // @[AecTranscendental.scala 172:26 253:87]
  wire [47:0] _GEN_14 = _T_14 ? $signed(term) : $signed(_GEN_8); // @[AecTranscendental.scala 168:17 253:87]
  wire [47:0] _GEN_15 = _T_14 ? $signed(accumulator) : $signed(_GEN_10); // @[AecTranscendental.scala 170:24 253:87]
  wire [31:0] _GEN_17 = _T_17 & inputInf ? 32'h7f800000 : _GEN_5; // @[AecTranscendental.scala 251:63 252:14]
  wire [4:0] _GEN_18 = _T_17 & inputInf ? 5'h12 : _GEN_12; // @[AecTranscendental.scala 251:63 252:38]
  wire [13:0] _GEN_19 = _T_17 & inputInf ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_13); // @[AecTranscendental.scala 172:26 251:63]
  wire [47:0] _GEN_20 = _T_17 & inputInf ? $signed(term) : $signed(_GEN_14); // @[AecTranscendental.scala 168:17 251:63]
  wire [47:0] _GEN_21 = _T_17 & inputInf ? $signed(accumulator) : $signed(_GEN_15); // @[AecTranscendental.scala 170:24 251:63]
  wire [31:0] _GEN_23 = _T_17 & inputZero ? 32'hff800000 : _GEN_17; // @[AecTranscendental.scala 249:64 250:14]
  wire [4:0] _GEN_24 = _T_17 & inputZero ? 5'h12 : _GEN_18; // @[AecTranscendental.scala 249:64 250:38]
  wire [13:0] _GEN_25 = _T_17 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_19); // @[AecTranscendental.scala 172:26 249:64]
  wire [47:0] _GEN_26 = _T_17 & inputZero ? $signed(term) : $signed(_GEN_20); // @[AecTranscendental.scala 168:17 249:64]
  wire [47:0] _GEN_27 = _T_17 & inputZero ? $signed(accumulator) : $signed(_GEN_21); // @[AecTranscendental.scala 170:24 249:64]
  wire [31:0] _GEN_29 = io_req_bits_op == 16'h74 & inputInf ? {{1'd0}, _result_T} : _GEN_23; // @[AecTranscendental.scala 247:63 248:14]
  wire [4:0] _GEN_30 = io_req_bits_op == 16'h74 & inputInf ? 5'h12 : _GEN_24; // @[AecTranscendental.scala 247:63 248:59]
  wire [13:0] _GEN_31 = io_req_bits_op == 16'h74 & inputInf ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(
    _GEN_25); // @[AecTranscendental.scala 172:26 247:63]
  wire [47:0] _GEN_32 = io_req_bits_op == 16'h74 & inputInf ? $signed(term) : $signed(_GEN_26); // @[AecTranscendental.scala 168:17 247:63]
  wire [47:0] _GEN_33 = io_req_bits_op == 16'h74 & inputInf ? $signed(accumulator) : $signed(_GEN_27); // @[AecTranscendental.scala 170:24 247:63]
  wire [31:0] _GEN_35 = _T_13 & inputZero ? 32'h3f800000 : _GEN_29; // @[AecTranscendental.scala 245:64 246:14]
  wire [4:0] _GEN_36 = _T_13 & inputZero ? 5'h12 : _GEN_30; // @[AecTranscendental.scala 245:64 246:38]
  wire [13:0] _GEN_37 = _T_13 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_31); // @[AecTranscendental.scala 172:26 245:64]
  wire [47:0] _GEN_38 = _T_13 & inputZero ? $signed(term) : $signed(_GEN_32); // @[AecTranscendental.scala 168:17 245:64]
  wire [47:0] _GEN_39 = _T_13 & inputZero ? $signed(accumulator) : $signed(_GEN_33); // @[AecTranscendental.scala 170:24 245:64]
  wire [4:0] _GEN_42 = _T_12 & inputZero ? 5'h12 : _GEN_36; // @[AecTranscendental.scala 243:64 244:39]
  wire [13:0] _GEN_43 = _T_12 & inputZero ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_37); // @[AecTranscendental.scala 172:26 243:64]
  wire [47:0] _GEN_44 = _T_12 & inputZero ? $signed(term) : $signed(_GEN_38); // @[AecTranscendental.scala 168:17 243:64]
  wire [47:0] _GEN_45 = _T_12 & inputZero ? $signed(accumulator) : $signed(_GEN_39); // @[AecTranscendental.scala 170:24 243:64]
  wire [4:0] _GEN_48 = _T_21 ? 5'h12 : _GEN_42; // @[AecTranscendental.scala 241:70 242:37]
  wire [13:0] _GEN_49 = _T_21 ? $signed({{2{exponentScale[11]}},exponentScale}) : $signed(_GEN_43); // @[AecTranscendental.scala 172:26 241:70]
  wire [47:0] _GEN_50 = _T_21 ? $signed(term) : $signed(_GEN_44); // @[AecTranscendental.scala 168:17 241:70]
  wire [47:0] _GEN_51 = _T_21 ? $signed(accumulator) : $signed(_GEN_45); // @[AecTranscendental.scala 170:24 241:70]
  wire [3:0] _GEN_55 = _T_11 ? 4'h0 : step; // @[AecTranscendental.scala 173:21 236:22]
  wire [4:0] _GEN_57 = _T_11 ? _GEN_48 : _GEN_6; // @[AecTranscendental.scala 236:22]
  wire [13:0] _GEN_58 = _T_11 ? $signed(_GEN_49) : $signed({{2{exponentScale[11]}},exponentScale}); // @[AecTranscendental.scala 236:22 172:26]
  wire [47:0] _GEN_60 = _T_11 ? $signed(_GEN_51) : $signed(accumulator); // @[AecTranscendental.scala 236:22 170:24]
  wire [47:0] _signedQuadrant_T_3 = $signed(multiplyResult) + 48'sh200000000; // @[AecTranscendental.scala 273:23]
  wire [13:0] _signedQuadrant_T_4 = _signedQuadrant_T_3[47:34]; // @[AecTranscendental.scala 273:33]
  wire [47:0] _signedQuadrant_T_7 = 48'sh0 - $signed(multiplyResult); // @[AecTranscendental.scala 273:42]
  wire [47:0] _signedQuadrant_T_10 = $signed(_signedQuadrant_T_7) + 48'sh200000000; // @[AecTranscendental.scala 273:58]
  wire [13:0] _signedQuadrant_T_11 = _signedQuadrant_T_10[47:34]; // @[AecTranscendental.scala 273:68]
  wire [13:0] _signedQuadrant_T_14 = 14'sh0 - $signed(_signedQuadrant_T_11); // @[AecTranscendental.scala 273:39]
  wire [13:0] signedQuadrant = $signed(multiplyResult) >= 48'sh0 ? $signed(_signedQuadrant_T_4) : $signed(
    _signedQuadrant_T_14); // @[AecTranscendental.scala 272:29]
  wire [13:0] _quadrant_T = $signed(multiplyResult) >= 48'sh0 ? $signed(_signedQuadrant_T_4) : $signed(
    _signedQuadrant_T_14); // @[AecTranscendental.scala 274:32]
  wire [47:0] _auxiliary_T = {$signed(signedQuadrant), 34'h0}; // @[AecTranscendental.scala 275:33]
  wire [47:0] _GEN_61 = _multiplyState_T & multiplier_io_resp_valid ? $signed(x) : $signed(48'sh0); // @[AecTranscendental.scala 270:47 271:15 182:30]
  wire [47:0] _GEN_62 = _multiplyState_T & multiplier_io_resp_valid ? $signed(48'sh28be60db9) : $signed(48'sh0); // @[AecTranscendental.scala 183:30 270:47 271:31]
  wire [4:0] _GEN_65 = _multiplyState_T & multiplier_io_resp_valid ? 5'h2 : _GEN_57; // @[AecTranscendental.scala 270:47 276:11]
  wire [47:0] _term_T_9 = $signed(x) - $signed(multiplyResult); // @[AecTranscendental.scala 280:15]
  wire  odd = quadrant[0]; // @[AecTranscendental.scala 281:23]
  wire  _polynomialCos_T = op == 16'h72; // @[AecTranscendental.scala 282:29]
  wire [47:0] _GEN_66 = _multiplyState_T_1 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_61); // @[AecTranscendental.scala 278:48 279:15]
  wire [47:0] _GEN_67 = _multiplyState_T_1 & multiplier_io_resp_valid ? $signed(48'sh6487ed511) : $signed(_GEN_62); // @[AecTranscendental.scala 278:48 279:39]
  wire [4:0] _GEN_71 = _multiplyState_T_1 & multiplier_io_resp_valid ? 5'h3 : _GEN_65; // @[AecTranscendental.scala 278:48 284:11]
  wire [47:0] _accumulator_T_9 = polynomialCos ? $signed(-48'sh127e) : $signed(-48'sh1ae); // @[AecTranscendental.scala 289:23]
  wire [47:0] _GEN_72 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_66); // @[AecTranscendental.scala 286:44 287:15]
  wire [47:0] _GEN_73 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_67); // @[AecTranscendental.scala 286:44 287:34]
  wire [47:0] _GEN_75 = _multiplyState_T_3 & multiplier_io_resp_valid ? $signed(_accumulator_T_9) : $signed(_GEN_60); // @[AecTranscendental.scala 286:44 289:17]
  wire [3:0] _GEN_76 = _multiplyState_T_3 & multiplier_io_resp_valid ? 4'h0 : _GEN_55; // @[AecTranscendental.scala 286:44 290:10]
  wire [4:0] _GEN_77 = _multiplyState_T_3 & multiplier_io_resp_valid ? 5'h4 : _GEN_71; // @[AecTranscendental.scala 286:44 291:11]
  wire  _T_43 = step < 4'h4; // @[AecTranscendental.scala 293:32]
  wire [47:0] _sinCoefficient_T_1 = 4'h0 == step ? $signed(48'shb8ef) : $signed(48'sh0); // @[Mux.scala 81:58]
  wire [47:0] _sinCoefficient_T_3 = 4'h1 == step ? $signed(-48'sh340340) : $signed(_sinCoefficient_T_1); // @[Mux.scala 81:58]
  wire [47:0] _sinCoefficient_T_5 = 4'h2 == step ? $signed(48'sh8888889) : $signed(_sinCoefficient_T_3); // @[Mux.scala 81:58]
  wire [47:0] sinCoefficient = 4'h3 == step ? $signed(-48'shaaaaaaab) : $signed(_sinCoefficient_T_5); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_1 = 4'h0 == step ? $signed(48'sh68068) : $signed(48'sh0); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_3 = 4'h1 == step ? $signed(-48'sh16c16c1) : $signed(_cosCoefficient_T_1); // @[Mux.scala 81:58]
  wire [47:0] _cosCoefficient_T_5 = 4'h2 == step ? $signed(48'sh2aaaaaab) : $signed(_cosCoefficient_T_3); // @[Mux.scala 81:58]
  wire [47:0] cosCoefficient = 4'h3 == step ? $signed(-48'sh200000000) : $signed(_cosCoefficient_T_5); // @[Mux.scala 81:58]
  wire [47:0] _accumulator_T_10 = polynomialCos ? $signed(cosCoefficient) : $signed(sinCoefficient); // @[AecTranscendental.scala 299:40]
  wire [47:0] _accumulator_T_13 = $signed(multiplyResult) + $signed(_accumulator_T_10); // @[AecTranscendental.scala 299:35]
  wire [3:0] _step_T_1 = step + 4'h1; // @[AecTranscendental.scala 300:73]
  wire [4:0] _GEN_78 = step == 4'h3 ? 5'h5 : _GEN_77; // @[AecTranscendental.scala 300:{25,33}]
  wire [3:0] _GEN_79 = step == 4'h3 ? _GEN_76 : _step_T_1; // @[AecTranscendental.scala 300:{25,65}]
  wire [47:0] _GEN_80 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(argument2) : $signed(
    _GEN_72); // @[AecTranscendental.scala 293:56 294:15]
  wire [47:0] _GEN_81 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(
    _GEN_73); // @[AecTranscendental.scala 293:56 294:39]
  wire [47:0] _GEN_82 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? $signed(_accumulator_T_13) :
    $signed(_GEN_75); // @[AecTranscendental.scala 293:56 299:17]
  wire [4:0] _GEN_83 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? _GEN_78 : _GEN_77; // @[AecTranscendental.scala 293:56]
  wire [3:0] _GEN_84 = _multiplyState_T_5 & step < 4'h4 & multiplier_io_resp_valid ? _GEN_79 : _GEN_76; // @[AecTranscendental.scala 293:56]
  wire [47:0] inner = 48'sh400000000 + $signed(multiplyResult); // @[AecTranscendental.scala 304:24]
  wire [47:0] _T_51 = 48'sh0 - $signed(inner); // @[AecTranscendental.scala 306:35]
  wire [47:0] packValue_out = negateResult ? $signed(_T_51) : $signed(inner); // @[AecTranscendental.scala 306:20]
  wire [47:0] _GEN_85 = polynomialCos ? $signed(packValue_out) : $signed(packValue); // @[AecTranscendental.scala 220:15 178:22 305:26]
  wire [11:0] _GEN_86 = polynomialCos ? $signed(12'sh0) : $signed(packScale); // @[AecTranscendental.scala 221:15 179:22 305:26]
  wire [4:0] _GEN_87 = polynomialCos ? 5'h10 : 5'h6; // @[AecTranscendental.scala 222:11 305:26 308:35]
  wire [47:0] _GEN_88 = polynomialCos ? $signed(_GEN_82) : $signed(inner); // @[AecTranscendental.scala 305:26 308:19]
  wire [47:0] _GEN_89 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_80); // @[AecTranscendental.scala 302:47 303:15]
  wire [47:0] _GEN_90 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_81); // @[AecTranscendental.scala 302:47 303:39]
  wire [47:0] _GEN_91 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(_GEN_85) : $signed(packValue); // @[AecTranscendental.scala 178:22 302:47]
  wire [11:0] _GEN_92 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(_GEN_86) : $signed(packScale); // @[AecTranscendental.scala 179:22 302:47]
  wire [4:0] _GEN_93 = _multiplyState_T_7 & multiplier_io_resp_valid ? _GEN_87 : _GEN_83; // @[AecTranscendental.scala 302:47]
  wire [47:0] _GEN_94 = _multiplyState_T_7 & multiplier_io_resp_valid ? $signed(_GEN_88) : $signed(_GEN_82); // @[AecTranscendental.scala 302:47]
  wire [47:0] packValue_out_1 = negateResult ? $signed(_signedQuadrant_T_7) : $signed(multiplyResult); // @[AecTranscendental.scala 313:18]
  wire [47:0] _GEN_95 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_89); // @[AecTranscendental.scala 311:50 312:15]
  wire [47:0] _GEN_96 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_90); // @[AecTranscendental.scala 311:50 312:34]
  wire [47:0] _GEN_97 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(packValue_out_1) : $signed(_GEN_91); // @[AecTranscendental.scala 220:15 311:50]
  wire [11:0] _GEN_98 = _multiplyState_T_9 & multiplier_io_resp_valid ? $signed(12'sh0) : $signed(_GEN_92); // @[AecTranscendental.scala 221:15 311:50]
  wire [4:0] _GEN_99 = _multiplyState_T_9 & multiplier_io_resp_valid ? 5'h10 : _GEN_93; // @[AecTranscendental.scala 222:11 311:50]
  wire [47:0] _GEN_100 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_95); // @[AecTranscendental.scala 316:46 317:15]
  wire [47:0] _GEN_101 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(48'sh2c5c85fdf) : $signed(_GEN_96); // @[AecTranscendental.scala 316:46 317:34]
  wire [47:0] _GEN_103 = _multiplyState_T_11 & multiplier_io_resp_valid ? $signed(48'sh127e) : $signed(_GEN_94); // @[AecTranscendental.scala 316:46 319:17]
  wire [3:0] _GEN_104 = _multiplyState_T_11 & multiplier_io_resp_valid ? 4'h4 : _GEN_84; // @[AecTranscendental.scala 316:46 324:10]
  wire [4:0] _GEN_105 = _multiplyState_T_11 & multiplier_io_resp_valid ? 5'h4 : _GEN_99; // @[AecTranscendental.scala 316:46 321:11]
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
  wire [47:0] _accumulator_T_16 = $signed(coefficient) + $signed(multiplyResult); // @[AecTranscendental.scala 332:32]
  wire [4:0] _GEN_109 = step == 4'hd ? 5'h10 : _GEN_105; // @[AecTranscendental.scala 222:11 333:26]
  wire [3:0] _GEN_110 = step == 4'hd ? _GEN_104 : _step_T_1; // @[AecTranscendental.scala 333:26 334:25]
  wire [47:0] _GEN_111 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_100
    ); // @[AecTranscendental.scala 326:57 327:15]
  wire [47:0] _GEN_112 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(
    _GEN_101); // @[AecTranscendental.scala 326:57 327:34]
  wire [4:0] _GEN_116 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? _GEN_109 : _GEN_105; // @[AecTranscendental.scala 326:57]
  wire [3:0] _GEN_117 = _multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid ? _GEN_110 : _GEN_104; // @[AecTranscendental.scala 326:57]
  wire [47:0] denominator = $signed(term) + 48'sh400000000; // @[AecTranscendental.scala 337:26]
  wire [47:0] _multiplyA_T_1 = _T_43 ? $signed(argument2) : $signed(term); // @[AecTranscendental.scala 343:23]
  wire [47:0] _multiplyA_T_4 = $signed(term) - 48'sh400000000; // @[AecTranscendental.scala 351:35]
  wire [47:0] _GEN_118 = 5'hf == state ? $signed(auxiliary) : $signed(_GEN_111); // @[AecTranscendental.scala 338:18 356:31]
  wire [47:0] _GEN_119 = 5'hf == state ? $signed(48'shb8aa3b296) : $signed(_GEN_112); // @[AecTranscendental.scala 338:18 356:55]
  wire [47:0] _GEN_120 = 5'he == state ? $signed(auxiliary) : $signed(_GEN_118); // @[AecTranscendental.scala 338:18 355:31]
  wire [47:0] _GEN_121 = 5'he == state ? $signed(accumulator) : $signed(_GEN_119); // @[AecTranscendental.scala 338:18 355:55]
  wire [47:0] _GEN_122 = 5'hc == state ? $signed(term) : $signed(_GEN_120); // @[AecTranscendental.scala 338:18 354:28]
  wire [47:0] _GEN_123 = 5'hc == state ? $signed(argument2) : $signed(_GEN_121); // @[AecTranscendental.scala 338:18 354:47]
  wire [47:0] _GEN_124 = 5'hd == state ? $signed(argument2) : $signed(_GEN_122); // @[AecTranscendental.scala 338:18 353:33]
  wire [47:0] _GEN_125 = 5'hd == state ? $signed(accumulator) : $signed(_GEN_123); // @[AecTranscendental.scala 338:18 353:57]
  wire [47:0] _GEN_126 = 5'hb == state ? $signed(term) : $signed(_GEN_124); // @[AecTranscendental.scala 338:18 352:32]
  wire [47:0] _GEN_127 = 5'hb == state ? $signed(term) : $signed(_GEN_125); // @[AecTranscendental.scala 338:18 352:51]
  wire [47:0] _GEN_128 = 5'ha == state ? $signed(_multiplyA_T_4) : $signed(_GEN_126); // @[AecTranscendental.scala 338:18 351:27]
  wire [47:0] _GEN_129 = 5'ha == state ? $signed(accumulator) : $signed(_GEN_127); // @[AecTranscendental.scala 338:18 351:55]
  wire [47:0] _GEN_130 = 5'h9 == state ? $signed(accumulator) : $signed(_GEN_128); // @[AecTranscendental.scala 338:18 350:38]
  wire [47:0] _GEN_131 = 5'h9 == state ? $signed(auxiliary) : $signed(_GEN_129); // @[AecTranscendental.scala 338:18 350:64]
  wire [47:0] _GEN_132 = 5'h8 == state ? $signed(denominator) : $signed(_GEN_130); // @[AecTranscendental.scala 338:18 349:35]
  wire [47:0] _GEN_133 = 5'h8 == state ? $signed(accumulator) : $signed(_GEN_131); // @[AecTranscendental.scala 338:18 349:61]
  wire [47:0] _GEN_134 = 5'h7 == state ? $signed(term) : $signed(_GEN_132); // @[AecTranscendental.scala 338:18 348:31]
  wire [47:0] _GEN_135 = 5'h7 == state ? $signed(48'sh2c5c85fdf) : $signed(_GEN_133); // @[AecTranscendental.scala 338:18 348:50]
  wire [47:0] _GEN_136 = 5'h6 == state ? $signed(term) : $signed(_GEN_134); // @[AecTranscendental.scala 338:18 347:35]
  wire [47:0] _GEN_137 = 5'h6 == state ? $signed(accumulator) : $signed(_GEN_135); // @[AecTranscendental.scala 338:18 347:54]
  wire [47:0] _GEN_138 = 5'h5 == state ? $signed(argument2) : $signed(_GEN_136); // @[AecTranscendental.scala 338:18 346:32]
  wire [47:0] _GEN_139 = 5'h5 == state ? $signed(accumulator) : $signed(_GEN_137); // @[AecTranscendental.scala 338:18 346:56]
  wire [47:0] _GEN_140 = 5'h4 == state ? $signed(_multiplyA_T_1) : $signed(_GEN_138); // @[AecTranscendental.scala 338:18 343:17]
  wire [47:0] _GEN_141 = 5'h4 == state ? $signed(accumulator) : $signed(_GEN_139); // @[AecTranscendental.scala 338:18 344:17]
  wire [47:0] _GEN_142 = 5'h3 == state ? $signed(term) : $signed(_GEN_140); // @[AecTranscendental.scala 338:18 341:29]
  wire [47:0] _GEN_143 = 5'h3 == state ? $signed(term) : $signed(_GEN_141); // @[AecTranscendental.scala 338:18 341:48]
  wire [47:0] _GEN_144 = 5'h2 == state ? $signed(auxiliary) : $signed(_GEN_142); // @[AecTranscendental.scala 338:18 340:33]
  wire [47:0] _GEN_145 = 5'h2 == state ? $signed(48'sh6487ed511) : $signed(_GEN_143); // @[AecTranscendental.scala 338:18 340:57]
  wire [47:0] _GEN_146 = 5'h1 == state ? $signed(x) : $signed(_GEN_144); // @[AecTranscendental.scala 338:18 339:32]
  wire [47:0] _GEN_147 = 5'h1 == state ? $signed(48'sh28be60db9) : $signed(_GEN_145); // @[AecTranscendental.scala 338:18 339:48]
  wire [47:0] _auxiliary_T_3 = 48'sh800000000 - $signed(multiplyResult); // @[AecTranscendental.scala 360:25]
  wire [47:0] _GEN_148 = _multiplyState_T_13 & multiplier_io_resp_valid ? $signed(denominator) : $signed(_GEN_146); // @[AecTranscendental.scala 358:50 359:15]
  wire [47:0] _GEN_149 = _multiplyState_T_13 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_147); // @[AecTranscendental.scala 358:50 359:41]
  wire [4:0] _GEN_151 = _multiplyState_T_13 & multiplier_io_resp_valid ? 5'h9 : _GEN_116; // @[AecTranscendental.scala 358:50 361:11]
  wire [4:0] _GEN_152 = step == 4'h2 ? 5'ha : 5'h8; // @[AecTranscendental.scala 366:{25,33,81}]
  wire [3:0] _GEN_153 = step == 4'h2 ? _GEN_117 : _step_T_1; // @[AecTranscendental.scala 366:{25,60}]
  wire [47:0] _GEN_154 = _multiplyState_T_15 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_148); // @[AecTranscendental.scala 363:53 364:15]
  wire [47:0] _GEN_155 = _multiplyState_T_15 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_149); // @[AecTranscendental.scala 363:53 364:41]
  wire [4:0] _GEN_157 = _multiplyState_T_15 & multiplier_io_resp_valid ? _GEN_152 : _GEN_151; // @[AecTranscendental.scala 363:53]
  wire [3:0] _GEN_158 = _multiplyState_T_15 & multiplier_io_resp_valid ? _GEN_153 : _GEN_117; // @[AecTranscendental.scala 363:53]
  wire [47:0] _GEN_159 = _multiplyState_T_17 & multiplier_io_resp_valid ? $signed(_multiplyA_T_4) : $signed(_GEN_154); // @[AecTranscendental.scala 368:42 369:15]
  wire [47:0] _GEN_160 = _multiplyState_T_17 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_155); // @[AecTranscendental.scala 368:42 369:43]
  wire [4:0] _GEN_162 = _multiplyState_T_17 & multiplier_io_resp_valid ? 5'hb : _GEN_157; // @[AecTranscendental.scala 368:42 371:11]
  wire [47:0] _GEN_163 = _multiplyState_T_19 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_159); // @[AecTranscendental.scala 373:47 374:15]
  wire [47:0] _GEN_164 = _multiplyState_T_19 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_160); // @[AecTranscendental.scala 373:47 374:34]
  wire [3:0] _GEN_167 = _multiplyState_T_19 & multiplier_io_resp_valid ? 4'h0 : _GEN_158; // @[AecTranscendental.scala 373:47 377:10]
  wire [4:0] _GEN_168 = _multiplyState_T_19 & multiplier_io_resp_valid ? 5'hd : _GEN_162; // @[AecTranscendental.scala 373:47 378:11]
  wire [47:0] _coefficient_T_20 = 4'h0 == step ? $signed(48'sh5d1745d1) : $signed(48'sh155555555); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_22 = 4'h1 == step ? $signed(48'sh71c71c72) : $signed(_coefficient_T_20); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_24 = 4'h2 == step ? $signed(48'sh92492492) : $signed(_coefficient_T_22); // @[Mux.scala 81:58]
  wire [47:0] _coefficient_T_26 = 4'h3 == step ? $signed(48'shcccccccd) : $signed(_coefficient_T_24); // @[Mux.scala 81:58]
  wire [47:0] coefficient_1 = 4'h4 == step ? $signed(48'sh155555555) : $signed(_coefficient_T_26); // @[Mux.scala 81:58]
  wire [47:0] _accumulator_T_19 = $signed(coefficient_1) + $signed(multiplyResult); // @[AecTranscendental.scala 384:32]
  wire [4:0] _GEN_169 = step == 4'h4 ? 5'hc : _GEN_168; // @[AecTranscendental.scala 385:{25,33}]
  wire [47:0] _GEN_171 = _multiplyState_T_21 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_163); // @[AecTranscendental.scala 380:48 381:15]
  wire [47:0] _GEN_172 = _multiplyState_T_21 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_164); // @[AecTranscendental.scala 380:48 381:39]
  wire [4:0] _GEN_174 = _multiplyState_T_21 & multiplier_io_resp_valid ? _GEN_169 : _GEN_168; // @[AecTranscendental.scala 380:48]
  wire [47:0] _GEN_176 = _multiplyState_T_23 & multiplier_io_resp_valid ? $signed(term) : $signed(_GEN_171); // @[AecTranscendental.scala 387:43 388:15]
  wire [47:0] _GEN_177 = _multiplyState_T_23 & multiplier_io_resp_valid ? $signed(argument2) : $signed(_GEN_172); // @[AecTranscendental.scala 387:43 388:34]
  wire [4:0] _GEN_179 = _multiplyState_T_23 & multiplier_io_resp_valid ? 5'he : _GEN_174; // @[AecTranscendental.scala 387:43 390:11]
  wire [47:0] _auxiliary_T_6 = $signed(term) + $signed(multiplyResult); // @[AecTranscendental.scala 394:23]
  wire [47:0] _GEN_180 = _multiplyState_T_25 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(_GEN_176); // @[AecTranscendental.scala 392:46 393:15]
  wire [47:0] _GEN_181 = _multiplyState_T_25 & multiplier_io_resp_valid ? $signed(accumulator) : $signed(_GEN_177); // @[AecTranscendental.scala 392:46 393:39]
  wire [45:0] _T_102 = {$signed(exponentScale), 34'h0}; // @[AecTranscendental.scala 399:30]
  wire [47:0] _GEN_194 = {{2{_T_102[45]}},_T_102}; // @[AecTranscendental.scala 399:36]
  wire [47:0] packValue_out_3 = $signed(_GEN_194) + $signed(multiplyResult); // @[AecTranscendental.scala 399:36]
  wire  _T_106 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  AecTransMultiplier multiplier ( // @[AecTranscendental.scala 184:26]
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
  AecQ34ToF32 packer ( // @[AecTranscendental.scala 213:22]
    .clock(packer_clock),
    .reset(packer_reset),
    .io_req_ready(packer_io_req_ready),
    .io_req_valid(packer_io_req_valid),
    .io_req_bits_value(packer_io_req_bits_value),
    .io_req_bits_scale(packer_io_req_bits_scale),
    .io_resp_ready(packer_io_resp_ready),
    .io_resp_valid(packer_io_resp_valid),
    .io_resp_bits(packer_io_resp_bits)
  );
  assign io_req_ready = state == 5'h0; // @[AecTranscendental.scala 225:25]
  assign io_resp_valid = state == 5'h12; // @[AecTranscendental.scala 226:26]
  assign io_resp_bits = result; // @[AecTranscendental.scala 227:16]
  assign multiplier_clock = clock;
  assign multiplier_reset = reset;
  assign multiplier_io_req_valid = _multiplyState_T_24 | state == 5'he | state == 5'hf; // @[AecTranscendental.scala 188:43]
  assign multiplier_io_req_bits_a = _multiplyState_T_27 & multiplier_io_resp_valid ? $signed(auxiliary) : $signed(
    _GEN_180); // @[AecTranscendental.scala 397:46 398:15]
  assign multiplier_io_req_bits_b = _multiplyState_T_27 & multiplier_io_resp_valid ? $signed(48'shb8aa3b296) : $signed(
    _GEN_181); // @[AecTranscendental.scala 397:46 398:39]
  assign multiplier_io_resp_ready = _multiplyState_T_24 | state == 5'he | state == 5'hf; // @[AecTranscendental.scala 188:43]
  assign packer_clock = clock;
  assign packer_reset = reset;
  assign packer_io_req_valid = state == 5'h10; // @[AecTranscendental.scala 214:32]
  assign packer_io_req_bits_value = packValue; // @[AecTranscendental.scala 215:28]
  assign packer_io_req_bits_scale = packScale; // @[AecTranscendental.scala 216:28]
  assign packer_io_resp_ready = state == 5'h11; // @[AecTranscendental.scala 217:33]
  always @(posedge clock) begin
    if (reset) begin // @[AecTranscendental.scala 165:22]
      state <= 5'h0; // @[AecTranscendental.scala 165:22]
    end else if (_T_106) begin // @[AecTranscendental.scala 402:23]
      state <= 5'h0; // @[AecTranscendental.scala 402:31]
    end else if (_multiplyState_T_27 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 397:46]
      state <= 5'h10; // @[AecTranscendental.scala 222:11]
    end else if (_multiplyState_T_25 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 392:46]
      state <= 5'hf; // @[AecTranscendental.scala 395:11]
    end else begin
      state <= _GEN_179;
    end
    if (_T_11) begin // @[AecTranscendental.scala 236:22]
      op <= io_req_bits_op; // @[AecTranscendental.scala 237:8]
    end
    if (_T_11) begin // @[AecTranscendental.scala 236:22]
      if (inputSign) begin // @[AecTranscendental.scala 208:19]
        x <= _inputQ_T_3;
      end else begin
        x <= _inputQ_T;
      end
    end
    if (_multiplyState_T_17 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 368:42]
      term <= multiplyResult; // @[AecTranscendental.scala 370:10]
    end else if (_multiplyState_T_11 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 316:46]
      term <= multiplyResult; // @[AecTranscendental.scala 318:10]
    end else if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 278:48]
      term <= _term_T_9; // @[AecTranscendental.scala 280:10]
    end else if (_T_11) begin // @[AecTranscendental.scala 236:22]
      term <= _GEN_50;
    end
    if (_multiplyState_T_19 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 373:47]
      argument2 <= multiplyResult; // @[AecTranscendental.scala 375:15]
    end else if (_multiplyState_T_3 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 286:44]
      argument2 <= multiplyResult; // @[AecTranscendental.scala 288:15]
    end
    if (_multiplyState_T_21 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 380:48]
      accumulator <= _accumulator_T_19; // @[AecTranscendental.scala 384:17]
    end else if (_multiplyState_T_19 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 373:47]
      accumulator <= 48'sh4ec4ec4f; // @[AecTranscendental.scala 376:17]
    end else if (_multiplyState_T_15 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 363:53]
      accumulator <= multiplyResult; // @[AecTranscendental.scala 365:17]
    end else if (_multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 326:57]
      accumulator <= _accumulator_T_16; // @[AecTranscendental.scala 332:17]
    end else begin
      accumulator <= _GEN_103;
    end
    if (_multiplyState_T_25 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 392:46]
      auxiliary <= _auxiliary_T_6; // @[AecTranscendental.scala 394:15]
    end else if (_multiplyState_T_23 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 387:43]
      auxiliary <= multiplyResult; // @[AecTranscendental.scala 389:15]
    end else if (_multiplyState_T_13 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 358:50]
      auxiliary <= _auxiliary_T_3; // @[AecTranscendental.scala 360:15]
    end else if (_multiplyState_T & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 270:47]
      auxiliary <= _auxiliary_T; // @[AecTranscendental.scala 275:15]
    end
    exponentScale <= _GEN_58[11:0];
    if (reset) begin // @[AecTranscendental.scala 173:21]
      step <= 4'h0; // @[AecTranscendental.scala 173:21]
    end else if (_multiplyState_T_21 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 380:48]
      if (step == 4'h4) begin // @[AecTranscendental.scala 385:25]
        step <= _GEN_167;
      end else begin
        step <= _step_T_1; // @[AecTranscendental.scala 385:61]
      end
    end else begin
      step <= _GEN_167;
    end
    if (_multiplyState_T & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 270:47]
      quadrant <= _quadrant_T[1:0]; // @[AecTranscendental.scala 274:14]
    end
    if (_multiplyState_T_11 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 316:46]
      polynomialCos <= 1'h0; // @[AecTranscendental.scala 322:19]
    end else if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 278:48]
      if (op == 16'h72) begin // @[AecTranscendental.scala 282:25]
        polynomialCos <= odd;
      end else begin
        polynomialCos <= ~odd;
      end
    end
    if (_multiplyState_T_1 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 278:48]
      if (_polynomialCos_T) begin // @[AecTranscendental.scala 283:24]
        negateResult <= quadrant[1];
      end else begin
        negateResult <= quadrant[1] ^ odd;
      end
    end
    if (reset) begin // @[AecTranscendental.scala 177:23]
      result <= 32'h0; // @[AecTranscendental.scala 177:23]
    end else if (_T_11) begin // @[AecTranscendental.scala 236:22]
      if (_T_21) begin // @[AecTranscendental.scala 241:70]
        result <= 32'h7fc00000; // @[AecTranscendental.scala 242:14]
      end else if (_T_12 & inputZero) begin // @[AecTranscendental.scala 243:64]
        result <= io_req_bits_in; // @[AecTranscendental.scala 244:14]
      end else begin
        result <= _GEN_35;
      end
    end else if (_T_10) begin // @[AecTranscendental.scala 230:30]
      result <= packer_io_resp_bits; // @[AecTranscendental.scala 231:12]
    end
    if (_multiplyState_T_27 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 397:46]
      packValue <= packValue_out_3; // @[AecTranscendental.scala 220:15]
    end else if (_multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 326:57]
      if (step == 4'hd) begin // @[AecTranscendental.scala 333:26]
        packValue <= _accumulator_T_16; // @[AecTranscendental.scala 220:15]
      end else begin
        packValue <= _GEN_97;
      end
    end else begin
      packValue <= _GEN_97;
    end
    if (_multiplyState_T_27 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 397:46]
      packScale <= 12'sh0; // @[AecTranscendental.scala 221:15]
    end else if (_multiplyState_T_5 & step >= 4'h4 & multiplier_io_resp_valid) begin // @[AecTranscendental.scala 326:57]
      if (step == 4'hd) begin // @[AecTranscendental.scala 333:26]
        packScale <= exponentScale; // @[AecTranscendental.scala 221:15]
      end else begin
        packScale <= _GEN_98;
      end
    end else begin
      packScale <= _GEN_98;
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
  _RAND_13 = {2{`RANDOM}};
  packValue = _RAND_13[47:0];
  _RAND_14 = {1{`RANDOM}};
  packScale = _RAND_14[11:0];
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
  reg [31:0] _RAND_2;
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
  reg [63:0] _RAND_34;
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
`endif // RANDOMIZE_REG_INIT
  wire  lanes_0_clock; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_reset; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_io_req_valid; // @[AecSfuWarpUnit.scala 17:45]
  wire [15:0] lanes_0_io_req_bits_op; // @[AecSfuWarpUnit.scala 17:45]
  wire [3:0] lanes_0_io_req_bits_dtype; // @[AecSfuWarpUnit.scala 17:45]
  wire [63:0] lanes_0_io_req_bits_a; // @[AecSfuWarpUnit.scala 17:45]
  wire [63:0] lanes_0_io_req_bits_b; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_io_resp_ready; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 17:45]
  wire [63:0] lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 17:45]
  wire  lanes_0_io_resp_bits_error; // @[AecSfuWarpUnit.scala 17:45]
  wire [4:0] lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 17:45]
  wire  requestBuffer_clock; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_reset; // @[AecSfuWarpUnit.scala 21:64]
  wire [15:0] requestBuffer_io_in_op; // @[AecSfuWarpUnit.scala 21:64]
  wire [3:0] requestBuffer_io_in_dtype; // @[AecSfuWarpUnit.scala 21:64]
  wire [31:0] requestBuffer_io_in_activeMask; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_0; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_1; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_2; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_3; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_4; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_5; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_6; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_7; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_8; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_9; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_10; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_11; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_12; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_13; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_14; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_15; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_16; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_17; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_18; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_19; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_20; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_21; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_22; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_23; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_24; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_25; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_26; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_27; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_28; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_29; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_30; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_a_31; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_0; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_1; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_2; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_3; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_4; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_5; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_6; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_7; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_8; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_9; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_10; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_11; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_12; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_13; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_14; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_15; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_16; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_17; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_18; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_19; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_20; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_21; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_22; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_23; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_24; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_25; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_26; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_27; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_28; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_29; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_30; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_in_b_31; // @[AecSfuWarpUnit.scala 21:64]
  wire [7:0] requestBuffer_io_in_dest; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_0; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_1; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_2; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_3; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_4; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_5; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_6; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_arm_7; // @[AecSfuWarpUnit.scala 21:64]
  wire  requestBuffer_io_capture; // @[AecSfuWarpUnit.scala 21:64]
  wire [15:0] requestBuffer_io_out_op; // @[AecSfuWarpUnit.scala 21:64]
  wire [3:0] requestBuffer_io_out_dtype; // @[AecSfuWarpUnit.scala 21:64]
  wire [31:0] requestBuffer_io_out_activeMask; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_0; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_1; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_2; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_3; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_4; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_5; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_6; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_7; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_8; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_9; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_10; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_11; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_12; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_13; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_14; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_15; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_16; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_17; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_18; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_19; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_20; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_21; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_22; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_23; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_24; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_25; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_26; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_27; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_28; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_29; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_30; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_a_31; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_0; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_1; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_2; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_3; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_4; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_5; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_6; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_7; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_8; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_9; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_10; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_11; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_12; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_13; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_14; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_15; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_16; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_17; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_18; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_19; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_20; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_21; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_22; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_23; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_24; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_25; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_26; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_27; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_28; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_29; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_30; // @[AecSfuWarpUnit.scala 21:64]
  wire [63:0] requestBuffer_io_out_b_31; // @[AecSfuWarpUnit.scala 21:64]
  wire [7:0] requestBuffer_io_out_dest; // @[AecSfuWarpUnit.scala 21:64]
  reg [2:0] state; // @[AecSfuWarpUnit.scala 19:22]
  reg [4:0] group; // @[AecSfuWarpUnit.scala 32:22]
  reg [4:0] laneGroup_0; // @[AecSfuWarpUnit.scala 33:22]
  reg [63:0] results_0; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_1; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_2; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_3; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_4; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_5; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_6; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_7; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_8; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_9; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_10; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_11; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_12; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_13; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_14; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_15; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_16; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_17; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_18; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_19; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_20; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_21; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_22; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_23; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_24; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_25; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_26; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_27; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_28; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_29; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_30; // @[AecSfuWarpUnit.scala 35:24]
  reg [63:0] results_31; // @[AecSfuWarpUnit.scala 35:24]
  reg [31:0] errors; // @[AecSfuWarpUnit.scala 36:23]
  reg [4:0] flags_0; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_1; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_2; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_3; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_4; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_5; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_6; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_7; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_8; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_9; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_10; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_11; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_12; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_13; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_14; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_15; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_16; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_17; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_18; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_19; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_20; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_21; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_22; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_23; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_24; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_25; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_26; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_27; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_28; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_29; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_30; // @[AecSfuWarpUnit.scala 37:22]
  reg [4:0] flags_31; // @[AecSfuWarpUnit.scala 37:22]
  reg [31:0] writeMask; // @[AecSfuWarpUnit.scala 38:26]
  wire [5:0] base = group * 1'h1; // @[AecSfuWarpUnit.scala 39:20]
  reg  retireWrite_0; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_1; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_2; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_3; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_4; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_5; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_6; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_7; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_8; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_9; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_10; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_11; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_12; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_13; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_14; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_15; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_16; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_17; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_18; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_19; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_20; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_21; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_22; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_23; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_24; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_25; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_26; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_27; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_28; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_29; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_30; // @[AecSfuWarpUnit.scala 43:28]
  reg  retireWrite_31; // @[AecSfuWarpUnit.scala 43:28]
  wire  armCapture = state == 3'h0 & io_req_valid; // @[AecSfuWarpUnit.scala 46:65]
  reg  armClusters_0; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_1; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_2; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_3; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_4; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_5; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_6; // @[AecSfuWarpUnit.scala 48:30]
  reg  armClusters_7; // @[AecSfuWarpUnit.scala 48:30]
  wire  _requestBuffer_io_capture_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [4:0] _lane_T_35 = 5'h1 == laneGroup_0 ? 5'h1 : 5'h0; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_37 = 5'h2 == laneGroup_0 ? 5'h2 : _lane_T_35; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_39 = 5'h3 == laneGroup_0 ? 5'h3 : _lane_T_37; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_41 = 5'h4 == laneGroup_0 ? 5'h4 : _lane_T_39; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_43 = 5'h5 == laneGroup_0 ? 5'h5 : _lane_T_41; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_45 = 5'h6 == laneGroup_0 ? 5'h6 : _lane_T_43; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_47 = 5'h7 == laneGroup_0 ? 5'h7 : _lane_T_45; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_49 = 5'h8 == laneGroup_0 ? 5'h8 : _lane_T_47; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_51 = 5'h9 == laneGroup_0 ? 5'h9 : _lane_T_49; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_53 = 5'ha == laneGroup_0 ? 5'ha : _lane_T_51; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_55 = 5'hb == laneGroup_0 ? 5'hb : _lane_T_53; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_57 = 5'hc == laneGroup_0 ? 5'hc : _lane_T_55; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_59 = 5'hd == laneGroup_0 ? 5'hd : _lane_T_57; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_61 = 5'he == laneGroup_0 ? 5'he : _lane_T_59; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_63 = 5'hf == laneGroup_0 ? 5'hf : _lane_T_61; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_65 = 5'h10 == laneGroup_0 ? 5'h10 : _lane_T_63; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_67 = 5'h11 == laneGroup_0 ? 5'h11 : _lane_T_65; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_69 = 5'h12 == laneGroup_0 ? 5'h12 : _lane_T_67; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_71 = 5'h13 == laneGroup_0 ? 5'h13 : _lane_T_69; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_73 = 5'h14 == laneGroup_0 ? 5'h14 : _lane_T_71; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_75 = 5'h15 == laneGroup_0 ? 5'h15 : _lane_T_73; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_77 = 5'h16 == laneGroup_0 ? 5'h16 : _lane_T_75; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_79 = 5'h17 == laneGroup_0 ? 5'h17 : _lane_T_77; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_81 = 5'h18 == laneGroup_0 ? 5'h18 : _lane_T_79; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_83 = 5'h19 == laneGroup_0 ? 5'h19 : _lane_T_81; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_85 = 5'h1a == laneGroup_0 ? 5'h1a : _lane_T_83; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_87 = 5'h1b == laneGroup_0 ? 5'h1b : _lane_T_85; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_89 = 5'h1c == laneGroup_0 ? 5'h1c : _lane_T_87; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_91 = 5'h1d == laneGroup_0 ? 5'h1d : _lane_T_89; // @[Mux.scala 81:58]
  wire [4:0] _lane_T_93 = 5'h1e == laneGroup_0 ? 5'h1e : _lane_T_91; // @[Mux.scala 81:58]
  wire [4:0] lane = 5'h1f == laneGroup_0 ? 5'h1f : _lane_T_93; // @[Mux.scala 81:58]
  wire  _lanes_0_io_req_valid_T_1 = state == 3'h3 & lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 66:46]
  wire [63:0] held_a_0 = requestBuffer_io_out_a_0; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] held_a_1 = requestBuffer_io_out_a_1; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_1 = 5'h1 == lane ? held_a_1 : held_a_0; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_2 = requestBuffer_io_out_a_2; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_2 = 5'h2 == lane ? held_a_2 : _GEN_1; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_3 = requestBuffer_io_out_a_3; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_3 = 5'h3 == lane ? held_a_3 : _GEN_2; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_4 = requestBuffer_io_out_a_4; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_4 = 5'h4 == lane ? held_a_4 : _GEN_3; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_5 = requestBuffer_io_out_a_5; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_5 = 5'h5 == lane ? held_a_5 : _GEN_4; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_6 = requestBuffer_io_out_a_6; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_6 = 5'h6 == lane ? held_a_6 : _GEN_5; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_7 = requestBuffer_io_out_a_7; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_7 = 5'h7 == lane ? held_a_7 : _GEN_6; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_8 = requestBuffer_io_out_a_8; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_8 = 5'h8 == lane ? held_a_8 : _GEN_7; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_9 = requestBuffer_io_out_a_9; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_9 = 5'h9 == lane ? held_a_9 : _GEN_8; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_10 = requestBuffer_io_out_a_10; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_10 = 5'ha == lane ? held_a_10 : _GEN_9; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_11 = requestBuffer_io_out_a_11; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_11 = 5'hb == lane ? held_a_11 : _GEN_10; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_12 = requestBuffer_io_out_a_12; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_12 = 5'hc == lane ? held_a_12 : _GEN_11; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_13 = requestBuffer_io_out_a_13; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_13 = 5'hd == lane ? held_a_13 : _GEN_12; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_14 = requestBuffer_io_out_a_14; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_14 = 5'he == lane ? held_a_14 : _GEN_13; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_15 = requestBuffer_io_out_a_15; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_15 = 5'hf == lane ? held_a_15 : _GEN_14; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_16 = requestBuffer_io_out_a_16; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_16 = 5'h10 == lane ? held_a_16 : _GEN_15; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_17 = requestBuffer_io_out_a_17; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_17 = 5'h11 == lane ? held_a_17 : _GEN_16; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_18 = requestBuffer_io_out_a_18; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_18 = 5'h12 == lane ? held_a_18 : _GEN_17; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_19 = requestBuffer_io_out_a_19; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_19 = 5'h13 == lane ? held_a_19 : _GEN_18; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_20 = requestBuffer_io_out_a_20; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_20 = 5'h14 == lane ? held_a_20 : _GEN_19; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_21 = requestBuffer_io_out_a_21; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_21 = 5'h15 == lane ? held_a_21 : _GEN_20; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_22 = requestBuffer_io_out_a_22; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_22 = 5'h16 == lane ? held_a_22 : _GEN_21; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_23 = requestBuffer_io_out_a_23; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_23 = 5'h17 == lane ? held_a_23 : _GEN_22; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_24 = requestBuffer_io_out_a_24; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_24 = 5'h18 == lane ? held_a_24 : _GEN_23; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_25 = requestBuffer_io_out_a_25; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_25 = 5'h19 == lane ? held_a_25 : _GEN_24; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_26 = requestBuffer_io_out_a_26; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_26 = 5'h1a == lane ? held_a_26 : _GEN_25; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_27 = requestBuffer_io_out_a_27; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_27 = 5'h1b == lane ? held_a_27 : _GEN_26; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_28 = requestBuffer_io_out_a_28; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_28 = 5'h1c == lane ? held_a_28 : _GEN_27; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_29 = requestBuffer_io_out_a_29; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_29 = 5'h1d == lane ? held_a_29 : _GEN_28; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_30 = requestBuffer_io_out_a_30; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_30 = 5'h1e == lane ? held_a_30 : _GEN_29; // @[AecSfuWarpUnit.scala 70:{28,28}]
  wire [63:0] held_a_31 = requestBuffer_io_out_a_31; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] held_b_0 = requestBuffer_io_out_b_0; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] held_b_1 = requestBuffer_io_out_b_1; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_33 = 5'h1 == lane ? held_b_1 : held_b_0; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_2 = requestBuffer_io_out_b_2; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_34 = 5'h2 == lane ? held_b_2 : _GEN_33; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_3 = requestBuffer_io_out_b_3; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_35 = 5'h3 == lane ? held_b_3 : _GEN_34; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_4 = requestBuffer_io_out_b_4; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_36 = 5'h4 == lane ? held_b_4 : _GEN_35; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_5 = requestBuffer_io_out_b_5; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_37 = 5'h5 == lane ? held_b_5 : _GEN_36; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_6 = requestBuffer_io_out_b_6; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_38 = 5'h6 == lane ? held_b_6 : _GEN_37; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_7 = requestBuffer_io_out_b_7; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_39 = 5'h7 == lane ? held_b_7 : _GEN_38; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_8 = requestBuffer_io_out_b_8; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_40 = 5'h8 == lane ? held_b_8 : _GEN_39; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_9 = requestBuffer_io_out_b_9; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_41 = 5'h9 == lane ? held_b_9 : _GEN_40; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_10 = requestBuffer_io_out_b_10; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_42 = 5'ha == lane ? held_b_10 : _GEN_41; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_11 = requestBuffer_io_out_b_11; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_43 = 5'hb == lane ? held_b_11 : _GEN_42; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_12 = requestBuffer_io_out_b_12; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_44 = 5'hc == lane ? held_b_12 : _GEN_43; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_13 = requestBuffer_io_out_b_13; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_45 = 5'hd == lane ? held_b_13 : _GEN_44; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_14 = requestBuffer_io_out_b_14; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_46 = 5'he == lane ? held_b_14 : _GEN_45; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_15 = requestBuffer_io_out_b_15; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_47 = 5'hf == lane ? held_b_15 : _GEN_46; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_16 = requestBuffer_io_out_b_16; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_48 = 5'h10 == lane ? held_b_16 : _GEN_47; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_17 = requestBuffer_io_out_b_17; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_49 = 5'h11 == lane ? held_b_17 : _GEN_48; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_18 = requestBuffer_io_out_b_18; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_50 = 5'h12 == lane ? held_b_18 : _GEN_49; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_19 = requestBuffer_io_out_b_19; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_51 = 5'h13 == lane ? held_b_19 : _GEN_50; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_20 = requestBuffer_io_out_b_20; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_52 = 5'h14 == lane ? held_b_20 : _GEN_51; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_21 = requestBuffer_io_out_b_21; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_53 = 5'h15 == lane ? held_b_21 : _GEN_52; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_22 = requestBuffer_io_out_b_22; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_54 = 5'h16 == lane ? held_b_22 : _GEN_53; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_23 = requestBuffer_io_out_b_23; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_55 = 5'h17 == lane ? held_b_23 : _GEN_54; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_24 = requestBuffer_io_out_b_24; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_56 = 5'h18 == lane ? held_b_24 : _GEN_55; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_25 = requestBuffer_io_out_b_25; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_57 = 5'h19 == lane ? held_b_25 : _GEN_56; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_26 = requestBuffer_io_out_b_26; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_58 = 5'h1a == lane ? held_b_26 : _GEN_57; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_27 = requestBuffer_io_out_b_27; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_59 = 5'h1b == lane ? held_b_27 : _GEN_58; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_28 = requestBuffer_io_out_b_28; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_60 = 5'h1c == lane ? held_b_28 : _GEN_59; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_29 = requestBuffer_io_out_b_29; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_61 = 5'h1d == lane ? held_b_29 : _GEN_60; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_30 = requestBuffer_io_out_b_30; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [63:0] _GEN_62 = 5'h1e == lane ? held_b_30 : _GEN_61; // @[AecSfuWarpUnit.scala 71:{28,28}]
  wire [63:0] held_b_31 = requestBuffer_io_out_b_31; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire  _lanes_0_io_resp_ready_T_1 = state == 3'h4 & lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 73:51]
  wire  _retireWrite_0_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h0; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_1_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_2_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h2; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_3_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h3; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_4_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h4; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_5_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h5; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_6_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h6; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_7_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h7; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_8_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h8; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_9_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h9; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_10_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'ha; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_11_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'hb; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_12_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'hc; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_13_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'hd; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_14_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'he; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_15_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'hf; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_16_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h10; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_17_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h11; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_18_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h12; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_19_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h13; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_20_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h14; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_21_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h15; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_22_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h16; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_23_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h17; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_24_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h18; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_25_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h19; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_26_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1a; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_27_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1b; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_28_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1c; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_29_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1d; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_30_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1e; // @[AecSfuWarpUnit.scala 77:39]
  wire  _retireWrite_31_T_3 = _lanes_0_io_resp_ready_T_1 & group == 5'h1f; // @[AecSfuWarpUnit.scala 77:39]
  wire [31:0] held_activeMask = requestBuffer_io_out_activeMask; // @[AecSfuWarpUnit.scala 20:18 24:10]
  wire [2:0] _GEN_128 = armCapture ? 3'h1 : state; // @[AecSfuWarpUnit.scala 19:22 88:{23,31}]
  wire [2:0] _GEN_129 = state == 3'h1 ? 3'h2 : _GEN_128; // @[AecSfuWarpUnit.scala 89:{26,34}]
  wire [2:0] _state_T_1 = |io_req_bits_activeMask ? 3'h3 : 3'h6; // @[AecSfuWarpUnit.scala 97:17]
  wire [4:0] _GEN_131 = _requestBuffer_io_capture_T ? 5'h0 : group; // @[AecSfuWarpUnit.scala 91:22 93:11 32:22]
  wire [4:0] _GEN_132 = _requestBuffer_io_capture_T ? 5'h0 : laneGroup_0; // @[AecSfuWarpUnit.scala 33:22 91:22 94:53]
  wire [31:0] _GEN_133 = _requestBuffer_io_capture_T ? 32'h0 : errors; // @[AecSfuWarpUnit.scala 91:22 95:12 36:23]
  wire [31:0] _GEN_134 = _requestBuffer_io_capture_T ? 32'h0 : writeMask; // @[AecSfuWarpUnit.scala 91:22 96:15 38:26]
  wire [2:0] _GEN_135 = _requestBuffer_io_capture_T ? _state_T_1 : _GEN_129; // @[AecSfuWarpUnit.scala 91:22 97:11]
  wire [2:0] _GEN_136 = _lanes_0_io_req_valid_T_1 ? 3'h4 : _GEN_135; // @[AecSfuWarpUnit.scala 99:{38,46}]
  wire [6:0] _completedMask_T = {{1'd0}, base}; // @[AecSfuWarpUnit.scala 101:87]
  wire [31:0] _completedMask_T_2 = held_activeMask >> _completedMask_T[5:0]; // @[AecSfuWarpUnit.scala 101:81]
  wire [63:0] _GEN_0 = {{63'd0}, _completedMask_T_2[0]}; // @[AecSfuWarpUnit.scala 101:103]
  wire [63:0] completedMask = _GEN_0 << base; // @[AecSfuWarpUnit.scala 101:103]
  wire  _errorGroup_T_4 = _completedMask_T_2[0] & lanes_0_io_resp_bits_error; // @[AecSfuWarpUnit.scala 103:35]
  wire [63:0] _GEN_31 = {{63'd0}, _errorGroup_T_4}; // @[AecSfuWarpUnit.scala 103:75]
  wire [63:0] errorGroup = _GEN_31 << base; // @[AecSfuWarpUnit.scala 103:75]
  wire [63:0] _GEN_147 = {{32'd0}, writeMask}; // @[AecSfuWarpUnit.scala 104:28]
  wire [63:0] _writeMask_T = _GEN_147 | completedMask; // @[AecSfuWarpUnit.scala 104:28]
  wire [63:0] _GEN_148 = {{32'd0}, errors}; // @[AecSfuWarpUnit.scala 105:22]
  wire [63:0] _errors_T = _GEN_148 | errorGroup; // @[AecSfuWarpUnit.scala 105:22]
  wire [63:0] _GEN_137 = _lanes_0_io_resp_ready_T_1 ? _writeMask_T : {{32'd0}, _GEN_134}; // @[AecSfuWarpUnit.scala 100:42 104:15]
  wire [63:0] _GEN_138 = _lanes_0_io_resp_ready_T_1 ? _errors_T : {{32'd0}, _GEN_133}; // @[AecSfuWarpUnit.scala 100:42 105:12]
  wire [5:0] _consumed_T_1 = base + 6'h1; // @[AecSfuWarpUnit.scala 109:40]
  wire [95:0] _consumed_T_2 = 96'h1 << _consumed_T_1; // @[AecSfuWarpUnit.scala 109:31]
  wire [95:0] consumed = _consumed_T_2 - 96'h1; // @[AecSfuWarpUnit.scala 109:60]
  wire [32:0] _remaining_T = {1'h0,held_activeMask}; // @[Cat.scala 33:92]
  wire [95:0] _remaining_T_1 = ~consumed; // @[AecSfuWarpUnit.scala 110:55]
  wire [95:0] _GEN_149 = {{63'd0}, _remaining_T}; // @[AecSfuWarpUnit.scala 110:53]
  wire [95:0] _remaining_T_2 = _GEN_149 & _remaining_T_1; // @[AecSfuWarpUnit.scala 110:53]
  wire [31:0] remaining = _remaining_T_2[31:0]; // @[AecSfuWarpUnit.scala 110:65]
  wire [4:0] _nextGroup_T_32 = remaining[30] ? 5'h1e : 5'h1f; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_33 = remaining[29] ? 5'h1d : _nextGroup_T_32; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_34 = remaining[28] ? 5'h1c : _nextGroup_T_33; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_35 = remaining[27] ? 5'h1b : _nextGroup_T_34; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_36 = remaining[26] ? 5'h1a : _nextGroup_T_35; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_37 = remaining[25] ? 5'h19 : _nextGroup_T_36; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_38 = remaining[24] ? 5'h18 : _nextGroup_T_37; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_39 = remaining[23] ? 5'h17 : _nextGroup_T_38; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_40 = remaining[22] ? 5'h16 : _nextGroup_T_39; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_41 = remaining[21] ? 5'h15 : _nextGroup_T_40; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_42 = remaining[20] ? 5'h14 : _nextGroup_T_41; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_43 = remaining[19] ? 5'h13 : _nextGroup_T_42; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_44 = remaining[18] ? 5'h12 : _nextGroup_T_43; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_45 = remaining[17] ? 5'h11 : _nextGroup_T_44; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_46 = remaining[16] ? 5'h10 : _nextGroup_T_45; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_47 = remaining[15] ? 5'hf : _nextGroup_T_46; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_48 = remaining[14] ? 5'he : _nextGroup_T_47; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_49 = remaining[13] ? 5'hd : _nextGroup_T_48; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_50 = remaining[12] ? 5'hc : _nextGroup_T_49; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_51 = remaining[11] ? 5'hb : _nextGroup_T_50; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_52 = remaining[10] ? 5'ha : _nextGroup_T_51; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_53 = remaining[9] ? 5'h9 : _nextGroup_T_52; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_54 = remaining[8] ? 5'h8 : _nextGroup_T_53; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_55 = remaining[7] ? 5'h7 : _nextGroup_T_54; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_56 = remaining[6] ? 5'h6 : _nextGroup_T_55; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_57 = remaining[5] ? 5'h5 : _nextGroup_T_56; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_58 = remaining[4] ? 5'h4 : _nextGroup_T_57; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_59 = remaining[3] ? 5'h3 : _nextGroup_T_58; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_60 = remaining[2] ? 5'h2 : _nextGroup_T_59; // @[Mux.scala 47:70]
  wire [4:0] _nextGroup_T_61 = remaining[1] ? 5'h1 : _nextGroup_T_60; // @[Mux.scala 47:70]
  wire  _T_201 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [63:0] _GEN_150 = reset ? 64'h0 : _GEN_138; // @[AecSfuWarpUnit.scala 36:{23,23}]
  wire [63:0] _GEN_151 = reset ? 64'h0 : _GEN_137; // @[AecSfuWarpUnit.scala 38:{26,26}]
  AESSFU lanes_0 ( // @[AecSfuWarpUnit.scala 17:45]
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
  AecWarpRequestBuffer requestBuffer ( // @[AecSfuWarpUnit.scala 21:64]
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
  assign io_req_ready = state == 3'h2; // @[AecSfuWarpUnit.scala 54:56]
  assign io_resp_valid = state == 3'h6; // @[AecSfuWarpUnit.scala 55:26]
  assign io_resp_bits_result_0 = writeMask[0] ? results_0 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_1 = writeMask[1] ? results_1 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_2 = writeMask[2] ? results_2 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_3 = writeMask[3] ? results_3 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_4 = writeMask[4] ? results_4 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_5 = writeMask[5] ? results_5 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_6 = writeMask[6] ? results_6 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_7 = writeMask[7] ? results_7 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_8 = writeMask[8] ? results_8 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_9 = writeMask[9] ? results_9 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_10 = writeMask[10] ? results_10 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_11 = writeMask[11] ? results_11 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_12 = writeMask[12] ? results_12 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_13 = writeMask[13] ? results_13 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_14 = writeMask[14] ? results_14 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_15 = writeMask[15] ? results_15 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_16 = writeMask[16] ? results_16 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_17 = writeMask[17] ? results_17 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_18 = writeMask[18] ? results_18 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_19 = writeMask[19] ? results_19 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_20 = writeMask[20] ? results_20 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_21 = writeMask[21] ? results_21 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_22 = writeMask[22] ? results_22 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_23 = writeMask[23] ? results_23 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_24 = writeMask[24] ? results_24 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_25 = writeMask[25] ? results_25 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_26 = writeMask[26] ? results_26 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_27 = writeMask[27] ? results_27 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_28 = writeMask[28] ? results_28 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_29 = writeMask[29] ? results_29 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_30 = writeMask[30] ? results_30 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_result_31 = writeMask[31] ? results_31 : 64'h0; // @[AecSfuWarpUnit.scala 56:59]
  assign io_resp_bits_predicateMask = 32'h0; // @[AecSfuWarpUnit.scala 57:30]
  assign io_resp_bits_errorMask = errors; // @[AecSfuWarpUnit.scala 58:26]
  assign io_resp_bits_exceptionFlags_0 = writeMask[0] ? flags_0 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_1 = writeMask[1] ? flags_1 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_2 = writeMask[2] ? flags_2 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_3 = writeMask[3] ? flags_3 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_4 = writeMask[4] ? flags_4 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_5 = writeMask[5] ? flags_5 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_6 = writeMask[6] ? flags_6 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_7 = writeMask[7] ? flags_7 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_8 = writeMask[8] ? flags_8 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_9 = writeMask[9] ? flags_9 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_10 = writeMask[10] ? flags_10 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_11 = writeMask[11] ? flags_11 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_12 = writeMask[12] ? flags_12 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_13 = writeMask[13] ? flags_13 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_14 = writeMask[14] ? flags_14 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_15 = writeMask[15] ? flags_15 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_16 = writeMask[16] ? flags_16 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_17 = writeMask[17] ? flags_17 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_18 = writeMask[18] ? flags_18 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_19 = writeMask[19] ? flags_19 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_20 = writeMask[20] ? flags_20 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_21 = writeMask[21] ? flags_21 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_22 = writeMask[22] ? flags_22 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_23 = writeMask[23] ? flags_23 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_24 = writeMask[24] ? flags_24 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_25 = writeMask[25] ? flags_25 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_26 = writeMask[26] ? flags_26 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_27 = writeMask[27] ? flags_27 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_28 = writeMask[28] ? flags_28 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_29 = writeMask[29] ? flags_29 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_30 = writeMask[30] ? flags_30 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_exceptionFlags_31 = writeMask[31] ? flags_31 : 5'h0; // @[AecSfuWarpUnit.scala 59:67]
  assign io_resp_bits_activeMask = requestBuffer_io_out_activeMask; // @[AecSfuWarpUnit.scala 20:18 24:10]
  assign io_resp_bits_dest = requestBuffer_io_out_dest; // @[AecSfuWarpUnit.scala 20:18 24:10]
  assign lanes_0_clock = clock;
  assign lanes_0_reset = reset;
  assign lanes_0_io_req_valid = state == 3'h3 & lanes_0_io_req_ready; // @[AecSfuWarpUnit.scala 66:46]
  assign lanes_0_io_req_bits_op = requestBuffer_io_out_op; // @[AecSfuWarpUnit.scala 20:18 24:10]
  assign lanes_0_io_req_bits_dtype = requestBuffer_io_out_dtype; // @[AecSfuWarpUnit.scala 20:18 24:10]
  assign lanes_0_io_req_bits_a = 5'h1f == lane ? held_a_31 : _GEN_30; // @[AecSfuWarpUnit.scala 70:{28,28}]
  assign lanes_0_io_req_bits_b = 5'h1f == lane ? held_b_31 : _GEN_62; // @[AecSfuWarpUnit.scala 71:{28,28}]
  assign lanes_0_io_resp_ready = state == 3'h4 & lanes_0_io_resp_valid; // @[AecSfuWarpUnit.scala 73:51]
  assign requestBuffer_clock = clock;
  assign requestBuffer_reset = reset;
  assign requestBuffer_io_in_op = io_req_bits_op; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_dtype = io_req_bits_dtype; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_activeMask = io_req_bits_activeMask; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_0 = io_req_bits_a_0; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_1 = io_req_bits_a_1; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_2 = io_req_bits_a_2; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_3 = io_req_bits_a_3; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_4 = io_req_bits_a_4; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_5 = io_req_bits_a_5; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_6 = io_req_bits_a_6; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_7 = io_req_bits_a_7; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_8 = io_req_bits_a_8; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_9 = io_req_bits_a_9; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_10 = io_req_bits_a_10; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_11 = io_req_bits_a_11; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_12 = io_req_bits_a_12; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_13 = io_req_bits_a_13; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_14 = io_req_bits_a_14; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_15 = io_req_bits_a_15; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_16 = io_req_bits_a_16; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_17 = io_req_bits_a_17; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_18 = io_req_bits_a_18; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_19 = io_req_bits_a_19; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_20 = io_req_bits_a_20; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_21 = io_req_bits_a_21; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_22 = io_req_bits_a_22; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_23 = io_req_bits_a_23; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_24 = io_req_bits_a_24; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_25 = io_req_bits_a_25; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_26 = io_req_bits_a_26; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_27 = io_req_bits_a_27; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_28 = io_req_bits_a_28; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_29 = io_req_bits_a_29; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_30 = io_req_bits_a_30; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_a_31 = io_req_bits_a_31; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_0 = io_req_bits_b_0; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_1 = io_req_bits_b_1; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_2 = io_req_bits_b_2; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_3 = io_req_bits_b_3; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_4 = io_req_bits_b_4; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_5 = io_req_bits_b_5; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_6 = io_req_bits_b_6; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_7 = io_req_bits_b_7; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_8 = io_req_bits_b_8; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_9 = io_req_bits_b_9; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_10 = io_req_bits_b_10; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_11 = io_req_bits_b_11; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_12 = io_req_bits_b_12; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_13 = io_req_bits_b_13; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_14 = io_req_bits_b_14; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_15 = io_req_bits_b_15; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_16 = io_req_bits_b_16; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_17 = io_req_bits_b_17; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_18 = io_req_bits_b_18; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_19 = io_req_bits_b_19; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_20 = io_req_bits_b_20; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_21 = io_req_bits_b_21; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_22 = io_req_bits_b_22; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_23 = io_req_bits_b_23; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_24 = io_req_bits_b_24; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_25 = io_req_bits_b_25; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_26 = io_req_bits_b_26; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_27 = io_req_bits_b_27; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_28 = io_req_bits_b_28; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_29 = io_req_bits_b_29; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_30 = io_req_bits_b_30; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_b_31 = io_req_bits_b_31; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_in_dest = io_req_bits_dest; // @[AecSfuWarpUnit.scala 23:29]
  assign requestBuffer_io_arm_0 = armClusters_0; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_1 = armClusters_1; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_2 = armClusters_2; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_3 = armClusters_3; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_4 = armClusters_4; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_5 = armClusters_5; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_6 = armClusters_6; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_arm_7 = armClusters_7; // @[AecSfuWarpUnit.scala 51:30]
  assign requestBuffer_io_capture = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  always @(posedge clock) begin
    if (reset) begin // @[AecSfuWarpUnit.scala 19:22]
      state <= 3'h0; // @[AecSfuWarpUnit.scala 19:22]
    end else if (_T_201) begin // @[AecSfuWarpUnit.scala 121:23]
      state <= 3'h0; // @[AecSfuWarpUnit.scala 121:31]
    end else if (state == 3'h5) begin // @[AecSfuWarpUnit.scala 108:27]
      if (~(|remaining)) begin // @[AecSfuWarpUnit.scala 111:27]
        state <= 3'h6; // @[AecSfuWarpUnit.scala 111:35]
      end else begin
        state <= 3'h3; // @[AecSfuWarpUnit.scala 118:15]
      end
    end else if (_lanes_0_io_resp_ready_T_1) begin // @[AecSfuWarpUnit.scala 100:42]
      state <= 3'h5; // @[AecSfuWarpUnit.scala 106:11]
    end else begin
      state <= _GEN_136;
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 32:22]
      group <= 5'h0; // @[AecSfuWarpUnit.scala 32:22]
    end else if (state == 3'h5) begin // @[AecSfuWarpUnit.scala 108:27]
      if (~(|remaining)) begin // @[AecSfuWarpUnit.scala 111:27]
        group <= _GEN_131;
      end else if (remaining[0]) begin // @[Mux.scala 47:70]
        group <= 5'h0;
      end else begin
        group <= _nextGroup_T_61;
      end
    end else begin
      group <= _GEN_131;
    end
    if (state == 3'h5) begin // @[AecSfuWarpUnit.scala 108:27]
      if (~(|remaining)) begin // @[AecSfuWarpUnit.scala 111:27]
        laneGroup_0 <= _GEN_132;
      end else if (remaining[0]) begin // @[Mux.scala 47:70]
        laneGroup_0 <= 5'h0;
      end else if (remaining[1]) begin // @[Mux.scala 47:70]
        laneGroup_0 <= 5'h1;
      end else begin
        laneGroup_0 <= _nextGroup_T_60;
      end
    end else begin
      laneGroup_0 <= _GEN_132;
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_0 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_0 & held_activeMask[0]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_0 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_1 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_1 & held_activeMask[1]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_1 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_2 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_2 & held_activeMask[2]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_2 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_3 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_3 & held_activeMask[3]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_3 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_4 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_4 & held_activeMask[4]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_4 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_5 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_5 & held_activeMask[5]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_5 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_6 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_6 & held_activeMask[6]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_6 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_7 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_7 & held_activeMask[7]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_7 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_8 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_8 & held_activeMask[8]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_8 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_9 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_9 & held_activeMask[9]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_9 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_10 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_10 & held_activeMask[10]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_10 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_11 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_11 & held_activeMask[11]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_11 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_12 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_12 & held_activeMask[12]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_12 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_13 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_13 & held_activeMask[13]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_13 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_14 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_14 & held_activeMask[14]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_14 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_15 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_15 & held_activeMask[15]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_15 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_16 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_16 & held_activeMask[16]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_16 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_17 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_17 & held_activeMask[17]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_17 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_18 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_18 & held_activeMask[18]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_18 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_19 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_19 & held_activeMask[19]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_19 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_20 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_20 & held_activeMask[20]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_20 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_21 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_21 & held_activeMask[21]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_21 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_22 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_22 & held_activeMask[22]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_22 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_23 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_23 & held_activeMask[23]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_23 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_24 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_24 & held_activeMask[24]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_24 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_25 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_25 & held_activeMask[25]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_25 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_26 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_26 & held_activeMask[26]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_26 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_27 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_27 & held_activeMask[27]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_27 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_28 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_28 & held_activeMask[28]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_28 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_29 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_29 & held_activeMask[29]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_29 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_30 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_30 & held_activeMask[30]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_30 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 35:24]
      results_31 <= 64'h0; // @[AecSfuWarpUnit.scala 35:24]
    end else if (retireWrite_31 & held_activeMask[31]) begin // @[AecSfuWarpUnit.scala 81:90]
      results_31 <= lanes_0_io_resp_bits_result; // @[AecSfuWarpUnit.scala 82:34]
    end
    errors <= _GEN_150[31:0]; // @[AecSfuWarpUnit.scala 36:{23,23}]
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_0 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_0 & held_activeMask[0]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_0 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_1 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_1 & held_activeMask[1]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_1 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_2 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_2 & held_activeMask[2]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_2 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_3 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_3 & held_activeMask[3]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_3 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_4 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_4 & held_activeMask[4]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_4 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_5 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_5 & held_activeMask[5]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_5 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_6 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_6 & held_activeMask[6]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_6 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_7 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_7 & held_activeMask[7]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_7 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_8 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_8 & held_activeMask[8]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_8 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_9 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_9 & held_activeMask[9]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_9 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_10 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_10 & held_activeMask[10]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_10 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_11 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_11 & held_activeMask[11]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_11 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_12 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_12 & held_activeMask[12]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_12 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_13 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_13 & held_activeMask[13]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_13 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_14 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_14 & held_activeMask[14]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_14 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_15 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_15 & held_activeMask[15]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_15 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_16 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_16 & held_activeMask[16]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_16 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_17 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_17 & held_activeMask[17]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_17 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_18 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_18 & held_activeMask[18]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_18 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_19 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_19 & held_activeMask[19]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_19 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_20 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_20 & held_activeMask[20]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_20 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_21 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_21 & held_activeMask[21]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_21 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_22 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_22 & held_activeMask[22]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_22 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_23 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_23 & held_activeMask[23]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_23 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_24 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_24 & held_activeMask[24]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_24 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_25 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_25 & held_activeMask[25]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_25 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_26 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_26 & held_activeMask[26]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_26 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_27 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_27 & held_activeMask[27]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_27 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_28 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_28 & held_activeMask[28]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_28 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_29 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_29 & held_activeMask[29]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_29 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_30 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_30 & held_activeMask[30]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_30 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 37:22]
      flags_31 <= 5'h0; // @[AecSfuWarpUnit.scala 37:22]
    end else if (retireWrite_31 & held_activeMask[31]) begin // @[AecSfuWarpUnit.scala 81:90]
      flags_31 <= lanes_0_io_resp_bits_exceptionFlags; // @[AecSfuWarpUnit.scala 83:32]
    end
    writeMask <= _GEN_151[31:0]; // @[AecSfuWarpUnit.scala 38:{26,26}]
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_0 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_0 <= _retireWrite_0_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_1 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_1 <= _retireWrite_1_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_2 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_2 <= _retireWrite_2_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_3 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_3 <= _retireWrite_3_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_4 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_4 <= _retireWrite_4_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_5 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_5 <= _retireWrite_5_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_6 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_6 <= _retireWrite_6_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_7 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_7 <= _retireWrite_7_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_8 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_8 <= _retireWrite_8_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_9 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_9 <= _retireWrite_9_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_10 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_10 <= _retireWrite_10_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_11 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_11 <= _retireWrite_11_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_12 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_12 <= _retireWrite_12_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_13 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_13 <= _retireWrite_13_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_14 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_14 <= _retireWrite_14_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_15 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_15 <= _retireWrite_15_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_16 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_16 <= _retireWrite_16_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_17 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_17 <= _retireWrite_17_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_18 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_18 <= _retireWrite_18_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_19 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_19 <= _retireWrite_19_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_20 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_20 <= _retireWrite_20_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_21 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_21 <= _retireWrite_21_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_22 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_22 <= _retireWrite_22_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_23 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_23 <= _retireWrite_23_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_24 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_24 <= _retireWrite_24_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_25 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_25 <= _retireWrite_25_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_26 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_26 <= _retireWrite_26_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_27 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_27 <= _retireWrite_27_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_28 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_28 <= _retireWrite_28_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_29 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_29 <= _retireWrite_29_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_30 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_30 <= _retireWrite_30_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 43:28]
      retireWrite_31 <= 1'h0; // @[AecSfuWarpUnit.scala 43:28]
    end else begin
      retireWrite_31 <= _retireWrite_31_T_3; // @[AecSfuWarpUnit.scala 76:47]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_0 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_0 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_1 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_1 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_2 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_2 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_3 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_3 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_4 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_4 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_5 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_5 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_6 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_6 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
    end
    if (reset) begin // @[AecSfuWarpUnit.scala 48:30]
      armClusters_7 <= 1'h0; // @[AecSfuWarpUnit.scala 48:30]
    end else begin
      armClusters_7 <= armCapture; // @[AecSfuWarpUnit.scala 49:27]
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
  _RAND_2 = {1{`RANDOM}};
  laneGroup_0 = _RAND_2[4:0];
  _RAND_3 = {2{`RANDOM}};
  results_0 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  results_1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  results_2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  results_3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  results_4 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  results_5 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  results_6 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  results_7 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  results_8 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  results_9 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  results_10 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  results_11 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  results_12 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  results_13 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  results_14 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  results_15 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  results_16 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  results_17 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  results_18 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  results_19 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  results_20 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  results_21 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  results_22 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  results_23 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  results_24 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  results_25 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  results_26 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  results_27 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  results_28 = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  results_29 = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  results_30 = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  results_31 = _RAND_34[63:0];
  _RAND_35 = {1{`RANDOM}};
  errors = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  flags_0 = _RAND_36[4:0];
  _RAND_37 = {1{`RANDOM}};
  flags_1 = _RAND_37[4:0];
  _RAND_38 = {1{`RANDOM}};
  flags_2 = _RAND_38[4:0];
  _RAND_39 = {1{`RANDOM}};
  flags_3 = _RAND_39[4:0];
  _RAND_40 = {1{`RANDOM}};
  flags_4 = _RAND_40[4:0];
  _RAND_41 = {1{`RANDOM}};
  flags_5 = _RAND_41[4:0];
  _RAND_42 = {1{`RANDOM}};
  flags_6 = _RAND_42[4:0];
  _RAND_43 = {1{`RANDOM}};
  flags_7 = _RAND_43[4:0];
  _RAND_44 = {1{`RANDOM}};
  flags_8 = _RAND_44[4:0];
  _RAND_45 = {1{`RANDOM}};
  flags_9 = _RAND_45[4:0];
  _RAND_46 = {1{`RANDOM}};
  flags_10 = _RAND_46[4:0];
  _RAND_47 = {1{`RANDOM}};
  flags_11 = _RAND_47[4:0];
  _RAND_48 = {1{`RANDOM}};
  flags_12 = _RAND_48[4:0];
  _RAND_49 = {1{`RANDOM}};
  flags_13 = _RAND_49[4:0];
  _RAND_50 = {1{`RANDOM}};
  flags_14 = _RAND_50[4:0];
  _RAND_51 = {1{`RANDOM}};
  flags_15 = _RAND_51[4:0];
  _RAND_52 = {1{`RANDOM}};
  flags_16 = _RAND_52[4:0];
  _RAND_53 = {1{`RANDOM}};
  flags_17 = _RAND_53[4:0];
  _RAND_54 = {1{`RANDOM}};
  flags_18 = _RAND_54[4:0];
  _RAND_55 = {1{`RANDOM}};
  flags_19 = _RAND_55[4:0];
  _RAND_56 = {1{`RANDOM}};
  flags_20 = _RAND_56[4:0];
  _RAND_57 = {1{`RANDOM}};
  flags_21 = _RAND_57[4:0];
  _RAND_58 = {1{`RANDOM}};
  flags_22 = _RAND_58[4:0];
  _RAND_59 = {1{`RANDOM}};
  flags_23 = _RAND_59[4:0];
  _RAND_60 = {1{`RANDOM}};
  flags_24 = _RAND_60[4:0];
  _RAND_61 = {1{`RANDOM}};
  flags_25 = _RAND_61[4:0];
  _RAND_62 = {1{`RANDOM}};
  flags_26 = _RAND_62[4:0];
  _RAND_63 = {1{`RANDOM}};
  flags_27 = _RAND_63[4:0];
  _RAND_64 = {1{`RANDOM}};
  flags_28 = _RAND_64[4:0];
  _RAND_65 = {1{`RANDOM}};
  flags_29 = _RAND_65[4:0];
  _RAND_66 = {1{`RANDOM}};
  flags_30 = _RAND_66[4:0];
  _RAND_67 = {1{`RANDOM}};
  flags_31 = _RAND_67[4:0];
  _RAND_68 = {1{`RANDOM}};
  writeMask = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  retireWrite_0 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  retireWrite_1 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  retireWrite_2 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  retireWrite_3 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  retireWrite_4 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  retireWrite_5 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  retireWrite_6 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  retireWrite_7 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  retireWrite_8 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  retireWrite_9 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  retireWrite_10 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  retireWrite_11 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  retireWrite_12 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  retireWrite_13 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  retireWrite_14 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  retireWrite_15 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  retireWrite_16 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  retireWrite_17 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  retireWrite_18 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  retireWrite_19 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  retireWrite_20 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  retireWrite_21 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  retireWrite_22 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  retireWrite_23 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  retireWrite_24 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  retireWrite_25 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  retireWrite_26 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  retireWrite_27 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  retireWrite_28 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  retireWrite_29 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  retireWrite_30 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  retireWrite_31 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  armClusters_0 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  armClusters_1 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  armClusters_2 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  armClusters_3 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  armClusters_4 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  armClusters_5 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  armClusters_6 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  armClusters_7 = _RAND_108[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
