/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MCsiRxDecoder.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
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
input  			iMipiDphyRx1_TX_READY_ESC,			// Lane0 LPDT TX Data Ready , TX_CLK_ESC
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
output	[ 1:0] 	oHsVc,
output	[ 1:0] 	oHsVcx,
output			oHsValid,
// Flow Controll
output 			oCddFifoFull,
input 			iEdv,
//
// CLK,RST
input			iSRST,
input			inSRST,
input			iSCLK
);

//-----------------------------------------------------------------------------
// HS Mode ステートマシン
// 各 Lnae は同期している前提
//-----------------------------------------------------------------------------
reg [7:0] 	rDphyHsDataLane0;
reg [7:0] 	rDphyHsDataLane1;
reg 		rDphyHsDataLaneLs;
reg 		rDphyHsDataLaneVd;
// reg 		rDphyHsSotSyncLan;	// Sot Error
reg 		rDphyHsSotSyncLan;	// Sot Sync Error
reg 		rDphyHsStopState;	// Rst に使用

always @(posedge iMipiDphyRx1_WORD_CLKOUT_HS, negedge qnHsRst)
begin
	if (!qnHsRst)
	begin
		rDphyHsDataLane0   	<= 8'd0;
		rDphyHsDataLane1   	<= 8'd0;
		rDphyHsDataLaneLs  	<= 1'b0;
		rDphyHsDataLaneVd  	<= 1'b0;
		rDphyHsStopState   	<= 1'b1;
	end
	else
	begin
		rDphyHsDataLane0   	<= iMipiDphyRx1_RX_DATA_HS_LAN0;
		rDphyHsDataLane1   	<= iMipiDphyRx1_RX_DATA_HS_LAN1;
		rDphyHsDataLaneLs  	<= iMipiDphyRx1_RX_SYNC_HS_LAN0;
		rDphyHsDataLaneVd  	<= iMipiDphyRx1_RX_VALID_HS_LAN0 | iMipiDphyRx1_RX_SYNC_HS_LAN0;
		rDphyHsStopState	<= iMipiDphyRx1_STOPSTATE_LAN0;
	end
end


//-----------------------------------------------------------------------------
// Csi2Decoder DualClkFifo
//-----------------------------------------------------------------------------
localparam lpFtiFifoBitWidth	= 20;
localparam lpFtiFifoDepth		= 2048;
localparam lpFtiFifoFullAlMost	= 2;

reg  [lpFtiFifoBitWidth*2-1:0] 	qFtiWd;
reg 						 	qFtiWe;
wire [1:0]					 	wFtifull;						assign oCddFifoFull = wFtifull[0];
wire [lpFtiFifoBitWidth*2-1:0] 	wFtiRd;
reg  						 	qFtiLs;
reg  						 	qFtiRe;
wire [1:0]					 	wFtiRvd;
wire [1:0]					 	wFtiEmp;
reg							 	qnFdcSRst, qnHsRst;

genvar n;

generate
	for (n = 0; n < 1; n = n + 1)
	begin
		fifoDualController #(
			.pFifoDepth(lpFtiFifoDepth),	.pFifoBitWidth(lpFtiFifoBitWidth),
			.pFullAlMost(lpFtiFifoFullAlMost)
		) Csi2DecoderDualClkFifo (
			// Write Side
			.iWd(qFtiWd[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]),
			.iWe(qFtiWe),		.ofull(wFtifull[n]),
			.iWCLK(iMipiDphyRx1_WORD_CLKOUT_HS),
			.iWnRST(qnHsRst),
			// Read Side
			.oRd({wFtiRd[(n+1)*lpFtiFifoBitWidth-1:n*lpFtiFifoBitWidth]}),
			.iRe(qFtiRe),
			.oRvd(wFtiRvd[n]),	.oEmp(wFtiEmp[n]),
			.iRCLK(iSCLK),		.iRnRST(qnFdcSRst)
		);
	end
endgenerate

