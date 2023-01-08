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
module MCsiRxController #(
	parameter	pMipiRxLaneNumCh1	= 2
)(
// CSI controller ouptut interface port
output			oMipiRxVs,			// Vsync
output			oMipiRxHs,			// HSync
output			oMipiRxVd,			// Data Valid
output	[63:0] 	oMipiRxPixelData,
output	[ 5:0]	oMipiRxOutDatatype,
output 	[15:0]	oMipiRxWordCnt,
output 	[15:0]	oMipiRxShortpkt,
output 	[ 3:0]	oMipiRxPCLK,
// Video Signals
output  [15:0]	oVideoData,
output  		oVideoVd,
input 			iVideofull,
//
// DPHY interface port
// HS Mode Signals Clk Domain WORD_CLKOUT_HS
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN0,		// HS Reception Active
input 			iMipiDphyRx1_RX_ACTIVE_HS_LAN1,		// HS Reception Active
input 			iMipiDphyRx1_RX_CLK_ACTIVE_HS,		// HS Clock Lane Active
input 			iMipiDphyRx1_RX_VALID_HS_LAN0,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_VALID_HS_LAN1,		// HS Data Receive Valid
input 			iMipiDphyRx1_RX_SYNC_HS_LAN0,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SYNC_HS_LAN1,		// HS Reveiver Sync. Observed
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0,	// HS Reveiver DeSkew Burst Received.
input 			iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1,	// HS Reveiver DeSkew Burst Received.
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN0,		// HS Receive Data
input	[7:0] 	iMipiDphyRx1_RX_DATA_HS_LAN1,		// HS Receive Data
input 			iMipiDphyRx1_ERR_SOT_HS_LAN0,
input 			iMipiDphyRx1_ERR_SOT_HS_LAN1,
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0,
input 			iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,
input  			iMipiDphyRx1_WORD_CLKOUT_HS,		// HS Receive Byte/Word CLK
// LP Mode Signals
input 			iMipiDphyRx1_RX_LPDT_ESC,			// Lane enter LPDT RX Mode.
input	[7:0] 	iMipiDphyRx1_RX_DATA_ESC,			// Lane LPDT RX Data
input 			iMipiDphyRx1_RX_VALID_ESC,
input 			iMipiDphyRx1_RX_CLK_ESC_LAN0,		// Escape Mode Receive CLK
input 			iMipiDphyRx1_RX_CLK_ESC_LAN1,		// Escape Mode Receive CLK
input 			iMipiDphyRx1_ERR_CONTROL_LAN0,		// Lane Has Line State Error
input 			iMipiDphyRx1_ERR_CONTROL_LAN1,		// Lane Has Line State Error
input 			iMipiDphyRx1_LP_CLK,				// Low Power State CLK
// Ultra Low Power Sleep Mode Signals
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT,
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0,
input 			iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,
input 			iMipiDphyRx1_RX_ULPS_CLK_NOT,
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN0,
input 			iMipiDphyRx1_RX_ULPS_ESC_LAN1,
// Controls and Status Signals
output 			oMipiDphyRx1_RESET_N,				// Disables PHY and Digital Logic
output 			oMipiDphyRx1_RST0_N,				// Async FIFO RST and sync out of RST
input 			iMipiDphyRx1_STOPSTATE_CLK,			// Lane in Stop State
input 			iMipiDphyRx1_STOPSTATE_LAN0,		// Data Lane in Stop State
input 			iMipiDphyRx1_STOPSTATE_LAN1,		// Data Lane in Stop State
input 			iMipiDphyRx1_ERR_ESC_LAN0,			// Lane Escape Command Error
input 			iMipiDphyRx1_ERR_ESC_LAN1,			// Lane Escape Command Error
// input 			iMipiDphyRx1_TX_REQUEST_ESC,
// input 			iMipiDphyRx1_TURN_REQUEST,
output 			oMipiDphyRx1_FORCE_RX_MODE,
// input	[3:0] 	iMipiDphyRx1_TX_TRIGGER_ESC,
input	[3:0] 	iMipiDphyRx1_RX_TRIGGER_ESC,		// Lane Received Trigger Event
input 			iMipiDphyRx1_ERR_CONTENTION_LP0,	// Lane Contention Error when Driving
input 			iMipiDphyRx1_ERR_CONTENTION_LP1,	// Lane Contention Error when Driving
//
// AXI4-Lite Interface
input 			axi_rready,
output 			axi_rvalid,
output	[31:0] 	axi_rdata,
output 			axi_arready,
input 			axi_arvalid,
input 	[5:0] 	axi_araddr,
input 			axi_bready,
output 			axi_bvalid,
output 			axi_wready,
input 			axi_wvalid,
input 	[31:0] 	axi_wdata,
output 			axi_awready,
input 	[5:0] 	axi_awaddr,
input 			axi_awvalid,
input 			axi_reset_n,
input 			axi_clk,
//
// Status
output 	[11:0]	oHsyncCntMonitor,
output 	[11:0]	oPplCntMonitor,
output 			oCdcFifoFull,
//
// Clk,Rst
input			iSRST,
input			inSRST,
input			iPRST,
input			inPRST,
input			iFRST,
input			inFRST,
input			iSCLK,
input			iPCLK,
input			iFCLK
);
  
