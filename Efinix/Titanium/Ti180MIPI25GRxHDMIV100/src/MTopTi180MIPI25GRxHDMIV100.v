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
// DPHY interface port
// Controls and Status Signals
output 			MipiDphyRx1_RESET_N,				// Disables PHY and Digital Logic
output 			MipiDphyRx1_RST0_N,					// Async FIFO RST and sync out of RST
input 			MipiDphyRx1_STOPSTATE_CLK,			// Lane in Stop State
input 			MipiDphyRx1_STOPSTATE_LAN0,			// Data Lane in Stop State
input 			MipiDphyRx1_STOPSTATE_LAN1,			// Data Lane in Stop State
input 			MipiDphyRx1_ERR_ESC_LAN0,			// Lane Escape Command Error
input 			MipiDphyRx1_ERR_ESC_LAN1,			// Lane Escape Command Error
input 			MipiDphyRx1_ERR_CONTROL_LAN0,		// Lane Has Line State Error
input 			MipiDphyRx1_ERR_CONTROL_LAN1,		// Lane Has Line State Error
// output 			MipiDphyRx1_TX_REQUEST_ESC,		// Lane0 Request TX Escape Mode , TX_CLK_ESC
// output 			MipiDphyRx1_TURN_REQUEST,		// Lane0 Request Trunaround , TX_CLK_ESC
output 			MipiDphyRx1_FORCE_RX_MODE,
// output	[3:0] 	MipiDphyRx1_TX_TRIGGER_ESC,		// Lane0 Send a Trigger Event , TX_CLK_ESC
input	[3:0] 	MipiDphyRx1_RX_TRIGGER_ESC,			// Lane0 Received Trigger Event , RX_CLK_ESC_LAN
// input 			MipiDphyRx1_DIRECTION,
input 			MipiDphyRx1_ERR_CONTENTION_LP0,		// Lane0 Contention Error when Driving
input 			MipiDphyRx1_ERR_CONTENTION_LP1,		// Lane0 Contention Error when Driving
//
// HS Mode Signals
input 			MipiDphyRx1_RX_CLK_ACTIVE_HS,		// HS Clock Lane Active
input 			MipiDphyRx1_RX_ACTIVE_HS_LAN0,		// HS Reception Active
input 			MipiDphyRx1_RX_ACTIVE_HS_LAN1,		// HS Reception Active
input 			MipiDphyRx1_RX_VALID_HS_LAN0,		// HS Data Receive Valid
input 			MipiDphyRx1_RX_VALID_HS_LAN1,		// HS Data Receive Valid
input 			MipiDphyRx1_RX_SYNC_HS_LAN0,		// HS Reveiver Sync. Observed
input 			MipiDphyRx1_RX_SYNC_HS_LAN1,		// HS Reveiver Sync. Observed
input 			MipiDphyRx1_RX_SKEW_CAL_HS_LAN0,	// HS Reveiver DeSkew Burst Received.
input 			MipiDphyRx1_RX_SKEW_CAL_HS_LAN1,	// HS Reveiver DeSkew Burst Received.
input	[7:0] 	MipiDphyRx1_RX_DATA_HS_LAN0,		// HS Receive Data
input	[7:0] 	MipiDphyRx1_RX_DATA_HS_LAN1,		// HS Receive Data
input 			MipiDphyRx1_ERR_SOT_HS_LAN0,		// State-of-Transmission(SOT)Error
input 			MipiDphyRx1_ERR_SOT_HS_LAN1,
input 			MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0,	// SOT SYnc Error
input 			MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,
//
// LP Mode Signals
input 			MipiDphyRx1_RX_LPDT_ESC,			// Lane enter LPDT RX Mode. , RX_CLK_ESC_LAN0
input	[7:0] 	MipiDphyRx1_RX_DATA_ESC,			// Lane LPDT RX Data , RX_CLK_ESC_LAN0
input 			MipiDphyRx1_RX_VALID_ESC,			// Lane LPDT RX Data Valid , RX_CLK_ESC_LAN0
// input 			MipiDphyRx1_RX_ERR_SYNC_ESC,	// LPDT RX Data Sync Error
// output 			MipiDphyRx1_TX_LPDT_ESC,		// Lane0 Enter LPDT TX Mode , TX_CLK_ESC
// output	[7:0]	MipiDphyRx1_TX_DATA_ESC,		// Lane0 LPDT TX Data , TX_CLK_ESC
// output 			MipiDphyRx1_TX_VALID_ESC,		// Lane0 LPDT TX Data Valid , TX_CLK_ESC
// output 			MipiDphyRx1_TX_READY_ESC,		// Lane0 LPDT TX Data Ready , TX_CLK_ESC
//
// Ultra Low Power Sleep Mode Signals
// output		MipiDphyRx1_TX_ULPS_ESC,				// Lane 0 Enter ULPS Mode. , TX_CLK_ESC
// output		MipiDphyRx1_TX_ULPS_EXIT,				// Lane 0 Exit ULPS Mode. , TX_CLK_ESC
input 			MipiDphyRx1_RX_ULPS_CLK_NOT,			// CLK0 Enter ULPS Mode
input 			MipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT,		// CLK0 is in ULPS (Active Low)
input 			MipiDphyRx1_RX_ULPS_ESC_LAN0,			// Lane n Enter ULPS Mode. RX_CLK_ESC_LANn
input 			MipiDphyRx1_RX_ULPS_ESC_LAN1,			// RX_CLK_ESC_LANn
input 			MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0,	// Lane n is in ULPS (Active Low)
input 			MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,
//
// Clock Domain
// output 		MipiDphyRx1_TX_CFG_CLK,				// Configration CLK
input  			MipiDphyRx1_WORD_CLKOUT_HS,			// HS Receive Byte/Word CLK
input 			MipiDphyRx1_LP_CLK,					// Low Power State CLK
input 			MipiDphyRx1_RX_CLK_ESC_LAN0,			// Escape Mode Receive CLK
input 			MipiDphyRx1_RX_CLK_ESC_LAN1,			// Escape Mode Receive CLK
// output 		MipiDphyRx1_TX_CLK_ESC,				// Escape Mode TX CLK must be lower than 20[MHz]
//
// YCbCr video output for ADV7511(HDMI)
output 			oAdv7511Vs,			// VSYNC pin
output 			oAdv7511Hs,			// HSYNC pin
output 			oAdv7511De,			// Data Enable pin
output	[15:0]	oAdv7511Data,		// YUV Output pin
input			iAdv7511Sda,		// I2C SDA pin
output			oAdv7511SdaOe,		// SDA TriState Sel
input			iAdv7511Scl,		// I2C SCL pin
output			oAdv7511SclOe,		// SCL TriState Sel
//
// User Interface LED, SW
output	[ 5:0] 	oLed,
input  	[ 1:0]	iPushSw,
//
// PLL1 Control
input			iSCLK,				// 100 [MHz]
input			iBCLK,				// 25 [MHz]
input			iPCLK,				// 25 [MHz]
input			iFCLK,				// 200 [MHz]
input			pll_inst1_LOCKED,	// PLL1 Locked
output			pll_inst1_RSTN,		// PLL1 Rst Active Low
//
// PLL2 Control
input			iVCLK,				// 74.25 [MHz]
input			pll_inst2_LOCKED,	// PLL2 Locked
output			pll_inst2_RSTN,		// PLL2 Rst Active Low
//
// TestPort
output	[11:0]	oTestPort,
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
assign 	pll_inst1_RSTN = 1'b1;
assign 	pll_inst2_RSTN = 1'b1;
//
reg 	qLocked;
reg 	rSRST,		rnSRST, 	qSRST,		qnSRST;
reg 	rPRST,		rnPRST, 	qPRST,		qnPRST;
reg 	rFRST,		rnFRST, 	qFRST,		qnFRST;
reg 	rBRST,		rnBRST,		qBRST,		qnBRST;
reg 	rVRST, 		rnVRST,		qVRST,		qnVRST;

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
//
always @(posedge iFCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rFRST  <= 1'b1;
	else if (qLocked)			rFRST  <= 1'b0;
	else 						rFRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnFRST <= 1'b0;
	else if (qLocked)			rnFRST <= 1'b1;
	else 						rnFRST <= 1'b0;
end
//
always @(posedge iBCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rBRST  <= 1'b1;
	else if (qLocked)			rBRST  <= 1'b0;
	else 						rBRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnBRST <= 1'b0;
	else if (qLocked)			rnBRST <= 1'b1;
	else 						rnBRST <= 1'b0;
end
//
always @(posedge iVCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rVRST  <= 1'b1;
	else if (qLocked)			rVRST  <= 1'b0;
	else 						rVRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnVRST <= 1'b0;
	else if (qLocked)			rnVRST <= 1'b1;
	else 						rnVRST <= 1'b0;
end

always @*
begin
	qLocked 	<= &{pll_inst1_LOCKED,pll_inst2_LOCKED};
	qSRST 		<= rSRST;
	qnSRST 		<= rnSRST;
	qPRST 		<= rPRST;
	qnPRST 		<= rnPRST;
	qFRST 		<= rFRST;
	qnFRST 		<= rnFRST;
	qBRST 	 	<= rBRST;
	qnBRST 	 	<= rnBRST;
	qVRST  		<= rVRST;
	qnVRST 		<= rnVRST;
end


//-----------------------------------------------------------------------------
// MIPI DPHY, Axi Logic Part
// VIO で設定したアドレス空間を繰り返し Read する。
//-----------------------------------------------------------------------------
reg 	[31:0]	rAxiRdata;
wire 	[31:0]	wAxiRdata;
reg 			rAxiArvalid, qAxiArvalidCke;
wire 	[5:0]	wAxiAraddr;
wire 			wAxiArready;
wire 			wAxiRvalid;

always @(posedge iSCLK)
begin
	if (qSRST) 					rAxiArvalid <=  1'b0;
	else if (qAxiArvalidCke)	rAxiArvalid <= ~rAxiArvalid;
	else 						rAxiArvalid <=  rAxiArvalid;

	if (wAxiRvalid) 			rAxiRdata <= wAxiRdata;
	else 						rAxiRdata <= rAxiRdata;
end

always @*
begin
	casex ( {rAxiArvalid,wAxiArready} )
	'b0x:		qAxiArvalidCke	<= 1'b1;	// Assert
	'b11:		qAxiArvalidCke	<= 1'b1;	// Diseert
	default:	qAxiArvalidCke	<= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// MIPI DPHY RX
//-----------------------------------------------------------------------------
wire			wMipiRxVd;
wire			wMipiRxHs;
wire			wMipiRxVs;
wire	[63:0] 	wMipiRxPixelData;
wire	[ 5:0]	wMipiRxOutDatatype;
wire 	[15:0]	wMipiRxWordCnt;
wire 	[15:0]	wMipiRxShortpkt;
wire 	[ 3:0]	wMipiRxPCLK;
//
wire 	[15:0]	wVideoData;
wire 			wVideoVd;
wire 			wVideofull;
//
wire 	[11:0]	wHsyncCntMonitor;
wire 	[11:0]	wPplCntMonitor;

MCsiRxController MCsiRxController (
	// CSI controller ouptut I/F port
	.oMipiRxVs(wMipiRxVs),						.oMipiRxHs(wMipiRxHs),
	.oMipiRxVd(wMipiRxVd),						.oMipiRxPixelData(wMipiRxPixelData),
	.oMipiRxOutDatatype(wMipiRxOutDatatype),	.oMipiRxWordCnt(wMipiRxWordCnt),
	.oMipiRxShortpkt(wMipiRxShortpkt),			.oMipiRxPCLK(wMipiRxPCLK),
	// Video Signals
	.oVideoData(wVideoData),
	.oVideoVd(wVideoVd),						.iVideofull(wVideofull),
	// DPHY I/F port
	.iMipiDphyRx1_WORD_CLKOUT_HS			(MipiDphyRx1_WORD_CLKOUT_HS),
	.oMipiDphyRx1_FORCE_RX_MODE				(MipiDphyRx1_FORCE_RX_MODE),
	.oMipiDphyRx1_RESET_N					(MipiDphyRx1_RESET_N),
	.oMipiDphyRx1_RST0_N					(MipiDphyRx1_RST0_N),
	.iMipiDphyRx1_ERR_CONTENTION_LP0		(MipiDphyRx1_ERR_CONTENTION_LP0),
	.iMipiDphyRx1_ERR_CONTENTION_LP1		(MipiDphyRx1_ERR_CONTENTION_LP1),
	.iMipiDphyRx1_ERR_CONTROL_LAN0			(MipiDphyRx1_ERR_CONTROL_LAN0),
	.iMipiDphyRx1_ERR_CONTROL_LAN1			(MipiDphyRx1_ERR_CONTROL_LAN1),
	.iMipiDphyRx1_ERR_ESC_LAN0				(MipiDphyRx1_ERR_ESC_LAN0),
	.iMipiDphyRx1_ERR_ESC_LAN1				(MipiDphyRx1_ERR_ESC_LAN1),
	.iMipiDphyRx1_ERR_SOT_HS_LAN0			(MipiDphyRx1_ERR_SOT_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_HS_LAN1			(MipiDphyRx1_ERR_SOT_HS_LAN1),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0		(MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1		(MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1),
	.iMipiDphyRx1_LP_CLK					(MipiDphyRx1_LP_CLK),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN0			(MipiDphyRx1_RX_ACTIVE_HS_LAN0),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN1			(MipiDphyRx1_RX_ACTIVE_HS_LAN1),
	.iMipiDphyRx1_RX_CLK_ACTIVE_HS			(MipiDphyRx1_RX_CLK_ACTIVE_HS),
	.iMipiDphyRx1_RX_CLK_ESC_LAN0			(MipiDphyRx1_RX_CLK_ESC_LAN0),
	.iMipiDphyRx1_RX_CLK_ESC_LAN1			(MipiDphyRx1_RX_CLK_ESC_LAN1),
	.iMipiDphyRx1_RX_DATA_ESC				(MipiDphyRx1_RX_DATA_ESC),
	.iMipiDphyRx1_RX_DATA_HS_LAN0			(MipiDphyRx1_RX_DATA_HS_LAN0),
	.iMipiDphyRx1_RX_DATA_HS_LAN1			(MipiDphyRx1_RX_DATA_HS_LAN1),
	.iMipiDphyRx1_RX_LPDT_ESC				(MipiDphyRx1_RX_LPDT_ESC),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0		(MipiDphyRx1_RX_SKEW_CAL_HS_LAN0),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1		(MipiDphyRx1_RX_SKEW_CAL_HS_LAN1),
	.iMipiDphyRx1_RX_SYNC_HS_LAN0			(MipiDphyRx1_RX_SYNC_HS_LAN0),
	.iMipiDphyRx1_RX_SYNC_HS_LAN1			(MipiDphyRx1_RX_SYNC_HS_LAN1),
	.iMipiDphyRx1_RX_TRIGGER_ESC			(MipiDphyRx1_RX_TRIGGER_ESC),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT	(MipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0	(MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1	(MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1),
	.iMipiDphyRx1_RX_ULPS_CLK_NOT			(MipiDphyRx1_RX_ULPS_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN0			(MipiDphyRx1_RX_ULPS_ESC_LAN0),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN1			(MipiDphyRx1_RX_ULPS_ESC_LAN1),
	.iMipiDphyRx1_RX_VALID_ESC				(MipiDphyRx1_RX_VALID_ESC),
	.iMipiDphyRx1_RX_VALID_HS_LAN0			(MipiDphyRx1_RX_VALID_HS_LAN0),
	.iMipiDphyRx1_RX_VALID_HS_LAN1			(MipiDphyRx1_RX_VALID_HS_LAN1),
	.iMipiDphyRx1_STOPSTATE_CLK				(MipiDphyRx1_STOPSTATE_CLK),
	.iMipiDphyRx1_STOPSTATE_LAN0			(MipiDphyRx1_STOPSTATE_LAN0),
	.iMipiDphyRx1_STOPSTATE_LAN1			(MipiDphyRx1_STOPSTATE_LAN1),
	// AXI4-Lite Interface
	.axi_awaddr(4'b0),					.axi_awvalid(1'b0),
	.axi_awready(),						.axi_wdata(32'b0),
	.axi_wvalid(1'b0),					.axi_wready(),
	.axi_bvalid(),						.axi_bready(1'b0),
	.axi_araddr(wAxiAraddr),			.axi_arvalid(rAxiArvalid),
	.axi_arready(wAxiArready),
	.axi_rdata(wAxiRdata),
	.axi_rvalid(wAxiRvalid),			.axi_rready(1'b1),
	.axi_clk(iSCLK), 					.axi_reset_n(qnSRST),
	// Status
	.oHsyncCntMonitor(wHsyncCntMonitor),
	.oPplCntMonitor(wPplCntMonitor),
	// Common
	.iSRST(qSRST),						.inSRST(qnSRST),
	.iPRST(qPRST),						.inPRST(qnPRST),
	.iFRST(qFRST),						.inFRST(qnFRST),
	.iSCLK(iSCLK),						.iPCLK(iPCLK),
	.iFCLK(iFCLK)
);


//-----------------------------------------------------------------------------
// HDMI Output part
//-----------------------------------------------------------------------------
localparam 			lpVideoMaxHRES	= 11'd1920;
localparam 			lpVideoMaxVRES	= 11'd1080;
localparam 			lpVideoHSP		= 8'd44;
localparam 			lpVideoHBP		= 8'd148;
localparam 			lpVideoHFP		= 8'd88;
localparam 			lpVideoVSP		= 6'd5;
localparam 			lpVideoVBP		= 6'd36;
localparam 			lpVideoVFP		= 6'd4;

wire 		wAdv7511Vs;			assign oAdv7511Vs 	= wAdv7511Vs;
wire 		wAdv7511Hs;			assign oAdv7511Hs 	= wAdv7511Hs;
wire 		wAdv7511De;			assign oAdv7511De 	= wAdv7511De;
wire [15:0]	wAdv7511Data;		assign oAdv7511Data = wAdv7511Data;

MVideoPostProcess #(
	.pVideoMaxHRES(lpVideoMaxHRES),	.pVideoHBP(lpVideoHBP),
	.pVideoHFP(lpVideoHFP),			.pVideoHSP(lpVideoHSP),
	.pVideoMaxVRES(lpVideoMaxVRES),	.pVideoVBP(lpVideoVBP),
	.pVideoVFP(lpVideoVFP),			.pVideoVSP(lpVideoVSP)
) MVideoPostProcess (
	// ADV7511 GPIO
	.oAdv7511Vs(wAdv7511Vs),		.oAdv7511Hs(wAdv7511Hs),
	.oAdv7511De(wAdv7511De),		.oAdv7511Data(wAdv7511Data),
	.iAdv7511Sda(iAdv7511Sda),		.oAdv7511SdaOe(oAdv7511SdaOe),
	.iAdv7511Scl(iAdv7511Scl),		.oAdv7511SclOe(oAdv7511SclOe),
	// Video Signal
	.iVideoData(wVideoData),
	.iVideoVd(wVideoVd),			.oVideofull(wVideofull),
	// Status
	.iVideoSignalSel(1'b0),
	.i_pll_locked(pll_inst1_LOCKED),
	// common
	.iSRST(qSRST),					.inSRST(qnSRST),
	.iPRST(qPRST),					.inPRST(qnPRST),
	.iVRST(qVRST),					.inVRST(qnVRST),
	.iBRST(qBRST),					.inBRST(qnBRST),
	.iFRST(qFRST),					.inFRST(qnFRST),
	.iSCLK(iSCLK),					.iPCLK(iPCLK),
	.iVCLK(iVCLK),					.iBCLK(iBCLK),
	.iFCLK(iFCLK)
);


//-----------------------------------------------------------------------------
// Debug 信号生成、下記用途用
// Top に入力される PLL が正常に動作しているか確認
// Top に入力される PLL が設定通りの周波数で CLK を生成しているか確認
// Mipi IP の CLK, Sync 信号が動作しているか確認
// TestPort に適当な信号を出力して 拡張ボードと GPIO の割り当てを確認
//-----------------------------------------------------------------------------
localparam lpPulseGenNumber	= 5;						// pulse 生成個数
localparam [32*lpPulseGenNumber-1:0] lpClkDivCnt = {	// 分周値
	32'd5000,
	32'd3,
	32'd5000,
	32'd0,
	32'd30000000
};

wire [lpPulseGenNumber-1:0] wSampling = {
	wMipiRxHs,
	wMipiRxVs,
	wMipiRxVd,
	1'b0,
	1'b1
};
wire [lpPulseGenNumber-1:0] wPulse;
//
genvar n;

generate
begin
	for (n = 0; n < lpPulseGenNumber; n = n + 1)
	begin
		MPulseGenerator #(
			.pCntMax(lpClkDivCnt[32*(n+1)-1:32*n]), .pStartPulse(1'b0)
		) MSPulseGenerator (
			.oPulse(wPulse[n]),	.iSampling(wSampling[n]),
			.iRST(qPRST),		.iCLK(iPCLK)
		);
	end
end
endgenerate


//-----------------------------------------------------------------------------
// TestPort / Led Coonect
//-----------------------------------------------------------------------------
assign oLed[0] = wPulse[0];
assign oLed[1] = wPulse[1];
assign oLed[2] = wPulse[2];
assign oLed[3] = wPulse[3];
assign oLed[4] = wPulse[4];
assign oLed[5] = qLocked;
// FMC to QSE Adapter Card to J3 MIPI and LVDS Expansion Daughter Card
// ※ 一部 回路図・データシートと異なる IO の位置
assign oTestPort[0]  = 1'b0;		// Pin31
assign oTestPort[1]  = 1'b0;		// Pin32
assign oTestPort[2]  = 1'b0;		// Pin33
assign oTestPort[3]  = 1'b0;		// Pin34
assign oTestPort[4]  = 1'b0;		// Pin37
assign oTestPort[5]  = wAdv7511Hs;	// Pin38 -> Pin40
assign oTestPort[6]  = wAdv7511Vs;	// Pin39 -> Pin37
assign oTestPort[7]  = wAdv7511De;	// Pin40 -> Pin38
assign oTestPort[8]  = 1'b0;		// Pin2
assign oTestPort[9]  = wMipiRxHs;	// Pin4
assign oTestPort[10] = wMipiRxVs;	// Pin7
assign oTestPort[11] = wMipiRxVd;	// Pin8
// Pin5,6,11,12,17,18,23,24,29,30,35,36 = GND


//-----------------------------------------------------------------------------
// VIO
// 手動ロジアナ、VIO を使用する場合は、
// プロジェクトのカレントディレクトリに debug_TEMPLATE.v が生成されるのでコピーして使用する。
// Project Editor -> タブの Debugger 選択 -> Debugger Auto Instantiation のチェックマークを OFF にする。
// Open Debug Wizard の USER2 などで 自動ロジアナ生成をすると自動でチェックマークが ON になるので注意。
// 
// 自動生成のロジアナを使用する場合は、手動生成 module をコメントアウトする
//-----------------------------------------------------------------------------
// edb_top edb_top_inst (
//     .bscan_CAPTURE      ( jtag_inst1_CAPTURE ),
//     .bscan_DRCK         ( jtag_inst1_DRCK ),
//     .bscan_RESET        ( jtag_inst1_RESET ),
//     .bscan_RUNTEST      ( jtag_inst1_RUNTEST ),
//     .bscan_SEL          ( jtag_inst1_SEL ),
//     .bscan_SHIFT        ( jtag_inst1_SHIFT ),
//     .bscan_TCK          ( jtag_inst1_TCK ),
//     .bscan_TDI          ( jtag_inst1_TDI ),
//     .bscan_TMS          ( jtag_inst1_TMS ),
//     .bscan_UPDATE       ( jtag_inst1_UPDATE ),
//     .bscan_TDO          ( jtag_inst1_TDO ),
//     .vio0_clk       	( iSCLK ),
//     .vio0_Axi_rdata    	( rAxiRdata ),
//     .vio0_Axi_araddr   	( wAxiAraddr ),
// 	.vio0_HsyncCnt	   	( wHsyncCntMonitor ),
// 	.vio0_PplCnt	   	( wPplCntMonitor ),
// 	.vio0_Datatype		( wMipiRxOutDatatype ),
// 	.vio0_WordCnt		( wMipiRxWordCnt ),
// 	.vio0_ShortPkt		( wMipiRxShortpkt ),
// 	.vio0_PCLK			( wMipiRxPCLK )
// 	// .vio0_PixelData   	( wMipiRxPixelData )
// );


endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------