/*-----------------------------------------------------------------------------
 * Create  2023/08/23
 * Author  kouta kimura
 * -
 * v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module VideoTxBlock #(
	// USI
	parameter 						pBlockAdrsWidth		= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h06,
	parameter 						pUsiBusWidth		= 16,
	parameter 						pCsrAdrsWidth		= 16,
	parameter 						pCsrActiveWidth		= 16,
	// UFI
	parameter 						pUfiBusWidth 		= 32,
	//
	parameter [3:0] 				pUfiAdrsMap			= 'h2,
	parameter 						pDmaAdrsWidth		= 18,
	parameter 						pDmaBurstLength		= 256,
	// Display Size, Simlation も兼ねて Top から操作設定可能にしている
	// parameter pVHA	= 480,		// Video Horizontal Active
	// parameter pVHB	= 43,		// Video Horizontal Back
	// parameter pVHF	= 8,		// Video Horizontal Front
	// parameter pVHS	= 10,		// Video Horizontal Sync
	// parameter pVVA	= 272,		// Video Vertical Active
	// parameter pVVF	= 12,		// Video Vertical Front
	// parameter pVVB	= 4,		// Video Vertical Back
	// parameter pVVS	= 10		// Video Vertical Sync
	parameter	pVVA = 240,		// Video Horizontal Active
	parameter	pVVB = 2,		// Video Horizontal Back
	parameter	pVVF = 2,		// Video Horizontal Front
	parameter	pVVS = 4,		// Video Horizontal Sync
	parameter	pVHA = 320,		// Video Vertical Active
	parameter	pVHB = 10,		// Video Vertical Front
	parameter	pVHF = 20,		// Video Vertical Back
	parameter	pVHS = 10		// Video Vertical Sync
)(
	// VIDEO Output Signal Ctrl
	output [23:0]					oVIDEO_DQ,
	output							oVIDEO_WRX,
	output							oVIDEO_RDX,
	output							oVIDEO_DCX,
	output							oVIDEO_CSX,
	output							oVIDEO_RST,
	output [ 3:0]					oVIDEO_IM,
	output							oVIDEO_BL,
	output							oVIDEO_DCK,
	output							oVIDEO_HS,
	output							oVIDEO_VS,
	output							oVIDEO_DE,
	output							oVIDEO_FE,
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0] 		oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] 		iSUsiWd,
	input	[pUsiBusWidth-1:0] 		iSUsiAdrs,
	// Ufi Bus Master Read
	input	[pUfiBusWidth-1:0] 		iMUfiRd,
	input							iMUfiVd,
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0] 		oMUfiWd,
	input							iMUfiRdy,
	// CLK Rst
	input 							iSRST,
	input 							inSRST,
	input 							iSCLK,
	input 							iVRST,
	input 							inVRST,
	input 							iVCLK
);

//-----------------------------------------------------------------------------
// Video Tx Csr Space
//-----------------------------------------------------------------------------
localparam lpVHAW = f_detect_bitwidth(pVHA);	// Video Horizontal Active Width
localparam lpVHBW = f_detect_bitwidth(pVHB);	// Video Horizontal Back Width
localparam lpVHFW = f_detect_bitwidth(pVHF);	// Video Horizontal Front Width
localparam lpVHSW = f_detect_bitwidth(pVHS);	// Video Horizontal Sync Width
localparam lpVVAW = f_detect_bitwidth(pVVA);	// Video Vertical Active Width
localparam lpVVBW = f_detect_bitwidth(pVVB);	// Video Vertical Front Width
localparam lpVVFW = f_detect_bitwidth(pVVF);	// Video Vertical Back Width
localparam lpVVSW = f_detect_bitwidth(pVVS);	// Video Vertical Sync Width
//
localparam lpDstColorDepth 	= 16;	// RGB565
localparam lpSynColorDepth	= 24;	// α8bit +  RGB565
//
parameter	pObjectAnimeNum			= 8;	// アニメーション可能なオブジェクトの個数
parameter	pObjectAnimeTime		= 8;	// アニメーション指定時間の最大時間 Bit幅で指定する。1フレーム単位で処理するため、8bit幅だったら 最大255フレーム間隔で可能になる。
parameter	pObjectAnimeXposWidth	= 16;	// [15:11] NC Bit, [10:0] xpos
parameter	pObjectAnimeYposWidth	= 16;	// [15:11] NC Bit, [10:0] ypos
//
reg 		rBRST, rnBRST;
wire		wBRST;
//
wire 		wDmaEnableCsr;
wire 		wDmaCycleEnableCsr;
wire 		wDmaAdrsStartCsr;
wire 		wDmaAdrsEndCsr;
wire 		wDmaAdrsAddCsr;
wire 		wDmaDoneCsr;
// Video Sync Gen
wire		wVsgRst;
// Video tft Unit
wire [lpDstColorDepth-1:0]	wVtuMcuDqCsr;
wire 						wVtuMcuWRXCsr,	wVtuMcuDCXCsr,	wVtuMcuRDXCsr,	wVtuMcuCSXCsr;
wire 						wVtuMcuRSTCsr;
wire [3:0]					wVtuMcuIMCsr;
wire 						wVtuMcuGateCsr;
wire						wVtuConverterRstCsr;
wire						wVtuMcuBLCsr;
wire [15:0]					wVtuBlDutyRatioCsr;
wire [31:0]					wVtuBlIVtimerCsr;
// 
wire 						wMapXSizeCsr;
wire 						wMapYSizeCsr;
// Video Pixel Gen
wire [lpSynColorDepth-1:0]	wDotSquareColor1Csr, wDotSquareColor2Csr, wDotSquareColor3Csr, wDotSquareColor4Csr, wDotSquareColor5Csr, wDotSquareColor6Csr, wDotSquareColor7Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft1Csr,  wDotSquareRight1Csr, wDotSquareTop1Csr,   wDotSquareUnder1Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft2Csr,  wDotSquareRight2Csr, wDotSquareTop2Csr,   wDotSquareUnder2Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft3Csr,  wDotSquareRight3Csr, wDotSquareTop3Csr,   wDotSquareUnder3Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft4Csr,  wDotSquareRight4Csr, wDotSquareTop4Csr,   wDotSquareUnder4Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft5Csr,  wDotSquareRight5Csr, wDotSquareTop5Csr,   wDotSquareUnder5Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft6Csr,  wDotSquareRight6Csr, wDotSquareTop6Csr,   wDotSquareUnder6Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft7Csr,  wDotSquareRight7Csr, wDotSquareTop7Csr,   wDotSquareUnder7Csr;
//
wire wVpgUnitRstCsr;
//
wire wSceneColorCsr;
wire wSceneFrameTimingCsr;
wire wSceneFrameAddEnCsr;
wire wSceneFrameSubEnCsr;
wire wSceneFrameRstCsr;
wire wSceneAlphaMaxCsr;
wire wSceneAlphaMinCsr;
//
wire [(pObjectAnimeNum * pObjectAnimeTime)-1:0] 		wObdAnimeFrameNumCsr;
wire [(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] 	wObdAnimeXposCsr;
wire [(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] 	wObdAnimeYposCsr;
//
wire [lpVHAW-1:0] 	wBdpHposCsr;
wire [lpVVAW-1:0] 	wBdpVposCsr;
wire [lpVHAW-1:0] 	wPdpXposCsr;
wire [lpVVAW-1:0] 	wPdpYposCsr;
wire 				wPdpInitCsr;
//
wire [23:0]			wBramWdCsr;
wire [31:0]			wBramAdrsCsr;

VideoTxCsr #(
	// USIB
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),	
	.pUsiBusWidth(pUsiBusWidth),			.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),		.pDmaAdrsWidth(pDmaAdrsWidth),
	// Video Timing Parameter
    .pVHA(pVHA),	.pVHB(pVHB),	.pVHF(pVHF),	.pVHS(pVHS),
    .pVVA(pVVA),	.pVVF(pVVF),	.pVVB(pVVB),	.pVVS(pVVS),
	.pVHAW(lpVHAW),	.pVHBW(lpVHBW),	.pVHFW(lpVHFW),	.pVHSW(lpVHSW),
    .pVVAW(lpVVAW),	.pVVBW(lpVVBW),	.pVVFW(lpVVFW),	.pVVSW(lpVVSW),
	// Video Control / Status
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth),
	//
	.pObjectAnimeNum(pObjectAnimeNum),
	.pObjectAnimeTime(pObjectAnimeTime),
	.pObjectAnimeXposWidth(pObjectAnimeXposWidth),
	.pObjectAnimeYposWidth(pObjectAnimeYposWidth)
) VideoTxCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Block RST
	.oBlockRst(wBRST),
	// DMA
	.oDmaEnable(wDmaEnableCsr),			.oDmaCycleEnable(wDmaCycleEnableCsr),
	.oDmaAdrsStart(wDmaAdrsStartCsr),	.oDmaAdrsEnd(wDmaAdrsEndCsr),
	.oDmaAdrsAdd(wDmaAdrsAddCsr),
	.iDmaDone(wDmaDoneCsr),
	// Video Sync Gen
	.oVsgRst(wVsgRst),
	// Vtu TFT Config
	.oVtuMcuDq(wVtuMcuDqCsr),		.oVtuMcuWRX(wVtuMcuWRXCsr),
	.oVtuMcuRDX(wVtuMcuRDXCsr),		.oVtuMcuDCX(wVtuMcuDCXCsr),
	.oVtuMcuCSX(wVtuMcuCSXCsr),		.oVtuMcuRST(wVtuMcuRSTCsr),
	.oVtuMcuIM(wVtuMcuIMCsr),		.oVtuMcuGate(wVtuMcuGateCsr),
	.oVtuMcuBL(wVtuMcuBLCsr),
	.oVtuBlDutyRatio(wVtuBlDutyRatioCsr),
	.oVtuBlIVtimer(wVtuBlIVtimerCsr),
	.oVtuConverterRst(wVtuConverterRstCsr),
	// Vpg
	.oVpgUnitRst(wVpgUnitRstCsr),
	// Map Info
	.oMapXSize(wMapXSizeCsr),
	.oMapYSize(wMapYSizeCsr),
	// Csr Dot Square Gen
	.oDotSquareColor1(wDotSquareColor1Csr),	.oDotSquareLeft1(wDotSquareLeft1Csr),	.oDotSquareRight1(wDotSquareRight1Csr),	.oDotSquareTop1(wDotSquareTop1Csr),	.oDotSquareUnder1(wDotSquareUnder1Csr),
	.oDotSquareColor2(wDotSquareColor2Csr),	.oDotSquareLeft2(wDotSquareLeft2Csr),	.oDotSquareRight2(wDotSquareRight2Csr),	.oDotSquareTop2(wDotSquareTop2Csr),	.oDotSquareUnder2(wDotSquareUnder2Csr),
	.oDotSquareColor3(wDotSquareColor3Csr),	.oDotSquareLeft3(wDotSquareLeft3Csr),	.oDotSquareRight3(wDotSquareRight3Csr),	.oDotSquareTop3(wDotSquareTop3Csr),	.oDotSquareUnder3(wDotSquareUnder3Csr),
	.oDotSquareColor4(wDotSquareColor4Csr),	.oDotSquareLeft4(wDotSquareLeft4Csr),	.oDotSquareRight4(wDotSquareRight4Csr),	.oDotSquareTop4(wDotSquareTop4Csr),	.oDotSquareUnder4(wDotSquareUnder4Csr),
	.oDotSquareColor5(wDotSquareColor5Csr),	.oDotSquareLeft5(wDotSquareLeft5Csr),	.oDotSquareRight5(wDotSquareRight5Csr),	.oDotSquareTop5(wDotSquareTop5Csr),	.oDotSquareUnder5(wDotSquareUnder5Csr),
	.oDotSquareColor6(wDotSquareColor6Csr),	.oDotSquareLeft6(wDotSquareLeft6Csr),	.oDotSquareRight6(wDotSquareRight6Csr),	.oDotSquareTop6(wDotSquareTop6Csr),	.oDotSquareUnder6(wDotSquareUnder6Csr),
	.oDotSquareColor7(wDotSquareColor7Csr),	.oDotSquareLeft7(wDotSquareLeft7Csr),	.oDotSquareRight7(wDotSquareRight7Csr),	.oDotSquareTop7(wDotSquareTop7Csr),	.oDotSquareUnder7(wDotSquareUnder7Csr),
	// Scene Change
	.oSceneColor(wSceneColorCsr),
	.oSceneFrameTiming(wSceneFrameTimingCsr),
	.oSceneFrameAddEn(wSceneFrameAddEnCsr),
	.oSceneFrameSubEn(wSceneFrameSubEnCsr),
	.oSceneFrameRst(wSceneFrameRstCsr),
	.iSceneAlphaMax(wSceneAlphaMaxCsr),
	.iSceneAlphaMin(wSceneAlphaMinCsr),
	//
	.oObdAnimeFrameNum(wObdAnimeFrameNumCsr),
	.oObdAnimeXpos(wObdAnimeXposCsr),
	.oObdAnimeYpos(wObdAnimeYposCsr),
	// Draw Position
	.iBdpHpos(wPdpHposCsr),
	.iBdpVpos(wPdpVposCsr),
	.oPdpXpos(wPdpXposCsr),
	.oPdpYpos(wPdpYposCsr),
	.oPdpInit(wPdpInitCsr),
	// Block Ram Cache
	.oBramWd(wBramWdCsr),
	.oBramAdrs(wBramAdrsCsr),
	//
	.iSRST(rBRST),	.iSCLK(iSCLK)
);

/**-----------------------------------------------------------------------------
 * Block RST
 *-----------------------------------------------------------------------------*/
 always @(posedge iSCLK)