//-----------------------------------------------------------------------------
// YUV422 8bit
// [63:56] Y4
// [55:48] V3
// [47:40] Y3
// [39:32] U3
// [31:24] Y2
// [23:16] V1
// [15: 8] Y1
// [ 7: 0] U0
// 
// ※1Lane 8bit の場合、CSI2.5G SoftIP 生成時に 16bit 指定になっている。
// 　define.vh・IPname.sv(今回は mCsiIpCOre) のソースの手動変更が必要になるので注意
// 
// データシートに記載はないが下記フォーマットでレジスタ値確認。
// PixelPerClock・DataType が恐らく正常に出力されているので正しそうではある。
// Raw16 = 0x2e
// Raw20 = 0x2f 
// 
//-----------------------------------------------------------------------------
assign oMipiDphyRx1_FORCE_RX_MODE	= 1'b0; // 用途不明
assign oMipiDphyRx1_RESET_N			= qIpCorerHsnRST;
assign oMipiDphyRx1_RST0_N			= inSRST;
//
reg qIpCorerHsnRST;
//
wire			wMipiRxVd;					assign oMipiRxVd	 		= wMipiRxVd;
wire			wMipiRxVs;					assign oMipiRxVs	 		= wMipiRxVs;
wire			wMipiRxHs;					assign oMipiRxHs	 		= wMipiRxHs;
wire	[63:0]	wMipiRxData;				assign oMipiRxPixelData		= wMipiRxData;
wire 	[15:0]	wMipiRxWordCnt;				assign oMipiRxWordCnt 		= wMipiRxWordCnt;
wire	[ 5:0]	wMipiRxDatatype;			assign oMipiRxOutDatatype 	= wMipiRxDatatype;
wire 	[15:0]	wMipiRxShortpkt;			assign oMipiRxShortpkt		= wMipiRxShortpkt;
wire 	[ 3:0]	wMipiRxPCLK;				assign oMipiRxPCLK			= wMipiRxPCLK;		// 用途不明-Byte bit?
//
wire 	[ 1:0] 	wRxClkEsc			= {iMipiDphyRx1_RX_CLK_ESC_LAN1,iMipiDphyRx1_RX_CLK_ESC_LAN0};
wire 	[ 1:0] 	wRxErrEsc			= {iMipiDphyRx1_ERR_ESC_LAN1,iMipiDphyRx1_ERR_ESC_LAN0};
wire 	[ 1:0] 	wRxErrControl		= {iMipiDphyRx1_ERR_CONTROL_LAN1,iMipiDphyRx1_ERR_CONTROL_LAN0};
wire 	[ 1:0] 	wRxErrSotSyncHS		= {iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0};
wire 			wRxUlpsClkNot		=  iMipiDphyRx1_RX_ULPS_CLK_NOT;
wire 			wRxUlpsActiveClkNot	=  iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT;
wire 	[ 1:0] 	wRxUlpsEsc			= {iMipiDphyRx1_RX_ULPS_ESC_LAN1,iMipiDphyRx1_RX_ULPS_ESC_LAN0};
wire 	[ 1:0] 	wRxUlpsActiveNot	= {iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0};
wire 	[ 1:0] 	wRxSkewCalHS		= {iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1,iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0};
wire 	[ 1:0] 	wRxStopState		= {iMipiDphyRx1_STOPSTATE_LAN1,iMipiDphyRx1_STOPSTATE_LAN0};
wire 	[ 1:0] 	wRxSyncHS			= {iMipiDphyRx1_RX_SYNC_HS_LAN1,iMipiDphyRx1_RX_SYNC_HS_LAN0};

