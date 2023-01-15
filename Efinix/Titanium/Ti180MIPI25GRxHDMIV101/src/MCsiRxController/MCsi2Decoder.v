/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MCsiRxDecoder.v
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
 * 14/Jan-2023 V1.00 New Release, Inh.fr. "MCsiRxDecoder.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MCsi2Decoder (
// Hard D-PHY Port
// Controls and Status Signals
output 			oMipiDphyRx1_RESET_N,				// Disables PHY and Digital Logic
output 			oMipiDphyRx1_RST0_N,				// Async FIFO RST and sync out of RST
input 			iMipiDphyRx1_STOPSTATE_CLK,			// Lane in Stop State
input 			iMipiDphyRx1_STOPSTATE_LAN0,		// Data Lane in Stop State, Active High
input 			iMipiDphyRx1_STOPSTATE_LAN1,		// Data Lane in Stop State
input 			iMipiDphyRx1_ERR_ESC_LAN0,			// Lane Escape Command Error
input 			iMipiDphyRx1_ERR_ESC_LAN1,			// Lane Escape Command Error
input 			iMipiDphyRx1_ERR_CONTROL_LAN0,		// Lane Has Line State Error
input 			iMipiDphyRx1_ERR_CONTROL_LAN1,		// Lane Has Line State Error
output 			oMipiDphyRx1_TX_REQUEST_ESC,		// Lane0 Request TX Escape Mode , TX_CLK_ESC
output 			oMipiDphyRx1_TURN_REQUEST,			// Lane0 Request Trunaround , TX_CLK_ESC
output 			oMipiDphyRx1_FORCE_RX_MODE,
output	[3:0] 	oMipiDphyRx1_TX_TRIGGER_ESC,		// Lane0 Send a Trigger Event , TX_CLK_ESC
input	[3:0] 	iMipiDphyRx1_RX_TRIGGER_ESC,		// Lane0 Received Trigger Event , RX_CLK_ESC_LAN
input 			iMipiDphyRx1_DIRECTION,
input 			iMipiDphyRx1_ERR_CONTENTION_LP0,	// Lane0 Contention Error when Driving
input 			iMipiDphyRx1_ERR_CONTENTION_LP1,	// Lane0 Contention Error when Driving
//
// HS Mode Signals
input 			iMipiDphyRx1_RX_CLK_ACTIVE_HS,		// HS Clock Lane Active
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN0,		// HS Reception Active
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN1,		// HS Reception Active
input 			iMipiDphyRx1_RX_VALID_HS_LAN0,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_VALID_HS_LAN1,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_SYNC_HS_LAN0,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SYNC_HS_LAN1,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0,	// HS Reveiver DeSkew Burst Received.
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1,	// HS Reveiver DeSkew Burst Received.
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN0,		// HS Receive Data
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN1,		// HS Receive Data
input 			iMipiDphyRx1_ERR_SOT_HS_LAN0,		// State-of-Transmission(SOT)Error
input 			iMipiDphyRx1_ERR_SOT_HS_LAN1,
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0,	// SOT SYnc Error
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,
//
// LP Mode Signals
input 			iMipiDphyRx1_RX_LPDT_ESC,			// Lane enter LPDT RX Mode. , RX_CLK_ESC_LAN0
input	[7:0] 	iMipiDphyRx1_RX_DATA_ESC,			// Lane LPDT RX Data , RX_CLK_ESC_LAN0
input 			iMipiDphyRx1_RX_VALID_ESC,			// Lane LPDT RX Data Valid , RX_CLK_ESC_LAN0
input 			iMipiDphyRx1_RX_ERR_SYNC_ESC,		// LPDT RX Data Sync Error
output 			oMipiDphyRx1_TX_LPDT_ESC,			// Lane0 Enter LPDT TX Mode , TX_CLK_ESC
output	[7:0]	oMipiDphyRx1_TX_DATA_ESC,			// Lane0 LPDT TX Data , TX_CLK_ESC
output 			oMipiDphyRx1_TX_VALID_ESC,			// Lane0 LPDT TX Data Valid , TX_CLK_ESC
output 			oMipiDphyRx1_TX_READY_ESC,			// Lane0 LPDT TX Data Ready , TX_CLK_ESC
//
// Ultra Low Power Sleep Mode Signals
output			oMipiDphyRx1_TX_ULPS_ESC,				// Lane 0 Enter ULPS Mode. , TX_CLK_ESC
output			oMipiDphyRx1_TX_ULPS_EXIT,				// Lane 0 Exit ULPS Mode. , TX_CLK_ESC
input 			iMipiDphyRx1_RX_ULPS_CLK_NOT,			// CLK0 Enter ULPS Mode
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT,	// CLK0 is in ULPS (Active Low)
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN0,			// Lane n Enter ULPS Mode. RX_CLK_ESC_LANn
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN1,			// RX_CLK_ESC_LANn
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0,	// Lane n is in ULPS (Active Low)
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,
//
// Clock Domain
// output 			oMipiDphyRx1_TX_CFG_CLK,			// Configration CLK
input  			iMipiDphyRx1_WORD_CLKOUT_HS,			// HS Receive Byte/Word CLK
input 			iMipiDphyRx1_LP_CLK,					// Low Power State CLK
input 			iMipiDphyRx1_RX_CLK_ESC_LAN0,			// Escape Mode Receive CLK
input 			iMipiDphyRx1_RX_CLK_ESC_LAN1,			// Escape Mode Receive CLK
output 			oMipiDphyRx1_TX_CLK_ESC,				// Escape Mode TX CLK must be lower than 20[MHz]
//
// CSI controller ouptut interface port
output	[31:0] 	oHsPixel,
output	[ 5:0] 	oHsDatatype,
output	[15:0] 	oHsWordCnt,
output	[ 7:0] 	oHsEcc,
output			oHsValid,
//
input 			iEdv,
//
// CLK,RST
input			iSRST,
input			inSRST,
input			iSCLK
);
  

