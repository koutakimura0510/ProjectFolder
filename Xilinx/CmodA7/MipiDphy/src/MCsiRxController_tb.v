/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MCsiRxController.v
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
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MCsiRxController.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MCsiRxController_tb;


//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam 	lpSCLK = 4;
localparam 	lpMCLK = 6;
localparam 	lpRstTime = lpMCLK * 2;

wire 		wSCLK, wMCLK;
reg  		rSRST, rnSRST;

SimSystemClk #(.pSystemClkCycle	(lpSCLK)) SimSclk (.oSysClk (wSCLK));
SimSystemClk #(.pSystemClkCycle	(lpMCLK)) SimMclk (.oSysClk (wMCLK));

task system_reset();
begin
	rSRST  <= 1'b1;
	rnSRST <= 1'b0;
	#(lpRstTime);
	rSRST  <= 1'b0;
	rnSRST <= 1'b1;
	#(lpRstTime);
end
endtask


//-----------------------------------------------------------------------------
// MIPI D-PHY 信号生成
//-----------------------------------------------------------------------------
wire [7:0] 	wDphyHsDataLane0;
wire [7:0] 	wDphyHsDataLane1;
wire 		wDphyHsDataLaneLs;
wire 		wDphyHsDataLaneVd;

MMipiDphyGen_tb MMipiDphyGen_tb(
	.oDphyHsDataLane0(wDphyHsDataLane0),
	.oDphyHsDataLane1(wDphyHsDataLane1),
	.oDphyHsDataLaneLs(wDphyHsDataLaneLs),
	.oDphyHsDataLaneVd(wDphyHsDataLaneVd),
	.iRST(rSRST),
	.iMCLK(wMCLK)
);


//-----------------------------------------------------------------------------
// MIPI DPHY RX
//-----------------------------------------------------------------------------
wire [31:0] wHsPixel;
wire [ 5:0] wHsDatatype;
wire [15:0] wHsWordCnt;
wire [ 7:0] wHsEcc;
wire [ 1:0]	wHsVc;
wire [ 1:0]	wHsVcx;
wire 		wHsValid;

MCsi2Decoder MCsi2Decoder (
	// Hard D-PHY Port
	// Controls and Status Signals
	.oMipiDphyRx1_RESET_N					(),
	.oMipiDphyRx1_RST0_N					(),
	.iMipiDphyRx1_STOPSTATE_CLK				(1'b0),
	.iMipiDphyRx1_STOPSTATE_LAN0			(1'b0),
	.iMipiDphyRx1_STOPSTATE_LAN1			(1'b0),
	.iMipiDphyRx1_ERR_ESC_LAN0				(1'b0),
	.iMipiDphyRx1_ERR_ESC_LAN1				(1'b0),
	.iMipiDphyRx1_ERR_CONTROL_LAN0			(1'b0),
	.iMipiDphyRx1_ERR_CONTROL_LAN1			(1'b0),
	.oMipiDphyRx1_TX_REQUEST_ESC			(),
	.oMipiDphyRx1_TURN_REQUEST				(),
	.oMipiDphyRx1_FORCE_RX_MODE				(),
	.oMipiDphyRx1_TX_TRIGGER_ESC			(),
	.iMipiDphyRx1_RX_TRIGGER_ESC			(1'b0),
	.iMipiDphyRx1_DIRECTION					(1'b0),
	.iMipiDphyRx1_ERR_CONTENTION_LP0		(1'b0),
	.iMipiDphyRx1_ERR_CONTENTION_LP1		(1'b0),
	// HS Mode Signals
	.iMipiDphyRx1_RX_CLK_ACTIVE_HS			(1'b0),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN0			(1'b0),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN1			(1'b0),
	.iMipiDphyRx1_RX_VALID_HS_LAN0			(wDphyHsDataLaneVs),
	.iMipiDphyRx1_RX_VALID_HS_LAN1			(wDphyHsDataLaneVs),
	.iMipiDphyRx1_RX_SYNC_HS_LAN0			(wDphyHsDataLaneLs),
	.iMipiDphyRx1_RX_SYNC_HS_LAN1			(wDphyHsDataLaneLs),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0		(1'b0),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1		(1'b0),
	.iMipiDphyRx1_RX_DATA_HS_LAN0			(wDphyHsDataLane0),
	.iMipiDphyRx1_RX_DATA_HS_LAN1			(wDphyHsDataLane1),
	.iMipiDphyRx1_ERR_SOT_HS_LAN0			(1'b0),
	.iMipiDphyRx1_ERR_SOT_HS_LAN1			(1'b0),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0		(1'b0),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1		(1'b0),
	// LP Mode Signals
	.iMipiDphyRx1_RX_LPDT_ESC				(1'b0),
	.iMipiDphyRx1_RX_DATA_ESC				(8'd0),
	.iMipiDphyRx1_RX_VALID_ESC				(1'b0),
	.iMipiDphyRx1_RX_ERR_SYNC_ESC			(1'b0),
	.oMipiDphyRx1_TX_LPDT_ESC				(),
	.oMipiDphyRx1_TX_DATA_ESC				(),
	.oMipiDphyRx1_TX_VALID_ESC				(),
	.oMipiDphyRx1_TX_READY_ESC				(),
	// Ultra Low Power Sleep Mode Signals
	.oMipiDphyRx1_TX_ULPS_ESC				(),
	.oMipiDphyRx1_TX_ULPS_EXIT				(),
	.iMipiDphyRx1_RX_ULPS_CLK_NOT			(1'b0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT	(1'b0),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN0			(1'b0),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN1			(1'b0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0	(1'b0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1	(1'b0),
	// Clock Domain
	//oMipiDphyRx1_TX_CFG_CLK(MipiDphyRx1_TX_CFG_CLK),
	.iMipiDphyRx1_WORD_CLKOUT_HS			(wMCLK),
	.iMipiDphyRx1_LP_CLK					(1'b0),
	.iMipiDphyRx1_RX_CLK_ESC_LAN0			(1'b0),
	.iMipiDphyRx1_RX_CLK_ESC_LAN1			(1'b0),
	.oMipiDphyRx1_TX_CLK_ESC				(),
	// Out Pixel
	.oHsPixel(wHsPixel),		.oHsDatatype(wHsDatatype),
	.oHsWordCnt(wHsWordCnt),	.oHsEcc(wHsEcc),
	.oHsVc(wHsVc),				.oHsVcx(wHsVcx),
	.oHsValid(wHsValid),
	//
	// Status
	.iEdv(1'b0),
	//
	// CLK RST
	.iSRST(rSRST),
	.inSRST(rnSRST),
	.iSCLK(rSCLK)
);


initial begin
	system_reset();
	#(lpSCLK * 500 * 4);
    $stop;
end


endmodule