mCsiIpCore mCsiIpCore (
	// DPHY I/F
	.RxDataHS0(iMipiDphyRx1_RX_DATA_HS_LAN0),		.RxDataHS1(iMipiDphyRx1_RX_DATA_HS_LAN1),
	.RxDataHS2(),									.RxDataHS3(),
	.RxDataHS4(),									.RxDataHS5(),
	.RxDataHS6(),									.RxDataHS7(),
	.RxValidHS0(iMipiDphyRx1_RX_VALID_HS_LAN0),		.RxValidHS1(iMipiDphyRx1_RX_VALID_HS_LAN1),
	.RxValidHS2(),									.RxValidHS3(),
	.RxValidHS4(),									.RxValidHS5(),
	.RxValidHS6(),									.RxValidHS7(),
	.RxClkEsc(wRxClkEsc),							.RxErrEsc(wRxErrEsc),
	.RxErrControl(wRxErrControl),					.RxErrSotSyncHS(wRxErrSotSyncHS),
	.RxUlpsActiveClkNot(wRxUlpsActiveClkNot),		.RxUlpsClkNot(wRxUlpsClkNot),
	.RxUlpsEsc(wRxUlpsEsc),							.RxUlpsActiveNot(wRxUlpsActiveNot),
	.RxSkewCalHS(wRxSkewCalHS),						.RxStopState(wRxStopState),
	.RxSyncHS(wRxSyncHS),
	.clk_byte_HS(iMipiDphyRx1_WORD_CLKOUT_HS),		.reset_byte_HS_n(qIpCorerHsnRST),
	// 
	// CSI Video I/F PCLK
	.hsync_vc0(wMipiRxHs),		.hsync_vc1(),		.hsync_vc2(),		.hsync_vc3(),
	.hsync_vc4(),				.hsync_vc5(),		.hsync_vc6(),		.hsync_vc7(),
	.hsync_vc8(),				.hsync_vc9(),		.hsync_vc10(),		.hsync_vc11(),
	.hsync_vc12(),				.hsync_vc13(),		.hsync_vc14(),		.hsync_vc15(),
	.vsync_vc0(wMipiRxVs),		.vsync_vc1(),		.vsync_vc2(),		.vsync_vc3(),
	.vsync_vc4(),				.vsync_vc5(),		.vsync_vc6(),		.vsync_vc7(),
	.vsync_vc8(),				.vsync_vc9(),		.vsync_vc10(),		.vsync_vc11(),
	.vsync_vc12(),				.vsync_vc13(),		.vsync_vc14(),		.vsync_vc15(),
	.vc(),						.vcx(),
	.word_count(wMipiRxWordCnt),					.shortpkt_data_field(wMipiRxShortpkt),
	.datatype(wMipiRxDatatype),						.pixel_per_clk(wMipiRxPCLK),
	.pixel_data(wMipiRxData),						.pixel_data_valid(wMipiRxVd),
	.irq(),
	.clk_pixel(iPCLK),  							.reset_pixel_n(inPRST),
	//
	// AXI4-Lite Interface
	.axi_awaddr(axi_awaddr),						.axi_awvalid(axi_awvalid),
	.axi_awready(axi_awready),						.axi_wdata(axi_wdata),
	.axi_wvalid(axi_wvalid),						.axi_wready(axi_wready),
	.axi_bvalid(axi_bvalid),						.axi_bready(axi_bready),
	.axi_araddr(axi_araddr),						.axi_arvalid(axi_arvalid),
	.axi_arready(axi_arready),						.axi_rdata(axi_rdata),
	.axi_rvalid(axi_rvalid),						.axi_rready(axi_rready),
	.axi_clk(axi_clk), 								.axi_reset_n(axi_reset_n),
	//
	// Core CLK
	.clk(iSCLK),									.reset_n(inSRST)
);


