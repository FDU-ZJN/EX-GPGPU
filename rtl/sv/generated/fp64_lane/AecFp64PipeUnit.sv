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
  output [106:0] io_out_pp_12,
  output [106:0] io_out_pp_13,
  output [106:0] io_out_pp_14,
  output [106:0] io_out_pp_15,
  output [106:0] io_out_pp_16,
  output [106:0] io_out_pp_17,
  output [106:0] io_out_pp_18,
  output [106:0] io_out_pp_19,
  output [106:0] io_out_pp_20,
  output [106:0] io_out_pp_21,
  output [106:0] io_out_pp_22,
  output [106:0] io_out_pp_23,
  output [106:0] io_out_pp_24,
  output [106:0] io_out_pp_25,
  output [106:0] io_out_pp_26
);
  wire [54:0] in_b_cat = {1'h0,io_in_b,1'h0}; // @[Cat.scala 33:92]
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
  wire [2:0] booth_seq_13 = in_b_cat[28:26]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_78 = 3'h6 == booth_seq_13 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_79 = 3'h5 == booth_seq_13 ? 2'h2 : _GEN_78; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_80 = 3'h4 == booth_seq_13 ? 2'h1 : _GEN_79; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_81 = 3'h3 == booth_seq_13 ? 3'h4 : {{1'd0}, _GEN_80}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_82 = 3'h2 == booth_seq_13 ? 4'h8 : {{1'd0}, _GEN_81}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_13 = 3'h1 == booth_seq_13 ? 4'h8 : _GEN_82; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_14 = in_b_cat[30:28]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_84 = 3'h6 == booth_seq_14 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_85 = 3'h5 == booth_seq_14 ? 2'h2 : _GEN_84; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_86 = 3'h4 == booth_seq_14 ? 2'h1 : _GEN_85; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_87 = 3'h3 == booth_seq_14 ? 3'h4 : {{1'd0}, _GEN_86}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_88 = 3'h2 == booth_seq_14 ? 4'h8 : {{1'd0}, _GEN_87}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_14 = 3'h1 == booth_seq_14 ? 4'h8 : _GEN_88; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_15 = in_b_cat[32:30]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_90 = 3'h6 == booth_seq_15 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_91 = 3'h5 == booth_seq_15 ? 2'h2 : _GEN_90; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_92 = 3'h4 == booth_seq_15 ? 2'h1 : _GEN_91; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_93 = 3'h3 == booth_seq_15 ? 3'h4 : {{1'd0}, _GEN_92}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_94 = 3'h2 == booth_seq_15 ? 4'h8 : {{1'd0}, _GEN_93}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_15 = 3'h1 == booth_seq_15 ? 4'h8 : _GEN_94; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_16 = in_b_cat[34:32]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_96 = 3'h6 == booth_seq_16 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_97 = 3'h5 == booth_seq_16 ? 2'h2 : _GEN_96; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_98 = 3'h4 == booth_seq_16 ? 2'h1 : _GEN_97; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_99 = 3'h3 == booth_seq_16 ? 3'h4 : {{1'd0}, _GEN_98}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_100 = 3'h2 == booth_seq_16 ? 4'h8 : {{1'd0}, _GEN_99}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_16 = 3'h1 == booth_seq_16 ? 4'h8 : _GEN_100; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_17 = in_b_cat[36:34]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_102 = 3'h6 == booth_seq_17 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_103 = 3'h5 == booth_seq_17 ? 2'h2 : _GEN_102; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_104 = 3'h4 == booth_seq_17 ? 2'h1 : _GEN_103; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_105 = 3'h3 == booth_seq_17 ? 3'h4 : {{1'd0}, _GEN_104}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_106 = 3'h2 == booth_seq_17 ? 4'h8 : {{1'd0}, _GEN_105}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_17 = 3'h1 == booth_seq_17 ? 4'h8 : _GEN_106; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_18 = in_b_cat[38:36]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_108 = 3'h6 == booth_seq_18 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_109 = 3'h5 == booth_seq_18 ? 2'h2 : _GEN_108; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_110 = 3'h4 == booth_seq_18 ? 2'h1 : _GEN_109; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_111 = 3'h3 == booth_seq_18 ? 3'h4 : {{1'd0}, _GEN_110}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_112 = 3'h2 == booth_seq_18 ? 4'h8 : {{1'd0}, _GEN_111}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_18 = 3'h1 == booth_seq_18 ? 4'h8 : _GEN_112; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_19 = in_b_cat[40:38]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_114 = 3'h6 == booth_seq_19 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_115 = 3'h5 == booth_seq_19 ? 2'h2 : _GEN_114; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_116 = 3'h4 == booth_seq_19 ? 2'h1 : _GEN_115; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_117 = 3'h3 == booth_seq_19 ? 3'h4 : {{1'd0}, _GEN_116}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_118 = 3'h2 == booth_seq_19 ? 4'h8 : {{1'd0}, _GEN_117}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_19 = 3'h1 == booth_seq_19 ? 4'h8 : _GEN_118; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_20 = in_b_cat[42:40]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_120 = 3'h6 == booth_seq_20 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_121 = 3'h5 == booth_seq_20 ? 2'h2 : _GEN_120; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_122 = 3'h4 == booth_seq_20 ? 2'h1 : _GEN_121; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_123 = 3'h3 == booth_seq_20 ? 3'h4 : {{1'd0}, _GEN_122}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_124 = 3'h2 == booth_seq_20 ? 4'h8 : {{1'd0}, _GEN_123}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_20 = 3'h1 == booth_seq_20 ? 4'h8 : _GEN_124; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_21 = in_b_cat[44:42]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_126 = 3'h6 == booth_seq_21 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_127 = 3'h5 == booth_seq_21 ? 2'h2 : _GEN_126; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_128 = 3'h4 == booth_seq_21 ? 2'h1 : _GEN_127; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_129 = 3'h3 == booth_seq_21 ? 3'h4 : {{1'd0}, _GEN_128}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_130 = 3'h2 == booth_seq_21 ? 4'h8 : {{1'd0}, _GEN_129}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_21 = 3'h1 == booth_seq_21 ? 4'h8 : _GEN_130; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_22 = in_b_cat[46:44]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_132 = 3'h6 == booth_seq_22 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_133 = 3'h5 == booth_seq_22 ? 2'h2 : _GEN_132; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_134 = 3'h4 == booth_seq_22 ? 2'h1 : _GEN_133; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_135 = 3'h3 == booth_seq_22 ? 3'h4 : {{1'd0}, _GEN_134}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_136 = 3'h2 == booth_seq_22 ? 4'h8 : {{1'd0}, _GEN_135}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_22 = 3'h1 == booth_seq_22 ? 4'h8 : _GEN_136; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_23 = in_b_cat[48:46]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_138 = 3'h6 == booth_seq_23 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_139 = 3'h5 == booth_seq_23 ? 2'h2 : _GEN_138; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_140 = 3'h4 == booth_seq_23 ? 2'h1 : _GEN_139; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_141 = 3'h3 == booth_seq_23 ? 3'h4 : {{1'd0}, _GEN_140}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_142 = 3'h2 == booth_seq_23 ? 4'h8 : {{1'd0}, _GEN_141}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_23 = 3'h1 == booth_seq_23 ? 4'h8 : _GEN_142; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_24 = in_b_cat[50:48]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_144 = 3'h6 == booth_seq_24 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_145 = 3'h5 == booth_seq_24 ? 2'h2 : _GEN_144; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_146 = 3'h4 == booth_seq_24 ? 2'h1 : _GEN_145; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_147 = 3'h3 == booth_seq_24 ? 3'h4 : {{1'd0}, _GEN_146}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_148 = 3'h2 == booth_seq_24 ? 4'h8 : {{1'd0}, _GEN_147}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_24 = 3'h1 == booth_seq_24 ? 4'h8 : _GEN_148; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_25 = in_b_cat[52:50]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_150 = 3'h6 == booth_seq_25 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_151 = 3'h5 == booth_seq_25 ? 2'h2 : _GEN_150; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_152 = 3'h4 == booth_seq_25 ? 2'h1 : _GEN_151; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_153 = 3'h3 == booth_seq_25 ? 3'h4 : {{1'd0}, _GEN_152}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_154 = 3'h2 == booth_seq_25 ? 4'h8 : {{1'd0}, _GEN_153}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_25 = 3'h1 == booth_seq_25 ? 4'h8 : _GEN_154; // @[FloatFMA.scala 909:25 910:42]
  wire [2:0] booth_seq_26 = in_b_cat[54:52]; // @[FloatFMA.scala 907:29]
  wire [1:0] _GEN_156 = 3'h6 == booth_seq_26 ? 2'h2 : 2'h0; // @[FloatFMA.scala 909:25 908:26 915:42]
  wire [1:0] _GEN_157 = 3'h5 == booth_seq_26 ? 2'h2 : _GEN_156; // @[FloatFMA.scala 909:25 914:42]
  wire [1:0] _GEN_158 = 3'h4 == booth_seq_26 ? 2'h1 : _GEN_157; // @[FloatFMA.scala 909:25 913:42]
  wire [2:0] _GEN_159 = 3'h3 == booth_seq_26 ? 3'h4 : {{1'd0}, _GEN_158}; // @[FloatFMA.scala 909:25 912:42]
  wire [3:0] _GEN_160 = 3'h2 == booth_seq_26 ? 4'h8 : {{1'd0}, _GEN_159}; // @[FloatFMA.scala 909:25 911:42]
  wire [3:0] booth_4bit_onehot_26 = 3'h1 == booth_seq_26 ? 4'h8 : _GEN_160; // @[FloatFMA.scala 909:25 910:42]
  wire  sign_seq_0 = booth_4bit_onehot_0[1] | booth_4bit_onehot_0[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_0_T_2 = booth_4bit_onehot_0[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_0_T_3 = {1'h0,io_in_a}; // @[Cat.scala 33:92]
  wire [53:0] _pp_seq_f64_0_T_4 = _pp_seq_f64_0_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_0_T_7 = booth_4bit_onehot_0[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_0_T_8 = {io_in_a,1'h0}; // @[Cat.scala 33:92]
  wire [53:0] _pp_seq_f64_0_T_9 = _pp_seq_f64_0_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_0_T_10 = _pp_seq_f64_0_T_4 | _pp_seq_f64_0_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_0_T_13 = booth_4bit_onehot_0[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [52:0] _pp_seq_f64_0_T_14 = ~io_in_a; // @[FloatFMA.scala 928:59]
  wire [53:0] _pp_seq_f64_0_T_15 = {1'h1,_pp_seq_f64_0_T_14}; // @[Cat.scala 33:92]
  wire [53:0] _pp_seq_f64_0_T_16 = _pp_seq_f64_0_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_0_T_17 = _pp_seq_f64_0_T_10 | _pp_seq_f64_0_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_0_T_20 = booth_4bit_onehot_0[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_0_T_22 = {_pp_seq_f64_0_T_14,1'h1}; // @[Cat.scala 33:92]
  wire [53:0] _pp_seq_f64_0_T_23 = _pp_seq_f64_0_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_0 = _pp_seq_f64_0_T_17 | _pp_seq_f64_0_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_1 = booth_4bit_onehot_1[1] | booth_4bit_onehot_1[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_1_T_2 = booth_4bit_onehot_1[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_1_T_4 = _pp_seq_f64_1_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_1_T_7 = booth_4bit_onehot_1[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_1_T_9 = _pp_seq_f64_1_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_1_T_10 = _pp_seq_f64_1_T_4 | _pp_seq_f64_1_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_1_T_13 = booth_4bit_onehot_1[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_1_T_16 = _pp_seq_f64_1_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_1_T_17 = _pp_seq_f64_1_T_10 | _pp_seq_f64_1_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_1_T_20 = booth_4bit_onehot_1[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_1_T_23 = _pp_seq_f64_1_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_1 = _pp_seq_f64_1_T_17 | _pp_seq_f64_1_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_2 = booth_4bit_onehot_2[1] | booth_4bit_onehot_2[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_2_T_2 = booth_4bit_onehot_2[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_2_T_4 = _pp_seq_f64_2_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_2_T_7 = booth_4bit_onehot_2[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_2_T_9 = _pp_seq_f64_2_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_2_T_10 = _pp_seq_f64_2_T_4 | _pp_seq_f64_2_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_2_T_13 = booth_4bit_onehot_2[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_2_T_16 = _pp_seq_f64_2_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_2_T_17 = _pp_seq_f64_2_T_10 | _pp_seq_f64_2_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_2_T_20 = booth_4bit_onehot_2[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_2_T_23 = _pp_seq_f64_2_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_2 = _pp_seq_f64_2_T_17 | _pp_seq_f64_2_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_3 = booth_4bit_onehot_3[1] | booth_4bit_onehot_3[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_3_T_2 = booth_4bit_onehot_3[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_3_T_4 = _pp_seq_f64_3_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_3_T_7 = booth_4bit_onehot_3[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_3_T_9 = _pp_seq_f64_3_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_3_T_10 = _pp_seq_f64_3_T_4 | _pp_seq_f64_3_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_3_T_13 = booth_4bit_onehot_3[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_3_T_16 = _pp_seq_f64_3_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_3_T_17 = _pp_seq_f64_3_T_10 | _pp_seq_f64_3_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_3_T_20 = booth_4bit_onehot_3[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_3_T_23 = _pp_seq_f64_3_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_3 = _pp_seq_f64_3_T_17 | _pp_seq_f64_3_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_4 = booth_4bit_onehot_4[1] | booth_4bit_onehot_4[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_4_T_2 = booth_4bit_onehot_4[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_4_T_4 = _pp_seq_f64_4_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_4_T_7 = booth_4bit_onehot_4[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_4_T_9 = _pp_seq_f64_4_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_4_T_10 = _pp_seq_f64_4_T_4 | _pp_seq_f64_4_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_4_T_13 = booth_4bit_onehot_4[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_4_T_16 = _pp_seq_f64_4_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_4_T_17 = _pp_seq_f64_4_T_10 | _pp_seq_f64_4_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_4_T_20 = booth_4bit_onehot_4[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_4_T_23 = _pp_seq_f64_4_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_4 = _pp_seq_f64_4_T_17 | _pp_seq_f64_4_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_5 = booth_4bit_onehot_5[1] | booth_4bit_onehot_5[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_5_T_2 = booth_4bit_onehot_5[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_5_T_4 = _pp_seq_f64_5_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_5_T_7 = booth_4bit_onehot_5[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_5_T_9 = _pp_seq_f64_5_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_5_T_10 = _pp_seq_f64_5_T_4 | _pp_seq_f64_5_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_5_T_13 = booth_4bit_onehot_5[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_5_T_16 = _pp_seq_f64_5_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_5_T_17 = _pp_seq_f64_5_T_10 | _pp_seq_f64_5_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_5_T_20 = booth_4bit_onehot_5[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_5_T_23 = _pp_seq_f64_5_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_5 = _pp_seq_f64_5_T_17 | _pp_seq_f64_5_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_6 = booth_4bit_onehot_6[1] | booth_4bit_onehot_6[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_6_T_2 = booth_4bit_onehot_6[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_6_T_4 = _pp_seq_f64_6_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_6_T_7 = booth_4bit_onehot_6[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_6_T_9 = _pp_seq_f64_6_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_6_T_10 = _pp_seq_f64_6_T_4 | _pp_seq_f64_6_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_6_T_13 = booth_4bit_onehot_6[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_6_T_16 = _pp_seq_f64_6_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_6_T_17 = _pp_seq_f64_6_T_10 | _pp_seq_f64_6_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_6_T_20 = booth_4bit_onehot_6[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_6_T_23 = _pp_seq_f64_6_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_6 = _pp_seq_f64_6_T_17 | _pp_seq_f64_6_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_7 = booth_4bit_onehot_7[1] | booth_4bit_onehot_7[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_7_T_2 = booth_4bit_onehot_7[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_7_T_4 = _pp_seq_f64_7_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_7_T_7 = booth_4bit_onehot_7[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_7_T_9 = _pp_seq_f64_7_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_7_T_10 = _pp_seq_f64_7_T_4 | _pp_seq_f64_7_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_7_T_13 = booth_4bit_onehot_7[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_7_T_16 = _pp_seq_f64_7_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_7_T_17 = _pp_seq_f64_7_T_10 | _pp_seq_f64_7_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_7_T_20 = booth_4bit_onehot_7[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_7_T_23 = _pp_seq_f64_7_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_7 = _pp_seq_f64_7_T_17 | _pp_seq_f64_7_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_8 = booth_4bit_onehot_8[1] | booth_4bit_onehot_8[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_8_T_2 = booth_4bit_onehot_8[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_8_T_4 = _pp_seq_f64_8_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_8_T_7 = booth_4bit_onehot_8[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_8_T_9 = _pp_seq_f64_8_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_8_T_10 = _pp_seq_f64_8_T_4 | _pp_seq_f64_8_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_8_T_13 = booth_4bit_onehot_8[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_8_T_16 = _pp_seq_f64_8_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_8_T_17 = _pp_seq_f64_8_T_10 | _pp_seq_f64_8_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_8_T_20 = booth_4bit_onehot_8[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_8_T_23 = _pp_seq_f64_8_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_8 = _pp_seq_f64_8_T_17 | _pp_seq_f64_8_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_9 = booth_4bit_onehot_9[1] | booth_4bit_onehot_9[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_9_T_2 = booth_4bit_onehot_9[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_9_T_4 = _pp_seq_f64_9_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_9_T_7 = booth_4bit_onehot_9[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_9_T_9 = _pp_seq_f64_9_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_9_T_10 = _pp_seq_f64_9_T_4 | _pp_seq_f64_9_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_9_T_13 = booth_4bit_onehot_9[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_9_T_16 = _pp_seq_f64_9_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_9_T_17 = _pp_seq_f64_9_T_10 | _pp_seq_f64_9_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_9_T_20 = booth_4bit_onehot_9[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_9_T_23 = _pp_seq_f64_9_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_9 = _pp_seq_f64_9_T_17 | _pp_seq_f64_9_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_10 = booth_4bit_onehot_10[1] | booth_4bit_onehot_10[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_10_T_2 = booth_4bit_onehot_10[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_10_T_4 = _pp_seq_f64_10_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_10_T_7 = booth_4bit_onehot_10[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_10_T_9 = _pp_seq_f64_10_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_10_T_10 = _pp_seq_f64_10_T_4 | _pp_seq_f64_10_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_10_T_13 = booth_4bit_onehot_10[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_10_T_16 = _pp_seq_f64_10_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_10_T_17 = _pp_seq_f64_10_T_10 | _pp_seq_f64_10_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_10_T_20 = booth_4bit_onehot_10[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_10_T_23 = _pp_seq_f64_10_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_10 = _pp_seq_f64_10_T_17 | _pp_seq_f64_10_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_11 = booth_4bit_onehot_11[1] | booth_4bit_onehot_11[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_11_T_2 = booth_4bit_onehot_11[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_11_T_4 = _pp_seq_f64_11_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_11_T_7 = booth_4bit_onehot_11[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_11_T_9 = _pp_seq_f64_11_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_11_T_10 = _pp_seq_f64_11_T_4 | _pp_seq_f64_11_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_11_T_13 = booth_4bit_onehot_11[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_11_T_16 = _pp_seq_f64_11_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_11_T_17 = _pp_seq_f64_11_T_10 | _pp_seq_f64_11_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_11_T_20 = booth_4bit_onehot_11[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_11_T_23 = _pp_seq_f64_11_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_11 = _pp_seq_f64_11_T_17 | _pp_seq_f64_11_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_12 = booth_4bit_onehot_12[1] | booth_4bit_onehot_12[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_12_T_2 = booth_4bit_onehot_12[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_12_T_4 = _pp_seq_f64_12_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_12_T_7 = booth_4bit_onehot_12[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_12_T_9 = _pp_seq_f64_12_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_12_T_10 = _pp_seq_f64_12_T_4 | _pp_seq_f64_12_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_12_T_13 = booth_4bit_onehot_12[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_12_T_16 = _pp_seq_f64_12_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_12_T_17 = _pp_seq_f64_12_T_10 | _pp_seq_f64_12_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_12_T_20 = booth_4bit_onehot_12[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_12_T_23 = _pp_seq_f64_12_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_12 = _pp_seq_f64_12_T_17 | _pp_seq_f64_12_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_13 = booth_4bit_onehot_13[1] | booth_4bit_onehot_13[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_13_T_2 = booth_4bit_onehot_13[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_13_T_4 = _pp_seq_f64_13_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_13_T_7 = booth_4bit_onehot_13[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_13_T_9 = _pp_seq_f64_13_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_13_T_10 = _pp_seq_f64_13_T_4 | _pp_seq_f64_13_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_13_T_13 = booth_4bit_onehot_13[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_13_T_16 = _pp_seq_f64_13_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_13_T_17 = _pp_seq_f64_13_T_10 | _pp_seq_f64_13_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_13_T_20 = booth_4bit_onehot_13[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_13_T_23 = _pp_seq_f64_13_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_13 = _pp_seq_f64_13_T_17 | _pp_seq_f64_13_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_14 = booth_4bit_onehot_14[1] | booth_4bit_onehot_14[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_14_T_2 = booth_4bit_onehot_14[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_14_T_4 = _pp_seq_f64_14_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_14_T_7 = booth_4bit_onehot_14[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_14_T_9 = _pp_seq_f64_14_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_14_T_10 = _pp_seq_f64_14_T_4 | _pp_seq_f64_14_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_14_T_13 = booth_4bit_onehot_14[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_14_T_16 = _pp_seq_f64_14_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_14_T_17 = _pp_seq_f64_14_T_10 | _pp_seq_f64_14_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_14_T_20 = booth_4bit_onehot_14[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_14_T_23 = _pp_seq_f64_14_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_14 = _pp_seq_f64_14_T_17 | _pp_seq_f64_14_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_15 = booth_4bit_onehot_15[1] | booth_4bit_onehot_15[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_15_T_2 = booth_4bit_onehot_15[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_15_T_4 = _pp_seq_f64_15_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_15_T_7 = booth_4bit_onehot_15[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_15_T_9 = _pp_seq_f64_15_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_15_T_10 = _pp_seq_f64_15_T_4 | _pp_seq_f64_15_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_15_T_13 = booth_4bit_onehot_15[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_15_T_16 = _pp_seq_f64_15_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_15_T_17 = _pp_seq_f64_15_T_10 | _pp_seq_f64_15_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_15_T_20 = booth_4bit_onehot_15[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_15_T_23 = _pp_seq_f64_15_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_15 = _pp_seq_f64_15_T_17 | _pp_seq_f64_15_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_16 = booth_4bit_onehot_16[1] | booth_4bit_onehot_16[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_16_T_2 = booth_4bit_onehot_16[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_16_T_4 = _pp_seq_f64_16_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_16_T_7 = booth_4bit_onehot_16[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_16_T_9 = _pp_seq_f64_16_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_16_T_10 = _pp_seq_f64_16_T_4 | _pp_seq_f64_16_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_16_T_13 = booth_4bit_onehot_16[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_16_T_16 = _pp_seq_f64_16_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_16_T_17 = _pp_seq_f64_16_T_10 | _pp_seq_f64_16_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_16_T_20 = booth_4bit_onehot_16[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_16_T_23 = _pp_seq_f64_16_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_16 = _pp_seq_f64_16_T_17 | _pp_seq_f64_16_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_17 = booth_4bit_onehot_17[1] | booth_4bit_onehot_17[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_17_T_2 = booth_4bit_onehot_17[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_17_T_4 = _pp_seq_f64_17_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_17_T_7 = booth_4bit_onehot_17[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_17_T_9 = _pp_seq_f64_17_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_17_T_10 = _pp_seq_f64_17_T_4 | _pp_seq_f64_17_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_17_T_13 = booth_4bit_onehot_17[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_17_T_16 = _pp_seq_f64_17_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_17_T_17 = _pp_seq_f64_17_T_10 | _pp_seq_f64_17_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_17_T_20 = booth_4bit_onehot_17[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_17_T_23 = _pp_seq_f64_17_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_17 = _pp_seq_f64_17_T_17 | _pp_seq_f64_17_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_18 = booth_4bit_onehot_18[1] | booth_4bit_onehot_18[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_18_T_2 = booth_4bit_onehot_18[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_18_T_4 = _pp_seq_f64_18_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_18_T_7 = booth_4bit_onehot_18[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_18_T_9 = _pp_seq_f64_18_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_18_T_10 = _pp_seq_f64_18_T_4 | _pp_seq_f64_18_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_18_T_13 = booth_4bit_onehot_18[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_18_T_16 = _pp_seq_f64_18_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_18_T_17 = _pp_seq_f64_18_T_10 | _pp_seq_f64_18_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_18_T_20 = booth_4bit_onehot_18[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_18_T_23 = _pp_seq_f64_18_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_18 = _pp_seq_f64_18_T_17 | _pp_seq_f64_18_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_19 = booth_4bit_onehot_19[1] | booth_4bit_onehot_19[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_19_T_2 = booth_4bit_onehot_19[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_19_T_4 = _pp_seq_f64_19_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_19_T_7 = booth_4bit_onehot_19[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_19_T_9 = _pp_seq_f64_19_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_19_T_10 = _pp_seq_f64_19_T_4 | _pp_seq_f64_19_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_19_T_13 = booth_4bit_onehot_19[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_19_T_16 = _pp_seq_f64_19_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_19_T_17 = _pp_seq_f64_19_T_10 | _pp_seq_f64_19_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_19_T_20 = booth_4bit_onehot_19[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_19_T_23 = _pp_seq_f64_19_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_19 = _pp_seq_f64_19_T_17 | _pp_seq_f64_19_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_20 = booth_4bit_onehot_20[1] | booth_4bit_onehot_20[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_20_T_2 = booth_4bit_onehot_20[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_20_T_4 = _pp_seq_f64_20_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_20_T_7 = booth_4bit_onehot_20[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_20_T_9 = _pp_seq_f64_20_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_20_T_10 = _pp_seq_f64_20_T_4 | _pp_seq_f64_20_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_20_T_13 = booth_4bit_onehot_20[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_20_T_16 = _pp_seq_f64_20_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_20_T_17 = _pp_seq_f64_20_T_10 | _pp_seq_f64_20_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_20_T_20 = booth_4bit_onehot_20[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_20_T_23 = _pp_seq_f64_20_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_20 = _pp_seq_f64_20_T_17 | _pp_seq_f64_20_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_21 = booth_4bit_onehot_21[1] | booth_4bit_onehot_21[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_21_T_2 = booth_4bit_onehot_21[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_21_T_4 = _pp_seq_f64_21_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_21_T_7 = booth_4bit_onehot_21[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_21_T_9 = _pp_seq_f64_21_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_21_T_10 = _pp_seq_f64_21_T_4 | _pp_seq_f64_21_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_21_T_13 = booth_4bit_onehot_21[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_21_T_16 = _pp_seq_f64_21_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_21_T_17 = _pp_seq_f64_21_T_10 | _pp_seq_f64_21_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_21_T_20 = booth_4bit_onehot_21[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_21_T_23 = _pp_seq_f64_21_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_21 = _pp_seq_f64_21_T_17 | _pp_seq_f64_21_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_22 = booth_4bit_onehot_22[1] | booth_4bit_onehot_22[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_22_T_2 = booth_4bit_onehot_22[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_22_T_4 = _pp_seq_f64_22_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_22_T_7 = booth_4bit_onehot_22[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_22_T_9 = _pp_seq_f64_22_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_22_T_10 = _pp_seq_f64_22_T_4 | _pp_seq_f64_22_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_22_T_13 = booth_4bit_onehot_22[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_22_T_16 = _pp_seq_f64_22_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_22_T_17 = _pp_seq_f64_22_T_10 | _pp_seq_f64_22_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_22_T_20 = booth_4bit_onehot_22[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_22_T_23 = _pp_seq_f64_22_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_22 = _pp_seq_f64_22_T_17 | _pp_seq_f64_22_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_23 = booth_4bit_onehot_23[1] | booth_4bit_onehot_23[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_23_T_2 = booth_4bit_onehot_23[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_23_T_4 = _pp_seq_f64_23_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_23_T_7 = booth_4bit_onehot_23[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_23_T_9 = _pp_seq_f64_23_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_23_T_10 = _pp_seq_f64_23_T_4 | _pp_seq_f64_23_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_23_T_13 = booth_4bit_onehot_23[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_23_T_16 = _pp_seq_f64_23_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_23_T_17 = _pp_seq_f64_23_T_10 | _pp_seq_f64_23_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_23_T_20 = booth_4bit_onehot_23[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_23_T_23 = _pp_seq_f64_23_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_23 = _pp_seq_f64_23_T_17 | _pp_seq_f64_23_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_24 = booth_4bit_onehot_24[1] | booth_4bit_onehot_24[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_24_T_2 = booth_4bit_onehot_24[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_24_T_4 = _pp_seq_f64_24_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_24_T_7 = booth_4bit_onehot_24[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_24_T_9 = _pp_seq_f64_24_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_24_T_10 = _pp_seq_f64_24_T_4 | _pp_seq_f64_24_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_24_T_13 = booth_4bit_onehot_24[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_24_T_16 = _pp_seq_f64_24_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_24_T_17 = _pp_seq_f64_24_T_10 | _pp_seq_f64_24_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_24_T_20 = booth_4bit_onehot_24[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_24_T_23 = _pp_seq_f64_24_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_24 = _pp_seq_f64_24_T_17 | _pp_seq_f64_24_T_23; // @[FloatFMA.scala 928:69]
  wire  sign_seq_25 = booth_4bit_onehot_25[1] | booth_4bit_onehot_25[0]; // @[FloatFMA.scala 924:44]
  wire [53:0] _pp_seq_f64_25_T_2 = booth_4bit_onehot_25[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_25_T_4 = _pp_seq_f64_25_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_25_T_7 = booth_4bit_onehot_25[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_25_T_9 = _pp_seq_f64_25_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_25_T_10 = _pp_seq_f64_25_T_4 | _pp_seq_f64_25_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_25_T_13 = booth_4bit_onehot_25[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_25_T_16 = _pp_seq_f64_25_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_25_T_17 = _pp_seq_f64_25_T_10 | _pp_seq_f64_25_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_25_T_20 = booth_4bit_onehot_25[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_25_T_23 = _pp_seq_f64_25_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_25 = _pp_seq_f64_25_T_17 | _pp_seq_f64_25_T_23; // @[FloatFMA.scala 928:69]
  wire [53:0] _pp_seq_f64_26_T_2 = booth_4bit_onehot_26[3] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_26_T_4 = _pp_seq_f64_26_T_2 & _pp_seq_f64_0_T_3; // @[FloatFMA.scala 926:63]
  wire [53:0] _pp_seq_f64_26_T_7 = booth_4bit_onehot_26[2] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_26_T_9 = _pp_seq_f64_26_T_7 & _pp_seq_f64_0_T_8; // @[FloatFMA.scala 927:48]
  wire [53:0] _pp_seq_f64_26_T_10 = _pp_seq_f64_26_T_4 | _pp_seq_f64_26_T_9; // @[FloatFMA.scala 926:83]
  wire [53:0] _pp_seq_f64_26_T_13 = booth_4bit_onehot_26[1] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_26_T_16 = _pp_seq_f64_26_T_13 & _pp_seq_f64_0_T_15; // @[FloatFMA.scala 928:48]
  wire [53:0] _pp_seq_f64_26_T_17 = _pp_seq_f64_26_T_10 | _pp_seq_f64_26_T_16; // @[FloatFMA.scala 927:68]
  wire [53:0] _pp_seq_f64_26_T_20 = booth_4bit_onehot_26[0] ? 54'h3fffffffffffff : 54'h0; // @[Bitwise.scala 77:12]
  wire [53:0] _pp_seq_f64_26_T_23 = _pp_seq_f64_26_T_20 & _pp_seq_f64_0_T_22; // @[FloatFMA.scala 929:48]
  wire [53:0] pp_seq_f64_26 = _pp_seq_f64_26_T_17 | _pp_seq_f64_26_T_23; // @[FloatFMA.scala 928:69]
  wire  _addend_seq_f64_0_T = ~sign_seq_0; // @[FloatFMA.scala 967:62]
  wire [105:0] _addend_seq_f64_0_T_1 = {49'h0,_addend_seq_f64_0_T,sign_seq_0,sign_seq_0,pp_seq_f64_0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_1_T = ~sign_seq_1; // @[FloatFMA.scala 968:71]
  wire [105:0] _addend_seq_f64_1_T_1 = {49'h1,_addend_seq_f64_1_T,pp_seq_f64_1,1'h0,sign_seq_0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_2_T = ~sign_seq_2; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_2_T_1 = {47'h1,_addend_seq_f64_2_T,pp_seq_f64_2,1'h0,sign_seq_1,2'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_3_T = ~sign_seq_3; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_3_T_1 = {45'h1,_addend_seq_f64_3_T,pp_seq_f64_3,1'h0,sign_seq_2,4'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_4_T = ~sign_seq_4; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_4_T_1 = {43'h1,_addend_seq_f64_4_T,pp_seq_f64_4,1'h0,sign_seq_3,6'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_5_T = ~sign_seq_5; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_5_T_1 = {41'h1,_addend_seq_f64_5_T,pp_seq_f64_5,1'h0,sign_seq_4,8'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_6_T = ~sign_seq_6; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_6_T_1 = {39'h1,_addend_seq_f64_6_T,pp_seq_f64_6,1'h0,sign_seq_5,10'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_7_T = ~sign_seq_7; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_7_T_1 = {37'h1,_addend_seq_f64_7_T,pp_seq_f64_7,1'h0,sign_seq_6,12'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_8_T = ~sign_seq_8; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_8_T_1 = {35'h1,_addend_seq_f64_8_T,pp_seq_f64_8,1'h0,sign_seq_7,14'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_9_T = ~sign_seq_9; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_9_T_1 = {33'h1,_addend_seq_f64_9_T,pp_seq_f64_9,1'h0,sign_seq_8,16'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_10_T = ~sign_seq_10; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_10_T_1 = {31'h1,_addend_seq_f64_10_T,pp_seq_f64_10,1'h0,sign_seq_9,18'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_11_T = ~sign_seq_11; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_11_T_1 = {29'h1,_addend_seq_f64_11_T,pp_seq_f64_11,1'h0,sign_seq_10,20'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_12_T = ~sign_seq_12; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_12_T_1 = {27'h1,_addend_seq_f64_12_T,pp_seq_f64_12,1'h0,sign_seq_11,22'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_13_T = ~sign_seq_13; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_13_T_1 = {25'h1,_addend_seq_f64_13_T,pp_seq_f64_13,1'h0,sign_seq_12,24'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_14_T = ~sign_seq_14; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_14_T_1 = {23'h1,_addend_seq_f64_14_T,pp_seq_f64_14,1'h0,sign_seq_13,26'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_15_T = ~sign_seq_15; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_15_T_1 = {21'h1,_addend_seq_f64_15_T,pp_seq_f64_15,1'h0,sign_seq_14,28'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_16_T = ~sign_seq_16; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_16_T_1 = {19'h1,_addend_seq_f64_16_T,pp_seq_f64_16,1'h0,sign_seq_15,30'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_17_T = ~sign_seq_17; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_17_T_1 = {17'h1,_addend_seq_f64_17_T,pp_seq_f64_17,1'h0,sign_seq_16,32'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_18_T = ~sign_seq_18; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_18_T_1 = {15'h1,_addend_seq_f64_18_T,pp_seq_f64_18,1'h0,sign_seq_17,34'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_19_T = ~sign_seq_19; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_19_T_1 = {13'h1,_addend_seq_f64_19_T,pp_seq_f64_19,1'h0,sign_seq_18,36'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_20_T = ~sign_seq_20; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_20_T_1 = {11'h1,_addend_seq_f64_20_T,pp_seq_f64_20,1'h0,sign_seq_19,38'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_21_T = ~sign_seq_21; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_21_T_1 = {9'h1,_addend_seq_f64_21_T,pp_seq_f64_21,1'h0,sign_seq_20,40'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_22_T = ~sign_seq_22; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_22_T_1 = {7'h1,_addend_seq_f64_22_T,pp_seq_f64_22,1'h0,sign_seq_21,42'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_23_T = ~sign_seq_23; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_23_T_1 = {5'h1,_addend_seq_f64_23_T,pp_seq_f64_23,1'h0,sign_seq_22,44'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_24_T = ~sign_seq_24; // @[FloatFMA.scala 979:71]
  wire [105:0] _addend_seq_f64_24_T_1 = {3'h1,_addend_seq_f64_24_T,pp_seq_f64_24,1'h0,sign_seq_23,46'h0}; // @[Cat.scala 33:92]
  wire  _addend_seq_f64_25_T = ~sign_seq_25; // @[FloatFMA.scala 974:44]
  wire [105:0] _addend_seq_f64_25_T_1 = {1'h1,_addend_seq_f64_25_T,pp_seq_f64_25,1'h0,sign_seq_24,48'h0}; // @[Cat.scala 33:92]
  wire [50:0] addend_seq_f64_26_lo = {sign_seq_25,50'h0}; // @[Cat.scala 33:92]
  wire [55:0] addend_seq_f64_26_hi = {1'h1,pp_seq_f64_26,1'h0}; // @[Cat.scala 33:92]
  assign io_out_pp_0 = {{1'd0}, _addend_seq_f64_0_T_1}; // @[FloatFMA.scala 955:28 967:35]
  assign io_out_pp_1 = {{1'd0}, _addend_seq_f64_1_T_1}; // @[FloatFMA.scala 955:28 968:35]
  assign io_out_pp_2 = {{1'd0}, _addend_seq_f64_2_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_3 = {{1'd0}, _addend_seq_f64_3_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_4 = {{1'd0}, _addend_seq_f64_4_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_5 = {{1'd0}, _addend_seq_f64_5_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_6 = {{1'd0}, _addend_seq_f64_6_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_7 = {{1'd0}, _addend_seq_f64_7_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_8 = {{1'd0}, _addend_seq_f64_8_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_9 = {{1'd0}, _addend_seq_f64_9_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_10 = {{1'd0}, _addend_seq_f64_10_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_11 = {{1'd0}, _addend_seq_f64_11_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_12 = {{1'd0}, _addend_seq_f64_12_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_13 = {{1'd0}, _addend_seq_f64_13_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_14 = {{1'd0}, _addend_seq_f64_14_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_15 = {{1'd0}, _addend_seq_f64_15_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_16 = {{1'd0}, _addend_seq_f64_16_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_17 = {{1'd0}, _addend_seq_f64_17_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_18 = {{1'd0}, _addend_seq_f64_18_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_19 = {{1'd0}, _addend_seq_f64_19_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_20 = {{1'd0}, _addend_seq_f64_20_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_21 = {{1'd0}, _addend_seq_f64_21_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_22 = {{1'd0}, _addend_seq_f64_22_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_23 = {{1'd0}, _addend_seq_f64_23_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_24 = {{1'd0}, _addend_seq_f64_24_T_1}; // @[FloatFMA.scala 955:28 979:35]
  assign io_out_pp_25 = {{1'd0}, _addend_seq_f64_25_T_1}; // @[FloatFMA.scala 955:28 974:32]
  assign io_out_pp_26 = {addend_seq_f64_26_hi,addend_seq_f64_26_lo}; // @[Cat.scala 33:92]
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
  input  [106:0] io_in_13,
  input  [106:0] io_in_14,
  input  [106:0] io_in_15,
  input  [106:0] io_in_16,
  input  [106:0] io_in_17,
  input  [106:0] io_in_18,
  input  [106:0] io_in_19,
  input  [106:0] io_in_20,
  input  [106:0] io_in_21,
  input  [106:0] io_in_22,
  input  [106:0] io_in_23,
  input  [106:0] io_in_24,
  input  [106:0] io_in_25,
  input  [106:0] io_in_26,
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
  assign U_CSA3to2_4_io_in_b = io_in_13; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_4_io_in_c = io_in_14; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_5_io_in_a = io_in_15; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_5_io_in_b = io_in_16; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_5_io_in_c = io_in_17; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_6_io_in_a = io_in_18; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_6_io_in_b = io_in_19; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_6_io_in_c = io_in_20; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_7_io_in_a = io_in_21; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_7_io_in_b = io_in_22; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_7_io_in_c = io_in_23; // @[FloatFMA.scala 1061:25]
  assign U_CSA3to2_8_io_in_a = io_in_24; // @[FloatFMA.scala 1059:25]
  assign U_CSA3to2_8_io_in_b = io_in_25; // @[FloatFMA.scala 1060:25]
  assign U_CSA3to2_8_io_in_c = io_in_26; // @[FloatFMA.scala 1061:25]
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
  reg [31:0] _RAND_5;
  reg [191:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [191:0] _RAND_13;
  reg [191:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [191:0] _RAND_16;
  reg [63:0] _RAND_17;
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
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
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
  wire [106:0] U_BoothEncoder_io_out_pp_13; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_14; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_15; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_16; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_17; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_18; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_19; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_20; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_21; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_22; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_23; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_24; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_25; // @[FloatFMA.scala 268:30]
  wire [106:0] U_BoothEncoder_io_out_pp_26; // @[FloatFMA.scala 268:30]
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
  wire [106:0] U_CSAnto2_io_in_13; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_14; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_15; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_16; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_17; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_18; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_19; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_20; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_21; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_22; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_23; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_24; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_25; // @[FloatFMA.scala 273:25]
  wire [106:0] U_CSAnto2_io_in_26; // @[FloatFMA.scala 273:25]
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
  wire  _fp_a_f64_T_4 = fp_a_is_sign_inv ? ~io_fp_a[63] : io_fp_a[63]; // @[FloatFMA.scala 88:12]
  wire [63:0] fp_a_f64 = {_fp_a_f64_T_4,io_fp_a[62:0]}; // @[Cat.scala 33:92]
  wire  _fp_c_f64_T_4 = fp_c_is_sign_inv ? ~io_fp_c[63] : io_fp_c[63]; // @[FloatFMA.scala 88:12]
  wire [63:0] _fp_c_f64_T_6 = {_fp_c_f64_T_4,io_fp_c[62:0]}; // @[Cat.scala 33:92]
  wire [63:0] fp_c_f64 = is_fmul ? 64'h0 : _fp_c_f64_T_6; // @[FloatFMA.scala 95:34]
  wire  sign_a_b_f64 = fp_a_f64[63] ^ io_fp_b[63]; // @[FloatFMA.scala 106:45]
  wire  sign_c_f64 = fp_c_f64[63]; // @[FloatFMA.scala 109:39]
  wire  is_sub_f64 = sign_a_b_f64 ^ sign_c_f64; // @[FloatFMA.scala 110:44]
  reg  is_sub_f64_reg0; // @[Reg.scala 19:16]
  wire [10:0] Ea_f64 = fp_a_f64[62:52]; // @[FloatFMA.scala 118:52]
  wire [10:0] Eb_f64 = io_fp_b[62:52]; // @[FloatFMA.scala 119:52]
  wire [10:0] Ec_f64 = fp_c_f64[62:52]; // @[FloatFMA.scala 120:52]
  wire  Ea_f64_is_not_zero = |Ea_f64; // @[FloatFMA.scala 129:38]
  wire  Eb_f64_is_not_zero = |Eb_f64; // @[FloatFMA.scala 130:38]
  wire  Ec_f64_is_not_zero = |Ec_f64; // @[FloatFMA.scala 131:38]
  wire [52:0] fp_a_significand_f64 = {Ea_f64_is_not_zero,fp_a_f64[51:0]}; // @[Cat.scala 33:92]
  wire [52:0] fp_b_significand_f64 = {Eb_f64_is_not_zero,io_fp_b[51:0]}; // @[Cat.scala 33:92]
  wire [52:0] fp_c_significand_f64 = {Ec_f64_is_not_zero,fp_c_f64[51:0]}; // @[Cat.scala 33:92]
  wire  _Ea_fix_f64_T_3 = ~Ea_f64_is_not_zero | Ea_f64[0]; // @[FloatFMA.scala 151:84]
  wire [10:0] Ea_fix_f64 = {Ea_f64[10:1],_Ea_fix_f64_T_3}; // @[Cat.scala 33:92]
  wire  _Eb_fix_f64_T_3 = ~Eb_f64_is_not_zero | Eb_f64[0]; // @[FloatFMA.scala 152:84]
  wire [10:0] Eb_fix_f64 = {Eb_f64[10:1],_Eb_fix_f64_T_3}; // @[Cat.scala 33:92]
  wire  _Ec_fix_f64_T_3 = ~Ec_f64_is_not_zero | Ec_f64[0]; // @[FloatFMA.scala 153:84]
  wire [10:0] Ec_fix_f64 = {Ec_f64[10:1],_Ec_fix_f64_T_3}; // @[Cat.scala 33:92]
  wire [11:0] _Eab_f64_T = Ea_fix_f64 + Eb_fix_f64; // @[FloatFMA.scala 162:50]
  wire [12:0] _Eab_f64_T_2 = {1'h0,_Eab_f64_T}; // @[FloatFMA.scala 162:65]
  wire [12:0] _Eab_f64_T_5 = $signed(_Eab_f64_T_2) - 13'sh3ff; // @[FloatFMA.scala 162:72]
  wire [12:0] Eab_f64 = $signed(_Eab_f64_T_5) + 13'sh38; // @[FloatFMA.scala 162:84]
  wire [11:0] _rshift_value_f64_T = {1'h0,Ec_f64[10:1],_Ec_fix_f64_T_3}; // @[Cat.scala 33:92]
  wire [11:0] _rshift_value_f64_T_1 = {1'h0,Ec_f64[10:1],_Ec_fix_f64_T_3}; // @[FloatFMA.scala 167:61]
  wire [12:0] _GEN_182 = {{1{_rshift_value_f64_T_1[11]}},_rshift_value_f64_T_1}; // @[FloatFMA.scala 167:39]
  wire [12:0] rshift_value_f64 = $signed(Eab_f64) - $signed(_GEN_182); // @[FloatFMA.scala 167:39]
  wire [7:0] rshift_value_cut_f64 = rshift_value_f64[7:0]; // @[FloatFMA.scala 171:47]
  wire [162:0] fp_c_significand_cat0_f64 = {Ec_f64_is_not_zero,fp_c_f64[51:0],110'h0}; // @[Cat.scala 33:92]
  wire [162:0] rshift_result_with_grs_f64_res_vec_1 = rshift_value_cut_f64[0] ? {{1'd0}, fp_c_significand_cat0_f64[162:1
    ]} : fp_c_significand_cat0_f64; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_1 = rshift_value_cut_f64[0] & |fp_c_significand_cat0_f64[0]; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_2 = rshift_value_cut_f64[1] ? {{2'd0},
    rshift_result_with_grs_f64_res_vec_1[162:2]} : rshift_result_with_grs_f64_res_vec_1; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_2 = rshift_value_cut_f64[1] ? rshift_result_with_grs_f64_sticky_vec_1 | |
    rshift_result_with_grs_f64_res_vec_1[1:0] : rshift_result_with_grs_f64_sticky_vec_1; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_3 = rshift_value_cut_f64[2] ? {{4'd0},
    rshift_result_with_grs_f64_res_vec_2[162:4]} : rshift_result_with_grs_f64_res_vec_2; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_3 = rshift_value_cut_f64[2] ? rshift_result_with_grs_f64_sticky_vec_2 | |
    rshift_result_with_grs_f64_res_vec_2[3:0] : rshift_result_with_grs_f64_sticky_vec_2; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_4 = rshift_value_cut_f64[3] ? {{8'd0},
    rshift_result_with_grs_f64_res_vec_3[162:8]} : rshift_result_with_grs_f64_res_vec_3; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_4 = rshift_value_cut_f64[3] ? rshift_result_with_grs_f64_sticky_vec_3 | |
    rshift_result_with_grs_f64_res_vec_3[7:0] : rshift_result_with_grs_f64_sticky_vec_3; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_5 = rshift_value_cut_f64[4] ? {{16'd0},
    rshift_result_with_grs_f64_res_vec_4[162:16]} : rshift_result_with_grs_f64_res_vec_4; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_5 = rshift_value_cut_f64[4] ? rshift_result_with_grs_f64_sticky_vec_4 | |
    rshift_result_with_grs_f64_res_vec_4[15:0] : rshift_result_with_grs_f64_sticky_vec_4; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_6 = rshift_value_cut_f64[5] ? {{32'd0},
    rshift_result_with_grs_f64_res_vec_5[162:32]} : rshift_result_with_grs_f64_res_vec_5; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_6 = rshift_value_cut_f64[5] ? rshift_result_with_grs_f64_sticky_vec_5 | |
    rshift_result_with_grs_f64_res_vec_5[31:0] : rshift_result_with_grs_f64_sticky_vec_5; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_7 = rshift_value_cut_f64[6] ? {{64'd0},
    rshift_result_with_grs_f64_res_vec_6[162:64]} : rshift_result_with_grs_f64_res_vec_6; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_7 = rshift_value_cut_f64[6] ? rshift_result_with_grs_f64_sticky_vec_6 | |
    rshift_result_with_grs_f64_res_vec_6[63:0] : rshift_result_with_grs_f64_sticky_vec_6; // @[FloatFMA.scala 46:29]
  wire [162:0] rshift_result_with_grs_f64_res_vec_8 = rshift_value_cut_f64[7] ? {{128'd0},
    rshift_result_with_grs_f64_res_vec_7[162:128]} : rshift_result_with_grs_f64_res_vec_7; // @[FloatFMA.scala 45:26]
  wire  rshift_result_with_grs_f64_sticky_vec_8 = rshift_value_cut_f64[7] ? rshift_result_with_grs_f64_sticky_vec_7 | |
    rshift_result_with_grs_f64_res_vec_7[127:0] : rshift_result_with_grs_f64_sticky_vec_7; // @[FloatFMA.scala 46:29]
  wire [163:0] rshift_result_with_grs_f64 = {rshift_result_with_grs_f64_res_vec_8,
    rshift_result_with_grs_f64_sticky_vec_8}; // @[Cat.scala 33:92]
  wire  Ec_is_too_big_f64 = $signed(rshift_value_f64) <= 13'sh0; // @[FloatFMA.scala 184:53]
  wire  Ec_is_too_small_f64 = $signed(rshift_value_f64) > 13'sha3; // @[FloatFMA.scala 188:60]
  wire  Ec_is_medium_f64 = ~Ec_is_too_big_f64 & ~Ec_is_too_small_f64; // @[FloatFMA.scala 192:55]
  reg  rshift_guard_f16; // @[Reg.scala 19:16]
  reg  rshift_round_f16; // @[Reg.scala 19:16]
  wire  _rshift_sticky_f64_reg_d_T_1 = |fp_c_significand_f64; // @[FloatFMA.scala 209:138]
  reg  rshift_sticky_f16; // @[Reg.scala 19:16]
  wire [160:0] rshift_result_temp_f64 = rshift_result_with_grs_f64[163:3]; // @[FloatFMA.scala 225:67]
  wire [160:0] _rshift_result_f64_T_1 = Ec_is_too_big_f64 ? fp_c_significand_cat0_f64[162:2] : 161'h0; // @[FloatFMA.scala 231:8]
  wire [160:0] rshift_result_f64 = Ec_is_medium_f64 ? rshift_result_temp_f64 : _rshift_result_f64_T_1; // @[FloatFMA.scala 229:39]
  wire [160:0] _fp_c_rshiftValue_inv_f64_reg_d_T_1 = ~rshift_result_f64; // @[FloatFMA.scala 242:71]
  wire [161:0] _fp_c_rshiftValue_inv_f64_reg_d_T_2 = {1'h1,_fp_c_rshiftValue_inv_f64_reg_d_T_1}; // @[Cat.scala 33:92]
  wire [161:0] _fp_c_rshiftValue_inv_f64_reg_d_T_3 = {1'h0,rshift_result_f64}; // @[Cat.scala 33:92]
  reg [161:0] fp_c_rshiftValue_inv_f64_reg0; // @[Reg.scala 19:16]
  wire  _CSA3to2_in_b_T_6 = is_sub_f64_reg0 & ~rshift_guard_f16 & ~rshift_round_f16 & ~rshift_sticky_f16; // @[FloatFMA.scala 280:97]
  wire [106:0] adder_lowbit_f64 = U_CSA3to2_io_out_sum + U_CSA3to2_io_out_car; // @[FloatFMA.scala 316:47]
  wire [55:0] fp_c_rshift_result_high_inv_add0_f64 = fp_c_rshiftValue_inv_f64_reg0[161:106]; // @[FloatFMA.scala 320:80]
  wire [58:0] _fp_c_rshift_result_high_inv_add1_T_1 = {3'h0,fp_c_rshift_result_high_inv_add0_f64}; // @[Cat.scala 33:92]
  wire [58:0] fp_c_rshift_result_high_inv_add1 = _fp_c_rshift_result_high_inv_add1_T_1 + 59'h1; // @[FloatFMA.scala 334:5]
  wire [55:0] fp_c_rshift_result_high_inv_add1_f64 = fp_c_rshift_result_high_inv_add1[55:0]; // @[FloatFMA.scala 336:78]
  wire [55:0] _adder_f64_T_2 = adder_lowbit_f64[106] ? fp_c_rshift_result_high_inv_add1_f64 :
    fp_c_rshift_result_high_inv_add0_f64; // @[FloatFMA.scala 340:32]
  wire [1:0] adder_f64_hi = {rshift_guard_f16,rshift_round_f16}; // @[Cat.scala 33:92]
  wire [2:0] _adder_f64_T_4 = {rshift_guard_f16,rshift_round_f16,rshift_sticky_f16}; // @[Cat.scala 33:92]
  wire [2:0] _adder_f64_T_5 = ~_adder_f64_T_4; // @[FloatFMA.scala 341:28]
  wire [2:0] _adder_f64_T_7 = _adder_f64_T_5 + 3'h1; // @[FloatFMA.scala 341:93]
  wire [1:0] _adder_f64_T_10 = is_sub_f64_reg0 ? _adder_f64_T_7[2:1] : adder_f64_hi; // @[FloatFMA.scala 341:8]
  wire [163:0] adder_f64 = {_adder_f64_T_2,adder_lowbit_f64[105:0],_adder_f64_T_10}; // @[Cat.scala 33:92]
  wire  adder_is_negative_f64 = adder_f64[163]; // @[FloatFMA.scala 350:45]
  reg  adder_is_negative_reg1; // @[Reg.scala 19:16]
  reg  adder_is_negative_f16_reg2; // @[Reg.scala 19:16]
  wire [162:0] _adder_inv_f64_T_1 = ~adder_f64[162:0]; // @[FloatFMA.scala 363:57]
  wire [162:0] adder_inv_f64 = adder_is_negative_f64 ? _adder_inv_f64_T_1 : adder_f64[162:0]; // @[FloatFMA.scala 363:32]
  wire  Eab_is_greater_f64 = $signed(rshift_value_f64) > 13'sh0; // @[FloatFMA.scala 367:48]
  reg [11:0] E_greater_reg2_r; // @[Reg.scala 19:16]
  reg [11:0] E_greater_reg2_r_1; // @[Reg.scala 19:16]
  reg [11:0] E_greater_f64_reg2; // @[Reg.scala 19:16]
  wire [11:0] _lshift_value_max_f64_reg_d_T_2 = Eab_f64[11:0] - 12'h1; // @[FloatFMA.scala 383:93]
  wire [10:0] _lshift_value_max_f64_reg_d_T_4 = Ec_fix_f64 - 11'h1; // @[FloatFMA.scala 383:119]
  wire [11:0] _lshift_value_max_f64_reg_d_T_5 = {1'h0,_lshift_value_max_f64_reg_d_T_4}; // @[Cat.scala 33:92]
  reg [11:0] lshift_value_max_f64_reg0; // @[Reg.scala 19:16]
  wire [162:0] _lshift_value_mask_f64_T_4 = 163'h7ffffffffffffffffffffffffffffffffffffffff >> lshift_value_max_f64_reg0[
    7:0]; // @[FloatFMA.scala 400:39]
  wire [162:0] lshift_value_mask_f64 = |lshift_value_max_f64_reg0[11:8] ? 163'h0 : _lshift_value_mask_f64_T_4; // @[FloatFMA.scala 398:34]
  wire [63:0] _GEN_185 = {{32'd0}, adder_f64[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_5 = _GEN_185 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_7 = {adder_f64[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_9 = _tzd_adder_f64_reg_d_T_7 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_10 = _tzd_adder_f64_reg_d_T_5 | _tzd_adder_f64_reg_d_T_9; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_186 = {{16'd0}, _tzd_adder_f64_reg_d_T_10[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_15 = _GEN_186 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_17 = {_tzd_adder_f64_reg_d_T_10[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_19 = _tzd_adder_f64_reg_d_T_17 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_20 = _tzd_adder_f64_reg_d_T_15 | _tzd_adder_f64_reg_d_T_19; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_187 = {{8'd0}, _tzd_adder_f64_reg_d_T_20[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_25 = _GEN_187 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_27 = {_tzd_adder_f64_reg_d_T_20[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_29 = _tzd_adder_f64_reg_d_T_27 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_30 = _tzd_adder_f64_reg_d_T_25 | _tzd_adder_f64_reg_d_T_29; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_188 = {{4'd0}, _tzd_adder_f64_reg_d_T_30[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_35 = _GEN_188 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_37 = {_tzd_adder_f64_reg_d_T_30[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_39 = _tzd_adder_f64_reg_d_T_37 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_40 = _tzd_adder_f64_reg_d_T_35 | _tzd_adder_f64_reg_d_T_39; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_189 = {{2'd0}, _tzd_adder_f64_reg_d_T_40[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_45 = _GEN_189 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_47 = {_tzd_adder_f64_reg_d_T_40[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_49 = _tzd_adder_f64_reg_d_T_47 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_50 = _tzd_adder_f64_reg_d_T_45 | _tzd_adder_f64_reg_d_T_49; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_190 = {{1'd0}, _tzd_adder_f64_reg_d_T_50[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_55 = _GEN_190 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_57 = {_tzd_adder_f64_reg_d_T_50[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_59 = _tzd_adder_f64_reg_d_T_57 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_60 = _tzd_adder_f64_reg_d_T_55 | _tzd_adder_f64_reg_d_T_59; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_191 = {{32'd0}, adder_f64[127:96]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_65 = _GEN_191 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_67 = {adder_f64[95:64], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_69 = _tzd_adder_f64_reg_d_T_67 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_70 = _tzd_adder_f64_reg_d_T_65 | _tzd_adder_f64_reg_d_T_69; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_192 = {{16'd0}, _tzd_adder_f64_reg_d_T_70[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_75 = _GEN_192 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_77 = {_tzd_adder_f64_reg_d_T_70[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_79 = _tzd_adder_f64_reg_d_T_77 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_80 = _tzd_adder_f64_reg_d_T_75 | _tzd_adder_f64_reg_d_T_79; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_193 = {{8'd0}, _tzd_adder_f64_reg_d_T_80[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_85 = _GEN_193 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_87 = {_tzd_adder_f64_reg_d_T_80[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_89 = _tzd_adder_f64_reg_d_T_87 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_90 = _tzd_adder_f64_reg_d_T_85 | _tzd_adder_f64_reg_d_T_89; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_194 = {{4'd0}, _tzd_adder_f64_reg_d_T_90[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_95 = _GEN_194 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_97 = {_tzd_adder_f64_reg_d_T_90[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_99 = _tzd_adder_f64_reg_d_T_97 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_100 = _tzd_adder_f64_reg_d_T_95 | _tzd_adder_f64_reg_d_T_99; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_195 = {{2'd0}, _tzd_adder_f64_reg_d_T_100[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_105 = _GEN_195 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_107 = {_tzd_adder_f64_reg_d_T_100[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_109 = _tzd_adder_f64_reg_d_T_107 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_110 = _tzd_adder_f64_reg_d_T_105 | _tzd_adder_f64_reg_d_T_109; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_196 = {{1'd0}, _tzd_adder_f64_reg_d_T_110[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_115 = _GEN_196 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg_d_T_117 = {_tzd_adder_f64_reg_d_T_110[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg_d_T_119 = _tzd_adder_f64_reg_d_T_117 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg_d_T_120 = _tzd_adder_f64_reg_d_T_115 | _tzd_adder_f64_reg_d_T_119; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_197 = {{16'd0}, adder_f64[159:144]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_127 = _GEN_197 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_129 = {adder_f64[143:128], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg_d_T_131 = _tzd_adder_f64_reg_d_T_129 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg_d_T_132 = _tzd_adder_f64_reg_d_T_127 | _tzd_adder_f64_reg_d_T_131; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_198 = {{8'd0}, _tzd_adder_f64_reg_d_T_132[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_137 = _GEN_198 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_139 = {_tzd_adder_f64_reg_d_T_132[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg_d_T_141 = _tzd_adder_f64_reg_d_T_139 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg_d_T_142 = _tzd_adder_f64_reg_d_T_137 | _tzd_adder_f64_reg_d_T_141; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_199 = {{4'd0}, _tzd_adder_f64_reg_d_T_142[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_147 = _GEN_199 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_149 = {_tzd_adder_f64_reg_d_T_142[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg_d_T_151 = _tzd_adder_f64_reg_d_T_149 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg_d_T_152 = _tzd_adder_f64_reg_d_T_147 | _tzd_adder_f64_reg_d_T_151; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_200 = {{2'd0}, _tzd_adder_f64_reg_d_T_152[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_157 = _GEN_200 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_159 = {_tzd_adder_f64_reg_d_T_152[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg_d_T_161 = _tzd_adder_f64_reg_d_T_159 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg_d_T_162 = _tzd_adder_f64_reg_d_T_157 | _tzd_adder_f64_reg_d_T_161; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_201 = {{1'd0}, _tzd_adder_f64_reg_d_T_162[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_167 = _GEN_201 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg_d_T_169 = {_tzd_adder_f64_reg_d_T_162[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg_d_T_171 = _tzd_adder_f64_reg_d_T_169 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg_d_T_172 = _tzd_adder_f64_reg_d_T_167 | _tzd_adder_f64_reg_d_T_171; // @[Bitwise.scala 108:39]
  wire [163:0] tzd_adder_f64_reg_d = {_tzd_adder_f64_reg_d_T_60,_tzd_adder_f64_reg_d_T_120,_tzd_adder_f64_reg_d_T_172,
    adder_f64[160],adder_f64[161],adder_f64[162],adder_f64[163]}; // @[Cat.scala 33:92]
  reg [163:0] tzd_adder_reg1; // @[Reg.scala 19:16]
  wire [164:0] _tzd_adder_f64_reg1_T = {tzd_adder_reg1,1'h1}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_216 = {{32'd0}, _tzd_adder_f64_reg1_T[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_6 = _GEN_216 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_8 = {_tzd_adder_f64_reg1_T[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_10 = _tzd_adder_f64_reg1_T_8 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_11 = _tzd_adder_f64_reg1_T_6 | _tzd_adder_f64_reg1_T_10; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_217 = {{16'd0}, _tzd_adder_f64_reg1_T_11[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_16 = _GEN_217 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_18 = {_tzd_adder_f64_reg1_T_11[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_20 = _tzd_adder_f64_reg1_T_18 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_21 = _tzd_adder_f64_reg1_T_16 | _tzd_adder_f64_reg1_T_20; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_218 = {{8'd0}, _tzd_adder_f64_reg1_T_21[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_26 = _GEN_218 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_28 = {_tzd_adder_f64_reg1_T_21[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_30 = _tzd_adder_f64_reg1_T_28 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_31 = _tzd_adder_f64_reg1_T_26 | _tzd_adder_f64_reg1_T_30; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_219 = {{4'd0}, _tzd_adder_f64_reg1_T_31[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_36 = _GEN_219 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_38 = {_tzd_adder_f64_reg1_T_31[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_40 = _tzd_adder_f64_reg1_T_38 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_41 = _tzd_adder_f64_reg1_T_36 | _tzd_adder_f64_reg1_T_40; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_220 = {{2'd0}, _tzd_adder_f64_reg1_T_41[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_46 = _GEN_220 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_48 = {_tzd_adder_f64_reg1_T_41[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_50 = _tzd_adder_f64_reg1_T_48 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_51 = _tzd_adder_f64_reg1_T_46 | _tzd_adder_f64_reg1_T_50; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_221 = {{1'd0}, _tzd_adder_f64_reg1_T_51[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_56 = _GEN_221 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_58 = {_tzd_adder_f64_reg1_T_51[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_60 = _tzd_adder_f64_reg1_T_58 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_61 = _tzd_adder_f64_reg1_T_56 | _tzd_adder_f64_reg1_T_60; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_222 = {{32'd0}, _tzd_adder_f64_reg1_T[127:96]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_66 = _GEN_222 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_68 = {_tzd_adder_f64_reg1_T[95:64], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_70 = _tzd_adder_f64_reg1_T_68 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_71 = _tzd_adder_f64_reg1_T_66 | _tzd_adder_f64_reg1_T_70; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_223 = {{16'd0}, _tzd_adder_f64_reg1_T_71[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_76 = _GEN_223 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_78 = {_tzd_adder_f64_reg1_T_71[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_80 = _tzd_adder_f64_reg1_T_78 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_81 = _tzd_adder_f64_reg1_T_76 | _tzd_adder_f64_reg1_T_80; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_224 = {{8'd0}, _tzd_adder_f64_reg1_T_81[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_86 = _GEN_224 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_88 = {_tzd_adder_f64_reg1_T_81[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_90 = _tzd_adder_f64_reg1_T_88 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_91 = _tzd_adder_f64_reg1_T_86 | _tzd_adder_f64_reg1_T_90; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_225 = {{4'd0}, _tzd_adder_f64_reg1_T_91[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_96 = _GEN_225 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_98 = {_tzd_adder_f64_reg1_T_91[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_100 = _tzd_adder_f64_reg1_T_98 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_101 = _tzd_adder_f64_reg1_T_96 | _tzd_adder_f64_reg1_T_100; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_226 = {{2'd0}, _tzd_adder_f64_reg1_T_101[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_106 = _GEN_226 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_108 = {_tzd_adder_f64_reg1_T_101[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_110 = _tzd_adder_f64_reg1_T_108 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_111 = _tzd_adder_f64_reg1_T_106 | _tzd_adder_f64_reg1_T_110; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_227 = {{1'd0}, _tzd_adder_f64_reg1_T_111[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_116 = _GEN_227 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _tzd_adder_f64_reg1_T_118 = {_tzd_adder_f64_reg1_T_111[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _tzd_adder_f64_reg1_T_120 = _tzd_adder_f64_reg1_T_118 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _tzd_adder_f64_reg1_T_121 = _tzd_adder_f64_reg1_T_116 | _tzd_adder_f64_reg1_T_120; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_228 = {{16'd0}, _tzd_adder_f64_reg1_T[159:144]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_128 = _GEN_228 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_130 = {_tzd_adder_f64_reg1_T[143:128], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg1_T_132 = _tzd_adder_f64_reg1_T_130 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg1_T_133 = _tzd_adder_f64_reg1_T_128 | _tzd_adder_f64_reg1_T_132; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_229 = {{8'd0}, _tzd_adder_f64_reg1_T_133[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_138 = _GEN_229 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_140 = {_tzd_adder_f64_reg1_T_133[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg1_T_142 = _tzd_adder_f64_reg1_T_140 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg1_T_143 = _tzd_adder_f64_reg1_T_138 | _tzd_adder_f64_reg1_T_142; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_230 = {{4'd0}, _tzd_adder_f64_reg1_T_143[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_148 = _GEN_230 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_150 = {_tzd_adder_f64_reg1_T_143[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg1_T_152 = _tzd_adder_f64_reg1_T_150 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg1_T_153 = _tzd_adder_f64_reg1_T_148 | _tzd_adder_f64_reg1_T_152; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_231 = {{2'd0}, _tzd_adder_f64_reg1_T_153[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_158 = _GEN_231 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_160 = {_tzd_adder_f64_reg1_T_153[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg1_T_162 = _tzd_adder_f64_reg1_T_160 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg1_T_163 = _tzd_adder_f64_reg1_T_158 | _tzd_adder_f64_reg1_T_162; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_232 = {{1'd0}, _tzd_adder_f64_reg1_T_163[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_168 = _GEN_232 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _tzd_adder_f64_reg1_T_170 = {_tzd_adder_f64_reg1_T_163[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _tzd_adder_f64_reg1_T_172 = _tzd_adder_f64_reg1_T_170 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _tzd_adder_f64_reg1_T_173 = _tzd_adder_f64_reg1_T_168 | _tzd_adder_f64_reg1_T_172; // @[Bitwise.scala 108:39]
  wire [164:0] _tzd_adder_f64_reg1_T_188 = {_tzd_adder_f64_reg1_T_61,_tzd_adder_f64_reg1_T_121,_tzd_adder_f64_reg1_T_173
    ,_tzd_adder_f64_reg1_T[160],_tzd_adder_f64_reg1_T[161],_tzd_adder_f64_reg1_T[162],_tzd_adder_f64_reg1_T[163],
    _tzd_adder_f64_reg1_T[164]}; // @[Cat.scala 33:92]
  wire [7:0] _tzd_adder_f64_reg1_T_354 = _tzd_adder_f64_reg1_T_188[163] ? 8'ha3 : 8'ha4; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_355 = _tzd_adder_f64_reg1_T_188[162] ? 8'ha2 : _tzd_adder_f64_reg1_T_354; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_356 = _tzd_adder_f64_reg1_T_188[161] ? 8'ha1 : _tzd_adder_f64_reg1_T_355; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_357 = _tzd_adder_f64_reg1_T_188[160] ? 8'ha0 : _tzd_adder_f64_reg1_T_356; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_358 = _tzd_adder_f64_reg1_T_188[159] ? 8'h9f : _tzd_adder_f64_reg1_T_357; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_359 = _tzd_adder_f64_reg1_T_188[158] ? 8'h9e : _tzd_adder_f64_reg1_T_358; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_360 = _tzd_adder_f64_reg1_T_188[157] ? 8'h9d : _tzd_adder_f64_reg1_T_359; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_361 = _tzd_adder_f64_reg1_T_188[156] ? 8'h9c : _tzd_adder_f64_reg1_T_360; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_362 = _tzd_adder_f64_reg1_T_188[155] ? 8'h9b : _tzd_adder_f64_reg1_T_361; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_363 = _tzd_adder_f64_reg1_T_188[154] ? 8'h9a : _tzd_adder_f64_reg1_T_362; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_364 = _tzd_adder_f64_reg1_T_188[153] ? 8'h99 : _tzd_adder_f64_reg1_T_363; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_365 = _tzd_adder_f64_reg1_T_188[152] ? 8'h98 : _tzd_adder_f64_reg1_T_364; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_366 = _tzd_adder_f64_reg1_T_188[151] ? 8'h97 : _tzd_adder_f64_reg1_T_365; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_367 = _tzd_adder_f64_reg1_T_188[150] ? 8'h96 : _tzd_adder_f64_reg1_T_366; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_368 = _tzd_adder_f64_reg1_T_188[149] ? 8'h95 : _tzd_adder_f64_reg1_T_367; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_369 = _tzd_adder_f64_reg1_T_188[148] ? 8'h94 : _tzd_adder_f64_reg1_T_368; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_370 = _tzd_adder_f64_reg1_T_188[147] ? 8'h93 : _tzd_adder_f64_reg1_T_369; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_371 = _tzd_adder_f64_reg1_T_188[146] ? 8'h92 : _tzd_adder_f64_reg1_T_370; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_372 = _tzd_adder_f64_reg1_T_188[145] ? 8'h91 : _tzd_adder_f64_reg1_T_371; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_373 = _tzd_adder_f64_reg1_T_188[144] ? 8'h90 : _tzd_adder_f64_reg1_T_372; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_374 = _tzd_adder_f64_reg1_T_188[143] ? 8'h8f : _tzd_adder_f64_reg1_T_373; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_375 = _tzd_adder_f64_reg1_T_188[142] ? 8'h8e : _tzd_adder_f64_reg1_T_374; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_376 = _tzd_adder_f64_reg1_T_188[141] ? 8'h8d : _tzd_adder_f64_reg1_T_375; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_377 = _tzd_adder_f64_reg1_T_188[140] ? 8'h8c : _tzd_adder_f64_reg1_T_376; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_378 = _tzd_adder_f64_reg1_T_188[139] ? 8'h8b : _tzd_adder_f64_reg1_T_377; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_379 = _tzd_adder_f64_reg1_T_188[138] ? 8'h8a : _tzd_adder_f64_reg1_T_378; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_380 = _tzd_adder_f64_reg1_T_188[137] ? 8'h89 : _tzd_adder_f64_reg1_T_379; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_381 = _tzd_adder_f64_reg1_T_188[136] ? 8'h88 : _tzd_adder_f64_reg1_T_380; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_382 = _tzd_adder_f64_reg1_T_188[135] ? 8'h87 : _tzd_adder_f64_reg1_T_381; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_383 = _tzd_adder_f64_reg1_T_188[134] ? 8'h86 : _tzd_adder_f64_reg1_T_382; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_384 = _tzd_adder_f64_reg1_T_188[133] ? 8'h85 : _tzd_adder_f64_reg1_T_383; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_385 = _tzd_adder_f64_reg1_T_188[132] ? 8'h84 : _tzd_adder_f64_reg1_T_384; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_386 = _tzd_adder_f64_reg1_T_188[131] ? 8'h83 : _tzd_adder_f64_reg1_T_385; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_387 = _tzd_adder_f64_reg1_T_188[130] ? 8'h82 : _tzd_adder_f64_reg1_T_386; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_388 = _tzd_adder_f64_reg1_T_188[129] ? 8'h81 : _tzd_adder_f64_reg1_T_387; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_389 = _tzd_adder_f64_reg1_T_188[128] ? 8'h80 : _tzd_adder_f64_reg1_T_388; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_390 = _tzd_adder_f64_reg1_T_188[127] ? 8'h7f : _tzd_adder_f64_reg1_T_389; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_391 = _tzd_adder_f64_reg1_T_188[126] ? 8'h7e : _tzd_adder_f64_reg1_T_390; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_392 = _tzd_adder_f64_reg1_T_188[125] ? 8'h7d : _tzd_adder_f64_reg1_T_391; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_393 = _tzd_adder_f64_reg1_T_188[124] ? 8'h7c : _tzd_adder_f64_reg1_T_392; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_394 = _tzd_adder_f64_reg1_T_188[123] ? 8'h7b : _tzd_adder_f64_reg1_T_393; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_395 = _tzd_adder_f64_reg1_T_188[122] ? 8'h7a : _tzd_adder_f64_reg1_T_394; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_396 = _tzd_adder_f64_reg1_T_188[121] ? 8'h79 : _tzd_adder_f64_reg1_T_395; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_397 = _tzd_adder_f64_reg1_T_188[120] ? 8'h78 : _tzd_adder_f64_reg1_T_396; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_398 = _tzd_adder_f64_reg1_T_188[119] ? 8'h77 : _tzd_adder_f64_reg1_T_397; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_399 = _tzd_adder_f64_reg1_T_188[118] ? 8'h76 : _tzd_adder_f64_reg1_T_398; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_400 = _tzd_adder_f64_reg1_T_188[117] ? 8'h75 : _tzd_adder_f64_reg1_T_399; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_401 = _tzd_adder_f64_reg1_T_188[116] ? 8'h74 : _tzd_adder_f64_reg1_T_400; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_402 = _tzd_adder_f64_reg1_T_188[115] ? 8'h73 : _tzd_adder_f64_reg1_T_401; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_403 = _tzd_adder_f64_reg1_T_188[114] ? 8'h72 : _tzd_adder_f64_reg1_T_402; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_404 = _tzd_adder_f64_reg1_T_188[113] ? 8'h71 : _tzd_adder_f64_reg1_T_403; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_405 = _tzd_adder_f64_reg1_T_188[112] ? 8'h70 : _tzd_adder_f64_reg1_T_404; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_406 = _tzd_adder_f64_reg1_T_188[111] ? 8'h6f : _tzd_adder_f64_reg1_T_405; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_407 = _tzd_adder_f64_reg1_T_188[110] ? 8'h6e : _tzd_adder_f64_reg1_T_406; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_408 = _tzd_adder_f64_reg1_T_188[109] ? 8'h6d : _tzd_adder_f64_reg1_T_407; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_409 = _tzd_adder_f64_reg1_T_188[108] ? 8'h6c : _tzd_adder_f64_reg1_T_408; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_410 = _tzd_adder_f64_reg1_T_188[107] ? 8'h6b : _tzd_adder_f64_reg1_T_409; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_411 = _tzd_adder_f64_reg1_T_188[106] ? 8'h6a : _tzd_adder_f64_reg1_T_410; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_412 = _tzd_adder_f64_reg1_T_188[105] ? 8'h69 : _tzd_adder_f64_reg1_T_411; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_413 = _tzd_adder_f64_reg1_T_188[104] ? 8'h68 : _tzd_adder_f64_reg1_T_412; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_414 = _tzd_adder_f64_reg1_T_188[103] ? 8'h67 : _tzd_adder_f64_reg1_T_413; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_415 = _tzd_adder_f64_reg1_T_188[102] ? 8'h66 : _tzd_adder_f64_reg1_T_414; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_416 = _tzd_adder_f64_reg1_T_188[101] ? 8'h65 : _tzd_adder_f64_reg1_T_415; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_417 = _tzd_adder_f64_reg1_T_188[100] ? 8'h64 : _tzd_adder_f64_reg1_T_416; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_418 = _tzd_adder_f64_reg1_T_188[99] ? 8'h63 : _tzd_adder_f64_reg1_T_417; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_419 = _tzd_adder_f64_reg1_T_188[98] ? 8'h62 : _tzd_adder_f64_reg1_T_418; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_420 = _tzd_adder_f64_reg1_T_188[97] ? 8'h61 : _tzd_adder_f64_reg1_T_419; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_421 = _tzd_adder_f64_reg1_T_188[96] ? 8'h60 : _tzd_adder_f64_reg1_T_420; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_422 = _tzd_adder_f64_reg1_T_188[95] ? 8'h5f : _tzd_adder_f64_reg1_T_421; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_423 = _tzd_adder_f64_reg1_T_188[94] ? 8'h5e : _tzd_adder_f64_reg1_T_422; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_424 = _tzd_adder_f64_reg1_T_188[93] ? 8'h5d : _tzd_adder_f64_reg1_T_423; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_425 = _tzd_adder_f64_reg1_T_188[92] ? 8'h5c : _tzd_adder_f64_reg1_T_424; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_426 = _tzd_adder_f64_reg1_T_188[91] ? 8'h5b : _tzd_adder_f64_reg1_T_425; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_427 = _tzd_adder_f64_reg1_T_188[90] ? 8'h5a : _tzd_adder_f64_reg1_T_426; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_428 = _tzd_adder_f64_reg1_T_188[89] ? 8'h59 : _tzd_adder_f64_reg1_T_427; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_429 = _tzd_adder_f64_reg1_T_188[88] ? 8'h58 : _tzd_adder_f64_reg1_T_428; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_430 = _tzd_adder_f64_reg1_T_188[87] ? 8'h57 : _tzd_adder_f64_reg1_T_429; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_431 = _tzd_adder_f64_reg1_T_188[86] ? 8'h56 : _tzd_adder_f64_reg1_T_430; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_432 = _tzd_adder_f64_reg1_T_188[85] ? 8'h55 : _tzd_adder_f64_reg1_T_431; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_433 = _tzd_adder_f64_reg1_T_188[84] ? 8'h54 : _tzd_adder_f64_reg1_T_432; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_434 = _tzd_adder_f64_reg1_T_188[83] ? 8'h53 : _tzd_adder_f64_reg1_T_433; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_435 = _tzd_adder_f64_reg1_T_188[82] ? 8'h52 : _tzd_adder_f64_reg1_T_434; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_436 = _tzd_adder_f64_reg1_T_188[81] ? 8'h51 : _tzd_adder_f64_reg1_T_435; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_437 = _tzd_adder_f64_reg1_T_188[80] ? 8'h50 : _tzd_adder_f64_reg1_T_436; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_438 = _tzd_adder_f64_reg1_T_188[79] ? 8'h4f : _tzd_adder_f64_reg1_T_437; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_439 = _tzd_adder_f64_reg1_T_188[78] ? 8'h4e : _tzd_adder_f64_reg1_T_438; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_440 = _tzd_adder_f64_reg1_T_188[77] ? 8'h4d : _tzd_adder_f64_reg1_T_439; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_441 = _tzd_adder_f64_reg1_T_188[76] ? 8'h4c : _tzd_adder_f64_reg1_T_440; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_442 = _tzd_adder_f64_reg1_T_188[75] ? 8'h4b : _tzd_adder_f64_reg1_T_441; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_443 = _tzd_adder_f64_reg1_T_188[74] ? 8'h4a : _tzd_adder_f64_reg1_T_442; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_444 = _tzd_adder_f64_reg1_T_188[73] ? 8'h49 : _tzd_adder_f64_reg1_T_443; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_445 = _tzd_adder_f64_reg1_T_188[72] ? 8'h48 : _tzd_adder_f64_reg1_T_444; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_446 = _tzd_adder_f64_reg1_T_188[71] ? 8'h47 : _tzd_adder_f64_reg1_T_445; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_447 = _tzd_adder_f64_reg1_T_188[70] ? 8'h46 : _tzd_adder_f64_reg1_T_446; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_448 = _tzd_adder_f64_reg1_T_188[69] ? 8'h45 : _tzd_adder_f64_reg1_T_447; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_449 = _tzd_adder_f64_reg1_T_188[68] ? 8'h44 : _tzd_adder_f64_reg1_T_448; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_450 = _tzd_adder_f64_reg1_T_188[67] ? 8'h43 : _tzd_adder_f64_reg1_T_449; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_451 = _tzd_adder_f64_reg1_T_188[66] ? 8'h42 : _tzd_adder_f64_reg1_T_450; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_452 = _tzd_adder_f64_reg1_T_188[65] ? 8'h41 : _tzd_adder_f64_reg1_T_451; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_453 = _tzd_adder_f64_reg1_T_188[64] ? 8'h40 : _tzd_adder_f64_reg1_T_452; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_454 = _tzd_adder_f64_reg1_T_188[63] ? 8'h3f : _tzd_adder_f64_reg1_T_453; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_455 = _tzd_adder_f64_reg1_T_188[62] ? 8'h3e : _tzd_adder_f64_reg1_T_454; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_456 = _tzd_adder_f64_reg1_T_188[61] ? 8'h3d : _tzd_adder_f64_reg1_T_455; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_457 = _tzd_adder_f64_reg1_T_188[60] ? 8'h3c : _tzd_adder_f64_reg1_T_456; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_458 = _tzd_adder_f64_reg1_T_188[59] ? 8'h3b : _tzd_adder_f64_reg1_T_457; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_459 = _tzd_adder_f64_reg1_T_188[58] ? 8'h3a : _tzd_adder_f64_reg1_T_458; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_460 = _tzd_adder_f64_reg1_T_188[57] ? 8'h39 : _tzd_adder_f64_reg1_T_459; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_461 = _tzd_adder_f64_reg1_T_188[56] ? 8'h38 : _tzd_adder_f64_reg1_T_460; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_462 = _tzd_adder_f64_reg1_T_188[55] ? 8'h37 : _tzd_adder_f64_reg1_T_461; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_463 = _tzd_adder_f64_reg1_T_188[54] ? 8'h36 : _tzd_adder_f64_reg1_T_462; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_464 = _tzd_adder_f64_reg1_T_188[53] ? 8'h35 : _tzd_adder_f64_reg1_T_463; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_465 = _tzd_adder_f64_reg1_T_188[52] ? 8'h34 : _tzd_adder_f64_reg1_T_464; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_466 = _tzd_adder_f64_reg1_T_188[51] ? 8'h33 : _tzd_adder_f64_reg1_T_465; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_467 = _tzd_adder_f64_reg1_T_188[50] ? 8'h32 : _tzd_adder_f64_reg1_T_466; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_468 = _tzd_adder_f64_reg1_T_188[49] ? 8'h31 : _tzd_adder_f64_reg1_T_467; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_469 = _tzd_adder_f64_reg1_T_188[48] ? 8'h30 : _tzd_adder_f64_reg1_T_468; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_470 = _tzd_adder_f64_reg1_T_188[47] ? 8'h2f : _tzd_adder_f64_reg1_T_469; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_471 = _tzd_adder_f64_reg1_T_188[46] ? 8'h2e : _tzd_adder_f64_reg1_T_470; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_472 = _tzd_adder_f64_reg1_T_188[45] ? 8'h2d : _tzd_adder_f64_reg1_T_471; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_473 = _tzd_adder_f64_reg1_T_188[44] ? 8'h2c : _tzd_adder_f64_reg1_T_472; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_474 = _tzd_adder_f64_reg1_T_188[43] ? 8'h2b : _tzd_adder_f64_reg1_T_473; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_475 = _tzd_adder_f64_reg1_T_188[42] ? 8'h2a : _tzd_adder_f64_reg1_T_474; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_476 = _tzd_adder_f64_reg1_T_188[41] ? 8'h29 : _tzd_adder_f64_reg1_T_475; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_477 = _tzd_adder_f64_reg1_T_188[40] ? 8'h28 : _tzd_adder_f64_reg1_T_476; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_478 = _tzd_adder_f64_reg1_T_188[39] ? 8'h27 : _tzd_adder_f64_reg1_T_477; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_479 = _tzd_adder_f64_reg1_T_188[38] ? 8'h26 : _tzd_adder_f64_reg1_T_478; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_480 = _tzd_adder_f64_reg1_T_188[37] ? 8'h25 : _tzd_adder_f64_reg1_T_479; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_481 = _tzd_adder_f64_reg1_T_188[36] ? 8'h24 : _tzd_adder_f64_reg1_T_480; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_482 = _tzd_adder_f64_reg1_T_188[35] ? 8'h23 : _tzd_adder_f64_reg1_T_481; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_483 = _tzd_adder_f64_reg1_T_188[34] ? 8'h22 : _tzd_adder_f64_reg1_T_482; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_484 = _tzd_adder_f64_reg1_T_188[33] ? 8'h21 : _tzd_adder_f64_reg1_T_483; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_485 = _tzd_adder_f64_reg1_T_188[32] ? 8'h20 : _tzd_adder_f64_reg1_T_484; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_486 = _tzd_adder_f64_reg1_T_188[31] ? 8'h1f : _tzd_adder_f64_reg1_T_485; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_487 = _tzd_adder_f64_reg1_T_188[30] ? 8'h1e : _tzd_adder_f64_reg1_T_486; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_488 = _tzd_adder_f64_reg1_T_188[29] ? 8'h1d : _tzd_adder_f64_reg1_T_487; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_489 = _tzd_adder_f64_reg1_T_188[28] ? 8'h1c : _tzd_adder_f64_reg1_T_488; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_490 = _tzd_adder_f64_reg1_T_188[27] ? 8'h1b : _tzd_adder_f64_reg1_T_489; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_491 = _tzd_adder_f64_reg1_T_188[26] ? 8'h1a : _tzd_adder_f64_reg1_T_490; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_492 = _tzd_adder_f64_reg1_T_188[25] ? 8'h19 : _tzd_adder_f64_reg1_T_491; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_493 = _tzd_adder_f64_reg1_T_188[24] ? 8'h18 : _tzd_adder_f64_reg1_T_492; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_494 = _tzd_adder_f64_reg1_T_188[23] ? 8'h17 : _tzd_adder_f64_reg1_T_493; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_495 = _tzd_adder_f64_reg1_T_188[22] ? 8'h16 : _tzd_adder_f64_reg1_T_494; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_496 = _tzd_adder_f64_reg1_T_188[21] ? 8'h15 : _tzd_adder_f64_reg1_T_495; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_497 = _tzd_adder_f64_reg1_T_188[20] ? 8'h14 : _tzd_adder_f64_reg1_T_496; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_498 = _tzd_adder_f64_reg1_T_188[19] ? 8'h13 : _tzd_adder_f64_reg1_T_497; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_499 = _tzd_adder_f64_reg1_T_188[18] ? 8'h12 : _tzd_adder_f64_reg1_T_498; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_500 = _tzd_adder_f64_reg1_T_188[17] ? 8'h11 : _tzd_adder_f64_reg1_T_499; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_501 = _tzd_adder_f64_reg1_T_188[16] ? 8'h10 : _tzd_adder_f64_reg1_T_500; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_502 = _tzd_adder_f64_reg1_T_188[15] ? 8'hf : _tzd_adder_f64_reg1_T_501; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_503 = _tzd_adder_f64_reg1_T_188[14] ? 8'he : _tzd_adder_f64_reg1_T_502; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_504 = _tzd_adder_f64_reg1_T_188[13] ? 8'hd : _tzd_adder_f64_reg1_T_503; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_505 = _tzd_adder_f64_reg1_T_188[12] ? 8'hc : _tzd_adder_f64_reg1_T_504; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_506 = _tzd_adder_f64_reg1_T_188[11] ? 8'hb : _tzd_adder_f64_reg1_T_505; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_507 = _tzd_adder_f64_reg1_T_188[10] ? 8'ha : _tzd_adder_f64_reg1_T_506; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_508 = _tzd_adder_f64_reg1_T_188[9] ? 8'h9 : _tzd_adder_f64_reg1_T_507; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_509 = _tzd_adder_f64_reg1_T_188[8] ? 8'h8 : _tzd_adder_f64_reg1_T_508; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_510 = _tzd_adder_f64_reg1_T_188[7] ? 8'h7 : _tzd_adder_f64_reg1_T_509; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_511 = _tzd_adder_f64_reg1_T_188[6] ? 8'h6 : _tzd_adder_f64_reg1_T_510; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_512 = _tzd_adder_f64_reg1_T_188[5] ? 8'h5 : _tzd_adder_f64_reg1_T_511; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_513 = _tzd_adder_f64_reg1_T_188[4] ? 8'h4 : _tzd_adder_f64_reg1_T_512; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_514 = _tzd_adder_f64_reg1_T_188[3] ? 8'h3 : _tzd_adder_f64_reg1_T_513; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_515 = _tzd_adder_f64_reg1_T_188[2] ? 8'h2 : _tzd_adder_f64_reg1_T_514; // @[Mux.scala 47:70]
  wire [7:0] _tzd_adder_f64_reg1_T_516 = _tzd_adder_f64_reg1_T_188[1] ? 8'h1 : _tzd_adder_f64_reg1_T_515; // @[Mux.scala 47:70]
  wire [7:0] tzd_adder_f64_reg1 = _tzd_adder_f64_reg1_T_188[0] ? 8'h0 : _tzd_adder_f64_reg1_T_516; // @[Mux.scala 47:70]
  wire [162:0] lzd_adder_inv_mask_f64_reg_d = adder_inv_f64 | lshift_value_mask_f64; // @[FloatFMA.scala 424:52]
  reg [162:0] lzd_adder_inv_mask_reg1; // @[Reg.scala 19:16]
  wire [163:0] _lzd_adder_inv_mask_f64_T = {lzd_adder_inv_mask_reg1,1'h1}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_247 = {{32'd0}, _lzd_adder_inv_mask_f64_T[63:32]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_6 = _GEN_247 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_8 = {_lzd_adder_inv_mask_f64_T[31:0], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_10 = _lzd_adder_inv_mask_f64_T_8 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_11 = _lzd_adder_inv_mask_f64_T_6 | _lzd_adder_inv_mask_f64_T_10; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_248 = {{16'd0}, _lzd_adder_inv_mask_f64_T_11[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_16 = _GEN_248 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_18 = {_lzd_adder_inv_mask_f64_T_11[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_20 = _lzd_adder_inv_mask_f64_T_18 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_21 = _lzd_adder_inv_mask_f64_T_16 | _lzd_adder_inv_mask_f64_T_20; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_249 = {{8'd0}, _lzd_adder_inv_mask_f64_T_21[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_26 = _GEN_249 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_28 = {_lzd_adder_inv_mask_f64_T_21[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_30 = _lzd_adder_inv_mask_f64_T_28 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_31 = _lzd_adder_inv_mask_f64_T_26 | _lzd_adder_inv_mask_f64_T_30; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_250 = {{4'd0}, _lzd_adder_inv_mask_f64_T_31[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_36 = _GEN_250 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_38 = {_lzd_adder_inv_mask_f64_T_31[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_40 = _lzd_adder_inv_mask_f64_T_38 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_41 = _lzd_adder_inv_mask_f64_T_36 | _lzd_adder_inv_mask_f64_T_40; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_251 = {{2'd0}, _lzd_adder_inv_mask_f64_T_41[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_46 = _GEN_251 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_48 = {_lzd_adder_inv_mask_f64_T_41[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_50 = _lzd_adder_inv_mask_f64_T_48 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_51 = _lzd_adder_inv_mask_f64_T_46 | _lzd_adder_inv_mask_f64_T_50; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_252 = {{1'd0}, _lzd_adder_inv_mask_f64_T_51[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_56 = _GEN_252 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_58 = {_lzd_adder_inv_mask_f64_T_51[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_60 = _lzd_adder_inv_mask_f64_T_58 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_61 = _lzd_adder_inv_mask_f64_T_56 | _lzd_adder_inv_mask_f64_T_60; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_253 = {{32'd0}, _lzd_adder_inv_mask_f64_T[127:96]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_66 = _GEN_253 & 64'hffffffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_68 = {_lzd_adder_inv_mask_f64_T[95:64], 32'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_70 = _lzd_adder_inv_mask_f64_T_68 & 64'hffffffff00000000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_71 = _lzd_adder_inv_mask_f64_T_66 | _lzd_adder_inv_mask_f64_T_70; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_254 = {{16'd0}, _lzd_adder_inv_mask_f64_T_71[63:16]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_76 = _GEN_254 & 64'hffff0000ffff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_78 = {_lzd_adder_inv_mask_f64_T_71[47:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_80 = _lzd_adder_inv_mask_f64_T_78 & 64'hffff0000ffff0000; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_81 = _lzd_adder_inv_mask_f64_T_76 | _lzd_adder_inv_mask_f64_T_80; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_255 = {{8'd0}, _lzd_adder_inv_mask_f64_T_81[63:8]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_86 = _GEN_255 & 64'hff00ff00ff00ff; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_88 = {_lzd_adder_inv_mask_f64_T_81[55:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_90 = _lzd_adder_inv_mask_f64_T_88 & 64'hff00ff00ff00ff00; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_91 = _lzd_adder_inv_mask_f64_T_86 | _lzd_adder_inv_mask_f64_T_90; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_256 = {{4'd0}, _lzd_adder_inv_mask_f64_T_91[63:4]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_96 = _GEN_256 & 64'hf0f0f0f0f0f0f0f; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_98 = {_lzd_adder_inv_mask_f64_T_91[59:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_100 = _lzd_adder_inv_mask_f64_T_98 & 64'hf0f0f0f0f0f0f0f0; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_101 = _lzd_adder_inv_mask_f64_T_96 | _lzd_adder_inv_mask_f64_T_100; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_257 = {{2'd0}, _lzd_adder_inv_mask_f64_T_101[63:2]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_106 = _GEN_257 & 64'h3333333333333333; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_108 = {_lzd_adder_inv_mask_f64_T_101[61:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_110 = _lzd_adder_inv_mask_f64_T_108 & 64'hcccccccccccccccc; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_111 = _lzd_adder_inv_mask_f64_T_106 | _lzd_adder_inv_mask_f64_T_110; // @[Bitwise.scala 108:39]
  wire [63:0] _GEN_258 = {{1'd0}, _lzd_adder_inv_mask_f64_T_111[63:1]}; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_116 = _GEN_258 & 64'h5555555555555555; // @[Bitwise.scala 108:31]
  wire [63:0] _lzd_adder_inv_mask_f64_T_118 = {_lzd_adder_inv_mask_f64_T_111[62:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [63:0] _lzd_adder_inv_mask_f64_T_120 = _lzd_adder_inv_mask_f64_T_118 & 64'haaaaaaaaaaaaaaaa; // @[Bitwise.scala 108:80]
  wire [63:0] _lzd_adder_inv_mask_f64_T_121 = _lzd_adder_inv_mask_f64_T_116 | _lzd_adder_inv_mask_f64_T_120; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_259 = {{16'd0}, _lzd_adder_inv_mask_f64_T[159:144]}; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_128 = _GEN_259 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_130 = {_lzd_adder_inv_mask_f64_T[143:128], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _lzd_adder_inv_mask_f64_T_132 = _lzd_adder_inv_mask_f64_T_130 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _lzd_adder_inv_mask_f64_T_133 = _lzd_adder_inv_mask_f64_T_128 | _lzd_adder_inv_mask_f64_T_132; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_260 = {{8'd0}, _lzd_adder_inv_mask_f64_T_133[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_138 = _GEN_260 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_140 = {_lzd_adder_inv_mask_f64_T_133[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _lzd_adder_inv_mask_f64_T_142 = _lzd_adder_inv_mask_f64_T_140 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _lzd_adder_inv_mask_f64_T_143 = _lzd_adder_inv_mask_f64_T_138 | _lzd_adder_inv_mask_f64_T_142; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_261 = {{4'd0}, _lzd_adder_inv_mask_f64_T_143[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_148 = _GEN_261 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_150 = {_lzd_adder_inv_mask_f64_T_143[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _lzd_adder_inv_mask_f64_T_152 = _lzd_adder_inv_mask_f64_T_150 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _lzd_adder_inv_mask_f64_T_153 = _lzd_adder_inv_mask_f64_T_148 | _lzd_adder_inv_mask_f64_T_152; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_262 = {{2'd0}, _lzd_adder_inv_mask_f64_T_153[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_158 = _GEN_262 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_160 = {_lzd_adder_inv_mask_f64_T_153[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _lzd_adder_inv_mask_f64_T_162 = _lzd_adder_inv_mask_f64_T_160 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _lzd_adder_inv_mask_f64_T_163 = _lzd_adder_inv_mask_f64_T_158 | _lzd_adder_inv_mask_f64_T_162; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_263 = {{1'd0}, _lzd_adder_inv_mask_f64_T_163[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_168 = _GEN_263 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _lzd_adder_inv_mask_f64_T_170 = {_lzd_adder_inv_mask_f64_T_163[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _lzd_adder_inv_mask_f64_T_172 = _lzd_adder_inv_mask_f64_T_170 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _lzd_adder_inv_mask_f64_T_173 = _lzd_adder_inv_mask_f64_T_168 | _lzd_adder_inv_mask_f64_T_172; // @[Bitwise.scala 108:39]
  wire [163:0] _lzd_adder_inv_mask_f64_T_185 = {_lzd_adder_inv_mask_f64_T_61,_lzd_adder_inv_mask_f64_T_121,
    _lzd_adder_inv_mask_f64_T_173,_lzd_adder_inv_mask_f64_T[160],_lzd_adder_inv_mask_f64_T[161],
    _lzd_adder_inv_mask_f64_T[162],_lzd_adder_inv_mask_f64_T[163]}; // @[Cat.scala 33:92]
  wire [7:0] _lzd_adder_inv_mask_f64_T_350 = _lzd_adder_inv_mask_f64_T_185[162] ? 8'ha2 : 8'ha3; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_351 = _lzd_adder_inv_mask_f64_T_185[161] ? 8'ha1 : _lzd_adder_inv_mask_f64_T_350; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_352 = _lzd_adder_inv_mask_f64_T_185[160] ? 8'ha0 : _lzd_adder_inv_mask_f64_T_351; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_353 = _lzd_adder_inv_mask_f64_T_185[159] ? 8'h9f : _lzd_adder_inv_mask_f64_T_352; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_354 = _lzd_adder_inv_mask_f64_T_185[158] ? 8'h9e : _lzd_adder_inv_mask_f64_T_353; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_355 = _lzd_adder_inv_mask_f64_T_185[157] ? 8'h9d : _lzd_adder_inv_mask_f64_T_354; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_356 = _lzd_adder_inv_mask_f64_T_185[156] ? 8'h9c : _lzd_adder_inv_mask_f64_T_355; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_357 = _lzd_adder_inv_mask_f64_T_185[155] ? 8'h9b : _lzd_adder_inv_mask_f64_T_356; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_358 = _lzd_adder_inv_mask_f64_T_185[154] ? 8'h9a : _lzd_adder_inv_mask_f64_T_357; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_359 = _lzd_adder_inv_mask_f64_T_185[153] ? 8'h99 : _lzd_adder_inv_mask_f64_T_358; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_360 = _lzd_adder_inv_mask_f64_T_185[152] ? 8'h98 : _lzd_adder_inv_mask_f64_T_359; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_361 = _lzd_adder_inv_mask_f64_T_185[151] ? 8'h97 : _lzd_adder_inv_mask_f64_T_360; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_362 = _lzd_adder_inv_mask_f64_T_185[150] ? 8'h96 : _lzd_adder_inv_mask_f64_T_361; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_363 = _lzd_adder_inv_mask_f64_T_185[149] ? 8'h95 : _lzd_adder_inv_mask_f64_T_362; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_364 = _lzd_adder_inv_mask_f64_T_185[148] ? 8'h94 : _lzd_adder_inv_mask_f64_T_363; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_365 = _lzd_adder_inv_mask_f64_T_185[147] ? 8'h93 : _lzd_adder_inv_mask_f64_T_364; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_366 = _lzd_adder_inv_mask_f64_T_185[146] ? 8'h92 : _lzd_adder_inv_mask_f64_T_365; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_367 = _lzd_adder_inv_mask_f64_T_185[145] ? 8'h91 : _lzd_adder_inv_mask_f64_T_366; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_368 = _lzd_adder_inv_mask_f64_T_185[144] ? 8'h90 : _lzd_adder_inv_mask_f64_T_367; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_369 = _lzd_adder_inv_mask_f64_T_185[143] ? 8'h8f : _lzd_adder_inv_mask_f64_T_368; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_370 = _lzd_adder_inv_mask_f64_T_185[142] ? 8'h8e : _lzd_adder_inv_mask_f64_T_369; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_371 = _lzd_adder_inv_mask_f64_T_185[141] ? 8'h8d : _lzd_adder_inv_mask_f64_T_370; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_372 = _lzd_adder_inv_mask_f64_T_185[140] ? 8'h8c : _lzd_adder_inv_mask_f64_T_371; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_373 = _lzd_adder_inv_mask_f64_T_185[139] ? 8'h8b : _lzd_adder_inv_mask_f64_T_372; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_374 = _lzd_adder_inv_mask_f64_T_185[138] ? 8'h8a : _lzd_adder_inv_mask_f64_T_373; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_375 = _lzd_adder_inv_mask_f64_T_185[137] ? 8'h89 : _lzd_adder_inv_mask_f64_T_374; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_376 = _lzd_adder_inv_mask_f64_T_185[136] ? 8'h88 : _lzd_adder_inv_mask_f64_T_375; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_377 = _lzd_adder_inv_mask_f64_T_185[135] ? 8'h87 : _lzd_adder_inv_mask_f64_T_376; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_378 = _lzd_adder_inv_mask_f64_T_185[134] ? 8'h86 : _lzd_adder_inv_mask_f64_T_377; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_379 = _lzd_adder_inv_mask_f64_T_185[133] ? 8'h85 : _lzd_adder_inv_mask_f64_T_378; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_380 = _lzd_adder_inv_mask_f64_T_185[132] ? 8'h84 : _lzd_adder_inv_mask_f64_T_379; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_381 = _lzd_adder_inv_mask_f64_T_185[131] ? 8'h83 : _lzd_adder_inv_mask_f64_T_380; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_382 = _lzd_adder_inv_mask_f64_T_185[130] ? 8'h82 : _lzd_adder_inv_mask_f64_T_381; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_383 = _lzd_adder_inv_mask_f64_T_185[129] ? 8'h81 : _lzd_adder_inv_mask_f64_T_382; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_384 = _lzd_adder_inv_mask_f64_T_185[128] ? 8'h80 : _lzd_adder_inv_mask_f64_T_383; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_385 = _lzd_adder_inv_mask_f64_T_185[127] ? 8'h7f : _lzd_adder_inv_mask_f64_T_384; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_386 = _lzd_adder_inv_mask_f64_T_185[126] ? 8'h7e : _lzd_adder_inv_mask_f64_T_385; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_387 = _lzd_adder_inv_mask_f64_T_185[125] ? 8'h7d : _lzd_adder_inv_mask_f64_T_386; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_388 = _lzd_adder_inv_mask_f64_T_185[124] ? 8'h7c : _lzd_adder_inv_mask_f64_T_387; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_389 = _lzd_adder_inv_mask_f64_T_185[123] ? 8'h7b : _lzd_adder_inv_mask_f64_T_388; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_390 = _lzd_adder_inv_mask_f64_T_185[122] ? 8'h7a : _lzd_adder_inv_mask_f64_T_389; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_391 = _lzd_adder_inv_mask_f64_T_185[121] ? 8'h79 : _lzd_adder_inv_mask_f64_T_390; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_392 = _lzd_adder_inv_mask_f64_T_185[120] ? 8'h78 : _lzd_adder_inv_mask_f64_T_391; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_393 = _lzd_adder_inv_mask_f64_T_185[119] ? 8'h77 : _lzd_adder_inv_mask_f64_T_392; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_394 = _lzd_adder_inv_mask_f64_T_185[118] ? 8'h76 : _lzd_adder_inv_mask_f64_T_393; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_395 = _lzd_adder_inv_mask_f64_T_185[117] ? 8'h75 : _lzd_adder_inv_mask_f64_T_394; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_396 = _lzd_adder_inv_mask_f64_T_185[116] ? 8'h74 : _lzd_adder_inv_mask_f64_T_395; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_397 = _lzd_adder_inv_mask_f64_T_185[115] ? 8'h73 : _lzd_adder_inv_mask_f64_T_396; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_398 = _lzd_adder_inv_mask_f64_T_185[114] ? 8'h72 : _lzd_adder_inv_mask_f64_T_397; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_399 = _lzd_adder_inv_mask_f64_T_185[113] ? 8'h71 : _lzd_adder_inv_mask_f64_T_398; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_400 = _lzd_adder_inv_mask_f64_T_185[112] ? 8'h70 : _lzd_adder_inv_mask_f64_T_399; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_401 = _lzd_adder_inv_mask_f64_T_185[111] ? 8'h6f : _lzd_adder_inv_mask_f64_T_400; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_402 = _lzd_adder_inv_mask_f64_T_185[110] ? 8'h6e : _lzd_adder_inv_mask_f64_T_401; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_403 = _lzd_adder_inv_mask_f64_T_185[109] ? 8'h6d : _lzd_adder_inv_mask_f64_T_402; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_404 = _lzd_adder_inv_mask_f64_T_185[108] ? 8'h6c : _lzd_adder_inv_mask_f64_T_403; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_405 = _lzd_adder_inv_mask_f64_T_185[107] ? 8'h6b : _lzd_adder_inv_mask_f64_T_404; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_406 = _lzd_adder_inv_mask_f64_T_185[106] ? 8'h6a : _lzd_adder_inv_mask_f64_T_405; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_407 = _lzd_adder_inv_mask_f64_T_185[105] ? 8'h69 : _lzd_adder_inv_mask_f64_T_406; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_408 = _lzd_adder_inv_mask_f64_T_185[104] ? 8'h68 : _lzd_adder_inv_mask_f64_T_407; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_409 = _lzd_adder_inv_mask_f64_T_185[103] ? 8'h67 : _lzd_adder_inv_mask_f64_T_408; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_410 = _lzd_adder_inv_mask_f64_T_185[102] ? 8'h66 : _lzd_adder_inv_mask_f64_T_409; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_411 = _lzd_adder_inv_mask_f64_T_185[101] ? 8'h65 : _lzd_adder_inv_mask_f64_T_410; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_412 = _lzd_adder_inv_mask_f64_T_185[100] ? 8'h64 : _lzd_adder_inv_mask_f64_T_411; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_413 = _lzd_adder_inv_mask_f64_T_185[99] ? 8'h63 : _lzd_adder_inv_mask_f64_T_412; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_414 = _lzd_adder_inv_mask_f64_T_185[98] ? 8'h62 : _lzd_adder_inv_mask_f64_T_413; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_415 = _lzd_adder_inv_mask_f64_T_185[97] ? 8'h61 : _lzd_adder_inv_mask_f64_T_414; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_416 = _lzd_adder_inv_mask_f64_T_185[96] ? 8'h60 : _lzd_adder_inv_mask_f64_T_415; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_417 = _lzd_adder_inv_mask_f64_T_185[95] ? 8'h5f : _lzd_adder_inv_mask_f64_T_416; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_418 = _lzd_adder_inv_mask_f64_T_185[94] ? 8'h5e : _lzd_adder_inv_mask_f64_T_417; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_419 = _lzd_adder_inv_mask_f64_T_185[93] ? 8'h5d : _lzd_adder_inv_mask_f64_T_418; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_420 = _lzd_adder_inv_mask_f64_T_185[92] ? 8'h5c : _lzd_adder_inv_mask_f64_T_419; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_421 = _lzd_adder_inv_mask_f64_T_185[91] ? 8'h5b : _lzd_adder_inv_mask_f64_T_420; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_422 = _lzd_adder_inv_mask_f64_T_185[90] ? 8'h5a : _lzd_adder_inv_mask_f64_T_421; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_423 = _lzd_adder_inv_mask_f64_T_185[89] ? 8'h59 : _lzd_adder_inv_mask_f64_T_422; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_424 = _lzd_adder_inv_mask_f64_T_185[88] ? 8'h58 : _lzd_adder_inv_mask_f64_T_423; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_425 = _lzd_adder_inv_mask_f64_T_185[87] ? 8'h57 : _lzd_adder_inv_mask_f64_T_424; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_426 = _lzd_adder_inv_mask_f64_T_185[86] ? 8'h56 : _lzd_adder_inv_mask_f64_T_425; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_427 = _lzd_adder_inv_mask_f64_T_185[85] ? 8'h55 : _lzd_adder_inv_mask_f64_T_426; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_428 = _lzd_adder_inv_mask_f64_T_185[84] ? 8'h54 : _lzd_adder_inv_mask_f64_T_427; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_429 = _lzd_adder_inv_mask_f64_T_185[83] ? 8'h53 : _lzd_adder_inv_mask_f64_T_428; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_430 = _lzd_adder_inv_mask_f64_T_185[82] ? 8'h52 : _lzd_adder_inv_mask_f64_T_429; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_431 = _lzd_adder_inv_mask_f64_T_185[81] ? 8'h51 : _lzd_adder_inv_mask_f64_T_430; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_432 = _lzd_adder_inv_mask_f64_T_185[80] ? 8'h50 : _lzd_adder_inv_mask_f64_T_431; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_433 = _lzd_adder_inv_mask_f64_T_185[79] ? 8'h4f : _lzd_adder_inv_mask_f64_T_432; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_434 = _lzd_adder_inv_mask_f64_T_185[78] ? 8'h4e : _lzd_adder_inv_mask_f64_T_433; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_435 = _lzd_adder_inv_mask_f64_T_185[77] ? 8'h4d : _lzd_adder_inv_mask_f64_T_434; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_436 = _lzd_adder_inv_mask_f64_T_185[76] ? 8'h4c : _lzd_adder_inv_mask_f64_T_435; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_437 = _lzd_adder_inv_mask_f64_T_185[75] ? 8'h4b : _lzd_adder_inv_mask_f64_T_436; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_438 = _lzd_adder_inv_mask_f64_T_185[74] ? 8'h4a : _lzd_adder_inv_mask_f64_T_437; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_439 = _lzd_adder_inv_mask_f64_T_185[73] ? 8'h49 : _lzd_adder_inv_mask_f64_T_438; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_440 = _lzd_adder_inv_mask_f64_T_185[72] ? 8'h48 : _lzd_adder_inv_mask_f64_T_439; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_441 = _lzd_adder_inv_mask_f64_T_185[71] ? 8'h47 : _lzd_adder_inv_mask_f64_T_440; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_442 = _lzd_adder_inv_mask_f64_T_185[70] ? 8'h46 : _lzd_adder_inv_mask_f64_T_441; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_443 = _lzd_adder_inv_mask_f64_T_185[69] ? 8'h45 : _lzd_adder_inv_mask_f64_T_442; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_444 = _lzd_adder_inv_mask_f64_T_185[68] ? 8'h44 : _lzd_adder_inv_mask_f64_T_443; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_445 = _lzd_adder_inv_mask_f64_T_185[67] ? 8'h43 : _lzd_adder_inv_mask_f64_T_444; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_446 = _lzd_adder_inv_mask_f64_T_185[66] ? 8'h42 : _lzd_adder_inv_mask_f64_T_445; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_447 = _lzd_adder_inv_mask_f64_T_185[65] ? 8'h41 : _lzd_adder_inv_mask_f64_T_446; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_448 = _lzd_adder_inv_mask_f64_T_185[64] ? 8'h40 : _lzd_adder_inv_mask_f64_T_447; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_449 = _lzd_adder_inv_mask_f64_T_185[63] ? 8'h3f : _lzd_adder_inv_mask_f64_T_448; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_450 = _lzd_adder_inv_mask_f64_T_185[62] ? 8'h3e : _lzd_adder_inv_mask_f64_T_449; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_451 = _lzd_adder_inv_mask_f64_T_185[61] ? 8'h3d : _lzd_adder_inv_mask_f64_T_450; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_452 = _lzd_adder_inv_mask_f64_T_185[60] ? 8'h3c : _lzd_adder_inv_mask_f64_T_451; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_453 = _lzd_adder_inv_mask_f64_T_185[59] ? 8'h3b : _lzd_adder_inv_mask_f64_T_452; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_454 = _lzd_adder_inv_mask_f64_T_185[58] ? 8'h3a : _lzd_adder_inv_mask_f64_T_453; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_455 = _lzd_adder_inv_mask_f64_T_185[57] ? 8'h39 : _lzd_adder_inv_mask_f64_T_454; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_456 = _lzd_adder_inv_mask_f64_T_185[56] ? 8'h38 : _lzd_adder_inv_mask_f64_T_455; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_457 = _lzd_adder_inv_mask_f64_T_185[55] ? 8'h37 : _lzd_adder_inv_mask_f64_T_456; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_458 = _lzd_adder_inv_mask_f64_T_185[54] ? 8'h36 : _lzd_adder_inv_mask_f64_T_457; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_459 = _lzd_adder_inv_mask_f64_T_185[53] ? 8'h35 : _lzd_adder_inv_mask_f64_T_458; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_460 = _lzd_adder_inv_mask_f64_T_185[52] ? 8'h34 : _lzd_adder_inv_mask_f64_T_459; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_461 = _lzd_adder_inv_mask_f64_T_185[51] ? 8'h33 : _lzd_adder_inv_mask_f64_T_460; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_462 = _lzd_adder_inv_mask_f64_T_185[50] ? 8'h32 : _lzd_adder_inv_mask_f64_T_461; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_463 = _lzd_adder_inv_mask_f64_T_185[49] ? 8'h31 : _lzd_adder_inv_mask_f64_T_462; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_464 = _lzd_adder_inv_mask_f64_T_185[48] ? 8'h30 : _lzd_adder_inv_mask_f64_T_463; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_465 = _lzd_adder_inv_mask_f64_T_185[47] ? 8'h2f : _lzd_adder_inv_mask_f64_T_464; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_466 = _lzd_adder_inv_mask_f64_T_185[46] ? 8'h2e : _lzd_adder_inv_mask_f64_T_465; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_467 = _lzd_adder_inv_mask_f64_T_185[45] ? 8'h2d : _lzd_adder_inv_mask_f64_T_466; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_468 = _lzd_adder_inv_mask_f64_T_185[44] ? 8'h2c : _lzd_adder_inv_mask_f64_T_467; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_469 = _lzd_adder_inv_mask_f64_T_185[43] ? 8'h2b : _lzd_adder_inv_mask_f64_T_468; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_470 = _lzd_adder_inv_mask_f64_T_185[42] ? 8'h2a : _lzd_adder_inv_mask_f64_T_469; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_471 = _lzd_adder_inv_mask_f64_T_185[41] ? 8'h29 : _lzd_adder_inv_mask_f64_T_470; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_472 = _lzd_adder_inv_mask_f64_T_185[40] ? 8'h28 : _lzd_adder_inv_mask_f64_T_471; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_473 = _lzd_adder_inv_mask_f64_T_185[39] ? 8'h27 : _lzd_adder_inv_mask_f64_T_472; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_474 = _lzd_adder_inv_mask_f64_T_185[38] ? 8'h26 : _lzd_adder_inv_mask_f64_T_473; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_475 = _lzd_adder_inv_mask_f64_T_185[37] ? 8'h25 : _lzd_adder_inv_mask_f64_T_474; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_476 = _lzd_adder_inv_mask_f64_T_185[36] ? 8'h24 : _lzd_adder_inv_mask_f64_T_475; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_477 = _lzd_adder_inv_mask_f64_T_185[35] ? 8'h23 : _lzd_adder_inv_mask_f64_T_476; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_478 = _lzd_adder_inv_mask_f64_T_185[34] ? 8'h22 : _lzd_adder_inv_mask_f64_T_477; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_479 = _lzd_adder_inv_mask_f64_T_185[33] ? 8'h21 : _lzd_adder_inv_mask_f64_T_478; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_480 = _lzd_adder_inv_mask_f64_T_185[32] ? 8'h20 : _lzd_adder_inv_mask_f64_T_479; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_481 = _lzd_adder_inv_mask_f64_T_185[31] ? 8'h1f : _lzd_adder_inv_mask_f64_T_480; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_482 = _lzd_adder_inv_mask_f64_T_185[30] ? 8'h1e : _lzd_adder_inv_mask_f64_T_481; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_483 = _lzd_adder_inv_mask_f64_T_185[29] ? 8'h1d : _lzd_adder_inv_mask_f64_T_482; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_484 = _lzd_adder_inv_mask_f64_T_185[28] ? 8'h1c : _lzd_adder_inv_mask_f64_T_483; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_485 = _lzd_adder_inv_mask_f64_T_185[27] ? 8'h1b : _lzd_adder_inv_mask_f64_T_484; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_486 = _lzd_adder_inv_mask_f64_T_185[26] ? 8'h1a : _lzd_adder_inv_mask_f64_T_485; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_487 = _lzd_adder_inv_mask_f64_T_185[25] ? 8'h19 : _lzd_adder_inv_mask_f64_T_486; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_488 = _lzd_adder_inv_mask_f64_T_185[24] ? 8'h18 : _lzd_adder_inv_mask_f64_T_487; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_489 = _lzd_adder_inv_mask_f64_T_185[23] ? 8'h17 : _lzd_adder_inv_mask_f64_T_488; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_490 = _lzd_adder_inv_mask_f64_T_185[22] ? 8'h16 : _lzd_adder_inv_mask_f64_T_489; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_491 = _lzd_adder_inv_mask_f64_T_185[21] ? 8'h15 : _lzd_adder_inv_mask_f64_T_490; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_492 = _lzd_adder_inv_mask_f64_T_185[20] ? 8'h14 : _lzd_adder_inv_mask_f64_T_491; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_493 = _lzd_adder_inv_mask_f64_T_185[19] ? 8'h13 : _lzd_adder_inv_mask_f64_T_492; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_494 = _lzd_adder_inv_mask_f64_T_185[18] ? 8'h12 : _lzd_adder_inv_mask_f64_T_493; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_495 = _lzd_adder_inv_mask_f64_T_185[17] ? 8'h11 : _lzd_adder_inv_mask_f64_T_494; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_496 = _lzd_adder_inv_mask_f64_T_185[16] ? 8'h10 : _lzd_adder_inv_mask_f64_T_495; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_497 = _lzd_adder_inv_mask_f64_T_185[15] ? 8'hf : _lzd_adder_inv_mask_f64_T_496; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_498 = _lzd_adder_inv_mask_f64_T_185[14] ? 8'he : _lzd_adder_inv_mask_f64_T_497; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_499 = _lzd_adder_inv_mask_f64_T_185[13] ? 8'hd : _lzd_adder_inv_mask_f64_T_498; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_500 = _lzd_adder_inv_mask_f64_T_185[12] ? 8'hc : _lzd_adder_inv_mask_f64_T_499; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_501 = _lzd_adder_inv_mask_f64_T_185[11] ? 8'hb : _lzd_adder_inv_mask_f64_T_500; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_502 = _lzd_adder_inv_mask_f64_T_185[10] ? 8'ha : _lzd_adder_inv_mask_f64_T_501; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_503 = _lzd_adder_inv_mask_f64_T_185[9] ? 8'h9 : _lzd_adder_inv_mask_f64_T_502; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_504 = _lzd_adder_inv_mask_f64_T_185[8] ? 8'h8 : _lzd_adder_inv_mask_f64_T_503; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_505 = _lzd_adder_inv_mask_f64_T_185[7] ? 8'h7 : _lzd_adder_inv_mask_f64_T_504; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_506 = _lzd_adder_inv_mask_f64_T_185[6] ? 8'h6 : _lzd_adder_inv_mask_f64_T_505; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_507 = _lzd_adder_inv_mask_f64_T_185[5] ? 8'h5 : _lzd_adder_inv_mask_f64_T_506; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_508 = _lzd_adder_inv_mask_f64_T_185[4] ? 8'h4 : _lzd_adder_inv_mask_f64_T_507; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_509 = _lzd_adder_inv_mask_f64_T_185[3] ? 8'h3 : _lzd_adder_inv_mask_f64_T_508; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_510 = _lzd_adder_inv_mask_f64_T_185[2] ? 8'h2 : _lzd_adder_inv_mask_f64_T_509; // @[Mux.scala 47:70]
  wire [7:0] _lzd_adder_inv_mask_f64_T_511 = _lzd_adder_inv_mask_f64_T_185[1] ? 8'h1 : _lzd_adder_inv_mask_f64_T_510; // @[Mux.scala 47:70]
  wire [7:0] lzd_adder_inv_mask_f64 = _lzd_adder_inv_mask_f64_T_185[0] ? 8'h0 : _lzd_adder_inv_mask_f64_T_511; // @[Mux.scala 47:70]
  wire  lshift_mask_valid_f64_reg_d = lzd_adder_inv_mask_f64_reg_d == lshift_value_mask_f64; // @[FloatFMA.scala 442:77]
  reg  lshift_mask_valid_f16_reg1; // @[Reg.scala 19:16]
  reg [163:0] adder_f64_reg1; // @[Reg.scala 19:16]
  wire [291:0] _lshift_adder_f64_res_vec_1_T_1 = {adder_f64_reg1, 128'h0}; // @[FloatFMA.scala 33:75]
  wire [291:0] _lshift_adder_f64_res_vec_1_T_2 = lzd_adder_inv_mask_f64[7] ? _lshift_adder_f64_res_vec_1_T_1 : {{128
    'd0}, adder_f64_reg1}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_1 = _lshift_adder_f64_res_vec_1_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [227:0] _lshift_adder_f64_res_vec_2_T_1 = {lshift_adder_f64_res_vec_1, 64'h0}; // @[FloatFMA.scala 33:75]
  wire [227:0] _lshift_adder_f64_res_vec_2_T_2 = lzd_adder_inv_mask_f64[6] ? _lshift_adder_f64_res_vec_2_T_1 : {{64
    'd0}, lshift_adder_f64_res_vec_1}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_2 = _lshift_adder_f64_res_vec_2_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [195:0] _lshift_adder_f64_res_vec_3_T_1 = {lshift_adder_f64_res_vec_2, 32'h0}; // @[FloatFMA.scala 33:75]
  wire [195:0] _lshift_adder_f64_res_vec_3_T_2 = lzd_adder_inv_mask_f64[5] ? _lshift_adder_f64_res_vec_3_T_1 : {{32
    'd0}, lshift_adder_f64_res_vec_2}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_3 = _lshift_adder_f64_res_vec_3_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [179:0] _lshift_adder_f64_res_vec_4_T_1 = {lshift_adder_f64_res_vec_3, 16'h0}; // @[FloatFMA.scala 33:75]
  wire [179:0] _lshift_adder_f64_res_vec_4_T_2 = lzd_adder_inv_mask_f64[4] ? _lshift_adder_f64_res_vec_4_T_1 : {{16
    'd0}, lshift_adder_f64_res_vec_3}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_4 = _lshift_adder_f64_res_vec_4_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [171:0] _lshift_adder_f64_res_vec_5_T_1 = {lshift_adder_f64_res_vec_4, 8'h0}; // @[FloatFMA.scala 33:75]
  wire [171:0] _lshift_adder_f64_res_vec_5_T_2 = lzd_adder_inv_mask_f64[3] ? _lshift_adder_f64_res_vec_5_T_1 : {{8'd0},
    lshift_adder_f64_res_vec_4}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_5 = _lshift_adder_f64_res_vec_5_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [167:0] _lshift_adder_f64_res_vec_6_T_1 = {lshift_adder_f64_res_vec_5, 4'h0}; // @[FloatFMA.scala 33:75]
  wire [167:0] _lshift_adder_f64_res_vec_6_T_2 = lzd_adder_inv_mask_f64[2] ? _lshift_adder_f64_res_vec_6_T_1 : {{4'd0},
    lshift_adder_f64_res_vec_5}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_6 = _lshift_adder_f64_res_vec_6_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [165:0] _lshift_adder_f64_res_vec_7_T_1 = {lshift_adder_f64_res_vec_6, 2'h0}; // @[FloatFMA.scala 33:75]
  wire [165:0] _lshift_adder_f64_res_vec_7_T_2 = lzd_adder_inv_mask_f64[1] ? _lshift_adder_f64_res_vec_7_T_1 : {{2'd0},
    lshift_adder_f64_res_vec_6}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_7 = _lshift_adder_f64_res_vec_7_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [164:0] _lshift_adder_f64_res_vec_8_T_1 = {lshift_adder_f64_res_vec_7, 1'h0}; // @[FloatFMA.scala 33:75]
  wire [164:0] _lshift_adder_f64_res_vec_8_T_2 = lzd_adder_inv_mask_f64[0] ? _lshift_adder_f64_res_vec_8_T_1 : {{1'd0},
    lshift_adder_f64_res_vec_7}; // @[FloatFMA.scala 33:26]
  wire [163:0] lshift_adder_f64_res_vec_8 = _lshift_adder_f64_res_vec_8_T_2[163:0]; // @[FloatFMA.scala 30:26 33:20]
  wire [56:0] _lshift_adder_inv_f64_T_1 = ~lshift_adder_f64_res_vec_8[163:107]; // @[FloatFMA.scala 468:64]
  wire [56:0] _lshift_adder_inv_f64_T_3 = adder_is_negative_reg1 ? _lshift_adder_inv_f64_T_1 :
    lshift_adder_f64_res_vec_8[163:107]; // @[FloatFMA.scala 468:40]
  wire [163:0] lshift_adder_inv_f64 = {_lshift_adder_inv_f64_T_3,lshift_adder_f64_res_vec_8[106:0]}; // @[Cat.scala 33:92]
  wire [7:0] _is_fix_f64_T_1 = tzd_adder_f64_reg1 + lzd_adder_inv_mask_f64; // @[FloatFMA.scala 472:40]
  wire  is_fix_f64 = _is_fix_f64_T_1 == 8'ha3; // @[FloatFMA.scala 472:71]
  wire [162:0] lshift_adder_inv_fix_f64 = is_fix_f64 ? lshift_adder_inv_f64[163:1] : lshift_adder_inv_f64[162:0]; // @[FloatFMA.scala 476:37]
  wire [51:0] fraction_result_no_round_f64_reg_d = lshift_adder_inv_fix_f64[161:110]; // @[FloatFMA.scala 481:81]
  reg [51:0] fraction_result_no_round_f64_reg2; // @[Reg.scala 19:16]
  reg  sign_result_temp_f64_reg2_r; // @[Reg.scala 19:16]
  reg  sign_result_temp_f64_reg2_r_1; // @[Reg.scala 19:16]
  reg  sign_result_temp_f64_reg2_r_2; // @[Reg.scala 19:16]
  reg  sign_result_temp_f64_reg2; // @[Reg.scala 19:16]
  reg  sticky_f64_reg2_r; // @[Reg.scala 19:16]
  wire [7:0] _sticky_f64_reg2_T_1 = lzd_adder_inv_mask_f64 + tzd_adder_f64_reg1; // @[FloatFMA.scala 513:107]
  wire  _sticky_f64_reg2_T_3 = sticky_f64_reg2_r | _sticky_f64_reg2_T_1 < 8'h6c; // @[FloatFMA.scala 513:76]
  reg  sticky_f64_reg2; // @[Reg.scala 19:16]
  reg  sticky_uf_f64_reg2_r; // @[Reg.scala 19:16]
  wire  _sticky_uf_f64_reg2_T_3 = sticky_uf_f64_reg2_r | _sticky_f64_reg2_T_1 < 8'h6b; // @[FloatFMA.scala 517:79]
  reg  sticky_uf_f64_reg2; // @[Reg.scala 19:16]
  reg  round_lshift_f64_reg2; // @[Reg.scala 19:16]
  reg  guard_lshift_f64_reg2; // @[Reg.scala 19:16]
  wire  _round_f64_T = ~sticky_f64_reg2; // @[FloatFMA.scala 530:77]
  wire  guard_uf_f64 = adder_is_negative_f16_reg2 ? round_lshift_f64_reg2 ^ ~sticky_f64_reg2 : round_lshift_f64_reg2; // @[FloatFMA.scala 530:24]
  wire  guard_f64 = adder_is_negative_f16_reg2 ? guard_lshift_f64_reg2 ^ _round_f64_T & round_lshift_f64_reg2 :
    guard_lshift_f64_reg2; // @[FloatFMA.scala 534:26]
  reg  round_lshift_uf_f64_reg2; // @[Reg.scala 19:16]
  wire  round_uf_f64 = adder_is_negative_f16_reg2 ? round_lshift_uf_f64_reg2 ^ ~sticky_uf_f64_reg2 :
    round_lshift_uf_f64_reg2; // @[FloatFMA.scala 546:27]
  wire  _round_add1_f64_T_3 = guard_f64 & (fraction_result_no_round_f64_reg2[0] | guard_uf_f64 | sticky_f64_reg2); // @[FloatFMA.scala 551:43]
  wire  _round_add1_f64_T_7 = guard_f64 | guard_uf_f64 | sticky_f64_reg2; // @[FloatFMA.scala 552:64]
  wire  _round_add1_f64_T_23 = adder_is_negative_f16_reg2 & ~guard_f64 & ~guard_uf_f64 & _round_f64_T; // @[FloatFMA.scala 555:58]
  wire  round_add1_f64 = _round_add1_f64_T_3 | _round_add1_f64_T_23; // @[FloatFMA.scala 554:26]
  wire  round_add1_uf_f64 = guard_uf_f64 & (guard_f64 | round_uf_f64 | sticky_uf_f64_reg2); // @[FloatFMA.scala 569:52]
  wire  exponent_add_1_f64 = &fraction_result_no_round_f64_reg2 & round_add1_f64; // @[FloatFMA.scala 582:67]
  reg  is_fix_reg2; // @[Reg.scala 19:16]
  reg [7:0] lshift_value_reg2; // @[Reg.scala 19:16]
  wire [11:0] _GEN_278 = {{4'd0}, lshift_value_reg2}; // @[FloatFMA.scala 594:24]
  wire [11:0] _exponent_result_add_value_f64_T_2 = E_greater_f64_reg2 - _GEN_278; // @[FloatFMA.scala 594:24]
  wire [11:0] _exponent_result_add_value_f64_T_4 = _exponent_result_add_value_f64_T_2 + 12'h1; // @[FloatFMA.scala 594:44]
  wire [11:0] exponent_result_add_value_f64 = exponent_add_1_f64 | is_fix_reg2 ? _exponent_result_add_value_f64_T_4 :
    _exponent_result_add_value_f64_T_2; // @[FloatFMA.scala 593:42]
  wire  exponent_overflow_f64 = exponent_result_add_value_f64[11] | &exponent_result_add_value_f64[10:0]; // @[FloatFMA.scala 606:84]
  wire  _exponent_is_min_f64_T_5 = ~lshift_adder_inv_fix_f64[162] & lshift_mask_valid_f16_reg1 & ~is_fix_f64; // @[FloatFMA.scala 611:119]
  reg  exponent_is_min_f64; // @[Reg.scala 19:16]
  wire [10:0] _exponent_result_temp_f64_T = {10'h0,exponent_add_1_f64}; // @[Cat.scala 33:92]
  wire [10:0] exponent_result_temp_f64 = exponent_is_min_f64 ? _exponent_result_temp_f64_T :
    exponent_result_add_value_f64[10:0]; // @[FloatFMA.scala 615:42]
  wire [51:0] _fraction_result_temp_f64_T_1 = fraction_result_no_round_f64_reg2 + 52'h1; // @[FloatFMA.scala 627:92]
  wire [51:0] fraction_result_temp_f64 = round_add1_f64 ? _fraction_result_temp_f64_T_1 :
    fraction_result_no_round_f64_reg2; // @[FloatFMA.scala 627:38]
  wire  UF_f64 = _round_add1_f64_T_7 & exponent_is_min_f64 & (~exponent_add_1_f64 | ~(guard_f64 & round_add1_uf_f64)); // @[FloatFMA.scala 641:42]
  wire [4:0] _fflags_f64_T = {3'h0,UF_f64,_round_add1_f64_T_7}; // @[Cat.scala 33:92]
  wire  fp_a_is_zero_f64 = ~(|fp_a_significand_f64); // @[FloatFMA.scala 645:53]
  wire  fp_b_is_zero_f64 = ~(|fp_b_significand_f64); // @[FloatFMA.scala 648:53]
  wire  fp_c_is_zero_f64 = ~_rshift_sticky_f64_reg_d_T_1; // @[FloatFMA.scala 651:53]
  wire  _normal_result_is_zero_f64_reg2_T_1 = ~(|adder_f64); // @[FloatFMA.scala 656:60]
  reg  normal_result_is_zero_f64_reg2_r; // @[Reg.scala 19:16]
  reg  normal_result_is_zero_f64_reg2; // @[Reg.scala 19:16]
  reg  has_zero_f64_reg2_r; // @[Reg.scala 19:16]
  reg  has_zero_f64_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_zero_f64_reg2_r_2; // @[Reg.scala 19:16]
  wire  has_zero_f64_reg2 = has_zero_f64_reg2_r_2 | normal_result_is_zero_f64_reg2; // @[FloatFMA.scala 660:149]
  wire [63:0] normal_result_f64 = {sign_result_temp_f64_reg2,exponent_result_temp_f64,fraction_result_temp_f64}; // @[Cat.scala 33:92]
  wire [63:0] result_overflow_up_f64 = {sign_result_temp_f64_reg2,11'h7ff,52'h0}; // @[Cat.scala 33:92]
  wire  _fp_a_is_nan_f64_T = &Ea_f64; // @[FloatFMA.scala 678:58]
  wire  _fp_a_is_nan_f64_T_2 = |fp_a_significand_f64[51:0]; // @[FloatFMA.scala 678:94]
  wire  fp_a_is_nan_f64 = &Ea_f64 & |fp_a_significand_f64[51:0]; // @[FloatFMA.scala 678:63]
  wire  _fp_b_is_nan_f64_T = &Eb_f64; // @[FloatFMA.scala 681:58]
  wire  _fp_b_is_nan_f64_T_2 = |fp_b_significand_f64[51:0]; // @[FloatFMA.scala 681:94]
  wire  fp_b_is_nan_f64 = &Eb_f64 & |fp_b_significand_f64[51:0]; // @[FloatFMA.scala 681:63]
  wire  _fp_c_is_nan_f64_T = &Ec_f64; // @[FloatFMA.scala 684:58]
  wire  _fp_c_is_nan_f64_T_2 = |fp_c_significand_f64[51:0]; // @[FloatFMA.scala 684:94]
  wire  fp_c_is_nan_f64 = &Ec_f64 & |fp_c_significand_f64[51:0]; // @[FloatFMA.scala 684:63]
  wire  fp_a_is_snan_f64 = _fp_a_is_nan_f64_T & ~fp_a_significand_f64[51] & |fp_a_significand_f64[50:0]; // @[FloatFMA.scala 692:106]
  wire  fp_b_is_snan_f64 = _fp_b_is_nan_f64_T & ~fp_b_significand_f64[51] & |fp_b_significand_f64[50:0]; // @[FloatFMA.scala 695:106]
  wire  fp_c_is_snan_f64 = _fp_c_is_nan_f64_T & ~fp_c_significand_f64[51] & |fp_c_significand_f64[50:0]; // @[FloatFMA.scala 698:106]
  wire  has_snan_f64 = fp_a_is_snan_f64 | fp_b_is_snan_f64 | fp_c_is_snan_f64; // @[FloatFMA.scala 702:58]
  wire  fp_a_is_inf_f64 = _fp_a_is_nan_f64_T & ~_fp_a_is_nan_f64_T_2; // @[FloatFMA.scala 706:64]
  wire  fp_b_is_inf_f64 = _fp_b_is_nan_f64_T & ~_fp_b_is_nan_f64_T_2; // @[FloatFMA.scala 709:64]
  wire  fp_c_is_inf_f64 = _fp_c_is_nan_f64_T & ~_fp_c_is_nan_f64_T_2; // @[FloatFMA.scala 712:64]
  wire  _has_inf_f64_T = fp_a_is_inf_f64 | fp_b_is_inf_f64; // @[FloatFMA.scala 716:37]
  wire  _fp_result_f64_fp_a_or_b_is_zero_T_4 = is_fmul ? sign_a_b_f64 : sign_a_b_f64 & sign_c_f64; // @[FloatFMA.scala 736:10]
  wire  _fp_result_f64_fp_a_or_b_is_zero_T_6 = fp_c_is_zero_f64 ? _fp_result_f64_fp_a_or_b_is_zero_T_4 : fp_c_f64[63]; // @[FloatFMA.scala 734:8]
  reg [63:0] fp_result_fp_a_or_b_is_zero_reg_r; // @[Reg.scala 19:16]
  reg [63:0] fp_result_fp_a_or_b_is_zero_reg_r_1; // @[Reg.scala 19:16]
  reg [63:0] fp_result_f64_fp_a_or_b_is_zero_reg2; // @[Reg.scala 19:16]
  reg  has_nan_f64_reg2_r; // @[Reg.scala 19:16]
  reg  has_nan_f64_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_nan_f64_reg2; // @[Reg.scala 19:16]
  wire  _has_nan_f64_is_NV_reg2_T_1 = fp_a_is_inf_f64 & fp_b_is_zero_f64; // @[FloatFMA.scala 764:44]
  wire  _has_nan_f64_is_NV_reg2_T_3 = fp_a_is_zero_f64 & fp_b_is_inf_f64; // @[FloatFMA.scala 764:84]
  reg  has_nan_f64_is_NV_reg2_r; // @[Reg.scala 19:16]
  reg  has_nan_f64_is_NV_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_nan_f64_is_NV_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f64_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f64_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f64_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f64_is_NV_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f64_is_NV_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f64_is_NV_reg2; // @[Reg.scala 19:16]
  reg  has_inf_f64_result_inf_sign_reg2_r; // @[Reg.scala 19:16]
  reg  has_inf_f64_result_inf_sign_reg2_r_1; // @[Reg.scala 19:16]
  reg  has_inf_f64_result_inf_sign_reg2; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f64_reg2_r; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f64_reg2_r_1; // @[Reg.scala 19:16]
  reg  fp_a_or_b_is_zero_f64_reg2; // @[Reg.scala 19:16]
  wire [4:0] _fflags_f64_T_1 = has_nan_f64_is_NV_reg2 ? 5'h10 : 5'h0; // @[FloatFMA.scala 780:22]
  wire [63:0] _fp_result_f64_T = {has_inf_f64_result_inf_sign_reg2,63'h7ff0000000000000}; // @[Cat.scala 33:92]
  wire [63:0] _fp_result_f64_T_1 = has_inf_f64_is_NV_reg2 ? 64'h7ff8000000000000 : _fp_result_f64_T; // @[FloatFMA.scala 782:25]
  wire [4:0] _fflags_f64_T_2 = has_inf_f64_is_NV_reg2 ? 5'h10 : 5'h0; // @[FloatFMA.scala 783:22]
  wire [63:0] _fp_result_f64_T_4 = normal_result_is_zero_f64_reg2 ? 64'h0 : normal_result_f64; // @[FloatFMA.scala 790:10]
  wire [63:0] _fp_result_f64_T_5 = fp_a_or_b_is_zero_f64_reg2 ? fp_result_f64_fp_a_or_b_is_zero_reg2 :
    _fp_result_f64_T_4; // @[FloatFMA.scala 788:25]
  wire [4:0] _fflags_f64_T_5 = fp_a_or_b_is_zero_f64_reg2 | normal_result_is_zero_f64_reg2 ? 5'h0 : _fflags_f64_T; // @[FloatFMA.scala 792:22]
  wire [63:0] _GEN_122 = has_zero_f64_reg2 ? _fp_result_f64_T_5 : normal_result_f64; // @[FloatFMA.scala 787:32 788:19 794:19]
  wire [4:0] _GEN_123 = has_zero_f64_reg2 ? _fflags_f64_T_5 : _fflags_f64_T; // @[FloatFMA.scala 787:32 792:16 635:28]
  wire [63:0] _GEN_124 = exponent_overflow_f64 ? result_overflow_up_f64 : _GEN_122; // @[FloatFMA.scala 784:35 785:19]
  wire [4:0] _GEN_125 = exponent_overflow_f64 ? 5'h5 : _GEN_123; // @[FloatFMA.scala 784:35 786:16]
  wire [63:0] _GEN_126 = has_inf_f64_reg2 ? _fp_result_f64_T_1 : _GEN_124; // @[FloatFMA.scala 781:31 782:19]
  wire [4:0] _GEN_127 = has_inf_f64_reg2 ? _fflags_f64_T_2 : _GEN_125; // @[FloatFMA.scala 781:31 783:16]
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
    .io_out_pp_12(U_BoothEncoder_io_out_pp_12),
    .io_out_pp_13(U_BoothEncoder_io_out_pp_13),
    .io_out_pp_14(U_BoothEncoder_io_out_pp_14),
    .io_out_pp_15(U_BoothEncoder_io_out_pp_15),
    .io_out_pp_16(U_BoothEncoder_io_out_pp_16),
    .io_out_pp_17(U_BoothEncoder_io_out_pp_17),
    .io_out_pp_18(U_BoothEncoder_io_out_pp_18),
    .io_out_pp_19(U_BoothEncoder_io_out_pp_19),
    .io_out_pp_20(U_BoothEncoder_io_out_pp_20),
    .io_out_pp_21(U_BoothEncoder_io_out_pp_21),
    .io_out_pp_22(U_BoothEncoder_io_out_pp_22),
    .io_out_pp_23(U_BoothEncoder_io_out_pp_23),
    .io_out_pp_24(U_BoothEncoder_io_out_pp_24),
    .io_out_pp_25(U_BoothEncoder_io_out_pp_25),
    .io_out_pp_26(U_BoothEncoder_io_out_pp_26)
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
    .io_in_13(U_CSAnto2_io_in_13),
    .io_in_14(U_CSAnto2_io_in_14),
    .io_in_15(U_CSAnto2_io_in_15),
    .io_in_16(U_CSAnto2_io_in_16),
    .io_in_17(U_CSAnto2_io_in_17),
    .io_in_18(U_CSAnto2_io_in_18),
    .io_in_19(U_CSAnto2_io_in_19),
    .io_in_20(U_CSAnto2_io_in_20),
    .io_in_21(U_CSAnto2_io_in_21),
    .io_in_22(U_CSAnto2_io_in_22),
    .io_in_23(U_CSAnto2_io_in_23),
    .io_in_24(U_CSAnto2_io_in_24),
    .io_in_25(U_CSAnto2_io_in_25),
    .io_in_26(U_CSAnto2_io_in_26),
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
  assign io_fp_result = has_nan_f64_reg2 ? 64'h7ff8000000000000 : _GEN_126; // @[FloatFMA.scala 778:25 779:19]
  assign io_fflags = has_nan_f64_reg2 ? _fflags_f64_T_1 : _GEN_127; // @[FloatFMA.scala 778:25 780:16]
  assign U_BoothEncoder_io_in_a = {Ea_f64_is_not_zero,fp_a_f64[51:0]}; // @[Cat.scala 33:92]
  assign U_BoothEncoder_io_in_b = {Eb_f64_is_not_zero,io_fp_b[51:0]}; // @[Cat.scala 33:92]
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
  assign U_CSAnto2_io_in_13 = U_BoothEncoder_io_out_pp_13; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_14 = U_BoothEncoder_io_out_pp_14; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_15 = U_BoothEncoder_io_out_pp_15; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_16 = U_BoothEncoder_io_out_pp_16; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_17 = U_BoothEncoder_io_out_pp_17; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_18 = U_BoothEncoder_io_out_pp_18; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_19 = U_BoothEncoder_io_out_pp_19; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_20 = U_BoothEncoder_io_out_pp_20; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_21 = U_BoothEncoder_io_out_pp_21; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_22 = U_BoothEncoder_io_out_pp_22; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_23 = U_BoothEncoder_io_out_pp_23; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_24 = U_BoothEncoder_io_out_pp_24; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_25 = U_BoothEncoder_io_out_pp_25; // @[FloatFMA.scala 275:19]
  assign U_CSAnto2_io_in_26 = U_BoothEncoder_io_out_pp_26; // @[FloatFMA.scala 275:19]
  assign U_CSA3to2_io_in_a = U_CSAnto2_io_out_sum; // @[FloatFMA.scala 312:21]
  assign U_CSA3to2_io_in_b = {U_CSAnto2_io_out_car[106:1],_CSA3to2_in_b_T_6}; // @[Cat.scala 33:92]
  assign U_CSA3to2_io_in_c = {1'h0,fp_c_rshiftValue_inv_f64_reg0[105:0]}; // @[Cat.scala 33:92]
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
    is_sub_f64_reg0 <= sign_a_b_f64 ^ sign_c_f64; // @[FloatFMA.scala 110:44]
    rshift_guard_f16 <= Ec_is_medium_f64 & rshift_result_with_grs_f64[2]; // @[FloatFMA.scala 197:39]
    rshift_round_f16 <= Ec_is_medium_f64 & rshift_result_with_grs_f64[1]; // @[FloatFMA.scala 203:39]
    if (Ec_is_medium_f64) begin // @[FloatFMA.scala 209:39]
      rshift_sticky_f16 <= rshift_result_with_grs_f64[0];
    end else if (Ec_is_too_big_f64) begin // @[FloatFMA.scala 209:92]
      rshift_sticky_f16 <= 1'h0;
    end else begin
      rshift_sticky_f16 <= |fp_c_significand_f64;
    end
    if (is_sub_f64) begin // @[FloatFMA.scala 242:43]
      fp_c_rshiftValue_inv_f64_reg0 <= _fp_c_rshiftValue_inv_f64_reg_d_T_2;
    end else begin
      fp_c_rshiftValue_inv_f64_reg0 <= _fp_c_rshiftValue_inv_f64_reg_d_T_3;
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      adder_is_negative_reg1 <= adder_is_negative_f64; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      adder_is_negative_f16_reg2 <= adder_is_negative_reg1; // @[Reg.scala 20:22]
    end
    if (Eab_is_greater_f64) begin // @[FloatFMA.scala 372:33]
      E_greater_reg2_r <= Eab_f64[11:0];
    end else begin
      E_greater_reg2_r <= _rshift_value_f64_T;
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      E_greater_reg2_r_1 <= E_greater_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      E_greater_f64_reg2 <= E_greater_reg2_r_1; // @[Reg.scala 20:22]
    end
    if (Eab_is_greater_f64) begin // @[FloatFMA.scala 383:40]
      lshift_value_max_f64_reg0 <= _lshift_value_max_f64_reg_d_T_2;
    end else begin
      lshift_value_max_f64_reg0 <= _lshift_value_max_f64_reg_d_T_5;
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      tzd_adder_reg1 <= tzd_adder_f64_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      lzd_adder_inv_mask_reg1 <= lzd_adder_inv_mask_f64_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      lshift_mask_valid_f16_reg1 <= lshift_mask_valid_f64_reg_d; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      adder_f64_reg1 <= adder_f64; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fraction_result_no_round_f64_reg2 <= fraction_result_no_round_f64_reg_d; // @[Reg.scala 20:22]
    end
    sign_result_temp_f64_reg2_r <= fp_c_f64[63]; // @[FloatFMA.scala 109:39]
    sign_result_temp_f64_reg2_r_1 <= fp_a_f64[63] ^ io_fp_b[63]; // @[FloatFMA.scala 106:45]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      if (adder_is_negative_f64) begin // @[FloatFMA.scala 497:60]
        sign_result_temp_f64_reg2_r_2 <= sign_result_temp_f64_reg2_r;
      end else begin
        sign_result_temp_f64_reg2_r_2 <= sign_result_temp_f64_reg2_r_1;
      end
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sign_result_temp_f64_reg2 <= sign_result_temp_f64_reg2_r_2; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      sticky_f64_reg2_r <= rshift_sticky_f16; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sticky_f64_reg2 <= _sticky_f64_reg2_T_3; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      sticky_uf_f64_reg2_r <= rshift_sticky_f16; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      sticky_uf_f64_reg2 <= _sticky_uf_f64_reg2_T_3; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      round_lshift_f64_reg2 <= lshift_adder_inv_fix_f64[108]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      guard_lshift_f64_reg2 <= lshift_adder_inv_fix_f64[109]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      round_lshift_uf_f64_reg2 <= lshift_adder_inv_fix_f64[107]; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      is_fix_reg2 <= is_fix_f64; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      if (_lzd_adder_inv_mask_f64_T_185[0]) begin // @[Mux.scala 47:70]
        lshift_value_reg2 <= 8'h0;
      end else if (_lzd_adder_inv_mask_f64_T_185[1]) begin // @[Mux.scala 47:70]
        lshift_value_reg2 <= 8'h1;
      end else if (_lzd_adder_inv_mask_f64_T_185[2]) begin // @[Mux.scala 47:70]
        lshift_value_reg2 <= 8'h2;
      end else begin
        lshift_value_reg2 <= _lzd_adder_inv_mask_f64_T_509;
      end
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      exponent_is_min_f64 <= _exponent_is_min_f64_T_5; // @[Reg.scala 20:22]
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      normal_result_is_zero_f64_reg2_r <= _normal_result_is_zero_f64_reg2_T_1; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      normal_result_is_zero_f64_reg2 <= normal_result_is_zero_f64_reg2_r; // @[Reg.scala 20:22]
    end
    has_zero_f64_reg2_r <= fp_a_is_zero_f64 | fp_b_is_zero_f64 | fp_c_is_zero_f64; // @[FloatFMA.scala 660:97]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_zero_f64_reg2_r_1 <= has_zero_f64_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_zero_f64_reg2_r_2 <= has_zero_f64_reg2_r_1; // @[Reg.scala 20:22]
    end
    fp_result_fp_a_or_b_is_zero_reg_r <= {_fp_result_f64_fp_a_or_b_is_zero_T_6,fp_c_f64[62:0]}; // @[Cat.scala 33:92]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      fp_result_fp_a_or_b_is_zero_reg_r_1 <= fp_result_fp_a_or_b_is_zero_reg_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fp_result_f64_fp_a_or_b_is_zero_reg2 <= fp_result_fp_a_or_b_is_zero_reg_r_1; // @[Reg.scala 20:22]
    end
    has_nan_f64_reg2_r <= fp_a_is_nan_f64 | fp_b_is_nan_f64 | fp_c_is_nan_f64; // @[FloatFMA.scala 688:55]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_nan_f64_reg2_r_1 <= has_nan_f64_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_nan_f64_reg2 <= has_nan_f64_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_nan_f64_is_NV_reg2_r <= has_snan_f64 | fp_a_is_inf_f64 & fp_b_is_zero_f64 | fp_a_is_zero_f64 & fp_b_is_inf_f64; // @[FloatFMA.scala 764:64]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_nan_f64_is_NV_reg2_r_1 <= has_nan_f64_is_NV_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_nan_f64_is_NV_reg2 <= has_nan_f64_is_NV_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_inf_f64_reg2_r <= fp_a_is_inf_f64 | fp_b_is_inf_f64 | fp_c_is_inf_f64; // @[FloatFMA.scala 716:55]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_reg2_r_1 <= has_inf_f64_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_reg2 <= has_inf_f64_reg2_r_1; // @[Reg.scala 20:22]
    end
    has_inf_f64_is_NV_reg2_r <= _has_nan_f64_is_NV_reg2_T_1 | _has_nan_f64_is_NV_reg2_T_3 | fp_c_is_inf_f64 &
      _has_inf_f64_T & (sign_c_f64 ^ sign_a_b_f64); // @[FloatFMA.scala 768:83]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_is_NV_reg2_r_1 <= has_inf_f64_is_NV_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_is_NV_reg2 <= has_inf_f64_is_NV_reg2_r_1; // @[Reg.scala 20:22]
    end
    if (_has_inf_f64_T) begin // @[FloatFMA.scala 771:8]
      has_inf_f64_result_inf_sign_reg2_r <= sign_a_b_f64;
    end else begin
      has_inf_f64_result_inf_sign_reg2_r <= sign_c_f64;
    end
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_result_inf_sign_reg2_r_1 <= has_inf_f64_result_inf_sign_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      has_inf_f64_result_inf_sign_reg2 <= has_inf_f64_result_inf_sign_reg2_r_1; // @[Reg.scala 20:22]
    end
    fp_a_or_b_is_zero_f64_reg2_r <= fp_a_is_zero_f64 | fp_b_is_zero_f64; // @[FloatFMA.scala 775:83]
    if (fire_reg0_last_r) begin // @[Reg.scala 20:18]
      fp_a_or_b_is_zero_f64_reg2_r_1 <= fp_a_or_b_is_zero_f64_reg2_r; // @[Reg.scala 20:22]
    end
    if (fire_reg1_last_r) begin // @[Reg.scala 20:18]
      fp_a_or_b_is_zero_f64_reg2 <= fp_a_or_b_is_zero_f64_reg2_r_1; // @[Reg.scala 20:22]
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
  is_sub_f64_reg0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rshift_guard_f16 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  rshift_round_f16 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  rshift_sticky_f16 = _RAND_5[0:0];
  _RAND_6 = {6{`RANDOM}};
  fp_c_rshiftValue_inv_f64_reg0 = _RAND_6[161:0];
  _RAND_7 = {1{`RANDOM}};
  adder_is_negative_reg1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  adder_is_negative_f16_reg2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  E_greater_reg2_r = _RAND_9[11:0];
  _RAND_10 = {1{`RANDOM}};
  E_greater_reg2_r_1 = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  E_greater_f64_reg2 = _RAND_11[11:0];
  _RAND_12 = {1{`RANDOM}};
  lshift_value_max_f64_reg0 = _RAND_12[11:0];
  _RAND_13 = {6{`RANDOM}};
  tzd_adder_reg1 = _RAND_13[163:0];
  _RAND_14 = {6{`RANDOM}};
  lzd_adder_inv_mask_reg1 = _RAND_14[162:0];
  _RAND_15 = {1{`RANDOM}};
  lshift_mask_valid_f16_reg1 = _RAND_15[0:0];
  _RAND_16 = {6{`RANDOM}};
  adder_f64_reg1 = _RAND_16[163:0];
  _RAND_17 = {2{`RANDOM}};
  fraction_result_no_round_f64_reg2 = _RAND_17[51:0];
  _RAND_18 = {1{`RANDOM}};
  sign_result_temp_f64_reg2_r = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_result_temp_f64_reg2_r_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_result_temp_f64_reg2_r_2 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_result_temp_f64_reg2 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sticky_f64_reg2_r = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sticky_f64_reg2 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  sticky_uf_f64_reg2_r = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  sticky_uf_f64_reg2 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  round_lshift_f64_reg2 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  guard_lshift_f64_reg2 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  round_lshift_uf_f64_reg2 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  is_fix_reg2 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  lshift_value_reg2 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  exponent_is_min_f64 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  normal_result_is_zero_f64_reg2_r = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  normal_result_is_zero_f64_reg2 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  has_zero_f64_reg2_r = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  has_zero_f64_reg2_r_1 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  has_zero_f64_reg2_r_2 = _RAND_36[0:0];
  _RAND_37 = {2{`RANDOM}};
  fp_result_fp_a_or_b_is_zero_reg_r = _RAND_37[63:0];
  _RAND_38 = {2{`RANDOM}};
  fp_result_fp_a_or_b_is_zero_reg_r_1 = _RAND_38[63:0];
  _RAND_39 = {2{`RANDOM}};
  fp_result_f64_fp_a_or_b_is_zero_reg2 = _RAND_39[63:0];
  _RAND_40 = {1{`RANDOM}};
  has_nan_f64_reg2_r = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  has_nan_f64_reg2_r_1 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  has_nan_f64_reg2 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  has_nan_f64_is_NV_reg2_r = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  has_nan_f64_is_NV_reg2_r_1 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  has_nan_f64_is_NV_reg2 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  has_inf_f64_reg2_r = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  has_inf_f64_reg2_r_1 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  has_inf_f64_reg2 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  has_inf_f64_is_NV_reg2_r = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  has_inf_f64_is_NV_reg2_r_1 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  has_inf_f64_is_NV_reg2 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  has_inf_f64_result_inf_sign_reg2_r = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  has_inf_f64_result_inf_sign_reg2_r_1 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  has_inf_f64_result_inf_sign_reg2 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f64_reg2_r = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f64_reg2_r_1 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  fp_a_or_b_is_zero_f64_reg2 = _RAND_57[0:0];
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
  wire [63:0] _addend_T_1 = io_req_bits_b ^ 64'h8000000000000000; // @[YunSuanFmaPipe.scala 55:66]
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
  assign core_io_fp_b = synthAdd ? 64'h3ff0000000000000 : io_req_bits_b; // @[YunSuanFmaPipe.scala 65:22]
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
module RoundingUnit_4(
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
module ShiftRightJam_2(
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
  RoundingUnit_4 normal_rounder ( // @[FPToFP.scala 80:30]
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
  RoundingUnit_4 subnormal_rounder ( // @[FPToFP.scala 114:33]
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
  wire  f64Pipe_clock; // @[AecFpUnit.scala 203:23]
  wire  f64Pipe_reset; // @[AecFpUnit.scala 203:23]
  wire  f64Pipe_io_req_ready; // @[AecFpUnit.scala 203:23]
  wire  f64Pipe_io_req_valid; // @[AecFpUnit.scala 203:23]
  wire [6:0] f64Pipe_io_req_bits_op; // @[AecFpUnit.scala 203:23]
  wire [63:0] f64Pipe_io_req_bits_a; // @[AecFpUnit.scala 203:23]
  wire [63:0] f64Pipe_io_req_bits_b; // @[AecFpUnit.scala 203:23]
  wire [63:0] f64Pipe_io_req_bits_c; // @[AecFpUnit.scala 203:23]
  wire [5:0] f64Pipe_io_req_bits_seq; // @[AecFpUnit.scala 203:23]
  wire [7:0] f64Pipe_io_req_bits_dest; // @[AecFpUnit.scala 203:23]
  wire [3:0] f64Pipe_io_req_bits_dtype; // @[AecFpUnit.scala 203:23]
  wire  f64Pipe_io_resp_ready; // @[AecFpUnit.scala 203:23]
  wire  f64Pipe_io_resp_valid; // @[AecFpUnit.scala 203:23]
  wire [63:0] f64Pipe_io_resp_bits_result; // @[AecFpUnit.scala 203:23]
  wire [4:0] f64Pipe_io_resp_bits_fflags; // @[AecFpUnit.scala 203:23]
  wire [5:0] f64Pipe_io_resp_bits_seq; // @[AecFpUnit.scala 203:23]
  wire [7:0] f64Pipe_io_resp_bits_dest; // @[AecFpUnit.scala 203:23]
  wire [3:0] f64Pipe_io_resp_bits_dtype; // @[AecFpUnit.scala 203:23]
  wire  issueQ_clock; // @[AecFpUnit.scala 254:24]
  wire  issueQ_reset; // @[AecFpUnit.scala 254:24]
  wire  issueQ_io_enq_ready; // @[AecFpUnit.scala 254:24]
  wire  issueQ_io_enq_valid; // @[AecFpUnit.scala 254:24]
  wire [5:0] issueQ_io_enq_bits; // @[AecFpUnit.scala 254:24]
  wire  issueQ_io_deq_ready; // @[AecFpUnit.scala 254:24]
  wire  issueQ_io_deq_valid; // @[AecFpUnit.scala 254:24]
  wire [5:0] issueQ_io_deq_bits; // @[AecFpUnit.scala 254:24]
  wire  simpleQ_clock; // @[AecFpUnit.scala 255:25]
  wire  simpleQ_reset; // @[AecFpUnit.scala 255:25]
  wire  simpleQ_io_enq_ready; // @[AecFpUnit.scala 255:25]
  wire  simpleQ_io_enq_valid; // @[AecFpUnit.scala 255:25]
  wire [5:0] simpleQ_io_enq_bits_seq; // @[AecFpUnit.scala 255:25]
  wire [6:0] simpleQ_io_enq_bits_req_op; // @[AecFpUnit.scala 255:25]
  wire [3:0] simpleQ_io_enq_bits_req_dtype; // @[AecFpUnit.scala 255:25]
  wire [63:0] simpleQ_io_enq_bits_req_a; // @[AecFpUnit.scala 255:25]
  wire [63:0] simpleQ_io_enq_bits_req_b; // @[AecFpUnit.scala 255:25]
  wire [7:0] simpleQ_io_enq_bits_req_dest; // @[AecFpUnit.scala 255:25]
  wire  simpleQ_io_deq_ready; // @[AecFpUnit.scala 255:25]
  wire  simpleQ_io_deq_valid; // @[AecFpUnit.scala 255:25]
  wire [5:0] simpleQ_io_deq_bits_seq; // @[AecFpUnit.scala 255:25]
  wire [6:0] simpleQ_io_deq_bits_req_op; // @[AecFpUnit.scala 255:25]
  wire [3:0] simpleQ_io_deq_bits_req_dtype; // @[AecFpUnit.scala 255:25]
  wire [63:0] simpleQ_io_deq_bits_req_a; // @[AecFpUnit.scala 255:25]
  wire [63:0] simpleQ_io_deq_bits_req_b; // @[AecFpUnit.scala 255:25]
  wire [7:0] simpleQ_io_deq_bits_req_dest; // @[AecFpUnit.scala 255:25]
  wire [16:0] cmp16_io_a; // @[AecFpUnit.scala 281:21]
  wire [16:0] cmp16_io_b; // @[AecFpUnit.scala 281:21]
  wire  cmp16_io_lt; // @[AecFpUnit.scala 281:21]
  wire  cmp16_io_eq; // @[AecFpUnit.scala 281:21]
  wire  cmp16_io_gt; // @[AecFpUnit.scala 281:21]
  wire [32:0] cmp32_io_a; // @[AecFpUnit.scala 281:66]
  wire [32:0] cmp32_io_b; // @[AecFpUnit.scala 281:66]
  wire  cmp32_io_lt; // @[AecFpUnit.scala 281:66]
  wire  cmp32_io_eq; // @[AecFpUnit.scala 281:66]
  wire  cmp32_io_gt; // @[AecFpUnit.scala 281:66]
  wire [64:0] cmp64_io_a; // @[AecFpUnit.scala 281:111]
  wire [64:0] cmp64_io_b; // @[AecFpUnit.scala 281:111]
  wire  cmp64_io_lt; // @[AecFpUnit.scala 281:111]
  wire  cmp64_io_eq; // @[AecFpUnit.scala 281:111]
  wire  cmp64_io_gt; // @[AecFpUnit.scala 281:111]
  wire [63:0] f64DownF16_io_in; // @[AecFpUnit.scala 316:26]
  wire [15:0] f64DownF16_io_result; // @[AecFpUnit.scala 316:26]
  wire [63:0] f64DownBf16_io_in; // @[AecFpUnit.scala 317:27]
  wire [15:0] f64DownBf16_io_result; // @[AecFpUnit.scala 317:27]
  wire [63:0] f64DownF32_io_in; // @[AecFpUnit.scala 318:26]
  wire [31:0] f64DownF32_io_result; // @[AecFpUnit.scala 318:26]
  wire  _reqPipe_T_3 = io_req_bits_op == 7'h3; // @[AecFpUnit.scala 202:22]
  wire  _reqPipe_T_4 = io_req_bits_op == 7'h1 | io_req_bits_op == 7'h2 | _reqPipe_T_3; // @[AecFpUnit.scala 201:71]
  wire  reqPipe = _reqPipe_T_4 | io_req_bits_op == 7'h5; // @[AecFpUnit.scala 202:38]
  wire  reqDtypeSupported = io_req_bits_dtype == 4'h9; // @[AecFpUnit.scala 222:75]
  reg [5:0] issueSeq; // @[AecFpUnit.scala 256:27]
  wire  selectedReady = reqPipe ? f64Pipe_io_req_ready : simpleQ_io_enq_ready; // @[AecFpUnit.scala 259:28]
  wire  _issueQ_io_enq_valid_T = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  wire [5:0] _issueSeq_T_1 = issueSeq + 6'h1; // @[AecFpUnit.scala 266:47]
  wire  f64AtHead = f64Pipe_io_resp_valid & issueQ_io_deq_valid & f64Pipe_io_resp_bits_seq == issueQ_io_deq_bits; // @[AecFpUnit.scala 268:63]
  wire  oldAtHead = simpleQ_io_deq_valid & issueQ_io_deq_valid & simpleQ_io_deq_bits_seq == issueQ_io_deq_bits; // @[AecFpUnit.scala 269:62]
  wire [3:0] held_dtype = simpleQ_io_deq_bits_req_dtype; // @[AecFpUnit.scala 232:18 267:10]
  wire  isF32 = held_dtype == 4'h8; // @[AecFpUnit.scala 276:26]
  wire  isF64 = held_dtype == 4'h9; // @[AecFpUnit.scala 276:58]
  wire [6:0] held_op = simpleQ_io_deq_bits_req_op; // @[AecFpUnit.scala 232:18 267:10]
  wire [63:0] held_a = simpleQ_io_deq_bits_req_a; // @[AecFpUnit.scala 232:18 267:10]
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
  wire [24:0] _GEN_26 = {{15'd0}, cmp16_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _cmp16_io_a_rawIn_subnormFract_T = _GEN_26 << cmp16_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] cmp16_io_a_rawIn_subnormFract = {_cmp16_io_a_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_1 = {{2'd0}, cmp16_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_a_rawIn_adjustedExp_T = _GEN_1 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_a_rawIn_adjustedExp_T_1 = cmp16_io_a_rawIn_isZeroExpIn ? _cmp16_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp16_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp16_io_a_rawIn_adjustedExp_T_2 = cmp16_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_2 = {{3'd0}, _cmp16_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _cmp16_io_a_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_2; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_3 = {{1'd0}, _cmp16_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] cmp16_io_a_rawIn_adjustedExp = _cmp16_io_a_rawIn_adjustedExp_T_1 + _GEN_3; // @[rawFloatFromFN.scala 57:9]
  wire  cmp16_io_a_rawIn_isZero = cmp16_io_a_rawIn_isZeroExpIn & cmp16_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp16_io_a_rawIn_isSpecial = cmp16_io_a_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp16_io_a_rawIn__isNaN = cmp16_io_a_rawIn_isSpecial & ~cmp16_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] cmp16_io_a_rawIn__sExp = {1'b0,$signed(cmp16_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp16_io_a_rawIn_out_sig_T = ~cmp16_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _cmp16_io_a_rawIn_out_sig_T_2 = cmp16_io_a_rawIn_isZeroExpIn ? cmp16_io_a_rawIn_subnormFract :
    cmp16_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] cmp16_io_a_rawIn__sig = {1'h0,_cmp16_io_a_rawIn_out_sig_T,_cmp16_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp16_io_a_T_15 = cmp16_io_a_rawIn_isZero ? 3'h0 : cmp16_io_a_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_4 = {{2'd0}, cmp16_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp16_io_a_T_17 = _cmp16_io_a_T_15 | _GEN_4; // @[recFNFromFN.scala 48:76]
  wire [6:0] _cmp16_io_a_T_20 = {cmp16_io_a_rawIn_sign,_cmp16_io_a_T_17,cmp16_io_a_rawIn__sExp[2:0]}; // @[recFNFromFN.scala 49:45]
  wire [63:0] held_b = simpleQ_io_deq_bits_req_b; // @[AecFpUnit.scala 232:18 267:10]
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
  wire [24:0] _GEN_27 = {{15'd0}, cmp16_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [24:0] _cmp16_io_b_rawIn_subnormFract_T = _GEN_27 << cmp16_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [9:0] cmp16_io_b_rawIn_subnormFract = {_cmp16_io_b_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [5:0] _GEN_5 = {{2'd0}, cmp16_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_b_rawIn_adjustedExp_T = _GEN_5 ^ 6'h3f; // @[rawFloatFromFN.scala 55:18]
  wire [5:0] _cmp16_io_b_rawIn_adjustedExp_T_1 = cmp16_io_b_rawIn_isZeroExpIn ? _cmp16_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp16_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp16_io_b_rawIn_adjustedExp_T_2 = cmp16_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [4:0] _GEN_6 = {{3'd0}, _cmp16_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [4:0] _cmp16_io_b_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_6; // @[rawFloatFromFN.scala 58:9]
  wire [5:0] _GEN_7 = {{1'd0}, _cmp16_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [5:0] cmp16_io_b_rawIn_adjustedExp = _cmp16_io_b_rawIn_adjustedExp_T_1 + _GEN_7; // @[rawFloatFromFN.scala 57:9]
  wire  cmp16_io_b_rawIn_isZero = cmp16_io_b_rawIn_isZeroExpIn & cmp16_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp16_io_b_rawIn_isSpecial = cmp16_io_b_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp16_io_b_rawIn__isNaN = cmp16_io_b_rawIn_isSpecial & ~cmp16_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [6:0] cmp16_io_b_rawIn__sExp = {1'b0,$signed(cmp16_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp16_io_b_rawIn_out_sig_T = ~cmp16_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [9:0] _cmp16_io_b_rawIn_out_sig_T_2 = cmp16_io_b_rawIn_isZeroExpIn ? cmp16_io_b_rawIn_subnormFract :
    cmp16_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [11:0] cmp16_io_b_rawIn__sig = {1'h0,_cmp16_io_b_rawIn_out_sig_T,_cmp16_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp16_io_b_T_15 = cmp16_io_b_rawIn_isZero ? 3'h0 : cmp16_io_b_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_8 = {{2'd0}, cmp16_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp16_io_b_T_17 = _cmp16_io_b_T_15 | _GEN_8; // @[recFNFromFN.scala 48:76]
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
  wire [53:0] _GEN_28 = {{31'd0}, cmp32_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_a_rawIn_subnormFract_T = _GEN_28 << cmp32_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
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
  wire [2:0] _cmp32_io_a_T_15 = cmp32_io_a_rawIn_isZero ? 3'h0 : cmp32_io_a_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_12 = {{2'd0}, cmp32_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_a_T_17 = _cmp32_io_a_T_15 | _GEN_12; // @[recFNFromFN.scala 48:76]
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
  wire [53:0] _GEN_29 = {{31'd0}, cmp32_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [53:0] _cmp32_io_b_rawIn_subnormFract_T = _GEN_29 << cmp32_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
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
  wire [2:0] _cmp32_io_b_T_15 = cmp32_io_b_rawIn_isZero ? 3'h0 : cmp32_io_b_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_16 = {{2'd0}, cmp32_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp32_io_b_T_17 = _cmp32_io_b_T_15 | _GEN_16; // @[recFNFromFN.scala 48:76]
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
  wire [114:0] _GEN_30 = {{63'd0}, cmp64_io_a_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _cmp64_io_a_rawIn_subnormFract_T = _GEN_30 << cmp64_io_a_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] cmp64_io_a_rawIn_subnormFract = {_cmp64_io_a_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_17 = {{6'd0}, cmp64_io_a_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_a_rawIn_adjustedExp_T = _GEN_17 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_a_rawIn_adjustedExp_T_1 = cmp64_io_a_rawIn_isZeroExpIn ? _cmp64_io_a_rawIn_adjustedExp_T : {{1
    'd0}, cmp64_io_a_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp64_io_a_rawIn_adjustedExp_T_2 = cmp64_io_a_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_18 = {{9'd0}, _cmp64_io_a_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _cmp64_io_a_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_18; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_19 = {{1'd0}, _cmp64_io_a_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] cmp64_io_a_rawIn_adjustedExp = _cmp64_io_a_rawIn_adjustedExp_T_1 + _GEN_19; // @[rawFloatFromFN.scala 57:9]
  wire  cmp64_io_a_rawIn_isZero = cmp64_io_a_rawIn_isZeroExpIn & cmp64_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp64_io_a_rawIn_isSpecial = cmp64_io_a_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp64_io_a_rawIn__isNaN = cmp64_io_a_rawIn_isSpecial & ~cmp64_io_a_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] cmp64_io_a_rawIn__sExp = {1'b0,$signed(cmp64_io_a_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp64_io_a_rawIn_out_sig_T = ~cmp64_io_a_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _cmp64_io_a_rawIn_out_sig_T_2 = cmp64_io_a_rawIn_isZeroExpIn ? cmp64_io_a_rawIn_subnormFract :
    cmp64_io_a_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] cmp64_io_a_rawIn__sig = {1'h0,_cmp64_io_a_rawIn_out_sig_T,_cmp64_io_a_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp64_io_a_T_1 = cmp64_io_a_rawIn_isZero ? 3'h0 : cmp64_io_a_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_20 = {{2'd0}, cmp64_io_a_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp64_io_a_T_3 = _cmp64_io_a_T_1 | _GEN_20; // @[recFNFromFN.scala 48:76]
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
  wire [114:0] _GEN_31 = {{63'd0}, cmp64_io_b_rawIn_fractIn}; // @[rawFloatFromFN.scala 52:33]
  wire [114:0] _cmp64_io_b_rawIn_subnormFract_T = _GEN_31 << cmp64_io_b_rawIn_normDist; // @[rawFloatFromFN.scala 52:33]
  wire [51:0] cmp64_io_b_rawIn_subnormFract = {_cmp64_io_b_rawIn_subnormFract_T[50:0], 1'h0}; // @[rawFloatFromFN.scala 52:64]
  wire [11:0] _GEN_21 = {{6'd0}, cmp64_io_b_rawIn_normDist}; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_b_rawIn_adjustedExp_T = _GEN_21 ^ 12'hfff; // @[rawFloatFromFN.scala 55:18]
  wire [11:0] _cmp64_io_b_rawIn_adjustedExp_T_1 = cmp64_io_b_rawIn_isZeroExpIn ? _cmp64_io_b_rawIn_adjustedExp_T : {{1
    'd0}, cmp64_io_b_rawIn_expIn}; // @[rawFloatFromFN.scala 54:10]
  wire [1:0] _cmp64_io_b_rawIn_adjustedExp_T_2 = cmp64_io_b_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 58:14]
  wire [10:0] _GEN_22 = {{9'd0}, _cmp64_io_b_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 58:9]
  wire [10:0] _cmp64_io_b_rawIn_adjustedExp_T_3 = 11'h400 | _GEN_22; // @[rawFloatFromFN.scala 58:9]
  wire [11:0] _GEN_23 = {{1'd0}, _cmp64_io_b_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 57:9]
  wire [11:0] cmp64_io_b_rawIn_adjustedExp = _cmp64_io_b_rawIn_adjustedExp_T_1 + _GEN_23; // @[rawFloatFromFN.scala 57:9]
  wire  cmp64_io_b_rawIn_isZero = cmp64_io_b_rawIn_isZeroExpIn & cmp64_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 60:30]
  wire  cmp64_io_b_rawIn_isSpecial = cmp64_io_b_rawIn_adjustedExp[11:10] == 2'h3; // @[rawFloatFromFN.scala 61:57]
  wire  cmp64_io_b_rawIn__isNaN = cmp64_io_b_rawIn_isSpecial & ~cmp64_io_b_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 64:28]
  wire [12:0] cmp64_io_b_rawIn__sExp = {1'b0,$signed(cmp64_io_b_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 68:42]
  wire  _cmp64_io_b_rawIn_out_sig_T = ~cmp64_io_b_rawIn_isZero; // @[rawFloatFromFN.scala 70:19]
  wire [51:0] _cmp64_io_b_rawIn_out_sig_T_2 = cmp64_io_b_rawIn_isZeroExpIn ? cmp64_io_b_rawIn_subnormFract :
    cmp64_io_b_rawIn_fractIn; // @[rawFloatFromFN.scala 70:33]
  wire [53:0] cmp64_io_b_rawIn__sig = {1'h0,_cmp64_io_b_rawIn_out_sig_T,_cmp64_io_b_rawIn_out_sig_T_2}; // @[rawFloatFromFN.scala 70:27]
  wire [2:0] _cmp64_io_b_T_1 = cmp64_io_b_rawIn_isZero ? 3'h0 : cmp64_io_b_rawIn__sExp[11:9]; // @[recFNFromFN.scala 48:15]
  wire [2:0] _GEN_24 = {{2'd0}, cmp64_io_b_rawIn__isNaN}; // @[recFNFromFN.scala 48:76]
  wire [2:0] _cmp64_io_b_T_3 = _cmp64_io_b_T_1 | _GEN_24; // @[recFNFromFN.scala 48:76]
  wire [12:0] _cmp64_io_b_T_6 = {cmp64_io_b_rawIn_sign,_cmp64_io_b_T_3,cmp64_io_b_rawIn__sExp[8:0]}; // @[recFNFromFN.scala 49:45]
  wire  isCmp = held_op >= 7'h20 & held_op < 7'h26; // @[AecFpUnit.scala 292:42]
  wire  isCmpP = held_op >= 7'h28 & held_op < 7'h2e; // @[AecFpUnit.scala 293:44]
  wire [6:0] _cmpMode_T_1 = held_op - 7'h28; // @[AecFpUnit.scala 294:37]
  wire [6:0] _cmpMode_T_3 = held_op - 7'h20; // @[AecFpUnit.scala 294:65]
  wire [6:0] cmpMode = isCmpP ? _cmpMode_T_1 : _cmpMode_T_3; // @[AecFpUnit.scala 294:20]
  wire  _cmpTrue_T_1 = 4'ha == held_dtype ? cmp16_io_eq : cmp32_io_eq; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_3 = 4'hb == held_dtype ? cmp32_io_eq : _cmpTrue_T_1; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_5 = 4'h9 == held_dtype ? cmp64_io_eq : _cmpTrue_T_3; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_6 = ~cmp32_io_eq; // @[AecFpUnit.scala 297:34]
  wire  _cmpTrue_T_7 = ~cmp16_io_eq; // @[AecFpUnit.scala 297:62]
  wire  _cmpTrue_T_9 = ~cmp64_io_eq; // @[AecFpUnit.scala 297:109]
  wire  _cmpTrue_T_11 = 4'ha == held_dtype ? _cmpTrue_T_7 : _cmpTrue_T_6; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_13 = 4'hb == held_dtype ? _cmpTrue_T_6 : _cmpTrue_T_11; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_15 = 4'h9 == held_dtype ? _cmpTrue_T_9 : _cmpTrue_T_13; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_17 = 4'ha == held_dtype ? cmp16_io_lt : cmp32_io_lt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_19 = 4'hb == held_dtype ? cmp32_io_lt : _cmpTrue_T_17; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_21 = 4'h9 == held_dtype ? cmp64_io_lt : _cmpTrue_T_19; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_22 = cmp32_io_lt | cmp32_io_eq; // @[AecFpUnit.scala 299:46]
  wire  _cmpTrue_T_23 = cmp16_io_lt | cmp16_io_eq; // @[AecFpUnit.scala 299:87]
  wire  _cmpTrue_T_25 = cmp64_io_lt | cmp64_io_eq; // @[AecFpUnit.scala 299:162]
  wire  _cmpTrue_T_27 = 4'ha == held_dtype ? _cmpTrue_T_23 : _cmpTrue_T_22; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_29 = 4'hb == held_dtype ? _cmpTrue_T_22 : _cmpTrue_T_27; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_31 = 4'h9 == held_dtype ? _cmpTrue_T_25 : _cmpTrue_T_29; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_33 = 4'ha == held_dtype ? cmp16_io_gt : cmp32_io_gt; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_35 = 4'hb == held_dtype ? cmp32_io_gt : _cmpTrue_T_33; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_37 = 4'h9 == held_dtype ? cmp64_io_gt : _cmpTrue_T_35; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_38 = cmp32_io_gt | cmp32_io_eq; // @[AecFpUnit.scala 301:46]
  wire  _cmpTrue_T_39 = cmp16_io_gt | cmp16_io_eq; // @[AecFpUnit.scala 301:87]
  wire  _cmpTrue_T_41 = cmp64_io_gt | cmp64_io_eq; // @[AecFpUnit.scala 301:162]
  wire  _cmpTrue_T_43 = 4'ha == held_dtype ? _cmpTrue_T_39 : _cmpTrue_T_38; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_45 = 4'hb == held_dtype ? _cmpTrue_T_38 : _cmpTrue_T_43; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_47 = 4'h9 == held_dtype ? _cmpTrue_T_41 : _cmpTrue_T_45; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_51 = 7'h1 == cmpMode ? _cmpTrue_T_15 : 7'h0 == cmpMode & _cmpTrue_T_5; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_53 = 7'h2 == cmpMode ? _cmpTrue_T_21 : _cmpTrue_T_51; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_55 = 7'h3 == cmpMode ? _cmpTrue_T_31 : _cmpTrue_T_53; // @[Mux.scala 81:58]
  wire  _cmpTrue_T_57 = 7'h4 == cmpMode ? _cmpTrue_T_37 : _cmpTrue_T_55; // @[Mux.scala 81:58]
  wire  cmpTrue = 7'h5 == cmpMode ? _cmpTrue_T_47 : _cmpTrue_T_57; // @[Mux.scala 81:58]
  wire  aNaN32 = &held_a[30:23] & |held_a[22:0]; // @[AecFpUnit.scala 303:33]
  wire  bNaN32 = &held_b[30:23] & |held_b[22:0]; // @[AecFpUnit.scala 304:33]
  wire  bothZero32 = held_a[30:0] == 31'h0 & held_b[30:0] == 31'h0; // @[AecFpUnit.scala 305:39]
  wire  _minNumeric32_T_2 = held_a[31] | held_b[31]; // @[AecFpUnit.scala 306:50]
  wire [31:0] _minNumeric32_T_3 = {_minNumeric32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _minNumeric32_T_4 = cmp32_io_lt ? held_a[31:0] : held_b[31:0]; // @[AecFpUnit.scala 306:76]
  wire [31:0] minNumeric32 = bothZero32 ? _minNumeric32_T_3 : _minNumeric32_T_4; // @[AecFpUnit.scala 306:25]
  wire  _maxNumeric32_T_2 = held_a[31] & held_b[31]; // @[AecFpUnit.scala 307:50]
  wire [31:0] _maxNumeric32_T_3 = {_maxNumeric32_T_2,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _maxNumeric32_T_4 = cmp32_io_gt ? held_a[31:0] : held_b[31:0]; // @[AecFpUnit.scala 307:76]
  wire [31:0] maxNumeric32 = bothZero32 ? _maxNumeric32_T_3 : _maxNumeric32_T_4; // @[AecFpUnit.scala 307:25]
  wire  _minMax32_T_1 = held_op == 7'h9; // @[AecFpUnit.scala 309:51]
  wire [31:0] _minMax32_T_2 = held_op == 7'h9 ? minNumeric32 : maxNumeric32; // @[AecFpUnit.scala 309:42]
  wire [31:0] _minMax32_T_3 = bNaN32 ? held_a[31:0] : _minMax32_T_2; // @[AecFpUnit.scala 309:25]
  wire [31:0] _minMax32_T_4 = aNaN32 ? held_b[31:0] : _minMax32_T_3; // @[AecFpUnit.scala 309:8]
  wire [31:0] minMax32 = aNaN32 & bNaN32 ? 32'h7fc00000 : _minMax32_T_4; // @[AecFpUnit.scala 308:21]
  wire [94:0] _unarySign_T_3 = isF32 ? 95'h80000000 : 95'h8000; // @[AecFpUnit.scala 310:52]
  wire [126:0] unarySign = isF64 ? 127'h8000000000000000 : {{32'd0}, _unarySign_T_3}; // @[AecFpUnit.scala 310:22]
  wire  _unaryRaw_T = held_op == 7'h8; // @[AecFpUnit.scala 311:30]
  wire [126:0] _unaryRaw_T_1 = ~unarySign; // @[AecFpUnit.scala 311:56]
  wire [126:0] _GEN_25 = {{63'd0}, held_a}; // @[AecFpUnit.scala 311:54]
  wire [126:0] _unaryRaw_T_2 = _GEN_25 & _unaryRaw_T_1; // @[AecFpUnit.scala 311:54]
  wire  _unaryRaw_T_3 = held_op == 7'h7; // @[AecFpUnit.scala 311:80]
  wire [126:0] _unaryRaw_T_4 = _GEN_25 ^ unarySign; // @[AecFpUnit.scala 311:104]
  wire [126:0] _unaryRaw_T_5 = held_op == 7'h7 ? _unaryRaw_T_4 : {{63'd0}, held_a}; // @[AecFpUnit.scala 311:71]
  wire [126:0] unaryRaw = held_op == 7'h8 ? _unaryRaw_T_2 : _unaryRaw_T_5; // @[AecFpUnit.scala 311:21]
  wire [63:0] _unary_T_1 = {32'h0,unaryRaw[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_3 = {48'h0,unaryRaw[15:0]}; // @[Cat.scala 33:92]
  wire [63:0] _unary_T_4 = isF32 ? _unary_T_1 : _unary_T_3; // @[AecFpUnit.scala 312:39]
  wire [126:0] unary = isF64 ? unaryRaw : {{63'd0}, _unary_T_4}; // @[AecFpUnit.scala 312:18]
  wire  isMinMax = _minMax32_T_1 | held_op == 7'ha; // @[AecFpUnit.scala 313:42]
  wire  _oldResult_T = isCmp | isCmpP; // @[AecFpUnit.scala 314:29]
  wire [63:0] _oldResult_T_1 = {63'h0,cmpTrue}; // @[Cat.scala 33:92]
  wire [63:0] _oldResult_T_2 = {32'h0,minMax32}; // @[Cat.scala 33:92]
  wire [126:0] _oldResult_T_3 = isMinMax ? {{63'd0}, _oldResult_T_2} : unary; // @[AecFpUnit.scala 315:8]
  wire [126:0] oldResult = isCmp | isCmpP ? {{63'd0}, _oldResult_T_1} : _oldResult_T_3; // @[AecFpUnit.scala 314:22]
  wire  pipeF64NaNRaw = f64Pipe_io_resp_bits_result[62:52] == 11'h7ff & |f64Pipe_io_resp_bits_result[51:0]; // @[AecFpUnit.scala 320:52]
  wire [63:0] _pipeResult_T = {48'h0,f64DownF16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_1 = pipeF64NaNRaw ? 64'h7e00 : _pipeResult_T; // @[AecFpUnit.scala 327:16]
  wire [63:0] _pipeResult_T_2 = {48'h0,f64DownBf16_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_3 = pipeF64NaNRaw ? 64'h7fc0 : _pipeResult_T_2; // @[AecFpUnit.scala 328:16]
  wire [63:0] _pipeResult_T_4 = {32'h0,f64DownF32_io_result}; // @[Cat.scala 33:92]
  wire [63:0] _pipeResult_T_5 = pipeF64NaNRaw ? 64'h7fc00000 : _pipeResult_T_4; // @[AecFpUnit.scala 329:15]
  wire [63:0] _pipeResult_T_7 = 4'ha == f64Pipe_io_resp_bits_dtype ? _pipeResult_T_1 : f64Pipe_io_resp_bits_result; // @[Mux.scala 81:58]
  wire [63:0] _pipeResult_T_9 = 4'hb == f64Pipe_io_resp_bits_dtype ? _pipeResult_T_3 : _pipeResult_T_7; // @[Mux.scala 81:58]
  wire [63:0] pipeResult = 4'h8 == f64Pipe_io_resp_bits_dtype ? _pipeResult_T_5 : _pipeResult_T_9; // @[Mux.scala 81:58]
  wire  oldPredicate = isCmpP & cmpTrue; // @[AecFpUnit.scala 331:25]
  wire  oldError = ~(_oldResult_T | isMinMax | _unaryRaw_T_3 | _unaryRaw_T); // @[AecFpUnit.scala 332:18]
  wire [126:0] _io_resp_bits_result_T = f64AtHead ? {{63'd0}, pipeResult} : oldResult; // @[AecFpUnit.scala 347:31]
  wire [7:0] held_dest = simpleQ_io_deq_bits_req_dest; // @[AecFpUnit.scala 232:18 267:10]
  YunSuanFmaPipe f64Pipe ( // @[AecFpUnit.scala 203:23]
    .clock(f64Pipe_clock),
    .reset(f64Pipe_reset),
    .io_req_ready(f64Pipe_io_req_ready),
    .io_req_valid(f64Pipe_io_req_valid),
    .io_req_bits_op(f64Pipe_io_req_bits_op),
    .io_req_bits_a(f64Pipe_io_req_bits_a),
    .io_req_bits_b(f64Pipe_io_req_bits_b),
    .io_req_bits_c(f64Pipe_io_req_bits_c),
    .io_req_bits_seq(f64Pipe_io_req_bits_seq),
    .io_req_bits_dest(f64Pipe_io_req_bits_dest),
    .io_req_bits_dtype(f64Pipe_io_req_bits_dtype),
    .io_resp_ready(f64Pipe_io_resp_ready),
    .io_resp_valid(f64Pipe_io_resp_valid),
    .io_resp_bits_result(f64Pipe_io_resp_bits_result),
    .io_resp_bits_fflags(f64Pipe_io_resp_bits_fflags),
    .io_resp_bits_seq(f64Pipe_io_resp_bits_seq),
    .io_resp_bits_dest(f64Pipe_io_resp_bits_dest),
    .io_resp_bits_dtype(f64Pipe_io_resp_bits_dtype)
  );
  Queue_1 issueQ ( // @[AecFpUnit.scala 254:24]
    .clock(issueQ_clock),
    .reset(issueQ_reset),
    .io_enq_ready(issueQ_io_enq_ready),
    .io_enq_valid(issueQ_io_enq_valid),
    .io_enq_bits(issueQ_io_enq_bits),
    .io_deq_ready(issueQ_io_deq_ready),
    .io_deq_valid(issueQ_io_deq_valid),
    .io_deq_bits(issueQ_io_deq_bits)
  );
  Queue_2 simpleQ ( // @[AecFpUnit.scala 255:25]
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
  CompareRecFN cmp16 ( // @[AecFpUnit.scala 281:21]
    .io_a(cmp16_io_a),
    .io_b(cmp16_io_b),
    .io_lt(cmp16_io_lt),
    .io_eq(cmp16_io_eq),
    .io_gt(cmp16_io_gt)
  );
  CompareRecFN_1 cmp32 ( // @[AecFpUnit.scala 281:66]
    .io_a(cmp32_io_a),
    .io_b(cmp32_io_b),
    .io_lt(cmp32_io_lt),
    .io_eq(cmp32_io_eq),
    .io_gt(cmp32_io_gt)
  );
  CompareRecFN_2 cmp64 ( // @[AecFpUnit.scala 281:111]
    .io_a(cmp64_io_a),
    .io_b(cmp64_io_b),
    .io_lt(cmp64_io_lt),
    .io_eq(cmp64_io_eq),
    .io_gt(cmp64_io_gt)
  );
  FPToFP_9 f64DownF16 ( // @[AecFpUnit.scala 316:26]
    .io_in(f64DownF16_io_in),
    .io_result(f64DownF16_io_result)
  );
  FPToFP_10 f64DownBf16 ( // @[AecFpUnit.scala 317:27]
    .io_in(f64DownBf16_io_in),
    .io_result(f64DownBf16_io_result)
  );
  FPToFP_11 f64DownF32 ( // @[AecFpUnit.scala 318:26]
    .io_in(f64DownF32_io_in),
    .io_result(f64DownF32_io_result)
  );
  assign io_req_ready = reqDtypeSupported & issueQ_io_enq_ready & selectedReady; // @[AecFpUnit.scala 260:62]
  assign io_resp_valid = f64AtHead | oldAtHead; // @[AecFpUnit.scala 290:34]
  assign io_resp_bits_result = _io_resp_bits_result_T[63:0]; // @[AecFpUnit.scala 347:25]
  assign io_resp_bits_predicate_result = f64AtHead ? 1'h0 : oldPredicate; // @[AecFpUnit.scala 348:41]
  assign io_resp_bits_dest = f64AtHead ? f64Pipe_io_resp_bits_dest : held_dest; // @[AecFpUnit.scala 349:29]
  assign io_resp_bits_error = f64AtHead ? 1'h0 : oldError; // @[AecFpUnit.scala 350:30]
  assign io_resp_bits_exception_flags = f64AtHead ? f64Pipe_io_resp_bits_fflags : 5'h0; // @[AecFpUnit.scala 351:40]
  assign f64Pipe_clock = clock;
  assign f64Pipe_reset = reset;
  assign f64Pipe_io_req_valid = io_req_valid & reqPipe & reqDtypeSupported & issueQ_io_enq_ready; // @[AecFpUnit.scala 258:74]
  assign f64Pipe_io_req_bits_op = io_req_bits_op; // @[AecFpUnit.scala 223:26]
  assign f64Pipe_io_req_bits_a = io_req_bits_a; // @[AecFpUnit.scala 224:25]
  assign f64Pipe_io_req_bits_b = io_req_bits_b; // @[AecFpUnit.scala 225:25]
  assign f64Pipe_io_req_bits_c = io_req_bits_c; // @[AecFpUnit.scala 226:25]
  assign f64Pipe_io_req_bits_seq = issueSeq; // @[AecFpUnit.scala 228:21 257:13]
  assign f64Pipe_io_req_bits_dest = io_req_bits_dest; // @[AecFpUnit.scala 230:28]
  assign f64Pipe_io_req_bits_dtype = io_req_bits_dtype; // @[AecFpUnit.scala 231:29]
  assign f64Pipe_io_resp_ready = io_resp_ready & f64AtHead; // @[AecFpUnit.scala 291:42]
  assign issueQ_clock = clock;
  assign issueQ_reset = reset;
  assign issueQ_io_enq_valid = io_req_ready & io_req_valid; // @[Decoupled.scala 51:35]
  assign issueQ_io_enq_bits = issueSeq; // @[AecFpUnit.scala 262:24]
  assign issueQ_io_deq_ready = io_resp_ready & io_resp_valid; // @[Decoupled.scala 51:35]
  assign simpleQ_clock = clock;
  assign simpleQ_reset = reset;
  assign simpleQ_io_enq_valid = io_req_valid & ~reqPipe & reqDtypeSupported & issueQ_io_enq_ready; // @[AecFpUnit.scala 263:75]
  assign simpleQ_io_enq_bits_seq = issueSeq; // @[AecFpUnit.scala 264:29]
  assign simpleQ_io_enq_bits_req_op = io_req_bits_op; // @[AecFpUnit.scala 265:29]
  assign simpleQ_io_enq_bits_req_dtype = io_req_bits_dtype; // @[AecFpUnit.scala 265:29]
  assign simpleQ_io_enq_bits_req_a = io_req_bits_a; // @[AecFpUnit.scala 265:29]
  assign simpleQ_io_enq_bits_req_b = io_req_bits_b; // @[AecFpUnit.scala 265:29]
  assign simpleQ_io_enq_bits_req_dest = io_req_bits_dest; // @[AecFpUnit.scala 265:29]
  assign simpleQ_io_deq_ready = io_resp_ready & oldAtHead; // @[AecFpUnit.scala 271:43]
  assign cmp16_io_a = {_cmp16_io_a_T_20,cmp16_io_a_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp16_io_b = {_cmp16_io_b_T_20,cmp16_io_b_rawIn__sig[9:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_a = {_cmp32_io_a_T_20,cmp32_io_a_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp32_io_b = {_cmp32_io_b_T_20,cmp32_io_b_rawIn__sig[22:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_a = {_cmp64_io_a_T_6,cmp64_io_a_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign cmp64_io_b = {_cmp64_io_b_T_6,cmp64_io_b_rawIn__sig[51:0]}; // @[recFNFromFN.scala 50:41]
  assign f64DownF16_io_in = f64Pipe_io_resp_bits_result; // @[AecFpUnit.scala 322:20]
  assign f64DownBf16_io_in = f64Pipe_io_resp_bits_result; // @[AecFpUnit.scala 323:21]
  assign f64DownF32_io_in = f64Pipe_io_resp_bits_result; // @[AecFpUnit.scala 324:20]
  always @(posedge clock) begin
    if (reset) begin // @[AecFpUnit.scala 256:27]
      issueSeq <= 6'h0; // @[AecFpUnit.scala 256:27]
    end else if (_issueQ_io_enq_valid_T) begin // @[AecFpUnit.scala 266:24]
      issueSeq <= _issueSeq_T_1; // @[AecFpUnit.scala 266:35]
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