begin
	rBRST	<= iSRST | wBRST;
	rnBRST	<= inSRST & (~wBRST);
end


/**----------------------------------------------------------------------------
 * キャラクターの座標移動を司る
 *---------------------------------------------------------------------------*/

/**----------------------------------------------------------------------------
 * Pgu に対するビデオデータの管理を司る
  *---------------------------------------------------------------------------*/
// VideoInfoManageUnit

/**----------------------------------------------------------------------------
 * Video Pixel Generator (Vpg)
 *---------------------------------------------------------------------------*/
wire [lpDstColorDepth-1:0] wVpgPD;
reg  qVpgRS;
wire wVpgVD;
wire wVpgFD;

VideoPixelGenUnit #(
	.pVHA(pVHA),
	.pVVA(pVVA),
	.pVHAW(lpVHAW),
	.pVVAW(lpVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth),
	//
	.pObjectAnimeNum(pObjectAnimeNum),
	.pObjectAnimeTime(pObjectAnimeTime),
	.pObjectAnimeXposWidth(pObjectAnimeXposWidth),
	.pObjectAnimeYposWidth(pObjectAnimeYposWidth)
) VideoPixelGenUnit (
	// Csr Dot Square Gen
	.iDotSquareColor1(wDotSquareColor1Csr),	.iDotSquareLeft1(wDotSquareLeft1Csr),	.iDotSquareRight1(wDotSquareRight1Csr),	.iDotSquareTop1(wDotSquareTop1Csr),	.iDotSquareUnder1(wDotSquareUnder1Csr),
	.iDotSquareColor2(wDotSquareColor2Csr),	.iDotSquareLeft2(wDotSquareLeft2Csr),	.iDotSquareRight2(wDotSquareRight2Csr),	.iDotSquareTop2(wDotSquareTop2Csr),	.iDotSquareUnder2(wDotSquareUnder2Csr),
	.iDotSquareColor3(wDotSquareColor3Csr),	.iDotSquareLeft3(wDotSquareLeft3Csr),	.iDotSquareRight3(wDotSquareRight3Csr),	.iDotSquareTop3(wDotSquareTop3Csr),	.iDotSquareUnder3(wDotSquareUnder3Csr),
	.iDotSquareColor4(wDotSquareColor4Csr),	.iDotSquareLeft4(wDotSquareLeft4Csr),	.iDotSquareRight4(wDotSquareRight4Csr),	.iDotSquareTop4(wDotSquareTop4Csr),	.iDotSquareUnder4(wDotSquareUnder4Csr),
	.iDotSquareColor5(wDotSquareColor5Csr),	.iDotSquareLeft5(wDotSquareLeft5Csr),	.iDotSquareRight5(wDotSquareRight5Csr),	.iDotSquareTop5(wDotSquareTop5Csr),	.iDotSquareUnder5(wDotSquareUnder5Csr),
	.iDotSquareColor6(wDotSquareColor6Csr),	.iDotSquareLeft6(wDotSquareLeft6Csr),	.iDotSquareRight6(wDotSquareRight6Csr),	.iDotSquareTop6(wDotSquareTop6Csr),	.iDotSquareUnder6(wDotSquareUnder6Csr),
	.iDotSquareColor7(wDotSquareColor7Csr),	.iDotSquareLeft7(wDotSquareLeft7Csr),	.iDotSquareRight7(wDotSquareRight7Csr),	.iDotSquareTop7(wDotSquareTop7Csr),	.iDotSquareUnder7(wDotSquareUnder7Csr),
	//
	.iSceneColor(wSceneColorCsr),
	.iSceneFrameTiming(wSceneFrameTimingCsr),
	.iSceneFrameAddEn(wSceneFrameAddEnCsr),
	.iSceneFrameSubEn(wSceneFrameSubEnCsr),
	.iSceneFrameRst(wSceneFrameRstCsr),
	.oSceneAlphaMax(wSceneAlphaMaxCsr),
	.oSceneAlphaMin(wSceneAlphaMinCsr),
	//
	.iObdAnimeFrameNum(wObdAnimeFrameNumCsr),
	.iObdAnimeXpos(wObdAnimeXposCsr),
	.iObdAnimeYpos(wObdAnimeYposCsr),
	// Draw Position
	.oBdpHpos(wBdpHposCsr),	.oBdpVpos(wBdpVposCsr),	.oBdpFe(),
	.iPdpXpos(wPdpXposCsr),
	.iPdpYpos(wPdpYposCsr),
	.iPdpInit(wPdpInitCsr),
	// Block Ram (Cache)
	.iBramWd(wBramWdCsr),
	.iBramAdrs(wBramAdrsCsr),
	// Dst Fifo Side
	.oPD(wVpgPD),		.iRS(qVpgRS),
	.oVD(wVpgVD),		.oFD(wVpgFD),
	// rst
	.iUnitRst(wVpgUnitRstCsr),
	// Common
	.iRST(rBRST),		.inRST(rnBRST),		.iCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Video Tft Unit
//-----------------------------------------------------------------------------
wire[lpDstColorDepth-1:0]	wTftDQ;
wire						wTftWRX;
wire						wTftDCX;
wire						wTftRDX;
wire						wTftCSX;
wire						wTftRST;
wire[ 3:0]					wTftIM;
reg [lpDstColorDepth-1:0] 	qVtuDS;
reg							qVtuWE;
wire						wVtuFLL;

VideoTftUnit VideoTftUnit (
	// Video Output Part
	.oTftDQ(wTftDQ),			.oTftWRX(wTftWRX),	.oTftDCX(wTftDCX),
	.oTftRDX(wTftRDX),			.oTftCSX(wTftCSX),	.oTftRST(wTftRST),
	.oTftIM(wTftIM),
	// Data Stream Input Part
	.iDS(qVtuDS),				.iWE(qVtuWE),		.oFLL(wVtuFLL),
	// MCU Data Stream Input Part
	.iMcuDS(wVtuMcuDqCsr),		.iMcuWRX(wVtuMcuWRXCsr),	.iMcuDCX(wVtuMcuDCXCsr),
	.iMcuRDX(wVtuMcuRDXCsr),	.iMcuCSX(wVtuMcuCSXCsr),	.iMcuRST(wVtuMcuRSTCsr),
	.iMcuIM(wVtuMcuIMCsr),		.iMcuGate(wVtuMcuGateCsr),
	// MCU Data Stream Input Part
	.iConverterRst(wVtuConverterRstCsr),
	// Common
	.iSRST(rBRST),		.inSRST(rnBRST),	.iSCLK(iSCLK),
	.iVRST(iVRST),		.inVRST(inVRST),	.iVCLK(iVCLK)
);

always @*
begin
	qVtuDS	<= wVpgPD;
	qVtuWE	<= wVpgVD;
	qVpgRS 	<= ~wVtuFLL;
end

/**----------------------------------------------------------------------------
 * Back Light
 *---------------------------------------------------------------------------*/
wire wPwm;
 
DutyGenerator #(
	.pPWMDutyWidth(16),
	.pIVtimerWidth(32)
) TftBl (
	.oPwm(wPwm),
	.oDutyCycleCke(),
	.oIVCke(),
	.iPWMEn(wVtuMcuBLCsr),
	.iDutyRatio(wVtuBlDutyRatioCsr),
	.iIVtimer(wVtuBlIVtimerCsr),
	// Common
	.iRST(iSRST),	.iCLK(iSCLK)
);

/**----------------------------------------------------------------------------
 * Video Signals Coneect
 *---------------------------------------------------------------------------*/
// Video TFT Signals
assign oVIDEO_DQ	= wTftDQ;
assign oVIDEO_WRX	= wTftWRX;
assign oVIDEO_DCX	= wTftDCX;
assign oVIDEO_RDX	= wTftRDX;
assign oVIDEO_CSX	= wTftCSX;
assign oVIDEO_RST	= wTftRST;
assign oVIDEO_IM[0]	= wTftIM[0];
assign oVIDEO_IM[1]	= wTftIM[1];
assign oVIDEO_IM[2]	= wTftIM[2];
assign oVIDEO_IM[3]	= wTftIM[3];
assign oVIDEO_BL	= wPwm;
// Video Sync Signals
assign oVIDEO_DCK 	= 1'b0;		// unused
assign oVIDEO_HS 	= 1'b0;		//
assign oVIDEO_VS 	= 1'b0;		//
assign oVIDEO_DE 	= 1'b0;		//
assign oVIDEO_FE 	= 1'b0;		//


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction



endmodule