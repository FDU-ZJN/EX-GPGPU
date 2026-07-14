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
  input  [3:0]   io_in_bits_ctrl_dtype,
  input          io_in_bits_ctrl_finite_fma,
  input          io_in_bits_ctrl_fma_sign,
  input          io_out_ready,
  output         io_out_valid,
  output [63:0]  io_out_bits_result,
  output [4:0]   io_out_bits_fflags,
  output [5:0]   io_out_bits_ctrl_seq,
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
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
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
  reg [3:0] toAdd_ctrl_r_dtype; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_finite_fma; // @[Reg.scala 19:16]
  reg  toAdd_ctrl_r_fma_sign; // @[Reg.scala 19:16]
  reg [5:0] toAdd_ctrl_r_1_seq; // @[Reg.scala 19:16]
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
  toAdd_ctrl_r_dtype = _RAND_24[3:0];
  _RAND_25 = {1{`RANDOM}};
  toAdd_ctrl_r_finite_fma = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  toAdd_ctrl_r_fma_sign = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  toAdd_ctrl_r_1_seq = _RAND_27[5:0];
  _RAND_28 = {1{`RANDOM}};
  toAdd_ctrl_r_1_dtype = _RAND_28[3:0];
  _RAND_29 = {1{`RANDOM}};
  toAdd_ctrl_r_1_finite_fma = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  toAdd_ctrl_r_1_fma_sign = _RAND_30[0:0];
  _RAND_31 = {2{`RANDOM}};
  toAdd_addAnother_r = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  toAdd_addAnother_r_1 = _RAND_32[63:0];
  _RAND_33 = {1{`RANDOM}};
  toAdd_op_r = _RAND_33[2:0];
  _RAND_34 = {1{`RANDOM}};
  toAdd_op_r_1 = _RAND_34[2:0];
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
  input  [3:0]   io_in_bits_ctrl_dtype,
  input          io_in_bits_ctrl_finite_fma,
  input          io_in_bits_ctrl_fma_sign,
  input          io_out_ready,
  output         io_out_valid,
  output [63:0]  io_out_bits_result,
  output [4:0]   io_out_bits_fflags,
  output [5:0]   io_out_bits_ctrl_seq,
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
  io_out_bits_ctrl_r_dtype = _RAND_18[3:0];
  _RAND_19 = {1{`RANDOM}};
  io_out_bits_ctrl_r_finite_fma = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  io_out_bits_ctrl_r_fma_sign = _RAND_20[0:0];
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
  input  [3:0] io_in_0_bits_ctrl_dtype,
  input        io_in_0_bits_ctrl_finite_fma,
  input        io_in_0_bits_ctrl_fma_sign,
  input  [2:0] io_in_0_bits_op,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [5:0] io_in_1_bits_ctrl_seq,
  input  [3:0] io_in_1_bits_ctrl_dtype,
  input        io_in_1_bits_ctrl_finite_fma,
  input        io_in_1_bits_ctrl_fma_sign,
  input  [2:0] io_in_1_bits_op,
  input        io_out_ready,
  output       io_out_valid,
  output [5:0] io_out_bits_ctrl_seq,
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
  input  [3:0] io_enq_bits_ctrl_dtype,
  input        io_enq_bits_ctrl_finite_fma,
  input        io_enq_bits_ctrl_fma_sign,
  input  [2:0] io_enq_bits_op,
  input        io_deq_ready,
  output       io_deq_valid,
  output [5:0] io_deq_bits_ctrl_seq,
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
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ram_ctrl_seq [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_en; // @[Decoupled.scala 273:95]
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
  assign io_deq_bits_ctrl_dtype = ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_finite_fma = ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_fma_sign = ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_op = ram_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_ctrl_seq_MPORT_en & ram_ctrl_seq_MPORT_mask) begin
      ram_ctrl_seq[ram_ctrl_seq_MPORT_addr] <= ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
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
    ram_ctrl_dtype[initvar] = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_finite_fma[initvar] = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_fma_sign[initvar] = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_op[initvar] = _RAND_4[2:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
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
  input  [2:0]  io_enq_bits_op,
  input  [63:0] io_enq_bits_a,
  input  [63:0] io_enq_bits_b,
  input  [2:0]  io_enq_bits_rm,
  input  [5:0]  io_enq_bits_ctrl_seq,
  input  [3:0]  io_enq_bits_ctrl_dtype,
  input         io_enq_bits_ctrl_finite_fma,
  input         io_enq_bits_ctrl_fma_sign,
  input         io_deq_ready,
  output        io_deq_valid,
  output [2:0]  io_deq_bits_op,
  output [63:0] io_deq_bits_a,
  output [63:0] io_deq_bits_b,
  output [2:0]  io_deq_bits_rm,
  output [5:0]  io_deq_bits_ctrl_seq,
  output [3:0]  io_deq_bits_ctrl_dtype,
  output        io_deq_bits_ctrl_finite_fma,
  output        io_deq_bits_ctrl_fma_sign
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] ram_op [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_op_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_op_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [2:0] ram_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_op_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_op_MPORT_en; // @[Decoupled.scala 273:95]
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
  reg [5:0] ram_ctrl_seq [0:0]; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_ctrl_seq_MPORT_en; // @[Decoupled.scala 273:95]
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
  assign ram_op_io_deq_bits_MPORT_en = 1'h1;
  assign ram_op_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_op_io_deq_bits_MPORT_data = ram_op[ram_op_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_op_MPORT_data = io_enq_bits_op;
  assign ram_op_MPORT_addr = 1'h0;
  assign ram_op_MPORT_mask = 1'h1;
  assign ram_op_MPORT_en = io_enq_ready & io_enq_valid;
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
  assign ram_rm_MPORT_data = io_enq_bits_rm;
  assign ram_rm_MPORT_addr = 1'h0;
  assign ram_rm_MPORT_mask = 1'h1;
  assign ram_rm_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_ctrl_seq_io_deq_bits_MPORT_en = 1'h1;
  assign ram_ctrl_seq_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_io_deq_bits_MPORT_data = ram_ctrl_seq[ram_ctrl_seq_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_ctrl_seq_MPORT_data = io_enq_bits_ctrl_seq;
  assign ram_ctrl_seq_MPORT_addr = 1'h0;
  assign ram_ctrl_seq_MPORT_mask = 1'h1;
  assign ram_ctrl_seq_MPORT_en = io_enq_ready & io_enq_valid;
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
  assign io_deq_bits_op = ram_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_a = ram_a_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_b = ram_b_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_rm = ram_rm_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_seq = ram_ctrl_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_dtype = ram_ctrl_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_finite_fma = ram_ctrl_finite_fma_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_ctrl_fma_sign = ram_ctrl_fma_sign_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_op_MPORT_en & ram_op_MPORT_mask) begin
      ram_op[ram_op_MPORT_addr] <= ram_op_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_a_MPORT_en & ram_a_MPORT_mask) begin
      ram_a[ram_a_MPORT_addr] <= ram_a_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_b_MPORT_en & ram_b_MPORT_mask) begin
      ram_b[ram_b_MPORT_addr] <= ram_b_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_rm_MPORT_en & ram_rm_MPORT_mask) begin
      ram_rm[ram_rm_MPORT_addr] <= ram_rm_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_ctrl_seq_MPORT_en & ram_ctrl_seq_MPORT_mask) begin
      ram_ctrl_seq[ram_ctrl_seq_MPORT_addr] <= ram_ctrl_seq_MPORT_data; // @[Decoupled.scala 273:95]
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
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_op[initvar] = _RAND_0[2:0];
  _RAND_1 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_a[initvar] = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_b[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_rm[initvar] = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_seq[initvar] = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_dtype[initvar] = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_finite_fma[initvar] = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_fma_sign[initvar] = _RAND_7[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  maybe_full = _RAND_8[0:0];
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
  input  [2:0]   io_enq_bits_rm,
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
  assign ram_rm_MPORT_data = io_enq_bits_rm;
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
module Queue_6(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_result,
  input  [4:0]  io_enq_bits_fflags,
  input  [5:0]  io_enq_bits_ctrl_seq,
  input  [3:0]  io_enq_bits_ctrl_dtype,
  input         io_enq_bits_ctrl_finite_fma,
  input         io_enq_bits_ctrl_fma_sign,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_result,
  output [4:0]  io_deq_bits_fflags,
  output [5:0]  io_deq_bits_ctrl_seq,
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
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
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
    ram_ctrl_dtype[initvar] = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_finite_fma[initvar] = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_ctrl_fma_sign[initvar] = _RAND_5[0:0];
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
module Arbiter_1(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits_result,
  input  [4:0]  io_in_0_bits_fflags,
  input  [5:0]  io_in_0_bits_ctrl_seq,
  input  [3:0]  io_in_0_bits_ctrl_dtype,
  input         io_in_0_bits_ctrl_finite_fma,
  input         io_in_0_bits_ctrl_fma_sign,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits_result,
  input  [4:0]  io_in_1_bits_fflags,
  input  [5:0]  io_in_1_bits_ctrl_seq,
  input  [3:0]  io_in_1_bits_ctrl_dtype,
  input         io_in_1_bits_ctrl_finite_fma,
  input         io_in_1_bits_ctrl_fma_sign,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_result,
  output [4:0]  io_out_bits_fflags,
  output [5:0]  io_out_bits_ctrl_seq,
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
  input  [3:0]  io_in_bits_ctrl_dtype,
  input         io_in_bits_ctrl_finite_fma,
  input         io_in_bits_ctrl_fma_sign,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_result,
  output [4:0]  io_out_bits_fflags,
  output [5:0]  io_out_bits_ctrl_seq,
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
  wire [3:0] mulPipe_io_in_bits_ctrl_dtype; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_bits_ctrl_finite_fma; // @[FMA.scala 118:23]
  wire  mulPipe_io_in_bits_ctrl_fma_sign; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_ready; // @[FMA.scala 118:23]
  wire  mulPipe_io_out_valid; // @[FMA.scala 118:23]
  wire [63:0] mulPipe_io_out_bits_result; // @[FMA.scala 118:23]
  wire [4:0] mulPipe_io_out_bits_fflags; // @[FMA.scala 118:23]
  wire [5:0] mulPipe_io_out_bits_ctrl_seq; // @[FMA.scala 118:23]
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
  wire [3:0] addPipe_io_in_bits_ctrl_dtype; // @[FMA.scala 119:23]
  wire  addPipe_io_in_bits_ctrl_finite_fma; // @[FMA.scala 119:23]
  wire  addPipe_io_in_bits_ctrl_fma_sign; // @[FMA.scala 119:23]
  wire  addPipe_io_out_ready; // @[FMA.scala 119:23]
  wire  addPipe_io_out_valid; // @[FMA.scala 119:23]
  wire [63:0] addPipe_io_out_bits_result; // @[FMA.scala 119:23]
  wire [4:0] addPipe_io_out_bits_fflags; // @[FMA.scala 119:23]
  wire [5:0] addPipe_io_out_bits_ctrl_seq; // @[FMA.scala 119:23]
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
  wire [3:0] toAddArbiter_io_in_0_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_0_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_0_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_in_0_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_ready; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_valid; // @[FMA.scala 133:28]
  wire [5:0] toAddArbiter_io_in_1_bits_ctrl_seq; // @[FMA.scala 133:28]
  wire [3:0] toAddArbiter_io_in_1_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_in_1_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_in_1_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_ready; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_valid; // @[FMA.scala 133:28]
  wire [5:0] toAddArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 133:28]
  wire [3:0] toAddArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 133:28]
  wire  toAddArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 133:28]
  wire [2:0] toAddArbiter_io_out_bits_op; // @[FMA.scala 133:28]
  wire  toAddArbiterFIFO_0_clock; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_reset; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_0_io_enq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_0_io_enq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_0_io_deq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_0_io_deq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_0_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_0_io_deq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_clock; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_reset; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_1_io_enq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_1_io_enq_bits_op; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_ready; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_valid; // @[FMA.scala 134:44]
  wire [5:0] toAddArbiterFIFO_1_io_deq_bits_ctrl_seq; // @[FMA.scala 134:44]
  wire [3:0] toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 134:44]
  wire  toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 134:44]
  wire [2:0] toAddArbiterFIFO_1_io_deq_bits_op; // @[FMA.scala 134:44]
  wire  inToAddFIFO_clock; // @[FMA.scala 144:27]
  wire  inToAddFIFO_reset; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_enq_ready; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_enq_valid; // @[FMA.scala 144:27]
  wire [2:0] inToAddFIFO_io_enq_bits_op; // @[FMA.scala 144:27]
  wire [63:0] inToAddFIFO_io_enq_bits_a; // @[FMA.scala 144:27]
  wire [63:0] inToAddFIFO_io_enq_bits_b; // @[FMA.scala 144:27]
  wire [2:0] inToAddFIFO_io_enq_bits_rm; // @[FMA.scala 144:27]
  wire [5:0] inToAddFIFO_io_enq_bits_ctrl_seq; // @[FMA.scala 144:27]
  wire [3:0] inToAddFIFO_io_enq_bits_ctrl_dtype; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_deq_ready; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_deq_valid; // @[FMA.scala 144:27]
  wire [2:0] inToAddFIFO_io_deq_bits_op; // @[FMA.scala 144:27]
  wire [63:0] inToAddFIFO_io_deq_bits_a; // @[FMA.scala 144:27]
  wire [63:0] inToAddFIFO_io_deq_bits_b; // @[FMA.scala 144:27]
  wire [2:0] inToAddFIFO_io_deq_bits_rm; // @[FMA.scala 144:27]
  wire [5:0] inToAddFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 144:27]
  wire [3:0] inToAddFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 144:27]
  wire  inToAddFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 144:27]
  wire  mulToAddFIFO_clock; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_reset; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_ready; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_valid; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 149:28]
  wire [10:0] mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 149:28]
  wire [104:0] mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 149:28]
  wire [63:0] mulToAddFIFO_io_enq_bits_addAnother; // @[FMA.scala 149:28]
  wire [2:0] mulToAddFIFO_io_enq_bits_rm; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_ready; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_valid; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 149:28]
  wire [10:0] mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 149:28]
  wire [104:0] mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 149:28]
  wire  mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 149:28]
  wire [63:0] mulToAddFIFO_io_deq_bits_addAnother; // @[FMA.scala 149:28]
  wire [2:0] mulToAddFIFO_io_deq_bits_rm; // @[FMA.scala 149:28]
  wire  addInputStage_clock; // @[FMA.scala 158:29]
  wire  addInputStage_reset; // @[FMA.scala 158:29]
  wire  addInputStage_io_enq_ready; // @[FMA.scala 158:29]
  wire  addInputStage_io_enq_valid; // @[FMA.scala 158:29]
  wire [2:0] addInputStage_io_enq_bits_op; // @[FMA.scala 158:29]
  wire [63:0] addInputStage_io_enq_bits_a; // @[FMA.scala 158:29]
  wire [63:0] addInputStage_io_enq_bits_b; // @[FMA.scala 158:29]
  wire [2:0] addInputStage_io_enq_bits_rm; // @[FMA.scala 158:29]
  wire [5:0] addInputStage_io_enq_bits_ctrl_seq; // @[FMA.scala 158:29]
  wire [3:0] addInputStage_io_enq_bits_ctrl_dtype; // @[FMA.scala 158:29]
  wire  addInputStage_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 158:29]
  wire  addInputStage_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 158:29]
  wire  addInputStage_io_deq_ready; // @[FMA.scala 158:29]
  wire  addInputStage_io_deq_valid; // @[FMA.scala 158:29]
  wire [2:0] addInputStage_io_deq_bits_op; // @[FMA.scala 158:29]
  wire [63:0] addInputStage_io_deq_bits_a; // @[FMA.scala 158:29]
  wire [63:0] addInputStage_io_deq_bits_b; // @[FMA.scala 158:29]
  wire [2:0] addInputStage_io_deq_bits_rm; // @[FMA.scala 158:29]
  wire [5:0] addInputStage_io_deq_bits_ctrl_seq; // @[FMA.scala 158:29]
  wire [3:0] addInputStage_io_deq_bits_ctrl_dtype; // @[FMA.scala 158:29]
  wire  addInputStage_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 158:29]
  wire  addInputStage_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 158:29]
  wire  addMulStage_clock; // @[FMA.scala 159:27]
  wire  addMulStage_reset; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_ready; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_valid; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 159:27]
  wire [10:0] addMulStage_io_enq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 159:27]
  wire [104:0] addMulStage_io_enq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 159:27]
  wire  addMulStage_io_enq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 159:27]
  wire [63:0] addMulStage_io_enq_bits_addAnother; // @[FMA.scala 159:27]
  wire [2:0] addMulStage_io_enq_bits_rm; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_ready; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_valid; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 159:27]
  wire [10:0] addMulStage_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 159:27]
  wire [104:0] addMulStage_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 159:27]
  wire  addMulStage_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 159:27]
  wire [63:0] addMulStage_io_deq_bits_addAnother; // @[FMA.scala 159:27]
  wire [2:0] addMulStage_io_deq_bits_rm; // @[FMA.scala 159:27]
  wire  mulFIFO_clock; // @[FMA.scala 180:23]
  wire  mulFIFO_reset; // @[FMA.scala 180:23]
  wire  mulFIFO_io_enq_ready; // @[FMA.scala 180:23]
  wire  mulFIFO_io_enq_valid; // @[FMA.scala 180:23]
  wire [63:0] mulFIFO_io_enq_bits_result; // @[FMA.scala 180:23]
  wire [4:0] mulFIFO_io_enq_bits_fflags; // @[FMA.scala 180:23]
  wire [5:0] mulFIFO_io_enq_bits_ctrl_seq; // @[FMA.scala 180:23]
  wire [3:0] mulFIFO_io_enq_bits_ctrl_dtype; // @[FMA.scala 180:23]
  wire  mulFIFO_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 180:23]
  wire  mulFIFO_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 180:23]
  wire  mulFIFO_io_deq_ready; // @[FMA.scala 180:23]
  wire  mulFIFO_io_deq_valid; // @[FMA.scala 180:23]
  wire [63:0] mulFIFO_io_deq_bits_result; // @[FMA.scala 180:23]
  wire [4:0] mulFIFO_io_deq_bits_fflags; // @[FMA.scala 180:23]
  wire [5:0] mulFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 180:23]
  wire [3:0] mulFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 180:23]
  wire  mulFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 180:23]
  wire  mulFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 180:23]
  wire  addFIFO_clock; // @[FMA.scala 181:23]
  wire  addFIFO_reset; // @[FMA.scala 181:23]
  wire  addFIFO_io_enq_ready; // @[FMA.scala 181:23]
  wire  addFIFO_io_enq_valid; // @[FMA.scala 181:23]
  wire [63:0] addFIFO_io_enq_bits_result; // @[FMA.scala 181:23]
  wire [4:0] addFIFO_io_enq_bits_fflags; // @[FMA.scala 181:23]
  wire [5:0] addFIFO_io_enq_bits_ctrl_seq; // @[FMA.scala 181:23]
  wire [3:0] addFIFO_io_enq_bits_ctrl_dtype; // @[FMA.scala 181:23]
  wire  addFIFO_io_enq_bits_ctrl_finite_fma; // @[FMA.scala 181:23]
  wire  addFIFO_io_enq_bits_ctrl_fma_sign; // @[FMA.scala 181:23]
  wire  addFIFO_io_deq_ready; // @[FMA.scala 181:23]
  wire  addFIFO_io_deq_valid; // @[FMA.scala 181:23]
  wire [63:0] addFIFO_io_deq_bits_result; // @[FMA.scala 181:23]
  wire [4:0] addFIFO_io_deq_bits_fflags; // @[FMA.scala 181:23]
  wire [5:0] addFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 181:23]
  wire [3:0] addFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 181:23]
  wire  addFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 181:23]
  wire  addFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 181:23]
  wire  toOutArbiter_io_in_0_ready; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_0_valid; // @[FMA.scala 190:28]
  wire [63:0] toOutArbiter_io_in_0_bits_result; // @[FMA.scala 190:28]
  wire [4:0] toOutArbiter_io_in_0_bits_fflags; // @[FMA.scala 190:28]
  wire [5:0] toOutArbiter_io_in_0_bits_ctrl_seq; // @[FMA.scala 190:28]
  wire [3:0] toOutArbiter_io_in_0_bits_ctrl_dtype; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_0_bits_ctrl_finite_fma; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_0_bits_ctrl_fma_sign; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_1_ready; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_1_valid; // @[FMA.scala 190:28]
  wire [63:0] toOutArbiter_io_in_1_bits_result; // @[FMA.scala 190:28]
  wire [4:0] toOutArbiter_io_in_1_bits_fflags; // @[FMA.scala 190:28]
  wire [5:0] toOutArbiter_io_in_1_bits_ctrl_seq; // @[FMA.scala 190:28]
  wire [3:0] toOutArbiter_io_in_1_bits_ctrl_dtype; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_1_bits_ctrl_finite_fma; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_in_1_bits_ctrl_fma_sign; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_out_ready; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_out_valid; // @[FMA.scala 190:28]
  wire [63:0] toOutArbiter_io_out_bits_result; // @[FMA.scala 190:28]
  wire [4:0] toOutArbiter_io_out_bits_fflags; // @[FMA.scala 190:28]
  wire [5:0] toOutArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 190:28]
  wire [3:0] toOutArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 190:28]
  wire  toOutArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 190:28]
  wire  _mulPipe_io_in_valid_T_2 = io_in_bits_op == 3'h2; // @[FPUOps.scala 81:10]
  wire  _toAddArbiterFIFO_1_io_enq_valid_T_1 = io_in_bits_op[2:1] == 2'h0; // @[FPUOps.scala 63:16]
  wire  _mulFIFO_io_enq_valid_T = mulPipe_toAdd_op == 3'h2; // @[FPUOps.scala 81:10]
  wire  _mulPipe_io_out_ready_T_4 = mulFIFO_io_enq_ready & _mulFIFO_io_enq_valid_T; // @[FMA.scala 187:27]
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
    .io_in_bits_ctrl_dtype(mulPipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(mulPipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(mulPipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(mulPipe_io_out_ready),
    .io_out_valid(mulPipe_io_out_valid),
    .io_out_bits_result(mulPipe_io_out_bits_result),
    .io_out_bits_fflags(mulPipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(mulPipe_io_out_bits_ctrl_seq),
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
    .io_in_bits_ctrl_dtype(addPipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(addPipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(addPipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(addPipe_io_out_ready),
    .io_out_valid(addPipe_io_out_valid),
    .io_out_bits_result(addPipe_io_out_bits_result),
    .io_out_bits_fflags(addPipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(addPipe_io_out_bits_ctrl_seq),
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
    .io_in_0_bits_ctrl_dtype(toAddArbiter_io_in_0_bits_ctrl_dtype),
    .io_in_0_bits_ctrl_finite_fma(toAddArbiter_io_in_0_bits_ctrl_finite_fma),
    .io_in_0_bits_ctrl_fma_sign(toAddArbiter_io_in_0_bits_ctrl_fma_sign),
    .io_in_0_bits_op(toAddArbiter_io_in_0_bits_op),
    .io_in_1_ready(toAddArbiter_io_in_1_ready),
    .io_in_1_valid(toAddArbiter_io_in_1_valid),
    .io_in_1_bits_ctrl_seq(toAddArbiter_io_in_1_bits_ctrl_seq),
    .io_in_1_bits_ctrl_dtype(toAddArbiter_io_in_1_bits_ctrl_dtype),
    .io_in_1_bits_ctrl_finite_fma(toAddArbiter_io_in_1_bits_ctrl_finite_fma),
    .io_in_1_bits_ctrl_fma_sign(toAddArbiter_io_in_1_bits_ctrl_fma_sign),
    .io_in_1_bits_op(toAddArbiter_io_in_1_bits_op),
    .io_out_ready(toAddArbiter_io_out_ready),
    .io_out_valid(toAddArbiter_io_out_valid),
    .io_out_bits_ctrl_seq(toAddArbiter_io_out_bits_ctrl_seq),
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
    .io_enq_bits_ctrl_dtype(toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign),
    .io_enq_bits_op(toAddArbiterFIFO_0_io_enq_bits_op),
    .io_deq_ready(toAddArbiterFIFO_0_io_deq_ready),
    .io_deq_valid(toAddArbiterFIFO_0_io_deq_valid),
    .io_deq_bits_ctrl_seq(toAddArbiterFIFO_0_io_deq_bits_ctrl_seq),
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
    .io_enq_bits_ctrl_dtype(toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign),
    .io_enq_bits_op(toAddArbiterFIFO_1_io_enq_bits_op),
    .io_deq_ready(toAddArbiterFIFO_1_io_deq_ready),
    .io_deq_valid(toAddArbiterFIFO_1_io_deq_valid),
    .io_deq_bits_ctrl_seq(toAddArbiterFIFO_1_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dtype(toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign),
    .io_deq_bits_op(toAddArbiterFIFO_1_io_deq_bits_op)
  );
  Queue_2 inToAddFIFO ( // @[FMA.scala 144:27]
    .clock(inToAddFIFO_clock),
    .reset(inToAddFIFO_reset),
    .io_enq_ready(inToAddFIFO_io_enq_ready),
    .io_enq_valid(inToAddFIFO_io_enq_valid),
    .io_enq_bits_op(inToAddFIFO_io_enq_bits_op),
    .io_enq_bits_a(inToAddFIFO_io_enq_bits_a),
    .io_enq_bits_b(inToAddFIFO_io_enq_bits_b),
    .io_enq_bits_rm(inToAddFIFO_io_enq_bits_rm),
    .io_enq_bits_ctrl_seq(inToAddFIFO_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dtype(inToAddFIFO_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(inToAddFIFO_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(inToAddFIFO_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(inToAddFIFO_io_deq_ready),
    .io_deq_valid(inToAddFIFO_io_deq_valid),
    .io_deq_bits_op(inToAddFIFO_io_deq_bits_op),
    .io_deq_bits_a(inToAddFIFO_io_deq_bits_a),
    .io_deq_bits_b(inToAddFIFO_io_deq_bits_b),
    .io_deq_bits_rm(inToAddFIFO_io_deq_bits_rm),
    .io_deq_bits_ctrl_seq(inToAddFIFO_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dtype(inToAddFIFO_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(inToAddFIFO_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(inToAddFIFO_io_deq_bits_ctrl_fma_sign)
  );
  Queue_3 mulToAddFIFO ( // @[FMA.scala 149:28]
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
    .io_enq_bits_rm(mulToAddFIFO_io_enq_bits_rm),
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
  Queue_2 addInputStage ( // @[FMA.scala 158:29]
    .clock(addInputStage_clock),
    .reset(addInputStage_reset),
    .io_enq_ready(addInputStage_io_enq_ready),
    .io_enq_valid(addInputStage_io_enq_valid),
    .io_enq_bits_op(addInputStage_io_enq_bits_op),
    .io_enq_bits_a(addInputStage_io_enq_bits_a),
    .io_enq_bits_b(addInputStage_io_enq_bits_b),
    .io_enq_bits_rm(addInputStage_io_enq_bits_rm),
    .io_enq_bits_ctrl_seq(addInputStage_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dtype(addInputStage_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(addInputStage_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(addInputStage_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(addInputStage_io_deq_ready),
    .io_deq_valid(addInputStage_io_deq_valid),
    .io_deq_bits_op(addInputStage_io_deq_bits_op),
    .io_deq_bits_a(addInputStage_io_deq_bits_a),
    .io_deq_bits_b(addInputStage_io_deq_bits_b),
    .io_deq_bits_rm(addInputStage_io_deq_bits_rm),
    .io_deq_bits_ctrl_seq(addInputStage_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dtype(addInputStage_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(addInputStage_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(addInputStage_io_deq_bits_ctrl_fma_sign)
  );
  Queue_3 addMulStage ( // @[FMA.scala 159:27]
    .clock(addMulStage_clock),
    .reset(addMulStage_reset),
    .io_enq_ready(addMulStage_io_enq_ready),
    .io_enq_valid(addMulStage_io_enq_valid),
    .io_enq_bits_mulOutput_fp_prod_sign(addMulStage_io_enq_bits_mulOutput_fp_prod_sign),
    .io_enq_bits_mulOutput_fp_prod_exp(addMulStage_io_enq_bits_mulOutput_fp_prod_exp),
    .io_enq_bits_mulOutput_fp_prod_sig(addMulStage_io_enq_bits_mulOutput_fp_prod_sig),
    .io_enq_bits_mulOutput_inter_flags_isNaN(addMulStage_io_enq_bits_mulOutput_inter_flags_isNaN),
    .io_enq_bits_mulOutput_inter_flags_isInf(addMulStage_io_enq_bits_mulOutput_inter_flags_isInf),
    .io_enq_bits_mulOutput_inter_flags_isInv(addMulStage_io_enq_bits_mulOutput_inter_flags_isInv),
    .io_enq_bits_mulOutput_inter_flags_overflow(addMulStage_io_enq_bits_mulOutput_inter_flags_overflow),
    .io_enq_bits_mulOutput_inter_flags_prod_sign(addMulStage_io_enq_bits_mulOutput_inter_flags_prod_sign),
    .io_enq_bits_addAnother(addMulStage_io_enq_bits_addAnother),
    .io_enq_bits_rm(addMulStage_io_enq_bits_rm),
    .io_deq_ready(addMulStage_io_deq_ready),
    .io_deq_valid(addMulStage_io_deq_valid),
    .io_deq_bits_mulOutput_fp_prod_sign(addMulStage_io_deq_bits_mulOutput_fp_prod_sign),
    .io_deq_bits_mulOutput_fp_prod_exp(addMulStage_io_deq_bits_mulOutput_fp_prod_exp),
    .io_deq_bits_mulOutput_fp_prod_sig(addMulStage_io_deq_bits_mulOutput_fp_prod_sig),
    .io_deq_bits_mulOutput_inter_flags_isNaN(addMulStage_io_deq_bits_mulOutput_inter_flags_isNaN),
    .io_deq_bits_mulOutput_inter_flags_isInf(addMulStage_io_deq_bits_mulOutput_inter_flags_isInf),
    .io_deq_bits_mulOutput_inter_flags_isInv(addMulStage_io_deq_bits_mulOutput_inter_flags_isInv),
    .io_deq_bits_mulOutput_inter_flags_overflow(addMulStage_io_deq_bits_mulOutput_inter_flags_overflow),
    .io_deq_bits_mulOutput_inter_flags_prod_sign(addMulStage_io_deq_bits_mulOutput_inter_flags_prod_sign),
    .io_deq_bits_addAnother(addMulStage_io_deq_bits_addAnother),
    .io_deq_bits_rm(addMulStage_io_deq_bits_rm)
  );
  Queue_6 mulFIFO ( // @[FMA.scala 180:23]
    .clock(mulFIFO_clock),
    .reset(mulFIFO_reset),
    .io_enq_ready(mulFIFO_io_enq_ready),
    .io_enq_valid(mulFIFO_io_enq_valid),
    .io_enq_bits_result(mulFIFO_io_enq_bits_result),
    .io_enq_bits_fflags(mulFIFO_io_enq_bits_fflags),
    .io_enq_bits_ctrl_seq(mulFIFO_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dtype(mulFIFO_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(mulFIFO_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(mulFIFO_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(mulFIFO_io_deq_ready),
    .io_deq_valid(mulFIFO_io_deq_valid),
    .io_deq_bits_result(mulFIFO_io_deq_bits_result),
    .io_deq_bits_fflags(mulFIFO_io_deq_bits_fflags),
    .io_deq_bits_ctrl_seq(mulFIFO_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dtype(mulFIFO_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(mulFIFO_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(mulFIFO_io_deq_bits_ctrl_fma_sign)
  );
  Queue_6 addFIFO ( // @[FMA.scala 181:23]
    .clock(addFIFO_clock),
    .reset(addFIFO_reset),
    .io_enq_ready(addFIFO_io_enq_ready),
    .io_enq_valid(addFIFO_io_enq_valid),
    .io_enq_bits_result(addFIFO_io_enq_bits_result),
    .io_enq_bits_fflags(addFIFO_io_enq_bits_fflags),
    .io_enq_bits_ctrl_seq(addFIFO_io_enq_bits_ctrl_seq),
    .io_enq_bits_ctrl_dtype(addFIFO_io_enq_bits_ctrl_dtype),
    .io_enq_bits_ctrl_finite_fma(addFIFO_io_enq_bits_ctrl_finite_fma),
    .io_enq_bits_ctrl_fma_sign(addFIFO_io_enq_bits_ctrl_fma_sign),
    .io_deq_ready(addFIFO_io_deq_ready),
    .io_deq_valid(addFIFO_io_deq_valid),
    .io_deq_bits_result(addFIFO_io_deq_bits_result),
    .io_deq_bits_fflags(addFIFO_io_deq_bits_fflags),
    .io_deq_bits_ctrl_seq(addFIFO_io_deq_bits_ctrl_seq),
    .io_deq_bits_ctrl_dtype(addFIFO_io_deq_bits_ctrl_dtype),
    .io_deq_bits_ctrl_finite_fma(addFIFO_io_deq_bits_ctrl_finite_fma),
    .io_deq_bits_ctrl_fma_sign(addFIFO_io_deq_bits_ctrl_fma_sign)
  );
  Arbiter_1 toOutArbiter ( // @[FMA.scala 190:28]
    .io_in_0_ready(toOutArbiter_io_in_0_ready),
    .io_in_0_valid(toOutArbiter_io_in_0_valid),
    .io_in_0_bits_result(toOutArbiter_io_in_0_bits_result),
    .io_in_0_bits_fflags(toOutArbiter_io_in_0_bits_fflags),
    .io_in_0_bits_ctrl_seq(toOutArbiter_io_in_0_bits_ctrl_seq),
    .io_in_0_bits_ctrl_dtype(toOutArbiter_io_in_0_bits_ctrl_dtype),
    .io_in_0_bits_ctrl_finite_fma(toOutArbiter_io_in_0_bits_ctrl_finite_fma),
    .io_in_0_bits_ctrl_fma_sign(toOutArbiter_io_in_0_bits_ctrl_fma_sign),
    .io_in_1_ready(toOutArbiter_io_in_1_ready),
    .io_in_1_valid(toOutArbiter_io_in_1_valid),
    .io_in_1_bits_result(toOutArbiter_io_in_1_bits_result),
    .io_in_1_bits_fflags(toOutArbiter_io_in_1_bits_fflags),
    .io_in_1_bits_ctrl_seq(toOutArbiter_io_in_1_bits_ctrl_seq),
    .io_in_1_bits_ctrl_dtype(toOutArbiter_io_in_1_bits_ctrl_dtype),
    .io_in_1_bits_ctrl_finite_fma(toOutArbiter_io_in_1_bits_ctrl_finite_fma),
    .io_in_1_bits_ctrl_fma_sign(toOutArbiter_io_in_1_bits_ctrl_fma_sign),
    .io_out_ready(toOutArbiter_io_out_ready),
    .io_out_valid(toOutArbiter_io_out_valid),
    .io_out_bits_result(toOutArbiter_io_out_bits_result),
    .io_out_bits_fflags(toOutArbiter_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(toOutArbiter_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dtype(toOutArbiter_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(toOutArbiter_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(toOutArbiter_io_out_bits_ctrl_fma_sign)
  );
  assign io_in_ready = _toAddArbiterFIFO_1_io_enq_valid_T_1 ? toAddArbiterFIFO_1_io_enq_ready : mulPipe_io_in_ready; // @[FMA.scala 179:21]
  assign io_out_valid = toOutArbiter_io_out_valid; // @[FMA.scala 193:10]
  assign io_out_bits_result = toOutArbiter_io_out_bits_result; // @[FMA.scala 193:10]
  assign io_out_bits_fflags = toOutArbiter_io_out_bits_fflags; // @[FMA.scala 193:10]
  assign io_out_bits_ctrl_seq = toOutArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 193:10]
  assign io_out_bits_ctrl_dtype = toOutArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 193:10]
  assign io_out_bits_ctrl_finite_fma = toOutArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 193:10]
  assign io_out_bits_ctrl_fma_sign = toOutArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 193:10]
  assign mulPipe_clock = clock;
  assign mulPipe_reset = reset;
  assign mulPipe_io_in_valid = io_in_valid & (io_in_bits_op[2] | _mulPipe_io_in_valid_T_2); // @[FMA.scala 122:38]
  assign mulPipe_io_in_bits_op = io_in_bits_op; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_a = io_in_bits_a; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_b = io_in_bits_b; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_c = io_in_bits_c; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_seq = io_in_bits_ctrl_seq; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_dtype = io_in_bits_ctrl_dtype; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_finite_fma = io_in_bits_ctrl_finite_fma; // @[FMA.scala 121:22]
  assign mulPipe_io_in_bits_ctrl_fma_sign = io_in_bits_ctrl_fma_sign; // @[FMA.scala 121:22]
  assign mulPipe_io_out_ready = toAddArbiterFIFO_0_io_enq_ready & mulPipe_toAdd_op[2] | _mulPipe_io_out_ready_T_4; // @[FMA.scala 186:96]
  assign addPipe_clock = clock;
  assign addPipe_reset = reset;
  assign addPipe_io_in_valid = addInputStage_io_deq_valid & addMulStage_io_deq_valid; // @[FMA.scala 171:53]
  assign addPipe_io_in_bits_op = addInputStage_io_deq_bits_op; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_a = addInputStage_io_deq_bits_a; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_b = addInputStage_io_deq_bits_b; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_rm = addInputStage_io_deq_bits_rm; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_ctrl_seq = addInputStage_io_deq_bits_ctrl_seq; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_ctrl_dtype = addInputStage_io_deq_bits_ctrl_dtype; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_ctrl_finite_fma = addInputStage_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 169:22]
  assign addPipe_io_in_bits_ctrl_fma_sign = addInputStage_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 169:22]
  assign addPipe_io_out_ready = addFIFO_io_enq_ready; // @[FMA.scala 184:18]
  assign addPipe_fromMul_mulOutput_fp_prod_sign = addMulStage_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_fp_prod_exp = addMulStage_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_fp_prod_sig = addMulStage_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isNaN = addMulStage_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isInf = addMulStage_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_inter_flags_isInv = addMulStage_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_inter_flags_overflow = addMulStage_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 170:19]
  assign addPipe_fromMul_mulOutput_inter_flags_prod_sign = addMulStage_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 170:19]
  assign addPipe_fromMul_addAnother = addMulStage_io_deq_bits_addAnother; // @[FMA.scala 170:19]
  assign addPipe_fromMul_rm = addMulStage_io_deq_bits_rm; // @[FMA.scala 170:19]
  assign toAddArbiter_io_in_0_valid = toAddArbiterFIFO_0_io_deq_valid; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_seq = toAddArbiterFIFO_0_io_deq_bits_ctrl_seq; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_dtype = toAddArbiterFIFO_0_io_deq_bits_ctrl_dtype; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_finite_fma = toAddArbiterFIFO_0_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_ctrl_fma_sign = toAddArbiterFIFO_0_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_0_bits_op = toAddArbiterFIFO_0_io_deq_bits_op; // @[FMA.scala 141:25]
  assign toAddArbiter_io_in_1_valid = toAddArbiterFIFO_1_io_deq_valid; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_seq = toAddArbiterFIFO_1_io_deq_bits_ctrl_seq; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_dtype = toAddArbiterFIFO_1_io_deq_bits_ctrl_dtype; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_finite_fma = toAddArbiterFIFO_1_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_ctrl_fma_sign = toAddArbiterFIFO_1_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 142:25]
  assign toAddArbiter_io_in_1_bits_op = toAddArbiterFIFO_1_io_deq_bits_op; // @[FMA.scala 142:25]
  assign toAddArbiter_io_out_ready = addInputStage_io_enq_ready & addMulStage_io_enq_ready; // @[FMA.scala 164:50]
  assign toAddArbiterFIFO_0_clock = clock;
  assign toAddArbiterFIFO_0_reset = reset;
  assign toAddArbiterFIFO_0_io_enq_valid = mulPipe_toAdd_op[2] & mulPipe_io_out_valid; // @[FMA.scala 140:70]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_seq = mulPipe_toAdd_ctrl_seq; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_dtype = mulPipe_toAdd_ctrl_dtype; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_finite_fma = mulPipe_toAdd_ctrl_finite_fma; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_ctrl_fma_sign = mulPipe_toAdd_ctrl_fma_sign; // @[FMA.scala 138:51]
  assign toAddArbiterFIFO_0_io_enq_bits_op = mulPipe_toAdd_op; // @[FMA.scala 137:38]
  assign toAddArbiterFIFO_0_io_deq_ready = toAddArbiter_io_in_0_ready; // @[FMA.scala 141:25]
  assign toAddArbiterFIFO_1_clock = clock;
  assign toAddArbiterFIFO_1_reset = reset;
  assign toAddArbiterFIFO_1_io_enq_valid = _toAddArbiterFIFO_1_io_enq_valid_T_1 & io_in_valid; // @[FMA.scala 139:70]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_seq = io_in_bits_ctrl_seq; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_dtype = io_in_bits_ctrl_dtype; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_finite_fma = io_in_bits_ctrl_finite_fma; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_ctrl_fma_sign = io_in_bits_ctrl_fma_sign; // @[FMA.scala 136:51]
  assign toAddArbiterFIFO_1_io_enq_bits_op = io_in_bits_op; // @[FMA.scala 135:54]
  assign toAddArbiterFIFO_1_io_deq_ready = toAddArbiter_io_in_1_ready; // @[FMA.scala 142:25]
  assign inToAddFIFO_clock = clock;
  assign inToAddFIFO_reset = reset;
  assign inToAddFIFO_io_enq_valid = _toAddArbiterFIFO_1_io_enq_valid_T_1 & io_in_valid; // @[FMA.scala 146:62]
  assign inToAddFIFO_io_enq_bits_op = io_in_bits_op; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_a = io_in_bits_a; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_b = io_in_bits_b; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_rm = 3'h0; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_ctrl_seq = io_in_bits_ctrl_seq; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_ctrl_dtype = io_in_bits_ctrl_dtype; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_ctrl_finite_fma = io_in_bits_ctrl_finite_fma; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_enq_bits_ctrl_fma_sign = io_in_bits_ctrl_fma_sign; // @[FMA.scala 145:27]
  assign inToAddFIFO_io_deq_ready = toAddArbiter_io_in_1_ready; // @[FMA.scala 147:28]
  assign mulToAddFIFO_clock = clock;
  assign mulToAddFIFO_reset = reset;
  assign mulToAddFIFO_io_enq_valid = toAddArbiterFIFO_0_io_enq_ready & toAddArbiterFIFO_0_io_enq_valid; // @[Decoupled.scala 51:35]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sign = mulPipe_toAdd_mulOutput_fp_prod_sign; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_exp = mulPipe_toAdd_mulOutput_fp_prod_exp; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_fp_prod_sig = mulPipe_toAdd_mulOutput_fp_prod_sig; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isNaN = mulPipe_toAdd_mulOutput_inter_flags_isNaN; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInf = mulPipe_toAdd_mulOutput_inter_flags_isInf; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_isInv = mulPipe_toAdd_mulOutput_inter_flags_isInv; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_overflow = mulPipe_toAdd_mulOutput_inter_flags_overflow; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_mulOutput_inter_flags_prod_sign = mulPipe_toAdd_mulOutput_inter_flags_prod_sign; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_addAnother = mulPipe_toAdd_addAnother; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_enq_bits_rm = 3'h0; // @[FMA.scala 150:28]
  assign mulToAddFIFO_io_deq_ready = toAddArbiter_io_in_0_ready; // @[FMA.scala 152:29]
  assign addInputStage_clock = clock;
  assign addInputStage_reset = reset;
  assign addInputStage_io_enq_valid = toAddArbiter_io_out_valid & addMulStage_io_enq_ready; // @[FMA.scala 165:59]
  assign addInputStage_io_enq_bits_op = toAddArbiter_io_out_bits_op; // @[FMA.scala 161:32]
  assign addInputStage_io_enq_bits_a = inToAddFIFO_io_deq_bits_a; // @[FMA.scala 160:29]
  assign addInputStage_io_enq_bits_b = inToAddFIFO_io_deq_bits_b; // @[FMA.scala 160:29]
  assign addInputStage_io_enq_bits_rm = inToAddFIFO_io_deq_bits_rm; // @[FMA.scala 160:29]
  assign addInputStage_io_enq_bits_ctrl_seq = toAddArbiter_io_out_bits_ctrl_seq; // @[FMA.scala 162:44]
  assign addInputStage_io_enq_bits_ctrl_dtype = toAddArbiter_io_out_bits_ctrl_dtype; // @[FMA.scala 162:44]
  assign addInputStage_io_enq_bits_ctrl_finite_fma = toAddArbiter_io_out_bits_ctrl_finite_fma; // @[FMA.scala 162:44]
  assign addInputStage_io_enq_bits_ctrl_fma_sign = toAddArbiter_io_out_bits_ctrl_fma_sign; // @[FMA.scala 162:44]
  assign addInputStage_io_deq_ready = addPipe_io_in_ready & addInputStage_io_deq_valid & addMulStage_io_deq_valid; // @[FMA.scala 172:75]
  assign addMulStage_clock = clock;
  assign addMulStage_reset = reset;
  assign addMulStage_io_enq_valid = toAddArbiter_io_out_valid & addInputStage_io_enq_ready; // @[FMA.scala 166:57]
  assign addMulStage_io_enq_bits_mulOutput_fp_prod_sign = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sign; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_fp_prod_exp = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_exp; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_fp_prod_sig = mulToAddFIFO_io_deq_bits_mulOutput_fp_prod_sig; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_inter_flags_isNaN = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isNaN; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_inter_flags_isInf = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInf; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_inter_flags_isInv = mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_isInv; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_inter_flags_overflow =
    mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_overflow; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_mulOutput_inter_flags_prod_sign =
    mulToAddFIFO_io_deq_bits_mulOutput_inter_flags_prod_sign; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_addAnother = mulToAddFIFO_io_deq_bits_addAnother; // @[FMA.scala 163:27]
  assign addMulStage_io_enq_bits_rm = mulToAddFIFO_io_deq_bits_rm; // @[FMA.scala 163:27]
  assign addMulStage_io_deq_ready = addPipe_io_in_ready & addInputStage_io_deq_valid & addMulStage_io_deq_valid; // @[FMA.scala 172:75]
  assign mulFIFO_clock = clock;
  assign mulFIFO_reset = reset;
  assign mulFIFO_io_enq_valid = mulPipe_io_out_valid & _mulFIFO_io_enq_valid_T; // @[FMA.scala 183:48]
  assign mulFIFO_io_enq_bits_result = mulPipe_io_out_bits_result; // @[FMA.scala 182:23]
  assign mulFIFO_io_enq_bits_fflags = mulPipe_io_out_bits_fflags; // @[FMA.scala 182:23]
  assign mulFIFO_io_enq_bits_ctrl_seq = mulPipe_io_out_bits_ctrl_seq; // @[FMA.scala 182:23]
  assign mulFIFO_io_enq_bits_ctrl_dtype = mulPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 182:23]
  assign mulFIFO_io_enq_bits_ctrl_finite_fma = mulPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 182:23]
  assign mulFIFO_io_enq_bits_ctrl_fma_sign = mulPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 182:23]
  assign mulFIFO_io_deq_ready = toOutArbiter_io_in_1_ready; // @[FMA.scala 192:25]
  assign addFIFO_clock = clock;
  assign addFIFO_reset = reset;
  assign addFIFO_io_enq_valid = addPipe_io_out_valid; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_result = addPipe_io_out_bits_result; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_fflags = addPipe_io_out_bits_fflags; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_ctrl_seq = addPipe_io_out_bits_ctrl_seq; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_ctrl_dtype = addPipe_io_out_bits_ctrl_dtype; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_ctrl_finite_fma = addPipe_io_out_bits_ctrl_finite_fma; // @[FMA.scala 184:18]
  assign addFIFO_io_enq_bits_ctrl_fma_sign = addPipe_io_out_bits_ctrl_fma_sign; // @[FMA.scala 184:18]
  assign addFIFO_io_deq_ready = toOutArbiter_io_in_0_ready; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_valid = addFIFO_io_deq_valid; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_result = addFIFO_io_deq_bits_result; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_fflags = addFIFO_io_deq_bits_fflags; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_ctrl_seq = addFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_ctrl_dtype = addFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_ctrl_finite_fma = addFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_0_bits_ctrl_fma_sign = addFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 191:25]
  assign toOutArbiter_io_in_1_valid = mulFIFO_io_deq_valid; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_result = mulFIFO_io_deq_bits_result; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_fflags = mulFIFO_io_deq_bits_fflags; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_ctrl_seq = mulFIFO_io_deq_bits_ctrl_seq; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_ctrl_dtype = mulFIFO_io_deq_bits_ctrl_dtype; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_ctrl_finite_fma = mulFIFO_io_deq_bits_ctrl_finite_fma; // @[FMA.scala 192:25]
  assign toOutArbiter_io_in_1_bits_ctrl_fma_sign = mulFIFO_io_deq_bits_ctrl_fma_sign; // @[FMA.scala 192:25]
  assign toOutArbiter_io_out_ready = io_out_ready; // @[FMA.scala 193:10]
endmodule
module Queue_8(
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
module AecFp64PipeUnit(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [6:0]  io_req_bits_op,
  input  [3:0]  io_req_bits_dtype,
  input  [63:0] io_req_bits_a,
  input  [63:0] io_req_bits_b,
  input  [63:0] io_req_bits_c,
  input         io_resp_ready,
  output        io_resp_valid,
  output [63:0] io_resp_bits_result,
  output        io_resp_bits_predicate_result,
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
`endif // RANDOMIZE_REG_INIT
  wire  f64Pipe_clock; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_reset; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_in_ready; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_in_valid; // @[AecFpUnit.scala 98:23]
  wire [2:0] f64Pipe_io_in_bits_op; // @[AecFpUnit.scala 98:23]
  wire [63:0] f64Pipe_io_in_bits_a; // @[AecFpUnit.scala 98:23]
  wire [63:0] f64Pipe_io_in_bits_b; // @[AecFpUnit.scala 98:23]
  wire [63:0] f64Pipe_io_in_bits_c; // @[AecFpUnit.scala 98:23]
  wire [5:0] f64Pipe_io_in_bits_ctrl_seq; // @[AecFpUnit.scala 98:23]
  wire [3:0] f64Pipe_io_in_bits_ctrl_dtype; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_in_bits_ctrl_finite_fma; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_in_bits_ctrl_fma_sign; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_out_ready; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_out_valid; // @[AecFpUnit.scala 98:23]
  wire [63:0] f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 98:23]
  wire [4:0] f64Pipe_io_out_bits_fflags; // @[AecFpUnit.scala 98:23]
  wire [5:0] f64Pipe_io_out_bits_ctrl_seq; // @[AecFpUnit.scala 98:23]
  wire [3:0] f64Pipe_io_out_bits_ctrl_dtype; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_out_bits_ctrl_finite_fma; // @[AecFpUnit.scala 98:23]
  wire  f64Pipe_io_out_bits_ctrl_fma_sign; // @[AecFpUnit.scala 98:23]
  wire  issueQ_clock; // @[AecFpUnit.scala 99:22]
  wire  issueQ_reset; // @[AecFpUnit.scala 99:22]
  wire  issueQ_io_enq_ready; // @[AecFpUnit.scala 99:22]
  wire  issueQ_io_enq_valid; // @[AecFpUnit.scala 99:22]
  wire [5:0] issueQ_io_enq_bits; // @[AecFpUnit.scala 99:22]
  wire  issueQ_io_deq_ready; // @[AecFpUnit.scala 99:22]
  wire  issueQ_io_deq_valid; // @[AecFpUnit.scala 99:22]
  wire [5:0] issueQ_io_deq_bits; // @[AecFpUnit.scala 99:22]
  wire [16:0] cmp16_io_a; // @[AecFpUnit.scala 156:21]
  wire [16:0] cmp16_io_b; // @[AecFpUnit.scala 156:21]
  wire  cmp16_io_lt; // @[AecFpUnit.scala 156:21]
  wire  cmp16_io_eq; // @[AecFpUnit.scala 156:21]
  wire  cmp16_io_gt; // @[AecFpUnit.scala 156:21]
  wire [32:0] cmp32_io_a; // @[AecFpUnit.scala 156:66]
  wire [32:0] cmp32_io_b; // @[AecFpUnit.scala 156:66]
  wire  cmp32_io_lt; // @[AecFpUnit.scala 156:66]
  wire  cmp32_io_eq; // @[AecFpUnit.scala 156:66]
  wire  cmp32_io_gt; // @[AecFpUnit.scala 156:66]
  wire [64:0] cmp64_io_a; // @[AecFpUnit.scala 156:111]
  wire [64:0] cmp64_io_b; // @[AecFpUnit.scala 156:111]
  wire  cmp64_io_lt; // @[AecFpUnit.scala 156:111]
  wire  cmp64_io_eq; // @[AecFpUnit.scala 156:111]
  wire  cmp64_io_gt; // @[AecFpUnit.scala 156:111]
  wire [63:0] f64DownF16_io_in; // @[AecFpUnit.scala 197:26]
  wire [15:0] f64DownF16_io_result; // @[AecFpUnit.scala 197:26]
  wire [63:0] f64DownBf16_io_in; // @[AecFpUnit.scala 198:27]
  wire [15:0] f64DownBf16_io_result; // @[AecFpUnit.scala 198:27]
  wire [63:0] f64DownF32_io_in; // @[AecFpUnit.scala 199:26]
  wire [31:0] f64DownF32_io_result; // @[AecFpUnit.scala 199:26]
  reg [6:0] held_op; // @[AecFpUnit.scala 93:17]
  reg [3:0] held_dtype; // @[AecFpUnit.scala 93:17]
  reg [63:0] held_a; // @[AecFpUnit.scala 93:17]
  reg [63:0] held_b; // @[AecFpUnit.scala 93:17]
  reg  busy; // @[AecFpUnit.scala 94:21]
  wire  _reqPipe_T_3 = io_req_bits_op == 7'h3; // @[AecFpUnit.scala 97:22]
  wire  _reqPipe_T_4 = io_req_bits_op == 7'h1 | io_req_bits_op == 7'h2 | _reqPipe_T_3; // @[AecFpUnit.scala 96:71]
  wire  _reqPipe_T_5 = io_req_bits_op == 7'h5; // @[AecFpUnit.scala 97:56]
  wire  reqPipe = _reqPipe_T_4 | io_req_bits_op == 7'h5; // @[AecFpUnit.scala 97:38]
  reg [5:0] issueSeq; // @[AecFpUnit.scala 100:25]
  wire [2:0] _pipeOp_T_3 = 7'h2 == io_req_bits_op ? 3'h1 : 3'h0; // @[Mux.scala 81:58]
  wire [2:0] _pipeOp_T_5 = 7'h3 == io_req_bits_op ? 3'h2 : _pipeOp_T_3; // @[Mux.scala 81:58]
  wire  _f64Pipe_io_in_bits_ctrl_finite_fma_T_2 = io_req_bits_a[62:52] != 11'h7ff; // @[AecFpUnit.scala 134:30]
  wire  _f64Pipe_io_in_bits_ctrl_finite_fma_T_3 = _reqPipe_T_5 & _f64Pipe_io_in_bits_ctrl_finite_fma_T_2; // @[AecFpUnit.scala 133:55]
  wire  _f64Pipe_io_in_valid_T = ~busy; // @[AecFpUnit.scala 136:41]
  wire  _selectedPipeReady_T_3 = 4'hb == io_req_bits_dtype ? f64Pipe_io_in_ready : 4'ha == io_req_bits_dtype &
    f64Pipe_io_in_ready; // @[Mux.scala 81:58]
  wire  _selectedPipeReady_T_5 = 4'h8 == io_req_bits_dtype ? f64Pipe_io_in_ready : _selectedPipeReady_T_3; // @[Mux.scala 81:58]
  wire  selectedPipeReady = 4'h9 == io_req_bits_dtype ? f64Pipe_io_in_ready : _selectedPipeReady_T_5; // @[Mux.scala 81:58]
  wire  reqDtypeSupported = io_req_bits_dtype == 4'h9; // @[AecFpUnit.scala 142:75]
  wire  _io_req_ready_T_3 = reqPipe ? selectedPipeReady & issueQ_io_enq_ready : 1'h1; // @[AecFpUnit.scala 143:52]
  wire  _issueQ_io_enq_valid_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [5:0] _issueSeq_T_1 = issueSeq + 6'h1; // @[AecFpUnit.scala 146:45]
  wire  _GEN_7 = _issueQ_io_enq_valid_T & ~reqPipe | busy; // @[AecFpUnit.scala 147:{34,62} 94:21]
  wire  isF32 = held_dtype == 4'h8; // @[AecFpUnit.scala 151:26]
  wire  isF64 = held_dtype == 4'h9; // @[AecFpUnit.scala 151:58]
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
  wire  f64AtHead = f64Pipe_io_out_valid & issueQ_io_deq_valid & f64Pipe_io_out_bits_ctrl_seq == issueQ_io_deq_bits; // @[AecFpUnit.scala 166:63]
  wire  oldAtHead = busy & issueQ_io_deq_valid; // @[AecFpUnit.scala 167:32]
  wire  _issueQ_io_deq_ready_T = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire  isCmp = held_op >= 7'h20 & held_op < 7'h26; // @[AecFpUnit.scala 173:42]
  wire  isCmpP = held_op >= 7'h28 & held_op < 7'h2e; // @[AecFpUnit.scala 174:44]
  wire [6:0] _cmpMode_T_1 = held_op - 7'h28; // @[AecFpUnit.scala 175:37]
  wire [6:0] _cmpMode_T_3 = held_op - 7'h20; // @[AecFpUnit.scala 175:65]
  wire [6:0] cmpMode = isCmpP ? _cmpMode_T_1 : _cmpMode_T_3; // @[AecFpUnit.scala 175:20]
  wire  _cmpTrue_T_1 = 4'ha == held_dtype ? cmp16_io_eq : cmp32_io_eq; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_3 = 4'hb == held_dtype ? cmp32_io_eq : _cmpTrue_T_1; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_5 = 4'h9 == held_dtype ? cmp64_io_eq : _cmpTrue_T_3; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_6 = ~cmp32_io_eq; // @[AecFpUnit.scala 178:34]
  wire  _cmpTrue_T_7 = ~cmp16_io_eq; // @[AecFpUnit.scala 178:62]
  wire  _cmpTrue_T_9 = ~cmp64_io_eq; // @[AecFpUnit.scala 178:109]
  wire  _cmpTrue_T_11 = 4'ha == held_dtype ? _cmpTrue_T_7 : _cmpTrue_T_6; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_13 = 4'hb == held_dtype ? _cmpTrue_T_6 : _cmpTrue_T_11; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_15 = 4'h9 == held_dtype ? _cmpTrue_T_9 : _cmpTrue_T_13; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_17 = 4'ha == held_dtype ? cmp16_io_lt : cmp32_io_lt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_19 = 4'hb == held_dtype ? cmp32_io_lt : _cmpTrue_T_17; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_21 = 4'h9 == held_dtype ? cmp64_io_lt : _cmpTrue_T_19; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_22 = cmp32_io_lt | cmp32_io_eq; // @[AecFpUnit.scala 180:46]
  wire  _cmpTrue_T_23 = cmp16_io_lt | cmp16_io_eq; // @[AecFpUnit.scala 180:87]
  wire  _cmpTrue_T_25 = cmp64_io_lt | cmp64_io_eq; // @[AecFpUnit.scala 180:162]
  wire  _cmpTrue_T_27 = 4'ha == held_dtype ? _cmpTrue_T_23 : _cmpTrue_T_22; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_29 = 4'hb == held_dtype ? _cmpTrue_T_22 : _cmpTrue_T_27; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_31 = 4'h9 == held_dtype ? _cmpTrue_T_25 : _cmpTrue_T_29; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_33 = 4'ha == held_dtype ? cmp16_io_gt : cmp32_io_gt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_35 = 4'hb == held_dtype ? cmp32_io_gt : _cmpTrue_T_33; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_37 = 4'h9 == held_dtype ? cmp64_io_gt : _cmpTrue_T_35; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_38 = cmp32_io_gt | cmp32_io_eq; // @[AecFpUnit.scala 182:46]
  wire  _cmpTrue_T_39 = cmp16_io_gt | cmp16_io_eq; // @[AecFpUnit.scala 182:87]
  wire  _cmpTrue_T_41 = cmp64_io_gt | cmp64_io_eq; // @[AecFpUnit.scala 182:162]
  wire  _cmpTrue_T_43 = 4'ha == held_dtype ? _cmpTrue_T_39 : _cmpTrue_T_38; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_45 = 4'hb == held_dtype ? _cmpTrue_T_38 : _cmpTrue_T_43; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_47 = 4'h9 == held_dtype ? _cmpTrue_T_41 : _cmpTrue_T_45; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_51 = 7'h1 == cmpMode ? _cmpTrue_T_15 : 7'h0 == cmpMode & _cmpTrue_T_5; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_53 = 7'h2 == cmpMode ? _cmpTrue_T_21 : _cmpTrue_T_51; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_55 = 7'h3 == cmpMode ? _cmpTrue_T_31 : _cmpTrue_T_53; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_57 = 7'h4 == cmpMode ? _cmpTrue_T_37 : _cmpTrue_T_55; // @[Mux.scala 81:58]
  wire  cmpTrue = 7'h5 == cmpMode ? _cmpTrue_T_47 : _cmpTrue_T_57; // @[Mux.scala 81:58]
  wire  aNaN32 = &held_a[30:23] & |held_a[22:0]; // @[AecFpUnit.scala 184:33]
  wire  bNaN32 = &held_b[30:23] & |held_b[22:0]; // @[AecFpUnit.scala 185:33]
  wire  bothZero32 = held_a[30:0] == 31'h0 & held_b[30:0] == 31'h0; // @[AecFpUnit.scala 186:39]
  wire  _minNumeric32_T_2 = held_a[31] | held_b[31]; // @[AecFpUnit.scala 187:50]
  wire [31:0] _minNumeric32_T_3 = {_minNumeric32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _minNumeric32_T_4 = cmp32_io_lt ? held_a[31:0] : held_b[31:0]; // @[AecFpUnit.scala 187:76]
  wire [31:0] minNumeric32 = bothZero32 ? _minNumeric32_T_3 : _minNumeric32_T_4; // @[AecFpUnit.scala 187:25]
  wire  _maxNumeric32_T_2 = held_a[31] & held_b[31]; // @[AecFpUnit.scala 188:50]
  wire [31:0] _maxNumeric32_T_3 = {_maxNumeric32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _maxNumeric32_T_4 = cmp32_io_gt ? held_a[31:0] : held_b[31:0]; // @[AecFpUnit.scala 188:76]
  wire [31:0] maxNumeric32 = bothZero32 ? _maxNumeric32_T_3 : _maxNumeric32_T_4; // @[AecFpUnit.scala 188:25]
  wire  _minMax32_T_1 = held_op == 7'h9; // @[AecFpUnit.scala 190:51]
  wire [31:0] _minMax32_T_2 = held_op == 7'h9 ? minNumeric32 : maxNumeric32; // @[AecFpUnit.scala 190:42]
  wire [31:0] _minMax32_T_3 = bNaN32 ? held_a[31:0] : _minMax32_T_2; // @[AecFpUnit.scala 190:25]
  wire [31:0] _minMax32_T_4 = aNaN32 ? held_b[31:0] : _minMax32_T_3; // @[AecFpUnit.scala 190:8]
  wire [31:0] minMax32 = aNaN32 & bNaN32 ? 32'h7fc00000 : _minMax32_T_4; // @[AecFpUnit.scala 189:21]
  wire [94:0] _unarySign_T_3 = isF32 ? 95'h80000000 : 95'h8000; // @[AecFpUnit.scala 191:52]
  wire [126:0] unarySign = isF64 ? 127'h8000000000000000 : {{32'd0}, _unarySign_T_3}; // @[AecFpUnit.scala 191:22]
  wire  _unaryRaw_T = held_op == 7'h8; // @[AecFpUnit.scala 192:30]
  wire [126:0] _unaryRaw_T_1 = ~unarySign; // @[AecFpUnit.scala 192:56]
  wire [126:0] _GEN_33 = {{63'd0}, held_a}; // @[AecFpUnit.scala 192:54]
  wire [126:0] _unaryRaw_T_2 = _GEN_33 & _unaryRaw_T_1; // @[AecFpUnit.scala 192:54]
  wire  _unaryRaw_T_3 = held_op == 7'h7; // @[AecFpUnit.scala 192:80]
  wire [126:0] _unaryRaw_T_4 = _GEN_33 ^ unarySign; // @[AecFpUnit.scala 192:104]
  wire [126:0] _unaryRaw_T_5 = held_op == 7'h7 ? _unaryRaw_T_4 : {{63'd0}, held_a}; // @[AecFpUnit.scala 192:71]
  wire [126:0] unaryRaw = held_op == 7'h8 ? _unaryRaw_T_2 : _unaryRaw_T_5; // @[AecFpUnit.scala 192:21]
  wire [63:0] _unary_T_1 = {32'h0,unaryRaw[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_3 = {48'h0,unaryRaw[15:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_4 = isF32 ? _unary_T_1 : _unary_T_3; // @[AecFpUnit.scala 193:39]
  wire [126:0] unary = isF64 ? unaryRaw : {{63'd0}, _unary_T_4}; // @[AecFpUnit.scala 193:18]
  wire  isMinMax = _minMax32_T_1 | held_op == 7'ha; // @[AecFpUnit.scala 194:42]
  wire  _oldResult_T = isCmp | isCmpP; // @[AecFpUnit.scala 195:29]
  wire [63:0] _oldResult_T_1 = {63'h0,cmpTrue}; // @[Cat.scala 33:92]
  wire [63:0] _oldResult_T_2 = {32'h0,minMax32}; // @[Cat.scala 33:92]
  wire [126:0] _oldResult_T_3 = isMinMax ? {{63'd0}, _oldResult_T_2} : unary; // @[AecFpUnit.scala 196:8]
  wire [126:0] oldResult = isCmp | isCmpP ? {{63'd0}, _oldResult_T_1} : _oldResult_T_3; // @[AecFpUnit.scala 195:22]
  wire  pipeF64NaNRaw = f64Pipe_io_out_bits_result[62:52] == 11'h7ff & |f64Pipe_io_out_bits_result[51:0]; // @[AecFpUnit.scala 201:52]
  wire  _pipeF64Fixed_T = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma; // @[AecFpUnit.scala 202:40]
  wire [63:0] _pipeF64Fixed_T_1 = {f64Pipe_io_out_bits_ctrl_fma_sign,11'h7ff,52'h0}; // @[Cat.scala 33:92]
  wire [63:0] pipeF64Fixed = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 202:25]
  wire  pipeF64NaN = pipeF64Fixed[62:52] == 11'h7ff & |pipeF64Fixed[51:0]; // @[AecFpUnit.scala 207:51]
  wire [63:0] _pipeResult_T = {48'h0,f64DownF16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_1 = pipeF64NaN ? 64'h7e00 : _pipeResult_T; // @[AecFpUnit.scala 209:16]
  wire [63:0] _pipeResult_T_2 = {48'h0,f64DownBf16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_3 = pipeF64NaN ? 64'h7fc0 : _pipeResult_T_2; // @[AecFpUnit.scala 210:16]
  wire [63:0] _pipeResult_T_4 = {32'h0,f64DownF32_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_5 = pipeF64NaN ? 64'h7fc00000 : _pipeResult_T_4; // @[AecFpUnit.scala 211:15]
  wire [63:0] _pipeResult_T_7 = 4'ha == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_1 : pipeF64Fixed; // @[Mux.scala 81:58]
  wire [63:0] _pipeResult_T_9 = 4'hb == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_3 : _pipeResult_T_7; // @[Mux.scala 81:58]
  wire [63:0] pipeResult = 4'h8 == f64Pipe_io_out_bits_ctrl_dtype ? _pipeResult_T_5 : _pipeResult_T_9; // @[Mux.scala 81:58]
  wire [4:0] f64Flags = _pipeF64Fixed_T ? 5'h5 : f64Pipe_io_out_bits_fflags; // @[AecFpUnit.scala 213:21]
  wire [126:0] _io_resp_bits_result_T = f64AtHead ? {{63'd0}, pipeResult} : oldResult; // @[AecFpUnit.scala 215:29]
  wire  _io_resp_bits_error_T_6 = ~(_oldResult_T | isMinMax | _unaryRaw_T_3 | _unaryRaw_T); // @[AecFpUnit.scala 219:5]
  FMA f64Pipe ( // @[AecFpUnit.scala 98:23]
    .clock(f64Pipe_clock),
    .reset(f64Pipe_reset),
    .io_in_ready(f64Pipe_io_in_ready),
    .io_in_valid(f64Pipe_io_in_valid),
    .io_in_bits_op(f64Pipe_io_in_bits_op),
    .io_in_bits_a(f64Pipe_io_in_bits_a),
    .io_in_bits_b(f64Pipe_io_in_bits_b),
    .io_in_bits_c(f64Pipe_io_in_bits_c),
    .io_in_bits_ctrl_seq(f64Pipe_io_in_bits_ctrl_seq),
    .io_in_bits_ctrl_dtype(f64Pipe_io_in_bits_ctrl_dtype),
    .io_in_bits_ctrl_finite_fma(f64Pipe_io_in_bits_ctrl_finite_fma),
    .io_in_bits_ctrl_fma_sign(f64Pipe_io_in_bits_ctrl_fma_sign),
    .io_out_ready(f64Pipe_io_out_ready),
    .io_out_valid(f64Pipe_io_out_valid),
    .io_out_bits_result(f64Pipe_io_out_bits_result),
    .io_out_bits_fflags(f64Pipe_io_out_bits_fflags),
    .io_out_bits_ctrl_seq(f64Pipe_io_out_bits_ctrl_seq),
    .io_out_bits_ctrl_dtype(f64Pipe_io_out_bits_ctrl_dtype),
    .io_out_bits_ctrl_finite_fma(f64Pipe_io_out_bits_ctrl_finite_fma),
    .io_out_bits_ctrl_fma_sign(f64Pipe_io_out_bits_ctrl_fma_sign)
  );
  Queue_8 issueQ ( // @[AecFpUnit.scala 99:22]
    .clock(issueQ_clock),
    .reset(issueQ_reset),
    .io_enq_ready(issueQ_io_enq_ready),
    .io_enq_valid(issueQ_io_enq_valid),
    .io_enq_bits(issueQ_io_enq_bits),
    .io_deq_ready(issueQ_io_deq_ready),
    .io_deq_valid(issueQ_io_deq_valid),
    .io_deq_bits(issueQ_io_deq_bits)
  );
  CompareRecFN cmp16 ( // @[AecFpUnit.scala 156:21]
    .io_a(cmp16_io_a),
    .io_b(cmp16_io_b),
    .io_lt(cmp16_io_lt),
    .io_eq(cmp16_io_eq),
    .io_gt(cmp16_io_gt)
  );
  CompareRecFN_1 cmp32 ( // @[AecFpUnit.scala 156:66]
    .io_a(cmp32_io_a),
    .io_b(cmp32_io_b),
    .io_lt(cmp32_io_lt),
    .io_eq(cmp32_io_eq),
    .io_gt(cmp32_io_gt)
  );
  CompareRecFN_2 cmp64 ( // @[AecFpUnit.scala 156:111]
    .io_a(cmp64_io_a),
    .io_b(cmp64_io_b),
    .io_lt(cmp64_io_lt),
    .io_eq(cmp64_io_eq),
    .io_gt(cmp64_io_gt)
  );
  FPToFP_9 f64DownF16 ( // @[AecFpUnit.scala 197:26]
    .io_in(f64DownF16_io_in),
    .io_result(f64DownF16_io_result)
  );
  FPToFP_10 f64DownBf16 ( // @[AecFpUnit.scala 198:27]
    .io_in(f64DownBf16_io_in),
    .io_result(f64DownBf16_io_result)
  );
  FPToFP_11 f64DownF32 ( // @[AecFpUnit.scala 199:26]
    .io_in(f64DownF32_io_in),
    .io_result(f64DownF32_io_result)
  );
  assign io_req_ready = _f64Pipe_io_in_valid_T & reqDtypeSupported & _io_req_ready_T_3; // @[AecFpUnit.scala 143:46]
  assign io_resp_valid = f64AtHead | oldAtHead; // @[AecFpUnit.scala 169:34]
  assign io_resp_bits_result = _io_resp_bits_result_T[63:0]; // @[AecFpUnit.scala 215:23]
  assign io_resp_bits_predicate_result = f64AtHead ? 1'h0 : isCmpP & cmpTrue; // @[AecFpUnit.scala 216:39]
  assign io_resp_bits_error = f64AtHead ? 1'h0 : _io_resp_bits_error_T_6; // @[AecFpUnit.scala 218:28]
  assign io_resp_bits_exception_flags = f64AtHead ? f64Flags : 5'h0; // @[AecFpUnit.scala 220:38]
  assign f64Pipe_clock = clock;
  assign f64Pipe_reset = reset;
  assign f64Pipe_io_in_valid = io_req_valid & ~busy & reqPipe & issueQ_io_enq_ready; // @[AecFpUnit.scala 136:58]
  assign f64Pipe_io_in_bits_op = 7'h5 == io_req_bits_op ? 3'h4 : _pipeOp_T_5; // @[Mux.scala 81:58]
  assign f64Pipe_io_in_bits_a = io_req_bits_a; // @[AecFpUnit.scala 126:23]
  assign f64Pipe_io_in_bits_b = io_req_bits_b; // @[AecFpUnit.scala 127:23]
  assign f64Pipe_io_in_bits_c = io_req_bits_c; // @[AecFpUnit.scala 128:23]
  assign f64Pipe_io_in_bits_ctrl_seq = issueSeq; // @[AecFpUnit.scala 130:14]
  assign f64Pipe_io_in_bits_ctrl_dtype = io_req_bits_dtype; // @[AecFpUnit.scala 132:16]
  assign f64Pipe_io_in_bits_ctrl_finite_fma = _f64Pipe_io_in_bits_ctrl_finite_fma_T_3 & io_req_bits_b[62:52] != 11'h7ff
     & io_req_bits_c[62:52] != 11'h7ff; // @[AecFpUnit.scala 134:78]
  assign f64Pipe_io_in_bits_ctrl_fma_sign = io_req_bits_a[63] ^ io_req_bits_b[63]; // @[AecFpUnit.scala 135:42]
  assign f64Pipe_io_out_ready = io_resp_ready & f64AtHead; // @[AecFpUnit.scala 171:41]
  assign issueQ_clock = clock;
  assign issueQ_reset = reset;
  assign issueQ_io_enq_valid = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign issueQ_io_enq_bits = issueSeq; // @[AecFpUnit.scala 145:22]
  assign issueQ_io_deq_ready = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign cmp16_io_a = {_cmp16_io_a_T_20,cmp16_io_a_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp16_io_b = {_cmp16_io_b_T_20,cmp16_io_b_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_a = {_cmp32_io_a_T_20,cmp32_io_a_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_b = {_cmp32_io_b_T_20,cmp32_io_b_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_a = {_cmp64_io_a_T_6,cmp64_io_a_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_b = {_cmp64_io_b_T_6,cmp64_io_b_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign f64DownF16_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 202:25]
  assign f64DownBf16_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 202:25]
  assign f64DownF32_io_in = pipeF64NaNRaw & f64Pipe_io_out_bits_ctrl_finite_fma ? _pipeF64Fixed_T_1 :
    f64Pipe_io_out_bits_result; // @[AecFpUnit.scala 202:25]
  always @(posedge clock) begin
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 147:34]
      held_op <= io_req_bits_op; // @[AecFpUnit.scala 147:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 147:34]
      held_dtype <= io_req_bits_dtype; // @[AecFpUnit.scala 147:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 147:34]
      held_a <= io_req_bits_a; // @[AecFpUnit.scala 147:41]
    end
    if (_issueQ_io_enq_valid_T & ~reqPipe) begin // @[AecFpUnit.scala 147:34]
      held_b <= io_req_bits_b; // @[AecFpUnit.scala 147:41]
    end
    if (reset) begin // @[AecFpUnit.scala 94:21]
      busy <= 1'h0; // @[AecFpUnit.scala 94:21]
    end else if (_issueQ_io_deq_ready_T & oldAtHead) begin // @[AecFpUnit.scala 172:36]
      busy <= 1'h0; // @[AecFpUnit.scala 172:43]
    end else begin
      busy <= _GEN_7;
    end
    if (reset) begin // @[AecFpUnit.scala 100:25]
      issueSeq <= 6'h0; // @[AecFpUnit.scala 100:25]
    end else if (_issueQ_io_enq_valid_T) begin // @[AecFpUnit.scala 146:22]
      issueSeq <= _issueSeq_T_1; // @[AecFpUnit.scala 146:33]
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
  busy = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  issueSeq = _RAND_5[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecFpWarpRequestStage(
  input         clock,
  input         reset,
  input         io_inValid,
  output        io_inReady,
  input  [3:0]  io_group,
  input  [6:0]  io_data_0_op,
  input  [3:0]  io_data_0_dtype,
  input  [63:0] io_data_0_a,
  input  [63:0] io_data_0_b,
  input  [63:0] io_data_0_c,
  input  [6:0]  io_data_1_op,
  input  [3:0]  io_data_1_dtype,
  input  [63:0] io_data_1_a,
  input  [63:0] io_data_1_b,
  input  [63:0] io_data_1_c,
  input  [6:0]  io_data_2_op,
  input  [3:0]  io_data_2_dtype,
  input  [63:0] io_data_2_a,
  input  [63:0] io_data_2_b,
  input  [63:0] io_data_2_c,
  input  [6:0]  io_data_3_op,
  input  [3:0]  io_data_3_dtype,
  input  [63:0] io_data_3_a,
  input  [63:0] io_data_3_b,
  input  [63:0] io_data_3_c,
  input  [6:0]  io_data_4_op,
  input  [3:0]  io_data_4_dtype,
  input  [63:0] io_data_4_a,
  input  [63:0] io_data_4_b,
  input  [63:0] io_data_4_c,
  input  [6:0]  io_data_5_op,
  input  [3:0]  io_data_5_dtype,
  input  [63:0] io_data_5_a,
  input  [63:0] io_data_5_b,
  input  [63:0] io_data_5_c,
  input  [6:0]  io_data_6_op,
  input  [3:0]  io_data_6_dtype,
  input  [63:0] io_data_6_a,
  input  [63:0] io_data_6_b,
  input  [63:0] io_data_6_c,
  input  [6:0]  io_data_7_op,
  input  [3:0]  io_data_7_dtype,
  input  [63:0] io_data_7_a,
  input  [63:0] io_data_7_b,
  input  [63:0] io_data_7_c,
  input  [6:0]  io_data_8_op,
  input  [3:0]  io_data_8_dtype,
  input  [63:0] io_data_8_a,
  input  [63:0] io_data_8_b,
  input  [63:0] io_data_8_c,
  input  [6:0]  io_data_9_op,
  input  [3:0]  io_data_9_dtype,
  input  [63:0] io_data_9_a,
  input  [63:0] io_data_9_b,
  input  [63:0] io_data_9_c,
  input  [6:0]  io_data_10_op,
  input  [3:0]  io_data_10_dtype,
  input  [63:0] io_data_10_a,
  input  [63:0] io_data_10_b,
  input  [63:0] io_data_10_c,
  input  [6:0]  io_data_11_op,
  input  [3:0]  io_data_11_dtype,
  input  [63:0] io_data_11_a,
  input  [63:0] io_data_11_b,
  input  [63:0] io_data_11_c,
  input  [6:0]  io_data_12_op,
  input  [3:0]  io_data_12_dtype,
  input  [63:0] io_data_12_a,
  input  [63:0] io_data_12_b,
  input  [63:0] io_data_12_c,
  input  [6:0]  io_data_13_op,
  input  [3:0]  io_data_13_dtype,
  input  [63:0] io_data_13_a,
  input  [63:0] io_data_13_b,
  input  [63:0] io_data_13_c,
  input  [6:0]  io_data_14_op,
  input  [3:0]  io_data_14_dtype,
  input  [63:0] io_data_14_a,
  input  [63:0] io_data_14_b,
  input  [63:0] io_data_14_c,
  input  [6:0]  io_data_15_op,
  input  [3:0]  io_data_15_dtype,
  input  [63:0] io_data_15_a,
  input  [63:0] io_data_15_b,
  input  [63:0] io_data_15_c,
  input         io_out_ready,
  output        io_out_valid,
  output [6:0]  io_out_bits_op,
  output [3:0]  io_out_bits_dtype,
  output [63:0] io_out_bits_a,
  output [63:0] io_out_bits_b,
  output [63:0] io_out_bits_c
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  selectValid; // @[AecFpUnit.scala 52:28]
  reg [3:0] selectedGroup; // @[AecFpUnit.scala 53:26]
  reg  dataValid; // @[AecFpUnit.scala 54:26]
  reg [6:0] data_op; // @[AecFpUnit.scala 55:17]
  reg [3:0] data_dtype; // @[AecFpUnit.scala 55:17]
  reg [63:0] data_a; // @[AecFpUnit.scala 55:17]
  reg [63:0] data_b; // @[AecFpUnit.scala 55:17]
  reg [63:0] data_c; // @[AecFpUnit.scala 55:17]
  wire  dataReady = ~dataValid | io_out_ready; // @[AecFpUnit.scala 56:30]
  wire  selectReady = ~selectValid | dataReady; // @[AecFpUnit.scala 57:34]
  wire [6:0] _GEN_1 = 4'h1 == selectedGroup ? io_data_1_op : io_data_0_op; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_2 = 4'h2 == selectedGroup ? io_data_2_op : _GEN_1; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_3 = 4'h3 == selectedGroup ? io_data_3_op : _GEN_2; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_4 = 4'h4 == selectedGroup ? io_data_4_op : _GEN_3; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_5 = 4'h5 == selectedGroup ? io_data_5_op : _GEN_4; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_6 = 4'h6 == selectedGroup ? io_data_6_op : _GEN_5; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_7 = 4'h7 == selectedGroup ? io_data_7_op : _GEN_6; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_8 = 4'h8 == selectedGroup ? io_data_8_op : _GEN_7; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_9 = 4'h9 == selectedGroup ? io_data_9_op : _GEN_8; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_10 = 4'ha == selectedGroup ? io_data_10_op : _GEN_9; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_11 = 4'hb == selectedGroup ? io_data_11_op : _GEN_10; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_12 = 4'hc == selectedGroup ? io_data_12_op : _GEN_11; // @[AecFpUnit.scala 64:{31,31}]
  wire [6:0] _GEN_13 = 4'hd == selectedGroup ? io_data_13_op : _GEN_12; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_17 = 4'h1 == selectedGroup ? io_data_1_dtype : io_data_0_dtype; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_18 = 4'h2 == selectedGroup ? io_data_2_dtype : _GEN_17; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_19 = 4'h3 == selectedGroup ? io_data_3_dtype : _GEN_18; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_20 = 4'h4 == selectedGroup ? io_data_4_dtype : _GEN_19; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_21 = 4'h5 == selectedGroup ? io_data_5_dtype : _GEN_20; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_22 = 4'h6 == selectedGroup ? io_data_6_dtype : _GEN_21; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_23 = 4'h7 == selectedGroup ? io_data_7_dtype : _GEN_22; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_24 = 4'h8 == selectedGroup ? io_data_8_dtype : _GEN_23; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_25 = 4'h9 == selectedGroup ? io_data_9_dtype : _GEN_24; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_26 = 4'ha == selectedGroup ? io_data_10_dtype : _GEN_25; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_27 = 4'hb == selectedGroup ? io_data_11_dtype : _GEN_26; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_28 = 4'hc == selectedGroup ? io_data_12_dtype : _GEN_27; // @[AecFpUnit.scala 64:{31,31}]
  wire [3:0] _GEN_29 = 4'hd == selectedGroup ? io_data_13_dtype : _GEN_28; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_33 = 4'h1 == selectedGroup ? io_data_1_a : io_data_0_a; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_34 = 4'h2 == selectedGroup ? io_data_2_a : _GEN_33; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_35 = 4'h3 == selectedGroup ? io_data_3_a : _GEN_34; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_36 = 4'h4 == selectedGroup ? io_data_4_a : _GEN_35; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_37 = 4'h5 == selectedGroup ? io_data_5_a : _GEN_36; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_38 = 4'h6 == selectedGroup ? io_data_6_a : _GEN_37; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_39 = 4'h7 == selectedGroup ? io_data_7_a : _GEN_38; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_40 = 4'h8 == selectedGroup ? io_data_8_a : _GEN_39; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_41 = 4'h9 == selectedGroup ? io_data_9_a : _GEN_40; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_42 = 4'ha == selectedGroup ? io_data_10_a : _GEN_41; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_43 = 4'hb == selectedGroup ? io_data_11_a : _GEN_42; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_44 = 4'hc == selectedGroup ? io_data_12_a : _GEN_43; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_45 = 4'hd == selectedGroup ? io_data_13_a : _GEN_44; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_49 = 4'h1 == selectedGroup ? io_data_1_b : io_data_0_b; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_50 = 4'h2 == selectedGroup ? io_data_2_b : _GEN_49; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_51 = 4'h3 == selectedGroup ? io_data_3_b : _GEN_50; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_52 = 4'h4 == selectedGroup ? io_data_4_b : _GEN_51; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_53 = 4'h5 == selectedGroup ? io_data_5_b : _GEN_52; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_54 = 4'h6 == selectedGroup ? io_data_6_b : _GEN_53; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_55 = 4'h7 == selectedGroup ? io_data_7_b : _GEN_54; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_56 = 4'h8 == selectedGroup ? io_data_8_b : _GEN_55; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_57 = 4'h9 == selectedGroup ? io_data_9_b : _GEN_56; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_58 = 4'ha == selectedGroup ? io_data_10_b : _GEN_57; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_59 = 4'hb == selectedGroup ? io_data_11_b : _GEN_58; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_60 = 4'hc == selectedGroup ? io_data_12_b : _GEN_59; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_61 = 4'hd == selectedGroup ? io_data_13_b : _GEN_60; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_65 = 4'h1 == selectedGroup ? io_data_1_c : io_data_0_c; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_66 = 4'h2 == selectedGroup ? io_data_2_c : _GEN_65; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_67 = 4'h3 == selectedGroup ? io_data_3_c : _GEN_66; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_68 = 4'h4 == selectedGroup ? io_data_4_c : _GEN_67; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_69 = 4'h5 == selectedGroup ? io_data_5_c : _GEN_68; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_70 = 4'h6 == selectedGroup ? io_data_6_c : _GEN_69; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_71 = 4'h7 == selectedGroup ? io_data_7_c : _GEN_70; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_72 = 4'h8 == selectedGroup ? io_data_8_c : _GEN_71; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_73 = 4'h9 == selectedGroup ? io_data_9_c : _GEN_72; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_74 = 4'ha == selectedGroup ? io_data_10_c : _GEN_73; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_75 = 4'hb == selectedGroup ? io_data_11_c : _GEN_74; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_76 = 4'hc == selectedGroup ? io_data_12_c : _GEN_75; // @[AecFpUnit.scala 64:{31,31}]
  wire [63:0] _GEN_77 = 4'hd == selectedGroup ? io_data_13_c : _GEN_76; // @[AecFpUnit.scala 64:{31,31}]
  assign io_inReady = ~selectValid | dataReady; // @[AecFpUnit.scala 57:34]
  assign io_out_valid = dataValid; // @[AecFpUnit.scala 60:16]
  assign io_out_bits_op = data_op; // @[AecFpUnit.scala 61:15]
  assign io_out_bits_dtype = data_dtype; // @[AecFpUnit.scala 61:15]
  assign io_out_bits_a = data_a; // @[AecFpUnit.scala 61:15]
  assign io_out_bits_b = data_b; // @[AecFpUnit.scala 61:15]
  assign io_out_bits_c = data_c; // @[AecFpUnit.scala 61:15]
  always @(posedge clock) begin
    if (reset) begin // @[AecFpUnit.scala 52:28]
      selectValid <= 1'h0; // @[AecFpUnit.scala 52:28]
    end else if (selectReady) begin // @[AecFpUnit.scala 66:22]
      selectValid <= io_inValid; // @[AecFpUnit.scala 67:17]
    end
    if (selectReady) begin // @[AecFpUnit.scala 66:22]
      if (io_inValid) begin // @[AecFpUnit.scala 68:23]
        selectedGroup <= io_group; // @[AecFpUnit.scala 68:39]
      end
    end
    if (reset) begin // @[AecFpUnit.scala 54:26]
      dataValid <= 1'h0; // @[AecFpUnit.scala 54:26]
    end else if (dataReady) begin // @[AecFpUnit.scala 62:20]
      dataValid <= selectValid; // @[AecFpUnit.scala 63:15]
    end
    if (dataReady) begin // @[AecFpUnit.scala 62:20]
      if (selectValid) begin // @[AecFpUnit.scala 64:24]
        if (4'hf == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_op <= io_data_15_op; // @[AecFpUnit.scala 64:31]
        end else if (4'he == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_op <= io_data_14_op; // @[AecFpUnit.scala 64:31]
        end else begin
          data_op <= _GEN_13;
        end
      end
    end
    if (dataReady) begin // @[AecFpUnit.scala 62:20]
      if (selectValid) begin // @[AecFpUnit.scala 64:24]
        if (4'hf == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_dtype <= io_data_15_dtype; // @[AecFpUnit.scala 64:31]
        end else if (4'he == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_dtype <= io_data_14_dtype; // @[AecFpUnit.scala 64:31]
        end else begin
          data_dtype <= _GEN_29;
        end
      end
    end
    if (dataReady) begin // @[AecFpUnit.scala 62:20]
      if (selectValid) begin // @[AecFpUnit.scala 64:24]
        if (4'hf == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_a <= io_data_15_a; // @[AecFpUnit.scala 64:31]
        end else if (4'he == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_a <= io_data_14_a; // @[AecFpUnit.scala 64:31]
        end else begin
          data_a <= _GEN_45;
        end
      end
    end
    if (dataReady) begin // @[AecFpUnit.scala 62:20]
      if (selectValid) begin // @[AecFpUnit.scala 64:24]
        if (4'hf == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_b <= io_data_15_b; // @[AecFpUnit.scala 64:31]
        end else if (4'he == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_b <= io_data_14_b; // @[AecFpUnit.scala 64:31]
        end else begin
          data_b <= _GEN_61;
        end
      end
    end
    if (dataReady) begin // @[AecFpUnit.scala 62:20]
      if (selectValid) begin // @[AecFpUnit.scala 64:24]
        if (4'hf == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_c <= io_data_15_c; // @[AecFpUnit.scala 64:31]
        end else if (4'he == selectedGroup) begin // @[AecFpUnit.scala 64:31]
          data_c <= io_data_14_c; // @[AecFpUnit.scala 64:31]
        end else begin
          data_c <= _GEN_77;
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
  selectValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  selectedGroup = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  dataValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  data_op = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  data_dtype = _RAND_4[3:0];
  _RAND_5 = {2{`RANDOM}};
  data_a = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  data_b = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  data_c = _RAND_7[63:0];
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
  input  [63:0] io_in_c_0,
  input  [63:0] io_in_c_1,
  input  [63:0] io_in_c_2,
  input  [63:0] io_in_c_3,
  input  [63:0] io_in_c_4,
  input  [63:0] io_in_c_5,
  input  [63:0] io_in_c_6,
  input  [63:0] io_in_c_7,
  input  [63:0] io_in_c_8,
  input  [63:0] io_in_c_9,
  input  [63:0] io_in_c_10,
  input  [63:0] io_in_c_11,
  input  [63:0] io_in_c_12,
  input  [63:0] io_in_c_13,
  input  [63:0] io_in_c_14,
  input  [63:0] io_in_c_15,
  input  [63:0] io_in_c_16,
  input  [63:0] io_in_c_17,
  input  [63:0] io_in_c_18,
  input  [63:0] io_in_c_19,
  input  [63:0] io_in_c_20,
  input  [63:0] io_in_c_21,
  input  [63:0] io_in_c_22,
  input  [63:0] io_in_c_23,
  input  [63:0] io_in_c_24,
  input  [63:0] io_in_c_25,
  input  [63:0] io_in_c_26,
  input  [63:0] io_in_c_27,
  input  [63:0] io_in_c_28,
  input  [63:0] io_in_c_29,
  input  [63:0] io_in_c_30,
  input  [63:0] io_in_c_31,
  input  [7:0]  io_in_dest,
  input         io_arm,
  input         io_capture,
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
  output [63:0] io_out_c_0,
  output [63:0] io_out_c_1,
  output [63:0] io_out_c_2,
  output [63:0] io_out_c_3,
  output [63:0] io_out_c_4,
  output [63:0] io_out_c_5,
  output [63:0] io_out_c_6,
  output [63:0] io_out_c_7,
  output [63:0] io_out_c_8,
  output [63:0] io_out_c_9,
  output [63:0] io_out_c_10,
  output [63:0] io_out_c_11,
  output [63:0] io_out_c_12,
  output [63:0] io_out_c_13,
  output [63:0] io_out_c_14,
  output [63:0] io_out_c_15,
  output [63:0] io_out_c_16,
  output [63:0] io_out_c_17,
  output [63:0] io_out_c_18,
  output [63:0] io_out_c_19,
  output [63:0] io_out_c_20,
  output [63:0] io_out_c_21,
  output [63:0] io_out_c_22,
  output [63:0] io_out_c_23,
  output [63:0] io_out_c_24,
  output [63:0] io_out_c_25,
  output [63:0] io_out_c_26,
  output [63:0] io_out_c_27,
  output [63:0] io_out_c_28,
  output [63:0] io_out_c_29,
  output [63:0] io_out_c_30,
  output [63:0] io_out_c_31,
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
  reg [31:0] _RAND_707;
  reg [31:0] _RAND_708;
  reg [31:0] _RAND_709;
  reg [31:0] _RAND_710;
  reg [31:0] _RAND_711;
  reg [31:0] _RAND_712;
  reg [31:0] _RAND_713;
  reg [31:0] _RAND_714;
  reg [31:0] _RAND_715;
  reg [31:0] _RAND_716;
  reg [31:0] _RAND_717;
  reg [31:0] _RAND_718;
  reg [31:0] _RAND_719;
  reg [31:0] _RAND_720;
  reg [31:0] _RAND_721;
  reg [31:0] _RAND_722;
  reg [31:0] _RAND_723;
  reg [31:0] _RAND_724;
  reg [31:0] _RAND_725;
  reg [31:0] _RAND_726;
  reg [31:0] _RAND_727;
  reg [31:0] _RAND_728;
  reg [31:0] _RAND_729;
  reg [31:0] _RAND_730;
  reg [31:0] _RAND_731;
  reg [31:0] _RAND_732;
  reg [31:0] _RAND_733;
  reg [31:0] _RAND_734;
  reg [31:0] _RAND_735;
  reg [31:0] _RAND_736;
  reg [31:0] _RAND_737;
  reg [31:0] _RAND_738;
  reg [31:0] _RAND_739;
  reg [31:0] _RAND_740;
  reg [31:0] _RAND_741;
  reg [31:0] _RAND_742;
  reg [31:0] _RAND_743;
  reg [31:0] _RAND_744;
  reg [31:0] _RAND_745;
  reg [31:0] _RAND_746;
  reg [31:0] _RAND_747;
  reg [31:0] _RAND_748;
  reg [31:0] _RAND_749;
  reg [31:0] _RAND_750;
  reg [31:0] _RAND_751;
  reg [31:0] _RAND_752;
  reg [31:0] _RAND_753;
  reg [31:0] _RAND_754;
  reg [31:0] _RAND_755;
  reg [31:0] _RAND_756;
  reg [31:0] _RAND_757;
  reg [31:0] _RAND_758;
  reg [31:0] _RAND_759;
  reg [31:0] _RAND_760;
  reg [31:0] _RAND_761;
  reg [31:0] _RAND_762;
  reg [31:0] _RAND_763;
  reg [31:0] _RAND_764;
  reg [31:0] _RAND_765;
  reg [31:0] _RAND_766;
  reg [31:0] _RAND_767;
  reg [31:0] _RAND_768;
  reg [31:0] _RAND_769;
  reg [31:0] _RAND_770;
  reg [31:0] _RAND_771;
  reg [31:0] _RAND_772;
  reg [31:0] _RAND_773;
  reg [31:0] _RAND_774;
  reg [31:0] _RAND_775;
  reg [31:0] _RAND_776;
  reg [31:0] _RAND_777;
  reg [31:0] _RAND_778;
  reg [31:0] _RAND_779;
  reg [31:0] _RAND_780;
  reg [31:0] _RAND_781;
  reg [31:0] _RAND_782;
  reg [31:0] _RAND_783;
  reg [31:0] _RAND_784;
  reg [31:0] _RAND_785;
  reg [31:0] _RAND_786;
  reg [31:0] _RAND_787;
  reg [31:0] _RAND_788;
  reg [31:0] _RAND_789;
  reg [31:0] _RAND_790;
  reg [31:0] _RAND_791;
  reg [31:0] _RAND_792;
  reg [31:0] _RAND_793;
  reg [31:0] _RAND_794;
  reg [31:0] _RAND_795;
  reg [31:0] _RAND_796;
  reg [31:0] _RAND_797;
  reg [31:0] _RAND_798;
  reg [31:0] _RAND_799;
  reg [31:0] _RAND_800;
  reg [31:0] _RAND_801;
  reg [31:0] _RAND_802;
  reg [31:0] _RAND_803;
  reg [31:0] _RAND_804;
  reg [31:0] _RAND_805;
  reg [31:0] _RAND_806;
  reg [31:0] _RAND_807;
  reg [31:0] _RAND_808;
  reg [31:0] _RAND_809;
  reg [31:0] _RAND_810;
  reg [31:0] _RAND_811;
  reg [31:0] _RAND_812;
  reg [31:0] _RAND_813;
  reg [31:0] _RAND_814;
  reg [31:0] _RAND_815;
  reg [31:0] _RAND_816;
  reg [31:0] _RAND_817;
  reg [31:0] _RAND_818;
  reg [31:0] _RAND_819;
  reg [31:0] _RAND_820;
  reg [31:0] _RAND_821;
  reg [31:0] _RAND_822;
  reg [31:0] _RAND_823;
  reg [31:0] _RAND_824;
  reg [31:0] _RAND_825;
  reg [31:0] _RAND_826;
  reg [31:0] _RAND_827;
  reg [31:0] _RAND_828;
  reg [31:0] _RAND_829;
  reg [31:0] _RAND_830;
  reg [31:0] _RAND_831;
  reg [31:0] _RAND_832;
`endif // RANDOMIZE_REG_INIT
  reg  operandCapture_0_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_0_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_1_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_2_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_3_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_4_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_5_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_6_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_7_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_8_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_9_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_10_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_11_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_12_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_13_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_14_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_15_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_16_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_17_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_18_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_19_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_20_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_21_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_22_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_23_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_24_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_25_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_26_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_27_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_28_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_29_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_30_11; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_0; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_1; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_2; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_3; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_4; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_5; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_6; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_7; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_8; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_9; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_10; // @[AecExecPort.scala 62:31]
  reg  operandCapture_31_11; // @[AecExecPort.scala 62:31]
  reg  maskCapture_0; // @[AecExecPort.scala 64:28]
  reg  maskCapture_1; // @[AecExecPort.scala 64:28]
  reg  maskCapture_2; // @[AecExecPort.scala 64:28]
  reg  maskCapture_3; // @[AecExecPort.scala 64:28]
  reg  maskCapture_4; // @[AecExecPort.scala 64:28]
  reg  maskCapture_5; // @[AecExecPort.scala 64:28]
  reg  maskCapture_6; // @[AecExecPort.scala 64:28]
  reg  maskCapture_7; // @[AecExecPort.scala 64:28]
  reg  maskCapture_8; // @[AecExecPort.scala 64:28]
  reg  maskCapture_9; // @[AecExecPort.scala 64:28]
  reg  maskCapture_10; // @[AecExecPort.scala 64:28]
  reg  maskCapture_11; // @[AecExecPort.scala 64:28]
  reg  maskCapture_12; // @[AecExecPort.scala 64:28]
  reg  maskCapture_13; // @[AecExecPort.scala 64:28]
  reg  maskCapture_14; // @[AecExecPort.scala 64:28]
  reg  maskCapture_15; // @[AecExecPort.scala 64:28]
  reg  maskCapture_16; // @[AecExecPort.scala 64:28]
  reg  maskCapture_17; // @[AecExecPort.scala 64:28]
  reg  maskCapture_18; // @[AecExecPort.scala 64:28]
  reg  maskCapture_19; // @[AecExecPort.scala 64:28]
  reg  maskCapture_20; // @[AecExecPort.scala 64:28]
  reg  maskCapture_21; // @[AecExecPort.scala 64:28]
  reg  maskCapture_22; // @[AecExecPort.scala 64:28]
  reg  maskCapture_23; // @[AecExecPort.scala 64:28]
  reg  maskCapture_24; // @[AecExecPort.scala 64:28]
  reg  maskCapture_25; // @[AecExecPort.scala 64:28]
  reg  maskCapture_26; // @[AecExecPort.scala 64:28]
  reg  maskCapture_27; // @[AecExecPort.scala 64:28]
  reg  maskCapture_28; // @[AecExecPort.scala 64:28]
  reg  maskCapture_29; // @[AecExecPort.scala 64:28]
  reg  maskCapture_30; // @[AecExecPort.scala 64:28]
  reg  maskCapture_31; // @[AecExecPort.scala 64:28]
  reg [15:0] a_0_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_0_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_0_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_0_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_1_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_1_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_1_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_1_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_2_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_2_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_2_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_2_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_3_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_3_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_3_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_3_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_4_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_4_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_4_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_4_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_5_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_5_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_5_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_5_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_6_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_6_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_6_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_6_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_7_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_7_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_7_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_7_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_8_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_8_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_8_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_8_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_9_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_9_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_9_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_9_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_10_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_10_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_10_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_10_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_11_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_11_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_11_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_11_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_12_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_12_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_12_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_12_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_13_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_13_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_13_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_13_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_14_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_14_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_14_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_14_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_15_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_15_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_15_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_15_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_16_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_16_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_16_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_16_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_17_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_17_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_17_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_17_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_18_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_18_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_18_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_18_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_19_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_19_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_19_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_19_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_20_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_20_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_20_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_20_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_21_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_21_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_21_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_21_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_22_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_22_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_22_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_22_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_23_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_23_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_23_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_23_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_24_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_24_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_24_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_24_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_25_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_25_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_25_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_25_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_26_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_26_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_26_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_26_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_27_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_27_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_27_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_27_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_28_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_28_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_28_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_28_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_29_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_29_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_29_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_29_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_30_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_30_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_30_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_30_3; // @[AecExecPort.scala 66:14]
  reg [15:0] a_31_0; // @[AecExecPort.scala 66:14]
  reg [15:0] a_31_1; // @[AecExecPort.scala 66:14]
  reg [15:0] a_31_2; // @[AecExecPort.scala 66:14]
  reg [15:0] a_31_3; // @[AecExecPort.scala 66:14]
  reg [15:0] b_0_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_0_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_0_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_0_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_1_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_1_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_1_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_1_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_2_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_2_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_2_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_2_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_3_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_3_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_3_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_3_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_4_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_4_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_4_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_4_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_5_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_5_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_5_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_5_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_6_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_6_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_6_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_6_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_7_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_7_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_7_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_7_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_8_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_8_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_8_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_8_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_9_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_9_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_9_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_9_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_10_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_10_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_10_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_10_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_11_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_11_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_11_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_11_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_12_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_12_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_12_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_12_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_13_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_13_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_13_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_13_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_14_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_14_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_14_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_14_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_15_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_15_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_15_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_15_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_16_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_16_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_16_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_16_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_17_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_17_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_17_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_17_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_18_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_18_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_18_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_18_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_19_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_19_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_19_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_19_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_20_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_20_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_20_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_20_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_21_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_21_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_21_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_21_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_22_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_22_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_22_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_22_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_23_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_23_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_23_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_23_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_24_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_24_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_24_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_24_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_25_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_25_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_25_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_25_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_26_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_26_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_26_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_26_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_27_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_27_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_27_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_27_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_28_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_28_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_28_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_28_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_29_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_29_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_29_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_29_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_30_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_30_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_30_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_30_3; // @[AecExecPort.scala 67:14]
  reg [15:0] b_31_0; // @[AecExecPort.scala 67:14]
  reg [15:0] b_31_1; // @[AecExecPort.scala 67:14]
  reg [15:0] b_31_2; // @[AecExecPort.scala 67:14]
  reg [15:0] b_31_3; // @[AecExecPort.scala 67:14]
  reg [15:0] c_0_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_0_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_0_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_0_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_1_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_1_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_1_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_1_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_2_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_2_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_2_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_2_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_3_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_3_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_3_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_3_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_4_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_4_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_4_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_4_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_5_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_5_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_5_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_5_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_6_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_6_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_6_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_6_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_7_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_7_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_7_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_7_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_8_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_8_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_8_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_8_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_9_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_9_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_9_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_9_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_10_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_10_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_10_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_10_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_11_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_11_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_11_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_11_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_12_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_12_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_12_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_12_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_13_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_13_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_13_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_13_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_14_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_14_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_14_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_14_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_15_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_15_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_15_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_15_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_16_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_16_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_16_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_16_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_17_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_17_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_17_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_17_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_18_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_18_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_18_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_18_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_19_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_19_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_19_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_19_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_20_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_20_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_20_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_20_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_21_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_21_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_21_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_21_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_22_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_22_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_22_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_22_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_23_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_23_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_23_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_23_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_24_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_24_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_24_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_24_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_25_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_25_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_25_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_25_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_26_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_26_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_26_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_26_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_27_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_27_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_27_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_27_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_28_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_28_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_28_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_28_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_29_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_29_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_29_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_29_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_30_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_30_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_30_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_30_3; // @[AecExecPort.scala 68:14]
  reg [15:0] c_31_0; // @[AecExecPort.scala 68:14]
  reg [15:0] c_31_1; // @[AecExecPort.scala 68:14]
  reg [15:0] c_31_2; // @[AecExecPort.scala 68:14]
  reg [15:0] c_31_3; // @[AecExecPort.scala 68:14]
  reg  active_0; // @[AecExecPort.scala 69:19]
  reg  active_1; // @[AecExecPort.scala 69:19]
  reg  active_2; // @[AecExecPort.scala 69:19]
  reg  active_3; // @[AecExecPort.scala 69:19]
  reg  active_4; // @[AecExecPort.scala 69:19]
  reg  active_5; // @[AecExecPort.scala 69:19]
  reg  active_6; // @[AecExecPort.scala 69:19]
  reg  active_7; // @[AecExecPort.scala 69:19]
  reg  active_8; // @[AecExecPort.scala 69:19]
  reg  active_9; // @[AecExecPort.scala 69:19]
  reg  active_10; // @[AecExecPort.scala 69:19]
  reg  active_11; // @[AecExecPort.scala 69:19]
  reg  active_12; // @[AecExecPort.scala 69:19]
  reg  active_13; // @[AecExecPort.scala 69:19]
  reg  active_14; // @[AecExecPort.scala 69:19]
  reg  active_15; // @[AecExecPort.scala 69:19]
  reg  active_16; // @[AecExecPort.scala 69:19]
  reg  active_17; // @[AecExecPort.scala 69:19]
  reg  active_18; // @[AecExecPort.scala 69:19]
  reg  active_19; // @[AecExecPort.scala 69:19]
  reg  active_20; // @[AecExecPort.scala 69:19]
  reg  active_21; // @[AecExecPort.scala 69:19]
  reg  active_22; // @[AecExecPort.scala 69:19]
  reg  active_23; // @[AecExecPort.scala 69:19]
  reg  active_24; // @[AecExecPort.scala 69:19]
  reg  active_25; // @[AecExecPort.scala 69:19]
  reg  active_26; // @[AecExecPort.scala 69:19]
  reg  active_27; // @[AecExecPort.scala 69:19]
  reg  active_28; // @[AecExecPort.scala 69:19]
  reg  active_29; // @[AecExecPort.scala 69:19]
  reg  active_30; // @[AecExecPort.scala 69:19]
  reg  active_31; // @[AecExecPort.scala 69:19]
  reg [7:0] dest; // @[AecExecPort.scala 73:17]
  wire  _GEN_14 = io_arm | operandCapture_0_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_15 = io_arm | operandCapture_0_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_16 = io_arm | operandCapture_0_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_17 = io_arm | operandCapture_0_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_18 = io_arm | operandCapture_0_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_19 = io_arm | operandCapture_0_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_20 = io_arm | operandCapture_0_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_21 = io_arm | operandCapture_0_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_22 = io_arm | operandCapture_0_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_23 = io_arm | operandCapture_0_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_24 = io_arm | operandCapture_0_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_25 = io_arm | operandCapture_0_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_26 = io_arm | maskCapture_0; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_54 = io_arm | operandCapture_1_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_55 = io_arm | operandCapture_1_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_56 = io_arm | operandCapture_1_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_57 = io_arm | operandCapture_1_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_58 = io_arm | operandCapture_1_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_59 = io_arm | operandCapture_1_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_60 = io_arm | operandCapture_1_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_61 = io_arm | operandCapture_1_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_62 = io_arm | operandCapture_1_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_63 = io_arm | operandCapture_1_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_64 = io_arm | operandCapture_1_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_65 = io_arm | operandCapture_1_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_66 = io_arm | maskCapture_1; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_94 = io_arm | operandCapture_2_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_95 = io_arm | operandCapture_2_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_96 = io_arm | operandCapture_2_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_97 = io_arm | operandCapture_2_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_98 = io_arm | operandCapture_2_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_99 = io_arm | operandCapture_2_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_100 = io_arm | operandCapture_2_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_101 = io_arm | operandCapture_2_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_102 = io_arm | operandCapture_2_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_103 = io_arm | operandCapture_2_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_104 = io_arm | operandCapture_2_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_105 = io_arm | operandCapture_2_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_106 = io_arm | maskCapture_2; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_134 = io_arm | operandCapture_3_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_135 = io_arm | operandCapture_3_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_136 = io_arm | operandCapture_3_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_137 = io_arm | operandCapture_3_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_138 = io_arm | operandCapture_3_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_139 = io_arm | operandCapture_3_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_140 = io_arm | operandCapture_3_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_141 = io_arm | operandCapture_3_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_142 = io_arm | operandCapture_3_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_143 = io_arm | operandCapture_3_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_144 = io_arm | operandCapture_3_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_145 = io_arm | operandCapture_3_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_146 = io_arm | maskCapture_3; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_174 = io_arm | operandCapture_4_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_175 = io_arm | operandCapture_4_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_176 = io_arm | operandCapture_4_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_177 = io_arm | operandCapture_4_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_178 = io_arm | operandCapture_4_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_179 = io_arm | operandCapture_4_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_180 = io_arm | operandCapture_4_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_181 = io_arm | operandCapture_4_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_182 = io_arm | operandCapture_4_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_183 = io_arm | operandCapture_4_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_184 = io_arm | operandCapture_4_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_185 = io_arm | operandCapture_4_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_186 = io_arm | maskCapture_4; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_214 = io_arm | operandCapture_5_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_215 = io_arm | operandCapture_5_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_216 = io_arm | operandCapture_5_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_217 = io_arm | operandCapture_5_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_218 = io_arm | operandCapture_5_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_219 = io_arm | operandCapture_5_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_220 = io_arm | operandCapture_5_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_221 = io_arm | operandCapture_5_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_222 = io_arm | operandCapture_5_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_223 = io_arm | operandCapture_5_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_224 = io_arm | operandCapture_5_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_225 = io_arm | operandCapture_5_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_226 = io_arm | maskCapture_5; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_254 = io_arm | operandCapture_6_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_255 = io_arm | operandCapture_6_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_256 = io_arm | operandCapture_6_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_257 = io_arm | operandCapture_6_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_258 = io_arm | operandCapture_6_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_259 = io_arm | operandCapture_6_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_260 = io_arm | operandCapture_6_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_261 = io_arm | operandCapture_6_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_262 = io_arm | operandCapture_6_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_263 = io_arm | operandCapture_6_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_264 = io_arm | operandCapture_6_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_265 = io_arm | operandCapture_6_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_266 = io_arm | maskCapture_6; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_294 = io_arm | operandCapture_7_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_295 = io_arm | operandCapture_7_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_296 = io_arm | operandCapture_7_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_297 = io_arm | operandCapture_7_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_298 = io_arm | operandCapture_7_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_299 = io_arm | operandCapture_7_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_300 = io_arm | operandCapture_7_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_301 = io_arm | operandCapture_7_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_302 = io_arm | operandCapture_7_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_303 = io_arm | operandCapture_7_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_304 = io_arm | operandCapture_7_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_305 = io_arm | operandCapture_7_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_306 = io_arm | maskCapture_7; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_334 = io_arm | operandCapture_8_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_335 = io_arm | operandCapture_8_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_336 = io_arm | operandCapture_8_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_337 = io_arm | operandCapture_8_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_338 = io_arm | operandCapture_8_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_339 = io_arm | operandCapture_8_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_340 = io_arm | operandCapture_8_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_341 = io_arm | operandCapture_8_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_342 = io_arm | operandCapture_8_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_343 = io_arm | operandCapture_8_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_344 = io_arm | operandCapture_8_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_345 = io_arm | operandCapture_8_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_346 = io_arm | maskCapture_8; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_374 = io_arm | operandCapture_9_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_375 = io_arm | operandCapture_9_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_376 = io_arm | operandCapture_9_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_377 = io_arm | operandCapture_9_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_378 = io_arm | operandCapture_9_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_379 = io_arm | operandCapture_9_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_380 = io_arm | operandCapture_9_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_381 = io_arm | operandCapture_9_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_382 = io_arm | operandCapture_9_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_383 = io_arm | operandCapture_9_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_384 = io_arm | operandCapture_9_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_385 = io_arm | operandCapture_9_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_386 = io_arm | maskCapture_9; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_414 = io_arm | operandCapture_10_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_415 = io_arm | operandCapture_10_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_416 = io_arm | operandCapture_10_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_417 = io_arm | operandCapture_10_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_418 = io_arm | operandCapture_10_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_419 = io_arm | operandCapture_10_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_420 = io_arm | operandCapture_10_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_421 = io_arm | operandCapture_10_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_422 = io_arm | operandCapture_10_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_423 = io_arm | operandCapture_10_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_424 = io_arm | operandCapture_10_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_425 = io_arm | operandCapture_10_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_426 = io_arm | maskCapture_10; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_454 = io_arm | operandCapture_11_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_455 = io_arm | operandCapture_11_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_456 = io_arm | operandCapture_11_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_457 = io_arm | operandCapture_11_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_458 = io_arm | operandCapture_11_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_459 = io_arm | operandCapture_11_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_460 = io_arm | operandCapture_11_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_461 = io_arm | operandCapture_11_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_462 = io_arm | operandCapture_11_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_463 = io_arm | operandCapture_11_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_464 = io_arm | operandCapture_11_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_465 = io_arm | operandCapture_11_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_466 = io_arm | maskCapture_11; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_494 = io_arm | operandCapture_12_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_495 = io_arm | operandCapture_12_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_496 = io_arm | operandCapture_12_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_497 = io_arm | operandCapture_12_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_498 = io_arm | operandCapture_12_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_499 = io_arm | operandCapture_12_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_500 = io_arm | operandCapture_12_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_501 = io_arm | operandCapture_12_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_502 = io_arm | operandCapture_12_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_503 = io_arm | operandCapture_12_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_504 = io_arm | operandCapture_12_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_505 = io_arm | operandCapture_12_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_506 = io_arm | maskCapture_12; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_534 = io_arm | operandCapture_13_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_535 = io_arm | operandCapture_13_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_536 = io_arm | operandCapture_13_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_537 = io_arm | operandCapture_13_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_538 = io_arm | operandCapture_13_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_539 = io_arm | operandCapture_13_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_540 = io_arm | operandCapture_13_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_541 = io_arm | operandCapture_13_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_542 = io_arm | operandCapture_13_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_543 = io_arm | operandCapture_13_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_544 = io_arm | operandCapture_13_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_545 = io_arm | operandCapture_13_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_546 = io_arm | maskCapture_13; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_574 = io_arm | operandCapture_14_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_575 = io_arm | operandCapture_14_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_576 = io_arm | operandCapture_14_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_577 = io_arm | operandCapture_14_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_578 = io_arm | operandCapture_14_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_579 = io_arm | operandCapture_14_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_580 = io_arm | operandCapture_14_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_581 = io_arm | operandCapture_14_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_582 = io_arm | operandCapture_14_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_583 = io_arm | operandCapture_14_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_584 = io_arm | operandCapture_14_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_585 = io_arm | operandCapture_14_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_586 = io_arm | maskCapture_14; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_614 = io_arm | operandCapture_15_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_615 = io_arm | operandCapture_15_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_616 = io_arm | operandCapture_15_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_617 = io_arm | operandCapture_15_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_618 = io_arm | operandCapture_15_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_619 = io_arm | operandCapture_15_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_620 = io_arm | operandCapture_15_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_621 = io_arm | operandCapture_15_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_622 = io_arm | operandCapture_15_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_623 = io_arm | operandCapture_15_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_624 = io_arm | operandCapture_15_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_625 = io_arm | operandCapture_15_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_626 = io_arm | maskCapture_15; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_654 = io_arm | operandCapture_16_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_655 = io_arm | operandCapture_16_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_656 = io_arm | operandCapture_16_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_657 = io_arm | operandCapture_16_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_658 = io_arm | operandCapture_16_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_659 = io_arm | operandCapture_16_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_660 = io_arm | operandCapture_16_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_661 = io_arm | operandCapture_16_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_662 = io_arm | operandCapture_16_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_663 = io_arm | operandCapture_16_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_664 = io_arm | operandCapture_16_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_665 = io_arm | operandCapture_16_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_666 = io_arm | maskCapture_16; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_694 = io_arm | operandCapture_17_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_695 = io_arm | operandCapture_17_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_696 = io_arm | operandCapture_17_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_697 = io_arm | operandCapture_17_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_698 = io_arm | operandCapture_17_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_699 = io_arm | operandCapture_17_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_700 = io_arm | operandCapture_17_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_701 = io_arm | operandCapture_17_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_702 = io_arm | operandCapture_17_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_703 = io_arm | operandCapture_17_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_704 = io_arm | operandCapture_17_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_705 = io_arm | operandCapture_17_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_706 = io_arm | maskCapture_17; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_734 = io_arm | operandCapture_18_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_735 = io_arm | operandCapture_18_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_736 = io_arm | operandCapture_18_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_737 = io_arm | operandCapture_18_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_738 = io_arm | operandCapture_18_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_739 = io_arm | operandCapture_18_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_740 = io_arm | operandCapture_18_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_741 = io_arm | operandCapture_18_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_742 = io_arm | operandCapture_18_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_743 = io_arm | operandCapture_18_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_744 = io_arm | operandCapture_18_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_745 = io_arm | operandCapture_18_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_746 = io_arm | maskCapture_18; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_774 = io_arm | operandCapture_19_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_775 = io_arm | operandCapture_19_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_776 = io_arm | operandCapture_19_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_777 = io_arm | operandCapture_19_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_778 = io_arm | operandCapture_19_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_779 = io_arm | operandCapture_19_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_780 = io_arm | operandCapture_19_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_781 = io_arm | operandCapture_19_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_782 = io_arm | operandCapture_19_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_783 = io_arm | operandCapture_19_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_784 = io_arm | operandCapture_19_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_785 = io_arm | operandCapture_19_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_786 = io_arm | maskCapture_19; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_814 = io_arm | operandCapture_20_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_815 = io_arm | operandCapture_20_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_816 = io_arm | operandCapture_20_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_817 = io_arm | operandCapture_20_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_818 = io_arm | operandCapture_20_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_819 = io_arm | operandCapture_20_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_820 = io_arm | operandCapture_20_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_821 = io_arm | operandCapture_20_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_822 = io_arm | operandCapture_20_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_823 = io_arm | operandCapture_20_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_824 = io_arm | operandCapture_20_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_825 = io_arm | operandCapture_20_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_826 = io_arm | maskCapture_20; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_854 = io_arm | operandCapture_21_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_855 = io_arm | operandCapture_21_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_856 = io_arm | operandCapture_21_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_857 = io_arm | operandCapture_21_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_858 = io_arm | operandCapture_21_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_859 = io_arm | operandCapture_21_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_860 = io_arm | operandCapture_21_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_861 = io_arm | operandCapture_21_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_862 = io_arm | operandCapture_21_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_863 = io_arm | operandCapture_21_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_864 = io_arm | operandCapture_21_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_865 = io_arm | operandCapture_21_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_866 = io_arm | maskCapture_21; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_894 = io_arm | operandCapture_22_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_895 = io_arm | operandCapture_22_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_896 = io_arm | operandCapture_22_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_897 = io_arm | operandCapture_22_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_898 = io_arm | operandCapture_22_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_899 = io_arm | operandCapture_22_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_900 = io_arm | operandCapture_22_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_901 = io_arm | operandCapture_22_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_902 = io_arm | operandCapture_22_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_903 = io_arm | operandCapture_22_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_904 = io_arm | operandCapture_22_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_905 = io_arm | operandCapture_22_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_906 = io_arm | maskCapture_22; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_934 = io_arm | operandCapture_23_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_935 = io_arm | operandCapture_23_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_936 = io_arm | operandCapture_23_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_937 = io_arm | operandCapture_23_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_938 = io_arm | operandCapture_23_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_939 = io_arm | operandCapture_23_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_940 = io_arm | operandCapture_23_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_941 = io_arm | operandCapture_23_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_942 = io_arm | operandCapture_23_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_943 = io_arm | operandCapture_23_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_944 = io_arm | operandCapture_23_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_945 = io_arm | operandCapture_23_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_946 = io_arm | maskCapture_23; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_974 = io_arm | operandCapture_24_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_975 = io_arm | operandCapture_24_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_976 = io_arm | operandCapture_24_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_977 = io_arm | operandCapture_24_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_978 = io_arm | operandCapture_24_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_979 = io_arm | operandCapture_24_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_980 = io_arm | operandCapture_24_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_981 = io_arm | operandCapture_24_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_982 = io_arm | operandCapture_24_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_983 = io_arm | operandCapture_24_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_984 = io_arm | operandCapture_24_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_985 = io_arm | operandCapture_24_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_986 = io_arm | maskCapture_24; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1014 = io_arm | operandCapture_25_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1015 = io_arm | operandCapture_25_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1016 = io_arm | operandCapture_25_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1017 = io_arm | operandCapture_25_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1018 = io_arm | operandCapture_25_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1019 = io_arm | operandCapture_25_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1020 = io_arm | operandCapture_25_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1021 = io_arm | operandCapture_25_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1022 = io_arm | operandCapture_25_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1023 = io_arm | operandCapture_25_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1024 = io_arm | operandCapture_25_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1025 = io_arm | operandCapture_25_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1026 = io_arm | maskCapture_25; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1054 = io_arm | operandCapture_26_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1055 = io_arm | operandCapture_26_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1056 = io_arm | operandCapture_26_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1057 = io_arm | operandCapture_26_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1058 = io_arm | operandCapture_26_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1059 = io_arm | operandCapture_26_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1060 = io_arm | operandCapture_26_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1061 = io_arm | operandCapture_26_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1062 = io_arm | operandCapture_26_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1063 = io_arm | operandCapture_26_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1064 = io_arm | operandCapture_26_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1065 = io_arm | operandCapture_26_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1066 = io_arm | maskCapture_26; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1094 = io_arm | operandCapture_27_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1095 = io_arm | operandCapture_27_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1096 = io_arm | operandCapture_27_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1097 = io_arm | operandCapture_27_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1098 = io_arm | operandCapture_27_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1099 = io_arm | operandCapture_27_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1100 = io_arm | operandCapture_27_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1101 = io_arm | operandCapture_27_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1102 = io_arm | operandCapture_27_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1103 = io_arm | operandCapture_27_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1104 = io_arm | operandCapture_27_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1105 = io_arm | operandCapture_27_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1106 = io_arm | maskCapture_27; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1134 = io_arm | operandCapture_28_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1135 = io_arm | operandCapture_28_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1136 = io_arm | operandCapture_28_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1137 = io_arm | operandCapture_28_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1138 = io_arm | operandCapture_28_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1139 = io_arm | operandCapture_28_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1140 = io_arm | operandCapture_28_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1141 = io_arm | operandCapture_28_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1142 = io_arm | operandCapture_28_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1143 = io_arm | operandCapture_28_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1144 = io_arm | operandCapture_28_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1145 = io_arm | operandCapture_28_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1146 = io_arm | maskCapture_28; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1174 = io_arm | operandCapture_29_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1175 = io_arm | operandCapture_29_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1176 = io_arm | operandCapture_29_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1177 = io_arm | operandCapture_29_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1178 = io_arm | operandCapture_29_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1179 = io_arm | operandCapture_29_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1180 = io_arm | operandCapture_29_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1181 = io_arm | operandCapture_29_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1182 = io_arm | operandCapture_29_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1183 = io_arm | operandCapture_29_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1184 = io_arm | operandCapture_29_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1185 = io_arm | operandCapture_29_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1186 = io_arm | maskCapture_29; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1214 = io_arm | operandCapture_30_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1215 = io_arm | operandCapture_30_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1216 = io_arm | operandCapture_30_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1217 = io_arm | operandCapture_30_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1218 = io_arm | operandCapture_30_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1219 = io_arm | operandCapture_30_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1220 = io_arm | operandCapture_30_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1221 = io_arm | operandCapture_30_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1222 = io_arm | operandCapture_30_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1223 = io_arm | operandCapture_30_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1224 = io_arm | operandCapture_30_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1225 = io_arm | operandCapture_30_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1226 = io_arm | maskCapture_30; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire  _GEN_1254 = io_arm | operandCapture_31_0; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1255 = io_arm | operandCapture_31_1; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1256 = io_arm | operandCapture_31_2; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1257 = io_arm | operandCapture_31_3; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1258 = io_arm | operandCapture_31_4; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1259 = io_arm | operandCapture_31_5; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1260 = io_arm | operandCapture_31_6; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1261 = io_arm | operandCapture_31_7; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1262 = io_arm | operandCapture_31_8; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1263 = io_arm | operandCapture_31_9; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1264 = io_arm | operandCapture_31_10; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1265 = io_arm | operandCapture_31_11; // @[AecExecPort.scala 88:19 89:25 62:31]
  wire  _GEN_1266 = io_arm | maskCapture_31; // @[AecExecPort.scala 88:19 90:22 64:28]
  wire [31:0] io_out_a_0_lo = {a_0_1,a_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_0_hi = {a_0_3,a_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_0_lo = {b_0_1,b_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_0_hi = {b_0_3,b_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_0_lo = {c_0_1,c_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_0_hi = {c_0_3,c_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_1_lo = {a_1_1,a_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_1_hi = {a_1_3,a_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_1_lo = {b_1_1,b_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_1_hi = {b_1_3,b_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_1_lo = {c_1_1,c_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_1_hi = {c_1_3,c_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_2_lo = {a_2_1,a_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_2_hi = {a_2_3,a_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_2_lo = {b_2_1,b_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_2_hi = {b_2_3,b_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_2_lo = {c_2_1,c_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_2_hi = {c_2_3,c_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_3_lo = {a_3_1,a_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_3_hi = {a_3_3,a_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_3_lo = {b_3_1,b_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_3_hi = {b_3_3,b_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_3_lo = {c_3_1,c_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_3_hi = {c_3_3,c_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_4_lo = {a_4_1,a_4_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_4_hi = {a_4_3,a_4_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_4_lo = {b_4_1,b_4_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_4_hi = {b_4_3,b_4_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_4_lo = {c_4_1,c_4_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_4_hi = {c_4_3,c_4_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_5_lo = {a_5_1,a_5_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_5_hi = {a_5_3,a_5_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_5_lo = {b_5_1,b_5_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_5_hi = {b_5_3,b_5_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_5_lo = {c_5_1,c_5_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_5_hi = {c_5_3,c_5_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_6_lo = {a_6_1,a_6_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_6_hi = {a_6_3,a_6_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_6_lo = {b_6_1,b_6_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_6_hi = {b_6_3,b_6_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_6_lo = {c_6_1,c_6_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_6_hi = {c_6_3,c_6_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_7_lo = {a_7_1,a_7_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_7_hi = {a_7_3,a_7_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_7_lo = {b_7_1,b_7_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_7_hi = {b_7_3,b_7_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_7_lo = {c_7_1,c_7_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_7_hi = {c_7_3,c_7_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_8_lo = {a_8_1,a_8_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_8_hi = {a_8_3,a_8_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_8_lo = {b_8_1,b_8_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_8_hi = {b_8_3,b_8_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_8_lo = {c_8_1,c_8_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_8_hi = {c_8_3,c_8_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_9_lo = {a_9_1,a_9_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_9_hi = {a_9_3,a_9_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_9_lo = {b_9_1,b_9_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_9_hi = {b_9_3,b_9_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_9_lo = {c_9_1,c_9_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_9_hi = {c_9_3,c_9_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_10_lo = {a_10_1,a_10_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_10_hi = {a_10_3,a_10_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_10_lo = {b_10_1,b_10_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_10_hi = {b_10_3,b_10_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_10_lo = {c_10_1,c_10_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_10_hi = {c_10_3,c_10_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_11_lo = {a_11_1,a_11_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_11_hi = {a_11_3,a_11_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_11_lo = {b_11_1,b_11_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_11_hi = {b_11_3,b_11_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_11_lo = {c_11_1,c_11_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_11_hi = {c_11_3,c_11_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_12_lo = {a_12_1,a_12_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_12_hi = {a_12_3,a_12_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_12_lo = {b_12_1,b_12_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_12_hi = {b_12_3,b_12_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_12_lo = {c_12_1,c_12_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_12_hi = {c_12_3,c_12_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_13_lo = {a_13_1,a_13_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_13_hi = {a_13_3,a_13_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_13_lo = {b_13_1,b_13_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_13_hi = {b_13_3,b_13_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_13_lo = {c_13_1,c_13_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_13_hi = {c_13_3,c_13_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_14_lo = {a_14_1,a_14_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_14_hi = {a_14_3,a_14_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_14_lo = {b_14_1,b_14_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_14_hi = {b_14_3,b_14_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_14_lo = {c_14_1,c_14_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_14_hi = {c_14_3,c_14_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_15_lo = {a_15_1,a_15_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_15_hi = {a_15_3,a_15_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_15_lo = {b_15_1,b_15_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_15_hi = {b_15_3,b_15_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_15_lo = {c_15_1,c_15_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_15_hi = {c_15_3,c_15_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_16_lo = {a_16_1,a_16_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_16_hi = {a_16_3,a_16_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_16_lo = {b_16_1,b_16_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_16_hi = {b_16_3,b_16_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_16_lo = {c_16_1,c_16_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_16_hi = {c_16_3,c_16_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_17_lo = {a_17_1,a_17_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_17_hi = {a_17_3,a_17_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_17_lo = {b_17_1,b_17_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_17_hi = {b_17_3,b_17_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_17_lo = {c_17_1,c_17_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_17_hi = {c_17_3,c_17_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_18_lo = {a_18_1,a_18_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_18_hi = {a_18_3,a_18_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_18_lo = {b_18_1,b_18_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_18_hi = {b_18_3,b_18_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_18_lo = {c_18_1,c_18_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_18_hi = {c_18_3,c_18_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_19_lo = {a_19_1,a_19_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_19_hi = {a_19_3,a_19_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_19_lo = {b_19_1,b_19_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_19_hi = {b_19_3,b_19_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_19_lo = {c_19_1,c_19_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_19_hi = {c_19_3,c_19_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_20_lo = {a_20_1,a_20_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_20_hi = {a_20_3,a_20_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_20_lo = {b_20_1,b_20_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_20_hi = {b_20_3,b_20_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_20_lo = {c_20_1,c_20_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_20_hi = {c_20_3,c_20_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_21_lo = {a_21_1,a_21_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_21_hi = {a_21_3,a_21_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_21_lo = {b_21_1,b_21_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_21_hi = {b_21_3,b_21_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_21_lo = {c_21_1,c_21_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_21_hi = {c_21_3,c_21_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_22_lo = {a_22_1,a_22_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_22_hi = {a_22_3,a_22_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_22_lo = {b_22_1,b_22_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_22_hi = {b_22_3,b_22_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_22_lo = {c_22_1,c_22_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_22_hi = {c_22_3,c_22_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_23_lo = {a_23_1,a_23_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_23_hi = {a_23_3,a_23_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_23_lo = {b_23_1,b_23_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_23_hi = {b_23_3,b_23_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_23_lo = {c_23_1,c_23_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_23_hi = {c_23_3,c_23_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_24_lo = {a_24_1,a_24_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_24_hi = {a_24_3,a_24_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_24_lo = {b_24_1,b_24_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_24_hi = {b_24_3,b_24_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_24_lo = {c_24_1,c_24_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_24_hi = {c_24_3,c_24_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_25_lo = {a_25_1,a_25_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_25_hi = {a_25_3,a_25_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_25_lo = {b_25_1,b_25_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_25_hi = {b_25_3,b_25_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_25_lo = {c_25_1,c_25_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_25_hi = {c_25_3,c_25_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_26_lo = {a_26_1,a_26_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_26_hi = {a_26_3,a_26_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_26_lo = {b_26_1,b_26_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_26_hi = {b_26_3,b_26_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_26_lo = {c_26_1,c_26_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_26_hi = {c_26_3,c_26_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_27_lo = {a_27_1,a_27_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_27_hi = {a_27_3,a_27_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_27_lo = {b_27_1,b_27_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_27_hi = {b_27_3,b_27_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_27_lo = {c_27_1,c_27_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_27_hi = {c_27_3,c_27_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_28_lo = {a_28_1,a_28_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_28_hi = {a_28_3,a_28_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_28_lo = {b_28_1,b_28_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_28_hi = {b_28_3,b_28_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_28_lo = {c_28_1,c_28_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_28_hi = {c_28_3,c_28_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_29_lo = {a_29_1,a_29_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_29_hi = {a_29_3,a_29_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_29_lo = {b_29_1,b_29_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_29_hi = {b_29_3,b_29_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_29_lo = {c_29_1,c_29_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_29_hi = {c_29_3,c_29_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_30_lo = {a_30_1,a_30_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_30_hi = {a_30_3,a_30_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_30_lo = {b_30_1,b_30_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_30_hi = {b_30_3,b_30_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_30_lo = {c_30_1,c_30_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_30_hi = {c_30_3,c_30_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_31_lo = {a_31_1,a_31_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_a_31_hi = {a_31_3,a_31_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_31_lo = {b_31_1,b_31_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_b_31_hi = {b_31_3,b_31_2}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_31_lo = {c_31_1,c_31_0}; // @[Cat.scala 33:92]
  wire [31:0] io_out_c_31_hi = {c_31_3,c_31_2}; // @[Cat.scala 33:92]
  wire [7:0] io_out_activeMask_lo_lo = {active_7,active_6,active_5,active_4,active_3,active_2,active_1,active_0}; // @[Cat.scala 33:92]
  wire [15:0] io_out_activeMask_lo = {active_15,active_14,active_13,active_12,active_11,active_10,active_9,active_8,
    io_out_activeMask_lo_lo}; // @[Cat.scala 33:92]
  wire [7:0] io_out_activeMask_hi_lo = {active_23,active_22,active_21,active_20,active_19,active_18,active_17,active_16}
    ; // @[Cat.scala 33:92]
  wire [15:0] io_out_activeMask_hi = {active_31,active_30,active_29,active_28,active_27,active_26,active_25,active_24,
    io_out_activeMask_hi_lo}; // @[Cat.scala 33:92]
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
  assign io_out_c_0 = {io_out_c_0_hi,io_out_c_0_lo}; // @[Cat.scala 33:92]
  assign io_out_c_1 = {io_out_c_1_hi,io_out_c_1_lo}; // @[Cat.scala 33:92]
  assign io_out_c_2 = {io_out_c_2_hi,io_out_c_2_lo}; // @[Cat.scala 33:92]
  assign io_out_c_3 = {io_out_c_3_hi,io_out_c_3_lo}; // @[Cat.scala 33:92]
  assign io_out_c_4 = {io_out_c_4_hi,io_out_c_4_lo}; // @[Cat.scala 33:92]
  assign io_out_c_5 = {io_out_c_5_hi,io_out_c_5_lo}; // @[Cat.scala 33:92]
  assign io_out_c_6 = {io_out_c_6_hi,io_out_c_6_lo}; // @[Cat.scala 33:92]
  assign io_out_c_7 = {io_out_c_7_hi,io_out_c_7_lo}; // @[Cat.scala 33:92]
  assign io_out_c_8 = {io_out_c_8_hi,io_out_c_8_lo}; // @[Cat.scala 33:92]
  assign io_out_c_9 = {io_out_c_9_hi,io_out_c_9_lo}; // @[Cat.scala 33:92]
  assign io_out_c_10 = {io_out_c_10_hi,io_out_c_10_lo}; // @[Cat.scala 33:92]
  assign io_out_c_11 = {io_out_c_11_hi,io_out_c_11_lo}; // @[Cat.scala 33:92]
  assign io_out_c_12 = {io_out_c_12_hi,io_out_c_12_lo}; // @[Cat.scala 33:92]
  assign io_out_c_13 = {io_out_c_13_hi,io_out_c_13_lo}; // @[Cat.scala 33:92]
  assign io_out_c_14 = {io_out_c_14_hi,io_out_c_14_lo}; // @[Cat.scala 33:92]
  assign io_out_c_15 = {io_out_c_15_hi,io_out_c_15_lo}; // @[Cat.scala 33:92]
  assign io_out_c_16 = {io_out_c_16_hi,io_out_c_16_lo}; // @[Cat.scala 33:92]
  assign io_out_c_17 = {io_out_c_17_hi,io_out_c_17_lo}; // @[Cat.scala 33:92]
  assign io_out_c_18 = {io_out_c_18_hi,io_out_c_18_lo}; // @[Cat.scala 33:92]
  assign io_out_c_19 = {io_out_c_19_hi,io_out_c_19_lo}; // @[Cat.scala 33:92]
  assign io_out_c_20 = {io_out_c_20_hi,io_out_c_20_lo}; // @[Cat.scala 33:92]
  assign io_out_c_21 = {io_out_c_21_hi,io_out_c_21_lo}; // @[Cat.scala 33:92]
  assign io_out_c_22 = {io_out_c_22_hi,io_out_c_22_lo}; // @[Cat.scala 33:92]
  assign io_out_c_23 = {io_out_c_23_hi,io_out_c_23_lo}; // @[Cat.scala 33:92]
  assign io_out_c_24 = {io_out_c_24_hi,io_out_c_24_lo}; // @[Cat.scala 33:92]
  assign io_out_c_25 = {io_out_c_25_hi,io_out_c_25_lo}; // @[Cat.scala 33:92]
  assign io_out_c_26 = {io_out_c_26_hi,io_out_c_26_lo}; // @[Cat.scala 33:92]
  assign io_out_c_27 = {io_out_c_27_hi,io_out_c_27_lo}; // @[Cat.scala 33:92]
  assign io_out_c_28 = {io_out_c_28_hi,io_out_c_28_lo}; // @[Cat.scala 33:92]
  assign io_out_c_29 = {io_out_c_29_hi,io_out_c_29_lo}; // @[Cat.scala 33:92]
  assign io_out_c_30 = {io_out_c_30_hi,io_out_c_30_lo}; // @[Cat.scala 33:92]
  assign io_out_c_31 = {io_out_c_31_hi,io_out_c_31_lo}; // @[Cat.scala 33:92]
  assign io_out_dest = dest; // @[AecExecPort.scala 106:15]
  always @(posedge clock) begin
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_0 <= _GEN_14;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_1 <= _GEN_15;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_2 <= _GEN_16;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_3 <= _GEN_17;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_4 <= _GEN_18;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_5 <= _GEN_19;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_6 <= _GEN_20;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_7 <= _GEN_21;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_8 <= _GEN_22;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_9 <= _GEN_23;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_10 <= _GEN_24;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_0_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_0_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_0_11 <= _GEN_25;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_0 <= _GEN_54;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_1 <= _GEN_55;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_2 <= _GEN_56;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_3 <= _GEN_57;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_4 <= _GEN_58;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_5 <= _GEN_59;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_6 <= _GEN_60;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_7 <= _GEN_61;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_8 <= _GEN_62;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_9 <= _GEN_63;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_10 <= _GEN_64;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_1_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_1_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_1_11 <= _GEN_65;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_0 <= _GEN_94;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_1 <= _GEN_95;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_2 <= _GEN_96;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_3 <= _GEN_97;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_4 <= _GEN_98;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_5 <= _GEN_99;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_6 <= _GEN_100;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_7 <= _GEN_101;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_8 <= _GEN_102;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_9 <= _GEN_103;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_10 <= _GEN_104;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_2_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_2_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_2_11 <= _GEN_105;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_0 <= _GEN_134;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_1 <= _GEN_135;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_2 <= _GEN_136;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_3 <= _GEN_137;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_4 <= _GEN_138;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_5 <= _GEN_139;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_6 <= _GEN_140;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_7 <= _GEN_141;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_8 <= _GEN_142;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_9 <= _GEN_143;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_10 <= _GEN_144;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_3_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_3_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_3_11 <= _GEN_145;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_0 <= _GEN_174;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_1 <= _GEN_175;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_2 <= _GEN_176;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_3 <= _GEN_177;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_4 <= _GEN_178;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_5 <= _GEN_179;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_6 <= _GEN_180;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_7 <= _GEN_181;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_8 <= _GEN_182;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_9 <= _GEN_183;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_10 <= _GEN_184;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_4_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_4_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_4_11 <= _GEN_185;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_0 <= _GEN_214;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_1 <= _GEN_215;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_2 <= _GEN_216;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_3 <= _GEN_217;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_4 <= _GEN_218;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_5 <= _GEN_219;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_6 <= _GEN_220;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_7 <= _GEN_221;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_8 <= _GEN_222;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_9 <= _GEN_223;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_10 <= _GEN_224;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_5_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_5_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_5_11 <= _GEN_225;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_0 <= _GEN_254;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_1 <= _GEN_255;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_2 <= _GEN_256;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_3 <= _GEN_257;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_4 <= _GEN_258;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_5 <= _GEN_259;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_6 <= _GEN_260;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_7 <= _GEN_261;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_8 <= _GEN_262;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_9 <= _GEN_263;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_10 <= _GEN_264;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_6_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_6_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_6_11 <= _GEN_265;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_0 <= _GEN_294;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_1 <= _GEN_295;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_2 <= _GEN_296;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_3 <= _GEN_297;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_4 <= _GEN_298;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_5 <= _GEN_299;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_6 <= _GEN_300;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_7 <= _GEN_301;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_8 <= _GEN_302;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_9 <= _GEN_303;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_10 <= _GEN_304;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_7_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_7_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_7_11 <= _GEN_305;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_0 <= _GEN_334;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_1 <= _GEN_335;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_2 <= _GEN_336;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_3 <= _GEN_337;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_4 <= _GEN_338;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_5 <= _GEN_339;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_6 <= _GEN_340;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_7 <= _GEN_341;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_8 <= _GEN_342;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_9 <= _GEN_343;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_10 <= _GEN_344;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_8_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_8_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_8_11 <= _GEN_345;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_0 <= _GEN_374;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_1 <= _GEN_375;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_2 <= _GEN_376;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_3 <= _GEN_377;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_4 <= _GEN_378;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_5 <= _GEN_379;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_6 <= _GEN_380;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_7 <= _GEN_381;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_8 <= _GEN_382;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_9 <= _GEN_383;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_10 <= _GEN_384;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_9_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_9_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_9_11 <= _GEN_385;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_0 <= _GEN_414;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_1 <= _GEN_415;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_2 <= _GEN_416;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_3 <= _GEN_417;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_4 <= _GEN_418;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_5 <= _GEN_419;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_6 <= _GEN_420;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_7 <= _GEN_421;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_8 <= _GEN_422;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_9 <= _GEN_423;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_10 <= _GEN_424;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_10_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_10_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_10_11 <= _GEN_425;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_0 <= _GEN_454;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_1 <= _GEN_455;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_2 <= _GEN_456;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_3 <= _GEN_457;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_4 <= _GEN_458;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_5 <= _GEN_459;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_6 <= _GEN_460;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_7 <= _GEN_461;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_8 <= _GEN_462;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_9 <= _GEN_463;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_10 <= _GEN_464;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_11_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_11_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_11_11 <= _GEN_465;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_0 <= _GEN_494;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_1 <= _GEN_495;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_2 <= _GEN_496;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_3 <= _GEN_497;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_4 <= _GEN_498;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_5 <= _GEN_499;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_6 <= _GEN_500;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_7 <= _GEN_501;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_8 <= _GEN_502;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_9 <= _GEN_503;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_10 <= _GEN_504;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_12_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_12_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_12_11 <= _GEN_505;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_0 <= _GEN_534;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_1 <= _GEN_535;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_2 <= _GEN_536;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_3 <= _GEN_537;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_4 <= _GEN_538;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_5 <= _GEN_539;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_6 <= _GEN_540;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_7 <= _GEN_541;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_8 <= _GEN_542;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_9 <= _GEN_543;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_10 <= _GEN_544;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_13_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_13_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_13_11 <= _GEN_545;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_0 <= _GEN_574;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_1 <= _GEN_575;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_2 <= _GEN_576;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_3 <= _GEN_577;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_4 <= _GEN_578;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_5 <= _GEN_579;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_6 <= _GEN_580;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_7 <= _GEN_581;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_8 <= _GEN_582;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_9 <= _GEN_583;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_10 <= _GEN_584;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_14_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_14_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_14_11 <= _GEN_585;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_0 <= _GEN_614;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_1 <= _GEN_615;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_2 <= _GEN_616;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_3 <= _GEN_617;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_4 <= _GEN_618;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_5 <= _GEN_619;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_6 <= _GEN_620;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_7 <= _GEN_621;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_8 <= _GEN_622;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_9 <= _GEN_623;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_10 <= _GEN_624;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_15_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_15_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_15_11 <= _GEN_625;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_0 <= _GEN_654;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_1 <= _GEN_655;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_2 <= _GEN_656;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_3 <= _GEN_657;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_4 <= _GEN_658;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_5 <= _GEN_659;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_6 <= _GEN_660;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_7 <= _GEN_661;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_8 <= _GEN_662;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_9 <= _GEN_663;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_10 <= _GEN_664;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_16_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_16_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_16_11 <= _GEN_665;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_0 <= _GEN_694;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_1 <= _GEN_695;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_2 <= _GEN_696;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_3 <= _GEN_697;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_4 <= _GEN_698;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_5 <= _GEN_699;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_6 <= _GEN_700;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_7 <= _GEN_701;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_8 <= _GEN_702;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_9 <= _GEN_703;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_10 <= _GEN_704;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_17_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_17_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_17_11 <= _GEN_705;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_0 <= _GEN_734;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_1 <= _GEN_735;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_2 <= _GEN_736;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_3 <= _GEN_737;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_4 <= _GEN_738;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_5 <= _GEN_739;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_6 <= _GEN_740;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_7 <= _GEN_741;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_8 <= _GEN_742;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_9 <= _GEN_743;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_10 <= _GEN_744;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_18_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_18_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_18_11 <= _GEN_745;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_0 <= _GEN_774;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_1 <= _GEN_775;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_2 <= _GEN_776;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_3 <= _GEN_777;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_4 <= _GEN_778;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_5 <= _GEN_779;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_6 <= _GEN_780;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_7 <= _GEN_781;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_8 <= _GEN_782;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_9 <= _GEN_783;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_10 <= _GEN_784;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_19_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_19_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_19_11 <= _GEN_785;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_0 <= _GEN_814;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_1 <= _GEN_815;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_2 <= _GEN_816;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_3 <= _GEN_817;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_4 <= _GEN_818;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_5 <= _GEN_819;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_6 <= _GEN_820;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_7 <= _GEN_821;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_8 <= _GEN_822;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_9 <= _GEN_823;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_10 <= _GEN_824;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_20_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_20_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_20_11 <= _GEN_825;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_0 <= _GEN_854;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_1 <= _GEN_855;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_2 <= _GEN_856;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_3 <= _GEN_857;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_4 <= _GEN_858;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_5 <= _GEN_859;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_6 <= _GEN_860;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_7 <= _GEN_861;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_8 <= _GEN_862;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_9 <= _GEN_863;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_10 <= _GEN_864;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_21_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_21_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_21_11 <= _GEN_865;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_0 <= _GEN_894;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_1 <= _GEN_895;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_2 <= _GEN_896;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_3 <= _GEN_897;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_4 <= _GEN_898;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_5 <= _GEN_899;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_6 <= _GEN_900;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_7 <= _GEN_901;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_8 <= _GEN_902;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_9 <= _GEN_903;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_10 <= _GEN_904;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_22_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_22_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_22_11 <= _GEN_905;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_0 <= _GEN_934;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_1 <= _GEN_935;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_2 <= _GEN_936;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_3 <= _GEN_937;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_4 <= _GEN_938;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_5 <= _GEN_939;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_6 <= _GEN_940;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_7 <= _GEN_941;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_8 <= _GEN_942;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_9 <= _GEN_943;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_10 <= _GEN_944;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_23_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_23_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_23_11 <= _GEN_945;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_0 <= _GEN_974;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_1 <= _GEN_975;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_2 <= _GEN_976;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_3 <= _GEN_977;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_4 <= _GEN_978;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_5 <= _GEN_979;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_6 <= _GEN_980;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_7 <= _GEN_981;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_8 <= _GEN_982;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_9 <= _GEN_983;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_10 <= _GEN_984;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_24_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_24_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_24_11 <= _GEN_985;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_0 <= _GEN_1014;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_1 <= _GEN_1015;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_2 <= _GEN_1016;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_3 <= _GEN_1017;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_4 <= _GEN_1018;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_5 <= _GEN_1019;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_6 <= _GEN_1020;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_7 <= _GEN_1021;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_8 <= _GEN_1022;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_9 <= _GEN_1023;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_10 <= _GEN_1024;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_25_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_25_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_25_11 <= _GEN_1025;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_0 <= _GEN_1054;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_1 <= _GEN_1055;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_2 <= _GEN_1056;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_3 <= _GEN_1057;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_4 <= _GEN_1058;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_5 <= _GEN_1059;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_6 <= _GEN_1060;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_7 <= _GEN_1061;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_8 <= _GEN_1062;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_9 <= _GEN_1063;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_10 <= _GEN_1064;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_26_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_26_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_26_11 <= _GEN_1065;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_0 <= _GEN_1094;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_1 <= _GEN_1095;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_2 <= _GEN_1096;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_3 <= _GEN_1097;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_4 <= _GEN_1098;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_5 <= _GEN_1099;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_6 <= _GEN_1100;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_7 <= _GEN_1101;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_8 <= _GEN_1102;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_9 <= _GEN_1103;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_10 <= _GEN_1104;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_27_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_27_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_27_11 <= _GEN_1105;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_0 <= _GEN_1134;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_1 <= _GEN_1135;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_2 <= _GEN_1136;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_3 <= _GEN_1137;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_4 <= _GEN_1138;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_5 <= _GEN_1139;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_6 <= _GEN_1140;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_7 <= _GEN_1141;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_8 <= _GEN_1142;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_9 <= _GEN_1143;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_10 <= _GEN_1144;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_28_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_28_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_28_11 <= _GEN_1145;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_0 <= _GEN_1174;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_1 <= _GEN_1175;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_2 <= _GEN_1176;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_3 <= _GEN_1177;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_4 <= _GEN_1178;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_5 <= _GEN_1179;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_6 <= _GEN_1180;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_7 <= _GEN_1181;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_8 <= _GEN_1182;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_9 <= _GEN_1183;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_10 <= _GEN_1184;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_29_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_29_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_29_11 <= _GEN_1185;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_0 <= _GEN_1214;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_1 <= _GEN_1215;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_2 <= _GEN_1216;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_3 <= _GEN_1217;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_4 <= _GEN_1218;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_5 <= _GEN_1219;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_6 <= _GEN_1220;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_7 <= _GEN_1221;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_8 <= _GEN_1222;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_9 <= _GEN_1223;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_10 <= _GEN_1224;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_30_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_30_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_30_11 <= _GEN_1225;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_0 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_0 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_0 <= _GEN_1254;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_1 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_1 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_1 <= _GEN_1255;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_2 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_2 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_2 <= _GEN_1256;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_3 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_3 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_3 <= _GEN_1257;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_4 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_4 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_4 <= _GEN_1258;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_5 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_5 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_5 <= _GEN_1259;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_6 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_6 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_6 <= _GEN_1260;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_7 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_7 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_7 <= _GEN_1261;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_8 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_8 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_8 <= _GEN_1262;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_9 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_9 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_9 <= _GEN_1263;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_10 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_10 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_10 <= _GEN_1264;
    end
    if (reset) begin // @[AecExecPort.scala 62:31]
      operandCapture_31_11 <= 1'h0; // @[AecExecPort.scala 62:31]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      operandCapture_31_11 <= 1'h0; // @[AecExecPort.scala 93:25]
    end else begin
      operandCapture_31_11 <= _GEN_1265;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_0 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_0 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_0 <= _GEN_26;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_1 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_1 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_1 <= _GEN_66;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_2 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_2 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_2 <= _GEN_106;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_3 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_3 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_3 <= _GEN_146;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_4 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_4 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_4 <= _GEN_186;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_5 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_5 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_5 <= _GEN_226;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_6 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_6 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_6 <= _GEN_266;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_7 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_7 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_7 <= _GEN_306;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_8 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_8 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_8 <= _GEN_346;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_9 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_9 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_9 <= _GEN_386;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_10 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_10 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_10 <= _GEN_426;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_11 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_11 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_11 <= _GEN_466;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_12 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_12 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_12 <= _GEN_506;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_13 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_13 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_13 <= _GEN_546;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_14 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_14 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_14 <= _GEN_586;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_15 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_15 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_15 <= _GEN_626;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_16 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_16 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_16 <= _GEN_666;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_17 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_17 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_17 <= _GEN_706;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_18 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_18 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_18 <= _GEN_746;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_19 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_19 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_19 <= _GEN_786;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_20 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_20 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_20 <= _GEN_826;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_21 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_21 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_21 <= _GEN_866;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_22 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_22 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_22 <= _GEN_906;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_23 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_23 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_23 <= _GEN_946;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_24 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_24 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_24 <= _GEN_986;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_25 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_25 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_25 <= _GEN_1026;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_26 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_26 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_26 <= _GEN_1066;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_27 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_27 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_27 <= _GEN_1106;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_28 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_28 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_28 <= _GEN_1146;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_29 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_29 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_29 <= _GEN_1186;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_30 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_30 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_30 <= _GEN_1226;
    end
    if (reset) begin // @[AecExecPort.scala 64:28]
      maskCapture_31 <= 1'h0; // @[AecExecPort.scala 64:28]
    end else if (io_capture) begin // @[AecExecPort.scala 92:23]
      maskCapture_31 <= 1'h0; // @[AecExecPort.scala 94:22]
    end else begin
      maskCapture_31 <= _GEN_1266;
    end
    if (operandCapture_0_0) begin // @[AecExecPort.scala 80:38]
      a_0_0 <= io_in_a_0[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_0_1) begin // @[AecExecPort.scala 80:38]
      a_0_1 <= io_in_a_0[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_0_2) begin // @[AecExecPort.scala 80:38]
      a_0_2 <= io_in_a_0[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_0_3) begin // @[AecExecPort.scala 80:38]
      a_0_3 <= io_in_a_0[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_1_0) begin // @[AecExecPort.scala 80:38]
      a_1_0 <= io_in_a_1[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_1_1) begin // @[AecExecPort.scala 80:38]
      a_1_1 <= io_in_a_1[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_1_2) begin // @[AecExecPort.scala 80:38]
      a_1_2 <= io_in_a_1[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_1_3) begin // @[AecExecPort.scala 80:38]
      a_1_3 <= io_in_a_1[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_2_0) begin // @[AecExecPort.scala 80:38]
      a_2_0 <= io_in_a_2[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_2_1) begin // @[AecExecPort.scala 80:38]
      a_2_1 <= io_in_a_2[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_2_2) begin // @[AecExecPort.scala 80:38]
      a_2_2 <= io_in_a_2[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_2_3) begin // @[AecExecPort.scala 80:38]
      a_2_3 <= io_in_a_2[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_3_0) begin // @[AecExecPort.scala 80:38]
      a_3_0 <= io_in_a_3[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_3_1) begin // @[AecExecPort.scala 80:38]
      a_3_1 <= io_in_a_3[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_3_2) begin // @[AecExecPort.scala 80:38]
      a_3_2 <= io_in_a_3[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_3_3) begin // @[AecExecPort.scala 80:38]
      a_3_3 <= io_in_a_3[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_4_0) begin // @[AecExecPort.scala 80:38]
      a_4_0 <= io_in_a_4[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_4_1) begin // @[AecExecPort.scala 80:38]
      a_4_1 <= io_in_a_4[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_4_2) begin // @[AecExecPort.scala 80:38]
      a_4_2 <= io_in_a_4[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_4_3) begin // @[AecExecPort.scala 80:38]
      a_4_3 <= io_in_a_4[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_5_0) begin // @[AecExecPort.scala 80:38]
      a_5_0 <= io_in_a_5[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_5_1) begin // @[AecExecPort.scala 80:38]
      a_5_1 <= io_in_a_5[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_5_2) begin // @[AecExecPort.scala 80:38]
      a_5_2 <= io_in_a_5[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_5_3) begin // @[AecExecPort.scala 80:38]
      a_5_3 <= io_in_a_5[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_6_0) begin // @[AecExecPort.scala 80:38]
      a_6_0 <= io_in_a_6[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_6_1) begin // @[AecExecPort.scala 80:38]
      a_6_1 <= io_in_a_6[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_6_2) begin // @[AecExecPort.scala 80:38]
      a_6_2 <= io_in_a_6[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_6_3) begin // @[AecExecPort.scala 80:38]
      a_6_3 <= io_in_a_6[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_7_0) begin // @[AecExecPort.scala 80:38]
      a_7_0 <= io_in_a_7[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_7_1) begin // @[AecExecPort.scala 80:38]
      a_7_1 <= io_in_a_7[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_7_2) begin // @[AecExecPort.scala 80:38]
      a_7_2 <= io_in_a_7[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_7_3) begin // @[AecExecPort.scala 80:38]
      a_7_3 <= io_in_a_7[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_8_0) begin // @[AecExecPort.scala 80:38]
      a_8_0 <= io_in_a_8[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_8_1) begin // @[AecExecPort.scala 80:38]
      a_8_1 <= io_in_a_8[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_8_2) begin // @[AecExecPort.scala 80:38]
      a_8_2 <= io_in_a_8[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_8_3) begin // @[AecExecPort.scala 80:38]
      a_8_3 <= io_in_a_8[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_9_0) begin // @[AecExecPort.scala 80:38]
      a_9_0 <= io_in_a_9[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_9_1) begin // @[AecExecPort.scala 80:38]
      a_9_1 <= io_in_a_9[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_9_2) begin // @[AecExecPort.scala 80:38]
      a_9_2 <= io_in_a_9[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_9_3) begin // @[AecExecPort.scala 80:38]
      a_9_3 <= io_in_a_9[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_10_0) begin // @[AecExecPort.scala 80:38]
      a_10_0 <= io_in_a_10[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_10_1) begin // @[AecExecPort.scala 80:38]
      a_10_1 <= io_in_a_10[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_10_2) begin // @[AecExecPort.scala 80:38]
      a_10_2 <= io_in_a_10[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_10_3) begin // @[AecExecPort.scala 80:38]
      a_10_3 <= io_in_a_10[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_11_0) begin // @[AecExecPort.scala 80:38]
      a_11_0 <= io_in_a_11[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_11_1) begin // @[AecExecPort.scala 80:38]
      a_11_1 <= io_in_a_11[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_11_2) begin // @[AecExecPort.scala 80:38]
      a_11_2 <= io_in_a_11[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_11_3) begin // @[AecExecPort.scala 80:38]
      a_11_3 <= io_in_a_11[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_12_0) begin // @[AecExecPort.scala 80:38]
      a_12_0 <= io_in_a_12[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_12_1) begin // @[AecExecPort.scala 80:38]
      a_12_1 <= io_in_a_12[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_12_2) begin // @[AecExecPort.scala 80:38]
      a_12_2 <= io_in_a_12[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_12_3) begin // @[AecExecPort.scala 80:38]
      a_12_3 <= io_in_a_12[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_13_0) begin // @[AecExecPort.scala 80:38]
      a_13_0 <= io_in_a_13[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_13_1) begin // @[AecExecPort.scala 80:38]
      a_13_1 <= io_in_a_13[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_13_2) begin // @[AecExecPort.scala 80:38]
      a_13_2 <= io_in_a_13[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_13_3) begin // @[AecExecPort.scala 80:38]
      a_13_3 <= io_in_a_13[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_14_0) begin // @[AecExecPort.scala 80:38]
      a_14_0 <= io_in_a_14[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_14_1) begin // @[AecExecPort.scala 80:38]
      a_14_1 <= io_in_a_14[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_14_2) begin // @[AecExecPort.scala 80:38]
      a_14_2 <= io_in_a_14[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_14_3) begin // @[AecExecPort.scala 80:38]
      a_14_3 <= io_in_a_14[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_15_0) begin // @[AecExecPort.scala 80:38]
      a_15_0 <= io_in_a_15[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_15_1) begin // @[AecExecPort.scala 80:38]
      a_15_1 <= io_in_a_15[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_15_2) begin // @[AecExecPort.scala 80:38]
      a_15_2 <= io_in_a_15[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_15_3) begin // @[AecExecPort.scala 80:38]
      a_15_3 <= io_in_a_15[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_16_0) begin // @[AecExecPort.scala 80:38]
      a_16_0 <= io_in_a_16[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_16_1) begin // @[AecExecPort.scala 80:38]
      a_16_1 <= io_in_a_16[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_16_2) begin // @[AecExecPort.scala 80:38]
      a_16_2 <= io_in_a_16[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_16_3) begin // @[AecExecPort.scala 80:38]
      a_16_3 <= io_in_a_16[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_17_0) begin // @[AecExecPort.scala 80:38]
      a_17_0 <= io_in_a_17[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_17_1) begin // @[AecExecPort.scala 80:38]
      a_17_1 <= io_in_a_17[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_17_2) begin // @[AecExecPort.scala 80:38]
      a_17_2 <= io_in_a_17[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_17_3) begin // @[AecExecPort.scala 80:38]
      a_17_3 <= io_in_a_17[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_18_0) begin // @[AecExecPort.scala 80:38]
      a_18_0 <= io_in_a_18[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_18_1) begin // @[AecExecPort.scala 80:38]
      a_18_1 <= io_in_a_18[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_18_2) begin // @[AecExecPort.scala 80:38]
      a_18_2 <= io_in_a_18[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_18_3) begin // @[AecExecPort.scala 80:38]
      a_18_3 <= io_in_a_18[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_19_0) begin // @[AecExecPort.scala 80:38]
      a_19_0 <= io_in_a_19[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_19_1) begin // @[AecExecPort.scala 80:38]
      a_19_1 <= io_in_a_19[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_19_2) begin // @[AecExecPort.scala 80:38]
      a_19_2 <= io_in_a_19[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_19_3) begin // @[AecExecPort.scala 80:38]
      a_19_3 <= io_in_a_19[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_20_0) begin // @[AecExecPort.scala 80:38]
      a_20_0 <= io_in_a_20[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_20_1) begin // @[AecExecPort.scala 80:38]
      a_20_1 <= io_in_a_20[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_20_2) begin // @[AecExecPort.scala 80:38]
      a_20_2 <= io_in_a_20[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_20_3) begin // @[AecExecPort.scala 80:38]
      a_20_3 <= io_in_a_20[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_21_0) begin // @[AecExecPort.scala 80:38]
      a_21_0 <= io_in_a_21[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_21_1) begin // @[AecExecPort.scala 80:38]
      a_21_1 <= io_in_a_21[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_21_2) begin // @[AecExecPort.scala 80:38]
      a_21_2 <= io_in_a_21[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_21_3) begin // @[AecExecPort.scala 80:38]
      a_21_3 <= io_in_a_21[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_22_0) begin // @[AecExecPort.scala 80:38]
      a_22_0 <= io_in_a_22[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_22_1) begin // @[AecExecPort.scala 80:38]
      a_22_1 <= io_in_a_22[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_22_2) begin // @[AecExecPort.scala 80:38]
      a_22_2 <= io_in_a_22[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_22_3) begin // @[AecExecPort.scala 80:38]
      a_22_3 <= io_in_a_22[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_23_0) begin // @[AecExecPort.scala 80:38]
      a_23_0 <= io_in_a_23[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_23_1) begin // @[AecExecPort.scala 80:38]
      a_23_1 <= io_in_a_23[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_23_2) begin // @[AecExecPort.scala 80:38]
      a_23_2 <= io_in_a_23[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_23_3) begin // @[AecExecPort.scala 80:38]
      a_23_3 <= io_in_a_23[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_24_0) begin // @[AecExecPort.scala 80:38]
      a_24_0 <= io_in_a_24[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_24_1) begin // @[AecExecPort.scala 80:38]
      a_24_1 <= io_in_a_24[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_24_2) begin // @[AecExecPort.scala 80:38]
      a_24_2 <= io_in_a_24[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_24_3) begin // @[AecExecPort.scala 80:38]
      a_24_3 <= io_in_a_24[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_25_0) begin // @[AecExecPort.scala 80:38]
      a_25_0 <= io_in_a_25[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_25_1) begin // @[AecExecPort.scala 80:38]
      a_25_1 <= io_in_a_25[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_25_2) begin // @[AecExecPort.scala 80:38]
      a_25_2 <= io_in_a_25[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_25_3) begin // @[AecExecPort.scala 80:38]
      a_25_3 <= io_in_a_25[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_26_0) begin // @[AecExecPort.scala 80:38]
      a_26_0 <= io_in_a_26[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_26_1) begin // @[AecExecPort.scala 80:38]
      a_26_1 <= io_in_a_26[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_26_2) begin // @[AecExecPort.scala 80:38]
      a_26_2 <= io_in_a_26[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_26_3) begin // @[AecExecPort.scala 80:38]
      a_26_3 <= io_in_a_26[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_27_0) begin // @[AecExecPort.scala 80:38]
      a_27_0 <= io_in_a_27[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_27_1) begin // @[AecExecPort.scala 80:38]
      a_27_1 <= io_in_a_27[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_27_2) begin // @[AecExecPort.scala 80:38]
      a_27_2 <= io_in_a_27[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_27_3) begin // @[AecExecPort.scala 80:38]
      a_27_3 <= io_in_a_27[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_28_0) begin // @[AecExecPort.scala 80:38]
      a_28_0 <= io_in_a_28[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_28_1) begin // @[AecExecPort.scala 80:38]
      a_28_1 <= io_in_a_28[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_28_2) begin // @[AecExecPort.scala 80:38]
      a_28_2 <= io_in_a_28[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_28_3) begin // @[AecExecPort.scala 80:38]
      a_28_3 <= io_in_a_28[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_29_0) begin // @[AecExecPort.scala 80:38]
      a_29_0 <= io_in_a_29[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_29_1) begin // @[AecExecPort.scala 80:38]
      a_29_1 <= io_in_a_29[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_29_2) begin // @[AecExecPort.scala 80:38]
      a_29_2 <= io_in_a_29[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_29_3) begin // @[AecExecPort.scala 80:38]
      a_29_3 <= io_in_a_29[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_30_0) begin // @[AecExecPort.scala 80:38]
      a_30_0 <= io_in_a_30[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_30_1) begin // @[AecExecPort.scala 80:38]
      a_30_1 <= io_in_a_30[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_30_2) begin // @[AecExecPort.scala 80:38]
      a_30_2 <= io_in_a_30[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_30_3) begin // @[AecExecPort.scala 80:38]
      a_30_3 <= io_in_a_30[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_31_0) begin // @[AecExecPort.scala 80:38]
      a_31_0 <= io_in_a_31[15:0]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_31_1) begin // @[AecExecPort.scala 80:38]
      a_31_1 <= io_in_a_31[31:16]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_31_2) begin // @[AecExecPort.scala 80:38]
      a_31_2 <= io_in_a_31[47:32]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_31_3) begin // @[AecExecPort.scala 80:38]
      a_31_3 <= io_in_a_31[63:48]; // @[AecExecPort.scala 80:51]
    end
    if (operandCapture_0_4) begin // @[AecExecPort.scala 81:56]
      b_0_0 <= io_in_b_0[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_0_5) begin // @[AecExecPort.scala 81:56]
      b_0_1 <= io_in_b_0[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_0_6) begin // @[AecExecPort.scala 81:56]
      b_0_2 <= io_in_b_0[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_0_7) begin // @[AecExecPort.scala 81:56]
      b_0_3 <= io_in_b_0[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_1_4) begin // @[AecExecPort.scala 81:56]
      b_1_0 <= io_in_b_1[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_1_5) begin // @[AecExecPort.scala 81:56]
      b_1_1 <= io_in_b_1[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_1_6) begin // @[AecExecPort.scala 81:56]
      b_1_2 <= io_in_b_1[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_1_7) begin // @[AecExecPort.scala 81:56]
      b_1_3 <= io_in_b_1[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_2_4) begin // @[AecExecPort.scala 81:56]
      b_2_0 <= io_in_b_2[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_2_5) begin // @[AecExecPort.scala 81:56]
      b_2_1 <= io_in_b_2[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_2_6) begin // @[AecExecPort.scala 81:56]
      b_2_2 <= io_in_b_2[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_2_7) begin // @[AecExecPort.scala 81:56]
      b_2_3 <= io_in_b_2[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_3_4) begin // @[AecExecPort.scala 81:56]
      b_3_0 <= io_in_b_3[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_3_5) begin // @[AecExecPort.scala 81:56]
      b_3_1 <= io_in_b_3[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_3_6) begin // @[AecExecPort.scala 81:56]
      b_3_2 <= io_in_b_3[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_3_7) begin // @[AecExecPort.scala 81:56]
      b_3_3 <= io_in_b_3[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_4_4) begin // @[AecExecPort.scala 81:56]
      b_4_0 <= io_in_b_4[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_4_5) begin // @[AecExecPort.scala 81:56]
      b_4_1 <= io_in_b_4[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_4_6) begin // @[AecExecPort.scala 81:56]
      b_4_2 <= io_in_b_4[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_4_7) begin // @[AecExecPort.scala 81:56]
      b_4_3 <= io_in_b_4[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_5_4) begin // @[AecExecPort.scala 81:56]
      b_5_0 <= io_in_b_5[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_5_5) begin // @[AecExecPort.scala 81:56]
      b_5_1 <= io_in_b_5[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_5_6) begin // @[AecExecPort.scala 81:56]
      b_5_2 <= io_in_b_5[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_5_7) begin // @[AecExecPort.scala 81:56]
      b_5_3 <= io_in_b_5[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_6_4) begin // @[AecExecPort.scala 81:56]
      b_6_0 <= io_in_b_6[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_6_5) begin // @[AecExecPort.scala 81:56]
      b_6_1 <= io_in_b_6[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_6_6) begin // @[AecExecPort.scala 81:56]
      b_6_2 <= io_in_b_6[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_6_7) begin // @[AecExecPort.scala 81:56]
      b_6_3 <= io_in_b_6[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_7_4) begin // @[AecExecPort.scala 81:56]
      b_7_0 <= io_in_b_7[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_7_5) begin // @[AecExecPort.scala 81:56]
      b_7_1 <= io_in_b_7[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_7_6) begin // @[AecExecPort.scala 81:56]
      b_7_2 <= io_in_b_7[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_7_7) begin // @[AecExecPort.scala 81:56]
      b_7_3 <= io_in_b_7[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_8_4) begin // @[AecExecPort.scala 81:56]
      b_8_0 <= io_in_b_8[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_8_5) begin // @[AecExecPort.scala 81:56]
      b_8_1 <= io_in_b_8[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_8_6) begin // @[AecExecPort.scala 81:56]
      b_8_2 <= io_in_b_8[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_8_7) begin // @[AecExecPort.scala 81:56]
      b_8_3 <= io_in_b_8[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_9_4) begin // @[AecExecPort.scala 81:56]
      b_9_0 <= io_in_b_9[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_9_5) begin // @[AecExecPort.scala 81:56]
      b_9_1 <= io_in_b_9[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_9_6) begin // @[AecExecPort.scala 81:56]
      b_9_2 <= io_in_b_9[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_9_7) begin // @[AecExecPort.scala 81:56]
      b_9_3 <= io_in_b_9[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_10_4) begin // @[AecExecPort.scala 81:56]
      b_10_0 <= io_in_b_10[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_10_5) begin // @[AecExecPort.scala 81:56]
      b_10_1 <= io_in_b_10[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_10_6) begin // @[AecExecPort.scala 81:56]
      b_10_2 <= io_in_b_10[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_10_7) begin // @[AecExecPort.scala 81:56]
      b_10_3 <= io_in_b_10[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_11_4) begin // @[AecExecPort.scala 81:56]
      b_11_0 <= io_in_b_11[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_11_5) begin // @[AecExecPort.scala 81:56]
      b_11_1 <= io_in_b_11[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_11_6) begin // @[AecExecPort.scala 81:56]
      b_11_2 <= io_in_b_11[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_11_7) begin // @[AecExecPort.scala 81:56]
      b_11_3 <= io_in_b_11[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_12_4) begin // @[AecExecPort.scala 81:56]
      b_12_0 <= io_in_b_12[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_12_5) begin // @[AecExecPort.scala 81:56]
      b_12_1 <= io_in_b_12[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_12_6) begin // @[AecExecPort.scala 81:56]
      b_12_2 <= io_in_b_12[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_12_7) begin // @[AecExecPort.scala 81:56]
      b_12_3 <= io_in_b_12[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_13_4) begin // @[AecExecPort.scala 81:56]
      b_13_0 <= io_in_b_13[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_13_5) begin // @[AecExecPort.scala 81:56]
      b_13_1 <= io_in_b_13[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_13_6) begin // @[AecExecPort.scala 81:56]
      b_13_2 <= io_in_b_13[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_13_7) begin // @[AecExecPort.scala 81:56]
      b_13_3 <= io_in_b_13[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_14_4) begin // @[AecExecPort.scala 81:56]
      b_14_0 <= io_in_b_14[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_14_5) begin // @[AecExecPort.scala 81:56]
      b_14_1 <= io_in_b_14[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_14_6) begin // @[AecExecPort.scala 81:56]
      b_14_2 <= io_in_b_14[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_14_7) begin // @[AecExecPort.scala 81:56]
      b_14_3 <= io_in_b_14[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_15_4) begin // @[AecExecPort.scala 81:56]
      b_15_0 <= io_in_b_15[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_15_5) begin // @[AecExecPort.scala 81:56]
      b_15_1 <= io_in_b_15[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_15_6) begin // @[AecExecPort.scala 81:56]
      b_15_2 <= io_in_b_15[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_15_7) begin // @[AecExecPort.scala 81:56]
      b_15_3 <= io_in_b_15[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_16_4) begin // @[AecExecPort.scala 81:56]
      b_16_0 <= io_in_b_16[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_16_5) begin // @[AecExecPort.scala 81:56]
      b_16_1 <= io_in_b_16[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_16_6) begin // @[AecExecPort.scala 81:56]
      b_16_2 <= io_in_b_16[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_16_7) begin // @[AecExecPort.scala 81:56]
      b_16_3 <= io_in_b_16[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_17_4) begin // @[AecExecPort.scala 81:56]
      b_17_0 <= io_in_b_17[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_17_5) begin // @[AecExecPort.scala 81:56]
      b_17_1 <= io_in_b_17[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_17_6) begin // @[AecExecPort.scala 81:56]
      b_17_2 <= io_in_b_17[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_17_7) begin // @[AecExecPort.scala 81:56]
      b_17_3 <= io_in_b_17[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_18_4) begin // @[AecExecPort.scala 81:56]
      b_18_0 <= io_in_b_18[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_18_5) begin // @[AecExecPort.scala 81:56]
      b_18_1 <= io_in_b_18[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_18_6) begin // @[AecExecPort.scala 81:56]
      b_18_2 <= io_in_b_18[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_18_7) begin // @[AecExecPort.scala 81:56]
      b_18_3 <= io_in_b_18[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_19_4) begin // @[AecExecPort.scala 81:56]
      b_19_0 <= io_in_b_19[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_19_5) begin // @[AecExecPort.scala 81:56]
      b_19_1 <= io_in_b_19[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_19_6) begin // @[AecExecPort.scala 81:56]
      b_19_2 <= io_in_b_19[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_19_7) begin // @[AecExecPort.scala 81:56]
      b_19_3 <= io_in_b_19[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_20_4) begin // @[AecExecPort.scala 81:56]
      b_20_0 <= io_in_b_20[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_20_5) begin // @[AecExecPort.scala 81:56]
      b_20_1 <= io_in_b_20[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_20_6) begin // @[AecExecPort.scala 81:56]
      b_20_2 <= io_in_b_20[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_20_7) begin // @[AecExecPort.scala 81:56]
      b_20_3 <= io_in_b_20[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_21_4) begin // @[AecExecPort.scala 81:56]
      b_21_0 <= io_in_b_21[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_21_5) begin // @[AecExecPort.scala 81:56]
      b_21_1 <= io_in_b_21[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_21_6) begin // @[AecExecPort.scala 81:56]
      b_21_2 <= io_in_b_21[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_21_7) begin // @[AecExecPort.scala 81:56]
      b_21_3 <= io_in_b_21[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_22_4) begin // @[AecExecPort.scala 81:56]
      b_22_0 <= io_in_b_22[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_22_5) begin // @[AecExecPort.scala 81:56]
      b_22_1 <= io_in_b_22[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_22_6) begin // @[AecExecPort.scala 81:56]
      b_22_2 <= io_in_b_22[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_22_7) begin // @[AecExecPort.scala 81:56]
      b_22_3 <= io_in_b_22[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_23_4) begin // @[AecExecPort.scala 81:56]
      b_23_0 <= io_in_b_23[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_23_5) begin // @[AecExecPort.scala 81:56]
      b_23_1 <= io_in_b_23[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_23_6) begin // @[AecExecPort.scala 81:56]
      b_23_2 <= io_in_b_23[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_23_7) begin // @[AecExecPort.scala 81:56]
      b_23_3 <= io_in_b_23[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_24_4) begin // @[AecExecPort.scala 81:56]
      b_24_0 <= io_in_b_24[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_24_5) begin // @[AecExecPort.scala 81:56]
      b_24_1 <= io_in_b_24[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_24_6) begin // @[AecExecPort.scala 81:56]
      b_24_2 <= io_in_b_24[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_24_7) begin // @[AecExecPort.scala 81:56]
      b_24_3 <= io_in_b_24[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_25_4) begin // @[AecExecPort.scala 81:56]
      b_25_0 <= io_in_b_25[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_25_5) begin // @[AecExecPort.scala 81:56]
      b_25_1 <= io_in_b_25[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_25_6) begin // @[AecExecPort.scala 81:56]
      b_25_2 <= io_in_b_25[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_25_7) begin // @[AecExecPort.scala 81:56]
      b_25_3 <= io_in_b_25[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_26_4) begin // @[AecExecPort.scala 81:56]
      b_26_0 <= io_in_b_26[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_26_5) begin // @[AecExecPort.scala 81:56]
      b_26_1 <= io_in_b_26[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_26_6) begin // @[AecExecPort.scala 81:56]
      b_26_2 <= io_in_b_26[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_26_7) begin // @[AecExecPort.scala 81:56]
      b_26_3 <= io_in_b_26[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_27_4) begin // @[AecExecPort.scala 81:56]
      b_27_0 <= io_in_b_27[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_27_5) begin // @[AecExecPort.scala 81:56]
      b_27_1 <= io_in_b_27[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_27_6) begin // @[AecExecPort.scala 81:56]
      b_27_2 <= io_in_b_27[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_27_7) begin // @[AecExecPort.scala 81:56]
      b_27_3 <= io_in_b_27[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_28_4) begin // @[AecExecPort.scala 81:56]
      b_28_0 <= io_in_b_28[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_28_5) begin // @[AecExecPort.scala 81:56]
      b_28_1 <= io_in_b_28[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_28_6) begin // @[AecExecPort.scala 81:56]
      b_28_2 <= io_in_b_28[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_28_7) begin // @[AecExecPort.scala 81:56]
      b_28_3 <= io_in_b_28[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_29_4) begin // @[AecExecPort.scala 81:56]
      b_29_0 <= io_in_b_29[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_29_5) begin // @[AecExecPort.scala 81:56]
      b_29_1 <= io_in_b_29[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_29_6) begin // @[AecExecPort.scala 81:56]
      b_29_2 <= io_in_b_29[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_29_7) begin // @[AecExecPort.scala 81:56]
      b_29_3 <= io_in_b_29[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_30_4) begin // @[AecExecPort.scala 81:56]
      b_30_0 <= io_in_b_30[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_30_5) begin // @[AecExecPort.scala 81:56]
      b_30_1 <= io_in_b_30[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_30_6) begin // @[AecExecPort.scala 81:56]
      b_30_2 <= io_in_b_30[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_30_7) begin // @[AecExecPort.scala 81:56]
      b_30_3 <= io_in_b_30[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_31_4) begin // @[AecExecPort.scala 81:56]
      b_31_0 <= io_in_b_31[15:0]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_31_5) begin // @[AecExecPort.scala 81:56]
      b_31_1 <= io_in_b_31[31:16]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_31_6) begin // @[AecExecPort.scala 81:56]
      b_31_2 <= io_in_b_31[47:32]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_31_7) begin // @[AecExecPort.scala 81:56]
      b_31_3 <= io_in_b_31[63:48]; // @[AecExecPort.scala 81:69]
    end
    if (operandCapture_0_8) begin // @[AecExecPort.scala 82:60]
      c_0_0 <= io_in_c_0[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_0_9) begin // @[AecExecPort.scala 82:60]
      c_0_1 <= io_in_c_0[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_0_10) begin // @[AecExecPort.scala 82:60]
      c_0_2 <= io_in_c_0[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_0_11) begin // @[AecExecPort.scala 82:60]
      c_0_3 <= io_in_c_0[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_1_8) begin // @[AecExecPort.scala 82:60]
      c_1_0 <= io_in_c_1[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_1_9) begin // @[AecExecPort.scala 82:60]
      c_1_1 <= io_in_c_1[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_1_10) begin // @[AecExecPort.scala 82:60]
      c_1_2 <= io_in_c_1[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_1_11) begin // @[AecExecPort.scala 82:60]
      c_1_3 <= io_in_c_1[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_2_8) begin // @[AecExecPort.scala 82:60]
      c_2_0 <= io_in_c_2[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_2_9) begin // @[AecExecPort.scala 82:60]
      c_2_1 <= io_in_c_2[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_2_10) begin // @[AecExecPort.scala 82:60]
      c_2_2 <= io_in_c_2[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_2_11) begin // @[AecExecPort.scala 82:60]
      c_2_3 <= io_in_c_2[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_3_8) begin // @[AecExecPort.scala 82:60]
      c_3_0 <= io_in_c_3[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_3_9) begin // @[AecExecPort.scala 82:60]
      c_3_1 <= io_in_c_3[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_3_10) begin // @[AecExecPort.scala 82:60]
      c_3_2 <= io_in_c_3[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_3_11) begin // @[AecExecPort.scala 82:60]
      c_3_3 <= io_in_c_3[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_4_8) begin // @[AecExecPort.scala 82:60]
      c_4_0 <= io_in_c_4[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_4_9) begin // @[AecExecPort.scala 82:60]
      c_4_1 <= io_in_c_4[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_4_10) begin // @[AecExecPort.scala 82:60]
      c_4_2 <= io_in_c_4[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_4_11) begin // @[AecExecPort.scala 82:60]
      c_4_3 <= io_in_c_4[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_5_8) begin // @[AecExecPort.scala 82:60]
      c_5_0 <= io_in_c_5[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_5_9) begin // @[AecExecPort.scala 82:60]
      c_5_1 <= io_in_c_5[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_5_10) begin // @[AecExecPort.scala 82:60]
      c_5_2 <= io_in_c_5[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_5_11) begin // @[AecExecPort.scala 82:60]
      c_5_3 <= io_in_c_5[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_6_8) begin // @[AecExecPort.scala 82:60]
      c_6_0 <= io_in_c_6[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_6_9) begin // @[AecExecPort.scala 82:60]
      c_6_1 <= io_in_c_6[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_6_10) begin // @[AecExecPort.scala 82:60]
      c_6_2 <= io_in_c_6[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_6_11) begin // @[AecExecPort.scala 82:60]
      c_6_3 <= io_in_c_6[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_7_8) begin // @[AecExecPort.scala 82:60]
      c_7_0 <= io_in_c_7[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_7_9) begin // @[AecExecPort.scala 82:60]
      c_7_1 <= io_in_c_7[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_7_10) begin // @[AecExecPort.scala 82:60]
      c_7_2 <= io_in_c_7[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_7_11) begin // @[AecExecPort.scala 82:60]
      c_7_3 <= io_in_c_7[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_8_8) begin // @[AecExecPort.scala 82:60]
      c_8_0 <= io_in_c_8[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_8_9) begin // @[AecExecPort.scala 82:60]
      c_8_1 <= io_in_c_8[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_8_10) begin // @[AecExecPort.scala 82:60]
      c_8_2 <= io_in_c_8[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_8_11) begin // @[AecExecPort.scala 82:60]
      c_8_3 <= io_in_c_8[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_9_8) begin // @[AecExecPort.scala 82:60]
      c_9_0 <= io_in_c_9[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_9_9) begin // @[AecExecPort.scala 82:60]
      c_9_1 <= io_in_c_9[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_9_10) begin // @[AecExecPort.scala 82:60]
      c_9_2 <= io_in_c_9[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_9_11) begin // @[AecExecPort.scala 82:60]
      c_9_3 <= io_in_c_9[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_10_8) begin // @[AecExecPort.scala 82:60]
      c_10_0 <= io_in_c_10[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_10_9) begin // @[AecExecPort.scala 82:60]
      c_10_1 <= io_in_c_10[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_10_10) begin // @[AecExecPort.scala 82:60]
      c_10_2 <= io_in_c_10[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_10_11) begin // @[AecExecPort.scala 82:60]
      c_10_3 <= io_in_c_10[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_11_8) begin // @[AecExecPort.scala 82:60]
      c_11_0 <= io_in_c_11[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_11_9) begin // @[AecExecPort.scala 82:60]
      c_11_1 <= io_in_c_11[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_11_10) begin // @[AecExecPort.scala 82:60]
      c_11_2 <= io_in_c_11[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_11_11) begin // @[AecExecPort.scala 82:60]
      c_11_3 <= io_in_c_11[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_12_8) begin // @[AecExecPort.scala 82:60]
      c_12_0 <= io_in_c_12[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_12_9) begin // @[AecExecPort.scala 82:60]
      c_12_1 <= io_in_c_12[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_12_10) begin // @[AecExecPort.scala 82:60]
      c_12_2 <= io_in_c_12[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_12_11) begin // @[AecExecPort.scala 82:60]
      c_12_3 <= io_in_c_12[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_13_8) begin // @[AecExecPort.scala 82:60]
      c_13_0 <= io_in_c_13[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_13_9) begin // @[AecExecPort.scala 82:60]
      c_13_1 <= io_in_c_13[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_13_10) begin // @[AecExecPort.scala 82:60]
      c_13_2 <= io_in_c_13[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_13_11) begin // @[AecExecPort.scala 82:60]
      c_13_3 <= io_in_c_13[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_14_8) begin // @[AecExecPort.scala 82:60]
      c_14_0 <= io_in_c_14[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_14_9) begin // @[AecExecPort.scala 82:60]
      c_14_1 <= io_in_c_14[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_14_10) begin // @[AecExecPort.scala 82:60]
      c_14_2 <= io_in_c_14[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_14_11) begin // @[AecExecPort.scala 82:60]
      c_14_3 <= io_in_c_14[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_15_8) begin // @[AecExecPort.scala 82:60]
      c_15_0 <= io_in_c_15[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_15_9) begin // @[AecExecPort.scala 82:60]
      c_15_1 <= io_in_c_15[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_15_10) begin // @[AecExecPort.scala 82:60]
      c_15_2 <= io_in_c_15[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_15_11) begin // @[AecExecPort.scala 82:60]
      c_15_3 <= io_in_c_15[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_16_8) begin // @[AecExecPort.scala 82:60]
      c_16_0 <= io_in_c_16[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_16_9) begin // @[AecExecPort.scala 82:60]
      c_16_1 <= io_in_c_16[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_16_10) begin // @[AecExecPort.scala 82:60]
      c_16_2 <= io_in_c_16[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_16_11) begin // @[AecExecPort.scala 82:60]
      c_16_3 <= io_in_c_16[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_17_8) begin // @[AecExecPort.scala 82:60]
      c_17_0 <= io_in_c_17[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_17_9) begin // @[AecExecPort.scala 82:60]
      c_17_1 <= io_in_c_17[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_17_10) begin // @[AecExecPort.scala 82:60]
      c_17_2 <= io_in_c_17[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_17_11) begin // @[AecExecPort.scala 82:60]
      c_17_3 <= io_in_c_17[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_18_8) begin // @[AecExecPort.scala 82:60]
      c_18_0 <= io_in_c_18[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_18_9) begin // @[AecExecPort.scala 82:60]
      c_18_1 <= io_in_c_18[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_18_10) begin // @[AecExecPort.scala 82:60]
      c_18_2 <= io_in_c_18[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_18_11) begin // @[AecExecPort.scala 82:60]
      c_18_3 <= io_in_c_18[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_19_8) begin // @[AecExecPort.scala 82:60]
      c_19_0 <= io_in_c_19[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_19_9) begin // @[AecExecPort.scala 82:60]
      c_19_1 <= io_in_c_19[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_19_10) begin // @[AecExecPort.scala 82:60]
      c_19_2 <= io_in_c_19[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_19_11) begin // @[AecExecPort.scala 82:60]
      c_19_3 <= io_in_c_19[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_20_8) begin // @[AecExecPort.scala 82:60]
      c_20_0 <= io_in_c_20[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_20_9) begin // @[AecExecPort.scala 82:60]
      c_20_1 <= io_in_c_20[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_20_10) begin // @[AecExecPort.scala 82:60]
      c_20_2 <= io_in_c_20[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_20_11) begin // @[AecExecPort.scala 82:60]
      c_20_3 <= io_in_c_20[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_21_8) begin // @[AecExecPort.scala 82:60]
      c_21_0 <= io_in_c_21[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_21_9) begin // @[AecExecPort.scala 82:60]
      c_21_1 <= io_in_c_21[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_21_10) begin // @[AecExecPort.scala 82:60]
      c_21_2 <= io_in_c_21[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_21_11) begin // @[AecExecPort.scala 82:60]
      c_21_3 <= io_in_c_21[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_22_8) begin // @[AecExecPort.scala 82:60]
      c_22_0 <= io_in_c_22[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_22_9) begin // @[AecExecPort.scala 82:60]
      c_22_1 <= io_in_c_22[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_22_10) begin // @[AecExecPort.scala 82:60]
      c_22_2 <= io_in_c_22[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_22_11) begin // @[AecExecPort.scala 82:60]
      c_22_3 <= io_in_c_22[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_23_8) begin // @[AecExecPort.scala 82:60]
      c_23_0 <= io_in_c_23[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_23_9) begin // @[AecExecPort.scala 82:60]
      c_23_1 <= io_in_c_23[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_23_10) begin // @[AecExecPort.scala 82:60]
      c_23_2 <= io_in_c_23[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_23_11) begin // @[AecExecPort.scala 82:60]
      c_23_3 <= io_in_c_23[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_24_8) begin // @[AecExecPort.scala 82:60]
      c_24_0 <= io_in_c_24[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_24_9) begin // @[AecExecPort.scala 82:60]
      c_24_1 <= io_in_c_24[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_24_10) begin // @[AecExecPort.scala 82:60]
      c_24_2 <= io_in_c_24[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_24_11) begin // @[AecExecPort.scala 82:60]
      c_24_3 <= io_in_c_24[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_25_8) begin // @[AecExecPort.scala 82:60]
      c_25_0 <= io_in_c_25[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_25_9) begin // @[AecExecPort.scala 82:60]
      c_25_1 <= io_in_c_25[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_25_10) begin // @[AecExecPort.scala 82:60]
      c_25_2 <= io_in_c_25[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_25_11) begin // @[AecExecPort.scala 82:60]
      c_25_3 <= io_in_c_25[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_26_8) begin // @[AecExecPort.scala 82:60]
      c_26_0 <= io_in_c_26[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_26_9) begin // @[AecExecPort.scala 82:60]
      c_26_1 <= io_in_c_26[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_26_10) begin // @[AecExecPort.scala 82:60]
      c_26_2 <= io_in_c_26[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_26_11) begin // @[AecExecPort.scala 82:60]
      c_26_3 <= io_in_c_26[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_27_8) begin // @[AecExecPort.scala 82:60]
      c_27_0 <= io_in_c_27[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_27_9) begin // @[AecExecPort.scala 82:60]
      c_27_1 <= io_in_c_27[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_27_10) begin // @[AecExecPort.scala 82:60]
      c_27_2 <= io_in_c_27[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_27_11) begin // @[AecExecPort.scala 82:60]
      c_27_3 <= io_in_c_27[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_28_8) begin // @[AecExecPort.scala 82:60]
      c_28_0 <= io_in_c_28[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_28_9) begin // @[AecExecPort.scala 82:60]
      c_28_1 <= io_in_c_28[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_28_10) begin // @[AecExecPort.scala 82:60]
      c_28_2 <= io_in_c_28[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_28_11) begin // @[AecExecPort.scala 82:60]
      c_28_3 <= io_in_c_28[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_29_8) begin // @[AecExecPort.scala 82:60]
      c_29_0 <= io_in_c_29[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_29_9) begin // @[AecExecPort.scala 82:60]
      c_29_1 <= io_in_c_29[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_29_10) begin // @[AecExecPort.scala 82:60]
      c_29_2 <= io_in_c_29[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_29_11) begin // @[AecExecPort.scala 82:60]
      c_29_3 <= io_in_c_29[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_30_8) begin // @[AecExecPort.scala 82:60]
      c_30_0 <= io_in_c_30[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_30_9) begin // @[AecExecPort.scala 82:60]
      c_30_1 <= io_in_c_30[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_30_10) begin // @[AecExecPort.scala 82:60]
      c_30_2 <= io_in_c_30[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_30_11) begin // @[AecExecPort.scala 82:60]
      c_30_3 <= io_in_c_30[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_31_8) begin // @[AecExecPort.scala 82:60]
      c_31_0 <= io_in_c_31[15:0]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_31_9) begin // @[AecExecPort.scala 82:60]
      c_31_1 <= io_in_c_31[31:16]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_31_10) begin // @[AecExecPort.scala 82:60]
      c_31_2 <= io_in_c_31[47:32]; // @[AecExecPort.scala 82:73]
    end
    if (operandCapture_31_11) begin // @[AecExecPort.scala 82:60]
      c_31_3 <= io_in_c_31[63:48]; // @[AecExecPort.scala 82:73]
    end
    if (maskCapture_0) begin // @[AecExecPort.scala 84:27]
      active_0 <= io_in_activeMask[0]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_1) begin // @[AecExecPort.scala 84:27]
      active_1 <= io_in_activeMask[1]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_2) begin // @[AecExecPort.scala 84:27]
      active_2 <= io_in_activeMask[2]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_3) begin // @[AecExecPort.scala 84:27]
      active_3 <= io_in_activeMask[3]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_4) begin // @[AecExecPort.scala 84:27]
      active_4 <= io_in_activeMask[4]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_5) begin // @[AecExecPort.scala 84:27]
      active_5 <= io_in_activeMask[5]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_6) begin // @[AecExecPort.scala 84:27]
      active_6 <= io_in_activeMask[6]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_7) begin // @[AecExecPort.scala 84:27]
      active_7 <= io_in_activeMask[7]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_8) begin // @[AecExecPort.scala 84:27]
      active_8 <= io_in_activeMask[8]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_9) begin // @[AecExecPort.scala 84:27]
      active_9 <= io_in_activeMask[9]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_10) begin // @[AecExecPort.scala 84:27]
      active_10 <= io_in_activeMask[10]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_11) begin // @[AecExecPort.scala 84:27]
      active_11 <= io_in_activeMask[11]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_12) begin // @[AecExecPort.scala 84:27]
      active_12 <= io_in_activeMask[12]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_13) begin // @[AecExecPort.scala 84:27]
      active_13 <= io_in_activeMask[13]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_14) begin // @[AecExecPort.scala 84:27]
      active_14 <= io_in_activeMask[14]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_15) begin // @[AecExecPort.scala 84:27]
      active_15 <= io_in_activeMask[15]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_16) begin // @[AecExecPort.scala 84:27]
      active_16 <= io_in_activeMask[16]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_17) begin // @[AecExecPort.scala 84:27]
      active_17 <= io_in_activeMask[17]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_18) begin // @[AecExecPort.scala 84:27]
      active_18 <= io_in_activeMask[18]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_19) begin // @[AecExecPort.scala 84:27]
      active_19 <= io_in_activeMask[19]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_20) begin // @[AecExecPort.scala 84:27]
      active_20 <= io_in_activeMask[20]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_21) begin // @[AecExecPort.scala 84:27]
      active_21 <= io_in_activeMask[21]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_22) begin // @[AecExecPort.scala 84:27]
      active_22 <= io_in_activeMask[22]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_23) begin // @[AecExecPort.scala 84:27]
      active_23 <= io_in_activeMask[23]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_24) begin // @[AecExecPort.scala 84:27]
      active_24 <= io_in_activeMask[24]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_25) begin // @[AecExecPort.scala 84:27]
      active_25 <= io_in_activeMask[25]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_26) begin // @[AecExecPort.scala 84:27]
      active_26 <= io_in_activeMask[26]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_27) begin // @[AecExecPort.scala 84:27]
      active_27 <= io_in_activeMask[27]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_28) begin // @[AecExecPort.scala 84:27]
      active_28 <= io_in_activeMask[28]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_29) begin // @[AecExecPort.scala 84:27]
      active_29 <= io_in_activeMask[29]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_30) begin // @[AecExecPort.scala 84:27]
      active_30 <= io_in_activeMask[30]; // @[AecExecPort.scala 85:17]
    end
    if (maskCapture_31) begin // @[AecExecPort.scala 84:27]
      active_31 <= io_in_activeMask[31]; // @[AecExecPort.scala 85:17]
    end
    if (io_capture) begin // @[AecExecPort.scala 97:21]
      dest <= io_in_dest; // @[AecExecPort.scala 100:10]
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
  c_0_0 = _RAND_672[15:0];
  _RAND_673 = {1{`RANDOM}};
  c_0_1 = _RAND_673[15:0];
  _RAND_674 = {1{`RANDOM}};
  c_0_2 = _RAND_674[15:0];
  _RAND_675 = {1{`RANDOM}};
  c_0_3 = _RAND_675[15:0];
  _RAND_676 = {1{`RANDOM}};
  c_1_0 = _RAND_676[15:0];
  _RAND_677 = {1{`RANDOM}};
  c_1_1 = _RAND_677[15:0];
  _RAND_678 = {1{`RANDOM}};
  c_1_2 = _RAND_678[15:0];
  _RAND_679 = {1{`RANDOM}};
  c_1_3 = _RAND_679[15:0];
  _RAND_680 = {1{`RANDOM}};
  c_2_0 = _RAND_680[15:0];
  _RAND_681 = {1{`RANDOM}};
  c_2_1 = _RAND_681[15:0];
  _RAND_682 = {1{`RANDOM}};
  c_2_2 = _RAND_682[15:0];
  _RAND_683 = {1{`RANDOM}};
  c_2_3 = _RAND_683[15:0];
  _RAND_684 = {1{`RANDOM}};
  c_3_0 = _RAND_684[15:0];
  _RAND_685 = {1{`RANDOM}};
  c_3_1 = _RAND_685[15:0];
  _RAND_686 = {1{`RANDOM}};
  c_3_2 = _RAND_686[15:0];
  _RAND_687 = {1{`RANDOM}};
  c_3_3 = _RAND_687[15:0];
  _RAND_688 = {1{`RANDOM}};
  c_4_0 = _RAND_688[15:0];
  _RAND_689 = {1{`RANDOM}};
  c_4_1 = _RAND_689[15:0];
  _RAND_690 = {1{`RANDOM}};
  c_4_2 = _RAND_690[15:0];
  _RAND_691 = {1{`RANDOM}};
  c_4_3 = _RAND_691[15:0];
  _RAND_692 = {1{`RANDOM}};
  c_5_0 = _RAND_692[15:0];
  _RAND_693 = {1{`RANDOM}};
  c_5_1 = _RAND_693[15:0];
  _RAND_694 = {1{`RANDOM}};
  c_5_2 = _RAND_694[15:0];
  _RAND_695 = {1{`RANDOM}};
  c_5_3 = _RAND_695[15:0];
  _RAND_696 = {1{`RANDOM}};
  c_6_0 = _RAND_696[15:0];
  _RAND_697 = {1{`RANDOM}};
  c_6_1 = _RAND_697[15:0];
  _RAND_698 = {1{`RANDOM}};
  c_6_2 = _RAND_698[15:0];
  _RAND_699 = {1{`RANDOM}};
  c_6_3 = _RAND_699[15:0];
  _RAND_700 = {1{`RANDOM}};
  c_7_0 = _RAND_700[15:0];
  _RAND_701 = {1{`RANDOM}};
  c_7_1 = _RAND_701[15:0];
  _RAND_702 = {1{`RANDOM}};
  c_7_2 = _RAND_702[15:0];
  _RAND_703 = {1{`RANDOM}};
  c_7_3 = _RAND_703[15:0];
  _RAND_704 = {1{`RANDOM}};
  c_8_0 = _RAND_704[15:0];
  _RAND_705 = {1{`RANDOM}};
  c_8_1 = _RAND_705[15:0];
  _RAND_706 = {1{`RANDOM}};
  c_8_2 = _RAND_706[15:0];
  _RAND_707 = {1{`RANDOM}};
  c_8_3 = _RAND_707[15:0];
  _RAND_708 = {1{`RANDOM}};
  c_9_0 = _RAND_708[15:0];
  _RAND_709 = {1{`RANDOM}};
  c_9_1 = _RAND_709[15:0];
  _RAND_710 = {1{`RANDOM}};
  c_9_2 = _RAND_710[15:0];
  _RAND_711 = {1{`RANDOM}};
  c_9_3 = _RAND_711[15:0];
  _RAND_712 = {1{`RANDOM}};
  c_10_0 = _RAND_712[15:0];
  _RAND_713 = {1{`RANDOM}};
  c_10_1 = _RAND_713[15:0];
  _RAND_714 = {1{`RANDOM}};
  c_10_2 = _RAND_714[15:0];
  _RAND_715 = {1{`RANDOM}};
  c_10_3 = _RAND_715[15:0];
  _RAND_716 = {1{`RANDOM}};
  c_11_0 = _RAND_716[15:0];
  _RAND_717 = {1{`RANDOM}};
  c_11_1 = _RAND_717[15:0];
  _RAND_718 = {1{`RANDOM}};
  c_11_2 = _RAND_718[15:0];
  _RAND_719 = {1{`RANDOM}};
  c_11_3 = _RAND_719[15:0];
  _RAND_720 = {1{`RANDOM}};
  c_12_0 = _RAND_720[15:0];
  _RAND_721 = {1{`RANDOM}};
  c_12_1 = _RAND_721[15:0];
  _RAND_722 = {1{`RANDOM}};
  c_12_2 = _RAND_722[15:0];
  _RAND_723 = {1{`RANDOM}};
  c_12_3 = _RAND_723[15:0];
  _RAND_724 = {1{`RANDOM}};
  c_13_0 = _RAND_724[15:0];
  _RAND_725 = {1{`RANDOM}};
  c_13_1 = _RAND_725[15:0];
  _RAND_726 = {1{`RANDOM}};
  c_13_2 = _RAND_726[15:0];
  _RAND_727 = {1{`RANDOM}};
  c_13_3 = _RAND_727[15:0];
  _RAND_728 = {1{`RANDOM}};
  c_14_0 = _RAND_728[15:0];
  _RAND_729 = {1{`RANDOM}};
  c_14_1 = _RAND_729[15:0];
  _RAND_730 = {1{`RANDOM}};
  c_14_2 = _RAND_730[15:0];
  _RAND_731 = {1{`RANDOM}};
  c_14_3 = _RAND_731[15:0];
  _RAND_732 = {1{`RANDOM}};
  c_15_0 = _RAND_732[15:0];
  _RAND_733 = {1{`RANDOM}};
  c_15_1 = _RAND_733[15:0];
  _RAND_734 = {1{`RANDOM}};
  c_15_2 = _RAND_734[15:0];
  _RAND_735 = {1{`RANDOM}};
  c_15_3 = _RAND_735[15:0];
  _RAND_736 = {1{`RANDOM}};
  c_16_0 = _RAND_736[15:0];
  _RAND_737 = {1{`RANDOM}};
  c_16_1 = _RAND_737[15:0];
  _RAND_738 = {1{`RANDOM}};
  c_16_2 = _RAND_738[15:0];
  _RAND_739 = {1{`RANDOM}};
  c_16_3 = _RAND_739[15:0];
  _RAND_740 = {1{`RANDOM}};
  c_17_0 = _RAND_740[15:0];
  _RAND_741 = {1{`RANDOM}};
  c_17_1 = _RAND_741[15:0];
  _RAND_742 = {1{`RANDOM}};
  c_17_2 = _RAND_742[15:0];
  _RAND_743 = {1{`RANDOM}};
  c_17_3 = _RAND_743[15:0];
  _RAND_744 = {1{`RANDOM}};
  c_18_0 = _RAND_744[15:0];
  _RAND_745 = {1{`RANDOM}};
  c_18_1 = _RAND_745[15:0];
  _RAND_746 = {1{`RANDOM}};
  c_18_2 = _RAND_746[15:0];
  _RAND_747 = {1{`RANDOM}};
  c_18_3 = _RAND_747[15:0];
  _RAND_748 = {1{`RANDOM}};
  c_19_0 = _RAND_748[15:0];
  _RAND_749 = {1{`RANDOM}};
  c_19_1 = _RAND_749[15:0];
  _RAND_750 = {1{`RANDOM}};
  c_19_2 = _RAND_750[15:0];
  _RAND_751 = {1{`RANDOM}};
  c_19_3 = _RAND_751[15:0];
  _RAND_752 = {1{`RANDOM}};
  c_20_0 = _RAND_752[15:0];
  _RAND_753 = {1{`RANDOM}};
  c_20_1 = _RAND_753[15:0];
  _RAND_754 = {1{`RANDOM}};
  c_20_2 = _RAND_754[15:0];
  _RAND_755 = {1{`RANDOM}};
  c_20_3 = _RAND_755[15:0];
  _RAND_756 = {1{`RANDOM}};
  c_21_0 = _RAND_756[15:0];
  _RAND_757 = {1{`RANDOM}};
  c_21_1 = _RAND_757[15:0];
  _RAND_758 = {1{`RANDOM}};
  c_21_2 = _RAND_758[15:0];
  _RAND_759 = {1{`RANDOM}};
  c_21_3 = _RAND_759[15:0];
  _RAND_760 = {1{`RANDOM}};
  c_22_0 = _RAND_760[15:0];
  _RAND_761 = {1{`RANDOM}};
  c_22_1 = _RAND_761[15:0];
  _RAND_762 = {1{`RANDOM}};
  c_22_2 = _RAND_762[15:0];
  _RAND_763 = {1{`RANDOM}};
  c_22_3 = _RAND_763[15:0];
  _RAND_764 = {1{`RANDOM}};
  c_23_0 = _RAND_764[15:0];
  _RAND_765 = {1{`RANDOM}};
  c_23_1 = _RAND_765[15:0];
  _RAND_766 = {1{`RANDOM}};
  c_23_2 = _RAND_766[15:0];
  _RAND_767 = {1{`RANDOM}};
  c_23_3 = _RAND_767[15:0];
  _RAND_768 = {1{`RANDOM}};
  c_24_0 = _RAND_768[15:0];
  _RAND_769 = {1{`RANDOM}};
  c_24_1 = _RAND_769[15:0];
  _RAND_770 = {1{`RANDOM}};
  c_24_2 = _RAND_770[15:0];
  _RAND_771 = {1{`RANDOM}};
  c_24_3 = _RAND_771[15:0];
  _RAND_772 = {1{`RANDOM}};
  c_25_0 = _RAND_772[15:0];
  _RAND_773 = {1{`RANDOM}};
  c_25_1 = _RAND_773[15:0];
  _RAND_774 = {1{`RANDOM}};
  c_25_2 = _RAND_774[15:0];
  _RAND_775 = {1{`RANDOM}};
  c_25_3 = _RAND_775[15:0];
  _RAND_776 = {1{`RANDOM}};
  c_26_0 = _RAND_776[15:0];
  _RAND_777 = {1{`RANDOM}};
  c_26_1 = _RAND_777[15:0];
  _RAND_778 = {1{`RANDOM}};
  c_26_2 = _RAND_778[15:0];
  _RAND_779 = {1{`RANDOM}};
  c_26_3 = _RAND_779[15:0];
  _RAND_780 = {1{`RANDOM}};
  c_27_0 = _RAND_780[15:0];
  _RAND_781 = {1{`RANDOM}};
  c_27_1 = _RAND_781[15:0];
  _RAND_782 = {1{`RANDOM}};
  c_27_2 = _RAND_782[15:0];
  _RAND_783 = {1{`RANDOM}};
  c_27_3 = _RAND_783[15:0];
  _RAND_784 = {1{`RANDOM}};
  c_28_0 = _RAND_784[15:0];
  _RAND_785 = {1{`RANDOM}};
  c_28_1 = _RAND_785[15:0];
  _RAND_786 = {1{`RANDOM}};
  c_28_2 = _RAND_786[15:0];
  _RAND_787 = {1{`RANDOM}};
  c_28_3 = _RAND_787[15:0];
  _RAND_788 = {1{`RANDOM}};
  c_29_0 = _RAND_788[15:0];
  _RAND_789 = {1{`RANDOM}};
  c_29_1 = _RAND_789[15:0];
  _RAND_790 = {1{`RANDOM}};
  c_29_2 = _RAND_790[15:0];
  _RAND_791 = {1{`RANDOM}};
  c_29_3 = _RAND_791[15:0];
  _RAND_792 = {1{`RANDOM}};
  c_30_0 = _RAND_792[15:0];
  _RAND_793 = {1{`RANDOM}};
  c_30_1 = _RAND_793[15:0];
  _RAND_794 = {1{`RANDOM}};
  c_30_2 = _RAND_794[15:0];
  _RAND_795 = {1{`RANDOM}};
  c_30_3 = _RAND_795[15:0];
  _RAND_796 = {1{`RANDOM}};
  c_31_0 = _RAND_796[15:0];
  _RAND_797 = {1{`RANDOM}};
  c_31_1 = _RAND_797[15:0];
  _RAND_798 = {1{`RANDOM}};
  c_31_2 = _RAND_798[15:0];
  _RAND_799 = {1{`RANDOM}};
  c_31_3 = _RAND_799[15:0];
  _RAND_800 = {1{`RANDOM}};
  active_0 = _RAND_800[0:0];
  _RAND_801 = {1{`RANDOM}};
  active_1 = _RAND_801[0:0];
  _RAND_802 = {1{`RANDOM}};
  active_2 = _RAND_802[0:0];
  _RAND_803 = {1{`RANDOM}};
  active_3 = _RAND_803[0:0];
  _RAND_804 = {1{`RANDOM}};
  active_4 = _RAND_804[0:0];
  _RAND_805 = {1{`RANDOM}};
  active_5 = _RAND_805[0:0];
  _RAND_806 = {1{`RANDOM}};
  active_6 = _RAND_806[0:0];
  _RAND_807 = {1{`RANDOM}};
  active_7 = _RAND_807[0:0];
  _RAND_808 = {1{`RANDOM}};
  active_8 = _RAND_808[0:0];
  _RAND_809 = {1{`RANDOM}};
  active_9 = _RAND_809[0:0];
  _RAND_810 = {1{`RANDOM}};
  active_10 = _RAND_810[0:0];
  _RAND_811 = {1{`RANDOM}};
  active_11 = _RAND_811[0:0];
  _RAND_812 = {1{`RANDOM}};
  active_12 = _RAND_812[0:0];
  _RAND_813 = {1{`RANDOM}};
  active_13 = _RAND_813[0:0];
  _RAND_814 = {1{`RANDOM}};
  active_14 = _RAND_814[0:0];
  _RAND_815 = {1{`RANDOM}};
  active_15 = _RAND_815[0:0];
  _RAND_816 = {1{`RANDOM}};
  active_16 = _RAND_816[0:0];
  _RAND_817 = {1{`RANDOM}};
  active_17 = _RAND_817[0:0];
  _RAND_818 = {1{`RANDOM}};
  active_18 = _RAND_818[0:0];
  _RAND_819 = {1{`RANDOM}};
  active_19 = _RAND_819[0:0];
  _RAND_820 = {1{`RANDOM}};
  active_20 = _RAND_820[0:0];
  _RAND_821 = {1{`RANDOM}};
  active_21 = _RAND_821[0:0];
  _RAND_822 = {1{`RANDOM}};
  active_22 = _RAND_822[0:0];
  _RAND_823 = {1{`RANDOM}};
  active_23 = _RAND_823[0:0];
  _RAND_824 = {1{`RANDOM}};
  active_24 = _RAND_824[0:0];
  _RAND_825 = {1{`RANDOM}};
  active_25 = _RAND_825[0:0];
  _RAND_826 = {1{`RANDOM}};
  active_26 = _RAND_826[0:0];
  _RAND_827 = {1{`RANDOM}};
  active_27 = _RAND_827[0:0];
  _RAND_828 = {1{`RANDOM}};
  active_28 = _RAND_828[0:0];
  _RAND_829 = {1{`RANDOM}};
  active_29 = _RAND_829[0:0];
  _RAND_830 = {1{`RANDOM}};
  active_30 = _RAND_830[0:0];
  _RAND_831 = {1{`RANDOM}};
  active_31 = _RAND_831[0:0];
  _RAND_832 = {1{`RANDOM}};
  dest = _RAND_832[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecResultLaneBank(
  input         clock,
  input         reset,
  input         io_write,
  input  [63:0] io_writeResult,
  input  [4:0]  io_writeFlags,
  output [63:0] io_result,
  output [4:0]  io_flags
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] result; // @[AecExecPort.scala 38:23]
  reg [4:0] flags; // @[AecExecPort.scala 39:22]
  reg  pending; // @[AecExecPort.scala 40:24]
  reg [63:0] stagedResult; // @[AecExecPort.scala 41:29]
  reg [4:0] stagedFlags; // @[AecExecPort.scala 42:28]
  assign io_result = result; // @[AecExecPort.scala 47:13]
  assign io_flags = flags; // @[AecExecPort.scala 48:12]
  always @(posedge clock) begin
    if (reset) begin // @[AecExecPort.scala 38:23]
      result <= 64'h0; // @[AecExecPort.scala 38:23]
    end else if (pending) begin // @[AecExecPort.scala 43:18]
      result <= stagedResult; // @[AecExecPort.scala 44:12]
    end
    if (reset) begin // @[AecExecPort.scala 39:22]
      flags <= 5'h0; // @[AecExecPort.scala 39:22]
    end else if (pending) begin // @[AecExecPort.scala 43:18]
      flags <= stagedFlags; // @[AecExecPort.scala 45:11]
    end
    if (reset) begin // @[AecExecPort.scala 40:24]
      pending <= 1'h0; // @[AecExecPort.scala 40:24]
    end else begin
      pending <= io_write; // @[AecExecPort.scala 40:24]
    end
    stagedResult <= io_writeResult; // @[AecExecPort.scala 41:29]
    stagedFlags <= io_writeFlags; // @[AecExecPort.scala 42:28]
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
  result = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  flags = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  pending = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  stagedResult = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  stagedFlags = _RAND_4[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecFp64Unit(
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
`endif // RANDOMIZE_REG_INIT
  wire  pipes_0_clock; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_reset; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_req_ready; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_req_valid; // @[AecFpWarpUnits.scala 120:45]
  wire [6:0] pipes_0_io_req_bits_op; // @[AecFpWarpUnits.scala 120:45]
  wire [3:0] pipes_0_io_req_bits_dtype; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_0_io_req_bits_a; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_0_io_req_bits_b; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_0_io_req_bits_c; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_resp_ready; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_resp_valid; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_resp_bits_predicate_result; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_0_io_resp_bits_error; // @[AecFpWarpUnits.scala 120:45]
  wire [4:0] pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_clock; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_reset; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_req_ready; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_req_valid; // @[AecFpWarpUnits.scala 120:45]
  wire [6:0] pipes_1_io_req_bits_op; // @[AecFpWarpUnits.scala 120:45]
  wire [3:0] pipes_1_io_req_bits_dtype; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_1_io_req_bits_a; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_1_io_req_bits_b; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_1_io_req_bits_c; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_resp_ready; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_resp_valid; // @[AecFpWarpUnits.scala 120:45]
  wire [63:0] pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_resp_bits_predicate_result; // @[AecFpWarpUnits.scala 120:45]
  wire  pipes_1_io_resp_bits_error; // @[AecFpWarpUnits.scala 120:45]
  wire [4:0] pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 120:45]
  wire  requestStages_0_clock; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_0_reset; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_0_io_inValid; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_0_io_inReady; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_group; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_0_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_0_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_0_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_0_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_0_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_1_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_1_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_1_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_1_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_1_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_2_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_2_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_2_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_2_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_2_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_3_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_3_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_3_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_3_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_3_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_4_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_4_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_4_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_4_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_4_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_5_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_5_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_5_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_5_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_5_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_6_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_6_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_6_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_6_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_6_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_7_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_7_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_7_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_7_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_7_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_8_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_8_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_8_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_8_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_8_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_9_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_9_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_9_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_9_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_9_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_10_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_10_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_10_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_10_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_10_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_11_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_11_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_11_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_11_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_11_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_12_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_12_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_12_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_12_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_12_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_13_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_13_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_13_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_13_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_13_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_14_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_14_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_14_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_14_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_14_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_data_15_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_data_15_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_15_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_15_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_data_15_c; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_0_io_out_ready; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_0_io_out_valid; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_0_io_out_bits_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_0_io_out_bits_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_out_bits_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_out_bits_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_0_io_out_bits_c; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_clock; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_reset; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_io_inValid; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_io_inReady; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_group; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_0_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_0_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_0_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_0_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_0_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_1_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_1_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_1_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_1_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_1_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_2_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_2_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_2_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_2_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_2_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_3_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_3_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_3_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_3_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_3_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_4_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_4_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_4_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_4_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_4_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_5_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_5_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_5_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_5_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_5_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_6_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_6_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_6_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_6_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_6_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_7_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_7_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_7_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_7_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_7_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_8_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_8_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_8_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_8_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_8_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_9_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_9_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_9_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_9_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_9_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_10_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_10_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_10_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_10_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_10_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_11_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_11_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_11_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_11_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_11_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_12_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_12_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_12_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_12_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_12_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_13_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_13_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_13_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_13_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_13_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_14_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_14_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_14_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_14_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_14_c; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_data_15_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_data_15_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_15_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_15_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_data_15_c; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_io_out_ready; // @[AecFpWarpUnits.scala 122:53]
  wire  requestStages_1_io_out_valid; // @[AecFpWarpUnits.scala 122:53]
  wire [6:0] requestStages_1_io_out_bits_op; // @[AecFpWarpUnits.scala 122:53]
  wire [3:0] requestStages_1_io_out_bits_dtype; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_out_bits_a; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_out_bits_b; // @[AecFpWarpUnits.scala 122:53]
  wire [63:0] requestStages_1_io_out_bits_c; // @[AecFpWarpUnits.scala 122:53]
  wire  requestBuffer_clock; // @[AecFpWarpUnits.scala 123:29]
  wire  requestBuffer_reset; // @[AecFpWarpUnits.scala 123:29]
  wire [31:0] requestBuffer_io_in_activeMask; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_a_31; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_b_31; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_in_c_31; // @[AecFpWarpUnits.scala 123:29]
  wire [7:0] requestBuffer_io_in_dest; // @[AecFpWarpUnits.scala 123:29]
  wire  requestBuffer_io_arm; // @[AecFpWarpUnits.scala 123:29]
  wire  requestBuffer_io_capture; // @[AecFpWarpUnits.scala 123:29]
  wire [31:0] requestBuffer_io_out_activeMask; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_a_31; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_b_31; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_0; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_1; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_2; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_3; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_4; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_5; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_6; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_7; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_8; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_9; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_10; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_11; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_12; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_13; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_14; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_15; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_16; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_17; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_18; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_19; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_20; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_21; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_22; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_23; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_24; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_25; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_26; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_27; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_28; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_29; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_30; // @[AecFpWarpUnits.scala 123:29]
  wire [63:0] requestBuffer_io_out_c_31; // @[AecFpWarpUnits.scala 123:29]
  wire [7:0] requestBuffer_io_out_dest; // @[AecFpWarpUnits.scala 123:29]
  wire  resultBanks_0_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_0_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_0_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_0_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_0_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_0_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_0_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_1_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_1_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_1_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_1_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_1_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_1_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_1_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_2_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_2_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_2_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_2_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_2_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_2_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_2_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_3_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_3_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_3_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_3_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_3_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_3_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_3_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_4_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_4_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_4_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_4_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_4_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_4_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_4_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_5_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_5_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_5_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_5_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_5_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_5_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_5_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_6_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_6_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_6_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_6_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_6_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_6_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_6_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_7_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_7_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_7_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_7_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_7_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_7_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_7_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_8_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_8_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_8_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_8_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_8_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_8_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_8_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_9_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_9_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_9_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_9_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_9_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_9_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_9_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_10_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_10_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_10_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_10_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_10_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_10_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_10_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_11_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_11_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_11_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_11_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_11_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_11_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_11_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_12_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_12_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_12_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_12_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_12_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_12_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_12_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_13_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_13_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_13_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_13_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_13_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_13_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_13_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_14_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_14_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_14_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_14_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_14_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_14_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_14_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_15_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_15_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_15_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_15_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_15_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_15_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_15_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_16_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_16_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_16_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_16_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_16_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_16_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_16_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_17_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_17_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_17_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_17_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_17_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_17_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_17_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_18_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_18_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_18_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_18_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_18_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_18_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_18_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_19_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_19_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_19_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_19_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_19_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_19_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_19_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_20_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_20_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_20_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_20_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_20_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_20_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_20_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_21_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_21_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_21_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_21_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_21_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_21_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_21_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_22_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_22_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_22_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_22_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_22_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_22_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_22_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_23_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_23_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_23_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_23_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_23_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_23_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_23_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_24_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_24_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_24_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_24_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_24_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_24_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_24_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_25_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_25_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_25_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_25_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_25_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_25_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_25_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_26_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_26_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_26_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_26_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_26_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_26_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_26_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_27_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_27_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_27_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_27_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_27_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_27_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_27_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_28_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_28_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_28_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_28_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_28_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_28_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_28_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_29_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_29_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_29_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_29_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_29_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_29_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_29_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_30_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_30_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_30_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_30_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_30_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_30_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_30_io_flags; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_31_clock; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_31_reset; // @[AecFpWarpUnits.scala 131:40]
  wire  resultBanks_31_io_write; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_31_io_writeResult; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_31_io_writeFlags; // @[AecFpWarpUnits.scala 131:40]
  wire [63:0] resultBanks_31_io_result; // @[AecFpWarpUnits.scala 131:40]
  wire [4:0] resultBanks_31_io_flags; // @[AecFpWarpUnits.scala 131:40]
  reg  capturePending; // @[AecFpWarpUnits.scala 126:31]
  reg [3:0] group; // @[AecFpWarpUnits.scala 127:22]
  reg  outValid; // @[AecFpWarpUnits.scala 127:91]
  reg  running; // @[AecFpWarpUnits.scala 128:24]
  reg  groupIssued; // @[AecFpWarpUnits.scala 129:28]
  reg  commitPending; // @[AecFpWarpUnits.scala 130:30]
  reg [31:0] predicates; // @[AecFpWarpUnits.scala 132:27]
  reg [31:0] errors; // @[AecFpWarpUnits.scala 132:60]
  reg [31:0] writeMask; // @[AecFpWarpUnits.scala 133:26]
  reg [6:0] laneOp_0; // @[AecFpWarpUnits.scala 134:19]
  reg [6:0] laneOp_1; // @[AecFpWarpUnits.scala 134:19]
  reg [3:0] laneDtype_0; // @[AecFpWarpUnits.scala 135:22]
  reg [3:0] laneDtype_1; // @[AecFpWarpUnits.scala 135:22]
  reg [7:0] laneDest_0; // @[AecFpWarpUnits.scala 136:21]
  reg [7:0] laneDest_1; // @[AecFpWarpUnits.scala 136:21]
  wire [5:0] base = group * 2'h2; // @[AecFpWarpUnits.scala 138:20]
  wire  allReady = requestStages_0_io_inReady & requestStages_1_io_inReady; // @[AecFpWarpUnits.scala 139:59]
  wire  allValid = pipes_0_io_resp_valid & pipes_1_io_resp_valid; // @[AecFpWarpUnits.scala 139:117]
  wire  _armCapture_T_3 = ~outValid; // @[AecFpWarpUnits.scala 140:51]
  wire  armCapture = ~capturePending & ~running & ~outValid & io_req_valid; // @[AecFpWarpUnits.scala 140:61]
  wire  _requestBuffer_io_capture_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _requestStages_0_io_inValid_T_1 = running & ~groupIssued; // @[AecFpWarpUnits.scala 151:44]
  wire [6:0] _groupPredicateBits_lane_T = {{1'd0}, base}; // @[AecFpWarpUnits.scala 166:21]
  wire [5:0] groupPredicateBits_lane = _groupPredicateBits_lane_T[5:0]; // @[AecFpWarpUnits.scala 166:21]
  wire [31:0] _groupPredicateBits_T = requestBuffer_io_out_activeMask >> groupPredicateBits_lane; // @[AecFpWarpUnits.scala 167:24]
  wire [94:0] _groupPredicateBits_T_3 = 95'h1 << groupPredicateBits_lane; // @[AecFpWarpUnits.scala 168:18]
  wire [31:0] _groupPredicateBits_T_5 = _groupPredicateBits_T[0] & pipes_0_io_resp_bits_predicate_result ?
    _groupPredicateBits_T_3[31:0] : 32'h0; // @[AecFpWarpUnits.scala 167:8]
  wire [5:0] groupPredicateBits_lane_1 = base + 6'h1; // @[AecFpWarpUnits.scala 166:21]
  wire [31:0] _groupPredicateBits_T_6 = requestBuffer_io_out_activeMask >> groupPredicateBits_lane_1; // @[AecFpWarpUnits.scala 167:24]
  wire [94:0] _groupPredicateBits_T_9 = 95'h1 << groupPredicateBits_lane_1; // @[AecFpWarpUnits.scala 168:18]
  wire [31:0] _groupPredicateBits_T_11 = _groupPredicateBits_T_6[0] & pipes_1_io_resp_bits_predicate_result ?
    _groupPredicateBits_T_9[31:0] : 32'h0; // @[AecFpWarpUnits.scala 167:8]
  wire [31:0] groupPredicateBits = _groupPredicateBits_T_5 | _groupPredicateBits_T_11; // @[AecFpWarpUnits.scala 169:14]
  wire [31:0] _groupErrorBits_T_5 = _groupPredicateBits_T[0] & pipes_0_io_resp_bits_error ? _groupPredicateBits_T_3[31:0
    ] : 32'h0; // @[AecFpWarpUnits.scala 172:8]
  wire [31:0] _groupErrorBits_T_11 = _groupPredicateBits_T_6[0] & pipes_1_io_resp_bits_error ? _groupPredicateBits_T_9[
    31:0] : 32'h0; // @[AecFpWarpUnits.scala 172:8]
  wire [31:0] groupErrorBits = _groupErrorBits_T_5 | _groupErrorBits_T_11; // @[AecFpWarpUnits.scala 174:14]
  wire  _resultBanks_30_io_write_T_3 = group == 4'hf; // @[AecFpWarpUnits.scala 177:90]
  wire  _GEN_0 = armCapture | capturePending; // @[AecFpWarpUnits.scala 181:21 126:31 181:38]
  wire [6:0] _laneOp_1_T_1 = io_req_bits_op[6:0] ^ 7'h1; // @[AecFpWarpUnits.scala 184:41]
  wire [3:0] _laneDtype_1_T = io_req_bits_dtype ^ 4'h1; // @[AecFpWarpUnits.scala 185:41]
  wire [7:0] _laneDest_1_T = io_req_bits_dest ^ 8'h1; // @[AecFpWarpUnits.scala 186:39]
  wire  _running_T = |io_req_bits_activeMask; // @[AecFpWarpUnits.scala 191:39]
  wire  _GEN_9 = _requestBuffer_io_capture_T ? 1'h0 : groupIssued; // @[AecFpWarpUnits.scala 182:22 189:17 129:28]
  wire  _GEN_10 = _requestBuffer_io_capture_T ? 1'h0 : commitPending; // @[AecFpWarpUnits.scala 182:22 190:19 130:30]
  wire  _GEN_11 = _requestBuffer_io_capture_T ? |io_req_bits_activeMask : running; // @[AecFpWarpUnits.scala 182:22 191:13 128:24]
  wire  _GEN_12 = _requestBuffer_io_capture_T ? ~_running_T : outValid; // @[AecFpWarpUnits.scala 182:22 192:14 127:91]
  wire  _T_131 = ~commitPending; // @[AecFpWarpUnits.scala 195:36]
  wire  _GEN_16 = _requestStages_0_io_inValid_T_1 & ~commitPending & allReady | _GEN_9; // @[AecFpWarpUnits.scala 195:{64,78}]
  wire [31:0] _predicates_T = predicates | groupPredicateBits; // @[AecFpWarpUnits.scala 198:30]
  wire [31:0] _errors_T = errors | groupErrorBits; // @[AecFpWarpUnits.scala 199:22]
  wire  _GEN_17 = running & groupIssued & _T_131 & allValid | _GEN_10; // @[AecFpWarpUnits.scala 196:63 197:19]
  wire [34:0] _groupMask_T_2 = 35'h4 - 35'h1; // @[AecFpWarpUnits.scala 203:53]
  wire [97:0] _GEN_1 = {{63'd0}, _groupMask_T_2}; // @[AecFpWarpUnits.scala 203:60]
  wire [97:0] _groupMask_T_3 = _GEN_1 << base; // @[AecFpWarpUnits.scala 203:60]
  wire [31:0] groupMask = _groupMask_T_3[31:0]; // @[AecFpWarpUnits.scala 203:68]
  wire [31:0] _writeMask_T = requestBuffer_io_out_activeMask & groupMask; // @[AecFpWarpUnits.scala 204:47]
  wire [31:0] _writeMask_T_1 = writeMask | _writeMask_T; // @[AecFpWarpUnits.scala 204:28]
  wire [3:0] _group_T_1 = group + 4'h1; // @[AecFpWarpUnits.scala 206:121]
  wire  _GEN_20 = _resultBanks_30_io_write_T_3 | _GEN_12; // @[AecFpWarpUnits.scala 206:{37,48}]
  wire  _T_139 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  AecFp64PipeUnit pipes_0 ( // @[AecFpWarpUnits.scala 120:45]
    .clock(pipes_0_clock),
    .reset(pipes_0_reset),
    .io_req_ready(pipes_0_io_req_ready),
    .io_req_valid(pipes_0_io_req_valid),
    .io_req_bits_op(pipes_0_io_req_bits_op),
    .io_req_bits_dtype(pipes_0_io_req_bits_dtype),
    .io_req_bits_a(pipes_0_io_req_bits_a),
    .io_req_bits_b(pipes_0_io_req_bits_b),
    .io_req_bits_c(pipes_0_io_req_bits_c),
    .io_resp_ready(pipes_0_io_resp_ready),
    .io_resp_valid(pipes_0_io_resp_valid),
    .io_resp_bits_result(pipes_0_io_resp_bits_result),
    .io_resp_bits_predicate_result(pipes_0_io_resp_bits_predicate_result),
    .io_resp_bits_error(pipes_0_io_resp_bits_error),
    .io_resp_bits_exception_flags(pipes_0_io_resp_bits_exception_flags)
  );
  AecFp64PipeUnit pipes_1 ( // @[AecFpWarpUnits.scala 120:45]
    .clock(pipes_1_clock),
    .reset(pipes_1_reset),
    .io_req_ready(pipes_1_io_req_ready),
    .io_req_valid(pipes_1_io_req_valid),
    .io_req_bits_op(pipes_1_io_req_bits_op),
    .io_req_bits_dtype(pipes_1_io_req_bits_dtype),
    .io_req_bits_a(pipes_1_io_req_bits_a),
    .io_req_bits_b(pipes_1_io_req_bits_b),
    .io_req_bits_c(pipes_1_io_req_bits_c),
    .io_resp_ready(pipes_1_io_resp_ready),
    .io_resp_valid(pipes_1_io_resp_valid),
    .io_resp_bits_result(pipes_1_io_resp_bits_result),
    .io_resp_bits_predicate_result(pipes_1_io_resp_bits_predicate_result),
    .io_resp_bits_error(pipes_1_io_resp_bits_error),
    .io_resp_bits_exception_flags(pipes_1_io_resp_bits_exception_flags)
  );
  AecFpWarpRequestStage requestStages_0 ( // @[AecFpWarpUnits.scala 122:53]
    .clock(requestStages_0_clock),
    .reset(requestStages_0_reset),
    .io_inValid(requestStages_0_io_inValid),
    .io_inReady(requestStages_0_io_inReady),
    .io_group(requestStages_0_io_group),
    .io_data_0_op(requestStages_0_io_data_0_op),
    .io_data_0_dtype(requestStages_0_io_data_0_dtype),
    .io_data_0_a(requestStages_0_io_data_0_a),
    .io_data_0_b(requestStages_0_io_data_0_b),
    .io_data_0_c(requestStages_0_io_data_0_c),
    .io_data_1_op(requestStages_0_io_data_1_op),
    .io_data_1_dtype(requestStages_0_io_data_1_dtype),
    .io_data_1_a(requestStages_0_io_data_1_a),
    .io_data_1_b(requestStages_0_io_data_1_b),
    .io_data_1_c(requestStages_0_io_data_1_c),
    .io_data_2_op(requestStages_0_io_data_2_op),
    .io_data_2_dtype(requestStages_0_io_data_2_dtype),
    .io_data_2_a(requestStages_0_io_data_2_a),
    .io_data_2_b(requestStages_0_io_data_2_b),
    .io_data_2_c(requestStages_0_io_data_2_c),
    .io_data_3_op(requestStages_0_io_data_3_op),
    .io_data_3_dtype(requestStages_0_io_data_3_dtype),
    .io_data_3_a(requestStages_0_io_data_3_a),
    .io_data_3_b(requestStages_0_io_data_3_b),
    .io_data_3_c(requestStages_0_io_data_3_c),
    .io_data_4_op(requestStages_0_io_data_4_op),
    .io_data_4_dtype(requestStages_0_io_data_4_dtype),
    .io_data_4_a(requestStages_0_io_data_4_a),
    .io_data_4_b(requestStages_0_io_data_4_b),
    .io_data_4_c(requestStages_0_io_data_4_c),
    .io_data_5_op(requestStages_0_io_data_5_op),
    .io_data_5_dtype(requestStages_0_io_data_5_dtype),
    .io_data_5_a(requestStages_0_io_data_5_a),
    .io_data_5_b(requestStages_0_io_data_5_b),
    .io_data_5_c(requestStages_0_io_data_5_c),
    .io_data_6_op(requestStages_0_io_data_6_op),
    .io_data_6_dtype(requestStages_0_io_data_6_dtype),
    .io_data_6_a(requestStages_0_io_data_6_a),
    .io_data_6_b(requestStages_0_io_data_6_b),
    .io_data_6_c(requestStages_0_io_data_6_c),
    .io_data_7_op(requestStages_0_io_data_7_op),
    .io_data_7_dtype(requestStages_0_io_data_7_dtype),
    .io_data_7_a(requestStages_0_io_data_7_a),
    .io_data_7_b(requestStages_0_io_data_7_b),
    .io_data_7_c(requestStages_0_io_data_7_c),
    .io_data_8_op(requestStages_0_io_data_8_op),
    .io_data_8_dtype(requestStages_0_io_data_8_dtype),
    .io_data_8_a(requestStages_0_io_data_8_a),
    .io_data_8_b(requestStages_0_io_data_8_b),
    .io_data_8_c(requestStages_0_io_data_8_c),
    .io_data_9_op(requestStages_0_io_data_9_op),
    .io_data_9_dtype(requestStages_0_io_data_9_dtype),
    .io_data_9_a(requestStages_0_io_data_9_a),
    .io_data_9_b(requestStages_0_io_data_9_b),
    .io_data_9_c(requestStages_0_io_data_9_c),
    .io_data_10_op(requestStages_0_io_data_10_op),
    .io_data_10_dtype(requestStages_0_io_data_10_dtype),
    .io_data_10_a(requestStages_0_io_data_10_a),
    .io_data_10_b(requestStages_0_io_data_10_b),
    .io_data_10_c(requestStages_0_io_data_10_c),
    .io_data_11_op(requestStages_0_io_data_11_op),
    .io_data_11_dtype(requestStages_0_io_data_11_dtype),
    .io_data_11_a(requestStages_0_io_data_11_a),
    .io_data_11_b(requestStages_0_io_data_11_b),
    .io_data_11_c(requestStages_0_io_data_11_c),
    .io_data_12_op(requestStages_0_io_data_12_op),
    .io_data_12_dtype(requestStages_0_io_data_12_dtype),
    .io_data_12_a(requestStages_0_io_data_12_a),
    .io_data_12_b(requestStages_0_io_data_12_b),
    .io_data_12_c(requestStages_0_io_data_12_c),
    .io_data_13_op(requestStages_0_io_data_13_op),
    .io_data_13_dtype(requestStages_0_io_data_13_dtype),
    .io_data_13_a(requestStages_0_io_data_13_a),
    .io_data_13_b(requestStages_0_io_data_13_b),
    .io_data_13_c(requestStages_0_io_data_13_c),
    .io_data_14_op(requestStages_0_io_data_14_op),
    .io_data_14_dtype(requestStages_0_io_data_14_dtype),
    .io_data_14_a(requestStages_0_io_data_14_a),
    .io_data_14_b(requestStages_0_io_data_14_b),
    .io_data_14_c(requestStages_0_io_data_14_c),
    .io_data_15_op(requestStages_0_io_data_15_op),
    .io_data_15_dtype(requestStages_0_io_data_15_dtype),
    .io_data_15_a(requestStages_0_io_data_15_a),
    .io_data_15_b(requestStages_0_io_data_15_b),
    .io_data_15_c(requestStages_0_io_data_15_c),
    .io_out_ready(requestStages_0_io_out_ready),
    .io_out_valid(requestStages_0_io_out_valid),
    .io_out_bits_op(requestStages_0_io_out_bits_op),
    .io_out_bits_dtype(requestStages_0_io_out_bits_dtype),
    .io_out_bits_a(requestStages_0_io_out_bits_a),
    .io_out_bits_b(requestStages_0_io_out_bits_b),
    .io_out_bits_c(requestStages_0_io_out_bits_c)
  );
  AecFpWarpRequestStage requestStages_1 ( // @[AecFpWarpUnits.scala 122:53]
    .clock(requestStages_1_clock),
    .reset(requestStages_1_reset),
    .io_inValid(requestStages_1_io_inValid),
    .io_inReady(requestStages_1_io_inReady),
    .io_group(requestStages_1_io_group),
    .io_data_0_op(requestStages_1_io_data_0_op),
    .io_data_0_dtype(requestStages_1_io_data_0_dtype),
    .io_data_0_a(requestStages_1_io_data_0_a),
    .io_data_0_b(requestStages_1_io_data_0_b),
    .io_data_0_c(requestStages_1_io_data_0_c),
    .io_data_1_op(requestStages_1_io_data_1_op),
    .io_data_1_dtype(requestStages_1_io_data_1_dtype),
    .io_data_1_a(requestStages_1_io_data_1_a),
    .io_data_1_b(requestStages_1_io_data_1_b),
    .io_data_1_c(requestStages_1_io_data_1_c),
    .io_data_2_op(requestStages_1_io_data_2_op),
    .io_data_2_dtype(requestStages_1_io_data_2_dtype),
    .io_data_2_a(requestStages_1_io_data_2_a),
    .io_data_2_b(requestStages_1_io_data_2_b),
    .io_data_2_c(requestStages_1_io_data_2_c),
    .io_data_3_op(requestStages_1_io_data_3_op),
    .io_data_3_dtype(requestStages_1_io_data_3_dtype),
    .io_data_3_a(requestStages_1_io_data_3_a),
    .io_data_3_b(requestStages_1_io_data_3_b),
    .io_data_3_c(requestStages_1_io_data_3_c),
    .io_data_4_op(requestStages_1_io_data_4_op),
    .io_data_4_dtype(requestStages_1_io_data_4_dtype),
    .io_data_4_a(requestStages_1_io_data_4_a),
    .io_data_4_b(requestStages_1_io_data_4_b),
    .io_data_4_c(requestStages_1_io_data_4_c),
    .io_data_5_op(requestStages_1_io_data_5_op),
    .io_data_5_dtype(requestStages_1_io_data_5_dtype),
    .io_data_5_a(requestStages_1_io_data_5_a),
    .io_data_5_b(requestStages_1_io_data_5_b),
    .io_data_5_c(requestStages_1_io_data_5_c),
    .io_data_6_op(requestStages_1_io_data_6_op),
    .io_data_6_dtype(requestStages_1_io_data_6_dtype),
    .io_data_6_a(requestStages_1_io_data_6_a),
    .io_data_6_b(requestStages_1_io_data_6_b),
    .io_data_6_c(requestStages_1_io_data_6_c),
    .io_data_7_op(requestStages_1_io_data_7_op),
    .io_data_7_dtype(requestStages_1_io_data_7_dtype),
    .io_data_7_a(requestStages_1_io_data_7_a),
    .io_data_7_b(requestStages_1_io_data_7_b),
    .io_data_7_c(requestStages_1_io_data_7_c),
    .io_data_8_op(requestStages_1_io_data_8_op),
    .io_data_8_dtype(requestStages_1_io_data_8_dtype),
    .io_data_8_a(requestStages_1_io_data_8_a),
    .io_data_8_b(requestStages_1_io_data_8_b),
    .io_data_8_c(requestStages_1_io_data_8_c),
    .io_data_9_op(requestStages_1_io_data_9_op),
    .io_data_9_dtype(requestStages_1_io_data_9_dtype),
    .io_data_9_a(requestStages_1_io_data_9_a),
    .io_data_9_b(requestStages_1_io_data_9_b),
    .io_data_9_c(requestStages_1_io_data_9_c),
    .io_data_10_op(requestStages_1_io_data_10_op),
    .io_data_10_dtype(requestStages_1_io_data_10_dtype),
    .io_data_10_a(requestStages_1_io_data_10_a),
    .io_data_10_b(requestStages_1_io_data_10_b),
    .io_data_10_c(requestStages_1_io_data_10_c),
    .io_data_11_op(requestStages_1_io_data_11_op),
    .io_data_11_dtype(requestStages_1_io_data_11_dtype),
    .io_data_11_a(requestStages_1_io_data_11_a),
    .io_data_11_b(requestStages_1_io_data_11_b),
    .io_data_11_c(requestStages_1_io_data_11_c),
    .io_data_12_op(requestStages_1_io_data_12_op),
    .io_data_12_dtype(requestStages_1_io_data_12_dtype),
    .io_data_12_a(requestStages_1_io_data_12_a),
    .io_data_12_b(requestStages_1_io_data_12_b),
    .io_data_12_c(requestStages_1_io_data_12_c),
    .io_data_13_op(requestStages_1_io_data_13_op),
    .io_data_13_dtype(requestStages_1_io_data_13_dtype),
    .io_data_13_a(requestStages_1_io_data_13_a),
    .io_data_13_b(requestStages_1_io_data_13_b),
    .io_data_13_c(requestStages_1_io_data_13_c),
    .io_data_14_op(requestStages_1_io_data_14_op),
    .io_data_14_dtype(requestStages_1_io_data_14_dtype),
    .io_data_14_a(requestStages_1_io_data_14_a),
    .io_data_14_b(requestStages_1_io_data_14_b),
    .io_data_14_c(requestStages_1_io_data_14_c),
    .io_data_15_op(requestStages_1_io_data_15_op),
    .io_data_15_dtype(requestStages_1_io_data_15_dtype),
    .io_data_15_a(requestStages_1_io_data_15_a),
    .io_data_15_b(requestStages_1_io_data_15_b),
    .io_data_15_c(requestStages_1_io_data_15_c),
    .io_out_ready(requestStages_1_io_out_ready),
    .io_out_valid(requestStages_1_io_out_valid),
    .io_out_bits_op(requestStages_1_io_out_bits_op),
    .io_out_bits_dtype(requestStages_1_io_out_bits_dtype),
    .io_out_bits_a(requestStages_1_io_out_bits_a),
    .io_out_bits_b(requestStages_1_io_out_bits_b),
    .io_out_bits_c(requestStages_1_io_out_bits_c)
  );
  AecWarpRequestBuffer requestBuffer ( // @[AecFpWarpUnits.scala 123:29]
    .clock(requestBuffer_clock),
    .reset(requestBuffer_reset),
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
    .io_in_c_0(requestBuffer_io_in_c_0),
    .io_in_c_1(requestBuffer_io_in_c_1),
    .io_in_c_2(requestBuffer_io_in_c_2),
    .io_in_c_3(requestBuffer_io_in_c_3),
    .io_in_c_4(requestBuffer_io_in_c_4),
    .io_in_c_5(requestBuffer_io_in_c_5),
    .io_in_c_6(requestBuffer_io_in_c_6),
    .io_in_c_7(requestBuffer_io_in_c_7),
    .io_in_c_8(requestBuffer_io_in_c_8),
    .io_in_c_9(requestBuffer_io_in_c_9),
    .io_in_c_10(requestBuffer_io_in_c_10),
    .io_in_c_11(requestBuffer_io_in_c_11),
    .io_in_c_12(requestBuffer_io_in_c_12),
    .io_in_c_13(requestBuffer_io_in_c_13),
    .io_in_c_14(requestBuffer_io_in_c_14),
    .io_in_c_15(requestBuffer_io_in_c_15),
    .io_in_c_16(requestBuffer_io_in_c_16),
    .io_in_c_17(requestBuffer_io_in_c_17),
    .io_in_c_18(requestBuffer_io_in_c_18),
    .io_in_c_19(requestBuffer_io_in_c_19),
    .io_in_c_20(requestBuffer_io_in_c_20),
    .io_in_c_21(requestBuffer_io_in_c_21),
    .io_in_c_22(requestBuffer_io_in_c_22),
    .io_in_c_23(requestBuffer_io_in_c_23),
    .io_in_c_24(requestBuffer_io_in_c_24),
    .io_in_c_25(requestBuffer_io_in_c_25),
    .io_in_c_26(requestBuffer_io_in_c_26),
    .io_in_c_27(requestBuffer_io_in_c_27),
    .io_in_c_28(requestBuffer_io_in_c_28),
    .io_in_c_29(requestBuffer_io_in_c_29),
    .io_in_c_30(requestBuffer_io_in_c_30),
    .io_in_c_31(requestBuffer_io_in_c_31),
    .io_in_dest(requestBuffer_io_in_dest),
    .io_arm(requestBuffer_io_arm),
    .io_capture(requestBuffer_io_capture),
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
    .io_out_c_0(requestBuffer_io_out_c_0),
    .io_out_c_1(requestBuffer_io_out_c_1),
    .io_out_c_2(requestBuffer_io_out_c_2),
    .io_out_c_3(requestBuffer_io_out_c_3),
    .io_out_c_4(requestBuffer_io_out_c_4),
    .io_out_c_5(requestBuffer_io_out_c_5),
    .io_out_c_6(requestBuffer_io_out_c_6),
    .io_out_c_7(requestBuffer_io_out_c_7),
    .io_out_c_8(requestBuffer_io_out_c_8),
    .io_out_c_9(requestBuffer_io_out_c_9),
    .io_out_c_10(requestBuffer_io_out_c_10),
    .io_out_c_11(requestBuffer_io_out_c_11),
    .io_out_c_12(requestBuffer_io_out_c_12),
    .io_out_c_13(requestBuffer_io_out_c_13),
    .io_out_c_14(requestBuffer_io_out_c_14),
    .io_out_c_15(requestBuffer_io_out_c_15),
    .io_out_c_16(requestBuffer_io_out_c_16),
    .io_out_c_17(requestBuffer_io_out_c_17),
    .io_out_c_18(requestBuffer_io_out_c_18),
    .io_out_c_19(requestBuffer_io_out_c_19),
    .io_out_c_20(requestBuffer_io_out_c_20),
    .io_out_c_21(requestBuffer_io_out_c_21),
    .io_out_c_22(requestBuffer_io_out_c_22),
    .io_out_c_23(requestBuffer_io_out_c_23),
    .io_out_c_24(requestBuffer_io_out_c_24),
    .io_out_c_25(requestBuffer_io_out_c_25),
    .io_out_c_26(requestBuffer_io_out_c_26),
    .io_out_c_27(requestBuffer_io_out_c_27),
    .io_out_c_28(requestBuffer_io_out_c_28),
    .io_out_c_29(requestBuffer_io_out_c_29),
    .io_out_c_30(requestBuffer_io_out_c_30),
    .io_out_c_31(requestBuffer_io_out_c_31),
    .io_out_dest(requestBuffer_io_out_dest)
  );
  AecResultLaneBank resultBanks_0 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_0_clock),
    .reset(resultBanks_0_reset),
    .io_write(resultBanks_0_io_write),
    .io_writeResult(resultBanks_0_io_writeResult),
    .io_writeFlags(resultBanks_0_io_writeFlags),
    .io_result(resultBanks_0_io_result),
    .io_flags(resultBanks_0_io_flags)
  );
  AecResultLaneBank resultBanks_1 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_1_clock),
    .reset(resultBanks_1_reset),
    .io_write(resultBanks_1_io_write),
    .io_writeResult(resultBanks_1_io_writeResult),
    .io_writeFlags(resultBanks_1_io_writeFlags),
    .io_result(resultBanks_1_io_result),
    .io_flags(resultBanks_1_io_flags)
  );
  AecResultLaneBank resultBanks_2 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_2_clock),
    .reset(resultBanks_2_reset),
    .io_write(resultBanks_2_io_write),
    .io_writeResult(resultBanks_2_io_writeResult),
    .io_writeFlags(resultBanks_2_io_writeFlags),
    .io_result(resultBanks_2_io_result),
    .io_flags(resultBanks_2_io_flags)
  );
  AecResultLaneBank resultBanks_3 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_3_clock),
    .reset(resultBanks_3_reset),
    .io_write(resultBanks_3_io_write),
    .io_writeResult(resultBanks_3_io_writeResult),
    .io_writeFlags(resultBanks_3_io_writeFlags),
    .io_result(resultBanks_3_io_result),
    .io_flags(resultBanks_3_io_flags)
  );
  AecResultLaneBank resultBanks_4 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_4_clock),
    .reset(resultBanks_4_reset),
    .io_write(resultBanks_4_io_write),
    .io_writeResult(resultBanks_4_io_writeResult),
    .io_writeFlags(resultBanks_4_io_writeFlags),
    .io_result(resultBanks_4_io_result),
    .io_flags(resultBanks_4_io_flags)
  );
  AecResultLaneBank resultBanks_5 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_5_clock),
    .reset(resultBanks_5_reset),
    .io_write(resultBanks_5_io_write),
    .io_writeResult(resultBanks_5_io_writeResult),
    .io_writeFlags(resultBanks_5_io_writeFlags),
    .io_result(resultBanks_5_io_result),
    .io_flags(resultBanks_5_io_flags)
  );
  AecResultLaneBank resultBanks_6 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_6_clock),
    .reset(resultBanks_6_reset),
    .io_write(resultBanks_6_io_write),
    .io_writeResult(resultBanks_6_io_writeResult),
    .io_writeFlags(resultBanks_6_io_writeFlags),
    .io_result(resultBanks_6_io_result),
    .io_flags(resultBanks_6_io_flags)
  );
  AecResultLaneBank resultBanks_7 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_7_clock),
    .reset(resultBanks_7_reset),
    .io_write(resultBanks_7_io_write),
    .io_writeResult(resultBanks_7_io_writeResult),
    .io_writeFlags(resultBanks_7_io_writeFlags),
    .io_result(resultBanks_7_io_result),
    .io_flags(resultBanks_7_io_flags)
  );
  AecResultLaneBank resultBanks_8 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_8_clock),
    .reset(resultBanks_8_reset),
    .io_write(resultBanks_8_io_write),
    .io_writeResult(resultBanks_8_io_writeResult),
    .io_writeFlags(resultBanks_8_io_writeFlags),
    .io_result(resultBanks_8_io_result),
    .io_flags(resultBanks_8_io_flags)
  );
  AecResultLaneBank resultBanks_9 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_9_clock),
    .reset(resultBanks_9_reset),
    .io_write(resultBanks_9_io_write),
    .io_writeResult(resultBanks_9_io_writeResult),
    .io_writeFlags(resultBanks_9_io_writeFlags),
    .io_result(resultBanks_9_io_result),
    .io_flags(resultBanks_9_io_flags)
  );
  AecResultLaneBank resultBanks_10 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_10_clock),
    .reset(resultBanks_10_reset),
    .io_write(resultBanks_10_io_write),
    .io_writeResult(resultBanks_10_io_writeResult),
    .io_writeFlags(resultBanks_10_io_writeFlags),
    .io_result(resultBanks_10_io_result),
    .io_flags(resultBanks_10_io_flags)
  );
  AecResultLaneBank resultBanks_11 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_11_clock),
    .reset(resultBanks_11_reset),
    .io_write(resultBanks_11_io_write),
    .io_writeResult(resultBanks_11_io_writeResult),
    .io_writeFlags(resultBanks_11_io_writeFlags),
    .io_result(resultBanks_11_io_result),
    .io_flags(resultBanks_11_io_flags)
  );
  AecResultLaneBank resultBanks_12 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_12_clock),
    .reset(resultBanks_12_reset),
    .io_write(resultBanks_12_io_write),
    .io_writeResult(resultBanks_12_io_writeResult),
    .io_writeFlags(resultBanks_12_io_writeFlags),
    .io_result(resultBanks_12_io_result),
    .io_flags(resultBanks_12_io_flags)
  );
  AecResultLaneBank resultBanks_13 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_13_clock),
    .reset(resultBanks_13_reset),
    .io_write(resultBanks_13_io_write),
    .io_writeResult(resultBanks_13_io_writeResult),
    .io_writeFlags(resultBanks_13_io_writeFlags),
    .io_result(resultBanks_13_io_result),
    .io_flags(resultBanks_13_io_flags)
  );
  AecResultLaneBank resultBanks_14 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_14_clock),
    .reset(resultBanks_14_reset),
    .io_write(resultBanks_14_io_write),
    .io_writeResult(resultBanks_14_io_writeResult),
    .io_writeFlags(resultBanks_14_io_writeFlags),
    .io_result(resultBanks_14_io_result),
    .io_flags(resultBanks_14_io_flags)
  );
  AecResultLaneBank resultBanks_15 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_15_clock),
    .reset(resultBanks_15_reset),
    .io_write(resultBanks_15_io_write),
    .io_writeResult(resultBanks_15_io_writeResult),
    .io_writeFlags(resultBanks_15_io_writeFlags),
    .io_result(resultBanks_15_io_result),
    .io_flags(resultBanks_15_io_flags)
  );
  AecResultLaneBank resultBanks_16 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_16_clock),
    .reset(resultBanks_16_reset),
    .io_write(resultBanks_16_io_write),
    .io_writeResult(resultBanks_16_io_writeResult),
    .io_writeFlags(resultBanks_16_io_writeFlags),
    .io_result(resultBanks_16_io_result),
    .io_flags(resultBanks_16_io_flags)
  );
  AecResultLaneBank resultBanks_17 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_17_clock),
    .reset(resultBanks_17_reset),
    .io_write(resultBanks_17_io_write),
    .io_writeResult(resultBanks_17_io_writeResult),
    .io_writeFlags(resultBanks_17_io_writeFlags),
    .io_result(resultBanks_17_io_result),
    .io_flags(resultBanks_17_io_flags)
  );
  AecResultLaneBank resultBanks_18 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_18_clock),
    .reset(resultBanks_18_reset),
    .io_write(resultBanks_18_io_write),
    .io_writeResult(resultBanks_18_io_writeResult),
    .io_writeFlags(resultBanks_18_io_writeFlags),
    .io_result(resultBanks_18_io_result),
    .io_flags(resultBanks_18_io_flags)
  );
  AecResultLaneBank resultBanks_19 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_19_clock),
    .reset(resultBanks_19_reset),
    .io_write(resultBanks_19_io_write),
    .io_writeResult(resultBanks_19_io_writeResult),
    .io_writeFlags(resultBanks_19_io_writeFlags),
    .io_result(resultBanks_19_io_result),
    .io_flags(resultBanks_19_io_flags)
  );
  AecResultLaneBank resultBanks_20 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_20_clock),
    .reset(resultBanks_20_reset),
    .io_write(resultBanks_20_io_write),
    .io_writeResult(resultBanks_20_io_writeResult),
    .io_writeFlags(resultBanks_20_io_writeFlags),
    .io_result(resultBanks_20_io_result),
    .io_flags(resultBanks_20_io_flags)
  );
  AecResultLaneBank resultBanks_21 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_21_clock),
    .reset(resultBanks_21_reset),
    .io_write(resultBanks_21_io_write),
    .io_writeResult(resultBanks_21_io_writeResult),
    .io_writeFlags(resultBanks_21_io_writeFlags),
    .io_result(resultBanks_21_io_result),
    .io_flags(resultBanks_21_io_flags)
  );
  AecResultLaneBank resultBanks_22 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_22_clock),
    .reset(resultBanks_22_reset),
    .io_write(resultBanks_22_io_write),
    .io_writeResult(resultBanks_22_io_writeResult),
    .io_writeFlags(resultBanks_22_io_writeFlags),
    .io_result(resultBanks_22_io_result),
    .io_flags(resultBanks_22_io_flags)
  );
  AecResultLaneBank resultBanks_23 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_23_clock),
    .reset(resultBanks_23_reset),
    .io_write(resultBanks_23_io_write),
    .io_writeResult(resultBanks_23_io_writeResult),
    .io_writeFlags(resultBanks_23_io_writeFlags),
    .io_result(resultBanks_23_io_result),
    .io_flags(resultBanks_23_io_flags)
  );
  AecResultLaneBank resultBanks_24 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_24_clock),
    .reset(resultBanks_24_reset),
    .io_write(resultBanks_24_io_write),
    .io_writeResult(resultBanks_24_io_writeResult),
    .io_writeFlags(resultBanks_24_io_writeFlags),
    .io_result(resultBanks_24_io_result),
    .io_flags(resultBanks_24_io_flags)
  );
  AecResultLaneBank resultBanks_25 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_25_clock),
    .reset(resultBanks_25_reset),
    .io_write(resultBanks_25_io_write),
    .io_writeResult(resultBanks_25_io_writeResult),
    .io_writeFlags(resultBanks_25_io_writeFlags),
    .io_result(resultBanks_25_io_result),
    .io_flags(resultBanks_25_io_flags)
  );
  AecResultLaneBank resultBanks_26 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_26_clock),
    .reset(resultBanks_26_reset),
    .io_write(resultBanks_26_io_write),
    .io_writeResult(resultBanks_26_io_writeResult),
    .io_writeFlags(resultBanks_26_io_writeFlags),
    .io_result(resultBanks_26_io_result),
    .io_flags(resultBanks_26_io_flags)
  );
  AecResultLaneBank resultBanks_27 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_27_clock),
    .reset(resultBanks_27_reset),
    .io_write(resultBanks_27_io_write),
    .io_writeResult(resultBanks_27_io_writeResult),
    .io_writeFlags(resultBanks_27_io_writeFlags),
    .io_result(resultBanks_27_io_result),
    .io_flags(resultBanks_27_io_flags)
  );
  AecResultLaneBank resultBanks_28 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_28_clock),
    .reset(resultBanks_28_reset),
    .io_write(resultBanks_28_io_write),
    .io_writeResult(resultBanks_28_io_writeResult),
    .io_writeFlags(resultBanks_28_io_writeFlags),
    .io_result(resultBanks_28_io_result),
    .io_flags(resultBanks_28_io_flags)
  );
  AecResultLaneBank resultBanks_29 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_29_clock),
    .reset(resultBanks_29_reset),
    .io_write(resultBanks_29_io_write),
    .io_writeResult(resultBanks_29_io_writeResult),
    .io_writeFlags(resultBanks_29_io_writeFlags),
    .io_result(resultBanks_29_io_result),
    .io_flags(resultBanks_29_io_flags)
  );
  AecResultLaneBank resultBanks_30 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_30_clock),
    .reset(resultBanks_30_reset),
    .io_write(resultBanks_30_io_write),
    .io_writeResult(resultBanks_30_io_writeResult),
    .io_writeFlags(resultBanks_30_io_writeFlags),
    .io_result(resultBanks_30_io_result),
    .io_flags(resultBanks_30_io_flags)
  );
  AecResultLaneBank resultBanks_31 ( // @[AecFpWarpUnits.scala 131:40]
    .clock(resultBanks_31_clock),
    .reset(resultBanks_31_reset),
    .io_write(resultBanks_31_io_write),
    .io_writeResult(resultBanks_31_io_writeResult),
    .io_writeFlags(resultBanks_31_io_writeFlags),
    .io_result(resultBanks_31_io_result),
    .io_flags(resultBanks_31_io_flags)
  );
  assign io_req_ready = capturePending; // @[AecFpWarpUnits.scala 143:16]
  assign io_resp_valid = outValid; // @[AecFpWarpUnits.scala 144:17]
  assign io_resp_bits_result_0 = writeMask[0] ? resultBanks_0_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_1 = writeMask[1] ? resultBanks_1_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_2 = writeMask[2] ? resultBanks_2_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_3 = writeMask[3] ? resultBanks_3_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_4 = writeMask[4] ? resultBanks_4_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_5 = writeMask[5] ? resultBanks_5_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_6 = writeMask[6] ? resultBanks_6_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_7 = writeMask[7] ? resultBanks_7_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_8 = writeMask[8] ? resultBanks_8_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_9 = writeMask[9] ? resultBanks_9_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_10 = writeMask[10] ? resultBanks_10_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_11 = writeMask[11] ? resultBanks_11_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_12 = writeMask[12] ? resultBanks_12_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_13 = writeMask[13] ? resultBanks_13_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_14 = writeMask[14] ? resultBanks_14_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_15 = writeMask[15] ? resultBanks_15_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_16 = writeMask[16] ? resultBanks_16_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_17 = writeMask[17] ? resultBanks_17_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_18 = writeMask[18] ? resultBanks_18_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_19 = writeMask[19] ? resultBanks_19_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_20 = writeMask[20] ? resultBanks_20_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_21 = writeMask[21] ? resultBanks_21_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_22 = writeMask[22] ? resultBanks_22_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_23 = writeMask[23] ? resultBanks_23_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_24 = writeMask[24] ? resultBanks_24_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_25 = writeMask[25] ? resultBanks_25_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_26 = writeMask[26] ? resultBanks_26_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_27 = writeMask[27] ? resultBanks_27_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_28 = writeMask[28] ? resultBanks_28_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_29 = writeMask[29] ? resultBanks_29_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_30 = writeMask[30] ? resultBanks_30_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_result_31 = writeMask[31] ? resultBanks_31_io_result : 64'h0; // @[AecFpWarpUnits.scala 145:59]
  assign io_resp_bits_predicateMask = predicates; // @[AecFpWarpUnits.scala 146:30]
  assign io_resp_bits_errorMask = errors; // @[AecFpWarpUnits.scala 147:26]
  assign io_resp_bits_exceptionFlags_0 = writeMask[0] ? resultBanks_0_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_1 = writeMask[1] ? resultBanks_1_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_2 = writeMask[2] ? resultBanks_2_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_3 = writeMask[3] ? resultBanks_3_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_4 = writeMask[4] ? resultBanks_4_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_5 = writeMask[5] ? resultBanks_5_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_6 = writeMask[6] ? resultBanks_6_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_7 = writeMask[7] ? resultBanks_7_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_8 = writeMask[8] ? resultBanks_8_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_9 = writeMask[9] ? resultBanks_9_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_10 = writeMask[10] ? resultBanks_10_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_11 = writeMask[11] ? resultBanks_11_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_12 = writeMask[12] ? resultBanks_12_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_13 = writeMask[13] ? resultBanks_13_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_14 = writeMask[14] ? resultBanks_14_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_15 = writeMask[15] ? resultBanks_15_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_16 = writeMask[16] ? resultBanks_16_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_17 = writeMask[17] ? resultBanks_17_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_18 = writeMask[18] ? resultBanks_18_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_19 = writeMask[19] ? resultBanks_19_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_20 = writeMask[20] ? resultBanks_20_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_21 = writeMask[21] ? resultBanks_21_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_22 = writeMask[22] ? resultBanks_22_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_23 = writeMask[23] ? resultBanks_23_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_24 = writeMask[24] ? resultBanks_24_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_25 = writeMask[25] ? resultBanks_25_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_26 = writeMask[26] ? resultBanks_26_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_27 = writeMask[27] ? resultBanks_27_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_28 = writeMask[28] ? resultBanks_28_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_29 = writeMask[29] ? resultBanks_29_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_30 = writeMask[30] ? resultBanks_30_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_exceptionFlags_31 = writeMask[31] ? resultBanks_31_io_flags : 5'h0; // @[AecFpWarpUnits.scala 148:67]
  assign io_resp_bits_activeMask = requestBuffer_io_out_activeMask; // @[AecFpWarpUnits.scala 149:27]
  assign io_resp_bits_dest = requestBuffer_io_out_dest; // @[AecFpWarpUnits.scala 149:65]
  assign pipes_0_clock = clock;
  assign pipes_0_reset = reset;
  assign pipes_0_io_req_valid = requestStages_0_io_out_valid; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_req_bits_op = requestStages_0_io_out_bits_op; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_req_bits_dtype = requestStages_0_io_out_bits_dtype; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_req_bits_a = requestStages_0_io_out_bits_a; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_req_bits_b = requestStages_0_io_out_bits_b; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_req_bits_c = requestStages_0_io_out_bits_c; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_0_io_resp_ready = _armCapture_T_3 & allValid; // @[AecFpWarpUnits.scala 163:41]
  assign pipes_1_clock = clock;
  assign pipes_1_reset = reset;
  assign pipes_1_io_req_valid = requestStages_1_io_out_valid; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_req_bits_op = requestStages_1_io_out_bits_op; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_req_bits_dtype = requestStages_1_io_out_bits_dtype; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_req_bits_a = requestStages_1_io_out_bits_a; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_req_bits_b = requestStages_1_io_out_bits_b; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_req_bits_c = requestStages_1_io_out_bits_c; // @[AecFpWarpUnits.scala 162:21]
  assign pipes_1_io_resp_ready = _armCapture_T_3 & allValid; // @[AecFpWarpUnits.scala 163:41]
  assign requestStages_0_clock = clock;
  assign requestStages_0_reset = reset;
  assign requestStages_0_io_inValid = running & ~groupIssued & |requestBuffer_io_out_activeMask & _armCapture_T_3 &
    allReady; // @[AecFpWarpUnits.scala 151:116]
  assign requestStages_0_io_group = group; // @[AecFpWarpUnits.scala 152:31]
  assign requestStages_0_io_data_0_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_0_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_0_a = requestBuffer_io_out_a_0; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_0_b = requestBuffer_io_out_b_0; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_0_c = requestBuffer_io_out_c_0; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_1_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_1_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_1_a = requestBuffer_io_out_a_2; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_1_b = requestBuffer_io_out_b_2; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_1_c = requestBuffer_io_out_c_2; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_2_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_2_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_2_a = requestBuffer_io_out_a_4; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_2_b = requestBuffer_io_out_b_4; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_2_c = requestBuffer_io_out_c_4; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_3_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_3_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_3_a = requestBuffer_io_out_a_6; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_3_b = requestBuffer_io_out_b_6; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_3_c = requestBuffer_io_out_c_6; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_4_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_4_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_4_a = requestBuffer_io_out_a_8; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_4_b = requestBuffer_io_out_b_8; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_4_c = requestBuffer_io_out_c_8; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_5_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_5_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_5_a = requestBuffer_io_out_a_10; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_5_b = requestBuffer_io_out_b_10; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_5_c = requestBuffer_io_out_c_10; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_6_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_6_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_6_a = requestBuffer_io_out_a_12; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_6_b = requestBuffer_io_out_b_12; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_6_c = requestBuffer_io_out_c_12; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_7_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_7_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_7_a = requestBuffer_io_out_a_14; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_7_b = requestBuffer_io_out_b_14; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_7_c = requestBuffer_io_out_c_14; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_8_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_8_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_8_a = requestBuffer_io_out_a_16; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_8_b = requestBuffer_io_out_b_16; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_8_c = requestBuffer_io_out_c_16; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_9_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_9_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_9_a = requestBuffer_io_out_a_18; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_9_b = requestBuffer_io_out_b_18; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_9_c = requestBuffer_io_out_c_18; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_10_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_10_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_10_a = requestBuffer_io_out_a_20; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_10_b = requestBuffer_io_out_b_20; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_10_c = requestBuffer_io_out_c_20; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_11_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_11_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_11_a = requestBuffer_io_out_a_22; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_11_b = requestBuffer_io_out_b_22; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_11_c = requestBuffer_io_out_c_22; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_12_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_12_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_12_a = requestBuffer_io_out_a_24; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_12_b = requestBuffer_io_out_b_24; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_12_c = requestBuffer_io_out_c_24; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_13_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_13_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_13_a = requestBuffer_io_out_a_26; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_13_b = requestBuffer_io_out_b_26; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_13_c = requestBuffer_io_out_c_26; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_14_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_14_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_14_a = requestBuffer_io_out_a_28; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_14_b = requestBuffer_io_out_b_28; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_14_c = requestBuffer_io_out_c_28; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_data_15_op = laneOp_0; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_0_io_data_15_dtype = laneDtype_0; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_0_io_data_15_a = requestBuffer_io_out_a_30; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_0_io_data_15_b = requestBuffer_io_out_b_30; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_0_io_data_15_c = requestBuffer_io_out_c_30; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_0_io_out_ready = pipes_0_io_req_ready; // @[AecFpWarpUnits.scala 162:21]
  assign requestStages_1_clock = clock;
  assign requestStages_1_reset = reset;
  assign requestStages_1_io_inValid = running & ~groupIssued & |requestBuffer_io_out_activeMask & _armCapture_T_3 &
    allReady; // @[AecFpWarpUnits.scala 151:116]
  assign requestStages_1_io_group = group; // @[AecFpWarpUnits.scala 152:31]
  assign requestStages_1_io_data_0_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_0_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_0_a = requestBuffer_io_out_a_1; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_0_b = requestBuffer_io_out_b_1; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_0_c = requestBuffer_io_out_c_1; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_1_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_1_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_1_a = requestBuffer_io_out_a_3; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_1_b = requestBuffer_io_out_b_3; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_1_c = requestBuffer_io_out_c_3; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_2_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_2_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_2_a = requestBuffer_io_out_a_5; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_2_b = requestBuffer_io_out_b_5; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_2_c = requestBuffer_io_out_c_5; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_3_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_3_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_3_a = requestBuffer_io_out_a_7; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_3_b = requestBuffer_io_out_b_7; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_3_c = requestBuffer_io_out_c_7; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_4_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_4_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_4_a = requestBuffer_io_out_a_9; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_4_b = requestBuffer_io_out_b_9; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_4_c = requestBuffer_io_out_c_9; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_5_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_5_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_5_a = requestBuffer_io_out_a_11; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_5_b = requestBuffer_io_out_b_11; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_5_c = requestBuffer_io_out_c_11; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_6_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_6_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_6_a = requestBuffer_io_out_a_13; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_6_b = requestBuffer_io_out_b_13; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_6_c = requestBuffer_io_out_c_13; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_7_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_7_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_7_a = requestBuffer_io_out_a_15; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_7_b = requestBuffer_io_out_b_15; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_7_c = requestBuffer_io_out_c_15; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_8_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_8_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_8_a = requestBuffer_io_out_a_17; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_8_b = requestBuffer_io_out_b_17; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_8_c = requestBuffer_io_out_c_17; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_9_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_9_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_9_a = requestBuffer_io_out_a_19; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_9_b = requestBuffer_io_out_b_19; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_9_c = requestBuffer_io_out_c_19; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_10_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_10_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_10_a = requestBuffer_io_out_a_21; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_10_b = requestBuffer_io_out_b_21; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_10_c = requestBuffer_io_out_c_21; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_11_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_11_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_11_a = requestBuffer_io_out_a_23; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_11_b = requestBuffer_io_out_b_23; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_11_c = requestBuffer_io_out_c_23; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_12_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_12_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_12_a = requestBuffer_io_out_a_25; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_12_b = requestBuffer_io_out_b_25; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_12_c = requestBuffer_io_out_c_25; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_13_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_13_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_13_a = requestBuffer_io_out_a_27; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_13_b = requestBuffer_io_out_b_27; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_13_c = requestBuffer_io_out_c_27; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_14_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_14_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_14_a = requestBuffer_io_out_a_29; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_14_b = requestBuffer_io_out_b_29; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_14_c = requestBuffer_io_out_c_29; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_data_15_op = laneOp_1 ^ 7'h1; // @[AecFpWarpUnits.scala 155:51]
  assign requestStages_1_io_data_15_dtype = laneDtype_1 ^ 4'h1; // @[AecFpWarpUnits.scala 156:57]
  assign requestStages_1_io_data_15_a = requestBuffer_io_out_a_31; // @[AecFpWarpUnits.scala 157:37]
  assign requestStages_1_io_data_15_b = requestBuffer_io_out_b_31; // @[AecFpWarpUnits.scala 158:37]
  assign requestStages_1_io_data_15_c = requestBuffer_io_out_c_31; // @[AecFpWarpUnits.scala 159:37]
  assign requestStages_1_io_out_ready = pipes_1_io_req_ready; // @[AecFpWarpUnits.scala 162:21]
  assign requestBuffer_clock = clock;
  assign requestBuffer_reset = reset;
  assign requestBuffer_io_in_activeMask = io_req_bits_activeMask; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_0 = io_req_bits_a_0; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_1 = io_req_bits_a_1; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_2 = io_req_bits_a_2; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_3 = io_req_bits_a_3; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_4 = io_req_bits_a_4; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_5 = io_req_bits_a_5; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_6 = io_req_bits_a_6; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_7 = io_req_bits_a_7; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_8 = io_req_bits_a_8; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_9 = io_req_bits_a_9; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_10 = io_req_bits_a_10; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_11 = io_req_bits_a_11; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_12 = io_req_bits_a_12; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_13 = io_req_bits_a_13; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_14 = io_req_bits_a_14; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_15 = io_req_bits_a_15; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_16 = io_req_bits_a_16; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_17 = io_req_bits_a_17; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_18 = io_req_bits_a_18; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_19 = io_req_bits_a_19; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_20 = io_req_bits_a_20; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_21 = io_req_bits_a_21; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_22 = io_req_bits_a_22; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_23 = io_req_bits_a_23; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_24 = io_req_bits_a_24; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_25 = io_req_bits_a_25; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_26 = io_req_bits_a_26; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_27 = io_req_bits_a_27; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_28 = io_req_bits_a_28; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_29 = io_req_bits_a_29; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_30 = io_req_bits_a_30; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_a_31 = io_req_bits_a_31; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_0 = io_req_bits_b_0; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_1 = io_req_bits_b_1; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_2 = io_req_bits_b_2; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_3 = io_req_bits_b_3; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_4 = io_req_bits_b_4; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_5 = io_req_bits_b_5; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_6 = io_req_bits_b_6; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_7 = io_req_bits_b_7; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_8 = io_req_bits_b_8; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_9 = io_req_bits_b_9; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_10 = io_req_bits_b_10; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_11 = io_req_bits_b_11; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_12 = io_req_bits_b_12; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_13 = io_req_bits_b_13; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_14 = io_req_bits_b_14; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_15 = io_req_bits_b_15; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_16 = io_req_bits_b_16; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_17 = io_req_bits_b_17; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_18 = io_req_bits_b_18; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_19 = io_req_bits_b_19; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_20 = io_req_bits_b_20; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_21 = io_req_bits_b_21; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_22 = io_req_bits_b_22; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_23 = io_req_bits_b_23; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_24 = io_req_bits_b_24; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_25 = io_req_bits_b_25; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_26 = io_req_bits_b_26; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_27 = io_req_bits_b_27; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_28 = io_req_bits_b_28; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_29 = io_req_bits_b_29; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_30 = io_req_bits_b_30; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_b_31 = io_req_bits_b_31; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_0 = io_req_bits_c_0; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_1 = io_req_bits_c_1; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_2 = io_req_bits_c_2; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_3 = io_req_bits_c_3; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_4 = io_req_bits_c_4; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_5 = io_req_bits_c_5; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_6 = io_req_bits_c_6; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_7 = io_req_bits_c_7; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_8 = io_req_bits_c_8; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_9 = io_req_bits_c_9; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_10 = io_req_bits_c_10; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_11 = io_req_bits_c_11; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_12 = io_req_bits_c_12; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_13 = io_req_bits_c_13; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_14 = io_req_bits_c_14; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_15 = io_req_bits_c_15; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_16 = io_req_bits_c_16; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_17 = io_req_bits_c_17; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_18 = io_req_bits_c_18; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_19 = io_req_bits_c_19; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_20 = io_req_bits_c_20; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_21 = io_req_bits_c_21; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_22 = io_req_bits_c_22; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_23 = io_req_bits_c_23; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_24 = io_req_bits_c_24; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_25 = io_req_bits_c_25; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_26 = io_req_bits_c_26; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_27 = io_req_bits_c_27; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_28 = io_req_bits_c_28; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_29 = io_req_bits_c_29; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_30 = io_req_bits_c_30; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_c_31 = io_req_bits_c_31; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_in_dest = io_req_bits_dest; // @[AecFpWarpUnits.scala 124:23]
  assign requestBuffer_io_arm = ~capturePending & ~running & ~outValid & io_req_valid; // @[AecFpWarpUnits.scala 140:61]
  assign requestBuffer_io_capture = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign resultBanks_0_clock = clock;
  assign resultBanks_0_reset = reset;
  assign resultBanks_0_io_write = running & _armCapture_T_3 & allValid & group == 4'h0; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_0_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_0_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_1_clock = clock;
  assign resultBanks_1_reset = reset;
  assign resultBanks_1_io_write = running & _armCapture_T_3 & allValid & group == 4'h0; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_1_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_1_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_2_clock = clock;
  assign resultBanks_2_reset = reset;
  assign resultBanks_2_io_write = running & _armCapture_T_3 & allValid & group == 4'h1; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_2_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_2_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_3_clock = clock;
  assign resultBanks_3_reset = reset;
  assign resultBanks_3_io_write = running & _armCapture_T_3 & allValid & group == 4'h1; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_3_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_3_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_4_clock = clock;
  assign resultBanks_4_reset = reset;
  assign resultBanks_4_io_write = running & _armCapture_T_3 & allValid & group == 4'h2; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_4_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_4_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_5_clock = clock;
  assign resultBanks_5_reset = reset;
  assign resultBanks_5_io_write = running & _armCapture_T_3 & allValid & group == 4'h2; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_5_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_5_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_6_clock = clock;
  assign resultBanks_6_reset = reset;
  assign resultBanks_6_io_write = running & _armCapture_T_3 & allValid & group == 4'h3; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_6_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_6_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_7_clock = clock;
  assign resultBanks_7_reset = reset;
  assign resultBanks_7_io_write = running & _armCapture_T_3 & allValid & group == 4'h3; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_7_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_7_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_8_clock = clock;
  assign resultBanks_8_reset = reset;
  assign resultBanks_8_io_write = running & _armCapture_T_3 & allValid & group == 4'h4; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_8_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_8_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_9_clock = clock;
  assign resultBanks_9_reset = reset;
  assign resultBanks_9_io_write = running & _armCapture_T_3 & allValid & group == 4'h4; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_9_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_9_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_10_clock = clock;
  assign resultBanks_10_reset = reset;
  assign resultBanks_10_io_write = running & _armCapture_T_3 & allValid & group == 4'h5; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_10_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_10_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_11_clock = clock;
  assign resultBanks_11_reset = reset;
  assign resultBanks_11_io_write = running & _armCapture_T_3 & allValid & group == 4'h5; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_11_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_11_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_12_clock = clock;
  assign resultBanks_12_reset = reset;
  assign resultBanks_12_io_write = running & _armCapture_T_3 & allValid & group == 4'h6; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_12_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_12_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_13_clock = clock;
  assign resultBanks_13_reset = reset;
  assign resultBanks_13_io_write = running & _armCapture_T_3 & allValid & group == 4'h6; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_13_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_13_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_14_clock = clock;
  assign resultBanks_14_reset = reset;
  assign resultBanks_14_io_write = running & _armCapture_T_3 & allValid & group == 4'h7; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_14_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_14_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_15_clock = clock;
  assign resultBanks_15_reset = reset;
  assign resultBanks_15_io_write = running & _armCapture_T_3 & allValid & group == 4'h7; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_15_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_15_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_16_clock = clock;
  assign resultBanks_16_reset = reset;
  assign resultBanks_16_io_write = running & _armCapture_T_3 & allValid & group == 4'h8; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_16_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_16_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_17_clock = clock;
  assign resultBanks_17_reset = reset;
  assign resultBanks_17_io_write = running & _armCapture_T_3 & allValid & group == 4'h8; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_17_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_17_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_18_clock = clock;
  assign resultBanks_18_reset = reset;
  assign resultBanks_18_io_write = running & _armCapture_T_3 & allValid & group == 4'h9; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_18_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_18_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_19_clock = clock;
  assign resultBanks_19_reset = reset;
  assign resultBanks_19_io_write = running & _armCapture_T_3 & allValid & group == 4'h9; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_19_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_19_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_20_clock = clock;
  assign resultBanks_20_reset = reset;
  assign resultBanks_20_io_write = running & _armCapture_T_3 & allValid & group == 4'ha; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_20_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_20_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_21_clock = clock;
  assign resultBanks_21_reset = reset;
  assign resultBanks_21_io_write = running & _armCapture_T_3 & allValid & group == 4'ha; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_21_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_21_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_22_clock = clock;
  assign resultBanks_22_reset = reset;
  assign resultBanks_22_io_write = running & _armCapture_T_3 & allValid & group == 4'hb; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_22_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_22_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_23_clock = clock;
  assign resultBanks_23_reset = reset;
  assign resultBanks_23_io_write = running & _armCapture_T_3 & allValid & group == 4'hb; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_23_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_23_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_24_clock = clock;
  assign resultBanks_24_reset = reset;
  assign resultBanks_24_io_write = running & _armCapture_T_3 & allValid & group == 4'hc; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_24_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_24_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_25_clock = clock;
  assign resultBanks_25_reset = reset;
  assign resultBanks_25_io_write = running & _armCapture_T_3 & allValid & group == 4'hc; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_25_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_25_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_26_clock = clock;
  assign resultBanks_26_reset = reset;
  assign resultBanks_26_io_write = running & _armCapture_T_3 & allValid & group == 4'hd; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_26_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_26_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_27_clock = clock;
  assign resultBanks_27_reset = reset;
  assign resultBanks_27_io_write = running & _armCapture_T_3 & allValid & group == 4'hd; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_27_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_27_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_28_clock = clock;
  assign resultBanks_28_reset = reset;
  assign resultBanks_28_io_write = running & _armCapture_T_3 & allValid & group == 4'he; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_28_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_28_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_29_clock = clock;
  assign resultBanks_29_reset = reset;
  assign resultBanks_29_io_write = running & _armCapture_T_3 & allValid & group == 4'he; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_29_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_29_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_30_clock = clock;
  assign resultBanks_30_reset = reset;
  assign resultBanks_30_io_write = running & _armCapture_T_3 & allValid & group == 4'hf; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_30_io_writeResult = pipes_0_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_30_io_writeFlags = pipes_0_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  assign resultBanks_31_clock = clock;
  assign resultBanks_31_reset = reset;
  assign resultBanks_31_io_write = running & _armCapture_T_3 & allValid & group == 4'hf; // @[AecFpWarpUnits.scala 177:81]
  assign resultBanks_31_io_writeResult = pipes_1_io_resp_bits_result; // @[AecFpWarpUnits.scala 178:51]
  assign resultBanks_31_io_writeFlags = pipes_1_io_resp_bits_exception_flags; // @[AecFpWarpUnits.scala 179:50]
  always @(posedge clock) begin
    if (reset) begin // @[AecFpWarpUnits.scala 126:31]
      capturePending <= 1'h0; // @[AecFpWarpUnits.scala 126:31]
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      capturePending <= 1'h0; // @[AecFpWarpUnits.scala 188:20]
    end else begin
      capturePending <= _GEN_0;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 127:22]
      group <= 4'h0; // @[AecFpWarpUnits.scala 127:22]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      if (_resultBanks_30_io_write_T_3) begin // @[AecFpWarpUnits.scala 206:37]
        group <= 4'h0; // @[AecFpWarpUnits.scala 206:85]
      end else begin
        group <= _group_T_1; // @[AecFpWarpUnits.scala 206:112]
      end
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      group <= 4'h0; // @[AecFpWarpUnits.scala 188:38]
    end
    if (reset) begin // @[AecFpWarpUnits.scala 127:91]
      outValid <= 1'h0; // @[AecFpWarpUnits.scala 127:91]
    end else if (_T_139) begin // @[AecFpWarpUnits.scala 208:23]
      outValid <= 1'h0; // @[AecFpWarpUnits.scala 209:14]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      outValid <= _GEN_20;
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      outValid <= ~_running_T; // @[AecFpWarpUnits.scala 192:14]
    end
    if (reset) begin // @[AecFpWarpUnits.scala 128:24]
      running <= 1'h0; // @[AecFpWarpUnits.scala 128:24]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      if (_resultBanks_30_io_write_T_3) begin // @[AecFpWarpUnits.scala 206:37]
        running <= 1'h0; // @[AecFpWarpUnits.scala 206:67]
      end else begin
        running <= _GEN_11;
      end
    end else begin
      running <= _GEN_11;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 129:28]
      groupIssued <= 1'h0; // @[AecFpWarpUnits.scala 129:28]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      groupIssued <= 1'h0; // @[AecFpWarpUnits.scala 202:17]
    end else begin
      groupIssued <= _GEN_16;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 130:30]
      commitPending <= 1'h0; // @[AecFpWarpUnits.scala 130:30]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      commitPending <= 1'h0; // @[AecFpWarpUnits.scala 205:19]
    end else begin
      commitPending <= _GEN_17;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 132:27]
      predicates <= 32'h0; // @[AecFpWarpUnits.scala 132:27]
    end else if (running & groupIssued & _T_131 & allValid) begin // @[AecFpWarpUnits.scala 196:63]
      predicates <= _predicates_T; // @[AecFpWarpUnits.scala 198:16]
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      predicates <= 32'h0; // @[AecFpWarpUnits.scala 193:16]
    end
    if (reset) begin // @[AecFpWarpUnits.scala 132:60]
      errors <= 32'h0; // @[AecFpWarpUnits.scala 132:60]
    end else if (running & groupIssued & _T_131 & allValid) begin // @[AecFpWarpUnits.scala 196:63]
      errors <= _errors_T; // @[AecFpWarpUnits.scala 199:12]
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      errors <= 32'h0; // @[AecFpWarpUnits.scala 193:31]
    end
    if (reset) begin // @[AecFpWarpUnits.scala 133:26]
      writeMask <= 32'h0; // @[AecFpWarpUnits.scala 133:26]
    end else if (commitPending) begin // @[AecFpWarpUnits.scala 201:24]
      writeMask <= _writeMask_T_1; // @[AecFpWarpUnits.scala 204:15]
    end else if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      writeMask <= 32'h0; // @[AecFpWarpUnits.scala 193:49]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneOp_0 <= io_req_bits_op[6:0]; // @[AecFpWarpUnits.scala 184:17]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneOp_1 <= _laneOp_1_T_1; // @[AecFpWarpUnits.scala 184:17]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneDtype_0 <= io_req_bits_dtype; // @[AecFpWarpUnits.scala 185:20]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneDtype_1 <= _laneDtype_1_T; // @[AecFpWarpUnits.scala 185:20]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneDest_0 <= io_req_bits_dest; // @[AecFpWarpUnits.scala 186:19]
    end
    if (_requestBuffer_io_capture_T) begin // @[AecFpWarpUnits.scala 182:22]
      laneDest_1 <= _laneDest_1_T; // @[AecFpWarpUnits.scala 186:19]
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
  capturePending = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  group = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  outValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  running = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  groupIssued = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  commitPending = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  predicates = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  errors = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  writeMask = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  laneOp_0 = _RAND_9[6:0];
  _RAND_10 = {1{`RANDOM}};
  laneOp_1 = _RAND_10[6:0];
  _RAND_11 = {1{`RANDOM}};
  laneDtype_0 = _RAND_11[3:0];
  _RAND_12 = {1{`RANDOM}};
  laneDtype_1 = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  laneDest_0 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  laneDest_1 = _RAND_14[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
