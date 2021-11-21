// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue May 11 08:25:35 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_MAIN_0_0/design_1_MAIN_0_0_stub.v
// Design      : design_1_MAIN_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "MAIN,Vivado 2020.2" *)
module design_1_MAIN_0_0(CLK, RESET, MCLK_IN_IBUF, BCLK_OUT, 
  AUDIO_DATA_OUT, LRCLK_OUT, SOUND_IN, COUNT_OUT, GP_OPERATION)
/* synthesis syn_black_box black_box_pad_pin="CLK,RESET,MCLK_IN_IBUF,BCLK_OUT,AUDIO_DATA_OUT,LRCLK_OUT,SOUND_IN[31:0],COUNT_OUT[31:0],GP_OPERATION[31:0]" */;
  input CLK;
  input RESET;
  input MCLK_IN_IBUF;
  output BCLK_OUT;
  output AUDIO_DATA_OUT;
  output LRCLK_OUT;
  input [31:0]SOUND_IN;
  output [31:0]COUNT_OUT;
  input [31:0]GP_OPERATION;
endmodule
