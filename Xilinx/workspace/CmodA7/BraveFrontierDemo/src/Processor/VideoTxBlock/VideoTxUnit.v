//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Video信号の制御を司るユニット
// 
//----------------------------------------------------------
module VideoTxUnit #(
	parameter						pBusAdrsBit			= 16,
	parameter						pUfiBusWidth		= 16,
	parameter						pMemAdrsWidth		= 19,
	// Display Size
    parameter       				pHdisplayWidth		= 11,
    parameter       				pVdisplayWidth		= 11,
	// Color Depth ARGB:4444
	parameter						pColorDepth			= 16,
	// Dual Clk FIFO Depth
	parameter						pDualClkFifoDepth 	= 1024,
	parameter						pDmaFifoDepth		= 1024
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
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]		iMUfiRd,	// Read Data
	input 							iMUfiREd,	// Read Data Enable
	// Ufi Master Write
	output [pUfiBusWidth-1:0]		oMUfiWd,
	output [pBusAdrsBit-1:0]		oMUfiAdrs,
	output 							oMUfiEd,	// Adrs Data Enable
	output 							oMUfiVd,	// Data Valid
	output 							oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 							iMUfiRdy,	// Ufi Bus 転送可能時 Assert
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
	//
	input 	[pMemAdrsWidth-1:0]		iDmaWAdrs,
	input 	[pMemAdrsWidth-1:0]		iDmaRAdrs,
	input 	[pMemAdrsWidth-1:0]		iDmaWLen,
	input 	[pMemAdrsWidth-1:0]		iDmaRLen,
	input 							iDmaEn,
    // CLK Reset
    input           				iSysClk,
	input 							iVideoClk,
    input           				iSysRst,
	// debug
	output 							oFe
);

//-----------------------------------------------------------------------------
// // Alpha の ビット幅を除いた数値
//-----------------------------------------------------------------------------
localparam lpDualFifoWidth = pColorDepth - (pColorDepth / 4);


//-----------------------------------------------------------------------------
// 1pixel毎の描画データ生成
//-----------------------------------------------------------------------------
wire [lpDualFifoWidth-1:0] wDrawPixel;
wire wDrawPixelVd;
reg  qVideoPixelGenCke;

VideoPixelGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) VideoPixelGen (
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	.oPixel				(wDrawPixel),
	.oVd				(wDrawPixelVd),
	.iRst				(iVtbSystemRst),
	.iCke				(qVideoPixelGenCke),
	.iClk				(iSysClk)
);


//-----------------------------------------------------------------------------
// Video DMA
//-----------------------------------------------------------------------------
wire 					wDmaFull;
wire [pUfiBusWidth-1:0]	wDmaRd;
wire 					wDmaREd;
reg						qDmaRe;

VideoDmaUnit #(
	.pUfiBusWidth		(pUfiBusWidth),
	.pBusAdrsBit		(pBusAdrsBit),
	.pMemAdrsWidth		(pMemAdrsWidth),
	.pFifoDepth			(pDmaFifoDepth)
) VideoDmaUnit (
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	.oMUfiWd			(oMUfiWd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiEd			(oMUfiEd),
	.oMUfiVd			(oMUfiVd),
	.oMUfiCmd			(oMUfiCmd),
	.iMUfiRdy			(iMUfiRdy),
	//
	.iDmaWd				(wDrawPixel[7:0]),
	.iDmaWEd			(wDrawPixelVd),
	.oDmaFull			(wDmaFull),
	.oDmaRd				(wDmaRd),
	.oDmaREd			(wDmaREd),
	.iDmaRe				(qDmaRe),
	//
	.iDmaWAdrs			(iDmaWAdrs),
	.iDmaRAdrs			(iDmaRAdrs),
	.iDmaWLen			(iDmaWLen),
	.iDmaRLen			(iDmaRLen),
	.iDmaEn				(iDmaEn),
	//
	.iRst				(iSysRst),
	.iClk				(iSysClk)
);

always @*
begin
	qVideoPixelGenCke <= (~wDmaFull);
end

//-----------------------------------------------------------------------------
// Video Sync Gen
//-----------------------------------------------------------------------------
wire wHSync;
wire wVSync;
wire wVde;
wire wFe;							assign oFe = wFe;

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
	.iRst			(iVtbVideoRst),
	.iVideoClk		(iVideoClk)
);


//-----------------------------------------------------------------------------
// SystemClk <=> VideoClk Dual Clk FIFO
//-----------------------------------------------------------------------------
//
wire [lpDualFifoWidth-1:0] 	wVideoDualFifoRd;
wire 						wVideoDualFifoFull;

VideoDualClkFIFO #(
	.pBuffDepth		(pDualClkFifoDepth),
	.pBitWidth		(lpDualFifoWidth)
) VIDEO_DUAL_CLK_FIFO (
	.iWd			({4'd0, wDmaRd}),
	.iWe			(wDmaREd),
	.ofull			(wVideoDualFifoFull),
	.oRd			(wVideoDualFifoRd),
	.iRe			(wVde),
	.iSrcRst		(iVtbSystemRst),
	.iDstRst		(iVtbVideoRst),
	.iSrcClk		(iSysClk),
	.iDstClk		(iVideoClk)
);

always @*
begin
	qDmaRe <= (~wVideoDualFifoFull);
end
//
// Dual Clk Fifo 経由で 2レイテンシ遅延が発生するため、
// Sync系統も同様に遅らせる
localparam lpSyncLatancy = 2;

reg [lpSyncLatancy-1:0] rVideoHSync;
reg [lpSyncLatancy-1:0] rVideoVSync;
reg [lpSyncLatancy-1:0] rVideoVde;

always @(posedge iVideoClk)
begin
	if (iVtbVideoRst) 	rVideoHSync <= {lpSyncLatancy{1'b0}};
	else 				rVideoHSync <= {rVideoHSync[lpSyncLatancy-2:0], wHSync};

	if (iVtbVideoRst) 	rVideoVSync <= {lpSyncLatancy{1'b0}};
	else 				rVideoVSync <= {rVideoVSync[lpSyncLatancy-2:0], wVSync};

	if (iVtbVideoRst) 	rVideoVde <= {lpSyncLatancy{1'b0}};
	else 				rVideoVde <= {rVideoVde[lpSyncLatancy-2:0], wVde};
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
	.iClk			(iSysClk),
	.iRst			(iSysRst)
);


//---------------------------------------------------------------------------
// TFT DIsplay 出力
//---------------------------------------------------------------------------
genvar i;

generate
	for (i = 0; i < 4; i = i + 1)
	begin
		OBUF TFT_R (.O (oTftColorR[4+i]),	.I (wVideoDualFifoRd[8+i]));
		OBUF TFT_G (.O (oTftColorG[4+i]),	.I (wVideoDualFifoRd[4+i]));
		OBUF TFT_B (.O (oTftColorB[4+i]),	.I (wVideoDualFifoRd[0+i]));
	end
	OBUF TFT_DCLK 	(.O (oTftDclk),			.I (iVideoClk));
	OBUF TFT_HSync 	(.O (oTftHSync),		.I (rVideoHSync[lpSyncLatancy-1]));
	OBUF TFT_VSync 	(.O (oTftVSync),		.I (rVideoVSync[lpSyncLatancy-1]));
	OBUF TFT_VDE 	(.O (oTftDe),			.I (rVideoVde[lpSyncLatancy-1]));
	OBUF TFT_BL 	(.O (oTftBackLight),	.I (wTftBackLight));
	OBUF TFT_RST 	(.O (oTftRst),			.I (iDisplayRst));
endgenerate

endmodule