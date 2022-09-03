//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Video信号の制御を司るユニット
// 
//----------------------------------------------------------
module VideoTxUnit #(
	// Variable
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11
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
	input 							iPixelClk,
    input           				iSysRst
);


//-----------------------------------------------------------------------------
// 1pixel毎の描画データ生成
//-----------------------------------------------------------------------------
PixelDotGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorRGBDepth		(pColorRGBDepth),
) PIXEL_DOT_GEN (
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	.oPixel				(oPixel),
	.oVd				(oVd),
	.iRst				(iSysRst),
	.iClk				(iSysClk)
);


//-----------------------------------------------------------------------------
// SystemClk <=> VideoClk Dual Clk FIFO
//-----------------------------------------------------------------------------


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
	.iPixelClk		(iPixelClk),
	.iSysRst		(iSysRst)
);


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
		OBUF TFT_R (.O (oTftColorR[4+i]),	.I (1'b0));
		OBUF TFT_G (.O (oTftColorG[4+i]),	.I (1'b1));
		OBUF TFT_B (.O (oTftColorB[4+i]),	.I (1'b0));
		// OBUF TFT_R (.O (oTftColorR[4+i]),	.I (iPixelData[8+i]));
		// OBUF TFT_G (.O (oTftColorG[4+i]),	.I (iPixelData[4+i]));
		// OBUF TFT_B (.O (oTftColorB[4+i]),	.I (iPixelData[0+i]));
	end
	OBUF TFT_DCLK 	(.O (oTftDclk),			.I (iPixelClk));
	OBUF TFT_HSync 	(.O (oTftHSync),		.I (wHSync));
	OBUF TFT_VSync 	(.O (oTftVSync),		.I (wVSync));
	OBUF TFT_VDE 	(.O (oTftDe),			.I (wVde));
	OBUF TFT_BL 	(.O (oTftBackLight),	.I (wTftBackLight));
	OBUF TFT_RST 	(.O (oTftRst),			.I (iDisplayRst));
endgenerate

endmodule