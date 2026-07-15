module BoothEncoderF64F32F16(
  input  [52:0]  io_in_a,
  input  [52:0]  io_in_b,
  output [106:0] io_out_pp_0,
  output [106:0] io_out_pp_1,
  output [106:0] io_out_pp_2,
  output [106:0] io_out_pp_3,
  output [106:0] io_out_pp_4,
  output [106:0] io_out_pp_5,
  output [106:0] io_out_pp_6,
  output [106:0] io_out_pp_7,
  output [106:0] io_out_pp_8,
  output [106:0] io_out_pp_9,
  output [106:0] io_out_pp_10,
  output [106:0] io_out_pp_11,
  output [106:0] io_out_pp_12
);
  wire [54:0] in_b_cat = {30'h0,io_in_b[23:0],1'h0}; // @[Cat.scala 33:92]
  wire [2:0] booth_seq_0 = in_b_cat[2:0]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_0 = 3'h6 == booth_seq_0 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_1 = 3'h5 == booth_seq_0 ? 2'h2 : _GEN_0; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_2 = 3'h4 == booth_seq_0 ? 2'h1 : _GEN_1; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_3 = 3'h3 == booth_seq_0 ? 3'h4 : {{1'd0}, _GEN_2}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_4 = 3'h2 == booth_seq_0 ? 4'h8 : {{1'd0}, _GEN_3}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_0 = 3'h1 == booth_seq_0 ? 4'h8 : _GEN_4; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_1 = in_b_cat[4:2]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_6 = 3'h6 == booth_seq_1 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_7 = 3'h5 == booth_seq_1 ? 2'h2 : _GEN_6; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_8 = 3'h4 == booth_seq_1 ? 2'h1 : _GEN_7; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_9 = 3'h3 == booth_seq_1 ? 3'h4 : {{1'd0}, _GEN_8}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_10 = 3'h2 == booth_seq_1 ? 4'h8 : {{1'd0}, _GEN_9}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_1 = 3'h1 == booth_seq_1 ? 4'h8 : _GEN_10; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_2 = in_b_cat[6:4]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_12 = 3'h6 == booth_seq_2 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_13 = 3'h5 == booth_seq_2 ? 2'h2 : _GEN_12; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_14 = 3'h4 == booth_seq_2 ? 2'h1 : _GEN_13; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_15 = 3'h3 == booth_seq_2 ? 3'h4 : {{1'd0}, _GEN_14}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_16 = 3'h2 == booth_seq_2 ? 4'h8 : {{1'd0}, _GEN_15}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_2 = 3'h1 == booth_seq_2 ? 4'h8 : _GEN_16; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_3 = in_b_cat[8:6]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_18 = 3'h6 == booth_seq_3 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_19 = 3'h5 == booth_seq_3 ? 2'h2 : _GEN_18; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_20 = 3'h4 == booth_seq_3 ? 2'h1 : _GEN_19; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_21 = 3'h3 == booth_seq_3 ? 3'h4 : {{1'd0}, _GEN_20}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_22 = 3'h2 == booth_seq_3 ? 4'h8 : {{1'd0}, _GEN_21}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_3 = 3'h1 == booth_seq_3 ? 4'h8 : _GEN_22; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_4 = in_b_cat[10:8]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_24 = 3'h6 == booth_seq_4 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_25 = 3'h5 == booth_seq_4 ? 2'h2 : _GEN_24; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_26 = 3'h4 == booth_seq_4 ? 2'h1 : _GEN_25; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_27 = 3'h3 == booth_seq_4 ? 3'h4 : {{1'd0}, _GEN_26}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_28 = 3'h2 == booth_seq_4 ? 4'h8 : {{1'd0}, _GEN_27}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_4 = 3'h1 == booth_seq_4 ? 4'h8 : _GEN_28; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_5 = in_b_cat[12:10]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_30 = 3'h6 == booth_seq_5 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_31 = 3'h5 == booth_seq_5 ? 2'h2 : _GEN_30; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_32 = 3'h4 == booth_seq_5 ? 2'h1 : _GEN_31; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_33 = 3'h3 == booth_seq_5 ? 3'h4 : {{1'd0}, _GEN_32}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_34 = 3'h2 == booth_seq_5 ? 4'h8 : {{1'd0}, _GEN_33}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_5 = 3'h1 == booth_seq_5 ? 4'h8 : _GEN_34; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_6 = in_b_cat[14:12]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_36 = 3'h6 == booth_seq_6 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_37 = 3'h5 == booth_seq_6 ? 2'h2 : _GEN_36; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_38 = 3'h4 == booth_seq_6 ? 2'h1 : _GEN_37; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_39 = 3'h3 == booth_seq_6 ? 3'h4 : {{1'd0}, _GEN_38}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_40 = 3'h2 == booth_seq_6 ? 4'h8 : {{1'd0}, _GEN_39}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_6 = 3'h1 == booth_seq_6 ? 4'h8 : _GEN_40; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_7 = in_b_cat[16:14]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_42 = 3'h6 == booth_seq_7 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_43 = 3'h5 == booth_seq_7 ? 2'h2 : _GEN_42; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_44 = 3'h4 == booth_seq_7 ? 2'h1 : _GEN_43; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_45 = 3'h3 == booth_seq_7 ? 3'h4 : {{1'd0}, _GEN_44}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_46 = 3'h2 == booth_seq_7 ? 4'h8 : {{1'd0}, _GEN_45}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_7 = 3'h1 == booth_seq_7 ? 4'h8 : _GEN_46; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_8 = in_b_cat[18:16]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_48 = 3'h6 == booth_seq_8 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_49 = 3'h5 == booth_seq_8 ? 2'h2 : _GEN_48; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_50 = 3'h4 == booth_seq_8 ? 2'h1 : _GEN_49; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_51 = 3'h3 == booth_seq_8 ? 3'h4 : {{1'd0}, _GEN_50}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_52 = 3'h2 == booth_seq_8 ? 4'h8 : {{1'd0}, _GEN_51}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_8 = 3'h1 == booth_seq_8 ? 4'h8 : _GEN_52; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_9 = in_b_cat[20:18]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_54 = 3'h6 == booth_seq_9 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_55 = 3'h5 == booth_seq_9 ? 2'h2 : _GEN_54; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_56 = 3'h4 == booth_seq_9 ? 2'h1 : _GEN_55; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_57 = 3'h3 == booth_seq_9 ? 3'h4 : {{1'd0}, _GEN_56}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_58 = 3'h2 == booth_seq_9 ? 4'h8 : {{1'd0}, _GEN_57}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_9 = 3'h1 == booth_seq_9 ? 4'h8 : _GEN_58; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_10 = in_b_cat[22:20]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_60 = 3'h6 == booth_seq_10 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_61 = 3'h5 == booth_seq_10 ? 2'h2 : _GEN_60; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_62 = 3'h4 == booth_seq_10 ? 2'h1 : _GEN_61; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_63 = 3'h3 == booth_seq_10 ? 3'h4 : {{1'd0}, _GEN_62}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_64 = 3'h2 == booth_seq_10 ? 4'h8 : {{1'd0}, _GEN_63}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_10 = 3'h1 == booth_seq_10 ? 4'h8 : _GEN_64; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_11 = in_b_cat[24:22]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_66 = 3'h6 == booth_seq_11 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_67 = 3'h5 == booth_seq_11 ? 2'h2 : _GEN_66; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_68 = 3'h4 == booth_seq_11 ? 2'h1 : _GEN_67; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_69 = 3'h3 == booth_seq_11 ? 3'h4 : {{1'd0}, _GEN_68}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_70 = 3'h2 == booth_seq_11 ? 4'h8 : {{1'd0}, _GEN_69}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_11 = 3'h1 == booth_seq_11 ? 4'h8 : _GEN_70; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_12 = in_b_cat[26:24]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_72 = 3'h6 == booth_seq_12 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_73 = 3'h5 == booth_seq_12 ? 2'h2 : _GEN_72; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_74 = 3'h4 == booth_seq_12 ? 2'h1 : _GEN_73; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_75 = 3'h3 == booth_seq_12 ? 3'h4 : {{1'd0}, _GEN_74}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_76 = 3'h2 == booth_seq_12 ? 4'h8 : {{1'd0}, _GEN_75}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_12 = 3'h1 == booth_seq_12 ? 4'h8 : _GEN_76; // @[FloatFMA.scala 909:25 910:42]
  wire  sign_seq_0 = booth_4bit_onehot_0[1] | booth_4bit_onehot_0[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_0_T_2 = booth_4bit_onehot_0[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_0_T_4 = {1'h0,io_in_a[23:0]}; // @[Cat.scala 33:92]
  wire [24:0] _pp_seq_f32_0_T_5 = _pp_seq_f32_0_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_0_T_8 = booth_4bit_onehot_0[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_0_T_10 = {io_in_a[23:0],1'h0}; // @[Cat.scala 33:92]
  wire [24:0] _pp_seq_f32_0_T_11 = _pp_seq_f32_0_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_0_T_12 = _pp_seq_f32_0_T_5 | _pp_seq_f32_0_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_0_T_15 = booth_4bit_onehot_0[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [23:0] _pp_seq_f32_0_T_17 = ~io_in_a[23:0]; // @[FloatFMA.scala 936:56]
  wire [24:0] _pp_seq_f32_0_T_18 = {1'h1,_pp_seq_f32_0_T_17}; // @[Cat.scala 33:92]
  wire [24:0] _pp_seq_f32_0_T_19 = _pp_seq_f32_0_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_0_T_20 = _pp_seq_f32_0_T_12 | _pp_seq_f32_0_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_0_T_23 = booth_4bit_onehot_0[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_0_T_26 = {_pp_seq_f32_0_T_17,1'h1}; // @[Cat.scala 33:92]
  wire [24:0] _pp_seq_f32_0_T_27 = _pp_seq_f32_0_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_0 = _pp_seq_f32_0_T_20 | _pp_seq_f32_0_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_1 = booth_4bit_onehot_1[1] | booth_4bit_onehot_1[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_1_T_2 = booth_4bit_onehot_1[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_1_T_5 = _pp_seq_f32_1_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_1_T_8 = booth_4bit_onehot_1[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_1_T_11 = _pp_seq_f32_1_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_1_T_12 = _pp_seq_f32_1_T_5 | _pp_seq_f32_1_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_1_T_15 = booth_4bit_onehot_1[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_1_T_19 = _pp_seq_f32_1_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_1_T_20 = _pp_seq_f32_1_T_12 | _pp_seq_f32_1_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_1_T_23 = booth_4bit_onehot_1[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_1_T_27 = _pp_seq_f32_1_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_1 = _pp_seq_f32_1_T_20 | _pp_seq_f32_1_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_2 = booth_4bit_onehot_2[1] | booth_4bit_onehot_2[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_2_T_2 = booth_4bit_onehot_2[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_2_T_5 = _pp_seq_f32_2_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_2_T_8 = booth_4bit_onehot_2[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_2_T_11 = _pp_seq_f32_2_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_2_T_12 = _pp_seq_f32_2_T_5 | _pp_seq_f32_2_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_2_T_15 = booth_4bit_onehot_2[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_2_T_19 = _pp_seq_f32_2_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_2_T_20 = _pp_seq_f32_2_T_12 | _pp_seq_f32_2_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_2_T_23 = booth_4bit_onehot_2[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_2_T_27 = _pp_seq_f32_2_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_2 = _pp_seq_f32_2_T_20 | _pp_seq_f32_2_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_3 = booth_4bit_onehot_3[1] | booth_4bit_onehot_3[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_3_T_2 = booth_4bit_onehot_3[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_3_T_5 = _pp_seq_f32_3_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_3_T_8 = booth_4bit_onehot_3[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_3_T_11 = _pp_seq_f32_3_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_3_T_12 = _pp_seq_f32_3_T_5 | _pp_seq_f32_3_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_3_T_15 = booth_4bit_onehot_3[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_3_T_19 = _pp_seq_f32_3_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_3_T_20 = _pp_seq_f32_3_T_12 | _pp_seq_f32_3_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_3_T_23 = booth_4bit_onehot_3[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_3_T_27 = _pp_seq_f32_3_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_3 = _pp_seq_f32_3_T_20 | _pp_seq_f32_3_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_4 = booth_4bit_onehot_4[1] | booth_4bit_onehot_4[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_4_T_2 = booth_4bit_onehot_4[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_4_T_5 = _pp_seq_f32_4_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_4_T_8 = booth_4bit_onehot_4[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_4_T_11 = _pp_seq_f32_4_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_4_T_12 = _pp_seq_f32_4_T_5 | _pp_seq_f32_4_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_4_T_15 = booth_4bit_onehot_4[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_4_T_19 = _pp_seq_f32_4_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_4_T_20 = _pp_seq_f32_4_T_12 | _pp_seq_f32_4_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_4_T_23 = booth_4bit_onehot_4[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_4_T_27 = _pp_seq_f32_4_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_4 = _pp_seq_f32_4_T_20 | _pp_seq_f32_4_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_5 = booth_4bit_onehot_5[1] | booth_4bit_onehot_5[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_5_T_2 = booth_4bit_onehot_5[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_5_T_5 = _pp_seq_f32_5_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_5_T_8 = booth_4bit_onehot_5[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_5_T_11 = _pp_seq_f32_5_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_5_T_12 = _pp_seq_f32_5_T_5 | _pp_seq_f32_5_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_5_T_15 = booth_4bit_onehot_5[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_5_T_19 = _pp_seq_f32_5_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_5_T_20 = _pp_seq_f32_5_T_12 | _pp_seq_f32_5_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_5_T_23 = booth_4bit_onehot_5[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_5_T_27 = _pp_seq_f32_5_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_5 = _pp_seq_f32_5_T_20 | _pp_seq_f32_5_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_6 = booth_4bit_onehot_6[1] | booth_4bit_onehot_6[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_6_T_2 = booth_4bit_onehot_6[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_6_T_5 = _pp_seq_f32_6_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_6_T_8 = booth_4bit_onehot_6[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_6_T_11 = _pp_seq_f32_6_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_6_T_12 = _pp_seq_f32_6_T_5 | _pp_seq_f32_6_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_6_T_15 = booth_4bit_onehot_6[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_6_T_19 = _pp_seq_f32_6_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_6_T_20 = _pp_seq_f32_6_T_12 | _pp_seq_f32_6_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_6_T_23 = booth_4bit_onehot_6[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_6_T_27 = _pp_seq_f32_6_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_6 = _pp_seq_f32_6_T_20 | _pp_seq_f32_6_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_7 = booth_4bit_onehot_7[1] | booth_4bit_onehot_7[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_7_T_2 = booth_4bit_onehot_7[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_7_T_5 = _pp_seq_f32_7_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_7_T_8 = booth_4bit_onehot_7[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_7_T_11 = _pp_seq_f32_7_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_7_T_12 = _pp_seq_f32_7_T_5 | _pp_seq_f32_7_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_7_T_15 = booth_4bit_onehot_7[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_7_T_19 = _pp_seq_f32_7_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_7_T_20 = _pp_seq_f32_7_T_12 | _pp_seq_f32_7_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_7_T_23 = booth_4bit_onehot_7[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_7_T_27 = _pp_seq_f32_7_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_7 = _pp_seq_f32_7_T_20 | _pp_seq_f32_7_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_8 = booth_4bit_onehot_8[1] | booth_4bit_onehot_8[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_8_T_2 = booth_4bit_onehot_8[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_8_T_5 = _pp_seq_f32_8_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_8_T_8 = booth_4bit_onehot_8[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_8_T_11 = _pp_seq_f32_8_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_8_T_12 = _pp_seq_f32_8_T_5 | _pp_seq_f32_8_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_8_T_15 = booth_4bit_onehot_8[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_8_T_19 = _pp_seq_f32_8_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_8_T_20 = _pp_seq_f32_8_T_12 | _pp_seq_f32_8_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_8_T_23 = booth_4bit_onehot_8[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_8_T_27 = _pp_seq_f32_8_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_8 = _pp_seq_f32_8_T_20 | _pp_seq_f32_8_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_9 = booth_4bit_onehot_9[1] | booth_4bit_onehot_9[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_9_T_2 = booth_4bit_onehot_9[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_9_T_5 = _pp_seq_f32_9_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_9_T_8 = booth_4bit_onehot_9[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_9_T_11 = _pp_seq_f32_9_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_9_T_12 = _pp_seq_f32_9_T_5 | _pp_seq_f32_9_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_9_T_15 = booth_4bit_onehot_9[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_9_T_19 = _pp_seq_f32_9_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_9_T_20 = _pp_seq_f32_9_T_12 | _pp_seq_f32_9_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_9_T_23 = booth_4bit_onehot_9[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_9_T_27 = _pp_seq_f32_9_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_9 = _pp_seq_f32_9_T_20 | _pp_seq_f32_9_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_10 = booth_4bit_onehot_10[1] | booth_4bit_onehot_10[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_10_T_2 = booth_4bit_onehot_10[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_10_T_5 = _pp_seq_f32_10_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_10_T_8 = booth_4bit_onehot_10[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_10_T_11 = _pp_seq_f32_10_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_10_T_12 = _pp_seq_f32_10_T_5 | _pp_seq_f32_10_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_10_T_15 = booth_4bit_onehot_10[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_10_T_19 = _pp_seq_f32_10_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_10_T_20 = _pp_seq_f32_10_T_12 | _pp_seq_f32_10_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_10_T_23 = booth_4bit_onehot_10[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_10_T_27 = _pp_seq_f32_10_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_10 = _pp_seq_f32_10_T_20 | _pp_seq_f32_10_T_27; // @[FloatFMA.scala 936:72]
  wire  sign_seq_11 = booth_4bit_onehot_11[1] | booth_4bit_onehot_11[0]; // @[FloatFMA.scala 924:44]
  wire [24:0] _pp_seq_f32_11_T_2 = booth_4bit_onehot_11[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_11_T_5 = _pp_seq_f32_11_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_11_T_8 = booth_4bit_onehot_11[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_11_T_11 = _pp_seq_f32_11_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_11_T_12 = _pp_seq_f32_11_T_5 | _pp_seq_f32_11_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_11_T_15 = booth_4bit_onehot_11[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_11_T_19 = _pp_seq_f32_11_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_11_T_20 = _pp_seq_f32_11_T_12 | _pp_seq_f32_11_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_11_T_23 = booth_4bit_onehot_11[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_11_T_27 = _pp_seq_f32_11_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_11 = _pp_seq_f32_11_T_20 | _pp_seq_f32_11_T_27; // @[FloatFMA.scala 936:72]
  wire [24:0] _pp_seq_f32_12_T_2 = booth_4bit_onehot_12[3] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_12_T_5 = _pp_seq_f32_12_T_2 & _pp_seq_f32_0_T_4; // @[FloatFMA.scala 934:44]
  wire [24:0] _pp_seq_f32_12_T_8 = booth_4bit_onehot_12[2] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_12_T_11 = _pp_seq_f32_12_T_8 & _pp_seq_f32_0_T_10; // @[FloatFMA.scala 935:46]
  wire [24:0] _pp_seq_f32_12_T_12 = _pp_seq_f32_12_T_5 | _pp_seq_f32_12_T_11; // @[FloatFMA.scala 934:70]
  wire [24:0] _pp_seq_f32_12_T_15 = booth_4bit_onehot_12[1] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_12_T_19 = _pp_seq_f32_12_T_15 & _pp_seq_f32_0_T_18; // @[FloatFMA.scala 936:46]
  wire [24:0] _pp_seq_f32_12_T_20 = _pp_seq_f32_12_T_12 | _pp_seq_f32_12_T_19; // @[FloatFMA.scala 935:72]
  wire [24:0] _pp_seq_f32_12_T_23 = booth_4bit_onehot_12[0] ? 25'h1ffffff : 25'h0; // @[Bitwise.scala 77:12]
  wire [24:0] _pp_seq_f32_12_T_27 = _pp_seq_f32_12_T_23 & _pp_seq_f32_0_T_26; // @[FloatFMA.scala 937:46]
  wire [24:0] pp_seq_f32_12 = _pp_seq_f32_12_T_20 | _pp_seq_f32_12_T_27; // @[FloatFMA.scala 936:72]
  wire  _addend_seq_f64_0_T = ~sign_seq_0; // @[FloatFMA.scala 967:62]
  wire  _addend_seq_f64_1_T = ~sign_seq_1; // @[FloatFMA.scala 968:71]
  wire  _addend_seq_f64_2_T = ~sign_seq_2; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_3_T = ~sign_seq_3; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_4_T = ~sign_seq_4; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_5_T = ~sign_seq_5; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_6_T = ~sign_seq_6; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_7_T = ~sign_seq_7; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_8_T = ~sign_seq_8; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_9_T = ~sign_seq_9; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_10_T = ~sign_seq_10; // @[FloatFMA.scala 979:71]
  wire  _addend_seq_f64_11_T = ~sign_seq_11; // @[FloatFMA.scala 979:71]
  wire [47:0] _addend_seq_f32_0_T_1 = {20'h0,_addend_seq_f64_0_T,sign_seq_0,sign_seq_0,pp_seq_f32_0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_0 = {{1'd0}, _addend_seq_f32_0_T_1}; // @[FloatFMA.scala 958:28 987:35]
  wire [47:0] _addend_seq_f32_1_T_1 = {20'h1,_addend_seq_f64_1_T,pp_seq_f32_1,1'h0,sign_seq_0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_1 = {{1'd0}, _addend_seq_f32_1_T_1}; // @[FloatFMA.scala 958:28 988:35]
  wire [47:0] _addend_seq_f32_2_T_1 = {18'h1,_addend_seq_f64_2_T,pp_seq_f32_2,1'h0,sign_seq_1,2'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_2 = {{1'd0}, _addend_seq_f32_2_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_3_T_1 = {16'h1,_addend_seq_f64_3_T,pp_seq_f32_3,1'h0,sign_seq_2,4'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_3 = {{1'd0}, _addend_seq_f32_3_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_4_T_1 = {14'h1,_addend_seq_f64_4_T,pp_seq_f32_4,1'h0,sign_seq_3,6'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_4 = {{1'd0}, _addend_seq_f32_4_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_5_T_1 = {12'h1,_addend_seq_f64_5_T,pp_seq_f32_5,1'h0,sign_seq_4,8'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_5 = {{1'd0}, _addend_seq_f32_5_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_6_T_1 = {10'h1,_addend_seq_f64_6_T,pp_seq_f32_6,1'h0,sign_seq_5,10'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_6 = {{1'd0}, _addend_seq_f32_6_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_7_T_1 = {8'h1,_addend_seq_f64_7_T,pp_seq_f32_7,1'h0,sign_seq_6,12'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_7 = {{1'd0}, _addend_seq_f32_7_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_8_T_1 = {6'h1,_addend_seq_f64_8_T,pp_seq_f32_8,1'h0,sign_seq_7,14'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_8 = {{1'd0}, _addend_seq_f32_8_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_9_T_1 = {4'h1,_addend_seq_f64_9_T,pp_seq_f32_9,1'h0,sign_seq_8,16'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_9 = {{1'd0}, _addend_seq_f32_9_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [47:0] _addend_seq_f32_10_T_1 = {2'h1,_addend_seq_f64_10_T,pp_seq_f32_10,1'h0,sign_seq_9,18'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_10 = {{1'd0}, _addend_seq_f32_10_T_1}; // @[FloatFMA.scala 958:28 991:35]
  wire [48:0] addend_seq_f32_11 = {1'h1,_addend_seq_f64_11_T,pp_seq_f32_11,1'h0,sign_seq_10,20'h0}; // @[Cat.scala 33:92]
  wire [47:0] _addend_seq_f32_12_T_1 = {pp_seq_f32_12[23:0],1'h0,sign_seq_11,22'h0}; // @[Cat.scala 33:92]
  wire [48:0] addend_seq_f32_12 = {{1'd0}, _addend_seq_f32_12_T_1}; // @[FloatFMA.scala 958:28 990:36]
  assign io_out_pp_0 = {58'h0,addend_seq_f32_0}; // @[Cat.scala 33:92]
  assign io_out_pp_1 = {58'h0,addend_seq_f32_1}; // @[Cat.scala 33:92]
  assign io_out_pp_2 = {58'h0,addend_seq_f32_2}; // @[Cat.scala 33:92]
  assign io_out_pp_3 = {58'h0,addend_seq_f32_3}; // @[Cat.scala 33:92]
  assign io_out_pp_4 = {58'h0,addend_seq_f32_4}; // @[Cat.scala 33:92]
  assign io_out_pp_5 = {58'h0,addend_seq_f32_5}; // @[Cat.scala 33:92]
  assign io_out_pp_6 = {58'h0,addend_seq_f32_6}; // @[Cat.scala 33:92]
  assign io_out_pp_7 = {58'h0,addend_seq_f32_7}; // @[Cat.scala 33:92]
  assign io_out_pp_8 = {58'h0,addend_seq_f32_8}; // @[Cat.scala 33:92]
  assign io_out_pp_9 = {58'h0,addend_seq_f32_9}; // @[Cat.scala 33:92]
  assign io_out_pp_10 = {58'h0,addend_seq_f32_10}; // @[Cat.scala 33:92]
  assign io_out_pp_11 = {58'h0,addend_seq_f32_11}; // @[Cat.scala 33:92]
  assign io_out_pp_12 = {58'h0,addend_seq_f32_12}; // @[Cat.scala 33:92]
endmodule
module CSA3to2(
  input  [106:0] io_in_a,
  input  [106:0] io_in_b,
  input  [106:0] io_in_c,
  output [106:0] io_out_sum,
  output [106:0] io_out_car
);
  wire [106:0] _io_out_sum_T = io_in_a ^ io_in_b; // @[FloatFMA.scala 1094:25]
  wire [106:0] _io_out_car_T = io_in_a & io_in_b; // @[FloatFMA.scala 1095:33]
  wire [106:0] _io_out_car_T_1 = io_in_a & io_in_c; // @[FloatFMA.scala 1095:55]
  wire [106:0] _io_out_car_T_2 = _io_out_car_T | _io_out_car_T_1; // @[FloatFMA.scala 1095:44]
  wire [106:0] _io_out_car_T_3 = io_in_b & io_in_c; // @[FloatFMA.scala 1095:77]
  wire [106:0] _io_out_car_T_4 = _io_out_car_T_2 | _io_out_car_T_3; // @[FloatFMA.scala 1095:66]
  assign io_out_sum = _io_out_sum_T ^ io_in_c; // @[FloatFMA.scala 1094:35]
  assign io_out_car = {_io_out_car_T_4[105:0],1'h0}; // @[Cat.scala 33:92]
endmodule
module CSA4to2(
  input  [106:0] io_in_a,
  input  [106:0] io_in_b,
  input  [106:0] io_in_c,
  input  [106:0] io_in_d,
  output [106:0] io_out_sum,
  output [106:0] io_out_car
);
  wire  _cout_vec_0_T_2 = io_in_a[0] ^ io_in_b[0]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_0 = io_in_a[0] ^ io_in_b[0] ? io_in_c[0] : io_in_a[0]; // @[FloatFMA.scala 1115:23]
  wire  sum_vec_0 = _cout_vec_0_T_2 ^ io_in_c[0] ^ io_in_d[0]; // @[FloatFMA.scala 1117:60]
  wire  carry_vec_0 = sum_vec_0 ? 1'h0 : io_in_d[0]; // @[FloatFMA.scala 1118:26]
  wire  _cout_vec_1_T_2 = io_in_a[1] ^ io_in_b[1]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_1 = io_in_a[1] ^ io_in_b[1] ? io_in_c[1] : io_in_a[1]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_1_T_6 = _cout_vec_1_T_2 ^ io_in_c[1] ^ io_in_d[1]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_1 = _cout_vec_1_T_2 ^ io_in_c[1] ^ io_in_d[1] ^ cout_vec_0; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_1 = _sum_vec_1_T_6 ? cout_vec_0 : io_in_d[1]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_2_T_2 = io_in_a[2] ^ io_in_b[2]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_2 = io_in_a[2] ^ io_in_b[2] ? io_in_c[2] : io_in_a[2]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_2_T_6 = _cout_vec_2_T_2 ^ io_in_c[2] ^ io_in_d[2]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_2 = _cout_vec_2_T_2 ^ io_in_c[2] ^ io_in_d[2] ^ cout_vec_1; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_2 = _sum_vec_2_T_6 ? cout_vec_1 : io_in_d[2]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_3_T_2 = io_in_a[3] ^ io_in_b[3]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_3 = io_in_a[3] ^ io_in_b[3] ? io_in_c[3] : io_in_a[3]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_3_T_6 = _cout_vec_3_T_2 ^ io_in_c[3] ^ io_in_d[3]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_3 = _cout_vec_3_T_2 ^ io_in_c[3] ^ io_in_d[3] ^ cout_vec_2; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_3 = _sum_vec_3_T_6 ? cout_vec_2 : io_in_d[3]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_4_T_2 = io_in_a[4] ^ io_in_b[4]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_4 = io_in_a[4] ^ io_in_b[4] ? io_in_c[4] : io_in_a[4]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_4_T_6 = _cout_vec_4_T_2 ^ io_in_c[4] ^ io_in_d[4]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_4 = _cout_vec_4_T_2 ^ io_in_c[4] ^ io_in_d[4] ^ cout_vec_3; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_4 = _sum_vec_4_T_6 ? cout_vec_3 : io_in_d[4]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_5_T_2 = io_in_a[5] ^ io_in_b[5]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_5 = io_in_a[5] ^ io_in_b[5] ? io_in_c[5] : io_in_a[5]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_5_T_6 = _cout_vec_5_T_2 ^ io_in_c[5] ^ io_in_d[5]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_5 = _cout_vec_5_T_2 ^ io_in_c[5] ^ io_in_d[5] ^ cout_vec_4; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_5 = _sum_vec_5_T_6 ? cout_vec_4 : io_in_d[5]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_6_T_2 = io_in_a[6] ^ io_in_b[6]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_6 = io_in_a[6] ^ io_in_b[6] ? io_in_c[6] : io_in_a[6]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_6_T_6 = _cout_vec_6_T_2 ^ io_in_c[6] ^ io_in_d[6]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_6 = _cout_vec_6_T_2 ^ io_in_c[6] ^ io_in_d[6] ^ cout_vec_5; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_6 = _sum_vec_6_T_6 ? cout_vec_5 : io_in_d[6]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_7_T_2 = io_in_a[7] ^ io_in_b[7]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_7 = io_in_a[7] ^ io_in_b[7] ? io_in_c[7] : io_in_a[7]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_7_T_6 = _cout_vec_7_T_2 ^ io_in_c[7] ^ io_in_d[7]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_7 = _cout_vec_7_T_2 ^ io_in_c[7] ^ io_in_d[7] ^ cout_vec_6; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_7 = _sum_vec_7_T_6 ? cout_vec_6 : io_in_d[7]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_8_T_2 = io_in_a[8] ^ io_in_b[8]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_8 = io_in_a[8] ^ io_in_b[8] ? io_in_c[8] : io_in_a[8]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_8_T_6 = _cout_vec_8_T_2 ^ io_in_c[8] ^ io_in_d[8]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_8 = _cout_vec_8_T_2 ^ io_in_c[8] ^ io_in_d[8] ^ cout_vec_7; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_8 = _sum_vec_8_T_6 ? cout_vec_7 : io_in_d[8]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_9_T_2 = io_in_a[9] ^ io_in_b[9]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_9 = io_in_a[9] ^ io_in_b[9] ? io_in_c[9] : io_in_a[9]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_9_T_6 = _cout_vec_9_T_2 ^ io_in_c[9] ^ io_in_d[9]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_9 = _cout_vec_9_T_2 ^ io_in_c[9] ^ io_in_d[9] ^ cout_vec_8; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_9 = _sum_vec_9_T_6 ? cout_vec_8 : io_in_d[9]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_10_T_2 = io_in_a[10] ^ io_in_b[10]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_10 = io_in_a[10] ^ io_in_b[10] ? io_in_c[10] : io_in_a[10]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_10_T_6 = _cout_vec_10_T_2 ^ io_in_c[10] ^ io_in_d[10]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_10 = _cout_vec_10_T_2 ^ io_in_c[10] ^ io_in_d[10] ^ cout_vec_9; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_10 = _sum_vec_10_T_6 ? cout_vec_9 : io_in_d[10]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_11_T_2 = io_in_a[11] ^ io_in_b[11]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_11 = io_in_a[11] ^ io_in_b[11] ? io_in_c[11] : io_in_a[11]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_11_T_6 = _cout_vec_11_T_2 ^ io_in_c[11] ^ io_in_d[11]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_11 = _cout_vec_11_T_2 ^ io_in_c[11] ^ io_in_d[11] ^ cout_vec_10; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_11 = _sum_vec_11_T_6 ? cout_vec_10 : io_in_d[11]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_12_T_2 = io_in_a[12] ^ io_in_b[12]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_12 = io_in_a[12] ^ io_in_b[12] ? io_in_c[12] : io_in_a[12]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_12_T_6 = _cout_vec_12_T_2 ^ io_in_c[12] ^ io_in_d[12]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_12 = _cout_vec_12_T_2 ^ io_in_c[12] ^ io_in_d[12] ^ cout_vec_11; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_12 = _sum_vec_12_T_6 ? cout_vec_11 : io_in_d[12]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_13_T_2 = io_in_a[13] ^ io_in_b[13]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_13 = io_in_a[13] ^ io_in_b[13] ? io_in_c[13] : io_in_a[13]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_13_T_6 = _cout_vec_13_T_2 ^ io_in_c[13] ^ io_in_d[13]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_13 = _cout_vec_13_T_2 ^ io_in_c[13] ^ io_in_d[13] ^ cout_vec_12; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_13 = _sum_vec_13_T_6 ? cout_vec_12 : io_in_d[13]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_14_T_2 = io_in_a[14] ^ io_in_b[14]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_14 = io_in_a[14] ^ io_in_b[14] ? io_in_c[14] : io_in_a[14]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_14_T_6 = _cout_vec_14_T_2 ^ io_in_c[14] ^ io_in_d[14]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_14 = _cout_vec_14_T_2 ^ io_in_c[14] ^ io_in_d[14] ^ cout_vec_13; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_14 = _sum_vec_14_T_6 ? cout_vec_13 : io_in_d[14]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_15_T_2 = io_in_a[15] ^ io_in_b[15]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_15 = io_in_a[15] ^ io_in_b[15] ? io_in_c[15] : io_in_a[15]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_15_T_6 = _cout_vec_15_T_2 ^ io_in_c[15] ^ io_in_d[15]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_15 = _cout_vec_15_T_2 ^ io_in_c[15] ^ io_in_d[15] ^ cout_vec_14; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_15 = _sum_vec_15_T_6 ? cout_vec_14 : io_in_d[15]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_16_T_2 = io_in_a[16] ^ io_in_b[16]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_16 = io_in_a[16] ^ io_in_b[16] ? io_in_c[16] : io_in_a[16]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_16_T_6 = _cout_vec_16_T_2 ^ io_in_c[16] ^ io_in_d[16]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_16 = _cout_vec_16_T_2 ^ io_in_c[16] ^ io_in_d[16] ^ cout_vec_15; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_16 = _sum_vec_16_T_6 ? cout_vec_15 : io_in_d[16]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_17_T_2 = io_in_a[17] ^ io_in_b[17]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_17 = io_in_a[17] ^ io_in_b[17] ? io_in_c[17] : io_in_a[17]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_17_T_6 = _cout_vec_17_T_2 ^ io_in_c[17] ^ io_in_d[17]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_17 = _cout_vec_17_T_2 ^ io_in_c[17] ^ io_in_d[17] ^ cout_vec_16; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_17 = _sum_vec_17_T_6 ? cout_vec_16 : io_in_d[17]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_18_T_2 = io_in_a[18] ^ io_in_b[18]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_18 = io_in_a[18] ^ io_in_b[18] ? io_in_c[18] : io_in_a[18]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_18_T_6 = _cout_vec_18_T_2 ^ io_in_c[18] ^ io_in_d[18]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_18 = _cout_vec_18_T_2 ^ io_in_c[18] ^ io_in_d[18] ^ cout_vec_17; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_18 = _sum_vec_18_T_6 ? cout_vec_17 : io_in_d[18]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_19_T_2 = io_in_a[19] ^ io_in_b[19]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_19 = io_in_a[19] ^ io_in_b[19] ? io_in_c[19] : io_in_a[19]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_19_T_6 = _cout_vec_19_T_2 ^ io_in_c[19] ^ io_in_d[19]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_19 = _cout_vec_19_T_2 ^ io_in_c[19] ^ io_in_d[19] ^ cout_vec_18; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_19 = _sum_vec_19_T_6 ? cout_vec_18 : io_in_d[19]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_20_T_2 = io_in_a[20] ^ io_in_b[20]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_20 = io_in_a[20] ^ io_in_b[20] ? io_in_c[20] : io_in_a[20]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_20_T_6 = _cout_vec_20_T_2 ^ io_in_c[20] ^ io_in_d[20]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_20 = _cout_vec_20_T_2 ^ io_in_c[20] ^ io_in_d[20] ^ cout_vec_19; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_20 = _sum_vec_20_T_6 ? cout_vec_19 : io_in_d[20]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_21_T_2 = io_in_a[21] ^ io_in_b[21]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_21 = io_in_a[21] ^ io_in_b[21] ? io_in_c[21] : io_in_a[21]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_21_T_6 = _cout_vec_21_T_2 ^ io_in_c[21] ^ io_in_d[21]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_21 = _cout_vec_21_T_2 ^ io_in_c[21] ^ io_in_d[21] ^ cout_vec_20; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_21 = _sum_vec_21_T_6 ? cout_vec_20 : io_in_d[21]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_22_T_2 = io_in_a[22] ^ io_in_b[22]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_22 = io_in_a[22] ^ io_in_b[22] ? io_in_c[22] : io_in_a[22]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_22_T_6 = _cout_vec_22_T_2 ^ io_in_c[22] ^ io_in_d[22]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_22 = _cout_vec_22_T_2 ^ io_in_c[22] ^ io_in_d[22] ^ cout_vec_21; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_22 = _sum_vec_22_T_6 ? cout_vec_21 : io_in_d[22]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_23_T_2 = io_in_a[23] ^ io_in_b[23]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_23 = io_in_a[23] ^ io_in_b[23] ? io_in_c[23] : io_in_a[23]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_23_T_6 = _cout_vec_23_T_2 ^ io_in_c[23] ^ io_in_d[23]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_23 = _cout_vec_23_T_2 ^ io_in_c[23] ^ io_in_d[23] ^ cout_vec_22; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_23 = _sum_vec_23_T_6 ? cout_vec_22 : io_in_d[23]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_24_T_2 = io_in_a[24] ^ io_in_b[24]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_24 = io_in_a[24] ^ io_in_b[24] ? io_in_c[24] : io_in_a[24]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_24_T_6 = _cout_vec_24_T_2 ^ io_in_c[24] ^ io_in_d[24]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_24 = _cout_vec_24_T_2 ^ io_in_c[24] ^ io_in_d[24] ^ cout_vec_23; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_24 = _sum_vec_24_T_6 ? cout_vec_23 : io_in_d[24]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_25_T_2 = io_in_a[25] ^ io_in_b[25]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_25 = io_in_a[25] ^ io_in_b[25] ? io_in_c[25] : io_in_a[25]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_25_T_6 = _cout_vec_25_T_2 ^ io_in_c[25] ^ io_in_d[25]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_25 = _cout_vec_25_T_2 ^ io_in_c[25] ^ io_in_d[25] ^ cout_vec_24; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_25 = _sum_vec_25_T_6 ? cout_vec_24 : io_in_d[25]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_26_T_2 = io_in_a[26] ^ io_in_b[26]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_26 = io_in_a[26] ^ io_in_b[26] ? io_in_c[26] : io_in_a[26]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_26_T_6 = _cout_vec_26_T_2 ^ io_in_c[26] ^ io_in_d[26]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_26 = _cout_vec_26_T_2 ^ io_in_c[26] ^ io_in_d[26] ^ cout_vec_25; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_26 = _sum_vec_26_T_6 ? cout_vec_25 : io_in_d[26]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_27_T_2 = io_in_a[27] ^ io_in_b[27]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_27 = io_in_a[27] ^ io_in_b[27] ? io_in_c[27] : io_in_a[27]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_27_T_6 = _cout_vec_27_T_2 ^ io_in_c[27] ^ io_in_d[27]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_27 = _cout_vec_27_T_2 ^ io_in_c[27] ^ io_in_d[27] ^ cout_vec_26; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_27 = _sum_vec_27_T_6 ? cout_vec_26 : io_in_d[27]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_28_T_2 = io_in_a[28] ^ io_in_b[28]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_28 = io_in_a[28] ^ io_in_b[28] ? io_in_c[28] : io_in_a[28]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_28_T_6 = _cout_vec_28_T_2 ^ io_in_c[28] ^ io_in_d[28]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_28 = _cout_vec_28_T_2 ^ io_in_c[28] ^ io_in_d[28] ^ cout_vec_27; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_28 = _sum_vec_28_T_6 ? cout_vec_27 : io_in_d[28]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_29_T_2 = io_in_a[29] ^ io_in_b[29]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_29 = io_in_a[29] ^ io_in_b[29] ? io_in_c[29] : io_in_a[29]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_29_T_6 = _cout_vec_29_T_2 ^ io_in_c[29] ^ io_in_d[29]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_29 = _cout_vec_29_T_2 ^ io_in_c[29] ^ io_in_d[29] ^ cout_vec_28; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_29 = _sum_vec_29_T_6 ? cout_vec_28 : io_in_d[29]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_30_T_2 = io_in_a[30] ^ io_in_b[30]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_30 = io_in_a[30] ^ io_in_b[30] ? io_in_c[30] : io_in_a[30]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_30_T_6 = _cout_vec_30_T_2 ^ io_in_c[30] ^ io_in_d[30]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_30 = _cout_vec_30_T_2 ^ io_in_c[30] ^ io_in_d[30] ^ cout_vec_29; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_30 = _sum_vec_30_T_6 ? cout_vec_29 : io_in_d[30]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_31_T_2 = io_in_a[31] ^ io_in_b[31]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_31 = io_in_a[31] ^ io_in_b[31] ? io_in_c[31] : io_in_a[31]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_31_T_6 = _cout_vec_31_T_2 ^ io_in_c[31] ^ io_in_d[31]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_31 = _cout_vec_31_T_2 ^ io_in_c[31] ^ io_in_d[31] ^ cout_vec_30; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_31 = _sum_vec_31_T_6 ? cout_vec_30 : io_in_d[31]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_32_T_2 = io_in_a[32] ^ io_in_b[32]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_32 = io_in_a[32] ^ io_in_b[32] ? io_in_c[32] : io_in_a[32]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_32_T_6 = _cout_vec_32_T_2 ^ io_in_c[32] ^ io_in_d[32]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_32 = _cout_vec_32_T_2 ^ io_in_c[32] ^ io_in_d[32] ^ cout_vec_31; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_32 = _sum_vec_32_T_6 ? cout_vec_31 : io_in_d[32]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_33_T_2 = io_in_a[33] ^ io_in_b[33]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_33 = io_in_a[33] ^ io_in_b[33] ? io_in_c[33] : io_in_a[33]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_33_T_6 = _cout_vec_33_T_2 ^ io_in_c[33] ^ io_in_d[33]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_33 = _cout_vec_33_T_2 ^ io_in_c[33] ^ io_in_d[33] ^ cout_vec_32; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_33 = _sum_vec_33_T_6 ? cout_vec_32 : io_in_d[33]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_34_T_2 = io_in_a[34] ^ io_in_b[34]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_34 = io_in_a[34] ^ io_in_b[34] ? io_in_c[34] : io_in_a[34]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_34_T_6 = _cout_vec_34_T_2 ^ io_in_c[34] ^ io_in_d[34]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_34 = _cout_vec_34_T_2 ^ io_in_c[34] ^ io_in_d[34] ^ cout_vec_33; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_34 = _sum_vec_34_T_6 ? cout_vec_33 : io_in_d[34]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_35_T_2 = io_in_a[35] ^ io_in_b[35]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_35 = io_in_a[35] ^ io_in_b[35] ? io_in_c[35] : io_in_a[35]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_35_T_6 = _cout_vec_35_T_2 ^ io_in_c[35] ^ io_in_d[35]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_35 = _cout_vec_35_T_2 ^ io_in_c[35] ^ io_in_d[35] ^ cout_vec_34; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_35 = _sum_vec_35_T_6 ? cout_vec_34 : io_in_d[35]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_36_T_2 = io_in_a[36] ^ io_in_b[36]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_36 = io_in_a[36] ^ io_in_b[36] ? io_in_c[36] : io_in_a[36]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_36_T_6 = _cout_vec_36_T_2 ^ io_in_c[36] ^ io_in_d[36]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_36 = _cout_vec_36_T_2 ^ io_in_c[36] ^ io_in_d[36] ^ cout_vec_35; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_36 = _sum_vec_36_T_6 ? cout_vec_35 : io_in_d[36]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_37_T_2 = io_in_a[37] ^ io_in_b[37]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_37 = io_in_a[37] ^ io_in_b[37] ? io_in_c[37] : io_in_a[37]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_37_T_6 = _cout_vec_37_T_2 ^ io_in_c[37] ^ io_in_d[37]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_37 = _cout_vec_37_T_2 ^ io_in_c[37] ^ io_in_d[37] ^ cout_vec_36; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_37 = _sum_vec_37_T_6 ? cout_vec_36 : io_in_d[37]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_38_T_2 = io_in_a[38] ^ io_in_b[38]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_38 = io_in_a[38] ^ io_in_b[38] ? io_in_c[38] : io_in_a[38]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_38_T_6 = _cout_vec_38_T_2 ^ io_in_c[38] ^ io_in_d[38]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_38 = _cout_vec_38_T_2 ^ io_in_c[38] ^ io_in_d[38] ^ cout_vec_37; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_38 = _sum_vec_38_T_6 ? cout_vec_37 : io_in_d[38]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_39_T_2 = io_in_a[39] ^ io_in_b[39]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_39 = io_in_a[39] ^ io_in_b[39] ? io_in_c[39] : io_in_a[39]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_39_T_6 = _cout_vec_39_T_2 ^ io_in_c[39] ^ io_in_d[39]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_39 = _cout_vec_39_T_2 ^ io_in_c[39] ^ io_in_d[39] ^ cout_vec_38; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_39 = _sum_vec_39_T_6 ? cout_vec_38 : io_in_d[39]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_40_T_2 = io_in_a[40] ^ io_in_b[40]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_40 = io_in_a[40] ^ io_in_b[40] ? io_in_c[40] : io_in_a[40]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_40_T_6 = _cout_vec_40_T_2 ^ io_in_c[40] ^ io_in_d[40]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_40 = _cout_vec_40_T_2 ^ io_in_c[40] ^ io_in_d[40] ^ cout_vec_39; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_40 = _sum_vec_40_T_6 ? cout_vec_39 : io_in_d[40]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_41_T_2 = io_in_a[41] ^ io_in_b[41]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_41 = io_in_a[41] ^ io_in_b[41] ? io_in_c[41] : io_in_a[41]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_41_T_6 = _cout_vec_41_T_2 ^ io_in_c[41] ^ io_in_d[41]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_41 = _cout_vec_41_T_2 ^ io_in_c[41] ^ io_in_d[41] ^ cout_vec_40; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_41 = _sum_vec_41_T_6 ? cout_vec_40 : io_in_d[41]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_42_T_2 = io_in_a[42] ^ io_in_b[42]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_42 = io_in_a[42] ^ io_in_b[42] ? io_in_c[42] : io_in_a[42]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_42_T_6 = _cout_vec_42_T_2 ^ io_in_c[42] ^ io_in_d[42]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_42 = _cout_vec_42_T_2 ^ io_in_c[42] ^ io_in_d[42] ^ cout_vec_41; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_42 = _sum_vec_42_T_6 ? cout_vec_41 : io_in_d[42]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_43_T_2 = io_in_a[43] ^ io_in_b[43]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_43 = io_in_a[43] ^ io_in_b[43] ? io_in_c[43] : io_in_a[43]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_43_T_6 = _cout_vec_43_T_2 ^ io_in_c[43] ^ io_in_d[43]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_43 = _cout_vec_43_T_2 ^ io_in_c[43] ^ io_in_d[43] ^ cout_vec_42; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_43 = _sum_vec_43_T_6 ? cout_vec_42 : io_in_d[43]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_44_T_2 = io_in_a[44] ^ io_in_b[44]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_44 = io_in_a[44] ^ io_in_b[44] ? io_in_c[44] : io_in_a[44]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_44_T_6 = _cout_vec_44_T_2 ^ io_in_c[44] ^ io_in_d[44]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_44 = _cout_vec_44_T_2 ^ io_in_c[44] ^ io_in_d[44] ^ cout_vec_43; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_44 = _sum_vec_44_T_6 ? cout_vec_43 : io_in_d[44]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_45_T_2 = io_in_a[45] ^ io_in_b[45]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_45 = io_in_a[45] ^ io_in_b[45] ? io_in_c[45] : io_in_a[45]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_45_T_6 = _cout_vec_45_T_2 ^ io_in_c[45] ^ io_in_d[45]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_45 = _cout_vec_45_T_2 ^ io_in_c[45] ^ io_in_d[45] ^ cout_vec_44; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_45 = _sum_vec_45_T_6 ? cout_vec_44 : io_in_d[45]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_46_T_2 = io_in_a[46] ^ io_in_b[46]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_46 = io_in_a[46] ^ io_in_b[46] ? io_in_c[46] : io_in_a[46]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_46_T_6 = _cout_vec_46_T_2 ^ io_in_c[46] ^ io_in_d[46]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_46 = _cout_vec_46_T_2 ^ io_in_c[46] ^ io_in_d[46] ^ cout_vec_45; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_46 = _sum_vec_46_T_6 ? cout_vec_45 : io_in_d[46]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_47_T_2 = io_in_a[47] ^ io_in_b[47]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_47 = io_in_a[47] ^ io_in_b[47] ? io_in_c[47] : io_in_a[47]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_47_T_6 = _cout_vec_47_T_2 ^ io_in_c[47] ^ io_in_d[47]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_47 = _cout_vec_47_T_2 ^ io_in_c[47] ^ io_in_d[47] ^ cout_vec_46; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_47 = _sum_vec_47_T_6 ? cout_vec_46 : io_in_d[47]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_48_T_2 = io_in_a[48] ^ io_in_b[48]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_48 = io_in_a[48] ^ io_in_b[48] ? io_in_c[48] : io_in_a[48]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_48_T_6 = _cout_vec_48_T_2 ^ io_in_c[48] ^ io_in_d[48]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_48 = _cout_vec_48_T_2 ^ io_in_c[48] ^ io_in_d[48] ^ cout_vec_47; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_48 = _sum_vec_48_T_6 ? cout_vec_47 : io_in_d[48]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_49_T_2 = io_in_a[49] ^ io_in_b[49]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_49 = io_in_a[49] ^ io_in_b[49] ? io_in_c[49] : io_in_a[49]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_49_T_6 = _cout_vec_49_T_2 ^ io_in_c[49] ^ io_in_d[49]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_49 = _cout_vec_49_T_2 ^ io_in_c[49] ^ io_in_d[49] ^ cout_vec_48; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_49 = _sum_vec_49_T_6 ? cout_vec_48 : io_in_d[49]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_50_T_2 = io_in_a[50] ^ io_in_b[50]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_50 = io_in_a[50] ^ io_in_b[50] ? io_in_c[50] : io_in_a[50]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_50_T_6 = _cout_vec_50_T_2 ^ io_in_c[50] ^ io_in_d[50]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_50 = _cout_vec_50_T_2 ^ io_in_c[50] ^ io_in_d[50] ^ cout_vec_49; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_50 = _sum_vec_50_T_6 ? cout_vec_49 : io_in_d[50]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_51_T_2 = io_in_a[51] ^ io_in_b[51]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_51 = io_in_a[51] ^ io_in_b[51] ? io_in_c[51] : io_in_a[51]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_51_T_6 = _cout_vec_51_T_2 ^ io_in_c[51] ^ io_in_d[51]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_51 = _cout_vec_51_T_2 ^ io_in_c[51] ^ io_in_d[51] ^ cout_vec_50; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_51 = _sum_vec_51_T_6 ? cout_vec_50 : io_in_d[51]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_52_T_2 = io_in_a[52] ^ io_in_b[52]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_52 = io_in_a[52] ^ io_in_b[52] ? io_in_c[52] : io_in_a[52]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_52_T_6 = _cout_vec_52_T_2 ^ io_in_c[52] ^ io_in_d[52]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_52 = _cout_vec_52_T_2 ^ io_in_c[52] ^ io_in_d[52] ^ cout_vec_51; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_52 = _sum_vec_52_T_6 ? cout_vec_51 : io_in_d[52]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_53_T_2 = io_in_a[53] ^ io_in_b[53]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_53 = io_in_a[53] ^ io_in_b[53] ? io_in_c[53] : io_in_a[53]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_53_T_6 = _cout_vec_53_T_2 ^ io_in_c[53] ^ io_in_d[53]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_53 = _cout_vec_53_T_2 ^ io_in_c[53] ^ io_in_d[53] ^ cout_vec_52; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_53 = _sum_vec_53_T_6 ? cout_vec_52 : io_in_d[53]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_54_T_2 = io_in_a[54] ^ io_in_b[54]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_54 = io_in_a[54] ^ io_in_b[54] ? io_in_c[54] : io_in_a[54]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_54_T_6 = _cout_vec_54_T_2 ^ io_in_c[54] ^ io_in_d[54]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_54 = _cout_vec_54_T_2 ^ io_in_c[54] ^ io_in_d[54] ^ cout_vec_53; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_54 = _sum_vec_54_T_6 ? cout_vec_53 : io_in_d[54]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_55_T_2 = io_in_a[55] ^ io_in_b[55]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_55 = io_in_a[55] ^ io_in_b[55] ? io_in_c[55] : io_in_a[55]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_55_T_6 = _cout_vec_55_T_2 ^ io_in_c[55] ^ io_in_d[55]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_55 = _cout_vec_55_T_2 ^ io_in_c[55] ^ io_in_d[55] ^ cout_vec_54; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_55 = _sum_vec_55_T_6 ? cout_vec_54 : io_in_d[55]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_56_T_2 = io_in_a[56] ^ io_in_b[56]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_56 = io_in_a[56] ^ io_in_b[56] ? io_in_c[56] : io_in_a[56]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_56_T_6 = _cout_vec_56_T_2 ^ io_in_c[56] ^ io_in_d[56]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_56 = _cout_vec_56_T_2 ^ io_in_c[56] ^ io_in_d[56] ^ cout_vec_55; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_56 = _sum_vec_56_T_6 ? cout_vec_55 : io_in_d[56]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_57_T_2 = io_in_a[57] ^ io_in_b[57]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_57 = io_in_a[57] ^ io_in_b[57] ? io_in_c[57] : io_in_a[57]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_57_T_6 = _cout_vec_57_T_2 ^ io_in_c[57] ^ io_in_d[57]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_57 = _cout_vec_57_T_2 ^ io_in_c[57] ^ io_in_d[57] ^ cout_vec_56; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_57 = _sum_vec_57_T_6 ? cout_vec_56 : io_in_d[57]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_58_T_2 = io_in_a[58] ^ io_in_b[58]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_58 = io_in_a[58] ^ io_in_b[58] ? io_in_c[58] : io_in_a[58]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_58_T_6 = _cout_vec_58_T_2 ^ io_in_c[58] ^ io_in_d[58]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_58 = _cout_vec_58_T_2 ^ io_in_c[58] ^ io_in_d[58] ^ cout_vec_57; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_58 = _sum_vec_58_T_6 ? cout_vec_57 : io_in_d[58]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_59_T_2 = io_in_a[59] ^ io_in_b[59]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_59 = io_in_a[59] ^ io_in_b[59] ? io_in_c[59] : io_in_a[59]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_59_T_6 = _cout_vec_59_T_2 ^ io_in_c[59] ^ io_in_d[59]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_59 = _cout_vec_59_T_2 ^ io_in_c[59] ^ io_in_d[59] ^ cout_vec_58; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_59 = _sum_vec_59_T_6 ? cout_vec_58 : io_in_d[59]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_60_T_2 = io_in_a[60] ^ io_in_b[60]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_60 = io_in_a[60] ^ io_in_b[60] ? io_in_c[60] : io_in_a[60]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_60_T_6 = _cout_vec_60_T_2 ^ io_in_c[60] ^ io_in_d[60]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_60 = _cout_vec_60_T_2 ^ io_in_c[60] ^ io_in_d[60] ^ cout_vec_59; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_60 = _sum_vec_60_T_6 ? cout_vec_59 : io_in_d[60]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_61_T_2 = io_in_a[61] ^ io_in_b[61]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_61 = io_in_a[61] ^ io_in_b[61] ? io_in_c[61] : io_in_a[61]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_61_T_6 = _cout_vec_61_T_2 ^ io_in_c[61] ^ io_in_d[61]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_61 = _cout_vec_61_T_2 ^ io_in_c[61] ^ io_in_d[61] ^ cout_vec_60; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_61 = _sum_vec_61_T_6 ? cout_vec_60 : io_in_d[61]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_62_T_2 = io_in_a[62] ^ io_in_b[62]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_62 = io_in_a[62] ^ io_in_b[62] ? io_in_c[62] : io_in_a[62]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_62_T_6 = _cout_vec_62_T_2 ^ io_in_c[62] ^ io_in_d[62]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_62 = _cout_vec_62_T_2 ^ io_in_c[62] ^ io_in_d[62] ^ cout_vec_61; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_62 = _sum_vec_62_T_6 ? cout_vec_61 : io_in_d[62]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_63_T_2 = io_in_a[63] ^ io_in_b[63]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_63 = io_in_a[63] ^ io_in_b[63] ? io_in_c[63] : io_in_a[63]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_63_T_6 = _cout_vec_63_T_2 ^ io_in_c[63] ^ io_in_d[63]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_63 = _cout_vec_63_T_2 ^ io_in_c[63] ^ io_in_d[63] ^ cout_vec_62; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_63 = _sum_vec_63_T_6 ? cout_vec_62 : io_in_d[63]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_64_T_2 = io_in_a[64] ^ io_in_b[64]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_64 = io_in_a[64] ^ io_in_b[64] ? io_in_c[64] : io_in_a[64]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_64_T_6 = _cout_vec_64_T_2 ^ io_in_c[64] ^ io_in_d[64]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_64 = _cout_vec_64_T_2 ^ io_in_c[64] ^ io_in_d[64] ^ cout_vec_63; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_64 = _sum_vec_64_T_6 ? cout_vec_63 : io_in_d[64]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_65_T_2 = io_in_a[65] ^ io_in_b[65]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_65 = io_in_a[65] ^ io_in_b[65] ? io_in_c[65] : io_in_a[65]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_65_T_6 = _cout_vec_65_T_2 ^ io_in_c[65] ^ io_in_d[65]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_65 = _cout_vec_65_T_2 ^ io_in_c[65] ^ io_in_d[65] ^ cout_vec_64; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_65 = _sum_vec_65_T_6 ? cout_vec_64 : io_in_d[65]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_66_T_2 = io_in_a[66] ^ io_in_b[66]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_66 = io_in_a[66] ^ io_in_b[66] ? io_in_c[66] : io_in_a[66]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_66_T_6 = _cout_vec_66_T_2 ^ io_in_c[66] ^ io_in_d[66]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_66 = _cout_vec_66_T_2 ^ io_in_c[66] ^ io_in_d[66] ^ cout_vec_65; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_66 = _sum_vec_66_T_6 ? cout_vec_65 : io_in_d[66]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_67_T_2 = io_in_a[67] ^ io_in_b[67]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_67 = io_in_a[67] ^ io_in_b[67] ? io_in_c[67] : io_in_a[67]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_67_T_6 = _cout_vec_67_T_2 ^ io_in_c[67] ^ io_in_d[67]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_67 = _cout_vec_67_T_2 ^ io_in_c[67] ^ io_in_d[67] ^ cout_vec_66; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_67 = _sum_vec_67_T_6 ? cout_vec_66 : io_in_d[67]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_68_T_2 = io_in_a[68] ^ io_in_b[68]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_68 = io_in_a[68] ^ io_in_b[68] ? io_in_c[68] : io_in_a[68]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_68_T_6 = _cout_vec_68_T_2 ^ io_in_c[68] ^ io_in_d[68]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_68 = _cout_vec_68_T_2 ^ io_in_c[68] ^ io_in_d[68] ^ cout_vec_67; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_68 = _sum_vec_68_T_6 ? cout_vec_67 : io_in_d[68]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_69_T_2 = io_in_a[69] ^ io_in_b[69]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_69 = io_in_a[69] ^ io_in_b[69] ? io_in_c[69] : io_in_a[69]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_69_T_6 = _cout_vec_69_T_2 ^ io_in_c[69] ^ io_in_d[69]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_69 = _cout_vec_69_T_2 ^ io_in_c[69] ^ io_in_d[69] ^ cout_vec_68; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_69 = _sum_vec_69_T_6 ? cout_vec_68 : io_in_d[69]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_70_T_2 = io_in_a[70] ^ io_in_b[70]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_70 = io_in_a[70] ^ io_in_b[70] ? io_in_c[70] : io_in_a[70]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_70_T_6 = _cout_vec_70_T_2 ^ io_in_c[70] ^ io_in_d[70]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_70 = _cout_vec_70_T_2 ^ io_in_c[70] ^ io_in_d[70] ^ cout_vec_69; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_70 = _sum_vec_70_T_6 ? cout_vec_69 : io_in_d[70]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_71_T_2 = io_in_a[71] ^ io_in_b[71]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_71 = io_in_a[71] ^ io_in_b[71] ? io_in_c[71] : io_in_a[71]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_71_T_6 = _cout_vec_71_T_2 ^ io_in_c[71] ^ io_in_d[71]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_71 = _cout_vec_71_T_2 ^ io_in_c[71] ^ io_in_d[71] ^ cout_vec_70; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_71 = _sum_vec_71_T_6 ? cout_vec_70 : io_in_d[71]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_72_T_2 = io_in_a[72] ^ io_in_b[72]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_72 = io_in_a[72] ^ io_in_b[72] ? io_in_c[72] : io_in_a[72]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_72_T_6 = _cout_vec_72_T_2 ^ io_in_c[72] ^ io_in_d[72]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_72 = _cout_vec_72_T_2 ^ io_in_c[72] ^ io_in_d[72] ^ cout_vec_71; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_72 = _sum_vec_72_T_6 ? cout_vec_71 : io_in_d[72]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_73_T_2 = io_in_a[73] ^ io_in_b[73]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_73 = io_in_a[73] ^ io_in_b[73] ? io_in_c[73] : io_in_a[73]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_73_T_6 = _cout_vec_73_T_2 ^ io_in_c[73] ^ io_in_d[73]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_73 = _cout_vec_73_T_2 ^ io_in_c[73] ^ io_in_d[73] ^ cout_vec_72; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_73 = _sum_vec_73_T_6 ? cout_vec_72 : io_in_d[73]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_74_T_2 = io_in_a[74] ^ io_in_b[74]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_74 = io_in_a[74] ^ io_in_b[74] ? io_in_c[74] : io_in_a[74]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_74_T_6 = _cout_vec_74_T_2 ^ io_in_c[74] ^ io_in_d[74]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_74 = _cout_vec_74_T_2 ^ io_in_c[74] ^ io_in_d[74] ^ cout_vec_73; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_74 = _sum_vec_74_T_6 ? cout_vec_73 : io_in_d[74]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_75_T_2 = io_in_a[75] ^ io_in_b[75]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_75 = io_in_a[75] ^ io_in_b[75] ? io_in_c[75] : io_in_a[75]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_75_T_6 = _cout_vec_75_T_2 ^ io_in_c[75] ^ io_in_d[75]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_75 = _cout_vec_75_T_2 ^ io_in_c[75] ^ io_in_d[75] ^ cout_vec_74; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_75 = _sum_vec_75_T_6 ? cout_vec_74 : io_in_d[75]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_76_T_2 = io_in_a[76] ^ io_in_b[76]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_76 = io_in_a[76] ^ io_in_b[76] ? io_in_c[76] : io_in_a[76]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_76_T_6 = _cout_vec_76_T_2 ^ io_in_c[76] ^ io_in_d[76]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_76 = _cout_vec_76_T_2 ^ io_in_c[76] ^ io_in_d[76] ^ cout_vec_75; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_76 = _sum_vec_76_T_6 ? cout_vec_75 : io_in_d[76]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_77_T_2 = io_in_a[77] ^ io_in_b[77]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_77 = io_in_a[77] ^ io_in_b[77] ? io_in_c[77] : io_in_a[77]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_77_T_6 = _cout_vec_77_T_2 ^ io_in_c[77] ^ io_in_d[77]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_77 = _cout_vec_77_T_2 ^ io_in_c[77] ^ io_in_d[77] ^ cout_vec_76; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_77 = _sum_vec_77_T_6 ? cout_vec_76 : io_in_d[77]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_78_T_2 = io_in_a[78] ^ io_in_b[78]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_78 = io_in_a[78] ^ io_in_b[78] ? io_in_c[78] : io_in_a[78]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_78_T_6 = _cout_vec_78_T_2 ^ io_in_c[78] ^ io_in_d[78]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_78 = _cout_vec_78_T_2 ^ io_in_c[78] ^ io_in_d[78] ^ cout_vec_77; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_78 = _sum_vec_78_T_6 ? cout_vec_77 : io_in_d[78]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_79_T_2 = io_in_a[79] ^ io_in_b[79]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_79 = io_in_a[79] ^ io_in_b[79] ? io_in_c[79] : io_in_a[79]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_79_T_6 = _cout_vec_79_T_2 ^ io_in_c[79] ^ io_in_d[79]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_79 = _cout_vec_79_T_2 ^ io_in_c[79] ^ io_in_d[79] ^ cout_vec_78; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_79 = _sum_vec_79_T_6 ? cout_vec_78 : io_in_d[79]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_80_T_2 = io_in_a[80] ^ io_in_b[80]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_80 = io_in_a[80] ^ io_in_b[80] ? io_in_c[80] : io_in_a[80]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_80_T_6 = _cout_vec_80_T_2 ^ io_in_c[80] ^ io_in_d[80]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_80 = _cout_vec_80_T_2 ^ io_in_c[80] ^ io_in_d[80] ^ cout_vec_79; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_80 = _sum_vec_80_T_6 ? cout_vec_79 : io_in_d[80]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_81_T_2 = io_in_a[81] ^ io_in_b[81]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_81 = io_in_a[81] ^ io_in_b[81] ? io_in_c[81] : io_in_a[81]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_81_T_6 = _cout_vec_81_T_2 ^ io_in_c[81] ^ io_in_d[81]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_81 = _cout_vec_81_T_2 ^ io_in_c[81] ^ io_in_d[81] ^ cout_vec_80; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_81 = _sum_vec_81_T_6 ? cout_vec_80 : io_in_d[81]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_82_T_2 = io_in_a[82] ^ io_in_b[82]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_82 = io_in_a[82] ^ io_in_b[82] ? io_in_c[82] : io_in_a[82]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_82_T_6 = _cout_vec_82_T_2 ^ io_in_c[82] ^ io_in_d[82]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_82 = _cout_vec_82_T_2 ^ io_in_c[82] ^ io_in_d[82] ^ cout_vec_81; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_82 = _sum_vec_82_T_6 ? cout_vec_81 : io_in_d[82]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_83_T_2 = io_in_a[83] ^ io_in_b[83]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_83 = io_in_a[83] ^ io_in_b[83] ? io_in_c[83] : io_in_a[83]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_83_T_6 = _cout_vec_83_T_2 ^ io_in_c[83] ^ io_in_d[83]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_83 = _cout_vec_83_T_2 ^ io_in_c[83] ^ io_in_d[83] ^ cout_vec_82; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_83 = _sum_vec_83_T_6 ? cout_vec_82 : io_in_d[83]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_84_T_2 = io_in_a[84] ^ io_in_b[84]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_84 = io_in_a[84] ^ io_in_b[84] ? io_in_c[84] : io_in_a[84]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_84_T_6 = _cout_vec_84_T_2 ^ io_in_c[84] ^ io_in_d[84]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_84 = _cout_vec_84_T_2 ^ io_in_c[84] ^ io_in_d[84] ^ cout_vec_83; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_84 = _sum_vec_84_T_6 ? cout_vec_83 : io_in_d[84]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_85_T_2 = io_in_a[85] ^ io_in_b[85]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_85 = io_in_a[85] ^ io_in_b[85] ? io_in_c[85] : io_in_a[85]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_85_T_6 = _cout_vec_85_T_2 ^ io_in_c[85] ^ io_in_d[85]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_85 = _cout_vec_85_T_2 ^ io_in_c[85] ^ io_in_d[85] ^ cout_vec_84; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_85 = _sum_vec_85_T_6 ? cout_vec_84 : io_in_d[85]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_86_T_2 = io_in_a[86] ^ io_in_b[86]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_86 = io_in_a[86] ^ io_in_b[86] ? io_in_c[86] : io_in_a[86]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_86_T_6 = _cout_vec_86_T_2 ^ io_in_c[86] ^ io_in_d[86]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_86 = _cout_vec_86_T_2 ^ io_in_c[86] ^ io_in_d[86] ^ cout_vec_85; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_86 = _sum_vec_86_T_6 ? cout_vec_85 : io_in_d[86]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_87_T_2 = io_in_a[87] ^ io_in_b[87]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_87 = io_in_a[87] ^ io_in_b[87] ? io_in_c[87] : io_in_a[87]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_87_T_6 = _cout_vec_87_T_2 ^ io_in_c[87] ^ io_in_d[87]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_87 = _cout_vec_87_T_2 ^ io_in_c[87] ^ io_in_d[87] ^ cout_vec_86; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_87 = _sum_vec_87_T_6 ? cout_vec_86 : io_in_d[87]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_88_T_2 = io_in_a[88] ^ io_in_b[88]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_88 = io_in_a[88] ^ io_in_b[88] ? io_in_c[88] : io_in_a[88]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_88_T_6 = _cout_vec_88_T_2 ^ io_in_c[88] ^ io_in_d[88]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_88 = _cout_vec_88_T_2 ^ io_in_c[88] ^ io_in_d[88] ^ cout_vec_87; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_88 = _sum_vec_88_T_6 ? cout_vec_87 : io_in_d[88]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_89_T_2 = io_in_a[89] ^ io_in_b[89]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_89 = io_in_a[89] ^ io_in_b[89] ? io_in_c[89] : io_in_a[89]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_89_T_6 = _cout_vec_89_T_2 ^ io_in_c[89] ^ io_in_d[89]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_89 = _cout_vec_89_T_2 ^ io_in_c[89] ^ io_in_d[89] ^ cout_vec_88; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_89 = _sum_vec_89_T_6 ? cout_vec_88 : io_in_d[89]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_90_T_2 = io_in_a[90] ^ io_in_b[90]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_90 = io_in_a[90] ^ io_in_b[90] ? io_in_c[90] : io_in_a[90]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_90_T_6 = _cout_vec_90_T_2 ^ io_in_c[90] ^ io_in_d[90]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_90 = _cout_vec_90_T_2 ^ io_in_c[90] ^ io_in_d[90] ^ cout_vec_89; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_90 = _sum_vec_90_T_6 ? cout_vec_89 : io_in_d[90]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_91_T_2 = io_in_a[91] ^ io_in_b[91]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_91 = io_in_a[91] ^ io_in_b[91] ? io_in_c[91] : io_in_a[91]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_91_T_6 = _cout_vec_91_T_2 ^ io_in_c[91] ^ io_in_d[91]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_91 = _cout_vec_91_T_2 ^ io_in_c[91] ^ io_in_d[91] ^ cout_vec_90; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_91 = _sum_vec_91_T_6 ? cout_vec_90 : io_in_d[91]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_92_T_2 = io_in_a[92] ^ io_in_b[92]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_92 = io_in_a[92] ^ io_in_b[92] ? io_in_c[92] : io_in_a[92]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_92_T_6 = _cout_vec_92_T_2 ^ io_in_c[92] ^ io_in_d[92]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_92 = _cout_vec_92_T_2 ^ io_in_c[92] ^ io_in_d[92] ^ cout_vec_91; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_92 = _sum_vec_92_T_6 ? cout_vec_91 : io_in_d[92]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_93_T_2 = io_in_a[93] ^ io_in_b[93]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_93 = io_in_a[93] ^ io_in_b[93] ? io_in_c[93] : io_in_a[93]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_93_T_6 = _cout_vec_93_T_2 ^ io_in_c[93] ^ io_in_d[93]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_93 = _cout_vec_93_T_2 ^ io_in_c[93] ^ io_in_d[93] ^ cout_vec_92; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_93 = _sum_vec_93_T_6 ? cout_vec_92 : io_in_d[93]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_94_T_2 = io_in_a[94] ^ io_in_b[94]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_94 = io_in_a[94] ^ io_in_b[94] ? io_in_c[94] : io_in_a[94]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_94_T_6 = _cout_vec_94_T_2 ^ io_in_c[94] ^ io_in_d[94]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_94 = _cout_vec_94_T_2 ^ io_in_c[94] ^ io_in_d[94] ^ cout_vec_93; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_94 = _sum_vec_94_T_6 ? cout_vec_93 : io_in_d[94]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_95_T_2 = io_in_a[95] ^ io_in_b[95]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_95 = io_in_a[95] ^ io_in_b[95] ? io_in_c[95] : io_in_a[95]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_95_T_6 = _cout_vec_95_T_2 ^ io_in_c[95] ^ io_in_d[95]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_95 = _cout_vec_95_T_2 ^ io_in_c[95] ^ io_in_d[95] ^ cout_vec_94; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_95 = _sum_vec_95_T_6 ? cout_vec_94 : io_in_d[95]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_96_T_2 = io_in_a[96] ^ io_in_b[96]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_96 = io_in_a[96] ^ io_in_b[96] ? io_in_c[96] : io_in_a[96]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_96_T_6 = _cout_vec_96_T_2 ^ io_in_c[96] ^ io_in_d[96]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_96 = _cout_vec_96_T_2 ^ io_in_c[96] ^ io_in_d[96] ^ cout_vec_95; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_96 = _sum_vec_96_T_6 ? cout_vec_95 : io_in_d[96]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_97_T_2 = io_in_a[97] ^ io_in_b[97]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_97 = io_in_a[97] ^ io_in_b[97] ? io_in_c[97] : io_in_a[97]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_97_T_6 = _cout_vec_97_T_2 ^ io_in_c[97] ^ io_in_d[97]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_97 = _cout_vec_97_T_2 ^ io_in_c[97] ^ io_in_d[97] ^ cout_vec_96; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_97 = _sum_vec_97_T_6 ? cout_vec_96 : io_in_d[97]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_98_T_2 = io_in_a[98] ^ io_in_b[98]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_98 = io_in_a[98] ^ io_in_b[98] ? io_in_c[98] : io_in_a[98]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_98_T_6 = _cout_vec_98_T_2 ^ io_in_c[98] ^ io_in_d[98]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_98 = _cout_vec_98_T_2 ^ io_in_c[98] ^ io_in_d[98] ^ cout_vec_97; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_98 = _sum_vec_98_T_6 ? cout_vec_97 : io_in_d[98]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_99_T_2 = io_in_a[99] ^ io_in_b[99]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_99 = io_in_a[99] ^ io_in_b[99] ? io_in_c[99] : io_in_a[99]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_99_T_6 = _cout_vec_99_T_2 ^ io_in_c[99] ^ io_in_d[99]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_99 = _cout_vec_99_T_2 ^ io_in_c[99] ^ io_in_d[99] ^ cout_vec_98; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_99 = _sum_vec_99_T_6 ? cout_vec_98 : io_in_d[99]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_100_T_2 = io_in_a[100] ^ io_in_b[100]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_100 = io_in_a[100] ^ io_in_b[100] ? io_in_c[100] : io_in_a[100]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_100_T_6 = _cout_vec_100_T_2 ^ io_in_c[100] ^ io_in_d[100]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_100 = _cout_vec_100_T_2 ^ io_in_c[100] ^ io_in_d[100] ^ cout_vec_99; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_100 = _sum_vec_100_T_6 ? cout_vec_99 : io_in_d[100]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_101_T_2 = io_in_a[101] ^ io_in_b[101]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_101 = io_in_a[101] ^ io_in_b[101] ? io_in_c[101] : io_in_a[101]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_101_T_6 = _cout_vec_101_T_2 ^ io_in_c[101] ^ io_in_d[101]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_101 = _cout_vec_101_T_2 ^ io_in_c[101] ^ io_in_d[101] ^ cout_vec_100; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_101 = _sum_vec_101_T_6 ? cout_vec_100 : io_in_d[101]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_102_T_2 = io_in_a[102] ^ io_in_b[102]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_102 = io_in_a[102] ^ io_in_b[102] ? io_in_c[102] : io_in_a[102]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_102_T_6 = _cout_vec_102_T_2 ^ io_in_c[102] ^ io_in_d[102]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_102 = _cout_vec_102_T_2 ^ io_in_c[102] ^ io_in_d[102] ^ cout_vec_101; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_102 = _sum_vec_102_T_6 ? cout_vec_101 : io_in_d[102]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_103_T_2 = io_in_a[103] ^ io_in_b[103]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_103 = io_in_a[103] ^ io_in_b[103] ? io_in_c[103] : io_in_a[103]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_103_T_6 = _cout_vec_103_T_2 ^ io_in_c[103] ^ io_in_d[103]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_103 = _cout_vec_103_T_2 ^ io_in_c[103] ^ io_in_d[103] ^ cout_vec_102; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_103 = _sum_vec_103_T_6 ? cout_vec_102 : io_in_d[103]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_104_T_2 = io_in_a[104] ^ io_in_b[104]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_104 = io_in_a[104] ^ io_in_b[104] ? io_in_c[104] : io_in_a[104]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_104_T_6 = _cout_vec_104_T_2 ^ io_in_c[104] ^ io_in_d[104]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_104 = _cout_vec_104_T_2 ^ io_in_c[104] ^ io_in_d[104] ^ cout_vec_103; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_104 = _sum_vec_104_T_6 ? cout_vec_103 : io_in_d[104]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_105_T_2 = io_in_a[105] ^ io_in_b[105]; // @[FloatFMA.scala 1115:35]
  wire  cout_vec_105 = io_in_a[105] ^ io_in_b[105] ? io_in_c[105] : io_in_a[105]; // @[FloatFMA.scala 1115:23]
  wire  _sum_vec_105_T_6 = _cout_vec_105_T_2 ^ io_in_c[105] ^ io_in_d[105]; // @[FloatFMA.scala 1121:61]
  wire  sum_vec_105 = _cout_vec_105_T_2 ^ io_in_c[105] ^ io_in_d[105] ^ cout_vec_104; // @[FloatFMA.scala 1121:74]
  wire  carry_vec_105 = _sum_vec_105_T_6 ? cout_vec_104 : io_in_d[105]; // @[FloatFMA.scala 1122:26]
  wire  _cout_vec_106_T_2 = io_in_a[106] ^ io_in_b[106]; // @[FloatFMA.scala 1115:35]
  wire  sum_vec_106 = _cout_vec_106_T_2 ^ io_in_c[106] ^ io_in_d[106] ^ cout_vec_105; // @[FloatFMA.scala 1121:74]
  wire [5:0] io_out_sum_lo_lo_lo_lo = {carry_vec_4,sum_vec_4,carry_vec_2,sum_vec_2,carry_vec_0,sum_vec_0}; // @[FloatFMA.scala 1142:30]
  wire [12:0] io_out_sum_lo_lo_lo = {sum_vec_12,carry_vec_10,sum_vec_10,carry_vec_8,sum_vec_8,carry_vec_6,sum_vec_6,
    io_out_sum_lo_lo_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [5:0] io_out_sum_lo_lo_hi_lo = {sum_vec_18,carry_vec_16,sum_vec_16,carry_vec_14,sum_vec_14,carry_vec_12}; // @[FloatFMA.scala 1142:30]
  wire [25:0] io_out_sum_lo_lo = {carry_vec_24,sum_vec_24,carry_vec_22,sum_vec_22,carry_vec_20,sum_vec_20,carry_vec_18,
    io_out_sum_lo_lo_hi_lo,io_out_sum_lo_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [5:0] io_out_sum_lo_hi_lo_lo = {carry_vec_30,sum_vec_30,carry_vec_28,sum_vec_28,carry_vec_26,sum_vec_26}; // @[FloatFMA.scala 1142:30]
  wire [12:0] io_out_sum_lo_hi_lo = {sum_vec_38,carry_vec_36,sum_vec_36,carry_vec_34,sum_vec_34,carry_vec_32,sum_vec_32,
    io_out_sum_lo_hi_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [6:0] io_out_sum_lo_hi_hi_lo = {carry_vec_44,sum_vec_44,carry_vec_42,sum_vec_42,carry_vec_40,sum_vec_40,
    carry_vec_38}; // @[FloatFMA.scala 1142:30]
  wire [52:0] io_out_sum_lo = {sum_vec_52,carry_vec_50,sum_vec_50,carry_vec_48,sum_vec_48,carry_vec_46,sum_vec_46,
    io_out_sum_lo_hi_hi_lo,io_out_sum_lo_hi_lo,io_out_sum_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [5:0] io_out_sum_hi_lo_lo_lo = {sum_vec_58,carry_vec_56,sum_vec_56,carry_vec_54,sum_vec_54,carry_vec_52}; // @[FloatFMA.scala 1142:30]
  wire [12:0] io_out_sum_hi_lo_lo = {carry_vec_64,sum_vec_64,carry_vec_62,sum_vec_62,carry_vec_60,sum_vec_60,
    carry_vec_58,io_out_sum_hi_lo_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [6:0] io_out_sum_hi_lo_hi_lo = {sum_vec_72,carry_vec_70,sum_vec_70,carry_vec_68,sum_vec_68,carry_vec_66,
    sum_vec_66}; // @[FloatFMA.scala 1142:30]
  wire [26:0] io_out_sum_hi_lo = {carry_vec_78,sum_vec_78,carry_vec_76,sum_vec_76,carry_vec_74,sum_vec_74,carry_vec_72,
    io_out_sum_hi_lo_hi_lo,io_out_sum_hi_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [5:0] io_out_sum_hi_hi_lo_lo = {carry_vec_84,sum_vec_84,carry_vec_82,sum_vec_82,carry_vec_80,sum_vec_80}; // @[FloatFMA.scala 1142:30]
  wire [12:0] io_out_sum_hi_hi_lo = {sum_vec_92,carry_vec_90,sum_vec_90,carry_vec_88,sum_vec_88,carry_vec_86,sum_vec_86,
    io_out_sum_hi_hi_lo_lo}; // @[FloatFMA.scala 1142:30]
  wire [6:0] io_out_sum_hi_hi_hi_lo = {carry_vec_98,sum_vec_98,carry_vec_96,sum_vec_96,carry_vec_94,sum_vec_94,
    carry_vec_92}; // @[FloatFMA.scala 1142:30]
  wire [53:0] io_out_sum_hi = {sum_vec_106,carry_vec_104,sum_vec_104,carry_vec_102,sum_vec_102,carry_vec_100,sum_vec_100
    ,io_out_sum_hi_hi_hi_lo,io_out_sum_hi_hi_lo,io_out_sum_hi_lo}; // @[FloatFMA.scala 1142:30]
  wire [5:0] io_out_car_lo_lo_lo_lo = {sum_vec_5,carry_vec_3,sum_vec_3,carry_vec_1,sum_vec_1,1'h0}; // @[FloatFMA.scala 1143:32]
  wire [12:0] io_out_car_lo_lo_lo = {carry_vec_11,sum_vec_11,carry_vec_9,sum_vec_9,carry_vec_7,sum_vec_7,carry_vec_5,
    io_out_car_lo_lo_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [5:0] io_out_car_lo_lo_hi_lo = {carry_vec_17,sum_vec_17,carry_vec_15,sum_vec_15,carry_vec_13,sum_vec_13}; // @[FloatFMA.scala 1143:32]
  wire [25:0] io_out_car_lo_lo = {sum_vec_25,carry_vec_23,sum_vec_23,carry_vec_21,sum_vec_21,carry_vec_19,sum_vec_19,
    io_out_car_lo_lo_hi_lo,io_out_car_lo_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [5:0] io_out_car_lo_hi_lo_lo = {sum_vec_31,carry_vec_29,sum_vec_29,carry_vec_27,sum_vec_27,carry_vec_25}; // @[FloatFMA.scala 1143:32]
  wire [12:0] io_out_car_lo_hi_lo = {carry_vec_37,sum_vec_37,carry_vec_35,sum_vec_35,carry_vec_33,sum_vec_33,
    carry_vec_31,io_out_car_lo_hi_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [6:0] io_out_car_lo_hi_hi_lo = {sum_vec_45,carry_vec_43,sum_vec_43,carry_vec_41,sum_vec_41,carry_vec_39,
    sum_vec_39}; // @[FloatFMA.scala 1143:32]
  wire [52:0] io_out_car_lo = {carry_vec_51,sum_vec_51,carry_vec_49,sum_vec_49,carry_vec_47,sum_vec_47,carry_vec_45,
    io_out_car_lo_hi_hi_lo,io_out_car_lo_hi_lo,io_out_car_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [5:0] io_out_car_hi_lo_lo_lo = {carry_vec_57,sum_vec_57,carry_vec_55,sum_vec_55,carry_vec_53,sum_vec_53}; // @[FloatFMA.scala 1143:32]
  wire [12:0] io_out_car_hi_lo_lo = {sum_vec_65,carry_vec_63,sum_vec_63,carry_vec_61,sum_vec_61,carry_vec_59,sum_vec_59,
    io_out_car_hi_lo_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [6:0] io_out_car_hi_lo_hi_lo = {carry_vec_71,sum_vec_71,carry_vec_69,sum_vec_69,carry_vec_67,sum_vec_67,
    carry_vec_65}; // @[FloatFMA.scala 1143:32]
  wire [26:0] io_out_car_hi_lo = {sum_vec_79,carry_vec_77,sum_vec_77,carry_vec_75,sum_vec_75,carry_vec_73,sum_vec_73,
    io_out_car_hi_lo_hi_lo,io_out_car_hi_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [5:0] io_out_car_hi_hi_lo_lo = {sum_vec_85,carry_vec_83,sum_vec_83,carry_vec_81,sum_vec_81,carry_vec_79}; // @[FloatFMA.scala 1143:32]
  wire [12:0] io_out_car_hi_hi_lo = {carry_vec_91,sum_vec_91,carry_vec_89,sum_vec_89,carry_vec_87,sum_vec_87,
    carry_vec_85,io_out_car_hi_hi_lo_lo}; // @[FloatFMA.scala 1143:32]
  wire [6:0] io_out_car_hi_hi_hi_lo = {sum_vec_99,carry_vec_97,sum_vec_97,carry_vec_95,sum_vec_95,carry_vec_93,
    sum_vec_93}; // @[FloatFMA.scala 1143:32]
  wire [53:0] io_out_car_hi = {carry_vec_105,sum_vec_105,carry_vec_103,sum_vec_103,carry_vec_101,sum_vec_101,
    carry_vec_99,io_out_car_hi_hi_hi_lo,io_out_car_hi_hi_lo,io_out_car_hi_lo}; // @[FloatFMA.scala 1143:32]
  assign io_out_sum = {io_out_sum_hi,io_out_sum_lo}; // @[FloatFMA.scala 1142:30]
  assign io_out_car = {io_out_car_hi,io_out_car_lo}; // @[FloatFMA.scala 1143:32]
endmodule
module CSA_Nto2With3to2MainPipeline(
  input          clock,
  input  [106:0] io_in_0,
  input  [106:0] io_in_1,
  input  [106:0] io_in_2,
  input  [106:0] io_in_3,
  input  [106:0] io_in_4,
  input  [106:0] io_in_5,
  input  [106:0] io_in_6,
  input  [106:0] io_in_7,
  input  [106:0] io_in_8,
  input  [106:0] io_in_9,
  input  [106:0] io_in_10,
  input  [106:0] io_in_11,
  input  [106:0] io_in_12,
  output [106:0] io_out_sum,
  output [106:0] io_out_car
);
`ifdef RANDOMIZE_REG_INIT
  reg [127:0] _RAND_0;
  reg [127:0] _RAND_1;
  reg [127:0] _RAND_2;
  reg [127:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [106:0] U_CSA3to2_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_1_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_1_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_1_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_1_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_1_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_2_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_2_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_2_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_2_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_2_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_3_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_3_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_3_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_3_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_3_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_4_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_4_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_4_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_4_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_4_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_5_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_5_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_5_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_5_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_5_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_6_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_6_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_6_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_6_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_6_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_7_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_7_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_7_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_7_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_7_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_8_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_8_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_8_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_8_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_8_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_9_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_9_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_9_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_9_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_9_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_10_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_10_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_10_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_10_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_10_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_11_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_11_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_11_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_11_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_11_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_12_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_12_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_12_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_12_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_12_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_13_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_13_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_13_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_13_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_13_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_14_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_14_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_14_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_14_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_14_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_15_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_15_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_15_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_15_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_15_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_16_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_16_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_16_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_16_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_16_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_17_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_17_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_17_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_17_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_17_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_18_io_in_a; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_18_io_in_b; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_18_io_in_c; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_18_io_out_sum; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA3to2_18_io_out_car; // @[FloatFMA.scala 1058:29]
  wire [106:0] U_CSA4to2_io_in_a; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_io_in_b; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_io_in_c; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_io_in_d; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_io_out_sum; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_io_out_car; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_in_a; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_in_b; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_in_c; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_in_d; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_out_sum; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_1_io_out_car; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_in_a; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_in_b; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_in_c; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_in_d; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_out_sum; // @[FloatFMA.scala 1049:29]
  wire [106:0] U_CSA4to2_2_io_out_car; // @[FloatFMA.scala 1049:29]
  reg [106:0] U_CSA4to2_io_in_a_r; // @[Reg.scala 19:16]
  reg [106:0] U_CSA4to2_io_in_b_r; // @[Reg.scala 19:16]
  reg [106:0] U_CSA4to2_io_in_c_r; // @[Reg.scala 19:16]
  reg [106:0] U_CSA4to2_io_in_d_r; // @[Reg.scala 19:16]
  CSA3to2 U_CSA3to2 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_io_in_a),
    .io_in_b(U_CSA3to2_io_in_b),
    .io_in_c(U_CSA3to2_io_in_c),
    .io_out_sum(U_CSA3to2_io_out_sum),
    .io_out_car(U_CSA3to2_io_out_car)
  );
  CSA3to2 U_CSA3to2_1 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_1_io_in_a),
    .io_in_b(U_CSA3to2_1_io_in_b),
    .io_in_c(U_CSA3to2_1_io_in_c),
    .io_out_sum(U_CSA3to2_1_io_out_sum),
    .io_out_car(U_CSA3to2_1_io_out_car)
  );
  CSA3to2 U_CSA3to2_2 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_2_io_in_a),
    .io_in_b(U_CSA3to2_2_io_in_b),
    .io_in_c(U_CSA3to2_2_io_in_c),
    .io_out_sum(U_CSA3to2_2_io_out_sum),
    .io_out_car(U_CSA3to2_2_io_out_car)
  );
  CSA3to2 U_CSA3to2_3 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_3_io_in_a),
    .io_in_b(U_CSA3to2_3_io_in_b),
    .io_in_c(U_CSA3to2_3_io_in_c),
    .io_out_sum(U_CSA3to2_3_io_out_sum),
    .io_out_car(U_CSA3to2_3_io_out_car)
  );
  CSA3to2 U_CSA3to2_4 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_4_io_in_a),
    .io_in_b(U_CSA3to2_4_io_in_b),
    .io_in_c(U_CSA3to2_4_io_in_c),
    .io_out_sum(U_CSA3to2_4_io_out_sum),
    .io_out_car(U_CSA3to2_4_io_out_car)
  );
  CSA3to2 U_CSA3to2_5 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_5_io_in_a),
    .io_in_b(U_CSA3to2_5_io_in_b),
    .io_in_c(U_CSA3to2_5_io_in_c),
    .io_out_sum(U_CSA3to2_5_io_out_sum),
    .io_out_car(U_CSA3to2_5_io_out_car)
  );
  CSA3to2 U_CSA3to2_6 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_6_io_in_a),
    .io_in_b(U_CSA3to2_6_io_in_b),
    .io_in_c(U_CSA3to2_6_io_in_c),
    .io_out_sum(U_CSA3to2_6_io_out_sum),
    .io_out_car(U_CSA3to2_6_io_out_car)
  );
  CSA3to2 U_CSA3to2_7 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_7_io_in_a),
    .io_in_b(U_CSA3to2_7_io_in_b),
    .io_in_c(U_CSA3to2_7_io_in_c),
    .io_out_sum(U_CSA3to2_7_io_out_sum),
    .io_out_car(U_CSA3to2_7_io_out_car)
  );
  CSA3to2 U_CSA3to2_8 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_8_io_in_a),
    .io_in_b(U_CSA3to2_8_io_in_b),
    .io_in_c(U_CSA3to2_8_io_in_c),
    .io_out_sum(U_CSA3to2_8_io_out_sum),
    .io_out_car(U_CSA3to2_8_io_out_car)
  );
  CSA3to2 U_CSA3to2_9 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_9_io_in_a),
    .io_in_b(U_CSA3to2_9_io_in_b),
    .io_in_c(U_CSA3to2_9_io_in_c),
    .io_out_sum(U_CSA3to2_9_io_out_sum),
    .io_out_car(U_CSA3to2_9_io_out_car)
  );
  CSA3to2 U_CSA3to2_10 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_10_io_in_a),
    .io_in_b(U_CSA3to2_10_io_in_b),
    .io_in_c(U_CSA3to2_10_io_in_c),
    .io_out_sum(U_CSA3to2_10_io_out_sum),
    .io_out_car(U_CSA3to2_10_io_out_car)
  );
  CSA3to2 U_CSA3to2_11 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_11_io_in_a),
    .io_in_b(U_CSA3to2_11_io_in_b),
    .io_in_c(U_CSA3to2_11_io_in_c),
    .io_out_sum(U_CSA3to2_11_io_out_sum),
    .io_out_car(U_CSA3to2_11_io_out_car)
  );
  CSA3to2 U_CSA3to2_12 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_12_io_in_a),
    .io_in_b(U_CSA3to2_12_io_in_b),
    .io_in_c(U_CSA3to2_12_io_in_c),
    .io_out_sum(U_CSA3to2_12_io_out_sum),
    .io_out_car(U_CSA3to2_12_io_out_car)
  );
  CSA3to2 U_CSA3to2_13 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_13_io_in_a),
    .io_in_b(U_CSA3to2_13_io_in_b),
    .io_in_c(U_CSA3to2_13_io_in_c),
    .io_out_sum(U_CSA3to2_13_io_out_sum),
    .io_out_car(U_CSA3to2_13_io_out_car)
  );
  CSA3to2 U_CSA3to2_14 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_14_io_in_a),
    .io_in_b(U_CSA3to2_14_io_in_b),
    .io_in_c(U_CSA3to2_14_io_in_c),
    .io_out_sum(U_CSA3to2_14_io_out_sum),
    .io_out_car(U_CSA3to2_14_io_out_car)
  );
  CSA3to2 U_CSA3to2_15 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_15_io_in_a),
    .io_in_b(U_CSA3to2_15_io_in_b),
    .io_in_c(U_CSA3to2_15_io_in_c),
    .io_out_sum(U_CSA3to2_15_io_out_sum),
    .io_out_car(U_CSA3to2_15_io_out_car)
  );
  CSA3to2 U_CSA3to2_16 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_16_io_in_a),
    .io_in_b(U_CSA3to2_16_io_in_b),
    .io_in_c(U_CSA3to2_16_io_in_c),
    .io_out_sum(U_CSA3to2_16_io_out_sum),
    .io_out_car(U_CSA3to2_16_io_out_car)
  );
  CSA3to2 U_CSA3to2_17 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_17_io_in_a),
    .io_in_b(U_CSA3to2_17_io_in_b),
    .io_in_c(U_CSA3to2_17_io_in_c),
    .io_out_sum(U_CSA3to2_17_io_out_sum),
    .io_out_car(U_CSA3to2_17_io_out_car)
  );
  CSA3to2 U_CSA3to2_18 ( // @[FloatFMA.scala 1058:29]
    .io_in_a(U_CSA3to2_18_io_in_a),
    .io_in_b(U_CSA3to2_18_io_in_b),
    .io_in_c(U_CSA3to2_18_io_in_c),
    .io_out_sum(U_CSA3to2_18_io_out_sum),
    .io_out_car(U_CSA3to2_18_io_out_car)
  );
  CSA4to2 U_CSA4to2 ( // @[FloatFMA.scala 1049:29]
    .io_in_a(U_CSA4to2_io_in_a),
    .io_in_b(U_CSA4to2_io_in_b),
    .io_in_c(U_CSA4to2_io_in_c),
    .io_in_d(U_CSA4to2_io_in_d),
    .io_out_sum(U_CSA4to2_io_out_sum),
    .io_out_car(U_CSA4to2_io_out_car)
  );
  CSA4to2 U_CSA4to2_1 ( // @[FloatFMA.scala 1049:29]
    .io_in_a(U_CSA4to2_1_io_in_a),
    .io_in_b(U_CSA4to2_1_io_in_b),
    .io_in_c(U_CSA4to2_1_io_in_c),
    .io_in_d(U_CSA4to2_1_io_in_d),
    .io_out_sum(U_CSA4to2_1_io_out_sum),
    .io_out_car(U_CSA4to2_1_io_out_car)
  );
  CSA4to2 U_CSA4to2_2 ( // @[FloatFMA.scala 1049:29]
    .io_in_a(U_CSA4to2_2_io_in_a),
    .io_in_b(U_CSA4to2_2_io_in_b),
    .io_in_c(U_CSA4to2_2_io_in_c),
    .io_in_d(U_CSA4to2_2_io_in_d),
    .io_out_sum(U_CSA4to2_2_io_out_sum),
    .io_out_car(U_CSA4to2_2_io_out_car)
  );
  assign io_out_sum = U_CSA4to2_2_io_out_sum; // @[FloatFMA.scala 1079:14]
  assign io_out_car = U_CSA4to2_2_io_out_car; // @[FloatFMA.scala 1080:14]
  assign U_CSA3to2_io_in_a = io_in_0; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_io_in_b = io_in_1; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_io_in_c = io_in_2; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_1_io_in_a = io_in_3; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_1_io_in_b = io_in_4; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_1_io_in_c = io_in_5; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_2_io_in_a = io_in_6; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_2_io_in_b = io_in_7; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_2_io_in_c = io_in_8; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_3_io_in_a = io_in_9; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_3_io_in_b = io_in_10; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_3_io_in_c = io_in_11; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_4_io_in_a = io_in_12; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_4_io_in_b = 107'h0; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_4_io_in_c = 107'h0; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_5_io_in_a = 107'h0; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_5_io_in_b = 107'h0; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_5_io_in_c = 107'h0; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_6_io_in_a = 107'h0; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_6_io_in_b = 107'h0; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_6_io_in_c = 107'h0; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_7_io_in_a = 107'h0; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_7_io_in_b = 107'h0; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_7_io_in_c = 107'h0; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_8_io_in_a = 107'h0; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_8_io_in_b = 107'h0; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_8_io_in_c = 107'h0; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_9_io_in_a = U_CSA3to2_io_out_sum; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_9_io_in_b = U_CSA3to2_io_out_car; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_9_io_in_c = U_CSA3to2_1_io_out_sum; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_10_io_in_a = U_CSA3to2_1_io_out_car; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_10_io_in_b = U_CSA3to2_2_io_out_sum; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_10_io_in_c = U_CSA3to2_2_io_out_car; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_11_io_in_a = U_CSA3to2_3_io_out_sum; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_11_io_in_b = U_CSA3to2_3_io_out_car; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_11_io_in_c = U_CSA3to2_4_io_out_sum; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_12_io_in_a = U_CSA3to2_4_io_out_car; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_12_io_in_b = U_CSA3to2_5_io_out_sum; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_12_io_in_c = U_CSA3to2_5_io_out_car; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_13_io_in_a = U_CSA3to2_6_io_out_sum; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_13_io_in_b = U_CSA3to2_6_io_out_car; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_13_io_in_c = U_CSA3to2_7_io_out_sum; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_14_io_in_a = U_CSA3to2_7_io_out_car; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_14_io_in_b = U_CSA3to2_8_io_out_sum; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_14_io_in_c = U_CSA3to2_8_io_out_car; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_15_io_in_a = U_CSA3to2_9_io_out_sum; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_15_io_in_b = U_CSA3to2_9_io_out_car; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_15_io_in_c = U_CSA3to2_10_io_out_sum; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_16_io_in_a = U_CSA3to2_10_io_out_car; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_16_io_in_b = U_CSA3to2_11_io_out_sum; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_16_io_in_c = U_CSA3to2_11_io_out_car; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_17_io_in_a = U_CSA3to2_12_io_out_sum; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_17_io_in_b = U_CSA3to2_12_io_out_car; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_17_io_in_c = U_CSA3to2_13_io_out_sum; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_18_io_in_a = U_CSA3to2_13_io_out_car; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_18_io_in_b = U_CSA3to2_14_io_out_sum; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_18_io_in_c = U_CSA3to2_14_io_out_car; // @[FloatFMA.scala 1061:25]
  assign U_CSA4to2_io_in_a = U_CSA3to2_15_io_out_sum; // @[FloatFMA.scala 1050:25]
  assign U_CSA4to2_io_in_b = U_CSA3to2_15_io_out_car; // @[FloatFMA.scala 1051:25]
  assign U_CSA4to2_io_in_c = U_CSA3to2_16_io_out_sum; // @[FloatFMA.scala 1052:25]
  assign U_CSA4to2_io_in_d = U_CSA3to2_16_io_out_car; // @[FloatFMA.scala 1053:25]
  assign U_CSA4to2_1_io_in_a = U_CSA3to2_17_io_out_sum; // @[FloatFMA.scala 1050:25]
  assign U_CSA4to2_1_io_in_b = U_CSA3to2_17_io_out_car; // @[FloatFMA.scala 1051:25]
  assign U_CSA4to2_1_io_in_c = U_CSA3to2_18_io_out_sum; // @[FloatFMA.scala 1052:25]
  assign U_CSA4to2_1_io_in_d = U_CSA3to2_18_io_out_car; // @[FloatFMA.scala 1053:25]
  assign U_CSA4to2_2_io_in_a = U_CSA4to2_io_in_a_r; // @[FloatFMA.scala 1050:25]
  assign U_CSA4to2_2_io_in_b = U_CSA4to2_io_in_b_r; // @[FloatFMA.scala 1051:25]
  assign U_CSA4to2_2_io_in_c = U_CSA4to2_io_in_c_r; // @[FloatFMA.scala 1052:25]
  assign U_CSA4to2_2_io_in_d = U_CSA4to2_io_in_d_r; // @[FloatFMA.scala 1053:25]
  always @(posedge clock) begin
    U_CSA4to2_io_in_a_r <= U_CSA4to2_io_out_sum; // @[Reg.scala 19:16 20:{18,22}]
    U_CSA4to2_io_in_b_r <= U_CSA4to2_io_out_car; // @[Reg.scala 19:16 20:{18,22}]
    U_CSA4to2_io_in_c_r <= U_CSA4to2_1_io_out_sum; // @[Reg.scala 19:16 20:{18,22}]
    U_CSA4to2_io_in_d_r <= U_CSA4to2_1_io_out_car; // @[Reg.scala 19:16 20:{18,22}]
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
  _RAND_0 = {4{`RANDOM}};
  U_CSA4to2_io_in_a_r = _RAND_0[106:0];
  _RAND_1 = {4{`RANDOM}};
  U_CSA4to2_io_in_b_r = _RAND_1[106:0];
  _RAND_2 = {4{`RANDOM}};
  U_CSA4to2_io_in_c_r = _RAND_2[106:0];
  _RAND_3 = {4{`RANDOM}};
  U_CSA4to2_io_in_d_r = _RAND_3[106:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FloatFMA(
  input         clock,
  input         reset,
  input  [63:0] io_fp_a,
  input  [63:0] io_fp_b,
  input  [63:0] io_fp_c,
  input  [3:0]  io_op_code,
  output [63:0] io_fp_result,
  output [4:0]  io_fflags
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [191:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [191:0] _RAND_14;
  reg [191:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [95:0] _RAND_17;
  reg [63:0] _RAND_18;
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
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
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
`endif // RANDOMIZE_REG_INIT
  wire [52:0] U_BoothEncoder_io_in_a; // @[FloatFMA.scala 268:30]
  wire [52:0] U_BoothEncoder_io_in_b; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_0; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_1; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_2; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_3; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_4; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_5; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_6; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_7; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_8; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_9; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_10; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_11; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_12; // @[FloatFMA.scala 268:30]
  wire  U_CSAnto2_clock; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_0; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_1; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_2; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_3; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_4; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_5; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_6; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_7; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_8; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_9; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_10; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_11; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_12; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_out_sum; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_out_car; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSA3to2_io_in_a; // @[FloatFMA.scala 311:25]
  wire [106:0] U_CSA3to2_io_in_b; // @[FloatFMA.scala 311:25]
  wire [106:0] U_CSA3to2_io_in_c; // @[FloatFMA.scala 311:25]
  wire [106:0] U_CSA3to2_io_out_sum; // @[FloatFMA.scala 311:25]
  wire [106:0] U_CSA3to2_io_out_car; // @[FloatFMA.scala 311:25]
  reg  fire_reg0_last_r; // @[Reg.scala 35:20]
  reg  fire_reg1_last_r; // @[Reg.scala 35:20]
  wire  _fire_reg1_last_T = fire_reg0_last_r | fire_reg1_last_r; // @[Compat.scala 23:40]
  wire  is_fmul = io_op_code == 4'h0; // @[FloatFMA.scala 53:30]
  wire  is_fnmacc = io_op_code == 4'h2; // @[FloatFMA.scala 55:30]
  wire  is_fmsac = io_op_code == 4'h3; // @[FloatFMA.scala 56:30]
  wire  is_fnmsac = io_op_code == 4'h4; // @[FloatFMA.scala 57:30]
  wire  fp_a_is_sign_inv = is_fnmacc | is_fnmsac; // @[FloatFMA.scala 90:36]
  wire  fp_c_is_sign_inv = is_fnmacc | is_fmsac; // @[FloatFMA.scala 91:36]
  wire  _fp_a_f32_T_4 = fp_a_is_sign_inv ? ~io_fp_a[31] : io_fp_a[31]; // @[FloatFMA.scala 88:12]
  wire [31:0] fp_a_f32 = {_fp_a_f32_T_4,io_fp_a[30:0]}; // @[Cat.scala 33:92]
  wire [31:0] fp_b_f32 = io_fp_b[31:0]; // @[FloatFMA.scala 97:38]
  wire  _fp_c_f32_T_4 = fp_c_is_sign_inv ? ~io_fp_c[31] : io_fp_c[31]; // @[FloatFMA.scala 88:12]
  wire [31:0] _fp_c_f32_T_6 = {_fp_c_f32_T_4,io_fp_c[30:0]}; // @[Cat.scala 33:92]
  wire [31:0] fp_c_f32 = is_fmul ? 32'h0 : _fp_c_f32_T_6; // @[FloatFMA.scala 98:34]
  wire  sign_a_b_f32 = fp_a_f32[31] ^ fp_b_f32[31]; // @[FloatFMA.scala 105:49]
  wire  sign_c_f32 = fp_c_f32[31]; // @[FloatFMA.scala 108:44]
  wire  is_sub_f32 = sign_a_b_f32 ^ sign_c_f32; // @[FloatFMA.scala 114:44]
  wire [7:0] Ea_f32 = fp_a_f32[30:23]; // @[FloatFMA.scala 121:39]
  wire [7:0] Eb_f32 = fp_b_f32[30:23]; // @[FloatFMA.scala 122:39]
  wire [7:0] Ec_f32 = fp_c_f32[30:23]; // @[FloatFMA.scala 123:39]
  wire  Ea_f32_is_not_zero = |Ea_f32; // @[FloatFMA.scala 132:38]
  wire  Eb_f32_is_not_zero = |Eb_f32; // @[FloatFMA.scala 133:38]
  wire  Ec_f32_is_not_zero = |Ec_f32; // @[FloatFMA.scala 134:38]
  wire [23:0] fp_a_significand_f32 = {Ea_f32_is_not_zero,fp_a_f32[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] fp_b_significand_f32 = {Eb_f32_is_not_zero,fp_b_f32[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] fp_c_significand_f32 = {Ec_f32_is_not_zero,fp_c_f32[22:0]}; // @[Cat.scala 33:92]
  wire  _Ea_fix_f32_T_3 = ~Ea_f32_is_not_zero | Ea_f32[0]; // @[FloatFMA.scala 154:72]
  wire [7:0] Ea_fix_f32 = {Ea_f32[7:1],_Ea_fix_f32_T_3}; // @[Cat.scala 33:92]
  wire  _Eb_fix_f32_T_3 = ~Eb_f32_is_not_zero | Eb_f32[0]; // @[FloatFMA.scala 155:72]
  wire [7:0] Eb_fix_f32 = {Eb_f32[7:1],_Eb_fix_f32_T_3}; // @[Cat.scala 33:92]
  wire  _Ec_fix_f32_T_3 = ~Ec_f32_is_not_zero | Ec_f32[0]; // @[FloatFMA.scala 156:72]
  wire [7:0] Ec_fix_f32 = {Ec_f32[7:1],_Ec_fix_f32_T_3}; // @[Cat.scala 33:92]
  wire [8:0] _Eab_f32_T = Ea_fix_f32 + Eb_fix_f32; // @[FloatFMA.scala 163:50]
  wire [9:0] _Eab_f32_T_2 = {1'h0,_Eab_f32_T}; // @[FloatFMA.scala 163:65]
  wire [9:0] _Eab_f32_T_5 = $signed(_Eab_f32_T_2) - 10'sh7f; // @[FloatFMA.scala 163:72]
  wire [9:0] Eab_f32 = $signed(_Eab_f32_T_5) + 10'sh1b; // @[FloatFMA.scala 163:84]
  wire [8:0] _rshift_value_f32_T = {1'h0,Ec_f32[7:1],_Ec_fix_f32_T_3}; // @[Cat.scala 33:92]
  wire [8:0] _rshift_value_f32_T_1 = {1'h0,Ec_f32[7:1],_Ec_fix_f32_T_3}; // @[FloatFMA.scala 168:61]
  wire [9:0] _GEN_183 = {{1{_rshift_value_f32_T_1[8]}},_rshift_value_f32_T_1}; // @[FloatFMA.scala 168:39]
  wire [9:0] rshift_value_f32 = $signed(Eab_f32) - $signed(_GEN_183); // @[FloatFMA.scala 168:39]
  wire [6:0] rshift_value_cut_f32 = rshift_value_f32[6:0]; // @[FloatFMA.scala 172:47]
  wire [75:0] fp_c_significand_cat0_f32 = {Ec_f32_is_not_zero,fp_c_f32[22:0],52'h0}; // @[Cat.scala 33:92]
  wire [75:0] rshift_result_with_grs_f32_res_vec_1 = rshift_value_cut_f32[0] ? {{1'd0}, fp_c_significand_cat0_f32[75:1]}
     : fp_c_significand_cat0_f32; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_1 = rshift_value_cut_f32[0] & |fp_c_significand_cat0_f32[0]; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_2 = rshift_value_cut_f32[1] ? {{2'd0},
    rshift_result_with_grs_f32_res_vec_1[75:2]} : rshift_result_with_grs_f32_res_vec_1; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_2 = rshift_value_cut_f32[1] ? rshift_result_with_grs_f32_sticky_vec_1 | |
    rshift_result_with_grs_f32_res_vec_1[1:0] : rshift_result_with_grs_f32_sticky_vec_1; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_3 = rshift_value_cut_f32[2] ? {{4'd0},
    rshift_result_with_grs_f32_res_vec_2[75:4]} : rshift_result_with_grs_f32_res_vec_2; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_3 = rshift_value_cut_f32[2] ? rshift_result_with_grs_f32_sticky_vec_2 | |
    rshift_result_with_grs_f32_res_vec_2[3:0] : rshift_result_with_grs_f32_sticky_vec_2; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_4 = rshift_value_cut_f32[3] ? {{8'd0},
    rshift_result_with_grs_f32_res_vec_3[75:8]} : rshift_result_with_grs_f32_res_vec_3; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_4 = rshift_value_cut_f32[3] ? rshift_result_with_grs_f32_sticky_vec_3 | |
    rshift_result_with_grs_f32_res_vec_3[7:0] : rshift_result_with_grs_f32_sticky_vec_3; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_5 = rshift_value_cut_f32[4] ? {{16'd0},
    rshift_result_with_grs_f32_res_vec_4[75:16]} : rshift_result_with_grs_f32_res_vec_4; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_5 = rshift_value_cut_f32[4] ? rshift_result_with_grs_f32_sticky_vec_4 | |
    rshift_result_with_grs_f32_res_vec_4[15:0] : rshift_result_with_grs_f32_sticky_vec_4; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_6 = rshift_value_cut_f32[5] ? {{32'd0},
    rshift_result_with_grs_f32_res_vec_5[75:32]} : rshift_result_with_grs_f32_res_vec_5; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_6 = rshift_value_cut_f32[5] ? rshift_result_with_grs_f32_sticky_vec_5 | |
    rshift_result_with_grs_f32_res_vec_5[31:0] : rshift_result_with_grs_f32_sticky_vec_5; // @[FloatFMA.scala 46:29]
  wire [75:0] rshift_result_with_grs_f32_res_vec_7 = rshift_value_cut_f32[6] ? {{64'd0},
    rshift_result_with_grs_f32_res_vec_6[75:64]} : rshift_result_with_grs_f32_res_vec_6; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f32_sticky_vec_7 = rshift_value_cut_f32[6] ? rshift_result_with_grs_f32_sticky_vec_6 | |
    rshift_result_with_grs_f32_res_vec_6[63:0] : rshift_result_with_grs_f32_sticky_vec_6; // @[FloatFMA.scala 46:29]
  wire [76:0] rshift_result_with_grs_f32 = {rshift_result_with_grs_f32_res_vec_7,rshift_result_with_grs_f32_sticky_vec_7
    }; // @[Cat.scala 33:92]
  wire  Ec_is_too_big_f32 = $signed(rshift_value_f32) <= 10'sh0; // @[FloatFMA.scala 185:53]
  wire  Ec_is_too_small_f32 = $signed(rshift_value_f32) > 10'sh4c; // @[FloatFMA.scala 189:60]
  wire  Ec_is_medium_f32 = ~Ec_is_too_big_f32 & ~Ec_is_too_small_f32; // @[FloatFMA.scala 193:55]
  reg  rshift_guard_f16; // @[Reg.scala 19:16]
  reg  rshift_round_f16; // @[Reg.scala 19:16]
  wire  _rshift_sticky_f32_reg_d_T_1 = |fp_c_significand_f32; // @[FloatFMA.scala 210:138]
  reg  rshift_sticky_f16; // @[Reg.scala 19:16]
  wire [73:0] rshift_result_temp_f32 = rshift_result_with_grs_f32[76:3]; // @[FloatFMA.scala 226:67]
  wire [73:0] _rshift_result_f32_T_1 = Ec_is_too_big_f32 ? fp_c_significand_cat0_f32[75:2] : 74'h0; // @[FloatFMA.scala 235:8]
  wire [73:0] rshift_result_f32 = Ec_is_medium_f32 ? rshift_result_temp_f32 : _rshift_result_f32_T_1; // @[FloatFMA.scala 233:39]
  wire [73:0] _fp_c_rshiftValue_inv_f32_reg_d_T_1 = ~rshift_result_f32; // @[FloatFMA.scala 243:71]
  wire [74:0] _fp_c_rshiftValue_inv_f32_reg_d_T_2 = {1'h1,_fp_c_rshiftValue_inv_f32_reg_d_T_1}; // @[Cat.scala 33:92]
  wire [74:0] _fp_c_rshiftValue_inv_f32_reg_d_T_3 = {1'h0,rshift_result_f32}; // @[Cat.scala 33:92]
  wire [74:0] fp_c_rshiftValue_inv_f32_reg_d = is_sub_f32 ? _fp_c_rshiftValue_inv_f32_reg_d_T_2 :
    _fp_c_rshiftValue_inv_f32_reg_d_T_3; // @[FloatFMA.scala 243:43]
  reg [161:0] fp_c_rshiftValue_inv_f64_reg0; // @[Reg.scala 19:16]
  wire [74:0] fp_c_rshiftValue_inv_f32_reg0 = fp_c_rshiftValue_inv_f64_reg0[74:0]; // @[FloatFMA.scala 248:64]
  wire  _CSA3to2_in_b_T_1 = ~rshift_guard_f16; // @[FloatFMA.scala 280:59]
  wire  _CSA3to2_in_b_T_3 = ~rshift_round_f16; // @[FloatFMA.scala 280:79]
  wire  _CSA3to2_in_b_T_5 = ~rshift_sticky_f16; // @[FloatFMA.scala 280:99]
  reg  CSA3to2_in_b_r; // @[Reg.scala 19:16]
  wire  _CSA3to2_in_b_T_16 = CSA3to2_in_b_r & _CSA3to2_in_b_T_1 & _CSA3to2_in_b_T_3 & _CSA3to2_in_b_T_5; // @[FloatFMA.scala 285:105]
  wire [48:0] CSA3to2_in_b_lo = {U_CSAnto2_io_out_car[48:1],_CSA3to2_in_b_T_16}; // @[Cat.scala 33:92]
  wire [57:0] CSA3to2_in_b_hi = {U_CSAnto2_io_out_car[106:59],1'h0,U_CSAnto2_io_out_car[57:49]}; // @[Cat.scala 33:92]
  wire [96:0] _CSA3to2_in_c_T_3 = {49'h0,fp_c_rshiftValue_inv_f32_reg0[47:0]}; // @[Cat.scala 33:92]
  wire [106:0] adder_lowbit_f64 = U_CSA3to2_io_out_sum + U_CSA3to2_io_out_car; // @[FloatFMA.scala 316:47]
  wire [48:0] adder_lowbit_f32 = adder_lowbit_f64[48:0]; // @[FloatFMA.scala 317:42]
  wire [26:0] fp_c_rshift_result_high_inv_add0_f32 = fp_c_rshiftValue_inv_f32_reg0[74:48]; // @[FloatFMA.scala 321:80]
  wire [58:0] _fp_c_rshift_result_high_inv_add1_T_3 = {32'h0,fp_c_rshift_result_high_inv_add0_f32}; // @[Cat.scala 33:92]
  wire [58:0] fp_c_rshift_result_high_inv_add1 = _fp_c_rshift_result_high_inv_add1_T_3 + 59'h1; // @[FloatFMA.scala 334:5]
  wire [26:0] fp_c_rshift_result_high_inv_add1_f32 = fp_c_rshift_result_high_inv_add1[26:0]; // @[FloatFMA.scala 337:78]
  wire [1:0] adder_f64_hi = {rshift_guard_f16,rshift_round_f16}; // @[Cat.scala 33:92]
  wire [2:0] _adder_f64_T_4 = {rshift_guard_f16,rshift_round_f16,rshift_sticky_f16}; // @[Cat.scala 33:92]
  wire [2:0] _adder_f64_T_5 = ~_adder_f64_T_4; // @[FloatFMA.scala 341:28]
  wire [2:0] _adder_f64_T_7 = _adder_f64_T_5 + 3'h1; // @[FloatFMA.scala 341:93]
  wire [26:0] _adder_f32_T_2 = adder_lowbit_f32[48] ? fp_c_rshift_result_high_inv_add1_f32 :
    fp_c_rshift_result_high_inv_add0_f32; // @[FloatFMA.scala 343:32]
  reg  adder_f32_r; // @[Reg.scala 19:16]
  wire [1:0] _adder_f32_T_10 = adder_f32_r ? _adder_f64_T_7[2:1] : adder_f64_hi; // @[FloatFMA.scala 344:8]
  wire [76:0] adder_f32 = {_adder_f32_T_2,adder_lowbit_f32[47:0],_adder_f32_T_10}; // @[Cat.scala 33:92]
  wire  adder_is_negative_f32 = adder_f32[76]; // @[FloatFMA.scala 351:45]
  reg  adder_is_negative_reg1; // @[Reg.scala 19:16]
  reg  adder_is_negative_f16_reg2; // @[Reg.scala 19:16]
  wire [75:0] _adder_inv_f32_T_1 = ~adder_f32[75:0]; // @[FloatFMA.scala 364:57]
  wire [75:0] adder_inv_f32 = adder_is_negative_f32 ? _adder_inv_f32_T_1 : adder_f32[75:0]; // @[FloatFMA.scala 364:32]
  wire  Eab_is_greater_f32 = $signed(rshift_value_f32) > 10'sh0; // @[FloatFMA.scala 368:48]
  wire [8:0] E_greater_f32_reg_d = Eab_is_greater_f32 ? Eab_f32[8:0] : _rshift_value_f32_T; // @[FloatFMA.scala 373:33]
  reg [11:0] E_greater_reg2_r; // @[Reg.scala 19:16]
  reg [11:0] E_greater_reg2_r_1; // @[Reg.scala 19:16]
  reg [11:0] E_greater_f64_reg2; // @[Reg.scala 19:16]
  wire [8:0] E_greater_f32_reg2 = E_greater_f64_reg2[8:0]; // @[FloatFMA.scala 379:42]
  wire [8:0] _lshift_value_max_f32_reg_d_T_2 = Eab_f32[8:0] - 9'h1; // @[FloatFMA.scala 384:81]
  wire [7:0] _lshift_value_max_f32_reg_d_T_4 = Ec_fix_f32 - 8'h1; // @[FloatFMA.scala 384:107]
  wire [8:0] _lshift_value_max_f32_reg_d_T_5 = {1'h0,_lshift_value_max_f32_reg_d_T_4}; // @[Cat.scala 33:92]
  wire [8:0] lshift_value_max_f32_reg_d = Eab_is_greater_f32 ? _lshift_value_max_f32_reg_d_T_2 :
    _lshift_value_max_f32_reg_d_T_5; // @[FloatFMA.scala 384:40]
  reg [11:0] lshift_value_max_f64_reg0; // @[Reg.scala 19:16]
  wire [8:0] lshift_value_max_f32_reg0 = lshift_value_max_f64_reg0[8:0]; // @[FloatFMA.scala 390:58]
  wire [75:0] _lshift_value_mask_f32_T_4 = 76'hfffffffffffffffffff >> lshift_value_max_f32_reg0[6:0]; // @[FloatFMA.scala 404:39]
  wire [75:0] lshift_value_mask_f32 = |lshift_value_max_f32_reg0[8:7] ? 76'h0 : _lshift_value_mask_f32_T_4; // @[FloatFMA.scala 402:34]
  wire [63:0] _GEN_202 = {{32'd0}, adder_f32[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_4 = _GEN_202 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_6 = {adder_f32[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_8 = _tzd_adder_f32_reg_d_T_6 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_9 = _tzd_adder_f32_reg_d_T_4 | _tzd_adder_f32_reg_d_T_8; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_203 = {{16'd0}, _tzd_adder_f32_reg_d_T_9[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_14 = _GEN_203 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_16 = {_tzd_adder_f32_reg_d_T_9[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_18 = _tzd_adder_f32_reg_d_T_16 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_19 = _tzd_adder_f32_reg_d_T_14 | _tzd_adder_f32_reg_d_T_18; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_204 = {{8'd0}, _tzd_adder_f32_reg_d_T_19[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_24 = _GEN_204 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_26 = {_tzd_adder_f32_reg_d_T_19[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_28 = _tzd_adder_f32_reg_d_T_26 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_29 = _tzd_adder_f32_reg_d_T_24 | _tzd_adder_f32_reg_d_T_28; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_205 = {{4'd0}, _tzd_adder_f32_reg_d_T_29[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_34 = _GEN_205 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_36 = {_tzd_adder_f32_reg_d_T_29[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_38 = _tzd_adder_f32_reg_d_T_36 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_39 = _tzd_adder_f32_reg_d_T_34 | _tzd_adder_f32_reg_d_T_38; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_206 = {{2'd0}, _tzd_adder_f32_reg_d_T_39[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_44 = _GEN_206 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_46 = {_tzd_adder_f32_reg_d_T_39[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_48 = _tzd_adder_f32_reg_d_T_46 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_49 = _tzd_adder_f32_reg_d_T_44 | _tzd_adder_f32_reg_d_T_48; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_207 = {{1'd0}, _tzd_adder_f32_reg_d_T_49[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_54 = _GEN_207 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg_d_T_56 = {_tzd_adder_f32_reg_d_T_49[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg_d_T_58 = _tzd_adder_f32_reg_d_T_56 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg_d_T_59 = _tzd_adder_f32_reg_d_T_54 | _tzd_adder_f32_reg_d_T_58; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_208 = {{4'd0}, adder_f32[71:68]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_65 = _GEN_208 & 8'hf; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_67 = {adder_f32[67:64], 4'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg_d_T_69 = _tzd_adder_f32_reg_d_T_67 & 8'hf0; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg_d_T_70 = _tzd_adder_f32_reg_d_T_65 | _tzd_adder_f32_reg_d_T_69; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_209 = {{2'd0}, _tzd_adder_f32_reg_d_T_70[7:2]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_75 = _GEN_209 & 8'h33; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_77 = {_tzd_adder_f32_reg_d_T_70[5:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg_d_T_79 = _tzd_adder_f32_reg_d_T_77 & 8'hcc; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg_d_T_80 = _tzd_adder_f32_reg_d_T_75 | _tzd_adder_f32_reg_d_T_79; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_210 = {{1'd0}, _tzd_adder_f32_reg_d_T_80[7:1]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_85 = _GEN_210 & 8'h55; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg_d_T_87 = {_tzd_adder_f32_reg_d_T_80[6:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg_d_T_89 = _tzd_adder_f32_reg_d_T_87 & 8'haa; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg_d_T_90 = _tzd_adder_f32_reg_d_T_85 | _tzd_adder_f32_reg_d_T_89; // @[Bitwise.scala 108:39]
  wire [76:0] tzd_adder_f32_reg_d = {_tzd_adder_f32_reg_d_T_59,_tzd_adder_f32_reg_d_T_90,adder_f32[72],adder_f32[73],
    adder_f32[74],adder_f32[75],adder_f32[76]}; // @[Cat.scala 33:92]
  wire [163:0] tzd_adder_reg_d = {{87'd0}, tzd_adder_f32_reg_d}; // @[FloatFMA.scala 415:37]
  reg [163:0] tzd_adder_reg1; // @[Reg.scala 19:16]
  wire [77:0] _tzd_adder_f32_reg1_T_1 = {tzd_adder_reg1[76:0],1'h1}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_233 = {{32'd0}, _tzd_adder_f32_reg1_T_1[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_6 = _GEN_233 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_8 = {_tzd_adder_f32_reg1_T_1[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_10 = _tzd_adder_f32_reg1_T_8 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_11 = _tzd_adder_f32_reg1_T_6 | _tzd_adder_f32_reg1_T_10; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_234 = {{16'd0}, _tzd_adder_f32_reg1_T_11[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_16 = _GEN_234 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_18 = {_tzd_adder_f32_reg1_T_11[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_20 = _tzd_adder_f32_reg1_T_18 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_21 = _tzd_adder_f32_reg1_T_16 | _tzd_adder_f32_reg1_T_20; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_235 = {{8'd0}, _tzd_adder_f32_reg1_T_21[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_26 = _GEN_235 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_28 = {_tzd_adder_f32_reg1_T_21[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_30 = _tzd_adder_f32_reg1_T_28 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_31 = _tzd_adder_f32_reg1_T_26 | _tzd_adder_f32_reg1_T_30; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_236 = {{4'd0}, _tzd_adder_f32_reg1_T_31[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_36 = _GEN_236 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_38 = {_tzd_adder_f32_reg1_T_31[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_40 = _tzd_adder_f32_reg1_T_38 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_41 = _tzd_adder_f32_reg1_T_36 | _tzd_adder_f32_reg1_T_40; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_237 = {{2'd0}, _tzd_adder_f32_reg1_T_41[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_46 = _GEN_237 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_48 = {_tzd_adder_f32_reg1_T_41[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_50 = _tzd_adder_f32_reg1_T_48 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_51 = _tzd_adder_f32_reg1_T_46 | _tzd_adder_f32_reg1_T_50; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_238 = {{1'd0}, _tzd_adder_f32_reg1_T_51[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_56 = _GEN_238 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f32_reg1_T_58 = {_tzd_adder_f32_reg1_T_51[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f32_reg1_T_60 = _tzd_adder_f32_reg1_T_58 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f32_reg1_T_61 = _tzd_adder_f32_reg1_T_56 | _tzd_adder_f32_reg1_T_60; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_239 = {{4'd0}, _tzd_adder_f32_reg1_T_1[71:68]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_67 = _GEN_239 & 8'hf; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_69 = {_tzd_adder_f32_reg1_T_1[67:64], 4'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg1_T_71 = _tzd_adder_f32_reg1_T_69 & 8'hf0; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg1_T_72 = _tzd_adder_f32_reg1_T_67 | _tzd_adder_f32_reg1_T_71; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_240 = {{2'd0}, _tzd_adder_f32_reg1_T_72[7:2]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_77 = _GEN_240 & 8'h33; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_79 = {_tzd_adder_f32_reg1_T_72[5:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg1_T_81 = _tzd_adder_f32_reg1_T_79 & 8'hcc; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg1_T_82 = _tzd_adder_f32_reg1_T_77 | _tzd_adder_f32_reg1_T_81; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_241 = {{1'd0}, _tzd_adder_f32_reg1_T_82[7:1]}; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_87 = _GEN_241 & 8'h55; // @[Bitwise.scala 108:31]
  wire [7:0] _tzd_adder_f32_reg1_T_89 = {_tzd_adder_f32_reg1_T_82[6:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _tzd_adder_f32_reg1_T_91 = _tzd_adder_f32_reg1_T_89 & 8'haa; // @[Bitwise.scala 108:80]
  wire [7:0] _tzd_adder_f32_reg1_T_92 = _tzd_adder_f32_reg1_T_87 | _tzd_adder_f32_reg1_T_91; // @[Bitwise.scala 108:39]
  wire [77:0] _tzd_adder_f32_reg1_T_110 = {_tzd_adder_f32_reg1_T_61,_tzd_adder_f32_reg1_T_92,_tzd_adder_f32_reg1_T_1[72]
    ,_tzd_adder_f32_reg1_T_1[73],_tzd_adder_f32_reg1_T_1[74],_tzd_adder_f32_reg1_T_1[75],_tzd_adder_f32_reg1_T_1[76],
    _tzd_adder_f32_reg1_T_1[77]}; // @[Cat.scala 33:92]
  wire [6:0] _tzd_adder_f32_reg1_T_189 = _tzd_adder_f32_reg1_T_110[76] ? 7'h4c : 7'h4d; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_190 = _tzd_adder_f32_reg1_T_110[75] ? 7'h4b : _tzd_adder_f32_reg1_T_189; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_191 = _tzd_adder_f32_reg1_T_110[74] ? 7'h4a : _tzd_adder_f32_reg1_T_190; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_192 = _tzd_adder_f32_reg1_T_110[73] ? 7'h49 : _tzd_adder_f32_reg1_T_191; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_193 = _tzd_adder_f32_reg1_T_110[72] ? 7'h48 : _tzd_adder_f32_reg1_T_192; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_194 = _tzd_adder_f32_reg1_T_110[71] ? 7'h47 : _tzd_adder_f32_reg1_T_193; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_195 = _tzd_adder_f32_reg1_T_110[70] ? 7'h46 : _tzd_adder_f32_reg1_T_194; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_196 = _tzd_adder_f32_reg1_T_110[69] ? 7'h45 : _tzd_adder_f32_reg1_T_195; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_197 = _tzd_adder_f32_reg1_T_110[68] ? 7'h44 : _tzd_adder_f32_reg1_T_196; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_198 = _tzd_adder_f32_reg1_T_110[67] ? 7'h43 : _tzd_adder_f32_reg1_T_197; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_199 = _tzd_adder_f32_reg1_T_110[66] ? 7'h42 : _tzd_adder_f32_reg1_T_198; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_200 = _tzd_adder_f32_reg1_T_110[65] ? 7'h41 : _tzd_adder_f32_reg1_T_199; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_201 = _tzd_adder_f32_reg1_T_110[64] ? 7'h40 : _tzd_adder_f32_reg1_T_200; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_202 = _tzd_adder_f32_reg1_T_110[63] ? 7'h3f : _tzd_adder_f32_reg1_T_201; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_203 = _tzd_adder_f32_reg1_T_110[62] ? 7'h3e : _tzd_adder_f32_reg1_T_202; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_204 = _tzd_adder_f32_reg1_T_110[61] ? 7'h3d : _tzd_adder_f32_reg1_T_203; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_205 = _tzd_adder_f32_reg1_T_110[60] ? 7'h3c : _tzd_adder_f32_reg1_T_204; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_206 = _tzd_adder_f32_reg1_T_110[59] ? 7'h3b : _tzd_adder_f32_reg1_T_205; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_207 = _tzd_adder_f32_reg1_T_110[58] ? 7'h3a : _tzd_adder_f32_reg1_T_206; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_208 = _tzd_adder_f32_reg1_T_110[57] ? 7'h39 : _tzd_adder_f32_reg1_T_207; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_209 = _tzd_adder_f32_reg1_T_110[56] ? 7'h38 : _tzd_adder_f32_reg1_T_208; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_210 = _tzd_adder_f32_reg1_T_110[55] ? 7'h37 : _tzd_adder_f32_reg1_T_209; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_211 = _tzd_adder_f32_reg1_T_110[54] ? 7'h36 : _tzd_adder_f32_reg1_T_210; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_212 = _tzd_adder_f32_reg1_T_110[53] ? 7'h35 : _tzd_adder_f32_reg1_T_211; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_213 = _tzd_adder_f32_reg1_T_110[52] ? 7'h34 : _tzd_adder_f32_reg1_T_212; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_214 = _tzd_adder_f32_reg1_T_110[51] ? 7'h33 : _tzd_adder_f32_reg1_T_213; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_215 = _tzd_adder_f32_reg1_T_110[50] ? 7'h32 : _tzd_adder_f32_reg1_T_214; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_216 = _tzd_adder_f32_reg1_T_110[49] ? 7'h31 : _tzd_adder_f32_reg1_T_215; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_217 = _tzd_adder_f32_reg1_T_110[48] ? 7'h30 : _tzd_adder_f32_reg1_T_216; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_218 = _tzd_adder_f32_reg1_T_110[47] ? 7'h2f : _tzd_adder_f32_reg1_T_217; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_219 = _tzd_adder_f32_reg1_T_110[46] ? 7'h2e : _tzd_adder_f32_reg1_T_218; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_220 = _tzd_adder_f32_reg1_T_110[45] ? 7'h2d : _tzd_adder_f32_reg1_T_219; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_221 = _tzd_adder_f32_reg1_T_110[44] ? 7'h2c : _tzd_adder_f32_reg1_T_220; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_222 = _tzd_adder_f32_reg1_T_110[43] ? 7'h2b : _tzd_adder_f32_reg1_T_221; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_223 = _tzd_adder_f32_reg1_T_110[42] ? 7'h2a : _tzd_adder_f32_reg1_T_222; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_224 = _tzd_adder_f32_reg1_T_110[41] ? 7'h29 : _tzd_adder_f32_reg1_T_223; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_225 = _tzd_adder_f32_reg1_T_110[40] ? 7'h28 : _tzd_adder_f32_reg1_T_224; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_226 = _tzd_adder_f32_reg1_T_110[39] ? 7'h27 : _tzd_adder_f32_reg1_T_225; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_227 = _tzd_adder_f32_reg1_T_110[38] ? 7'h26 : _tzd_adder_f32_reg1_T_226; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_228 = _tzd_adder_f32_reg1_T_110[37] ? 7'h25 : _tzd_adder_f32_reg1_T_227; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_229 = _tzd_adder_f32_reg1_T_110[36] ? 7'h24 : _tzd_adder_f32_reg1_T_228; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_230 = _tzd_adder_f32_reg1_T_110[35] ? 7'h23 : _tzd_adder_f32_reg1_T_229; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_231 = _tzd_adder_f32_reg1_T_110[34] ? 7'h22 : _tzd_adder_f32_reg1_T_230; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_232 = _tzd_adder_f32_reg1_T_110[33] ? 7'h21 : _tzd_adder_f32_reg1_T_231; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_233 = _tzd_adder_f32_reg1_T_110[32] ? 7'h20 : _tzd_adder_f32_reg1_T_232; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_234 = _tzd_adder_f32_reg1_T_110[31] ? 7'h1f : _tzd_adder_f32_reg1_T_233; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_235 = _tzd_adder_f32_reg1_T_110[30] ? 7'h1e : _tzd_adder_f32_reg1_T_234; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_236 = _tzd_adder_f32_reg1_T_110[29] ? 7'h1d : _tzd_adder_f32_reg1_T_235; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_237 = _tzd_adder_f32_reg1_T_110[28] ? 7'h1c : _tzd_adder_f32_reg1_T_236; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_238 = _tzd_adder_f32_reg1_T_110[27] ? 7'h1b : _tzd_adder_f32_reg1_T_237; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_239 = _tzd_adder_f32_reg1_T_110[26] ? 7'h1a : _tzd_adder_f32_reg1_T_238; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_240 = _tzd_adder_f32_reg1_T_110[25] ? 7'h19 : _tzd_adder_f32_reg1_T_239; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_241 = _tzd_adder_f32_reg1_T_110[24] ? 7'h18 : _tzd_adder_f32_reg1_T_240; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_242 = _tzd_adder_f32_reg1_T_110[23] ? 7'h17 : _tzd_adder_f32_reg1_T_241; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_243 = _tzd_adder_f32_reg1_T_110[22] ? 7'h16 : _tzd_adder_f32_reg1_T_242; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_244 = _tzd_adder_f32_reg1_T_110[21] ? 7'h15 : _tzd_adder_f32_reg1_T_243; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_245 = _tzd_adder_f32_reg1_T_110[20] ? 7'h14 : _tzd_adder_f32_reg1_T_244; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_246 = _tzd_adder_f32_reg1_T_110[19] ? 7'h13 : _tzd_adder_f32_reg1_T_245; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_247 = _tzd_adder_f32_reg1_T_110[18] ? 7'h12 : _tzd_adder_f32_reg1_T_246; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_248 = _tzd_adder_f32_reg1_T_110[17] ? 7'h11 : _tzd_adder_f32_reg1_T_247; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_249 = _tzd_adder_f32_reg1_T_110[16] ? 7'h10 : _tzd_adder_f32_reg1_T_248; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_250 = _tzd_adder_f32_reg1_T_110[15] ? 7'hf : _tzd_adder_f32_reg1_T_249; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_251 = _tzd_adder_f32_reg1_T_110[14] ? 7'he : _tzd_adder_f32_reg1_T_250; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_252 = _tzd_adder_f32_reg1_T_110[13] ? 7'hd : _tzd_adder_f32_reg1_T_251; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_253 = _tzd_adder_f32_reg1_T_110[12] ? 7'hc : _tzd_adder_f32_reg1_T_252; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_254 = _tzd_adder_f32_reg1_T_110[11] ? 7'hb : _tzd_adder_f32_reg1_T_253; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_255 = _tzd_adder_f32_reg1_T_110[10] ? 7'ha : _tzd_adder_f32_reg1_T_254; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_256 = _tzd_adder_f32_reg1_T_110[9] ? 7'h9 : _tzd_adder_f32_reg1_T_255; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_257 = _tzd_adder_f32_reg1_T_110[8] ? 7'h8 : _tzd_adder_f32_reg1_T_256; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_258 = _tzd_adder_f32_reg1_T_110[7] ? 7'h7 : _tzd_adder_f32_reg1_T_257; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_259 = _tzd_adder_f32_reg1_T_110[6] ? 7'h6 : _tzd_adder_f32_reg1_T_258; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_260 = _tzd_adder_f32_reg1_T_110[5] ? 7'h5 : _tzd_adder_f32_reg1_T_259; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_261 = _tzd_adder_f32_reg1_T_110[4] ? 7'h4 : _tzd_adder_f32_reg1_T_260; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_262 = _tzd_adder_f32_reg1_T_110[3] ? 7'h3 : _tzd_adder_f32_reg1_T_261; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_263 = _tzd_adder_f32_reg1_T_110[2] ? 7'h2 : _tzd_adder_f32_reg1_T_262; // @[Mux.scala 47:70]
  wire [6:0] _tzd_adder_f32_reg1_T_264 = _tzd_adder_f32_reg1_T_110[1] ? 7'h1 : _tzd_adder_f32_reg1_T_263; // @[Mux.scala 47:70]
  wire [6:0] tzd_adder_f32_reg1 = _tzd_adder_f32_reg1_T_110[0] ? 7'h0 : _tzd_adder_f32_reg1_T_264; // @[Mux.scala 47:70]
  wire [75:0] lzd_adder_inv_mask_f32_reg_d = adder_inv_f32 | lshift_value_mask_f32; // @[FloatFMA.scala 425:52]
  wire [162:0] lzd_adder_inv_mask_reg_d = {{87'd0}, lzd_adder_inv_mask_f32_reg_d}; // @[FloatFMA.scala 427:41]
  reg [162:0] lzd_adder_inv_mask_reg1; // @[Reg.scala 19:16]
  wire [76:0] _lzd_adder_inv_mask_f32_T_1 = {lzd_adder_inv_mask_reg1[75:0],1'h1}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_264 = {{32'd0}, _lzd_adder_inv_mask_f32_T_1[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_6 = _GEN_264 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_8 = {_lzd_adder_inv_mask_f32_T_1[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_10 = _lzd_adder_inv_mask_f32_T_8 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_11 = _lzd_adder_inv_mask_f32_T_6 | _lzd_adder_inv_mask_f32_T_10; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_265 = {{16'd0}, _lzd_adder_inv_mask_f32_T_11[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_16 = _GEN_265 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_18 = {_lzd_adder_inv_mask_f32_T_11[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_20 = _lzd_adder_inv_mask_f32_T_18 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_21 = _lzd_adder_inv_mask_f32_T_16 | _lzd_adder_inv_mask_f32_T_20; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_266 = {{8'd0}, _lzd_adder_inv_mask_f32_T_21[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_26 = _GEN_266 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_28 = {_lzd_adder_inv_mask_f32_T_21[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_30 = _lzd_adder_inv_mask_f32_T_28 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_31 = _lzd_adder_inv_mask_f32_T_26 | _lzd_adder_inv_mask_f32_T_30; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_267 = {{4'd0}, _lzd_adder_inv_mask_f32_T_31[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_36 = _GEN_267 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_38 = {_lzd_adder_inv_mask_f32_T_31[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_40 = _lzd_adder_inv_mask_f32_T_38 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_41 = _lzd_adder_inv_mask_f32_T_36 | _lzd_adder_inv_mask_f32_T_40; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_268 = {{2'd0}, _lzd_adder_inv_mask_f32_T_41[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_46 = _GEN_268 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_48 = {_lzd_adder_inv_mask_f32_T_41[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_50 = _lzd_adder_inv_mask_f32_T_48 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_51 = _lzd_adder_inv_mask_f32_T_46 | _lzd_adder_inv_mask_f32_T_50; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_269 = {{1'd0}, _lzd_adder_inv_mask_f32_T_51[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_56 = _GEN_269 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f32_T_58 = {_lzd_adder_inv_mask_f32_T_51[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f32_T_60 = _lzd_adder_inv_mask_f32_T_58 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f32_T_61 = _lzd_adder_inv_mask_f32_T_56 | _lzd_adder_inv_mask_f32_T_60; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_270 = {{4'd0}, _lzd_adder_inv_mask_f32_T_1[71:68]}; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_67 = _GEN_270 & 8'hf; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_69 = {_lzd_adder_inv_mask_f32_T_1[67:64], 4'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _lzd_adder_inv_mask_f32_T_71 = _lzd_adder_inv_mask_f32_T_69 & 8'hf0; // @[Bitwise.scala 108:80]
  wire [7:0] _lzd_adder_inv_mask_f32_T_72 = _lzd_adder_inv_mask_f32_T_67 | _lzd_adder_inv_mask_f32_T_71; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_271 = {{2'd0}, _lzd_adder_inv_mask_f32_T_72[7:2]}; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_77 = _GEN_271 & 8'h33; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_79 = {_lzd_adder_inv_mask_f32_T_72[5:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _lzd_adder_inv_mask_f32_T_81 = _lzd_adder_inv_mask_f32_T_79 & 8'hcc; // @[Bitwise.scala 108:80]
  wire [7:0] _lzd_adder_inv_mask_f32_T_82 = _lzd_adder_inv_mask_f32_T_77 | _lzd_adder_inv_mask_f32_T_81; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_272 = {{1'd0}, _lzd_adder_inv_mask_f32_T_82[7:1]}; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_87 = _GEN_272 & 8'h55; // @[Bitwise.scala 108:31]
  wire [7:0] _lzd_adder_inv_mask_f32_T_89 = {_lzd_adder_inv_mask_f32_T_82[6:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _lzd_adder_inv_mask_f32_T_91 = _lzd_adder_inv_mask_f32_T_89 & 8'haa; // @[Bitwise.scala 108:80]
  wire [7:0] _lzd_adder_inv_mask_f32_T_92 = _lzd_adder_inv_mask_f32_T_87 | _lzd_adder_inv_mask_f32_T_91; // @[Bitwise.scala 108:39]
  wire [76:0] _lzd_adder_inv_mask_f32_T_107 = {_lzd_adder_inv_mask_f32_T_61,_lzd_adder_inv_mask_f32_T_92,
    _lzd_adder_inv_mask_f32_T_1[72],_lzd_adder_inv_mask_f32_T_1[73],_lzd_adder_inv_mask_f32_T_1[74],
    _lzd_adder_inv_mask_f32_T_1[75],_lzd_adder_inv_mask_f32_T_1[76]}; // @[Cat.scala 33:92]
  wire [6:0] _lzd_adder_inv_mask_f32_T_185 = _lzd_adder_inv_mask_f32_T_107[75] ? 7'h4b : 7'h4c; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_186 = _lzd_adder_inv_mask_f32_T_107[74] ? 7'h4a : _lzd_adder_inv_mask_f32_T_185; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_187 = _lzd_adder_inv_mask_f32_T_107[73] ? 7'h49 : _lzd_adder_inv_mask_f32_T_186; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_188 = _lzd_adder_inv_mask_f32_T_107[72] ? 7'h48 : _lzd_adder_inv_mask_f32_T_187; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_189 = _lzd_adder_inv_mask_f32_T_107[71] ? 7'h47 : _lzd_adder_inv_mask_f32_T_188; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_190 = _lzd_adder_inv_mask_f32_T_107[70] ? 7'h46 : _lzd_adder_inv_mask_f32_T_189; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_191 = _lzd_adder_inv_mask_f32_T_107[69] ? 7'h45 : _lzd_adder_inv_mask_f32_T_190; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_192 = _lzd_adder_inv_mask_f32_T_107[68] ? 7'h44 : _lzd_adder_inv_mask_f32_T_191; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_193 = _lzd_adder_inv_mask_f32_T_107[67] ? 7'h43 : _lzd_adder_inv_mask_f32_T_192; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_194 = _lzd_adder_inv_mask_f32_T_107[66] ? 7'h42 : _lzd_adder_inv_mask_f32_T_193; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_195 = _lzd_adder_inv_mask_f32_T_107[65] ? 7'h41 : _lzd_adder_inv_mask_f32_T_194; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_196 = _lzd_adder_inv_mask_f32_T_107[64] ? 7'h40 : _lzd_adder_inv_mask_f32_T_195; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_197 = _lzd_adder_inv_mask_f32_T_107[63] ? 7'h3f : _lzd_adder_inv_mask_f32_T_196; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_198 = _lzd_adder_inv_mask_f32_T_107[62] ? 7'h3e : _lzd_adder_inv_mask_f32_T_197; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_199 = _lzd_adder_inv_mask_f32_T_107[61] ? 7'h3d : _lzd_adder_inv_mask_f32_T_198; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_200 = _lzd_adder_inv_mask_f32_T_107[60] ? 7'h3c : _lzd_adder_inv_mask_f32_T_199; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_201 = _lzd_adder_inv_mask_f32_T_107[59] ? 7'h3b : _lzd_adder_inv_mask_f32_T_200; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_202 = _lzd_adder_inv_mask_f32_T_107[58] ? 7'h3a : _lzd_adder_inv_mask_f32_T_201; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_203 = _lzd_adder_inv_mask_f32_T_107[57] ? 7'h39 : _lzd_adder_inv_mask_f32_T_202; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_204 = _lzd_adder_inv_mask_f32_T_107[56] ? 7'h38 : _lzd_adder_inv_mask_f32_T_203; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_205 = _lzd_adder_inv_mask_f32_T_107[55] ? 7'h37 : _lzd_adder_inv_mask_f32_T_204; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_206 = _lzd_adder_inv_mask_f32_T_107[54] ? 7'h36 : _lzd_adder_inv_mask_f32_T_205; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_207 = _lzd_adder_inv_mask_f32_T_107[53] ? 7'h35 : _lzd_adder_inv_mask_f32_T_206; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_208 = _lzd_adder_inv_mask_f32_T_107[52] ? 7'h34 : _lzd_adder_inv_mask_f32_T_207; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_209 = _lzd_adder_inv_mask_f32_T_107[51] ? 7'h33 : _lzd_adder_inv_mask_f32_T_208; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_210 = _lzd_adder_inv_mask_f32_T_107[50] ? 7'h32 : _lzd_adder_inv_mask_f32_T_209; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_211 = _lzd_adder_inv_mask_f32_T_107[49] ? 7'h31 : _lzd_adder_inv_mask_f32_T_210; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_212 = _lzd_adder_inv_mask_f32_T_107[48] ? 7'h30 : _lzd_adder_inv_mask_f32_T_211; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_213 = _lzd_adder_inv_mask_f32_T_107[47] ? 7'h2f : _lzd_adder_inv_mask_f32_T_212; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_214 = _lzd_adder_inv_mask_f32_T_107[46] ? 7'h2e : _lzd_adder_inv_mask_f32_T_213; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_215 = _lzd_adder_inv_mask_f32_T_107[45] ? 7'h2d : _lzd_adder_inv_mask_f32_T_214; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_216 = _lzd_adder_inv_mask_f32_T_107[44] ? 7'h2c : _lzd_adder_inv_mask_f32_T_215; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_217 = _lzd_adder_inv_mask_f32_T_107[43] ? 7'h2b : _lzd_adder_inv_mask_f32_T_216; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_218 = _lzd_adder_inv_mask_f32_T_107[42] ? 7'h2a : _lzd_adder_inv_mask_f32_T_217; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_219 = _lzd_adder_inv_mask_f32_T_107[41] ? 7'h29 : _lzd_adder_inv_mask_f32_T_218; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_220 = _lzd_adder_inv_mask_f32_T_107[40] ? 7'h28 : _lzd_adder_inv_mask_f32_T_219; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_221 = _lzd_adder_inv_mask_f32_T_107[39] ? 7'h27 : _lzd_adder_inv_mask_f32_T_220; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_222 = _lzd_adder_inv_mask_f32_T_107[38] ? 7'h26 : _lzd_adder_inv_mask_f32_T_221; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_223 = _lzd_adder_inv_mask_f32_T_107[37] ? 7'h25 : _lzd_adder_inv_mask_f32_T_222; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_224 = _lzd_adder_inv_mask_f32_T_107[36] ? 7'h24 : _lzd_adder_inv_mask_f32_T_223; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_225 = _lzd_adder_inv_mask_f32_T_107[35] ? 7'h23 : _lzd_adder_inv_mask_f32_T_224; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_226 = _lzd_adder_inv_mask_f32_T_107[34] ? 7'h22 : _lzd_adder_inv_mask_f32_T_225; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_227 = _lzd_adder_inv_mask_f32_T_107[33] ? 7'h21 : _lzd_adder_inv_mask_f32_T_226; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_228 = _lzd_adder_inv_mask_f32_T_107[32] ? 7'h20 : _lzd_adder_inv_mask_f32_T_227; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_229 = _lzd_adder_inv_mask_f32_T_107[31] ? 7'h1f : _lzd_adder_inv_mask_f32_T_228; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_230 = _lzd_adder_inv_mask_f32_T_107[30] ? 7'h1e : _lzd_adder_inv_mask_f32_T_229; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_231 = _lzd_adder_inv_mask_f32_T_107[29] ? 7'h1d : _lzd_adder_inv_mask_f32_T_230; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_232 = _lzd_adder_inv_mask_f32_T_107[28] ? 7'h1c : _lzd_adder_inv_mask_f32_T_231; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_233 = _lzd_adder_inv_mask_f32_T_107[27] ? 7'h1b : _lzd_adder_inv_mask_f32_T_232; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_234 = _lzd_adder_inv_mask_f32_T_107[26] ? 7'h1a : _lzd_adder_inv_mask_f32_T_233; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_235 = _lzd_adder_inv_mask_f32_T_107[25] ? 7'h19 : _lzd_adder_inv_mask_f32_T_234; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_236 = _lzd_adder_inv_mask_f32_T_107[24] ? 7'h18 : _lzd_adder_inv_mask_f32_T_235; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_237 = _lzd_adder_inv_mask_f32_T_107[23] ? 7'h17 : _lzd_adder_inv_mask_f32_T_236; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_238 = _lzd_adder_inv_mask_f32_T_107[22] ? 7'h16 : _lzd_adder_inv_mask_f32_T_237; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_239 = _lzd_adder_inv_mask_f32_T_107[21] ? 7'h15 : _lzd_adder_inv_mask_f32_T_238; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_240 = _lzd_adder_inv_mask_f32_T_107[20] ? 7'h14 : _lzd_adder_inv_mask_f32_T_239; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_241 = _lzd_adder_inv_mask_f32_T_107[19] ? 7'h13 : _lzd_adder_inv_mask_f32_T_240; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_242 = _lzd_adder_inv_mask_f32_T_107[18] ? 7'h12 : _lzd_adder_inv_mask_f32_T_241; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_243 = _lzd_adder_inv_mask_f32_T_107[17] ? 7'h11 : _lzd_adder_inv_mask_f32_T_242; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_244 = _lzd_adder_inv_mask_f32_T_107[16] ? 7'h10 : _lzd_adder_inv_mask_f32_T_243; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_245 = _lzd_adder_inv_mask_f32_T_107[15] ? 7'hf : _lzd_adder_inv_mask_f32_T_244; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_246 = _lzd_adder_inv_mask_f32_T_107[14] ? 7'he : _lzd_adder_inv_mask_f32_T_245; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_247 = _lzd_adder_inv_mask_f32_T_107[13] ? 7'hd : _lzd_adder_inv_mask_f32_T_246; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_248 = _lzd_adder_inv_mask_f32_T_107[12] ? 7'hc : _lzd_adder_inv_mask_f32_T_247; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_249 = _lzd_adder_inv_mask_f32_T_107[11] ? 7'hb : _lzd_adder_inv_mask_f32_T_248; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_250 = _lzd_adder_inv_mask_f32_T_107[10] ? 7'ha : _lzd_adder_inv_mask_f32_T_249; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_251 = _lzd_adder_inv_mask_f32_T_107[9] ? 7'h9 : _lzd_adder_inv_mask_f32_T_250; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_252 = _lzd_adder_inv_mask_f32_T_107[8] ? 7'h8 : _lzd_adder_inv_mask_f32_T_251; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_253 = _lzd_adder_inv_mask_f32_T_107[7] ? 7'h7 : _lzd_adder_inv_mask_f32_T_252; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_254 = _lzd_adder_inv_mask_f32_T_107[6] ? 7'h6 : _lzd_adder_inv_mask_f32_T_253; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_255 = _lzd_adder_inv_mask_f32_T_107[5] ? 7'h5 : _lzd_adder_inv_mask_f32_T_254; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_256 = _lzd_adder_inv_mask_f32_T_107[4] ? 7'h4 : _lzd_adder_inv_mask_f32_T_255; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_257 = _lzd_adder_inv_mask_f32_T_107[3] ? 7'h3 : _lzd_adder_inv_mask_f32_T_256; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_258 = _lzd_adder_inv_mask_f32_T_107[2] ? 7'h2 : _lzd_adder_inv_mask_f32_T_257; // @[Mux.scala 47:70]
  wire [6:0] _lzd_adder_inv_mask_f32_T_259 = _lzd_adder_inv_mask_f32_T_107[1] ? 7'h1 : _lzd_adder_inv_mask_f32_T_258; // @[Mux.scala 47:70]
  wire [6:0] lzd_adder_inv_mask_f32 = _lzd_adder_inv_mask_f32_T_107[0] ? 7'h0 : _lzd_adder_inv_mask_f32_T_259; // @[Mux.scala 47:70]
  wire  lshift_mask_valid_f32_reg_d = lzd_adder_inv_mask_f32_reg_d == lshift_value_mask_f32; // @[FloatFMA.scala 443:77]
  reg  lshift_mask_valid_f16_reg1; // @[Reg.scala 19:16]
  reg [76:0] adder_f32_reg1; // @[Reg.scala 19:16]
  wire [140:0] _lshift_adder_f32_res_vec_1_T_1 = {adder_f32_reg1, 64'h0}; // @[FloatFMA.scala 33:75]
  wire [140:0] _lshift_adder_f32_res_vec_1_T_2 = lzd_adder_inv_mask_f32[6] ? _lshift_adder_f32_res_vec_1_T_1 : {{64
    'd0}, adder_f32_reg1}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_1 = _lshift_adder_f32_res_vec_1_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [108:0] _lshift_adder_f32_res_vec_2_T_1 = {lshift_adder_f32_res_vec_1, 32'h0}; // @[FloatFMA.scala 33:75]
  wire [108:0] _lshift_adder_f32_res_vec_2_T_2 = lzd_adder_inv_mask_f32[5] ? _lshift_adder_f32_res_vec_2_T_1 : {{32
    'd0}, lshift_adder_f32_res_vec_1}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_2 = _lshift_adder_f32_res_vec_2_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [92:0] _lshift_adder_f32_res_vec_3_T_1 = {lshift_adder_f32_res_vec_2, 16'h0}; // @[FloatFMA.scala 33:75]
  wire [92:0] _lshift_adder_f32_res_vec_3_T_2 = lzd_adder_inv_mask_f32[4] ? _lshift_adder_f32_res_vec_3_T_1 : {{16'd0},
    lshift_adder_f32_res_vec_2}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_3 = _lshift_adder_f32_res_vec_3_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [84:0] _lshift_adder_f32_res_vec_4_T_1 = {lshift_adder_f32_res_vec_3, 8'h0}; // @[FloatFMA.scala 33:75]
  wire [84:0] _lshift_adder_f32_res_vec_4_T_2 = lzd_adder_inv_mask_f32[3] ? _lshift_adder_f32_res_vec_4_T_1 : {{8'd0},
    lshift_adder_f32_res_vec_3}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_4 = _lshift_adder_f32_res_vec_4_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [80:0] _lshift_adder_f32_res_vec_5_T_1 = {lshift_adder_f32_res_vec_4, 4'h0}; // @[FloatFMA.scala 33:75]
  wire [80:0] _lshift_adder_f32_res_vec_5_T_2 = lzd_adder_inv_mask_f32[2] ? _lshift_adder_f32_res_vec_5_T_1 : {{4'd0},
    lshift_adder_f32_res_vec_4}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_5 = _lshift_adder_f32_res_vec_5_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [78:0] _lshift_adder_f32_res_vec_6_T_1 = {lshift_adder_f32_res_vec_5, 2'h0}; // @[FloatFMA.scala 33:75]
  wire [78:0] _lshift_adder_f32_res_vec_6_T_2 = lzd_adder_inv_mask_f32[1] ? _lshift_adder_f32_res_vec_6_T_1 : {{2'd0},
    lshift_adder_f32_res_vec_5}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_6 = _lshift_adder_f32_res_vec_6_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [77:0] _lshift_adder_f32_res_vec_7_T_1 = {lshift_adder_f32_res_vec_6, 1'h0}; // @[FloatFMA.scala 33:75]
  wire [77:0] _lshift_adder_f32_res_vec_7_T_2 = lzd_adder_inv_mask_f32[0] ? _lshift_adder_f32_res_vec_7_T_1 : {{1'd0},
    lshift_adder_f32_res_vec_6}; // @[FloatFMA.scala 33:26]
  wire [76:0] lshift_adder_f32_res_vec_7 = _lshift_adder_f32_res_vec_7_T_2[76:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [27:0] _lshift_adder_inv_f32_T_1 = ~lshift_adder_f32_res_vec_7[76:49]; // @[FloatFMA.scala 469:64]
  wire [27:0] _lshift_adder_inv_f32_T_3 = adder_is_negative_reg1 ? _lshift_adder_inv_f32_T_1 :
    lshift_adder_f32_res_vec_7[76:49]; // @[FloatFMA.scala 469:40]
  wire [76:0] lshift_adder_inv_f32 = {_lshift_adder_inv_f32_T_3,lshift_adder_f32_res_vec_7[48:0]}; // @[Cat.scala 33:92]
  wire [6:0] _is_fix_f32_T_1 = tzd_adder_f32_reg1 + lzd_adder_inv_mask_f32; // @[FloatFMA.scala 473:40]
  wire  is_fix_f32 = _is_fix_f32_T_1 == 7'h4c; // @[FloatFMA.scala 473:71]
  wire [75:0] lshift_adder_inv_fix_f32 = is_fix_f32 ? lshift_adder_inv_f32[76:1] : lshift_adder_inv_f32[75:0]; // @[FloatFMA.scala 477:37]
  wire [22:0] fraction_result_no_round_f32_reg_d = lshift_adder_inv_fix_f32[74:52]; // @[FloatFMA.scala 482:81]
  wire [51:0] fraction_result_no_round_reg_d = {{29'd0}, fraction_result_no_round_f32_reg_d}; // @[FloatFMA.scala 484:47]
  reg [51:0] fraction_result_no_round_f64_reg2; // @[Reg.scala 19:16]
  wire [22:0] fraction_result_no_round_f32_reg2 = fraction_result_no_round_f64_reg2[22:0]; // @[FloatFMA.scala 489:72]
  reg  sign_result_temp_f32_reg2_r; // @[Reg.scala 19:16]
  reg  sign_result_temp_f32_reg2_r_1; // @[Reg.scala 19:16]
  reg  sign_result_temp_f32_reg2_r_2; // @[Reg.scala 19:16]
  reg  sign_result_temp_f32_reg2; // @[Reg.scala 19:16]
  reg  sticky_f32_reg2_r; // @[Reg.scala 19:16]
  wire [6:0] _sticky_f32_reg2_T_1 = lzd_adder_inv_mask_f32 + tzd_adder_f32_reg1; // @[FloatFMA.scala 514:107]
  wire  _sticky_f32_reg2_T_3 = sticky_f32_reg2_r | _sticky_f32_reg2_T_1 < 7'h32; // @[FloatFMA.scala 514:76]
  reg  sticky_f32_reg2; // @[Reg.scala 19:16]
  reg  sticky_uf_f32_reg2_r; // @[Reg.scala 19:16]
  wire  _sticky_uf_f32_reg2_T_3 = sticky_uf_f32_reg2_r | _sticky_f32_reg2_T_1 < 7'h31; // @[FloatFMA.scala 518:79]
  reg  sticky_uf_f32_reg2; // @[Reg.scala 19:16]
  reg  round_lshift_f32_reg2; // @[Reg.scala 19:16]
  reg  guard_lshift_f32_reg2; // @[Reg.scala 19:16]
  wire  _round_f32_T = ~sticky_f32_reg2; // @[FloatFMA.scala 531:77]
  wire  guard_uf_f32 = adder_is_negative_f16_reg2 ? round_lshift_f32_reg2 ^ ~sticky_f32_reg2 : round_lshift_f32_reg2; // @[FloatFMA.scala 531:24]
  wire  guard_f32 = adder_is_negative_f16_reg2 ? guard_lshift_f32_reg2 ^ _round_f32_T & round_lshift_f32_reg2 :
    guard_lshift_f32_reg2; // @[FloatFMA.scala 535:24]
  reg  round_lshift_uf_f32_reg2; // @[Reg.scala 19:16]
  wire  round_uf_f32 = adder_is_negative_f16_reg2 ? round_lshift_uf_f32_reg2 ^ ~sticky_uf_f32_reg2 :
    round_lshift_uf_f32_reg2; // @[FloatFMA.scala 547:27]
  wire  _round_add1_f32_T_3 = guard_f32 & (fraction_result_no_round_f32_reg2[0] | guard_uf_f32 | sticky_f32_reg2); // @[FloatFMA.scala 557:43]
  wire  _round_add1_f32_T_7 = guard_f32 | guard_uf_f32 | sticky_f32_reg2; // @[FloatFMA.scala 558:64]
  wire  _round_add1_f32_T_23 = adder_is_negative_f16_reg2 & ~guard_f32 & ~guard_uf_f32 & _round_f32_T; // @[FloatFMA.scala 561:58]
  wire  round_add1_f32 = _round_add1_f32_T_3 | _round_add1_f32_T_23; // @[FloatFMA.scala 560:26]
  wire  round_add1_uf_f32 = guard_uf_f32 & (guard_f32 | round_uf_f32 | sticky_uf_f32_reg2); // @[FloatFMA.scala 573:52]
  wire  exponent_add_1_f32 = &fraction_result_no_round_f32_reg2 & round_add1_f32; // @[FloatFMA.scala 583:67]
  reg  is_fix_reg2; // @[Reg.scala 19:16]
  wire [7:0] lshift_value_reg_d = {{1'd0}, lzd_adder_inv_mask_f32}; // @[FloatFMA.scala 590:42]
  reg [7:0] lshift_value_reg2; // @[Reg.scala 19:16]
  wire [8:0] _GEN_280 = {{2'd0}, lshift_value_reg2[6:0]}; // @[FloatFMA.scala 598:24]
  wire [8:0] _exponent_result_add_value_f32_T_3 = E_greater_f32_reg2 - _GEN_280; // @[FloatFMA.scala 598:24]
  wire [8:0] _exponent_result_add_value_f32_T_5 = _exponent_result_add_value_f32_T_3 + 9'h1; // @[FloatFMA.scala 598:49]
  wire [8:0] exponent_result_add_value_f32 = exponent_add_1_f32 | is_fix_reg2 ? _exponent_result_add_value_f32_T_5 :
    _exponent_result_add_value_f32_T_3; // @[FloatFMA.scala 597:42]
  wire  exponent_overflow_f32 = exponent_result_add_value_f32[8] | &exponent_result_add_value_f32[7:0]; // @[FloatFMA.scala 607:84]
  wire  _exponent_is_min_f32_T_5 = ~lshift_adder_inv_fix_f32[75] & lshift_mask_valid_f16_reg1 & ~is_fix_f32; // @[FloatFMA.scala 612:119]
  reg  exponent_is_min_f32; // @[Reg.scala 19:16]
  wire [4:0] _exponent_result_temp_f32_T = {4'h0,exponent_add_1_f32}; // @[Cat.scala 33:92]
  wire [7:0] exponent_result_temp_f32 = exponent_is_min_f32 ? {{3'd0}, _exponent_result_temp_f32_T} :
    exponent_result_add_value_f32[7:0]; // @[FloatFMA.scala 619:42]
  wire [22:0] _fraction_result_temp_f32_T_1 = fraction_result_no_round_f32_reg2 + 23'h1; // @[FloatFMA.scala 628:92]
  wire [22:0] fraction_result_temp_f32 = round_add1_f32 ? _fraction_result_temp_f32_T_1 :
    fraction_result_no_round_f32_reg2; // @[FloatFMA.scala 628:38]
  wire  UF_f32 = _round_add1_f32_T_7 & exponent_is_min_f32 & (~exponent_add_1_f32 | ~(guard_f32 & round_add1_uf_f32)); // @[FloatFMA.scala 642:42]
  wire [4:0] _fflags_f32_T = {3'h0,UF_f32,_round_add1_f32_T_7}; // @[Cat.scala 33:92]
  wire  fp_a_is_zero_f32 = ~(|fp_a_significand_f32); // @[FloatFMA.scala 646:53]
  wire  fp_b_is_zero_f32 = ~(|fp_b_significand_f32); // @[FloatFMA.scala 649:53]
  wire  fp_c_is_zero_f32 = ~_rshift_sticky_f32_reg_d_T_1; // @[FloatFMA.scala 652:53]
  wire  _normal_result_is_zero_f32_reg2_T_1 = ~(|adder_f32); // @[FloatFMA.scala 657:60]
  reg  normal_result_is_zero_f32_reg2_r; // @[Reg.scala 19:16]
  reg  normal_result_is_zero_f32_reg2; // @[Reg.scala 19:16]
  reg  has_zero_f32_reg2_r; // @[Reg.scala 19:16]
  reg  has_zero_f32_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_zero_f32_reg2_r_2; // @[Reg.scala 19:16]
  wire  has_zero_f32_reg2 = has_zero_f32_reg2_r_2 | normal_result_is_zero_f32_reg2; // @[FloatFMA.scala 661:143]
  wire [31:0] normal_result_f32 = {sign_result_temp_f32_reg2,exponent_result_temp_f32,fraction_result_temp_f32}; // @[Cat.scala 33:92]
  wire [31:0] result_overflow_up_f32 = {sign_result_temp_f32_reg2,8'hff,23'h0}; // @[Cat.scala 33:92]
  wire  _fp_a_is_nan_f32_T = &Ea_f32; // @[FloatFMA.scala 679:58]
  wire  _fp_a_is_nan_f32_T_2 = |fp_a_significand_f32[22:0]; // @[FloatFMA.scala 679:94]
  wire  fp_a_is_nan_f32 = &Ea_f32 & |fp_a_significand_f32[22:0]; // @[FloatFMA.scala 679:63]
  wire  _fp_b_is_nan_f32_T = &Eb_f32; // @[FloatFMA.scala 682:58]
  wire  _fp_b_is_nan_f32_T_2 = |fp_b_significand_f32[22:0]; // @[FloatFMA.scala 682:94]
  wire  fp_b_is_nan_f32 = &Eb_f32 & |fp_b_significand_f32[22:0]; // @[FloatFMA.scala 682:63]
  wire  _fp_c_is_nan_f32_T = &Ec_f32; // @[FloatFMA.scala 685:58]
  wire  _fp_c_is_nan_f32_T_2 = |fp_c_significand_f32[22:0]; // @[FloatFMA.scala 685:94]
  wire  fp_c_is_nan_f32 = &Ec_f32 & |fp_c_significand_f32[22:0]; // @[FloatFMA.scala 685:63]
  wire  fp_a_is_snan_f32 = _fp_a_is_nan_f32_T & ~fp_a_significand_f32[22] & |fp_a_significand_f32[21:0]; // @[FloatFMA.scala 693:106]
  wire  fp_b_is_snan_f32 = _fp_b_is_nan_f32_T & ~fp_b_significand_f32[22] & |fp_b_significand_f32[21:0]; // @[FloatFMA.scala 696:106]
  wire  fp_c_is_snan_f32 = _fp_c_is_nan_f32_T & ~fp_c_significand_f32[22] & |fp_c_significand_f32[21:0]; // @[FloatFMA.scala 699:106]
  wire  has_snan_f32 = fp_a_is_snan_f32 | fp_b_is_snan_f32 | fp_c_is_snan_f32; // @[FloatFMA.scala 703:58]
  wire  fp_a_is_inf_f32 = _fp_a_is_nan_f32_T & ~_fp_a_is_nan_f32_T_2; // @[FloatFMA.scala 707:64]
  wire  fp_b_is_inf_f32 = _fp_b_is_nan_f32_T & ~_fp_b_is_nan_f32_T_2; // @[FloatFMA.scala 710:64]
  wire  fp_c_is_inf_f32 = _fp_c_is_nan_f32_T & ~_fp_c_is_nan_f32_T_2; // @[FloatFMA.scala 713:64]
  wire  _has_inf_f32_T = fp_a_is_inf_f32 | fp_b_is_inf_f32; // @[FloatFMA.scala 717:37]
  wire  _fp_result_f32_fp_a_or_b_is_zero_T_4 = is_fmul ? sign_a_b_f32 : sign_a_b_f32 & sign_c_f32; // @[FloatFMA.scala 744:10]
  wire  _fp_result_f32_fp_a_or_b_is_zero_T_6 = fp_c_is_zero_f32 ? _fp_result_f32_fp_a_or_b_is_zero_T_4 : sign_c_f32; // @[FloatFMA.scala 742:8]
  wire [31:0] fp_result_f32_fp_a_or_b_is_zero = {_fp_result_f32_fp_a_or_b_is_zero_T_6,fp_c_f32[30:0]}; // @[Cat.scala 33:92]
  reg [63:0] fp_result_fp_a_or_b_is_zero_reg_r; // @[Reg.scala 19:16]
  reg [63:0] fp_result_fp_a_or_b_is_zero_reg_r_1; // @[Reg.scala 19:16]
  reg [63:0] fp_result_f64_fp_a_or_b_is_zero_reg2; // @[Reg.scala 19:16]
  reg  has_nan_f32_reg2_r; // @[Reg.scala 19:16]
  reg  has_nan_f32_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_nan_f32_reg2; // @[Reg.scala 19:16]
  wire  _has_nan_f32_is_NV_reg2_T_1 = fp_a_is_inf_f32 & fp_b_is_zero_f32; // @[FloatFMA.scala 799:44]
  wire  _has_nan_f32_is_NV_reg2_T_3 = fp_a_is_zero_f32 & fp_b_is_inf_f32; // @[FloatFMA.scala 799:84]
  reg  has_nan_f32_is_NV_reg2_r; // @[Reg.scala 19:16]
  reg  has_nan_f32_is_NV_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_nan_f32_is_NV_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f32_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f32_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f32_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f32_is_NV_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f32_is_NV_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f32_is_NV_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f32_result_inf_sign_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f32_result_inf_sign_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f32_result_inf_sign_reg2; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f32_reg2_r; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f32_reg2_r_1; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f32_reg2; // @[Reg.scala 19:16]
  wire [31:0] fp_result_f32_fp_a_or_b_is_zero_reg2 = fp_result_f64_fp_a_or_b_is_zero_reg2[31:0]; // @[FloatFMA.scala 810:77]
  wire [4:0] _fflags_f32_T_1 = has_nan_f32_is_NV_reg2 ? 5'h10 : 5'h0; // @[FloatFMA.scala 813:22]
  wire [31:0] _fp_result_f32_T = {has_inf_f32_result_inf_sign_reg2,31'h7f800000}; // @[Cat.scala 33:92]
  wire [31:0] _fp_result_f32_T_1 = has_inf_f32_is_NV_reg2 ? 32'h7fc00000 : _fp_result_f32_T; // @[FloatFMA.scala 815:25]
  wire [4:0] _fflags_f32_T_2 = has_inf_f32_is_NV_reg2 ? 5'h10 : 5'h0; // @[FloatFMA.scala 816:22]
  wire [31:0] _fp_result_f32_T_4 = normal_result_is_zero_f32_reg2 ? 32'h0 : normal_result_f32; // @[FloatFMA.scala 823:10]
  wire [31:0] _fp_result_f32_T_5 = fp_a_or_b_is_zero_f32_reg2 ? fp_result_f32_fp_a_or_b_is_zero_reg2 :
    _fp_result_f32_T_4; // @[FloatFMA.scala 821:25]
  wire [4:0] _fflags_f32_T_5 = fp_a_or_b_is_zero_f32_reg2 | normal_result_is_zero_f32_reg2 ? 5'h0 : _fflags_f32_T; // @[FloatFMA.scala 825:22]
  wire [31:0] _GEN_148 = has_zero_f32_reg2 ? _fp_result_f32_T_5 : normal_result_f32; // @[FloatFMA.scala 820:32 821:19 827:19]
  wire [4:0] _GEN_149 = has_zero_f32_reg2 ? _fflags_f32_T_5 : _fflags_f32_T; // @[FloatFMA.scala 820:32 825:16 636:28]
  wire [31:0] _GEN_150 = exponent_overflow_f32 ? result_overflow_up_f32 : _GEN_148; // @[FloatFMA.scala 817:35 818:19]
  wire [4:0] _GEN_151 = exponent_overflow_f32 ? 5'h5 : _GEN_149; // @[FloatFMA.scala 817:35 819:16]
  wire [31:0] _GEN_152 = has_inf_f32_reg2 ? _fp_result_f32_T_1 : _GEN_150; // @[FloatFMA.scala 814:31 815:19]
  wire [4:0] _GEN_153 = has_inf_f32_reg2 ? _fflags_f32_T_2 : _GEN_151; // @[FloatFMA.scala 814:31 816:16]
  wire [31:0] fp_result_f32 = has_nan_f32_reg2 ? 32'h7fc00000 : _GEN_152; // @[FloatFMA.scala 811:25 812:19]
  BoothEncoderF64F32F16 U_BoothEncoder ( // @[FloatFMA.scala 268:30]
    .io_in_a(U_BoothEncoder_io_in_a),
    .io_in_b(U_BoothEncoder_io_in_b),
    .io_out_pp_0(U_BoothEncoder_io_out_pp_0),
    .io_out_pp_1(U_BoothEncoder_io_out_pp_1),
    .io_out_pp_2(U_BoothEncoder_io_out_pp_2),
    .io_out_pp_3(U_BoothEncoder_io_out_pp_3),
    .io_out_pp_4(U_BoothEncoder_io_out_pp_4),
    .io_out_pp_5(U_BoothEncoder_io_out_pp_5),
    .io_out_pp_6(U_BoothEncoder_io_out_pp_6),
    .io_out_pp_7(U_BoothEncoder_io_out_pp_7),
    .io_out_pp_8(U_BoothEncoder_io_out_pp_8),
    .io_out_pp_9(U_BoothEncoder_io_out_pp_9),
    .io_out_pp_10(U_BoothEncoder_io_out_pp_10),
    .io_out_pp_11(U_BoothEncoder_io_out_pp_11),
    .io_out_pp_12(U_BoothEncoder_io_out_pp_12)
  );
  CSA_Nto2With3to2MainPipeline U_CSAnto2 ( // @[FloatFMA.scala 273:25]
    .clock(U_CSAnto2_clock),
    .io_in_0(U_CSAnto2_io_in_0),
    .io_in_1(U_CSAnto2_io_in_1),
    .io_in_2(U_CSAnto2_io_in_2),
    .io_in_3(U_CSAnto2_io_in_3),
    .io_in_4(U_CSAnto2_io_in_4),
    .io_in_5(U_CSAnto2_io_in_5),
    .io_in_6(U_CSAnto2_io_in_6),
    .io_in_7(U_CSAnto2_io_in_7),
    .io_in_8(U_CSAnto2_io_in_8),
    .io_in_9(U_CSAnto2_io_in_9),
    .io_in_10(U_CSAnto2_io_in_10),
    .io_in_11(U_CSAnto2_io_in_11),
    .io_in_12(U_CSAnto2_io_in_12),
    .io_out_sum(U_CSAnto2_io_out_sum),
    .io_out_car(U_CSAnto2_io_out_car)
  );
  CSA3to2 U_CSA3to2 ( // @[FloatFMA.scala 311:25]
    .io_in_a(U_CSA3to2_io_in_a),
    .io_in_b(U_CSA3to2_io_in_b),
    .io_in_c(U_CSA3to2_io_in_c),
    .io_out_sum(U_CSA3to2_io_out_sum),
    .io_out_car(U_CSA3to2_io_out_car)
  );
  assign io_fp_result = {32'hffffffff,fp_result_f32}; // @[Cat.scala 33:92]
  assign io_fflags = has_nan_f32_reg2 ? _fflags_f32_T_1 : _GEN_153; // @[FloatFMA.scala 811:25 813:16]
  assign U_BoothEncoder_io_in_a = {29'h0,fp_a_significand_f32}; // @[Cat.scala 33:92]
  assign U_BoothEncoder_io_in_b = {29'h0,fp_b_significand_f32}; // @[Cat.scala 33:92]
  assign U_CSAnto2_clock = clock;
  assign U_CSAnto2_io_in_0 = U_BoothEncoder_io_out_pp_0; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_1 = U_BoothEncoder_io_out_pp_1; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_2 = U_BoothEncoder_io_out_pp_2; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_3 = U_BoothEncoder_io_out_pp_3; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_4 = U_BoothEncoder_io_out_pp_4; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_5 = U_BoothEncoder_io_out_pp_5; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_6 = U_BoothEncoder_io_out_pp_6; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_7 = U_BoothEncoder_io_out_pp_7; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_8 = U_BoothEncoder_io_out_pp_8; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_9 = U_BoothEncoder_io_out_pp_9; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_10 = U_BoothEncoder_io_out_pp_10; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_11 = U_BoothEncoder_io_out_pp_11; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_12 = U_BoothEncoder_io_out_pp_12; // @[FloatFMA.scala 275:19]
  assign U_CSA3to2_io_in_a = U_CSAnto2_io_out_sum; // @[FloatFMA.scala 312:21]
  assign U_CSA3to2_io_in_b = {CSA3to2_in_b_hi,CSA3to2_in_b_lo}; // @[Cat.scala 33:92]
  assign U_CSA3to2_io_in_c = {{10'd0}, _CSA3to2_in_c_T_3}; // @[FloatFMA.scala 301:8]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 35:20]
      fire_reg0_last_r <= 1'h0; // @[Reg.scala 35:20]
    end else begin
      fire_reg0_last_r <= 1'h1;
    end
    if (reset) begin // @[Reg.scala 35:20]
      fire_reg1_last_r <= 1'h0; // @[Reg.scala 35:20]
    end else if (_fire_reg1_last_T) begin // @[Reg.scala 36:18]
      fire_reg1_last_r <= fire_reg0_last_r; // @[Reg.scala 36:22]
    end
    rshift_guard_f16 <= Ec_is_medium_f32 & rshift_result_with_grs_f32[2]; // @[FloatFMA.scala 198:39]
    rshift_round_f16 <= Ec_is_medium_f32 & rshift_result_with_grs_f32[1]; // @[FloatFMA.scala 204:39]
    if (Ec_is_medium_f32) begin // @[FloatFMA.scala 210:39]
      rshift_sticky_f16 <= rshift_result_with_grs_f32[0];
    end else if (Ec_is_too_big_f32) begin // @[FloatFMA.scala 210:92]
      rshift_sticky_f16 <= 1'h0;
    end else begin
      rshift_sticky_f16 <= |fp_c_significand_f32;
    end
    fp_c_rshiftValue_inv_f64_reg0 <= {{87'd0}, fp_c_rshiftValue_inv_f32_reg_d}; // @[FloatFMA.scala 245:43]
    CSA3to2_in_b_r <= sign_a_b_f32 ^ sign_c_f32; // @[FloatFMA.scala 114:44]
    adder_f32_r <= sign_a_b_f32 ^ sign_c_f32; // @[FloatFMA.scala 114:44]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      adder_is_negative_reg1 <= adder_is_negative_f32; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      adder_is_negative_f16_reg2 <= adder_is_negative_reg1; // @[Reg.scala 20:22]
    end
    E_greater_reg2_r <= {{3'd0}, E_greater_f32_reg_d}; // @[FloatFMA.scala 375:33]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      E_greater_reg2_r_1 <= E_greater_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      E_greater_f64_reg2 <= E_greater_reg2_r_1; // @[Reg.scala 20:22]
    end
    lshift_value_max_f64_reg0 <= {{3'd0}, lshift_value_max_f32_reg_d}; // @[FloatFMA.scala 386:40]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      tzd_adder_reg1 <= tzd_adder_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      lzd_adder_inv_mask_reg1 <= lzd_adder_inv_mask_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      lshift_mask_valid_f16_reg1 <= lshift_mask_valid_f32_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      adder_f32_reg1 <= adder_f32; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fraction_result_no_round_f64_reg2 <= fraction_result_no_round_reg_d; // @[Reg.scala 20:22]
    end
    sign_result_temp_f32_reg2_r <= fp_c_f32[31]; // @[FloatFMA.scala 108:44]
    sign_result_temp_f32_reg2_r_1 <= fp_a_f32[31] ^ fp_b_f32[31]; // @[FloatFMA.scala 105:49]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      if (adder_is_negative_f32) begin // @[FloatFMA.scala 498:58]
        sign_result_temp_f32_reg2_r_2 <= sign_result_temp_f32_reg2_r;
      end else begin
        sign_result_temp_f32_reg2_r_2 <= sign_result_temp_f32_reg2_r_1;
      end
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sign_result_temp_f32_reg2 <= sign_result_temp_f32_reg2_r_2; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      sticky_f32_reg2_r <= rshift_sticky_f16; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sticky_f32_reg2 <= _sticky_f32_reg2_T_3; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      sticky_uf_f32_reg2_r <= rshift_sticky_f16; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sticky_uf_f32_reg2 <= _sticky_uf_f32_reg2_T_3; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      round_lshift_f32_reg2 <= lshift_adder_inv_fix_f32[50]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      guard_lshift_f32_reg2 <= lshift_adder_inv_fix_f32[51]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      round_lshift_uf_f32_reg2 <= lshift_adder_inv_fix_f32[49]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      is_fix_reg2 <= is_fix_f32; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      lshift_value_reg2 <= lshift_value_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      exponent_is_min_f32 <= _exponent_is_min_f32_T_5; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      normal_result_is_zero_f32_reg2_r <= _normal_result_is_zero_f32_reg2_T_1; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      normal_result_is_zero_f32_reg2 <= normal_result_is_zero_f32_reg2_r; // @[Reg.scala 20:22]
    end
    has_zero_f32_reg2_r <= fp_a_is_zero_f32 | fp_b_is_zero_f32 | fp_c_is_zero_f32; // @[FloatFMA.scala 661:93]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_zero_f32_reg2_r_1 <= has_zero_f32_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_zero_f32_reg2_r_2 <= has_zero_f32_reg2_r_1; // @[Reg.scala 20:22]
    end
    fp_result_fp_a_or_b_is_zero_reg_r <= {{32'd0}, fp_result_f32_fp_a_or_b_is_zero}; // @[FloatFMA.scala 757:46]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      fp_result_fp_a_or_b_is_zero_reg_r_1 <= fp_result_fp_a_or_b_is_zero_reg_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fp_result_f64_fp_a_or_b_is_zero_reg2 <= fp_result_fp_a_or_b_is_zero_reg_r_1; // @[Reg.scala 20:22]
    end
    has_nan_f32_reg2_r <= fp_a_is_nan_f32 | fp_b_is_nan_f32 | fp_c_is_nan_f32; // @[FloatFMA.scala 689:55]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_nan_f32_reg2_r_1 <= has_nan_f32_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_nan_f32_reg2 <= has_nan_f32_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_nan_f32_is_NV_reg2_r <= has_snan_f32 | fp_a_is_inf_f32 & fp_b_is_zero_f32 | fp_a_is_zero_f32 & fp_b_is_inf_f32; // @[FloatFMA.scala 799:64]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_nan_f32_is_NV_reg2_r_1 <= has_nan_f32_is_NV_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_nan_f32_is_NV_reg2 <= has_nan_f32_is_NV_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_inf_f32_reg2_r <= fp_a_is_inf_f32 | fp_b_is_inf_f32 | fp_c_is_inf_f32; // @[FloatFMA.scala 717:55]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_reg2_r_1 <= has_inf_f32_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_reg2 <= has_inf_f32_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_inf_f32_is_NV_reg2_r <= _has_nan_f32_is_NV_reg2_T_1 | _has_nan_f32_is_NV_reg2_T_3 | fp_c_is_inf_f32 &
      _has_inf_f32_T & (sign_c_f32 ^ sign_a_b_f32); // @[FloatFMA.scala 803:83]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_is_NV_reg2_r_1 <= has_inf_f32_is_NV_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_is_NV_reg2 <= has_inf_f32_is_NV_reg2_r_1; // @[Reg.scala 20:22]
    end
    if (_has_inf_f32_T) begin // @[FloatFMA.scala 806:8]
      has_inf_f32_result_inf_sign_reg2_r <= sign_a_b_f32;
    end else begin
      has_inf_f32_result_inf_sign_reg2_r <= sign_c_f32;
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_result_inf_sign_reg2_r_1 <= has_inf_f32_result_inf_sign_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f32_result_inf_sign_reg2 <= has_inf_f32_result_inf_sign_reg2_r_1; // @[Reg.scala 20:22]
    end
    fp_a_or_b_is_zero_f32_reg2_r <= fp_a_is_zero_f32 | fp_b_is_zero_f32; // @[FloatFMA.scala 809:83]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      fp_a_or_b_is_zero_f32_reg2_r_1 <= fp_a_or_b_is_zero_f32_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fp_a_or_b_is_zero_f32_reg2 <= fp_a_or_b_is_zero_f32_reg2_r_1; // @[Reg.scala 20:22]
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
  fire_reg0_last_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  fire_reg1_last_r = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rshift_guard_f16 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rshift_round_f16 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  rshift_sticky_f16 = _RAND_4[0:0];
  _RAND_5 = {6{`RANDOM}};
  fp_c_rshiftValue_inv_f64_reg0 = _RAND_5[161:0];
  _RAND_6 = {1{`RANDOM}};
  CSA3to2_in_b_r = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  adder_f32_r = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  adder_is_negative_reg1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  adder_is_negative_f16_reg2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  E_greater_reg2_r = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  E_greater_reg2_r_1 = _RAND_11[11:0];
  _RAND_12 = {1{`RANDOM}};
  E_greater_f64_reg2 = _RAND_12[11:0];
  _RAND_13 = {1{`RANDOM}};
  lshift_value_max_f64_reg0 = _RAND_13[11:0];
  _RAND_14 = {6{`RANDOM}};
  tzd_adder_reg1 = _RAND_14[163:0];
  _RAND_15 = {6{`RANDOM}};
  lzd_adder_inv_mask_reg1 = _RAND_15[162:0];
  _RAND_16 = {1{`RANDOM}};
  lshift_mask_valid_f16_reg1 = _RAND_16[0:0];
  _RAND_17 = {3{`RANDOM}};
  adder_f32_reg1 = _RAND_17[76:0];
  _RAND_18 = {2{`RANDOM}};
  fraction_result_no_round_f64_reg2 = _RAND_18[51:0];
  _RAND_19 = {1{`RANDOM}};
  sign_result_temp_f32_reg2_r = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_result_temp_f32_reg2_r_1 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_result_temp_f32_reg2_r_2 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sign_result_temp_f32_reg2 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sticky_f32_reg2_r = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  sticky_f32_reg2 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  sticky_uf_f32_reg2_r = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  sticky_uf_f32_reg2 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  round_lshift_f32_reg2 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  guard_lshift_f32_reg2 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  round_lshift_uf_f32_reg2 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  is_fix_reg2 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  lshift_value_reg2 = _RAND_31[7:0];
  _RAND_32 = {1{`RANDOM}};
  exponent_is_min_f32 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  normal_result_is_zero_f32_reg2_r = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  normal_result_is_zero_f32_reg2 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  has_zero_f32_reg2_r = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  has_zero_f32_reg2_r_1 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  has_zero_f32_reg2_r_2 = _RAND_37[0:0];
  _RAND_38 = {2{`RANDOM}};
  fp_result_fp_a_or_b_is_zero_reg_r = _RAND_38[63:0];
  _RAND_39 = {2{`RANDOM}};
  fp_result_fp_a_or_b_is_zero_reg_r_1 = _RAND_39[63:0];
  _RAND_40 = {2{`RANDOM}};
  fp_result_f64_fp_a_or_b_is_zero_reg2 = _RAND_40[63:0];
  _RAND_41 = {1{`RANDOM}};
  has_nan_f32_reg2_r = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  has_nan_f32_reg2_r_1 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  has_nan_f32_reg2 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  has_nan_f32_is_NV_reg2_r = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  has_nan_f32_is_NV_reg2_r_1 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  has_nan_f32_is_NV_reg2 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  has_inf_f32_reg2_r = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  has_inf_f32_reg2_r_1 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  has_inf_f32_reg2 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  has_inf_f32_is_NV_reg2_r = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  has_inf_f32_is_NV_reg2_r_1 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  has_inf_f32_is_NV_reg2 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  has_inf_f32_result_inf_sign_reg2_r = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  has_inf_f32_result_inf_sign_reg2_r_1 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  has_inf_f32_result_inf_sign_reg2 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f32_reg2_r = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f32_reg2_r_1 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f32_reg2 = _RAND_58[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_result,
  input  [4:0]  io_enq_bits_fflags,
  input  [5:0]  io_enq_bits_seq,
  input  [7:0]  io_enq_bits_dest,
  input  [3:0]  io_enq_bits_dtype,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_result,
  output [4:0]  io_deq_bits_fflags,
  output [5:0]  io_deq_bits_seq,
  output [7:0]  io_deq_bits_dest,
  output [3:0]  io_deq_bits_dtype
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_result [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_result_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_result_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_result_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_result_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_result_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_result_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_result_MPORT_en; // @[Decoupled.scala 273:95]
  reg [4:0] ram_fflags [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_fflags_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_fflags_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [4:0] ram_fflags_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [4:0] ram_fflags_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_fflags_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_fflags_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_fflags_MPORT_en; // @[Decoupled.scala 273:95]
  reg [5:0] ram_seq [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_seq_MPORT_en; // @[Decoupled.scala 273:95]
  reg [7:0] ram_dest [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_dest_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_dest_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_dest_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_dest_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_dest_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_dest_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] ram_dtype [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_dtype_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_dtype_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_dtype_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_dtype_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_dtype_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_dtype_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  assign ram_result_io_deq_bits_MPORT_en = 1'h1;
  assign ram_result_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_result_io_deq_bits_MPORT_data = ram_result[ram_result_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_result_MPORT_data = io_enq_bits_result;
  assign ram_result_MPORT_addr = enq_ptr_value;
  assign ram_result_MPORT_mask = 1'h1;
  assign ram_result_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_fflags_io_deq_bits_MPORT_en = 1'h1;
  assign ram_fflags_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_fflags_io_deq_bits_MPORT_data = ram_fflags[ram_fflags_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_fflags_MPORT_data = io_enq_bits_fflags;
  assign ram_fflags_MPORT_addr = enq_ptr_value;
  assign ram_fflags_MPORT_mask = 1'h1;
  assign ram_fflags_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_seq_io_deq_bits_MPORT_en = 1'h1;
  assign ram_seq_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_seq_io_deq_bits_MPORT_data = ram_seq[ram_seq_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_seq_MPORT_data = io_enq_bits_seq;
  assign ram_seq_MPORT_addr = enq_ptr_value;
  assign ram_seq_MPORT_mask = 1'h1;
  assign ram_seq_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_dest_io_deq_bits_MPORT_en = 1'h1;
  assign ram_dest_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_dest_io_deq_bits_MPORT_data = ram_dest[ram_dest_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_dest_MPORT_data = io_enq_bits_dest;
  assign ram_dest_MPORT_addr = enq_ptr_value;
  assign ram_dest_MPORT_mask = 1'h1;
  assign ram_dest_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_dtype_io_deq_bits_MPORT_en = 1'h1;
  assign ram_dtype_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_dtype_io_deq_bits_MPORT_data = ram_dtype[ram_dtype_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_dtype_MPORT_data = io_enq_bits_dtype;
  assign ram_dtype_MPORT_addr = enq_ptr_value;
  assign ram_dtype_MPORT_mask = 1'h1;
  assign ram_dtype_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | ~full; // @[Decoupled.scala 303:16 323:{24,39}]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_result = ram_result_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_fflags = ram_fflags_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_seq = ram_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_dest = ram_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_dtype = ram_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_result_MPORT_en & ram_result_MPORT_mask) begin
      ram_result[ram_result_MPORT_addr] <= ram_result_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_fflags_MPORT_en & ram_fflags_MPORT_mask) begin
      ram_fflags[ram_fflags_MPORT_addr] <= ram_fflags_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_seq_MPORT_en & ram_seq_MPORT_mask) begin
      ram_seq[ram_seq_MPORT_addr] <= ram_seq_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_dest_MPORT_en & ram_dest_MPORT_mask) begin
      ram_dest[ram_dest_MPORT_addr] <= ram_dest_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_dtype_MPORT_en & ram_dtype_MPORT_mask) begin
      ram_dtype[ram_dtype_MPORT_addr] <= ram_dtype_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
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
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_result[initvar] = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_fflags[initvar] = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_seq[initvar] = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_dest[initvar] = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_dtype[initvar] = _RAND_4[3:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  enq_ptr_value = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  deq_ptr_value = _RAND_6[2:0];
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
module YunSuanFmaPipe(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [6:0]  io_req_bits_op,
  input  [63:0] io_req_bits_a,
  input  [63:0] io_req_bits_b,
  input  [63:0] io_req_bits_c,
  input  [5:0]  io_req_bits_seq,
  input  [7:0]  io_req_bits_dest,
  input  [3:0]  io_req_bits_dtype,
  input         io_resp_ready,
  output        io_resp_valid,
  output [63:0] io_resp_bits_result,
  output [4:0]  io_resp_bits_fflags,
  output [5:0]  io_resp_bits_seq,
  output [7:0]  io_resp_bits_dest,
  output [3:0]  io_resp_bits_dtype
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
`endif // RANDOMIZE_REG_INIT
  wire  core_clock; // @[YunSuanFmaPipe.scala 45:20]
  wire  core_reset; // @[YunSuanFmaPipe.scala 45:20]
  wire [63:0] core_io_fp_a; // @[YunSuanFmaPipe.scala 45:20]
  wire [63:0] core_io_fp_b; // @[YunSuanFmaPipe.scala 45:20]
  wire [63:0] core_io_fp_c; // @[YunSuanFmaPipe.scala 45:20]
  wire [3:0] core_io_op_code; // @[YunSuanFmaPipe.scala 45:20]
  wire [63:0] core_io_fp_result; // @[YunSuanFmaPipe.scala 45:20]
  wire [4:0] core_io_fflags; // @[YunSuanFmaPipe.scala 45:20]
  wire  completionQ_clock; // @[YunSuanFmaPipe.scala 46:27]
  wire  completionQ_reset; // @[YunSuanFmaPipe.scala 46:27]
  wire  completionQ_io_enq_ready; // @[YunSuanFmaPipe.scala 46:27]
  wire  completionQ_io_enq_valid; // @[YunSuanFmaPipe.scala 46:27]
  wire [63:0] completionQ_io_enq_bits_result; // @[YunSuanFmaPipe.scala 46:27]
  wire [4:0] completionQ_io_enq_bits_fflags; // @[YunSuanFmaPipe.scala 46:27]
  wire [5:0] completionQ_io_enq_bits_seq; // @[YunSuanFmaPipe.scala 46:27]
  wire [7:0] completionQ_io_enq_bits_dest; // @[YunSuanFmaPipe.scala 46:27]
  wire [3:0] completionQ_io_enq_bits_dtype; // @[YunSuanFmaPipe.scala 46:27]
  wire  completionQ_io_deq_ready; // @[YunSuanFmaPipe.scala 46:27]
  wire  completionQ_io_deq_valid; // @[YunSuanFmaPipe.scala 46:27]
  wire [63:0] completionQ_io_deq_bits_result; // @[YunSuanFmaPipe.scala 46:27]
  wire [4:0] completionQ_io_deq_bits_fflags; // @[YunSuanFmaPipe.scala 46:27]
  wire [5:0] completionQ_io_deq_bits_seq; // @[YunSuanFmaPipe.scala 46:27]
  wire [7:0] completionQ_io_deq_bits_dest; // @[YunSuanFmaPipe.scala 46:27]
  wire [3:0] completionQ_io_deq_bits_dtype; // @[YunSuanFmaPipe.scala 46:27]
  reg [3:0] outstanding; // @[YunSuanFmaPipe.scala 47:28]
  wire  fire = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire  _synthAdd_T_1 = io_req_bits_op == 7'h2; // @[YunSuanFmaPipe.scala 52:67]
  wire  synthAdd = io_req_bits_op == 7'h1 | io_req_bits_op == 7'h2; // @[YunSuanFmaPipe.scala 52:49]
  wire [63:0] _addend_T_1 = io_req_bits_b ^ 64'h80000000; // @[YunSuanFmaPipe.scala 55:66]
  wire [63:0] addend = _synthAdd_T_1 ? _addend_T_1 : io_req_bits_b; // @[YunSuanFmaPipe.scala 55:19]
  reg  valid0; // @[YunSuanFmaPipe.scala 74:23]
  reg  valid1; // @[YunSuanFmaPipe.scala 75:23]
  reg  valid2; // @[YunSuanFmaPipe.scala 76:23]
  reg [5:0] meta0_seq; // @[Reg.scala 19:16]
  reg [7:0] meta0_dest; // @[Reg.scala 19:16]
  reg [3:0] meta0_dtype; // @[Reg.scala 19:16]
  reg [5:0] meta1_seq; // @[Reg.scala 19:16]
  reg [7:0] meta1_dest; // @[Reg.scala 19:16]
  reg [3:0] meta1_dtype; // @[Reg.scala 19:16]
  reg [5:0] meta2_seq; // @[Reg.scala 19:16]
  reg [7:0] meta2_dest; // @[Reg.scala 19:16]
  reg [3:0] meta2_dtype; // @[Reg.scala 19:16]
  wire  _T = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _outstanding_T_1 = outstanding + 4'h1; // @[YunSuanFmaPipe.scala 94:42]
  wire [3:0] _outstanding_T_3 = outstanding - 4'h1; // @[YunSuanFmaPipe.scala 94:61]
  FloatFMA core ( // @[YunSuanFmaPipe.scala 45:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_fp_a(core_io_fp_a),
    .io_fp_b(core_io_fp_b),
    .io_fp_c(core_io_fp_c),
    .io_op_code(core_io_op_code),
    .io_fp_result(core_io_fp_result),
    .io_fflags(core_io_fflags)
  );
  Queue completionQ ( // @[YunSuanFmaPipe.scala 46:27]
    .clock(completionQ_clock),
    .reset(completionQ_reset),
    .io_enq_ready(completionQ_io_enq_ready),
    .io_enq_valid(completionQ_io_enq_valid),
    .io_enq_bits_result(completionQ_io_enq_bits_result),
    .io_enq_bits_fflags(completionQ_io_enq_bits_fflags),
    .io_enq_bits_seq(completionQ_io_enq_bits_seq),
    .io_enq_bits_dest(completionQ_io_enq_bits_dest),
    .io_enq_bits_dtype(completionQ_io_enq_bits_dtype),
    .io_deq_ready(completionQ_io_deq_ready),
    .io_deq_valid(completionQ_io_deq_valid),
    .io_deq_bits_result(completionQ_io_deq_bits_result),
    .io_deq_bits_fflags(completionQ_io_deq_bits_fflags),
    .io_deq_bits_seq(completionQ_io_deq_bits_seq),
    .io_deq_bits_dest(completionQ_io_deq_bits_dest),
    .io_deq_bits_dtype(completionQ_io_deq_bits_dtype)
  );
  assign io_req_ready = outstanding < 4'h8; // @[YunSuanFmaPipe.scala 48:32]
  assign io_resp_valid = completionQ_io_deq_valid; // @[YunSuanFmaPipe.scala 92:11]
  assign io_resp_bits_result = completionQ_io_deq_bits_result; // @[YunSuanFmaPipe.scala 92:11]
  assign io_resp_bits_fflags = completionQ_io_deq_bits_fflags; // @[YunSuanFmaPipe.scala 92:11]
  assign io_resp_bits_seq = completionQ_io_deq_bits_seq; // @[YunSuanFmaPipe.scala 92:11]
  assign io_resp_bits_dest = completionQ_io_deq_bits_dest; // @[YunSuanFmaPipe.scala 92:11]
  assign io_resp_bits_dtype = completionQ_io_deq_bits_dtype; // @[YunSuanFmaPipe.scala 92:11]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_fp_a = io_req_bits_a; // @[YunSuanFmaPipe.scala 64:16]
  assign core_io_fp_b = synthAdd ? 64'h3f800000 : io_req_bits_b; // @[YunSuanFmaPipe.scala 65:22]
  assign core_io_fp_c = synthAdd ? addend : io_req_bits_c; // @[YunSuanFmaPipe.scala 66:22]
  assign core_io_op_code = io_req_bits_op == 7'h3 ? 4'h0 : 4'h1; // @[YunSuanFmaPipe.scala 69:25]
  assign completionQ_clock = clock;
  assign completionQ_reset = reset;
  assign completionQ_io_enq_valid = valid2; // @[YunSuanFmaPipe.scala 81:28]
  assign completionQ_io_enq_bits_result = core_io_fp_result; // @[YunSuanFmaPipe.scala 82:34]
  assign completionQ_io_enq_bits_fflags = core_io_fflags; // @[YunSuanFmaPipe.scala 83:34]
  assign completionQ_io_enq_bits_seq = meta2_seq; // @[YunSuanFmaPipe.scala 84:31]
  assign completionQ_io_enq_bits_dest = meta2_dest; // @[YunSuanFmaPipe.scala 85:32]
  assign completionQ_io_enq_bits_dtype = meta2_dtype; // @[YunSuanFmaPipe.scala 86:33]
  assign completionQ_io_deq_ready = io_resp_ready; // @[YunSuanFmaPipe.scala 92:11]
  always @(posedge clock) begin
    if (reset) begin // @[YunSuanFmaPipe.scala 47:28]
      outstanding <= 4'h0; // @[YunSuanFmaPipe.scala 47:28]
    end else if (fire != _T) begin // @[YunSuanFmaPipe.scala 93:32]
      if (fire) begin // @[YunSuanFmaPipe.scala 94:23]
        outstanding <= _outstanding_T_1;
      end else begin
        outstanding <= _outstanding_T_3;
      end
    end
    if (reset) begin // @[YunSuanFmaPipe.scala 74:23]
      valid0 <= 1'h0; // @[YunSuanFmaPipe.scala 74:23]
    end else begin
      valid0 <= fire; // @[YunSuanFmaPipe.scala 74:23]
    end
    if (reset) begin // @[YunSuanFmaPipe.scala 75:23]
      valid1 <= 1'h0; // @[YunSuanFmaPipe.scala 75:23]
    end else begin
      valid1 <= valid0; // @[YunSuanFmaPipe.scala 75:23]
    end
    if (reset) begin // @[YunSuanFmaPipe.scala 76:23]
      valid2 <= 1'h0; // @[YunSuanFmaPipe.scala 76:23]
    end else begin
      valid2 <= valid1; // @[YunSuanFmaPipe.scala 76:23]
    end
    if (fire) begin // @[Reg.scala 20:18]
      meta0_seq <= io_req_bits_seq; // @[Reg.scala 20:22]
    end
    if (fire) begin // @[Reg.scala 20:18]
      meta0_dest <= io_req_bits_dest; // @[Reg.scala 20:22]
    end
    if (fire) begin // @[Reg.scala 20:18]
      meta0_dtype <= io_req_bits_dtype; // @[Reg.scala 20:22]
    end
    if (valid0) begin // @[Reg.scala 20:18]
      meta1_seq <= meta0_seq; // @[Reg.scala 20:22]
    end
    if (valid0) begin // @[Reg.scala 20:18]
      meta1_dest <= meta0_dest; // @[Reg.scala 20:22]
    end
    if (valid0) begin // @[Reg.scala 20:18]
      meta1_dtype <= meta0_dtype; // @[Reg.scala 20:22]
    end
    if (valid1) begin // @[Reg.scala 20:18]
      meta2_seq <= meta1_seq; // @[Reg.scala 20:22]
    end
    if (valid1) begin // @[Reg.scala 20:18]
      meta2_dest <= meta1_dest; // @[Reg.scala 20:22]
    end
    if (valid1) begin // @[Reg.scala 20:18]
      meta2_dtype <= meta1_dtype; // @[Reg.scala 20:22]
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
  outstanding = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  valid0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  valid1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid2 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  meta0_seq = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  meta0_dest = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  meta0_dtype = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  meta1_seq = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  meta1_dest = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  meta1_dtype = _RAND_9[3:0];
  _RAND_10 = {1{`RANDOM}};
  meta2_seq = _RAND_10[5:0];
  _RAND_11 = {1{`RANDOM}};
  meta2_dest = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  meta2_dtype = _RAND_12[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CLZ(
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
  output [31:0] io_result
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
  wire [7:0] _GEN_0 = {{3'd0}, fp_in_exp}; // @[FPToFP.scala 214:47]
  wire [7:0] normal_exp = 8'h70 + _GEN_0; // @[FPToFP.scala 214:47]
  wire [24:0] _GEN_2 = {{15'd0}, fp_in_sig}; // @[FPToFP.scala 218:20]
  wire [24:0] _subnormal_sig_T = _GEN_2 << subnormal_shamt_clz_io_out; // @[FPToFP.scala 218:20]
  wire [7:0] _GEN_1 = {{4'd0}, subnormal_shamt_clz_io_out}; // @[FPToFP.scala 219:50]
  wire [7:0] subnormal_exp = 8'h70 - _GEN_1; // @[FPToFP.scala 219:50]
  wire  _result_T_1 = ~decode_in__isNaN & fp_in_sign; // @[FPToFP.scala 222:22]
  wire  _result_T_4 = ~decode_in_expIsOnes & ~decode_in__expIsZero; // @[FPToFP.scala 228:30]
  wire [7:0] _result_T_6 = decode_in_expIsOnes ? 8'hff : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_8 = decode_in__isSubnormal ? subnormal_exp : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_9 = _result_T_4 ? normal_exp : 8'h0; // @[Mux.scala 27:73]
  wire [7:0] _result_T_11 = _result_T_6 | _result_T_8; // @[Mux.scala 27:73]
  wire [7:0] _result_T_12 = _result_T_11 | _result_T_9; // @[Mux.scala 27:73]
  wire [22:0] _result_T_16 = {decode_in_sigNotZero,22'h0}; // @[Cat.scala 33:92]
  wire [22:0] _result_T_17 = {_subnormal_sig_T[8:0],1'h0,13'h0}; // @[Cat.scala 33:92]
  wire [22:0] _result_T_18 = {fp_in_sig,13'h0}; // @[Cat.scala 33:92]
  wire [22:0] _result_T_19 = decode_in_expIsOnes ? _result_T_16 : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _result_T_20 = decode_in__expIsZero ? _result_T_17 : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _result_T_21 = _result_T_4 ? _result_T_18 : 23'h0; // @[Mux.scala 27:73]
  wire [22:0] _result_T_22 = _result_T_19 | _result_T_20; // @[Mux.scala 27:73]
  wire [22:0] _result_T_23 = _result_T_22 | _result_T_21; // @[Mux.scala 27:73]
  wire [8:0] result_hi = {_result_T_1,_result_T_12}; // @[Cat.scala 33:92]
  CLZ subnormal_shamt_clz ( // @[CLZ.scala 22:21]
    .io_in(subnormal_shamt_clz_io_in),
    .io_out(subnormal_shamt_clz_io_out)
  );
  assign io_result = {result_hi,_result_T_23}; // @[Cat.scala 33:92]
  assign subnormal_shamt_clz_io_in = io_in[9:0]; // @[package.scala 61:18]
endmodule
module FPToFP(
  input  [15:0] io_in,
  output [31:0] io_result
);
  wire [15:0] converter_io_in; // @[FPToFP.scala 42:11]
  wire [31:0] converter_io_result; // @[FPToFP.scala 42:11]
  FPUpConverter converter ( // @[FPToFP.scala 42:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module Queue_1(
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
  reg [5:0] ram [0:15]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
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
module Queue_2(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [5:0]  io_enq_bits_seq,
  input  [6:0]  io_enq_bits_req_op,
  input  [3:0]  io_enq_bits_req_dtype,
  input  [63:0] io_enq_bits_req_a,
  input  [63:0] io_enq_bits_req_b,
  input  [7:0]  io_enq_bits_req_dest,
  input         io_deq_ready,
  output        io_deq_valid,
  output [5:0]  io_deq_bits_seq,
  output [6:0]  io_deq_bits_req_op,
  output [3:0]  io_deq_bits_req_dtype,
  output [63:0] io_deq_bits_req_a,
  output [63:0] io_deq_bits_req_b,
  output [7:0]  io_deq_bits_req_dest
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ram_seq [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_seq_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_seq_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [5:0] ram_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [5:0] ram_seq_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_seq_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_seq_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_seq_MPORT_en; // @[Decoupled.scala 273:95]
  reg [6:0] ram_req_op [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_req_op_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_op_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [6:0] ram_req_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [6:0] ram_req_op_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_op_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_req_op_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_req_op_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] ram_req_dtype [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_req_dtype_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_dtype_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [3:0] ram_req_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_req_dtype_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_dtype_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_req_dtype_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_req_dtype_MPORT_en; // @[Decoupled.scala 273:95]
  reg [63:0] ram_req_a [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_req_a_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_a_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_req_a_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_req_a_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_a_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_req_a_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_req_a_MPORT_en; // @[Decoupled.scala 273:95]
  reg [63:0] ram_req_b [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_req_b_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_b_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [63:0] ram_req_b_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [63:0] ram_req_b_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_b_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_req_b_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_req_b_MPORT_en; // @[Decoupled.scala 273:95]
  reg [7:0] ram_req_dest [0:3]; // @[Decoupled.scala 273:95]
  wire  ram_req_dest_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_dest_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_req_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_req_dest_MPORT_data; // @[Decoupled.scala 273:95]
  wire [1:0] ram_req_dest_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_req_dest_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_req_dest_MPORT_en; // @[Decoupled.scala 273:95]
  reg [1:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [1:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [1:0] _value_T_1 = enq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  wire [1:0] _value_T_3 = deq_ptr_value + 2'h1; // @[Counter.scala 77:24]
  assign ram_seq_io_deq_bits_MPORT_en = 1'h1;
  assign ram_seq_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_seq_io_deq_bits_MPORT_data = ram_seq[ram_seq_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_seq_MPORT_data = io_enq_bits_seq;
  assign ram_seq_MPORT_addr = enq_ptr_value;
  assign ram_seq_MPORT_mask = 1'h1;
  assign ram_seq_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_req_op_io_deq_bits_MPORT_en = 1'h1;
  assign ram_req_op_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_req_op_io_deq_bits_MPORT_data = ram_req_op[ram_req_op_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_req_op_MPORT_data = io_enq_bits_req_op;
  assign ram_req_op_MPORT_addr = enq_ptr_value;
  assign ram_req_op_MPORT_mask = 1'h1;
  assign ram_req_op_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_req_dtype_io_deq_bits_MPORT_en = 1'h1;
  assign ram_req_dtype_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_req_dtype_io_deq_bits_MPORT_data = ram_req_dtype[ram_req_dtype_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_req_dtype_MPORT_data = io_enq_bits_req_dtype;
  assign ram_req_dtype_MPORT_addr = enq_ptr_value;
  assign ram_req_dtype_MPORT_mask = 1'h1;
  assign ram_req_dtype_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_req_a_io_deq_bits_MPORT_en = 1'h1;
  assign ram_req_a_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_req_a_io_deq_bits_MPORT_data = ram_req_a[ram_req_a_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_req_a_MPORT_data = io_enq_bits_req_a;
  assign ram_req_a_MPORT_addr = enq_ptr_value;
  assign ram_req_a_MPORT_mask = 1'h1;
  assign ram_req_a_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_req_b_io_deq_bits_MPORT_en = 1'h1;
  assign ram_req_b_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_req_b_io_deq_bits_MPORT_data = ram_req_b[ram_req_b_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_req_b_MPORT_data = io_enq_bits_req_b;
  assign ram_req_b_MPORT_addr = enq_ptr_value;
  assign ram_req_b_MPORT_mask = 1'h1;
  assign ram_req_b_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_req_dest_io_deq_bits_MPORT_en = 1'h1;
  assign ram_req_dest_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_req_dest_io_deq_bits_MPORT_data = ram_req_dest[ram_req_dest_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_req_dest_MPORT_data = io_enq_bits_req_dest;
  assign ram_req_dest_MPORT_addr = enq_ptr_value;
  assign ram_req_dest_MPORT_mask = 1'h1;
  assign ram_req_dest_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits_seq = ram_seq_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_req_op = ram_req_op_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_req_dtype = ram_req_dtype_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_req_a = ram_req_a_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_req_b = ram_req_b_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_deq_bits_req_dest = ram_req_dest_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_seq_MPORT_en & ram_seq_MPORT_mask) begin
      ram_seq[ram_seq_MPORT_addr] <= ram_seq_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_req_op_MPORT_en & ram_req_op_MPORT_mask) begin
      ram_req_op[ram_req_op_MPORT_addr] <= ram_req_op_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_req_dtype_MPORT_en & ram_req_dtype_MPORT_mask) begin
      ram_req_dtype[ram_req_dtype_MPORT_addr] <= ram_req_dtype_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_req_a_MPORT_en & ram_req_a_MPORT_mask) begin
      ram_req_a[ram_req_a_MPORT_addr] <= ram_req_a_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_req_b_MPORT_en & ram_req_b_MPORT_mask) begin
      ram_req_b[ram_req_b_MPORT_addr] <= ram_req_b_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (ram_req_dest_MPORT_en & ram_req_dest_MPORT_mask) begin
      ram_req_dest[ram_req_dest_MPORT_addr] <= ram_req_dest_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 2'h0; // @[Counter.scala 61:40]
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
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_seq[initvar] = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_req_op[initvar] = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_req_dtype[initvar] = _RAND_2[3:0];
  _RAND_3 = {2{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_req_a[initvar] = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_req_b[initvar] = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram_req_dest[initvar] = _RAND_5[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  enq_ptr_value = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  deq_ptr_value = _RAND_7[1:0];
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
module RoundingUnit(
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
module ShiftRightJam(
  input  [11:0] io_in,
  input  [7:0]  io_shamt,
  output [11:0] io_out,
  output        io_sticky
);
  wire  exceed_max_shift = io_shamt > 8'hc; // @[ShiftRightJam.scala 17:35]
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
  input  [31:0] io_in,
  output [15:0] io_result
);
  wire [9:0] normal_rounder_io_in; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_roundIn; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_stickyIn; // @[FPToFP.scala 80:30]
  wire [9:0] normal_rounder_io_out; // @[FPToFP.scala 80:30]
  wire  normal_rounder_io_cout; // @[FPToFP.scala 80:30]
  wire [11:0] shiftRightJam_io_in; // @[ShiftRightJam.scala 27:31]
  wire [7:0] shiftRightJam_io_shamt; // @[ShiftRightJam.scala 27:31]
  wire [11:0] shiftRightJam_io_out; // @[ShiftRightJam.scala 27:31]
  wire  shiftRightJam_io_sticky; // @[ShiftRightJam.scala 27:31]
  wire [9:0] subnormal_rounder_io_in; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_roundIn; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_stickyIn; // @[FPToFP.scala 114:33]
  wire [9:0] subnormal_rounder_io_out; // @[FPToFP.scala 114:33]
  wire  subnormal_rounder_io_cout; // @[FPToFP.scala 114:33]
  wire  fp_in_sign = io_in[31]; // @[package.scala 59:19]
  wire [7:0] fp_in_exp = io_in[30:23]; // @[package.scala 60:18]
  wire [22:0] fp_in_sig = io_in[22:0]; // @[package.scala 61:18]
  wire  decode_expNotZero = |fp_in_exp; // @[package.scala 32:31]
  wire  decode_expIsOnes = &fp_in_exp; // @[package.scala 33:31]
  wire  decode_sigNotZero = |fp_in_sig; // @[package.scala 34:31]
  wire  decode__isNaN = decode_expIsOnes & decode_sigNotZero; // @[package.scala 44:40]
  wire [8:0] _down_exp_T = {1'b0,$signed(fp_in_exp)}; // @[FPToFP.scala 71:32]
  wire [8:0] down_exp = $signed(_down_exp_T) - 9'sh70; // @[FPToFP.scala 71:35]
  wire  normal_stickyBit = |fp_in_sig[11:0]; // @[FPToFP.scala 78:58]
  wire [8:0] _normal_exp_rounded_T_2 = $signed(down_exp) + 9'sh1; // @[FPToFP.scala 88:65]
  wire [8:0] normal_exp_rounded = normal_rounder_io_cout ? $signed(_normal_exp_rounded_T_2) : $signed(down_exp); // @[FPToFP.scala 88:31]
  wire  _normal_of_T = $signed(down_exp) > 9'sh1d; // @[FPToFP.scala 91:14]
  wire  _normal_of_T_1 = $signed(down_exp) > 9'sh1e; // @[FPToFP.scala 92:14]
  wire  normal_of = normal_rounder_io_cout ? _normal_of_T : _normal_of_T_1; // @[FPToFP.scala 89:22]
  wire  _exp_uf_T_1 = $signed(down_exp) < 9'sh1; // @[FPToFP.scala 94:69]
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
  RoundingUnit normal_rounder ( // @[FPToFP.scala 80:30]
    .io_in(normal_rounder_io_in),
    .io_roundIn(normal_rounder_io_roundIn),
    .io_stickyIn(normal_rounder_io_stickyIn),
    .io_out(normal_rounder_io_out),
    .io_cout(normal_rounder_io_cout)
  );
  ShiftRightJam shiftRightJam ( // @[ShiftRightJam.scala 27:31]
    .io_in(shiftRightJam_io_in),
    .io_shamt(shiftRightJam_io_shamt),
    .io_out(shiftRightJam_io_out),
    .io_sticky(shiftRightJam_io_sticky)
  );
  RoundingUnit subnormal_rounder ( // @[FPToFP.scala 114:33]
    .io_in(subnormal_rounder_io_in),
    .io_roundIn(subnormal_rounder_io_roundIn),
    .io_stickyIn(subnormal_rounder_io_stickyIn),
    .io_out(subnormal_rounder_io_out),
    .io_cout(subnormal_rounder_io_cout)
  );
  assign io_result = {result_hi,_result_T_11}; // @[Cat.scala 33:92]
  assign normal_rounder_io_in = fp_in_sig[22:13]; // @[FPToFP.scala 76:34]
  assign normal_rounder_io_roundIn = fp_in_sig[12]; // @[FPToFP.scala 77:62]
  assign normal_rounder_io_stickyIn = |fp_in_sig[11:0]; // @[FPToFP.scala 78:58]
  assign shiftRightJam_io_in = {decode_expNotZero,fp_in_sig[22:12]}; // @[Cat.scala 33:92]
  assign shiftRightJam_io_shamt = 8'h71 - fp_in_exp; // @[FPToFP.scala 108:47]
  assign subnormal_rounder_io_in = shiftRightJam_io_out[10:1]; // @[FPToFP.scala 115:56]
  assign subnormal_rounder_io_roundIn = shiftRightJam_io_out[0]; // @[FPToFP.scala 116:48]
  assign subnormal_rounder_io_stickyIn = shiftRightJam_io_sticky | normal_stickyBit; // @[FPToFP.scala 113:42]
endmodule
module FPToFP_5(
  input  [31:0] io_in,
  output [15:0] io_result
);
  wire [31:0] converter_io_in; // @[FPToFP.scala 33:11]
  wire [15:0] converter_io_result; // @[FPToFP.scala 33:11]
  FPDownConverter converter ( // @[FPToFP.scala 33:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module CLZ_5(
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
module FPUpConverter_5(
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
  CLZ_5 subnormal_shamt_clz ( // @[CLZ.scala 22:21]
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
  FPUpConverter_5 converter ( // @[FPToFP.scala 42:11]
    .io_in(converter_io_in),
    .io_result(converter_io_result)
  );
  assign io_result = converter_io_result; // @[FPToFP.scala 52:6]
  assign converter_io_in = io_in; // @[FPToFP.scala 52:6]
endmodule
module RoundingUnit_2(
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
module ShiftRightJam_1(
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
  RoundingUnit_2 normal_rounder ( // @[FPToFP.scala 80:30]
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
  RoundingUnit_2 subnormal_rounder ( // @[FPToFP.scala 114:33]
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
module FPToFP_7(
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
module AecFp32PipeUnit(
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
`endif // RANDOMIZE_REG_INIT
  wire  pipe_clock; // @[AecFp32Unit.scala 23:20]
  wire  pipe_reset; // @[AecFp32Unit.scala 23:20]
  wire  pipe_io_req_ready; // @[AecFp32Unit.scala 23:20]
  wire  pipe_io_req_valid; // @[AecFp32Unit.scala 23:20]
  wire [6:0] pipe_io_req_bits_op; // @[AecFp32Unit.scala 23:20]
  wire [63:0] pipe_io_req_bits_a; // @[AecFp32Unit.scala 23:20]
  wire [63:0] pipe_io_req_bits_b; // @[AecFp32Unit.scala 23:20]
  wire [63:0] pipe_io_req_bits_c; // @[AecFp32Unit.scala 23:20]
  wire [5:0] pipe_io_req_bits_seq; // @[AecFp32Unit.scala 23:20]
  wire [7:0] pipe_io_req_bits_dest; // @[AecFp32Unit.scala 23:20]
  wire [3:0] pipe_io_req_bits_dtype; // @[AecFp32Unit.scala 23:20]
  wire  pipe_io_resp_ready; // @[AecFp32Unit.scala 23:20]
  wire  pipe_io_resp_valid; // @[AecFp32Unit.scala 23:20]
  wire [63:0] pipe_io_resp_bits_result; // @[AecFp32Unit.scala 23:20]
  wire [4:0] pipe_io_resp_bits_fflags; // @[AecFp32Unit.scala 23:20]
  wire [5:0] pipe_io_resp_bits_seq; // @[AecFp32Unit.scala 23:20]
  wire [7:0] pipe_io_resp_bits_dest; // @[AecFp32Unit.scala 23:20]
  wire [3:0] pipe_io_resp_bits_dtype; // @[AecFp32Unit.scala 23:20]
  wire [15:0] f16Up_0_io_in; // @[AecFp32Unit.scala 29:33]
  wire [31:0] f16Up_0_io_result; // @[AecFp32Unit.scala 29:33]
  wire [15:0] f16Up_1_io_in; // @[AecFp32Unit.scala 29:33]
  wire [31:0] f16Up_1_io_result; // @[AecFp32Unit.scala 29:33]
  wire [15:0] f16Up_2_io_in; // @[AecFp32Unit.scala 29:33]
  wire [31:0] f16Up_2_io_result; // @[AecFp32Unit.scala 29:33]
  wire  issueQ_clock; // @[AecFp32Unit.scala 73:24]
  wire  issueQ_reset; // @[AecFp32Unit.scala 73:24]
  wire  issueQ_io_enq_ready; // @[AecFp32Unit.scala 73:24]
  wire  issueQ_io_enq_valid; // @[AecFp32Unit.scala 73:24]
  wire [5:0] issueQ_io_enq_bits; // @[AecFp32Unit.scala 73:24]
  wire  issueQ_io_deq_ready; // @[AecFp32Unit.scala 73:24]
  wire  issueQ_io_deq_valid; // @[AecFp32Unit.scala 73:24]
  wire [5:0] issueQ_io_deq_bits; // @[AecFp32Unit.scala 73:24]
  wire  simpleQ_clock; // @[AecFp32Unit.scala 74:25]
  wire  simpleQ_reset; // @[AecFp32Unit.scala 74:25]
  wire  simpleQ_io_enq_ready; // @[AecFp32Unit.scala 74:25]
  wire  simpleQ_io_enq_valid; // @[AecFp32Unit.scala 74:25]
  wire [5:0] simpleQ_io_enq_bits_seq; // @[AecFp32Unit.scala 74:25]
  wire [6:0] simpleQ_io_enq_bits_req_op; // @[AecFp32Unit.scala 74:25]
  wire [3:0] simpleQ_io_enq_bits_req_dtype; // @[AecFp32Unit.scala 74:25]
  wire [63:0] simpleQ_io_enq_bits_req_a; // @[AecFp32Unit.scala 74:25]
  wire [63:0] simpleQ_io_enq_bits_req_b; // @[AecFp32Unit.scala 74:25]
  wire [7:0] simpleQ_io_enq_bits_req_dest; // @[AecFp32Unit.scala 74:25]
  wire  simpleQ_io_deq_ready; // @[AecFp32Unit.scala 74:25]
  wire  simpleQ_io_deq_valid; // @[AecFp32Unit.scala 74:25]
  wire [5:0] simpleQ_io_deq_bits_seq; // @[AecFp32Unit.scala 74:25]
  wire [6:0] simpleQ_io_deq_bits_req_op; // @[AecFp32Unit.scala 74:25]
  wire [3:0] simpleQ_io_deq_bits_req_dtype; // @[AecFp32Unit.scala 74:25]
  wire [63:0] simpleQ_io_deq_bits_req_a; // @[AecFp32Unit.scala 74:25]
  wire [63:0] simpleQ_io_deq_bits_req_b; // @[AecFp32Unit.scala 74:25]
  wire [7:0] simpleQ_io_deq_bits_req_dest; // @[AecFp32Unit.scala 74:25]
  wire [16:0] heldF16Cmp_io_a; // @[AecFp32Unit.scala 96:26]
  wire [16:0] heldF16Cmp_io_b; // @[AecFp32Unit.scala 96:26]
  wire  heldF16Cmp_io_lt; // @[AecFp32Unit.scala 96:26]
  wire  heldF16Cmp_io_eq; // @[AecFp32Unit.scala 96:26]
  wire  heldF16Cmp_io_gt; // @[AecFp32Unit.scala 96:26]
  wire [15:0] heldUp_0_io_in; // @[AecFp32Unit.scala 100:34]
  wire [31:0] heldUp_0_io_result; // @[AecFp32Unit.scala 100:34]
  wire [15:0] heldUp_1_io_in; // @[AecFp32Unit.scala 100:34]
  wire [31:0] heldUp_1_io_result; // @[AecFp32Unit.scala 100:34]
  wire [32:0] cmp32_io_a; // @[AecFp32Unit.scala 104:21]
  wire [32:0] cmp32_io_b; // @[AecFp32Unit.scala 104:21]
  wire  cmp32_io_lt; // @[AecFp32Unit.scala 104:21]
  wire  cmp32_io_eq; // @[AecFp32Unit.scala 104:21]
  wire  cmp32_io_gt; // @[AecFp32Unit.scala 104:21]
  wire [31:0] downF16_io_in; // @[AecFp32Unit.scala 146:23]
  wire [15:0] downF16_io_result; // @[AecFp32Unit.scala 146:23]
  wire [31:0] bf16Wide_io_in; // @[AecFp32Unit.scala 149:24]
  wire [63:0] bf16Wide_io_result; // @[AecFp32Unit.scala 149:24]
  wire [63:0] downBf16_io_in; // @[AecFp32Unit.scala 150:24]
  wire [15:0] downBf16_io_result; // @[AecFp32Unit.scala 150:24]
  wire  _reqPipe_T_3 = io_req_bits_op == 7'h3; // @[AecFp32Unit.scala 26:20]
  wire  _reqPipe_T_4 = io_req_bits_op == 7'h1 | io_req_bits_op == 7'h2 | _reqPipe_T_3; // @[AecFp32Unit.scala 25:82]
  wire  _reqPipe_T_7 = io_req_bits_op == 7'h5; // @[AecFp32Unit.scala 27:20]
  wire  reqPipe = _reqPipe_T_4 | io_req_bits_op == 7'h4 | _reqPipe_T_7; // @[AecFp32Unit.scala 26:70]
  wire [15:0] reqLow_0 = io_req_bits_a[15:0]; // @[AecFp32Unit.scala 30:35]
  wire [15:0] reqLow_1 = io_req_bits_b[15:0]; // @[AecFp32Unit.scala 30:59]
  wire [15:0] reqLow_2 = io_req_bits_c[15:0]; // @[AecFp32Unit.scala 30:83]
  wire [31:0] pipe_io_req_bits_a_f32 = io_req_bits_a[31:0]; // @[AecFp32Unit.scala 33:34]
  wire [31:0] _pipe_io_req_bits_a_T = {reqLow_0,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _pipe_io_req_bits_a_T_2 = 4'ha == io_req_bits_dtype ? f16Up_0_io_result : pipe_io_req_bits_a_f32; // @[Mux.scala 81:58]
  wire [31:0] _pipe_io_req_bits_a_T_4 = 4'hb == io_req_bits_dtype ? _pipe_io_req_bits_a_T : _pipe_io_req_bits_a_T_2; // @[Mux.scala 81:58]
  wire [31:0] _pipe_io_req_bits_b_T = {reqLow_1,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _pipe_io_req_bits_b_T_2 = 4'ha == io_req_bits_dtype ? f16Up_1_io_result : io_req_bits_b[31:0]; // @[Mux.scala 81:58]
  wire [31:0] _pipe_io_req_bits_b_T_4 = 4'hb == io_req_bits_dtype ? _pipe_io_req_bits_b_T : _pipe_io_req_bits_b_T_2; // @[Mux.scala 81:58]
  wire [31:0] _pipe_io_req_bits_c_T = {reqLow_2,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _pipe_io_req_bits_c_T_2 = 4'ha == io_req_bits_dtype ? f16Up_2_io_result : io_req_bits_c[31:0]; // @[Mux.scala 81:58]
  wire [31:0] _pipe_io_req_bits_c_T_4 = 4'hb == io_req_bits_dtype ? _pipe_io_req_bits_c_T : _pipe_io_req_bits_c_T_2; // @[Mux.scala 81:58]
  reg [5:0] issueSeq; // @[AecFp32Unit.scala 75:27]
  wire  _io_req_ready_T = reqPipe ? pipe_io_req_ready : simpleQ_io_enq_ready; // @[AecFp32Unit.scala 78:47]
  wire  _issueQ_io_enq_valid_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [5:0] _issueSeq_T_1 = issueSeq + 6'h1; // @[AecFp32Unit.scala 84:47]
  wire  pipeHead = pipe_io_resp_valid & issueQ_io_deq_valid & pipe_io_resp_bits_seq == issueQ_io_deq_bits; // @[AecFp32Unit.scala 86:59]
  wire  oldHead = simpleQ_io_deq_valid & issueQ_io_deq_valid & simpleQ_io_deq_bits_seq == issueQ_io_deq_bits; // @[AecFp32Unit.scala 87:60]
  wire [3:0] held_dtype = simpleQ_io_deq_bits_req_dtype; // @[AecFp32Unit.scala 46:18 85:10]
  wire  isF16 = held_dtype == 4'ha; // @[AecFp32Unit.scala 92:26]
  wire  isBF16 = held_dtype == 4'hb; // @[AecFp32Unit.scala 93:27]
  wire [63:0] held_a = simpleQ_io_deq_bits_req_a; // @[AecFp32Unit.scala 46:18 85:10]
  wire [15:0] heldF16_0 = held_a[15:0]; // @[AecFp32Unit.scala 95:27]
  wire [63:0] held_b = simpleQ_io_deq_bits_req_b; // @[AecFp32Unit.scala 46:18 85:10]
  wire [15:0] heldF16_1 = held_b[15:0]; // @[AecFp32Unit.scala 95:42]
  wire  heldF16Cmp_io_a_rawIn_sign = heldF16_0[15]; // @[rawFloatFromFN.scala 44:18]
  wire [4:0] heldF16Cmp_io_a_rawIn_expIn = heldF16_0[14:10]; // @[rawFloatFromFN.scala 45:19]
  wire [9:0] heldF16Cmp_io_a_rawIn_fractIn = heldF16_0[9:0]; // @[rawFloatFromFN.scala 46:21]
  wire  heldF16Cmp_io_a_rawIn_isZeroExpIn = heldF16Cmp_io_a_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 48:30]
  wire  heldF16Cmp_io_a_rawIn_isZeroFractIn = heldF16Cmp_io_a_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 49:34]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_10 = heldF16Cmp_io_a_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_11 = heldF16Cmp_io_a_rawIn_fractIn[2] ? 4'h7 :
    _heldF16Cmp_io_a_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_12 = heldF16Cmp_io_a_rawIn_fractIn[3] ? 4'h6 :
    _heldF16Cmp_io_a_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_13 = heldF16Cmp_io_a_rawIn_fractIn[4] ? 4'h5 :
    _heldF16Cmp_io_a_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_14 = heldF16Cmp_io_a_rawIn_fractIn[5] ? 4'h4 :
    _heldF16Cmp_io_a_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_15 = heldF16Cmp_io_a_rawIn_fractIn[6] ? 4'h3 :
    _heldF16Cmp_io_a_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_16 = heldF16Cmp_io_a_rawIn_fractIn[7] ? 4'h2 :
    _heldF16Cmp_io_a_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_a_rawIn_normDist_T_17 = heldF16Cmp_io_a_rawIn_fractIn[8] ? 4'h1 :
    _heldF16Cmp_io_a_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] heldF16Cmp_io_a_rawIn_normDist = heldF16Cmp_io_a_rawIn_fractIn[9] ? 4'h0 :
    _heldF16Cmp_io_a_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_17 = {{15'd0}, heldF16Cmp_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _heldF16Cmp_io_a_rawIn_subnormFract_T = _GEN_17 << heldF16Cmp_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] heldF16Cmp_io_a_rawIn_subnormFract = {_heldF16Cmp_io_a_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_1 = {{2'd0}, heldF16Cmp_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _heldF16Cmp_io_a_rawIn_adjustedExp_T = _GEN_1 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _heldF16Cmp_io_a_rawIn_adjustedExp_T_1 = heldF16Cmp_io_a_rawIn_isZeroExpIn ?
    _heldF16Cmp_io_a_rawIn_adjustedExp_T : {{1'd0}, heldF16Cmp_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _heldF16Cmp_io_a_rawIn_adjustedExp_T_2 = heldF16Cmp_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_2 = {{3'd0}, _heldF16Cmp_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _heldF16Cmp_io_a_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_2; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_3 = {{1'd0}, _heldF16Cmp_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] heldF16Cmp_io_a_rawIn_adjustedExp = _heldF16Cmp_io_a_rawIn_adjustedExp_T_1 + _GEN_3; // @[rawFloatFromFN.scala 57:9]
  wire  heldF16Cmp_io_a_rawIn_isZero = heldF16Cmp_io_a_rawIn_isZeroExpIn & heldF16Cmp_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  heldF16Cmp_io_a_rawIn_isSpecial = heldF16Cmp_io_a_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  heldF16Cmp_io_a_rawIn__isNaN = heldF16Cmp_io_a_rawIn_isSpecial & ~heldF16Cmp_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] heldF16Cmp_io_a_rawIn__sExp = {1'b0,$signed(heldF16Cmp_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _heldF16Cmp_io_a_rawIn_out_sig_T = ~heldF16Cmp_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _heldF16Cmp_io_a_rawIn_out_sig_T_2 = heldF16Cmp_io_a_rawIn_isZeroExpIn ? heldF16Cmp_io_a_rawIn_subnormFract
     : heldF16Cmp_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] heldF16Cmp_io_a_rawIn__sig = {1'h0,_heldF16Cmp_io_a_rawIn_out_sig_T,_heldF16Cmp_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _heldF16Cmp_io_a_T_1 = heldF16Cmp_io_a_rawIn_isZero ? 3'h0 : heldF16Cmp_io_a_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_4 = {{2'd0}, heldF16Cmp_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _heldF16Cmp_io_a_T_3 = _heldF16Cmp_io_a_T_1 | _GEN_4; // @[recFNFromFN.scala 48:76]
  wire [6:0] _heldF16Cmp_io_a_T_6 = {heldF16Cmp_io_a_rawIn_sign,_heldF16Cmp_io_a_T_3,heldF16Cmp_io_a_rawIn__sExp[2:0]}; // @[recFNFromFN.scala 49:45]
  wire  heldF16Cmp_io_b_rawIn_sign = heldF16_1[15]; // @[rawFloatFromFN.scala 44:18]
  wire [4:0] heldF16Cmp_io_b_rawIn_expIn = heldF16_1[14:10]; // @[rawFloatFromFN.scala 45:19]
  wire [9:0] heldF16Cmp_io_b_rawIn_fractIn = heldF16_1[9:0]; // @[rawFloatFromFN.scala 46:21]
  wire  heldF16Cmp_io_b_rawIn_isZeroExpIn = heldF16Cmp_io_b_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 48:30]
  wire  heldF16Cmp_io_b_rawIn_isZeroFractIn = heldF16Cmp_io_b_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 49:34]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_10 = heldF16Cmp_io_b_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_11 = heldF16Cmp_io_b_rawIn_fractIn[2] ? 4'h7 :
    _heldF16Cmp_io_b_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_12 = heldF16Cmp_io_b_rawIn_fractIn[3] ? 4'h6 :
    _heldF16Cmp_io_b_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_13 = heldF16Cmp_io_b_rawIn_fractIn[4] ? 4'h5 :
    _heldF16Cmp_io_b_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_14 = heldF16Cmp_io_b_rawIn_fractIn[5] ? 4'h4 :
    _heldF16Cmp_io_b_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_15 = heldF16Cmp_io_b_rawIn_fractIn[6] ? 4'h3 :
    _heldF16Cmp_io_b_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_16 = heldF16Cmp_io_b_rawIn_fractIn[7] ? 4'h2 :
    _heldF16Cmp_io_b_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _heldF16Cmp_io_b_rawIn_normDist_T_17 = heldF16Cmp_io_b_rawIn_fractIn[8] ? 4'h1 :
    _heldF16Cmp_io_b_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] heldF16Cmp_io_b_rawIn_normDist = heldF16Cmp_io_b_rawIn_fractIn[9] ? 4'h0 :
    _heldF16Cmp_io_b_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_18 = {{15'd0}, heldF16Cmp_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _heldF16Cmp_io_b_rawIn_subnormFract_T = _GEN_18 << heldF16Cmp_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] heldF16Cmp_io_b_rawIn_subnormFract = {_heldF16Cmp_io_b_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_5 = {{2'd0}, heldF16Cmp_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _heldF16Cmp_io_b_rawIn_adjustedExp_T = _GEN_5 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _heldF16Cmp_io_b_rawIn_adjustedExp_T_1 = heldF16Cmp_io_b_rawIn_isZeroExpIn ?
    _heldF16Cmp_io_b_rawIn_adjustedExp_T : {{1'd0}, heldF16Cmp_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _heldF16Cmp_io_b_rawIn_adjustedExp_T_2 = heldF16Cmp_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_6 = {{3'd0}, _heldF16Cmp_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _heldF16Cmp_io_b_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_6; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_7 = {{1'd0}, _heldF16Cmp_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] heldF16Cmp_io_b_rawIn_adjustedExp = _heldF16Cmp_io_b_rawIn_adjustedExp_T_1 + _GEN_7; // @[rawFloatFromFN.scala 57:9]
  wire  heldF16Cmp_io_b_rawIn_isZero = heldF16Cmp_io_b_rawIn_isZeroExpIn & heldF16Cmp_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  heldF16Cmp_io_b_rawIn_isSpecial = heldF16Cmp_io_b_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  heldF16Cmp_io_b_rawIn__isNaN = heldF16Cmp_io_b_rawIn_isSpecial & ~heldF16Cmp_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] heldF16Cmp_io_b_rawIn__sExp = {1'b0,$signed(heldF16Cmp_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _heldF16Cmp_io_b_rawIn_out_sig_T = ~heldF16Cmp_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _heldF16Cmp_io_b_rawIn_out_sig_T_2 = heldF16Cmp_io_b_rawIn_isZeroExpIn ? heldF16Cmp_io_b_rawIn_subnormFract
     : heldF16Cmp_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] heldF16Cmp_io_b_rawIn__sig = {1'h0,_heldF16Cmp_io_b_rawIn_out_sig_T,_heldF16Cmp_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _heldF16Cmp_io_b_T_1 = heldF16Cmp_io_b_rawIn_isZero ? 3'h0 : heldF16Cmp_io_b_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_8 = {{2'd0}, heldF16Cmp_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _heldF16Cmp_io_b_T_3 = _heldF16Cmp_io_b_T_1 | _GEN_8; // @[recFNFromFN.scala 48:76]
  wire [6:0] _heldF16Cmp_io_b_T_6 = {heldF16Cmp_io_b_rawIn_sign,_heldF16Cmp_io_b_T_3,heldF16Cmp_io_b_rawIn__sExp[2:0]}; // @[recFNFromFN.scala 49:45]
  wire [31:0] _heldA32_T_2 = {heldF16_0,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _heldA32_T_4 = 4'ha == held_dtype ? heldUp_0_io_result : held_a[31:0]; // @[Mux.scala 81:58]
  wire [31:0] heldA32 = 4'hb == held_dtype ? _heldA32_T_2 : _heldA32_T_4; // @[Mux.scala 81:58]
  wire [31:0] _heldB32_T_2 = {heldF16_1,16'h0}; // @[Cat.scala 33:92]
  wire [31:0] _heldB32_T_4 = 4'ha == held_dtype ? heldUp_1_io_result : held_b[31:0]; // @[Mux.scala 81:58]
  wire [31:0] heldB32 = 4'hb == held_dtype ? _heldB32_T_2 : _heldB32_T_4; // @[Mux.scala 81:58]
  wire  cmp32_io_a_rawIn_sign = heldA32[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] cmp32_io_a_rawIn_expIn = heldA32[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] cmp32_io_a_rawIn_fractIn = heldA32[22:0]; // @[rawFloatFromFN.scala 46:21]
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
  wire [53:0] _GEN_19 = {{31'd0}, cmp32_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_a_rawIn_subnormFract_T = _GEN_19 << cmp32_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] cmp32_io_a_rawIn_subnormFract = {_cmp32_io_a_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_9 = {{4'd0}, cmp32_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_a_rawIn_adjustedExp_T = _GEN_9 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_a_rawIn_adjustedExp_T_1 = cmp32_io_a_rawIn_isZeroExpIn ? _cmp32_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp32_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp32_io_a_rawIn_adjustedExp_T_2 = cmp32_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_10 = {{6'd0}, _cmp32_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _cmp32_io_a_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_10; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_11 = {{1'd0}, _cmp32_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] cmp32_io_a_rawIn_adjustedExp = _cmp32_io_a_rawIn_adjustedExp_T_1 + _GEN_11; // @[rawFloatFromFN.scala 57:9]
  wire  cmp32_io_a_rawIn_isZero = cmp32_io_a_rawIn_isZeroExpIn & cmp32_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp32_io_a_rawIn_isSpecial = cmp32_io_a_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp32_io_a_rawIn__isNaN = cmp32_io_a_rawIn_isSpecial & ~cmp32_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] cmp32_io_a_rawIn__sExp = {1'b0,$signed(cmp32_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp32_io_a_rawIn_out_sig_T = ~cmp32_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _cmp32_io_a_rawIn_out_sig_T_2 = cmp32_io_a_rawIn_isZeroExpIn ? cmp32_io_a_rawIn_subnormFract :
    cmp32_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] cmp32_io_a_rawIn__sig = {1'h0,_cmp32_io_a_rawIn_out_sig_T,_cmp32_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp32_io_a_T_1 = cmp32_io_a_rawIn_isZero ? 3'h0 : cmp32_io_a_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_12 = {{2'd0}, cmp32_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_a_T_3 = _cmp32_io_a_T_1 | _GEN_12; // @[recFNFromFN.scala 48:76]
  wire [9:0] _cmp32_io_a_T_6 = {cmp32_io_a_rawIn_sign,_cmp32_io_a_T_3,cmp32_io_a_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire  cmp32_io_b_rawIn_sign = heldB32[31]; // @[rawFloatFromFN.scala 44:18]
  wire [7:0] cmp32_io_b_rawIn_expIn = heldB32[30:23]; // @[rawFloatFromFN.scala 45:19]
  wire [22:0] cmp32_io_b_rawIn_fractIn = heldB32[22:0]; // @[rawFloatFromFN.scala 46:21]
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
  wire [53:0] _GEN_20 = {{31'd0}, cmp32_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_b_rawIn_subnormFract_T = _GEN_20 << cmp32_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [22:0] cmp32_io_b_rawIn_subnormFract = {_cmp32_io_b_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [8:0] _GEN_13 = {{4'd0}, cmp32_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_b_rawIn_adjustedExp_T = _GEN_13 ^ 9'h1ff; // @[rawFloatFromFN.scala 55:18]
  wire [8:0] _cmp32_io_b_rawIn_adjustedExp_T_1 = cmp32_io_b_rawIn_isZeroExpIn ? _cmp32_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp32_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp32_io_b_rawIn_adjustedExp_T_2 = cmp32_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [7:0] _GEN_14 = {{6'd0}, _cmp32_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [7:0] _cmp32_io_b_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_14; // @[rawFloatFromFN.scala 58:9]
  wire [8:0] _GEN_15 = {{1'd0}, _cmp32_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [8:0] cmp32_io_b_rawIn_adjustedExp = _cmp32_io_b_rawIn_adjustedExp_T_1 + _GEN_15; // @[rawFloatFromFN.scala 57:9]
  wire  cmp32_io_b_rawIn_isZero = cmp32_io_b_rawIn_isZeroExpIn & cmp32_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp32_io_b_rawIn_isSpecial = cmp32_io_b_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp32_io_b_rawIn__isNaN = cmp32_io_b_rawIn_isSpecial & ~cmp32_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [9:0] cmp32_io_b_rawIn__sExp = {1'b0,$signed(cmp32_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp32_io_b_rawIn_out_sig_T = ~cmp32_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [22:0] _cmp32_io_b_rawIn_out_sig_T_2 = cmp32_io_b_rawIn_isZeroExpIn ? cmp32_io_b_rawIn_subnormFract :
    cmp32_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [24:0] cmp32_io_b_rawIn__sig = {1'h0,_cmp32_io_b_rawIn_out_sig_T,_cmp32_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp32_io_b_T_1 = cmp32_io_b_rawIn_isZero ? 3'h0 : cmp32_io_b_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_16 = {{2'd0}, cmp32_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_b_T_3 = _cmp32_io_b_T_1 | _GEN_16; // @[recFNFromFN.scala 48:76]
  wire [9:0] _cmp32_io_b_T_6 = {cmp32_io_b_rawIn_sign,_cmp32_io_b_T_3,cmp32_io_b_rawIn__sExp[5:0]}; // @[recFNFromFN.scala 49:45]
  wire [6:0] held_op = simpleQ_io_deq_bits_req_op; // @[AecFp32Unit.scala 46:18 85:10]
  wire  _cmpMode_T = held_op >= 7'h28; // @[AecFp32Unit.scala 106:29]
  wire [6:0] _cmpMode_T_2 = held_op - 7'h28; // @[AecFp32Unit.scala 106:58]
  wire [6:0] _cmpMode_T_4 = held_op - 7'h20; // @[AecFp32Unit.scala 106:86]
  wire [6:0] cmpMode = held_op >= 7'h28 ? _cmpMode_T_2 : _cmpMode_T_4; // @[AecFp32Unit.scala 106:20]
  wire  eq = isF16 ? heldF16Cmp_io_eq : cmp32_io_eq; // @[AecFp32Unit.scala 107:15]
  wire  lt = isF16 ? heldF16Cmp_io_lt : cmp32_io_lt; // @[AecFp32Unit.scala 108:15]
  wire  gt = isF16 ? heldF16Cmp_io_gt : cmp32_io_gt; // @[AecFp32Unit.scala 109:15]
  wire  _cmpTrue_T = ~eq; // @[AecFp32Unit.scala 111:23]
  wire  _cmpTrue_T_1 = lt | eq; // @[AecFp32Unit.scala 111:50]
  wire  _cmpTrue_T_2 = gt | eq; // @[AecFp32Unit.scala 111:80]
  wire  _cmpTrue_T_6 = 7'h1 == cmpMode ? _cmpTrue_T : 7'h0 == cmpMode & eq; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_8 = 7'h2 == cmpMode ? lt : _cmpTrue_T_6; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_10 = 7'h3 == cmpMode ? _cmpTrue_T_1 : _cmpTrue_T_8; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_12 = 7'h4 == cmpMode ? gt : _cmpTrue_T_10; // @[Mux.scala 81:58]
  wire  cmpTrue = 7'h5 == cmpMode ? _cmpTrue_T_2 : _cmpTrue_T_12; // @[Mux.scala 81:58]
  wire  _narrowUnary_T = held_op == 7'h8; // @[AecFp32Unit.scala 115:33]
  wire [15:0] _narrowUnary_T_2 = heldF16_0 & 16'h7fff; // @[AecFp32Unit.scala 115:64]
  wire  _narrowUnary_T_3 = held_op == 7'h7; // @[AecFp32Unit.scala 116:17]
  wire [15:0] _narrowUnary_T_5 = heldF16_0 ^ 16'h8000; // @[AecFp32Unit.scala 116:48]
  wire [15:0] _narrowUnary_T_7 = held_op == 7'h7 ? _narrowUnary_T_5 : heldF16_0; // @[AecFp32Unit.scala 116:8]
  wire [15:0] narrowUnary = held_op == 7'h8 ? _narrowUnary_T_2 : _narrowUnary_T_7; // @[AecFp32Unit.scala 115:24]
  wire [31:0] _wideUnary_T_2 = held_a[31:0] & 32'h7fffffff; // @[AecFp32Unit.scala 117:62]
  wire [31:0] _wideUnary_T_5 = held_a[31:0] ^ 32'h80000000; // @[AecFp32Unit.scala 118:48]
  wire [31:0] _wideUnary_T_7 = _narrowUnary_T_3 ? _wideUnary_T_5 : held_a[31:0]; // @[AecFp32Unit.scala 118:8]
  wire [31:0] wideUnary = _narrowUnary_T ? _wideUnary_T_2 : _wideUnary_T_7; // @[AecFp32Unit.scala 117:22]
  wire  _unaryResult_T = isF16 | isBF16; // @[AecFp32Unit.scala 119:31]
  wire [63:0] _unaryResult_T_1 = {48'h0,narrowUnary}; // @[Cat.scala 33:92]
  wire [63:0] _unaryResult_T_2 = {32'h0,wideUnary}; // @[Cat.scala 33:92]
  wire [63:0] unaryResult = isF16 | isBF16 ? _unaryResult_T_1 : _unaryResult_T_2; // @[AecFp32Unit.scala 119:24]
  wire  isCmp = held_op >= 7'h20 & held_op < 7'h26; // @[AecFp32Unit.scala 121:42]
  wire  isCmpP = _cmpMode_T & held_op < 7'h2e; // @[AecFp32Unit.scala 122:44]
  wire  _isMinMax_T = held_op == 7'h9; // @[AecFp32Unit.scala 123:26]
  wire  isMinMax = held_op == 7'h9 | held_op == 7'ha; // @[AecFp32Unit.scala 123:42]
  wire  _aNaN16_T_9 = &heldF16_0[14:7] & |heldF16_0[6:0]; // @[AecFp32Unit.scala 126:24]
  wire  aNaN16 = isF16 ? &heldF16Cmp_io_a_rawIn_expIn & |heldF16Cmp_io_a_rawIn_fractIn : _aNaN16_T_9; // @[AecFp32Unit.scala 125:19]
  wire  _bNaN16_T_9 = &heldF16_1[14:7] & |heldF16_1[6:0]; // @[AecFp32Unit.scala 128:24]
  wire  bNaN16 = isF16 ? &heldF16Cmp_io_b_rawIn_expIn & |heldF16Cmp_io_b_rawIn_fractIn : _bNaN16_T_9; // @[AecFp32Unit.scala 127:19]
  wire  bothZero16 = heldF16_0[14:0] == 15'h0 & heldF16_1[14:0] == 15'h0; // @[AecFp32Unit.scala 129:42]
  wire  _min16_T_2 = heldF16Cmp_io_a_rawIn_sign | heldF16Cmp_io_b_rawIn_sign; // @[AecFp32Unit.scala 130:46]
  wire [15:0] _min16_T_3 = {_min16_T_2,15'h0}; // @[Cat.scala 33:92]
  wire [15:0] _min16_T_4 = lt ? heldF16_0 : heldF16_1; // @[AecFp32Unit.scala 130:75]
  wire [15:0] min16 = bothZero16 ? _min16_T_3 : _min16_T_4; // @[AecFp32Unit.scala 130:18]
  wire  _max16_T_2 = heldF16Cmp_io_a_rawIn_sign & heldF16Cmp_io_b_rawIn_sign; // @[AecFp32Unit.scala 131:46]
  wire [15:0] _max16_T_3 = {_max16_T_2,15'h0}; // @[Cat.scala 33:92]
  wire [15:0] _max16_T_4 = gt ? heldF16_0 : heldF16_1; // @[AecFp32Unit.scala 131:75]
  wire [15:0] max16 = bothZero16 ? _max16_T_3 : _max16_T_4; // @[AecFp32Unit.scala 131:18]
  wire [15:0] canonical16 = isF16 ? 16'h7e00 : 16'h7fc0; // @[AecFp32Unit.scala 132:24]
  wire [15:0] _minMax16_T_2 = _isMinMax_T ? min16 : max16; // @[AecFp32Unit.scala 134:48]
  wire [15:0] _minMax16_T_3 = bNaN16 ? heldF16_0 : _minMax16_T_2; // @[AecFp32Unit.scala 134:28]
  wire [15:0] _minMax16_T_4 = aNaN16 ? heldF16_1 : _minMax16_T_3; // @[AecFp32Unit.scala 134:8]
  wire [15:0] minMax16 = aNaN16 & bNaN16 ? canonical16 : _minMax16_T_4; // @[AecFp32Unit.scala 133:21]
  wire  aNaN32 = &held_a[30:23] & |held_a[22:0]; // @[AecFp32Unit.scala 136:36]
  wire  bNaN32 = &held_b[30:23] & |held_b[22:0]; // @[AecFp32Unit.scala 137:36]
  wire  bothZero32 = held_a[30:0] == 31'h0 & held_b[30:0] == 31'h0; // @[AecFp32Unit.scala 138:42]
  wire  _min32_T_2 = held_a[31] | held_b[31]; // @[AecFp32Unit.scala 139:46]
  wire [31:0] _min32_T_3 = {_min32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _min32_T_4 = lt ? held_a[31:0] : held_b[31:0]; // @[AecFp32Unit.scala 139:75]
  wire [31:0] min32 = bothZero32 ? _min32_T_3 : _min32_T_4; // @[AecFp32Unit.scala 139:18]
  wire  _max32_T_2 = held_a[31] & held_b[31]; // @[AecFp32Unit.scala 140:46]
  wire [31:0] _max32_T_3 = {_max32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _max32_T_4 = gt ? held_a[31:0] : held_b[31:0]; // @[AecFp32Unit.scala 140:75]
  wire [31:0] max32 = bothZero32 ? _max32_T_3 : _max32_T_4; // @[AecFp32Unit.scala 140:18]
  wire [31:0] _minMax32_T_2 = _isMinMax_T ? min32 : max32; // @[AecFp32Unit.scala 142:48]
  wire [31:0] _minMax32_T_3 = bNaN32 ? held_a[31:0] : _minMax32_T_2; // @[AecFp32Unit.scala 142:28]
  wire [31:0] _minMax32_T_4 = aNaN32 ? held_b[31:0] : _minMax32_T_3; // @[AecFp32Unit.scala 142:8]
  wire [31:0] minMax32 = aNaN32 & bNaN32 ? 32'h7fc00000 : _minMax32_T_4; // @[AecFp32Unit.scala 141:21]
  wire [63:0] _minMaxResult_T_1 = {48'h0,minMax16}; // @[Cat.scala 33:92]
  wire [63:0] _minMaxResult_T_2 = {32'h0,minMax32}; // @[Cat.scala 33:92]
  wire [63:0] minMaxResult = _unaryResult_T ? _minMaxResult_T_1 : _minMaxResult_T_2; // @[AecFp32Unit.scala 143:25]
  wire  _oldResult_T = isCmp | isCmpP; // @[AecFp32Unit.scala 144:29]
  wire [63:0] _oldResult_T_1 = {63'h0,cmpTrue}; // @[Cat.scala 33:92]
  wire [63:0] _oldResult_T_2 = isMinMax ? minMaxResult : unaryResult; // @[AecFp32Unit.scala 145:8]
  wire [63:0] oldResult = isCmp | isCmpP ? _oldResult_T_1 : _oldResult_T_2; // @[AecFp32Unit.scala 144:22]
  wire [31:0] pipeFixed = pipe_io_resp_bits_result[31:0]; // @[AecFp32Unit.scala 151:41]
  wire  pipeNaN = pipeFixed[30:23] == 8'hff & |pipeFixed[22:0]; // @[AecFp32Unit.scala 152:43]
  wire [63:0] _pipeResult_T = {32'h0,pipeFixed}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_1 = {48'h0,downF16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_2 = pipeNaN ? 64'h7e00 : _pipeResult_T_1; // @[AecFp32Unit.scala 158:16]
  wire [63:0] _pipeResult_T_3 = {48'h0,downBf16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_4 = pipeNaN ? 64'h7fc0 : _pipeResult_T_3; // @[AecFp32Unit.scala 159:16]
  wire [63:0] _pipeResult_T_6 = 4'ha == pipe_io_resp_bits_dtype ? _pipeResult_T_2 : _pipeResult_T; // @[Mux.scala 81:58]
  wire [63:0] pipeResult = 4'hb == pipe_io_resp_bits_dtype ? _pipeResult_T_4 : _pipeResult_T_6; // @[Mux.scala 81:58]
  wire  oldPredicate = isCmpP & cmpTrue; // @[AecFp32Unit.scala 162:29]
  wire  oldError = ~(_oldResult_T | isMinMax | _narrowUnary_T_3 | _narrowUnary_T); // @[AecFp32Unit.scala 163:18]
  wire [7:0] held_dest = simpleQ_io_deq_bits_req_dest; // @[AecFp32Unit.scala 46:18 85:10]
  YunSuanFmaPipe pipe ( // @[AecFp32Unit.scala 23:20]
    .clock(pipe_clock),
    .reset(pipe_reset),
    .io_req_ready(pipe_io_req_ready),
    .io_req_valid(pipe_io_req_valid),
    .io_req_bits_op(pipe_io_req_bits_op),
    .io_req_bits_a(pipe_io_req_bits_a),
    .io_req_bits_b(pipe_io_req_bits_b),
    .io_req_bits_c(pipe_io_req_bits_c),
    .io_req_bits_seq(pipe_io_req_bits_seq),
    .io_req_bits_dest(pipe_io_req_bits_dest),
    .io_req_bits_dtype(pipe_io_req_bits_dtype),
    .io_resp_ready(pipe_io_resp_ready),
    .io_resp_valid(pipe_io_resp_valid),
    .io_resp_bits_result(pipe_io_resp_bits_result),
    .io_resp_bits_fflags(pipe_io_resp_bits_fflags),
    .io_resp_bits_seq(pipe_io_resp_bits_seq),
    .io_resp_bits_dest(pipe_io_resp_bits_dest),
    .io_resp_bits_dtype(pipe_io_resp_bits_dtype)
  );
  FPToFP f16Up_0 ( // @[AecFp32Unit.scala 29:33]
    .io_in(f16Up_0_io_in),
    .io_result(f16Up_0_io_result)
  );
  FPToFP f16Up_1 ( // @[AecFp32Unit.scala 29:33]
    .io_in(f16Up_1_io_in),
    .io_result(f16Up_1_io_result)
  );
  FPToFP f16Up_2 ( // @[AecFp32Unit.scala 29:33]
    .io_in(f16Up_2_io_in),
    .io_result(f16Up_2_io_result)
  );
  Queue_1 issueQ ( // @[AecFp32Unit.scala 73:24]
    .clock(issueQ_clock),
    .reset(issueQ_reset),
    .io_enq_ready(issueQ_io_enq_ready),
    .io_enq_valid(issueQ_io_enq_valid),
    .io_enq_bits(issueQ_io_enq_bits),
    .io_deq_ready(issueQ_io_deq_ready),
    .io_deq_valid(issueQ_io_deq_valid),
    .io_deq_bits(issueQ_io_deq_bits)
  );
  Queue_2 simpleQ ( // @[AecFp32Unit.scala 74:25]
    .clock(simpleQ_clock),
    .reset(simpleQ_reset),
    .io_enq_ready(simpleQ_io_enq_ready),
    .io_enq_valid(simpleQ_io_enq_valid),
    .io_enq_bits_seq(simpleQ_io_enq_bits_seq),
    .io_enq_bits_req_op(simpleQ_io_enq_bits_req_op),
    .io_enq_bits_req_dtype(simpleQ_io_enq_bits_req_dtype),
    .io_enq_bits_req_a(simpleQ_io_enq_bits_req_a),
    .io_enq_bits_req_b(simpleQ_io_enq_bits_req_b),
    .io_enq_bits_req_dest(simpleQ_io_enq_bits_req_dest),
    .io_deq_ready(simpleQ_io_deq_ready),
    .io_deq_valid(simpleQ_io_deq_valid),
    .io_deq_bits_seq(simpleQ_io_deq_bits_seq),
    .io_deq_bits_req_op(simpleQ_io_deq_bits_req_op),
    .io_deq_bits_req_dtype(simpleQ_io_deq_bits_req_dtype),
    .io_deq_bits_req_a(simpleQ_io_deq_bits_req_a),
    .io_deq_bits_req_b(simpleQ_io_deq_bits_req_b),
    .io_deq_bits_req_dest(simpleQ_io_deq_bits_req_dest)
  );
  CompareRecFN heldF16Cmp ( // @[AecFp32Unit.scala 96:26]
    .io_a(heldF16Cmp_io_a),
    .io_b(heldF16Cmp_io_b),
    .io_lt(heldF16Cmp_io_lt),
    .io_eq(heldF16Cmp_io_eq),
    .io_gt(heldF16Cmp_io_gt)
  );
  FPToFP heldUp_0 ( // @[AecFp32Unit.scala 100:34]
    .io_in(heldUp_0_io_in),
    .io_result(heldUp_0_io_result)
  );
  FPToFP heldUp_1 ( // @[AecFp32Unit.scala 100:34]
    .io_in(heldUp_1_io_in),
    .io_result(heldUp_1_io_result)
  );
  CompareRecFN_1 cmp32 ( // @[AecFp32Unit.scala 104:21]
    .io_a(cmp32_io_a),
    .io_b(cmp32_io_b),
    .io_lt(cmp32_io_lt),
    .io_eq(cmp32_io_eq),
    .io_gt(cmp32_io_gt)
  );
  FPToFP_5 downF16 ( // @[AecFp32Unit.scala 146:23]
    .io_in(downF16_io_in),
    .io_result(downF16_io_result)
  );
  FPToFP_6 bf16Wide ( // @[AecFp32Unit.scala 149:24]
    .io_in(bf16Wide_io_in),
    .io_result(bf16Wide_io_result)
  );
  FPToFP_7 downBf16 ( // @[AecFp32Unit.scala 150:24]
    .io_in(downBf16_io_in),
    .io_result(downBf16_io_result)
  );
  assign io_req_ready = issueQ_io_enq_ready & _io_req_ready_T; // @[AecFp32Unit.scala 78:41]
  assign io_resp_valid = pipeHead | oldHead; // @[AecFp32Unit.scala 160:29]
  assign io_resp_bits_result = pipeHead ? pipeResult : oldResult; // @[AecFp32Unit.scala 178:31]
  assign io_resp_bits_predicate_result = pipeHead ? 1'h0 : oldPredicate; // @[AecFp32Unit.scala 179:41]
  assign io_resp_bits_dest = pipeHead ? pipe_io_resp_bits_dest : held_dest; // @[AecFp32Unit.scala 180:29]
  assign io_resp_bits_error = pipeHead ? 1'h0 : oldError; // @[AecFp32Unit.scala 181:30]
  assign io_resp_bits_exception_flags = pipeHead ? pipe_io_resp_bits_fflags : 5'h0; // @[AecFp32Unit.scala 182:40]
  assign pipe_clock = clock;
  assign pipe_reset = reset;
  assign pipe_io_req_valid = io_req_valid & reqPipe & issueQ_io_enq_ready; // @[AecFp32Unit.scala 77:50]
  assign pipe_io_req_bits_op = io_req_bits_op; // @[AecFp32Unit.scala 37:23]
  assign pipe_io_req_bits_a = {32'h0,_pipe_io_req_bits_a_T_4}; // @[Cat.scala 33:92]
  assign pipe_io_req_bits_b = {32'h0,_pipe_io_req_bits_b_T_4}; // @[Cat.scala 33:92]
  assign pipe_io_req_bits_c = {32'h0,_pipe_io_req_bits_c_T_4}; // @[Cat.scala 33:92]
  assign pipe_io_req_bits_seq = issueSeq; // @[AecFp32Unit.scala 42:21 76:13]
  assign pipe_io_req_bits_dest = io_req_bits_dest; // @[AecFp32Unit.scala 44:25]
  assign pipe_io_req_bits_dtype = io_req_bits_dtype; // @[AecFp32Unit.scala 45:26]
  assign pipe_io_resp_ready = io_resp_ready & pipeHead; // @[AecFp32Unit.scala 161:39]
  assign f16Up_0_io_in = io_req_bits_a[15:0]; // @[AecFp32Unit.scala 30:35]
  assign f16Up_1_io_in = io_req_bits_b[15:0]; // @[AecFp32Unit.scala 30:59]
  assign f16Up_2_io_in = io_req_bits_c[15:0]; // @[AecFp32Unit.scala 30:83]
  assign issueQ_clock = clock;
  assign issueQ_reset = reset;
  assign issueQ_io_enq_valid = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign issueQ_io_enq_bits = issueSeq; // @[AecFp32Unit.scala 80:24]
  assign issueQ_io_deq_ready = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign simpleQ_clock = clock;
  assign simpleQ_reset = reset;
  assign simpleQ_io_enq_valid = io_req_valid & ~reqPipe & issueQ_io_enq_ready; // @[AecFp32Unit.scala 81:54]
  assign simpleQ_io_enq_bits_seq = issueSeq; // @[AecFp32Unit.scala 82:29]
  assign simpleQ_io_enq_bits_req_op = io_req_bits_op; // @[AecFp32Unit.scala 83:29]
  assign simpleQ_io_enq_bits_req_dtype = io_req_bits_dtype; // @[AecFp32Unit.scala 83:29]
  assign simpleQ_io_enq_bits_req_a = io_req_bits_a; // @[AecFp32Unit.scala 83:29]
  assign simpleQ_io_enq_bits_req_b = io_req_bits_b; // @[AecFp32Unit.scala 83:29]
  assign simpleQ_io_enq_bits_req_dest = io_req_bits_dest; // @[AecFp32Unit.scala 83:29]
  assign simpleQ_io_deq_ready = io_resp_ready & oldHead; // @[AecFp32Unit.scala 89:43]
  assign heldF16Cmp_io_a = {_heldF16Cmp_io_a_T_6,heldF16Cmp_io_a_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign heldF16Cmp_io_b = {_heldF16Cmp_io_b_T_6,heldF16Cmp_io_b_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign heldUp_0_io_in = held_a[15:0]; // @[AecFp32Unit.scala 95:27]
  assign heldUp_1_io_in = held_b[15:0]; // @[AecFp32Unit.scala 95:42]
  assign cmp32_io_a = {_cmp32_io_a_T_6,cmp32_io_a_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_b = {_cmp32_io_b_T_6,cmp32_io_b_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign downF16_io_in = pipe_io_resp_bits_result[31:0]; // @[AecFp32Unit.scala 151:41]
  assign bf16Wide_io_in = pipe_io_resp_bits_result[31:0]; // @[AecFp32Unit.scala 151:41]
  assign downBf16_io_in = bf16Wide_io_result; // @[AecFp32Unit.scala 156:18]
  always @(posedge clock) begin
    if (reset) begin // @[AecFp32Unit.scala 75:27]
      issueSeq <= 6'h0; // @[AecFp32Unit.scala 75:27]
    end else if (_issueQ_io_enq_valid_T) begin // @[AecFp32Unit.scala 84:24]
      issueSeq <= _issueSeq_T_1; // @[AecFp32Unit.scala 84:35]
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
  issueSeq = _RAND_0[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
