module NaiveMultiplier(
  input          clock,
  input  [53:0]  io_a,
  input  [53:0]  io_b,
  input          io_regEnables_0,
  output [107:0] io_result
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [53:0] io_result_r; // @[Reg.scala 19:16]
  reg [53:0] io_result_r_1; // @[Reg.scala 19:16]
  assign io_result = io_result_r * io_result_r_1; // @[FMA.scala 18:50]
  always @(posedge clock) begin
    if (io_regEnables_0) begin // @[Reg.scala 20:18]
      io_result_r <= io_a; // @[Reg.scala 20:22]
    end
    if (io_regEnables_0) begin // @[Reg.scala 20:18]
      io_result_r_1 <= io_b; // @[Reg.scala 20:22]
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
  _RAND_0 = {2{`RANDOM}};
  io_result_r = _RAND_0[53:0];
  _RAND_1 = {2{`RANDOM}};
  io_result_r_1 = _RAND_1[53:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CLZ(
  input  [107:0] io_in,
  output [6:0]   io_out
);
  wire [6:0] _io_out_T_108 = io_in[1] ? 7'h6a : 7'h6b; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_109 = io_in[2] ? 7'h69 : _io_out_T_108; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_110 = io_in[3] ? 7'h68 : _io_out_T_109; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_111 = io_in[4] ? 7'h67 : _io_out_T_110; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_112 = io_in[5] ? 7'h66 : _io_out_T_111; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_113 = io_in[6] ? 7'h65 : _io_out_T_112; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_114 = io_in[7] ? 7'h64 : _io_out_T_113; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_115 = io_in[8] ? 7'h63 : _io_out_T_114; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_116 = io_in[9] ? 7'h62 : _io_out_T_115; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_117 = io_in[10] ? 7'h61 : _io_out_T_116; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_118 = io_in[11] ? 7'h60 : _io_out_T_117; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_119 = io_in[12] ? 7'h5f : _io_out_T_118; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_120 = io_in[13] ? 7'h5e : _io_out_T_119; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_121 = io_in[14] ? 7'h5d : _io_out_T_120; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_122 = io_in[15] ? 7'h5c : _io_out_T_121; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_123 = io_in[16] ? 7'h5b : _io_out_T_122; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_124 = io_in[17] ? 7'h5a : _io_out_T_123; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_125 = io_in[18] ? 7'h59 : _io_out_T_124; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_126 = io_in[19] ? 7'h58 : _io_out_T_125; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_127 = io_in[20] ? 7'h57 : _io_out_T_126; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_128 = io_in[21] ? 7'h56 : _io_out_T_127; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_129 = io_in[22] ? 7'h55 : _io_out_T_128; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_130 = io_in[23] ? 7'h54 : _io_out_T_129; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_131 = io_in[24] ? 7'h53 : _io_out_T_130; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_132 = io_in[25] ? 7'h52 : _io_out_T_131; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_133 = io_in[26] ? 7'h51 : _io_out_T_132; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_134 = io_in[27] ? 7'h50 : _io_out_T_133; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_135 = io_in[28] ? 7'h4f : _io_out_T_134; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_136 = io_in[29] ? 7'h4e : _io_out_T_135; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_137 = io_in[30] ? 7'h4d : _io_out_T_136; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_138 = io_in[31] ? 7'h4c : _io_out_T_137; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_139 = io_in[32] ? 7'h4b : _io_out_T_138; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_140 = io_in[33] ? 7'h4a : _io_out_T_139; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_141 = io_in[34] ? 7'h49 : _io_out_T_140; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_142 = io_in[35] ? 7'h48 : _io_out_T_141; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_143 = io_in[36] ? 7'h47 : _io_out_T_142; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_144 = io_in[37] ? 7'h46 : _io_out_T_143; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_145 = io_in[38] ? 7'h45 : _io_out_T_144; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_146 = io_in[39] ? 7'h44 : _io_out_T_145; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_147 = io_in[40] ? 7'h43 : _io_out_T_146; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_148 = io_in[41] ? 7'h42 : _io_out_T_147; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_149 = io_in[42] ? 7'h41 : _io_out_T_148; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_150 = io_in[43] ? 7'h40 : _io_out_T_149; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_151 = io_in[44] ? 7'h3f : _io_out_T_150; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_152 = io_in[45] ? 7'h3e : _io_out_T_151; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_153 = io_in[46] ? 7'h3d : _io_out_T_152; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_154 = io_in[47] ? 7'h3c : _io_out_T_153; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_155 = io_in[48] ? 7'h3b : _io_out_T_154; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_156 = io_in[49] ? 7'h3a : _io_out_T_155; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_157 = io_in[50] ? 7'h39 : _io_out_T_156; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_158 = io_in[51] ? 7'h38 : _io_out_T_157; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_159 = io_in[52] ? 7'h37 : _io_out_T_158; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_160 = io_in[53] ? 7'h36 : _io_out_T_159; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_161 = io_in[54] ? 7'h35 : _io_out_T_160; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_162 = io_in[55] ? 7'h34 : _io_out_T_161; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_163 = io_in[56] ? 7'h33 : _io_out_T_162; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_164 = io_in[57] ? 7'h32 : _io_out_T_163; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_165 = io_in[58] ? 7'h31 : _io_out_T_164; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_166 = io_in[59] ? 7'h30 : _io_out_T_165; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_167 = io_in[60] ? 7'h2f : _io_out_T_166; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_168 = io_in[61] ? 7'h2e : _io_out_T_167; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_169 = io_in[62] ? 7'h2d : _io_out_T_168; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_170 = io_in[63] ? 7'h2c : _io_out_T_169; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_171 = io_in[64] ? 7'h2b : _io_out_T_170; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_172 = io_in[65] ? 7'h2a : _io_out_T_171; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_173 = io_in[66] ? 7'h29 : _io_out_T_172; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_174 = io_in[67] ? 7'h28 : _io_out_T_173; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_175 = io_in[68] ? 7'h27 : _io_out_T_174; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_176 = io_in[69] ? 7'h26 : _io_out_T_175; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_177 = io_in[70] ? 7'h25 : _io_out_T_176; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_178 = io_in[71] ? 7'h24 : _io_out_T_177; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_179 = io_in[72] ? 7'h23 : _io_out_T_178; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_180 = io_in[73] ? 7'h22 : _io_out_T_179; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_181 = io_in[74] ? 7'h21 : _io_out_T_180; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_182 = io_in[75] ? 7'h20 : _io_out_T_181; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_183 = io_in[76] ? 7'h1f : _io_out_T_182; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_184 = io_in[77] ? 7'h1e : _io_out_T_183; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_185 = io_in[78] ? 7'h1d : _io_out_T_184; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_186 = io_in[79] ? 7'h1c : _io_out_T_185; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_187 = io_in[80] ? 7'h1b : _io_out_T_186; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_188 = io_in[81] ? 7'h1a : _io_out_T_187; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_189 = io_in[82] ? 7'h19 : _io_out_T_188; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_190 = io_in[83] ? 7'h18 : _io_out_T_189; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_191 = io_in[84] ? 7'h17 : _io_out_T_190; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_192 = io_in[85] ? 7'h16 : _io_out_T_191; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_193 = io_in[86] ? 7'h15 : _io_out_T_192; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_194 = io_in[87] ? 7'h14 : _io_out_T_193; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_195 = io_in[88] ? 7'h13 : _io_out_T_194; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_196 = io_in[89] ? 7'h12 : _io_out_T_195; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_197 = io_in[90] ? 7'h11 : _io_out_T_196; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_198 = io_in[91] ? 7'h10 : _io_out_T_197; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_199 = io_in[92] ? 7'hf : _io_out_T_198; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_200 = io_in[93] ? 7'he : _io_out_T_199; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_201 = io_in[94] ? 7'hd : _io_out_T_200; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_202 = io_in[95] ? 7'hc : _io_out_T_201; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_203 = io_in[96] ? 7'hb : _io_out_T_202; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_204 = io_in[97] ? 7'ha : _io_out_T_203; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_205 = io_in[98] ? 7'h9 : _io_out_T_204; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_206 = io_in[99] ? 7'h8 : _io_out_T_205; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_207 = io_in[100] ? 7'h7 : _io_out_T_206; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_208 = io_in[101] ? 7'h6 : _io_out_T_207; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_209 = io_in[102] ? 7'h5 : _io_out_T_208; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_210 = io_in[103] ? 7'h4 : _io_out_T_209; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_211 = io_in[104] ? 7'h3 : _io_out_T_210; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_212 = io_in[105] ? 7'h2 : _io_out_T_211; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_213 = io_in[106] ? 7'h1 : _io_out_T_212; // @[Mux.scala 47:70]
  assign io_out = io_in[107] ? 7'h0 : _io_out_T_213; // @[Mux.scala 47:70]
endmodule
module FMUL_s1(
  input  [63:0] io_a,
  input  [63:0] io_b,
  output        io_out_special_case_valid,
  output        io_out_special_case_bits_nan,
  output        io_out_special_case_bits_inf,
  output        io_out_special_case_bits_inv,
  output        io_out_special_case_bits_hasZero,
  output        io_out_early_overflow,
  output        io_out_prod_sign,
  output [11:0] io_out_shift_amt,
  output [11:0] io_out_exp_shifted,
  output        io_out_may_be_subnormal
);
  wire [107:0] lzc_clz_io_in; // @[CLZ.scala 22:21]
  wire [6:0] lzc_clz_io_out; // @[CLZ.scala 22:21]
  wire  fp_a_sign = io_a[63]; // @[package.scala 59:19]
  wire [10:0] fp_a_exp = io_a[62:52]; // @[package.scala 60:18]
  wire [51:0] fp_a_sig = io_a[51:0]; // @[package.scala 61:18]
  wire  fp_b_sign = io_b[63]; // @[package.scala 59:19]
  wire [10:0] fp_b_exp = io_b[62:52]; // @[package.scala 60:18]
  wire [51:0] fp_b_sig = io_b[51:0]; // @[package.scala 61:18]
  wire  expNotZero = |fp_a_exp; // @[package.scala 32:31]
  wire  expIsOnes = &fp_a_exp; // @[package.scala 33:31]
  wire  sigNotZero = |fp_a_sig; // @[package.scala 34:31]
  wire  decode_a_expIsZero = ~expNotZero; // @[package.scala 37:27]
  wire  decode_a_sigIsZero = ~sigNotZero; // @[package.scala 40:27]
  wire  decode_a_isInf = expIsOnes & decode_a_sigIsZero; // @[package.scala 42:40]
  wire  decode_a_isZero = decode_a_expIsZero & decode_a_sigIsZero; // @[package.scala 43:41]
  wire  decode_a_isNaN = expIsOnes & sigNotZero; // @[package.scala 44:40]
  wire  decode_a_isSNaN = decode_a_isNaN & ~fp_a_sig[51]; // @[package.scala 45:37]
  wire  expNotZero_1 = |fp_b_exp; // @[package.scala 32:31]
  wire  expIsOnes_1 = &fp_b_exp; // @[package.scala 33:31]
  wire  sigNotZero_1 = |fp_b_sig; // @[package.scala 34:31]
  wire  decode_b_expIsZero = ~expNotZero_1; // @[package.scala 37:27]
  wire  decode_b_sigIsZero = ~sigNotZero_1; // @[package.scala 40:27]
  wire  decode_b_isInf = expIsOnes_1 & decode_b_sigIsZero; // @[package.scala 42:40]
  wire  decode_b_isZero = decode_b_expIsZero & decode_b_sigIsZero; // @[package.scala 43:41]
  wire  decode_b_isNaN = expIsOnes_1 & sigNotZero_1; // @[package.scala 44:40]
  wire  decode_b_isSNaN = decode_b_isNaN & ~fp_b_sig[51]; // @[package.scala 45:37]
  wire [10:0] _GEN_0 = {{10'd0}, decode_a_expIsZero}; // @[package.scala 83:27]
  wire [10:0] raw_a_exp = fp_a_exp | _GEN_0; // @[package.scala 83:27]
  wire [52:0] raw_a_sig = {expNotZero,fp_a_sig}; // @[Cat.scala 33:92]
  wire [10:0] _GEN_1 = {{10'd0}, decode_b_expIsZero}; // @[package.scala 83:27]
  wire [10:0] raw_b_exp = fp_b_exp | _GEN_1; // @[package.scala 83:27]
  wire [52:0] raw_b_sig = {expNotZero_1,fp_b_sig}; // @[Cat.scala 33:92]
  wire [11:0] exp_sum = raw_a_exp + raw_b_exp; // @[FMUL.scala 80:27]
  wire [11:0] prod_exp = exp_sum - 12'h3c7; // @[FMUL.scala 81:26]
  wire [12:0] _shift_lim_sub_T = {1'h0,exp_sum}; // @[Cat.scala 33:92]
  wire [12:0] shift_lim_sub = _shift_lim_sub_T - 13'h3c8; // @[FMUL.scala 83:46]
  wire  prod_exp_uf = shift_lim_sub[12]; // @[FMUL.scala 84:39]
  wire [11:0] shift_lim = shift_lim_sub[11:0]; // @[FMUL.scala 85:37]
  wire [52:0] subnormal_sig = decode_a_expIsZero ? raw_a_sig : raw_b_sig; // @[FMUL.scala 90:26]
  wire [11:0] _GEN_2 = {{5'd0}, lzc_clz_io_out}; // @[FMUL.scala 92:30]
  wire  exceed_lim = shift_lim <= _GEN_2; // @[FMUL.scala 92:30]
  wire [11:0] _shift_amt_T = exceed_lim ? shift_lim : {{5'd0}, lzc_clz_io_out}; // @[FMUL.scala 93:44]
  wire [11:0] shift_amt = prod_exp_uf ? 12'h0 : _shift_amt_T; // @[FMUL.scala 93:22]
  wire  hasZero = decode_a_isZero | decode_b_isZero; // @[FMUL.scala 107:33]
  wire  hasNaN = decode_a_isNaN | decode_b_isNaN; // @[FMUL.scala 108:31]
  wire  hasSNaN = decode_a_isSNaN | decode_b_isSNaN; // @[FMUL.scala 109:33]
  wire  hasInf = decode_a_isInf | decode_b_isInf; // @[FMUL.scala 110:31]
  wire  zero_mul_inf = hasZero & hasInf; // @[FMUL.scala 113:30]
  CLZ lzc_clz ( // @[CLZ.scala 22:21]
    .io_in(lzc_clz_io_in),
    .io_out(lzc_clz_io_out)
  );
  assign io_out_special_case_valid = hasZero | hasNaN | hasInf; // @[FMUL.scala 111:47]
  assign io_out_special_case_bits_nan = hasNaN | zero_mul_inf; // @[FMUL.scala 114:27]
  assign io_out_special_case_bits_inf = decode_a_isInf | decode_b_isInf; // @[FMUL.scala 110:31]
  assign io_out_special_case_bits_inv = hasSNaN | zero_mul_inf; // @[FMUL.scala 115:28]
  assign io_out_special_case_bits_hasZero = decode_a_isZero | decode_b_isZero; // @[FMUL.scala 107:33]
  assign io_out_early_overflow = exp_sum > 12'hbfd; // @[FMUL.scala 87:29]
  assign io_out_prod_sign = fp_a_sign ^ fp_b_sign; // @[FMUL.scala 63:29]
  assign io_out_shift_amt = prod_exp_uf ? 12'h0 : _shift_amt_T; // @[FMUL.scala 93:22]
  assign io_out_exp_shifted = prod_exp - shift_amt; // @[FMUL.scala 95:30]
  assign io_out_may_be_subnormal = exceed_lim | prod_exp_uf; // @[FMUL.scala 101:41]
  assign lzc_clz_io_in = {55'h0,subnormal_sig}; // @[Cat.scala 33:92]
endmodule
module FMUL_s2(
  input          io_in_special_case_valid,
  input          io_in_special_case_bits_nan,
  input          io_in_special_case_bits_inf,
  input          io_in_special_case_bits_inv,
  input          io_in_special_case_bits_hasZero,
  input          io_in_early_overflow,
  input          io_in_prod_sign,
  input  [11:0]  io_in_shift_amt,
  input  [11:0]  io_in_exp_shifted,
  input          io_in_may_be_subnormal,
  input  [105:0] io_prod,
  output         io_out_special_case_valid,
  output         io_out_special_case_bits_nan,
  output         io_out_special_case_bits_inf,
  output         io_out_special_case_bits_inv,
  output         io_out_special_case_bits_hasZero,
  output         io_out_early_overflow,
  output [105:0] io_out_prod,
  output         io_out_prod_sign,
  output [11:0]  io_out_shift_amt,
  output [11:0]  io_out_exp_shifted,
  output         io_out_may_be_subnormal
);
  assign io_out_special_case_valid = io_in_special_case_valid; // @[FMUL.scala 132:23]
  assign io_out_special_case_bits_nan = io_in_special_case_bits_nan; // @[FMUL.scala 132:23]
  assign io_out_special_case_bits_inf = io_in_special_case_bits_inf; // @[FMUL.scala 132:23]
  assign io_out_special_case_bits_inv = io_in_special_case_bits_inv; // @[FMUL.scala 132:23]
  assign io_out_special_case_bits_hasZero = io_in_special_case_bits_hasZero; // @[FMUL.scala 132:23]
  assign io_out_early_overflow = io_in_early_overflow; // @[FMUL.scala 133:25]
  assign io_out_prod = io_prod; // @[FMUL.scala 139:15]
  assign io_out_prod_sign = io_in_prod_sign; // @[FMUL.scala 134:20]
  assign io_out_shift_amt = io_in_shift_amt; // @[FMUL.scala 135:20]
  assign io_out_exp_shifted = io_in_exp_shifted; // @[FMUL.scala 136:22]
  assign io_out_may_be_subnormal = io_in_may_be_subnormal; // @[FMUL.scala 137:27]
endmodule
module RoundingUnit(
  input  [51:0] io_in,
  input         io_roundIn,
  input         io_stickyIn,
  input         io_signIn,
  input  [2:0]  io_rm,
  output [51:0] io_out,
  output        io_inexact,
  output        io_cout
);
  wire  g = io_in[0]; // @[RoundingUnit.scala 19:25]
  wire  inexact = io_roundIn | io_stickyIn; // @[RoundingUnit.scala 20:19]
  wire  _r_up_T_4 = io_roundIn & io_stickyIn | io_roundIn & ~io_stickyIn & g; // @[RoundingUnit.scala 25:24]
  wire  _r_up_T_6 = inexact & ~io_signIn; // @[RoundingUnit.scala 27:23]
  wire  _r_up_T_7 = inexact & io_signIn; // @[RoundingUnit.scala 28:23]
  wire  _r_up_T_11 = 3'h1 == io_rm ? 1'h0 : 3'h0 == io_rm & _r_up_T_4; // @[Mux.scala 81:58]
  wire  _r_up_T_13 = 3'h3 == io_rm ? _r_up_T_6 : _r_up_T_11; // @[Mux.scala 81:58]
  wire  _r_up_T_15 = 3'h2 == io_rm ? _r_up_T_7 : _r_up_T_13; // @[Mux.scala 81:58]
  wire  r_up = 3'h4 == io_rm ? io_roundIn : _r_up_T_15; // @[Mux.scala 81:58]
  wire [51:0] out_r_up = io_in + 52'h1; // @[RoundingUnit.scala 32:24]
  assign io_out = r_up ? out_r_up : io_in; // @[RoundingUnit.scala 33:16]
  assign io_inexact = io_roundIn | io_stickyIn; // @[RoundingUnit.scala 20:19]
  assign io_cout = r_up & &io_in; // @[RoundingUnit.scala 36:19]
endmodule
module TininessRounder(
  input         io_in_sign,
  input  [55:0] io_in_sig,
  input  [2:0]  io_rm,
  output        io_tininess
);
  wire [51:0] rounder_io_in; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_roundIn; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_stickyIn; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_signIn; // @[RoundingUnit.scala 44:25]
  wire [2:0] rounder_io_rm; // @[RoundingUnit.scala 44:25]
  wire [51:0] rounder_io_out; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_inexact; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_cout; // @[RoundingUnit.scala 44:25]
  wire  _tininess_T_5 = io_in_sig[55:54] == 2'h1 & ~rounder_io_cout; // @[RoundingUnit.scala 74:41]
  RoundingUnit rounder ( // @[RoundingUnit.scala 44:25]
    .io_in(rounder_io_in),
    .io_roundIn(rounder_io_roundIn),
    .io_stickyIn(rounder_io_stickyIn),
    .io_signIn(rounder_io_signIn),
    .io_rm(rounder_io_rm),
    .io_out(rounder_io_out),
    .io_inexact(rounder_io_inexact),
    .io_cout(rounder_io_cout)
  );
  assign io_tininess = io_in_sig[55:54] == 2'h0 | _tininess_T_5; // @[RoundingUnit.scala 73:53]
  assign rounder_io_in = io_in_sig[53:2]; // @[RoundingUnit.scala 45:33]
  assign rounder_io_roundIn = io_in_sig[1]; // @[RoundingUnit.scala 46:50]
  assign rounder_io_stickyIn = |io_in_sig[0]; // @[RoundingUnit.scala 47:54]
  assign rounder_io_signIn = io_in_sign; // @[RoundingUnit.scala 49:23]
  assign rounder_io_rm = io_rm; // @[RoundingUnit.scala 48:19]
endmodule
module FMUL_s3(
  input          io_in_special_case_valid,
  input          io_in_special_case_bits_nan,
  input          io_in_special_case_bits_inf,
  input          io_in_special_case_bits_inv,
  input          io_in_special_case_bits_hasZero,
  input          io_in_early_overflow,
  input  [105:0] io_in_prod,
  input          io_in_prod_sign,
  input  [11:0]  io_in_shift_amt,
  input  [11:0]  io_in_exp_shifted,
  input          io_in_may_be_subnormal,
  output [63:0]  io_result,
  output [4:0]   io_fflags,
  output         io_to_fadd_fp_prod_sign,
  output [10:0]  io_to_fadd_fp_prod_exp,
  output [104:0] io_to_fadd_fp_prod_sig,
  output         io_to_fadd_inter_flags_isNaN,
  output         io_to_fadd_inter_flags_isInf,
  output         io_to_fadd_inter_flags_isInv,
  output         io_to_fadd_inter_flags_overflow,
  output         io_to_fadd_inter_flags_prod_sign
);
  wire  tininess_rounder_io_in_sign; // @[FMUL.scala 184:32]
  wire [55:0] tininess_rounder_io_in_sig; // @[FMUL.scala 184:32]
  wire [2:0] tininess_rounder_io_rm; // @[FMUL.scala 184:32]
  wire  tininess_rounder_io_tininess; // @[FMUL.scala 184:32]
  wire [51:0] rounder_io_in; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_roundIn; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_stickyIn; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_signIn; // @[RoundingUnit.scala 44:25]
  wire [2:0] rounder_io_rm; // @[RoundingUnit.scala 44:25]
  wire [51:0] rounder_io_out; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_inexact; // @[RoundingUnit.scala 44:25]
  wire  rounder_io_cout; // @[RoundingUnit.scala 44:25]
  wire [160:0] sig_shifter_in = {55'h0,io_in_prod}; // @[Cat.scala 33:92]
  wire [4255:0] _GEN_2 = {{4095'd0}, sig_shifter_in}; // @[FMUL.scala 172:41]
  wire [4255:0] _sig_shifted_raw_T = _GEN_2 << io_in_shift_amt; // @[FMUL.scala 172:41]
  wire [160:0] sig_shifted_raw = _sig_shifted_raw_T[160:0]; // @[FMUL.scala 172:54]
  wire  exp_is_subnormal = io_in_may_be_subnormal & ~sig_shifted_raw[160]; // @[FMUL.scala 173:49]
  wire  no_extra_shift = sig_shifted_raw[160] | exp_is_subnormal; // @[FMUL.scala 174:55]
  wire [11:0] _exp_pre_round_T_1 = io_in_exp_shifted - 12'h1; // @[FMUL.scala 176:95]
  wire [11:0] _exp_pre_round_T_2 = no_extra_shift ? io_in_exp_shifted : _exp_pre_round_T_1; // @[FMUL.scala 176:53]
  wire [11:0] exp_pre_round = exp_is_subnormal ? 12'h0 : _exp_pre_round_T_2; // @[FMUL.scala 176:26]
  wire [160:0] _sig_shifted_T_1 = {sig_shifted_raw[159:0],1'h0}; // @[Cat.scala 33:92]
  wire [160:0] sig_shifted = no_extra_shift ? sig_shifted_raw : _sig_shifted_T_1; // @[FMUL.scala 177:24]
  wire  _raw_in_sig_T_2 = |sig_shifted[105:0]; // @[FMUL.scala 182:86]
  wire [55:0] raw_in_sig = {sig_shifted[160:106],_raw_in_sig_T_2}; // @[Cat.scala 33:92]
  wire [10:0] raw_in_exp = exp_pre_round[10:0]; // @[FMUL.scala 179:20 181:14]
  wire [10:0] _GEN_0 = {{10'd0}, rounder_io_cout}; // @[FMUL.scala 196:37]
  wire [10:0] exp_rounded = _GEN_0 + raw_in_exp; // @[FMUL.scala 196:37]
  wire  _common_of_T = raw_in_exp == 11'h7fe; // @[FMUL.scala 201:16]
  wire  _common_of_T_1 = raw_in_exp == 11'h7ff; // @[FMUL.scala 202:16]
  wire  _common_of_T_2 = rounder_io_cout ? _common_of_T : _common_of_T_1; // @[FMUL.scala 199:22]
  wire  common_of = _common_of_T_2 | io_in_early_overflow; // @[FMUL.scala 203:5]
  wire  common_ix = rounder_io_inexact | common_of; // @[FMUL.scala 204:38]
  wire  common_uf = tininess_rounder_io_tininess & common_ix; // @[FMUL.scala 205:28]
  wire [10:0] common_exp = common_of ? 11'h7ff : exp_rounded; // @[FMUL.scala 213:23]
  wire [51:0] common_sig = common_of ? 52'h0 : rounder_io_out; // @[FMUL.scala 218:23]
  wire [63:0] common_result = {io_in_prod_sign,common_exp,common_sig}; // @[Cat.scala 33:92]
  wire [4:0] common_fflags = {2'h0,common_of,common_uf,common_ix}; // @[Cat.scala 33:92]
  wire [63:0] _special_result_T_2 = {io_in_prod_sign,11'h7ff,52'h0}; // @[Cat.scala 33:92]
  wire [63:0] _special_result_T_3 = {io_in_prod_sign,63'h0}; // @[Cat.scala 33:92]
  wire [63:0] _special_result_T_4 = io_in_special_case_bits_inf ? _special_result_T_2 : _special_result_T_3; // @[FMUL.scala 231:8]
  wire [63:0] special_result = io_in_special_case_bits_nan ? 64'h7ff8000000000000 : _special_result_T_4; // @[FMUL.scala 229:27]
  wire [4:0] special_fflags = {io_in_special_case_bits_inv,1'h0,1'h0,2'h0}; // @[Cat.scala 33:92]
  wire [11:0] _io_to_fadd_fp_prod_exp_T = io_in_special_case_bits_hasZero ? 12'h0 : exp_pre_round; // @[FMUL.scala 245:32]
  wire [104:0] _GEN_1 = {{104'd0}, |sig_shifted[54:0]}; // @[FMUL.scala 248:49]
  wire [104:0] _io_to_fadd_fp_prod_sig_T_4 = sig_shifted[159:55] | _GEN_1; // @[FMUL.scala 248:49]
  TininessRounder tininess_rounder ( // @[FMUL.scala 184:32]
    .io_in_sign(tininess_rounder_io_in_sign),
    .io_in_sig(tininess_rounder_io_in_sig),
    .io_rm(tininess_rounder_io_rm),
    .io_tininess(tininess_rounder_io_tininess)
  );
  RoundingUnit rounder ( // @[RoundingUnit.scala 44:25]
    .io_in(rounder_io_in),
    .io_roundIn(rounder_io_roundIn),
    .io_stickyIn(rounder_io_stickyIn),
    .io_signIn(rounder_io_signIn),
    .io_rm(rounder_io_rm),
    .io_out(rounder_io_out),
    .io_inexact(rounder_io_inexact),
    .io_cout(rounder_io_cout)
  );
  assign io_result = io_in_special_case_valid ? special_result : common_result; // @[FMUL.scala 241:19]
  assign io_fflags = io_in_special_case_valid ? special_fflags : common_fflags; // @[FMUL.scala 242:19]
  assign io_to_fadd_fp_prod_sign = io_in_prod_sign; // @[FMUL.scala 244:27]
  assign io_to_fadd_fp_prod_exp = _io_to_fadd_fp_prod_exp_T[10:0]; // @[FMUL.scala 245:26]
  assign io_to_fadd_fp_prod_sig = io_in_special_case_bits_hasZero ? 105'h0 : _io_to_fadd_fp_prod_sig_T_4; // @[FMUL.scala 246:32]
  assign io_to_fadd_inter_flags_isNaN = io_in_special_case_bits_nan; // @[FMUL.scala 252:32]
  assign io_to_fadd_inter_flags_isInf = io_in_special_case_bits_inf & ~io_in_special_case_bits_nan; // @[FMUL.scala 251:57]
  assign io_to_fadd_inter_flags_isInv = io_in_special_case_bits_inv; // @[FMUL.scala 250:32]
  assign io_to_fadd_inter_flags_overflow = exp_pre_round > 12'h7ff; // @[FMUL.scala 253:52]
  assign io_to_fadd_inter_flags_prod_sign = io_in_prod_sign; // @[FMUL.scala 254:36]
  assign tininess_rounder_io_in_sign = io_in_prod_sign; // @[FMUL.scala 179:20 180:15]
  assign tininess_rounder_io_in_sig = {sig_shifted[160:106],_raw_in_sig_T_2}; // @[Cat.scala 33:92]
  assign tininess_rounder_io_rm = 3'h0; // @[FMUL.scala 186:26]
  assign rounder_io_in = raw_in_sig[54:3]; // @[RoundingUnit.scala 45:33]
  assign rounder_io_roundIn = raw_in_sig[2]; // @[RoundingUnit.scala 46:50]
  assign rounder_io_stickyIn = |raw_in_sig[1:0]; // @[RoundingUnit.scala 47:54]
  assign rounder_io_signIn = io_in_prod_sign; // @[FMUL.scala 179:20 180:15]
  assign rounder_io_rm = 3'h0; // @[RoundingUnit.scala 48:19]
endmodule
module FMULPipe(
  input          clock,
  input          reset,
  output         io_in_ready,
  input          io_in_valid,
  input  [2:0]   io_in_bits_op,
  input  [63:0]  io_in_bits_a,
  input  [63:0]  io_in_bits_b,
  input  [63:0]  io_in_bits_c,
  input  [5:0]   io_in_bits_ctrl_seq,
  input  [7:0]   io_in_bits_ctrl_dest,
  input  [3:0]   io_in_bits_ctrl_dtype,
  input          io_in_bits_ctrl_finite_fma,
  input          io_in_bits_ctrl_fma_sign,
  input          io_out_ready,
  output         io_out_valid,
  output [63:0]  io_out_bits_result,
  output [4:0]   io_out_bits_fflags,
  output [5:0]   io_out_bits_ctrl_seq,
  output [7:0]   io_out_bits_ctrl_dest,
  output [3:0]   io_out_bits_ctrl_dtype,
  output         io_out_bits_ctrl_finite_fma,
  output         io_out_bits_ctrl_fma_sign,
  output         toAdd_mulOutput_fp_prod_sign,
  output [10:0]  toAdd_mulOutput_fp_prod_exp,
  output [104:0] toAdd_mulOutput_fp_prod_sig,
  output         toAdd_mulOutput_inter_flags_isNaN,
  output         toAdd_mulOutput_inter_flags_isInf,
  output         toAdd_mulOutput_inter_flags_isInv,
  output         toAdd_mulOutput_inter_flags_overflow,
  output         toAdd_mulOutput_inter_flags_prod_sign,
  output [63:0]  toAdd_addAnother,
  output [2:0]   toAdd_op,
  output [5:0]   toAdd_ctrl_seq,
  output [7:0]   toAdd_ctrl_dest,
  output [3:0]   toAdd_ctrl_dtype,
  output         toAdd_ctrl_finite_fma,
  output         toAdd_ctrl_fma_sign
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
  reg [127:0] _RAND_18;
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
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
`endif // RANDOMIZE_REG_INIT
  wire  multiplier_clock; // @[FMA.scala 39:26]
  wire [53:0] multiplier_io_a; // @[FMA.scala 39:26]
  wire [53:0] multiplier_io_b; // @[FMA.scala 39:26]
  wire  multiplier_io_regEnables_0; // @[FMA.scala 39:26]
  wire [107:0] multiplier_io_result; // @[FMA.scala 39:26]
  wire [63:0] s1_io_a; // @[FMA.scala 40:18]
  wire [63:0] s1_io_b; // @[FMA.scala 40:18]
  wire  s1_io_out_special_case_valid; // @[FMA.scala 40:18]
  wire  s1_io_out_special_case_bits_nan; // @[FMA.scala 40:18]
  wire  s1_io_out_special_case_bits_inf; // @[FMA.scala 40:18]
  wire  s1_io_out_special_case_bits_inv; // @[FMA.scala 40:18]
  wire  s1_io_out_special_case_bits_hasZero; // @[FMA.scala 40:18]
  wire  s1_io_out_early_overflow; // @[FMA.scala 40:18]
  wire  s1_io_out_prod_sign; // @[FMA.scala 40:18]
  wire [11:0] s1_io_out_shift_amt; // @[FMA.scala 40:18]
  wire [11:0] s1_io_out_exp_shifted; // @[FMA.scala 40:18]
  wire  s1_io_out_may_be_subnormal; // @[FMA.scala 40:18]
  wire  s2_io_in_special_case_valid; // @[FMA.scala 41:18]
  wire  s2_io_in_special_case_bits_nan; // @[FMA.scala 41:18]
  wire  s2_io_in_special_case_bits_inf; // @[FMA.scala 41:18]
  wire  s2_io_in_special_case_bits_inv; // @[FMA.scala 41:18]
  wire  s2_io_in_special_case_bits_hasZero; // @[FMA.scala 41:18]
  wire  s2_io_in_early_overflow; // @[FMA.scala 41:18]
  wire  s2_io_in_prod_sign; // @[FMA.scala 41:18]
  wire [11:0] s2_io_in_shift_amt; // @[FMA.scala 41:18]
  wire [11:0] s2_io_in_exp_shifted; // @[FMA.scala 41:18]
  wire  s2_io_in_may_be_subnormal; // @[FMA.scala 41:18]
  wire [105:0] s2_io_prod; // @[FMA.scala 41:18]
  wire  s2_io_out_special_case_valid; // @[FMA.scala 41:18]
  wire  s2_io_out_special_case_bits_nan; // @[FMA.scala 41:18]
  wire  s2_io_out_special_case_bits_inf; // @[FMA.scala 41:18]
  wire  s2_io_out_special_case_bits_inv; // @[FMA.scala 41:18]
  wire  s2_io_out_special_case_bits_hasZero; // @[FMA.scala 41:18]
  wire  s2_io_out_early_overflow; // @[FMA.scala 41:18]
  wire [105:0] s2_io_out_prod; // @[FMA.scala 41:18]
  wire  s2_io_out_prod_sign; // @[FMA.scala 41:18]
  wire [11:0] s2_io_out_shift_amt; // @[FMA.scala 41:18]
  wire [11:0] s2_io_out_exp_shifted; // @[FMA.scala 41:18]
  wire  s2_io_out_may_be_subnormal; // @[FMA.scala 41:18]
  wire  s3_io_in_special_case_valid; // @[FMA.scala 42:18]
  wire  s3_io_in_special_case_bits_nan; // @[FMA.scala 42:18]
  wire  s3_io_in_special_case_bits_inf; // @[FMA.scala 42:18]
  wire  s3_io_in_special_case_bits_inv; // @[FMA.scala 42:18]
  wire  s3_io_in_special_case_bits_hasZero; // @[FMA.scala 42:18]
  wire  s3_io_in_early_overflow; // @[FMA.scala 42:18]
  wire [105:0] s3_io_in_prod; // @[FMA.scala 42:18]
  wire  s3_io_in_prod_sign; // @[FMA.scala 42:18]
  wire [11:0] s3_io_in_shift_amt; // @[FMA.scala 42:18]
  wire [11:0] s3_io_in_exp_shifted; // @[FMA.scala 42:18]
  wire  s3_io_in_may_be_subnormal; // @[FMA.scala 42:18]
  wire [63:0] s3_io_result; // @[FMA.scala 42:18]
  wire [4:0] s3_io_fflags; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_fp_prod_sign; // @[FMA.scala 42:18]
  wire [10:0] s3_io_to_fadd_fp_prod_exp; // @[FMA.scala 42:18]
  wire [104:0] s3_io_to_fadd_fp_prod_sig; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_inter_flags_isNaN; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_inter_flags_isInf; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_inter_flags_isInv; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_inter_flags_overflow; // @[FMA.scala 42:18]
  wire  s3_io_to_fadd_inter_flags_prod_sign; // @[FMA.scala 42:18]
  reg  REG; // @[HasPipelineReg.scala 16:58]
  reg  REG_1; // @[HasPipelineReg.scala 16:58]
  wire  _T_2 = ~io_out_ready & (REG & REG_1); // @[HasPipelineReg.scala 18:26]
  wire  _T_3 = ~(~io_out_ready & (REG & REG_1)); // @[HasPipelineReg.scala 18:10]
  wire  _T_6 = ~(~io_out_ready & REG_1); // @[HasPipelineReg.scala 18:10]
  wire [5:0] _GEN_41 = {{3'd0}, io_in_bits_op}; // @[FPUOps.scala 94:36]
  wire  invProd = io_in_bits_op == 3'h7 | _GEN_41 == 6'h6; // @[FPUOps.scala 94:30]
  wire  _s1_io_b_T_1 = ~io_in_bits_b[63]; // @[FPUSubModule.scala 76:9]
  wire [63:0] _s1_io_b_T_3 = {_s1_io_b_T_1,io_in_bits_b[62:0]}; // @[Cat.scala 33:92]
  wire  _s2_io_in_T_4 = io_in_valid & _T_3; // @[HasPipelineReg.scala 26:79]
  reg  s2_io_in_r_special_case_valid; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_nan; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_inf; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_inv; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_hasZero; // @[Reg.scala 19:16]
  reg  s2_io_in_r_early_overflow; // @[Reg.scala 19:16]
  reg  s2_io_in_r_prod_sign; // @[Reg.scala 19:16]
  reg [11:0] s2_io_in_r_shift_amt; // @[Reg.scala 19:16]
  reg [11:0] s2_io_in_r_exp_shifted; // @[Reg.scala 19:16]
  reg  s2_io_in_r_may_be_subnormal; // @[Reg.scala 19:16]
  wire  _s3_io_in_T_3 = REG & _T_6; // @[HasPipelineReg.scala 26:79]
  reg  s3_io_in_r_special_case_valid; // @[Reg.scala 19:16]
  reg  s3_io_in_r_special_case_bits_nan; // @[Reg.scala 19:16]
  reg  s3_io_in_r_special_case_bits_inf; // @[Reg.scala 19:16]
  reg  s3_io_in_r_special_case_bits_inv; // @[Reg.scala 19:16]
  reg  s3_io_in_r_special_case_bits_hasZero; // @[Reg.scala 19:16]
  reg  s3_io_in_r_early_overflow; // @[Reg.scala 19:16]
  reg [105:0] s3_io_in_r_prod; // @[Reg.scala 19:16]
  reg  s3_io_in_r_prod_sign; // @[Reg.scala 19:16]
  reg [11:0] s3_io_in_r_shift_amt; // @[Reg.scala 19:16]
  reg [11:0] s3_io_in_r_exp_shifted; // @[Reg.scala 19:16]
  reg  s3_io_in_r_may_be_subnormal; // @[Reg.scala 19:16]
  wire [10:0] raw_a_fp_exp = s1_io_a[62:52]; // @[package.scala 60:18]
  wire [51:0] raw_a_fp_sig = s1_io_a[51:0]; // @[package.scala 61:18]
  wire  raw_a_raw_nz = |raw_a_fp_exp; // @[package.scala 81:72]
  wire [52:0] raw_a_sig = {raw_a_raw_nz,raw_a_fp_sig}; // @[Cat.scala 33:92]
  wire [10:0] raw_b_fp_exp = s1_io_b[62:52]; // @[package.scala 60:18]
  wire [51:0] raw_b_fp_sig = s1_io_b[51:0]; // @[package.scala 61:18]
  wire  raw_b_raw_nz = |raw_b_fp_exp; // @[package.scala 81:72]
  wire [52:0] raw_b_sig = {raw_b_raw_nz,raw_b_fp_sig}; // @[Cat.scala 33:92]
  reg [5:0] toAdd_ctrl_r_seq; // @[Reg.scala 19:16]
  reg [7:0] toAdd_ctrl_r_dest; // @[Reg.scala 19:16]
  reg [3:0] toAdd_ctrl_r_dtype; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_finite_fma; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_fma_sign; // @[Reg.scala 19:16]
  reg [5:0] toAdd_ctrl_r_1_seq; // @[Reg.scala 19:16]
  reg [7:0] toAdd_ctrl_r_1_dest; // @[Reg.scala 19:16]
  reg [3:0] toAdd_ctrl_r_1_dtype; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_1_finite_fma; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_1_fma_sign; // @[Reg.scala 19:16]
  reg [63:0] toAdd_addAnother_r; // @[Reg.scala 19:16]
  reg [63:0] toAdd_addAnother_r_1; // @[Reg.scala 19:16]
  reg [2:0] toAdd_op_r; // @[Reg.scala 19:16]
  reg [2:0] toAdd_op_r_1; // @[Reg.scala 19:16]
  NaiveMultiplier multiplier ( // @[FMA.scala 39:26]
    .clock(multiplier_clock),
    .io_a(multiplier_io_a),
    .io_b(multiplier_io_b),
    .io_regEnables_0(multiplier_io_regEnables_0),
    .io_result(multiplier_io_result)
  );
  FMUL_s1 s1 ( // @[FMA.scala 40:18]
    .io_a(s1_io_a),
    .io_b(s1_io_b),
    .io_out_special_case_valid(s1_io_out_special_case_valid),
    .io_out_special_case_bits_nan(s1_io_out_special_case_bits_nan),
    .io_out_special_case_bits_inf(s1_io_out_special_case_bits_inf),
    .io_out_special_case_bits_inv(s1_io_out_special_case_bits_inv),
    .io_out_special_case_bits_hasZero(s1_io_out_special_case_bits_hasZero),
    .io_out_early_overflow(s1_io_out_early_overflow),
    .io_out_prod_sign(s1_io_out_prod_sign),
    .io_out_shift_amt(s1_io_out_shift_amt),
    .io_out_exp_shifted(s1_io_out_exp_shifted),
    .io_out_may_be_subnormal(s1_io_out_may_be_subnormal)
  );
  FMUL_s2 s2 ( // @[FMA.scala 41:18]
    .io_in_special_case_valid(s2_io_in_special_case_valid),
    .io_in_special_case_bits_nan(s2_io_in_special_case_bits_nan),
    .io_in_special_case_bits_inf(s2_io_in_special_case_bits_inf),
    .io_in_special_case_bits_inv(s2_io_in_special_case_bits_inv),
    .io_in_special_case_bits_hasZero(s2_io_in_special_case_bits_hasZero),
    .io_in_early_overflow(s2_io_in_early_overflow),
    .io_in_prod_sign(s2_io_in_prod_sign),
    .io_in_shift_amt(s2_io_in_shift_amt),
    .io_in_exp_shifted(s2_io_in_exp_shifted),
    .io_in_may_be_subnormal(s2_io_in_may_be_subnormal),
    .io_prod(s2_io_prod),
    .io_out_special_case_valid(s2_io_out_special_case_valid),
    .io_out_special_case_bits_nan(s2_io_out_special_case_bits_nan),
    .io_out_special_case_bits_inf(s2_io_out_special_case_bits_inf),
    .io_out_special_case_bits_inv(s2_io_out_special_case_bits_inv),
    .io_out_special_case_bits_hasZero(s2_io_out_special_case_bits_hasZero),
    .io_out_early_overflow(s2_io_out_early_overflow),
    .io_out_prod(s2_io_out_prod),
    .io_out_prod_sign(s2_io_out_prod_sign),
    .io_out_shift_amt(s2_io_out_shift_amt),
    .io_out_exp_shifted(s2_io_out_exp_shifted),
    .io_out_may_be_subnormal(s2_io_out_may_be_subnormal)
  );
  FMUL_s3 s3 ( // @[FMA.scala 42:18]
    .io_in_special_case_valid(s3_io_in_special_case_valid),
    .io_in_special_case_bits_nan(s3_io_in_special_case_bits_nan),
    .io_in_special_case_bits_inf(s3_io_in_special_case_bits_inf),
    .io_in_special_case_bits_inv(s3_io_in_special_case_bits_inv),
    .io_in_special_case_bits_hasZero(s3_io_in_special_case_bits_hasZero),
    .io_in_early_overflow(s3_io_in_early_overflow),
    .io_in_prod(s3_io_in_prod),
    .io_in_prod_sign(s3_io_in_prod_sign),
    .io_in_shift_amt(s3_io_in_shift_amt),
    .io_in_exp_shifted(s3_io_in_exp_shifted),
    .io_in_may_be_subnormal(s3_io_in_may_be_subnormal),
    .io_result(s3_io_result),
    .io_fflags(s3_io_fflags),
    .io_to_fadd_fp_prod_sign(s3_io_to_fadd_fp_prod_sign),
    .io_to_fadd_fp_prod_exp(s3_io_to_fadd_fp_prod_exp),
    .io_to_fadd_fp_prod_sig(s3_io_to_fadd_fp_prod_sig),
    .io_to_fadd_inter_flags_isNaN(s3_io_to_fadd_inter_flags_isNaN),
    .io_to_fadd_inter_flags_isInf(s3_io_to_fadd_inter_flags_isInf),
    .io_to_fadd_inter_flags_isInv(s3_io_to_fadd_inter_flags_isInv),
    .io_to_fadd_inter_flags_overflow(s3_io_to_fadd_inter_flags_overflow),
    .io_to_fadd_inter_flags_prod_sign(s3_io_to_fadd_inter_flags_prod_sign)
  );
  assign io_in_ready = ~_T_2; // @[HasPipelineReg.scala 38:18]
  assign io_out_valid = REG_1; // @[HasPipelineReg.scala 39:16]
  assign io_out_bits_result = s3_io_result; // @[FMA.scala 66:22]
  assign io_out_bits_fflags = s3_io_fflags; // @[FMA.scala 67:22]
  assign io_out_bits_ctrl_seq = toAdd_ctrl_seq; // @[FMA.scala 69:31]
  assign io_out_bits_ctrl_dest = toAdd_ctrl_dest; // @[FMA.scala 69:31]
  assign io_out_bits_ctrl_dtype = toAdd_ctrl_dtype; // @[FMA.scala 69:31]
  assign io_out_bits_ctrl_finite_fma = toAdd_ctrl_finite_fma; // @[FMA.scala 69:31]
  assign io_out_bits_ctrl_fma_sign = toAdd_ctrl_fma_sign; // @[FMA.scala 69:31]
  assign toAdd_mulOutput_fp_prod_sign = s3_io_to_fadd_fp_prod_sign; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_fp_prod_exp = s3_io_to_fadd_fp_prod_exp; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_fp_prod_sig = s3_io_to_fadd_fp_prod_sig; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_inter_flags_isNaN = s3_io_to_fadd_inter_flags_isNaN; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_inter_flags_isInf = s3_io_to_fadd_inter_flags_isInf; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_inter_flags_isInv = s3_io_to_fadd_inter_flags_isInv; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_inter_flags_overflow = s3_io_to_fadd_inter_flags_overflow; // @[FMA.scala 63:19]
  assign toAdd_mulOutput_inter_flags_prod_sign = s3_io_to_fadd_inter_flags_prod_sign; // @[FMA.scala 63:19]
  assign toAdd_addAnother = toAdd_addAnother_r_1; // @[FMA.scala 62:20]
  assign toAdd_op = toAdd_op_r_1; // @[FMA.scala 64:12]
  assign toAdd_ctrl_seq = toAdd_ctrl_r_1_seq; // @[FMA.scala 61:25]
  assign toAdd_ctrl_dest = toAdd_ctrl_r_1_dest; // @[FMA.scala 61:25]
  assign toAdd_ctrl_dtype = toAdd_ctrl_r_1_dtype; // @[FMA.scala 61:25]
  assign toAdd_ctrl_finite_fma = toAdd_ctrl_r_1_finite_fma; // @[FMA.scala 61:25]
  assign toAdd_ctrl_fma_sign = toAdd_ctrl_r_1_fma_sign; // @[FMA.scala 61:25]
  assign multiplier_clock = clock;
  assign multiplier_io_a = {{1'd0}, raw_a_sig}; // @[FMA.scala 57:19]
  assign multiplier_io_b = {{1'd0}, raw_b_sig}; // @[FMA.scala 58:19]
  assign multiplier_io_regEnables_0 = io_in_valid & _T_3; // @[HasPipelineReg.scala 23:47]
  assign s1_io_a = io_in_bits_a; // @[FMA.scala 46:11]
  assign s1_io_b = invProd ? _s1_io_b_T_3 : io_in_bits_b; // @[FMA.scala 47:17]
  assign s2_io_in_special_case_valid = s2_io_in_r_special_case_valid; // @[FMA.scala 50:12]
  assign s2_io_in_special_case_bits_nan = s2_io_in_r_special_case_bits_nan; // @[FMA.scala 50:12]
  assign s2_io_in_special_case_bits_inf = s2_io_in_r_special_case_bits_inf; // @[FMA.scala 50:12]
  assign s2_io_in_special_case_bits_inv = s2_io_in_r_special_case_bits_inv; // @[FMA.scala 50:12]
  assign s2_io_in_special_case_bits_hasZero = s2_io_in_r_special_case_bits_hasZero; // @[FMA.scala 50:12]
  assign s2_io_in_early_overflow = s2_io_in_r_early_overflow; // @[FMA.scala 50:12]
  assign s2_io_in_prod_sign = s2_io_in_r_prod_sign; // @[FMA.scala 50:12]
  assign s2_io_in_shift_amt = s2_io_in_r_shift_amt; // @[FMA.scala 50:12]
  assign s2_io_in_exp_shifted = s2_io_in_r_exp_shifted; // @[FMA.scala 50:12]
  assign s2_io_in_may_be_subnormal = s2_io_in_r_may_be_subnormal; // @[FMA.scala 50:12]
  assign s2_io_prod = multiplier_io_result[105:0]; // @[FMA.scala 51:14]
  assign s3_io_in_special_case_valid = s3_io_in_r_special_case_valid; // @[FMA.scala 52:12]
  assign s3_io_in_special_case_bits_nan = s3_io_in_r_special_case_bits_nan; // @[FMA.scala 52:12]
  assign s3_io_in_special_case_bits_inf = s3_io_in_r_special_case_bits_inf; // @[FMA.scala 52:12]
  assign s3_io_in_special_case_bits_inv = s3_io_in_r_special_case_bits_inv; // @[FMA.scala 52:12]
  assign s3_io_in_special_case_bits_hasZero = s3_io_in_r_special_case_bits_hasZero; // @[FMA.scala 52:12]
  assign s3_io_in_early_overflow = s3_io_in_r_early_overflow; // @[FMA.scala 52:12]
  assign s3_io_in_prod = s3_io_in_r_prod; // @[FMA.scala 52:12]
  assign s3_io_in_prod_sign = s3_io_in_r_prod_sign; // @[FMA.scala 52:12]
  assign s3_io_in_shift_amt = s3_io_in_r_shift_amt; // @[FMA.scala 52:12]
  assign s3_io_in_exp_shifted = s3_io_in_r_exp_shifted; // @[FMA.scala 52:12]
  assign s3_io_in_may_be_subnormal = s3_io_in_r_may_be_subnormal; // @[FMA.scala 52:12]
  always @(posedge clock) begin
    if (reset) begin // @[HasPipelineReg.scala 16:58]
      REG <= 1'h0; // @[HasPipelineReg.scala 16:58]
    end else if (~(~io_out_ready & (REG & REG_1))) begin // @[HasPipelineReg.scala 18:61]
      REG <= io_in_valid; // @[HasPipelineReg.scala 19:17]
    end
    if (reset) begin // @[HasPipelineReg.scala 16:58]
      REG_1 <= 1'h0; // @[HasPipelineReg.scala 16:58]
    end else if (~(~io_out_ready & REG_1)) begin // @[HasPipelineReg.scala 18:61]
      REG_1 <= REG; // @[HasPipelineReg.scala 19:17]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_valid <= s1_io_out_special_case_valid; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_nan <= s1_io_out_special_case_bits_nan; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_inf <= s1_io_out_special_case_bits_inf; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_inv <= s1_io_out_special_case_bits_inv; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_hasZero <= s1_io_out_special_case_bits_hasZero; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_early_overflow <= s1_io_out_early_overflow; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_prod_sign <= s1_io_out_prod_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_shift_amt <= s1_io_out_shift_amt; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_exp_shifted <= s1_io_out_exp_shifted; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      s2_io_in_r_may_be_subnormal <= s1_io_out_may_be_subnormal; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_special_case_valid <= s2_io_out_special_case_valid; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_special_case_bits_nan <= s2_io_out_special_case_bits_nan; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_special_case_bits_inf <= s2_io_out_special_case_bits_inf; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_special_case_bits_inv <= s2_io_out_special_case_bits_inv; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_special_case_bits_hasZero <= s2_io_out_special_case_bits_hasZero; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_early_overflow <= s2_io_out_early_overflow; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_prod <= s2_io_out_prod; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_prod_sign <= s2_io_out_prod_sign; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_shift_amt <= s2_io_out_shift_amt; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_exp_shifted <= s2_io_out_exp_shifted; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      s3_io_in_r_may_be_subnormal <= s2_io_out_may_be_subnormal; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_seq <= io_in_bits_ctrl_seq; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_dest <= io_in_bits_ctrl_dest; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_dtype <= io_in_bits_ctrl_dtype; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_finite_fma <= io_in_bits_ctrl_finite_fma; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_fma_sign <= io_in_bits_ctrl_fma_sign; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_1_seq <= toAdd_ctrl_r_seq; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_1_dest <= toAdd_ctrl_r_dest; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_1_dtype <= toAdd_ctrl_r_dtype; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_1_finite_fma <= toAdd_ctrl_r_finite_fma; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_ctrl_r_1_fma_sign <= toAdd_ctrl_r_fma_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_addAnother_r <= io_in_bits_c; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_addAnother_r_1 <= toAdd_addAnother_r; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_4) begin // @[Reg.scala 20:18]
      toAdd_op_r <= io_in_bits_op; // @[Reg.scala 20:22]
    end
    if (_s3_io_in_T_3) begin // @[Reg.scala 20:18]
      toAdd_op_r_1 <= toAdd_op_r; // @[Reg.scala 20:22]
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
  REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  REG_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  s2_io_in_r_special_case_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_nan = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_inf = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_inv = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_hasZero = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  s2_io_in_r_early_overflow = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  s2_io_in_r_prod_sign = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  s2_io_in_r_shift_amt = _RAND_9[11:0];
  _RAND_10 = {1{`RANDOM}};
  s2_io_in_r_exp_shifted = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  s2_io_in_r_may_be_subnormal = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  s3_io_in_r_special_case_valid = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  s3_io_in_r_special_case_bits_nan = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  s3_io_in_r_special_case_bits_inf = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  s3_io_in_r_special_case_bits_inv = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  s3_io_in_r_special_case_bits_hasZero = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  s3_io_in_r_early_overflow = _RAND_17[0:0];
  _RAND_18 = {4{`RANDOM}};
  s3_io_in_r_prod = _RAND_18[105:0];
  _RAND_19 = {1{`RANDOM}};
  s3_io_in_r_prod_sign = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  s3_io_in_r_shift_amt = _RAND_20[11:0];
  _RAND_21 = {1{`RANDOM}};
  s3_io_in_r_exp_shifted = _RAND_21[11:0];
  _RAND_22 = {1{`RANDOM}};
  s3_io_in_r_may_be_subnormal = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  toAdd_ctrl_r_seq = _RAND_23[5:0];
  _RAND_24 = {1{`RANDOM}};
  toAdd_ctrl_r_dest = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  toAdd_ctrl_r_dtype = _RAND_25[3:0];
  _RAND_26 = {1{`RANDOM}};
  toAdd_ctrl_r_finite_fma = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  toAdd_ctrl_r_fma_sign = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  toAdd_ctrl_r_1_seq = _RAND_28[5:0];
  _RAND_29 = {1{`RANDOM}};
  toAdd_ctrl_r_1_dest = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  toAdd_ctrl_r_1_dtype = _RAND_30[3:0];
  _RAND_31 = {1{`RANDOM}};
  toAdd_ctrl_r_1_finite_fma = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  toAdd_ctrl_r_1_fma_sign = _RAND_32[0:0];
  _RAND_33 = {2{`RANDOM}};
  toAdd_addAnother_r = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  toAdd_addAnother_r_1 = _RAND_34[63:0];
  _RAND_35 = {1{`RANDOM}};
  toAdd_op_r = _RAND_35[2:0];
  _RAND_36 = {1{`RANDOM}};
  toAdd_op_r_1 = _RAND_36[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ShiftRightJam(
  input  [107:0] io_in,
  input  [10:0]  io_shamt,
  output [107:0] io_out,
  output         io_sticky
);
  wire  exceed_max_shift = io_shamt > 11'h6c; // @[ShiftRightJam.scala 17:35]
  wire [6:0] shamt = io_shamt[6:0]; // @[ShiftRightJam.scala 18:23]
  wire [127:0] _sticky_mask_T = 128'h1 << shamt; // @[ShiftRightJam.scala 20:11]
  wire [127:0] _sticky_mask_T_2 = _sticky_mask_T - 128'h1; // @[ShiftRightJam.scala 20:30]
  wire [107:0] _sticky_mask_T_5 = exceed_max_shift ? 108'hfffffffffffffffffffffffffff : 108'h0; // @[Bitwise.scala 77:12]
  wire [107:0] sticky_mask = _sticky_mask_T_2[107:0] | _sticky_mask_T_5; // @[ShiftRightJam.scala 20:49]
  wire [107:0] _io_out_T = io_in >> io_shamt; // @[ShiftRightJam.scala 21:46]
  wire [107:0] _io_sticky_T = io_in & sticky_mask; // @[ShiftRightJam.scala 22:23]
  assign io_out = exceed_max_shift ? 108'h0 : _io_out_T; // @[ShiftRightJam.scala 21:16]
  assign io_sticky = |_io_sticky_T; // @[ShiftRightJam.scala 22:41]
endmodule
module FarPath(
  input          io_in_a_sign,
  input  [10:0]  io_in_a_exp,
  input  [105:0] io_in_a_sig,
  input  [105:0] io_in_b_sig,
  input  [10:0]  io_in_expDiff,
  input          io_in_effSub,
  input          io_in_smallAdd,
  output         io_out_result_sign,
  output [10:0]  io_out_result_exp,
  output [55:0]  io_out_result_sig
);
  wire [107:0] shiftRightJam_io_in; // @[ShiftRightJam.scala 27:31]
  wire [10:0] shiftRightJam_io_shamt; // @[ShiftRightJam.scala 27:31]
  wire [107:0] shiftRightJam_io_out; // @[ShiftRightJam.scala 27:31]
  wire  shiftRightJam_io_sticky; // @[ShiftRightJam.scala 27:31]
  wire [109:0] adder_in_sig_b = {1'h0,shiftRightJam_io_out,shiftRightJam_io_sticky}; // @[Cat.scala 33:92]
  wire [109:0] adder_in_sig_a = {1'h0,io_in_a_sig,3'h0}; // @[Cat.scala 33:92]
  wire [109:0] _adder_result_T = ~adder_in_sig_b; // @[FADD.scala 33:19]
  wire [109:0] _adder_result_T_1 = io_in_effSub ? _adder_result_T : adder_in_sig_b; // @[FADD.scala 33:10]
  wire [109:0] _adder_result_T_3 = adder_in_sig_a + _adder_result_T_1; // @[FADD.scala 32:20]
  wire [109:0] _GEN_0 = {{109'd0}, io_in_effSub}; // @[FADD.scala 33:61]
  wire [109:0] adder_result = _adder_result_T_3 + _GEN_0; // @[FADD.scala 33:61]
  wire [10:0] exp_a_plus_1 = io_in_a_exp + 11'h1; // @[FADD.scala 35:28]
  wire [10:0] exp_a_minus_1 = io_in_a_exp - 11'h1; // @[FADD.scala 36:29]
  wire  cout = adder_result[109]; // @[FADD.scala 38:31]
  wire  keep = adder_result[109:108] == 2'h1; // @[FADD.scala 39:35]
  wire  cancellation = adder_result[109:108] == 2'h0; // @[FADD.scala 40:43]
  wire  _far_path_sig_T = keep | io_in_smallAdd; // @[FADD.scala 43:20]
  wire  _far_path_sig_T_2 = cancellation & ~io_in_smallAdd; // @[FADD.scala 43:46]
  wire [55:0] _far_path_sig_T_6 = {adder_result[109:55],|adder_result[54:0]}; // @[FADD.scala 45:36]
  wire [55:0] _far_path_sig_T_11 = {adder_result[108:54],|adder_result[53:0]}; // @[FADD.scala 46:44]
  wire [55:0] _far_path_sig_T_16 = {adder_result[107:53],|adder_result[52:0]}; // @[FADD.scala 47:44]
  wire [55:0] _far_path_sig_T_17 = cout ? _far_path_sig_T_6 : 56'h0; // @[Mux.scala 27:73]
  wire [55:0] _far_path_sig_T_18 = _far_path_sig_T ? _far_path_sig_T_11 : 56'h0; // @[Mux.scala 27:73]
  wire [55:0] _far_path_sig_T_19 = _far_path_sig_T_2 ? _far_path_sig_T_16 : 56'h0; // @[Mux.scala 27:73]
  wire [55:0] _far_path_sig_T_20 = _far_path_sig_T_17 | _far_path_sig_T_18; // @[Mux.scala 27:73]
  wire [10:0] _far_path_exp_T = cout ? exp_a_plus_1 : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _far_path_exp_T_1 = keep ? io_in_a_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _far_path_exp_T_2 = cancellation ? exp_a_minus_1 : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _far_path_exp_T_3 = _far_path_exp_T | _far_path_exp_T_1; // @[Mux.scala 27:73]
  ShiftRightJam shiftRightJam ( // @[ShiftRightJam.scala 27:31]
    .io_in(shiftRightJam_io_in),
    .io_shamt(shiftRightJam_io_shamt),
    .io_out(shiftRightJam_io_out),
    .io_sticky(shiftRightJam_io_sticky)
  );
  assign io_out_result_sign = io_in_a_sign; // @[FADD.scala 56:20 57:15]
  assign io_out_result_exp = _far_path_exp_T_3 | _far_path_exp_T_2; // @[Mux.scala 27:73]
  assign io_out_result_sig = _far_path_sig_T_20 | _far_path_sig_T_19; // @[Mux.scala 27:73]
  assign shiftRightJam_io_in = {io_in_b_sig,2'h0}; // @[Cat.scala 33:92]
  assign shiftRightJam_io_shamt = io_in_expDiff; // @[ShiftRightJam.scala 29:28]
endmodule
module LZA(
  input  [106:0] io_a,
  input  [106:0] io_b,
  output [106:0] io_f
);
  wire  k_0 = ~io_a[0] & ~io_b[0]; // @[LZA.scala 19:21]
  wire  p_1 = io_a[1] ^ io_b[1]; // @[LZA.scala 18:18]
  wire  k_1 = ~io_a[1] & ~io_b[1]; // @[LZA.scala 19:21]
  wire  f_1 = p_1 ^ ~k_0; // @[LZA.scala 23:20]
  wire  p_2 = io_a[2] ^ io_b[2]; // @[LZA.scala 18:18]
  wire  k_2 = ~io_a[2] & ~io_b[2]; // @[LZA.scala 19:21]
  wire  f_2 = p_2 ^ ~k_1; // @[LZA.scala 23:20]
  wire  p_3 = io_a[3] ^ io_b[3]; // @[LZA.scala 18:18]
  wire  k_3 = ~io_a[3] & ~io_b[3]; // @[LZA.scala 19:21]
  wire  f_3 = p_3 ^ ~k_2; // @[LZA.scala 23:20]
  wire  p_4 = io_a[4] ^ io_b[4]; // @[LZA.scala 18:18]
  wire  k_4 = ~io_a[4] & ~io_b[4]; // @[LZA.scala 19:21]
  wire  f_4 = p_4 ^ ~k_3; // @[LZA.scala 23:20]
  wire  p_5 = io_a[5] ^ io_b[5]; // @[LZA.scala 18:18]
  wire  k_5 = ~io_a[5] & ~io_b[5]; // @[LZA.scala 19:21]
  wire  f_5 = p_5 ^ ~k_4; // @[LZA.scala 23:20]
  wire  p_6 = io_a[6] ^ io_b[6]; // @[LZA.scala 18:18]
  wire  k_6 = ~io_a[6] & ~io_b[6]; // @[LZA.scala 19:21]
  wire  f_6 = p_6 ^ ~k_5; // @[LZA.scala 23:20]
  wire  p_7 = io_a[7] ^ io_b[7]; // @[LZA.scala 18:18]
  wire  k_7 = ~io_a[7] & ~io_b[7]; // @[LZA.scala 19:21]
  wire  f_7 = p_7 ^ ~k_6; // @[LZA.scala 23:20]
  wire  p_8 = io_a[8] ^ io_b[8]; // @[LZA.scala 18:18]
  wire  k_8 = ~io_a[8] & ~io_b[8]; // @[LZA.scala 19:21]
  wire  f_8 = p_8 ^ ~k_7; // @[LZA.scala 23:20]
  wire  p_9 = io_a[9] ^ io_b[9]; // @[LZA.scala 18:18]
  wire  k_9 = ~io_a[9] & ~io_b[9]; // @[LZA.scala 19:21]
  wire  f_9 = p_9 ^ ~k_8; // @[LZA.scala 23:20]
  wire  p_10 = io_a[10] ^ io_b[10]; // @[LZA.scala 18:18]
  wire  k_10 = ~io_a[10] & ~io_b[10]; // @[LZA.scala 19:21]
  wire  f_10 = p_10 ^ ~k_9; // @[LZA.scala 23:20]
  wire  p_11 = io_a[11] ^ io_b[11]; // @[LZA.scala 18:18]
  wire  k_11 = ~io_a[11] & ~io_b[11]; // @[LZA.scala 19:21]
  wire  f_11 = p_11 ^ ~k_10; // @[LZA.scala 23:20]
  wire  p_12 = io_a[12] ^ io_b[12]; // @[LZA.scala 18:18]
  wire  k_12 = ~io_a[12] & ~io_b[12]; // @[LZA.scala 19:21]
  wire  f_12 = p_12 ^ ~k_11; // @[LZA.scala 23:20]
  wire  p_13 = io_a[13] ^ io_b[13]; // @[LZA.scala 18:18]
  wire  k_13 = ~io_a[13] & ~io_b[13]; // @[LZA.scala 19:21]
  wire  f_13 = p_13 ^ ~k_12; // @[LZA.scala 23:20]
  wire  p_14 = io_a[14] ^ io_b[14]; // @[LZA.scala 18:18]
  wire  k_14 = ~io_a[14] & ~io_b[14]; // @[LZA.scala 19:21]
  wire  f_14 = p_14 ^ ~k_13; // @[LZA.scala 23:20]
  wire  p_15 = io_a[15] ^ io_b[15]; // @[LZA.scala 18:18]
  wire  k_15 = ~io_a[15] & ~io_b[15]; // @[LZA.scala 19:21]
  wire  f_15 = p_15 ^ ~k_14; // @[LZA.scala 23:20]
  wire  p_16 = io_a[16] ^ io_b[16]; // @[LZA.scala 18:18]
  wire  k_16 = ~io_a[16] & ~io_b[16]; // @[LZA.scala 19:21]
  wire  f_16 = p_16 ^ ~k_15; // @[LZA.scala 23:20]
  wire  p_17 = io_a[17] ^ io_b[17]; // @[LZA.scala 18:18]
  wire  k_17 = ~io_a[17] & ~io_b[17]; // @[LZA.scala 19:21]
  wire  f_17 = p_17 ^ ~k_16; // @[LZA.scala 23:20]
  wire  p_18 = io_a[18] ^ io_b[18]; // @[LZA.scala 18:18]
  wire  k_18 = ~io_a[18] & ~io_b[18]; // @[LZA.scala 19:21]
  wire  f_18 = p_18 ^ ~k_17; // @[LZA.scala 23:20]
  wire  p_19 = io_a[19] ^ io_b[19]; // @[LZA.scala 18:18]
  wire  k_19 = ~io_a[19] & ~io_b[19]; // @[LZA.scala 19:21]
  wire  f_19 = p_19 ^ ~k_18; // @[LZA.scala 23:20]
  wire  p_20 = io_a[20] ^ io_b[20]; // @[LZA.scala 18:18]
  wire  k_20 = ~io_a[20] & ~io_b[20]; // @[LZA.scala 19:21]
  wire  f_20 = p_20 ^ ~k_19; // @[LZA.scala 23:20]
  wire  p_21 = io_a[21] ^ io_b[21]; // @[LZA.scala 18:18]
  wire  k_21 = ~io_a[21] & ~io_b[21]; // @[LZA.scala 19:21]
  wire  f_21 = p_21 ^ ~k_20; // @[LZA.scala 23:20]
  wire  p_22 = io_a[22] ^ io_b[22]; // @[LZA.scala 18:18]
  wire  k_22 = ~io_a[22] & ~io_b[22]; // @[LZA.scala 19:21]
  wire  f_22 = p_22 ^ ~k_21; // @[LZA.scala 23:20]
  wire  p_23 = io_a[23] ^ io_b[23]; // @[LZA.scala 18:18]
  wire  k_23 = ~io_a[23] & ~io_b[23]; // @[LZA.scala 19:21]
  wire  f_23 = p_23 ^ ~k_22; // @[LZA.scala 23:20]
  wire  p_24 = io_a[24] ^ io_b[24]; // @[LZA.scala 18:18]
  wire  k_24 = ~io_a[24] & ~io_b[24]; // @[LZA.scala 19:21]
  wire  f_24 = p_24 ^ ~k_23; // @[LZA.scala 23:20]
  wire  p_25 = io_a[25] ^ io_b[25]; // @[LZA.scala 18:18]
  wire  k_25 = ~io_a[25] & ~io_b[25]; // @[LZA.scala 19:21]
  wire  f_25 = p_25 ^ ~k_24; // @[LZA.scala 23:20]
  wire  p_26 = io_a[26] ^ io_b[26]; // @[LZA.scala 18:18]
  wire  k_26 = ~io_a[26] & ~io_b[26]; // @[LZA.scala 19:21]
  wire  f_26 = p_26 ^ ~k_25; // @[LZA.scala 23:20]
  wire  p_27 = io_a[27] ^ io_b[27]; // @[LZA.scala 18:18]
  wire  k_27 = ~io_a[27] & ~io_b[27]; // @[LZA.scala 19:21]
  wire  f_27 = p_27 ^ ~k_26; // @[LZA.scala 23:20]
  wire  p_28 = io_a[28] ^ io_b[28]; // @[LZA.scala 18:18]
  wire  k_28 = ~io_a[28] & ~io_b[28]; // @[LZA.scala 19:21]
  wire  f_28 = p_28 ^ ~k_27; // @[LZA.scala 23:20]
  wire  p_29 = io_a[29] ^ io_b[29]; // @[LZA.scala 18:18]
  wire  k_29 = ~io_a[29] & ~io_b[29]; // @[LZA.scala 19:21]
  wire  f_29 = p_29 ^ ~k_28; // @[LZA.scala 23:20]
  wire  p_30 = io_a[30] ^ io_b[30]; // @[LZA.scala 18:18]
  wire  k_30 = ~io_a[30] & ~io_b[30]; // @[LZA.scala 19:21]
  wire  f_30 = p_30 ^ ~k_29; // @[LZA.scala 23:20]
  wire  p_31 = io_a[31] ^ io_b[31]; // @[LZA.scala 18:18]
  wire  k_31 = ~io_a[31] & ~io_b[31]; // @[LZA.scala 19:21]
  wire  f_31 = p_31 ^ ~k_30; // @[LZA.scala 23:20]
  wire  p_32 = io_a[32] ^ io_b[32]; // @[LZA.scala 18:18]
  wire  k_32 = ~io_a[32] & ~io_b[32]; // @[LZA.scala 19:21]
  wire  f_32 = p_32 ^ ~k_31; // @[LZA.scala 23:20]
  wire  p_33 = io_a[33] ^ io_b[33]; // @[LZA.scala 18:18]
  wire  k_33 = ~io_a[33] & ~io_b[33]; // @[LZA.scala 19:21]
  wire  f_33 = p_33 ^ ~k_32; // @[LZA.scala 23:20]
  wire  p_34 = io_a[34] ^ io_b[34]; // @[LZA.scala 18:18]
  wire  k_34 = ~io_a[34] & ~io_b[34]; // @[LZA.scala 19:21]
  wire  f_34 = p_34 ^ ~k_33; // @[LZA.scala 23:20]
  wire  p_35 = io_a[35] ^ io_b[35]; // @[LZA.scala 18:18]
  wire  k_35 = ~io_a[35] & ~io_b[35]; // @[LZA.scala 19:21]
  wire  f_35 = p_35 ^ ~k_34; // @[LZA.scala 23:20]
  wire  p_36 = io_a[36] ^ io_b[36]; // @[LZA.scala 18:18]
  wire  k_36 = ~io_a[36] & ~io_b[36]; // @[LZA.scala 19:21]
  wire  f_36 = p_36 ^ ~k_35; // @[LZA.scala 23:20]
  wire  p_37 = io_a[37] ^ io_b[37]; // @[LZA.scala 18:18]
  wire  k_37 = ~io_a[37] & ~io_b[37]; // @[LZA.scala 19:21]
  wire  f_37 = p_37 ^ ~k_36; // @[LZA.scala 23:20]
  wire  p_38 = io_a[38] ^ io_b[38]; // @[LZA.scala 18:18]
  wire  k_38 = ~io_a[38] & ~io_b[38]; // @[LZA.scala 19:21]
  wire  f_38 = p_38 ^ ~k_37; // @[LZA.scala 23:20]
  wire  p_39 = io_a[39] ^ io_b[39]; // @[LZA.scala 18:18]
  wire  k_39 = ~io_a[39] & ~io_b[39]; // @[LZA.scala 19:21]
  wire  f_39 = p_39 ^ ~k_38; // @[LZA.scala 23:20]
  wire  p_40 = io_a[40] ^ io_b[40]; // @[LZA.scala 18:18]
  wire  k_40 = ~io_a[40] & ~io_b[40]; // @[LZA.scala 19:21]
  wire  f_40 = p_40 ^ ~k_39; // @[LZA.scala 23:20]
  wire  p_41 = io_a[41] ^ io_b[41]; // @[LZA.scala 18:18]
  wire  k_41 = ~io_a[41] & ~io_b[41]; // @[LZA.scala 19:21]
  wire  f_41 = p_41 ^ ~k_40; // @[LZA.scala 23:20]
  wire  p_42 = io_a[42] ^ io_b[42]; // @[LZA.scala 18:18]
  wire  k_42 = ~io_a[42] & ~io_b[42]; // @[LZA.scala 19:21]
  wire  f_42 = p_42 ^ ~k_41; // @[LZA.scala 23:20]
  wire  p_43 = io_a[43] ^ io_b[43]; // @[LZA.scala 18:18]
  wire  k_43 = ~io_a[43] & ~io_b[43]; // @[LZA.scala 19:21]
  wire  f_43 = p_43 ^ ~k_42; // @[LZA.scala 23:20]
  wire  p_44 = io_a[44] ^ io_b[44]; // @[LZA.scala 18:18]
  wire  k_44 = ~io_a[44] & ~io_b[44]; // @[LZA.scala 19:21]
  wire  f_44 = p_44 ^ ~k_43; // @[LZA.scala 23:20]
  wire  p_45 = io_a[45] ^ io_b[45]; // @[LZA.scala 18:18]
  wire  k_45 = ~io_a[45] & ~io_b[45]; // @[LZA.scala 19:21]
  wire  f_45 = p_45 ^ ~k_44; // @[LZA.scala 23:20]
  wire  p_46 = io_a[46] ^ io_b[46]; // @[LZA.scala 18:18]
  wire  k_46 = ~io_a[46] & ~io_b[46]; // @[LZA.scala 19:21]
  wire  f_46 = p_46 ^ ~k_45; // @[LZA.scala 23:20]
  wire  p_47 = io_a[47] ^ io_b[47]; // @[LZA.scala 18:18]
  wire  k_47 = ~io_a[47] & ~io_b[47]; // @[LZA.scala 19:21]
  wire  f_47 = p_47 ^ ~k_46; // @[LZA.scala 23:20]
  wire  p_48 = io_a[48] ^ io_b[48]; // @[LZA.scala 18:18]
  wire  k_48 = ~io_a[48] & ~io_b[48]; // @[LZA.scala 19:21]
  wire  f_48 = p_48 ^ ~k_47; // @[LZA.scala 23:20]
  wire  p_49 = io_a[49] ^ io_b[49]; // @[LZA.scala 18:18]
  wire  k_49 = ~io_a[49] & ~io_b[49]; // @[LZA.scala 19:21]
  wire  f_49 = p_49 ^ ~k_48; // @[LZA.scala 23:20]
  wire  p_50 = io_a[50] ^ io_b[50]; // @[LZA.scala 18:18]
  wire  k_50 = ~io_a[50] & ~io_b[50]; // @[LZA.scala 19:21]
  wire  f_50 = p_50 ^ ~k_49; // @[LZA.scala 23:20]
  wire  p_51 = io_a[51] ^ io_b[51]; // @[LZA.scala 18:18]
  wire  k_51 = ~io_a[51] & ~io_b[51]; // @[LZA.scala 19:21]
  wire  f_51 = p_51 ^ ~k_50; // @[LZA.scala 23:20]
  wire  p_52 = io_a[52] ^ io_b[52]; // @[LZA.scala 18:18]
  wire  k_52 = ~io_a[52] & ~io_b[52]; // @[LZA.scala 19:21]
  wire  f_52 = p_52 ^ ~k_51; // @[LZA.scala 23:20]
  wire  p_53 = io_a[53] ^ io_b[53]; // @[LZA.scala 18:18]
  wire  k_53 = ~io_a[53] & ~io_b[53]; // @[LZA.scala 19:21]
  wire  f_53 = p_53 ^ ~k_52; // @[LZA.scala 23:20]
  wire  p_54 = io_a[54] ^ io_b[54]; // @[LZA.scala 18:18]
  wire  k_54 = ~io_a[54] & ~io_b[54]; // @[LZA.scala 19:21]
  wire  f_54 = p_54 ^ ~k_53; // @[LZA.scala 23:20]
  wire  p_55 = io_a[55] ^ io_b[55]; // @[LZA.scala 18:18]
  wire  k_55 = ~io_a[55] & ~io_b[55]; // @[LZA.scala 19:21]
  wire  f_55 = p_55 ^ ~k_54; // @[LZA.scala 23:20]
  wire  p_56 = io_a[56] ^ io_b[56]; // @[LZA.scala 18:18]
  wire  k_56 = ~io_a[56] & ~io_b[56]; // @[LZA.scala 19:21]
  wire  f_56 = p_56 ^ ~k_55; // @[LZA.scala 23:20]
  wire  p_57 = io_a[57] ^ io_b[57]; // @[LZA.scala 18:18]
  wire  k_57 = ~io_a[57] & ~io_b[57]; // @[LZA.scala 19:21]
  wire  f_57 = p_57 ^ ~k_56; // @[LZA.scala 23:20]
  wire  p_58 = io_a[58] ^ io_b[58]; // @[LZA.scala 18:18]
  wire  k_58 = ~io_a[58] & ~io_b[58]; // @[LZA.scala 19:21]
  wire  f_58 = p_58 ^ ~k_57; // @[LZA.scala 23:20]
  wire  p_59 = io_a[59] ^ io_b[59]; // @[LZA.scala 18:18]
  wire  k_59 = ~io_a[59] & ~io_b[59]; // @[LZA.scala 19:21]
  wire  f_59 = p_59 ^ ~k_58; // @[LZA.scala 23:20]
  wire  p_60 = io_a[60] ^ io_b[60]; // @[LZA.scala 18:18]
  wire  k_60 = ~io_a[60] & ~io_b[60]; // @[LZA.scala 19:21]
  wire  f_60 = p_60 ^ ~k_59; // @[LZA.scala 23:20]
  wire  p_61 = io_a[61] ^ io_b[61]; // @[LZA.scala 18:18]
  wire  k_61 = ~io_a[61] & ~io_b[61]; // @[LZA.scala 19:21]
  wire  f_61 = p_61 ^ ~k_60; // @[LZA.scala 23:20]
  wire  p_62 = io_a[62] ^ io_b[62]; // @[LZA.scala 18:18]
  wire  k_62 = ~io_a[62] & ~io_b[62]; // @[LZA.scala 19:21]
  wire  f_62 = p_62 ^ ~k_61; // @[LZA.scala 23:20]
  wire  p_63 = io_a[63] ^ io_b[63]; // @[LZA.scala 18:18]
  wire  k_63 = ~io_a[63] & ~io_b[63]; // @[LZA.scala 19:21]
  wire  f_63 = p_63 ^ ~k_62; // @[LZA.scala 23:20]
  wire  p_64 = io_a[64] ^ io_b[64]; // @[LZA.scala 18:18]
  wire  k_64 = ~io_a[64] & ~io_b[64]; // @[LZA.scala 19:21]
  wire  f_64 = p_64 ^ ~k_63; // @[LZA.scala 23:20]
  wire  p_65 = io_a[65] ^ io_b[65]; // @[LZA.scala 18:18]
  wire  k_65 = ~io_a[65] & ~io_b[65]; // @[LZA.scala 19:21]
  wire  f_65 = p_65 ^ ~k_64; // @[LZA.scala 23:20]
  wire  p_66 = io_a[66] ^ io_b[66]; // @[LZA.scala 18:18]
  wire  k_66 = ~io_a[66] & ~io_b[66]; // @[LZA.scala 19:21]
  wire  f_66 = p_66 ^ ~k_65; // @[LZA.scala 23:20]
  wire  p_67 = io_a[67] ^ io_b[67]; // @[LZA.scala 18:18]
  wire  k_67 = ~io_a[67] & ~io_b[67]; // @[LZA.scala 19:21]
  wire  f_67 = p_67 ^ ~k_66; // @[LZA.scala 23:20]
  wire  p_68 = io_a[68] ^ io_b[68]; // @[LZA.scala 18:18]
  wire  k_68 = ~io_a[68] & ~io_b[68]; // @[LZA.scala 19:21]
  wire  f_68 = p_68 ^ ~k_67; // @[LZA.scala 23:20]
  wire  p_69 = io_a[69] ^ io_b[69]; // @[LZA.scala 18:18]
  wire  k_69 = ~io_a[69] & ~io_b[69]; // @[LZA.scala 19:21]
  wire  f_69 = p_69 ^ ~k_68; // @[LZA.scala 23:20]
  wire  p_70 = io_a[70] ^ io_b[70]; // @[LZA.scala 18:18]
  wire  k_70 = ~io_a[70] & ~io_b[70]; // @[LZA.scala 19:21]
  wire  f_70 = p_70 ^ ~k_69; // @[LZA.scala 23:20]
  wire  p_71 = io_a[71] ^ io_b[71]; // @[LZA.scala 18:18]
  wire  k_71 = ~io_a[71] & ~io_b[71]; // @[LZA.scala 19:21]
  wire  f_71 = p_71 ^ ~k_70; // @[LZA.scala 23:20]
  wire  p_72 = io_a[72] ^ io_b[72]; // @[LZA.scala 18:18]
  wire  k_72 = ~io_a[72] & ~io_b[72]; // @[LZA.scala 19:21]
  wire  f_72 = p_72 ^ ~k_71; // @[LZA.scala 23:20]
  wire  p_73 = io_a[73] ^ io_b[73]; // @[LZA.scala 18:18]
  wire  k_73 = ~io_a[73] & ~io_b[73]; // @[LZA.scala 19:21]
  wire  f_73 = p_73 ^ ~k_72; // @[LZA.scala 23:20]
  wire  p_74 = io_a[74] ^ io_b[74]; // @[LZA.scala 18:18]
  wire  k_74 = ~io_a[74] & ~io_b[74]; // @[LZA.scala 19:21]
  wire  f_74 = p_74 ^ ~k_73; // @[LZA.scala 23:20]
  wire  p_75 = io_a[75] ^ io_b[75]; // @[LZA.scala 18:18]
  wire  k_75 = ~io_a[75] & ~io_b[75]; // @[LZA.scala 19:21]
  wire  f_75 = p_75 ^ ~k_74; // @[LZA.scala 23:20]
  wire  p_76 = io_a[76] ^ io_b[76]; // @[LZA.scala 18:18]
  wire  k_76 = ~io_a[76] & ~io_b[76]; // @[LZA.scala 19:21]
  wire  f_76 = p_76 ^ ~k_75; // @[LZA.scala 23:20]
  wire  p_77 = io_a[77] ^ io_b[77]; // @[LZA.scala 18:18]
  wire  k_77 = ~io_a[77] & ~io_b[77]; // @[LZA.scala 19:21]
  wire  f_77 = p_77 ^ ~k_76; // @[LZA.scala 23:20]
  wire  p_78 = io_a[78] ^ io_b[78]; // @[LZA.scala 18:18]
  wire  k_78 = ~io_a[78] & ~io_b[78]; // @[LZA.scala 19:21]
  wire  f_78 = p_78 ^ ~k_77; // @[LZA.scala 23:20]
  wire  p_79 = io_a[79] ^ io_b[79]; // @[LZA.scala 18:18]
  wire  k_79 = ~io_a[79] & ~io_b[79]; // @[LZA.scala 19:21]
  wire  f_79 = p_79 ^ ~k_78; // @[LZA.scala 23:20]
  wire  p_80 = io_a[80] ^ io_b[80]; // @[LZA.scala 18:18]
  wire  k_80 = ~io_a[80] & ~io_b[80]; // @[LZA.scala 19:21]
  wire  f_80 = p_80 ^ ~k_79; // @[LZA.scala 23:20]
  wire  p_81 = io_a[81] ^ io_b[81]; // @[LZA.scala 18:18]
  wire  k_81 = ~io_a[81] & ~io_b[81]; // @[LZA.scala 19:21]
  wire  f_81 = p_81 ^ ~k_80; // @[LZA.scala 23:20]
  wire  p_82 = io_a[82] ^ io_b[82]; // @[LZA.scala 18:18]
  wire  k_82 = ~io_a[82] & ~io_b[82]; // @[LZA.scala 19:21]
  wire  f_82 = p_82 ^ ~k_81; // @[LZA.scala 23:20]
  wire  p_83 = io_a[83] ^ io_b[83]; // @[LZA.scala 18:18]
  wire  k_83 = ~io_a[83] & ~io_b[83]; // @[LZA.scala 19:21]
  wire  f_83 = p_83 ^ ~k_82; // @[LZA.scala 23:20]
  wire  p_84 = io_a[84] ^ io_b[84]; // @[LZA.scala 18:18]
  wire  k_84 = ~io_a[84] & ~io_b[84]; // @[LZA.scala 19:21]
  wire  f_84 = p_84 ^ ~k_83; // @[LZA.scala 23:20]
  wire  p_85 = io_a[85] ^ io_b[85]; // @[LZA.scala 18:18]
  wire  k_85 = ~io_a[85] & ~io_b[85]; // @[LZA.scala 19:21]
  wire  f_85 = p_85 ^ ~k_84; // @[LZA.scala 23:20]
  wire  p_86 = io_a[86] ^ io_b[86]; // @[LZA.scala 18:18]
  wire  k_86 = ~io_a[86] & ~io_b[86]; // @[LZA.scala 19:21]
  wire  f_86 = p_86 ^ ~k_85; // @[LZA.scala 23:20]
  wire  p_87 = io_a[87] ^ io_b[87]; // @[LZA.scala 18:18]
  wire  k_87 = ~io_a[87] & ~io_b[87]; // @[LZA.scala 19:21]
  wire  f_87 = p_87 ^ ~k_86; // @[LZA.scala 23:20]
  wire  p_88 = io_a[88] ^ io_b[88]; // @[LZA.scala 18:18]
  wire  k_88 = ~io_a[88] & ~io_b[88]; // @[LZA.scala 19:21]
  wire  f_88 = p_88 ^ ~k_87; // @[LZA.scala 23:20]
  wire  p_89 = io_a[89] ^ io_b[89]; // @[LZA.scala 18:18]
  wire  k_89 = ~io_a[89] & ~io_b[89]; // @[LZA.scala 19:21]
  wire  f_89 = p_89 ^ ~k_88; // @[LZA.scala 23:20]
  wire  p_90 = io_a[90] ^ io_b[90]; // @[LZA.scala 18:18]
  wire  k_90 = ~io_a[90] & ~io_b[90]; // @[LZA.scala 19:21]
  wire  f_90 = p_90 ^ ~k_89; // @[LZA.scala 23:20]
  wire  p_91 = io_a[91] ^ io_b[91]; // @[LZA.scala 18:18]
  wire  k_91 = ~io_a[91] & ~io_b[91]; // @[LZA.scala 19:21]
  wire  f_91 = p_91 ^ ~k_90; // @[LZA.scala 23:20]
  wire  p_92 = io_a[92] ^ io_b[92]; // @[LZA.scala 18:18]
  wire  k_92 = ~io_a[92] & ~io_b[92]; // @[LZA.scala 19:21]
  wire  f_92 = p_92 ^ ~k_91; // @[LZA.scala 23:20]
  wire  p_93 = io_a[93] ^ io_b[93]; // @[LZA.scala 18:18]
  wire  k_93 = ~io_a[93] & ~io_b[93]; // @[LZA.scala 19:21]
  wire  f_93 = p_93 ^ ~k_92; // @[LZA.scala 23:20]
  wire  p_94 = io_a[94] ^ io_b[94]; // @[LZA.scala 18:18]
  wire  k_94 = ~io_a[94] & ~io_b[94]; // @[LZA.scala 19:21]
  wire  f_94 = p_94 ^ ~k_93; // @[LZA.scala 23:20]
  wire  p_95 = io_a[95] ^ io_b[95]; // @[LZA.scala 18:18]
  wire  k_95 = ~io_a[95] & ~io_b[95]; // @[LZA.scala 19:21]
  wire  f_95 = p_95 ^ ~k_94; // @[LZA.scala 23:20]
  wire  p_96 = io_a[96] ^ io_b[96]; // @[LZA.scala 18:18]
  wire  k_96 = ~io_a[96] & ~io_b[96]; // @[LZA.scala 19:21]
  wire  f_96 = p_96 ^ ~k_95; // @[LZA.scala 23:20]
  wire  p_97 = io_a[97] ^ io_b[97]; // @[LZA.scala 18:18]
  wire  k_97 = ~io_a[97] & ~io_b[97]; // @[LZA.scala 19:21]
  wire  f_97 = p_97 ^ ~k_96; // @[LZA.scala 23:20]
  wire  p_98 = io_a[98] ^ io_b[98]; // @[LZA.scala 18:18]
  wire  k_98 = ~io_a[98] & ~io_b[98]; // @[LZA.scala 19:21]
  wire  f_98 = p_98 ^ ~k_97; // @[LZA.scala 23:20]
  wire  p_99 = io_a[99] ^ io_b[99]; // @[LZA.scala 18:18]
  wire  k_99 = ~io_a[99] & ~io_b[99]; // @[LZA.scala 19:21]
  wire  f_99 = p_99 ^ ~k_98; // @[LZA.scala 23:20]
  wire  p_100 = io_a[100] ^ io_b[100]; // @[LZA.scala 18:18]
  wire  k_100 = ~io_a[100] & ~io_b[100]; // @[LZA.scala 19:21]
  wire  f_100 = p_100 ^ ~k_99; // @[LZA.scala 23:20]
  wire  p_101 = io_a[101] ^ io_b[101]; // @[LZA.scala 18:18]
  wire  k_101 = ~io_a[101] & ~io_b[101]; // @[LZA.scala 19:21]
  wire  f_101 = p_101 ^ ~k_100; // @[LZA.scala 23:20]
  wire  p_102 = io_a[102] ^ io_b[102]; // @[LZA.scala 18:18]
  wire  k_102 = ~io_a[102] & ~io_b[102]; // @[LZA.scala 19:21]
  wire  f_102 = p_102 ^ ~k_101; // @[LZA.scala 23:20]
  wire  p_103 = io_a[103] ^ io_b[103]; // @[LZA.scala 18:18]
  wire  k_103 = ~io_a[103] & ~io_b[103]; // @[LZA.scala 19:21]
  wire  f_103 = p_103 ^ ~k_102; // @[LZA.scala 23:20]
  wire  p_104 = io_a[104] ^ io_b[104]; // @[LZA.scala 18:18]
  wire  k_104 = ~io_a[104] & ~io_b[104]; // @[LZA.scala 19:21]
  wire  f_104 = p_104 ^ ~k_103; // @[LZA.scala 23:20]
  wire  p_105 = io_a[105] ^ io_b[105]; // @[LZA.scala 18:18]
  wire  k_105 = ~io_a[105] & ~io_b[105]; // @[LZA.scala 19:21]
  wire  f_105 = p_105 ^ ~k_104; // @[LZA.scala 23:20]
  wire  p_106 = io_a[106] ^ io_b[106]; // @[LZA.scala 18:18]
  wire  f_106 = p_106 ^ ~k_105; // @[LZA.scala 23:20]
  wire [5:0] io_f_lo_lo_lo_lo = {f_5,f_4,f_3,f_2,f_1,1'h0}; // @[Cat.scala 33:92]
  wire [12:0] io_f_lo_lo_lo = {f_12,f_11,f_10,f_9,f_8,f_7,f_6,io_f_lo_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] io_f_lo_lo_hi_lo = {f_18,f_17,f_16,f_15,f_14,f_13}; // @[Cat.scala 33:92]
  wire [25:0] io_f_lo_lo = {f_25,f_24,f_23,f_22,f_21,f_20,f_19,io_f_lo_lo_hi_lo,io_f_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] io_f_lo_hi_lo_lo = {f_31,f_30,f_29,f_28,f_27,f_26}; // @[Cat.scala 33:92]
  wire [12:0] io_f_lo_hi_lo = {f_38,f_37,f_36,f_35,f_34,f_33,f_32,io_f_lo_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] io_f_lo_hi_hi_lo = {f_45,f_44,f_43,f_42,f_41,f_40,f_39}; // @[Cat.scala 33:92]
  wire [52:0] io_f_lo = {f_52,f_51,f_50,f_49,f_48,f_47,f_46,io_f_lo_hi_hi_lo,io_f_lo_hi_lo,io_f_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] io_f_hi_lo_lo_lo = {f_58,f_57,f_56,f_55,f_54,f_53}; // @[Cat.scala 33:92]
  wire [12:0] io_f_hi_lo_lo = {f_65,f_64,f_63,f_62,f_61,f_60,f_59,io_f_hi_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] io_f_hi_lo_hi_lo = {f_72,f_71,f_70,f_69,f_68,f_67,f_66}; // @[Cat.scala 33:92]
  wire [26:0] io_f_hi_lo = {f_79,f_78,f_77,f_76,f_75,f_74,f_73,io_f_hi_lo_hi_lo,io_f_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] io_f_hi_hi_lo_lo = {f_85,f_84,f_83,f_82,f_81,f_80}; // @[Cat.scala 33:92]
  wire [12:0] io_f_hi_hi_lo = {f_92,f_91,f_90,f_89,f_88,f_87,f_86,io_f_hi_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] io_f_hi_hi_hi_lo = {f_99,f_98,f_97,f_96,f_95,f_94,f_93}; // @[Cat.scala 33:92]
  wire [53:0] io_f_hi = {f_106,f_105,f_104,f_103,f_102,f_101,f_100,io_f_hi_hi_hi_lo,io_f_hi_hi_lo,io_f_hi_lo}; // @[Cat.scala 33:92]
  assign io_f = {io_f_hi,io_f_lo}; // @[Cat.scala 33:92]
endmodule
module CLZ_1(
  input  [106:0] io_in,
  output [6:0]   io_out
);
  wire [6:0] _io_out_T_107 = io_in[1] ? 7'h69 : 7'h6a; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_108 = io_in[2] ? 7'h68 : _io_out_T_107; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_109 = io_in[3] ? 7'h67 : _io_out_T_108; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_110 = io_in[4] ? 7'h66 : _io_out_T_109; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_111 = io_in[5] ? 7'h65 : _io_out_T_110; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_112 = io_in[6] ? 7'h64 : _io_out_T_111; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_113 = io_in[7] ? 7'h63 : _io_out_T_112; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_114 = io_in[8] ? 7'h62 : _io_out_T_113; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_115 = io_in[9] ? 7'h61 : _io_out_T_114; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_116 = io_in[10] ? 7'h60 : _io_out_T_115; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_117 = io_in[11] ? 7'h5f : _io_out_T_116; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_118 = io_in[12] ? 7'h5e : _io_out_T_117; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_119 = io_in[13] ? 7'h5d : _io_out_T_118; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_120 = io_in[14] ? 7'h5c : _io_out_T_119; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_121 = io_in[15] ? 7'h5b : _io_out_T_120; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_122 = io_in[16] ? 7'h5a : _io_out_T_121; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_123 = io_in[17] ? 7'h59 : _io_out_T_122; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_124 = io_in[18] ? 7'h58 : _io_out_T_123; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_125 = io_in[19] ? 7'h57 : _io_out_T_124; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_126 = io_in[20] ? 7'h56 : _io_out_T_125; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_127 = io_in[21] ? 7'h55 : _io_out_T_126; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_128 = io_in[22] ? 7'h54 : _io_out_T_127; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_129 = io_in[23] ? 7'h53 : _io_out_T_128; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_130 = io_in[24] ? 7'h52 : _io_out_T_129; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_131 = io_in[25] ? 7'h51 : _io_out_T_130; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_132 = io_in[26] ? 7'h50 : _io_out_T_131; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_133 = io_in[27] ? 7'h4f : _io_out_T_132; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_134 = io_in[28] ? 7'h4e : _io_out_T_133; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_135 = io_in[29] ? 7'h4d : _io_out_T_134; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_136 = io_in[30] ? 7'h4c : _io_out_T_135; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_137 = io_in[31] ? 7'h4b : _io_out_T_136; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_138 = io_in[32] ? 7'h4a : _io_out_T_137; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_139 = io_in[33] ? 7'h49 : _io_out_T_138; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_140 = io_in[34] ? 7'h48 : _io_out_T_139; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_141 = io_in[35] ? 7'h47 : _io_out_T_140; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_142 = io_in[36] ? 7'h46 : _io_out_T_141; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_143 = io_in[37] ? 7'h45 : _io_out_T_142; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_144 = io_in[38] ? 7'h44 : _io_out_T_143; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_145 = io_in[39] ? 7'h43 : _io_out_T_144; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_146 = io_in[40] ? 7'h42 : _io_out_T_145; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_147 = io_in[41] ? 7'h41 : _io_out_T_146; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_148 = io_in[42] ? 7'h40 : _io_out_T_147; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_149 = io_in[43] ? 7'h3f : _io_out_T_148; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_150 = io_in[44] ? 7'h3e : _io_out_T_149; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_151 = io_in[45] ? 7'h3d : _io_out_T_150; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_152 = io_in[46] ? 7'h3c : _io_out_T_151; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_153 = io_in[47] ? 7'h3b : _io_out_T_152; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_154 = io_in[48] ? 7'h3a : _io_out_T_153; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_155 = io_in[49] ? 7'h39 : _io_out_T_154; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_156 = io_in[50] ? 7'h38 : _io_out_T_155; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_157 = io_in[51] ? 7'h37 : _io_out_T_156; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_158 = io_in[52] ? 7'h36 : _io_out_T_157; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_159 = io_in[53] ? 7'h35 : _io_out_T_158; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_160 = io_in[54] ? 7'h34 : _io_out_T_159; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_161 = io_in[55] ? 7'h33 : _io_out_T_160; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_162 = io_in[56] ? 7'h32 : _io_out_T_161; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_163 = io_in[57] ? 7'h31 : _io_out_T_162; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_164 = io_in[58] ? 7'h30 : _io_out_T_163; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_165 = io_in[59] ? 7'h2f : _io_out_T_164; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_166 = io_in[60] ? 7'h2e : _io_out_T_165; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_167 = io_in[61] ? 7'h2d : _io_out_T_166; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_168 = io_in[62] ? 7'h2c : _io_out_T_167; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_169 = io_in[63] ? 7'h2b : _io_out_T_168; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_170 = io_in[64] ? 7'h2a : _io_out_T_169; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_171 = io_in[65] ? 7'h29 : _io_out_T_170; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_172 = io_in[66] ? 7'h28 : _io_out_T_171; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_173 = io_in[67] ? 7'h27 : _io_out_T_172; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_174 = io_in[68] ? 7'h26 : _io_out_T_173; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_175 = io_in[69] ? 7'h25 : _io_out_T_174; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_176 = io_in[70] ? 7'h24 : _io_out_T_175; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_177 = io_in[71] ? 7'h23 : _io_out_T_176; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_178 = io_in[72] ? 7'h22 : _io_out_T_177; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_179 = io_in[73] ? 7'h21 : _io_out_T_178; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_180 = io_in[74] ? 7'h20 : _io_out_T_179; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_181 = io_in[75] ? 7'h1f : _io_out_T_180; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_182 = io_in[76] ? 7'h1e : _io_out_T_181; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_183 = io_in[77] ? 7'h1d : _io_out_T_182; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_184 = io_in[78] ? 7'h1c : _io_out_T_183; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_185 = io_in[79] ? 7'h1b : _io_out_T_184; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_186 = io_in[80] ? 7'h1a : _io_out_T_185; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_187 = io_in[81] ? 7'h19 : _io_out_T_186; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_188 = io_in[82] ? 7'h18 : _io_out_T_187; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_189 = io_in[83] ? 7'h17 : _io_out_T_188; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_190 = io_in[84] ? 7'h16 : _io_out_T_189; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_191 = io_in[85] ? 7'h15 : _io_out_T_190; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_192 = io_in[86] ? 7'h14 : _io_out_T_191; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_193 = io_in[87] ? 7'h13 : _io_out_T_192; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_194 = io_in[88] ? 7'h12 : _io_out_T_193; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_195 = io_in[89] ? 7'h11 : _io_out_T_194; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_196 = io_in[90] ? 7'h10 : _io_out_T_195; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_197 = io_in[91] ? 7'hf : _io_out_T_196; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_198 = io_in[92] ? 7'he : _io_out_T_197; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_199 = io_in[93] ? 7'hd : _io_out_T_198; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_200 = io_in[94] ? 7'hc : _io_out_T_199; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_201 = io_in[95] ? 7'hb : _io_out_T_200; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_202 = io_in[96] ? 7'ha : _io_out_T_201; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_203 = io_in[97] ? 7'h9 : _io_out_T_202; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_204 = io_in[98] ? 7'h8 : _io_out_T_203; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_205 = io_in[99] ? 7'h7 : _io_out_T_204; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_206 = io_in[100] ? 7'h6 : _io_out_T_205; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_207 = io_in[101] ? 7'h5 : _io_out_T_206; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_208 = io_in[102] ? 7'h4 : _io_out_T_207; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_209 = io_in[103] ? 7'h3 : _io_out_T_208; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_210 = io_in[104] ? 7'h2 : _io_out_T_209; // @[Mux.scala 47:70]
  wire [6:0] _io_out_T_211 = io_in[105] ? 7'h1 : _io_out_T_210; // @[Mux.scala 47:70]
  assign io_out = io_in[106] ? 7'h0 : _io_out_T_211; // @[Mux.scala 47:70]
endmodule
module NearPath(
  input          io_in_a_sign,
  input  [10:0]  io_in_a_exp,
  input  [105:0] io_in_a_sig,
  input          io_in_b_sign,
  input  [105:0] io_in_b_sig,
  input          io_in_need_shift_b,
  output         io_out_result_sign,
  output [10:0]  io_out_result_exp,
  output [55:0]  io_out_result_sig,
  output         io_out_sig_is_zero,
  output         io_out_a_lt_b
);
  wire [106:0] lza_ab_io_a; // @[FADD.scala 87:22]
  wire [106:0] lza_ab_io_b; // @[FADD.scala 87:22]
  wire [106:0] lza_ab_io_f; // @[FADD.scala 87:22]
  wire [106:0] lzc_clz_io_in; // @[CLZ.scala 22:21]
  wire [6:0] lzc_clz_io_out; // @[CLZ.scala 22:21]
  wire [106:0] _b_sig_T = {io_in_b_sig,1'h0}; // @[Cat.scala 33:92]
  wire [106:0] b_sig = _b_sig_T >> io_in_need_shift_b; // @[FADD.scala 81:37]
  wire [106:0] b_neg = ~b_sig; // @[FADD.scala 82:16]
  wire [107:0] _a_minus_b_T = {1'h0,io_in_a_sig,1'h0}; // @[Cat.scala 33:92]
  wire [107:0] _a_minus_b_T_1 = {1'h1,b_neg}; // @[Cat.scala 33:92]
  wire [107:0] _a_minus_b_T_3 = _a_minus_b_T + _a_minus_b_T_1; // @[FADD.scala 84:40]
  wire [107:0] a_minus_b = _a_minus_b_T_3 + 108'h1; // @[FADD.scala 84:63]
  wire  a_lt_b = a_minus_b[107]; // @[FADD.scala 85:30]
  wire [106:0] sig_raw = a_minus_b[106:0]; // @[FADD.scala 86:31]
  wire  lza_str_zero = ~(|lza_ab_io_f); // @[FADD.scala 91:22]
  wire  need_shift_lim = io_in_a_exp < 11'h6b; // @[FADD.scala 94:30]
  wire [107:0] _shift_lim_mask_raw_T_2 = 108'h800000000000000000000000000 >> io_in_a_exp[6:0]; // @[FADD.scala 97:41]
  wire [106:0] shift_lim_mask_raw = _shift_lim_mask_raw_T_2[106:0]; // @[FADD.scala 98:16]
  wire [106:0] shift_lim_mask = need_shift_lim ? shift_lim_mask_raw : 107'h0; // @[FADD.scala 99:27]
  wire [106:0] _shift_lim_bit_T = shift_lim_mask_raw & sig_raw; // @[FADD.scala 100:43]
  wire  shift_lim_bit = |_shift_lim_bit_T; // @[FADD.scala 100:57]
  wire [106:0] lzc_str = shift_lim_mask | lza_ab_io_f; // @[FADD.scala 102:32]
  wire  _int_bit_mask_T_5 = lzc_str[105] & ~(|lzc_str[106]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_10 = lzc_str[104] & ~(|lzc_str[106:105]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_15 = lzc_str[103] & ~(|lzc_str[106:104]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_20 = lzc_str[102] & ~(|lzc_str[106:103]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_25 = lzc_str[101] & ~(|lzc_str[106:102]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_30 = lzc_str[100] & ~(|lzc_str[106:101]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_35 = lzc_str[99] & ~(|lzc_str[106:100]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_40 = lzc_str[98] & ~(|lzc_str[106:99]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_45 = lzc_str[97] & ~(|lzc_str[106:98]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_50 = lzc_str[96] & ~(|lzc_str[106:97]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_55 = lzc_str[95] & ~(|lzc_str[106:96]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_60 = lzc_str[94] & ~(|lzc_str[106:95]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_65 = lzc_str[93] & ~(|lzc_str[106:94]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_70 = lzc_str[92] & ~(|lzc_str[106:93]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_75 = lzc_str[91] & ~(|lzc_str[106:92]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_80 = lzc_str[90] & ~(|lzc_str[106:91]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_85 = lzc_str[89] & ~(|lzc_str[106:90]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_90 = lzc_str[88] & ~(|lzc_str[106:89]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_95 = lzc_str[87] & ~(|lzc_str[106:88]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_100 = lzc_str[86] & ~(|lzc_str[106:87]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_105 = lzc_str[85] & ~(|lzc_str[106:86]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_110 = lzc_str[84] & ~(|lzc_str[106:85]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_115 = lzc_str[83] & ~(|lzc_str[106:84]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_120 = lzc_str[82] & ~(|lzc_str[106:83]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_125 = lzc_str[81] & ~(|lzc_str[106:82]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_130 = lzc_str[80] & ~(|lzc_str[106:81]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_135 = lzc_str[79] & ~(|lzc_str[106:80]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_140 = lzc_str[78] & ~(|lzc_str[106:79]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_145 = lzc_str[77] & ~(|lzc_str[106:78]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_150 = lzc_str[76] & ~(|lzc_str[106:77]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_155 = lzc_str[75] & ~(|lzc_str[106:76]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_160 = lzc_str[74] & ~(|lzc_str[106:75]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_165 = lzc_str[73] & ~(|lzc_str[106:74]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_170 = lzc_str[72] & ~(|lzc_str[106:73]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_175 = lzc_str[71] & ~(|lzc_str[106:72]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_180 = lzc_str[70] & ~(|lzc_str[106:71]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_185 = lzc_str[69] & ~(|lzc_str[106:70]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_190 = lzc_str[68] & ~(|lzc_str[106:69]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_195 = lzc_str[67] & ~(|lzc_str[106:68]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_200 = lzc_str[66] & ~(|lzc_str[106:67]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_205 = lzc_str[65] & ~(|lzc_str[106:66]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_210 = lzc_str[64] & ~(|lzc_str[106:65]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_215 = lzc_str[63] & ~(|lzc_str[106:64]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_220 = lzc_str[62] & ~(|lzc_str[106:63]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_225 = lzc_str[61] & ~(|lzc_str[106:62]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_230 = lzc_str[60] & ~(|lzc_str[106:61]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_235 = lzc_str[59] & ~(|lzc_str[106:60]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_240 = lzc_str[58] & ~(|lzc_str[106:59]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_245 = lzc_str[57] & ~(|lzc_str[106:58]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_250 = lzc_str[56] & ~(|lzc_str[106:57]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_255 = lzc_str[55] & ~(|lzc_str[106:56]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_260 = lzc_str[54] & ~(|lzc_str[106:55]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_265 = lzc_str[53] & ~(|lzc_str[106:54]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_270 = lzc_str[52] & ~(|lzc_str[106:53]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_275 = lzc_str[51] & ~(|lzc_str[106:52]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_280 = lzc_str[50] & ~(|lzc_str[106:51]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_285 = lzc_str[49] & ~(|lzc_str[106:50]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_290 = lzc_str[48] & ~(|lzc_str[106:49]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_295 = lzc_str[47] & ~(|lzc_str[106:48]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_300 = lzc_str[46] & ~(|lzc_str[106:47]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_305 = lzc_str[45] & ~(|lzc_str[106:46]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_310 = lzc_str[44] & ~(|lzc_str[106:45]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_315 = lzc_str[43] & ~(|lzc_str[106:44]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_320 = lzc_str[42] & ~(|lzc_str[106:43]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_325 = lzc_str[41] & ~(|lzc_str[106:42]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_330 = lzc_str[40] & ~(|lzc_str[106:41]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_335 = lzc_str[39] & ~(|lzc_str[106:40]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_340 = lzc_str[38] & ~(|lzc_str[106:39]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_345 = lzc_str[37] & ~(|lzc_str[106:38]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_350 = lzc_str[36] & ~(|lzc_str[106:37]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_355 = lzc_str[35] & ~(|lzc_str[106:36]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_360 = lzc_str[34] & ~(|lzc_str[106:35]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_365 = lzc_str[33] & ~(|lzc_str[106:34]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_370 = lzc_str[32] & ~(|lzc_str[106:33]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_375 = lzc_str[31] & ~(|lzc_str[106:32]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_380 = lzc_str[30] & ~(|lzc_str[106:31]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_385 = lzc_str[29] & ~(|lzc_str[106:30]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_390 = lzc_str[28] & ~(|lzc_str[106:29]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_395 = lzc_str[27] & ~(|lzc_str[106:28]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_400 = lzc_str[26] & ~(|lzc_str[106:27]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_405 = lzc_str[25] & ~(|lzc_str[106:26]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_410 = lzc_str[24] & ~(|lzc_str[106:25]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_415 = lzc_str[23] & ~(|lzc_str[106:24]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_420 = lzc_str[22] & ~(|lzc_str[106:23]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_425 = lzc_str[21] & ~(|lzc_str[106:22]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_430 = lzc_str[20] & ~(|lzc_str[106:21]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_435 = lzc_str[19] & ~(|lzc_str[106:20]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_440 = lzc_str[18] & ~(|lzc_str[106:19]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_445 = lzc_str[17] & ~(|lzc_str[106:18]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_450 = lzc_str[16] & ~(|lzc_str[106:17]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_455 = lzc_str[15] & ~(|lzc_str[106:16]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_460 = lzc_str[14] & ~(|lzc_str[106:15]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_465 = lzc_str[13] & ~(|lzc_str[106:14]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_470 = lzc_str[12] & ~(|lzc_str[106:13]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_475 = lzc_str[11] & ~(|lzc_str[106:12]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_480 = lzc_str[10] & ~(|lzc_str[106:11]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_485 = lzc_str[9] & ~(|lzc_str[106:10]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_490 = lzc_str[8] & ~(|lzc_str[106:9]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_495 = lzc_str[7] & ~(|lzc_str[106:8]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_500 = lzc_str[6] & ~(|lzc_str[106:7]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_505 = lzc_str[5] & ~(|lzc_str[106:6]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_510 = lzc_str[4] & ~(|lzc_str[106:5]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_515 = lzc_str[3] & ~(|lzc_str[106:4]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_520 = lzc_str[2] & ~(|lzc_str[106:3]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_525 = lzc_str[1] & ~(|lzc_str[106:2]); // @[FADD.scala 107:40]
  wire  _int_bit_mask_T_530 = lzc_str[0] & ~(|lzc_str[106:1]); // @[FADD.scala 107:40]
  wire [5:0] int_bit_mask_lo_lo_lo_lo = {_int_bit_mask_T_505,_int_bit_mask_T_510,_int_bit_mask_T_515,_int_bit_mask_T_520
    ,_int_bit_mask_T_525,_int_bit_mask_T_530}; // @[Cat.scala 33:92]
  wire [12:0] int_bit_mask_lo_lo_lo = {_int_bit_mask_T_470,_int_bit_mask_T_475,_int_bit_mask_T_480,_int_bit_mask_T_485,
    _int_bit_mask_T_490,_int_bit_mask_T_495,_int_bit_mask_T_500,int_bit_mask_lo_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] int_bit_mask_lo_lo_hi_lo = {_int_bit_mask_T_440,_int_bit_mask_T_445,_int_bit_mask_T_450,_int_bit_mask_T_455
    ,_int_bit_mask_T_460,_int_bit_mask_T_465}; // @[Cat.scala 33:92]
  wire [25:0] int_bit_mask_lo_lo = {_int_bit_mask_T_405,_int_bit_mask_T_410,_int_bit_mask_T_415,_int_bit_mask_T_420,
    _int_bit_mask_T_425,_int_bit_mask_T_430,_int_bit_mask_T_435,int_bit_mask_lo_lo_hi_lo,int_bit_mask_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] int_bit_mask_lo_hi_lo_lo = {_int_bit_mask_T_375,_int_bit_mask_T_380,_int_bit_mask_T_385,_int_bit_mask_T_390
    ,_int_bit_mask_T_395,_int_bit_mask_T_400}; // @[Cat.scala 33:92]
  wire [12:0] int_bit_mask_lo_hi_lo = {_int_bit_mask_T_340,_int_bit_mask_T_345,_int_bit_mask_T_350,_int_bit_mask_T_355,
    _int_bit_mask_T_360,_int_bit_mask_T_365,_int_bit_mask_T_370,int_bit_mask_lo_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] int_bit_mask_lo_hi_hi_lo = {_int_bit_mask_T_305,_int_bit_mask_T_310,_int_bit_mask_T_315,_int_bit_mask_T_320
    ,_int_bit_mask_T_325,_int_bit_mask_T_330,_int_bit_mask_T_335}; // @[Cat.scala 33:92]
  wire [52:0] int_bit_mask_lo = {_int_bit_mask_T_270,_int_bit_mask_T_275,_int_bit_mask_T_280,_int_bit_mask_T_285,
    _int_bit_mask_T_290,_int_bit_mask_T_295,_int_bit_mask_T_300,int_bit_mask_lo_hi_hi_lo,int_bit_mask_lo_hi_lo,
    int_bit_mask_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] int_bit_mask_hi_lo_lo_lo = {_int_bit_mask_T_240,_int_bit_mask_T_245,_int_bit_mask_T_250,_int_bit_mask_T_255
    ,_int_bit_mask_T_260,_int_bit_mask_T_265}; // @[Cat.scala 33:92]
  wire [12:0] int_bit_mask_hi_lo_lo = {_int_bit_mask_T_205,_int_bit_mask_T_210,_int_bit_mask_T_215,_int_bit_mask_T_220,
    _int_bit_mask_T_225,_int_bit_mask_T_230,_int_bit_mask_T_235,int_bit_mask_hi_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] int_bit_mask_hi_lo_hi_lo = {_int_bit_mask_T_170,_int_bit_mask_T_175,_int_bit_mask_T_180,_int_bit_mask_T_185
    ,_int_bit_mask_T_190,_int_bit_mask_T_195,_int_bit_mask_T_200}; // @[Cat.scala 33:92]
  wire [26:0] int_bit_mask_hi_lo = {_int_bit_mask_T_135,_int_bit_mask_T_140,_int_bit_mask_T_145,_int_bit_mask_T_150,
    _int_bit_mask_T_155,_int_bit_mask_T_160,_int_bit_mask_T_165,int_bit_mask_hi_lo_hi_lo,int_bit_mask_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] int_bit_mask_hi_hi_lo_lo = {_int_bit_mask_T_105,_int_bit_mask_T_110,_int_bit_mask_T_115,_int_bit_mask_T_120
    ,_int_bit_mask_T_125,_int_bit_mask_T_130}; // @[Cat.scala 33:92]
  wire [12:0] int_bit_mask_hi_hi_lo = {_int_bit_mask_T_70,_int_bit_mask_T_75,_int_bit_mask_T_80,_int_bit_mask_T_85,
    _int_bit_mask_T_90,_int_bit_mask_T_95,_int_bit_mask_T_100,int_bit_mask_hi_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] int_bit_mask_hi_hi_hi_lo = {_int_bit_mask_T_35,_int_bit_mask_T_40,_int_bit_mask_T_45,_int_bit_mask_T_50,
    _int_bit_mask_T_55,_int_bit_mask_T_60,_int_bit_mask_T_65}; // @[Cat.scala 33:92]
  wire [53:0] int_bit_mask_hi = {lzc_str[106],_int_bit_mask_T_5,_int_bit_mask_T_10,_int_bit_mask_T_15,_int_bit_mask_T_20
    ,_int_bit_mask_T_25,_int_bit_mask_T_30,int_bit_mask_hi_hi_hi_lo,int_bit_mask_hi_hi_lo,int_bit_mask_hi_lo}; // @[Cat.scala 33:92]
  wire [106:0] int_bit_mask = {int_bit_mask_hi,int_bit_mask_lo}; // @[Cat.scala 33:92]
  wire [106:0] _GEN_0 = {{106'd0}, lza_str_zero}; // @[FADD.scala 111:20]
  wire [106:0] _int_bit_predicted_T = int_bit_mask | _GEN_0; // @[FADD.scala 111:20]
  wire [106:0] _int_bit_predicted_T_1 = _int_bit_predicted_T & sig_raw; // @[FADD.scala 111:36]
  wire  int_bit_predicted = |_int_bit_predicted_T_1; // @[FADD.scala 111:50]
  wire [106:0] _int_bit_rshift_1_T = {{1'd0}, int_bit_mask[106:1]}; // @[FADD.scala 113:20]
  wire [106:0] _int_bit_rshift_1_T_1 = _int_bit_rshift_1_T & sig_raw; // @[FADD.scala 113:37]
  wire  int_bit_rshift_1 = |_int_bit_rshift_1_T_1; // @[FADD.scala 113:51]
  wire  _exceed_lim_mask_T_1 = |lza_ab_io_f[106]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_3 = |lza_ab_io_f[106:105]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_5 = |lza_ab_io_f[106:104]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_7 = |lza_ab_io_f[106:103]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_9 = |lza_ab_io_f[106:102]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_11 = |lza_ab_io_f[106:101]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_13 = |lza_ab_io_f[106:100]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_15 = |lza_ab_io_f[106:99]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_17 = |lza_ab_io_f[106:98]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_19 = |lza_ab_io_f[106:97]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_21 = |lza_ab_io_f[106:96]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_23 = |lza_ab_io_f[106:95]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_25 = |lza_ab_io_f[106:94]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_27 = |lza_ab_io_f[106:93]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_29 = |lza_ab_io_f[106:92]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_31 = |lza_ab_io_f[106:91]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_33 = |lza_ab_io_f[106:90]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_35 = |lza_ab_io_f[106:89]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_37 = |lza_ab_io_f[106:88]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_39 = |lza_ab_io_f[106:87]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_41 = |lza_ab_io_f[106:86]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_43 = |lza_ab_io_f[106:85]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_45 = |lza_ab_io_f[106:84]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_47 = |lza_ab_io_f[106:83]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_49 = |lza_ab_io_f[106:82]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_51 = |lza_ab_io_f[106:81]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_53 = |lza_ab_io_f[106:80]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_55 = |lza_ab_io_f[106:79]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_57 = |lza_ab_io_f[106:78]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_59 = |lza_ab_io_f[106:77]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_61 = |lza_ab_io_f[106:76]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_63 = |lza_ab_io_f[106:75]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_65 = |lza_ab_io_f[106:74]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_67 = |lza_ab_io_f[106:73]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_69 = |lza_ab_io_f[106:72]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_71 = |lza_ab_io_f[106:71]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_73 = |lza_ab_io_f[106:70]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_75 = |lza_ab_io_f[106:69]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_77 = |lza_ab_io_f[106:68]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_79 = |lza_ab_io_f[106:67]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_81 = |lza_ab_io_f[106:66]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_83 = |lza_ab_io_f[106:65]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_85 = |lza_ab_io_f[106:64]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_87 = |lza_ab_io_f[106:63]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_89 = |lza_ab_io_f[106:62]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_91 = |lza_ab_io_f[106:61]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_93 = |lza_ab_io_f[106:60]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_95 = |lza_ab_io_f[106:59]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_97 = |lza_ab_io_f[106:58]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_99 = |lza_ab_io_f[106:57]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_101 = |lza_ab_io_f[106:56]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_103 = |lza_ab_io_f[106:55]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_105 = |lza_ab_io_f[106:54]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_107 = |lza_ab_io_f[106:53]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_109 = |lza_ab_io_f[106:52]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_111 = |lza_ab_io_f[106:51]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_113 = |lza_ab_io_f[106:50]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_115 = |lza_ab_io_f[106:49]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_117 = |lza_ab_io_f[106:48]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_119 = |lza_ab_io_f[106:47]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_121 = |lza_ab_io_f[106:46]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_123 = |lza_ab_io_f[106:45]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_125 = |lza_ab_io_f[106:44]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_127 = |lza_ab_io_f[106:43]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_129 = |lza_ab_io_f[106:42]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_131 = |lza_ab_io_f[106:41]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_133 = |lza_ab_io_f[106:40]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_135 = |lza_ab_io_f[106:39]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_137 = |lza_ab_io_f[106:38]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_139 = |lza_ab_io_f[106:37]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_141 = |lza_ab_io_f[106:36]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_143 = |lza_ab_io_f[106:35]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_145 = |lza_ab_io_f[106:34]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_147 = |lza_ab_io_f[106:33]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_149 = |lza_ab_io_f[106:32]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_151 = |lza_ab_io_f[106:31]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_153 = |lza_ab_io_f[106:30]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_155 = |lza_ab_io_f[106:29]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_157 = |lza_ab_io_f[106:28]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_159 = |lza_ab_io_f[106:27]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_161 = |lza_ab_io_f[106:26]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_163 = |lza_ab_io_f[106:25]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_165 = |lza_ab_io_f[106:24]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_167 = |lza_ab_io_f[106:23]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_169 = |lza_ab_io_f[106:22]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_171 = |lza_ab_io_f[106:21]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_173 = |lza_ab_io_f[106:20]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_175 = |lza_ab_io_f[106:19]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_177 = |lza_ab_io_f[106:18]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_179 = |lza_ab_io_f[106:17]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_181 = |lza_ab_io_f[106:16]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_183 = |lza_ab_io_f[106:15]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_185 = |lza_ab_io_f[106:14]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_187 = |lza_ab_io_f[106:13]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_189 = |lza_ab_io_f[106:12]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_191 = |lza_ab_io_f[106:11]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_193 = |lza_ab_io_f[106:10]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_195 = |lza_ab_io_f[106:9]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_197 = |lza_ab_io_f[106:8]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_199 = |lza_ab_io_f[106:7]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_201 = |lza_ab_io_f[106:6]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_203 = |lza_ab_io_f[106:5]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_205 = |lza_ab_io_f[106:4]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_207 = |lza_ab_io_f[106:3]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_209 = |lza_ab_io_f[106:2]; // @[FADD.scala 117:64]
  wire  _exceed_lim_mask_T_211 = |lza_ab_io_f[106:1]; // @[FADD.scala 117:64]
  wire [5:0] exceed_lim_mask_lo_lo_lo_lo = {_exceed_lim_mask_T_201,_exceed_lim_mask_T_203,_exceed_lim_mask_T_205,
    _exceed_lim_mask_T_207,_exceed_lim_mask_T_209,_exceed_lim_mask_T_211}; // @[Cat.scala 33:92]
  wire [12:0] exceed_lim_mask_lo_lo_lo = {_exceed_lim_mask_T_187,_exceed_lim_mask_T_189,_exceed_lim_mask_T_191,
    _exceed_lim_mask_T_193,_exceed_lim_mask_T_195,_exceed_lim_mask_T_197,_exceed_lim_mask_T_199,
    exceed_lim_mask_lo_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] exceed_lim_mask_lo_lo_hi_lo = {_exceed_lim_mask_T_175,_exceed_lim_mask_T_177,_exceed_lim_mask_T_179,
    _exceed_lim_mask_T_181,_exceed_lim_mask_T_183,_exceed_lim_mask_T_185}; // @[Cat.scala 33:92]
  wire [25:0] exceed_lim_mask_lo_lo = {_exceed_lim_mask_T_161,_exceed_lim_mask_T_163,_exceed_lim_mask_T_165,
    _exceed_lim_mask_T_167,_exceed_lim_mask_T_169,_exceed_lim_mask_T_171,_exceed_lim_mask_T_173,
    exceed_lim_mask_lo_lo_hi_lo,exceed_lim_mask_lo_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] exceed_lim_mask_lo_hi_lo_lo = {_exceed_lim_mask_T_149,_exceed_lim_mask_T_151,_exceed_lim_mask_T_153,
    _exceed_lim_mask_T_155,_exceed_lim_mask_T_157,_exceed_lim_mask_T_159}; // @[Cat.scala 33:92]
  wire [12:0] exceed_lim_mask_lo_hi_lo = {_exceed_lim_mask_T_135,_exceed_lim_mask_T_137,_exceed_lim_mask_T_139,
    _exceed_lim_mask_T_141,_exceed_lim_mask_T_143,_exceed_lim_mask_T_145,_exceed_lim_mask_T_147,
    exceed_lim_mask_lo_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [6:0] exceed_lim_mask_lo_hi_hi_lo = {_exceed_lim_mask_T_121,_exceed_lim_mask_T_123,_exceed_lim_mask_T_125,
    _exceed_lim_mask_T_127,_exceed_lim_mask_T_129,_exceed_lim_mask_T_131,_exceed_lim_mask_T_133}; // @[Cat.scala 33:92]
  wire [52:0] exceed_lim_mask_lo = {_exceed_lim_mask_T_107,_exceed_lim_mask_T_109,_exceed_lim_mask_T_111,
    _exceed_lim_mask_T_113,_exceed_lim_mask_T_115,_exceed_lim_mask_T_117,_exceed_lim_mask_T_119,
    exceed_lim_mask_lo_hi_hi_lo,exceed_lim_mask_lo_hi_lo,exceed_lim_mask_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] exceed_lim_mask_hi_lo_lo_lo = {_exceed_lim_mask_T_95,_exceed_lim_mask_T_97,_exceed_lim_mask_T_99,
    _exceed_lim_mask_T_101,_exceed_lim_mask_T_103,_exceed_lim_mask_T_105}; // @[Cat.scala 33:92]
  wire [12:0] exceed_lim_mask_hi_lo_lo = {_exceed_lim_mask_T_81,_exceed_lim_mask_T_83,_exceed_lim_mask_T_85,
    _exceed_lim_mask_T_87,_exceed_lim_mask_T_89,_exceed_lim_mask_T_91,_exceed_lim_mask_T_93,exceed_lim_mask_hi_lo_lo_lo}
    ; // @[Cat.scala 33:92]
  wire [6:0] exceed_lim_mask_hi_lo_hi_lo = {_exceed_lim_mask_T_67,_exceed_lim_mask_T_69,_exceed_lim_mask_T_71,
    _exceed_lim_mask_T_73,_exceed_lim_mask_T_75,_exceed_lim_mask_T_77,_exceed_lim_mask_T_79}; // @[Cat.scala 33:92]
  wire [26:0] exceed_lim_mask_hi_lo = {_exceed_lim_mask_T_53,_exceed_lim_mask_T_55,_exceed_lim_mask_T_57,
    _exceed_lim_mask_T_59,_exceed_lim_mask_T_61,_exceed_lim_mask_T_63,_exceed_lim_mask_T_65,exceed_lim_mask_hi_lo_hi_lo,
    exceed_lim_mask_hi_lo_lo}; // @[Cat.scala 33:92]
  wire [5:0] exceed_lim_mask_hi_hi_lo_lo = {_exceed_lim_mask_T_41,_exceed_lim_mask_T_43,_exceed_lim_mask_T_45,
    _exceed_lim_mask_T_47,_exceed_lim_mask_T_49,_exceed_lim_mask_T_51}; // @[Cat.scala 33:92]
  wire [12:0] exceed_lim_mask_hi_hi_lo = {_exceed_lim_mask_T_27,_exceed_lim_mask_T_29,_exceed_lim_mask_T_31,
    _exceed_lim_mask_T_33,_exceed_lim_mask_T_35,_exceed_lim_mask_T_37,_exceed_lim_mask_T_39,exceed_lim_mask_hi_hi_lo_lo}
    ; // @[Cat.scala 33:92]
  wire [6:0] exceed_lim_mask_hi_hi_hi_lo = {_exceed_lim_mask_T_13,_exceed_lim_mask_T_15,_exceed_lim_mask_T_17,
    _exceed_lim_mask_T_19,_exceed_lim_mask_T_21,_exceed_lim_mask_T_23,_exceed_lim_mask_T_25}; // @[Cat.scala 33:92]
  wire [53:0] exceed_lim_mask_hi = {1'h0,_exceed_lim_mask_T_1,_exceed_lim_mask_T_3,_exceed_lim_mask_T_5,
    _exceed_lim_mask_T_7,_exceed_lim_mask_T_9,_exceed_lim_mask_T_11,exceed_lim_mask_hi_hi_hi_lo,exceed_lim_mask_hi_hi_lo
    ,exceed_lim_mask_hi_lo}; // @[Cat.scala 33:92]
  wire [106:0] exceed_lim_mask = {exceed_lim_mask_hi,exceed_lim_mask_lo}; // @[Cat.scala 33:92]
  wire [106:0] _exceed_lim_T = exceed_lim_mask & shift_lim_mask_raw; // @[FADD.scala 120:41]
  wire  exceed_lim = need_shift_lim & ~(|_exceed_lim_T); // @[FADD.scala 120:20]
  wire  int_bit = exceed_lim ? shift_lim_bit : int_bit_rshift_1 | int_bit_predicted; // @[FADD.scala 123:8]
  wire  lza_error = ~int_bit_predicted & ~exceed_lim; // @[FADD.scala 125:38]
  wire [10:0] _GEN_2 = {{4'd0}, lzc_clz_io_out}; // @[FADD.scala 126:22]
  wire [10:0] exp_s1 = io_in_a_exp - _GEN_2; // @[FADD.scala 126:22]
  wire [10:0] _GEN_3 = {{10'd0}, lza_error}; // @[FADD.scala 127:23]
  wire [10:0] exp_s2 = exp_s1 - _GEN_3; // @[FADD.scala 127:23]
  wire [233:0] _GEN_4 = {{127'd0}, sig_raw}; // @[FADD.scala 128:25]
  wire [233:0] _sig_s1_T = _GEN_4 << lzc_clz_io_out; // @[FADD.scala 128:25]
  wire [106:0] sig_s1 = _sig_s1_T[106:0]; // @[FADD.scala 128:32]
  wire [106:0] _sig_s2_T_1 = {sig_s1[105:0],1'h0}; // @[Cat.scala 33:92]
  wire [106:0] near_path_sig = lza_error ? _sig_s2_T_1 : sig_s1; // @[FADD.scala 129:19]
  LZA lza_ab ( // @[FADD.scala 87:22]
    .io_a(lza_ab_io_a),
    .io_b(lza_ab_io_b),
    .io_f(lza_ab_io_f)
  );
  CLZ_1 lzc_clz ( // @[CLZ.scala 22:21]
    .io_in(lzc_clz_io_in),
    .io_out(lzc_clz_io_out)
  );
  assign io_out_result_sign = a_lt_b ? io_in_b_sign : io_in_a_sign; // @[FADD.scala 139:27]
  assign io_out_result_exp = int_bit ? exp_s2 : 11'h0; // @[FADD.scala 138:26]
  assign io_out_result_sig = {near_path_sig[106:52],|near_path_sig[51:0]}; // @[FADD.scala 144:47]
  assign io_out_sig_is_zero = lza_str_zero & ~sig_raw[0]; // @[FADD.scala 146:38]
  assign io_out_a_lt_b = a_minus_b[107]; // @[FADD.scala 85:30]
  assign lza_ab_io_a = {io_in_a_sig,1'h0}; // @[Cat.scala 33:92]
  assign lza_ab_io_b = ~b_sig; // @[FADD.scala 82:16]
  assign lzc_clz_io_in = shift_lim_mask | lza_ab_io_f; // @[FADD.scala 102:32]
endmodule
module FCMA_ADD_s1(
  input  [116:0] io_a,
  input  [116:0] io_b,
  input          io_b_inter_valid,
  input          io_b_inter_flags_isNaN,
  input          io_b_inter_flags_isInf,
  input          io_b_inter_flags_isInv,
  input          io_b_inter_flags_overflow,
  input          io_b_inter_flags_prod_sign,
  input  [2:0]   io_rm,
  output [2:0]   io_out_rm,
  output         io_out_far_path_out_sign,
  output [10:0]  io_out_far_path_out_exp,
  output [55:0]  io_out_far_path_out_sig,
  output         io_out_near_path_out_sign,
  output [10:0]  io_out_near_path_out_exp,
  output [55:0]  io_out_near_path_out_sig,
  output         io_out_special_case_valid,
  output         io_out_special_case_bits_iv,
  output         io_out_special_case_bits_nan,
  output         io_out_special_case_bits_inf_sign,
  output         io_out_small_add,
  output         io_out_far_path_mul_of,
  output         io_out_far_path_overflow_sign,
  output         io_out_near_path_sig_is_zero,
  output         io_out_sel_far_path
);
  wire  far_path_mods_0_io_in_a_sign; // @[FADD.scala 208:26]
  wire [10:0] far_path_mods_0_io_in_a_exp; // @[FADD.scala 208:26]
  wire [105:0] far_path_mods_0_io_in_a_sig; // @[FADD.scala 208:26]
  wire [105:0] far_path_mods_0_io_in_b_sig; // @[FADD.scala 208:26]
  wire [10:0] far_path_mods_0_io_in_expDiff; // @[FADD.scala 208:26]
  wire  far_path_mods_0_io_in_effSub; // @[FADD.scala 208:26]
  wire  far_path_mods_0_io_in_smallAdd; // @[FADD.scala 208:26]
  wire  far_path_mods_0_io_out_result_sign; // @[FADD.scala 208:26]
  wire [10:0] far_path_mods_0_io_out_result_exp; // @[FADD.scala 208:26]
  wire [55:0] far_path_mods_0_io_out_result_sig; // @[FADD.scala 208:26]
  wire  near_path_mods_0_io_in_a_sign; // @[FADD.scala 232:27]
  wire [10:0] near_path_mods_0_io_in_a_exp; // @[FADD.scala 232:27]
  wire [105:0] near_path_mods_0_io_in_a_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_0_io_in_b_sign; // @[FADD.scala 232:27]
  wire [105:0] near_path_mods_0_io_in_b_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_0_io_in_need_shift_b; // @[FADD.scala 232:27]
  wire  near_path_mods_0_io_out_result_sign; // @[FADD.scala 232:27]
  wire [10:0] near_path_mods_0_io_out_result_exp; // @[FADD.scala 232:27]
  wire [55:0] near_path_mods_0_io_out_result_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_0_io_out_sig_is_zero; // @[FADD.scala 232:27]
  wire  near_path_mods_0_io_out_a_lt_b; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_in_a_sign; // @[FADD.scala 232:27]
  wire [10:0] near_path_mods_1_io_in_a_exp; // @[FADD.scala 232:27]
  wire [105:0] near_path_mods_1_io_in_a_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_in_b_sign; // @[FADD.scala 232:27]
  wire [105:0] near_path_mods_1_io_in_b_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_in_need_shift_b; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_out_result_sign; // @[FADD.scala 232:27]
  wire [10:0] near_path_mods_1_io_out_result_exp; // @[FADD.scala 232:27]
  wire [55:0] near_path_mods_1_io_out_result_sig; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_out_sig_is_zero; // @[FADD.scala 232:27]
  wire  near_path_mods_1_io_out_a_lt_b; // @[FADD.scala 232:27]
  wire  fp_a_sign = io_a[116]; // @[package.scala 59:19]
  wire [10:0] fp_a_exp = io_a[115:105]; // @[package.scala 60:18]
  wire [104:0] fp_a_sig = io_a[104:0]; // @[package.scala 61:18]
  wire  fp_b_sign = io_b[116]; // @[package.scala 59:19]
  wire [10:0] fp_b_exp = io_b[115:105]; // @[package.scala 60:18]
  wire [104:0] fp_b_sig = io_b[104:0]; // @[package.scala 61:18]
  wire  decode_a_expNotZero = |fp_a_exp; // @[package.scala 32:31]
  wire  decode_a_expIsOnes = &fp_a_exp; // @[package.scala 33:31]
  wire  decode_a_sigNotZero = |fp_a_sig; // @[package.scala 34:31]
  wire  decode_a__expIsZero = ~decode_a_expNotZero; // @[package.scala 37:27]
  wire  decode_a__sigIsZero = ~decode_a_sigNotZero; // @[package.scala 40:27]
  wire  decode_a__isInf = decode_a_expIsOnes & decode_a__sigIsZero; // @[package.scala 42:40]
  wire  decode_a__isNaN = decode_a_expIsOnes & decode_a_sigNotZero; // @[package.scala 44:40]
  wire  decode_a__isSNaN = decode_a__isNaN & ~fp_a_sig[104]; // @[package.scala 45:37]
  wire  decode_b_expNotZero = |fp_b_exp; // @[package.scala 32:31]
  wire  decode_b_expIsOnes = &fp_b_exp; // @[package.scala 33:31]
  wire  decode_b_sigNotZero = |fp_b_sig; // @[package.scala 34:31]
  wire  decode_b__expIsZero = ~decode_b_expNotZero; // @[package.scala 37:27]
  wire  decode_b__sigIsZero = ~decode_b_sigNotZero; // @[package.scala 40:27]
  wire  decode_b__isInf = decode_b_expIsOnes & decode_b__sigIsZero; // @[package.scala 42:40]
  wire  decode_b__isNaN = decode_b_expIsOnes & decode_b_sigNotZero; // @[package.scala 44:40]
  wire  decode_b__isSNaN = decode_b__isNaN & ~fp_b_sig[104]; // @[package.scala 45:37]
  wire [10:0] _GEN_0 = {{10'd0}, decode_a__expIsZero}; // @[package.scala 83:27]
  wire [10:0] raw_a_exp = fp_a_exp | _GEN_0; // @[package.scala 83:27]
  wire [105:0] raw_a_sig = {decode_a_expNotZero,fp_a_sig}; // @[Cat.scala 33:92]
  wire [10:0] _GEN_1 = {{10'd0}, decode_b__expIsZero}; // @[package.scala 83:27]
  wire [10:0] raw_b_exp = fp_b_exp | _GEN_1; // @[package.scala 83:27]
  wire [105:0] raw_b_sig = {decode_b_expNotZero,fp_b_sig}; // @[Cat.scala 33:92]
  wire  eff_sub = fp_a_sign ^ fp_b_sign; // @[FADD.scala 168:28]
  wire  b_isNaN = io_b_inter_valid ? io_b_inter_flags_isNaN : decode_b__isNaN; // @[FADD.scala 175:20]
  wire  b_isSNaN = io_b_inter_valid ? io_b_inter_flags_isInv : decode_b__isSNaN; // @[FADD.scala 176:21]
  wire  b_isInf = io_b_inter_valid ? io_b_inter_flags_isInf : decode_b__isInf; // @[FADD.scala 177:20]
  wire  special_path_hasNaN = decode_a__isNaN | b_isNaN; // @[FADD.scala 179:44]
  wire  special_path_hasSNaN = decode_a__isSNaN | b_isSNaN; // @[FADD.scala 180:46]
  wire  special_path_hasInf = decode_a__isInf | b_isInf; // @[FADD.scala 181:44]
  wire  special_path_inf_iv = decode_a__isInf & b_isInf & eff_sub; // @[FADD.scala 182:55]
  wire [11:0] _exp_diff_a_b_T = {1'h0,raw_a_exp}; // @[Cat.scala 33:92]
  wire [11:0] _exp_diff_a_b_T_1 = {1'h0,raw_b_exp}; // @[Cat.scala 33:92]
  wire [11:0] exp_diff_a_b = _exp_diff_a_b_T - _exp_diff_a_b_T_1; // @[FADD.scala 187:47]
  wire [11:0] exp_diff_b_a = _exp_diff_a_b_T_1 - _exp_diff_a_b_T; // @[FADD.scala 188:47]
  wire  need_swap = exp_diff_a_b[11] | io_b_inter_flags_overflow; // @[FADD.scala 190:47]
  wire [10:0] ea_minus_eb = need_swap ? exp_diff_b_a[10:0] : exp_diff_a_b[10:0]; // @[FADD.scala 192:24]
  wire  _sel_far_path_T = ~eff_sub; // @[FADD.scala 193:22]
  wire  _T = ~need_swap; // @[FADD.scala 201:11]
  wire [11:0] _T_5 = _T ? exp_diff_a_b : exp_diff_b_a; // @[FADD.scala 203:10]
  wire  near_path_exp_neq = raw_a_exp[1:0] != raw_b_exp[1:0]; // @[FADD.scala 225:43]
  wire  _near_path_out_T_2 = need_swap | ~near_path_exp_neq & near_path_mods_0_io_out_a_lt_b; // @[FADD.scala 242:15]
  wire  _io_out_special_case_bits_inf_sign_T_1 = decode_a__isInf ? fp_a_sign : fp_b_sign; // @[FADD.scala 263:27]
  FarPath far_path_mods_0 ( // @[FADD.scala 208:26]
    .io_in_a_sign(far_path_mods_0_io_in_a_sign),
    .io_in_a_exp(far_path_mods_0_io_in_a_exp),
    .io_in_a_sig(far_path_mods_0_io_in_a_sig),
    .io_in_b_sig(far_path_mods_0_io_in_b_sig),
    .io_in_expDiff(far_path_mods_0_io_in_expDiff),
    .io_in_effSub(far_path_mods_0_io_in_effSub),
    .io_in_smallAdd(far_path_mods_0_io_in_smallAdd),
    .io_out_result_sign(far_path_mods_0_io_out_result_sign),
    .io_out_result_exp(far_path_mods_0_io_out_result_exp),
    .io_out_result_sig(far_path_mods_0_io_out_result_sig)
  );
  NearPath near_path_mods_0 ( // @[FADD.scala 232:27]
    .io_in_a_sign(near_path_mods_0_io_in_a_sign),
    .io_in_a_exp(near_path_mods_0_io_in_a_exp),
    .io_in_a_sig(near_path_mods_0_io_in_a_sig),
    .io_in_b_sign(near_path_mods_0_io_in_b_sign),
    .io_in_b_sig(near_path_mods_0_io_in_b_sig),
    .io_in_need_shift_b(near_path_mods_0_io_in_need_shift_b),
    .io_out_result_sign(near_path_mods_0_io_out_result_sign),
    .io_out_result_exp(near_path_mods_0_io_out_result_exp),
    .io_out_result_sig(near_path_mods_0_io_out_result_sig),
    .io_out_sig_is_zero(near_path_mods_0_io_out_sig_is_zero),
    .io_out_a_lt_b(near_path_mods_0_io_out_a_lt_b)
  );
  NearPath near_path_mods_1 ( // @[FADD.scala 232:27]
    .io_in_a_sign(near_path_mods_1_io_in_a_sign),
    .io_in_a_exp(near_path_mods_1_io_in_a_exp),
    .io_in_a_sig(near_path_mods_1_io_in_a_sig),
    .io_in_b_sign(near_path_mods_1_io_in_b_sign),
    .io_in_b_sig(near_path_mods_1_io_in_b_sig),
    .io_in_need_shift_b(near_path_mods_1_io_in_need_shift_b),
    .io_out_result_sign(near_path_mods_1_io_out_result_sign),
    .io_out_result_exp(near_path_mods_1_io_out_result_exp),
    .io_out_result_sig(near_path_mods_1_io_out_result_sig),
    .io_out_sig_is_zero(near_path_mods_1_io_out_sig_is_zero),
    .io_out_a_lt_b(near_path_mods_1_io_out_a_lt_b)
  );
  assign io_out_rm = io_rm; // @[FADD.scala 247:13]
  assign io_out_far_path_out_sign = far_path_mods_0_io_out_result_sign; // @[FADD.scala 251:23]
  assign io_out_far_path_out_exp = far_path_mods_0_io_out_result_exp; // @[FADD.scala 251:23]
  assign io_out_far_path_out_sig = far_path_mods_0_io_out_result_sig; // @[FADD.scala 251:23]
  assign io_out_near_path_out_sign = _near_path_out_T_2 ? near_path_mods_1_io_out_result_sign :
    near_path_mods_0_io_out_result_sign; // @[FADD.scala 241:26]
  assign io_out_near_path_out_exp = _near_path_out_T_2 ? near_path_mods_1_io_out_result_exp :
    near_path_mods_0_io_out_result_exp; // @[FADD.scala 241:26]
  assign io_out_near_path_out_sig = _near_path_out_T_2 ? near_path_mods_1_io_out_result_sig :
    near_path_mods_0_io_out_result_sig; // @[FADD.scala 241:26]
  assign io_out_special_case_valid = special_path_hasNaN | special_path_hasInf; // @[FADD.scala 184:49]
  assign io_out_special_case_bits_iv = special_path_hasSNaN | special_path_inf_iv; // @[FADD.scala 185:46]
  assign io_out_special_case_bits_nan = special_path_hasNaN | special_path_inf_iv; // @[FADD.scala 261:55]
  assign io_out_special_case_bits_inf_sign = io_b_inter_valid & io_b_inter_flags_isInf ? io_b_inter_flags_prod_sign :
    _io_out_special_case_bits_inf_sign_T_1; // @[FADD.scala 262:43]
  assign io_out_small_add = decode_a__expIsZero & decode_b__expIsZero; // @[FADD.scala 170:38]
  assign io_out_far_path_mul_of = io_b_inter_flags_overflow | decode_b_expIsOnes & _sel_far_path_T; // @[FADD.scala 252:46]
  assign io_out_far_path_overflow_sign = io_b_inter_valid & io_b_inter_flags_overflow ? io_b_inter_flags_prod_sign :
    far_path_mods_0_io_out_result_sign; // @[FADD.scala 253:39]
  assign io_out_near_path_sig_is_zero = _near_path_out_T_2 ? near_path_mods_1_io_out_sig_is_zero :
    near_path_mods_0_io_out_sig_is_zero; // @[FADD.scala 241:26]
  assign io_out_sel_far_path = ~eff_sub | ea_minus_eb > 11'h1 | io_b_inter_flags_overflow; // @[FADD.scala 193:52]
  assign far_path_mods_0_io_in_a_sign = ~need_swap ? fp_a_sign : fp_b_sign; // @[FADD.scala 201:10]
  assign far_path_mods_0_io_in_a_exp = ~need_swap ? raw_a_exp : raw_b_exp; // @[FADD.scala 201:10]
  assign far_path_mods_0_io_in_a_sig = ~need_swap ? raw_a_sig : raw_b_sig; // @[FADD.scala 201:10]
  assign far_path_mods_0_io_in_b_sig = _T ? raw_b_sig : raw_a_sig; // @[FADD.scala 202:10]
  assign far_path_mods_0_io_in_expDiff = _T_5[10:0]; // @[FADD.scala 211:28]
  assign far_path_mods_0_io_in_effSub = fp_a_sign ^ fp_b_sign; // @[FADD.scala 168:28]
  assign far_path_mods_0_io_in_smallAdd = decode_a__expIsZero & decode_b__expIsZero; // @[FADD.scala 170:38]
  assign near_path_mods_0_io_in_a_sign = io_a[116]; // @[package.scala 59:19]
  assign near_path_mods_0_io_in_a_exp = fp_a_exp | _GEN_0; // @[package.scala 83:27]
  assign near_path_mods_0_io_in_a_sig = {decode_a_expNotZero,fp_a_sig}; // @[Cat.scala 33:92]
  assign near_path_mods_0_io_in_b_sign = io_b[116]; // @[package.scala 59:19]
  assign near_path_mods_0_io_in_b_sig = {decode_b_expNotZero,fp_b_sig}; // @[Cat.scala 33:92]
  assign near_path_mods_0_io_in_need_shift_b = raw_a_exp[1:0] != raw_b_exp[1:0]; // @[FADD.scala 225:43]
  assign near_path_mods_1_io_in_a_sign = io_b[116]; // @[package.scala 59:19]
  assign near_path_mods_1_io_in_a_exp = fp_b_exp | _GEN_1; // @[package.scala 83:27]
  assign near_path_mods_1_io_in_a_sig = {decode_b_expNotZero,fp_b_sig}; // @[Cat.scala 33:92]
  assign near_path_mods_1_io_in_b_sign = io_a[116]; // @[package.scala 59:19]
  assign near_path_mods_1_io_in_b_sig = {decode_a_expNotZero,fp_a_sig}; // @[Cat.scala 33:92]
  assign near_path_mods_1_io_in_need_shift_b = raw_a_exp[1:0] != raw_b_exp[1:0]; // @[FADD.scala 225:43]
endmodule
module FCMA_ADD_s2(
  input  [2:0]  io_in_rm,
  input         io_in_far_path_out_sign,
  input  [10:0] io_in_far_path_out_exp,
  input  [55:0] io_in_far_path_out_sig,
  input         io_in_near_path_out_sign,
  input  [10:0] io_in_near_path_out_exp,
  input  [55:0] io_in_near_path_out_sig,
  input         io_in_special_case_valid,
  input         io_in_special_case_bits_iv,
  input         io_in_special_case_bits_nan,
  input         io_in_special_case_bits_inf_sign,
  input         io_in_small_add,
  input         io_in_far_path_mul_of,
  input         io_in_far_path_overflow_sign,
  input         io_in_near_path_sig_is_zero,
  input         io_in_sel_far_path,
  output [63:0] io_result,
  output [4:0]  io_fflags
);
  wire  far_path_tininess_rounder_io_in_sign; // @[FADD.scala 317:41]
  wire [55:0] far_path_tininess_rounder_io_in_sig; // @[FADD.scala 317:41]
  wire [2:0] far_path_tininess_rounder_io_rm; // @[FADD.scala 317:41]
  wire  far_path_tininess_rounder_io_tininess; // @[FADD.scala 317:41]
  wire [51:0] far_path_rounder_io_in; // @[RoundingUnit.scala 44:25]
  wire  far_path_rounder_io_roundIn; // @[RoundingUnit.scala 44:25]
  wire  far_path_rounder_io_stickyIn; // @[RoundingUnit.scala 44:25]
  wire  far_path_rounder_io_signIn; // @[RoundingUnit.scala 44:25]
  wire [2:0] far_path_rounder_io_rm; // @[RoundingUnit.scala 44:25]
  wire [51:0] far_path_rounder_io_out; // @[RoundingUnit.scala 44:25]
  wire  far_path_rounder_io_inexact; // @[RoundingUnit.scala 44:25]
  wire  far_path_rounder_io_cout; // @[RoundingUnit.scala 44:25]
  wire  near_path_tininess_rounder_io_in_sign; // @[FADD.scala 356:42]
  wire [55:0] near_path_tininess_rounder_io_in_sig; // @[FADD.scala 356:42]
  wire [2:0] near_path_tininess_rounder_io_rm; // @[FADD.scala 356:42]
  wire  near_path_tininess_rounder_io_tininess; // @[FADD.scala 356:42]
  wire [51:0] near_path_rounder_io_in; // @[RoundingUnit.scala 44:25]
  wire  near_path_rounder_io_roundIn; // @[RoundingUnit.scala 44:25]
  wire  near_path_rounder_io_stickyIn; // @[RoundingUnit.scala 44:25]
  wire  near_path_rounder_io_signIn; // @[RoundingUnit.scala 44:25]
  wire [2:0] near_path_rounder_io_rm; // @[RoundingUnit.scala 44:25]
  wire [51:0] near_path_rounder_io_out; // @[RoundingUnit.scala 44:25]
  wire  near_path_rounder_io_inexact; // @[RoundingUnit.scala 44:25]
  wire  near_path_rounder_io_cout; // @[RoundingUnit.scala 44:25]
  wire [63:0] _special_path_result_T_3 = {io_in_special_case_bits_inf_sign,11'h7ff,52'h0}; // @[Cat.scala 33:92]
  wire [63:0] special_path_result = io_in_special_case_bits_nan ? 64'h7ff8000000000000 : _special_path_result_T_3; // @[FADD.scala 299:32]
  wire [4:0] special_path_fflags = {io_in_special_case_bits_iv,4'h0}; // @[Cat.scala 33:92]
  wire  far_path_tininess = io_in_small_add & far_path_tininess_rounder_io_tininess; // @[FADD.scala 320:37]
  wire [10:0] _GEN_0 = {{10'd0}, far_path_rounder_io_cout}; // @[FADD.scala 329:55]
  wire [10:0] far_path_exp_rounded = _GEN_0 + io_in_far_path_out_exp; // @[FADD.scala 329:55]
  wire  far_path_may_uf = far_path_tininess & ~io_in_far_path_mul_of; // @[FADD.scala 334:43]
  wire  far_path_of_before_round = io_in_far_path_out_exp == 11'h7ff; // @[FADD.scala 337:18]
  wire  _far_path_of_after_round_T = io_in_far_path_out_exp == 11'h7fe; // @[FADD.scala 339:18]
  wire  far_path_of_after_round = far_path_rounder_io_cout & _far_path_of_after_round_T; // @[FADD.scala 338:58]
  wire  far_path_of = far_path_of_before_round | far_path_of_after_round | io_in_far_path_mul_of; // @[FADD.scala 342:57]
  wire  far_path_ix = far_path_rounder_io_inexact | far_path_of; // @[FADD.scala 343:49]
  wire  far_path_uf = far_path_may_uf & far_path_ix; // @[FADD.scala 344:37]
  wire [63:0] far_path_result = {io_in_far_path_out_sign,far_path_exp_rounded,far_path_rounder_io_out}; // @[Cat.scala 33:92]
  wire  near_path_is_zero = io_in_near_path_out_exp == 11'h0 & io_in_near_path_sig_is_zero; // @[FADD.scala 354:49]
  wire [10:0] _GEN_1 = {{10'd0}, near_path_rounder_io_cout}; // @[FADD.scala 368:57]
  wire [10:0] near_path_exp_rounded = _GEN_1 + io_in_near_path_out_exp; // @[FADD.scala 368:57]
  wire  near_path_zero_sign = io_in_rm == 3'h2; // @[FADD.scala 370:38]
  wire  _near_path_result_T_3 = io_in_near_path_out_sign & ~near_path_is_zero | near_path_zero_sign & near_path_is_zero; // @[FADD.scala 372:44]
  wire [63:0] near_path_result = {_near_path_result_T_3,near_path_exp_rounded,near_path_rounder_io_out}; // @[Cat.scala 33:92]
  wire  near_path_of = near_path_exp_rounded == 11'h7ff; // @[FADD.scala 377:44]
  wire  near_path_ix = near_path_rounder_io_inexact | near_path_of; // @[FADD.scala 378:51]
  wire  near_path_uf = near_path_tininess_rounder_io_tininess & near_path_ix; // @[FADD.scala 379:41]
  wire  _common_overflow_T_1 = ~io_in_sel_far_path; // @[FADD.scala 383:36]
  wire  common_overflow = io_in_sel_far_path & far_path_of | ~io_in_sel_far_path & near_path_of; // @[FADD.scala 383:33]
  wire  common_overflow_sign = io_in_sel_far_path ? io_in_far_path_overflow_sign : io_in_near_path_out_sign; // @[FADD.scala 385:8]
  wire  rmin = io_in_rm == 3'h1 | near_path_zero_sign & ~io_in_far_path_out_sign | io_in_rm == 3'h3 &
    io_in_far_path_out_sign; // @[RoundingUnit.scala 54:41]
  wire [10:0] common_overflow_exp = rmin ? 11'h7fe : 11'h7ff; // @[FADD.scala 387:32]
  wire [51:0] common_overflow_sig = rmin ? 52'hfffffffffffff : 52'h0; // @[FADD.scala 393:8]
  wire  common_underflow = io_in_sel_far_path & far_path_uf | _common_overflow_T_1 & near_path_uf; // @[FADD.scala 395:33]
  wire  common_inexact = io_in_sel_far_path & far_path_ix | _common_overflow_T_1 & near_path_ix; // @[FADD.scala 397:33]
  wire [4:0] common_fflags = {2'h0,common_overflow,common_underflow,common_inexact}; // @[Cat.scala 33:92]
  wire [63:0] _io_result_T = {common_overflow_sign,common_overflow_exp,common_overflow_sig}; // @[Cat.scala 33:92]
  wire [63:0] _io_result_T_1 = io_in_sel_far_path ? far_path_result : near_path_result; // @[FADD.scala 412:10]
  wire [63:0] _io_result_T_2 = common_overflow ? _io_result_T : _io_result_T_1; // @[FADD.scala 409:8]
  TininessRounder far_path_tininess_rounder ( // @[FADD.scala 317:41]
    .io_in_sign(far_path_tininess_rounder_io_in_sign),
    .io_in_sig(far_path_tininess_rounder_io_in_sig),
    .io_rm(far_path_tininess_rounder_io_rm),
    .io_tininess(far_path_tininess_rounder_io_tininess)
  );
  RoundingUnit far_path_rounder ( // @[RoundingUnit.scala 44:25]
    .io_in(far_path_rounder_io_in),
    .io_roundIn(far_path_rounder_io_roundIn),
    .io_stickyIn(far_path_rounder_io_stickyIn),
    .io_signIn(far_path_rounder_io_signIn),
    .io_rm(far_path_rounder_io_rm),
    .io_out(far_path_rounder_io_out),
    .io_inexact(far_path_rounder_io_inexact),
    .io_cout(far_path_rounder_io_cout)
  );
  TininessRounder near_path_tininess_rounder ( // @[FADD.scala 356:42]
    .io_in_sign(near_path_tininess_rounder_io_in_sign),
    .io_in_sig(near_path_tininess_rounder_io_in_sig),
    .io_rm(near_path_tininess_rounder_io_rm),
    .io_tininess(near_path_tininess_rounder_io_tininess)
  );
  RoundingUnit near_path_rounder ( // @[RoundingUnit.scala 44:25]
    .io_in(near_path_rounder_io_in),
    .io_roundIn(near_path_rounder_io_roundIn),
    .io_stickyIn(near_path_rounder_io_stickyIn),
    .io_signIn(near_path_rounder_io_signIn),
    .io_rm(near_path_rounder_io_rm),
    .io_out(near_path_rounder_io_out),
    .io_inexact(near_path_rounder_io_inexact),
    .io_cout(near_path_rounder_io_cout)
  );
  assign io_result = io_in_special_case_valid ? special_path_result : _io_result_T_2; // @[FADD.scala 406:19]
  assign io_fflags = io_in_special_case_valid ? special_path_fflags : common_fflags; // @[FADD.scala 415:19]
  assign far_path_tininess_rounder_io_in_sign = io_in_far_path_out_sign; // @[FADD.scala 318:35]
  assign far_path_tininess_rounder_io_in_sig = io_in_far_path_out_sig; // @[FADD.scala 318:35]
  assign far_path_tininess_rounder_io_rm = io_in_rm; // @[FADD.scala 319:35]
  assign far_path_rounder_io_in = io_in_far_path_out_sig[54:3]; // @[RoundingUnit.scala 45:33]
  assign far_path_rounder_io_roundIn = io_in_far_path_out_sig[2]; // @[RoundingUnit.scala 46:50]
  assign far_path_rounder_io_stickyIn = |io_in_far_path_out_sig[1:0]; // @[RoundingUnit.scala 47:54]
  assign far_path_rounder_io_signIn = io_in_far_path_out_sign; // @[RoundingUnit.scala 49:23]
  assign far_path_rounder_io_rm = io_in_rm; // @[RoundingUnit.scala 48:19]
  assign near_path_tininess_rounder_io_in_sign = io_in_near_path_out_sign; // @[FADD.scala 357:36]
  assign near_path_tininess_rounder_io_in_sig = io_in_near_path_out_sig; // @[FADD.scala 357:36]
  assign near_path_tininess_rounder_io_rm = io_in_rm; // @[FADD.scala 358:36]
  assign near_path_rounder_io_in = io_in_near_path_out_sig[54:3]; // @[RoundingUnit.scala 45:33]
  assign near_path_rounder_io_roundIn = io_in_near_path_out_sig[2]; // @[RoundingUnit.scala 46:50]
  assign near_path_rounder_io_stickyIn = |io_in_near_path_out_sig[1:0]; // @[RoundingUnit.scala 47:54]
  assign near_path_rounder_io_signIn = io_in_near_path_out_sign; // @[RoundingUnit.scala 49:23]
  assign near_path_rounder_io_rm = io_in_rm; // @[RoundingUnit.scala 48:19]
endmodule
module FADDPipe(
  input          clock,
  input          reset,
  output         io_in_ready,
  input          io_in_valid,
  input  [2:0]   io_in_bits_op,
  input  [63:0]  io_in_bits_a,
  input  [63:0]  io_in_bits_b,
  input  [2:0]   io_in_bits_rm,
  input  [5:0]   io_in_bits_ctrl_seq,
  input  [7:0]   io_in_bits_ctrl_dest,
  input  [3:0]   io_in_bits_ctrl_dtype,
  input          io_in_bits_ctrl_finite_fma,
  input          io_in_bits_ctrl_fma_sign,
  input          io_out_ready,
  output         io_out_valid,
  output [63:0]  io_out_bits_result,
  output [4:0]   io_out_bits_fflags,
  output [5:0]   io_out_bits_ctrl_seq,
  output [7:0]   io_out_bits_ctrl_dest,
  output [3:0]   io_out_bits_ctrl_dtype,
  output         io_out_bits_ctrl_finite_fma,
  output         io_out_bits_ctrl_fma_sign,
  input          fromMul_mulOutput_fp_prod_sign,
  input  [10:0]  fromMul_mulOutput_fp_prod_exp,
  input  [104:0] fromMul_mulOutput_fp_prod_sig,
  input          fromMul_mulOutput_inter_flags_isNaN,
  input          fromMul_mulOutput_inter_flags_isInf,
  input          fromMul_mulOutput_inter_flags_isInv,
  input          fromMul_mulOutput_inter_flags_overflow,
  input          fromMul_mulOutput_inter_flags_prod_sign,
  input  [63:0]  fromMul_addAnother,
  input  [2:0]   fromMul_rm
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
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
`endif // RANDOMIZE_REG_INIT
  wire [116:0] s1_io_a; // @[FMA.scala 80:18]
  wire [116:0] s1_io_b; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_valid; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_flags_isNaN; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_flags_isInf; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_flags_isInv; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_flags_overflow; // @[FMA.scala 80:18]
  wire  s1_io_b_inter_flags_prod_sign; // @[FMA.scala 80:18]
  wire [2:0] s1_io_rm; // @[FMA.scala 80:18]
  wire [2:0] s1_io_out_rm; // @[FMA.scala 80:18]
  wire  s1_io_out_far_path_out_sign; // @[FMA.scala 80:18]
  wire [10:0] s1_io_out_far_path_out_exp; // @[FMA.scala 80:18]
  wire [55:0] s1_io_out_far_path_out_sig; // @[FMA.scala 80:18]
  wire  s1_io_out_near_path_out_sign; // @[FMA.scala 80:18]
  wire [10:0] s1_io_out_near_path_out_exp; // @[FMA.scala 80:18]
  wire [55:0] s1_io_out_near_path_out_sig; // @[FMA.scala 80:18]
  wire  s1_io_out_special_case_valid; // @[FMA.scala 80:18]
  wire  s1_io_out_special_case_bits_iv; // @[FMA.scala 80:18]
  wire  s1_io_out_special_case_bits_nan; // @[FMA.scala 80:18]
  wire  s1_io_out_special_case_bits_inf_sign; // @[FMA.scala 80:18]
  wire  s1_io_out_small_add; // @[FMA.scala 80:18]
  wire  s1_io_out_far_path_mul_of; // @[FMA.scala 80:18]
  wire  s1_io_out_far_path_overflow_sign; // @[FMA.scala 80:18]
  wire  s1_io_out_near_path_sig_is_zero; // @[FMA.scala 80:18]
  wire  s1_io_out_sel_far_path; // @[FMA.scala 80:18]
  wire [2:0] s2_io_in_rm; // @[FMA.scala 81:18]
  wire  s2_io_in_far_path_out_sign; // @[FMA.scala 81:18]
  wire [10:0] s2_io_in_far_path_out_exp; // @[FMA.scala 81:18]
  wire [55:0] s2_io_in_far_path_out_sig; // @[FMA.scala 81:18]
  wire  s2_io_in_near_path_out_sign; // @[FMA.scala 81:18]
  wire [10:0] s2_io_in_near_path_out_exp; // @[FMA.scala 81:18]
  wire [55:0] s2_io_in_near_path_out_sig; // @[FMA.scala 81:18]
  wire  s2_io_in_special_case_valid; // @[FMA.scala 81:18]
  wire  s2_io_in_special_case_bits_iv; // @[FMA.scala 81:18]
  wire  s2_io_in_special_case_bits_nan; // @[FMA.scala 81:18]
  wire  s2_io_in_special_case_bits_inf_sign; // @[FMA.scala 81:18]
  wire  s2_io_in_small_add; // @[FMA.scala 81:18]
  wire  s2_io_in_far_path_mul_of; // @[FMA.scala 81:18]
  wire  s2_io_in_far_path_overflow_sign; // @[FMA.scala 81:18]
  wire  s2_io_in_near_path_sig_is_zero; // @[FMA.scala 81:18]
  wire  s2_io_in_sel_far_path; // @[FMA.scala 81:18]
  wire [63:0] s2_io_result; // @[FMA.scala 81:18]
  wire [4:0] s2_io_fflags; // @[FMA.scala 81:18]
  reg  REG; // @[HasPipelineReg.scala 16:58]
  wire  _T_1 = ~io_out_ready & REG; // @[HasPipelineReg.scala 18:26]
  wire  _T_2 = ~(~io_out_ready & REG); // @[HasPipelineReg.scala 18:10]
  wire  isFMA = io_in_bits_op[2]; // @[FPUOps.scala 72:9]
  wire [63:0] srcB = isFMA ? fromMul_addAnother : io_in_bits_b; // @[FMA.scala 88:17]
  wire  invAdd = io_in_bits_op[0]; // @[FPUOps.scala 89:7]
  wire [116:0] _add1_T = {fromMul_mulOutput_fp_prod_sign,fromMul_mulOutput_fp_prod_exp,fromMul_mulOutput_fp_prod_sig}; // @[FMA.scala 93:31]
  wire [116:0] _add1_T_2 = {io_in_bits_a,53'h0}; // @[Cat.scala 33:92]
  wire  _add2_T_1 = ~srcB[63]; // @[FPUSubModule.scala 76:9]
  wire [63:0] _add2_T_3 = {_add2_T_1,srcB[62:0]}; // @[Cat.scala 33:92]
  wire [63:0] _add2_T_4 = invAdd ? _add2_T_3 : srcB; // @[FMA.scala 97:8]
  wire  _s2_io_in_T_3 = io_in_valid & _T_2; // @[HasPipelineReg.scala 26:79]
  reg [2:0] s2_io_in_r_rm; // @[Reg.scala 19:16]
  reg  s2_io_in_r_far_path_out_sign; // @[Reg.scala 19:16]
  reg [10:0] s2_io_in_r_far_path_out_exp; // @[Reg.scala 19:16]
  reg [55:0] s2_io_in_r_far_path_out_sig; // @[Reg.scala 19:16]
  reg  s2_io_in_r_near_path_out_sign; // @[Reg.scala 19:16]
  reg [10:0] s2_io_in_r_near_path_out_exp; // @[Reg.scala 19:16]
  reg [55:0] s2_io_in_r_near_path_out_sig; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_valid; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_iv; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_nan; // @[Reg.scala 19:16]
  reg  s2_io_in_r_special_case_bits_inf_sign; // @[Reg.scala 19:16]
  reg  s2_io_in_r_small_add; // @[Reg.scala 19:16]
  reg  s2_io_in_r_far_path_mul_of; // @[Reg.scala 19:16]
  reg  s2_io_in_r_far_path_overflow_sign; // @[Reg.scala 19:16]
  reg  s2_io_in_r_near_path_sig_is_zero; // @[Reg.scala 19:16]
  reg  s2_io_in_r_sel_far_path; // @[Reg.scala 19:16]
  reg [5:0] io_out_bits_ctrl_r_seq; // @[Reg.scala 19:16]
  reg [7:0] io_out_bits_ctrl_r_dest; // @[Reg.scala 19:16]
  reg [3:0] io_out_bits_ctrl_r_dtype; // @[Reg.scala 19:16]
  reg  io_out_bits_ctrl_r_finite_fma; // @[Reg.scala 19:16]
  reg  io_out_bits_ctrl_r_fma_sign; // @[Reg.scala 19:16]
  FCMA_ADD_s1 s1 ( // @[FMA.scala 80:18]
    .io_a(s1_io_a),
    .io_b(s1_io_b),
    .io_b_inter_valid(s1_io_b_inter_valid),
    .io_b_inter_flags_isNaN(s1_io_b_inter_flags_isNaN),
    .io_b_inter_flags_isInf(s1_io_b_inter_flags_isInf),
    .io_b_inter_flags_isInv(s1_io_b_inter_flags_isInv),
    .io_b_inter_flags_overflow(s1_io_b_inter_flags_overflow),
    .io_b_inter_flags_prod_sign(s1_io_b_inter_flags_prod_sign),
    .io_rm(s1_io_rm),
    .io_out_rm(s1_io_out_rm),
    .io_out_far_path_out_sign(s1_io_out_far_path_out_sign),
    .io_out_far_path_out_exp(s1_io_out_far_path_out_exp),
    .io_out_far_path_out_sig(s1_io_out_far_path_out_sig),
    .io_out_near_path_out_sign(s1_io_out_near_path_out_sign),
    .io_out_near_path_out_exp(s1_io_out_near_path_out_exp),
    .io_out_near_path_out_sig(s1_io_out_near_path_out_sig),
    .io_out_special_case_valid(s1_io_out_special_case_valid),
    .io_out_special_case_bits_iv(s1_io_out_special_case_bits_iv),
    .io_out_special_case_bits_nan(s1_io_out_special_case_bits_nan),
    .io_out_special_case_bits_inf_sign(s1_io_out_special_case_bits_inf_sign),
    .io_out_small_add(s1_io_out_small_add),
    .io_out_far_path_mul_of(s1_io_out_far_path_mul_of),
    .io_out_far_path_overflow_sign(s1_io_out_far_path_overflow_sign),
    .io_out_near_path_sig_is_zero(s1_io_out_near_path_sig_is_zero),
    .io_out_sel_far_path(s1_io_out_sel_far_path)
  );
  FCMA_ADD_s2 s2 ( // @[FMA.scala 81:18]
    .io_in_rm(s2_io_in_rm),
    .io_in_far_path_out_sign(s2_io_in_far_path_out_sign),
    .io_in_far_path_out_exp(s2_io_in_far_path_out_exp),
    .io_in_far_path_out_sig(s2_io_in_far_path_out_sig),
    .io_in_near_path_out_sign(s2_io_in_near_path_out_sign),
    .io_in_near_path_out_exp(s2_io_in_near_path_out_exp),
    .io_in_near_path_out_sig(s2_io_in_near_path_out_sig),
    .io_in_special_case_valid(s2_io_in_special_case_valid),
    .io_in_special_case_bits_iv(s2_io_in_special_case_bits_iv),
    .io_in_special_case_bits_nan(s2_io_in_special_case_bits_nan),
    .io_in_special_case_bits_inf_sign(s2_io_in_special_case_bits_inf_sign),
    .io_in_small_add(s2_io_in_small_add),
    .io_in_far_path_mul_of(s2_io_in_far_path_mul_of),
    .io_in_far_path_overflow_sign(s2_io_in_far_path_overflow_sign),
    .io_in_near_path_sig_is_zero(s2_io_in_near_path_sig_is_zero),
    .io_in_sel_far_path(s2_io_in_sel_far_path),
    .io_result(s2_io_result),
    .io_fflags(s2_io_fflags)
  );
  assign io_in_ready = ~_T_1; // @[HasPipelineReg.scala 38:18]
  assign io_out_valid = REG; // @[HasPipelineReg.scala 39:16]
  assign io_out_bits_result = s2_io_result; // @[FMA.scala 110:22]
  assign io_out_bits_fflags = s2_io_fflags; // @[FMA.scala 111:22]
  assign io_out_bits_ctrl_seq = io_out_bits_ctrl_r_seq; // @[FMA.scala 112:31]
  assign io_out_bits_ctrl_dest = io_out_bits_ctrl_r_dest; // @[FMA.scala 112:31]
  assign io_out_bits_ctrl_dtype = io_out_bits_ctrl_r_dtype; // @[FMA.scala 112:31]
  assign io_out_bits_ctrl_finite_fma = io_out_bits_ctrl_r_finite_fma; // @[FMA.scala 112:31]
  assign io_out_bits_ctrl_fma_sign = io_out_bits_ctrl_r_fma_sign; // @[FMA.scala 112:31]
  assign s1_io_a = isFMA ? _add1_T : _add1_T_2; // @[FMA.scala 92:17]
  assign s1_io_b = {_add2_T_4,53'h0}; // @[Cat.scala 33:92]
  assign s1_io_b_inter_valid = io_in_bits_op[2]; // @[FPUOps.scala 72:9]
  assign s1_io_b_inter_flags_isNaN = isFMA & fromMul_mulOutput_inter_flags_isNaN; // @[FMA.scala 103:29]
  assign s1_io_b_inter_flags_isInf = isFMA & fromMul_mulOutput_inter_flags_isInf; // @[FMA.scala 103:29]
  assign s1_io_b_inter_flags_isInv = isFMA & fromMul_mulOutput_inter_flags_isInv; // @[FMA.scala 103:29]
  assign s1_io_b_inter_flags_overflow = isFMA & fromMul_mulOutput_inter_flags_overflow; // @[FMA.scala 103:29]
  assign s1_io_b_inter_flags_prod_sign = isFMA & fromMul_mulOutput_inter_flags_prod_sign; // @[FMA.scala 103:29]
  assign s1_io_rm = isFMA ? fromMul_rm : io_in_bits_rm; // @[FMA.scala 107:18]
  assign s2_io_in_rm = s2_io_in_r_rm; // @[FMA.scala 108:12]
  assign s2_io_in_far_path_out_sign = s2_io_in_r_far_path_out_sign; // @[FMA.scala 108:12]
  assign s2_io_in_far_path_out_exp = s2_io_in_r_far_path_out_exp; // @[FMA.scala 108:12]
  assign s2_io_in_far_path_out_sig = s2_io_in_r_far_path_out_sig; // @[FMA.scala 108:12]
  assign s2_io_in_near_path_out_sign = s2_io_in_r_near_path_out_sign; // @[FMA.scala 108:12]
  assign s2_io_in_near_path_out_exp = s2_io_in_r_near_path_out_exp; // @[FMA.scala 108:12]
  assign s2_io_in_near_path_out_sig = s2_io_in_r_near_path_out_sig; // @[FMA.scala 108:12]
  assign s2_io_in_special_case_valid = s2_io_in_r_special_case_valid; // @[FMA.scala 108:12]
  assign s2_io_in_special_case_bits_iv = s2_io_in_r_special_case_bits_iv; // @[FMA.scala 108:12]
  assign s2_io_in_special_case_bits_nan = s2_io_in_r_special_case_bits_nan; // @[FMA.scala 108:12]
  assign s2_io_in_special_case_bits_inf_sign = s2_io_in_r_special_case_bits_inf_sign; // @[FMA.scala 108:12]
  assign s2_io_in_small_add = s2_io_in_r_small_add; // @[FMA.scala 108:12]
  assign s2_io_in_far_path_mul_of = s2_io_in_r_far_path_mul_of; // @[FMA.scala 108:12]
  assign s2_io_in_far_path_overflow_sign = s2_io_in_r_far_path_overflow_sign; // @[FMA.scala 108:12]
  assign s2_io_in_near_path_sig_is_zero = s2_io_in_r_near_path_sig_is_zero; // @[FMA.scala 108:12]
  assign s2_io_in_sel_far_path = s2_io_in_r_sel_far_path; // @[FMA.scala 108:12]
  always @(posedge clock) begin
    if (reset) begin // @[HasPipelineReg.scala 16:58]
      REG <= 1'h0; // @[HasPipelineReg.scala 16:58]
    end else if (~(~io_out_ready & REG)) begin // @[HasPipelineReg.scala 18:61]
      REG <= io_in_valid; // @[HasPipelineReg.scala 19:17]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_rm <= s1_io_out_rm; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_far_path_out_sign <= s1_io_out_far_path_out_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_far_path_out_exp <= s1_io_out_far_path_out_exp; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_far_path_out_sig <= s1_io_out_far_path_out_sig; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_near_path_out_sign <= s1_io_out_near_path_out_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_near_path_out_exp <= s1_io_out_near_path_out_exp; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_near_path_out_sig <= s1_io_out_near_path_out_sig; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_valid <= s1_io_out_special_case_valid; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_iv <= s1_io_out_special_case_bits_iv; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_nan <= s1_io_out_special_case_bits_nan; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_special_case_bits_inf_sign <= s1_io_out_special_case_bits_inf_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_small_add <= s1_io_out_small_add; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_far_path_mul_of <= s1_io_out_far_path_mul_of; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_far_path_overflow_sign <= s1_io_out_far_path_overflow_sign; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_near_path_sig_is_zero <= s1_io_out_near_path_sig_is_zero; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      s2_io_in_r_sel_far_path <= s1_io_out_sel_far_path; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      io_out_bits_ctrl_r_seq <= io_in_bits_ctrl_seq; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      io_out_bits_ctrl_r_dest <= io_in_bits_ctrl_dest; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      io_out_bits_ctrl_r_dtype <= io_in_bits_ctrl_dtype; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      io_out_bits_ctrl_r_finite_fma <= io_in_bits_ctrl_finite_fma; // @[Reg.scala 20:22]
    end
    if (_s2_io_in_T_3) begin // @[Reg.scala 20:18]
      io_out_bits_ctrl_r_fma_sign <= io_in_bits_ctrl_fma_sign; // @[Reg.scala 20:22]
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
  REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  s2_io_in_r_rm = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  s2_io_in_r_far_path_out_sign = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s2_io_in_r_far_path_out_exp = _RAND_3[10:0];
  _RAND_4 = {2{`RANDOM}};
  s2_io_in_r_far_path_out_sig = _RAND_4[55:0];
  _RAND_5 = {1{`RANDOM}};
  s2_io_in_r_near_path_out_sign = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s2_io_in_r_near_path_out_exp = _RAND_6[10:0];
  _RAND_7 = {2{`RANDOM}};
  s2_io_in_r_near_path_out_sig = _RAND_7[55:0];
  _RAND_8 = {1{`RANDOM}};
  s2_io_in_r_special_case_valid = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_iv = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_nan = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  s2_io_in_r_special_case_bits_inf_sign = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  s2_io_in_r_small_add = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  s2_io_in_r_far_path_mul_of = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  s2_io_in_r_far_path_overflow_sign = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  s2_io_in_r_near_path_sig_is_zero = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  s2_io_in_r_sel_far_path = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_out_bits_ctrl_r_seq = _RAND_17[5:0];
  _RAND_18 = {1{`RANDOM}};
  io_out_bits_ctrl_r_dest = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  io_out_bits_ctrl_r_dtype = _RAND_19[3:0];
  _RAND_20 = {1{`RANDOM}};
  io_out_bits_ctrl_r_finite_fma = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  io_out_bits_ctrl_r_fma_sign = _RAND_21[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Arbiter(
  output       io_in_0_ready,
  input        io_in_0_valid,
  input  [5:0] io_in_0_bits_ctrl_seq,
  input  [7:0] io_in_0_bits_ctrl_dest,
  input  [3:0] io_in_0_bits_ctrl_dtype,
  input        io_in_0_bits_ctrl_finite_fma,
  input        io_in_0_bits_ctrl_fma_sign,
  input  [2:0] io_in_0_bits_op,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [5:0] io_in_1_bits_ctrl_seq,
  input  [7:0] io_in_1_bits_ctrl_dest,
  input  [3:0] io_in_1_bits_ctrl_dtype,
  input        io_in_1_bits_ctrl_finite_fma,
  input        io_in_1_bits_ctrl_fma_sign,
  input  [2:0] io_in_1_bits_op,
  input        io_out_ready,
  output       io_out_valid,
  output [5:0] io_out_bits_ctrl_seq,
  output [7:0] io_out_bits_ctrl_dest,
  output [3:0] io_out_bits_ctrl_dtype,
  output       io_out_bits_ctrl_finite_fma,
  output       io_out_bits_ctrl_fma_sign,
  output [2:0] io_out_bits_op
);
  wire  grant_1 = ~io_in_0_valid; // @[Arbiter.scala 45:78]
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 146:19]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[Arbiter.scala 146:19]
  assign io_out_valid = ~grant_1 | io_in_1_valid; // @[Arbiter.scala 147:31]
  assign io_out_bits_ctrl_seq = io_in_0_valid ? io_in_0_bits_ctrl_seq : io_in_1_bits_ctrl_seq; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_dest = io_in_0_valid ? io_in_0_bits_ctrl_dest : io_in_1_bits_ctrl_dest; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_dtype = io_in_0_valid ? io_in_0_bits_ctrl_dtype : io_in_1_bits_ctrl_dtype; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_finite_fma = io_in_0_valid ? io_in_0_bits_ctrl_finite_fma : io_in_1_bits_ctrl_finite_fma; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_fma_sign = io_in_0_valid ? io_in_0_bits_ctrl_fma_sign : io_in_1_bits_ctrl_fma_sign; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_op = io_in_0_valid ? io_in_0_bits_op : io_in_1_bits_op; // @[Arbiter.scala 136:15 138:26 140:19]
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [5:0] io_enq_bits_ctrl_seq,
  input  [7:0] io_enq_bits_ctrl_dest,
  input  [3:0] io_enq_bits_ctrl_dtype,
  input        io_enq_bits_ctrl_finite_fma,
  input        io_enq_bits_ctrl_fma_sign,
  input  [2:0] io_enq_bits_op,
  input        io_deq_ready,
  output       io_deq_valid,
  output [5:0] io_deq_bits_ctrl_seq,
  output [7:0] io_deq_bits_ctrl_dest,
  output [3:0] io_deq_bits_ctrl_dtype,
  output       io_deq_bits_ctrl_finite_fma,
  output       io_deq_bits_ctrl_fma_sign,
  output [2:0] io_deq_bits_op
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ram_ctrl_seq [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_en; // @[Decoupled.scala 273:95]
  reg [7:0] ram_ctrl_dest [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_ctrl_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_ctrl_dest_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] ram_ctrl_dtype [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_ctrl_dtype_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_ctrl_finite_fma [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_ctrl_fma_sign [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] ram_op [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_op_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_op_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [2:0] ram_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_op_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_en; // @[Decoupled.scala 273:95]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 278:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  assign ram_ctrl_seq_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_seq_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_io_deq_bits_MPORT_data = ram_ctrl_seq[ram_ctrl_seq_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_seq_MPORT_data = io_enq_bits_ctrl_seq;
  assign ram_ctrl_seq_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_MPORT_mask = 1'h1;
  assign ram_ctrl_seq_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_dest_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_dest_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_dest_io_deq_bits_MPORT_data = ram_ctrl_dest[ram_ctrl_dest_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_dest_MPORT_data = io_enq_bits_ctrl_dest;
  assign ram_ctrl_dest_MPORT_addr = 1'h0;
  assign ram_ctrl_dest_MPORT_mask = 1'h1;
  assign ram_ctrl_dest_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_data = ram_ctrl_dtype[ram_ctrl_dtype_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_dtype_MPORT_data = io_enq_bits_ctrl_dtype;
  assign ram_ctrl_dtype_MPORT_addr = 1'h0;
  assign ram_ctrl_dtype_MPORT_mask = 1'h1;
  assign ram_ctrl_dtype_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_data = ram_ctrl_finite_fma[ram_ctrl_finite_fma_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_finite_fma_MPORT_data = io_enq_bits_ctrl_finite_fma;
  assign ram_ctrl_finite_fma_MPORT_addr = 1'h0;
  assign ram_ctrl_finite_fma_MPORT_mask = 1'h1;
  assign ram_ctrl_finite_fma_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_data = ram_ctrl_fma_sign[ram_ctrl_fma_sign_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_fma_sign_MPORT_data = io_enq_bits_ctrl_fma_sign;
  assign ram_ctrl_fma_sign_MPORT_addr = 1'h0;
  assign ram_ctrl_fma_sign_MPORT_mask = 1'h1;
  assign ram_ctrl_fma_sign_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_op_io_deq_bits_MPORT_en = 1'h1;
  assign ram_op_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_op_io_deq_bits_MPORT_data = ram_op[ram_op_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_op_MPORT_data = io_enq_bits_op;
  assign ram_op_MPORT_addr = 1'h0;
  assign ram_op_MPORT_mask = 1'h1;
  assign ram_op_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_ctrl_seq = ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_dest = ram_ctrl_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_dtype = ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_finite_fma = ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_fma_sign = ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_op = ram_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_ctrl_seq_MPORT_en & ram_ctrl_seq_MPORT_mask) begin
      ram_ctrl_seq[ram_ctrl_seq_MPORT_addr] <= ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_dest_MPORT_en & ram_ctrl_dest_MPORT_mask) begin
      ram_ctrl_dest[ram_ctrl_dest_MPORT_addr] <= ram_ctrl_dest_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_dtype_MPORT_en & ram_ctrl_dtype_MPORT_mask) begin
      ram_ctrl_dtype[ram_ctrl_dtype_MPORT_addr] <= ram_ctrl_dtype_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_finite_fma_MPORT_en & ram_ctrl_finite_fma_MPORT_mask) begin
      ram_ctrl_finite_fma[ram_ctrl_finite_fma_MPORT_addr] <= ram_ctrl_finite_fma_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_fma_sign_MPORT_en & ram_ctrl_fma_sign_MPORT_mask) begin
      ram_ctrl_fma_sign[ram_ctrl_fma_sign_MPORT_addr] <= ram_ctrl_fma_sign_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_op_MPORT_en & ram_op_MPORT_mask) begin
      ram_op[ram_op_MPORT_addr] <= ram_op_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_seq[initvar] = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_dest[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_dtype[initvar] = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_finite_fma[initvar] = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_fma_sign[initvar] = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_op[initvar] = _RAND_5[2:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  maybe_full = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_2(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_a,
  input  [63:0] io_enq_bits_b,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_a,
  output [63:0] io_deq_bits_b,
  output [2:0]  io_deq_bits_rm
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_a [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_a_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_a_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_a_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_a_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_a_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_a_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_a_MPORT_en; // @[Decoupled.scala 273:95]
  reg [63:0] ram_b [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_b_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_b_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_b_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_b_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_b_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_b_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_b_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] ram_rm [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_rm_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_rm_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [2:0] ram_rm_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_rm_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_en; // @[Decoupled.scala 273:95]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 278:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  assign ram_a_io_deq_bits_MPORT_en = 1'h1;
  assign ram_a_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_a_io_deq_bits_MPORT_data = ram_a[ram_a_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_a_MPORT_data = io_enq_bits_a;
  assign ram_a_MPORT_addr = 1'h0;
  assign ram_a_MPORT_mask = 1'h1;
  assign ram_a_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_b_io_deq_bits_MPORT_en = 1'h1;
  assign ram_b_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_b_io_deq_bits_MPORT_data = ram_b[ram_b_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_b_MPORT_data = io_enq_bits_b;
  assign ram_b_MPORT_addr = 1'h0;
  assign ram_b_MPORT_mask = 1'h1;
  assign ram_b_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_rm_io_deq_bits_MPORT_en = 1'h1;
  assign ram_rm_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_rm_io_deq_bits_MPORT_data = ram_rm[ram_rm_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_rm_MPORT_data = 3'h0;
  assign ram_rm_MPORT_addr = 1'h0;
  assign ram_rm_MPORT_mask = 1'h1;
  assign ram_rm_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_a = ram_a_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_b = ram_b_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_rm = ram_rm_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_a_MPORT_en & ram_a_MPORT_mask) begin
      ram_a[ram_a_MPORT_addr] <= ram_a_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_b_MPORT_en & ram_b_MPORT_mask) begin
      ram_b[ram_b_MPORT_addr] <= ram_b_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_rm_MPORT_en & ram_rm_MPORT_mask) begin
      ram_rm[ram_rm_MPORT_addr] <= ram_rm_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_a[initvar] = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_b[initvar] = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_rm[initvar] = _RAND_2[2:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_3(
  input          clock,
  input          reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input          io_enq_bits_mulOutput_fp_prod_sign,
  input  [10:0]  io_enq_bits_mulOutput_fp_prod_exp,
  input  [104:0] io_enq_bits_mulOutput_fp_prod_sig,
  input          io_enq_bits_mulOutput_inter_flags_isNaN,
  input          io_enq_bits_mulOutput_inter_flags_isInf,
  input          io_enq_bits_mulOutput_inter_flags_isInv,
  input          io_enq_bits_mulOutput_inter_flags_overflow,
  input          io_enq_bits_mulOutput_inter_flags_prod_sign,
  input  [63:0]  io_enq_bits_addAnother,
  input          io_deq_ready,
  output         io_deq_valid,
  output         io_deq_bits_mulOutput_fp_prod_sign,
  output [10:0]  io_deq_bits_mulOutput_fp_prod_exp,
  output [104:0] io_deq_bits_mulOutput_fp_prod_sig,
  output         io_deq_bits_mulOutput_inter_flags_isNaN,
  output         io_deq_bits_mulOutput_inter_flags_isInf,
  output         io_deq_bits_mulOutput_inter_flags_isInv,
  output         io_deq_bits_mulOutput_inter_flags_overflow,
  output         io_deq_bits_mulOutput_inter_flags_prod_sign,
  output [63:0]  io_deq_bits_addAnother,
  output [2:0]   io_deq_bits_rm
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [127:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  ram_mulOutput_fp_prod_sign [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sign_MPORT_en; // @[Decoupled.scala 273:95]
  reg [10:0] ram_mulOutput_fp_prod_exp [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [10:0] ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [10:0] ram_mulOutput_fp_prod_exp_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_exp_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_exp_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_exp_MPORT_en; // @[Decoupled.scala 273:95]
  reg [104:0] ram_mulOutput_fp_prod_sig [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [104:0] ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [104:0] ram_mulOutput_fp_prod_sig_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sig_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sig_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_fp_prod_sig_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_mulOutput_inter_flags_isNaN [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isNaN_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_mulOutput_inter_flags_isInf [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInf_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_mulOutput_inter_flags_isInv [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_isInv_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_mulOutput_inter_flags_overflow [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_overflow_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_mulOutput_inter_flags_prod_sign [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_mulOutput_inter_flags_prod_sign_MPORT_en; // @[Decoupled.scala 273:95]
  reg [63:0] ram_addAnother [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_addAnother_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_addAnother_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_addAnother_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_addAnother_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_addAnother_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_addAnother_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_addAnother_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] ram_rm [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_rm_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_rm_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [2:0] ram_rm_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_rm_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_rm_MPORT_en; // @[Decoupled.scala 273:95]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 278:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  assign ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_data =
    ram_mulOutput_fp_prod_sign[ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_fp_prod_sign_MPORT_data = io_enq_bits_mulOutput_fp_prod_sign;
  assign ram_mulOutput_fp_prod_sign_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_sign_MPORT_mask = 1'h1;
  assign ram_mulOutput_fp_prod_sign_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_data =
    ram_mulOutput_fp_prod_exp[ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_fp_prod_exp_MPORT_data = io_enq_bits_mulOutput_fp_prod_exp;
  assign ram_mulOutput_fp_prod_exp_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_exp_MPORT_mask = 1'h1;
  assign ram_mulOutput_fp_prod_exp_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_data =
    ram_mulOutput_fp_prod_sig[ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_fp_prod_sig_MPORT_data = io_enq_bits_mulOutput_fp_prod_sig;
  assign ram_mulOutput_fp_prod_sig_MPORT_addr = 1'h0;
  assign ram_mulOutput_fp_prod_sig_MPORT_mask = 1'h1;
  assign ram_mulOutput_fp_prod_sig_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_data =
    ram_mulOutput_inter_flags_isNaN[ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_inter_flags_isNaN_MPORT_data = io_enq_bits_mulOutput_inter_flags_isNaN;
  assign ram_mulOutput_inter_flags_isNaN_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isNaN_MPORT_mask = 1'h1;
  assign ram_mulOutput_inter_flags_isNaN_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_data =
    ram_mulOutput_inter_flags_isInf[ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_inter_flags_isInf_MPORT_data = io_enq_bits_mulOutput_inter_flags_isInf;
  assign ram_mulOutput_inter_flags_isInf_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isInf_MPORT_mask = 1'h1;
  assign ram_mulOutput_inter_flags_isInf_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_data =
    ram_mulOutput_inter_flags_isInv[ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_inter_flags_isInv_MPORT_data = io_enq_bits_mulOutput_inter_flags_isInv;
  assign ram_mulOutput_inter_flags_isInv_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_isInv_MPORT_mask = 1'h1;
  assign ram_mulOutput_inter_flags_isInv_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_data =
    ram_mulOutput_inter_flags_overflow[ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_inter_flags_overflow_MPORT_data = io_enq_bits_mulOutput_inter_flags_overflow;
  assign ram_mulOutput_inter_flags_overflow_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_overflow_MPORT_mask = 1'h1;
  assign ram_mulOutput_inter_flags_overflow_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_data =
    ram_mulOutput_inter_flags_prod_sign[ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_mulOutput_inter_flags_prod_sign_MPORT_data = io_enq_bits_mulOutput_inter_flags_prod_sign;
  assign ram_mulOutput_inter_flags_prod_sign_MPORT_addr = 1'h0;
  assign ram_mulOutput_inter_flags_prod_sign_MPORT_mask = 1'h1;
  assign ram_mulOutput_inter_flags_prod_sign_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_addAnother_io_deq_bits_MPORT_en = 1'h1;
  assign ram_addAnother_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_addAnother_io_deq_bits_MPORT_data = ram_addAnother[ram_addAnother_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_addAnother_MPORT_data = io_enq_bits_addAnother;
  assign ram_addAnother_MPORT_addr = 1'h0;
  assign ram_addAnother_MPORT_mask = 1'h1;
  assign ram_addAnother_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_rm_io_deq_bits_MPORT_en = 1'h1;
  assign ram_rm_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_rm_io_deq_bits_MPORT_data = ram_rm[ram_rm_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_rm_MPORT_data = 3'h0;
  assign ram_rm_MPORT_addr = 1'h0;
  assign ram_rm_MPORT_mask = 1'h1;
  assign ram_rm_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_mulOutput_fp_prod_sign = ram_mulOutput_fp_prod_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_fp_prod_exp = ram_mulOutput_fp_prod_exp_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_fp_prod_sig = ram_mulOutput_fp_prod_sig_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_inter_flags_isNaN = ram_mulOutput_inter_flags_isNaN_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_inter_flags_isInf = ram_mulOutput_inter_flags_isInf_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_inter_flags_isInv = ram_mulOutput_inter_flags_isInv_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_inter_flags_overflow = ram_mulOutput_inter_flags_overflow_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_mulOutput_inter_flags_prod_sign = ram_mulOutput_inter_flags_prod_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_addAnother = ram_addAnother_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_rm = ram_rm_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_mulOutput_fp_prod_sign_MPORT_en & ram_mulOutput_fp_prod_sign_MPORT_mask) begin
      ram_mulOutput_fp_prod_sign[ram_mulOutput_fp_prod_sign_MPORT_addr] <= ram_mulOutput_fp_prod_sign_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_fp_prod_exp_MPORT_en & ram_mulOutput_fp_prod_exp_MPORT_mask) begin
      ram_mulOutput_fp_prod_exp[ram_mulOutput_fp_prod_exp_MPORT_addr] <= ram_mulOutput_fp_prod_exp_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_fp_prod_sig_MPORT_en & ram_mulOutput_fp_prod_sig_MPORT_mask) begin
      ram_mulOutput_fp_prod_sig[ram_mulOutput_fp_prod_sig_MPORT_addr] <= ram_mulOutput_fp_prod_sig_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_inter_flags_isNaN_MPORT_en & ram_mulOutput_inter_flags_isNaN_MPORT_mask) begin
      ram_mulOutput_inter_flags_isNaN[ram_mulOutput_inter_flags_isNaN_MPORT_addr] <=
        ram_mulOutput_inter_flags_isNaN_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_inter_flags_isInf_MPORT_en & ram_mulOutput_inter_flags_isInf_MPORT_mask) begin
      ram_mulOutput_inter_flags_isInf[ram_mulOutput_inter_flags_isInf_MPORT_addr] <=
        ram_mulOutput_inter_flags_isInf_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_inter_flags_isInv_MPORT_en & ram_mulOutput_inter_flags_isInv_MPORT_mask) begin
      ram_mulOutput_inter_flags_isInv[ram_mulOutput_inter_flags_isInv_MPORT_addr] <=
        ram_mulOutput_inter_flags_isInv_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_inter_flags_overflow_MPORT_en & ram_mulOutput_inter_flags_overflow_MPORT_mask) begin
      ram_mulOutput_inter_flags_overflow[ram_mulOutput_inter_flags_overflow_MPORT_addr] <=
        ram_mulOutput_inter_flags_overflow_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_mulOutput_inter_flags_prod_sign_MPORT_en & ram_mulOutput_inter_flags_prod_sign_MPORT_mask) begin
      ram_mulOutput_inter_flags_prod_sign[ram_mulOutput_inter_flags_prod_sign_MPORT_addr] <=
        ram_mulOutput_inter_flags_prod_sign_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_addAnother_MPORT_en & ram_addAnother_MPORT_mask) begin
      ram_addAnother[ram_addAnother_MPORT_addr] <= ram_addAnother_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_rm_MPORT_en & ram_rm_MPORT_mask) begin
      ram_rm[ram_rm_MPORT_addr] <= ram_rm_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_fp_prod_sign[initvar] = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_fp_prod_exp[initvar] = _RAND_1[10:0];
  _RAND_2 = {4{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_fp_prod_sig[initvar] = _RAND_2[104:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_inter_flags_isNaN[initvar] = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_inter_flags_isInf[initvar] = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_inter_flags_isInv[initvar] = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_inter_flags_overflow[initvar] = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mulOutput_inter_flags_prod_sign[initvar] = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_addAnother[initvar] = _RAND_8[63:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_rm[initvar] = _RAND_9[2:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  maybe_full = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_4(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_result,
  input  [4:0]  io_enq_bits_fflags,
  input  [5:0]  io_enq_bits_ctrl_seq,
  input  [7:0]  io_enq_bits_ctrl_dest,
  input  [3:0]  io_enq_bits_ctrl_dtype,
  input         io_enq_bits_ctrl_finite_fma,
  input         io_enq_bits_ctrl_fma_sign,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_result,
  output [4:0]  io_deq_bits_fflags,
  output [5:0]  io_deq_bits_ctrl_seq,
  output [7:0]  io_deq_bits_ctrl_dest,
  output [3:0]  io_deq_bits_ctrl_dtype,
  output        io_deq_bits_ctrl_finite_fma,
  output        io_deq_bits_ctrl_fma_sign
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_result [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_result_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_result_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_result_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_result_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_result_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_result_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_result_MPORT_en; // @[Decoupled.scala 273:95]
  reg [4:0] ram_fflags [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_fflags_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_fflags_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [4:0] ram_fflags_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [4:0] ram_fflags_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_fflags_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_fflags_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_fflags_MPORT_en; // @[Decoupled.scala 273:95]
  reg [5:0] ram_ctrl_seq [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_en; // @[Decoupled.scala 273:95]
  reg [7:0] ram_ctrl_dest [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_ctrl_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_ctrl_dest_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dest_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] ram_ctrl_dtype [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_ctrl_dtype_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_dtype_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_ctrl_finite_fma [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_finite_fma_MPORT_en; // @[Decoupled.scala 273:95]
  reg  ram_ctrl_fma_sign [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_fma_sign_MPORT_en; // @[Decoupled.scala 273:95]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 278:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  assign ram_result_io_deq_bits_MPORT_en = 1'h1;
  assign ram_result_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_result_io_deq_bits_MPORT_data = ram_result[ram_result_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_result_MPORT_data = io_enq_bits_result;
  assign ram_result_MPORT_addr = 1'h0;
  assign ram_result_MPORT_mask = 1'h1;
  assign ram_result_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_fflags_io_deq_bits_MPORT_en = 1'h1;
  assign ram_fflags_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_fflags_io_deq_bits_MPORT_data = ram_fflags[ram_fflags_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_fflags_MPORT_data = io_enq_bits_fflags;
  assign ram_fflags_MPORT_addr = 1'h0;
  assign ram_fflags_MPORT_mask = 1'h1;
  assign ram_fflags_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_seq_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_seq_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_io_deq_bits_MPORT_data = ram_ctrl_seq[ram_ctrl_seq_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_seq_MPORT_data = io_enq_bits_ctrl_seq;
  assign ram_ctrl_seq_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_MPORT_mask = 1'h1;
  assign ram_ctrl_seq_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_dest_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_dest_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_dest_io_deq_bits_MPORT_data = ram_ctrl_dest[ram_ctrl_dest_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_dest_MPORT_data = io_enq_bits_ctrl_dest;
  assign ram_ctrl_dest_MPORT_addr = 1'h0;
  assign ram_ctrl_dest_MPORT_mask = 1'h1;
  assign ram_ctrl_dest_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_dtype_io_deq_bits_MPORT_data = ram_ctrl_dtype[ram_ctrl_dtype_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_dtype_MPORT_data = io_enq_bits_ctrl_dtype;
  assign ram_ctrl_dtype_MPORT_addr = 1'h0;
  assign ram_ctrl_dtype_MPORT_mask = 1'h1;
  assign ram_ctrl_dtype_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_finite_fma_io_deq_bits_MPORT_data = ram_ctrl_finite_fma[ram_ctrl_finite_fma_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_finite_fma_MPORT_data = io_enq_bits_ctrl_finite_fma;
  assign ram_ctrl_finite_fma_MPORT_addr = 1'h0;
  assign ram_ctrl_finite_fma_MPORT_mask = 1'h1;
  assign ram_ctrl_finite_fma_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_fma_sign_io_deq_bits_MPORT_data = ram_ctrl_fma_sign[ram_ctrl_fma_sign_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_fma_sign_MPORT_data = io_enq_bits_ctrl_fma_sign;
  assign ram_ctrl_fma_sign_MPORT_addr = 1'h0;
  assign ram_ctrl_fma_sign_MPORT_mask = 1'h1;
  assign ram_ctrl_fma_sign_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_result = ram_result_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_fflags = ram_fflags_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_seq = ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_dest = ram_ctrl_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_dtype = ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_finite_fma = ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_fma_sign = ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_result_MPORT_en & ram_result_MPORT_mask) begin
      ram_result[ram_result_MPORT_addr] <= ram_result_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_fflags_MPORT_en & ram_fflags_MPORT_mask) begin
      ram_fflags[ram_fflags_MPORT_addr] <= ram_fflags_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_seq_MPORT_en & ram_ctrl_seq_MPORT_mask) begin
      ram_ctrl_seq[ram_ctrl_seq_MPORT_addr] <= ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_dest_MPORT_en & ram_ctrl_dest_MPORT_mask) begin
      ram_ctrl_dest[ram_ctrl_dest_MPORT_addr] <= ram_ctrl_dest_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_dtype_MPORT_en & ram_ctrl_dtype_MPORT_mask) begin
      ram_ctrl_dtype[ram_ctrl_dtype_MPORT_addr] <= ram_ctrl_dtype_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_finite_fma_MPORT_en & ram_ctrl_finite_fma_MPORT_mask) begin
      ram_ctrl_finite_fma[ram_ctrl_finite_fma_MPORT_addr] <= ram_ctrl_finite_fma_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_fma_sign_MPORT_en & ram_ctrl_fma_sign_MPORT_mask) begin
      ram_ctrl_fma_sign[ram_ctrl_fma_sign_MPORT_addr] <= ram_ctrl_fma_sign_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_result[initvar] = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_fflags[initvar] = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_seq[initvar] = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_dest[initvar] = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_dtype[initvar] = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_finite_fma[initvar] = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_fma_sign[initvar] = _RAND_6[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  maybe_full = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Arbiter_1(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits_result,
  input  [4:0]  io_in_0_bits_fflags,
  input  [5:0]  io_in_0_bits_ctrl_seq,
  input  [7:0]  io_in_0_bits_ctrl_dest,
  input  [3:0]  io_in_0_bits_ctrl_dtype,
  input         io_in_0_bits_ctrl_finite_fma,
  input         io_in_0_bits_ctrl_fma_sign,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits_result,
  input  [4:0]  io_in_1_bits_fflags,
  input  [5:0]  io_in_1_bits_ctrl_seq,
  input  [7:0]  io_in_1_bits_ctrl_dest,
  input  [3:0]  io_in_1_bits_ctrl_dtype,
  input         io_in_1_bits_ctrl_finite_fma,
  input         io_in_1_bits_ctrl_fma_sign,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_result,
  output [4:0]  io_out_bits_fflags,
  output [5:0]  io_out_bits_ctrl_seq,
  output [7:0]  io_out_bits_ctrl_dest,
  output [3:0]  io_out_bits_ctrl_dtype,
  output        io_out_bits_ctrl_finite_fma,
  output        io_out_bits_ctrl_fma_sign
);
  wire  grant_1 = ~io_in_0_valid; // @[Arbiter.scala 45:78]
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 146:19]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[Arbiter.scala 146:19]
  assign io_out_valid = ~grant_1 | io_in_1_valid; // @[Arbiter.scala 147:31]
  assign io_out_bits_result = io_in_0_valid ? io_in_0_bits_result : io_in_1_bits_result; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_fflags = io_in_0_valid ? io_in_0_bits_fflags : io_in_1_bits_fflags; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_seq = io_in_0_valid ? io_in_0_bits_ctrl_seq : io_in_1_bits_ctrl_seq; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_dest = io_in_0_valid ? io_in_0_bits_ctrl_dest : io_in_1_bits_ctrl_dest; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_dtype = io_in_0_valid ? io_in_0_bits_ctrl_dtype : io_in_1_bits_ctrl_dtype; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_finite_fma = io_in_0_valid ? io_in_0_bits_ctrl_finite_fma : io_in_1_bits_ctrl_finite_fma; // @[Arbiter.scala 136:15 138:26 140:19]
  assign io_out_bits_ctrl_fma_sign = io_in_0_valid ? io_in_0_bits_ctrl_fma_sign : io_in_1_bits_ctrl_fma_sign; // @[Arbiter.scala 136:15 138:26 140:19]
endmodule
module FMA(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [2:0]  io_in_bits_op,
  input  [63:0] io_in_bits_a,
  input  [63:0] io_in_bits_b,
  input  [63:0] io_in_bits_c,
  input  [5:0]  io_in_bits_ctrl_seq,
  input  [7:0]  io_in_bits_ctrl_dest,
  input  [3:0]  io_in_bits_ctrl_dtype,
  input         io_in_bits_ctrl_finite_fma,
  input         io_in_bits_ctrl_fma_sign,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_result,
  output [4:0]  io_out_bits_fflags,
  output [5:0]  io_out_bits_ctrl_seq,
  output [7:0]  io_out_bits_ctrl_dest,
  output [3:0]  io_out_bits_ctrl_dtype,
  output        io_out_bits_ctrl_finite_fma,
  output        io_out_bits_ctrl_fma_sign
);
  wire  mulPipe_clock; // @[FMA.scala 118:23]
  wire  mulPipe_reset; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_ready; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_valid; // @[FMA.scala 118:23]
  wire [2:0] mulPipe_io_in_bits_op; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_io_in_bits_a; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_io_in_bits_b; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_io_in_bits_c; // @[FMA.scala 118:23]
  wire [5:0] mulPipe_io_in_bits_ctrl_seq; // @[FMA.scala 118:23]
  wire [7:0] mulPipe_io_in_bits_ctrl_dest; // @[FMA.scala 118:23]
  wire [3:0] mulPipe_io_in_bits_ctrl_dtype; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_bits_ctrl_finite_fma; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_bits_ctrl_fma_sign; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_ready; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_valid; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_io_out_bits_result; // @[FMA.scala 118:23]
  wire [4:0] mulPipe_io_out_bits_fflags; // @[FMA.scala 118:23]
  wire [5:0] mulPipe_io_out_bits_ctrl_seq; // @[FMA.scala 118:23]
  wire [7:0] mulPipe_io_out_bits_ctrl_dest; // @[FMA.scala 118:23]
  wire [3:0] mulPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_fp_prod_sign; // @[FMA.scala 118:23]
  wire [10:0] mulPipe_toAdd_mulOutput_fp_prod_exp; // @[FMA.scala 118:23]
  wire [104:0] mulPipe_toAdd_mulOutput_fp_prod_sig; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_inter_flags_isNaN; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_inter_flags_isInf; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_inter_flags_isInv; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_inter_flags_overflow; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_mulOutput_inter_flags_prod_sign; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_toAdd_addAnother; // @[FMA.scala 118:23]
  wire [2:0] mulPipe_toAdd_op; // @[FMA.scala 118:23]
  wire [5:0] mulPipe_toAdd_ctrl_seq; // @[FMA.scala 118:23]
  wire [7:0] mulPipe_toAdd_ctrl_dest; // @[FMA.scala 118:23]
  wire [3:0] mulPipe_toAdd_ctrl_dtype; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_ctrl_finite_fma; // @[FMA.scala 118:23]
  wire  mulPipe_toAdd_ctrl_fma_sign; // @[FMA.scala 118:23]
  wire  addPipe_clock; // @[FMA.scala 119:23]
  wire  addPipe_reset; // @[FMA.scala 119:23]
  wire  addPipe_io_in_ready; // @[FMA.scala 119:23]
  wire  addPipe_io_in_valid; // @[FMA.scala 119:23]
  wire [2:0] addPipe_io_in_bits_op; // @[FMA.scala 119:23]
  wire [63:0] addPipe_io_in_bits_a; // @[FMA.scala 119:23]
  wire [63:0] addPipe_io_in_bits_b; // @[FMA.scala 119:23]
  wire [2:0] addPipe_io_in_bits_rm; // @[FMA.scala 119:23]
  wire [5:0] addPipe_io_in_bits_ctrl_seq; // @[FMA.scala 119:23]
  wire [7:0] addPipe_io_in_bits_ctrl_dest; // @[FMA.scala 119:23]
  wire [3:0] addPipe_io_in_bits_ctrl_dtype; // @[FMA.scala 119:23]
  wire  addPipe_io_in_bits_ctrl_finite_fma; // @[FMA.scala 119:23]
  wire  addPipe_io_in_bits_ctrl_fma_sign; // @[FMA.scala 119:23]
  wire  addPipe_io_out_ready; // @[FMA.scala 119:23]
  wire  addPipe_io_out_valid; // @[FMA.scala 119:23]
  wire [63:0] addPipe_io_out_bits_result; // @[FMA.scala 119:23]
  wire [4:0] addPipe_io_out_bits_fflags; // @[FMA.scala 119:23]
  wire [5:0] addPipe_io_out_bits_ctrl_seq; // @[FMA.scala 119:23]
  wire [7:0] addPipe_io_out_bits_ctrl_dest; // @[FMA.scala 119:23]
  wire [3:0] addPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 119:23]
  wire  addPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 119:23]
  wire  addPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_fp_prod_sign; // @[FMA.scala 119:23]
  wire [10:0] addPipe_fromMul_mulOutput_fp_prod_exp; // @[FMA.scala 119:23]
  wire [104:0] addPipe_fromMul_mulOutput_fp_prod_sig; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_inter_flags_isNaN; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_inter_flags_isInf; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_inter_flags_isInv; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_inter_flags_overflow; // @[FMA.scala 119:23]
  wire  addPipe_fromMul_mulOutput_inter_flags_prod_sign; // @[FMA.scala 119:23]
  wire [63:0] addPipe_fromMul_addAnother; // @[FMA.scala 119:23]
  wire [2:0] addPipe_fromMul_rm; // @[FMA.scala 119:23]
  wire  toAddArbiter_io_in_0_ready; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_0_valid; // @[FMA.scala 133:28]
  wire [5:0] toAddArbiter_io_in_0_bits_ctrl_seq; // @[FMA.scala 133:28]
  wire [7:0] toAddArbiter_io_in_0_bits_ctrl_dest; // @[FMA.scala 133:28]
  wire [3:0] toAddArbiter_io_in_0_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_0_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_0_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_in_0_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_ready; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_valid; // @[FMA.scala 133:28]
  wire [5:0] toAddArbiter_io_in_1_bits_ctrl_seq; // @[FMA.scala 133:28]
  wire [7:0] toAddArbiter_io_in_1_bits_ctrl_dest; // @[FMA.scala 133:28]
  wire [3:0] toAddArbiter_io_in_1_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_in_1_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_ready; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_valid; // @[FMA.scala 133:28]
  wire [5:0] toAddArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 133:28]
  wire [7:0] toAddArbiter_io_out_bits_ctrl_dest; // @[FMA.scala 133:28]
  wire [3:0] toAddArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_out_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiterFIFO_0_clock; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_reset; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_0_io_enq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [7:0] toAddArbiterFIFO_0_io_enq_bits_ctrl_dest; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_0_io_enq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_0_io_deq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [7:0] toAddArbiterFIFO_0_io_deq_bits_ctrl_dest; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_0_io_deq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_0_io_deq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_clock; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_reset; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_1_io_enq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [7:0] toAddArbiterFIFO_1_io_enq_bits_ctrl_dest; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_1_io_enq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_1_io_deq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [7:0] toAddArbiterFIFO_1_io_deq_bits_ctrl_dest; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_1_io_deq_bits_op; // @[FMA.scala 134:44]
  wire  inToAddFIFO_clock; // @[FMA.scala 145:27]
  wire  inToAddFIFO_reset; // @[FMA.scala 145:27]
  wire  inToAddFIFO_io_enq_ready; // @[FMA.scala 145:27]
  wire  inToAddFIFO_io_enq_valid; // @[FMA.scala 145:27]
  wire [63:0] inToAddFIFO_io_enq_bits_a; // @[FMA.scala 145:27]
  wire [63:0] inToAddFIFO_io_enq_bits_b; // @[FMA.scala 145:27]
  wire  inToAddFIFO_io_deq_ready; // @[FMA.scala 145:27]
  wire  inToAddFIFO_io_deq_valid; // @[FMA.scala 145:27]
  wire [63:0] inToAddFIFO_io_deq_bits_a; // @[FMA.scala 145:27]
  wire [63:0] inToAddFIFO_io_deq_bits_b; // @[FMA.scala 145:27]
  wire [2:0] inToAddFIFO_io_deq_bits_rm; // @[FMA.scala 145:27]
  wire  mulToAddFIFO_clock; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_reset; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_ready; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_valid; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 152:28]
  wire [10:0] mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 152:28]
  wire [104:0] mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 152:28]
  wire [63:0] mulToAddFIFO_io_enq_bits_addAnother; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_ready; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_valid; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 152:28]
  wire [10:0] mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 152:28]
  wire [104:0] mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 152:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 152:28]
  wire [63:0] mulToAddFIFO_io_deq_bits_addAnother; // @[FMA.scala 152:28]
  wire [2:0] mulToAddFIFO_io_deq_bits_rm; // @[FMA.scala 152:28]
  wire  mulFIFO_clock; // @[FMA.scala 167:23]
  wire  mulFIFO_reset; // @[FMA.scala 167:23]
  wire  mulFIFO_io_enq_ready; // @[FMA.scala 167:23]
  wire  mulFIFO_io_enq_valid; // @[FMA.scala 167:23]
  wire [63:0] mulFIFO_io_enq_bits_result; // @[FMA.scala 167:23]
  wire [4:0] mulFIFO_io_enq_bits_fflags; // @[FMA.scala 167:23]
  wire [5:0] mulFIFO_io_enq_bits_ctrl_seq; // @[FMA.scala 167:23]
  wire [7:0] mulFIFO_io_enq_bits_ctrl_dest; // @[FMA.scala 167:23]
  wire [3:0] mulFIFO_io_enq_bits_ctrl_dtype; // @[FMA.scala 167:23]
  wire  mulFIFO_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 167:23]
  wire  mulFIFO_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 167:23]
  wire  mulFIFO_io_deq_ready; // @[FMA.scala 167:23]
  wire  mulFIFO_io_deq_valid; // @[FMA.scala 167:23]
  wire [63:0] mulFIFO_io_deq_bits_result; // @[FMA.scala 167:23]
  wire [4:0] mulFIFO_io_deq_bits_fflags; // @[FMA.scala 167:23]
  wire [5:0] mulFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 167:23]
  wire [7:0] mulFIFO_io_deq_bits_ctrl_dest; // @[FMA.scala 167:23]
  wire [3:0] mulFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 167:23]
  wire  mulFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 167:23]
  wire  mulFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 167:23]
  wire  addFIFO_clock; // @[FMA.scala 168:23]
  wire  addFIFO_reset; // @[FMA.scala 168:23]
  wire  addFIFO_io_enq_ready; // @[FMA.scala 168:23]
  wire  addFIFO_io_enq_valid; // @[FMA.scala 168:23]
  wire [63:0] addFIFO_io_enq_bits_result; // @[FMA.scala 168:23]
  wire [4:0] addFIFO_io_enq_bits_fflags; // @[FMA.scala 168:23]
  wire [5:0] addFIFO_io_enq_bits_ctrl_seq; // @[FMA.scala 168:23]
  wire [7:0] addFIFO_io_enq_bits_ctrl_dest; // @[FMA.scala 168:23]
  wire [3:0] addFIFO_io_enq_bits_ctrl_dtype; // @[FMA.scala 168:23]
  wire  addFIFO_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 168:23]
  wire  addFIFO_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 168:23]
  wire  addFIFO_io_deq_ready; // @[FMA.scala 168:23]
  wire  addFIFO_io_deq_valid; // @[FMA.scala 168:23]
  wire [63:0] addFIFO_io_deq_bits_result; // @[FMA.scala 168:23]
  wire [4:0] addFIFO_io_deq_bits_fflags; // @[FMA.scala 168:23]
  wire [5:0] addFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 168:23]
  wire [7:0] addFIFO_io_deq_bits_ctrl_dest; // @[FMA.scala 168:23]
  wire [3:0] addFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 168:23]
  wire  addFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 168:23]
  wire  addFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 168:23]
  wire  toOutArbiter_io_in_0_ready; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_0_valid; // @[FMA.scala 177:28]
  wire [63:0] toOutArbiter_io_in_0_bits_result; // @[FMA.scala 177:28]
  wire [4:0] toOutArbiter_io_in_0_bits_fflags; // @[FMA.scala 177:28]
  wire [5:0] toOutArbiter_io_in_0_bits_ctrl_seq; // @[FMA.scala 177:28]
  wire [7:0] toOutArbiter_io_in_0_bits_ctrl_dest; // @[FMA.scala 177:28]
  wire [3:0] toOutArbiter_io_in_0_bits_ctrl_dtype; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_0_bits_ctrl_finite_fma; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_0_bits_ctrl_fma_sign; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_1_ready; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_1_valid; // @[FMA.scala 177:28]
  wire [63:0] toOutArbiter_io_in_1_bits_result; // @[FMA.scala 177:28]
  wire [4:0] toOutArbiter_io_in_1_bits_fflags; // @[FMA.scala 177:28]
  wire [5:0] toOutArbiter_io_in_1_bits_ctrl_seq; // @[FMA.scala 177:28]
  wire [7:0] toOutArbiter_io_in_1_bits_ctrl_dest; // @[FMA.scala 177:28]
  wire [3:0] toOutArbiter_io_in_1_bits_ctrl_dtype; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_1_bits_ctrl_finite_fma; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_in_1_bits_ctrl_fma_sign; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_out_ready; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_out_valid; // @[FMA.scala 177:28]
  wire [63:0] toOutArbiter_io_out_bits_result; // @[FMA.scala 177:28]
  wire [4:0] toOutArbiter_io_out_bits_fflags; // @[FMA.scala 177:28]
  wire [5:0] toOutArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 177:28]
  wire [7:0] toOutArbiter_io_out_bits_ctrl_dest; // @[FMA.scala 177:28]
  wire [3:0] toOutArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 177:28]
  wire  toOutArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 177:28]
  wire  _mulPipe_io_in_valid_T_2 = io_in_bits_op == 3'h2; // @[FPUOps.scala 81:10]
  wire  _toAddArbiterFIFO_1_io_enq_valid_T_1 = io_in_bits_op[2:1] == 2'h0; // @[FPUOps.scala 63:16]
  wire  _mulFIFO_io_enq_valid_T = mulPipe_toAdd_op == 3'h2; // @[FPUOps.scala 81:10]
  wire  _mulPipe_io_out_ready_T_4 = mulFIFO_io_enq_ready & _mulFIFO_io_enq_valid_T; // @[FMA.scala 174:27]
  FMULPipe mulPipe ( // @[FMA.scala 118:23]
    .clock(mulPipe_clock),
    .reset(mulPipe_reset),
    .io_in_ready(mulPipe_io_in_ready),
    .io_in_valid(mulPipe_io_in_valid),
    .io_in_bits_op(mulPipe_io_in_bits_op),
    .io_in_bits_a(mulPipe_io_in_bits_a),
    .io_in_bits_b(mulPipe_io_in_bits_b),
    .io_in_bits_c(mulPipe_io_in_bits_c),
    .io_in_bits_ctrl_seq(mulPipe_io_in_bits_ctrl_seq),
    .io_in_bits_ctrl_dest(mulPipe_io_in_bits_ctrl_dest),
    .io_in_bits_ctrl_dtype(mulPipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(mulPipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(mulPipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(mulPipe_io_out_ready),
    .io_out_valid(mulPipe_io_out_valid),
    .io_out_bits_result(mulPipe_io_out_bits_result),
    .io_out_bits_fflags(mulPipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(mulPipe_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dest(mulPipe_io_out_bits_ctrl_dest),
    .io_out_bits_ctrl_dtype(mulPipe_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(mulPipe_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(mulPipe_io_out_bits_ctrl_fma_sign),
    .toAdd_mulOutput_fp_prod_sign(mulPipe_toAdd_mulOutput_fp_prod_sign),
    .toAdd_mulOutput_fp_prod_exp(mulPipe_toAdd_mulOutput_fp_prod_exp),
    .toAdd_mulOutput_fp_prod_sig(mulPipe_toAdd_mulOutput_fp_prod_sig),
    .toAdd_mulOutput_inter_flags_isNaN(mulPipe_toAdd_mulOutput_inter_flags_isNaN),
    .toAdd_mulOutput_inter_flags_isInf(mulPipe_toAdd_mulOutput_inter_flags_isInf),
    .toAdd_mulOutput_inter_flags_isInv(mulPipe_toAdd_mulOutput_inter_flags_isInv),
    .toAdd_mulOutput_inter_flags_overflow(mulPipe_toAdd_mulOutput_inter_flags_overflow),
    .toAdd_mulOutput_inter_flags_prod_sign(mulPipe_toAdd_mulOutput_inter_flags_prod_sign),
    .toAdd_addAnother(mulPipe_toAdd_addAnother),
    .toAdd_op(mulPipe_toAdd_op),
    .toAdd_ctrl_seq(mulPipe_toAdd_ctrl_seq),
    .toAdd_ctrl_dest(mulPipe_toAdd_ctrl_dest),
    .toAdd_ctrl_dtype(mulPipe_toAdd_ctrl_dtype),
    .toAdd_ctrl_finite_fma(mulPipe_toAdd_ctrl_finite_fma),
    .toAdd_ctrl_fma_sign(mulPipe_toAdd_ctrl_fma_sign)
  );
  FADDPipe addPipe ( // @[FMA.scala 119:23]
    .clock(addPipe_clock),
    .reset(addPipe_reset),
    .io_in_ready(addPipe_io_in_ready),
    .io_in_valid(addPipe_io_in_valid),
    .io_in_bits_op(addPipe_io_in_bits_op),
    .io_in_bits_a(addPipe_io_in_bits_a),
    .io_in_bits_b(addPipe_io_in_bits_b),
    .io_in_bits_rm(addPipe_io_in_bits_rm),
    .io_in_bits_ctrl_seq(addPipe_io_in_bits_ctrl_seq),
    .io_in_bits_ctrl_dest(addPipe_io_in_bits_ctrl_dest),
    .io_in_bits_ctrl_dtype(addPipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(addPipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(addPipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(addPipe_io_out_ready),
    .io_out_valid(addPipe_io_out_valid),
    .io_out_bits_result(addPipe_io_out_bits_result),
    .io_out_bits_fflags(addPipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(addPipe_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dest(addPipe_io_out_bits_ctrl_dest),
    .io_out_bits_ctrl_dtype(addPipe_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(addPipe_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(addPipe_io_out_bits_ctrl_fma_sign),
    .fromMul_mulOutput_fp_prod_sign(addPipe_fromMul_mulOutput_fp_prod_sign),
    .fromMul_mulOutput_fp_prod_exp(addPipe_fromMul_mulOutput_fp_prod_exp),
    .fromMul_mulOutput_fp_prod_sig(addPipe_fromMul_mulOutput_fp_prod_sig),
    .fromMul_mulOutput_inter_flags_isNaN(addPipe_fromMul_mulOutput_inter_flags_isNaN),
    .fromMul_mulOutput_inter_flags_isInf(addPipe_fromMul_mulOutput_inter_flags_isInf),
    .fromMul_mulOutput_inter_flags_isInv(addPipe_fromMul_mulOutput_inter_flags_isInv),
    .fromMul_mulOutput_inter_flags_overflow(addPipe_fromMul_mulOutput_inter_flags_overflow),
    .fromMul_mulOutput_inter_flags_prod_sign(addPipe_fromMul_mulOutput_inter_flags_prod_sign),
    .fromMul_addAnother(addPipe_fromMul_addAnother),
    .fromMul_rm(addPipe_fromMul_rm)
  );
  Arbiter toAddArbiter ( // @[FMA.scala 133:28]
    .io_in_0_ready(toAddArbiter_io_in_0_ready),
    .io_in_0_valid(toAddArbiter_io_in_0_valid),
    .io_in_0_bits_ctrl_seq(toAddArbiter_io_in_0_bits_ctrl_seq),
    .io_in_0_bits_ctrl_dest(toAddArbiter_io_in_0_bits_ctrl_dest),
    .io_in_0_bits_ctrl_dtype(toAddArbiter_io_in_0_bits_ctrl_dtype),
    .io_in_0_bits_ctrl_finite_fma(toAddArbiter_io_in_0_bits_ctrl_finite_fma),
    .io_in_0_bits_ctrl_fma_sign(toAddArbiter_io_in_0_bits_ctrl_fma_sign),
    .io_in_0_bits_op(toAddArbiter_io_in_0_bits_op),
    .io_in_1_ready(toAddArbiter_io_in_1_ready),
    .io_in_1_valid(toAddArbiter_io_in_1_valid),
    .io_in_1_bits_ctrl_seq(toAddArbiter_io_in_1_bits_ctrl_seq),
    .io_in_1_bits_ctrl_dest(toAddArbiter_io_in_1_bits_ctrl_dest),
    .io_in_1_bits_ctrl_dtype(toAddArbiter_io_in_1_bits_ctrl_dtype),
    .io_in_1_bits_ctrl_finite_fma(toAddArbiter_io_in_1_bits_ctrl_finite_fma),
    .io_in_1_bits_ctrl_fma_sign(toAddArbiter_io_in_1_bits_ctrl_fma_sign),
    .io_in_1_bits_op(toAddArbiter_io_in_1_bits_op),
    .io_out_ready(toAddArbiter_io_out_ready),
    .io_out_valid(toAddArbiter_io_out_valid),
    .io_out_bits_ctrl_seq(toAddArbiter_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dest(toAddArbiter_io_out_bits_ctrl_dest),
    .io_out_bits_ctrl_dtype(toAddArbiter_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(toAddArbiter_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(toAddArbiter_io_out_bits_ctrl_fma_sign),
    .io_out_bits_op(toAddArbiter_io_out_bits_op)
  );
  Queue toAddArbiterFIFO_0 ( // @[FMA.scala 134:44]
    .clock(toAddArbiterFIFO_0_clock),
    .reset(toAddArbiterFIFO_0_reset),
    .io_enq_ready(toAddArbiterFIFO_0_io_enq_ready),
    .io_enq_valid(toAddArbiterFIFO_0_io_enq_valid),
    .io_enq_bits_ctrl_seq(toAddArbiterFIFO_0_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dest(toAddArbiterFIFO_0_io_enq_bits_ctrl_dest),
    .io_enq_bits_ctrl_dtype(toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign),
    .io_enq_bits_op(toAddArbiterFIFO_0_io_enq_bits_op),
    .io_deq_ready(toAddArbiterFIFO_0_io_deq_ready),
    .io_deq_valid(toAddArbiterFIFO_0_io_deq_valid),
    .io_deq_bits_ctrl_seq(toAddArbiterFIFO_0_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dest(toAddArbiterFIFO_0_io_deq_bits_ctrl_dest),
    .io_deq_bits_ctrl_dtype(toAddArbiterFIFO_0_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(toAddArbiterFIFO_0_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(toAddArbiterFIFO_0_io_deq_bits_ctrl_fma_sign),
    .io_deq_bits_op(toAddArbiterFIFO_0_io_deq_bits_op)
  );
  Queue toAddArbiterFIFO_1 ( // @[FMA.scala 134:44]
    .clock(toAddArbiterFIFO_1_clock),
    .reset(toAddArbiterFIFO_1_reset),
    .io_enq_ready(toAddArbiterFIFO_1_io_enq_ready),
    .io_enq_valid(toAddArbiterFIFO_1_io_enq_valid),
    .io_enq_bits_ctrl_seq(toAddArbiterFIFO_1_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dest(toAddArbiterFIFO_1_io_enq_bits_ctrl_dest),
    .io_enq_bits_ctrl_dtype(toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign),
    .io_enq_bits_op(toAddArbiterFIFO_1_io_enq_bits_op),
    .io_deq_ready(toAddArbiterFIFO_1_io_deq_ready),
    .io_deq_valid(toAddArbiterFIFO_1_io_deq_valid),
    .io_deq_bits_ctrl_seq(toAddArbiterFIFO_1_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dest(toAddArbiterFIFO_1_io_deq_bits_ctrl_dest),
    .io_deq_bits_ctrl_dtype(toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign),
    .io_deq_bits_op(toAddArbiterFIFO_1_io_deq_bits_op)
  );
  Queue_2 inToAddFIFO ( // @[FMA.scala 145:27]
    .clock(inToAddFIFO_clock),
    .reset(inToAddFIFO_reset),
    .io_enq_ready(inToAddFIFO_io_enq_ready),
    .io_enq_valid(inToAddFIFO_io_enq_valid),
    .io_enq_bits_a(inToAddFIFO_io_enq_bits_a),
    .io_enq_bits_b(inToAddFIFO_io_enq_bits_b),
    .io_deq_ready(inToAddFIFO_io_deq_ready),
    .io_deq_valid(inToAddFIFO_io_deq_valid),
    .io_deq_bits_a(inToAddFIFO_io_deq_bits_a),
    .io_deq_bits_b(inToAddFIFO_io_deq_bits_b),
    .io_deq_bits_rm(inToAddFIFO_io_deq_bits_rm)
  );
  Queue_3 mulToAddFIFO ( // @[FMA.scala 152:28]
    .clock(mulToAddFIFO_clock),
    .reset(mulToAddFIFO_reset),
    .io_enq_ready(mulToAddFIFO_io_enq_ready),
    .io_enq_valid(mulToAddFIFO_io_enq_valid),
    .io_enq_bits_mulOutput_fp_prod_sign(mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sign),
    .io_enq_bits_mulOutput_fp_prod_exp(mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_exp),
    .io_enq_bits_mulOutput_fp_prod_sig(mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sig),
    .io_enq_bits_mulOutput_inter_flags_isNaN(mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isNaN),
    .io_enq_bits_mulOutput_inter_flags_isInf(mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInf),
    .io_enq_bits_mulOutput_inter_flags_isInv(mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInv),
    .io_enq_bits_mulOutput_inter_flags_overflow(mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_overflow),
    .io_enq_bits_mulOutput_inter_flags_prod_sign(mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_prod_sign),
    .io_enq_bits_addAnother(mulToAddFIFO_io_enq_bits_addAnother),
    .io_deq_ready(mulToAddFIFO_io_deq_ready),
    .io_deq_valid(mulToAddFIFO_io_deq_valid),
    .io_deq_bits_mulOutput_fp_prod_sign(mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sign),
    .io_deq_bits_mulOutput_fp_prod_exp(mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_exp),
    .io_deq_bits_mulOutput_fp_prod_sig(mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sig),
    .io_deq_bits_mulOutput_inter_flags_isNaN(mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isNaN),
    .io_deq_bits_mulOutput_inter_flags_isInf(mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInf),
    .io_deq_bits_mulOutput_inter_flags_isInv(mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInv),
    .io_deq_bits_mulOutput_inter_flags_overflow(mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_overflow),
    .io_deq_bits_mulOutput_inter_flags_prod_sign(mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_prod_sign),
    .io_deq_bits_addAnother(mulToAddFIFO_io_deq_bits_addAnother),
    .io_deq_bits_rm(mulToAddFIFO_io_deq_bits_rm)
  );
  Queue_4 mulFIFO ( // @[FMA.scala 167:23]
    .clock(mulFIFO_clock),
    .reset(mulFIFO_reset),
    .io_enq_ready(mulFIFO_io_enq_ready),
    .io_enq_valid(mulFIFO_io_enq_valid),
    .io_enq_bits_result(mulFIFO_io_enq_bits_result),
    .io_enq_bits_fflags(mulFIFO_io_enq_bits_fflags),
    .io_enq_bits_ctrl_seq(mulFIFO_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dest(mulFIFO_io_enq_bits_ctrl_dest),
    .io_enq_bits_ctrl_dtype(mulFIFO_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(mulFIFO_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(mulFIFO_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(mulFIFO_io_deq_ready),
    .io_deq_valid(mulFIFO_io_deq_valid),
    .io_deq_bits_result(mulFIFO_io_deq_bits_result),
    .io_deq_bits_fflags(mulFIFO_io_deq_bits_fflags),
    .io_deq_bits_ctrl_seq(mulFIFO_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dest(mulFIFO_io_deq_bits_ctrl_dest),
    .io_deq_bits_ctrl_dtype(mulFIFO_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(mulFIFO_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(mulFIFO_io_deq_bits_ctrl_fma_sign)
  );
  Queue_4 addFIFO ( // @[FMA.scala 168:23]
    .clock(addFIFO_clock),
    .reset(addFIFO_reset),
    .io_enq_ready(addFIFO_io_enq_ready),
    .io_enq_valid(addFIFO_io_enq_valid),
    .io_enq_bits_result(addFIFO_io_enq_bits_result),
    .io_enq_bits_fflags(addFIFO_io_enq_bits_fflags),
    .io_enq_bits_ctrl_seq(addFIFO_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dest(addFIFO_io_enq_bits_ctrl_dest),
    .io_enq_bits_ctrl_dtype(addFIFO_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(addFIFO_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(addFIFO_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(addFIFO_io_deq_ready),
    .io_deq_valid(addFIFO_io_deq_valid),
    .io_deq_bits_result(addFIFO_io_deq_bits_result),
    .io_deq_bits_fflags(addFIFO_io_deq_bits_fflags),
    .io_deq_bits_ctrl_seq(addFIFO_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dest(addFIFO_io_deq_bits_ctrl_dest),
    .io_deq_bits_ctrl_dtype(addFIFO_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(addFIFO_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(addFIFO_io_deq_bits_ctrl_fma_sign)
  );
  Arbiter_1 toOutArbiter ( // @[FMA.scala 177:28]
    .io_in_0_ready(toOutArbiter_io_in_0_ready),
    .io_in_0_valid(toOutArbiter_io_in_0_valid),
    .io_in_0_bits_result(toOutArbiter_io_in_0_bits_result),
    .io_in_0_bits_fflags(toOutArbiter_io_in_0_bits_fflags),
    .io_in_0_bits_ctrl_seq(toOutArbiter_io_in_0_bits_ctrl_seq),
    .io_in_0_bits_ctrl_dest(toOutArbiter_io_in_0_bits_ctrl_dest),
    .io_in_0_bits_ctrl_dtype(toOutArbiter_io_in_0_bits_ctrl_dtype),
    .io_in_0_bits_ctrl_finite_fma(toOutArbiter_io_in_0_bits_ctrl_finite_fma),
    .io_in_0_bits_ctrl_fma_sign(toOutArbiter_io_in_0_bits_ctrl_fma_sign),
    .io_in_1_ready(toOutArbiter_io_in_1_ready),
    .io_in_1_valid(toOutArbiter_io_in_1_valid),
    .io_in_1_bits_result(toOutArbiter_io_in_1_bits_result),
    .io_in_1_bits_fflags(toOutArbiter_io_in_1_bits_fflags),
    .io_in_1_bits_ctrl_seq(toOutArbiter_io_in_1_bits_ctrl_seq),
    .io_in_1_bits_ctrl_dest(toOutArbiter_io_in_1_bits_ctrl_dest),
    .io_in_1_bits_ctrl_dtype(toOutArbiter_io_in_1_bits_ctrl_dtype),
    .io_in_1_bits_ctrl_finite_fma(toOutArbiter_io_in_1_bits_ctrl_finite_fma),
    .io_in_1_bits_ctrl_fma_sign(toOutArbiter_io_in_1_bits_ctrl_fma_sign),
    .io_out_ready(toOutArbiter_io_out_ready),
    .io_out_valid(toOutArbiter_io_out_valid),
    .io_out_bits_result(toOutArbiter_io_out_bits_result),
    .io_out_bits_fflags(toOutArbiter_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(toOutArbiter_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dest(toOutArbiter_io_out_bits_ctrl_dest),
    .io_out_bits_ctrl_dtype(toOutArbiter_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(toOutArbiter_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(toOutArbiter_io_out_bits_ctrl_fma_sign)
  );
  assign io_in_ready = _toAddArbiterFIFO_1_io_enq_valid_T_1 ? toAddArbiterFIFO_1_io_enq_ready : mulPipe_io_in_ready; // @[FMA.scala 166:21]
  assign io_out_valid = toOutArbiter_io_out_valid; // @[FMA.scala 180:10]
  assign io_out_bits_result = toOutArbiter_io_out_bits_result; // @[FMA.scala 180:10]
  assign io_out_bits_fflags = toOutArbiter_io_out_bits_fflags; // @[FMA.scala 180:10]
  assign io_out_bits_ctrl_seq = toOutArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 180:10]
  assign io_out_bits_ctrl_dest = toOutArbiter_io_out_bits_ctrl_dest; // @[FMA.scala 180:10]
  assign io_out_bits_ctrl_dtype = toOutArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 180:10]
  assign io_out_bits_ctrl_finite_fma = toOutArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 180:10]
  assign io_out_bits_ctrl_fma_sign = toOutArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 180:10]
  assign mulPipe_clock = clock;
  assign mulPipe_reset = reset;
  assign mulPipe_io_in_valid = io_in_valid & (io_in_bits_op[2] | _mulPipe_io_in_valid_T_2); // @[FMA.scala 122:38]
  assign mulPipe_io_in_bits_op = io_in_bits_op; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_a = io_in_bits_a; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_b = io_in_bits_b; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_c = io_in_bits_c; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_seq = io_in_bits_ctrl_seq; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_dest = io_in_bits_ctrl_dest; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_dtype = io_in_bits_ctrl_dtype; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_finite_fma = io_in_bits_ctrl_finite_fma; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_fma_sign = io_in_bits_ctrl_fma_sign; // @[FMA.scala 121:22]
  assign mulPipe_io_out_ready = toAddArbiterFIFO_0_io_enq_ready & mulPipe_toAdd_op[2] | _mulPipe_io_out_ready_T_4; // @[FMA.scala 173:96]
  assign addPipe_clock = clock;
  assign addPipe_reset = reset;
  assign addPipe_io_in_valid = toAddArbiter_io_out_valid; // @[FMA.scala 160:23]
  assign addPipe_io_in_bits_op = toAddArbiter_io_out_bits_op; // @[FMA.scala 149:25]
  assign addPipe_io_in_bits_a = inToAddFIFO_io_deq_bits_a; // @[FMA.scala 148:22]
  assign addPipe_io_in_bits_b = inToAddFIFO_io_deq_bits_b; // @[FMA.scala 148:22]
  assign addPipe_io_in_bits_rm = inToAddFIFO_io_deq_bits_rm; // @[FMA.scala 148:22]
  assign addPipe_io_in_bits_ctrl_seq = toAddArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 161:38]
  assign addPipe_io_in_bits_ctrl_dest = toAddArbiter_io_out_bits_ctrl_dest; // @[FMA.scala 161:38]
  assign addPipe_io_in_bits_ctrl_dtype = toAddArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 161:38]
  assign addPipe_io_in_bits_ctrl_finite_fma = toAddArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 161:38]
  assign addPipe_io_in_bits_ctrl_fma_sign = toAddArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 161:38]
  assign addPipe_io_out_ready = addFIFO_io_enq_ready; // @[FMA.scala 171:18]
  assign addPipe_fromMul_mulOutput_fp_prod_sign = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_fp_prod_exp = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_fp_prod_sig = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isNaN = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isInf = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isInv = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_inter_flags_overflow = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 155:19]
  assign addPipe_fromMul_mulOutput_inter_flags_prod_sign = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 155:19]
  assign addPipe_fromMul_addAnother = mulToAddFIFO_io_deq_bits_addAnother; // @[FMA.scala 155:19]
  assign addPipe_fromMul_rm = mulToAddFIFO_io_deq_bits_rm; // @[FMA.scala 155:19]
  assign toAddArbiter_io_in_0_valid = toAddArbiterFIFO_0_io_deq_valid; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_seq = toAddArbiterFIFO_0_io_deq_bits_ctrl_seq; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_dest = toAddArbiterFIFO_0_io_deq_bits_ctrl_dest; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_dtype = toAddArbiterFIFO_0_io_deq_bits_ctrl_dtype; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_finite_fma = toAddArbiterFIFO_0_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_fma_sign = toAddArbiterFIFO_0_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_op = toAddArbiterFIFO_0_io_deq_bits_op; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_1_valid = toAddArbiterFIFO_1_io_deq_valid; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_seq = toAddArbiterFIFO_1_io_deq_bits_ctrl_seq; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_dest = toAddArbiterFIFO_1_io_deq_bits_ctrl_dest; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_dtype = toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_finite_fma = toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_fma_sign = toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_op = toAddArbiterFIFO_1_io_deq_bits_op; // @[FMA.scala 142:25]
  assign toAddArbiter_io_out_ready = addPipe_io_in_ready; // @[FMA.scala 159:29]
  assign toAddArbiterFIFO_0_clock = clock;
  assign toAddArbiterFIFO_0_reset = reset;
  assign toAddArbiterFIFO_0_io_enq_valid = mulPipe_toAdd_op[2] & mulPipe_io_out_valid; // @[FMA.scala 140:70]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_seq = mulPipe_toAdd_ctrl_seq; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_dest = mulPipe_toAdd_ctrl_dest; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype = mulPipe_toAdd_ctrl_dtype; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma = mulPipe_toAdd_ctrl_finite_fma; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign = mulPipe_toAdd_ctrl_fma_sign; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_op = mulPipe_toAdd_op; // @[FMA.scala 137:38]
  assign toAddArbiterFIFO_0_io_deq_ready = toAddArbiter_io_in_0_ready; // @[FMA.scala 141:25]
  assign toAddArbiterFIFO_1_clock = clock;
  assign toAddArbiterFIFO_1_reset = reset;
  assign toAddArbiterFIFO_1_io_enq_valid = _toAddArbiterFIFO_1_io_enq_valid_T_1 & io_in_valid; // @[FMA.scala 139:70]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_seq = io_in_bits_ctrl_seq; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_dest = io_in_bits_ctrl_dest; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype = io_in_bits_ctrl_dtype; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma = io_in_bits_ctrl_finite_fma; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign = io_in_bits_ctrl_fma_sign; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_op = io_in_bits_op; // @[FMA.scala 135:54]
  assign toAddArbiterFIFO_1_io_deq_ready = toAddArbiter_io_in_1_ready; // @[FMA.scala 142:25]
  assign inToAddFIFO_clock = clock;
  assign inToAddFIFO_reset = reset;
  assign inToAddFIFO_io_enq_valid = _toAddArbiterFIFO_1_io_enq_valid_T_1 & io_in_valid; // @[FMA.scala 147:62]
  assign inToAddFIFO_io_enq_bits_a = io_in_bits_a; // @[FMA.scala 146:27]
  assign inToAddFIFO_io_enq_bits_b = io_in_bits_b; // @[FMA.scala 146:27]
  assign inToAddFIFO_io_deq_ready = toAddArbiter_io_in_1_ready; // @[FMA.scala 150:28]
  assign mulToAddFIFO_clock = clock;
  assign mulToAddFIFO_reset = reset;
  assign mulToAddFIFO_io_enq_valid = toAddArbiterFIFO_0_io_enq_ready & toAddArbiterFIFO_0_io_enq_valid; // @[Decoupled.scala 51:35]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sign = mulPipe_toAdd_mulOutput_fp_prod_sign; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_exp = mulPipe_toAdd_mulOutput_fp_prod_exp; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sig = mulPipe_toAdd_mulOutput_fp_prod_sig; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isNaN = mulPipe_toAdd_mulOutput_inter_flags_isNaN; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInf = mulPipe_toAdd_mulOutput_inter_flags_isInf; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInv = mulPipe_toAdd_mulOutput_inter_flags_isInv; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_overflow = mulPipe_toAdd_mulOutput_inter_flags_overflow; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_prod_sign = mulPipe_toAdd_mulOutput_inter_flags_prod_sign; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_enq_bits_addAnother = mulPipe_toAdd_addAnother; // @[FMA.scala 153:28]
  assign mulToAddFIFO_io_deq_ready = toAddArbiter_io_in_0_ready; // @[FMA.scala 156:29]
  assign mulFIFO_clock = clock;
  assign mulFIFO_reset = reset;
  assign mulFIFO_io_enq_valid = mulPipe_io_out_valid & _mulFIFO_io_enq_valid_T; // @[FMA.scala 170:48]
  assign mulFIFO_io_enq_bits_result = mulPipe_io_out_bits_result; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_fflags = mulPipe_io_out_bits_fflags; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_ctrl_seq = mulPipe_io_out_bits_ctrl_seq; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_ctrl_dest = mulPipe_io_out_bits_ctrl_dest; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_ctrl_dtype = mulPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_ctrl_finite_fma = mulPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 169:23]
  assign mulFIFO_io_enq_bits_ctrl_fma_sign = mulPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 169:23]
  assign mulFIFO_io_deq_ready = toOutArbiter_io_in_1_ready; // @[FMA.scala 179:25]
  assign addFIFO_clock = clock;
  assign addFIFO_reset = reset;
  assign addFIFO_io_enq_valid = addPipe_io_out_valid; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_result = addPipe_io_out_bits_result; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_fflags = addPipe_io_out_bits_fflags; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_ctrl_seq = addPipe_io_out_bits_ctrl_seq; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_ctrl_dest = addPipe_io_out_bits_ctrl_dest; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_ctrl_dtype = addPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_ctrl_finite_fma = addPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 171:18]
  assign addFIFO_io_enq_bits_ctrl_fma_sign = addPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 171:18]
  assign addFIFO_io_deq_ready = toOutArbiter_io_in_0_ready; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_valid = addFIFO_io_deq_valid; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_result = addFIFO_io_deq_bits_result; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_fflags = addFIFO_io_deq_bits_fflags; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_ctrl_seq = addFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_ctrl_dest = addFIFO_io_deq_bits_ctrl_dest; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_ctrl_dtype = addFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_ctrl_finite_fma = addFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_0_bits_ctrl_fma_sign = addFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 178:25]
  assign toOutArbiter_io_in_1_valid = mulFIFO_io_deq_valid; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_result = mulFIFO_io_deq_bits_result; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_fflags = mulFIFO_io_deq_bits_fflags; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_ctrl_seq = mulFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_ctrl_dest = mulFIFO_io_deq_bits_ctrl_dest; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_ctrl_dtype = mulFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_ctrl_finite_fma = mulFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 179:25]
  assign toOutArbiter_io_in_1_bits_ctrl_fma_sign = mulFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 179:25]
  assign toOutArbiter_io_out_ready = io_out_ready; // @[FMA.scala 180:10]
endmodule
module Queue_6(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [5:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [5:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ram [0:31]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [4:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [4:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [4:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [4:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [4:0] _value_T_1 = enq_ptr_value + 5'h1; // @[Counter.scala 77:24]
  wire [4:0] _value_T_3 = deq_ptr_value + 5'h1; // @[Counter.scala 77:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | ~full; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 5'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 5'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram[initvar] = _RAND_0[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CLZ_3(
  input  [9:0] io_in,
  output [3:0] io_out
);
  wire [3:0] _io_out_T_10 = io_in[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_11 = io_in[2] ? 4'h7 : _io_out_T_10; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_12 = io_in[3] ? 4'h6 : _io_out_T_11; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_13 = io_in[4] ? 4'h5 : _io_out_T_12; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_14 = io_in[5] ? 4'h4 : _io_out_T_13; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_15 = io_in[6] ? 4'h3 : _io_out_T_14; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_16 = io_in[7] ? 4'h2 : _io_out_T_15; // @[Mux.scala 47:70]
  wire [3:0] _io_out_T_17 = io_in[8] ? 4'h1 : _io_out_T_16; // @[Mux.scala 47:70]
  assign io_out = io_in[9] ? 4'h0 : _io_out_T_17; // @[Mux.scala 47:70]
endmodule
module FPUpConverter(
  input  [15:0] io_in,
  output [63:0] io_result
);
  wire [9:0] subnormal_shamt_clz_io_in; // @[CLZ.scala 22:21]
  wire [3:0] subnormal_shamt_clz_io_out; // @[CLZ.scala 22:21]
  wire  fp_in_sign = io_in[15]; // @[package.scala 59:19]
  wire [4:0] fp_in_exp = io_in[14:10]; // @[package.scala 60:18]
  wire [9:0] fp_in_sig = io_in[9:0]; // @[package.scala 61:18]
  wire  decode_in_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_in_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_in_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode_in__expIsZero = ~decode_in_expNotZero; // @[package.scala 37:27]
  wire  decode_in__isSubnormal = decode_in__expIsZero & decode_in_sigNotZero; // @[package.scala 41:46]
  wire  decode_in__isNaN = decode_in_expIsOnes & decode_in_sigNotZero; // @[package.scala 44:40]
  wire [10:0] _GEN_0 = {{6'd0}, fp_in_exp}; // @[FPToFP.scala 214:47]
  wire [10:0] normal_exp = 11'h3f0 + _GEN_0; // @[FPToFP.scala 214:47]
  wire [24:0] _GEN_2 = {{15'd0}, fp_in_sig}; // @[FPToFP.scala 218:20]
  wire [24:0] _subnormal_sig_T = _GEN_2 << subnormal_shamt_clz_io_out; // @[FPToFP.scala 218:20]
  wire [10:0] _GEN_1 = {{7'd0}, subnormal_shamt_clz_io_out}; // @[FPToFP.scala 219:50]
  wire [10:0] subnormal_exp = 11'h3f0 - _GEN_1; // @[FPToFP.scala 219:50]
  wire  _result_T_1 = ~decode_in__isNaN & fp_in_sign; // @[FPToFP.scala 222:22]
  wire  _result_T_4 = ~decode_in_expIsOnes & ~decode_in__expIsZero; // @[FPToFP.scala 228:30]
  wire [10:0] _result_T_6 = decode_in_expIsOnes ? 11'h7ff : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_8 = decode_in__isSubnormal ? subnormal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_9 = _result_T_4 ? normal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_11 = _result_T_6 | _result_T_8; // @[Mux.scala 27:73]
  wire [10:0] _result_T_12 = _result_T_11 | _result_T_9; // @[Mux.scala 27:73]
  wire [51:0] _result_T_16 = {decode_in_sigNotZero,51'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_17 = {_subnormal_sig_T[8:0],1'h0,42'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_18 = {fp_in_sig,42'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_19 = decode_in_expIsOnes ? _result_T_16 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_20 = decode_in__expIsZero ? _result_T_17 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_21 = _result_T_4 ? _result_T_18 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_22 = _result_T_19 | _result_T_20; // @[Mux.scala 27:73]
  wire [51:0] _result_T_23 = _result_T_22 | _result_T_21; // @[Mux.scala 27:73]
  wire [11:0] result_hi = {_result_T_1,_result_T_12}; // @[Cat.scala 33:92]
  CLZ_3 subnormal_shamt_clz ( // @[CLZ.scala 22:21]
    .io_in(subnormal_shamt_clz_io_in),
    .io_out(subnormal_shamt_clz_io_out)
  );
  assign io_result = {result_hi,_result_T_23}; // @[Cat.scala 33:92]
  assign subnormal_shamt_clz_io_in = io_in[9:0]; // @[package.scala 61:18]
endmodule
module FPToFP(
  input  [15:0] io_in,
  output [63:0] io_result
);
  wire [15:0] converter_io_in; // @[FPToFP.scala 42:11]
  wire [63:0] converter_io_result; // @[FPToFP.scala 42:11]
  FPUpConverter converter ( // @[FPToFP.scala 42:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module CLZ_6(
  input  [6:0] io_in,
  output [2:0] io_out
);
  wire [2:0] _io_out_T_7 = io_in[1] ? 3'h5 : 3'h6; // @[Mux.scala 47:70]
  wire [2:0] _io_out_T_8 = io_in[2] ? 3'h4 : _io_out_T_7; // @[Mux.scala 47:70]
  wire [2:0] _io_out_T_9 = io_in[3] ? 3'h3 : _io_out_T_8; // @[Mux.scala 47:70]
  wire [2:0] _io_out_T_10 = io_in[4] ? 3'h2 : _io_out_T_9; // @[Mux.scala 47:70]
  wire [2:0] _io_out_T_11 = io_in[5] ? 3'h1 : _io_out_T_10; // @[Mux.scala 47:70]
  assign io_out = io_in[6] ? 3'h0 : _io_out_T_11; // @[Mux.scala 47:70]
endmodule
module FPUpConverter_3(
  input  [15:0] io_in,
  output [63:0] io_result
);
  wire [6:0] subnormal_shamt_clz_io_in; // @[CLZ.scala 22:21]
  wire [2:0] subnormal_shamt_clz_io_out; // @[CLZ.scala 22:21]
  wire  fp_in_sign = io_in[15]; // @[package.scala 59:19]
  wire [7:0] fp_in_exp = io_in[14:7]; // @[package.scala 60:18]
  wire [6:0] fp_in_sig = io_in[6:0]; // @[package.scala 61:18]
  wire  decode_in_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_in_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_in_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode_in__expIsZero = ~decode_in_expNotZero; // @[package.scala 37:27]
  wire  decode_in__isSubnormal = decode_in__expIsZero & decode_in_sigNotZero; // @[package.scala 41:46]
  wire  decode_in__isNaN = decode_in_expIsOnes & decode_in_sigNotZero; // @[package.scala 44:40]
  wire [10:0] _GEN_0 = {{3'd0}, fp_in_exp}; // @[FPToFP.scala 214:47]
  wire [10:0] normal_exp = 11'h380 + _GEN_0; // @[FPToFP.scala 214:47]
  wire [13:0] _GEN_2 = {{7'd0}, fp_in_sig}; // @[FPToFP.scala 218:20]
  wire [13:0] _subnormal_sig_T = _GEN_2 << subnormal_shamt_clz_io_out; // @[FPToFP.scala 218:20]
  wire [10:0] _GEN_1 = {{8'd0}, subnormal_shamt_clz_io_out}; // @[FPToFP.scala 219:50]
  wire [10:0] subnormal_exp = 11'h380 - _GEN_1; // @[FPToFP.scala 219:50]
  wire  _result_T_1 = ~decode_in__isNaN & fp_in_sign; // @[FPToFP.scala 222:22]
  wire  _result_T_4 = ~decode_in_expIsOnes & ~decode_in__expIsZero; // @[FPToFP.scala 228:30]
  wire [10:0] _result_T_6 = decode_in_expIsOnes ? 11'h7ff : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_8 = decode_in__isSubnormal ? subnormal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_9 = _result_T_4 ? normal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_11 = _result_T_6 | _result_T_8; // @[Mux.scala 27:73]
  wire [10:0] _result_T_12 = _result_T_11 | _result_T_9; // @[Mux.scala 27:73]
  wire [51:0] _result_T_16 = {decode_in_sigNotZero,51'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_17 = {_subnormal_sig_T[5:0],1'h0,45'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_18 = {fp_in_sig,45'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_19 = decode_in_expIsOnes ? _result_T_16 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_20 = decode_in__expIsZero ? _result_T_17 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_21 = _result_T_4 ? _result_T_18 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_22 = _result_T_19 | _result_T_20; // @[Mux.scala 27:73]
  wire [51:0] _result_T_23 = _result_T_22 | _result_T_21; // @[Mux.scala 27:73]
  wire [11:0] result_hi = {_result_T_1,_result_T_12}; // @[Cat.scala 33:92]
  CLZ_6 subnormal_shamt_clz ( // @[CLZ.scala 22:21]
    .io_in(subnormal_shamt_clz_io_in),
    .io_out(subnormal_shamt_clz_io_out)
  );
  assign io_result = {result_hi,_result_T_23}; // @[Cat.scala 33:92]
  assign subnormal_shamt_clz_io_in = io_in[6:0]; // @[package.scala 61:18]
endmodule
module FPToFP_3(
  input  [15:0] io_in,
  output [63:0] io_result
);
  wire [15:0] converter_io_in; // @[FPToFP.scala 42:11]
  wire [63:0] converter_io_result; // @[FPToFP.scala 42:11]
  FPUpConverter_3 converter ( // @[FPToFP.scala 42:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module CLZ_9(
  input  [22:0] io_in,
  output [4:0]  io_out
);
  wire [4:0] _io_out_T_23 = io_in[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_24 = io_in[2] ? 5'h14 : _io_out_T_23; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_25 = io_in[3] ? 5'h13 : _io_out_T_24; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_26 = io_in[4] ? 5'h12 : _io_out_T_25; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_27 = io_in[5] ? 5'h11 : _io_out_T_26; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_28 = io_in[6] ? 5'h10 : _io_out_T_27; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_29 = io_in[7] ? 5'hf : _io_out_T_28; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_30 = io_in[8] ? 5'he : _io_out_T_29; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_31 = io_in[9] ? 5'hd : _io_out_T_30; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_32 = io_in[10] ? 5'hc : _io_out_T_31; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_33 = io_in[11] ? 5'hb : _io_out_T_32; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_34 = io_in[12] ? 5'ha : _io_out_T_33; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_35 = io_in[13] ? 5'h9 : _io_out_T_34; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_36 = io_in[14] ? 5'h8 : _io_out_T_35; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_37 = io_in[15] ? 5'h7 : _io_out_T_36; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_38 = io_in[16] ? 5'h6 : _io_out_T_37; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_39 = io_in[17] ? 5'h5 : _io_out_T_38; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_40 = io_in[18] ? 5'h4 : _io_out_T_39; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_41 = io_in[19] ? 5'h3 : _io_out_T_40; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_42 = io_in[20] ? 5'h2 : _io_out_T_41; // @[Mux.scala 47:70]
  wire [4:0] _io_out_T_43 = io_in[21] ? 5'h1 : _io_out_T_42; // @[Mux.scala 47:70]
  assign io_out = io_in[22] ? 5'h0 : _io_out_T_43; // @[Mux.scala 47:70]
endmodule
module FPUpConverter_6(
  input  [31:0] io_in,
  output [63:0] io_result
);
  wire [22:0] subnormal_shamt_clz_io_in; // @[CLZ.scala 22:21]
  wire [4:0] subnormal_shamt_clz_io_out; // @[CLZ.scala 22:21]
  wire  fp_in_sign = io_in[31]; // @[package.scala 59:19]
  wire [7:0] fp_in_exp = io_in[30:23]; // @[package.scala 60:18]
  wire [22:0] fp_in_sig = io_in[22:0]; // @[package.scala 61:18]
  wire  decode_in_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_in_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_in_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode_in__expIsZero = ~decode_in_expNotZero; // @[package.scala 37:27]
  wire  decode_in__isSubnormal = decode_in__expIsZero & decode_in_sigNotZero; // @[package.scala 41:46]
  wire  decode_in__isNaN = decode_in_expIsOnes & decode_in_sigNotZero; // @[package.scala 44:40]
  wire [10:0] _GEN_0 = {{3'd0}, fp_in_exp}; // @[FPToFP.scala 214:47]
  wire [10:0] normal_exp = 11'h380 + _GEN_0; // @[FPToFP.scala 214:47]
  wire [53:0] _GEN_2 = {{31'd0}, fp_in_sig}; // @[FPToFP.scala 218:20]
  wire [53:0] _subnormal_sig_T = _GEN_2 << subnormal_shamt_clz_io_out; // @[FPToFP.scala 218:20]
  wire [10:0] _GEN_1 = {{6'd0}, subnormal_shamt_clz_io_out}; // @[FPToFP.scala 219:50]
  wire [10:0] subnormal_exp = 11'h380 - _GEN_1; // @[FPToFP.scala 219:50]
  wire  _result_T_1 = ~decode_in__isNaN & fp_in_sign; // @[FPToFP.scala 222:22]
  wire  _result_T_4 = ~decode_in_expIsOnes & ~decode_in__expIsZero; // @[FPToFP.scala 228:30]
  wire [10:0] _result_T_6 = decode_in_expIsOnes ? 11'h7ff : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_8 = decode_in__isSubnormal ? subnormal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_9 = _result_T_4 ? normal_exp : 11'h0; // @[Mux.scala 27:73]
  wire [10:0] _result_T_11 = _result_T_6 | _result_T_8; // @[Mux.scala 27:73]
  wire [10:0] _result_T_12 = _result_T_11 | _result_T_9; // @[Mux.scala 27:73]
  wire [51:0] _result_T_16 = {decode_in_sigNotZero,51'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_17 = {_subnormal_sig_T[21:0],1'h0,29'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_18 = {fp_in_sig,29'h0}; // @[Cat.scala 33:92]
  wire [51:0] _result_T_19 = decode_in_expIsOnes ? _result_T_16 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_20 = decode_in__expIsZero ? _result_T_17 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_21 = _result_T_4 ? _result_T_18 : 52'h0; // @[Mux.scala 27:73]
  wire [51:0] _result_T_22 = _result_T_19 | _result_T_20; // @[Mux.scala 27:73]
  wire [51:0] _result_T_23 = _result_T_22 | _result_T_21; // @[Mux.scala 27:73]
  wire [11:0] result_hi = {_result_T_1,_result_T_12}; // @[Cat.scala 33:92]
  CLZ_9 subnormal_shamt_clz ( // @[CLZ.scala 22:21]
    .io_in(subnormal_shamt_clz_io_in),
    .io_out(subnormal_shamt_clz_io_out)
  );
  assign io_result = {result_hi,_result_T_23}; // @[Cat.scala 33:92]
  assign subnormal_shamt_clz_io_in = io_in[22:0]; // @[package.scala 61:18]
endmodule
module FPToFP_6(
  input  [31:0] io_in,
  output [63:0] io_result
);
  wire [31:0] converter_io_in; // @[FPToFP.scala 42:11]
  wire [63:0] converter_io_result; // @[FPToFP.scala 42:11]
  FPUpConverter_6 converter ( // @[FPToFP.scala 42:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module CompareRecFN(
  input  [16:0] io_a,
  input  [16:0] io_b,
  output        io_lt,
  output        io_eq,
  output        io_gt
);
  wire [5:0] rawA_exp = io_a[15:10]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawA_isZero = rawA_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawA_isSpecial = rawA_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawA__isNaN = rawA_isSpecial & rawA_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawA__isInf = rawA_isSpecial & ~rawA_exp[3]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawA__sign = io_a[16]; // @[rawFloatFromRecFN.scala 59:25]
  wire [6:0] rawA__sExp = {1'b0,$signed(rawA_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawA_out_sig_T = ~rawA_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [11:0] rawA__sig = {1'h0,_rawA_out_sig_T,io_a[9:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire [5:0] rawB_exp = io_b[15:10]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawB_isZero = rawB_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawB_isSpecial = rawB_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawB__isNaN = rawB_isSpecial & rawB_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawB__isInf = rawB_isSpecial & ~rawB_exp[3]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawB__sign = io_b[16]; // @[rawFloatFromRecFN.scala 59:25]
  wire [6:0] rawB__sExp = {1'b0,$signed(rawB_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawB_out_sig_T = ~rawB_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [11:0] rawB__sig = {1'h0,_rawB_out_sig_T,io_b[9:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire  ordered = ~rawA__isNaN & ~rawB__isNaN; // @[CompareRecFN.scala 57:32]
  wire  bothInfs = rawA__isInf & rawB__isInf; // @[CompareRecFN.scala 58:33]
  wire  bothZeros = rawA_isZero & rawB_isZero; // @[CompareRecFN.scala 59:33]
  wire  eqExps = $signed(rawA__sExp) == $signed(rawB__sExp); // @[CompareRecFN.scala 60:29]
  wire  common_ltMags = $signed(rawA__sExp) < $signed(rawB__sExp) | eqExps & rawA__sig < rawB__sig; // @[CompareRecFN.scala 62:33]
  wire  common_eqMags = eqExps & rawA__sig == rawB__sig; // @[CompareRecFN.scala 63:32]
  wire  _ordered_lt_T_1 = ~rawB__sign; // @[CompareRecFN.scala 67:28]
  wire  _ordered_lt_T_9 = _ordered_lt_T_1 & common_ltMags; // @[CompareRecFN.scala 70:41]
  wire  _ordered_lt_T_10 = rawA__sign & ~common_ltMags & ~common_eqMags | _ordered_lt_T_9; // @[CompareRecFN.scala 69:74]
  wire  _ordered_lt_T_11 = ~bothInfs & _ordered_lt_T_10; // @[CompareRecFN.scala 68:30]
  wire  _ordered_lt_T_12 = rawA__sign & ~rawB__sign | _ordered_lt_T_11; // @[CompareRecFN.scala 67:41]
  wire  ordered_lt = ~bothZeros & _ordered_lt_T_12; // @[CompareRecFN.scala 66:21]
  wire  ordered_eq = bothZeros | rawA__sign == rawB__sign & (bothInfs | common_eqMags); // @[CompareRecFN.scala 72:19]
  assign io_lt = ordered & ordered_lt; // @[CompareRecFN.scala 78:22]
  assign io_eq = ordered & ordered_eq; // @[CompareRecFN.scala 79:22]
  assign io_gt = ordered & ~ordered_lt & ~ordered_eq; // @[CompareRecFN.scala 80:38]
endmodule
module CompareRecFN_1(
  input  [32:0] io_a,
  input  [32:0] io_b,
  output        io_lt,
  output        io_eq,
  output        io_gt
);
  wire [8:0] rawA_exp = io_a[31:23]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawA_isZero = rawA_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawA_isSpecial = rawA_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawA__isNaN = rawA_isSpecial & rawA_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawA__isInf = rawA_isSpecial & ~rawA_exp[6]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawA__sign = io_a[32]; // @[rawFloatFromRecFN.scala 59:25]
  wire [9:0] rawA__sExp = {1'b0,$signed(rawA_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawA_out_sig_T = ~rawA_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [24:0] rawA__sig = {1'h0,_rawA_out_sig_T,io_a[22:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire [8:0] rawB_exp = io_b[31:23]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawB_isZero = rawB_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawB_isSpecial = rawB_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawB__isNaN = rawB_isSpecial & rawB_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawB__isInf = rawB_isSpecial & ~rawB_exp[6]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawB__sign = io_b[32]; // @[rawFloatFromRecFN.scala 59:25]
  wire [9:0] rawB__sExp = {1'b0,$signed(rawB_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawB_out_sig_T = ~rawB_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [24:0] rawB__sig = {1'h0,_rawB_out_sig_T,io_b[22:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire  ordered = ~rawA__isNaN & ~rawB__isNaN; // @[CompareRecFN.scala 57:32]
  wire  bothInfs = rawA__isInf & rawB__isInf; // @[CompareRecFN.scala 58:33]
  wire  bothZeros = rawA_isZero & rawB_isZero; // @[CompareRecFN.scala 59:33]
  wire  eqExps = $signed(rawA__sExp) == $signed(rawB__sExp); // @[CompareRecFN.scala 60:29]
  wire  common_ltMags = $signed(rawA__sExp) < $signed(rawB__sExp) | eqExps & rawA__sig < rawB__sig; // @[CompareRecFN.scala 62:33]
  wire  common_eqMags = eqExps & rawA__sig == rawB__sig; // @[CompareRecFN.scala 63:32]
  wire  _ordered_lt_T_1 = ~rawB__sign; // @[CompareRecFN.scala 67:28]
  wire  _ordered_lt_T_9 = _ordered_lt_T_1 & common_ltMags; // @[CompareRecFN.scala 70:41]
  wire  _ordered_lt_T_10 = rawA__sign & ~common_ltMags & ~common_eqMags | _ordered_lt_T_9; // @[CompareRecFN.scala 69:74]
  wire  _ordered_lt_T_11 = ~bothInfs & _ordered_lt_T_10; // @[CompareRecFN.scala 68:30]
  wire  _ordered_lt_T_12 = rawA__sign & ~rawB__sign | _ordered_lt_T_11; // @[CompareRecFN.scala 67:41]
  wire  ordered_lt = ~bothZeros & _ordered_lt_T_12; // @[CompareRecFN.scala 66:21]
  wire  ordered_eq = bothZeros | rawA__sign == rawB__sign & (bothInfs | common_eqMags); // @[CompareRecFN.scala 72:19]
  assign io_lt = ordered & ordered_lt; // @[CompareRecFN.scala 78:22]
  assign io_eq = ordered & ordered_eq; // @[CompareRecFN.scala 79:22]
  assign io_gt = ordered & ~ordered_lt & ~ordered_eq; // @[CompareRecFN.scala 80:38]
endmodule
module CompareRecFN_2(
  input  [64:0] io_a,
  input  [64:0] io_b,
  output        io_lt,
  output        io_eq,
  output        io_gt
);
  wire [11:0] rawA_exp = io_a[63:52]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawA_isZero = rawA_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawA_isSpecial = rawA_exp[11:10] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawA__isNaN = rawA_isSpecial & rawA_exp[9]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawA__isInf = rawA_isSpecial & ~rawA_exp[9]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawA__sign = io_a[64]; // @[rawFloatFromRecFN.scala 59:25]
  wire [12:0] rawA__sExp = {1'b0,$signed(rawA_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawA_out_sig_T = ~rawA_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [53:0] rawA__sig = {1'h0,_rawA_out_sig_T,io_a[51:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire [11:0] rawB_exp = io_b[63:52]; // @[rawFloatFromRecFN.scala 51:21]
  wire  rawB_isZero = rawB_exp[11:9] == 3'h0; // @[rawFloatFromRecFN.scala 52:53]
  wire  rawB_isSpecial = rawB_exp[11:10] == 2'h3; // @[rawFloatFromRecFN.scala 53:53]
  wire  rawB__isNaN = rawB_isSpecial & rawB_exp[9]; // @[rawFloatFromRecFN.scala 56:33]
  wire  rawB__isInf = rawB_isSpecial & ~rawB_exp[9]; // @[rawFloatFromRecFN.scala 57:33]
  wire  rawB__sign = io_b[64]; // @[rawFloatFromRecFN.scala 59:25]
  wire [12:0] rawB__sExp = {1'b0,$signed(rawB_exp)}; // @[rawFloatFromRecFN.scala 60:27]
  wire  _rawB_out_sig_T = ~rawB_isZero; // @[rawFloatFromRecFN.scala 61:35]
  wire [53:0] rawB__sig = {1'h0,_rawB_out_sig_T,io_b[51:0]}; // @[rawFloatFromRecFN.scala 61:44]
  wire  ordered = ~rawA__isNaN & ~rawB__isNaN; // @[CompareRecFN.scala 57:32]
  wire  bothInfs = rawA__isInf & rawB__isInf; // @[CompareRecFN.scala 58:33]
  wire  bothZeros = rawA_isZero & rawB_isZero; // @[CompareRecFN.scala 59:33]
  wire  eqExps = $signed(rawA__sExp) == $signed(rawB__sExp); // @[CompareRecFN.scala 60:29]
  wire  common_ltMags = $signed(rawA__sExp) < $signed(rawB__sExp) | eqExps & rawA__sig < rawB__sig; // @[CompareRecFN.scala 62:33]
  wire  common_eqMags = eqExps & rawA__sig == rawB__sig; // @[CompareRecFN.scala 63:32]
  wire  _ordered_lt_T_1 = ~rawB__sign; // @[CompareRecFN.scala 67:28]
  wire  _ordered_lt_T_9 = _ordered_lt_T_1 & common_ltMags; // @[CompareRecFN.scala 70:41]
  wire  _ordered_lt_T_10 = rawA__sign & ~common_ltMags & ~common_eqMags | _ordered_lt_T_9; // @[CompareRecFN.scala 69:74]
  wire  _ordered_lt_T_11 = ~bothInfs & _ordered_lt_T_10; // @[CompareRecFN.scala 68:30]
  wire  _ordered_lt_T_12 = rawA__sign & ~rawB__sign | _ordered_lt_T_11; // @[CompareRecFN.scala 67:41]
  wire  ordered_lt = ~bothZeros & _ordered_lt_T_12; // @[CompareRecFN.scala 66:21]
  wire  ordered_eq = bothZeros | rawA__sign == rawB__sign & (bothInfs | common_eqMags); // @[CompareRecFN.scala 72:19]
  assign io_lt = ordered & ordered_lt; // @[CompareRecFN.scala 78:22]
  assign io_eq = ordered & ordered_eq; // @[CompareRecFN.scala 79:22]
  assign io_gt = ordered & ~ordered_lt & ~ordered_eq; // @[CompareRecFN.scala 80:38]
endmodule
module RoundingUnit_6(
  input  [9:0] io_in,
  input        io_roundIn,
  input        io_stickyIn,
  output [9:0] io_out,
  output       io_cout
);
  wire  g = io_in[0]; // @[RoundingUnit.scala 19:25]
  wire  r_up = io_roundIn & io_stickyIn | io_roundIn & ~io_stickyIn & g; // @[RoundingUnit.scala 25:24]
  wire [9:0] out_r_up = io_in + 10'h1; // @[RoundingUnit.scala 32:24]
  assign io_out = r_up ? out_r_up : io_in; // @[RoundingUnit.scala 33:16]
  assign io_cout = r_up & &io_in; // @[RoundingUnit.scala 36:19]
endmodule
module ShiftRightJam_1(
  input  [11:0] io_in,
  input  [10:0] io_shamt,
  output [11:0] io_out,
  output        io_sticky
);
  wire  exceed_max_shift = io_shamt > 11'hc; // @[ShiftRightJam.scala 17:35]
  wire [3:0] shamt = io_shamt[3:0]; // @[ShiftRightJam.scala 18:23]
  wire [15:0] _sticky_mask_T = 16'h1 << shamt; // @[ShiftRightJam.scala 20:11]
  wire [15:0] _sticky_mask_T_2 = _sticky_mask_T - 16'h1; // @[ShiftRightJam.scala 20:30]
  wire [11:0] _sticky_mask_T_5 = exceed_max_shift ? 12'hfff : 12'h0; // @[Bitwise.scala 77:12]
  wire [11:0] sticky_mask = _sticky_mask_T_2[11:0] | _sticky_mask_T_5; // @[ShiftRightJam.scala 20:49]
  wire [11:0] _io_out_T = io_in >> io_shamt; // @[ShiftRightJam.scala 21:46]
  wire [11:0] _io_sticky_T = io_in & sticky_mask; // @[ShiftRightJam.scala 22:23]
  assign io_out = exceed_max_shift ? 12'h0 : _io_out_T; // @[ShiftRightJam.scala 21:16]
  assign io_sticky = |_io_sticky_T; // @[ShiftRightJam.scala 22:41]
endmodule
module FPDownConverter(
  input  [63:0] io_in,
  output [15:0] io_result
);
  wire [9:0] normal_rounder_io_in; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_roundIn; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_stickyIn; // @[FPToFP.scala 80:30]
  wire [9:0] normal_rounder_io_out; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_cout; // @[FPToFP.scala 80:30]
  wire [11:0] shiftRightJam_io_in; // @[ShiftRightJam.scala 27:31]
  wire [10:0] shiftRightJam_io_shamt; // @[ShiftRightJam.scala 27:31]
  wire [11:0] shiftRightJam_io_out; // @[ShiftRightJam.scala 27:31]
  wire  shiftRightJam_io_sticky; // @[ShiftRightJam.scala 27:31]
  wire [9:0] subnormal_rounder_io_in; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_roundIn; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_stickyIn; // @[FPToFP.scala 114:33]
  wire [9:0] subnormal_rounder_io_out; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_cout; // @[FPToFP.scala 114:33]
  wire  fp_in_sign = io_in[63]; // @[package.scala 59:19]
  wire [10:0] fp_in_exp = io_in[62:52]; // @[package.scala 60:18]
  wire [51:0] fp_in_sig = io_in[51:0]; // @[package.scala 61:18]
  wire  decode_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode__isNaN = decode_expIsOnes & decode_sigNotZero; // @[package.scala 44:40]
  wire [11:0] _down_exp_T = {1'b0,$signed(fp_in_exp)}; // @[FPToFP.scala 71:32]
  wire [11:0] down_exp = $signed(_down_exp_T) - 12'sh3f0; // @[FPToFP.scala 71:35]
  wire  normal_stickyBit = |fp_in_sig[40:0]; // @[FPToFP.scala 78:58]
  wire [11:0] _normal_exp_rounded_T_2 = $signed(down_exp) + 12'sh1; // @[FPToFP.scala 88:65]
  wire [11:0] normal_exp_rounded = normal_rounder_io_cout ? $signed(_normal_exp_rounded_T_2) : $signed(down_exp); // @[FPToFP.scala 88:31]
  wire  _normal_of_T = $signed(down_exp) > 12'sh1d; // @[FPToFP.scala 91:14]
  wire  _normal_of_T_1 = $signed(down_exp) > 12'sh1e; // @[FPToFP.scala 92:14]
  wire  normal_of = normal_rounder_io_cout ? _normal_of_T : _normal_of_T_1; // @[FPToFP.scala 89:22]
  wire  _exp_uf_T_1 = $signed(down_exp) < 12'sh1; // @[FPToFP.scala 94:69]
  wire  subnormal_exp_rounded = subnormal_rounder_io_cout; // @[FPToFP.scala 121:34]
  wire  _common_exp_T = ~_exp_uf_T_1; // @[FPToFP.scala 143:7]
  wire  _common_exp_T_1 = ~_exp_uf_T_1 & normal_of; // @[FPToFP.scala 143:25]
  wire  _common_exp_T_4 = _common_exp_T & ~normal_of; // @[FPToFP.scala 144:25]
  wire [4:0] _common_exp_T_6 = _common_exp_T_1 ? 5'h1f : 5'h0; // @[Mux.scala 27:73]
  wire [4:0] _common_exp_T_7 = _common_exp_T_4 ? normal_exp_rounded[4:0] : 5'h0; // @[Mux.scala 27:73]
  wire  _common_exp_T_8 = _exp_uf_T_1 & subnormal_exp_rounded; // @[Mux.scala 27:73]
  wire [4:0] _common_exp_T_9 = _common_exp_T_6 | _common_exp_T_7; // @[Mux.scala 27:73]
  wire [4:0] _GEN_1 = {{4'd0}, _common_exp_T_8}; // @[Mux.scala 27:73]
  wire [4:0] common_exp = _common_exp_T_9 | _GEN_1; // @[Mux.scala 27:73]
  wire [9:0] _common_sig_T_6 = _common_exp_T_4 ? normal_rounder_io_out : 10'h0; // @[Mux.scala 27:73]
  wire [9:0] _common_sig_T_7 = _exp_uf_T_1 ? subnormal_rounder_io_out : 10'h0; // @[Mux.scala 27:73]
  wire [9:0] common_sig = _common_sig_T_6 | _common_sig_T_7; // @[Mux.scala 27:73]
  wire  _of_T = ~decode_expIsOnes; // @[FPToFP.scala 171:12]
  wire  _result_T_1 = ~decode__isNaN & fp_in_sign; // @[FPToFP.scala 179:19]
  wire [4:0] _result_T_4 = decode_expIsOnes ? 5'h1f : 5'h0; // @[Mux.scala 27:73]
  wire [4:0] _result_T_5 = _of_T ? common_exp : 5'h0; // @[Mux.scala 27:73]
  wire [4:0] _result_T_6 = _result_T_4 | _result_T_5; // @[Mux.scala 27:73]
  wire [9:0] _result_T_8 = {decode_sigNotZero,9'h0}; // @[Cat.scala 33:92]
  wire [9:0] _result_T_9 = decode_expIsOnes ? _result_T_8 : 10'h0; // @[Mux.scala 27:73]
  wire [9:0] _result_T_10 = _of_T ? common_sig : 10'h0; // @[Mux.scala 27:73]
  wire [9:0] _result_T_11 = _result_T_9 | _result_T_10; // @[Mux.scala 27:73]
  wire [5:0] result_hi = {_result_T_1,_result_T_6}; // @[Cat.scala 33:92]
  RoundingUnit_6 normal_rounder ( // @[FPToFP.scala 80:30]
    .io_in(normal_rounder_io_in),
    .io_roundIn(normal_rounder_io_roundIn),
    .io_stickyIn(normal_rounder_io_stickyIn),
    .io_out(normal_rounder_io_out),
    .io_cout(normal_rounder_io_cout)
  );
  ShiftRightJam_1 shiftRightJam ( // @[ShiftRightJam.scala 27:31]
    .io_in(shiftRightJam_io_in),
    .io_shamt(shiftRightJam_io_shamt),
    .io_out(shiftRightJam_io_out),
    .io_sticky(shiftRightJam_io_sticky)
  );
  RoundingUnit_6 subnormal_rounder ( // @[FPToFP.scala 114:33]
    .io_in(subnormal_rounder_io_in),
    .io_roundIn(subnormal_rounder_io_roundIn),
    .io_stickyIn(subnormal_rounder_io_stickyIn),
    .io_out(subnormal_rounder_io_out),
    .io_cout(subnormal_rounder_io_cout)
  );
  assign io_result = {result_hi,_result_T_11}; // @[Cat.scala 33:92]
  assign normal_rounder_io_in = fp_in_sig[51:42]; // @[FPToFP.scala 76:34]
  assign normal_rounder_io_roundIn = fp_in_sig[41]; // @[FPToFP.scala 77:62]
  assign normal_rounder_io_stickyIn = |fp_in_sig[40:0]; // @[FPToFP.scala 78:58]
  assign shiftRightJam_io_in = {decode_expNotZero,fp_in_sig[51:41]}; // @[Cat.scala 33:92]
  assign shiftRightJam_io_shamt = 11'h3f1 - fp_in_exp; // @[FPToFP.scala 108:47]
  assign subnormal_rounder_io_in = shiftRightJam_io_out[10:1]; // @[FPToFP.scala 115:56]
  assign subnormal_rounder_io_roundIn = shiftRightJam_io_out[0]; // @[FPToFP.scala 116:48]
  assign subnormal_rounder_io_stickyIn = shiftRightJam_io_sticky | normal_stickyBit; // @[FPToFP.scala 113:42]
endmodule
module FPToFP_9(
  input  [63:0] io_in,
  output [15:0] io_result
);
  wire [63:0] converter_io_in; // @[FPToFP.scala 33:11]
  wire [15:0] converter_io_result; // @[FPToFP.scala 33:11]
  FPDownConverter converter ( // @[FPToFP.scala 33:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module RoundingUnit_8(
  input  [6:0] io_in,
  input        io_roundIn,
  input        io_stickyIn,
  output [6:0] io_out,
  output       io_cout
);
  wire  g = io_in[0]; // @[RoundingUnit.scala 19:25]
  wire  r_up = io_roundIn & io_stickyIn | io_roundIn & ~io_stickyIn & g; // @[RoundingUnit.scala 25:24]
  wire [6:0] out_r_up = io_in + 7'h1; // @[RoundingUnit.scala 32:24]
  assign io_out = r_up ? out_r_up : io_in; // @[RoundingUnit.scala 33:16]
  assign io_cout = r_up & &io_in; // @[RoundingUnit.scala 36:19]
endmodule
module ShiftRightJam_2(
  input  [8:0]  io_in,
  input  [10:0] io_shamt,
  output [8:0]  io_out,
  output        io_sticky
);
  wire  exceed_max_shift = io_shamt > 11'h9; // @[ShiftRightJam.scala 17:35]
  wire [3:0] shamt = io_shamt[3:0]; // @[ShiftRightJam.scala 18:23]
  wire [15:0] _sticky_mask_T = 16'h1 << shamt; // @[ShiftRightJam.scala 20:11]
  wire [15:0] _sticky_mask_T_2 = _sticky_mask_T - 16'h1; // @[ShiftRightJam.scala 20:30]
  wire [8:0] _sticky_mask_T_5 = exceed_max_shift ? 9'h1ff : 9'h0; // @[Bitwise.scala 77:12]
  wire [8:0] sticky_mask = _sticky_mask_T_2[8:0] | _sticky_mask_T_5; // @[ShiftRightJam.scala 20:49]
  wire [8:0] _io_out_T = io_in >> io_shamt; // @[ShiftRightJam.scala 21:46]
  wire [8:0] _io_sticky_T = io_in & sticky_mask; // @[ShiftRightJam.scala 22:23]
  assign io_out = exceed_max_shift ? 9'h0 : _io_out_T; // @[ShiftRightJam.scala 21:16]
  assign io_sticky = |_io_sticky_T; // @[ShiftRightJam.scala 22:41]
endmodule
module FPDownConverter_1(
  input  [63:0] io_in,
  output [15:0] io_result
);
  wire [6:0] normal_rounder_io_in; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_roundIn; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_stickyIn; // @[FPToFP.scala 80:30]
  wire [6:0] normal_rounder_io_out; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_cout; // @[FPToFP.scala 80:30]
  wire [8:0] shiftRightJam_io_in; // @[ShiftRightJam.scala 27:31]
  wire [10:0] shiftRightJam_io_shamt; // @[ShiftRightJam.scala 27:31]
  wire [8:0] shiftRightJam_io_out; // @[ShiftRightJam.scala 27:31]
  wire  shiftRightJam_io_sticky; // @[ShiftRightJam.scala 27:31]
  wire [6:0] subnormal_rounder_io_in; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_roundIn; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_stickyIn; // @[FPToFP.scala 114:33]
  wire [6:0] subnormal_rounder_io_out; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_cout; // @[FPToFP.scala 114:33]
  wire  fp_in_sign = io_in[63]; // @[package.scala 59:19]
  wire [10:0] fp_in_exp = io_in[62:52]; // @[package.scala 60:18]
  wire [51:0] fp_in_sig = io_in[51:0]; // @[package.scala 61:18]
  wire  decode_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode__isNaN = decode_expIsOnes & decode_sigNotZero; // @[package.scala 44:40]
  wire [11:0] _down_exp_T = {1'b0,$signed(fp_in_exp)}; // @[FPToFP.scala 71:32]
  wire [11:0] down_exp = $signed(_down_exp_T) - 12'sh380; // @[FPToFP.scala 71:35]
  wire  normal_stickyBit = |fp_in_sig[43:0]; // @[FPToFP.scala 78:58]
  wire [11:0] _normal_exp_rounded_T_2 = $signed(down_exp) + 12'sh1; // @[FPToFP.scala 88:65]
  wire [11:0] normal_exp_rounded = normal_rounder_io_cout ? $signed(_normal_exp_rounded_T_2) : $signed(down_exp); // @[FPToFP.scala 88:31]
  wire  _normal_of_T = $signed(down_exp) > 12'shfd; // @[FPToFP.scala 91:14]
  wire  _normal_of_T_1 = $signed(down_exp) > 12'shfe; // @[FPToFP.scala 92:14]
  wire  normal_of = normal_rounder_io_cout ? _normal_of_T : _normal_of_T_1; // @[FPToFP.scala 89:22]
  wire  _exp_uf_T_1 = $signed(down_exp) < 12'sh1; // @[FPToFP.scala 94:69]
  wire  subnormal_exp_rounded = subnormal_rounder_io_cout; // @[FPToFP.scala 121:34]
  wire  _common_exp_T = ~_exp_uf_T_1; // @[FPToFP.scala 143:7]
  wire  _common_exp_T_1 = ~_exp_uf_T_1 & normal_of; // @[FPToFP.scala 143:25]
  wire  _common_exp_T_4 = _common_exp_T & ~normal_of; // @[FPToFP.scala 144:25]
  wire [7:0] _common_exp_T_6 = _common_exp_T_1 ? 8'hff : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _common_exp_T_7 = _common_exp_T_4 ? normal_exp_rounded[7:0] : 8'h0; // @[Mux.scala 27:73]
  wire  _common_exp_T_8 = _exp_uf_T_1 & subnormal_exp_rounded; // @[Mux.scala 27:73]
  wire [7:0] _common_exp_T_9 = _common_exp_T_6 | _common_exp_T_7; // @[Mux.scala 27:73]
  wire [7:0] _GEN_1 = {{7'd0}, _common_exp_T_8}; // @[Mux.scala 27:73]
  wire [7:0] common_exp = _common_exp_T_9 | _GEN_1; // @[Mux.scala 27:73]
  wire [6:0] _common_sig_T_6 = _common_exp_T_4 ? normal_rounder_io_out : 7'h0; // @[Mux.scala 27:73]
  wire [6:0] _common_sig_T_7 = _exp_uf_T_1 ? subnormal_rounder_io_out : 7'h0; // @[Mux.scala 27:73]
  wire [6:0] common_sig = _common_sig_T_6 | _common_sig_T_7; // @[Mux.scala 27:73]
  wire  _of_T = ~decode_expIsOnes; // @[FPToFP.scala 171:12]
  wire  _result_T_1 = ~decode__isNaN & fp_in_sign; // @[FPToFP.scala 179:19]
  wire [7:0] _result_T_4 = decode_expIsOnes ? 8'hff : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_5 = _of_T ? common_exp : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_6 = _result_T_4 | _result_T_5; // @[Mux.scala 27:73]
  wire [6:0] _result_T_8 = {decode_sigNotZero,6'h0}; // @[Cat.scala 33:92]
  wire [6:0] _result_T_9 = decode_expIsOnes ? _result_T_8 : 7'h0; // @[Mux.scala 27:73]
  wire [6:0] _result_T_10 = _of_T ? common_sig : 7'h0; // @[Mux.scala 27:73]
  wire [6:0] _result_T_11 = _result_T_9 | _result_T_10; // @[Mux.scala 27:73]
  wire [8:0] result_hi = {_result_T_1,_result_T_6}; // @[Cat.scala 33:92]
  RoundingUnit_8 normal_rounder ( // @[FPToFP.scala 80:30]
    .io_in(normal_rounder_io_in),
    .io_roundIn(normal_rounder_io_roundIn),
    .io_stickyIn(normal_rounder_io_stickyIn),
    .io_out(normal_rounder_io_out),
    .io_cout(normal_rounder_io_cout)
  );
  ShiftRightJam_2 shiftRightJam ( // @[ShiftRightJam.scala 27:31]
    .io_in(shiftRightJam_io_in),
    .io_shamt(shiftRightJam_io_shamt),
    .io_out(shiftRightJam_io_out),
    .io_sticky(shiftRightJam_io_sticky)
  );
  RoundingUnit_8 subnormal_rounder ( // @[FPToFP.scala 114:33]
    .io_in(subnormal_rounder_io_in),
    .io_roundIn(subnormal_rounder_io_roundIn),
    .io_stickyIn(subnormal_rounder_io_stickyIn),
    .io_out(subnormal_rounder_io_out),
    .io_cout(subnormal_rounder_io_cout)
  );
  assign io_result = {result_hi,_result_T_11}; // @[Cat.scala 33:92]
  assign normal_rounder_io_in = fp_in_sig[51:45]; // @[FPToFP.scala 76:34]
  assign normal_rounder_io_roundIn = fp_in_sig[44]; // @[FPToFP.scala 77:62]
  assign normal_rounder_io_stickyIn = |fp_in_sig[43:0]; // @[FPToFP.scala 78:58]
  assign shiftRightJam_io_in = {decode_expNotZero,fp_in_sig[51:44]}; // @[Cat.scala 33:92]
  assign shiftRightJam_io_shamt = 11'h381 - fp_in_exp; // @[FPToFP.scala 108:47]
  assign subnormal_rounder_io_in = shiftRightJam_io_out[7:1]; // @[FPToFP.scala 115:56]
  assign subnormal_rounder_io_roundIn = shiftRightJam_io_out[0]; // @[FPToFP.scala 116:48]
  assign subnormal_rounder_io_stickyIn = shiftRightJam_io_sticky | normal_stickyBit; // @[FPToFP.scala 113:42]
endmodule
module FPToFP_10(
  input  [63:0] io_in,
  output [15:0] io_result
);
  wire [63:0] converter_io_in; // @[FPToFP.scala 33:11]
  wire [15:0] converter_io_result; // @[FPToFP.scala 33:11]
  FPDownConverter_1 converter ( // @[FPToFP.scala 33:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module RoundingUnit_10(
  input  [22:0] io_in,
  input         io_roundIn,
  input         io_stickyIn,
  output [22:0] io_out,
  output        io_cout
);
  wire  g = io_in[0]; // @[RoundingUnit.scala 19:25]
  wire  r_up = io_roundIn & io_stickyIn | io_roundIn & ~io_stickyIn & g; // @[RoundingUnit.scala 25:24]
  wire [22:0] out_r_up = io_in + 23'h1; // @[RoundingUnit.scala 32:24]
  assign io_out = r_up ? out_r_up : io_in; // @[RoundingUnit.scala 33:16]
  assign io_cout = r_up & &io_in; // @[RoundingUnit.scala 36:19]
endmodule
module ShiftRightJam_3(
  input  [24:0] io_in,
  input  [10:0] io_shamt,
  output [24:0] io_out,
  output        io_sticky
);
  wire  exceed_max_shift = io_shamt > 11'h19; // @[ShiftRightJam.scala 17:35]
  wire [4:0] shamt = io_shamt[4:0]; // @[ShiftRightJam.scala 18:23]
  wire [31:0] _sticky_mask_T = 32'h1 << shamt; // @[ShiftRightJam.scala 20:11]
  wire [31:0] _sticky_mask_T_2 = _sticky_mask_T - 32'h1; // @[ShiftRightJam.scala 20:30]
  wire [24:0] _sticky_mask_T_5 = exceed_max_shift ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] sticky_mask = _sticky_mask_T_2[24:0] | _sticky_mask_T_5; // @[ShiftRightJam.scala 20:49]
  wire [24:0] _io_out_T = io_in >> io_shamt; // @[ShiftRightJam.scala 21:46]
  wire [24:0] _io_sticky_T = io_in & sticky_mask; // @[ShiftRightJam.scala 22:23]
  assign io_out = exceed_max_shift ? 25'h0 : _io_out_T; // @[ShiftRightJam.scala 21:16]
  assign io_sticky = |_io_sticky_T; // @[ShiftRightJam.scala 22:41]
endmodule
module FPDownConverter_2(
  input  [63:0] io_in,
  output [31:0] io_result
);
  wire [22:0] normal_rounder_io_in; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_roundIn; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_stickyIn; // @[FPToFP.scala 80:30]
  wire [22:0] normal_rounder_io_out; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_cout; // @[FPToFP.scala 80:30]
  wire [24:0] shiftRightJam_io_in; // @[ShiftRightJam.scala 27:31]
  wire [10:0] shiftRightJam_io_shamt; // @[ShiftRightJam.scala 27:31]
  wire [24:0] shiftRightJam_io_out; // @[ShiftRightJam.scala 27:31]
  wire  shiftRightJam_io_sticky; // @[ShiftRightJam.scala 27:31]
  wire [22:0] subnormal_rounder_io_in; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_roundIn; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_stickyIn; // @[FPToFP.scala 114:33]
  wire [22:0] subnormal_rounder_io_out; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_cout; // @[FPToFP.scala 114:33]
  wire  fp_in_sign = io_in[63]; // @[package.scala 59:19]
  wire [10:0] fp_in_exp = io_in[62:52]; // @[package.scala 60:18]
  wire [51:0] fp_in_sig = io_in[51:0]; // @[package.scala 61:18]
  wire  decode_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode__isNaN = decode_expIsOnes & decode_sigNotZero; // @[package.scala 44:40]
  wire [11:0] _down_exp_T = {1'b0,$signed(fp_in_exp)}; // @[FPToFP.scala 71:32]
  wire [11:0] down_exp = $signed(_down_exp_T) - 12'sh380; // @[FPToFP.scala 71:35]
  wire  normal_stickyBit = |fp_in_sig[27:0]; // @[FPToFP.scala 78:58]
  wire [11:0] _normal_exp_rounded_T_2 = $signed(down_exp) + 12'sh1; // @[FPToFP.scala 88:65]
  wire [11:0] normal_exp_rounded = normal_rounder_io_cout ? $signed(_normal_exp_rounded_T_2) : $signed(down_exp); // @[FPToFP.scala 88:31]
  wire  _normal_of_T = $signed(down_exp) > 12'shfd; // @[FPToFP.scala 91:14]
  wire  _normal_of_T_1 = $signed(down_exp) > 12'shfe; // @[FPToFP.scala 92:14]
  wire  normal_of = normal_rounder_io_cout ? _normal_of_T : _normal_of_T_1; // @[FPToFP.scala 89:22]
  wire  _exp_uf_T_1 = $signed(down_exp) < 12'sh1; // @[FPToFP.scala 94:69]
  wire  subnormal_exp_rounded = subnormal_rounder_io_cout; // @[FPToFP.scala 121:34]
  wire  _common_exp_T = ~_exp_uf_T_1; // @[FPToFP.scala 143:7]
  wire  _common_exp_T_1 = ~_exp_uf_T_1 & normal_of; // @[FPToFP.scala 143:25]
  wire  _common_exp_T_4 = _common_exp_T & ~normal_of; // @[FPToFP.scala 144:25]
  wire [7:0] _common_exp_T_6 = _common_exp_T_1 ? 8'hff : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _common_exp_T_7 = _common_exp_T_4 ? normal_exp_rounded[7:0] : 8'h0; // @[Mux.scala 27:73]
  wire  _common_exp_T_8 = _exp_uf_T_1 & subnormal_exp_rounded; // @[Mux.scala 27:73]
  wire [7:0] _common_exp_T_9 = _common_exp_T_6 | _common_exp_T_7; // @[Mux.scala 27:73]
  wire [7:0] _GEN_1 = {{7'd0}, _common_exp_T_8}; // @[Mux.scala 27:73]
  wire [7:0] common_exp = _common_exp_T_9 | _GEN_1; // @[Mux.scala 27:73]
  wire [22:0] _common_sig_T_6 = _common_exp_T_4 ? normal_rounder_io_out : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _common_sig_T_7 = _exp_uf_T_1 ? subnormal_rounder_io_out : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] common_sig = _common_sig_T_6 | _common_sig_T_7; // @[Mux.scala 27:73]
  wire  _of_T = ~decode_expIsOnes; // @[FPToFP.scala 171:12]
  wire  _result_T_1 = ~decode__isNaN & fp_in_sign; // @[FPToFP.scala 179:19]
  wire [7:0] _result_T_4 = decode_expIsOnes ? 8'hff : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_5 = _of_T ? common_exp : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_6 = _result_T_4 | _result_T_5; // @[Mux.scala 27:73]
  wire [22:0] _result_T_8 = {decode_sigNotZero,22'h0}; // @[Cat.scala 33:92]
  wire [22:0] _result_T_9 = decode_expIsOnes ? _result_T_8 : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _result_T_10 = _of_T ? common_sig : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _result_T_11 = _result_T_9 | _result_T_10; // @[Mux.scala 27:73]
  wire [8:0] result_hi = {_result_T_1,_result_T_6}; // @[Cat.scala 33:92]
  RoundingUnit_10 normal_rounder ( // @[FPToFP.scala 80:30]
    .io_in(normal_rounder_io_in),
    .io_roundIn(normal_rounder_io_roundIn),
    .io_stickyIn(normal_rounder_io_stickyIn),
    .io_out(normal_rounder_io_out),
    .io_cout(normal_rounder_io_cout)
  );
  ShiftRightJam_3 shiftRightJam ( // @[ShiftRightJam.scala 27:31]
    .io_in(shiftRightJam_io_in),
    .io_shamt(shiftRightJam_io_shamt),
    .io_out(shiftRightJam_io_out),
    .io_sticky(shiftRightJam_io_sticky)
  );
  RoundingUnit_10 subnormal_rounder ( // @[FPToFP.scala 114:33]
    .io_in(subnormal_rounder_io_in),
    .io_roundIn(subnormal_rounder_io_roundIn),
    .io_stickyIn(subnormal_rounder_io_stickyIn),
    .io_out(subnormal_rounder_io_out),
    .io_cout(subnormal_rounder_io_cout)
  );
  assign io_result = {result_hi,_result_T_11}; // @[Cat.scala 33:92]
  assign normal_rounder_io_in = fp_in_sig[51:29]; // @[FPToFP.scala 76:34]
  assign normal_rounder_io_roundIn = fp_in_sig[28]; // @[FPToFP.scala 77:62]
  assign normal_rounder_io_stickyIn = |fp_in_sig[27:0]; // @[FPToFP.scala 78:58]
  assign shiftRightJam_io_in = {decode_expNotZero,fp_in_sig[51:28]}; // @[Cat.scala 33:92]
  assign shiftRightJam_io_shamt = 11'h381 - fp_in_exp; // @[FPToFP.scala 108:47]
  assign subnormal_rounder_io_in = shiftRightJam_io_out[23:1]; // @[FPToFP.scala 115:56]
  assign subnormal_rounder_io_roundIn = shiftRightJam_io_out[0]; // @[FPToFP.scala 116:48]
  assign subnormal_rounder_io_stickyIn = shiftRightJam_io_sticky | normal_stickyBit; // @[FPToFP.scala 113:42]
endmodule
module FPToFP_11(
  input  [63:0] io_in,
  output [31:0] io_result
);
  wire [63:0] converter_io_in; // @[FPToFP.scala 33:11]
  wire [31:0] converter_io_result; // @[FPToFP.scala 33:11]
  FPDownConverter_2 converter ( // @[FPToFP.scala 33:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module AecFpUnit(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [6:0]  io_req_bits_op,
  input  [3:0]  io_req_bits_dtype,
  input  [63:0] io_req_bits_a,
  input  [63:0] io_req_bits_b,
  input  [63:0] io_req_bits_c,
  input  [7:0]  io_req_bits_dest,
  input         io_resp_ready,
  output        io_resp_valid,
  output [63:0] io_resp_bits_result,
  output        io_resp_bits_predicate_result,
  output [7:0]  io_resp_bits_dest,
  output        io_resp_bits_error,
  output [4:0]  io_resp_bits_exception_flags
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  f64Pipe_clock; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_reset; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_in_ready; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_in_valid; // @[AecFpUnit.scala 67:23]
  wire [2:0] f64Pipe_io_in_bits_op; // @[AecFpUnit.scala 67:23]
  wire [63:0] f64Pipe_io_in_bits_a; // @[AecFpUnit.scala 67:23]
  wire [63:0] f64Pipe_io_in_bits_b; // @[AecFpUnit.scala 67:23]
  wire [63:0] f64Pipe_io_in_bits_c; // @[AecFpUnit.scala 67:23]
  wire [5:0] f64Pipe_io_in_bits_ctrl_seq; // @[AecFpUnit.scala 67:23]
  wire [7:0] f64Pipe_io_in_bits_ctrl_dest; // @[AecFpUnit.scala 67:23]
  wire [3:0] f64Pipe_io_in_bits_ctrl_dtype; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_in_bits_ctrl_finite_fma; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_in_bits_ctrl_fma_sign; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_out_ready; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_out_valid; // @[AecFpUnit.scala 67:23]
  wire [63:0] f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 67:23]
  wire [4:0] f64Pipe_io_out_bits_fflags; // @[AecFpUnit.scala 67:23]
  wire [5:0] f64Pipe_io_out_bits_ctrl_seq; // @[AecFpUnit.scala 67:23]
  wire [7:0] f64Pipe_io_out_bits_ctrl_dest; // @[AecFpUnit.scala 67:23]
  wire [3:0] f64Pipe_io_out_bits_ctrl_dtype; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_out_bits_ctrl_finite_fma; // @[AecFpUnit.scala 67:23]
  wire  f64Pipe_io_out_bits_ctrl_fma_sign; // @[AecFpUnit.scala 67:23]
  wire  issueQ_clock; // @[AecFpUnit.scala 68:22]
  wire  issueQ_reset; // @[AecFpUnit.scala 68:22]
  wire  issueQ_io_enq_ready; // @[AecFpUnit.scala 68:22]
  wire  issueQ_io_enq_valid; // @[AecFpUnit.scala 68:22]
  wire [5:0] issueQ_io_enq_bits; // @[AecFpUnit.scala 68:22]
  wire  issueQ_io_deq_ready; // @[AecFpUnit.scala 68:22]
  wire  issueQ_io_deq_valid; // @[AecFpUnit.scala 68:22]
  wire [5:0] issueQ_io_deq_bits; // @[AecFpUnit.scala 68:22]
  wire [15:0] f16Up_0_io_in; // @[AecFpUnit.scala 77:33]
  wire [63:0] f16Up_0_io_result; // @[AecFpUnit.scala 77:33]
  wire [15:0] f16Up_1_io_in; // @[AecFpUnit.scala 77:33]
  wire [63:0] f16Up_1_io_result; // @[AecFpUnit.scala 77:33]
  wire [15:0] f16Up_2_io_in; // @[AecFpUnit.scala 77:33]
  wire [63:0] f16Up_2_io_result; // @[AecFpUnit.scala 77:33]
  wire [15:0] bf16Up_0_io_in; // @[AecFpUnit.scala 78:34]
  wire [63:0] bf16Up_0_io_result; // @[AecFpUnit.scala 78:34]
  wire [15:0] bf16Up_1_io_in; // @[AecFpUnit.scala 78:34]
  wire [63:0] bf16Up_1_io_result; // @[AecFpUnit.scala 78:34]
  wire [15:0] bf16Up_2_io_in; // @[AecFpUnit.scala 78:34]
  wire [63:0] bf16Up_2_io_result; // @[AecFpUnit.scala 78:34]
  wire [31:0] f32Up_0_io_in; // @[AecFpUnit.scala 79:33]
  wire [63:0] f32Up_0_io_result; // @[AecFpUnit.scala 79:33]
  wire [31:0] f32Up_1_io_in; // @[AecFpUnit.scala 79:33]
  wire [63:0] f32Up_1_io_result; // @[AecFpUnit.scala 79:33]
  wire [31:0] f32Up_2_io_in; // @[AecFpUnit.scala 79:33]
  wire [63:0] f32Up_2_io_result; // @[AecFpUnit.scala 79:33]
  wire [16:0] cmp16_io_a; // @[AecFpUnit.scala 123:21]
  wire [16:0] cmp16_io_b; // @[AecFpUnit.scala 123:21]
  wire  cmp16_io_lt; // @[AecFpUnit.scala 123:21]
  wire  cmp16_io_eq; // @[AecFpUnit.scala 123:21]
  wire  cmp16_io_gt; // @[AecFpUnit.scala 123:21]
  wire [32:0] cmp32_io_a; // @[AecFpUnit.scala 123:66]
  wire [32:0] cmp32_io_b; // @[AecFpUnit.scala 123:66]
  wire  cmp32_io_lt; // @[AecFpUnit.scala 123:66]
  wire  cmp32_io_eq; // @[AecFpUnit.scala 123:66]
  wire  cmp32_io_gt; // @[AecFpUnit.scala 123:66]
  wire [64:0] cmp64_io_a; // @[AecFpUnit.scala 123:111]
  wire [64:0] cmp64_io_b; // @[AecFpUnit.scala 123:111]
  wire  cmp64_io_lt; // @[AecFpUnit.scala 123:111]
  wire  cmp64_io_eq; // @[AecFpUnit.scala 123:111]
  wire  cmp64_io_gt; // @[AecFpUnit.scala 123:111]
  wire [63:0] f64DownF16_io_in; // @[AecFpUnit.scala 154:26]
  wire [15:0] f64DownF16_io_result; // @[AecFpUnit.scala 154:26]
  wire [63:0] f64DownBf16_io_in; // @[AecFpUnit.scala 155:27]
  wire [15:0] f64DownBf16_io_result; // @[AecFpUnit.scala 155:27]
  wire [63:0] f64DownF32_io_in; // @[AecFpUnit.scala 156:26]
  wire [31:0] f64DownF32_io_result; // @[AecFpUnit.scala 156:26]
  reg [6:0] held_op; // @[AecFpUnit.scala 62:17]
  reg [3:0] held_dtype; // @[AecFpUnit.scala 62:17]
  reg [63:0] held_a; // @[AecFpUnit.scala 62:17]
  reg [63:0] held_b; // @[AecFpUnit.scala 62:17]
  reg [7:0] held_dest; // @[AecFpUnit.scala 62:17]
  reg  busy; // @[AecFpUnit.scala 63:21]
  wire  _reqPipe_T_3 = io_req_bits_op == 7'h3; // @[AecFpUnit.scala 66:22]
  wire  _reqPipe_T_4 = io_req_bits_op == 7'h1 | io_req_bits_op == 7'h2 | _reqPipe_T_3; // @[AecFpUnit.scala 65:71]
  wire  _reqPipe_T_5 = io_req_bits_op == 7'h5; // @[AecFpUnit.scala 66:56]
  wire  reqPipe = _reqPipe_T_4 | io_req_bits_op == 7'h5; // @[AecFpUnit.scala 66:38]
  reg [5:0] issueSeq; // @[AecFpUnit.scala 69:25]
  wire [2:0] _pipeOp_T_3 = 7'h2 == io_req_bits_op ? 3'h1 : 3'h0; // @[Mux.scala 81:58]
  wire [2:0] _pipeOp_T_5 = 7'h3 == io_req_bits_op ? 3'h2 : _pipeOp_T_3; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_a_T_1 = 4'ha == io_req_bits_dtype ? f16Up_0_io_result : io_req_bits_a; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_a_T_3 = 4'hb == io_req_bits_dtype ? bf16Up_0_io_result : _f64Pipe_io_in_bits_a_T_1; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_a_T_5 = 4'h8 == io_req_bits_dtype ? f32Up_0_io_result : _f64Pipe_io_in_bits_a_T_3; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_a_T_7 = 4'h9 == io_req_bits_dtype ? io_req_bits_a : _f64Pipe_io_in_bits_a_T_5; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_b_T_1 = 4'ha == io_req_bits_dtype ? f16Up_1_io_result : io_req_bits_a; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_b_T_3 = 4'hb == io_req_bits_dtype ? bf16Up_1_io_result : _f64Pipe_io_in_bits_b_T_1; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_b_T_5 = 4'h8 == io_req_bits_dtype ? f32Up_1_io_result : _f64Pipe_io_in_bits_b_T_3; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_b_T_7 = 4'h9 == io_req_bits_dtype ? io_req_bits_b : _f64Pipe_io_in_bits_b_T_5; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_c_T_1 = 4'ha == io_req_bits_dtype ? f16Up_2_io_result : io_req_bits_a; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_c_T_3 = 4'hb == io_req_bits_dtype ? bf16Up_2_io_result : _f64Pipe_io_in_bits_c_T_1; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_c_T_5 = 4'h8 == io_req_bits_dtype ? f32Up_2_io_result : _f64Pipe_io_in_bits_c_T_3; // @[Mux.scala 81:58]
  wire [63:0] _f64Pipe_io_in_bits_c_T_7 = 4'h9 == io_req_bits_dtype ? io_req_bits_c : _f64Pipe_io_in_bits_c_T_5; // @[Mux.scala 81:58]
  wire  _f64Pipe_io_in_bits_ctrl_finite_fma_T_10 = _f64Pipe_io_in_bits_a_T_7[62:52] != 11'h7ff; // @[AecFpUnit.scala 101:30]
  wire  _f64Pipe_io_in_bits_ctrl_finite_fma_T_11 = _reqPipe_T_5 & _f64Pipe_io_in_bits_ctrl_finite_fma_T_10; // @[AecFpUnit.scala 100:55]
  wire  _f64Pipe_io_in_valid_T = ~busy; // @[AecFpUnit.scala 103:41]
  wire  _selectedPipeReady_T_3 = 4'hb == io_req_bits_dtype ? f64Pipe_io_in_ready : 4'ha == io_req_bits_dtype &
    f64Pipe_io_in_ready; // @[Mux.scala 81:58]
  wire  _selectedPipeReady_T_5 = 4'h8 == io_req_bits_dtype ? f64Pipe_io_in_ready : _selectedPipeReady_T_3; // @[Mux.scala 81:58]
  wire  selectedPipeReady = 4'h9 == io_req_bits_dtype ? f64Pipe_io_in_ready : _selectedPipeReady_T_5; // @[Mux.scala 81:58]
  wire  _io_req_ready_T_3 = reqPipe ? selectedPipeReady & issueQ_io_enq_ready : 1'h1; // @[AecFpUnit.scala 110:52]
  wire  _issueQ_io_enq_valid_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [5:0] _issueSeq_T_1 = issueSeq + 6'h1; // @[AecFpUnit.scala 113:45]
  wire  _GEN_7 = _issueQ_io_enq_valid_T & ~reqPipe | busy; // @[AecFpUnit.scala 114:{34,62} 63:21]
  wire  isF32 = held_dtype == 4'h8; // @[AecFpUnit.scala 118:26]
  wire  isF64 = held_dtype == 4'h9; // @[AecFpUnit.scala 118:58]
  wire [31:0] _cmp16_io_a_T_3 = {held_a[15:0],16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _cmp16_io_a_T_7 = 4'ha == held_dtype ? {{16'd0}, held_a[15:0]} : held_a[31:0]; // @[Mux.scala 81:58]
  wire [31:0] _cmp16_io_a_T_9 = 4'hb == held_dtype ? _cmp16_io_a_T_3 : _cmp16_io_a_T_7; // @[Mux.scala 81:58]
  wire [31:0] _cmp16_io_a_T_11 = 4'h8 == held_dtype ? held_a[31:0] : _cmp16_io_a_T_9; // @[Mux.scala 81:58]
  wire [63:0] _cmp16_io_a_T_13 = 4'h9 == held_dtype ? held_a : {{32'd0}, _cmp16_io_a_T_11}; // @[Mux.scala 81:58]
  wire  cmp16_io_a_rawIn_sign = _cmp16_io_a_T_13[15]; // @[rawFloatFromFN.scala 44:18]
  wire [4:0] cmp16_io_a_rawIn_expIn = _cmp16_io_a_T_13[14:10]; // @[rawFloatFromFN.scala 45:19]
  wire [9:0] cmp16_io_a_rawIn_fractIn = _cmp16_io_a_T_13[9:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp16_io_a_rawIn_isZeroExpIn = cmp16_io_a_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp16_io_a_rawIn_isZeroFractIn = cmp16_io_a_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 49:34]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_10 = cmp16_io_a_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_11 = cmp16_io_a_rawIn_fractIn[2] ? 4'h7 : _cmp16_io_a_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_12 = cmp16_io_a_rawIn_fractIn[3] ? 4'h6 : _cmp16_io_a_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_13 = cmp16_io_a_rawIn_fractIn[4] ? 4'h5 : _cmp16_io_a_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_14 = cmp16_io_a_rawIn_fractIn[5] ? 4'h4 : _cmp16_io_a_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_15 = cmp16_io_a_rawIn_fractIn[6] ? 4'h3 : _cmp16_io_a_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_16 = cmp16_io_a_rawIn_fractIn[7] ? 4'h2 : _cmp16_io_a_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_a_rawIn_normDist_T_17 = cmp16_io_a_rawIn_fractIn[8] ? 4'h1 : _cmp16_io_a_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] cmp16_io_a_rawIn_normDist = cmp16_io_a_rawIn_fractIn[9] ? 4'h0 : _cmp16_io_a_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_1 = {{15'd0}, cmp16_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _cmp16_io_a_rawIn_subnormFract_T = _GEN_1 << cmp16_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] cmp16_io_a_rawIn_subnormFract = {_cmp16_io_a_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_9 = {{2'd0}, cmp16_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_a_rawIn_adjustedExp_T = _GEN_9 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_a_rawIn_adjustedExp_T_1 = cmp16_io_a_rawIn_isZeroExpIn ? _cmp16_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp16_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp16_io_a_rawIn_adjustedExp_T_2 = cmp16_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_10 = {{3'd0}, _cmp16_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _cmp16_io_a_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_10; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_11 = {{1'd0}, _cmp16_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] cmp16_io_a_rawIn_adjustedExp = _cmp16_io_a_rawIn_adjustedExp_T_1 + _GEN_11; // @[rawFloatFromFN.scala 57:9]
  wire  cmp16_io_a_rawIn_isZero = cmp16_io_a_rawIn_isZeroExpIn & cmp16_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp16_io_a_rawIn_isSpecial = cmp16_io_a_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp16_io_a_rawIn__isNaN = cmp16_io_a_rawIn_isSpecial & ~cmp16_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] cmp16_io_a_rawIn__sExp = {1'b0,$signed(cmp16_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp16_io_a_rawIn_out_sig_T = ~cmp16_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _cmp16_io_a_rawIn_out_sig_T_2 = cmp16_io_a_rawIn_isZeroExpIn ? cmp16_io_a_rawIn_subnormFract :
    cmp16_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] cmp16_io_a_rawIn__sig = {1'h0,_cmp16_io_a_rawIn_out_sig_T,_cmp16_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp16_io_a_T_15 = cmp16_io_a_rawIn_isZero ? 3'h0 : cmp16_io_a_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_12 = {{2'd0}, cmp16_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp16_io_a_T_17 = _cmp16_io_a_T_15 | _GEN_12; // @[recFNFromFN.scala 48:76]
  wire [6:0] _cmp16_io_a_T_20 = {cmp16_io_a_rawIn_sign,_cmp16_io_a_T_17,cmp16_io_a_rawIn__sExp[2:0]}; // @[recFNFromFN.scala 49:45]
  wire [31:0] _cmp16_io_b_T_3 = {held_b[15:0],16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _cmp16_io_b_T_7 = 4'ha == held_dtype ? {{16'd0}, held_b[15:0]} : held_b[31:0]; // @[Mux.scala 81:58]
  wire [31:0] _cmp16_io_b_T_9 = 4'hb == held_dtype ? _cmp16_io_b_T_3 : _cmp16_io_b_T_7; // @[Mux.scala 81:58]
  wire [31:0] _cmp16_io_b_T_11 = 4'h8 == held_dtype ? held_b[31:0] : _cmp16_io_b_T_9; // @[Mux.scala 81:58]
  wire [63:0] _cmp16_io_b_T_13 = 4'h9 == held_dtype ? held_b : {{32'd0}, _cmp16_io_b_T_11}; // @[Mux.scala 81:58]
  wire  cmp16_io_b_rawIn_sign = _cmp16_io_b_T_13[15]; // @[rawFloatFromFN.scala 44:18]
  wire [4:0] cmp16_io_b_rawIn_expIn = _cmp16_io_b_T_13[14:10]; // @[rawFloatFromFN.scala 45:19]
  wire [9:0] cmp16_io_b_rawIn_fractIn = _cmp16_io_b_T_13[9:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp16_io_b_rawIn_isZeroExpIn = cmp16_io_b_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp16_io_b_rawIn_isZeroFractIn = cmp16_io_b_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 49:34]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_10 = cmp16_io_b_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_11 = cmp16_io_b_rawIn_fractIn[2] ? 4'h7 : _cmp16_io_b_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_12 = cmp16_io_b_rawIn_fractIn[3] ? 4'h6 : _cmp16_io_b_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_13 = cmp16_io_b_rawIn_fractIn[4] ? 4'h5 : _cmp16_io_b_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_14 = cmp16_io_b_rawIn_fractIn[5] ? 4'h4 : _cmp16_io_b_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_15 = cmp16_io_b_rawIn_fractIn[6] ? 4'h3 : _cmp16_io_b_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_16 = cmp16_io_b_rawIn_fractIn[7] ? 4'h2 : _cmp16_io_b_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _cmp16_io_b_rawIn_normDist_T_17 = cmp16_io_b_rawIn_fractIn[8] ? 4'h1 : _cmp16_io_b_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] cmp16_io_b_rawIn_normDist = cmp16_io_b_rawIn_fractIn[9] ? 4'h0 : _cmp16_io_b_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_2 = {{15'd0}, cmp16_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _cmp16_io_b_rawIn_subnormFract_T = _GEN_2 << cmp16_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] cmp16_io_b_rawIn_subnormFract = {_cmp16_io_b_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_13 = {{2'd0}, cmp16_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_b_rawIn_adjustedExp_T = _GEN_13 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_b_rawIn_adjustedExp_T_1 = cmp16_io_b_rawIn_isZeroExpIn ? _cmp16_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp16_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp16_io_b_rawIn_adjustedExp_T_2 = cmp16_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_14 = {{3'd0}, _cmp16_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _cmp16_io_b_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_14; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_15 = {{1'd0}, _cmp16_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] cmp16_io_b_rawIn_adjustedExp = _cmp16_io_b_rawIn_adjustedExp_T_1 + _GEN_15; // @[rawFloatFromFN.scala 57:9]
  wire  cmp16_io_b_rawIn_isZero = cmp16_io_b_rawIn_isZeroExpIn & cmp16_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp16_io_b_rawIn_isSpecial = cmp16_io_b_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp16_io_b_rawIn__isNaN = cmp16_io_b_rawIn_isSpecial & ~cmp16_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] cmp16_io_b_rawIn__sExp = {1'b0,$signed(cmp16_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp16_io_b_rawIn_out_sig_T = ~cmp16_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _cmp16_io_b_rawIn_out_sig_T_2 = cmp16_io_b_rawIn_isZeroExpIn ? cmp16_io_b_rawIn_subnormFract :
    cmp16_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] cmp16_io_b_rawIn__sig = {1'h0,_cmp16_io_b_rawIn_out_sig_T,_cmp16_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp16_io_b_T_15 = cmp16_io_b_rawIn_isZero ? 3'h0 : cmp16_io_b_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_16 = {{2'd0}, cmp16_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp16_io_b_T_17 = _cmp16_io_b_T_15 | _GEN_16; // @[recFNFromFN.scala 48:76]
  wire [6:0] _cmp16_io_b_T_20 = {cmp16_io_b_rawIn_sign,_cmp16_io_b_T_17,cmp16_io_b_rawIn__sExp[2:0]}; // @[recFNFromFN.scala 49:45]
  wire  cmp32_io_a_rawIn_sign = _cmp16_io_a_T_13[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] cmp32_io_a_rawIn_expIn = _cmp16_io_a_T_13[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] cmp32_io_a_rawIn_fractIn = _cmp16_io_a_T_13[22:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp32_io_a_rawIn_isZeroExpIn = cmp32_io_a_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp32_io_a_rawIn_isZeroFractIn = cmp32_io_a_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 49:34]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_23 = cmp32_io_a_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_24 = cmp32_io_a_rawIn_fractIn[2] ? 5'h14 : _cmp32_io_a_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_25 = cmp32_io_a_rawIn_fractIn[3] ? 5'h13 : _cmp32_io_a_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_26 = cmp32_io_a_rawIn_fractIn[4] ? 5'h12 : _cmp32_io_a_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_27 = cmp32_io_a_rawIn_fractIn[5] ? 5'h11 : _cmp32_io_a_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_28 = cmp32_io_a_rawIn_fractIn[6] ? 5'h10 : _cmp32_io_a_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_29 = cmp32_io_a_rawIn_fractIn[7] ? 5'hf : _cmp32_io_a_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_30 = cmp32_io_a_rawIn_fractIn[8] ? 5'he : _cmp32_io_a_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_31 = cmp32_io_a_rawIn_fractIn[9] ? 5'hd : _cmp32_io_a_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_32 = cmp32_io_a_rawIn_fractIn[10] ? 5'hc : _cmp32_io_a_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_33 = cmp32_io_a_rawIn_fractIn[11] ? 5'hb : _cmp32_io_a_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_34 = cmp32_io_a_rawIn_fractIn[12] ? 5'ha : _cmp32_io_a_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_35 = cmp32_io_a_rawIn_fractIn[13] ? 5'h9 : _cmp32_io_a_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_36 = cmp32_io_a_rawIn_fractIn[14] ? 5'h8 : _cmp32_io_a_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_37 = cmp32_io_a_rawIn_fractIn[15] ? 5'h7 : _cmp32_io_a_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_38 = cmp32_io_a_rawIn_fractIn[16] ? 5'h6 : _cmp32_io_a_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_39 = cmp32_io_a_rawIn_fractIn[17] ? 5'h5 : _cmp32_io_a_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_40 = cmp32_io_a_rawIn_fractIn[18] ? 5'h4 : _cmp32_io_a_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_41 = cmp32_io_a_rawIn_fractIn[19] ? 5'h3 : _cmp32_io_a_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_42 = cmp32_io_a_rawIn_fractIn[20] ? 5'h2 : _cmp32_io_a_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_a_rawIn_normDist_T_43 = cmp32_io_a_rawIn_fractIn[21] ? 5'h1 : _cmp32_io_a_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] cmp32_io_a_rawIn_normDist = cmp32_io_a_rawIn_fractIn[22] ? 5'h0 : _cmp32_io_a_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_3 = {{31'd0}, cmp32_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_a_rawIn_subnormFract_T = _GEN_3 << cmp32_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] cmp32_io_a_rawIn_subnormFract = {_cmp32_io_a_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_17 = {{4'd0}, cmp32_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_a_rawIn_adjustedExp_T = _GEN_17 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_a_rawIn_adjustedExp_T_1 = cmp32_io_a_rawIn_isZeroExpIn ? _cmp32_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp32_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp32_io_a_rawIn_adjustedExp_T_2 = cmp32_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_18 = {{6'd0}, _cmp32_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _cmp32_io_a_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_18; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_19 = {{1'd0}, _cmp32_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] cmp32_io_a_rawIn_adjustedExp = _cmp32_io_a_rawIn_adjustedExp_T_1 + _GEN_19; // @[rawFloatFromFN.scala 57:9]
  wire  cmp32_io_a_rawIn_isZero = cmp32_io_a_rawIn_isZeroExpIn & cmp32_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp32_io_a_rawIn_isSpecial = cmp32_io_a_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp32_io_a_rawIn__isNaN = cmp32_io_a_rawIn_isSpecial & ~cmp32_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] cmp32_io_a_rawIn__sExp = {1'b0,$signed(cmp32_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp32_io_a_rawIn_out_sig_T = ~cmp32_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _cmp32_io_a_rawIn_out_sig_T_2 = cmp32_io_a_rawIn_isZeroExpIn ? cmp32_io_a_rawIn_subnormFract :
    cmp32_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] cmp32_io_a_rawIn__sig = {1'h0,_cmp32_io_a_rawIn_out_sig_T,_cmp32_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp32_io_a_T_15 = cmp32_io_a_rawIn_isZero ? 3'h0 : cmp32_io_a_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_20 = {{2'd0}, cmp32_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_a_T_17 = _cmp32_io_a_T_15 | _GEN_20; // @[recFNFromFN.scala 48:76]
  wire [9:0] _cmp32_io_a_T_20 = {cmp32_io_a_rawIn_sign,_cmp32_io_a_T_17,cmp32_io_a_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire  cmp32_io_b_rawIn_sign = _cmp16_io_b_T_13[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] cmp32_io_b_rawIn_expIn = _cmp16_io_b_T_13[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] cmp32_io_b_rawIn_fractIn = _cmp16_io_b_T_13[22:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp32_io_b_rawIn_isZeroExpIn = cmp32_io_b_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp32_io_b_rawIn_isZeroFractIn = cmp32_io_b_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 49:34]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_23 = cmp32_io_b_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_24 = cmp32_io_b_rawIn_fractIn[2] ? 5'h14 : _cmp32_io_b_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_25 = cmp32_io_b_rawIn_fractIn[3] ? 5'h13 : _cmp32_io_b_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_26 = cmp32_io_b_rawIn_fractIn[4] ? 5'h12 : _cmp32_io_b_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_27 = cmp32_io_b_rawIn_fractIn[5] ? 5'h11 : _cmp32_io_b_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_28 = cmp32_io_b_rawIn_fractIn[6] ? 5'h10 : _cmp32_io_b_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_29 = cmp32_io_b_rawIn_fractIn[7] ? 5'hf : _cmp32_io_b_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_30 = cmp32_io_b_rawIn_fractIn[8] ? 5'he : _cmp32_io_b_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_31 = cmp32_io_b_rawIn_fractIn[9] ? 5'hd : _cmp32_io_b_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_32 = cmp32_io_b_rawIn_fractIn[10] ? 5'hc : _cmp32_io_b_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_33 = cmp32_io_b_rawIn_fractIn[11] ? 5'hb : _cmp32_io_b_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_34 = cmp32_io_b_rawIn_fractIn[12] ? 5'ha : _cmp32_io_b_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_35 = cmp32_io_b_rawIn_fractIn[13] ? 5'h9 : _cmp32_io_b_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_36 = cmp32_io_b_rawIn_fractIn[14] ? 5'h8 : _cmp32_io_b_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_37 = cmp32_io_b_rawIn_fractIn[15] ? 5'h7 : _cmp32_io_b_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_38 = cmp32_io_b_rawIn_fractIn[16] ? 5'h6 : _cmp32_io_b_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_39 = cmp32_io_b_rawIn_fractIn[17] ? 5'h5 : _cmp32_io_b_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_40 = cmp32_io_b_rawIn_fractIn[18] ? 5'h4 : _cmp32_io_b_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_41 = cmp32_io_b_rawIn_fractIn[19] ? 5'h3 : _cmp32_io_b_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_42 = cmp32_io_b_rawIn_fractIn[20] ? 5'h2 : _cmp32_io_b_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _cmp32_io_b_rawIn_normDist_T_43 = cmp32_io_b_rawIn_fractIn[21] ? 5'h1 : _cmp32_io_b_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] cmp32_io_b_rawIn_normDist = cmp32_io_b_rawIn_fractIn[22] ? 5'h0 : _cmp32_io_b_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_4 = {{31'd0}, cmp32_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_b_rawIn_subnormFract_T = _GEN_4 << cmp32_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] cmp32_io_b_rawIn_subnormFract = {_cmp32_io_b_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_21 = {{4'd0}, cmp32_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_b_rawIn_adjustedExp_T = _GEN_21 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_b_rawIn_adjustedExp_T_1 = cmp32_io_b_rawIn_isZeroExpIn ? _cmp32_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp32_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp32_io_b_rawIn_adjustedExp_T_2 = cmp32_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_22 = {{6'd0}, _cmp32_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _cmp32_io_b_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_22; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_23 = {{1'd0}, _cmp32_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] cmp32_io_b_rawIn_adjustedExp = _cmp32_io_b_rawIn_adjustedExp_T_1 + _GEN_23; // @[rawFloatFromFN.scala 57:9]
  wire  cmp32_io_b_rawIn_isZero = cmp32_io_b_rawIn_isZeroExpIn & cmp32_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp32_io_b_rawIn_isSpecial = cmp32_io_b_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp32_io_b_rawIn__isNaN = cmp32_io_b_rawIn_isSpecial & ~cmp32_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] cmp32_io_b_rawIn__sExp = {1'b0,$signed(cmp32_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp32_io_b_rawIn_out_sig_T = ~cmp32_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _cmp32_io_b_rawIn_out_sig_T_2 = cmp32_io_b_rawIn_isZeroExpIn ? cmp32_io_b_rawIn_subnormFract :
    cmp32_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] cmp32_io_b_rawIn__sig = {1'h0,_cmp32_io_b_rawIn_out_sig_T,_cmp32_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp32_io_b_T_15 = cmp32_io_b_rawIn_isZero ? 3'h0 : cmp32_io_b_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_24 = {{2'd0}, cmp32_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_b_T_17 = _cmp32_io_b_T_15 | _GEN_24; // @[recFNFromFN.scala 48:76]
  wire [9:0] _cmp32_io_b_T_20 = {cmp32_io_b_rawIn_sign,_cmp32_io_b_T_17,cmp32_io_b_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire  cmp64_io_a_rawIn_sign = held_a[63]; // @[rawFloatFromFN.scala 44:18]
  wire [10:0] cmp64_io_a_rawIn_expIn = held_a[62:52]; // @[rawFloatFromFN.scala 45:19]
  wire [51:0] cmp64_io_a_rawIn_fractIn = held_a[51:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp64_io_a_rawIn_isZeroExpIn = cmp64_io_a_rawIn_expIn == 11'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp64_io_a_rawIn_isZeroFractIn = cmp64_io_a_rawIn_fractIn == 52'h0; // @[rawFloatFromFN.scala 49:34]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_52 = cmp64_io_a_rawIn_fractIn[1] ? 6'h32 : 6'h33; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_53 = cmp64_io_a_rawIn_fractIn[2] ? 6'h31 : _cmp64_io_a_rawIn_normDist_T_52; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_54 = cmp64_io_a_rawIn_fractIn[3] ? 6'h30 : _cmp64_io_a_rawIn_normDist_T_53; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_55 = cmp64_io_a_rawIn_fractIn[4] ? 6'h2f : _cmp64_io_a_rawIn_normDist_T_54; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_56 = cmp64_io_a_rawIn_fractIn[5] ? 6'h2e : _cmp64_io_a_rawIn_normDist_T_55; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_57 = cmp64_io_a_rawIn_fractIn[6] ? 6'h2d : _cmp64_io_a_rawIn_normDist_T_56; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_58 = cmp64_io_a_rawIn_fractIn[7] ? 6'h2c : _cmp64_io_a_rawIn_normDist_T_57; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_59 = cmp64_io_a_rawIn_fractIn[8] ? 6'h2b : _cmp64_io_a_rawIn_normDist_T_58; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_60 = cmp64_io_a_rawIn_fractIn[9] ? 6'h2a : _cmp64_io_a_rawIn_normDist_T_59; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_61 = cmp64_io_a_rawIn_fractIn[10] ? 6'h29 : _cmp64_io_a_rawIn_normDist_T_60; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_62 = cmp64_io_a_rawIn_fractIn[11] ? 6'h28 : _cmp64_io_a_rawIn_normDist_T_61; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_63 = cmp64_io_a_rawIn_fractIn[12] ? 6'h27 : _cmp64_io_a_rawIn_normDist_T_62; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_64 = cmp64_io_a_rawIn_fractIn[13] ? 6'h26 : _cmp64_io_a_rawIn_normDist_T_63; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_65 = cmp64_io_a_rawIn_fractIn[14] ? 6'h25 : _cmp64_io_a_rawIn_normDist_T_64; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_66 = cmp64_io_a_rawIn_fractIn[15] ? 6'h24 : _cmp64_io_a_rawIn_normDist_T_65; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_67 = cmp64_io_a_rawIn_fractIn[16] ? 6'h23 : _cmp64_io_a_rawIn_normDist_T_66; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_68 = cmp64_io_a_rawIn_fractIn[17] ? 6'h22 : _cmp64_io_a_rawIn_normDist_T_67; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_69 = cmp64_io_a_rawIn_fractIn[18] ? 6'h21 : _cmp64_io_a_rawIn_normDist_T_68; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_70 = cmp64_io_a_rawIn_fractIn[19] ? 6'h20 : _cmp64_io_a_rawIn_normDist_T_69; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_71 = cmp64_io_a_rawIn_fractIn[20] ? 6'h1f : _cmp64_io_a_rawIn_normDist_T_70; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_72 = cmp64_io_a_rawIn_fractIn[21] ? 6'h1e : _cmp64_io_a_rawIn_normDist_T_71; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_73 = cmp64_io_a_rawIn_fractIn[22] ? 6'h1d : _cmp64_io_a_rawIn_normDist_T_72; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_74 = cmp64_io_a_rawIn_fractIn[23] ? 6'h1c : _cmp64_io_a_rawIn_normDist_T_73; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_75 = cmp64_io_a_rawIn_fractIn[24] ? 6'h1b : _cmp64_io_a_rawIn_normDist_T_74; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_76 = cmp64_io_a_rawIn_fractIn[25] ? 6'h1a : _cmp64_io_a_rawIn_normDist_T_75; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_77 = cmp64_io_a_rawIn_fractIn[26] ? 6'h19 : _cmp64_io_a_rawIn_normDist_T_76; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_78 = cmp64_io_a_rawIn_fractIn[27] ? 6'h18 : _cmp64_io_a_rawIn_normDist_T_77; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_79 = cmp64_io_a_rawIn_fractIn[28] ? 6'h17 : _cmp64_io_a_rawIn_normDist_T_78; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_80 = cmp64_io_a_rawIn_fractIn[29] ? 6'h16 : _cmp64_io_a_rawIn_normDist_T_79; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_81 = cmp64_io_a_rawIn_fractIn[30] ? 6'h15 : _cmp64_io_a_rawIn_normDist_T_80; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_82 = cmp64_io_a_rawIn_fractIn[31] ? 6'h14 : _cmp64_io_a_rawIn_normDist_T_81; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_83 = cmp64_io_a_rawIn_fractIn[32] ? 6'h13 : _cmp64_io_a_rawIn_normDist_T_82; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_84 = cmp64_io_a_rawIn_fractIn[33] ? 6'h12 : _cmp64_io_a_rawIn_normDist_T_83; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_85 = cmp64_io_a_rawIn_fractIn[34] ? 6'h11 : _cmp64_io_a_rawIn_normDist_T_84; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_86 = cmp64_io_a_rawIn_fractIn[35] ? 6'h10 : _cmp64_io_a_rawIn_normDist_T_85; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_87 = cmp64_io_a_rawIn_fractIn[36] ? 6'hf : _cmp64_io_a_rawIn_normDist_T_86; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_88 = cmp64_io_a_rawIn_fractIn[37] ? 6'he : _cmp64_io_a_rawIn_normDist_T_87; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_89 = cmp64_io_a_rawIn_fractIn[38] ? 6'hd : _cmp64_io_a_rawIn_normDist_T_88; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_90 = cmp64_io_a_rawIn_fractIn[39] ? 6'hc : _cmp64_io_a_rawIn_normDist_T_89; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_91 = cmp64_io_a_rawIn_fractIn[40] ? 6'hb : _cmp64_io_a_rawIn_normDist_T_90; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_92 = cmp64_io_a_rawIn_fractIn[41] ? 6'ha : _cmp64_io_a_rawIn_normDist_T_91; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_93 = cmp64_io_a_rawIn_fractIn[42] ? 6'h9 : _cmp64_io_a_rawIn_normDist_T_92; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_94 = cmp64_io_a_rawIn_fractIn[43] ? 6'h8 : _cmp64_io_a_rawIn_normDist_T_93; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_95 = cmp64_io_a_rawIn_fractIn[44] ? 6'h7 : _cmp64_io_a_rawIn_normDist_T_94; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_96 = cmp64_io_a_rawIn_fractIn[45] ? 6'h6 : _cmp64_io_a_rawIn_normDist_T_95; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_97 = cmp64_io_a_rawIn_fractIn[46] ? 6'h5 : _cmp64_io_a_rawIn_normDist_T_96; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_98 = cmp64_io_a_rawIn_fractIn[47] ? 6'h4 : _cmp64_io_a_rawIn_normDist_T_97; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_99 = cmp64_io_a_rawIn_fractIn[48] ? 6'h3 : _cmp64_io_a_rawIn_normDist_T_98; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_100 = cmp64_io_a_rawIn_fractIn[49] ? 6'h2 : _cmp64_io_a_rawIn_normDist_T_99; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_a_rawIn_normDist_T_101 = cmp64_io_a_rawIn_fractIn[50] ? 6'h1 : _cmp64_io_a_rawIn_normDist_T_100; // @[Mux.scala 47:70]
  wire [5:0] cmp64_io_a_rawIn_normDist = cmp64_io_a_rawIn_fractIn[51] ? 6'h0 : _cmp64_io_a_rawIn_normDist_T_101; // @[Mux.scala 47:70]
  wire [114:0] _GEN_5 = {{63'd0}, cmp64_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _cmp64_io_a_rawIn_subnormFract_T = _GEN_5 << cmp64_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] cmp64_io_a_rawIn_subnormFract = {_cmp64_io_a_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_25 = {{6'd0}, cmp64_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_a_rawIn_adjustedExp_T = _GEN_25 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_a_rawIn_adjustedExp_T_1 = cmp64_io_a_rawIn_isZeroExpIn ? _cmp64_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp64_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp64_io_a_rawIn_adjustedExp_T_2 = cmp64_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_26 = {{9'd0}, _cmp64_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _cmp64_io_a_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_26; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_27 = {{1'd0}, _cmp64_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] cmp64_io_a_rawIn_adjustedExp = _cmp64_io_a_rawIn_adjustedExp_T_1 + _GEN_27; // @[rawFloatFromFN.scala 57:9]
  wire  cmp64_io_a_rawIn_isZero = cmp64_io_a_rawIn_isZeroExpIn & cmp64_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp64_io_a_rawIn_isSpecial = cmp64_io_a_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp64_io_a_rawIn__isNaN = cmp64_io_a_rawIn_isSpecial & ~cmp64_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] cmp64_io_a_rawIn__sExp = {1'b0,$signed(cmp64_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp64_io_a_rawIn_out_sig_T = ~cmp64_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _cmp64_io_a_rawIn_out_sig_T_2 = cmp64_io_a_rawIn_isZeroExpIn ? cmp64_io_a_rawIn_subnormFract :
    cmp64_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] cmp64_io_a_rawIn__sig = {1'h0,_cmp64_io_a_rawIn_out_sig_T,_cmp64_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp64_io_a_T_1 = cmp64_io_a_rawIn_isZero ? 3'h0 : cmp64_io_a_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_28 = {{2'd0}, cmp64_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp64_io_a_T_3 = _cmp64_io_a_T_1 | _GEN_28; // @[recFNFromFN.scala 48:76]
  wire [12:0] _cmp64_io_a_T_6 = {cmp64_io_a_rawIn_sign,_cmp64_io_a_T_3,cmp64_io_a_rawIn__sExp[8:0]}; // @[recFNFromFN.scala 49:45]
  wire  cmp64_io_b_rawIn_sign = held_b[63]; // @[rawFloatFromFN.scala 44:18]
  wire [10:0] cmp64_io_b_rawIn_expIn = held_b[62:52]; // @[rawFloatFromFN.scala 45:19]
  wire [51:0] cmp64_io_b_rawIn_fractIn = held_b[51:0]; // @[rawFloatFromFN.scala 46:21]
  wire  cmp64_io_b_rawIn_isZeroExpIn = cmp64_io_b_rawIn_expIn == 11'h0; // @[rawFloatFromFN.scala 48:30]
  wire  cmp64_io_b_rawIn_isZeroFractIn = cmp64_io_b_rawIn_fractIn == 52'h0; // @[rawFloatFromFN.scala 49:34]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_52 = cmp64_io_b_rawIn_fractIn[1] ? 6'h32 : 6'h33; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_53 = cmp64_io_b_rawIn_fractIn[2] ? 6'h31 : _cmp64_io_b_rawIn_normDist_T_52; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_54 = cmp64_io_b_rawIn_fractIn[3] ? 6'h30 : _cmp64_io_b_rawIn_normDist_T_53; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_55 = cmp64_io_b_rawIn_fractIn[4] ? 6'h2f : _cmp64_io_b_rawIn_normDist_T_54; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_56 = cmp64_io_b_rawIn_fractIn[5] ? 6'h2e : _cmp64_io_b_rawIn_normDist_T_55; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_57 = cmp64_io_b_rawIn_fractIn[6] ? 6'h2d : _cmp64_io_b_rawIn_normDist_T_56; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_58 = cmp64_io_b_rawIn_fractIn[7] ? 6'h2c : _cmp64_io_b_rawIn_normDist_T_57; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_59 = cmp64_io_b_rawIn_fractIn[8] ? 6'h2b : _cmp64_io_b_rawIn_normDist_T_58; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_60 = cmp64_io_b_rawIn_fractIn[9] ? 6'h2a : _cmp64_io_b_rawIn_normDist_T_59; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_61 = cmp64_io_b_rawIn_fractIn[10] ? 6'h29 : _cmp64_io_b_rawIn_normDist_T_60; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_62 = cmp64_io_b_rawIn_fractIn[11] ? 6'h28 : _cmp64_io_b_rawIn_normDist_T_61; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_63 = cmp64_io_b_rawIn_fractIn[12] ? 6'h27 : _cmp64_io_b_rawIn_normDist_T_62; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_64 = cmp64_io_b_rawIn_fractIn[13] ? 6'h26 : _cmp64_io_b_rawIn_normDist_T_63; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_65 = cmp64_io_b_rawIn_fractIn[14] ? 6'h25 : _cmp64_io_b_rawIn_normDist_T_64; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_66 = cmp64_io_b_rawIn_fractIn[15] ? 6'h24 : _cmp64_io_b_rawIn_normDist_T_65; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_67 = cmp64_io_b_rawIn_fractIn[16] ? 6'h23 : _cmp64_io_b_rawIn_normDist_T_66; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_68 = cmp64_io_b_rawIn_fractIn[17] ? 6'h22 : _cmp64_io_b_rawIn_normDist_T_67; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_69 = cmp64_io_b_rawIn_fractIn[18] ? 6'h21 : _cmp64_io_b_rawIn_normDist_T_68; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_70 = cmp64_io_b_rawIn_fractIn[19] ? 6'h20 : _cmp64_io_b_rawIn_normDist_T_69; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_71 = cmp64_io_b_rawIn_fractIn[20] ? 6'h1f : _cmp64_io_b_rawIn_normDist_T_70; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_72 = cmp64_io_b_rawIn_fractIn[21] ? 6'h1e : _cmp64_io_b_rawIn_normDist_T_71; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_73 = cmp64_io_b_rawIn_fractIn[22] ? 6'h1d : _cmp64_io_b_rawIn_normDist_T_72; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_74 = cmp64_io_b_rawIn_fractIn[23] ? 6'h1c : _cmp64_io_b_rawIn_normDist_T_73; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_75 = cmp64_io_b_rawIn_fractIn[24] ? 6'h1b : _cmp64_io_b_rawIn_normDist_T_74; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_76 = cmp64_io_b_rawIn_fractIn[25] ? 6'h1a : _cmp64_io_b_rawIn_normDist_T_75; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_77 = cmp64_io_b_rawIn_fractIn[26] ? 6'h19 : _cmp64_io_b_rawIn_normDist_T_76; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_78 = cmp64_io_b_rawIn_fractIn[27] ? 6'h18 : _cmp64_io_b_rawIn_normDist_T_77; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_79 = cmp64_io_b_rawIn_fractIn[28] ? 6'h17 : _cmp64_io_b_rawIn_normDist_T_78; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_80 = cmp64_io_b_rawIn_fractIn[29] ? 6'h16 : _cmp64_io_b_rawIn_normDist_T_79; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_81 = cmp64_io_b_rawIn_fractIn[30] ? 6'h15 : _cmp64_io_b_rawIn_normDist_T_80; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_82 = cmp64_io_b_rawIn_fractIn[31] ? 6'h14 : _cmp64_io_b_rawIn_normDist_T_81; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_83 = cmp64_io_b_rawIn_fractIn[32] ? 6'h13 : _cmp64_io_b_rawIn_normDist_T_82; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_84 = cmp64_io_b_rawIn_fractIn[33] ? 6'h12 : _cmp64_io_b_rawIn_normDist_T_83; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_85 = cmp64_io_b_rawIn_fractIn[34] ? 6'h11 : _cmp64_io_b_rawIn_normDist_T_84; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_86 = cmp64_io_b_rawIn_fractIn[35] ? 6'h10 : _cmp64_io_b_rawIn_normDist_T_85; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_87 = cmp64_io_b_rawIn_fractIn[36] ? 6'hf : _cmp64_io_b_rawIn_normDist_T_86; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_88 = cmp64_io_b_rawIn_fractIn[37] ? 6'he : _cmp64_io_b_rawIn_normDist_T_87; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_89 = cmp64_io_b_rawIn_fractIn[38] ? 6'hd : _cmp64_io_b_rawIn_normDist_T_88; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_90 = cmp64_io_b_rawIn_fractIn[39] ? 6'hc : _cmp64_io_b_rawIn_normDist_T_89; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_91 = cmp64_io_b_rawIn_fractIn[40] ? 6'hb : _cmp64_io_b_rawIn_normDist_T_90; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_92 = cmp64_io_b_rawIn_fractIn[41] ? 6'ha : _cmp64_io_b_rawIn_normDist_T_91; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_93 = cmp64_io_b_rawIn_fractIn[42] ? 6'h9 : _cmp64_io_b_rawIn_normDist_T_92; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_94 = cmp64_io_b_rawIn_fractIn[43] ? 6'h8 : _cmp64_io_b_rawIn_normDist_T_93; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_95 = cmp64_io_b_rawIn_fractIn[44] ? 6'h7 : _cmp64_io_b_rawIn_normDist_T_94; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_96 = cmp64_io_b_rawIn_fractIn[45] ? 6'h6 : _cmp64_io_b_rawIn_normDist_T_95; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_97 = cmp64_io_b_rawIn_fractIn[46] ? 6'h5 : _cmp64_io_b_rawIn_normDist_T_96; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_98 = cmp64_io_b_rawIn_fractIn[47] ? 6'h4 : _cmp64_io_b_rawIn_normDist_T_97; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_99 = cmp64_io_b_rawIn_fractIn[48] ? 6'h3 : _cmp64_io_b_rawIn_normDist_T_98; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_100 = cmp64_io_b_rawIn_fractIn[49] ? 6'h2 : _cmp64_io_b_rawIn_normDist_T_99; // @[Mux.scala 47:70]
  wire [5:0] _cmp64_io_b_rawIn_normDist_T_101 = cmp64_io_b_rawIn_fractIn[50] ? 6'h1 : _cmp64_io_b_rawIn_normDist_T_100; // @[Mux.scala 47:70]
  wire [5:0] cmp64_io_b_rawIn_normDist = cmp64_io_b_rawIn_fractIn[51] ? 6'h0 : _cmp64_io_b_rawIn_normDist_T_101; // @[Mux.scala 47:70]
  wire [114:0] _GEN_6 = {{63'd0}, cmp64_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _cmp64_io_b_rawIn_subnormFract_T = _GEN_6 << cmp64_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] cmp64_io_b_rawIn_subnormFract = {_cmp64_io_b_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_29 = {{6'd0}, cmp64_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_b_rawIn_adjustedExp_T = _GEN_29 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_b_rawIn_adjustedExp_T_1 = cmp64_io_b_rawIn_isZeroExpIn ? _cmp64_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp64_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp64_io_b_rawIn_adjustedExp_T_2 = cmp64_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_30 = {{9'd0}, _cmp64_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _cmp64_io_b_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_30; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_31 = {{1'd0}, _cmp64_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] cmp64_io_b_rawIn_adjustedExp = _cmp64_io_b_rawIn_adjustedExp_T_1 + _GEN_31; // @[rawFloatFromFN.scala 57:9]
  wire  cmp64_io_b_rawIn_isZero = cmp64_io_b_rawIn_isZeroExpIn & cmp64_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp64_io_b_rawIn_isSpecial = cmp64_io_b_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp64_io_b_rawIn__isNaN = cmp64_io_b_rawIn_isSpecial & ~cmp64_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] cmp64_io_b_rawIn__sExp = {1'b0,$signed(cmp64_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp64_io_b_rawIn_out_sig_T = ~cmp64_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _cmp64_io_b_rawIn_out_sig_T_2 = cmp64_io_b_rawIn_isZeroExpIn ? cmp64_io_b_rawIn_subnormFract :
    cmp64_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] cmp64_io_b_rawIn__sig = {1'h0,_cmp64_io_b_rawIn_out_sig_T,_cmp64_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp64_io_b_T_1 = cmp64_io_b_rawIn_isZero ? 3'h0 : cmp64_io_b_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_32 = {{2'd0}, cmp64_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp64_io_b_T_3 = _cmp64_io_b_T_1 | _GEN_32; // @[recFNFromFN.scala 48:76]
  wire [12:0] _cmp64_io_b_T_6 = {cmp64_io_b_rawIn_sign,_cmp64_io_b_T_3,cmp64_io_b_rawIn__sExp[8:0]}; // @[recFNFromFN.scala 49:45]
  wire  f64AtHead = f64Pipe_io_out_valid & issueQ_io_deq_valid & f64Pipe_io_out_bits_ctrl_seq == issueQ_io_deq_bits; // @[AecFpUnit.scala 133:63]
  wire  oldAtHead = busy & issueQ_io_deq_valid; // @[AecFpUnit.scala 134:32]
  wire  _issueQ_io_deq_ready_T = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire  isCmp = held_op >= 7'h20 & held_op < 7'h26; // @[AecFpUnit.scala 140:42]
  wire  isCmpP = held_op >= 7'h28 & held_op < 7'h2e; // @[AecFpUnit.scala 141:44]
  wire [6:0] _cmpMode_T_1 = held_op - 7'h28; // @[AecFpUnit.scala 142:37]
  wire [6:0] _cmpMode_T_3 = held_op - 7'h20; // @[AecFpUnit.scala 142:65]
  wire [6:0] cmpMode = isCmpP ? _cmpMode_T_1 : _cmpMode_T_3; // @[AecFpUnit.scala 142:20]
  wire  _cmpTrue_T_1 = 4'ha == held_dtype ? cmp16_io_eq : cmp32_io_eq; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_3 = 4'hb == held_dtype ? cmp32_io_eq : _cmpTrue_T_1; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_5 = 4'h9 == held_dtype ? cmp64_io_eq : _cmpTrue_T_3; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_6 = ~cmp32_io_eq; // @[AecFpUnit.scala 145:34]
  wire  _cmpTrue_T_7 = ~cmp16_io_eq; // @[AecFpUnit.scala 145:62]
  wire  _cmpTrue_T_9 = ~cmp64_io_eq; // @[AecFpUnit.scala 145:109]
  wire  _cmpTrue_T_11 = 4'ha == held_dtype ? _cmpTrue_T_7 : _cmpTrue_T_6; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_13 = 4'hb == held_dtype ? _cmpTrue_T_6 : _cmpTrue_T_11; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_15 = 4'h9 == held_dtype ? _cmpTrue_T_9 : _cmpTrue_T_13; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_17 = 4'ha == held_dtype ? cmp16_io_lt : cmp32_io_lt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_19 = 4'hb == held_dtype ? cmp32_io_lt : _cmpTrue_T_17; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_21 = 4'h9 == held_dtype ? cmp64_io_lt : _cmpTrue_T_19; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_22 = cmp32_io_lt | cmp32_io_eq; // @[AecFpUnit.scala 147:46]
  wire  _cmpTrue_T_23 = cmp16_io_lt | cmp16_io_eq; // @[AecFpUnit.scala 147:87]
  wire  _cmpTrue_T_25 = cmp64_io_lt | cmp64_io_eq; // @[AecFpUnit.scala 147:162]
  wire  _cmpTrue_T_27 = 4'ha == held_dtype ? _cmpTrue_T_23 : _cmpTrue_T_22; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_29 = 4'hb == held_dtype ? _cmpTrue_T_22 : _cmpTrue_T_27; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_31 = 4'h9 == held_dtype ? _cmpTrue_T_25 : _cmpTrue_T_29; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_33 = 4'ha == held_dtype ? cmp16_io_gt : cmp32_io_gt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_35 = 4'hb == held_dtype ? cmp32_io_gt : _cmpTrue_T_33; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_37 = 4'h9 == held_dtype ? cmp64_io_gt : _cmpTrue_T_35; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_38 = cmp32_io_gt | cmp32_io_eq; // @[AecFpUnit.scala 149:46]
  wire  _cmpTrue_T_39 = cmp16_io_gt | cmp16_io_eq; // @[AecFpUnit.scala 149:87]
  wire  _cmpTrue_T_41 = cmp64_io_gt | cmp64_io_eq; // @[AecFpUnit.scala 149:162]
  wire  _cmpTrue_T_43 = 4'ha == held_dtype ? _cmpTrue_T_39 : _cmpTrue_T_38; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_45 = 4'hb == held_dtype ? _cmpTrue_T_38 : _cmpTrue_T_43; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_47 = 4'h9 == held_dtype ? _cmpTrue_T_41 : _cmpTrue_T_45; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_51 = 7'h1 == cmpMode ? _cmpTrue_T_15 : 7'h0 == cmpMode & _cmpTrue_T_5; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_53 = 7'h2 == cmpMode ? _cmpTrue_T_21 : _cmpTrue_T_51; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_55 = 7'h3 == cmpMode ? _cmpTrue_T_31 : _cmpTrue_T_53; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_57 = 7'h4 == cmpMode ? _cmpTrue_T_37 : _cmpTrue_T_55; // @[Mux.scala 81:58]
  wire  cmpTrue = 7'h5 == cmpMode ? _cmpTrue_T_47 : _cmpTrue_T_57; // @[Mux.scala 81:58]
  wire [94:0] _unarySign_T_3 = isF32 ? 95'h80000000 : 95'h8000; // @[AecFpUnit.scala 150:52]
  wire [126:0] unarySign = isF64 ? 127'h8000000000000000 : {{32'd0}, _unarySign_T_3}; // @[AecFpUnit.scala 150:22]
  wire  _unaryRaw_T = held_op == 7'h8; // @[AecFpUnit.scala 151:30]
  wire [126:0] _unaryRaw_T_1 = ~unarySign; // @[AecFpUnit.scala 151:56]
  wire [126:0] _GEN_33 = {{63'd0}, held_a}; // @[AecFpUnit.scala 151:54]
  wire [126:0] _unaryRaw_T_2 = _GEN_33 & _unaryRaw_T_1; // @[AecFpUnit.scala 151:54]
  wire  _unaryRaw_T_3 = held_op == 7'h7; // @[AecFpUnit.scala 151:80]
  wire [126:0] _unaryRaw_T_4 = _GEN_33 ^ unarySign; // @[AecFpUnit.scala 151:104]
  wire [126:0] _unaryRaw_T_5 = held_op == 7'h7 ? _unaryRaw_T_4 : {{63'd0}, held_a}; // @[AecFpUnit.scala 151:71]
  wire [126:0] unaryRaw = held_op == 7'h8 ? _unaryRaw_T_2 : _unaryRaw_T_5; // @[AecFpUnit.scala 151:21]
  wire [63:0] _unary_T_1 = {32'h0,unaryRaw[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_3 = {48'h0,unaryRaw[15:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_4 = isF32 ? _unary_T_1 : _unary_T_3; // @[AecFpUnit.scala 152:39]
  wire [126:0] unary = isF64 ? unaryRaw : {{63'd0}, _unary_T_4}; // @[AecFpUnit.scala 152:18]
  wire  _oldResult_T = isCmp | isCmpP; // @[AecFpUnit.scala 153:29]
  wire [63:0] _oldResult_T_1 = {63'h0,cmpTrue}; // @[Cat.scala 33:92]
  wire [126:0] oldResult = isCmp | isCmpP ? {{63'd0}, _oldResult_T_1} : unary; // @[AecFpUnit.scala 153:22]
  wire  pipeF64NaNRaw = f64Pipe_io_out_bits_result[62:52] == 11'h7ff & |f64Pipe_io_out_bits_result[51:0]; // @[AecFpUnit.scala 158:52]
  wire  _pipeF64Fixed_T = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma; // @[AecFpUnit.scala 159:40]
  wire [63:0] _pipeF64Fixed_T_1 = {f64Pipe_io_out_bits_ctrl_fma_sign,11'h7ff,52'h0}; // @[Cat.scala 33:92]
  wire [63:0] pipeF64Fixed = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 159:25]
  wire  pipeF64NaN = pipeF64Fixed[62:52] == 11'h7ff & |pipeF64Fixed[51:0]; // @[AecFpUnit.scala 164:51]
  wire [63:0] _pipeResult_T = {48'h0,f64DownF16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_1 = pipeF64NaN ? 64'h7e00 : _pipeResult_T; // @[AecFpUnit.scala 166:16]
  wire [63:0] _pipeResult_T_2 = {48'h0,f64DownBf16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_3 = pipeF64NaN ? 64'h7fc0 : _pipeResult_T_2; // @[AecFpUnit.scala 167:16]
  wire [63:0] _pipeResult_T_4 = {32'h0,f64DownF32_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_5 = pipeF64NaN ? 64'h7fc00000 : _pipeResult_T_4; // @[AecFpUnit.scala 168:15]
  wire [63:0] _pipeResult_T_7 = 4'ha == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_1 : pipeF64Fixed; // @[Mux.scala 81:58]
  wire [63:0] _pipeResult_T_9 = 4'hb == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_3 : _pipeResult_T_7; // @[Mux.scala 81:58]
  wire [63:0] pipeResult = 4'h8 == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_5 : _pipeResult_T_9; // @[Mux.scala 81:58]
  wire [4:0] f64Flags = _pipeF64Fixed_T ? 5'h5 : f64Pipe_io_out_bits_fflags; // @[AecFpUnit.scala 170:21]
  wire [126:0] _io_resp_bits_result_T = f64AtHead ? {{63'd0}, pipeResult} : oldResult; // @[AecFpUnit.scala 172:29]
  wire  _io_resp_bits_error_T_5 = ~(_oldResult_T | _unaryRaw_T_3 | _unaryRaw_T); // @[AecFpUnit.scala 176:5]
  FMA f64Pipe ( // @[AecFpUnit.scala 67:23]
    .clock(f64Pipe_clock),
    .reset(f64Pipe_reset),
    .io_in_ready(f64Pipe_io_in_ready),
    .io_in_valid(f64Pipe_io_in_valid),
    .io_in_bits_op(f64Pipe_io_in_bits_op),
    .io_in_bits_a(f64Pipe_io_in_bits_a),
    .io_in_bits_b(f64Pipe_io_in_bits_b),
    .io_in_bits_c(f64Pipe_io_in_bits_c),
    .io_in_bits_ctrl_seq(f64Pipe_io_in_bits_ctrl_seq),
    .io_in_bits_ctrl_dest(f64Pipe_io_in_bits_ctrl_dest),
    .io_in_bits_ctrl_dtype(f64Pipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(f64Pipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(f64Pipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(f64Pipe_io_out_ready),
    .io_out_valid(f64Pipe_io_out_valid),
    .io_out_bits_result(f64Pipe_io_out_bits_result),
    .io_out_bits_fflags(f64Pipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(f64Pipe_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dest(f64Pipe_io_out_bits_ctrl_dest),
    .io_out_bits_ctrl_dtype(f64Pipe_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(f64Pipe_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(f64Pipe_io_out_bits_ctrl_fma_sign)
  );
  Queue_6 issueQ ( // @[AecFpUnit.scala 68:22]
    .clock(issueQ_clock),
    .reset(issueQ_reset),
    .io_enq_ready(issueQ_io_enq_ready),
    .io_enq_valid(issueQ_io_enq_valid),
    .io_enq_bits(issueQ_io_enq_bits),
    .io_deq_ready(issueQ_io_deq_ready),
    .io_deq_valid(issueQ_io_deq_valid),
    .io_deq_bits(issueQ_io_deq_bits)
  );
  FPToFP f16Up_0 ( // @[AecFpUnit.scala 77:33]
    .io_in(f16Up_0_io_in),
    .io_result(f16Up_0_io_result)
  );
  FPToFP f16Up_1 ( // @[AecFpUnit.scala 77:33]
    .io_in(f16Up_1_io_in),
    .io_result(f16Up_1_io_result)
  );
  FPToFP f16Up_2 ( // @[AecFpUnit.scala 77:33]
    .io_in(f16Up_2_io_in),
    .io_result(f16Up_2_io_result)
  );
  FPToFP_3 bf16Up_0 ( // @[AecFpUnit.scala 78:34]
    .io_in(bf16Up_0_io_in),
    .io_result(bf16Up_0_io_result)
  );
  FPToFP_3 bf16Up_1 ( // @[AecFpUnit.scala 78:34]
    .io_in(bf16Up_1_io_in),
    .io_result(bf16Up_1_io_result)
  );
  FPToFP_3 bf16Up_2 ( // @[AecFpUnit.scala 78:34]
    .io_in(bf16Up_2_io_in),
    .io_result(bf16Up_2_io_result)
  );
  FPToFP_6 f32Up_0 ( // @[AecFpUnit.scala 79:33]
    .io_in(f32Up_0_io_in),
    .io_result(f32Up_0_io_result)
  );
  FPToFP_6 f32Up_1 ( // @[AecFpUnit.scala 79:33]
    .io_in(f32Up_1_io_in),
    .io_result(f32Up_1_io_result)
  );
  FPToFP_6 f32Up_2 ( // @[AecFpUnit.scala 79:33]
    .io_in(f32Up_2_io_in),
    .io_result(f32Up_2_io_result)
  );
  CompareRecFN cmp16 ( // @[AecFpUnit.scala 123:21]
    .io_a(cmp16_io_a),
    .io_b(cmp16_io_b),
    .io_lt(cmp16_io_lt),
    .io_eq(cmp16_io_eq),
    .io_gt(cmp16_io_gt)
  );
  CompareRecFN_1 cmp32 ( // @[AecFpUnit.scala 123:66]
    .io_a(cmp32_io_a),
    .io_b(cmp32_io_b),
    .io_lt(cmp32_io_lt),
    .io_eq(cmp32_io_eq),
    .io_gt(cmp32_io_gt)
  );
  CompareRecFN_2 cmp64 ( // @[AecFpUnit.scala 123:111]
    .io_a(cmp64_io_a),
    .io_b(cmp64_io_b),
    .io_lt(cmp64_io_lt),
    .io_eq(cmp64_io_eq),
    .io_gt(cmp64_io_gt)
  );
  FPToFP_9 f64DownF16 ( // @[AecFpUnit.scala 154:26]
    .io_in(f64DownF16_io_in),
    .io_result(f64DownF16_io_result)
  );
  FPToFP_10 f64DownBf16 ( // @[AecFpUnit.scala 155:27]
    .io_in(f64DownBf16_io_in),
    .io_result(f64DownBf16_io_result)
  );
  FPToFP_11 f64DownF32 ( // @[AecFpUnit.scala 156:26]
    .io_in(f64DownF32_io_in),
    .io_result(f64DownF32_io_result)
  );
  assign io_req_ready = _f64Pipe_io_in_valid_T & _io_req_ready_T_3; // @[AecFpUnit.scala 110:46]
  assign io_resp_valid = f64AtHead | oldAtHead; // @[AecFpUnit.scala 136:34]
  assign io_resp_bits_result = _io_resp_bits_result_T[63:0]; // @[AecFpUnit.scala 172:23]
  assign io_resp_bits_predicate_result = f64AtHead ? 1'h0 : isCmpP & cmpTrue; // @[AecFpUnit.scala 173:39]
  assign io_resp_bits_dest = f64AtHead ? f64Pipe_io_out_bits_ctrl_dest : held_dest; // @[AecFpUnit.scala 174:27]
  assign io_resp_bits_error = f64AtHead ? 1'h0 : _io_resp_bits_error_T_5; // @[AecFpUnit.scala 175:28]
  assign io_resp_bits_exception_flags = f64AtHead ? f64Flags : 5'h0; // @[AecFpUnit.scala 177:38]
  assign f64Pipe_clock = clock;
  assign f64Pipe_reset = reset;
  assign f64Pipe_io_in_valid = io_req_valid & ~busy & reqPipe & issueQ_io_enq_ready; // @[AecFpUnit.scala 103:58]
  assign f64Pipe_io_in_bits_op = 7'h5 == io_req_bits_op ? 3'h4 : _pipeOp_T_5; // @[Mux.scala 81:58]
  assign f64Pipe_io_in_bits_a = 4'h9 == io_req_bits_dtype ? io_req_bits_a : _f64Pipe_io_in_bits_a_T_5; // @[Mux.scala 81:58]
  assign f64Pipe_io_in_bits_b = 4'h9 == io_req_bits_dtype ? io_req_bits_b : _f64Pipe_io_in_bits_b_T_5; // @[Mux.scala 81:58]
  assign f64Pipe_io_in_bits_c = 4'h9 == io_req_bits_dtype ? io_req_bits_c : _f64Pipe_io_in_bits_c_T_5; // @[Mux.scala 81:58]
  assign f64Pipe_io_in_bits_ctrl_seq = issueSeq; // @[AecFpUnit.scala 97:14]
  assign f64Pipe_io_in_bits_ctrl_dest = io_req_bits_dest; // @[AecFpUnit.scala 98:15]
  assign f64Pipe_io_in_bits_ctrl_dtype = io_req_bits_dtype; // @[AecFpUnit.scala 99:16]
  assign f64Pipe_io_in_bits_ctrl_finite_fma = _f64Pipe_io_in_bits_ctrl_finite_fma_T_11 & _f64Pipe_io_in_bits_b_T_7[62:52
    ] != 11'h7ff & _f64Pipe_io_in_bits_c_T_7[62:52] != 11'h7ff; // @[AecFpUnit.scala 101:78]
  assign f64Pipe_io_in_bits_ctrl_fma_sign = _f64Pipe_io_in_bits_a_T_7[63] ^ _f64Pipe_io_in_bits_b_T_7[63]; // @[AecFpUnit.scala 102:42]
  assign f64Pipe_io_out_ready = io_resp_ready & f64AtHead; // @[AecFpUnit.scala 138:41]
  assign issueQ_clock = clock;
  assign issueQ_reset = reset;
  assign issueQ_io_enq_valid = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign issueQ_io_enq_bits = issueSeq; // @[AecFpUnit.scala 112:22]
  assign issueQ_io_deq_ready = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign f16Up_0_io_in = io_req_bits_a[15:0]; // @[AecFpUnit.scala 80:41]
  assign f16Up_1_io_in = io_req_bits_b[15:0]; // @[AecFpUnit.scala 80:63]
  assign f16Up_2_io_in = io_req_bits_c[15:0]; // @[AecFpUnit.scala 80:85]
  assign bf16Up_0_io_in = io_req_bits_a[15:0]; // @[AecFpUnit.scala 80:41]
  assign bf16Up_1_io_in = io_req_bits_b[15:0]; // @[AecFpUnit.scala 80:63]
  assign bf16Up_2_io_in = io_req_bits_c[15:0]; // @[AecFpUnit.scala 80:85]
  assign f32Up_0_io_in = io_req_bits_a[31:0]; // @[AecFpUnit.scala 83:30]
  assign f32Up_1_io_in = io_req_bits_b[31:0]; // @[AecFpUnit.scala 83:52]
  assign f32Up_2_io_in = io_req_bits_c[31:0]; // @[AecFpUnit.scala 83:74]
  assign cmp16_io_a = {_cmp16_io_a_T_20,cmp16_io_a_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp16_io_b = {_cmp16_io_b_T_20,cmp16_io_b_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_a = {_cmp32_io_a_T_20,cmp32_io_a_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_b = {_cmp32_io_b_T_20,cmp32_io_b_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_a = {_cmp64_io_a_T_6,cmp64_io_a_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_b = {_cmp64_io_b_T_6,cmp64_io_b_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign f64DownF16_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 159:25]
  assign f64DownBf16_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 159:25]
  assign f64DownF32_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 159:25]
  always @(posedge clock) begin
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 114:34]
      held_op <= io_req_bits_op; // @[AecFpUnit.scala 114:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 114:34]
      held_dtype <= io_req_bits_dtype; // @[AecFpUnit.scala 114:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 114:34]
      held_a <= io_req_bits_a; // @[AecFpUnit.scala 114:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 114:34]
      held_b <= io_req_bits_b; // @[AecFpUnit.scala 114:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 114:34]
      held_dest <= io_req_bits_dest; // @[AecFpUnit.scala 114:41]
    end
    if (reset) begin // @[AecFpUnit.scala 63:21]
      busy <= 1'h0; // @[AecFpUnit.scala 63:21]
    end else if (_issueQ_io_deq_ready_T & oldAtHead) begin // @[AecFpUnit.scala 139:36]
      busy <= 1'h0; // @[AecFpUnit.scala 139:43]
    end else begin
      busy <= _GEN_7;
    end
    if (reset) begin // @[AecFpUnit.scala 69:25]
      issueSeq <= 6'h0; // @[AecFpUnit.scala 69:25]
    end else if (_issueQ_io_enq_valid_T) begin // @[AecFpUnit.scala 113:22]
      issueSeq <= _issueSeq_T_1; // @[AecFpUnit.scala 113:33]
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
  held_op = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  held_dtype = _RAND_1[3:0];
  _RAND_2 = {2{`RANDOM}};
  held_a = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  held_b = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  held_dest = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  busy = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  issueSeq = _RAND_6[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
