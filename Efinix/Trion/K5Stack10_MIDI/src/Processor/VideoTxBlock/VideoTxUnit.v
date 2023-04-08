//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Video信号の制御を司るユニット
// 
//----------------------------------------------------------
module VideoTxUnit #(
	parameter						pUfiBusWidth		= 16,
	parameter						pUsiBusWidth			= 16,
	parameter						pMemAdrsWidth		= 19,
	// Display Size
    parameter       				pHdisplayWidth		= 11,
    parameter       				pVdisplayWidth		= 11,
	// Csr Map Info
	parameter						pMapInfoBitWidth 	= 8,
	// MapChip
	parameter						pMapChipBasicSize	= 16,
	parameter						pMapChipBasicBs		= 4,	// pMapChipBasicSize の サイズで Bit Shiftした時の 幅
	// Color Depth ARGB:4444
	parameter						pColorDepth			= 16,
	// MapChip BRAM Depth
	parameter						pMapChipRamDepth	= 2048,
	parameter						pMapChipRamWidth	= 10,
	// FIFO Depth
	parameter						pDualClkFifoDepth 	= 32,
	parameter						pDmaFifoDepth		= 32,
	parameter						pFifoDepthOverride	= "no",
	parameter						pTestBencth			= "no"
)(
	// External port
	output 	[7:4] 					oTftColorR,
	output 	[7:4] 					oTftColorG,
	output 	[7:4] 					oTftColorB,
	output 							oTftDclk,
	output 							oTftHSync,
	output 							oTftVSync,
	output 							oTftDe,
	output 							oTftBackLight,
	output 							oTftRst,
	// Ufi Master Read
	input	[pUfiBusWidth-1:0]		iMUfiRd,	// Read Data
	input 							iMUfiREd,	// Read Data Enable
	// Ufi Master Write
	output 	[pUfiBusWidth-1:0]		oMUfiWd,
	output 	[pUsiBusWidth-1:0]		oMUfiAdrs,
	output 							oMUfiWEd,	// Adrs Data Enable
	output 							oMUfiREd,	// Adrs Data Enable
	output 							oMUfiVd,	// Data Valid
	output 							oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 							iMUfiRdy,	// Ufi Bus 転送可能時 Assert
	// Vtb Ufi Slave Side
	input 	[pUfiBusWidth-1:0] 		iSUfiWd,	// 書き込みデータ
	input 	[pUsiBusWidth-1:0] 		iSUfiAdrs,	// 書き込みアドレス
	input 							iSUfiWEd,	// 書き込み命令
	// Csr Display
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	input	[pHdisplayWidth:0]		iHSyncStart,
	input	[pHdisplayWidth:0]		iHSyncEnd,
	input	[pHdisplayWidth:0]		iHSyncMax,
	input	[pVdisplayWidth:0]		iVSyncStart,
	input	[pVdisplayWidth:0]		iVSyncEnd,
	input	[pVdisplayWidth:0]		iVSyncMax,
	// Csr Video System Rst
	input 							iVtbSystemRst,
	input 							iVtbVideoRst,
	input 							iDisplayRst,
	input 	[7:0]					iBlDutyRatio,
	// Csr DMA
	input 	[pMemAdrsWidth-1:0]		iFbufAdrs1,
	input 	[pMemAdrsWidth-1:0]		iFbufAdrs2,
	input 	[pMemAdrsWidth-1:0]		iFbufLen1,
	input 	[pMemAdrsWidth-1:0]		iFbufLen2,
	input 							iDmaEn,
	// Csr Map Info
	input	[7:0]					iMapXSize,
	input	[7:0]					iMapYSize,
	input 	[pMapInfoBitWidth-1:0] 	iMapInfoWd,
	input 							iMapInfoCke,
	input 							iMapInfoVd,
	// Csr SceneChange
    input	[pColorDepth-1:0]		iSceneColor,		// 描画色
	input 	[6:0]					iSceneFrameTiming,	// SceneChange の更新速度,fps基準
	input 							iSceneFrameAddEn,	// SceneChange Add Start
	input 							iSceneFrameSubEn,	// SceneChange Sub Start
    input                     		iSceneFrameRst,
	output							oSceneAlphaMax,
	output 							oSceneAlphaMin,
	// Csr Player Draw
	input 	[6:0]					iPDFeUpdateCnt,
	input 	[pRamAdrsWidth-1:0]		iPDRadrsNext,
	input 							iPDRst,
	output 							oPDFeCntCke,
    // CLK Reset
    input           				iSCLK,
	input 							iVideoClk,
    input           				iSRST,
	// debug
	output 							oFe
);

//-----------------------------------------------------------------------------
// Alpha の ビット幅を除いた数値
//-----------------------------------------------------------------------------
localparam lpDualFifoWidth = pColorDepth - (pColorDepth / 4);


