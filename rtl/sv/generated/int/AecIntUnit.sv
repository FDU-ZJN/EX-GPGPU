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
`endif // RANDOMIZE_REG_INIT
  reg  busy; // @[AecIntAlu.scala 39:21]
  reg [31:0] result; // @[AecIntAlu.scala 40:23]
  reg  predicateResult; // @[AecIntAlu.scala 41:32]
  reg  error; // @[AecIntAlu.scala 43:22]
  wire  isSigned = io_req_bits_dtype == 4'h3; // @[AecIntAlu.scala 52:36]
  wire [4:0] shift = io_req_bits_b[4:0]; // @[AecIntAlu.scala 58:16]
  wire  divByZero = io_req_bits_b == 32'h0; // @[AecIntAlu.scala 59:21]
  wire  isCmp = io_req_bits_op == 16'h20; // @[AecIntAlu.scala 60:30]
  wire  isCmmP = io_req_bits_op == 16'h21; // @[AecIntAlu.scala 61:31]
  wire [2:0] relation = io_req_bits_c[2:0]; // @[AecIntAlu.scala 62:19]
  wire  cmpEq = io_req_bits_a == io_req_bits_b; // @[AecIntAlu.scala 64:17]
  wire  _cmpLt_T = $signed(io_req_bits_a) < $signed(io_req_bits_b); // @[AecIntAlu.scala 65:32]
  wire  _cmpLt_T_1 = io_req_bits_a < io_req_bits_b; // @[AecIntAlu.scala 65:40]
  wire  cmpLt = isSigned ? $signed(io_req_bits_a) < $signed(io_req_bits_b) : io_req_bits_a < io_req_bits_b; // @[AecIntAlu.scala 65:18]
  wire  _cmpGt_T = $signed(io_req_bits_a) > $signed(io_req_bits_b); // @[AecIntAlu.scala 66:32]
  wire  _cmpGt_T_1 = io_req_bits_a > io_req_bits_b; // @[AecIntAlu.scala 66:40]
  wire  cmpGt = isSigned ? $signed(io_req_bits_a) > $signed(io_req_bits_b) : io_req_bits_a > io_req_bits_b; // @[AecIntAlu.scala 66:18]
  wire  _cmpResult_T = ~cmpEq; // @[AecIntAlu.scala 68:26]
  wire  _cmpResult_T_1 = cmpLt | cmpEq; // @[AecIntAlu.scala 69:19]
  wire  _cmpResult_T_2 = cmpGt | cmpEq; // @[AecIntAlu.scala 69:58]
  wire  _cmpResult_T_6 = 3'h1 == relation ? _cmpResult_T : 3'h0 == relation & cmpEq; // @[Mux.scala 81:58]
  wire  _cmpResult_T_8 = 3'h2 == relation ? cmpLt : _cmpResult_T_6; // @[Mux.scala 81:58]
  wire  _cmpResult_T_10 = 3'h3 == relation ? _cmpResult_T_1 : _cmpResult_T_8; // @[Mux.scala 81:58]
  wire  _cmpResult_T_12 = 3'h4 == relation ? cmpGt : _cmpResult_T_10; // @[Mux.scala 81:58]
  wire  cmpResult = 3'h5 == relation ? _cmpResult_T_2 : _cmpResult_T_12; // @[Mux.scala 81:58]
  wire [31:0] _aluResult_T_1 = io_req_bits_a + io_req_bits_b; // @[AecIntAlu.scala 78:20]
  wire [31:0] _aluResult_T_3 = io_req_bits_a - io_req_bits_b; // @[AecIntAlu.scala 80:20]
  wire [63:0] _aluResult_T_4 = io_req_bits_a * io_req_bits_b; // @[AecIntAlu.scala 82:20]
  wire [63:0] _GEN_55 = {{32'd0}, io_req_bits_c}; // @[AecIntAlu.scala 84:24]
  wire [63:0] _aluResult_T_7 = _aluResult_T_4 + _GEN_55; // @[AecIntAlu.scala 84:24]
  wire [32:0] _aluResult_T_9 = $signed(io_req_bits_a) / $signed(io_req_bits_b); // @[AecIntAlu.scala 87:53]
  wire [31:0] _aluResult_T_10 = io_req_bits_a / io_req_bits_b; // @[AecIntAlu.scala 88:35]
  wire [32:0] _GEN_0 = isSigned ? _aluResult_T_9 : {{1'd0}, _aluResult_T_10}; // @[AecIntAlu.scala 87:{28,40} 88:30]
  wire [32:0] _GEN_2 = divByZero ? 33'h0 : _GEN_0; // @[AecIntAlu.scala 86:22 71:30]
  wire [31:0] _aluResult_T_14 = 32'sh0 - $signed(io_req_bits_a); // @[AecIntAlu.scala 90:24]
  wire [31:0] _aluResult_T_20 = $signed(io_req_bits_a) < 32'sh0 ? _aluResult_T_14 : io_req_bits_a; // @[AecIntAlu.scala 92:21]
  wire [31:0] _aluResult_T_22 = _cmpLt_T ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 94:35]
  wire [31:0] _aluResult_T_24 = _cmpLt_T_1 ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 94:55]
  wire [31:0] _aluResult_T_25 = isSigned ? _aluResult_T_22 : _aluResult_T_24; // @[AecIntAlu.scala 94:21]
  wire [31:0] _aluResult_T_27 = _cmpGt_T ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 96:35]
  wire [31:0] _aluResult_T_29 = _cmpGt_T_1 ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 96:55]
  wire [31:0] _aluResult_T_30 = isSigned ? _aluResult_T_27 : _aluResult_T_29; // @[AecIntAlu.scala 96:21]
  wire [31:0] _aluResult_T_31 = io_req_bits_a & io_req_bits_b; // @[AecIntAlu.scala 98:20]
  wire [31:0] _aluResult_T_32 = io_req_bits_a | io_req_bits_b; // @[AecIntAlu.scala 100:20]
  wire [31:0] _aluResult_T_33 = io_req_bits_a ^ io_req_bits_b; // @[AecIntAlu.scala 102:20]
  wire [31:0] _aluResult_T_34 = ~io_req_bits_a; // @[AecIntAlu.scala 104:18]
  wire [62:0] _GEN_1 = {{31'd0}, io_req_bits_a}; // @[AecIntAlu.scala 106:20]
  wire [62:0] _aluResult_T_35 = _GEN_1 << shift; // @[AecIntAlu.scala 106:20]
  wire [31:0] _aluResult_T_37 = $signed(io_req_bits_a) >>> shift; // @[AecIntAlu.scala 108:46]
  wire [31:0] _aluResult_T_38 = io_req_bits_a >> shift; // @[AecIntAlu.scala 108:56]
  wire [31:0] _aluResult_T_39 = isSigned ? _aluResult_T_37 : _aluResult_T_38; // @[AecIntAlu.scala 108:21]
  wire [7:0] lsb = io_req_bits_c[7:0]; // @[AecIntAlu.scala 110:16]
  wire [7:0] width = io_req_bits_c[15:8]; // @[AecIntAlu.scala 110:37]
  wire [7:0] _valid_T_4 = lsb + width; // @[AecIntAlu.scala 111:53]
  wire  valid = lsb <= 8'h1f & width <= 8'h20 & _valid_T_4 <= 8'h20; // @[AecIntAlu.scala 111:46]
  wire  _mask_T = width == 8'h0; // @[AecIntAlu.scala 112:26]
  wire [287:0] _mask_T_1 = 288'h1 << width; // @[AecIntAlu.scala 112:52]
  wire [287:0] _mask_T_3 = _mask_T_1 - 288'h1; // @[AecIntAlu.scala 112:62]
  wire [31:0] mask = width == 8'h0 ? 32'h0 : _mask_T_3[31:0]; // @[AecIntAlu.scala 112:19]
  wire [31:0] _extracted_T = io_req_bits_a >> lsb; // @[AecIntAlu.scala 113:24]
  wire [31:0] extracted = _extracted_T & mask; // @[AecIntAlu.scala 113:32]
  wire  _aluError_T = ~valid; // @[AecIntAlu.scala 114:17]
  wire [7:0] _aluResult_T_43 = width - 8'h1; // @[AecIntAlu.scala 115:67]
  wire [31:0] _aluResult_T_44 = extracted >> _aluResult_T_43; // @[AecIntAlu.scala 115:60]
  wire [31:0] _aluResult_T_47 = ~mask; // @[AecIntAlu.scala 116:19]
  wire [31:0] _aluResult_T_48 = extracted | _aluResult_T_47; // @[AecIntAlu.scala 116:17]
  wire [31:0] _aluResult_T_49 = isSigned & width != 8'h0 & _aluResult_T_44[0] ? _aluResult_T_48 : extracted; // @[AecIntAlu.scala 115:21]
  wire [286:0] _GEN_47 = {{255'd0}, _mask_T_3[31:0]}; // @[AecIntAlu.scala 120:78]
  wire [286:0] _mask_T_10 = _GEN_47 << lsb; // @[AecIntAlu.scala 120:78]
  wire [286:0] mask_1 = _mask_T ? 287'h0 : _mask_T_10; // @[AecIntAlu.scala 120:19]
  wire [286:0] _aluResult_T_50 = ~mask_1; // @[AecIntAlu.scala 122:23]
  wire [286:0] _GEN_56 = {{255'd0}, io_req_bits_a}; // @[AecIntAlu.scala 122:21]
  wire [286:0] _aluResult_T_51 = _GEN_56 & _aluResult_T_50; // @[AecIntAlu.scala 122:21]
  wire [286:0] _GEN_48 = {{255'd0}, io_req_bits_b}; // @[AecIntAlu.scala 122:36]
  wire [286:0] _aluResult_T_52 = _GEN_48 << lsb; // @[AecIntAlu.scala 122:36]
  wire [286:0] _aluResult_T_53 = _aluResult_T_52 & mask_1; // @[AecIntAlu.scala 122:44]
  wire [286:0] _aluResult_T_54 = _aluResult_T_51 | _aluResult_T_53; // @[AecIntAlu.scala 122:30]
  wire [1:0] _aluResult_T_87 = io_req_bits_a[0] + io_req_bits_a[1]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_89 = io_req_bits_a[2] + io_req_bits_a[3]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_91 = _aluResult_T_87 + _aluResult_T_89; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_93 = io_req_bits_a[4] + io_req_bits_a[5]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_95 = io_req_bits_a[6] + io_req_bits_a[7]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_97 = _aluResult_T_93 + _aluResult_T_95; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_99 = _aluResult_T_91 + _aluResult_T_97; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_101 = io_req_bits_a[8] + io_req_bits_a[9]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_103 = io_req_bits_a[10] + io_req_bits_a[11]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_105 = _aluResult_T_101 + _aluResult_T_103; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_107 = io_req_bits_a[12] + io_req_bits_a[13]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_109 = io_req_bits_a[14] + io_req_bits_a[15]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_111 = _aluResult_T_107 + _aluResult_T_109; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_113 = _aluResult_T_105 + _aluResult_T_111; // @[Bitwise.scala 51:90]
  wire [4:0] _aluResult_T_115 = _aluResult_T_99 + _aluResult_T_113; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_117 = io_req_bits_a[16] + io_req_bits_a[17]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_119 = io_req_bits_a[18] + io_req_bits_a[19]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_121 = _aluResult_T_117 + _aluResult_T_119; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_123 = io_req_bits_a[20] + io_req_bits_a[21]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_125 = io_req_bits_a[22] + io_req_bits_a[23]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_127 = _aluResult_T_123 + _aluResult_T_125; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_129 = _aluResult_T_121 + _aluResult_T_127; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_131 = io_req_bits_a[24] + io_req_bits_a[25]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_133 = io_req_bits_a[26] + io_req_bits_a[27]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_135 = _aluResult_T_131 + _aluResult_T_133; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_137 = io_req_bits_a[28] + io_req_bits_a[29]; // @[Bitwise.scala 51:90]
  wire [1:0] _aluResult_T_139 = io_req_bits_a[30] + io_req_bits_a[31]; // @[Bitwise.scala 51:90]
  wire [2:0] _aluResult_T_141 = _aluResult_T_137 + _aluResult_T_139; // @[Bitwise.scala 51:90]
  wire [3:0] _aluResult_T_143 = _aluResult_T_135 + _aluResult_T_141; // @[Bitwise.scala 51:90]
  wire [4:0] _aluResult_T_145 = _aluResult_T_129 + _aluResult_T_143; // @[Bitwise.scala 51:90]
  wire [5:0] _aluResult_T_147 = _aluResult_T_115 + _aluResult_T_145; // @[Bitwise.scala 51:90]
  wire [4:0] _aluResult_T_181 = io_req_bits_a[30] ? 5'h1e : 5'h1f; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_182 = io_req_bits_a[29] ? 5'h1d : _aluResult_T_181; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_183 = io_req_bits_a[28] ? 5'h1c : _aluResult_T_182; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_184 = io_req_bits_a[27] ? 5'h1b : _aluResult_T_183; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_185 = io_req_bits_a[26] ? 5'h1a : _aluResult_T_184; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_186 = io_req_bits_a[25] ? 5'h19 : _aluResult_T_185; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_187 = io_req_bits_a[24] ? 5'h18 : _aluResult_T_186; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_188 = io_req_bits_a[23] ? 5'h17 : _aluResult_T_187; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_189 = io_req_bits_a[22] ? 5'h16 : _aluResult_T_188; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_190 = io_req_bits_a[21] ? 5'h15 : _aluResult_T_189; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_191 = io_req_bits_a[20] ? 5'h14 : _aluResult_T_190; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_192 = io_req_bits_a[19] ? 5'h13 : _aluResult_T_191; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_193 = io_req_bits_a[18] ? 5'h12 : _aluResult_T_192; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_194 = io_req_bits_a[17] ? 5'h11 : _aluResult_T_193; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_195 = io_req_bits_a[16] ? 5'h10 : _aluResult_T_194; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_196 = io_req_bits_a[15] ? 5'hf : _aluResult_T_195; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_197 = io_req_bits_a[14] ? 5'he : _aluResult_T_196; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_198 = io_req_bits_a[13] ? 5'hd : _aluResult_T_197; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_199 = io_req_bits_a[12] ? 5'hc : _aluResult_T_198; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_200 = io_req_bits_a[11] ? 5'hb : _aluResult_T_199; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_201 = io_req_bits_a[10] ? 5'ha : _aluResult_T_200; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_202 = io_req_bits_a[9] ? 5'h9 : _aluResult_T_201; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_203 = io_req_bits_a[8] ? 5'h8 : _aluResult_T_202; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_204 = io_req_bits_a[7] ? 5'h7 : _aluResult_T_203; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_205 = io_req_bits_a[6] ? 5'h6 : _aluResult_T_204; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_206 = io_req_bits_a[5] ? 5'h5 : _aluResult_T_205; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_207 = io_req_bits_a[4] ? 5'h4 : _aluResult_T_206; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_208 = io_req_bits_a[3] ? 5'h3 : _aluResult_T_207; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_209 = io_req_bits_a[2] ? 5'h2 : _aluResult_T_208; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_210 = io_req_bits_a[1] ? 5'h1 : _aluResult_T_209; // @[Mux.scala 47:70]
  wire [4:0] _aluResult_T_211 = io_req_bits_a[0] ? 5'h0 : _aluResult_T_210; // @[Mux.scala 47:70]
  wire [31:0] _GEN_3 = io_req_bits_a == 32'h0 ? 32'hffffffff : {{27'd0}, _aluResult_T_211}; // @[AecIntAlu.scala 126:15 127:{22,34}]
  wire [31:0] _aluResult_T_212 = io_req_bits_selectPredicate ? io_req_bits_a : io_req_bits_b; // @[AecIntAlu.scala 129:21]
  wire [31:0] _aluResult_T_214 = io_req_bits_a[31] ? io_req_bits_b : io_req_bits_a; // @[AecIntAlu.scala 131:21]
  wire [31:0] _GEN_4 = io_req_bits_op == 16'h23 ? _aluResult_T_214 : 32'h0; // @[AecIntAlu.scala 130:50 131:15 71:30]
  wire  _GEN_5 = io_req_bits_op == 16'h23 ? 1'h0 : 1'h1; // @[AecIntAlu.scala 130:50 133:14 73:29]
  wire [31:0] _GEN_6 = io_req_bits_op == 16'h22 ? _aluResult_T_212 : _GEN_4; // @[AecIntAlu.scala 128:49 129:15]
  wire  _GEN_7 = io_req_bits_op == 16'h22 ? 1'h0 : _GEN_5; // @[AecIntAlu.scala 128:49 73:29]
  wire [31:0] _GEN_8 = io_req_bits_op == 16'h19 ? _GEN_3 : _GEN_6; // @[AecIntAlu.scala 125:49]
  wire  _GEN_9 = io_req_bits_op == 16'h19 ? 1'h0 : _GEN_7; // @[AecIntAlu.scala 125:49 73:29]
  wire [31:0] _GEN_10 = io_req_bits_op == 16'h18 ? {{26'd0}, _aluResult_T_147} : _GEN_8; // @[AecIntAlu.scala 123:50 124:15]
  wire  _GEN_11 = io_req_bits_op == 16'h18 ? 1'h0 : _GEN_9; // @[AecIntAlu.scala 123:50 73:29]
  wire  _GEN_12 = io_req_bits_op == 16'h17 ? _aluError_T : _GEN_11; // @[AecIntAlu.scala 117:50 121:14]
  wire [286:0] _GEN_13 = io_req_bits_op == 16'h17 ? _aluResult_T_54 : {{255'd0}, _GEN_10}; // @[AecIntAlu.scala 117:50 122:15]
  wire  _GEN_14 = io_req_bits_op == 16'h16 ? ~valid : _GEN_12; // @[AecIntAlu.scala 109:49 114:14]
  wire [286:0] _GEN_15 = io_req_bits_op == 16'h16 ? {{255'd0}, _aluResult_T_49} : _GEN_13; // @[AecIntAlu.scala 109:49 115:15]
  wire [286:0] _GEN_16 = io_req_bits_op == 16'h15 ? {{255'd0}, _aluResult_T_39} : _GEN_15; // @[AecIntAlu.scala 107:49 108:15]
  wire  _GEN_17 = io_req_bits_op == 16'h15 ? 1'h0 : _GEN_14; // @[AecIntAlu.scala 107:49 73:29]
  wire [286:0] _GEN_18 = io_req_bits_op == 16'h14 ? {{224'd0}, _aluResult_T_35} : _GEN_16; // @[AecIntAlu.scala 105:49 106:15]
  wire  _GEN_19 = io_req_bits_op == 16'h14 ? 1'h0 : _GEN_17; // @[AecIntAlu.scala 105:49 73:29]
  wire [286:0] _GEN_20 = io_req_bits_op == 16'h13 ? {{255'd0}, _aluResult_T_34} : _GEN_18; // @[AecIntAlu.scala 103:51 104:15]
  wire  _GEN_21 = io_req_bits_op == 16'h13 ? 1'h0 : _GEN_19; // @[AecIntAlu.scala 103:51 73:29]
  wire [286:0] _GEN_22 = io_req_bits_op == 16'h12 ? {{255'd0}, _aluResult_T_33} : _GEN_20; // @[AecIntAlu.scala 101:51 102:15]
  wire  _GEN_23 = io_req_bits_op == 16'h12 ? 1'h0 : _GEN_21; // @[AecIntAlu.scala 101:51 73:29]
  wire [286:0] _GEN_24 = io_req_bits_op == 16'h11 ? {{255'd0}, _aluResult_T_32} : _GEN_22; // @[AecIntAlu.scala 100:15 99:50]
  wire  _GEN_25 = io_req_bits_op == 16'h11 ? 1'h0 : _GEN_23; // @[AecIntAlu.scala 73:29 99:50]
  wire [286:0] _GEN_26 = io_req_bits_op == 16'h10 ? {{255'd0}, _aluResult_T_31} : _GEN_24; // @[AecIntAlu.scala 97:51 98:15]
  wire  _GEN_27 = io_req_bits_op == 16'h10 ? 1'h0 : _GEN_25; // @[AecIntAlu.scala 73:29 97:51]
  wire [286:0] _GEN_28 = io_req_bits_op == 16'ha ? {{255'd0}, _aluResult_T_30} : _GEN_26; // @[AecIntAlu.scala 95:49 96:15]
  wire  _GEN_29 = io_req_bits_op == 16'ha ? 1'h0 : _GEN_27; // @[AecIntAlu.scala 73:29 95:49]
  wire [286:0] _GEN_30 = io_req_bits_op == 16'h9 ? {{255'd0}, _aluResult_T_25} : _GEN_28; // @[AecIntAlu.scala 93:49 94:15]
  wire  _GEN_31 = io_req_bits_op == 16'h9 ? 1'h0 : _GEN_29; // @[AecIntAlu.scala 73:29 93:49]
  wire [286:0] _GEN_32 = io_req_bits_op == 16'h8 ? {{255'd0}, _aluResult_T_20} : _GEN_30; // @[AecIntAlu.scala 91:49 92:15]
  wire  _GEN_33 = io_req_bits_op == 16'h8 ? 1'h0 : _GEN_31; // @[AecIntAlu.scala 73:29 91:49]
  wire [286:0] _GEN_34 = io_req_bits_op == 16'h7 ? {{255'd0}, _aluResult_T_14} : _GEN_32; // @[AecIntAlu.scala 89:49 90:15]
  wire  _GEN_35 = io_req_bits_op == 16'h7 ? 1'h0 : _GEN_33; // @[AecIntAlu.scala 73:29 89:49]
  wire  _GEN_36 = io_req_bits_op == 16'h6 ? divByZero : _GEN_35; // @[AecIntAlu.scala 85:49]
  wire [286:0] _GEN_37 = io_req_bits_op == 16'h6 ? {{254'd0}, _GEN_2} : _GEN_34; // @[AecIntAlu.scala 85:49]
  wire [286:0] _GEN_38 = io_req_bits_op == 16'h4 ? {{223'd0}, _aluResult_T_7} : _GEN_37; // @[AecIntAlu.scala 83:49 84:15]
  wire  _GEN_39 = io_req_bits_op == 16'h4 ? 1'h0 : _GEN_36; // @[AecIntAlu.scala 73:29 83:49]
  wire [286:0] _GEN_40 = io_req_bits_op == 16'h3 ? {{223'd0}, _aluResult_T_4} : _GEN_38; // @[AecIntAlu.scala 81:49 82:15]
  wire  _GEN_41 = io_req_bits_op == 16'h3 ? 1'h0 : _GEN_39; // @[AecIntAlu.scala 73:29 81:49]
  wire [286:0] _GEN_42 = io_req_bits_op == 16'h2 ? {{255'd0}, _aluResult_T_3} : _GEN_40; // @[AecIntAlu.scala 79:49 80:15]
  wire  _GEN_43 = io_req_bits_op == 16'h2 ? 1'h0 : _GEN_41; // @[AecIntAlu.scala 73:29 79:49]
  wire [286:0] _GEN_44 = io_req_bits_op == 16'h1 ? {{255'd0}, _aluResult_T_1} : _GEN_42; // @[AecIntAlu.scala 77:49 78:15]
  wire [286:0] _GEN_46 = isCmp | isCmmP ? {{286'd0}, cmpResult} : _GEN_44; // @[AecIntAlu.scala 74:26 75:15]
  wire  aluPredicate = (isCmp | isCmmP) & cmpResult; // @[AecIntAlu.scala 74:26 76:18 72:33]
  wire  _T_23 = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [31:0] aluResult = _GEN_46[31:0]; // @[AecIntAlu.scala 71:30]
  wire  _GEN_53 = _T_23 | busy; // @[AecIntAlu.scala 136:22 141:10 39:21]
  wire  _T_24 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign io_req_ready = ~busy; // @[AecIntAlu.scala 45:19]
  assign io_resp_valid = busy; // @[AecIntAlu.scala 46:17]
  assign io_resp_bits_result = result; // @[AecIntAlu.scala 47:23]
  assign io_resp_bits_predicateResult = predicateResult; // @[AecIntAlu.scala 48:32]
  assign io_resp_bits_error = error; // @[AecIntAlu.scala 50:22]
  always @(posedge clock) begin
    if (reset) begin // @[AecIntAlu.scala 39:21]
      busy <= 1'h0; // @[AecIntAlu.scala 39:21]
    end else if (_T_24) begin // @[AecIntAlu.scala 143:23]
      busy <= 1'h0; // @[AecIntAlu.scala 143:30]
    end else begin
      busy <= _GEN_53;
    end
    if (reset) begin // @[AecIntAlu.scala 40:23]
      result <= 32'h0; // @[AecIntAlu.scala 40:23]
    end else if (_T_23) begin // @[AecIntAlu.scala 136:22]
      result <= aluResult; // @[AecIntAlu.scala 137:12]
    end
    if (reset) begin // @[AecIntAlu.scala 41:32]
      predicateResult <= 1'h0; // @[AecIntAlu.scala 41:32]
    end else if (_T_23) begin // @[AecIntAlu.scala 136:22]
      predicateResult <= aluPredicate; // @[AecIntAlu.scala 138:21]
    end
    if (reset) begin // @[AecIntAlu.scala 43:22]
      error <= 1'h0; // @[AecIntAlu.scala 43:22]
    end else if (_T_23) begin // @[AecIntAlu.scala 136:22]
      if (isCmp | isCmmP) begin // @[AecIntAlu.scala 74:26]
        error <= 1'h0; // @[AecIntAlu.scala 73:29]
      end else if (io_req_bits_op == 16'h1) begin // @[AecIntAlu.scala 77:49]
        error <= 1'h0; // @[AecIntAlu.scala 73:29]
      end else begin
        error <= _GEN_43;
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
  result = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  predicateResult = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  error = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AecIntUnit(
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
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [63:0] _RAND_41;
  reg [63:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [63:0] _RAND_44;
  reg [63:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [63:0] _RAND_47;
  reg [63:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [63:0] _RAND_50;
  reg [63:0] _RAND_51;
  reg [63:0] _RAND_52;
  reg [63:0] _RAND_53;
  reg [63:0] _RAND_54;
  reg [63:0] _RAND_55;
  reg [63:0] _RAND_56;
  reg [63:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [63:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [63:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [63:0] _RAND_63;
  reg [63:0] _RAND_64;
  reg [63:0] _RAND_65;
  reg [63:0] _RAND_66;
  reg [63:0] _RAND_67;
  reg [63:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [63:0] _RAND_70;
  reg [63:0] _RAND_71;
  reg [63:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [63:0] _RAND_74;
  reg [63:0] _RAND_75;
  reg [63:0] _RAND_76;
  reg [63:0] _RAND_77;
  reg [63:0] _RAND_78;
  reg [63:0] _RAND_79;
  reg [63:0] _RAND_80;
  reg [63:0] _RAND_81;
  reg [63:0] _RAND_82;
  reg [63:0] _RAND_83;
  reg [63:0] _RAND_84;
  reg [63:0] _RAND_85;
  reg [63:0] _RAND_86;
  reg [63:0] _RAND_87;
  reg [63:0] _RAND_88;
  reg [63:0] _RAND_89;
  reg [63:0] _RAND_90;
  reg [63:0] _RAND_91;
  reg [63:0] _RAND_92;
  reg [63:0] _RAND_93;
  reg [63:0] _RAND_94;
  reg [63:0] _RAND_95;
  reg [63:0] _RAND_96;
  reg [63:0] _RAND_97;
  reg [63:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [63:0] _RAND_104;
  reg [63:0] _RAND_105;
  reg [63:0] _RAND_106;
  reg [63:0] _RAND_107;
  reg [63:0] _RAND_108;
  reg [63:0] _RAND_109;
  reg [63:0] _RAND_110;
  reg [63:0] _RAND_111;
  reg [63:0] _RAND_112;
  reg [63:0] _RAND_113;
  reg [63:0] _RAND_114;
  reg [63:0] _RAND_115;
  reg [63:0] _RAND_116;
  reg [63:0] _RAND_117;
  reg [63:0] _RAND_118;
  reg [63:0] _RAND_119;
  reg [63:0] _RAND_120;
  reg [63:0] _RAND_121;
  reg [63:0] _RAND_122;
  reg [63:0] _RAND_123;
  reg [63:0] _RAND_124;
  reg [63:0] _RAND_125;
  reg [63:0] _RAND_126;
  reg [63:0] _RAND_127;
  reg [63:0] _RAND_128;
  reg [63:0] _RAND_129;
  reg [63:0] _RAND_130;
  reg [63:0] _RAND_131;
  reg [63:0] _RAND_132;
  reg [63:0] _RAND_133;
  reg [63:0] _RAND_134;
  reg [63:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
`endif // RANDOMIZE_REG_INIT
  wire  pipe_clock; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_reset; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_req_ready; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_req_valid; // @[AecFpWarpUnits.scala 100:20]
  wire [15:0] pipe_io_req_bits_op; // @[AecFpWarpUnits.scala 100:20]
  wire [3:0] pipe_io_req_bits_dtype; // @[AecFpWarpUnits.scala 100:20]
  wire [31:0] pipe_io_req_bits_a; // @[AecFpWarpUnits.scala 100:20]
  wire [31:0] pipe_io_req_bits_b; // @[AecFpWarpUnits.scala 100:20]
  wire [31:0] pipe_io_req_bits_c; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_req_bits_selectPredicate; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_resp_ready; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_resp_valid; // @[AecFpWarpUnits.scala 100:20]
  wire [31:0] pipe_io_resp_bits_result; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_resp_bits_predicateResult; // @[AecFpWarpUnits.scala 100:20]
  wire  pipe_io_resp_bits_error; // @[AecFpWarpUnits.scala 100:20]
  reg [15:0] held_op; // @[AecFpWarpUnits.scala 101:17]
  reg [3:0] held_dtype; // @[AecFpWarpUnits.scala 101:17]
  reg [31:0] held_activeMask; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_0; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_1; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_2; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_3; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_4; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_5; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_6; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_7; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_8; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_9; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_10; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_11; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_12; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_13; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_14; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_15; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_16; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_17; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_18; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_19; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_20; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_21; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_22; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_23; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_24; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_25; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_26; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_27; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_28; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_29; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_30; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_a_31; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_0; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_1; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_2; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_3; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_4; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_5; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_6; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_7; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_8; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_9; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_10; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_11; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_12; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_13; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_14; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_15; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_16; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_17; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_18; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_19; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_20; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_21; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_22; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_23; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_24; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_25; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_26; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_27; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_28; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_29; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_30; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_b_31; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_0; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_1; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_2; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_3; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_4; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_5; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_6; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_7; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_8; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_9; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_10; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_11; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_12; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_13; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_14; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_15; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_16; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_17; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_18; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_19; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_20; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_21; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_22; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_23; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_24; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_25; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_26; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_27; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_28; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_29; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_30; // @[AecFpWarpUnits.scala 101:17]
  reg [63:0] held_c_31; // @[AecFpWarpUnits.scala 101:17]
  reg [7:0] held_dest; // @[AecFpWarpUnits.scala 101:17]
  reg [31:0] held_predicateValues; // @[AecFpWarpUnits.scala 101:17]
  reg [31:0] pending; // @[AecFpWarpUnits.scala 102:24]
  reg  inflight; // @[AecFpWarpUnits.scala 102:59]
  reg  outValid; // @[AecFpWarpUnits.scala 102:92]
  reg [63:0] results_0; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_1; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_2; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_3; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_4; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_5; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_6; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_7; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_8; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_9; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_10; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_11; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_12; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_13; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_14; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_15; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_16; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_17; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_18; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_19; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_20; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_21; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_22; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_23; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_24; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_25; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_26; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_27; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_28; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_29; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_30; // @[AecFpWarpUnits.scala 103:24]
  reg [63:0] results_31; // @[AecFpWarpUnits.scala 103:24]
  reg [31:0] predicates; // @[AecFpWarpUnits.scala 104:27]
  reg [31:0] errors; // @[AecFpWarpUnits.scala 104:60]
  wire [4:0] _lane_T_32 = pending[30] ? 5'h1e : 5'h1f; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_33 = pending[29] ? 5'h1d : _lane_T_32; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_34 = pending[28] ? 5'h1c : _lane_T_33; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_35 = pending[27] ? 5'h1b : _lane_T_34; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_36 = pending[26] ? 5'h1a : _lane_T_35; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_37 = pending[25] ? 5'h19 : _lane_T_36; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_38 = pending[24] ? 5'h18 : _lane_T_37; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_39 = pending[23] ? 5'h17 : _lane_T_38; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_40 = pending[22] ? 5'h16 : _lane_T_39; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_41 = pending[21] ? 5'h15 : _lane_T_40; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_42 = pending[20] ? 5'h14 : _lane_T_41; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_43 = pending[19] ? 5'h13 : _lane_T_42; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_44 = pending[18] ? 5'h12 : _lane_T_43; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_45 = pending[17] ? 5'h11 : _lane_T_44; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_46 = pending[16] ? 5'h10 : _lane_T_45; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_47 = pending[15] ? 5'hf : _lane_T_46; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_48 = pending[14] ? 5'he : _lane_T_47; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_49 = pending[13] ? 5'hd : _lane_T_48; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_50 = pending[12] ? 5'hc : _lane_T_49; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_51 = pending[11] ? 5'hb : _lane_T_50; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_52 = pending[10] ? 5'ha : _lane_T_51; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_53 = pending[9] ? 5'h9 : _lane_T_52; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_54 = pending[8] ? 5'h8 : _lane_T_53; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_55 = pending[7] ? 5'h7 : _lane_T_54; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_56 = pending[6] ? 5'h6 : _lane_T_55; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_57 = pending[5] ? 5'h5 : _lane_T_56; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_58 = pending[4] ? 5'h4 : _lane_T_57; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_59 = pending[3] ? 5'h3 : _lane_T_58; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_60 = pending[2] ? 5'h2 : _lane_T_59; // @[Mux.scala 47:70]
  wire [4:0] _lane_T_61 = pending[1] ? 5'h1 : _lane_T_60; // @[Mux.scala 47:70]
  wire [4:0] lane = pending[0] ? 5'h0 : _lane_T_61; // @[Mux.scala 47:70]
  wire [62:0] laneBit = 63'h1 << lane; // @[AecFpWarpUnits.scala 10:50]
  reg [4:0] inflightLane; // @[AecFpWarpUnits.scala 107:25]
  wire  _io_req_ready_T = |pending; // @[AecFpWarpUnits.scala 108:28]
  wire  _io_req_ready_T_2 = ~inflight; // @[AecFpWarpUnits.scala 108:35]
  wire  _io_req_ready_T_4 = ~outValid; // @[AecFpWarpUnits.scala 108:48]
  wire [63:0] _GEN_1 = 5'h1 == lane ? held_a_1 : held_a_0; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_2 = 5'h2 == lane ? held_a_2 : _GEN_1; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_3 = 5'h3 == lane ? held_a_3 : _GEN_2; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_4 = 5'h4 == lane ? held_a_4 : _GEN_3; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_5 = 5'h5 == lane ? held_a_5 : _GEN_4; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_6 = 5'h6 == lane ? held_a_6 : _GEN_5; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_7 = 5'h7 == lane ? held_a_7 : _GEN_6; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_8 = 5'h8 == lane ? held_a_8 : _GEN_7; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_9 = 5'h9 == lane ? held_a_9 : _GEN_8; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_10 = 5'ha == lane ? held_a_10 : _GEN_9; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_11 = 5'hb == lane ? held_a_11 : _GEN_10; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_12 = 5'hc == lane ? held_a_12 : _GEN_11; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_13 = 5'hd == lane ? held_a_13 : _GEN_12; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_14 = 5'he == lane ? held_a_14 : _GEN_13; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_15 = 5'hf == lane ? held_a_15 : _GEN_14; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_16 = 5'h10 == lane ? held_a_16 : _GEN_15; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_17 = 5'h11 == lane ? held_a_17 : _GEN_16; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_18 = 5'h12 == lane ? held_a_18 : _GEN_17; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_19 = 5'h13 == lane ? held_a_19 : _GEN_18; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_20 = 5'h14 == lane ? held_a_20 : _GEN_19; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_21 = 5'h15 == lane ? held_a_21 : _GEN_20; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_22 = 5'h16 == lane ? held_a_22 : _GEN_21; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_23 = 5'h17 == lane ? held_a_23 : _GEN_22; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_24 = 5'h18 == lane ? held_a_24 : _GEN_23; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_25 = 5'h19 == lane ? held_a_25 : _GEN_24; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_26 = 5'h1a == lane ? held_a_26 : _GEN_25; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_27 = 5'h1b == lane ? held_a_27 : _GEN_26; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_28 = 5'h1c == lane ? held_a_28 : _GEN_27; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_29 = 5'h1d == lane ? held_a_29 : _GEN_28; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_30 = 5'h1e == lane ? held_a_30 : _GEN_29; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_31 = 5'h1f == lane ? held_a_31 : _GEN_30; // @[AecFpWarpUnits.scala 115:{37,37}]
  wire [63:0] _GEN_33 = 5'h1 == lane ? held_b_1 : held_b_0; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_34 = 5'h2 == lane ? held_b_2 : _GEN_33; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_35 = 5'h3 == lane ? held_b_3 : _GEN_34; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_36 = 5'h4 == lane ? held_b_4 : _GEN_35; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_37 = 5'h5 == lane ? held_b_5 : _GEN_36; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_38 = 5'h6 == lane ? held_b_6 : _GEN_37; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_39 = 5'h7 == lane ? held_b_7 : _GEN_38; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_40 = 5'h8 == lane ? held_b_8 : _GEN_39; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_41 = 5'h9 == lane ? held_b_9 : _GEN_40; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_42 = 5'ha == lane ? held_b_10 : _GEN_41; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_43 = 5'hb == lane ? held_b_11 : _GEN_42; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_44 = 5'hc == lane ? held_b_12 : _GEN_43; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_45 = 5'hd == lane ? held_b_13 : _GEN_44; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_46 = 5'he == lane ? held_b_14 : _GEN_45; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_47 = 5'hf == lane ? held_b_15 : _GEN_46; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_48 = 5'h10 == lane ? held_b_16 : _GEN_47; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_49 = 5'h11 == lane ? held_b_17 : _GEN_48; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_50 = 5'h12 == lane ? held_b_18 : _GEN_49; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_51 = 5'h13 == lane ? held_b_19 : _GEN_50; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_52 = 5'h14 == lane ? held_b_20 : _GEN_51; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_53 = 5'h15 == lane ? held_b_21 : _GEN_52; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_54 = 5'h16 == lane ? held_b_22 : _GEN_53; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_55 = 5'h17 == lane ? held_b_23 : _GEN_54; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_56 = 5'h18 == lane ? held_b_24 : _GEN_55; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_57 = 5'h19 == lane ? held_b_25 : _GEN_56; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_58 = 5'h1a == lane ? held_b_26 : _GEN_57; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_59 = 5'h1b == lane ? held_b_27 : _GEN_58; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_60 = 5'h1c == lane ? held_b_28 : _GEN_59; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_61 = 5'h1d == lane ? held_b_29 : _GEN_60; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_62 = 5'h1e == lane ? held_b_30 : _GEN_61; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_63 = 5'h1f == lane ? held_b_31 : _GEN_62; // @[AecFpWarpUnits.scala 115:{80,80}]
  wire [63:0] _GEN_65 = 5'h1 == lane ? held_c_1 : held_c_0; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_66 = 5'h2 == lane ? held_c_2 : _GEN_65; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_67 = 5'h3 == lane ? held_c_3 : _GEN_66; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_68 = 5'h4 == lane ? held_c_4 : _GEN_67; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_69 = 5'h5 == lane ? held_c_5 : _GEN_68; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_70 = 5'h6 == lane ? held_c_6 : _GEN_69; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_71 = 5'h7 == lane ? held_c_7 : _GEN_70; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_72 = 5'h8 == lane ? held_c_8 : _GEN_71; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_73 = 5'h9 == lane ? held_c_9 : _GEN_72; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_74 = 5'ha == lane ? held_c_10 : _GEN_73; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_75 = 5'hb == lane ? held_c_11 : _GEN_74; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_76 = 5'hc == lane ? held_c_12 : _GEN_75; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_77 = 5'hd == lane ? held_c_13 : _GEN_76; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_78 = 5'he == lane ? held_c_14 : _GEN_77; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_79 = 5'hf == lane ? held_c_15 : _GEN_78; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_80 = 5'h10 == lane ? held_c_16 : _GEN_79; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_81 = 5'h11 == lane ? held_c_17 : _GEN_80; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_82 = 5'h12 == lane ? held_c_18 : _GEN_81; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_83 = 5'h13 == lane ? held_c_19 : _GEN_82; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_84 = 5'h14 == lane ? held_c_20 : _GEN_83; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_85 = 5'h15 == lane ? held_c_21 : _GEN_84; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_86 = 5'h16 == lane ? held_c_22 : _GEN_85; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_87 = 5'h17 == lane ? held_c_23 : _GEN_86; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_88 = 5'h18 == lane ? held_c_24 : _GEN_87; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_89 = 5'h19 == lane ? held_c_25 : _GEN_88; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_90 = 5'h1a == lane ? held_c_26 : _GEN_89; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_91 = 5'h1b == lane ? held_c_27 : _GEN_90; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_92 = 5'h1c == lane ? held_c_28 : _GEN_91; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_93 = 5'h1d == lane ? held_c_29 : _GEN_92; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_94 = 5'h1e == lane ? held_c_30 : _GEN_93; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [63:0] _GEN_95 = 5'h1f == lane ? held_c_31 : _GEN_94; // @[AecFpWarpUnits.scala 116:{37,37}]
  wire [31:0] _pipe_io_req_bits_selectPredicate_T = held_predicateValues >> lane; // @[AecFpWarpUnits.scala 117:59]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _GEN_198 = _T ? io_req_bits_activeMask : pending; // @[AecFpWarpUnits.scala 119:22 102:24 119:53]
  wire  _T_1 = pipe_io_req_ready & pipe_io_req_valid; // @[Decoupled.scala 51:35]
  wire [62:0] _pending_T = ~laneBit; // @[AecFpWarpUnits.scala 120:50]
  wire [62:0] _GEN_276 = {{31'd0}, pending}; // @[AecFpWarpUnits.scala 120:48]
  wire [62:0] _pending_T_1 = _GEN_276 & _pending_T; // @[AecFpWarpUnits.scala 120:48]
  wire [62:0] _GEN_199 = _T_1 ? _pending_T_1 : {{31'd0}, _GEN_198}; // @[AecFpWarpUnits.scala 120:{27,37}]
  wire  _GEN_201 = _T_1 | inflight; // @[AecFpWarpUnits.scala 120:27 102:59 120:91]
  wire  _T_2 = pipe_io_resp_ready & pipe_io_resp_valid; // @[Decoupled.scala 51:35]
  wire [62:0] responseBit = 63'h1 << inflightLane; // @[AecFpWarpUnits.scala 10:50]
  wire [63:0] _results_T = {32'h0,pipe_io_resp_bits_result}; // @[Cat.scala 33:92]
  wire [62:0] _GEN_277 = {{31'd0}, predicates}; // @[AecFpWarpUnits.scala 124:73]
  wire [62:0] _predicates_T = _GEN_277 | responseBit; // @[AecFpWarpUnits.scala 124:73]
  wire [62:0] _GEN_234 = pipe_io_resp_bits_predicateResult ? _predicates_T : {{31'd0}, predicates}; // @[AecFpWarpUnits.scala 104:27 124:{46,59}]
  wire [62:0] _GEN_278 = {{31'd0}, errors}; // @[AecFpWarpUnits.scala 125:55]
  wire [62:0] _errors_T = _GEN_278 | responseBit; // @[AecFpWarpUnits.scala 125:55]
  wire [62:0] _GEN_235 = pipe_io_resp_bits_error ? _errors_T : {{31'd0}, errors}; // @[AecFpWarpUnits.scala 125:{36,45} 104:60]
  wire  _GEN_236 = pending == 32'h0 | outValid; // @[AecFpWarpUnits.scala 126:{49,60} 102:92]
  wire [62:0] _GEN_269 = _T_2 ? _GEN_234 : {{31'd0}, predicates}; // @[AecFpWarpUnits.scala 104:27 121:28]
  wire [62:0] _GEN_270 = _T_2 ? _GEN_235 : {{31'd0}, errors}; // @[AecFpWarpUnits.scala 121:28 104:60]
  wire  _T_4 = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [62:0] _GEN_274 = _T_4 ? 63'h0 : _GEN_269; // @[AecFpWarpUnits.scala 128:{23,57}]
  wire [62:0] _GEN_275 = _T_4 ? 63'h0 : _GEN_270; // @[AecFpWarpUnits.scala 128:{23,72}]
  wire [62:0] _GEN_279 = reset ? 63'h0 : _GEN_199; // @[AecFpWarpUnits.scala 102:{24,24}]
  wire [62:0] _GEN_280 = reset ? 63'h0 : _GEN_274; // @[AecFpWarpUnits.scala 104:{27,27}]
  wire [62:0] _GEN_281 = reset ? 63'h0 : _GEN_275; // @[AecFpWarpUnits.scala 104:{60,60}]
  AecIntAlu pipe ( // @[AecFpWarpUnits.scala 100:20]
    .clock(pipe_clock),
    .reset(pipe_reset),
    .io_req_ready(pipe_io_req_ready),
    .io_req_valid(pipe_io_req_valid),
    .io_req_bits_op(pipe_io_req_bits_op),
    .io_req_bits_dtype(pipe_io_req_bits_dtype),
    .io_req_bits_a(pipe_io_req_bits_a),
    .io_req_bits_b(pipe_io_req_bits_b),
    .io_req_bits_c(pipe_io_req_bits_c),
    .io_req_bits_selectPredicate(pipe_io_req_bits_selectPredicate),
    .io_resp_ready(pipe_io_resp_ready),
    .io_resp_valid(pipe_io_resp_valid),
    .io_resp_bits_result(pipe_io_resp_bits_result),
    .io_resp_bits_predicateResult(pipe_io_resp_bits_predicateResult),
    .io_resp_bits_error(pipe_io_resp_bits_error)
  );
  assign io_req_ready = ~(|pending) & ~inflight & ~outValid; // @[AecFpWarpUnits.scala 108:45]
  assign io_resp_valid = outValid; // @[AecFpWarpUnits.scala 109:17]
  assign io_resp_bits_result_0 = results_0; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_1 = results_1; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_2 = results_2; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_3 = results_3; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_4 = results_4; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_5 = results_5; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_6 = results_6; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_7 = results_7; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_8 = results_8; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_9 = results_9; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_10 = results_10; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_11 = results_11; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_12 = results_12; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_13 = results_13; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_14 = results_14; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_15 = results_15; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_16 = results_16; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_17 = results_17; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_18 = results_18; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_19 = results_19; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_20 = results_20; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_21 = results_21; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_22 = results_22; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_23 = results_23; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_24 = results_24; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_25 = results_25; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_26 = results_26; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_27 = results_27; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_28 = results_28; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_29 = results_29; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_30 = results_30; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_result_31 = results_31; // @[AecFpWarpUnits.scala 110:23]
  assign io_resp_bits_predicateMask = predicates; // @[AecFpWarpUnits.scala 110:62]
  assign io_resp_bits_errorMask = errors; // @[AecFpWarpUnits.scala 111:26]
  assign io_resp_bits_exceptionFlags_0 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_1 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_2 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_3 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_4 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_5 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_6 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_7 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_8 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_9 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_10 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_11 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_12 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_13 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_14 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_15 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_16 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_17 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_18 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_19 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_20 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_21 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_22 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_23 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_24 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_25 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_26 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_27 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_28 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_29 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_30 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_exceptionFlags_31 = 5'h0; // @[AecFpWarpUnits.scala 111:65]
  assign io_resp_bits_activeMask = held_activeMask; // @[AecFpWarpUnits.scala 112:27]
  assign io_resp_bits_dest = held_dest; // @[AecFpWarpUnits.scala 112:65]
  assign pipe_clock = clock;
  assign pipe_reset = reset;
  assign pipe_io_req_valid = _io_req_ready_T & _io_req_ready_T_2 & _io_req_ready_T_4; // @[AecFpWarpUnits.scala 113:49]
  assign pipe_io_req_bits_op = held_op; // @[AecFpWarpUnits.scala 114:23]
  assign pipe_io_req_bits_dtype = held_dtype; // @[AecFpWarpUnits.scala 114:58]
  assign pipe_io_req_bits_a = _GEN_31[31:0]; // @[AecFpWarpUnits.scala 115:37]
  assign pipe_io_req_bits_b = _GEN_63[31:0]; // @[AecFpWarpUnits.scala 115:80]
  assign pipe_io_req_bits_c = _GEN_95[31:0]; // @[AecFpWarpUnits.scala 116:37]
  assign pipe_io_req_bits_selectPredicate = _pipe_io_req_bits_selectPredicate_T[0]; // @[AecFpWarpUnits.scala 117:59]
  assign pipe_io_resp_ready = inflight & _io_req_ready_T_4; // @[AecFpWarpUnits.scala 118:34]
  always @(posedge clock) begin
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_op <= io_req_bits_op; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_dtype <= io_req_bits_dtype; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_activeMask <= io_req_bits_activeMask; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_0 <= io_req_bits_a_0; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_1 <= io_req_bits_a_1; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_2 <= io_req_bits_a_2; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_3 <= io_req_bits_a_3; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_4 <= io_req_bits_a_4; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_5 <= io_req_bits_a_5; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_6 <= io_req_bits_a_6; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_7 <= io_req_bits_a_7; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_8 <= io_req_bits_a_8; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_9 <= io_req_bits_a_9; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_10 <= io_req_bits_a_10; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_11 <= io_req_bits_a_11; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_12 <= io_req_bits_a_12; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_13 <= io_req_bits_a_13; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_14 <= io_req_bits_a_14; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_15 <= io_req_bits_a_15; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_16 <= io_req_bits_a_16; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_17 <= io_req_bits_a_17; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_18 <= io_req_bits_a_18; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_19 <= io_req_bits_a_19; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_20 <= io_req_bits_a_20; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_21 <= io_req_bits_a_21; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_22 <= io_req_bits_a_22; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_23 <= io_req_bits_a_23; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_24 <= io_req_bits_a_24; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_25 <= io_req_bits_a_25; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_26 <= io_req_bits_a_26; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_27 <= io_req_bits_a_27; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_28 <= io_req_bits_a_28; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_29 <= io_req_bits_a_29; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_30 <= io_req_bits_a_30; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_a_31 <= io_req_bits_a_31; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_0 <= io_req_bits_b_0; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_1 <= io_req_bits_b_1; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_2 <= io_req_bits_b_2; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_3 <= io_req_bits_b_3; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_4 <= io_req_bits_b_4; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_5 <= io_req_bits_b_5; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_6 <= io_req_bits_b_6; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_7 <= io_req_bits_b_7; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_8 <= io_req_bits_b_8; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_9 <= io_req_bits_b_9; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_10 <= io_req_bits_b_10; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_11 <= io_req_bits_b_11; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_12 <= io_req_bits_b_12; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_13 <= io_req_bits_b_13; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_14 <= io_req_bits_b_14; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_15 <= io_req_bits_b_15; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_16 <= io_req_bits_b_16; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_17 <= io_req_bits_b_17; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_18 <= io_req_bits_b_18; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_19 <= io_req_bits_b_19; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_20 <= io_req_bits_b_20; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_21 <= io_req_bits_b_21; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_22 <= io_req_bits_b_22; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_23 <= io_req_bits_b_23; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_24 <= io_req_bits_b_24; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_25 <= io_req_bits_b_25; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_26 <= io_req_bits_b_26; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_27 <= io_req_bits_b_27; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_28 <= io_req_bits_b_28; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_29 <= io_req_bits_b_29; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_30 <= io_req_bits_b_30; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_b_31 <= io_req_bits_b_31; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_0 <= io_req_bits_c_0; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_1 <= io_req_bits_c_1; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_2 <= io_req_bits_c_2; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_3 <= io_req_bits_c_3; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_4 <= io_req_bits_c_4; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_5 <= io_req_bits_c_5; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_6 <= io_req_bits_c_6; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_7 <= io_req_bits_c_7; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_8 <= io_req_bits_c_8; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_9 <= io_req_bits_c_9; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_10 <= io_req_bits_c_10; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_11 <= io_req_bits_c_11; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_12 <= io_req_bits_c_12; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_13 <= io_req_bits_c_13; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_14 <= io_req_bits_c_14; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_15 <= io_req_bits_c_15; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_16 <= io_req_bits_c_16; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_17 <= io_req_bits_c_17; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_18 <= io_req_bits_c_18; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_19 <= io_req_bits_c_19; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_20 <= io_req_bits_c_20; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_21 <= io_req_bits_c_21; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_22 <= io_req_bits_c_22; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_23 <= io_req_bits_c_23; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_24 <= io_req_bits_c_24; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_25 <= io_req_bits_c_25; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_26 <= io_req_bits_c_26; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_27 <= io_req_bits_c_27; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_28 <= io_req_bits_c_28; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_29 <= io_req_bits_c_29; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_30 <= io_req_bits_c_30; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_c_31 <= io_req_bits_c_31; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_dest <= io_req_bits_dest; // @[AecFpWarpUnits.scala 119:29]
    end
    if (_T) begin // @[AecFpWarpUnits.scala 119:22]
      held_predicateValues <= io_req_bits_predicateValues; // @[AecFpWarpUnits.scala 119:29]
    end
    pending <= _GEN_279[31:0]; // @[AecFpWarpUnits.scala 102:{24,24}]
    if (reset) begin // @[AecFpWarpUnits.scala 102:59]
      inflight <= 1'h0; // @[AecFpWarpUnits.scala 102:59]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      inflight <= 1'h0; // @[AecFpWarpUnits.scala 126:14]
    end else begin
      inflight <= _GEN_201;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 102:92]
      outValid <= 1'h0; // @[AecFpWarpUnits.scala 102:92]
    end else if (_T_4) begin // @[AecFpWarpUnits.scala 128:23]
      outValid <= 1'h0; // @[AecFpWarpUnits.scala 128:34]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      outValid <= _GEN_236;
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_0 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h0 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_0 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_1 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_1 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_2 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h2 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_2 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_3 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h3 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_3 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_4 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h4 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_4 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_5 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h5 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_5 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_6 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h6 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_6 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_7 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h7 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_7 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_8 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h8 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_8 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_9 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h9 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_9 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_10 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'ha == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_10 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_11 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'hb == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_11 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_12 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'hc == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_12 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_13 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'hd == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_13 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_14 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'he == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_14 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_15 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'hf == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_15 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_16 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h10 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_16 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_17 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h11 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_17 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_18 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h12 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_18 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_19 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h13 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_19 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_20 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h14 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_20 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_21 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h15 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_21 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_22 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h16 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_22 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_23 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h17 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_23 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_24 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h18 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_24 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_25 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h19 == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_25 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_26 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1a == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_26 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_27 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1b == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_27 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_28 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1c == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_28 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_29 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1d == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_29 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_30 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1e == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_30 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    if (reset) begin // @[AecFpWarpUnits.scala 103:24]
      results_31 <= 64'h0; // @[AecFpWarpUnits.scala 103:24]
    end else if (_T_2) begin // @[AecFpWarpUnits.scala 121:28]
      if (5'h1f == inflightLane) begin // @[AecFpWarpUnits.scala 123:27]
        results_31 <= _results_T; // @[AecFpWarpUnits.scala 123:27]
      end
    end
    predicates <= _GEN_280[31:0]; // @[AecFpWarpUnits.scala 104:{27,27}]
    errors <= _GEN_281[31:0]; // @[AecFpWarpUnits.scala 104:{60,60}]
    if (_T_1) begin // @[AecFpWarpUnits.scala 120:27]
      if (pending[0]) begin // @[Mux.scala 47:70]
        inflightLane <= 5'h0;
      end else if (pending[1]) begin // @[Mux.scala 47:70]
        inflightLane <= 5'h1;
      end else if (pending[2]) begin // @[Mux.scala 47:70]
        inflightLane <= 5'h2;
      end else begin
        inflightLane <= _lane_T_59;
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
  held_op = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  held_dtype = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  held_activeMask = _RAND_2[31:0];
  _RAND_3 = {2{`RANDOM}};
  held_a_0 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  held_a_1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  held_a_2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  held_a_3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  held_a_4 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  held_a_5 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  held_a_6 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  held_a_7 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  held_a_8 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  held_a_9 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  held_a_10 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  held_a_11 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  held_a_12 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  held_a_13 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  held_a_14 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  held_a_15 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  held_a_16 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  held_a_17 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  held_a_18 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  held_a_19 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  held_a_20 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  held_a_21 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  held_a_22 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  held_a_23 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  held_a_24 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  held_a_25 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  held_a_26 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  held_a_27 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  held_a_28 = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  held_a_29 = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  held_a_30 = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  held_a_31 = _RAND_34[63:0];
  _RAND_35 = {2{`RANDOM}};
  held_b_0 = _RAND_35[63:0];
  _RAND_36 = {2{`RANDOM}};
  held_b_1 = _RAND_36[63:0];
  _RAND_37 = {2{`RANDOM}};
  held_b_2 = _RAND_37[63:0];
  _RAND_38 = {2{`RANDOM}};
  held_b_3 = _RAND_38[63:0];
  _RAND_39 = {2{`RANDOM}};
  held_b_4 = _RAND_39[63:0];
  _RAND_40 = {2{`RANDOM}};
  held_b_5 = _RAND_40[63:0];
  _RAND_41 = {2{`RANDOM}};
  held_b_6 = _RAND_41[63:0];
  _RAND_42 = {2{`RANDOM}};
  held_b_7 = _RAND_42[63:0];
  _RAND_43 = {2{`RANDOM}};
  held_b_8 = _RAND_43[63:0];
  _RAND_44 = {2{`RANDOM}};
  held_b_9 = _RAND_44[63:0];
  _RAND_45 = {2{`RANDOM}};
  held_b_10 = _RAND_45[63:0];
  _RAND_46 = {2{`RANDOM}};
  held_b_11 = _RAND_46[63:0];
  _RAND_47 = {2{`RANDOM}};
  held_b_12 = _RAND_47[63:0];
  _RAND_48 = {2{`RANDOM}};
  held_b_13 = _RAND_48[63:0];
  _RAND_49 = {2{`RANDOM}};
  held_b_14 = _RAND_49[63:0];
  _RAND_50 = {2{`RANDOM}};
  held_b_15 = _RAND_50[63:0];
  _RAND_51 = {2{`RANDOM}};
  held_b_16 = _RAND_51[63:0];
  _RAND_52 = {2{`RANDOM}};
  held_b_17 = _RAND_52[63:0];
  _RAND_53 = {2{`RANDOM}};
  held_b_18 = _RAND_53[63:0];
  _RAND_54 = {2{`RANDOM}};
  held_b_19 = _RAND_54[63:0];
  _RAND_55 = {2{`RANDOM}};
  held_b_20 = _RAND_55[63:0];
  _RAND_56 = {2{`RANDOM}};
  held_b_21 = _RAND_56[63:0];
  _RAND_57 = {2{`RANDOM}};
  held_b_22 = _RAND_57[63:0];
  _RAND_58 = {2{`RANDOM}};
  held_b_23 = _RAND_58[63:0];
  _RAND_59 = {2{`RANDOM}};
  held_b_24 = _RAND_59[63:0];
  _RAND_60 = {2{`RANDOM}};
  held_b_25 = _RAND_60[63:0];
  _RAND_61 = {2{`RANDOM}};
  held_b_26 = _RAND_61[63:0];
  _RAND_62 = {2{`RANDOM}};
  held_b_27 = _RAND_62[63:0];
  _RAND_63 = {2{`RANDOM}};
  held_b_28 = _RAND_63[63:0];
  _RAND_64 = {2{`RANDOM}};
  held_b_29 = _RAND_64[63:0];
  _RAND_65 = {2{`RANDOM}};
  held_b_30 = _RAND_65[63:0];
  _RAND_66 = {2{`RANDOM}};
  held_b_31 = _RAND_66[63:0];
  _RAND_67 = {2{`RANDOM}};
  held_c_0 = _RAND_67[63:0];
  _RAND_68 = {2{`RANDOM}};
  held_c_1 = _RAND_68[63:0];
  _RAND_69 = {2{`RANDOM}};
  held_c_2 = _RAND_69[63:0];
  _RAND_70 = {2{`RANDOM}};
  held_c_3 = _RAND_70[63:0];
  _RAND_71 = {2{`RANDOM}};
  held_c_4 = _RAND_71[63:0];
  _RAND_72 = {2{`RANDOM}};
  held_c_5 = _RAND_72[63:0];
  _RAND_73 = {2{`RANDOM}};
  held_c_6 = _RAND_73[63:0];
  _RAND_74 = {2{`RANDOM}};
  held_c_7 = _RAND_74[63:0];
  _RAND_75 = {2{`RANDOM}};
  held_c_8 = _RAND_75[63:0];
  _RAND_76 = {2{`RANDOM}};
  held_c_9 = _RAND_76[63:0];
  _RAND_77 = {2{`RANDOM}};
  held_c_10 = _RAND_77[63:0];
  _RAND_78 = {2{`RANDOM}};
  held_c_11 = _RAND_78[63:0];
  _RAND_79 = {2{`RANDOM}};
  held_c_12 = _RAND_79[63:0];
  _RAND_80 = {2{`RANDOM}};
  held_c_13 = _RAND_80[63:0];
  _RAND_81 = {2{`RANDOM}};
  held_c_14 = _RAND_81[63:0];
  _RAND_82 = {2{`RANDOM}};
  held_c_15 = _RAND_82[63:0];
  _RAND_83 = {2{`RANDOM}};
  held_c_16 = _RAND_83[63:0];
  _RAND_84 = {2{`RANDOM}};
  held_c_17 = _RAND_84[63:0];
  _RAND_85 = {2{`RANDOM}};
  held_c_18 = _RAND_85[63:0];
  _RAND_86 = {2{`RANDOM}};
  held_c_19 = _RAND_86[63:0];
  _RAND_87 = {2{`RANDOM}};
  held_c_20 = _RAND_87[63:0];
  _RAND_88 = {2{`RANDOM}};
  held_c_21 = _RAND_88[63:0];
  _RAND_89 = {2{`RANDOM}};
  held_c_22 = _RAND_89[63:0];
  _RAND_90 = {2{`RANDOM}};
  held_c_23 = _RAND_90[63:0];
  _RAND_91 = {2{`RANDOM}};
  held_c_24 = _RAND_91[63:0];
  _RAND_92 = {2{`RANDOM}};
  held_c_25 = _RAND_92[63:0];
  _RAND_93 = {2{`RANDOM}};
  held_c_26 = _RAND_93[63:0];
  _RAND_94 = {2{`RANDOM}};
  held_c_27 = _RAND_94[63:0];
  _RAND_95 = {2{`RANDOM}};
  held_c_28 = _RAND_95[63:0];
  _RAND_96 = {2{`RANDOM}};
  held_c_29 = _RAND_96[63:0];
  _RAND_97 = {2{`RANDOM}};
  held_c_30 = _RAND_97[63:0];
  _RAND_98 = {2{`RANDOM}};
  held_c_31 = _RAND_98[63:0];
  _RAND_99 = {1{`RANDOM}};
  held_dest = _RAND_99[7:0];
  _RAND_100 = {1{`RANDOM}};
  held_predicateValues = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  pending = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  inflight = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  outValid = _RAND_103[0:0];
  _RAND_104 = {2{`RANDOM}};
  results_0 = _RAND_104[63:0];
  _RAND_105 = {2{`RANDOM}};
  results_1 = _RAND_105[63:0];
  _RAND_106 = {2{`RANDOM}};
  results_2 = _RAND_106[63:0];
  _RAND_107 = {2{`RANDOM}};
  results_3 = _RAND_107[63:0];
  _RAND_108 = {2{`RANDOM}};
  results_4 = _RAND_108[63:0];
  _RAND_109 = {2{`RANDOM}};
  results_5 = _RAND_109[63:0];
  _RAND_110 = {2{`RANDOM}};
  results_6 = _RAND_110[63:0];
  _RAND_111 = {2{`RANDOM}};
  results_7 = _RAND_111[63:0];
  _RAND_112 = {2{`RANDOM}};
  results_8 = _RAND_112[63:0];
  _RAND_113 = {2{`RANDOM}};
  results_9 = _RAND_113[63:0];
  _RAND_114 = {2{`RANDOM}};
  results_10 = _RAND_114[63:0];
  _RAND_115 = {2{`RANDOM}};
  results_11 = _RAND_115[63:0];
  _RAND_116 = {2{`RANDOM}};
  results_12 = _RAND_116[63:0];
  _RAND_117 = {2{`RANDOM}};
  results_13 = _RAND_117[63:0];
  _RAND_118 = {2{`RANDOM}};
  results_14 = _RAND_118[63:0];
  _RAND_119 = {2{`RANDOM}};
  results_15 = _RAND_119[63:0];
  _RAND_120 = {2{`RANDOM}};
  results_16 = _RAND_120[63:0];
  _RAND_121 = {2{`RANDOM}};
  results_17 = _RAND_121[63:0];
  _RAND_122 = {2{`RANDOM}};
  results_18 = _RAND_122[63:0];
  _RAND_123 = {2{`RANDOM}};
  results_19 = _RAND_123[63:0];
  _RAND_124 = {2{`RANDOM}};
  results_20 = _RAND_124[63:0];
  _RAND_125 = {2{`RANDOM}};
  results_21 = _RAND_125[63:0];
  _RAND_126 = {2{`RANDOM}};
  results_22 = _RAND_126[63:0];
  _RAND_127 = {2{`RANDOM}};
  results_23 = _RAND_127[63:0];
  _RAND_128 = {2{`RANDOM}};
  results_24 = _RAND_128[63:0];
  _RAND_129 = {2{`RANDOM}};
  results_25 = _RAND_129[63:0];
  _RAND_130 = {2{`RANDOM}};
  results_26 = _RAND_130[63:0];
  _RAND_131 = {2{`RANDOM}};
  results_27 = _RAND_131[63:0];
  _RAND_132 = {2{`RANDOM}};
  results_28 = _RAND_132[63:0];
  _RAND_133 = {2{`RANDOM}};
  results_29 = _RAND_133[63:0];
  _RAND_134 = {2{`RANDOM}};
  results_30 = _RAND_134[63:0];
  _RAND_135 = {2{`RANDOM}};
  results_31 = _RAND_135[63:0];
  _RAND_136 = {1{`RANDOM}};
  predicates = _RAND_136[31:0];
  _RAND_137 = {1{`RANDOM}};
  errors = _RAND_137[31:0];
  _RAND_138 = {1{`RANDOM}};
  inflightLane = _RAND_138[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