always @*
begin
	qFtiWd	<= {3'd0, rDphyHsDataLaneLs, rDphyHsDataLane1, rDphyHsDataLane0};
	qFtiWe  <= rDphyHsDataLaneVd;
	qFtiRe	<= &{(~wFtiEmp[0]),iEdv};
	qFtiLs  <= &{wFtiRd[16],wFtiRvd[0]};
	// RST
	qnHsRst <= inSRST;//rDphyHsStopState;
end


//-----------------------------------------------------------------------------
// HS Mode データ取得ステートマシン
//-----------------------------------------------------------------------------
localparam lpStateIdNum	= 3;
localparam [lpStateIdNum-1:0]
	lpRxHsStateIdol = 3'd0,
	lpRxHsState1    = 3'd1,
	lpRxHsState2    = 3'd2,
	lpRxHsState3    = 3'd3,
	lpRxHsState4	= 3'd4,
	lpRxHsStateNum	= 3'd5;
reg [lpStateIdNum-1:0] 		rHsSt;
reg [lpRxHsStateNum-1:0]	qHsStNextCke;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rHsSt <= lpRxHsStateIdol;
	end
	else
	begin
		case (rHsSt)
			lpRxHsStateIdol:	rHsSt <= (qHsStNextCke[0])	? lpRxHsState1    : lpRxHsStateIdol;	// Line Start チェック
			lpRxHsState1:		rHsSt <= (qHsStNextCke[1]) 	? lpRxHsState2    : lpRxHsState1;		// Get Datatype and LSB Wordcnt
			lpRxHsState2:		rHsSt <= (qHsStNextCke[2]) 	? lpRxHsState3    : lpRxHsState2;		// Get MSB Wordcnt and ECC
			lpRxHsState3:		rHsSt <= (qHsStNextCke[3]) 	? lpRxHsState4    : lpRxHsStateIdol;	// Datatype Check
			lpRxHsState4:		rHsSt <= (qHsStNextCke[4]) 	? lpRxHsStateIdol : lpRxHsState4;		// Data 転送
			default:			rHsSt <= lpRxHsStateIdol;
		endcase
	end
end

always @*
begin
	qnFdcSRst <= inSRST;//(rHsSt == lpRxHsStateIdol) ? 1'b0 : 1'b1;
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
localparam lpPixelBitWidth 	= 32;
localparam lpFrameWidthBit  = 13;	// 8K Line

// MIPI Status
reg [lpPixelBitWidth-1:0] rPixel;			assign oHsPixel		= rPixel;
reg [ 5:0] 	rDatatype;						assign oHsDatatype 	= rDatatype;
reg [15:0] 	rWordcnt;						assign oHsWordCnt 	= rWordcnt;
reg [ 7:0] 	rEcc;							assign oHsEcc 		= rEcc;
reg [ 1:0]  rVc;							assign oVc			= oVc;
reg [ 1:0]  rVcx;							assign oVcx			= oVcx;
reg 		rHsValid;						assign oHsValid 	= rHsValid;
// CLK Enable
reg 		qHsValidCke;
reg 		qWordCntLsb, qWordCntMsb;
reg 		qDatatypeCheck, qDatatypeCke;
reg 		qEccCke;
// Line Cnt
reg [lpFrameWidthBit-1:0]	rFrameWidthCnt;
reg 						qLineCntRst, qLineCntCke, qLineCntMaxCke;

always @(posedge iSCLK)
begin
	rPixel <= {16'd0, wFtiRd[15:0]};

	case ({qWordCntMsb,qWordCntLsb})
	2'b01:	 rWordcnt <= {rWordcnt[15:8], wFtiRd[15:8]};
	2'b10:	 rWordcnt <= {wFtiRd[7:0], rWordcnt[7:0]};
	default: rWordcnt <= rWordcnt;
	endcase

	if (iSRST)				rHsValid <= 1'd0;
	else if (qHsValidCke)	rHsValid <= 1'b1;
	else					rHsValid <= 1'b0;

	if (iSRST)				rDatatype <= 6'd0;
	else if (qDatatypeCke)	rDatatype <= wFtiRd[5:0];
	else					rDatatype <= rDatatype;

	if (iSRST)				rVc <= 2'd0;
	else if (qDatatypeCke)	rVc <= wFtiRd[7:6];
	else					rVc <= rVc;

	if (iSRST)				rEcc <= 8'd0;
	else if (qEccCke)		rEcc <= wFtiRd[15:8];
	else					rEcc <= rEcc;

	if (qLineCntRst)		rFrameWidthCnt <= {lpFrameWidthBit{1'b0}};
	else if (qLineCntCke)	rFrameWidthCnt <= rFrameWidthCnt + 1'b1;
	else					rFrameWidthCnt <= rFrameWidthCnt;

	rVcx <= 2'd0;
end

always @*
begin
	// Wordcnt
	case (rHsSt)
		lpRxHsState2:	qWordCntMsb <= 1'b1;
		default:		qWordCntMsb <= 1'b0;
	endcase

	case (rHsSt)
		lpRxHsState1:	qWordCntLsb <= 1'b1;
		default:		qWordCntLsb <= 1'b0;
	endcase
	// Datatype
	case (rHsSt)
		lpRxHsState1:	qDatatypeCke <= 1'b1;
		default:		qDatatypeCke <= 1'b0;
	endcase
	// ECC
	case (rHsSt)
		lpRxHsState2:	qEccCke <= 1'b1;
		default:		qEccCke <= 1'b0;
	endcase
	// Datatype Check 時に、データ受信があればそのまま転送する
	casex ({qDatatypeCheck,wFtiRvd[0],rHsSt})
		{1'b1,1'b1,lpRxHsState3}:	qHsValidCke <= 1'b1;
		{1'bx,1'b1,lpRxHsState4}:	qHsValidCke <= 1'b1;
		default:					qHsValidCke <= 1'b0;
	endcase
	//
	qDatatypeCheck  <= (6'h13 < rDatatype);
	//
	qLineCntRst 	<= |{iSRST,qLineCntMaxCke};
	qLineCntMaxCke  <= &{((rWordcnt[15:1]-1'b1) == rFrameWidthCnt),wFtiRvd[0]} ? 1'b1 : 1'b0; // 1920 x YUV4228bit = F00

	case ({wFtiRvd[0],rHsSt})
		{1'b1,lpRxHsState3}:	qLineCntCke <= 1'b1;
		{1'b1,lpRxHsState4}:	qLineCntCke <= 1'b1;
		default:				qLineCntCke <= 1'b0;
	endcase
	//
	qHsStNextCke[0] <= qFtiLs;
	qHsStNextCke[1] <= wFtiRvd[0];
	qHsStNextCke[2] <= wFtiRvd[0];
	qHsStNextCke[3] <= qDatatypeCheck;
	qHsStNextCke[4] <= qLineCntMaxCke;
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
assign oMipiDphyRx1_TX_ULPS_ESC		= 1'b0;
assign oMipiDphyRx1_TX_ULPS_EXIT	= 1'b0;
assign oMipiDphyRx1_TX_CLK_ESC		= 1'b0;

wire [26:0] wUnused = {
	iMipiDphyRx1_TX_READY_ESC,
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
	// LP Signals
	iMipiDphyRx1_RX_LPDT_ESC,
	iMipiDphyRx1_RX_DATA_ESC[7:0],
	iMipiDphyRx1_RX_VALID_ESC,
	iMipiDphyRx1_RX_ERR_SYNC_ESC,
	iMipiDphyRx1_LP_CLK
};


endmodule