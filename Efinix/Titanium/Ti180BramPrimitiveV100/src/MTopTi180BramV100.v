/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MTopTi180MIPI25GRxHDMIV100.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MTopTi180MIPI25GRxHDMIV100.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MTopTi180MIPI25GRxHDMIV100 (
//
// User Interface LED, SW
output	[ 5:0] 	oLed,
input  	[ 1:0]	iPushSw,
//
// PLL1 Control
input			iSCLK,				// 100 [MHz]
input			iPCLK,				// 25 [MHz]
input			iPll2Locked,		// PLL1 Locked
output			oPll2nRst,		// PLL1 Rst Active Low
//
// Jtag I/F
input  			jtag_inst1_TDI,
input  			jtag_inst1_TCK,
input  			jtag_inst1_TMS,
output 			jtag_inst1_TDO,
input  			jtag_inst1_SEL,
input  			jtag_inst1_DRCK,
input  			jtag_inst1_RUNTEST,
input  			jtag_inst1_CAPTURE,
input  			jtag_inst1_SHIFT,
input  			jtag_inst1_UPDATE,
input  			jtag_inst1_RESET
);


//-----------------------------------------------------------------------------
// RST 生成
//-----------------------------------------------------------------------------
assign 	oPll2nRst = 1'b1;
//
reg 	qLocked;
reg 	rSRST,		rnSRST, 	qSRST,		qnSRST;
reg 	rPRST,		rnPRST, 	qPRST,		qnPRST;

always @(posedge iSCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rSRST  <= 1'b1;
	else if (qLocked)			rSRST  <= 1'b0;
	else 						rSRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnSRST <= 1'b0;
	else if (qLocked)			rnSRST <= 1'b1;
	else 						rnSRST <= 1'b0;
end
//
always @(posedge iPCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rPRST  <= 1'b1;
	else if (qLocked)			rPRST  <= 1'b0;
	else 						rPRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnPRST <= 1'b0;
	else if (qLocked)			rnPRST <= 1'b1;
	else 						rnPRST <= 1'b0;
end

always @*
begin
	qLocked 	<= iPll2Locked;
	qSRST 		<= rSRST;
	qnSRST 		<= rnSRST;
	qPRST 		<= rPRST;
	qnPRST 		<= rnPRST;
end

//-----------------------------------------------------------------------------
// BRAM Core
//-----------------------------------------------------------------------------




endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------