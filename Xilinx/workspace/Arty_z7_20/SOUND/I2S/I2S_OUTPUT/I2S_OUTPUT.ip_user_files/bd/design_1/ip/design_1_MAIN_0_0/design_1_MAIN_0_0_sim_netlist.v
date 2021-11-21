// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue May 11 08:25:35 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_MAIN_0_0/design_1_MAIN_0_0_sim_netlist.v
// Design      : design_1_MAIN_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_MAIN_0_0,MAIN,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "MAIN,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module design_1_MAIN_0_0
   (CLK,
    RESET,
    MCLK_IN_IBUF,
    BCLK_OUT,
    AUDIO_DATA_OUT,
    LRCLK_OUT,
    SOUND_IN,
    COUNT_OUT,
    GP_OPERATION);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RESET, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RESET, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RESET;
  input MCLK_IN_IBUF;
  output BCLK_OUT;
  output AUDIO_DATA_OUT;
  output LRCLK_OUT;
  input [31:0]SOUND_IN;
  output [31:0]COUNT_OUT;
  input [31:0]GP_OPERATION;

  wire AUDIO_DATA_OUT;
  wire BCLK_OUT;
  wire [31:0]COUNT_OUT;
  wire [31:0]GP_OPERATION;
  wire LRCLK_OUT;
  wire MCLK_IN_IBUF;
  wire RESET;
  wire [31:0]SOUND_IN;

  design_1_MAIN_0_0_MAIN inst
       (.AUDIO_DATA_OUT(AUDIO_DATA_OUT),
        .BCLK_reg_0(BCLK_OUT),
        .COUNT_OUT(COUNT_OUT),
        .GP_OPERATION(GP_OPERATION),
        .LRCLK_OUT(LRCLK_OUT),
        .MCLK_IN_IBUF(MCLK_IN_IBUF),
        .RESET(RESET),
        .SOUND_IN(SOUND_IN[0]));
endmodule

