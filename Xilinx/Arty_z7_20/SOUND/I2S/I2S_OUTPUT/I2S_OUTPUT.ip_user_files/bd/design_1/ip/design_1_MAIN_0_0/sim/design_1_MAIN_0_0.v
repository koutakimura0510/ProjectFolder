// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:MAIN:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_MAIN_0_0 (
  CLK,
  RESET,
  MCLK_IN_IBUF,
  BCLK_OUT,
  AUDIO_DATA_OUT,
  LRCLK_OUT,
  SOUND_IN,
  COUNT_OUT,
  GP_OPERATION
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RESET, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
input wire CLK;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RESET, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RESET RST" *)
input wire RESET;
input wire MCLK_IN_IBUF;
output wire BCLK_OUT;
output wire AUDIO_DATA_OUT;
output wire LRCLK_OUT;
input wire [31 : 0] SOUND_IN;
output wire [31 : 0] COUNT_OUT;
input wire [31 : 0] GP_OPERATION;

  MAIN #(
    .MAX_MCLK_COUNT(1),
    .MAX_BCLK_COUNT(31),
    .BCLK_COUNT_SIZE(5),
    .BCLK_COUNT(6'B000001),
    .FIFO_HEIGHT(31),
    .FIFO_WIDTH(31),
    .FIFO_POS_NUM(5),
    .PLAY_START(16)
  ) inst (
    .CLK(CLK),
    .RESET(RESET),
    .MCLK_IN_IBUF(MCLK_IN_IBUF),
    .BCLK_OUT(BCLK_OUT),
    .AUDIO_DATA_OUT(AUDIO_DATA_OUT),
    .LRCLK_OUT(LRCLK_OUT),
    .SOUND_IN(SOUND_IN),
    .COUNT_OUT(COUNT_OUT),
    .GP_OPERATION(GP_OPERATION)
  );
endmodule