//-----------------------------------------------------------------------------
// CSI-IP から出力される HSync Assert 期間中の VD をカウント
// SVO-03-MIPI の MIPI 信号を受信しているので、解像度が一致するか確認のため作成
// 
// ※以下確認済み
// 1ラインの Vd のカウント数は 解像度 1920,4PixelPer/Clock だと、1920 / 4 = 480(0x1E0)
// 1280,4PixelPer/Clock だと、1280 / 4 = 320(0x140),のため一致を確認。
// HSync は正常にカウントできていない。
// 
// Ppl = Pixel Per Line
//-----------------------------------------------------------------------------
reg 	[11:0]	rHsyncCnt, 	rHsyncCntMonitor;		assign oHsyncCntMonitor	= rHsyncCntMonitor;
reg 	[11:0] 	rPplCnt, 	rPplCntMonitor;			assign oPplCntMonitor 	= rPplCntMonitor;
reg 			rPplMonitorSel;
reg 			qPplCntCke, qPplCntMonitorCke;
reg 			qPplCntRst;
//
wire 	[11:0]	wHsyncCnt 	= rHsyncCnt + 1'b1;
wire 	[11:0]	wPplCnt 	= rPplCnt + 1'b1;

always @(posedge iPCLK)
begin
	// Hync Assert 期間をカウント
	if (qPplCntRst) 			rHsyncCnt <= 12'd1;
	else if (wMipiRxHs)			rHsyncCnt <= wHsyncCnt;
	else 						rHsyncCnt <= rHsyncCnt;

	case ( {rPplMonitorSel,wMipiRxHs} )
		'b0x: 					rHsyncCntMonitor <= rHsyncCntMonitor;
		'b10:					rHsyncCntMonitor <= rHsyncCnt;
		default: 				rHsyncCntMonitor <= rHsyncCntMonitor;
	endcase
	//
	// Hsync Assert 期間の VD 立ち上がり回数カウント
	if (qPplCntRst) 			rPplCnt <= 12'd0;
	else if (qPplCntCke)		rPplCnt <= wPplCnt;
	else 						rPplCnt <= rPplCnt;

	case ( {rPplMonitorSel,wMipiRxHs} )	// 上記 rPplCnt の結果をモニタリング用に保持
		'b0x: 					rPplCntMonitor <= rPplCntMonitor;
		'b10:					rPplCntMonitor <= rPplCnt;
		default: 				rPplCntMonitor <= rPplCntMonitor;
	endcase

	if (iSRST)					rPplMonitorSel <= 1'b0;
	else if (qPplCntMonitorCke)	rPplMonitorSel <= ~rPplMonitorSel;
	else 						rPplMonitorSel <=  rPplMonitorSel;
end

always @*
begin
	casex ( {rPplMonitorSel,wMipiRxHs} )
		'b01: 		qPplCntMonitorCke <= 1'b1;	// Assert
		'b10: 		qPplCntMonitorCke <= 1'b1;	// Negete
		default: 	qPplCntMonitorCke <= 1'b0;
	endcase

	qPplCntRst 		<= |{iSRST,~wMipiRxHs};		// Hsync Dissert でカウント回数クリア
	qPplCntCke 		<= wMipiRxVd;
end


//-----------------------------------------------------------------------------
// Dual CLK Fifo Side
// ピクセルクロックのタイミングで出力されるピクセルデータを高速なクロックに変換
// CSI2-IP から出力されるデータは垂れ流しで全て受け付ける。
// 
// ※ Titanium の DualClkRam が 最大8bit ～ 10bit, 深さ1024 までしか対応していない。
// 
//	BRAM のプリミティブ活用や、コードからの合成結果については試行回数が必要。
//	Quantum アーキテクチャの特徴を生かして、カスケード接続が定石か？
//-----------------------------------------------------------------------------
localparam lpCdcFifoBitWidth	= 64;
localparam lpCdcFifoCascade		= 8;
localparam lpCdcFifoDepth		= 1024;
localparam lpCdcFIfoFullAlMost	= 4;
//
wire [63:0] 	wCdcFifoRd;
wire 			wCdcFifoEmp;
wire 			wCdcFifoRvd;
reg  			qCdcFifoRe;
wire 			wCdcFifoFull;				assign oCdcFifoFull = wCdcFifoFull;
reg  			qCdcFifoWe;