//-----------------------------------------------------------------------------
// HS mode Decoder State Machine
// 各Lane はタイミングが同じで出力される前提
//-----------------------------------------------------------------------------
reg 	qnHsRst;
reg 	r

always @(posedge iMipiDphyRx1_WORD_CLKOUT_HS, negedge qnHsRst)
begin
	rDataLane[0] <= iMipiDphyRx1_RX_DATA_HS_LAN0;
	rDataLane[1] <= iMipiDphyRx1_RX_DATA_HS_LAN1;
end

always @*
begin
	qWidthMaxCke <= ((rHsWordCnt[15:1]-1'b1) == rFrameWidthCnt);
end


//-----------------------------------------------------------------------------
// Fifo Side
//-----------------------------------------------------------------------------
localparam lpFtiFifoBitWidth	= 16;
localparam lpFtiFifoDepth		= 8192 / lpFtiFifoBitWidth;
localparam lpFtiFifoBitLoop		= 32   / lpFtiFifoBitWidth;
localparam lpFtiFifoFullAlMost	= 2;

wire [31:0] 				wFtiRd;							assign oHsPixel = wFtiRd;
wire [lpFtiFifoBitLoop-1:0]	wFtiRvd;						assign oHsValid = wFtiRvd[0];
reg  						qFtiRe;
wire [lpFtiFifoBitLoop-1:0]	wFtiEmp;
wire [lpFtiFifoBitLoop-1:0]	wFtifull;

genvar n;

generate
	for (n = 0; n < lpFtiFifoBitLoop; n = n + 1) begin
		fifoController #(
			.pFifoDepth(lpFtiFifoDepth),	.pFifoBitWidth(lpFtiFifoBitWidth),
			.pFullAlMost(lpFtiFifoFullAlMost)
		) mVideoFIFO (
			// Write Side
			.iWd(rHsPixel[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]),
			.iWe(rHsValid),					.ofull(wFtifull[n]),
			// Read Side
			.oRd(wFtiRd[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]),
			.iRe(qFtiRe),
			.oRvd(wFtiRvd[n]),				.oEmp(wFtiEmp[n]),
			// common
			.iCLK(iMipiDphyRx1_WORD_CLKOUT_HS),	.inRST(qnHsRst)
		);
	end
endgenerate

always @*
begin
	qFtiRe		<= iEdv & (~wFtiEmp[0]);
end


//-----------------------------------------------------------------------------
// Hs Mode CLK,RST
//-----------------------------------------------------------------------------
assign oMipiDphyRx1_RESET_N			= inSRST;
assign oMipiDphyRx1_RST0_N			= inSRST;
// unused
assign oMipiDphyRx1_FORCE_RX_MODE	= 1'b0; // 用途不明
assign oMipiDphyRx1_TX_REQUEST_ESC	= 1'b0;
assign oMipiDphyRx1_TURN_REQUEST	= 1'b0;
assign oMipiDphyRx1_TX_TRIGGER_ESC  = 4'd0;
assign oMipiDphyRx1_TX_LPDT_ESC		= 1'b0;
assign oMipiDphyRx1_TX_DATA_ESC		= 8'd0;
assign oMipiDphyRx1_TX_VALID_ESC	= 1'b0;
assign oMipiDphyRx1_TX_READY_ESC	= 1'b0;
assign oMipiDphyRx1_TX_ULPS_ESC		= 1'b0;
assign oMipiDphyRx1_TX_ULPS_EXIT	= 1'b0;
assign oMipiDphyRx1_TX_CLK_ESC		= 1'b0;
wire [25:0] wUnused = {
	iMipiDphyRx1_STOPSTATE_CLK,
	iMipiDphyRx1_RX_TRIGGER_ESC[3:0],
	iMipiDphyRx1_DIRECTION,
	iMipiDphyRx1_ERR_CONTENTION_LP0,
	iMipiDphyRx1_ERR_CONTENTION_LP1,
	iMipiDphyRx1_RX_CLK_ACTIVE_HS,
	iMipiDphyRx1_RX_ACTIVE_HS_LAN0,
	iMipiDphyRx1_RX_ACTIVE_HS_LAN1,
	iMipiDphyRx1_ERR_SOT_HS_LAN0,
	iMipiDphyRx1_ERR_SOT_HS_LAN1,
	iMipiDphyRx1_RX_LPDT_ESC,
	iMipiDphyRx1_RX_DATA_ESC[7:0],
	iMipiDphyRx1_RX_VALID_ESC,
	iMipiDphyRx1_RX_ERR_SYNC_ESC,
	iMipiDphyRx1_LP_CLK
};


always @*
begin
	qnHsRst		 <= inSRST;
end


endmodule