//-----------------------------------------------------------------------------
// 1st Stage
// 1pixel毎の描画データ生成
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] 	wDrawPixel;
wire 					wDrawPixelWEd;
reg  					qVideoPixelGenEdd;

VideoPixelGen #(
	.pUfiBusWidth		(pUfiBusWidth),
	.pUsiBusWidth		(pUsiBusWidth),
	//
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	//
	.pMapIdWidth		(pMapInfoBitWidth),
	//
	.pMapChipBasicSize	(pMapChipBasicSize),
	.pMapChipBasicBs	(pMapChipBasicBs),
	//
	.pColorDepth		(pColorDepth),
	//
	.pMapChipRamDepth	(pMapChipRamDepth),
	.pMapChipRamWidth	(pMapChipRamWidth)
) VideoPixelGen (
	.iSUfiWd			(iSUfiWd),
	.iSUfiAdrs			(iSUfiAdrs),
	.iSUfiWEd			(iSUfiWEd),
	//
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	// Csr Map Info
	// .iMapXSize			(iMapXSize),
	// .iMapYSize			(iMapYSize),
	// .iMapInfoWd			(iMapInfoWd),
	// .iMapInfoCke		(iMapInfoCke),
	// .iMapInfoVd			(iMapInfoVd),
	//
	.iSceneColor		(iSceneColor),
	.iSceneFrameTiming	(iSceneFrameTiming),
	.iSceneFrameAddEn	(iSceneFrameAddEn),
	.iSceneFrameSubEn	(iSceneFrameSubEn),
	.iSceneFrameRst		(iSceneFrameRst),
	.oSceneAlphaMax		(oSceneAlphaMax),
	.oSceneAlphaMin		(oSceneAlphaMin),
	//
	.iPDFeUpdateCnt		(iPDFeUpdateCnt),
	.iPDRadrsNext		(iPDRadrsNext),
	.iPDRst				(iPDRst),
	.oPDFeCntCke		(oPDFeCntCke),
	//
	.oPixel				(wDrawPixel),
	.oWEd				(wDrawPixelWEd),
	.iEdd				(qVideoPixelGenEdd),
	// 
	.iRst				(iVtbSystemRst),
	.iClk				(iSCLK)
);


//-----------------------------------------------------------------------------
// 2nd Stage
// 1st Stage の pixel データを Video DMA で外部 RAM の FrameBuffer 領域に Write 転送
// 3rd Stage に Video DMA で外部 RAM の FrameBuffer 領域から Read 転送
//-----------------------------------------------------------------------------
localparam lpDmaFifoDepth = (pFifoDepthOverride == "yes") ? pDmaFifoDepth : 32;

wire	[pUfiBusWidth-1:0]	wDmaWd;
wire 	[pUfiBusWidth-1:0]	wDmaRd;
wire 						wDmaREd;
wire 						wDmaFull;
reg							qDmaRe;

VideoDmaUnit #(
	.pUfiBusWidth		(pUfiBusWidth),
	.pUsiBusWidth		(pUsiBusWidth),
	.pMemAdrsWidth		(pMemAdrsWidth),
	.pFifoDepth			(lpDmaFifoDepth)
) VideoDmaUnit (
	// Ufi Bus Transaction
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	.oMUfiWd			(oMUfiWd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiWEd			(oMUfiWEd),
	.oMUfiREd			(oMUfiREd),
	.oMUfiVd			(oMUfiVd),
	.oMUfiCmd			(oMUfiCmd),
	.iMUfiRdy			(iMUfiRdy),
	// DMA Transaction
	.iDmaWd				(wDmaWd),
	.iDmaWEd			(wDrawPixelWEd),
	.oDmaFull			(wDmaFull),
	.oDmaRd				(wDmaRd),
	.oDmaREd			(wDmaREd),
	.iDmaRe				(qDmaRe),
	// Csr DMA
	.iFbufAdrs1			(iFbufAdrs1),
	.iFbufAdrs2			(iFbufAdrs2),
	.iFbufLen1			(iFbufLen1),
	.iFbufLen2			(iFbufLen2),
	.iDmaEn				(iDmaEn),
	//
	.iRst				(iVtbSystemRst),
	.iClk				(iSCLK)
);

generate
	if (pUfiBusWidth == 8)	// debug の評価ボードが 8bit幅の SRAMだったため、本番とデバッグ用に generate使用
	begin
		assign wDmaWd = {wDrawPixel[11:9], wDrawPixel[7:6], wDrawPixel[3:1]};
	end
	else
	begin
		assign wDmaWd = wDrawPixel;
	end
endgenerate


//-----------------------------------------------------------------------------
// Video Sync Gen
// 3rd Stage 以降と、外部 Display I/F に使用する Sync 信号の生成
//-----------------------------------------------------------------------------
wire wHSync;
wire wVSync;
wire wVde;
wire wFe;							assign oFe = wFe;	// debug 用途に上位に出力

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
// あまり入れたくはないが 処理が間に合わない時の FPS 調整機能
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Read フレームの Pixel に加工を施す場合は Dual FIFO 前段で行う
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// 3rd Stage
// DMA Read 転送のデータ格納 及び SystemClk = VideoClk のクロック変換用途
//-----------------------------------------------------------------------------
localparam lpDualClkFifoDepth	= (pFifoDepthOverride == "yes") ? pDualClkFifoDepth : 32;
localparam lpDcfWidth			= lpDualFifoWidth + 2'd3;

reg		[pUfiBusWidth+2'd2:0]	qVideoDualFifoWd;
reg								qVideoDualFifoWEd;
wire 	[lpDualFifoWidth-1:0] 	wVideoDualFifoRd;
wire 							wVideoDualFifoFull;

VideoDualClkFIFO #(
	.pBuffDepth		(lpDualClkFifoDepth),
	.pBitWidth		(lpDcfWidth)
) VideoDualClkFIFO (
	.iWd			(qVideoDualFifoWd),
	.iWe			(qVideoDualFifoWEd),
	.ofull			(wVideoDualFifoFull),
	.oRd			(wVideoDualFifoRd),
	.iRe			(wVde),
	.iSrcRst		(iVtbSystemRst),
	.iDstRst		(iVtbVideoRst),
	.iSrcClk		(iSCLK),
	.iDstClk		(iVideoClk)
);

always @*
begin
	// TODO フレームバッファ領域を通らなくても動作するようにしたい
	qVideoDualFifoWd	<= {wVde,wVSync,wHSync,wDmaRd};		//iDmaEn ?   wDmaRd  : wDrawPixel[pUfiBusWidth-1:0];
	qVideoDualFifoWEd	<=  wDmaREd;						//iDmaEn ?   wDmaREd : wDrawPixelWEd;
	qVideoPixelGenEdd 	<= ~wDmaFull;						//iDmaEn ? (~wDmaFull) : (~wVideoDualFifoFull);
	qDmaRe 				<= (~wVideoDualFifoFull);
end

//-----------------------------------------------------------------------------
// 外部 Display のバックライト調光
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
	.iClk			(iSCLK),
	.iRst			(iSRST)
);