fifoDualController #(
	.pFifoDepth(lpCdcFifoDepth),
	.pFifoBitWidth(lpCdcFifoBitWidth),
	.pFifoCascade(lpCdcFifoCascade),
	.pFullAlMost(lpCdcFIfoFullAlMost)
) mCsiDualClkFIFO (
	// src side
	.iWd(wMipiRxData),
	.iWe(qCdcFifoWe),		.oFull(wCdcFifoFull),
	.iSrcClk(iPCLK),		.iSrcRst(iPRST),
	// dst side
	.oRd(wCdcFifoRd),		.oRvd(wCdcFifoRvd),
	.iRe(qCdcFifoRe),		.oEmp(wCdcFifoEmp),
	.iDstClk(iFCLK),		.iDstRst(iFRST)
);

always @*
begin
	qCdcFifoWe <= &{wMipiRxVd,~wCdcFifoFull};
end

//-----------------------------------------------------------------------------
// UYVY16bit 固定で 64bit to 16bit Convert
//-----------------------------------------------------------------------------
wire [15:0] wPfcWd;
wire 		wPfcWe;
wire 		wPfcRe;
reg 		qPfcEmp;
reg 		qPfcfull;

MPixelFormatConverter mPixelFormatConverter (
	.iRd(wCdcFifoRd),		.oRe(wPfcRe),
	.iRvd(wCdcFifoRvd),		.iEmp(qPfcEmp),
	.oWd(wPfcWd),			.oWe(wPfcWe),
	.ifull(qPfcfull),
	// common
	.iRST(iFRST),			.iCLK(iFCLK)
);

always @*
begin
	qCdcFifoRe	<= wPfcRe;
	qPfcEmp		<= (~wCdcFifoEmp);
end


//-----------------------------------------------------------------------------
// Dual Port Ram
// 前段のデータを貯める速度が出力より早いためデータが溢れてしまう。
// 回避するために途中で BRAM を挟み対応。
// 
// ※ 16bit 深さ512 まで
//-----------------------------------------------------------------------------
localparam lpPfcFifoBitWidth	= 16;
localparam lpPfcFifoCascade		= 1;
localparam lpPfcFifoDepth  		= 512 * lpPfcFifoCascade;
localparam lpPfcFIfoFullAlMost  = 16;
//
wire [15:0] 	wPfcFifoRd;				assign oVideoData = wPfcFifoRd;
wire 			wPfcFifoRvd;			assign oVideoVd	  = wPfcFifoRvd;
wire 			wPfcFifoEmp;
reg 			qPfcFifoRe;
wire 			wPfcFifoFull;
//
fifoController #(
	.pFifoDepth(lpPfcFifoDepth),
	.pFifoBitWidth(lpPfcFifoBitWidth),
	.pFifoCascade(lpPfcFifoCascade),
	.pFullAlMost(lpPfcFIfoFullAlMost)
) mCsiPfcFifo (
	// src side
	.iWd(wPfcWd),
	.iWe(wPfcWe),			.oFull(wPfcFifoFull),
	// dst side
	.oRd(wPfcFifoRd),
	.oRvd(wPfcFifoRvd),
	.iRe(qPfcFifoRe),		.oEmp(wPfcFifoEmp),
	// common
	.iCLK(iFCLK),			.iRST(iFRST)
);

always @*
begin
	qPfcFifoRe 	<= (~iVideofull) & (~wPfcFifoEmp);
	qPfcfull	<= (~wPfcFifoFull);
end

//-----------------------------------------------------------------------------
// CLK Rst Conn.
// サンプルが 3CLK 遅らせたリセットを入力していたため真似した。
//-----------------------------------------------------------------------------
reg [2:0] rIpCoreHsnRST;

always @(posedge iSCLK)
begin
	if (!inSRST) rIpCoreHsnRST <= 3'd0;
	else 		 rIpCoreHsnRST <= {rIpCoreHsnRST[1:0],inSRST};
end

always @*
begin
	qIpCorerHsnRST	<= rIpCoreHsnRST[2];
end

endmodule