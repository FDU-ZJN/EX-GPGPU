module AecIntAlu(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [15:0] io_req_bits_op,
  input  [3:0]  io_req_bits_dtype,
  input  [31:0] io_req_bits_a,
  input  [31:0] io_req_bits_b,
  input  [31:0] io_req_bits_c,
  input         io_req_bits_selectPredicate,
  input         io_resp_ready,
  output        io_resp_valid,
  output [31:0] io_resp_bits_result,
  output        io_resp_bits_predicateResult,
  output        io_resp_bits_error
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
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[AecIntAlu.scala 87:22]
  reg [31:0] result; // @[AecIntAlu.scala 88:23]
  reg  predicateResult; // @[AecIntAlu.scala 89:32]
  reg  error; // @[AecIntAlu.scala 91:22]
  reg [31:0] workValue; // @[AecIntAlu.scala 96:22]
  reg [31:0] workAux; // @[AecIntAlu.scala 97:20]
  reg [31:0] workAccum; // @[AecIntAlu.scala 98:22]
  reg [5:0] workCount; // @[AecIntAlu.scala 99:22]
  reg [31:0] multiplyAddend; // @[AecIntAlu.scala 100:27]
  reg  multiplyMad; // @[AecIntAlu.scala 101:24]
  reg  shiftRight; // @[AecIntAlu.scala 102:23]
  reg  shiftArithmetic; // @[AecIntAlu.scala 103:28]
  reg [5:0] bitfieldLsb; // @[AecIntAlu.scala 104:24]
  reg [5:0] bitfieldWidth; // @[AecIntAlu.scala 105:26]
  reg  bitfieldInsert; // @[AecIntAlu.scala 106:27]
  reg  bitfieldSigned; // @[AecIntAlu.scala 107:27]
  wire  isSigned = io_req_bits_dtype == 4'h3; // @[AecIntAlu.scala 116:36]
  wire [4:0] shift = io_req_bits_b[4:0]; // @[AecIntAlu.scala 122:16]
  wire  isCmp = io_req_bits_op == 16'h20; // @[AecIntAlu.scala 123:30]
  wire  isCmmP = io_req_bits_op == 16'h21; // @[AecIntAlu.scala 124:31]
  wire [2:0] relation = io_req_bits_c[2:0]; // @[AecIntAlu.scala 125:19]
  wire  cmpEq = io_req_bits_a == io_req_bits_b; // @[AecIntAlu.scala 127:17]
  wire  _cmpLt_T = $signed(io_req_bits_a) < $signed(io_req_bits_b); // @[AecIntAlu.scala 128:32]
  wire  _cmpLt_T_1 = io_req_bits_a < io_req_bits_b; // @[AecIntAlu.scala 128:40]
  wire  cmpLt = isSigned ? $signed(io_req_bits_a) < $signed(io_req_bits_b) : io_req_bits_a < io_req_bits_b; // @[AecIntAlu.scala 128:18]
  wire  _cmpGt_T = $signed(io_req_bits_a) > $signed(io_req_bits_b); // @[AecIntAlu.scala 129:32]
  wire  _cmpGt_T_1 = io_req_bits_a > io_req_bits_b; // @[AecIntAlu.scala 129:40]
  wire  cmpGt = isSigned ? $signed(io_req_bits_a) > $signed(io_req_bits_b) : io_req_bits_a > io_req_bits_b; // @[AecIntAlu.scala 129:18]
  wire  _cmpResult_T = ~cmpEq; // @[AecIntAlu.scala 131:26]
  wire  _cmpResult_T_1 = cmpLt | cmpEq; // @[AecIntAlu.scala 132:19]
  wire  _cmpResult_T_2 = cmpGt | cmpEq; // @[AecIntAlu.scala 132:58]
  wire  _cmpResult_T_6 = 3'h1 == relation ? _cmpResult_T : 3'h0 == relation & cmpEq; // @[Mux.scala 81:58]
  wire  _cmpResult_T_8 = 3'h2 == relation ? cmpLt : _cmpResult_T_6; // @[Mux.scala 81:58]
  wire  _cmpResult_T_10 = 3'h3 == relation ? _cmpResult_T_1 : _cmpResult_T_8; // @[Mux.scala 81:58]
  wire  _cmpResult_T_12 = 3'h4 == relation ? cmpGt : _cmpResult_T_10; // @[Mux.scala 81:58]
  wire  cmpResult = 3'h5 == relation ? _cmpResult_T_2 : _cmpResult_T_12; // @[Mux.scala 81:58]
  wire [31:0] _aluResult_T_1 = io_req_bits_a + io_req_bits_b; // @[AecIntAlu.scala 141:20]
  wire [31:0] _aluResult_T_3 = io_req_bits_a - io_req_bits_b; // @[AecIntAlu.scala 143:20]
  wire  _T_4 = io_req_bits_op == 16'h4; // @[AecIntAlu.scala 144:66]
  wire  _T_5 = io_req_bits_op == 16'h3 | io_req_bits_op == 16'h4; // @[AecIntAlu.scala 144:48]
  wire [31:0] _aluResult_T_7 = 32'sh0 - $signed(io_req_bits_a); // @[AecIntAlu.scala 152:24]
  wire [31:0] _aluResult_T_13 = $signed(io_req_bits_a) < 32'sh0 ? _aluResult_T_7 : io_req_bits_a; // @[AecIntAlu.scala 154:21]
  wire [31:0] _aluResult_T_15 = _cmpLt_T ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 156:35]
  wire [31:0] _aluResult_T_17 = _cmpLt_T_1 ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 156:55]
  wire [31:0] _aluResult_T_18 = isSigned ? _aluResult_T_15 : _aluResult_T_17; // @[AecIntAlu.scala 156:21]
  wire [31:0] _aluResult_T_20 = _cmpGt_T ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 158:35]
  wire [31:0] _aluResult_T_22 = _cmpGt_T_1 ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 158:55]
  wire [31:0] _aluResult_T_23 = isSigned ? _aluResult_T_20 : _aluResult_T_22; // @[AecIntAlu.scala 158:21]
  wire [31:0] _aluResult_T_24 = io_req_bits_a & io_req_bits_b; // @[AecIntAlu.scala 160:20]
  wire [31:0] _aluResult_T_25 = io_req_bits_a | io_req_bits_b; // @[AecIntAlu.scala 162:20]
  wire [31:0] _aluResult_T_26 = io_req_bits_a ^ io_req_bits_b; // @[AecIntAlu.scala 164:20]
  wire [31:0] _aluResult_T_27 = ~io_req_bits_a; // @[AecIntAlu.scala 166:18]
  wire  _T_16 = io_req_bits_op == 16'h15; // @[AecIntAlu.scala 167:66]
  wire  _T_17 = io_req_bits_op == 16'h14 | io_req_bits_op == 16'h15; // @[AecIntAlu.scala 167:48]
  wire  _T_18 = io_req_bits_op == 16'h16; // @[AecIntAlu.scala 168:20]
  wire  _T_19 = io_req_bits_op == 16'h14 | io_req_bits_op == 16'h15 | _T_18; // @[AecIntAlu.scala 167:84]
  wire  _T_20 = io_req_bits_op == 16'h17; // @[AecIntAlu.scala 168:56]
  wire [1:0] _aluResult_T_60 = io_req_bits_a[0] + io_req_bits_a[1]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_62 = io_req_bits_a[2] + io_req_bits_a[3]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_64 = _aluResult_T_60 + _aluResult_T_62; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_66 = io_req_bits_a[4] + io_req_bits_a[5]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_68 = io_req_bits_a[6] + io_req_bits_a[7]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_70 = _aluResult_T_66 + _aluResult_T_68; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_72 = _aluResult_T_64 + _aluResult_T_70; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_74 = io_req_bits_a[8] + io_req_bits_a[9]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_76 = io_req_bits_a[10] + io_req_bits_a[11]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_78 = _aluResult_T_74 + _aluResult_T_76; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_80 = io_req_bits_a[12] + io_req_bits_a[13]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_82 = io_req_bits_a[14] + io_req_bits_a[15]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_84 = _aluResult_T_80 + _aluResult_T_82; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_86 = _aluResult_T_78 + _aluResult_T_84; // @[Bitwise.scala 51:90]
  wire [4:0] _aluResult_T_88 = _aluResult_T_72 + _aluResult_T_86; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_90 = io_req_bits_a[16] + io_req_bits_a[17]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_92 = io_req_bits_a[18] + io_req_bits_a[19]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_94 = _aluResult_T_90 + _aluResult_T_92; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_96 = io_req_bits_a[20] + io_req_bits_a[21]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_98 = io_req_bits_a[22] + io_req_bits_a[23]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_100 = _aluResult_T_96 + _aluResult_T_98; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_102 = _aluResult_T_94 + _aluResult_T_100; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_104 = io_req_bits_a[24] + io_req_bits_a[25]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_106 = io_req_bits_a[26] + io_req_bits_a[27]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_108 = _aluResult_T_104 + _aluResult_T_106; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_110 = io_req_bits_a[28] + io_req_bits_a[29]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_112 = io_req_bits_a[30] + io_req_bits_a[31]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_114 = _aluResult_T_110 + _aluResult_T_112; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_116 = _aluResult_T_108 + _aluResult_T_114; // @[Bitwise.scala 51:90]
  wire [4:0] _aluResult_T_118 = _aluResult_T_102 + _aluResult_T_116; // @[Bitwise.scala 51:90]
  wire [5:0] _aluResult_T_120 = _aluResult_T_88 + _aluResult_T_118; // @[Bitwise.scala 51:90]
  wire [31:0] _GEN_153 = {{16'd0}, io_req_bits_a[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_125 = _GEN_153 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_127 = {io_req_bits_a[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _aluResult_T_129 = _aluResult_T_127 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _aluResult_T_130 = _aluResult_T_125 | _aluResult_T_129; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_154 = {{8'd0}, _aluResult_T_130[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_135 = _GEN_154 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_137 = {_aluResult_T_130[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _aluResult_T_139 = _aluResult_T_137 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _aluResult_T_140 = _aluResult_T_135 | _aluResult_T_139; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_155 = {{4'd0}, _aluResult_T_140[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_145 = _GEN_155 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_147 = {_aluResult_T_140[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _aluResult_T_149 = _aluResult_T_147 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _aluResult_T_150 = _aluResult_T_145 | _aluResult_T_149; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_156 = {{2'd0}, _aluResult_T_150[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_155 = _GEN_156 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_157 = {_aluResult_T_150[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _aluResult_T_159 = _aluResult_T_157 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _aluResult_T_160 = _aluResult_T_155 | _aluResult_T_159; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_157 = {{1'd0}, _aluResult_T_160[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_165 = _GEN_157 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _aluResult_T_167 = {_aluResult_T_160[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _aluResult_T_169 = _aluResult_T_167 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _aluResult_T_170 = _aluResult_T_165 | _aluResult_T_169; // @[Bitwise.scala 108:39]
  wire [4:0] _aluResult_T_203 = _aluResult_T_170[30] ? 5'h1e : 5'h1f; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_204 = _aluResult_T_170[29] ? 5'h1d : _aluResult_T_203; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_205 = _aluResult_T_170[28] ? 5'h1c : _aluResult_T_204; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_206 = _aluResult_T_170[27] ? 5'h1b : _aluResult_T_205; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_207 = _aluResult_T_170[26] ? 5'h1a : _aluResult_T_206; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_208 = _aluResult_T_170[25] ? 5'h19 : _aluResult_T_207; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_209 = _aluResult_T_170[24] ? 5'h18 : _aluResult_T_208; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_210 = _aluResult_T_170[23] ? 5'h17 : _aluResult_T_209; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_211 = _aluResult_T_170[22] ? 5'h16 : _aluResult_T_210; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_212 = _aluResult_T_170[21] ? 5'h15 : _aluResult_T_211; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_213 = _aluResult_T_170[20] ? 5'h14 : _aluResult_T_212; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_214 = _aluResult_T_170[19] ? 5'h13 : _aluResult_T_213; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_215 = _aluResult_T_170[18] ? 5'h12 : _aluResult_T_214; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_216 = _aluResult_T_170[17] ? 5'h11 : _aluResult_T_215; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_217 = _aluResult_T_170[16] ? 5'h10 : _aluResult_T_216; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_218 = _aluResult_T_170[15] ? 5'hf : _aluResult_T_217; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_219 = _aluResult_T_170[14] ? 5'he : _aluResult_T_218; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_220 = _aluResult_T_170[13] ? 5'hd : _aluResult_T_219; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_221 = _aluResult_T_170[12] ? 5'hc : _aluResult_T_220; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_222 = _aluResult_T_170[11] ? 5'hb : _aluResult_T_221; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_223 = _aluResult_T_170[10] ? 5'ha : _aluResult_T_222; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_224 = _aluResult_T_170[9] ? 5'h9 : _aluResult_T_223; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_225 = _aluResult_T_170[8] ? 5'h8 : _aluResult_T_224; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_226 = _aluResult_T_170[7] ? 5'h7 : _aluResult_T_225; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_227 = _aluResult_T_170[6] ? 5'h6 : _aluResult_T_226; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_228 = _aluResult_T_170[5] ? 5'h5 : _aluResult_T_227; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_229 = _aluResult_T_170[4] ? 5'h4 : _aluResult_T_228; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_230 = _aluResult_T_170[3] ? 5'h3 : _aluResult_T_229; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_231 = _aluResult_T_170[2] ? 5'h2 : _aluResult_T_230; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_232 = _aluResult_T_170[1] ? 5'h1 : _aluResult_T_231; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_233 = _aluResult_T_170[0] ? 5'h0 : _aluResult_T_232; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_235 = 5'h1f - _aluResult_T_233; // @[AecIntAlu.scala 175:23]
  wire [31:0] _GEN_0 = io_req_bits_a == 32'h0 ? 32'hffffffff : {{27'd0}, _aluResult_T_235}; // @[AecIntAlu.scala 175:15 176:{22,34}]
  wire [31:0] _aluResult_T_236 = io_req_bits_selectPredicate ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 178:21]
  wire [31:0] _aluResult_T_238 = io_req_bits_a[31] ? io_req_bits_b : io_req_bits_a; // @[AecIntAlu.scala 180:21]
  wire [31:0] _GEN_1 = io_req_bits_op == 16'h23 ? _aluResult_T_238 : 32'h0; // @[AecIntAlu.scala 179:50 180:15 134:30]
  wire  _GEN_2 = io_req_bits_op == 16'h23 ? 1'h0 : 1'h1; // @[AecIntAlu.scala 136:29 179:50 182:14]
  wire [31:0] _GEN_3 = io_req_bits_op == 16'h22 ? _aluResult_T_236 : _GEN_1; // @[AecIntAlu.scala 177:49 178:15]
  wire  _GEN_4 = io_req_bits_op == 16'h22 ? 1'h0 : _GEN_2; // @[AecIntAlu.scala 136:29 177:49]
  wire [31:0] _GEN_5 = io_req_bits_op == 16'h19 ? _GEN_0 : _GEN_3; // @[AecIntAlu.scala 172:49]
  wire  _GEN_6 = io_req_bits_op == 16'h19 ? 1'h0 : _GEN_4; // @[AecIntAlu.scala 136:29 172:49]
  wire [31:0] _GEN_7 = io_req_bits_op == 16'h18 ? {{26'd0}, _aluResult_T_120} : _GEN_5; // @[AecIntAlu.scala 170:50 171:15]
  wire  _GEN_8 = io_req_bits_op == 16'h18 ? 1'h0 : _GEN_6; // @[AecIntAlu.scala 136:29 170:50]
  wire [31:0] _GEN_9 = _T_19 | io_req_bits_op == 16'h17 ? 32'h0 : _GEN_7; // @[AecIntAlu.scala 168:76 169:15]
  wire  _GEN_10 = _T_19 | io_req_bits_op == 16'h17 ? 1'h0 : _GEN_8; // @[AecIntAlu.scala 136:29 168:76]
  wire [31:0] _GEN_11 = io_req_bits_op == 16'h13 ? _aluResult_T_27 : _GEN_9; // @[AecIntAlu.scala 165:51 166:15]
  wire  _GEN_12 = io_req_bits_op == 16'h13 ? 1'h0 : _GEN_10; // @[AecIntAlu.scala 136:29 165:51]
  wire [31:0] _GEN_13 = io_req_bits_op == 16'h12 ? _aluResult_T_26 : _GEN_11; // @[AecIntAlu.scala 163:51 164:15]
  wire  _GEN_14 = io_req_bits_op == 16'h12 ? 1'h0 : _GEN_12; // @[AecIntAlu.scala 136:29 163:51]
  wire [31:0] _GEN_15 = io_req_bits_op == 16'h11 ? _aluResult_T_25 : _GEN_13; // @[AecIntAlu.scala 161:50 162:15]
  wire  _GEN_16 = io_req_bits_op == 16'h11 ? 1'h0 : _GEN_14; // @[AecIntAlu.scala 136:29 161:50]
  wire [31:0] _GEN_17 = io_req_bits_op == 16'h10 ? _aluResult_T_24 : _GEN_15; // @[AecIntAlu.scala 159:51 160:15]
  wire  _GEN_18 = io_req_bits_op == 16'h10 ? 1'h0 : _GEN_16; // @[AecIntAlu.scala 136:29 159:51]
  wire [31:0] _GEN_19 = io_req_bits_op == 16'ha ? _aluResult_T_23 : _GEN_17; // @[AecIntAlu.scala 157:49 158:15]
  wire  _GEN_20 = io_req_bits_op == 16'ha ? 1'h0 : _GEN_18; // @[AecIntAlu.scala 136:29 157:49]
  wire [31:0] _GEN_21 = io_req_bits_op == 16'h9 ? _aluResult_T_18 : _GEN_19; // @[AecIntAlu.scala 155:49 156:15]
  wire  _GEN_22 = io_req_bits_op == 16'h9 ? 1'h0 : _GEN_20; // @[AecIntAlu.scala 136:29 155:49]
  wire [31:0] _GEN_23 = io_req_bits_op == 16'h8 ? _aluResult_T_13 : _GEN_21; // @[AecIntAlu.scala 153:49 154:15]
  wire  _GEN_24 = io_req_bits_op == 16'h8 ? 1'h0 : _GEN_22; // @[AecIntAlu.scala 136:29 153:49]
  wire [31:0] _GEN_25 = io_req_bits_op == 16'h7 ? _aluResult_T_7 : _GEN_23; // @[AecIntAlu.scala 151:49 152:15]
  wire  _GEN_26 = io_req_bits_op == 16'h7 ? 1'h0 : _GEN_24; // @[AecIntAlu.scala 136:29 151:49]
  wire  _GEN_27 = io_req_bits_op == 16'h6 | _GEN_26; // @[AecIntAlu.scala 146:49 150:14]
  wire [31:0] _GEN_28 = io_req_bits_op == 16'h6 ? 32'h0 : _GEN_25; // @[AecIntAlu.scala 134:30 146:49]
  wire [31:0] _GEN_29 = io_req_bits_op == 16'h3 | io_req_bits_op == 16'h4 ? 32'h0 : _GEN_28; // @[AecIntAlu.scala 144:85 145:15]
  wire  _GEN_30 = io_req_bits_op == 16'h3 | io_req_bits_op == 16'h4 ? 1'h0 : _GEN_27; // @[AecIntAlu.scala 136:29 144:85]
  wire [31:0] _GEN_31 = io_req_bits_op == 16'h2 ? _aluResult_T_3 : _GEN_29; // @[AecIntAlu.scala 142:49 143:15]
  wire  _GEN_32 = io_req_bits_op == 16'h2 ? 1'h0 : _GEN_30; // @[AecIntAlu.scala 136:29 142:49]
  wire [31:0] _GEN_33 = io_req_bits_op == 16'h1 ? _aluResult_T_1 : _GEN_31; // @[AecIntAlu.scala 140:49 141:15]
  wire  _GEN_34 = io_req_bits_op == 16'h1 ? 1'h0 : _GEN_32; // @[AecIntAlu.scala 136:29 140:49]
  wire [31:0] aluResult = isCmp | isCmmP ? {{31'd0}, cmpResult} : _GEN_33; // @[AecIntAlu.scala 137:26 138:15]
  wire  aluPredicate = (isCmp | isCmmP) & cmpResult; // @[AecIntAlu.scala 137:26 139:18 135:33]
  wire  aluError = isCmp | isCmmP ? 1'h0 : _GEN_34; // @[AecIntAlu.scala 137:26 136:29]
  wire  _T_27 = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [5:0] _workCount_T = {1'h0,shift}; // @[Cat.scala 33:92]
  wire [7:0] lsb = io_req_bits_c[7:0]; // @[AecIntAlu.scala 204:18]
  wire [7:0] width = io_req_bits_c[15:8]; // @[AecIntAlu.scala 205:20]
  wire [8:0] _valid_T_3 = lsb + width; // @[AecIntAlu.scala 206:55]
  wire  valid = lsb <= 8'h1f & width <= 8'h20 & _valid_T_3 <= 9'h20; // @[AecIntAlu.scala 206:48]
  wire  _T_37 = ~valid; // @[AecIntAlu.scala 207:13]
  wire [31:0] _workValue_T_1 = _T_20 ? io_req_bits_b : io_req_bits_a; // @[AecIntAlu.scala 213:25]
  wire [31:0] _GEN_38 = ~valid ? 32'h0 : result; // @[AecIntAlu.scala 207:21 208:16 88:23]
  wire [2:0] _GEN_40 = ~valid ? 3'h6 : 3'h3; // @[AecIntAlu.scala 207:21 210:15 220:15]
  wire [31:0] _GEN_41 = ~valid ? workAccum : io_req_bits_a; // @[AecIntAlu.scala 207:21 212:19 98:22]
  wire [31:0] _GEN_42 = ~valid ? workValue : _workValue_T_1; // @[AecIntAlu.scala 207:21 213:19 96:22]
  wire [31:0] _GEN_43 = ~valid ? workAux : 32'h0; // @[AecIntAlu.scala 207:21 214:17 97:20]
  wire [5:0] _GEN_44 = ~valid ? bitfieldLsb : lsb[5:0]; // @[AecIntAlu.scala 207:21 104:24 215:21]
  wire [5:0] _GEN_45 = ~valid ? workCount : lsb[5:0]; // @[AecIntAlu.scala 207:21 216:19 99:22]
  wire [5:0] _GEN_46 = ~valid ? bitfieldWidth : width[5:0]; // @[AecIntAlu.scala 207:21 105:26 217:23]
  wire  _GEN_47 = ~valid ? bitfieldInsert : _T_20; // @[AecIntAlu.scala 207:21 106:27 218:24]
  wire  _GEN_48 = ~valid ? bitfieldSigned : isSigned; // @[AecIntAlu.scala 207:21 107:27 219:24]
  wire [31:0] _GEN_49 = _T_18 | _T_20 ? _GEN_38 : aluResult; // @[AecIntAlu.scala 203:88 223:14]
  wire  _GEN_50 = _T_18 | _T_20 ? _T_37 : aluError; // @[AecIntAlu.scala 203:88 225:13]
  wire [2:0] _GEN_51 = _T_18 | _T_20 ? _GEN_40 : 3'h6; // @[AecIntAlu.scala 203:88 226:13]
  wire [31:0] _GEN_52 = _T_18 | _T_20 ? _GEN_41 : workAccum; // @[AecIntAlu.scala 203:88 98:22]
  wire [31:0] _GEN_53 = _T_18 | _T_20 ? _GEN_42 : workValue; // @[AecIntAlu.scala 203:88 96:22]
  wire [31:0] _GEN_54 = _T_18 | _T_20 ? _GEN_43 : workAux; // @[AecIntAlu.scala 203:88 97:20]
  wire [5:0] _GEN_56 = _T_18 | _T_20 ? _GEN_45 : workCount; // @[AecIntAlu.scala 203:88 99:22]
  wire  _GEN_60 = _T_18 | _T_20 ? 1'h0 : aluPredicate; // @[AecIntAlu.scala 187:21 203:88 224:23]
  wire [31:0] _GEN_61 = _T_17 ? io_req_bits_a : _GEN_53; // @[AecIntAlu.scala 197:87 198:17]
  wire [5:0] _GEN_62 = _T_17 ? _workCount_T : _GEN_56; // @[AecIntAlu.scala 197:87 199:17]
  wire [2:0] _GEN_65 = _T_17 ? 3'h2 : _GEN_51; // @[AecIntAlu.scala 197:87 202:13]
  wire [31:0] _GEN_66 = _T_17 ? result : _GEN_49; // @[AecIntAlu.scala 197:87 88:23]
  wire [31:0] _GEN_69 = _T_17 ? workAux : _GEN_54; // @[AecIntAlu.scala 197:87 97:20]
  wire [31:0] _GEN_75 = _T_5 ? io_req_bits_a : _GEN_61; // @[AecIntAlu.scala 189:81 190:17]
  wire [31:0] _GEN_76 = _T_5 ? io_req_bits_b : _GEN_69; // @[AecIntAlu.scala 189:81 191:15]
  wire [5:0] _GEN_78 = _T_5 ? 6'h0 : _GEN_62; // @[AecIntAlu.scala 189:81 193:17]
  wire [2:0] _GEN_81 = _T_5 ? 3'h1 : _GEN_65; // @[AecIntAlu.scala 189:81 196:13]
  wire [31:0] _GEN_84 = _T_5 ? result : _GEN_66; // @[AecIntAlu.scala 189:81 88:23]
  wire [31:0] _GEN_94 = _T_27 ? _GEN_75 : workValue; // @[AecIntAlu.scala 185:22 96:22]
  wire [31:0] _GEN_95 = _T_27 ? _GEN_76 : workAux; // @[AecIntAlu.scala 185:22 97:20]
  wire [5:0] _GEN_97 = _T_27 ? _GEN_78 : workCount; // @[AecIntAlu.scala 185:22 99:22]
  wire [2:0] _GEN_100 = _T_27 ? _GEN_81 : state; // @[AecIntAlu.scala 185:22 87:22]
  wire [31:0] _GEN_103 = _T_27 ? _GEN_84 : result; // @[AecIntAlu.scala 185:22 88:23]
  wire [31:0] _nextProduct_T_2 = workAccum + workValue; // @[AecIntAlu.scala 231:49]
  wire [31:0] nextProduct = workAux[0] ? _nextProduct_T_2 : workAccum; // @[AecIntAlu.scala 231:26]
  wire [32:0] _workValue_T_2 = {workValue, 1'h0}; // @[AecIntAlu.scala 233:28]
  wire [31:0] _result_T_1 = nextProduct + multiplyAddend; // @[AecIntAlu.scala 236:46]
  wire [31:0] _result_T_2 = multiplyMad ? _result_T_1 : nextProduct; // @[AecIntAlu.scala 236:20]
  wire [5:0] _workCount_T_3 = workCount + 6'h1; // @[AecIntAlu.scala 238:42]
  wire [31:0] _GEN_108 = workCount == 6'h1f ? _result_T_2 : _GEN_103; // @[AecIntAlu.scala 235:31 236:14]
  wire [2:0] _GEN_109 = workCount == 6'h1f ? 3'h6 : _GEN_100; // @[AecIntAlu.scala 235:31 237:13]
  wire [5:0] _GEN_110 = workCount == 6'h1f ? _GEN_97 : _workCount_T_3; // @[AecIntAlu.scala 235:31 238:29]
  wire [32:0] _GEN_112 = state == 3'h1 ? _workValue_T_2 : {{1'd0}, _GEN_94}; // @[AecIntAlu.scala 230:29 233:15]
  wire [31:0] _GEN_113 = state == 3'h1 ? {{1'd0}, workAux[31:1]} : _GEN_95; // @[AecIntAlu.scala 230:29 234:13]
  wire [31:0] _GEN_114 = state == 3'h1 ? _GEN_108 : _GEN_103; // @[AecIntAlu.scala 230:29]
  wire [2:0] _GEN_115 = state == 3'h1 ? _GEN_109 : _GEN_100; // @[AecIntAlu.scala 230:29]
  wire [5:0] _GEN_116 = state == 3'h1 ? _GEN_110 : _GEN_97; // @[AecIntAlu.scala 230:29]
  wire [31:0] _right_T_2 = {workValue[31],workValue[31:1]}; // @[Cat.scala 33:92]
  wire [31:0] _right_T_4 = {1'h0,workValue[31:1]}; // @[Cat.scala 33:92]
  wire [31:0] right = shiftArithmetic ? _right_T_2 : _right_T_4; // @[AecIntAlu.scala 242:20]
  wire [31:0] _nextValue_T_1 = {workValue[30:0],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] nextValue = shiftRight ? right : _nextValue_T_1; // @[AecIntAlu.scala 244:24]
  wire  _T_41 = workCount == 6'h0; // @[AecIntAlu.scala 245:21]
  wire [5:0] _workCount_T_5 = workCount - 6'h1; // @[AecIntAlu.scala 250:30]
  wire [31:0] _GEN_117 = workCount == 6'h1 ? nextValue : _GEN_114; // @[AecIntAlu.scala 251:32 252:16]
  wire [2:0] _GEN_118 = workCount == 6'h1 ? 3'h6 : _GEN_115; // @[AecIntAlu.scala 251:32 253:15]
  wire [31:0] _GEN_119 = workCount == 6'h0 ? workValue : _GEN_117; // @[AecIntAlu.scala 245:30 246:14]
  wire [2:0] _GEN_120 = workCount == 6'h0 ? 3'h6 : _GEN_118; // @[AecIntAlu.scala 245:30 247:13]
  wire [32:0] _GEN_121 = workCount == 6'h0 ? _GEN_112 : {{1'd0}, nextValue}; // @[AecIntAlu.scala 245:30 249:17]
  wire [5:0] _GEN_122 = workCount == 6'h0 ? _GEN_116 : _workCount_T_5; // @[AecIntAlu.scala 245:30 250:17]
  wire [31:0] _GEN_123 = state == 3'h2 ? _GEN_119 : _GEN_114; // @[AecIntAlu.scala 241:29]
  wire [2:0] _GEN_124 = state == 3'h2 ? _GEN_120 : _GEN_115; // @[AecIntAlu.scala 241:29]
  wire [32:0] _GEN_125 = state == 3'h2 ? _GEN_121 : _GEN_112; // @[AecIntAlu.scala 241:29]
  wire [5:0] _GEN_126 = state == 3'h2 ? _GEN_122 : _GEN_116; // @[AecIntAlu.scala 241:29]
  wire [32:0] _workValue_T_5 = bitfieldInsert ? _workValue_T_2 : {{2'd0}, workValue[31:1]}; // @[AecIntAlu.scala 263:23]
  wire [5:0] _GEN_127 = _T_41 ? bitfieldWidth : _workCount_T_5; // @[AecIntAlu.scala 259:30 260:17 264:17]
  wire [2:0] _GEN_128 = _T_41 ? 3'h4 : _GEN_124; // @[AecIntAlu.scala 259:30 261:13]
  wire [32:0] _GEN_129 = _T_41 ? _GEN_125 : _workValue_T_5; // @[AecIntAlu.scala 259:30 263:17]
  wire [5:0] _GEN_130 = state == 3'h3 ? _GEN_127 : _GEN_126; // @[AecIntAlu.scala 258:34]
  wire [2:0] _GEN_131 = state == 3'h3 ? _GEN_128 : _GEN_124; // @[AecIntAlu.scala 258:34]
  wire [32:0] _GEN_132 = state == 3'h3 ? _GEN_129 : _GEN_125; // @[AecIntAlu.scala 258:34]
  wire [31:0] extracted = workValue & workAux; // @[AecIntAlu.scala 273:35]
  wire [31:0] _signBit_T_1 = workAux + 32'h1; // @[AecIntAlu.scala 274:46]
  wire [31:0] _GEN_158 = {{1'd0}, _signBit_T_1[31:1]}; // @[AecIntAlu.scala 274:34]
  wire [31:0] _signBit_T_3 = extracted & _GEN_158; // @[AecIntAlu.scala 274:34]
  wire  signBit = |_signBit_T_3; // @[AecIntAlu.scala 274:60]
  wire [31:0] _result_T_4 = ~workAux; // @[AecIntAlu.scala 275:62]
  wire [31:0] _result_T_5 = extracted | _result_T_4; // @[AecIntAlu.scala 275:60]
  wire [31:0] _result_T_6 = bitfieldSigned & signBit ? _result_T_5 : extracted; // @[AecIntAlu.scala 275:22]
  wire [5:0] _GEN_133 = bitfieldInsert ? bitfieldLsb : _GEN_130; // @[AecIntAlu.scala 269:29 270:19]
  wire [2:0] _GEN_134 = bitfieldInsert ? 3'h5 : 3'h6; // @[AecIntAlu.scala 269:29 271:15 276:15]
  wire [31:0] _GEN_135 = bitfieldInsert ? _GEN_123 : _result_T_6; // @[AecIntAlu.scala 269:29 275:16]
  wire [32:0] _workAux_T_1 = {workAux, 1'h0}; // @[AecIntAlu.scala 279:27]
  wire [32:0] _workAux_T_2 = _workAux_T_1 | 33'h1; // @[AecIntAlu.scala 279:33]
  wire [5:0] _GEN_136 = _T_41 ? _GEN_133 : _workCount_T_5; // @[AecIntAlu.scala 268:30 280:17]
  wire [2:0] _GEN_137 = _T_41 ? _GEN_134 : _GEN_131; // @[AecIntAlu.scala 268:30]
  wire [31:0] _GEN_138 = _T_41 ? _GEN_135 : _GEN_123; // @[AecIntAlu.scala 268:30]
  wire [32:0] _GEN_139 = _T_41 ? {{1'd0}, _GEN_113} : _workAux_T_2; // @[AecIntAlu.scala 268:30 279:15]
  wire [5:0] _GEN_140 = state == 3'h4 ? _GEN_136 : _GEN_130; // @[AecIntAlu.scala 267:33]
  wire [2:0] _GEN_141 = state == 3'h4 ? _GEN_137 : _GEN_131; // @[AecIntAlu.scala 267:33]
  wire [31:0] _GEN_142 = state == 3'h4 ? _GEN_138 : _GEN_123; // @[AecIntAlu.scala 267:33]
  wire [32:0] _GEN_143 = state == 3'h4 ? _GEN_139 : {{1'd0}, _GEN_113}; // @[AecIntAlu.scala 267:33]
  wire [31:0] _result_T_8 = workAccum & _result_T_4; // @[AecIntAlu.scala 285:28]
  wire [31:0] _result_T_10 = _result_T_8 | extracted; // @[AecIntAlu.scala 285:40]
  wire [32:0] _GEN_146 = _T_41 ? _GEN_143 : _workAux_T_1; // @[AecIntAlu.scala 284:30 288:15]
  wire [32:0] _GEN_150 = state == 3'h5 ? _GEN_146 : _GEN_143; // @[AecIntAlu.scala 283:38]
  wire  _T_49 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign io_req_ready = state == 3'h0; // @[AecIntAlu.scala 109:25]
  assign io_resp_valid = state == 3'h6; // @[AecIntAlu.scala 110:26]
  assign io_resp_bits_result = result; // @[AecIntAlu.scala 111:23]
  assign io_resp_bits_predicateResult = predicateResult; // @[AecIntAlu.scala 112:32]
  assign io_resp_bits_error = error; // @[AecIntAlu.scala 114:22]
  always @(posedge clock) begin
    if (reset) begin // @[AecIntAlu.scala 87:22]
      state <= 3'h0; // @[AecIntAlu.scala 87:22]
    end else if (_T_49) begin // @[AecIntAlu.scala 293:23]
      state <= 3'h0; // @[AecIntAlu.scala 293:31]
    end else if (state == 3'h5) begin // @[AecIntAlu.scala 283:38]
      if (_T_41) begin // @[AecIntAlu.scala 284:30]
        state <= 3'h6; // @[AecIntAlu.scala 286:13]
      end else begin
        state <= _GEN_141;
      end
    end else begin
      state <= _GEN_141;
    end
    if (reset) begin // @[AecIntAlu.scala 88:23]
      result <= 32'h0; // @[AecIntAlu.scala 88:23]
    end else if (state == 3'h5) begin // @[AecIntAlu.scala 283:38]
      if (_T_41) begin // @[AecIntAlu.scala 284:30]
        result <= _result_T_10; // @[AecIntAlu.scala 285:14]
      end else begin
        result <= _GEN_142;
      end
    end else begin
      result <= _GEN_142;
    end
    if (reset) begin // @[AecIntAlu.scala 89:32]
      predicateResult <= 1'h0; // @[AecIntAlu.scala 89:32]
    end else if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (_T_5) begin // @[AecIntAlu.scala 189:81]
        predicateResult <= 1'h0; // @[AecIntAlu.scala 187:21]
      end else if (_T_17) begin // @[AecIntAlu.scala 197:87]
        predicateResult <= 1'h0; // @[AecIntAlu.scala 187:21]
      end else begin
        predicateResult <= _GEN_60;
      end
    end
    if (reset) begin // @[AecIntAlu.scala 91:22]
      error <= 1'h0; // @[AecIntAlu.scala 91:22]
    end else if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (_T_5) begin // @[AecIntAlu.scala 189:81]
        error <= 1'h0; // @[AecIntAlu.scala 188:11]
      end else if (_T_17) begin // @[AecIntAlu.scala 197:87]
        error <= 1'h0; // @[AecIntAlu.scala 188:11]
      end else begin
        error <= _GEN_50;
      end
    end
    workValue <= _GEN_132[31:0];
    workAux <= _GEN_150[31:0];
    if (state == 3'h1) begin // @[AecIntAlu.scala 230:29]
      if (workAux[0]) begin // @[AecIntAlu.scala 231:26]
        workAccum <= _nextProduct_T_2;
      end
    end else if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (_T_5) begin // @[AecIntAlu.scala 189:81]
        workAccum <= 32'h0; // @[AecIntAlu.scala 192:17]
      end else if (!(_T_17)) begin // @[AecIntAlu.scala 197:87]
        workAccum <= _GEN_52;
      end
    end
    if (state == 3'h5) begin // @[AecIntAlu.scala 283:38]
      if (_T_41) begin // @[AecIntAlu.scala 284:30]
        workCount <= _GEN_140;
      end else begin
        workCount <= _workCount_T_5; // @[AecIntAlu.scala 289:17]
      end
    end else begin
      workCount <= _GEN_140;
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (_T_5) begin // @[AecIntAlu.scala 189:81]
        multiplyAddend <= io_req_bits_c; // @[AecIntAlu.scala 194:22]
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (_T_5) begin // @[AecIntAlu.scala 189:81]
        multiplyMad <= _T_4; // @[AecIntAlu.scala 195:19]
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (_T_17) begin // @[AecIntAlu.scala 197:87]
          shiftRight <= _T_16; // @[AecIntAlu.scala 200:18]
        end
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (_T_17) begin // @[AecIntAlu.scala 197:87]
          shiftArithmetic <= _T_16 & isSigned; // @[AecIntAlu.scala 201:23]
        end
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (!(_T_17)) begin // @[AecIntAlu.scala 197:87]
          if (_T_18 | _T_20) begin // @[AecIntAlu.scala 203:88]
            bitfieldLsb <= _GEN_44;
          end
        end
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (!(_T_17)) begin // @[AecIntAlu.scala 197:87]
          if (_T_18 | _T_20) begin // @[AecIntAlu.scala 203:88]
            bitfieldWidth <= _GEN_46;
          end
        end
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (!(_T_17)) begin // @[AecIntAlu.scala 197:87]
          if (_T_18 | _T_20) begin // @[AecIntAlu.scala 203:88]
            bitfieldInsert <= _GEN_47;
          end
        end
      end
    end
    if (_T_27) begin // @[AecIntAlu.scala 185:22]
      if (!(_T_5)) begin // @[AecIntAlu.scala 189:81]
        if (!(_T_17)) begin // @[AecIntAlu.scala 197:87]
          if (_T_18 | _T_20) begin // @[AecIntAlu.scala 203:88]
            bitfieldSigned <= _GEN_48;
          end
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
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  result = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  predicateResult = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  error = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  workValue = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  workAux = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  workAccum = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  workCount = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  multiplyAddend = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  multiplyMad = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  shiftRight = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  shiftArithmetic = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  bitfieldLsb = _RAND_12[5:0];
  _RAND_13 = {1{`RANDOM}};
  bitfieldWidth = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  bitfieldInsert = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  bitfieldSigned = _RAND_15[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecIntWarpRequestStage(
  input         clock,
  input         reset,
  input         io_inValid,
  output        io_inReady,
  input         io_group,
  input  [15:0] io_data_0_op,
  input  [3:0]  io_data_0_dtype,
  input  [31:0] io_data_0_a,
  input  [31:0] io_data_0_b,
  input  [31:0] io_data_0_c,
  input         io_data_0_selectPredicate,
  input  [15:0] io_data_1_op,
  input  [3:0]  io_data_1_dtype,
  input  [31:0] io_data_1_a,
  input  [31:0] io_data_1_b,
  input  [31:0] io_data_1_c,
  input         io_data_1_selectPredicate,
  input         io_out_ready,
  output        io_out_valid,
  output [15:0] io_out_bits_op,
  output [3:0]  io_out_bits_dtype,
  output [31:0] io_out_bits_a,
  output [31:0] io_out_bits_b,
  output [31:0] io_out_bits_c,
  output        io_out_bits_selectPredicate
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
`endif // RANDOMIZE_REG_INIT
  reg  selectValid; // @[AecIntAlu.scala 51:28]
  reg  selectedGroup; // @[AecIntAlu.scala 52:26]
  reg  dataValid; // @[AecIntAlu.scala 53:26]
  reg [15:0] data_op; // @[AecIntAlu.scala 54:17]
  reg [3:0] data_dtype; // @[AecIntAlu.scala 54:17]
  reg [31:0] data_a; // @[AecIntAlu.scala 54:17]
  reg [31:0] data_b; // @[AecIntAlu.scala 54:17]
  reg [31:0] data_c; // @[AecIntAlu.scala 54:17]
  reg  data_selectPredicate; // @[AecIntAlu.scala 54:17]
  wire  dataReady = ~dataValid | io_out_ready; // @[AecIntAlu.scala 55:30]
  wire  selectReady = ~selectValid | dataReady; // @[AecIntAlu.scala 56:34]
  assign io_inReady = ~selectValid | dataReady; // @[AecIntAlu.scala 56:34]
  assign io_out_valid = dataValid; // @[AecIntAlu.scala 59:16]
  assign io_out_bits_op = data_op; // @[AecIntAlu.scala 60:15]
  assign io_out_bits_dtype = data_dtype; // @[AecIntAlu.scala 60:15]
  assign io_out_bits_a = data_a; // @[AecIntAlu.scala 60:15]
  assign io_out_bits_b = data_b; // @[AecIntAlu.scala 60:15]
  assign io_out_bits_c = data_c; // @[AecIntAlu.scala 60:15]
  assign io_out_bits_selectPredicate = data_selectPredicate; // @[AecIntAlu.scala 60:15]
  always @(posedge clock) begin
    if (reset) begin // @[AecIntAlu.scala 51:28]
      selectValid <= 1'h0; // @[AecIntAlu.scala 51:28]
    end else if (selectReady) begin // @[AecIntAlu.scala 65:22]
      selectValid <= io_inValid; // @[AecIntAlu.scala 66:17]
    end
    if (selectReady) begin // @[AecIntAlu.scala 65:22]
      if (io_inValid) begin // @[AecIntAlu.scala 67:23]
        selectedGroup <= io_group; // @[AecIntAlu.scala 67:39]
      end
    end
    if (reset) begin // @[AecIntAlu.scala 53:26]
      dataValid <= 1'h0; // @[AecIntAlu.scala 53:26]
    end else if (dataReady) begin // @[AecIntAlu.scala 61:20]
      dataValid <= selectValid; // @[AecIntAlu.scala 62:15]
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_op <= io_data_1_op; // @[AecIntAlu.scala 63:31]
        end else begin
          data_op <= io_data_0_op;
        end
      end
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_dtype <= io_data_1_dtype; // @[AecIntAlu.scala 63:31]
        end else begin
          data_dtype <= io_data_0_dtype;
        end
      end
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_a <= io_data_1_a; // @[AecIntAlu.scala 63:31]
        end else begin
          data_a <= io_data_0_a;
        end
      end
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_b <= io_data_1_b; // @[AecIntAlu.scala 63:31]
        end else begin
          data_b <= io_data_0_b;
        end
      end
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_c <= io_data_1_c; // @[AecIntAlu.scala 63:31]
        end else begin
          data_c <= io_data_0_c;
        end
      end
    end
    if (dataReady) begin // @[AecIntAlu.scala 61:20]
      if (selectValid) begin // @[AecIntAlu.scala 63:24]
        if (selectedGroup) begin // @[AecIntAlu.scala 63:31]
          data_selectPredicate <= io_data_1_selectPredicate; // @[AecIntAlu.scala 63:31]
        end else begin
          data_selectPredicate <= io_data_0_selectPredicate;
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
  selectedGroup = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dataValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  data_op = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  data_dtype = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  data_a = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  data_b = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  data_c = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  data_selectPredicate = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecWarpRequestLaneBank(
  input         clock,
  input         reset,
  input  [63:0] io_inA_0,
  input  [63:0] io_inA_1,
  input  [63:0] io_inA_2,
  input  [63:0] io_inA_3,
  input  [63:0] io_inB_0,
  input  [63:0] io_inB_1,
  input  [63:0] io_inB_2,
  input  [63:0] io_inB_3,
  input  [63:0] io_inC_0,
  input  [63:0] io_inC_1,
  input  [63:0] io_inC_2,
  input  [63:0] io_inC_3,
  input  [3:0]  io_inActive,
  input  [3:0]  io_inPredicates,
  input         io_arm,
  output [63:0] io_outA_0,
  output [63:0] io_outA_1,
  output [63:0] io_outA_2,
  output [63:0] io_outA_3,
  output [63:0] io_outB_0,
  output [63:0] io_outB_1,
  output [63:0] io_outB_2,
  output [63:0] io_outB_3,
  output [63:0] io_outC_0,
  output [63:0] io_outC_1,
  output [63:0] io_outC_2,
  output [63:0] io_outC_3,
  output [3:0]  io_outActive,
  output [3:0]  io_outPredicates
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
`endif // RANDOMIZE_REG_INIT
  reg  operandCapture_0_0; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_1; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_2; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_3; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_4; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_5; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_6; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_7; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_8; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_9; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_10; // @[AecExecPort.scala 83:31]
  reg  operandCapture_0_11; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_0; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_1; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_2; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_3; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_4; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_5; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_6; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_7; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_8; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_9; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_10; // @[AecExecPort.scala 83:31]
  reg  operandCapture_1_11; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_0; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_1; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_2; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_3; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_4; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_5; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_6; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_7; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_8; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_9; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_10; // @[AecExecPort.scala 83:31]
  reg  operandCapture_2_11; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_0; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_1; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_2; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_3; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_4; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_5; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_6; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_7; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_8; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_9; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_10; // @[AecExecPort.scala 83:31]
  reg  operandCapture_3_11; // @[AecExecPort.scala 83:31]
  reg  maskCapture_0; // @[AecExecPort.scala 85:28]
  reg  maskCapture_1; // @[AecExecPort.scala 85:28]
  reg  maskCapture_2; // @[AecExecPort.scala 85:28]
  reg  maskCapture_3; // @[AecExecPort.scala 85:28]
  reg [15:0] a_0_0; // @[AecExecPort.scala 87:14]
  reg [15:0] a_0_1; // @[AecExecPort.scala 87:14]
  reg [15:0] a_0_2; // @[AecExecPort.scala 87:14]
  reg [15:0] a_0_3; // @[AecExecPort.scala 87:14]
  reg [15:0] a_1_0; // @[AecExecPort.scala 87:14]
  reg [15:0] a_1_1; // @[AecExecPort.scala 87:14]
  reg [15:0] a_1_2; // @[AecExecPort.scala 87:14]
  reg [15:0] a_1_3; // @[AecExecPort.scala 87:14]
  reg [15:0] a_2_0; // @[AecExecPort.scala 87:14]
  reg [15:0] a_2_1; // @[AecExecPort.scala 87:14]
  reg [15:0] a_2_2; // @[AecExecPort.scala 87:14]
  reg [15:0] a_2_3; // @[AecExecPort.scala 87:14]
  reg [15:0] a_3_0; // @[AecExecPort.scala 87:14]
  reg [15:0] a_3_1; // @[AecExecPort.scala 87:14]
  reg [15:0] a_3_2; // @[AecExecPort.scala 87:14]
  reg [15:0] a_3_3; // @[AecExecPort.scala 87:14]
  reg [15:0] b_0_0; // @[AecExecPort.scala 88:14]
  reg [15:0] b_0_1; // @[AecExecPort.scala 88:14]
  reg [15:0] b_0_2; // @[AecExecPort.scala 88:14]
  reg [15:0] b_0_3; // @[AecExecPort.scala 88:14]
  reg [15:0] b_1_0; // @[AecExecPort.scala 88:14]
  reg [15:0] b_1_1; // @[AecExecPort.scala 88:14]
  reg [15:0] b_1_2; // @[AecExecPort.scala 88:14]
  reg [15:0] b_1_3; // @[AecExecPort.scala 88:14]
  reg [15:0] b_2_0; // @[AecExecPort.scala 88:14]
  reg [15:0] b_2_1; // @[AecExecPort.scala 88:14]
  reg [15:0] b_2_2; // @[AecExecPort.scala 88:14]
  reg [15:0] b_2_3; // @[AecExecPort.scala 88:14]
  reg [15:0] b_3_0; // @[AecExecPort.scala 88:14]
  reg [15:0] b_3_1; // @[AecExecPort.scala 88:14]
  reg [15:0] b_3_2; // @[AecExecPort.scala 88:14]
  reg [15:0] b_3_3; // @[AecExecPort.scala 88:14]
  reg [15:0] c_0_0; // @[AecExecPort.scala 89:14]
  reg [15:0] c_0_1; // @[AecExecPort.scala 89:14]
  reg [15:0] c_0_2; // @[AecExecPort.scala 89:14]
  reg [15:0] c_0_3; // @[AecExecPort.scala 89:14]
  reg [15:0] c_1_0; // @[AecExecPort.scala 89:14]
  reg [15:0] c_1_1; // @[AecExecPort.scala 89:14]
  reg [15:0] c_1_2; // @[AecExecPort.scala 89:14]
  reg [15:0] c_1_3; // @[AecExecPort.scala 89:14]
  reg [15:0] c_2_0; // @[AecExecPort.scala 89:14]
  reg [15:0] c_2_1; // @[AecExecPort.scala 89:14]
  reg [15:0] c_2_2; // @[AecExecPort.scala 89:14]
  reg [15:0] c_2_3; // @[AecExecPort.scala 89:14]
  reg [15:0] c_3_0; // @[AecExecPort.scala 89:14]
  reg [15:0] c_3_1; // @[AecExecPort.scala 89:14]
  reg [15:0] c_3_2; // @[AecExecPort.scala 89:14]
  reg [15:0] c_3_3; // @[AecExecPort.scala 89:14]
  reg  active_0; // @[AecExecPort.scala 90:19]
  reg  active_1; // @[AecExecPort.scala 90:19]
  reg  active_2; // @[AecExecPort.scala 90:19]
  reg  active_3; // @[AecExecPort.scala 90:19]
  reg  predicates_0; // @[AecExecPort.scala 91:23]
  reg  predicates_1; // @[AecExecPort.scala 91:23]
  reg  predicates_2; // @[AecExecPort.scala 91:23]
  reg  predicates_3; // @[AecExecPort.scala 91:23]
  wire [31:0] io_outA_0_lo = {a_0_1,a_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_0_hi = {a_0_3,a_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_0_lo = {b_0_1,b_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_0_hi = {b_0_3,b_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_0_lo = {c_0_1,c_0_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_0_hi = {c_0_3,c_0_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_1_lo = {a_1_1,a_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_1_hi = {a_1_3,a_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_1_lo = {b_1_1,b_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_1_hi = {b_1_3,b_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_1_lo = {c_1_1,c_1_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_1_hi = {c_1_3,c_1_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_2_lo = {a_2_1,a_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_2_hi = {a_2_3,a_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_2_lo = {b_2_1,b_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_2_hi = {b_2_3,b_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_2_lo = {c_2_1,c_2_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_2_hi = {c_2_3,c_2_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_3_lo = {a_3_1,a_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outA_3_hi = {a_3_3,a_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_3_lo = {b_3_1,b_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outB_3_hi = {b_3_3,b_3_2}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_3_lo = {c_3_1,c_3_0}; // @[Cat.scala 33:92]
  wire [31:0] io_outC_3_hi = {c_3_3,c_3_2}; // @[Cat.scala 33:92]
  wire [1:0] io_outActive_lo = {active_1,active_0}; // @[Cat.scala 33:92]
  wire [1:0] io_outActive_hi = {active_3,active_2}; // @[Cat.scala 33:92]
  wire [1:0] io_outPredicates_lo = {predicates_1,predicates_0}; // @[Cat.scala 33:92]
  wire [1:0] io_outPredicates_hi = {predicates_3,predicates_2}; // @[Cat.scala 33:92]
  assign io_outA_0 = {io_outA_0_hi,io_outA_0_lo}; // @[Cat.scala 33:92]
  assign io_outA_1 = {io_outA_1_hi,io_outA_1_lo}; // @[Cat.scala 33:92]
  assign io_outA_2 = {io_outA_2_hi,io_outA_2_lo}; // @[Cat.scala 33:92]
  assign io_outA_3 = {io_outA_3_hi,io_outA_3_lo}; // @[Cat.scala 33:92]
  assign io_outB_0 = {io_outB_0_hi,io_outB_0_lo}; // @[Cat.scala 33:92]
  assign io_outB_1 = {io_outB_1_hi,io_outB_1_lo}; // @[Cat.scala 33:92]
  assign io_outB_2 = {io_outB_2_hi,io_outB_2_lo}; // @[Cat.scala 33:92]
  assign io_outB_3 = {io_outB_3_hi,io_outB_3_lo}; // @[Cat.scala 33:92]
  assign io_outC_0 = {io_outC_0_hi,io_outC_0_lo}; // @[Cat.scala 33:92]
  assign io_outC_1 = {io_outC_1_hi,io_outC_1_lo}; // @[Cat.scala 33:92]
  assign io_outC_2 = {io_outC_2_hi,io_outC_2_lo}; // @[Cat.scala 33:92]
  assign io_outC_3 = {io_outC_3_hi,io_outC_3_lo}; // @[Cat.scala 33:92]
  assign io_outActive = {io_outActive_hi,io_outActive_lo}; // @[Cat.scala 33:92]
  assign io_outPredicates = {io_outPredicates_hi,io_outPredicates_lo}; // @[Cat.scala 33:92]
  always @(posedge clock) begin
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_0 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_0 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_1 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_1 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_2 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_2 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_3 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_3 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_4 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_4 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_5 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_5 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_6 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_6 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_7 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_7 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_8 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_8 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_9 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_9 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_10 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_10 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_0_11 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_0_11 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_0 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_0 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_1 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_1 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_2 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_2 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_3 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_3 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_4 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_4 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_5 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_5 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_6 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_6 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_7 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_7 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_8 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_8 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_9 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_9 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_10 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_10 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_1_11 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_1_11 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_0 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_0 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_1 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_1 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_2 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_2 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_3 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_3 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_4 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_4 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_5 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_5 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_6 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_6 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_7 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_7 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_8 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_8 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_9 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_9 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_10 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_10 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_2_11 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_2_11 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_0 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_0 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_1 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_1 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_2 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_2 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_3 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_3 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_4 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_4 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_5 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_5 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_6 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_6 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_7 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_7 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_8 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_8 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_9 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_9 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_10 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_10 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 83:31]
      operandCapture_3_11 <= 1'h0; // @[AecExecPort.scala 83:31]
    end else begin
      operandCapture_3_11 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 85:28]
      maskCapture_0 <= 1'h0; // @[AecExecPort.scala 85:28]
    end else begin
      maskCapture_0 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 85:28]
      maskCapture_1 <= 1'h0; // @[AecExecPort.scala 85:28]
    end else begin
      maskCapture_1 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 85:28]
      maskCapture_2 <= 1'h0; // @[AecExecPort.scala 85:28]
    end else begin
      maskCapture_2 <= io_arm;
    end
    if (reset) begin // @[AecExecPort.scala 85:28]
      maskCapture_3 <= 1'h0; // @[AecExecPort.scala 85:28]
    end else begin
      maskCapture_3 <= io_arm;
    end
    if (operandCapture_0_0) begin // @[AecExecPort.scala 97:38]
      a_0_0 <= io_inA_0[15:0]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_0_1) begin // @[AecExecPort.scala 97:38]
      a_0_1 <= io_inA_0[31:16]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_0_2) begin // @[AecExecPort.scala 97:38]
      a_0_2 <= io_inA_0[47:32]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_0_3) begin // @[AecExecPort.scala 97:38]
      a_0_3 <= io_inA_0[63:48]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_1_0) begin // @[AecExecPort.scala 97:38]
      a_1_0 <= io_inA_1[15:0]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_1_1) begin // @[AecExecPort.scala 97:38]
      a_1_1 <= io_inA_1[31:16]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_1_2) begin // @[AecExecPort.scala 97:38]
      a_1_2 <= io_inA_1[47:32]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_1_3) begin // @[AecExecPort.scala 97:38]
      a_1_3 <= io_inA_1[63:48]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_2_0) begin // @[AecExecPort.scala 97:38]
      a_2_0 <= io_inA_2[15:0]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_2_1) begin // @[AecExecPort.scala 97:38]
      a_2_1 <= io_inA_2[31:16]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_2_2) begin // @[AecExecPort.scala 97:38]
      a_2_2 <= io_inA_2[47:32]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_2_3) begin // @[AecExecPort.scala 97:38]
      a_2_3 <= io_inA_2[63:48]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_3_0) begin // @[AecExecPort.scala 97:38]
      a_3_0 <= io_inA_3[15:0]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_3_1) begin // @[AecExecPort.scala 97:38]
      a_3_1 <= io_inA_3[31:16]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_3_2) begin // @[AecExecPort.scala 97:38]
      a_3_2 <= io_inA_3[47:32]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_3_3) begin // @[AecExecPort.scala 97:38]
      a_3_3 <= io_inA_3[63:48]; // @[AecExecPort.scala 97:51]
    end
    if (operandCapture_0_4) begin // @[AecExecPort.scala 98:56]
      b_0_0 <= io_inB_0[15:0]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_0_5) begin // @[AecExecPort.scala 98:56]
      b_0_1 <= io_inB_0[31:16]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_0_6) begin // @[AecExecPort.scala 98:56]
      b_0_2 <= io_inB_0[47:32]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_0_7) begin // @[AecExecPort.scala 98:56]
      b_0_3 <= io_inB_0[63:48]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_1_4) begin // @[AecExecPort.scala 98:56]
      b_1_0 <= io_inB_1[15:0]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_1_5) begin // @[AecExecPort.scala 98:56]
      b_1_1 <= io_inB_1[31:16]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_1_6) begin // @[AecExecPort.scala 98:56]
      b_1_2 <= io_inB_1[47:32]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_1_7) begin // @[AecExecPort.scala 98:56]
      b_1_3 <= io_inB_1[63:48]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_2_4) begin // @[AecExecPort.scala 98:56]
      b_2_0 <= io_inB_2[15:0]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_2_5) begin // @[AecExecPort.scala 98:56]
      b_2_1 <= io_inB_2[31:16]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_2_6) begin // @[AecExecPort.scala 98:56]
      b_2_2 <= io_inB_2[47:32]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_2_7) begin // @[AecExecPort.scala 98:56]
      b_2_3 <= io_inB_2[63:48]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_3_4) begin // @[AecExecPort.scala 98:56]
      b_3_0 <= io_inB_3[15:0]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_3_5) begin // @[AecExecPort.scala 98:56]
      b_3_1 <= io_inB_3[31:16]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_3_6) begin // @[AecExecPort.scala 98:56]
      b_3_2 <= io_inB_3[47:32]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_3_7) begin // @[AecExecPort.scala 98:56]
      b_3_3 <= io_inB_3[63:48]; // @[AecExecPort.scala 98:69]
    end
    if (operandCapture_0_8) begin // @[AecExecPort.scala 99:60]
      c_0_0 <= io_inC_0[15:0]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_0_9) begin // @[AecExecPort.scala 99:60]
      c_0_1 <= io_inC_0[31:16]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_0_10) begin // @[AecExecPort.scala 99:60]
      c_0_2 <= io_inC_0[47:32]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_0_11) begin // @[AecExecPort.scala 99:60]
      c_0_3 <= io_inC_0[63:48]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_1_8) begin // @[AecExecPort.scala 99:60]
      c_1_0 <= io_inC_1[15:0]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_1_9) begin // @[AecExecPort.scala 99:60]
      c_1_1 <= io_inC_1[31:16]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_1_10) begin // @[AecExecPort.scala 99:60]
      c_1_2 <= io_inC_1[47:32]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_1_11) begin // @[AecExecPort.scala 99:60]
      c_1_3 <= io_inC_1[63:48]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_2_8) begin // @[AecExecPort.scala 99:60]
      c_2_0 <= io_inC_2[15:0]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_2_9) begin // @[AecExecPort.scala 99:60]
      c_2_1 <= io_inC_2[31:16]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_2_10) begin // @[AecExecPort.scala 99:60]
      c_2_2 <= io_inC_2[47:32]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_2_11) begin // @[AecExecPort.scala 99:60]
      c_2_3 <= io_inC_2[63:48]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_3_8) begin // @[AecExecPort.scala 99:60]
      c_3_0 <= io_inC_3[15:0]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_3_9) begin // @[AecExecPort.scala 99:60]
      c_3_1 <= io_inC_3[31:16]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_3_10) begin // @[AecExecPort.scala 99:60]
      c_3_2 <= io_inC_3[47:32]; // @[AecExecPort.scala 99:73]
    end
    if (operandCapture_3_11) begin // @[AecExecPort.scala 99:60]
      c_3_3 <= io_inC_3[63:48]; // @[AecExecPort.scala 99:73]
    end
    if (maskCapture_0) begin // @[AecExecPort.scala 101:27]
      active_0 <= io_inActive[0]; // @[AecExecPort.scala 102:17]
    end
    if (maskCapture_1) begin // @[AecExecPort.scala 101:27]
      active_1 <= io_inActive[1]; // @[AecExecPort.scala 102:17]
    end
    if (maskCapture_2) begin // @[AecExecPort.scala 101:27]
      active_2 <= io_inActive[2]; // @[AecExecPort.scala 102:17]
    end
    if (maskCapture_3) begin // @[AecExecPort.scala 101:27]
      active_3 <= io_inActive[3]; // @[AecExecPort.scala 102:17]
    end
    if (maskCapture_0) begin // @[AecExecPort.scala 101:27]
      predicates_0 <= io_inPredicates[0]; // @[AecExecPort.scala 103:21]
    end
    if (maskCapture_1) begin // @[AecExecPort.scala 101:27]
      predicates_1 <= io_inPredicates[1]; // @[AecExecPort.scala 103:21]
    end
    if (maskCapture_2) begin // @[AecExecPort.scala 101:27]
      predicates_2 <= io_inPredicates[2]; // @[AecExecPort.scala 103:21]
    end
    if (maskCapture_3) begin // @[AecExecPort.scala 101:27]
      predicates_3 <= io_inPredicates[3]; // @[AecExecPort.scala 103:21]
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
  maskCapture_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  maskCapture_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  maskCapture_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  maskCapture_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  a_0_0 = _RAND_52[15:0];
  _RAND_53 = {1{`RANDOM}};
  a_0_1 = _RAND_53[15:0];
  _RAND_54 = {1{`RANDOM}};
  a_0_2 = _RAND_54[15:0];
  _RAND_55 = {1{`RANDOM}};
  a_0_3 = _RAND_55[15:0];
  _RAND_56 = {1{`RANDOM}};
  a_1_0 = _RAND_56[15:0];
  _RAND_57 = {1{`RANDOM}};
  a_1_1 = _RAND_57[15:0];
  _RAND_58 = {1{`RANDOM}};
  a_1_2 = _RAND_58[15:0];
  _RAND_59 = {1{`RANDOM}};
  a_1_3 = _RAND_59[15:0];
  _RAND_60 = {1{`RANDOM}};
  a_2_0 = _RAND_60[15:0];
  _RAND_61 = {1{`RANDOM}};
  a_2_1 = _RAND_61[15:0];
  _RAND_62 = {1{`RANDOM}};
  a_2_2 = _RAND_62[15:0];
  _RAND_63 = {1{`RANDOM}};
  a_2_3 = _RAND_63[15:0];
  _RAND_64 = {1{`RANDOM}};
  a_3_0 = _RAND_64[15:0];
  _RAND_65 = {1{`RANDOM}};
  a_3_1 = _RAND_65[15:0];
  _RAND_66 = {1{`RANDOM}};
  a_3_2 = _RAND_66[15:0];
  _RAND_67 = {1{`RANDOM}};
  a_3_3 = _RAND_67[15:0];
  _RAND_68 = {1{`RANDOM}};
  b_0_0 = _RAND_68[15:0];
  _RAND_69 = {1{`RANDOM}};
  b_0_1 = _RAND_69[15:0];
  _RAND_70 = {1{`RANDOM}};
  b_0_2 = _RAND_70[15:0];
  _RAND_71 = {1{`RANDOM}};
  b_0_3 = _RAND_71[15:0];
  _RAND_72 = {1{`RANDOM}};
  b_1_0 = _RAND_72[15:0];
  _RAND_73 = {1{`RANDOM}};
  b_1_1 = _RAND_73[15:0];
  _RAND_74 = {1{`RANDOM}};
  b_1_2 = _RAND_74[15:0];
  _RAND_75 = {1{`RANDOM}};
  b_1_3 = _RAND_75[15:0];
  _RAND_76 = {1{`RANDOM}};
  b_2_0 = _RAND_76[15:0];
  _RAND_77 = {1{`RANDOM}};
  b_2_1 = _RAND_77[15:0];
  _RAND_78 = {1{`RANDOM}};
  b_2_2 = _RAND_78[15:0];
  _RAND_79 = {1{`RANDOM}};
  b_2_3 = _RAND_79[15:0];
  _RAND_80 = {1{`RANDOM}};
  b_3_0 = _RAND_80[15:0];
  _RAND_81 = {1{`RANDOM}};
  b_3_1 = _RAND_81[15:0];
  _RAND_82 = {1{`RANDOM}};
  b_3_2 = _RAND_82[15:0];
  _RAND_83 = {1{`RANDOM}};
  b_3_3 = _RAND_83[15:0];
  _RAND_84 = {1{`RANDOM}};
  c_0_0 = _RAND_84[15:0];
  _RAND_85 = {1{`RANDOM}};
  c_0_1 = _RAND_85[15:0];
  _RAND_86 = {1{`RANDOM}};
  c_0_2 = _RAND_86[15:0];
  _RAND_87 = {1{`RANDOM}};
  c_0_3 = _RAND_87[15:0];
  _RAND_88 = {1{`RANDOM}};
  c_1_0 = _RAND_88[15:0];
  _RAND_89 = {1{`RANDOM}};
  c_1_1 = _RAND_89[15:0];
  _RAND_90 = {1{`RANDOM}};
  c_1_2 = _RAND_90[15:0];
  _RAND_91 = {1{`RANDOM}};
  c_1_3 = _RAND_91[15:0];
  _RAND_92 = {1{`RANDOM}};
  c_2_0 = _RAND_92[15:0];
  _RAND_93 = {1{`RANDOM}};
  c_2_1 = _RAND_93[15:0];
  _RAND_94 = {1{`RANDOM}};
  c_2_2 = _RAND_94[15:0];
  _RAND_95 = {1{`RANDOM}};
  c_2_3 = _RAND_95[15:0];
  _RAND_96 = {1{`RANDOM}};
  c_3_0 = _RAND_96[15:0];
  _RAND_97 = {1{`RANDOM}};
  c_3_1 = _RAND_97[15:0];
  _RAND_98 = {1{`RANDOM}};
  c_3_2 = _RAND_98[15:0];
  _RAND_99 = {1{`RANDOM}};
  c_3_3 = _RAND_99[15:0];
  _RAND_100 = {1{`RANDOM}};
  active_0 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  active_1 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  active_2 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  active_3 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  predicates_0 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  predicates_1 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  predicates_2 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  predicates_3 = _RAND_107[0:0];
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
  input  [31:0] io_in_predicateValues,
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
  output [7:0]  io_out_dest,
  output [31:0] io_out_predicateValues
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  laneBanks_0_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_0_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_0_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_0_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_0_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_0_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_0_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_0_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_1_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_1_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_1_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_1_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_1_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_1_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_1_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_1_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_2_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_2_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_2_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_2_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_2_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_2_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_2_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_2_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_3_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_3_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_3_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_3_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_3_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_3_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_3_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_3_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_4_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_4_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_4_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_4_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_4_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_4_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_4_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_4_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_5_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_5_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_5_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_5_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_5_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_5_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_5_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_5_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_6_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_6_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_6_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_6_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_6_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_6_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_6_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_6_io_outPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_7_clock; // @[AecExecPort.scala 129:37]
  wire  laneBanks_7_reset; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_inC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_7_io_inActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_7_io_inPredicates; // @[AecExecPort.scala 129:37]
  wire  laneBanks_7_io_arm; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outA_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outA_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outA_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outA_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outB_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outB_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outB_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outB_3; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outC_0; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outC_1; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outC_2; // @[AecExecPort.scala 129:37]
  wire [63:0] laneBanks_7_io_outC_3; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_7_io_outActive; // @[AecExecPort.scala 129:37]
  wire [3:0] laneBanks_7_io_outPredicates; // @[AecExecPort.scala 129:37]
  reg [15:0] op; // @[AecExecPort.scala 145:15]
  reg [3:0] dtype; // @[AecExecPort.scala 146:18]
  reg [7:0] dest; // @[AecExecPort.scala 147:17]
  wire [15:0] io_out_activeMask_lo = {laneBanks_3_io_outActive,laneBanks_2_io_outActive,laneBanks_1_io_outActive,
    laneBanks_0_io_outActive}; // @[Cat.scala 33:92]
  wire [15:0] io_out_activeMask_hi = {laneBanks_7_io_outActive,laneBanks_6_io_outActive,laneBanks_5_io_outActive,
    laneBanks_4_io_outActive}; // @[Cat.scala 33:92]
  wire [15:0] io_out_predicateValues_lo = {laneBanks_3_io_outPredicates,laneBanks_2_io_outPredicates,
    laneBanks_1_io_outPredicates,laneBanks_0_io_outPredicates}; // @[Cat.scala 33:92]
  wire [15:0] io_out_predicateValues_hi = {laneBanks_7_io_outPredicates,laneBanks_6_io_outPredicates,
    laneBanks_5_io_outPredicates,laneBanks_4_io_outPredicates}; // @[Cat.scala 33:92]
  AecWarpRequestLaneBank laneBanks_0 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_0_clock),
    .reset(laneBanks_0_reset),
    .io_inA_0(laneBanks_0_io_inA_0),
    .io_inA_1(laneBanks_0_io_inA_1),
    .io_inA_2(laneBanks_0_io_inA_2),
    .io_inA_3(laneBanks_0_io_inA_3),
    .io_inB_0(laneBanks_0_io_inB_0),
    .io_inB_1(laneBanks_0_io_inB_1),
    .io_inB_2(laneBanks_0_io_inB_2),
    .io_inB_3(laneBanks_0_io_inB_3),
    .io_inC_0(laneBanks_0_io_inC_0),
    .io_inC_1(laneBanks_0_io_inC_1),
    .io_inC_2(laneBanks_0_io_inC_2),
    .io_inC_3(laneBanks_0_io_inC_3),
    .io_inActive(laneBanks_0_io_inActive),
    .io_inPredicates(laneBanks_0_io_inPredicates),
    .io_arm(laneBanks_0_io_arm),
    .io_outA_0(laneBanks_0_io_outA_0),
    .io_outA_1(laneBanks_0_io_outA_1),
    .io_outA_2(laneBanks_0_io_outA_2),
    .io_outA_3(laneBanks_0_io_outA_3),
    .io_outB_0(laneBanks_0_io_outB_0),
    .io_outB_1(laneBanks_0_io_outB_1),
    .io_outB_2(laneBanks_0_io_outB_2),
    .io_outB_3(laneBanks_0_io_outB_3),
    .io_outC_0(laneBanks_0_io_outC_0),
    .io_outC_1(laneBanks_0_io_outC_1),
    .io_outC_2(laneBanks_0_io_outC_2),
    .io_outC_3(laneBanks_0_io_outC_3),
    .io_outActive(laneBanks_0_io_outActive),
    .io_outPredicates(laneBanks_0_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_1 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_1_clock),
    .reset(laneBanks_1_reset),
    .io_inA_0(laneBanks_1_io_inA_0),
    .io_inA_1(laneBanks_1_io_inA_1),
    .io_inA_2(laneBanks_1_io_inA_2),
    .io_inA_3(laneBanks_1_io_inA_3),
    .io_inB_0(laneBanks_1_io_inB_0),
    .io_inB_1(laneBanks_1_io_inB_1),
    .io_inB_2(laneBanks_1_io_inB_2),
    .io_inB_3(laneBanks_1_io_inB_3),
    .io_inC_0(laneBanks_1_io_inC_0),
    .io_inC_1(laneBanks_1_io_inC_1),
    .io_inC_2(laneBanks_1_io_inC_2),
    .io_inC_3(laneBanks_1_io_inC_3),
    .io_inActive(laneBanks_1_io_inActive),
    .io_inPredicates(laneBanks_1_io_inPredicates),
    .io_arm(laneBanks_1_io_arm),
    .io_outA_0(laneBanks_1_io_outA_0),
    .io_outA_1(laneBanks_1_io_outA_1),
    .io_outA_2(laneBanks_1_io_outA_2),
    .io_outA_3(laneBanks_1_io_outA_3),
    .io_outB_0(laneBanks_1_io_outB_0),
    .io_outB_1(laneBanks_1_io_outB_1),
    .io_outB_2(laneBanks_1_io_outB_2),
    .io_outB_3(laneBanks_1_io_outB_3),
    .io_outC_0(laneBanks_1_io_outC_0),
    .io_outC_1(laneBanks_1_io_outC_1),
    .io_outC_2(laneBanks_1_io_outC_2),
    .io_outC_3(laneBanks_1_io_outC_3),
    .io_outActive(laneBanks_1_io_outActive),
    .io_outPredicates(laneBanks_1_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_2 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_2_clock),
    .reset(laneBanks_2_reset),
    .io_inA_0(laneBanks_2_io_inA_0),
    .io_inA_1(laneBanks_2_io_inA_1),
    .io_inA_2(laneBanks_2_io_inA_2),
    .io_inA_3(laneBanks_2_io_inA_3),
    .io_inB_0(laneBanks_2_io_inB_0),
    .io_inB_1(laneBanks_2_io_inB_1),
    .io_inB_2(laneBanks_2_io_inB_2),
    .io_inB_3(laneBanks_2_io_inB_3),
    .io_inC_0(laneBanks_2_io_inC_0),
    .io_inC_1(laneBanks_2_io_inC_1),
    .io_inC_2(laneBanks_2_io_inC_2),
    .io_inC_3(laneBanks_2_io_inC_3),
    .io_inActive(laneBanks_2_io_inActive),
    .io_inPredicates(laneBanks_2_io_inPredicates),
    .io_arm(laneBanks_2_io_arm),
    .io_outA_0(laneBanks_2_io_outA_0),
    .io_outA_1(laneBanks_2_io_outA_1),
    .io_outA_2(laneBanks_2_io_outA_2),
    .io_outA_3(laneBanks_2_io_outA_3),
    .io_outB_0(laneBanks_2_io_outB_0),
    .io_outB_1(laneBanks_2_io_outB_1),
    .io_outB_2(laneBanks_2_io_outB_2),
    .io_outB_3(laneBanks_2_io_outB_3),
    .io_outC_0(laneBanks_2_io_outC_0),
    .io_outC_1(laneBanks_2_io_outC_1),
    .io_outC_2(laneBanks_2_io_outC_2),
    .io_outC_3(laneBanks_2_io_outC_3),
    .io_outActive(laneBanks_2_io_outActive),
    .io_outPredicates(laneBanks_2_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_3 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_3_clock),
    .reset(laneBanks_3_reset),
    .io_inA_0(laneBanks_3_io_inA_0),
    .io_inA_1(laneBanks_3_io_inA_1),
    .io_inA_2(laneBanks_3_io_inA_2),
    .io_inA_3(laneBanks_3_io_inA_3),
    .io_inB_0(laneBanks_3_io_inB_0),
    .io_inB_1(laneBanks_3_io_inB_1),
    .io_inB_2(laneBanks_3_io_inB_2),
    .io_inB_3(laneBanks_3_io_inB_3),
    .io_inC_0(laneBanks_3_io_inC_0),
    .io_inC_1(laneBanks_3_io_inC_1),
    .io_inC_2(laneBanks_3_io_inC_2),
    .io_inC_3(laneBanks_3_io_inC_3),
    .io_inActive(laneBanks_3_io_inActive),
    .io_inPredicates(laneBanks_3_io_inPredicates),
    .io_arm(laneBanks_3_io_arm),
    .io_outA_0(laneBanks_3_io_outA_0),
    .io_outA_1(laneBanks_3_io_outA_1),
    .io_outA_2(laneBanks_3_io_outA_2),
    .io_outA_3(laneBanks_3_io_outA_3),
    .io_outB_0(laneBanks_3_io_outB_0),
    .io_outB_1(laneBanks_3_io_outB_1),
    .io_outB_2(laneBanks_3_io_outB_2),
    .io_outB_3(laneBanks_3_io_outB_3),
    .io_outC_0(laneBanks_3_io_outC_0),
    .io_outC_1(laneBanks_3_io_outC_1),
    .io_outC_2(laneBanks_3_io_outC_2),
    .io_outC_3(laneBanks_3_io_outC_3),
    .io_outActive(laneBanks_3_io_outActive),
    .io_outPredicates(laneBanks_3_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_4 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_4_clock),
    .reset(laneBanks_4_reset),
    .io_inA_0(laneBanks_4_io_inA_0),
    .io_inA_1(laneBanks_4_io_inA_1),
    .io_inA_2(laneBanks_4_io_inA_2),
    .io_inA_3(laneBanks_4_io_inA_3),
    .io_inB_0(laneBanks_4_io_inB_0),
    .io_inB_1(laneBanks_4_io_inB_1),
    .io_inB_2(laneBanks_4_io_inB_2),
    .io_inB_3(laneBanks_4_io_inB_3),
    .io_inC_0(laneBanks_4_io_inC_0),
    .io_inC_1(laneBanks_4_io_inC_1),
    .io_inC_2(laneBanks_4_io_inC_2),
    .io_inC_3(laneBanks_4_io_inC_3),
    .io_inActive(laneBanks_4_io_inActive),
    .io_inPredicates(laneBanks_4_io_inPredicates),
    .io_arm(laneBanks_4_io_arm),
    .io_outA_0(laneBanks_4_io_outA_0),
    .io_outA_1(laneBanks_4_io_outA_1),
    .io_outA_2(laneBanks_4_io_outA_2),
    .io_outA_3(laneBanks_4_io_outA_3),
    .io_outB_0(laneBanks_4_io_outB_0),
    .io_outB_1(laneBanks_4_io_outB_1),
    .io_outB_2(laneBanks_4_io_outB_2),
    .io_outB_3(laneBanks_4_io_outB_3),
    .io_outC_0(laneBanks_4_io_outC_0),
    .io_outC_1(laneBanks_4_io_outC_1),
    .io_outC_2(laneBanks_4_io_outC_2),
    .io_outC_3(laneBanks_4_io_outC_3),
    .io_outActive(laneBanks_4_io_outActive),
    .io_outPredicates(laneBanks_4_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_5 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_5_clock),
    .reset(laneBanks_5_reset),
    .io_inA_0(laneBanks_5_io_inA_0),
    .io_inA_1(laneBanks_5_io_inA_1),
    .io_inA_2(laneBanks_5_io_inA_2),
    .io_inA_3(laneBanks_5_io_inA_3),
    .io_inB_0(laneBanks_5_io_inB_0),
    .io_inB_1(laneBanks_5_io_inB_1),
    .io_inB_2(laneBanks_5_io_inB_2),
    .io_inB_3(laneBanks_5_io_inB_3),
    .io_inC_0(laneBanks_5_io_inC_0),
    .io_inC_1(laneBanks_5_io_inC_1),
    .io_inC_2(laneBanks_5_io_inC_2),
    .io_inC_3(laneBanks_5_io_inC_3),
    .io_inActive(laneBanks_5_io_inActive),
    .io_inPredicates(laneBanks_5_io_inPredicates),
    .io_arm(laneBanks_5_io_arm),
    .io_outA_0(laneBanks_5_io_outA_0),
    .io_outA_1(laneBanks_5_io_outA_1),
    .io_outA_2(laneBanks_5_io_outA_2),
    .io_outA_3(laneBanks_5_io_outA_3),
    .io_outB_0(laneBanks_5_io_outB_0),
    .io_outB_1(laneBanks_5_io_outB_1),
    .io_outB_2(laneBanks_5_io_outB_2),
    .io_outB_3(laneBanks_5_io_outB_3),
    .io_outC_0(laneBanks_5_io_outC_0),
    .io_outC_1(laneBanks_5_io_outC_1),
    .io_outC_2(laneBanks_5_io_outC_2),
    .io_outC_3(laneBanks_5_io_outC_3),
    .io_outActive(laneBanks_5_io_outActive),
    .io_outPredicates(laneBanks_5_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_6 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_6_clock),
    .reset(laneBanks_6_reset),
    .io_inA_0(laneBanks_6_io_inA_0),
    .io_inA_1(laneBanks_6_io_inA_1),
    .io_inA_2(laneBanks_6_io_inA_2),
    .io_inA_3(laneBanks_6_io_inA_3),
    .io_inB_0(laneBanks_6_io_inB_0),
    .io_inB_1(laneBanks_6_io_inB_1),
    .io_inB_2(laneBanks_6_io_inB_2),
    .io_inB_3(laneBanks_6_io_inB_3),
    .io_inC_0(laneBanks_6_io_inC_0),
    .io_inC_1(laneBanks_6_io_inC_1),
    .io_inC_2(laneBanks_6_io_inC_2),
    .io_inC_3(laneBanks_6_io_inC_3),
    .io_inActive(laneBanks_6_io_inActive),
    .io_inPredicates(laneBanks_6_io_inPredicates),
    .io_arm(laneBanks_6_io_arm),
    .io_outA_0(laneBanks_6_io_outA_0),
    .io_outA_1(laneBanks_6_io_outA_1),
    .io_outA_2(laneBanks_6_io_outA_2),
    .io_outA_3(laneBanks_6_io_outA_3),
    .io_outB_0(laneBanks_6_io_outB_0),
    .io_outB_1(laneBanks_6_io_outB_1),
    .io_outB_2(laneBanks_6_io_outB_2),
    .io_outB_3(laneBanks_6_io_outB_3),
    .io_outC_0(laneBanks_6_io_outC_0),
    .io_outC_1(laneBanks_6_io_outC_1),
    .io_outC_2(laneBanks_6_io_outC_2),
    .io_outC_3(laneBanks_6_io_outC_3),
    .io_outActive(laneBanks_6_io_outActive),
    .io_outPredicates(laneBanks_6_io_outPredicates)
  );
  AecWarpRequestLaneBank laneBanks_7 ( // @[AecExecPort.scala 129:37]
    .clock(laneBanks_7_clock),
    .reset(laneBanks_7_reset),
    .io_inA_0(laneBanks_7_io_inA_0),
    .io_inA_1(laneBanks_7_io_inA_1),
    .io_inA_2(laneBanks_7_io_inA_2),
    .io_inA_3(laneBanks_7_io_inA_3),
    .io_inB_0(laneBanks_7_io_inB_0),
    .io_inB_1(laneBanks_7_io_inB_1),
    .io_inB_2(laneBanks_7_io_inB_2),
    .io_inB_3(laneBanks_7_io_inB_3),
    .io_inC_0(laneBanks_7_io_inC_0),
    .io_inC_1(laneBanks_7_io_inC_1),
    .io_inC_2(laneBanks_7_io_inC_2),
    .io_inC_3(laneBanks_7_io_inC_3),
    .io_inActive(laneBanks_7_io_inActive),
    .io_inPredicates(laneBanks_7_io_inPredicates),
    .io_arm(laneBanks_7_io_arm),
    .io_outA_0(laneBanks_7_io_outA_0),
    .io_outA_1(laneBanks_7_io_outA_1),
    .io_outA_2(laneBanks_7_io_outA_2),
    .io_outA_3(laneBanks_7_io_outA_3),
    .io_outB_0(laneBanks_7_io_outB_0),
    .io_outB_1(laneBanks_7_io_outB_1),
    .io_outB_2(laneBanks_7_io_outB_2),
    .io_outB_3(laneBanks_7_io_outB_3),
    .io_outC_0(laneBanks_7_io_outC_0),
    .io_outC_1(laneBanks_7_io_outC_1),
    .io_outC_2(laneBanks_7_io_outC_2),
    .io_outC_3(laneBanks_7_io_outC_3),
    .io_outActive(laneBanks_7_io_outActive),
    .io_outPredicates(laneBanks_7_io_outPredicates)
  );
  assign io_out_op = op; // @[AecExecPort.scala 156:13]
  assign io_out_dtype = dtype; // @[AecExecPort.scala 157:16]
  assign io_out_activeMask = {io_out_activeMask_hi,io_out_activeMask_lo}; // @[Cat.scala 33:92]
  assign io_out_a_0 = laneBanks_0_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_1 = laneBanks_0_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_2 = laneBanks_0_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_3 = laneBanks_0_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_4 = laneBanks_1_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_5 = laneBanks_1_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_6 = laneBanks_1_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_7 = laneBanks_1_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_8 = laneBanks_2_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_9 = laneBanks_2_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_10 = laneBanks_2_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_11 = laneBanks_2_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_12 = laneBanks_3_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_13 = laneBanks_3_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_14 = laneBanks_3_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_15 = laneBanks_3_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_16 = laneBanks_4_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_17 = laneBanks_4_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_18 = laneBanks_4_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_19 = laneBanks_4_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_20 = laneBanks_5_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_21 = laneBanks_5_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_22 = laneBanks_5_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_23 = laneBanks_5_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_24 = laneBanks_6_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_25 = laneBanks_6_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_26 = laneBanks_6_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_27 = laneBanks_6_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_a_28 = laneBanks_7_io_outA_0; // @[AecExecPort.scala 137:29]
  assign io_out_a_29 = laneBanks_7_io_outA_1; // @[AecExecPort.scala 137:29]
  assign io_out_a_30 = laneBanks_7_io_outA_2; // @[AecExecPort.scala 137:29]
  assign io_out_a_31 = laneBanks_7_io_outA_3; // @[AecExecPort.scala 137:29]
  assign io_out_b_0 = laneBanks_0_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_1 = laneBanks_0_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_2 = laneBanks_0_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_3 = laneBanks_0_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_4 = laneBanks_1_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_5 = laneBanks_1_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_6 = laneBanks_1_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_7 = laneBanks_1_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_8 = laneBanks_2_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_9 = laneBanks_2_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_10 = laneBanks_2_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_11 = laneBanks_2_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_12 = laneBanks_3_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_13 = laneBanks_3_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_14 = laneBanks_3_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_15 = laneBanks_3_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_16 = laneBanks_4_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_17 = laneBanks_4_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_18 = laneBanks_4_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_19 = laneBanks_4_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_20 = laneBanks_5_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_21 = laneBanks_5_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_22 = laneBanks_5_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_23 = laneBanks_5_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_24 = laneBanks_6_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_25 = laneBanks_6_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_26 = laneBanks_6_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_27 = laneBanks_6_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_b_28 = laneBanks_7_io_outB_0; // @[AecExecPort.scala 138:29]
  assign io_out_b_29 = laneBanks_7_io_outB_1; // @[AecExecPort.scala 138:29]
  assign io_out_b_30 = laneBanks_7_io_outB_2; // @[AecExecPort.scala 138:29]
  assign io_out_b_31 = laneBanks_7_io_outB_3; // @[AecExecPort.scala 138:29]
  assign io_out_c_0 = laneBanks_0_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_1 = laneBanks_0_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_2 = laneBanks_0_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_3 = laneBanks_0_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_4 = laneBanks_1_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_5 = laneBanks_1_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_6 = laneBanks_1_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_7 = laneBanks_1_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_8 = laneBanks_2_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_9 = laneBanks_2_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_10 = laneBanks_2_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_11 = laneBanks_2_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_12 = laneBanks_3_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_13 = laneBanks_3_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_14 = laneBanks_3_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_15 = laneBanks_3_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_16 = laneBanks_4_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_17 = laneBanks_4_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_18 = laneBanks_4_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_19 = laneBanks_4_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_20 = laneBanks_5_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_21 = laneBanks_5_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_22 = laneBanks_5_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_23 = laneBanks_5_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_24 = laneBanks_6_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_25 = laneBanks_6_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_26 = laneBanks_6_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_27 = laneBanks_6_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_c_28 = laneBanks_7_io_outC_0; // @[AecExecPort.scala 139:29]
  assign io_out_c_29 = laneBanks_7_io_outC_1; // @[AecExecPort.scala 139:29]
  assign io_out_c_30 = laneBanks_7_io_outC_2; // @[AecExecPort.scala 139:29]
  assign io_out_c_31 = laneBanks_7_io_outC_3; // @[AecExecPort.scala 139:29]
  assign io_out_dest = dest; // @[AecExecPort.scala 158:15]
  assign io_out_predicateValues = {io_out_predicateValues_hi,io_out_predicateValues_lo}; // @[Cat.scala 33:92]
  assign laneBanks_0_clock = clock;
  assign laneBanks_0_reset = reset;
  assign laneBanks_0_io_inA_0 = io_in_a_0; // @[AecExecPort.scala 134:39]
  assign laneBanks_0_io_inA_1 = io_in_a_1; // @[AecExecPort.scala 134:39]
  assign laneBanks_0_io_inA_2 = io_in_a_2; // @[AecExecPort.scala 134:39]
  assign laneBanks_0_io_inA_3 = io_in_a_3; // @[AecExecPort.scala 134:39]
  assign laneBanks_0_io_inB_0 = io_in_b_0; // @[AecExecPort.scala 135:39]
  assign laneBanks_0_io_inB_1 = io_in_b_1; // @[AecExecPort.scala 135:39]
  assign laneBanks_0_io_inB_2 = io_in_b_2; // @[AecExecPort.scala 135:39]
  assign laneBanks_0_io_inB_3 = io_in_b_3; // @[AecExecPort.scala 135:39]
  assign laneBanks_0_io_inC_0 = io_in_c_0; // @[AecExecPort.scala 136:39]
  assign laneBanks_0_io_inC_1 = io_in_c_1; // @[AecExecPort.scala 136:39]
  assign laneBanks_0_io_inC_2 = io_in_c_2; // @[AecExecPort.scala 136:39]
  assign laneBanks_0_io_inC_3 = io_in_c_3; // @[AecExecPort.scala 136:39]
  assign laneBanks_0_io_inActive = io_in_activeMask[3:0]; // @[AecExecPort.scala 141:55]
  assign laneBanks_0_io_inPredicates = io_in_predicateValues[3:0]; // @[AecExecPort.scala 142:64]
  assign laneBanks_0_io_arm = io_arm_0; // @[AecExecPort.scala 132:31]
  assign laneBanks_1_clock = clock;
  assign laneBanks_1_reset = reset;
  assign laneBanks_1_io_inA_0 = io_in_a_4; // @[AecExecPort.scala 134:39]
  assign laneBanks_1_io_inA_1 = io_in_a_5; // @[AecExecPort.scala 134:39]
  assign laneBanks_1_io_inA_2 = io_in_a_6; // @[AecExecPort.scala 134:39]
  assign laneBanks_1_io_inA_3 = io_in_a_7; // @[AecExecPort.scala 134:39]
  assign laneBanks_1_io_inB_0 = io_in_b_4; // @[AecExecPort.scala 135:39]
  assign laneBanks_1_io_inB_1 = io_in_b_5; // @[AecExecPort.scala 135:39]
  assign laneBanks_1_io_inB_2 = io_in_b_6; // @[AecExecPort.scala 135:39]
  assign laneBanks_1_io_inB_3 = io_in_b_7; // @[AecExecPort.scala 135:39]
  assign laneBanks_1_io_inC_0 = io_in_c_4; // @[AecExecPort.scala 136:39]
  assign laneBanks_1_io_inC_1 = io_in_c_5; // @[AecExecPort.scala 136:39]
  assign laneBanks_1_io_inC_2 = io_in_c_6; // @[AecExecPort.scala 136:39]
  assign laneBanks_1_io_inC_3 = io_in_c_7; // @[AecExecPort.scala 136:39]
  assign laneBanks_1_io_inActive = io_in_activeMask[7:4]; // @[AecExecPort.scala 141:55]
  assign laneBanks_1_io_inPredicates = io_in_predicateValues[7:4]; // @[AecExecPort.scala 142:64]
  assign laneBanks_1_io_arm = io_arm_1; // @[AecExecPort.scala 132:31]
  assign laneBanks_2_clock = clock;
  assign laneBanks_2_reset = reset;
  assign laneBanks_2_io_inA_0 = io_in_a_8; // @[AecExecPort.scala 134:39]
  assign laneBanks_2_io_inA_1 = io_in_a_9; // @[AecExecPort.scala 134:39]
  assign laneBanks_2_io_inA_2 = io_in_a_10; // @[AecExecPort.scala 134:39]
  assign laneBanks_2_io_inA_3 = io_in_a_11; // @[AecExecPort.scala 134:39]
  assign laneBanks_2_io_inB_0 = io_in_b_8; // @[AecExecPort.scala 135:39]
  assign laneBanks_2_io_inB_1 = io_in_b_9; // @[AecExecPort.scala 135:39]
  assign laneBanks_2_io_inB_2 = io_in_b_10; // @[AecExecPort.scala 135:39]
  assign laneBanks_2_io_inB_3 = io_in_b_11; // @[AecExecPort.scala 135:39]
  assign laneBanks_2_io_inC_0 = io_in_c_8; // @[AecExecPort.scala 136:39]
  assign laneBanks_2_io_inC_1 = io_in_c_9; // @[AecExecPort.scala 136:39]
  assign laneBanks_2_io_inC_2 = io_in_c_10; // @[AecExecPort.scala 136:39]
  assign laneBanks_2_io_inC_3 = io_in_c_11; // @[AecExecPort.scala 136:39]
  assign laneBanks_2_io_inActive = io_in_activeMask[11:8]; // @[AecExecPort.scala 141:55]
  assign laneBanks_2_io_inPredicates = io_in_predicateValues[11:8]; // @[AecExecPort.scala 142:64]
  assign laneBanks_2_io_arm = io_arm_2; // @[AecExecPort.scala 132:31]
  assign laneBanks_3_clock = clock;
  assign laneBanks_3_reset = reset;
  assign laneBanks_3_io_inA_0 = io_in_a_12; // @[AecExecPort.scala 134:39]
  assign laneBanks_3_io_inA_1 = io_in_a_13; // @[AecExecPort.scala 134:39]
  assign laneBanks_3_io_inA_2 = io_in_a_14; // @[AecExecPort.scala 134:39]
  assign laneBanks_3_io_inA_3 = io_in_a_15; // @[AecExecPort.scala 134:39]
  assign laneBanks_3_io_inB_0 = io_in_b_12; // @[AecExecPort.scala 135:39]
  assign laneBanks_3_io_inB_1 = io_in_b_13; // @[AecExecPort.scala 135:39]
  assign laneBanks_3_io_inB_2 = io_in_b_14; // @[AecExecPort.scala 135:39]
  assign laneBanks_3_io_inB_3 = io_in_b_15; // @[AecExecPort.scala 135:39]
  assign laneBanks_3_io_inC_0 = io_in_c_12; // @[AecExecPort.scala 136:39]
  assign laneBanks_3_io_inC_1 = io_in_c_13; // @[AecExecPort.scala 136:39]
  assign laneBanks_3_io_inC_2 = io_in_c_14; // @[AecExecPort.scala 136:39]
  assign laneBanks_3_io_inC_3 = io_in_c_15; // @[AecExecPort.scala 136:39]
  assign laneBanks_3_io_inActive = io_in_activeMask[15:12]; // @[AecExecPort.scala 141:55]
  assign laneBanks_3_io_inPredicates = io_in_predicateValues[15:12]; // @[AecExecPort.scala 142:64]
  assign laneBanks_3_io_arm = io_arm_3; // @[AecExecPort.scala 132:31]
  assign laneBanks_4_clock = clock;
  assign laneBanks_4_reset = reset;
  assign laneBanks_4_io_inA_0 = io_in_a_16; // @[AecExecPort.scala 134:39]
  assign laneBanks_4_io_inA_1 = io_in_a_17; // @[AecExecPort.scala 134:39]
  assign laneBanks_4_io_inA_2 = io_in_a_18; // @[AecExecPort.scala 134:39]
  assign laneBanks_4_io_inA_3 = io_in_a_19; // @[AecExecPort.scala 134:39]
  assign laneBanks_4_io_inB_0 = io_in_b_16; // @[AecExecPort.scala 135:39]
  assign laneBanks_4_io_inB_1 = io_in_b_17; // @[AecExecPort.scala 135:39]
  assign laneBanks_4_io_inB_2 = io_in_b_18; // @[AecExecPort.scala 135:39]
  assign laneBanks_4_io_inB_3 = io_in_b_19; // @[AecExecPort.scala 135:39]
  assign laneBanks_4_io_inC_0 = io_in_c_16; // @[AecExecPort.scala 136:39]
  assign laneBanks_4_io_inC_1 = io_in_c_17; // @[AecExecPort.scala 136:39]
  assign laneBanks_4_io_inC_2 = io_in_c_18; // @[AecExecPort.scala 136:39]
  assign laneBanks_4_io_inC_3 = io_in_c_19; // @[AecExecPort.scala 136:39]
  assign laneBanks_4_io_inActive = io_in_activeMask[19:16]; // @[AecExecPort.scala 141:55]
  assign laneBanks_4_io_inPredicates = io_in_predicateValues[19:16]; // @[AecExecPort.scala 142:64]
  assign laneBanks_4_io_arm = io_arm_4; // @[AecExecPort.scala 132:31]
  assign laneBanks_5_clock = clock;
  assign laneBanks_5_reset = reset;
  assign laneBanks_5_io_inA_0 = io_in_a_20; // @[AecExecPort.scala 134:39]
  assign laneBanks_5_io_inA_1 = io_in_a_21; // @[AecExecPort.scala 134:39]
  assign laneBanks_5_io_inA_2 = io_in_a_22; // @[AecExecPort.scala 134:39]
  assign laneBanks_5_io_inA_3 = io_in_a_23; // @[AecExecPort.scala 134:39]
  assign laneBanks_5_io_inB_0 = io_in_b_20; // @[AecExecPort.scala 135:39]
  assign laneBanks_5_io_inB_1 = io_in_b_21; // @[AecExecPort.scala 135:39]
  assign laneBanks_5_io_inB_2 = io_in_b_22; // @[AecExecPort.scala 135:39]
  assign laneBanks_5_io_inB_3 = io_in_b_23; // @[AecExecPort.scala 135:39]
  assign laneBanks_5_io_inC_0 = io_in_c_20; // @[AecExecPort.scala 136:39]
  assign laneBanks_5_io_inC_1 = io_in_c_21; // @[AecExecPort.scala 136:39]
  assign laneBanks_5_io_inC_2 = io_in_c_22; // @[AecExecPort.scala 136:39]
  assign laneBanks_5_io_inC_3 = io_in_c_23; // @[AecExecPort.scala 136:39]
  assign laneBanks_5_io_inActive = io_in_activeMask[23:20]; // @[AecExecPort.scala 141:55]
  assign laneBanks_5_io_inPredicates = io_in_predicateValues[23:20]; // @[AecExecPort.scala 142:64]
  assign laneBanks_5_io_arm = io_arm_5; // @[AecExecPort.scala 132:31]
  assign laneBanks_6_clock = clock;
  assign laneBanks_6_reset = reset;
  assign laneBanks_6_io_inA_0 = io_in_a_24; // @[AecExecPort.scala 134:39]
  assign laneBanks_6_io_inA_1 = io_in_a_25; // @[AecExecPort.scala 134:39]
  assign laneBanks_6_io_inA_2 = io_in_a_26; // @[AecExecPort.scala 134:39]
  assign laneBanks_6_io_inA_3 = io_in_a_27; // @[AecExecPort.scala 134:39]
  assign laneBanks_6_io_inB_0 = io_in_b_24; // @[AecExecPort.scala 135:39]
  assign laneBanks_6_io_inB_1 = io_in_b_25; // @[AecExecPort.scala 135:39]
  assign laneBanks_6_io_inB_2 = io_in_b_26; // @[AecExecPort.scala 135:39]
  assign laneBanks_6_io_inB_3 = io_in_b_27; // @[AecExecPort.scala 135:39]
  assign laneBanks_6_io_inC_0 = io_in_c_24; // @[AecExecPort.scala 136:39]
  assign laneBanks_6_io_inC_1 = io_in_c_25; // @[AecExecPort.scala 136:39]
  assign laneBanks_6_io_inC_2 = io_in_c_26; // @[AecExecPort.scala 136:39]
  assign laneBanks_6_io_inC_3 = io_in_c_27; // @[AecExecPort.scala 136:39]
  assign laneBanks_6_io_inActive = io_in_activeMask[27:24]; // @[AecExecPort.scala 141:55]
  assign laneBanks_6_io_inPredicates = io_in_predicateValues[27:24]; // @[AecExecPort.scala 142:64]
  assign laneBanks_6_io_arm = io_arm_6; // @[AecExecPort.scala 132:31]
  assign laneBanks_7_clock = clock;
  assign laneBanks_7_reset = reset;
  assign laneBanks_7_io_inA_0 = io_in_a_28; // @[AecExecPort.scala 134:39]
  assign laneBanks_7_io_inA_1 = io_in_a_29; // @[AecExecPort.scala 134:39]
  assign laneBanks_7_io_inA_2 = io_in_a_30; // @[AecExecPort.scala 134:39]
  assign laneBanks_7_io_inA_3 = io_in_a_31; // @[AecExecPort.scala 134:39]
  assign laneBanks_7_io_inB_0 = io_in_b_28; // @[AecExecPort.scala 135:39]
  assign laneBanks_7_io_inB_1 = io_in_b_29; // @[AecExecPort.scala 135:39]
  assign laneBanks_7_io_inB_2 = io_in_b_30; // @[AecExecPort.scala 135:39]
  assign laneBanks_7_io_inB_3 = io_in_b_31; // @[AecExecPort.scala 135:39]
  assign laneBanks_7_io_inC_0 = io_in_c_28; // @[AecExecPort.scala 136:39]
  assign laneBanks_7_io_inC_1 = io_in_c_29; // @[AecExecPort.scala 136:39]
  assign laneBanks_7_io_inC_2 = io_in_c_30; // @[AecExecPort.scala 136:39]
  assign laneBanks_7_io_inC_3 = io_in_c_31; // @[AecExecPort.scala 136:39]
  assign laneBanks_7_io_inActive = io_in_activeMask[31:28]; // @[AecExecPort.scala 141:55]
  assign laneBanks_7_io_inPredicates = io_in_predicateValues[31:28]; // @[AecExecPort.scala 142:64]
  assign laneBanks_7_io_arm = io_arm_7; // @[AecExecPort.scala 132:31]
  always @(posedge clock) begin
    if (io_capture) begin // @[AecExecPort.scala 149:21]
      op <= io_in_op; // @[AecExecPort.scala 150:8]
    end
    if (io_capture) begin // @[AecExecPort.scala 149:21]
      dtype <= io_in_dtype; // @[AecExecPort.scala 151:11]
    end
    if (io_capture) begin // @[AecExecPort.scala 149:21]
      dest <= io_in_dest; // @[AecExecPort.scala 152:10]
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
  op = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  dtype = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  dest = _RAND_2[7:0];
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
  input         io_writePredicate,
  input         io_writeError,
  output [63:0] io_result,
  output        io_predicate,
  output        io_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] result; // @[AecExecPort.scala 42:23]
  reg  predicate; // @[AecExecPort.scala 44:26]
  reg  error; // @[AecExecPort.scala 45:22]
  reg  pending; // @[AecExecPort.scala 46:24]
  reg [63:0] stagedResult; // @[AecExecPort.scala 47:29]
  reg  stagedPredicate; // @[AecExecPort.scala 49:32]
  reg  stagedError; // @[AecExecPort.scala 50:28]
  assign io_result = result; // @[AecExecPort.scala 57:13]
  assign io_predicate = predicate; // @[AecExecPort.scala 59:16]
  assign io_error = error; // @[AecExecPort.scala 60:12]
  always @(posedge clock) begin
    if (reset) begin // @[AecExecPort.scala 42:23]
      result <= 64'h0; // @[AecExecPort.scala 42:23]
    end else if (pending) begin // @[AecExecPort.scala 51:18]
      result <= stagedResult; // @[AecExecPort.scala 52:12]
    end
    if (reset) begin // @[AecExecPort.scala 44:26]
      predicate <= 1'h0; // @[AecExecPort.scala 44:26]
    end else if (pending) begin // @[AecExecPort.scala 51:18]
      predicate <= stagedPredicate; // @[AecExecPort.scala 54:15]
    end
    if (reset) begin // @[AecExecPort.scala 45:22]
      error <= 1'h0; // @[AecExecPort.scala 45:22]
    end else if (pending) begin // @[AecExecPort.scala 51:18]
      error <= stagedError; // @[AecExecPort.scala 55:11]
    end
    if (reset) begin // @[AecExecPort.scala 46:24]
      pending <= 1'h0; // @[AecExecPort.scala 46:24]
    end else begin
      pending <= io_write; // @[AecExecPort.scala 46:24]
    end
    stagedResult <= io_writeResult; // @[AecExecPort.scala 47:29]
    stagedPredicate <= io_writePredicate; // @[AecExecPort.scala 49:32]
    stagedError <= io_writeError; // @[AecExecPort.scala 50:28]
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
  predicate = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  error = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  pending = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  stagedResult = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  stagedPredicate = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stagedError = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecEightLaneIntUnit(
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
`endif // RANDOMIZE_REG_INIT
  wire  lanes_0_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_0_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_0_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_0_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_0_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_0_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_0_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_0_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_1_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_1_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_1_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_1_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_1_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_1_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_1_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_2_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_2_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_2_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_2_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_2_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_2_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_2_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_3_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_3_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_3_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_3_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_3_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_3_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_3_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_4_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_4_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_4_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_4_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_4_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_4_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_4_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_5_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_5_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_5_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_5_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_5_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_5_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_5_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_6_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_6_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_6_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_6_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_6_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_6_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_6_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_7_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_7_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_7_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_7_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_7_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_7_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_7_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_8_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_8_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_8_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_8_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_8_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_8_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_8_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_9_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_9_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_9_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_9_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_9_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_9_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_9_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_10_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_10_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_10_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_10_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_10_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_10_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_10_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_11_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_11_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_11_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_11_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_11_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_11_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_11_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_12_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_12_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_12_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_12_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_12_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_12_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_12_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_13_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_13_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_13_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_13_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_13_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_13_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_13_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_14_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_14_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_14_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_14_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_14_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_14_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_14_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_clock; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_reset; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_req_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_req_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [15:0] lanes_15_io_req_bits_op; // @[AecEightLaneIntUnit.scala 23:45]
  wire [3:0] lanes_15_io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_15_io_req_bits_a; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_15_io_req_bits_b; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_15_io_req_bits_c; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_req_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_resp_ready; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_resp_valid; // @[AecEightLaneIntUnit.scala 23:45]
  wire [31:0] lanes_15_io_resp_bits_result; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 23:45]
  wire  lanes_15_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 23:45]
  wire  requestStages_0_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_0_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_0_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_0_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_0_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_0_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_0_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_0_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_0_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_1_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_1_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_1_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_1_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_1_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_1_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_1_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_1_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_2_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_2_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_2_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_2_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_2_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_2_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_2_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_2_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_3_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_3_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_3_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_3_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_3_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_3_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_3_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_3_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_4_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_4_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_4_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_4_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_4_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_4_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_4_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_4_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_5_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_5_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_5_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_5_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_5_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_5_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_5_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_5_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_6_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_6_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_6_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_6_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_6_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_6_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_6_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_6_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_7_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_7_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_7_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_7_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_7_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_7_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_7_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_7_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_8_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_8_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_8_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_8_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_8_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_8_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_8_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_8_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_9_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_9_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_9_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_9_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_9_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_9_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_9_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_9_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_10_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_10_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_10_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_10_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_10_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_10_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_10_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_10_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_11_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_11_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_11_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_11_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_11_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_11_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_11_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_11_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_12_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_12_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_12_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_12_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_12_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_12_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_12_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_12_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_13_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_13_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_13_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_13_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_13_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_13_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_13_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_13_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_14_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_14_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_14_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_14_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_14_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_14_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_14_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_14_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_clock; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_reset; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_inValid; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_inReady; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_group; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_15_io_data_0_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_15_io_data_0_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_0_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_0_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_0_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_data_0_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_15_io_data_1_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_15_io_data_1_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_1_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_1_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_data_1_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_data_1_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_out_ready; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_out_valid; // @[AecEightLaneIntUnit.scala 24:53]
  wire [15:0] requestStages_15_io_out_bits_op; // @[AecEightLaneIntUnit.scala 24:53]
  wire [3:0] requestStages_15_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_out_bits_a; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_out_bits_b; // @[AecEightLaneIntUnit.scala 24:53]
  wire [31:0] requestStages_15_io_out_bits_c; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestStages_15_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 24:53]
  wire  requestBuffer_clock; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_reset; // @[AecEightLaneIntUnit.scala 26:64]
  wire [15:0] requestBuffer_io_in_op; // @[AecEightLaneIntUnit.scala 26:64]
  wire [3:0] requestBuffer_io_in_dtype; // @[AecEightLaneIntUnit.scala 26:64]
  wire [31:0] requestBuffer_io_in_activeMask; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_a_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_b_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_in_c_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [7:0] requestBuffer_io_in_dest; // @[AecEightLaneIntUnit.scala 26:64]
  wire [31:0] requestBuffer_io_in_predicateValues; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_arm_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire  requestBuffer_io_capture; // @[AecEightLaneIntUnit.scala 26:64]
  wire [15:0] requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 26:64]
  wire [3:0] requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 26:64]
  wire [31:0] requestBuffer_io_out_activeMask; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_a_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_b_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_0; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_1; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_2; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_3; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_4; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_5; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_6; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_7; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_8; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_9; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_10; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_11; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_12; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_13; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_14; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_15; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_16; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_17; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_18; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_19; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_20; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_21; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_22; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_23; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_24; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_25; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_26; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_27; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_28; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_29; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_30; // @[AecEightLaneIntUnit.scala 26:64]
  wire [63:0] requestBuffer_io_out_c_31; // @[AecEightLaneIntUnit.scala 26:64]
  wire [7:0] requestBuffer_io_out_dest; // @[AecEightLaneIntUnit.scala 26:64]
  wire [31:0] requestBuffer_io_out_predicateValues; // @[AecEightLaneIntUnit.scala 26:64]
  wire  resultBanks_0_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_0_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_0_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_0_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_1_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_1_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_1_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_2_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_2_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_2_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_3_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_3_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_3_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_4_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_4_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_4_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_5_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_5_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_5_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_6_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_6_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_6_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_7_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_7_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_7_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_8_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_8_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_8_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_9_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_9_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_9_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_10_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_10_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_10_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_11_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_11_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_11_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_12_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_12_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_12_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_13_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_13_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_13_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_14_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_14_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_14_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_15_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_15_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_15_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_16_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_16_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_16_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_17_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_17_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_17_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_18_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_18_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_18_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_19_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_19_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_19_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_20_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_20_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_20_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_21_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_21_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_21_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_22_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_22_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_22_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_23_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_23_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_23_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_24_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_24_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_24_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_25_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_25_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_25_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_26_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_26_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_26_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_27_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_27_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_27_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_28_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_28_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_28_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_29_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_29_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_29_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_30_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_30_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_30_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_clock; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_reset; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_io_write; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_31_io_writeResult; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_io_writePredicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_io_writeError; // @[AecEightLaneIntUnit.scala 46:40]
  wire [63:0] resultBanks_31_io_result; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_io_predicate; // @[AecEightLaneIntUnit.scala 46:40]
  wire  resultBanks_31_io_error; // @[AecEightLaneIntUnit.scala 46:40]
  reg  group; // @[AecEightLaneIntUnit.scala 34:22]
  reg [9:0] state; // @[AecEightLaneIntUnit.scala 35:22]
  wire  stateIdle = state[0]; // @[AecEightLaneIntUnit.scala 36:24]
  wire  stateArm = state[1]; // @[AecEightLaneIntUnit.scala 37:23]
  wire  stateIssue = state[3]; // @[AecEightLaneIntUnit.scala 39:25]
  wire  stateIssueFanout = state[4]; // @[AecEightLaneIntUnit.scala 40:31]
  wire  stateWait = state[5]; // @[AecEightLaneIntUnit.scala 41:24]
  wire  stateWaitFanout = state[6]; // @[AecEightLaneIntUnit.scala 42:30]
  wire  stateRetire = state[7]; // @[AecEightLaneIntUnit.scala 43:26]
  wire  stateCommit = state[8]; // @[AecEightLaneIntUnit.scala 44:26]
  reg  retireWrite_0; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_1; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_2; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_3; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_4; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_5; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_6; // @[AecEightLaneIntUnit.scala 48:28]
  reg  retireWrite_7; // @[AecEightLaneIntUnit.scala 48:28]
  reg  issueWrite_0; // @[AecEightLaneIntUnit.scala 50:27]
  reg  issueWrite_1; // @[AecEightLaneIntUnit.scala 50:27]
  reg  issueWrite_2; // @[AecEightLaneIntUnit.scala 50:27]
  reg  issueWrite_3; // @[AecEightLaneIntUnit.scala 50:27]
  reg  responseReady_0; // @[AecEightLaneIntUnit.scala 52:30]
  reg  responseReady_1; // @[AecEightLaneIntUnit.scala 52:30]
  reg  responseReady_2; // @[AecEightLaneIntUnit.scala 52:30]
  reg  responseReady_3; // @[AecEightLaneIntUnit.scala 52:30]
  wire  armCapture = stateIdle & io_req_valid; // @[AecEightLaneIntUnit.scala 54:60]
  reg  armClusters_0; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_1; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_2; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_3; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_4; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_5; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_6; // @[AecEightLaneIntUnit.scala 56:30]
  reg  armClusters_7; // @[AecEightLaneIntUnit.scala 56:30]
  wire  _requestBuffer_io_capture_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _io_resp_bits_predicateMask_WIRE_1 = resultBanks_1_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_0 = resultBanks_0_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_3 = resultBanks_3_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_2 = resultBanks_2_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_5 = resultBanks_5_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_4 = resultBanks_4_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_7 = resultBanks_7_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_6 = resultBanks_6_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire [7:0] io_resp_bits_predicateMask_lo_lo = {_io_resp_bits_predicateMask_WIRE_7,_io_resp_bits_predicateMask_WIRE_6,
    _io_resp_bits_predicateMask_WIRE_5,_io_resp_bits_predicateMask_WIRE_4,_io_resp_bits_predicateMask_WIRE_3,
    _io_resp_bits_predicateMask_WIRE_2,_io_resp_bits_predicateMask_WIRE_1,_io_resp_bits_predicateMask_WIRE_0}; // @[AecEightLaneIntUnit.scala 65:74]
  wire  _io_resp_bits_predicateMask_WIRE_9 = resultBanks_9_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_8 = resultBanks_8_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_11 = resultBanks_11_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_10 = resultBanks_10_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_13 = resultBanks_13_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_12 = resultBanks_12_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_15 = resultBanks_15_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_14 = resultBanks_14_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire [15:0] io_resp_bits_predicateMask_lo = {_io_resp_bits_predicateMask_WIRE_15,_io_resp_bits_predicateMask_WIRE_14,
    _io_resp_bits_predicateMask_WIRE_13,_io_resp_bits_predicateMask_WIRE_12,_io_resp_bits_predicateMask_WIRE_11,
    _io_resp_bits_predicateMask_WIRE_10,_io_resp_bits_predicateMask_WIRE_9,_io_resp_bits_predicateMask_WIRE_8,
    io_resp_bits_predicateMask_lo_lo}; // @[AecEightLaneIntUnit.scala 65:74]
  wire  _io_resp_bits_predicateMask_WIRE_17 = resultBanks_17_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_16 = resultBanks_16_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_19 = resultBanks_19_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_18 = resultBanks_18_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_21 = resultBanks_21_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_20 = resultBanks_20_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_23 = resultBanks_23_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_22 = resultBanks_22_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire [7:0] io_resp_bits_predicateMask_hi_lo = {_io_resp_bits_predicateMask_WIRE_23,_io_resp_bits_predicateMask_WIRE_22
    ,_io_resp_bits_predicateMask_WIRE_21,_io_resp_bits_predicateMask_WIRE_20,_io_resp_bits_predicateMask_WIRE_19,
    _io_resp_bits_predicateMask_WIRE_18,_io_resp_bits_predicateMask_WIRE_17,_io_resp_bits_predicateMask_WIRE_16}; // @[AecEightLaneIntUnit.scala 65:74]
  wire  _io_resp_bits_predicateMask_WIRE_25 = resultBanks_25_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_24 = resultBanks_24_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_27 = resultBanks_27_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_26 = resultBanks_26_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_29 = resultBanks_29_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_28 = resultBanks_28_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_31 = resultBanks_31_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire  _io_resp_bits_predicateMask_WIRE_30 = resultBanks_30_io_predicate; // @[AecEightLaneIntUnit.scala 65:{40,40}]
  wire [15:0] io_resp_bits_predicateMask_hi = {_io_resp_bits_predicateMask_WIRE_31,_io_resp_bits_predicateMask_WIRE_30,
    _io_resp_bits_predicateMask_WIRE_29,_io_resp_bits_predicateMask_WIRE_28,_io_resp_bits_predicateMask_WIRE_27,
    _io_resp_bits_predicateMask_WIRE_26,_io_resp_bits_predicateMask_WIRE_25,_io_resp_bits_predicateMask_WIRE_24,
    io_resp_bits_predicateMask_hi_lo}; // @[AecEightLaneIntUnit.scala 65:74]
  wire  _io_resp_bits_errorMask_WIRE_1 = resultBanks_1_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_0 = resultBanks_0_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_3 = resultBanks_3_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_2 = resultBanks_2_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_5 = resultBanks_5_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_4 = resultBanks_4_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_7 = resultBanks_7_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_6 = resultBanks_6_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire [7:0] io_resp_bits_errorMask_lo_lo = {_io_resp_bits_errorMask_WIRE_7,_io_resp_bits_errorMask_WIRE_6,
    _io_resp_bits_errorMask_WIRE_5,_io_resp_bits_errorMask_WIRE_4,_io_resp_bits_errorMask_WIRE_3,
    _io_resp_bits_errorMask_WIRE_2,_io_resp_bits_errorMask_WIRE_1,_io_resp_bits_errorMask_WIRE_0}; // @[AecEightLaneIntUnit.scala 66:66]
  wire  _io_resp_bits_errorMask_WIRE_9 = resultBanks_9_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_8 = resultBanks_8_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_11 = resultBanks_11_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_10 = resultBanks_10_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_13 = resultBanks_13_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_12 = resultBanks_12_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_15 = resultBanks_15_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_14 = resultBanks_14_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire [15:0] io_resp_bits_errorMask_lo = {_io_resp_bits_errorMask_WIRE_15,_io_resp_bits_errorMask_WIRE_14,
    _io_resp_bits_errorMask_WIRE_13,_io_resp_bits_errorMask_WIRE_12,_io_resp_bits_errorMask_WIRE_11,
    _io_resp_bits_errorMask_WIRE_10,_io_resp_bits_errorMask_WIRE_9,_io_resp_bits_errorMask_WIRE_8,
    io_resp_bits_errorMask_lo_lo}; // @[AecEightLaneIntUnit.scala 66:66]
  wire  _io_resp_bits_errorMask_WIRE_17 = resultBanks_17_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_16 = resultBanks_16_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_19 = resultBanks_19_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_18 = resultBanks_18_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_21 = resultBanks_21_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_20 = resultBanks_20_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_23 = resultBanks_23_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_22 = resultBanks_22_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire [7:0] io_resp_bits_errorMask_hi_lo = {_io_resp_bits_errorMask_WIRE_23,_io_resp_bits_errorMask_WIRE_22,
    _io_resp_bits_errorMask_WIRE_21,_io_resp_bits_errorMask_WIRE_20,_io_resp_bits_errorMask_WIRE_19,
    _io_resp_bits_errorMask_WIRE_18,_io_resp_bits_errorMask_WIRE_17,_io_resp_bits_errorMask_WIRE_16}; // @[AecEightLaneIntUnit.scala 66:66]
  wire  _io_resp_bits_errorMask_WIRE_25 = resultBanks_25_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_24 = resultBanks_24_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_27 = resultBanks_27_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_26 = resultBanks_26_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_29 = resultBanks_29_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_28 = resultBanks_28_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_31 = resultBanks_31_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire  _io_resp_bits_errorMask_WIRE_30 = resultBanks_30_io_error; // @[AecEightLaneIntUnit.scala 66:{36,36}]
  wire [15:0] io_resp_bits_errorMask_hi = {_io_resp_bits_errorMask_WIRE_31,_io_resp_bits_errorMask_WIRE_30,
    _io_resp_bits_errorMask_WIRE_29,_io_resp_bits_errorMask_WIRE_28,_io_resp_bits_errorMask_WIRE_27,
    _io_resp_bits_errorMask_WIRE_26,_io_resp_bits_errorMask_WIRE_25,_io_resp_bits_errorMask_WIRE_24,
    io_resp_bits_errorMask_hi_lo}; // @[AecEightLaneIntUnit.scala 66:66]
  wire  allReady = requestStages_0_io_inReady & requestStages_1_io_inReady & requestStages_2_io_inReady &
    requestStages_3_io_inReady & requestStages_4_io_inReady & requestStages_5_io_inReady & requestStages_6_io_inReady &
    requestStages_7_io_inReady & requestStages_8_io_inReady & requestStages_9_io_inReady & requestStages_10_io_inReady
     & requestStages_11_io_inReady & requestStages_12_io_inReady & requestStages_13_io_inReady &
    requestStages_14_io_inReady & requestStages_15_io_inReady; // @[AecEightLaneIntUnit.scala 71:59]
  wire  allValid = lanes_0_io_resp_valid & lanes_1_io_resp_valid & lanes_2_io_resp_valid & lanes_3_io_resp_valid &
    lanes_4_io_resp_valid & lanes_5_io_resp_valid & lanes_6_io_resp_valid & lanes_7_io_resp_valid &
    lanes_8_io_resp_valid & lanes_9_io_resp_valid & lanes_10_io_resp_valid & lanes_11_io_resp_valid &
    lanes_12_io_resp_valid & lanes_13_io_resp_valid & lanes_14_io_resp_valid & lanes_15_io_resp_valid; // @[AecEightLaneIntUnit.scala 72:54]
  wire [63:0] held_a_0 = requestBuffer_io_out_a_0; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_0 = requestBuffer_io_out_b_0; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_0 = requestBuffer_io_out_c_0; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [31:0] held_predicateValues = requestBuffer_io_out_predicateValues; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_16 = requestBuffer_io_out_a_16; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_16 = requestBuffer_io_out_b_16; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_16 = requestBuffer_io_out_c_16; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_1 = requestBuffer_io_out_a_1; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_1 = requestBuffer_io_out_b_1; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_1 = requestBuffer_io_out_c_1; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_17 = requestBuffer_io_out_a_17; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_17 = requestBuffer_io_out_b_17; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_17 = requestBuffer_io_out_c_17; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_2 = requestBuffer_io_out_a_2; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_2 = requestBuffer_io_out_b_2; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_2 = requestBuffer_io_out_c_2; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_18 = requestBuffer_io_out_a_18; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_18 = requestBuffer_io_out_b_18; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_18 = requestBuffer_io_out_c_18; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_3 = requestBuffer_io_out_a_3; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_3 = requestBuffer_io_out_b_3; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_3 = requestBuffer_io_out_c_3; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_19 = requestBuffer_io_out_a_19; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_19 = requestBuffer_io_out_b_19; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_19 = requestBuffer_io_out_c_19; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_4 = requestBuffer_io_out_a_4; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_4 = requestBuffer_io_out_b_4; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_4 = requestBuffer_io_out_c_4; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_20 = requestBuffer_io_out_a_20; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_20 = requestBuffer_io_out_b_20; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_20 = requestBuffer_io_out_c_20; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_5 = requestBuffer_io_out_a_5; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_5 = requestBuffer_io_out_b_5; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_5 = requestBuffer_io_out_c_5; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_21 = requestBuffer_io_out_a_21; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_21 = requestBuffer_io_out_b_21; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_21 = requestBuffer_io_out_c_21; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_6 = requestBuffer_io_out_a_6; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_6 = requestBuffer_io_out_b_6; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_6 = requestBuffer_io_out_c_6; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_22 = requestBuffer_io_out_a_22; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_22 = requestBuffer_io_out_b_22; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_22 = requestBuffer_io_out_c_22; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_7 = requestBuffer_io_out_a_7; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_7 = requestBuffer_io_out_b_7; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_7 = requestBuffer_io_out_c_7; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_23 = requestBuffer_io_out_a_23; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_23 = requestBuffer_io_out_b_23; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_23 = requestBuffer_io_out_c_23; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_8 = requestBuffer_io_out_a_8; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_8 = requestBuffer_io_out_b_8; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_8 = requestBuffer_io_out_c_8; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_24 = requestBuffer_io_out_a_24; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_24 = requestBuffer_io_out_b_24; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_24 = requestBuffer_io_out_c_24; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_9 = requestBuffer_io_out_a_9; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_9 = requestBuffer_io_out_b_9; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_9 = requestBuffer_io_out_c_9; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_25 = requestBuffer_io_out_a_25; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_25 = requestBuffer_io_out_b_25; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_25 = requestBuffer_io_out_c_25; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_10 = requestBuffer_io_out_a_10; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_10 = requestBuffer_io_out_b_10; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_10 = requestBuffer_io_out_c_10; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_26 = requestBuffer_io_out_a_26; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_26 = requestBuffer_io_out_b_26; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_26 = requestBuffer_io_out_c_26; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_11 = requestBuffer_io_out_a_11; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_11 = requestBuffer_io_out_b_11; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_11 = requestBuffer_io_out_c_11; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_27 = requestBuffer_io_out_a_27; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_27 = requestBuffer_io_out_b_27; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_27 = requestBuffer_io_out_c_27; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_12 = requestBuffer_io_out_a_12; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_12 = requestBuffer_io_out_b_12; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_12 = requestBuffer_io_out_c_12; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_28 = requestBuffer_io_out_a_28; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_28 = requestBuffer_io_out_b_28; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_28 = requestBuffer_io_out_c_28; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_13 = requestBuffer_io_out_a_13; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_13 = requestBuffer_io_out_b_13; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_13 = requestBuffer_io_out_c_13; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_29 = requestBuffer_io_out_a_29; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_29 = requestBuffer_io_out_b_29; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_29 = requestBuffer_io_out_c_29; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_14 = requestBuffer_io_out_a_14; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_14 = requestBuffer_io_out_b_14; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_14 = requestBuffer_io_out_c_14; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_30 = requestBuffer_io_out_a_30; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_30 = requestBuffer_io_out_b_30; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_30 = requestBuffer_io_out_c_30; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_15 = requestBuffer_io_out_a_15; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_15 = requestBuffer_io_out_b_15; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_15 = requestBuffer_io_out_c_15; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_a_31 = requestBuffer_io_out_a_31; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_b_31 = requestBuffer_io_out_b_31; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] held_c_31 = requestBuffer_io_out_c_31; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire  _retireWrite_0_T = stateWait & allValid; // @[AecEightLaneIntUnit.scala 91:17]
  wire  _retireWrite_0_T_2 = stateWait & allValid & ~group; // @[AecEightLaneIntUnit.scala 91:29]
  wire  _retireWrite_4_T_2 = stateWait & allValid & group; // @[AecEightLaneIntUnit.scala 91:29]
  wire  _issueWrite_0_T = stateIssue & allReady; // @[AecEightLaneIntUnit.scala 94:39]
  wire [31:0] held_activeMask = requestBuffer_io_out_activeMask; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  wire [63:0] _resultBanks_0_io_writeResult_T_1 = {32'h0,lanes_0_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_1_io_writeResult_T_1 = {32'h0,lanes_1_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_2_io_writeResult_T_1 = {32'h0,lanes_2_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_3_io_writeResult_T_1 = {32'h0,lanes_3_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_4_io_writeResult_T_1 = {32'h0,lanes_4_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_5_io_writeResult_T_1 = {32'h0,lanes_5_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_6_io_writeResult_T_1 = {32'h0,lanes_6_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_7_io_writeResult_T_1 = {32'h0,lanes_7_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_8_io_writeResult_T_1 = {32'h0,lanes_8_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_9_io_writeResult_T_1 = {32'h0,lanes_9_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_10_io_writeResult_T_1 = {32'h0,lanes_10_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_11_io_writeResult_T_1 = {32'h0,lanes_11_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_12_io_writeResult_T_1 = {32'h0,lanes_12_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_13_io_writeResult_T_1 = {32'h0,lanes_13_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_14_io_writeResult_T_1 = {32'h0,lanes_14_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [63:0] _resultBanks_15_io_writeResult_T_1 = {32'h0,lanes_15_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [9:0] _GEN_0 = armCapture ? 10'h2 : state; // @[AecEightLaneIntUnit.scala 108:{23,31} 35:22]
  wire [9:0] _GEN_1 = stateArm ? 10'h4 : _GEN_0; // @[AecEightLaneIntUnit.scala 109:{21,29}]
  wire  _GEN_2 = _requestBuffer_io_capture_T ? 1'h0 : group; // @[AecEightLaneIntUnit.scala 111:22 112:11 34:22]
  wire [9:0] _GEN_3 = _requestBuffer_io_capture_T ? 10'h8 : _GEN_1; // @[AecEightLaneIntUnit.scala 111:22 113:11]
  wire [9:0] _GEN_4 = _issueWrite_0_T ? 10'h10 : _GEN_3; // @[AecEightLaneIntUnit.scala 115:33 116:11]
  wire [9:0] _GEN_5 = stateIssueFanout ? 10'h20 : _GEN_4; // @[AecEightLaneIntUnit.scala 118:27 119:11]
  wire [9:0] _GEN_6 = _retireWrite_0_T ? 10'h40 : _GEN_5; // @[AecEightLaneIntUnit.scala 121:32 122:11]
  wire [9:0] _GEN_7 = stateWaitFanout ? 10'h80 : _GEN_6; // @[AecEightLaneIntUnit.scala 124:26 125:11]
  wire  _T_4 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  AecIntAlu lanes_0 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_0_clock),
    .reset(lanes_0_reset),
    .io_req_ready(lanes_0_io_req_ready),
    .io_req_valid(lanes_0_io_req_valid),
    .io_req_bits_op(lanes_0_io_req_bits_op),
    .io_req_bits_dtype(lanes_0_io_req_bits_dtype),
    .io_req_bits_a(lanes_0_io_req_bits_a),
    .io_req_bits_b(lanes_0_io_req_bits_b),
    .io_req_bits_c(lanes_0_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_0_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_0_io_resp_ready),
    .io_resp_valid(lanes_0_io_resp_valid),
    .io_resp_bits_result(lanes_0_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_0_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_0_io_resp_bits_error)
  );
  AecIntAlu lanes_1 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_1_clock),
    .reset(lanes_1_reset),
    .io_req_ready(lanes_1_io_req_ready),
    .io_req_valid(lanes_1_io_req_valid),
    .io_req_bits_op(lanes_1_io_req_bits_op),
    .io_req_bits_dtype(lanes_1_io_req_bits_dtype),
    .io_req_bits_a(lanes_1_io_req_bits_a),
    .io_req_bits_b(lanes_1_io_req_bits_b),
    .io_req_bits_c(lanes_1_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_1_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_1_io_resp_ready),
    .io_resp_valid(lanes_1_io_resp_valid),
    .io_resp_bits_result(lanes_1_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_1_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_1_io_resp_bits_error)
  );
  AecIntAlu lanes_2 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_2_clock),
    .reset(lanes_2_reset),
    .io_req_ready(lanes_2_io_req_ready),
    .io_req_valid(lanes_2_io_req_valid),
    .io_req_bits_op(lanes_2_io_req_bits_op),
    .io_req_bits_dtype(lanes_2_io_req_bits_dtype),
    .io_req_bits_a(lanes_2_io_req_bits_a),
    .io_req_bits_b(lanes_2_io_req_bits_b),
    .io_req_bits_c(lanes_2_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_2_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_2_io_resp_ready),
    .io_resp_valid(lanes_2_io_resp_valid),
    .io_resp_bits_result(lanes_2_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_2_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_2_io_resp_bits_error)
  );
  AecIntAlu lanes_3 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_3_clock),
    .reset(lanes_3_reset),
    .io_req_ready(lanes_3_io_req_ready),
    .io_req_valid(lanes_3_io_req_valid),
    .io_req_bits_op(lanes_3_io_req_bits_op),
    .io_req_bits_dtype(lanes_3_io_req_bits_dtype),
    .io_req_bits_a(lanes_3_io_req_bits_a),
    .io_req_bits_b(lanes_3_io_req_bits_b),
    .io_req_bits_c(lanes_3_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_3_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_3_io_resp_ready),
    .io_resp_valid(lanes_3_io_resp_valid),
    .io_resp_bits_result(lanes_3_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_3_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_3_io_resp_bits_error)
  );
  AecIntAlu lanes_4 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_4_clock),
    .reset(lanes_4_reset),
    .io_req_ready(lanes_4_io_req_ready),
    .io_req_valid(lanes_4_io_req_valid),
    .io_req_bits_op(lanes_4_io_req_bits_op),
    .io_req_bits_dtype(lanes_4_io_req_bits_dtype),
    .io_req_bits_a(lanes_4_io_req_bits_a),
    .io_req_bits_b(lanes_4_io_req_bits_b),
    .io_req_bits_c(lanes_4_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_4_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_4_io_resp_ready),
    .io_resp_valid(lanes_4_io_resp_valid),
    .io_resp_bits_result(lanes_4_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_4_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_4_io_resp_bits_error)
  );
  AecIntAlu lanes_5 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_5_clock),
    .reset(lanes_5_reset),
    .io_req_ready(lanes_5_io_req_ready),
    .io_req_valid(lanes_5_io_req_valid),
    .io_req_bits_op(lanes_5_io_req_bits_op),
    .io_req_bits_dtype(lanes_5_io_req_bits_dtype),
    .io_req_bits_a(lanes_5_io_req_bits_a),
    .io_req_bits_b(lanes_5_io_req_bits_b),
    .io_req_bits_c(lanes_5_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_5_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_5_io_resp_ready),
    .io_resp_valid(lanes_5_io_resp_valid),
    .io_resp_bits_result(lanes_5_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_5_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_5_io_resp_bits_error)
  );
  AecIntAlu lanes_6 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_6_clock),
    .reset(lanes_6_reset),
    .io_req_ready(lanes_6_io_req_ready),
    .io_req_valid(lanes_6_io_req_valid),
    .io_req_bits_op(lanes_6_io_req_bits_op),
    .io_req_bits_dtype(lanes_6_io_req_bits_dtype),
    .io_req_bits_a(lanes_6_io_req_bits_a),
    .io_req_bits_b(lanes_6_io_req_bits_b),
    .io_req_bits_c(lanes_6_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_6_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_6_io_resp_ready),
    .io_resp_valid(lanes_6_io_resp_valid),
    .io_resp_bits_result(lanes_6_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_6_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_6_io_resp_bits_error)
  );
  AecIntAlu lanes_7 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_7_clock),
    .reset(lanes_7_reset),
    .io_req_ready(lanes_7_io_req_ready),
    .io_req_valid(lanes_7_io_req_valid),
    .io_req_bits_op(lanes_7_io_req_bits_op),
    .io_req_bits_dtype(lanes_7_io_req_bits_dtype),
    .io_req_bits_a(lanes_7_io_req_bits_a),
    .io_req_bits_b(lanes_7_io_req_bits_b),
    .io_req_bits_c(lanes_7_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_7_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_7_io_resp_ready),
    .io_resp_valid(lanes_7_io_resp_valid),
    .io_resp_bits_result(lanes_7_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_7_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_7_io_resp_bits_error)
  );
  AecIntAlu lanes_8 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_8_clock),
    .reset(lanes_8_reset),
    .io_req_ready(lanes_8_io_req_ready),
    .io_req_valid(lanes_8_io_req_valid),
    .io_req_bits_op(lanes_8_io_req_bits_op),
    .io_req_bits_dtype(lanes_8_io_req_bits_dtype),
    .io_req_bits_a(lanes_8_io_req_bits_a),
    .io_req_bits_b(lanes_8_io_req_bits_b),
    .io_req_bits_c(lanes_8_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_8_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_8_io_resp_ready),
    .io_resp_valid(lanes_8_io_resp_valid),
    .io_resp_bits_result(lanes_8_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_8_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_8_io_resp_bits_error)
  );
  AecIntAlu lanes_9 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_9_clock),
    .reset(lanes_9_reset),
    .io_req_ready(lanes_9_io_req_ready),
    .io_req_valid(lanes_9_io_req_valid),
    .io_req_bits_op(lanes_9_io_req_bits_op),
    .io_req_bits_dtype(lanes_9_io_req_bits_dtype),
    .io_req_bits_a(lanes_9_io_req_bits_a),
    .io_req_bits_b(lanes_9_io_req_bits_b),
    .io_req_bits_c(lanes_9_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_9_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_9_io_resp_ready),
    .io_resp_valid(lanes_9_io_resp_valid),
    .io_resp_bits_result(lanes_9_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_9_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_9_io_resp_bits_error)
  );
  AecIntAlu lanes_10 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_10_clock),
    .reset(lanes_10_reset),
    .io_req_ready(lanes_10_io_req_ready),
    .io_req_valid(lanes_10_io_req_valid),
    .io_req_bits_op(lanes_10_io_req_bits_op),
    .io_req_bits_dtype(lanes_10_io_req_bits_dtype),
    .io_req_bits_a(lanes_10_io_req_bits_a),
    .io_req_bits_b(lanes_10_io_req_bits_b),
    .io_req_bits_c(lanes_10_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_10_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_10_io_resp_ready),
    .io_resp_valid(lanes_10_io_resp_valid),
    .io_resp_bits_result(lanes_10_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_10_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_10_io_resp_bits_error)
  );
  AecIntAlu lanes_11 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_11_clock),
    .reset(lanes_11_reset),
    .io_req_ready(lanes_11_io_req_ready),
    .io_req_valid(lanes_11_io_req_valid),
    .io_req_bits_op(lanes_11_io_req_bits_op),
    .io_req_bits_dtype(lanes_11_io_req_bits_dtype),
    .io_req_bits_a(lanes_11_io_req_bits_a),
    .io_req_bits_b(lanes_11_io_req_bits_b),
    .io_req_bits_c(lanes_11_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_11_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_11_io_resp_ready),
    .io_resp_valid(lanes_11_io_resp_valid),
    .io_resp_bits_result(lanes_11_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_11_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_11_io_resp_bits_error)
  );
  AecIntAlu lanes_12 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_12_clock),
    .reset(lanes_12_reset),
    .io_req_ready(lanes_12_io_req_ready),
    .io_req_valid(lanes_12_io_req_valid),
    .io_req_bits_op(lanes_12_io_req_bits_op),
    .io_req_bits_dtype(lanes_12_io_req_bits_dtype),
    .io_req_bits_a(lanes_12_io_req_bits_a),
    .io_req_bits_b(lanes_12_io_req_bits_b),
    .io_req_bits_c(lanes_12_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_12_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_12_io_resp_ready),
    .io_resp_valid(lanes_12_io_resp_valid),
    .io_resp_bits_result(lanes_12_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_12_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_12_io_resp_bits_error)
  );
  AecIntAlu lanes_13 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_13_clock),
    .reset(lanes_13_reset),
    .io_req_ready(lanes_13_io_req_ready),
    .io_req_valid(lanes_13_io_req_valid),
    .io_req_bits_op(lanes_13_io_req_bits_op),
    .io_req_bits_dtype(lanes_13_io_req_bits_dtype),
    .io_req_bits_a(lanes_13_io_req_bits_a),
    .io_req_bits_b(lanes_13_io_req_bits_b),
    .io_req_bits_c(lanes_13_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_13_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_13_io_resp_ready),
    .io_resp_valid(lanes_13_io_resp_valid),
    .io_resp_bits_result(lanes_13_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_13_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_13_io_resp_bits_error)
  );
  AecIntAlu lanes_14 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_14_clock),
    .reset(lanes_14_reset),
    .io_req_ready(lanes_14_io_req_ready),
    .io_req_valid(lanes_14_io_req_valid),
    .io_req_bits_op(lanes_14_io_req_bits_op),
    .io_req_bits_dtype(lanes_14_io_req_bits_dtype),
    .io_req_bits_a(lanes_14_io_req_bits_a),
    .io_req_bits_b(lanes_14_io_req_bits_b),
    .io_req_bits_c(lanes_14_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_14_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_14_io_resp_ready),
    .io_resp_valid(lanes_14_io_resp_valid),
    .io_resp_bits_result(lanes_14_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_14_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_14_io_resp_bits_error)
  );
  AecIntAlu lanes_15 ( // @[AecEightLaneIntUnit.scala 23:45]
    .clock(lanes_15_clock),
    .reset(lanes_15_reset),
    .io_req_ready(lanes_15_io_req_ready),
    .io_req_valid(lanes_15_io_req_valid),
    .io_req_bits_op(lanes_15_io_req_bits_op),
    .io_req_bits_dtype(lanes_15_io_req_bits_dtype),
    .io_req_bits_a(lanes_15_io_req_bits_a),
    .io_req_bits_b(lanes_15_io_req_bits_b),
    .io_req_bits_c(lanes_15_io_req_bits_c),
    .io_req_bits_selectPredicate(lanes_15_io_req_bits_selectPredicate),
    .io_resp_ready(lanes_15_io_resp_ready),
    .io_resp_valid(lanes_15_io_resp_valid),
    .io_resp_bits_result(lanes_15_io_resp_bits_result),
    .io_resp_bits_predicateResult(lanes_15_io_resp_bits_predicateResult),
    .io_resp_bits_error(lanes_15_io_resp_bits_error)
  );
  AecIntWarpRequestStage requestStages_0 ( // @[AecEightLaneIntUnit.scala 24:53]
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
    .io_data_0_selectPredicate(requestStages_0_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_0_io_data_1_op),
    .io_data_1_dtype(requestStages_0_io_data_1_dtype),
    .io_data_1_a(requestStages_0_io_data_1_a),
    .io_data_1_b(requestStages_0_io_data_1_b),
    .io_data_1_c(requestStages_0_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_0_io_data_1_selectPredicate),
    .io_out_ready(requestStages_0_io_out_ready),
    .io_out_valid(requestStages_0_io_out_valid),
    .io_out_bits_op(requestStages_0_io_out_bits_op),
    .io_out_bits_dtype(requestStages_0_io_out_bits_dtype),
    .io_out_bits_a(requestStages_0_io_out_bits_a),
    .io_out_bits_b(requestStages_0_io_out_bits_b),
    .io_out_bits_c(requestStages_0_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_0_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_1 ( // @[AecEightLaneIntUnit.scala 24:53]
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
    .io_data_0_selectPredicate(requestStages_1_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_1_io_data_1_op),
    .io_data_1_dtype(requestStages_1_io_data_1_dtype),
    .io_data_1_a(requestStages_1_io_data_1_a),
    .io_data_1_b(requestStages_1_io_data_1_b),
    .io_data_1_c(requestStages_1_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_1_io_data_1_selectPredicate),
    .io_out_ready(requestStages_1_io_out_ready),
    .io_out_valid(requestStages_1_io_out_valid),
    .io_out_bits_op(requestStages_1_io_out_bits_op),
    .io_out_bits_dtype(requestStages_1_io_out_bits_dtype),
    .io_out_bits_a(requestStages_1_io_out_bits_a),
    .io_out_bits_b(requestStages_1_io_out_bits_b),
    .io_out_bits_c(requestStages_1_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_1_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_2 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_2_clock),
    .reset(requestStages_2_reset),
    .io_inValid(requestStages_2_io_inValid),
    .io_inReady(requestStages_2_io_inReady),
    .io_group(requestStages_2_io_group),
    .io_data_0_op(requestStages_2_io_data_0_op),
    .io_data_0_dtype(requestStages_2_io_data_0_dtype),
    .io_data_0_a(requestStages_2_io_data_0_a),
    .io_data_0_b(requestStages_2_io_data_0_b),
    .io_data_0_c(requestStages_2_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_2_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_2_io_data_1_op),
    .io_data_1_dtype(requestStages_2_io_data_1_dtype),
    .io_data_1_a(requestStages_2_io_data_1_a),
    .io_data_1_b(requestStages_2_io_data_1_b),
    .io_data_1_c(requestStages_2_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_2_io_data_1_selectPredicate),
    .io_out_ready(requestStages_2_io_out_ready),
    .io_out_valid(requestStages_2_io_out_valid),
    .io_out_bits_op(requestStages_2_io_out_bits_op),
    .io_out_bits_dtype(requestStages_2_io_out_bits_dtype),
    .io_out_bits_a(requestStages_2_io_out_bits_a),
    .io_out_bits_b(requestStages_2_io_out_bits_b),
    .io_out_bits_c(requestStages_2_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_2_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_3 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_3_clock),
    .reset(requestStages_3_reset),
    .io_inValid(requestStages_3_io_inValid),
    .io_inReady(requestStages_3_io_inReady),
    .io_group(requestStages_3_io_group),
    .io_data_0_op(requestStages_3_io_data_0_op),
    .io_data_0_dtype(requestStages_3_io_data_0_dtype),
    .io_data_0_a(requestStages_3_io_data_0_a),
    .io_data_0_b(requestStages_3_io_data_0_b),
    .io_data_0_c(requestStages_3_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_3_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_3_io_data_1_op),
    .io_data_1_dtype(requestStages_3_io_data_1_dtype),
    .io_data_1_a(requestStages_3_io_data_1_a),
    .io_data_1_b(requestStages_3_io_data_1_b),
    .io_data_1_c(requestStages_3_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_3_io_data_1_selectPredicate),
    .io_out_ready(requestStages_3_io_out_ready),
    .io_out_valid(requestStages_3_io_out_valid),
    .io_out_bits_op(requestStages_3_io_out_bits_op),
    .io_out_bits_dtype(requestStages_3_io_out_bits_dtype),
    .io_out_bits_a(requestStages_3_io_out_bits_a),
    .io_out_bits_b(requestStages_3_io_out_bits_b),
    .io_out_bits_c(requestStages_3_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_3_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_4 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_4_clock),
    .reset(requestStages_4_reset),
    .io_inValid(requestStages_4_io_inValid),
    .io_inReady(requestStages_4_io_inReady),
    .io_group(requestStages_4_io_group),
    .io_data_0_op(requestStages_4_io_data_0_op),
    .io_data_0_dtype(requestStages_4_io_data_0_dtype),
    .io_data_0_a(requestStages_4_io_data_0_a),
    .io_data_0_b(requestStages_4_io_data_0_b),
    .io_data_0_c(requestStages_4_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_4_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_4_io_data_1_op),
    .io_data_1_dtype(requestStages_4_io_data_1_dtype),
    .io_data_1_a(requestStages_4_io_data_1_a),
    .io_data_1_b(requestStages_4_io_data_1_b),
    .io_data_1_c(requestStages_4_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_4_io_data_1_selectPredicate),
    .io_out_ready(requestStages_4_io_out_ready),
    .io_out_valid(requestStages_4_io_out_valid),
    .io_out_bits_op(requestStages_4_io_out_bits_op),
    .io_out_bits_dtype(requestStages_4_io_out_bits_dtype),
    .io_out_bits_a(requestStages_4_io_out_bits_a),
    .io_out_bits_b(requestStages_4_io_out_bits_b),
    .io_out_bits_c(requestStages_4_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_4_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_5 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_5_clock),
    .reset(requestStages_5_reset),
    .io_inValid(requestStages_5_io_inValid),
    .io_inReady(requestStages_5_io_inReady),
    .io_group(requestStages_5_io_group),
    .io_data_0_op(requestStages_5_io_data_0_op),
    .io_data_0_dtype(requestStages_5_io_data_0_dtype),
    .io_data_0_a(requestStages_5_io_data_0_a),
    .io_data_0_b(requestStages_5_io_data_0_b),
    .io_data_0_c(requestStages_5_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_5_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_5_io_data_1_op),
    .io_data_1_dtype(requestStages_5_io_data_1_dtype),
    .io_data_1_a(requestStages_5_io_data_1_a),
    .io_data_1_b(requestStages_5_io_data_1_b),
    .io_data_1_c(requestStages_5_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_5_io_data_1_selectPredicate),
    .io_out_ready(requestStages_5_io_out_ready),
    .io_out_valid(requestStages_5_io_out_valid),
    .io_out_bits_op(requestStages_5_io_out_bits_op),
    .io_out_bits_dtype(requestStages_5_io_out_bits_dtype),
    .io_out_bits_a(requestStages_5_io_out_bits_a),
    .io_out_bits_b(requestStages_5_io_out_bits_b),
    .io_out_bits_c(requestStages_5_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_5_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_6 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_6_clock),
    .reset(requestStages_6_reset),
    .io_inValid(requestStages_6_io_inValid),
    .io_inReady(requestStages_6_io_inReady),
    .io_group(requestStages_6_io_group),
    .io_data_0_op(requestStages_6_io_data_0_op),
    .io_data_0_dtype(requestStages_6_io_data_0_dtype),
    .io_data_0_a(requestStages_6_io_data_0_a),
    .io_data_0_b(requestStages_6_io_data_0_b),
    .io_data_0_c(requestStages_6_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_6_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_6_io_data_1_op),
    .io_data_1_dtype(requestStages_6_io_data_1_dtype),
    .io_data_1_a(requestStages_6_io_data_1_a),
    .io_data_1_b(requestStages_6_io_data_1_b),
    .io_data_1_c(requestStages_6_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_6_io_data_1_selectPredicate),
    .io_out_ready(requestStages_6_io_out_ready),
    .io_out_valid(requestStages_6_io_out_valid),
    .io_out_bits_op(requestStages_6_io_out_bits_op),
    .io_out_bits_dtype(requestStages_6_io_out_bits_dtype),
    .io_out_bits_a(requestStages_6_io_out_bits_a),
    .io_out_bits_b(requestStages_6_io_out_bits_b),
    .io_out_bits_c(requestStages_6_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_6_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_7 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_7_clock),
    .reset(requestStages_7_reset),
    .io_inValid(requestStages_7_io_inValid),
    .io_inReady(requestStages_7_io_inReady),
    .io_group(requestStages_7_io_group),
    .io_data_0_op(requestStages_7_io_data_0_op),
    .io_data_0_dtype(requestStages_7_io_data_0_dtype),
    .io_data_0_a(requestStages_7_io_data_0_a),
    .io_data_0_b(requestStages_7_io_data_0_b),
    .io_data_0_c(requestStages_7_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_7_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_7_io_data_1_op),
    .io_data_1_dtype(requestStages_7_io_data_1_dtype),
    .io_data_1_a(requestStages_7_io_data_1_a),
    .io_data_1_b(requestStages_7_io_data_1_b),
    .io_data_1_c(requestStages_7_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_7_io_data_1_selectPredicate),
    .io_out_ready(requestStages_7_io_out_ready),
    .io_out_valid(requestStages_7_io_out_valid),
    .io_out_bits_op(requestStages_7_io_out_bits_op),
    .io_out_bits_dtype(requestStages_7_io_out_bits_dtype),
    .io_out_bits_a(requestStages_7_io_out_bits_a),
    .io_out_bits_b(requestStages_7_io_out_bits_b),
    .io_out_bits_c(requestStages_7_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_7_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_8 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_8_clock),
    .reset(requestStages_8_reset),
    .io_inValid(requestStages_8_io_inValid),
    .io_inReady(requestStages_8_io_inReady),
    .io_group(requestStages_8_io_group),
    .io_data_0_op(requestStages_8_io_data_0_op),
    .io_data_0_dtype(requestStages_8_io_data_0_dtype),
    .io_data_0_a(requestStages_8_io_data_0_a),
    .io_data_0_b(requestStages_8_io_data_0_b),
    .io_data_0_c(requestStages_8_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_8_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_8_io_data_1_op),
    .io_data_1_dtype(requestStages_8_io_data_1_dtype),
    .io_data_1_a(requestStages_8_io_data_1_a),
    .io_data_1_b(requestStages_8_io_data_1_b),
    .io_data_1_c(requestStages_8_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_8_io_data_1_selectPredicate),
    .io_out_ready(requestStages_8_io_out_ready),
    .io_out_valid(requestStages_8_io_out_valid),
    .io_out_bits_op(requestStages_8_io_out_bits_op),
    .io_out_bits_dtype(requestStages_8_io_out_bits_dtype),
    .io_out_bits_a(requestStages_8_io_out_bits_a),
    .io_out_bits_b(requestStages_8_io_out_bits_b),
    .io_out_bits_c(requestStages_8_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_8_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_9 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_9_clock),
    .reset(requestStages_9_reset),
    .io_inValid(requestStages_9_io_inValid),
    .io_inReady(requestStages_9_io_inReady),
    .io_group(requestStages_9_io_group),
    .io_data_0_op(requestStages_9_io_data_0_op),
    .io_data_0_dtype(requestStages_9_io_data_0_dtype),
    .io_data_0_a(requestStages_9_io_data_0_a),
    .io_data_0_b(requestStages_9_io_data_0_b),
    .io_data_0_c(requestStages_9_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_9_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_9_io_data_1_op),
    .io_data_1_dtype(requestStages_9_io_data_1_dtype),
    .io_data_1_a(requestStages_9_io_data_1_a),
    .io_data_1_b(requestStages_9_io_data_1_b),
    .io_data_1_c(requestStages_9_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_9_io_data_1_selectPredicate),
    .io_out_ready(requestStages_9_io_out_ready),
    .io_out_valid(requestStages_9_io_out_valid),
    .io_out_bits_op(requestStages_9_io_out_bits_op),
    .io_out_bits_dtype(requestStages_9_io_out_bits_dtype),
    .io_out_bits_a(requestStages_9_io_out_bits_a),
    .io_out_bits_b(requestStages_9_io_out_bits_b),
    .io_out_bits_c(requestStages_9_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_9_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_10 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_10_clock),
    .reset(requestStages_10_reset),
    .io_inValid(requestStages_10_io_inValid),
    .io_inReady(requestStages_10_io_inReady),
    .io_group(requestStages_10_io_group),
    .io_data_0_op(requestStages_10_io_data_0_op),
    .io_data_0_dtype(requestStages_10_io_data_0_dtype),
    .io_data_0_a(requestStages_10_io_data_0_a),
    .io_data_0_b(requestStages_10_io_data_0_b),
    .io_data_0_c(requestStages_10_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_10_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_10_io_data_1_op),
    .io_data_1_dtype(requestStages_10_io_data_1_dtype),
    .io_data_1_a(requestStages_10_io_data_1_a),
    .io_data_1_b(requestStages_10_io_data_1_b),
    .io_data_1_c(requestStages_10_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_10_io_data_1_selectPredicate),
    .io_out_ready(requestStages_10_io_out_ready),
    .io_out_valid(requestStages_10_io_out_valid),
    .io_out_bits_op(requestStages_10_io_out_bits_op),
    .io_out_bits_dtype(requestStages_10_io_out_bits_dtype),
    .io_out_bits_a(requestStages_10_io_out_bits_a),
    .io_out_bits_b(requestStages_10_io_out_bits_b),
    .io_out_bits_c(requestStages_10_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_10_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_11 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_11_clock),
    .reset(requestStages_11_reset),
    .io_inValid(requestStages_11_io_inValid),
    .io_inReady(requestStages_11_io_inReady),
    .io_group(requestStages_11_io_group),
    .io_data_0_op(requestStages_11_io_data_0_op),
    .io_data_0_dtype(requestStages_11_io_data_0_dtype),
    .io_data_0_a(requestStages_11_io_data_0_a),
    .io_data_0_b(requestStages_11_io_data_0_b),
    .io_data_0_c(requestStages_11_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_11_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_11_io_data_1_op),
    .io_data_1_dtype(requestStages_11_io_data_1_dtype),
    .io_data_1_a(requestStages_11_io_data_1_a),
    .io_data_1_b(requestStages_11_io_data_1_b),
    .io_data_1_c(requestStages_11_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_11_io_data_1_selectPredicate),
    .io_out_ready(requestStages_11_io_out_ready),
    .io_out_valid(requestStages_11_io_out_valid),
    .io_out_bits_op(requestStages_11_io_out_bits_op),
    .io_out_bits_dtype(requestStages_11_io_out_bits_dtype),
    .io_out_bits_a(requestStages_11_io_out_bits_a),
    .io_out_bits_b(requestStages_11_io_out_bits_b),
    .io_out_bits_c(requestStages_11_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_11_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_12 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_12_clock),
    .reset(requestStages_12_reset),
    .io_inValid(requestStages_12_io_inValid),
    .io_inReady(requestStages_12_io_inReady),
    .io_group(requestStages_12_io_group),
    .io_data_0_op(requestStages_12_io_data_0_op),
    .io_data_0_dtype(requestStages_12_io_data_0_dtype),
    .io_data_0_a(requestStages_12_io_data_0_a),
    .io_data_0_b(requestStages_12_io_data_0_b),
    .io_data_0_c(requestStages_12_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_12_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_12_io_data_1_op),
    .io_data_1_dtype(requestStages_12_io_data_1_dtype),
    .io_data_1_a(requestStages_12_io_data_1_a),
    .io_data_1_b(requestStages_12_io_data_1_b),
    .io_data_1_c(requestStages_12_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_12_io_data_1_selectPredicate),
    .io_out_ready(requestStages_12_io_out_ready),
    .io_out_valid(requestStages_12_io_out_valid),
    .io_out_bits_op(requestStages_12_io_out_bits_op),
    .io_out_bits_dtype(requestStages_12_io_out_bits_dtype),
    .io_out_bits_a(requestStages_12_io_out_bits_a),
    .io_out_bits_b(requestStages_12_io_out_bits_b),
    .io_out_bits_c(requestStages_12_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_12_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_13 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_13_clock),
    .reset(requestStages_13_reset),
    .io_inValid(requestStages_13_io_inValid),
    .io_inReady(requestStages_13_io_inReady),
    .io_group(requestStages_13_io_group),
    .io_data_0_op(requestStages_13_io_data_0_op),
    .io_data_0_dtype(requestStages_13_io_data_0_dtype),
    .io_data_0_a(requestStages_13_io_data_0_a),
    .io_data_0_b(requestStages_13_io_data_0_b),
    .io_data_0_c(requestStages_13_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_13_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_13_io_data_1_op),
    .io_data_1_dtype(requestStages_13_io_data_1_dtype),
    .io_data_1_a(requestStages_13_io_data_1_a),
    .io_data_1_b(requestStages_13_io_data_1_b),
    .io_data_1_c(requestStages_13_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_13_io_data_1_selectPredicate),
    .io_out_ready(requestStages_13_io_out_ready),
    .io_out_valid(requestStages_13_io_out_valid),
    .io_out_bits_op(requestStages_13_io_out_bits_op),
    .io_out_bits_dtype(requestStages_13_io_out_bits_dtype),
    .io_out_bits_a(requestStages_13_io_out_bits_a),
    .io_out_bits_b(requestStages_13_io_out_bits_b),
    .io_out_bits_c(requestStages_13_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_13_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_14 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_14_clock),
    .reset(requestStages_14_reset),
    .io_inValid(requestStages_14_io_inValid),
    .io_inReady(requestStages_14_io_inReady),
    .io_group(requestStages_14_io_group),
    .io_data_0_op(requestStages_14_io_data_0_op),
    .io_data_0_dtype(requestStages_14_io_data_0_dtype),
    .io_data_0_a(requestStages_14_io_data_0_a),
    .io_data_0_b(requestStages_14_io_data_0_b),
    .io_data_0_c(requestStages_14_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_14_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_14_io_data_1_op),
    .io_data_1_dtype(requestStages_14_io_data_1_dtype),
    .io_data_1_a(requestStages_14_io_data_1_a),
    .io_data_1_b(requestStages_14_io_data_1_b),
    .io_data_1_c(requestStages_14_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_14_io_data_1_selectPredicate),
    .io_out_ready(requestStages_14_io_out_ready),
    .io_out_valid(requestStages_14_io_out_valid),
    .io_out_bits_op(requestStages_14_io_out_bits_op),
    .io_out_bits_dtype(requestStages_14_io_out_bits_dtype),
    .io_out_bits_a(requestStages_14_io_out_bits_a),
    .io_out_bits_b(requestStages_14_io_out_bits_b),
    .io_out_bits_c(requestStages_14_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_14_io_out_bits_selectPredicate)
  );
  AecIntWarpRequestStage requestStages_15 ( // @[AecEightLaneIntUnit.scala 24:53]
    .clock(requestStages_15_clock),
    .reset(requestStages_15_reset),
    .io_inValid(requestStages_15_io_inValid),
    .io_inReady(requestStages_15_io_inReady),
    .io_group(requestStages_15_io_group),
    .io_data_0_op(requestStages_15_io_data_0_op),
    .io_data_0_dtype(requestStages_15_io_data_0_dtype),
    .io_data_0_a(requestStages_15_io_data_0_a),
    .io_data_0_b(requestStages_15_io_data_0_b),
    .io_data_0_c(requestStages_15_io_data_0_c),
    .io_data_0_selectPredicate(requestStages_15_io_data_0_selectPredicate),
    .io_data_1_op(requestStages_15_io_data_1_op),
    .io_data_1_dtype(requestStages_15_io_data_1_dtype),
    .io_data_1_a(requestStages_15_io_data_1_a),
    .io_data_1_b(requestStages_15_io_data_1_b),
    .io_data_1_c(requestStages_15_io_data_1_c),
    .io_data_1_selectPredicate(requestStages_15_io_data_1_selectPredicate),
    .io_out_ready(requestStages_15_io_out_ready),
    .io_out_valid(requestStages_15_io_out_valid),
    .io_out_bits_op(requestStages_15_io_out_bits_op),
    .io_out_bits_dtype(requestStages_15_io_out_bits_dtype),
    .io_out_bits_a(requestStages_15_io_out_bits_a),
    .io_out_bits_b(requestStages_15_io_out_bits_b),
    .io_out_bits_c(requestStages_15_io_out_bits_c),
    .io_out_bits_selectPredicate(requestStages_15_io_out_bits_selectPredicate)
  );
  AecWarpRequestBuffer requestBuffer ( // @[AecEightLaneIntUnit.scala 26:64]
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
    .io_in_predicateValues(requestBuffer_io_in_predicateValues),
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
    .io_out_dest(requestBuffer_io_out_dest),
    .io_out_predicateValues(requestBuffer_io_out_predicateValues)
  );
  AecResultLaneBank resultBanks_0 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_0_clock),
    .reset(resultBanks_0_reset),
    .io_write(resultBanks_0_io_write),
    .io_writeResult(resultBanks_0_io_writeResult),
    .io_writePredicate(resultBanks_0_io_writePredicate),
    .io_writeError(resultBanks_0_io_writeError),
    .io_result(resultBanks_0_io_result),
    .io_predicate(resultBanks_0_io_predicate),
    .io_error(resultBanks_0_io_error)
  );
  AecResultLaneBank resultBanks_1 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_1_clock),
    .reset(resultBanks_1_reset),
    .io_write(resultBanks_1_io_write),
    .io_writeResult(resultBanks_1_io_writeResult),
    .io_writePredicate(resultBanks_1_io_writePredicate),
    .io_writeError(resultBanks_1_io_writeError),
    .io_result(resultBanks_1_io_result),
    .io_predicate(resultBanks_1_io_predicate),
    .io_error(resultBanks_1_io_error)
  );
  AecResultLaneBank resultBanks_2 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_2_clock),
    .reset(resultBanks_2_reset),
    .io_write(resultBanks_2_io_write),
    .io_writeResult(resultBanks_2_io_writeResult),
    .io_writePredicate(resultBanks_2_io_writePredicate),
    .io_writeError(resultBanks_2_io_writeError),
    .io_result(resultBanks_2_io_result),
    .io_predicate(resultBanks_2_io_predicate),
    .io_error(resultBanks_2_io_error)
  );
  AecResultLaneBank resultBanks_3 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_3_clock),
    .reset(resultBanks_3_reset),
    .io_write(resultBanks_3_io_write),
    .io_writeResult(resultBanks_3_io_writeResult),
    .io_writePredicate(resultBanks_3_io_writePredicate),
    .io_writeError(resultBanks_3_io_writeError),
    .io_result(resultBanks_3_io_result),
    .io_predicate(resultBanks_3_io_predicate),
    .io_error(resultBanks_3_io_error)
  );
  AecResultLaneBank resultBanks_4 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_4_clock),
    .reset(resultBanks_4_reset),
    .io_write(resultBanks_4_io_write),
    .io_writeResult(resultBanks_4_io_writeResult),
    .io_writePredicate(resultBanks_4_io_writePredicate),
    .io_writeError(resultBanks_4_io_writeError),
    .io_result(resultBanks_4_io_result),
    .io_predicate(resultBanks_4_io_predicate),
    .io_error(resultBanks_4_io_error)
  );
  AecResultLaneBank resultBanks_5 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_5_clock),
    .reset(resultBanks_5_reset),
    .io_write(resultBanks_5_io_write),
    .io_writeResult(resultBanks_5_io_writeResult),
    .io_writePredicate(resultBanks_5_io_writePredicate),
    .io_writeError(resultBanks_5_io_writeError),
    .io_result(resultBanks_5_io_result),
    .io_predicate(resultBanks_5_io_predicate),
    .io_error(resultBanks_5_io_error)
  );
  AecResultLaneBank resultBanks_6 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_6_clock),
    .reset(resultBanks_6_reset),
    .io_write(resultBanks_6_io_write),
    .io_writeResult(resultBanks_6_io_writeResult),
    .io_writePredicate(resultBanks_6_io_writePredicate),
    .io_writeError(resultBanks_6_io_writeError),
    .io_result(resultBanks_6_io_result),
    .io_predicate(resultBanks_6_io_predicate),
    .io_error(resultBanks_6_io_error)
  );
  AecResultLaneBank resultBanks_7 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_7_clock),
    .reset(resultBanks_7_reset),
    .io_write(resultBanks_7_io_write),
    .io_writeResult(resultBanks_7_io_writeResult),
    .io_writePredicate(resultBanks_7_io_writePredicate),
    .io_writeError(resultBanks_7_io_writeError),
    .io_result(resultBanks_7_io_result),
    .io_predicate(resultBanks_7_io_predicate),
    .io_error(resultBanks_7_io_error)
  );
  AecResultLaneBank resultBanks_8 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_8_clock),
    .reset(resultBanks_8_reset),
    .io_write(resultBanks_8_io_write),
    .io_writeResult(resultBanks_8_io_writeResult),
    .io_writePredicate(resultBanks_8_io_writePredicate),
    .io_writeError(resultBanks_8_io_writeError),
    .io_result(resultBanks_8_io_result),
    .io_predicate(resultBanks_8_io_predicate),
    .io_error(resultBanks_8_io_error)
  );
  AecResultLaneBank resultBanks_9 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_9_clock),
    .reset(resultBanks_9_reset),
    .io_write(resultBanks_9_io_write),
    .io_writeResult(resultBanks_9_io_writeResult),
    .io_writePredicate(resultBanks_9_io_writePredicate),
    .io_writeError(resultBanks_9_io_writeError),
    .io_result(resultBanks_9_io_result),
    .io_predicate(resultBanks_9_io_predicate),
    .io_error(resultBanks_9_io_error)
  );
  AecResultLaneBank resultBanks_10 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_10_clock),
    .reset(resultBanks_10_reset),
    .io_write(resultBanks_10_io_write),
    .io_writeResult(resultBanks_10_io_writeResult),
    .io_writePredicate(resultBanks_10_io_writePredicate),
    .io_writeError(resultBanks_10_io_writeError),
    .io_result(resultBanks_10_io_result),
    .io_predicate(resultBanks_10_io_predicate),
    .io_error(resultBanks_10_io_error)
  );
  AecResultLaneBank resultBanks_11 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_11_clock),
    .reset(resultBanks_11_reset),
    .io_write(resultBanks_11_io_write),
    .io_writeResult(resultBanks_11_io_writeResult),
    .io_writePredicate(resultBanks_11_io_writePredicate),
    .io_writeError(resultBanks_11_io_writeError),
    .io_result(resultBanks_11_io_result),
    .io_predicate(resultBanks_11_io_predicate),
    .io_error(resultBanks_11_io_error)
  );
  AecResultLaneBank resultBanks_12 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_12_clock),
    .reset(resultBanks_12_reset),
    .io_write(resultBanks_12_io_write),
    .io_writeResult(resultBanks_12_io_writeResult),
    .io_writePredicate(resultBanks_12_io_writePredicate),
    .io_writeError(resultBanks_12_io_writeError),
    .io_result(resultBanks_12_io_result),
    .io_predicate(resultBanks_12_io_predicate),
    .io_error(resultBanks_12_io_error)
  );
  AecResultLaneBank resultBanks_13 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_13_clock),
    .reset(resultBanks_13_reset),
    .io_write(resultBanks_13_io_write),
    .io_writeResult(resultBanks_13_io_writeResult),
    .io_writePredicate(resultBanks_13_io_writePredicate),
    .io_writeError(resultBanks_13_io_writeError),
    .io_result(resultBanks_13_io_result),
    .io_predicate(resultBanks_13_io_predicate),
    .io_error(resultBanks_13_io_error)
  );
  AecResultLaneBank resultBanks_14 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_14_clock),
    .reset(resultBanks_14_reset),
    .io_write(resultBanks_14_io_write),
    .io_writeResult(resultBanks_14_io_writeResult),
    .io_writePredicate(resultBanks_14_io_writePredicate),
    .io_writeError(resultBanks_14_io_writeError),
    .io_result(resultBanks_14_io_result),
    .io_predicate(resultBanks_14_io_predicate),
    .io_error(resultBanks_14_io_error)
  );
  AecResultLaneBank resultBanks_15 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_15_clock),
    .reset(resultBanks_15_reset),
    .io_write(resultBanks_15_io_write),
    .io_writeResult(resultBanks_15_io_writeResult),
    .io_writePredicate(resultBanks_15_io_writePredicate),
    .io_writeError(resultBanks_15_io_writeError),
    .io_result(resultBanks_15_io_result),
    .io_predicate(resultBanks_15_io_predicate),
    .io_error(resultBanks_15_io_error)
  );
  AecResultLaneBank resultBanks_16 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_16_clock),
    .reset(resultBanks_16_reset),
    .io_write(resultBanks_16_io_write),
    .io_writeResult(resultBanks_16_io_writeResult),
    .io_writePredicate(resultBanks_16_io_writePredicate),
    .io_writeError(resultBanks_16_io_writeError),
    .io_result(resultBanks_16_io_result),
    .io_predicate(resultBanks_16_io_predicate),
    .io_error(resultBanks_16_io_error)
  );
  AecResultLaneBank resultBanks_17 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_17_clock),
    .reset(resultBanks_17_reset),
    .io_write(resultBanks_17_io_write),
    .io_writeResult(resultBanks_17_io_writeResult),
    .io_writePredicate(resultBanks_17_io_writePredicate),
    .io_writeError(resultBanks_17_io_writeError),
    .io_result(resultBanks_17_io_result),
    .io_predicate(resultBanks_17_io_predicate),
    .io_error(resultBanks_17_io_error)
  );
  AecResultLaneBank resultBanks_18 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_18_clock),
    .reset(resultBanks_18_reset),
    .io_write(resultBanks_18_io_write),
    .io_writeResult(resultBanks_18_io_writeResult),
    .io_writePredicate(resultBanks_18_io_writePredicate),
    .io_writeError(resultBanks_18_io_writeError),
    .io_result(resultBanks_18_io_result),
    .io_predicate(resultBanks_18_io_predicate),
    .io_error(resultBanks_18_io_error)
  );
  AecResultLaneBank resultBanks_19 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_19_clock),
    .reset(resultBanks_19_reset),
    .io_write(resultBanks_19_io_write),
    .io_writeResult(resultBanks_19_io_writeResult),
    .io_writePredicate(resultBanks_19_io_writePredicate),
    .io_writeError(resultBanks_19_io_writeError),
    .io_result(resultBanks_19_io_result),
    .io_predicate(resultBanks_19_io_predicate),
    .io_error(resultBanks_19_io_error)
  );
  AecResultLaneBank resultBanks_20 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_20_clock),
    .reset(resultBanks_20_reset),
    .io_write(resultBanks_20_io_write),
    .io_writeResult(resultBanks_20_io_writeResult),
    .io_writePredicate(resultBanks_20_io_writePredicate),
    .io_writeError(resultBanks_20_io_writeError),
    .io_result(resultBanks_20_io_result),
    .io_predicate(resultBanks_20_io_predicate),
    .io_error(resultBanks_20_io_error)
  );
  AecResultLaneBank resultBanks_21 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_21_clock),
    .reset(resultBanks_21_reset),
    .io_write(resultBanks_21_io_write),
    .io_writeResult(resultBanks_21_io_writeResult),
    .io_writePredicate(resultBanks_21_io_writePredicate),
    .io_writeError(resultBanks_21_io_writeError),
    .io_result(resultBanks_21_io_result),
    .io_predicate(resultBanks_21_io_predicate),
    .io_error(resultBanks_21_io_error)
  );
  AecResultLaneBank resultBanks_22 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_22_clock),
    .reset(resultBanks_22_reset),
    .io_write(resultBanks_22_io_write),
    .io_writeResult(resultBanks_22_io_writeResult),
    .io_writePredicate(resultBanks_22_io_writePredicate),
    .io_writeError(resultBanks_22_io_writeError),
    .io_result(resultBanks_22_io_result),
    .io_predicate(resultBanks_22_io_predicate),
    .io_error(resultBanks_22_io_error)
  );
  AecResultLaneBank resultBanks_23 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_23_clock),
    .reset(resultBanks_23_reset),
    .io_write(resultBanks_23_io_write),
    .io_writeResult(resultBanks_23_io_writeResult),
    .io_writePredicate(resultBanks_23_io_writePredicate),
    .io_writeError(resultBanks_23_io_writeError),
    .io_result(resultBanks_23_io_result),
    .io_predicate(resultBanks_23_io_predicate),
    .io_error(resultBanks_23_io_error)
  );
  AecResultLaneBank resultBanks_24 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_24_clock),
    .reset(resultBanks_24_reset),
    .io_write(resultBanks_24_io_write),
    .io_writeResult(resultBanks_24_io_writeResult),
    .io_writePredicate(resultBanks_24_io_writePredicate),
    .io_writeError(resultBanks_24_io_writeError),
    .io_result(resultBanks_24_io_result),
    .io_predicate(resultBanks_24_io_predicate),
    .io_error(resultBanks_24_io_error)
  );
  AecResultLaneBank resultBanks_25 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_25_clock),
    .reset(resultBanks_25_reset),
    .io_write(resultBanks_25_io_write),
    .io_writeResult(resultBanks_25_io_writeResult),
    .io_writePredicate(resultBanks_25_io_writePredicate),
    .io_writeError(resultBanks_25_io_writeError),
    .io_result(resultBanks_25_io_result),
    .io_predicate(resultBanks_25_io_predicate),
    .io_error(resultBanks_25_io_error)
  );
  AecResultLaneBank resultBanks_26 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_26_clock),
    .reset(resultBanks_26_reset),
    .io_write(resultBanks_26_io_write),
    .io_writeResult(resultBanks_26_io_writeResult),
    .io_writePredicate(resultBanks_26_io_writePredicate),
    .io_writeError(resultBanks_26_io_writeError),
    .io_result(resultBanks_26_io_result),
    .io_predicate(resultBanks_26_io_predicate),
    .io_error(resultBanks_26_io_error)
  );
  AecResultLaneBank resultBanks_27 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_27_clock),
    .reset(resultBanks_27_reset),
    .io_write(resultBanks_27_io_write),
    .io_writeResult(resultBanks_27_io_writeResult),
    .io_writePredicate(resultBanks_27_io_writePredicate),
    .io_writeError(resultBanks_27_io_writeError),
    .io_result(resultBanks_27_io_result),
    .io_predicate(resultBanks_27_io_predicate),
    .io_error(resultBanks_27_io_error)
  );
  AecResultLaneBank resultBanks_28 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_28_clock),
    .reset(resultBanks_28_reset),
    .io_write(resultBanks_28_io_write),
    .io_writeResult(resultBanks_28_io_writeResult),
    .io_writePredicate(resultBanks_28_io_writePredicate),
    .io_writeError(resultBanks_28_io_writeError),
    .io_result(resultBanks_28_io_result),
    .io_predicate(resultBanks_28_io_predicate),
    .io_error(resultBanks_28_io_error)
  );
  AecResultLaneBank resultBanks_29 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_29_clock),
    .reset(resultBanks_29_reset),
    .io_write(resultBanks_29_io_write),
    .io_writeResult(resultBanks_29_io_writeResult),
    .io_writePredicate(resultBanks_29_io_writePredicate),
    .io_writeError(resultBanks_29_io_writeError),
    .io_result(resultBanks_29_io_result),
    .io_predicate(resultBanks_29_io_predicate),
    .io_error(resultBanks_29_io_error)
  );
  AecResultLaneBank resultBanks_30 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_30_clock),
    .reset(resultBanks_30_reset),
    .io_write(resultBanks_30_io_write),
    .io_writeResult(resultBanks_30_io_writeResult),
    .io_writePredicate(resultBanks_30_io_writePredicate),
    .io_writeError(resultBanks_30_io_writeError),
    .io_result(resultBanks_30_io_result),
    .io_predicate(resultBanks_30_io_predicate),
    .io_error(resultBanks_30_io_error)
  );
  AecResultLaneBank resultBanks_31 ( // @[AecEightLaneIntUnit.scala 46:40]
    .clock(resultBanks_31_clock),
    .reset(resultBanks_31_reset),
    .io_write(resultBanks_31_io_write),
    .io_writeResult(resultBanks_31_io_writeResult),
    .io_writePredicate(resultBanks_31_io_writePredicate),
    .io_writeError(resultBanks_31_io_writeError),
    .io_result(resultBanks_31_io_result),
    .io_predicate(resultBanks_31_io_predicate),
    .io_error(resultBanks_31_io_error)
  );
  assign io_req_ready = state[2]; // @[AecEightLaneIntUnit.scala 38:27]
  assign io_resp_valid = state[9]; // @[AecEightLaneIntUnit.scala 45:23]
  assign io_resp_bits_result_0 = resultBanks_0_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_1 = resultBanks_1_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_2 = resultBanks_2_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_3 = resultBanks_3_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_4 = resultBanks_4_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_5 = resultBanks_5_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_6 = resultBanks_6_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_7 = resultBanks_7_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_8 = resultBanks_8_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_9 = resultBanks_9_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_10 = resultBanks_10_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_11 = resultBanks_11_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_12 = resultBanks_12_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_13 = resultBanks_13_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_14 = resultBanks_14_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_15 = resultBanks_15_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_16 = resultBanks_16_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_17 = resultBanks_17_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_18 = resultBanks_18_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_19 = resultBanks_19_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_20 = resultBanks_20_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_21 = resultBanks_21_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_22 = resultBanks_22_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_23 = resultBanks_23_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_24 = resultBanks_24_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_25 = resultBanks_25_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_26 = resultBanks_26_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_27 = resultBanks_27_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_28 = resultBanks_28_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_29 = resultBanks_29_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_30 = resultBanks_30_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_result_31 = resultBanks_31_io_result; // @[AecEightLaneIntUnit.scala 64:{33,33}]
  assign io_resp_bits_predicateMask = {io_resp_bits_predicateMask_hi,io_resp_bits_predicateMask_lo}; // @[AecEightLaneIntUnit.scala 65:74]
  assign io_resp_bits_errorMask = {io_resp_bits_errorMask_hi,io_resp_bits_errorMask_lo}; // @[AecEightLaneIntUnit.scala 66:66]
  assign io_resp_bits_exceptionFlags_0 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_1 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_2 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_3 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_4 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_5 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_6 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_7 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_8 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_9 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_10 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_11 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_12 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_13 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_14 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_15 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_16 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_17 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_18 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_19 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_20 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_21 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_22 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_23 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_24 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_25 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_26 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_27 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_28 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_29 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_30 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_exceptionFlags_31 = 5'h0; // @[AecEightLaneIntUnit.scala 67:{41,41}]
  assign io_resp_bits_activeMask = requestBuffer_io_out_activeMask; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign io_resp_bits_dest = requestBuffer_io_out_dest; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign lanes_0_clock = clock;
  assign lanes_0_reset = reset;
  assign lanes_0_io_req_valid = requestStages_0_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_op = requestStages_0_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_dtype = requestStages_0_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_a = requestStages_0_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_b = requestStages_0_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_c = requestStages_0_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_req_bits_selectPredicate = requestStages_0_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_0_io_resp_ready = responseReady_0; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_1_clock = clock;
  assign lanes_1_reset = reset;
  assign lanes_1_io_req_valid = requestStages_1_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_op = requestStages_1_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_dtype = requestStages_1_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_a = requestStages_1_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_b = requestStages_1_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_c = requestStages_1_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_req_bits_selectPredicate = requestStages_1_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_1_io_resp_ready = responseReady_0; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_2_clock = clock;
  assign lanes_2_reset = reset;
  assign lanes_2_io_req_valid = requestStages_2_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_op = requestStages_2_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_dtype = requestStages_2_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_a = requestStages_2_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_b = requestStages_2_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_c = requestStages_2_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_req_bits_selectPredicate = requestStages_2_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_2_io_resp_ready = responseReady_0; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_3_clock = clock;
  assign lanes_3_reset = reset;
  assign lanes_3_io_req_valid = requestStages_3_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_op = requestStages_3_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_dtype = requestStages_3_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_a = requestStages_3_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_b = requestStages_3_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_c = requestStages_3_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_req_bits_selectPredicate = requestStages_3_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_3_io_resp_ready = responseReady_0; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_4_clock = clock;
  assign lanes_4_reset = reset;
  assign lanes_4_io_req_valid = requestStages_4_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_op = requestStages_4_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_dtype = requestStages_4_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_a = requestStages_4_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_b = requestStages_4_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_c = requestStages_4_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_req_bits_selectPredicate = requestStages_4_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_4_io_resp_ready = responseReady_1; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_5_clock = clock;
  assign lanes_5_reset = reset;
  assign lanes_5_io_req_valid = requestStages_5_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_op = requestStages_5_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_dtype = requestStages_5_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_a = requestStages_5_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_b = requestStages_5_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_c = requestStages_5_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_req_bits_selectPredicate = requestStages_5_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_5_io_resp_ready = responseReady_1; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_6_clock = clock;
  assign lanes_6_reset = reset;
  assign lanes_6_io_req_valid = requestStages_6_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_op = requestStages_6_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_dtype = requestStages_6_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_a = requestStages_6_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_b = requestStages_6_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_c = requestStages_6_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_req_bits_selectPredicate = requestStages_6_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_6_io_resp_ready = responseReady_1; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_7_clock = clock;
  assign lanes_7_reset = reset;
  assign lanes_7_io_req_valid = requestStages_7_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_op = requestStages_7_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_dtype = requestStages_7_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_a = requestStages_7_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_b = requestStages_7_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_c = requestStages_7_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_req_bits_selectPredicate = requestStages_7_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_7_io_resp_ready = responseReady_1; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_8_clock = clock;
  assign lanes_8_reset = reset;
  assign lanes_8_io_req_valid = requestStages_8_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_op = requestStages_8_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_dtype = requestStages_8_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_a = requestStages_8_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_b = requestStages_8_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_c = requestStages_8_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_req_bits_selectPredicate = requestStages_8_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_8_io_resp_ready = responseReady_2; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_9_clock = clock;
  assign lanes_9_reset = reset;
  assign lanes_9_io_req_valid = requestStages_9_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_op = requestStages_9_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_dtype = requestStages_9_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_a = requestStages_9_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_b = requestStages_9_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_c = requestStages_9_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_req_bits_selectPredicate = requestStages_9_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_9_io_resp_ready = responseReady_2; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_10_clock = clock;
  assign lanes_10_reset = reset;
  assign lanes_10_io_req_valid = requestStages_10_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_op = requestStages_10_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_dtype = requestStages_10_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_a = requestStages_10_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_b = requestStages_10_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_c = requestStages_10_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_req_bits_selectPredicate = requestStages_10_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_10_io_resp_ready = responseReady_2; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_11_clock = clock;
  assign lanes_11_reset = reset;
  assign lanes_11_io_req_valid = requestStages_11_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_op = requestStages_11_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_dtype = requestStages_11_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_a = requestStages_11_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_b = requestStages_11_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_c = requestStages_11_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_req_bits_selectPredicate = requestStages_11_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_11_io_resp_ready = responseReady_2; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_12_clock = clock;
  assign lanes_12_reset = reset;
  assign lanes_12_io_req_valid = requestStages_12_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_op = requestStages_12_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_dtype = requestStages_12_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_a = requestStages_12_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_b = requestStages_12_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_c = requestStages_12_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_req_bits_selectPredicate = requestStages_12_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_12_io_resp_ready = responseReady_3; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_13_clock = clock;
  assign lanes_13_reset = reset;
  assign lanes_13_io_req_valid = requestStages_13_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_op = requestStages_13_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_dtype = requestStages_13_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_a = requestStages_13_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_b = requestStages_13_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_c = requestStages_13_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_req_bits_selectPredicate = requestStages_13_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_13_io_resp_ready = responseReady_3; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_14_clock = clock;
  assign lanes_14_reset = reset;
  assign lanes_14_io_req_valid = requestStages_14_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_op = requestStages_14_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_dtype = requestStages_14_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_a = requestStages_14_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_b = requestStages_14_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_c = requestStages_14_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_req_bits_selectPredicate = requestStages_14_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_14_io_resp_ready = responseReady_3; // @[AecEightLaneIntUnit.scala 87:28]
  assign lanes_15_clock = clock;
  assign lanes_15_reset = reset;
  assign lanes_15_io_req_valid = requestStages_15_io_out_valid; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_op = requestStages_15_io_out_bits_op; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_dtype = requestStages_15_io_out_bits_dtype; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_a = requestStages_15_io_out_bits_a; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_b = requestStages_15_io_out_bits_b; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_c = requestStages_15_io_out_bits_c; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_req_bits_selectPredicate = requestStages_15_io_out_bits_selectPredicate; // @[AecEightLaneIntUnit.scala 86:21]
  assign lanes_15_io_resp_ready = responseReady_3; // @[AecEightLaneIntUnit.scala 87:28]
  assign requestStages_0_clock = clock;
  assign requestStages_0_reset = reset;
  assign requestStages_0_io_inValid = issueWrite_0; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_0_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_0_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_0_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_0_io_data_0_a = held_a_0[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_0_io_data_0_b = held_b_0[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_0_io_data_0_c = held_c_0[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_0_io_data_0_selectPredicate = held_predicateValues[0]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_0_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_0_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_0_io_data_1_a = held_a_16[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_0_io_data_1_b = held_b_16[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_0_io_data_1_c = held_c_16[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_0_io_data_1_selectPredicate = held_predicateValues[16]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_0_io_out_ready = lanes_0_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_1_clock = clock;
  assign requestStages_1_reset = reset;
  assign requestStages_1_io_inValid = issueWrite_0; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_1_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_1_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_1_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_1_io_data_0_a = held_a_1[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_1_io_data_0_b = held_b_1[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_1_io_data_0_c = held_c_1[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_1_io_data_0_selectPredicate = held_predicateValues[1]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_1_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_1_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_1_io_data_1_a = held_a_17[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_1_io_data_1_b = held_b_17[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_1_io_data_1_c = held_c_17[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_1_io_data_1_selectPredicate = held_predicateValues[17]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_1_io_out_ready = lanes_1_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_2_clock = clock;
  assign requestStages_2_reset = reset;
  assign requestStages_2_io_inValid = issueWrite_0; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_2_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_2_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_2_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_2_io_data_0_a = held_a_2[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_2_io_data_0_b = held_b_2[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_2_io_data_0_c = held_c_2[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_2_io_data_0_selectPredicate = held_predicateValues[2]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_2_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_2_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_2_io_data_1_a = held_a_18[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_2_io_data_1_b = held_b_18[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_2_io_data_1_c = held_c_18[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_2_io_data_1_selectPredicate = held_predicateValues[18]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_2_io_out_ready = lanes_2_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_3_clock = clock;
  assign requestStages_3_reset = reset;
  assign requestStages_3_io_inValid = issueWrite_0; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_3_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_3_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_3_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_3_io_data_0_a = held_a_3[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_3_io_data_0_b = held_b_3[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_3_io_data_0_c = held_c_3[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_3_io_data_0_selectPredicate = held_predicateValues[3]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_3_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_3_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_3_io_data_1_a = held_a_19[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_3_io_data_1_b = held_b_19[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_3_io_data_1_c = held_c_19[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_3_io_data_1_selectPredicate = held_predicateValues[19]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_3_io_out_ready = lanes_3_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_4_clock = clock;
  assign requestStages_4_reset = reset;
  assign requestStages_4_io_inValid = issueWrite_1; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_4_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_4_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_4_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_4_io_data_0_a = held_a_4[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_4_io_data_0_b = held_b_4[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_4_io_data_0_c = held_c_4[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_4_io_data_0_selectPredicate = held_predicateValues[4]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_4_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_4_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_4_io_data_1_a = held_a_20[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_4_io_data_1_b = held_b_20[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_4_io_data_1_c = held_c_20[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_4_io_data_1_selectPredicate = held_predicateValues[20]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_4_io_out_ready = lanes_4_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_5_clock = clock;
  assign requestStages_5_reset = reset;
  assign requestStages_5_io_inValid = issueWrite_1; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_5_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_5_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_5_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_5_io_data_0_a = held_a_5[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_5_io_data_0_b = held_b_5[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_5_io_data_0_c = held_c_5[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_5_io_data_0_selectPredicate = held_predicateValues[5]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_5_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_5_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_5_io_data_1_a = held_a_21[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_5_io_data_1_b = held_b_21[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_5_io_data_1_c = held_c_21[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_5_io_data_1_selectPredicate = held_predicateValues[21]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_5_io_out_ready = lanes_5_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_6_clock = clock;
  assign requestStages_6_reset = reset;
  assign requestStages_6_io_inValid = issueWrite_1; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_6_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_6_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_6_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_6_io_data_0_a = held_a_6[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_6_io_data_0_b = held_b_6[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_6_io_data_0_c = held_c_6[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_6_io_data_0_selectPredicate = held_predicateValues[6]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_6_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_6_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_6_io_data_1_a = held_a_22[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_6_io_data_1_b = held_b_22[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_6_io_data_1_c = held_c_22[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_6_io_data_1_selectPredicate = held_predicateValues[22]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_6_io_out_ready = lanes_6_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_7_clock = clock;
  assign requestStages_7_reset = reset;
  assign requestStages_7_io_inValid = issueWrite_1; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_7_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_7_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_7_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_7_io_data_0_a = held_a_7[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_7_io_data_0_b = held_b_7[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_7_io_data_0_c = held_c_7[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_7_io_data_0_selectPredicate = held_predicateValues[7]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_7_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_7_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_7_io_data_1_a = held_a_23[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_7_io_data_1_b = held_b_23[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_7_io_data_1_c = held_c_23[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_7_io_data_1_selectPredicate = held_predicateValues[23]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_7_io_out_ready = lanes_7_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_8_clock = clock;
  assign requestStages_8_reset = reset;
  assign requestStages_8_io_inValid = issueWrite_2; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_8_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_8_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_8_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_8_io_data_0_a = held_a_8[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_8_io_data_0_b = held_b_8[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_8_io_data_0_c = held_c_8[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_8_io_data_0_selectPredicate = held_predicateValues[8]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_8_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_8_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_8_io_data_1_a = held_a_24[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_8_io_data_1_b = held_b_24[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_8_io_data_1_c = held_c_24[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_8_io_data_1_selectPredicate = held_predicateValues[24]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_8_io_out_ready = lanes_8_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_9_clock = clock;
  assign requestStages_9_reset = reset;
  assign requestStages_9_io_inValid = issueWrite_2; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_9_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_9_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_9_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_9_io_data_0_a = held_a_9[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_9_io_data_0_b = held_b_9[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_9_io_data_0_c = held_c_9[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_9_io_data_0_selectPredicate = held_predicateValues[9]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_9_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_9_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_9_io_data_1_a = held_a_25[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_9_io_data_1_b = held_b_25[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_9_io_data_1_c = held_c_25[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_9_io_data_1_selectPredicate = held_predicateValues[25]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_9_io_out_ready = lanes_9_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_10_clock = clock;
  assign requestStages_10_reset = reset;
  assign requestStages_10_io_inValid = issueWrite_2; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_10_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_10_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_10_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_10_io_data_0_a = held_a_10[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_10_io_data_0_b = held_b_10[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_10_io_data_0_c = held_c_10[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_10_io_data_0_selectPredicate = held_predicateValues[10]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_10_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_10_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_10_io_data_1_a = held_a_26[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_10_io_data_1_b = held_b_26[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_10_io_data_1_c = held_c_26[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_10_io_data_1_selectPredicate = held_predicateValues[26]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_10_io_out_ready = lanes_10_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_11_clock = clock;
  assign requestStages_11_reset = reset;
  assign requestStages_11_io_inValid = issueWrite_2; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_11_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_11_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_11_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_11_io_data_0_a = held_a_11[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_11_io_data_0_b = held_b_11[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_11_io_data_0_c = held_c_11[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_11_io_data_0_selectPredicate = held_predicateValues[11]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_11_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_11_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_11_io_data_1_a = held_a_27[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_11_io_data_1_b = held_b_27[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_11_io_data_1_c = held_c_27[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_11_io_data_1_selectPredicate = held_predicateValues[27]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_11_io_out_ready = lanes_11_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_12_clock = clock;
  assign requestStages_12_reset = reset;
  assign requestStages_12_io_inValid = issueWrite_3; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_12_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_12_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_12_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_12_io_data_0_a = held_a_12[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_12_io_data_0_b = held_b_12[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_12_io_data_0_c = held_c_12[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_12_io_data_0_selectPredicate = held_predicateValues[12]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_12_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_12_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_12_io_data_1_a = held_a_28[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_12_io_data_1_b = held_b_28[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_12_io_data_1_c = held_c_28[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_12_io_data_1_selectPredicate = held_predicateValues[28]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_12_io_out_ready = lanes_12_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_13_clock = clock;
  assign requestStages_13_reset = reset;
  assign requestStages_13_io_inValid = issueWrite_3; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_13_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_13_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_13_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_13_io_data_0_a = held_a_13[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_13_io_data_0_b = held_b_13[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_13_io_data_0_c = held_c_13[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_13_io_data_0_selectPredicate = held_predicateValues[13]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_13_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_13_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_13_io_data_1_a = held_a_29[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_13_io_data_1_b = held_b_29[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_13_io_data_1_c = held_c_29[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_13_io_data_1_selectPredicate = held_predicateValues[29]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_13_io_out_ready = lanes_13_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_14_clock = clock;
  assign requestStages_14_reset = reset;
  assign requestStages_14_io_inValid = issueWrite_3; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_14_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_14_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_14_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_14_io_data_0_a = held_a_14[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_14_io_data_0_b = held_b_14[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_14_io_data_0_c = held_c_14[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_14_io_data_0_selectPredicate = held_predicateValues[14]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_14_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_14_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_14_io_data_1_a = held_a_30[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_14_io_data_1_b = held_b_30[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_14_io_data_1_c = held_c_30[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_14_io_data_1_selectPredicate = held_predicateValues[30]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_14_io_out_ready = lanes_14_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestStages_15_clock = clock;
  assign requestStages_15_reset = reset;
  assign requestStages_15_io_inValid = issueWrite_3; // @[AecEightLaneIntUnit.scala 74:33]
  assign requestStages_15_io_group = group; // @[AecEightLaneIntUnit.scala 75:31]
  assign requestStages_15_io_data_0_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_15_io_data_0_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_15_io_data_0_a = held_a_15[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_15_io_data_0_b = held_b_15[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_15_io_data_0_c = held_c_15[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_15_io_data_0_selectPredicate = held_predicateValues[15]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_15_io_data_1_op = requestBuffer_io_out_op; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_15_io_data_1_dtype = requestBuffer_io_out_dtype; // @[AecEightLaneIntUnit.scala 25:18 29:10]
  assign requestStages_15_io_data_1_a = held_a_31[31:0]; // @[AecEightLaneIntUnit.scala 80:57]
  assign requestStages_15_io_data_1_b = held_b_31[31:0]; // @[AecEightLaneIntUnit.scala 81:57]
  assign requestStages_15_io_data_1_c = held_c_31[31:0]; // @[AecEightLaneIntUnit.scala 82:57]
  assign requestStages_15_io_data_1_selectPredicate = held_predicateValues[31]; // @[AecEightLaneIntUnit.scala 84:74]
  assign requestStages_15_io_out_ready = lanes_15_io_req_ready; // @[AecEightLaneIntUnit.scala 86:21]
  assign requestBuffer_clock = clock;
  assign requestBuffer_reset = reset;
  assign requestBuffer_io_in_op = io_req_bits_op; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_dtype = io_req_bits_dtype; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_activeMask = io_req_bits_activeMask; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_0 = io_req_bits_a_0; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_1 = io_req_bits_a_1; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_2 = io_req_bits_a_2; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_3 = io_req_bits_a_3; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_4 = io_req_bits_a_4; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_5 = io_req_bits_a_5; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_6 = io_req_bits_a_6; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_7 = io_req_bits_a_7; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_8 = io_req_bits_a_8; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_9 = io_req_bits_a_9; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_10 = io_req_bits_a_10; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_11 = io_req_bits_a_11; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_12 = io_req_bits_a_12; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_13 = io_req_bits_a_13; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_14 = io_req_bits_a_14; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_15 = io_req_bits_a_15; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_16 = io_req_bits_a_16; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_17 = io_req_bits_a_17; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_18 = io_req_bits_a_18; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_19 = io_req_bits_a_19; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_20 = io_req_bits_a_20; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_21 = io_req_bits_a_21; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_22 = io_req_bits_a_22; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_23 = io_req_bits_a_23; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_24 = io_req_bits_a_24; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_25 = io_req_bits_a_25; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_26 = io_req_bits_a_26; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_27 = io_req_bits_a_27; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_28 = io_req_bits_a_28; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_29 = io_req_bits_a_29; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_30 = io_req_bits_a_30; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_a_31 = io_req_bits_a_31; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_0 = io_req_bits_b_0; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_1 = io_req_bits_b_1; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_2 = io_req_bits_b_2; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_3 = io_req_bits_b_3; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_4 = io_req_bits_b_4; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_5 = io_req_bits_b_5; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_6 = io_req_bits_b_6; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_7 = io_req_bits_b_7; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_8 = io_req_bits_b_8; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_9 = io_req_bits_b_9; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_10 = io_req_bits_b_10; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_11 = io_req_bits_b_11; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_12 = io_req_bits_b_12; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_13 = io_req_bits_b_13; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_14 = io_req_bits_b_14; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_15 = io_req_bits_b_15; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_16 = io_req_bits_b_16; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_17 = io_req_bits_b_17; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_18 = io_req_bits_b_18; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_19 = io_req_bits_b_19; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_20 = io_req_bits_b_20; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_21 = io_req_bits_b_21; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_22 = io_req_bits_b_22; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_23 = io_req_bits_b_23; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_24 = io_req_bits_b_24; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_25 = io_req_bits_b_25; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_26 = io_req_bits_b_26; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_27 = io_req_bits_b_27; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_28 = io_req_bits_b_28; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_29 = io_req_bits_b_29; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_30 = io_req_bits_b_30; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_b_31 = io_req_bits_b_31; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_0 = io_req_bits_c_0; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_1 = io_req_bits_c_1; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_2 = io_req_bits_c_2; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_3 = io_req_bits_c_3; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_4 = io_req_bits_c_4; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_5 = io_req_bits_c_5; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_6 = io_req_bits_c_6; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_7 = io_req_bits_c_7; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_8 = io_req_bits_c_8; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_9 = io_req_bits_c_9; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_10 = io_req_bits_c_10; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_11 = io_req_bits_c_11; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_12 = io_req_bits_c_12; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_13 = io_req_bits_c_13; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_14 = io_req_bits_c_14; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_15 = io_req_bits_c_15; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_16 = io_req_bits_c_16; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_17 = io_req_bits_c_17; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_18 = io_req_bits_c_18; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_19 = io_req_bits_c_19; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_20 = io_req_bits_c_20; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_21 = io_req_bits_c_21; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_22 = io_req_bits_c_22; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_23 = io_req_bits_c_23; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_24 = io_req_bits_c_24; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_25 = io_req_bits_c_25; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_26 = io_req_bits_c_26; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_27 = io_req_bits_c_27; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_28 = io_req_bits_c_28; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_29 = io_req_bits_c_29; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_30 = io_req_bits_c_30; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_c_31 = io_req_bits_c_31; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_dest = io_req_bits_dest; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_in_predicateValues = io_req_bits_predicateValues; // @[AecEightLaneIntUnit.scala 28:29]
  assign requestBuffer_io_arm_0 = armClusters_0; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_1 = armClusters_1; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_2 = armClusters_2; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_3 = armClusters_3; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_4 = armClusters_4; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_5 = armClusters_5; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_6 = armClusters_6; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_arm_7 = armClusters_7; // @[AecEightLaneIntUnit.scala 59:30]
  assign requestBuffer_io_capture = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign resultBanks_0_clock = clock;
  assign resultBanks_0_reset = reset;
  assign resultBanks_0_io_write = retireWrite_0; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_0_io_writeResult = held_activeMask[0] ? _resultBanks_0_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_0_io_writePredicate = held_activeMask[0] & lanes_0_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_0_io_writeError = held_activeMask[0] & lanes_0_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_1_clock = clock;
  assign resultBanks_1_reset = reset;
  assign resultBanks_1_io_write = retireWrite_0; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_1_io_writeResult = held_activeMask[1] ? _resultBanks_1_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_1_io_writePredicate = held_activeMask[1] & lanes_1_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_1_io_writeError = held_activeMask[1] & lanes_1_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_2_clock = clock;
  assign resultBanks_2_reset = reset;
  assign resultBanks_2_io_write = retireWrite_0; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_2_io_writeResult = held_activeMask[2] ? _resultBanks_2_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_2_io_writePredicate = held_activeMask[2] & lanes_2_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_2_io_writeError = held_activeMask[2] & lanes_2_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_3_clock = clock;
  assign resultBanks_3_reset = reset;
  assign resultBanks_3_io_write = retireWrite_0; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_3_io_writeResult = held_activeMask[3] ? _resultBanks_3_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_3_io_writePredicate = held_activeMask[3] & lanes_3_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_3_io_writeError = held_activeMask[3] & lanes_3_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_4_clock = clock;
  assign resultBanks_4_reset = reset;
  assign resultBanks_4_io_write = retireWrite_1; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_4_io_writeResult = held_activeMask[4] ? _resultBanks_4_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_4_io_writePredicate = held_activeMask[4] & lanes_4_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_4_io_writeError = held_activeMask[4] & lanes_4_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_5_clock = clock;
  assign resultBanks_5_reset = reset;
  assign resultBanks_5_io_write = retireWrite_1; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_5_io_writeResult = held_activeMask[5] ? _resultBanks_5_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_5_io_writePredicate = held_activeMask[5] & lanes_5_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_5_io_writeError = held_activeMask[5] & lanes_5_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_6_clock = clock;
  assign resultBanks_6_reset = reset;
  assign resultBanks_6_io_write = retireWrite_1; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_6_io_writeResult = held_activeMask[6] ? _resultBanks_6_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_6_io_writePredicate = held_activeMask[6] & lanes_6_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_6_io_writeError = held_activeMask[6] & lanes_6_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_7_clock = clock;
  assign resultBanks_7_reset = reset;
  assign resultBanks_7_io_write = retireWrite_1; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_7_io_writeResult = held_activeMask[7] ? _resultBanks_7_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_7_io_writePredicate = held_activeMask[7] & lanes_7_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_7_io_writeError = held_activeMask[7] & lanes_7_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_8_clock = clock;
  assign resultBanks_8_reset = reset;
  assign resultBanks_8_io_write = retireWrite_2; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_8_io_writeResult = held_activeMask[8] ? _resultBanks_8_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_8_io_writePredicate = held_activeMask[8] & lanes_8_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_8_io_writeError = held_activeMask[8] & lanes_8_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_9_clock = clock;
  assign resultBanks_9_reset = reset;
  assign resultBanks_9_io_write = retireWrite_2; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_9_io_writeResult = held_activeMask[9] ? _resultBanks_9_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_9_io_writePredicate = held_activeMask[9] & lanes_9_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_9_io_writeError = held_activeMask[9] & lanes_9_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_10_clock = clock;
  assign resultBanks_10_reset = reset;
  assign resultBanks_10_io_write = retireWrite_2; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_10_io_writeResult = held_activeMask[10] ? _resultBanks_10_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_10_io_writePredicate = held_activeMask[10] & lanes_10_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_10_io_writeError = held_activeMask[10] & lanes_10_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_11_clock = clock;
  assign resultBanks_11_reset = reset;
  assign resultBanks_11_io_write = retireWrite_2; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_11_io_writeResult = held_activeMask[11] ? _resultBanks_11_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_11_io_writePredicate = held_activeMask[11] & lanes_11_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_11_io_writeError = held_activeMask[11] & lanes_11_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_12_clock = clock;
  assign resultBanks_12_reset = reset;
  assign resultBanks_12_io_write = retireWrite_3; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_12_io_writeResult = held_activeMask[12] ? _resultBanks_12_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_12_io_writePredicate = held_activeMask[12] & lanes_12_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_12_io_writeError = held_activeMask[12] & lanes_12_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_13_clock = clock;
  assign resultBanks_13_reset = reset;
  assign resultBanks_13_io_write = retireWrite_3; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_13_io_writeResult = held_activeMask[13] ? _resultBanks_13_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_13_io_writePredicate = held_activeMask[13] & lanes_13_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_13_io_writeError = held_activeMask[13] & lanes_13_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_14_clock = clock;
  assign resultBanks_14_reset = reset;
  assign resultBanks_14_io_write = retireWrite_3; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_14_io_writeResult = held_activeMask[14] ? _resultBanks_14_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_14_io_writePredicate = held_activeMask[14] & lanes_14_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_14_io_writeError = held_activeMask[14] & lanes_14_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_15_clock = clock;
  assign resultBanks_15_reset = reset;
  assign resultBanks_15_io_write = retireWrite_3; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_15_io_writeResult = held_activeMask[15] ? _resultBanks_15_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_15_io_writePredicate = held_activeMask[15] & lanes_15_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_15_io_writeError = held_activeMask[15] & lanes_15_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_16_clock = clock;
  assign resultBanks_16_reset = reset;
  assign resultBanks_16_io_write = retireWrite_4; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_16_io_writeResult = held_activeMask[16] ? _resultBanks_0_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_16_io_writePredicate = held_activeMask[16] & lanes_0_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_16_io_writeError = held_activeMask[16] & lanes_0_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_17_clock = clock;
  assign resultBanks_17_reset = reset;
  assign resultBanks_17_io_write = retireWrite_4; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_17_io_writeResult = held_activeMask[17] ? _resultBanks_1_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_17_io_writePredicate = held_activeMask[17] & lanes_1_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_17_io_writeError = held_activeMask[17] & lanes_1_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_18_clock = clock;
  assign resultBanks_18_reset = reset;
  assign resultBanks_18_io_write = retireWrite_4; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_18_io_writeResult = held_activeMask[18] ? _resultBanks_2_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_18_io_writePredicate = held_activeMask[18] & lanes_2_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_18_io_writeError = held_activeMask[18] & lanes_2_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_19_clock = clock;
  assign resultBanks_19_reset = reset;
  assign resultBanks_19_io_write = retireWrite_4; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_19_io_writeResult = held_activeMask[19] ? _resultBanks_3_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_19_io_writePredicate = held_activeMask[19] & lanes_3_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_19_io_writeError = held_activeMask[19] & lanes_3_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_20_clock = clock;
  assign resultBanks_20_reset = reset;
  assign resultBanks_20_io_write = retireWrite_5; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_20_io_writeResult = held_activeMask[20] ? _resultBanks_4_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_20_io_writePredicate = held_activeMask[20] & lanes_4_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_20_io_writeError = held_activeMask[20] & lanes_4_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_21_clock = clock;
  assign resultBanks_21_reset = reset;
  assign resultBanks_21_io_write = retireWrite_5; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_21_io_writeResult = held_activeMask[21] ? _resultBanks_5_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_21_io_writePredicate = held_activeMask[21] & lanes_5_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_21_io_writeError = held_activeMask[21] & lanes_5_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_22_clock = clock;
  assign resultBanks_22_reset = reset;
  assign resultBanks_22_io_write = retireWrite_5; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_22_io_writeResult = held_activeMask[22] ? _resultBanks_6_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_22_io_writePredicate = held_activeMask[22] & lanes_6_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_22_io_writeError = held_activeMask[22] & lanes_6_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_23_clock = clock;
  assign resultBanks_23_reset = reset;
  assign resultBanks_23_io_write = retireWrite_5; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_23_io_writeResult = held_activeMask[23] ? _resultBanks_7_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_23_io_writePredicate = held_activeMask[23] & lanes_7_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_23_io_writeError = held_activeMask[23] & lanes_7_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_24_clock = clock;
  assign resultBanks_24_reset = reset;
  assign resultBanks_24_io_write = retireWrite_6; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_24_io_writeResult = held_activeMask[24] ? _resultBanks_8_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_24_io_writePredicate = held_activeMask[24] & lanes_8_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_24_io_writeError = held_activeMask[24] & lanes_8_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_25_clock = clock;
  assign resultBanks_25_reset = reset;
  assign resultBanks_25_io_write = retireWrite_6; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_25_io_writeResult = held_activeMask[25] ? _resultBanks_9_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_25_io_writePredicate = held_activeMask[25] & lanes_9_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_25_io_writeError = held_activeMask[25] & lanes_9_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_26_clock = clock;
  assign resultBanks_26_reset = reset;
  assign resultBanks_26_io_write = retireWrite_6; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_26_io_writeResult = held_activeMask[26] ? _resultBanks_10_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_26_io_writePredicate = held_activeMask[26] & lanes_10_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_26_io_writeError = held_activeMask[26] & lanes_10_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_27_clock = clock;
  assign resultBanks_27_reset = reset;
  assign resultBanks_27_io_write = retireWrite_6; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_27_io_writeResult = held_activeMask[27] ? _resultBanks_11_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_27_io_writePredicate = held_activeMask[27] & lanes_11_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_27_io_writeError = held_activeMask[27] & lanes_11_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_28_clock = clock;
  assign resultBanks_28_reset = reset;
  assign resultBanks_28_io_write = retireWrite_7; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_28_io_writeResult = held_activeMask[28] ? _resultBanks_12_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_28_io_writePredicate = held_activeMask[28] & lanes_12_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_28_io_writeError = held_activeMask[28] & lanes_12_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_29_clock = clock;
  assign resultBanks_29_reset = reset;
  assign resultBanks_29_io_write = retireWrite_7; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_29_io_writeResult = held_activeMask[29] ? _resultBanks_13_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_29_io_writePredicate = held_activeMask[29] & lanes_13_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_29_io_writeError = held_activeMask[29] & lanes_13_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_30_clock = clock;
  assign resultBanks_30_reset = reset;
  assign resultBanks_30_io_write = retireWrite_7; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_30_io_writeResult = held_activeMask[30] ? _resultBanks_14_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_30_io_writePredicate = held_activeMask[30] & lanes_14_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_30_io_writeError = held_activeMask[30] & lanes_14_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  assign resultBanks_31_clock = clock;
  assign resultBanks_31_reset = reset;
  assign resultBanks_31_io_write = retireWrite_7; // @[AecEightLaneIntUnit.scala 99:45]
  assign resultBanks_31_io_writeResult = held_activeMask[31] ? _resultBanks_15_io_writeResult_T_1 : 64'h0; // @[AecEightLaneIntUnit.scala 100:57]
  assign resultBanks_31_io_writePredicate = held_activeMask[31] & lanes_15_io_resp_bits_predicateResult; // @[AecEightLaneIntUnit.scala 103:92]
  assign resultBanks_31_io_writeError = held_activeMask[31] & lanes_15_io_resp_bits_error; // @[AecEightLaneIntUnit.scala 104:88]
  always @(posedge clock) begin
    if (reset) begin // @[AecEightLaneIntUnit.scala 34:22]
      group <= 1'h0; // @[AecEightLaneIntUnit.scala 34:22]
    end else if (stateCommit) begin // @[AecEightLaneIntUnit.scala 130:22]
      if (group) begin // @[AecEightLaneIntUnit.scala 131:37]
        group <= _GEN_2;
      end else begin
        group <= group + 1'h1; // @[AecEightLaneIntUnit.scala 134:13]
      end
    end else begin
      group <= _GEN_2;
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 35:22]
      state <= 10'h1; // @[AecEightLaneIntUnit.scala 35:22]
    end else if (_T_4) begin // @[AecEightLaneIntUnit.scala 138:23]
      state <= 10'h1; // @[AecEightLaneIntUnit.scala 139:11]
    end else if (stateCommit) begin // @[AecEightLaneIntUnit.scala 130:22]
      if (group) begin // @[AecEightLaneIntUnit.scala 131:37]
        state <= 10'h200; // @[AecEightLaneIntUnit.scala 132:13]
      end else begin
        state <= 10'h8; // @[AecEightLaneIntUnit.scala 135:13]
      end
    end else if (stateRetire) begin // @[AecEightLaneIntUnit.scala 127:22]
      state <= 10'h100; // @[AecEightLaneIntUnit.scala 128:11]
    end else begin
      state <= _GEN_7;
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_0 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_0 <= _retireWrite_0_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_1 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_1 <= _retireWrite_0_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_2 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_2 <= _retireWrite_0_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_3 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_3 <= _retireWrite_0_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_4 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_4 <= _retireWrite_4_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_5 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_5 <= _retireWrite_4_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_6 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_6 <= _retireWrite_4_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 48:28]
      retireWrite_7 <= 1'h0; // @[AecEightLaneIntUnit.scala 48:28]
    end else begin
      retireWrite_7 <= _retireWrite_4_T_2; // @[AecEightLaneIntUnit.scala 90:47]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 50:27]
      issueWrite_0 <= 1'h0; // @[AecEightLaneIntUnit.scala 50:27]
    end else begin
      issueWrite_0 <= stateIssue & allReady; // @[AecEightLaneIntUnit.scala 94:25]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 50:27]
      issueWrite_1 <= 1'h0; // @[AecEightLaneIntUnit.scala 50:27]
    end else begin
      issueWrite_1 <= stateIssue & allReady; // @[AecEightLaneIntUnit.scala 94:25]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 50:27]
      issueWrite_2 <= 1'h0; // @[AecEightLaneIntUnit.scala 50:27]
    end else begin
      issueWrite_2 <= stateIssue & allReady; // @[AecEightLaneIntUnit.scala 94:25]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 50:27]
      issueWrite_3 <= 1'h0; // @[AecEightLaneIntUnit.scala 50:27]
    end else begin
      issueWrite_3 <= stateIssue & allReady; // @[AecEightLaneIntUnit.scala 94:25]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 52:30]
      responseReady_0 <= 1'h0; // @[AecEightLaneIntUnit.scala 52:30]
    end else begin
      responseReady_0 <= _retireWrite_0_T; // @[AecEightLaneIntUnit.scala 95:28]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 52:30]
      responseReady_1 <= 1'h0; // @[AecEightLaneIntUnit.scala 52:30]
    end else begin
      responseReady_1 <= _retireWrite_0_T; // @[AecEightLaneIntUnit.scala 95:28]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 52:30]
      responseReady_2 <= 1'h0; // @[AecEightLaneIntUnit.scala 52:30]
    end else begin
      responseReady_2 <= _retireWrite_0_T; // @[AecEightLaneIntUnit.scala 95:28]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 52:30]
      responseReady_3 <= 1'h0; // @[AecEightLaneIntUnit.scala 52:30]
    end else begin
      responseReady_3 <= _retireWrite_0_T; // @[AecEightLaneIntUnit.scala 95:28]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_0 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_0 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_1 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_1 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_2 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_2 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_3 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_3 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_4 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_4 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_5 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_5 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_6 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_6 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
    end
    if (reset) begin // @[AecEightLaneIntUnit.scala 56:30]
      armClusters_7 <= 1'h0; // @[AecEightLaneIntUnit.scala 56:30]
    end else begin
      armClusters_7 <= armCapture; // @[AecEightLaneIntUnit.scala 57:27]
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
  group = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  state = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  retireWrite_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  retireWrite_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  retireWrite_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  retireWrite_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  retireWrite_4 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  retireWrite_5 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  retireWrite_6 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  retireWrite_7 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  issueWrite_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  issueWrite_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  issueWrite_2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  issueWrite_3 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  responseReady_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  responseReady_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  responseReady_2 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  responseReady_3 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  armClusters_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  armClusters_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  armClusters_2 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  armClusters_3 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  armClusters_4 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  armClusters_5 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  armClusters_6 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  armClusters_7 = _RAND_25[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
