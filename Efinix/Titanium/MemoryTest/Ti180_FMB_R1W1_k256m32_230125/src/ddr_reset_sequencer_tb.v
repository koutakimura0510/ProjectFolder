/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2019 Efinix Inc. All rights reserved.
//
// Description:
//
// Efinix soft logic DDR system reset controller
//
// The Trion DDR controller block, (instantiated in the Interface Designer),
// has three input pins for reset control.  (when I2C calibration not enabled)
//
//     Master Reset (active low)
//     Sequencer Reset (active high)
//     Sequencer Start (active high)
//
// This Verilog module generates outputs that can directly
// connect to these pins, given a single reset signal and a clock.
//
// The module also generates a "done" status signal, to inform user system
// when reset + DDR-reinitialization is completed, and read/write operations
// to the DDR AXI interfaces may resume.  The user should define
// FREQ parameter to correspond to frequency of their clock signal.
//
// NOTE #1:  This reset sequencer resets and re-initializes both the DDR
//           interface of the Trion device, as well as the DDR module(s)
//           themselves.
//
// NOTE #2:  The user is not expected to pulse reset upon device configuration
//           and initial entry to user mode.  During the configuration process
//           DDR reset and initialization will be triggered automatically.  This
//           soft logic reset is only required if the user needs to reset
//           the DDR system again while maintaining the Trion device in user mode.
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
/////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module ddr_reset_sequencer_tb;

localparam lpCycle = 2;

reg rRST = 1'b1;
reg rCLK = 1'b0;

always
begin
	#(lpCycle/2);
	rCLK = ~rCLK;
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
wire w_ddr_axi_rstn;
wire w_ddr_cfg_seq_rst;
wire w_ddr_cfg_seq_start;
wire w_ddr_init_done;

ddr_reset_sequencer #(
	.pStartCntBitWidth(3)
) ddr_reset_sequencer (
	.iRST(rRST),
	.iCLK(rCLK),
	.iddr_cfg_done(1'b1),
	.o_ddr_axi_rstn(w_ddr_axi_rstn),
	.o_ddr_cfg_seq_rst(w_ddr_cfg_seq_rst),
	.o_ddr_cfg_seq_start(w_ddr_cfg_seq_start),
	.o_ddr_init_done(w_ddr_init_done)
);


initial
begin
	$dumpfile("ddr_reset_sequencer_tb.vcd");
	$dumpvars(0, ddr_reset_sequencer_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	rRST = 1'b1;
	#(lpCycle*16);
	rRST = 1'b0;
	#(lpCycle*100);
	$finish;
end

endmodule