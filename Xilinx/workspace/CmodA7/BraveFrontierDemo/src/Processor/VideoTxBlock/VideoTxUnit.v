//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Video信号の制御を司るユニット
// 
//----------------------------------------------------------
module VideoTxUnit #(
	// Display Size
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11,
	// Color Depth ARGB:4444
	parameter						pColorDepth		= 16,
	// Dual Clk FIFO Depth
	parameter						pDualClkFifoDepth = 1024
)(
	// External port
	output [7:4] 					oTftColorR,
	output [7:4] 					oTftColorG,
	output [7:4] 					oTftColorB,
	output 							oTftDclk,
	output 							oTftHSync,
	output 							oTftVSync,
	output 							oTftDe,
	output 							oTftBackLight,
	output 							oTftRst,
	// Internal Port
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	input	[pHdisplayWidth:0]		iHSyncStart,
	input	[pHdisplayWidth:0]		iHSyncEnd,
	input	[pHdisplayWidth:0]		iHSyncMax,
	input	[pVdisplayWidth:0]		iVSyncStart,
	input	[pVdisplayWidth:0]		iVSyncEnd,
	input	[pVdisplayWidth:0]		iVSyncMax,
	//
	input 							iVtbSystemRst,
	input 							iVtbVideoRst,
	input 							iDisplayRst,
	input 	[7:0]					iBlDutyRatio,
    // CLK Reset
    input           				iSysClk,
	input 							iVideoClk,
    input           				iSysRst
);


//-----------------------------------------------------------------------------
// 1pixel毎の描画データ生成
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] wDrawPixel;
wire wDrawPixelVd;
reg  qVideoDualFifoFull;

VideoPixelGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) VIDEO_PIXEL_GEN (
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	.oPixel				(wDrawPixel),
	.oVd				(wDrawPixelVd),
	.iRst				(iVtbSystemRst),
	.iCke				(qVideoDualFifoFull),
	.iClk				(iSysClk)
);


//-----------------------------------------------------------------------------
// Video Sync Gen
//-----------------------------------------------------------------------------
wire wHSync;
wire wVSync;
wire wVde;
wire wFe;

VideoSyncGen #(
	.pHdisplayWidth	(pHdisplayWidth),
	.pVdisplayWidth	(pVdisplayWidth)
) VIDEO_SYNC_GEN (
	.iHdisplay		(iHdisplay),
	.iVdisplay		(iVdisplay),
	.iHSyncStart	(iHSyncStart),
	.iHSyncEnd		(iHSyncEnd),
	.iHSyncMax		(iHSyncMax),
	.iVSyncStart	(iVSyncStart),
	.iVSyncEnd		(iVSyncEnd),
	.iVSyncMax		(iVSyncMax),
	.oHSync			(wHSync),
	.oVSync			(wVSync),
	.oVde			(wVde),
	.oFe			(wFe),
	.iVideoClk		(iVideoClk),
	.iSysRst		(iVtbVideoRst)
);


//-----------------------------------------------------------------------------
// SystemClk <=> VideoClk Dual Clk FIFO
//-----------------------------------------------------------------------------
localparam lpDualFifoWidth = pColorDepth - (pColorDepth / 4); // Alpha の ビット幅を除いた数値
//
wire [lpDualFifoWidth-1:0] 	wVideoDualFifoRd;
wire 						wVideoDualFifoFull;

VideoDualClkFIFO #(
	.pBuffDepth		(pDualClkFifoDepth),
	.pBitWidth		(lpDualFifoWidth)
) VIDEO_DUAL_CLK_FIFO (
	.iWd			(wDrawPixel),
	.iWe			(wDrawPixelVd),
	.ofull			(wVideoDualFifoFull),
	.oRd			(wVideoDualFifoRd),
	.iRe			(wVde),
	.iRst			(iSysRst),
	.iSrcClk		(iSysClk),
	.iDstClk		(iVideoClk)
);

always @*
begin
	qVideoDualFifoFull <= wVideoDualFifoFull;
end
//
// Dual Clk Fifo 経由で 3レイテンシ遅延が発生するため、
// Sync系統も同様に遅らせる
reg [2:0] rVideoHSync;
reg [2:0] rVideoVSync;
reg [2:0] rVideoVde;

always @(posedge iVideoClk)
begin
	if (iVtbVideoRst) 	rVideoHSync <= 3'b111;
	else 				rVideoHSync <= {rVideoHSync[1:0], wHSync};

	if (iVtbVideoRst) 	rVideoVSync <= 3'b111;
	else 				rVideoVSync <= {rVideoVSync[1:0], wVSync};

	if (iVtbVideoRst) 	rVideoVde <= 3'b111;
	else 				rVideoVde <= {rVideoVde[1:0], wVde};
end


//-----------------------------------------------------------------------------
// バックライト調光
//-----------------------------------------------------------------------------
wire wTftBackLight;

DutyGenerator #(
	.pPWMDutyWidth	(8),
	.pIVtimerWidth	(7)
) BL_GEN (
	.oPwm			(wTftBackLight),
	.oDutyCycleCke	(),
	.oIVCke			(),
	.iPWMEn			(1'b1),
	.iDutyRatio		(iBlDutyRatio),
	.iIVtimer		(100),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//---------------------------------------------------------------------------
// TFT DIsplay 出力
//---------------------------------------------------------------------------
genvar i;

generate
	for (i = 0; i < 4; i = i + 1)
	begin
		OBUF TFT_R (.O (oTftColorR[4+i]),	.I (wVideoDualFifoRd[0+i]));
		OBUF TFT_G (.O (oTftColorG[4+i]),	.I (wVideoDualFifoRd[4+i]));
		OBUF TFT_B (.O (oTftColorB[4+i]),	.I (wVideoDualFifoRd[8+i]));
	end
	OBUF TFT_DCLK 	(.O (oTftDclk),			.I (iVideoClk));
	OBUF TFT_HSync 	(.O (oTftHSync),		.I (rVideoHSync[2]));
	OBUF TFT_VSync 	(.O (oTftVSync),		.I (rVideoVSync[2]));
	OBUF TFT_VDE 	(.O (oTftDe),			.I (rVideoVde[2]));
	OBUF TFT_BL 	(.O (oTftBackLight),	.I (wTftBackLight));
	OBUF TFT_RST 	(.O (oTftRst),			.I (iDisplayRst));
endgenerate

endmodule