(* ORIG_REF_NAME = "MAIN" *) 
module design_1_MAIN_0_0_MAIN
   (LRCLK_OUT,
    BCLK_reg_0,
    AUDIO_DATA_OUT,
    COUNT_OUT,
    MCLK_IN_IBUF,
    GP_OPERATION,
    SOUND_IN,
    RESET);
  output LRCLK_OUT;
  output BCLK_reg_0;
  output AUDIO_DATA_OUT;
  output [31:0]COUNT_OUT;
  input MCLK_IN_IBUF;
  input [31:0]GP_OPERATION;
  input [0:0]SOUND_IN;
  input RESET;

  wire AUDIO_DATA_OUT;
  wire BCLK_i_1_n_0;
  wire BCLK_i_2_n_0;
  wire BCLK_reg_0;
  wire [31:0]COUNT_OUT;
  wire [31:0]GP_OPERATION;
  wire LRCLK_OUT;
  wire LRCLK_i_1_n_0;
  wire MCLK_IN_IBUF;
  wire RESET;
  wire SDATA_i_10_n_0;
  wire SDATA_i_1_n_0;
  wire SDATA_i_2_n_0;
  wire SDATA_i_3_n_0;
  wire SDATA_i_4_n_0;
  wire SDATA_i_5_n_0;
  wire SDATA_i_6_n_0;
  wire SDATA_i_7_n_0;
  wire SDATA_i_8_n_0;
  wire SDATA_i_9_n_0;
  wire [0:0]SOUND_IN;
  wire [4:1]bclk_cnt;
  wire [4:0]bclk_cnt_0;
  wire \bclk_cnt_reg_n_0_[0] ;
  wire mclk_cnt;
  wire mclk_cnt_i_1_n_0;
  wire \rp[0]_i_1_n_0 ;
  wire \rp[10]_i_1_n_0 ;
  wire \rp[11]_i_1_n_0 ;
  wire \rp[12]_i_1_n_0 ;
  wire \rp[13]_i_1_n_0 ;
  wire \rp[14]_i_1_n_0 ;
  wire \rp[15]_i_1_n_0 ;
  wire \rp[16]_i_1_n_0 ;
  wire \rp[17]_i_1_n_0 ;
  wire \rp[18]_i_1_n_0 ;
  wire \rp[19]_i_1_n_0 ;
  wire \rp[1]_i_1_n_0 ;
  wire \rp[20]_i_1_n_0 ;
  wire \rp[21]_i_1_n_0 ;
  wire \rp[22]_i_1_n_0 ;
  wire \rp[23]_i_1_n_0 ;
  wire \rp[24]_i_1_n_0 ;
  wire \rp[25]_i_1_n_0 ;
  wire \rp[26]_i_1_n_0 ;
  wire \rp[27]_i_1_n_0 ;
  wire \rp[28]_i_1_n_0 ;
  wire \rp[29]_i_1_n_0 ;
  wire \rp[2]_i_1_n_0 ;
  wire \rp[30]_i_1_n_0 ;
  wire \rp[31]_i_1_n_0 ;
  wire \rp[31]_i_2_n_0 ;
  wire \rp[31]_i_3_n_0 ;
  wire \rp[3]_i_1_n_0 ;
  wire \rp[4]_i_1_n_0 ;
  wire \rp[5]_i_1_n_0 ;
  wire \rp[6]_i_1_n_0 ;
  wire \rp[7]_i_1_n_0 ;
  wire \rp[8]_i_1_n_0 ;
  wire \rp[9]_i_1_n_0 ;
  wire \rp_reg[12]_i_2_n_0 ;
  wire \rp_reg[12]_i_2_n_1 ;
  wire \rp_reg[12]_i_2_n_2 ;
  wire \rp_reg[12]_i_2_n_3 ;
  wire \rp_reg[12]_i_2_n_4 ;
  wire \rp_reg[12]_i_2_n_5 ;
  wire \rp_reg[12]_i_2_n_6 ;
  wire \rp_reg[12]_i_2_n_7 ;
  wire \rp_reg[16]_i_2_n_0 ;
  wire \rp_reg[16]_i_2_n_1 ;
  wire \rp_reg[16]_i_2_n_2 ;
  wire \rp_reg[16]_i_2_n_3 ;
  wire \rp_reg[16]_i_2_n_4 ;
  wire \rp_reg[16]_i_2_n_5 ;
  wire \rp_reg[16]_i_2_n_6 ;
  wire \rp_reg[16]_i_2_n_7 ;
  wire \rp_reg[20]_i_2_n_0 ;
  wire \rp_reg[20]_i_2_n_1 ;
  wire \rp_reg[20]_i_2_n_2 ;
  wire \rp_reg[20]_i_2_n_3 ;
  wire \rp_reg[20]_i_2_n_4 ;
  wire \rp_reg[20]_i_2_n_5 ;
  wire \rp_reg[20]_i_2_n_6 ;
  wire \rp_reg[20]_i_2_n_7 ;
  wire \rp_reg[24]_i_2_n_0 ;
  wire \rp_reg[24]_i_2_n_1 ;
  wire \rp_reg[24]_i_2_n_2 ;
  wire \rp_reg[24]_i_2_n_3 ;
  wire \rp_reg[24]_i_2_n_4 ;
  wire \rp_reg[24]_i_2_n_5 ;
  wire \rp_reg[24]_i_2_n_6 ;
  wire \rp_reg[24]_i_2_n_7 ;
  wire \rp_reg[28]_i_2_n_0 ;
  wire \rp_reg[28]_i_2_n_1 ;
  wire \rp_reg[28]_i_2_n_2 ;
  wire \rp_reg[28]_i_2_n_3 ;
  wire \rp_reg[28]_i_2_n_4 ;
  wire \rp_reg[28]_i_2_n_5 ;
  wire \rp_reg[28]_i_2_n_6 ;
  wire \rp_reg[28]_i_2_n_7 ;
  wire \rp_reg[31]_i_4_n_2 ;
  wire \rp_reg[31]_i_4_n_3 ;
  wire \rp_reg[31]_i_4_n_5 ;
  wire \rp_reg[31]_i_4_n_6 ;
  wire \rp_reg[31]_i_4_n_7 ;
  wire \rp_reg[4]_i_2_n_0 ;
  wire \rp_reg[4]_i_2_n_1 ;
  wire \rp_reg[4]_i_2_n_2 ;
  wire \rp_reg[4]_i_2_n_3 ;
  wire \rp_reg[4]_i_2_n_4 ;
  wire \rp_reg[4]_i_2_n_5 ;
  wire \rp_reg[4]_i_2_n_6 ;
  wire \rp_reg[4]_i_2_n_7 ;
  wire \rp_reg[8]_i_2_n_0 ;
  wire \rp_reg[8]_i_2_n_1 ;
  wire \rp_reg[8]_i_2_n_2 ;
  wire \rp_reg[8]_i_2_n_3 ;
  wire \rp_reg[8]_i_2_n_4 ;
  wire \rp_reg[8]_i_2_n_5 ;
  wire \rp_reg[8]_i_2_n_6 ;
  wire \rp_reg[8]_i_2_n_7 ;
  wire [3:2]\NLW_rp_reg[31]_i_4_CO_UNCONNECTED ;
  wire [3:3]\NLW_rp_reg[31]_i_4_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    BCLK_i_1
       (.I0(mclk_cnt),
        .I1(BCLK_reg_0),
        .O(BCLK_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    BCLK_i_2
       (.I0(RESET),
        .O(BCLK_i_2_n_0));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    BCLK_reg
       (.C(MCLK_IN_IBUF),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(BCLK_i_1_n_0),
        .Q(BCLK_reg_0));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    LRCLK_i_1
       (.I0(bclk_cnt[4]),
        .I1(bclk_cnt[2]),
        .I2(\bclk_cnt_reg_n_0_[0] ),
        .I3(bclk_cnt[1]),
        .I4(bclk_cnt[3]),
        .I5(LRCLK_OUT),
        .O(LRCLK_i_1_n_0));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    LRCLK_reg
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(LRCLK_i_1_n_0),
        .Q(LRCLK_OUT));
  LUT5 #(
    .INIT(32'h00000002)) 
    SDATA_i_1
       (.I0(SDATA_i_2_n_0),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(SDATA_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    SDATA_i_10
       (.I0(GP_OPERATION[13]),
        .I1(GP_OPERATION[12]),
        .I2(GP_OPERATION[15]),
        .I3(GP_OPERATION[14]),
        .O(SDATA_i_10_n_0));
  LUT6 #(
    .INIT(64'hD555555500000000)) 
    SDATA_i_2
       (.I0(\bclk_cnt_reg_n_0_[0] ),
        .I1(bclk_cnt[1]),
        .I2(bclk_cnt[2]),
        .I3(bclk_cnt[3]),
        .I4(bclk_cnt[4]),
        .I5(SOUND_IN),
        .O(SDATA_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    SDATA_i_3
       (.I0(GP_OPERATION[18]),
        .I1(GP_OPERATION[19]),
        .I2(GP_OPERATION[16]),
        .I3(GP_OPERATION[17]),
        .I4(SDATA_i_7_n_0),
        .O(SDATA_i_3_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    SDATA_i_4
       (.I0(GP_OPERATION[26]),
        .I1(GP_OPERATION[27]),
        .I2(GP_OPERATION[24]),
        .I3(GP_OPERATION[25]),
        .I4(SDATA_i_8_n_0),
        .O(SDATA_i_4_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    SDATA_i_5
       (.I0(GP_OPERATION[2]),
        .I1(GP_OPERATION[3]),
        .I2(GP_OPERATION[0]),
        .I3(GP_OPERATION[1]),
        .I4(SDATA_i_9_n_0),
        .O(SDATA_i_5_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    SDATA_i_6
       (.I0(GP_OPERATION[10]),
        .I1(GP_OPERATION[11]),
        .I2(GP_OPERATION[8]),
        .I3(GP_OPERATION[9]),
        .I4(SDATA_i_10_n_0),
        .O(SDATA_i_6_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    SDATA_i_7
       (.I0(GP_OPERATION[21]),
        .I1(GP_OPERATION[20]),
        .I2(GP_OPERATION[23]),
        .I3(GP_OPERATION[22]),
        .O(SDATA_i_7_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    SDATA_i_8
       (.I0(GP_OPERATION[29]),
        .I1(GP_OPERATION[28]),
        .I2(GP_OPERATION[31]),
        .I3(GP_OPERATION[30]),
        .O(SDATA_i_8_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    SDATA_i_9
       (.I0(GP_OPERATION[4]),
        .I1(GP_OPERATION[5]),
        .I2(GP_OPERATION[7]),
        .I3(GP_OPERATION[6]),
        .O(SDATA_i_9_n_0));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    SDATA_reg
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(SDATA_i_1_n_0),
        .Q(AUDIO_DATA_OUT));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \bclk_cnt[0]_i_1 
       (.I0(\bclk_cnt_reg_n_0_[0] ),
        .O(bclk_cnt_0[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \bclk_cnt[1]_i_1 
       (.I0(bclk_cnt[1]),
        .I1(\bclk_cnt_reg_n_0_[0] ),
        .O(bclk_cnt_0[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \bclk_cnt[2]_i_1 
       (.I0(bclk_cnt[1]),
        .I1(\bclk_cnt_reg_n_0_[0] ),
        .I2(bclk_cnt[2]),
        .O(bclk_cnt_0[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \bclk_cnt[3]_i_1 
       (.I0(bclk_cnt[2]),
        .I1(\bclk_cnt_reg_n_0_[0] ),
        .I2(bclk_cnt[1]),
        .I3(bclk_cnt[3]),
        .O(bclk_cnt_0[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \bclk_cnt[4]_i_1 
       (.I0(bclk_cnt[3]),
        .I1(bclk_cnt[1]),
        .I2(\bclk_cnt_reg_n_0_[0] ),
        .I3(bclk_cnt[2]),
        .I4(bclk_cnt[4]),
        .O(bclk_cnt_0[4]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \bclk_cnt_reg[0] 
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(bclk_cnt_0[0]),
        .Q(\bclk_cnt_reg_n_0_[0] ));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \bclk_cnt_reg[1] 
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(bclk_cnt_0[1]),
        .Q(bclk_cnt[1]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \bclk_cnt_reg[2] 
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(bclk_cnt_0[2]),
        .Q(bclk_cnt[2]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \bclk_cnt_reg[3] 
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(bclk_cnt_0[3]),
        .Q(bclk_cnt[3]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \bclk_cnt_reg[4] 
       (.C(BCLK_reg_0),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(bclk_cnt_0[4]),
        .Q(bclk_cnt[4]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    mclk_cnt_i_1
       (.I0(mclk_cnt),
        .O(mclk_cnt_i_1_n_0));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    mclk_cnt_reg
       (.C(MCLK_IN_IBUF),
        .CE(1'b1),
        .CLR(BCLK_i_2_n_0),
        .D(mclk_cnt_i_1_n_0),
        .Q(mclk_cnt));
  LUT5 #(
    .INIT(32'h00000001)) 
    \rp[0]_i_1 
       (.I0(SDATA_i_3_n_0),
        .I1(SDATA_i_4_n_0),
        .I2(SDATA_i_5_n_0),
        .I3(SDATA_i_6_n_0),
        .I4(COUNT_OUT[0]),
        .O(\rp[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[10]_i_1 
       (.I0(\rp_reg[12]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[11]_i_1 
       (.I0(\rp_reg[12]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[12]_i_1 
       (.I0(\rp_reg[12]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[13]_i_1 
       (.I0(\rp_reg[16]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[14]_i_1 
       (.I0(\rp_reg[16]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[15]_i_1 
       (.I0(\rp_reg[16]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[16]_i_1 
       (.I0(\rp_reg[16]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[17]_i_1 
       (.I0(\rp_reg[20]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[18]_i_1 
       (.I0(\rp_reg[20]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[19]_i_1 
       (.I0(\rp_reg[20]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[1]_i_1 
       (.I0(\rp_reg[4]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[20]_i_1 
       (.I0(\rp_reg[20]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[21]_i_1 
       (.I0(\rp_reg[24]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[22]_i_1 
       (.I0(\rp_reg[24]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[23]_i_1 
       (.I0(\rp_reg[24]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[24]_i_1 
       (.I0(\rp_reg[24]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[25]_i_1 
       (.I0(\rp_reg[28]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[26]_i_1 
       (.I0(\rp_reg[28]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[27]_i_1 
       (.I0(\rp_reg[28]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[28]_i_1 
       (.I0(\rp_reg[28]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[29]_i_1 
       (.I0(\rp_reg[31]_i_4_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[2]_i_1 
       (.I0(\rp_reg[4]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[30]_i_1 
       (.I0(\rp_reg[31]_i_4_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \rp[31]_i_1 
       (.I0(SDATA_i_3_n_0),
        .I1(SDATA_i_4_n_0),
        .I2(SDATA_i_5_n_0),
        .I3(SDATA_i_6_n_0),
        .I4(\rp[31]_i_3_n_0 ),
        .O(\rp[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[31]_i_2 
       (.I0(\rp_reg[31]_i_4_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \rp[31]_i_3 
       (.I0(bclk_cnt[3]),
        .I1(bclk_cnt[1]),
        .I2(\bclk_cnt_reg_n_0_[0] ),
        .I3(bclk_cnt[2]),
        .I4(bclk_cnt[4]),
        .O(\rp[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[3]_i_1 
       (.I0(\rp_reg[4]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[4]_i_1 
       (.I0(\rp_reg[4]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[5]_i_1 
       (.I0(\rp_reg[8]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[6]_i_1 
       (.I0(\rp_reg[8]_i_2_n_6 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[7]_i_1 
       (.I0(\rp_reg[8]_i_2_n_5 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[8]_i_1 
       (.I0(\rp_reg[8]_i_2_n_4 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \rp[9]_i_1 
       (.I0(\rp_reg[12]_i_2_n_7 ),
        .I1(SDATA_i_3_n_0),
        .I2(SDATA_i_4_n_0),
        .I3(SDATA_i_5_n_0),
        .I4(SDATA_i_6_n_0),
        .O(\rp[9]_i_1_n_0 ));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[0] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[0]_i_1_n_0 ),
        .Q(COUNT_OUT[0]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[10] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[10]_i_1_n_0 ),
        .Q(COUNT_OUT[10]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[11] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[11]_i_1_n_0 ),
        .Q(COUNT_OUT[11]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[12] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[12]_i_1_n_0 ),
        .Q(COUNT_OUT[12]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[12]_i_2 
       (.CI(\rp_reg[8]_i_2_n_0 ),
        .CO({\rp_reg[12]_i_2_n_0 ,\rp_reg[12]_i_2_n_1 ,\rp_reg[12]_i_2_n_2 ,\rp_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[12]_i_2_n_4 ,\rp_reg[12]_i_2_n_5 ,\rp_reg[12]_i_2_n_6 ,\rp_reg[12]_i_2_n_7 }),
        .S(COUNT_OUT[12:9]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[13] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[13]_i_1_n_0 ),
        .Q(COUNT_OUT[13]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[14] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[14]_i_1_n_0 ),
        .Q(COUNT_OUT[14]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[15] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[15]_i_1_n_0 ),
        .Q(COUNT_OUT[15]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[16] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[16]_i_1_n_0 ),
        .Q(COUNT_OUT[16]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[16]_i_2 
       (.CI(\rp_reg[12]_i_2_n_0 ),
        .CO({\rp_reg[16]_i_2_n_0 ,\rp_reg[16]_i_2_n_1 ,\rp_reg[16]_i_2_n_2 ,\rp_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[16]_i_2_n_4 ,\rp_reg[16]_i_2_n_5 ,\rp_reg[16]_i_2_n_6 ,\rp_reg[16]_i_2_n_7 }),
        .S(COUNT_OUT[16:13]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[17] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[17]_i_1_n_0 ),
        .Q(COUNT_OUT[17]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[18] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[18]_i_1_n_0 ),
        .Q(COUNT_OUT[18]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[19] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[19]_i_1_n_0 ),
        .Q(COUNT_OUT[19]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[1] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[1]_i_1_n_0 ),
        .Q(COUNT_OUT[1]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[20] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[20]_i_1_n_0 ),
        .Q(COUNT_OUT[20]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[20]_i_2 
       (.CI(\rp_reg[16]_i_2_n_0 ),
        .CO({\rp_reg[20]_i_2_n_0 ,\rp_reg[20]_i_2_n_1 ,\rp_reg[20]_i_2_n_2 ,\rp_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[20]_i_2_n_4 ,\rp_reg[20]_i_2_n_5 ,\rp_reg[20]_i_2_n_6 ,\rp_reg[20]_i_2_n_7 }),
        .S(COUNT_OUT[20:17]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[21] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[21]_i_1_n_0 ),
        .Q(COUNT_OUT[21]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[22] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[22]_i_1_n_0 ),
        .Q(COUNT_OUT[22]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[23] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[23]_i_1_n_0 ),
        .Q(COUNT_OUT[23]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[24] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[24]_i_1_n_0 ),
        .Q(COUNT_OUT[24]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[24]_i_2 
       (.CI(\rp_reg[20]_i_2_n_0 ),
        .CO({\rp_reg[24]_i_2_n_0 ,\rp_reg[24]_i_2_n_1 ,\rp_reg[24]_i_2_n_2 ,\rp_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[24]_i_2_n_4 ,\rp_reg[24]_i_2_n_5 ,\rp_reg[24]_i_2_n_6 ,\rp_reg[24]_i_2_n_7 }),
        .S(COUNT_OUT[24:21]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[25] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[25]_i_1_n_0 ),
        .Q(COUNT_OUT[25]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[26] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[26]_i_1_n_0 ),
        .Q(COUNT_OUT[26]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[27] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[27]_i_1_n_0 ),
        .Q(COUNT_OUT[27]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[28] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[28]_i_1_n_0 ),
        .Q(COUNT_OUT[28]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[28]_i_2 
       (.CI(\rp_reg[24]_i_2_n_0 ),
        .CO({\rp_reg[28]_i_2_n_0 ,\rp_reg[28]_i_2_n_1 ,\rp_reg[28]_i_2_n_2 ,\rp_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[28]_i_2_n_4 ,\rp_reg[28]_i_2_n_5 ,\rp_reg[28]_i_2_n_6 ,\rp_reg[28]_i_2_n_7 }),
        .S(COUNT_OUT[28:25]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[29] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[29]_i_1_n_0 ),
        .Q(COUNT_OUT[29]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[2] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[2]_i_1_n_0 ),
        .Q(COUNT_OUT[2]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[30] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[30]_i_1_n_0 ),
        .Q(COUNT_OUT[30]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[31] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[31]_i_2_n_0 ),
        .Q(COUNT_OUT[31]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[31]_i_4 
       (.CI(\rp_reg[28]_i_2_n_0 ),
        .CO({\NLW_rp_reg[31]_i_4_CO_UNCONNECTED [3:2],\rp_reg[31]_i_4_n_2 ,\rp_reg[31]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_rp_reg[31]_i_4_O_UNCONNECTED [3],\rp_reg[31]_i_4_n_5 ,\rp_reg[31]_i_4_n_6 ,\rp_reg[31]_i_4_n_7 }),
        .S({1'b0,COUNT_OUT[31:29]}));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[3] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[3]_i_1_n_0 ),
        .Q(COUNT_OUT[3]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[4] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[4]_i_1_n_0 ),
        .Q(COUNT_OUT[4]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\rp_reg[4]_i_2_n_0 ,\rp_reg[4]_i_2_n_1 ,\rp_reg[4]_i_2_n_2 ,\rp_reg[4]_i_2_n_3 }),
        .CYINIT(COUNT_OUT[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[4]_i_2_n_4 ,\rp_reg[4]_i_2_n_5 ,\rp_reg[4]_i_2_n_6 ,\rp_reg[4]_i_2_n_7 }),
        .S(COUNT_OUT[4:1]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[5] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[5]_i_1_n_0 ),
        .Q(COUNT_OUT[5]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[6] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[6]_i_1_n_0 ),
        .Q(COUNT_OUT[6]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[7] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[7]_i_1_n_0 ),
        .Q(COUNT_OUT[7]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[8] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[8]_i_1_n_0 ),
        .Q(COUNT_OUT[8]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \rp_reg[8]_i_2 
       (.CI(\rp_reg[4]_i_2_n_0 ),
        .CO({\rp_reg[8]_i_2_n_0 ,\rp_reg[8]_i_2_n_1 ,\rp_reg[8]_i_2_n_2 ,\rp_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\rp_reg[8]_i_2_n_4 ,\rp_reg[8]_i_2_n_5 ,\rp_reg[8]_i_2_n_6 ,\rp_reg[8]_i_2_n_7 }),
        .S(COUNT_OUT[8:5]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \rp_reg[9] 
       (.C(BCLK_reg_0),
        .CE(\rp[31]_i_1_n_0 ),
        .CLR(BCLK_i_2_n_0),
        .D(\rp[9]_i_1_n_0 ),
        .Q(COUNT_OUT[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