//---------------------------------------------------------------------------
// TFT DIsplay 出力
// TODO TFT GPIO 出力部分
// CmodA7 の RAM 8bit幅に合わせている
//---------------------------------------------------------------------------
genvar i;

generate
	if (pUfiBusWidth == 8)
	begin
		OBUF TFT_R7 (.O (oTftColorR[7]),		.I (wVideoDualFifoRd[7]));
		OBUF TFT_R6 (.O (oTftColorR[6]),		.I (wVideoDualFifoRd[6]));
		OBUF TFT_R5 (.O (oTftColorR[5]),		.I (wVideoDualFifoRd[5]));
		OBUF TFT_R4 (.O (oTftColorR[4]),		.I (1'b0));
		//
		OBUF TFT_G7 (.O (oTftColorG[7]),		.I (wVideoDualFifoRd[4]));
		OBUF TFT_G6 (.O (oTftColorG[6]),		.I (wVideoDualFifoRd[3]));
		OBUF TFT_G5 (.O (oTftColorG[5]),		.I (1'b0));
		OBUF TFT_G4 (.O (oTftColorG[4]),		.I (1'b0));
		//
		OBUF TFT_B7 (.O (oTftColorB[7]),		.I (wVideoDualFifoRd[2]));
		OBUF TFT_B6 (.O (oTftColorB[6]),		.I (wVideoDualFifoRd[1]));
		OBUF TFT_B5 (.O (oTftColorB[5]),		.I (wVideoDualFifoRd[0]));
		OBUF TFT_B4 (.O (oTftColorB[4]),		.I (1'b0));
	end
	else
	begin
		for (i = 0; i < 4; i = i + 1)
		begin
			OBUF TFT_R (.O (oTftColorR[4+i]),	.I (wVideoDualFifoRd[8+i]));
			OBUF TFT_G (.O (oTftColorG[4+i]),	.I (wVideoDualFifoRd[4+i]));
			OBUF TFT_B (.O (oTftColorB[4+i]),	.I (wVideoDualFifoRd[0+i]));
		end
	end
	//
	OBUF TFT_DCLK 	(.O (oTftDclk),			.I (iVideoClk));
	OBUF TFT_HSync 	(.O (oTftHSync),		.I (wVideoDualFifoRd[lpDualFifoWidth]));
	OBUF TFT_VSync 	(.O (oTftVSync),		.I (wVideoDualFifoRd[lpDualFifoWidth+1'd1]));
	OBUF TFT_VDE 	(.O (oTftDe),			.I (wVideoDualFifoRd[lpDualFifoWidth+2'd2]));
	OBUF TFT_BL 	(.O (oTftBackLight),	.I (wTftBackLight));
	OBUF TFT_RST 	(.O (oTftRst),			.I (iDisplayRst));
endgenerate

endmodule