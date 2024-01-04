/*-----------------------------------------------------------------------------
 * Create  2023/08/23
 * Author  kouta kimura
 * -
 * v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module VideoTxBlock #(
	// USI
	parameter pBlockAdrsWidth	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h06,
	parameter pUsiBusWidth 		= 16,
	parameter pCsrAdrsWidth 	= 16,
	parameter pCsrActiveWidth 	= 16,
	// UFI
	parameter pUfiDqBusWidth 	= 16,
	parameter pUfiAdrsBusWidth 	= 32,
	parameter [3:0] pUfiAdrsMap	= 'h2,
	parameter pDmaAdrsWidth 	= 18,
	parameter pDmaBurstLength 	= 256,
	// Display Size, Simlation も兼ねて Top から操作設定可能にしている
    parameter pVHA	= 480,		// Video Horizontal Active
    parameter pVHB	= 43,		// Video Horizontal Back
    parameter pVHF	= 8,		// Video Horizontal Front
    parameter pVHS	= 10,		// Video Horizontal Sync
    parameter pVVA	= 272,		// Video Vertical Active
    parameter pVVF	= 12,		// Video Vertical Front
    parameter pVVB	= 4,		// Video Vertical Back
    parameter pVVS	= 10		// Video Vertical Sync
)(
	// VIDEO Output Signal Ctrl
	output [7:0]	oVIDEO_R,
	output [7:0]	oVIDEO_G,
	output [7:0]	oVIDEO_B,
	output			oVIDEO_DCK,
	output			oVIDEO_HS,
	output			oVIDEO_VS,
	output			oVIDEO_DE,
	output			oVIDEO_FE,
	output			oVIDEO_RST,
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] 	oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	input							iMUfiRdy,
	// CLK Rst
	input 	iSRST,
	input 	inSRST,
	input 	iSCLK,
	input 	iVRST,
	input 	inVRST,
	input 	iVCLK
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
localparam lpColorDepth = 32;
//
wire wDmaEnableCsr;
wire wDmaCycleEnableCsr;
wire wDmaAdrsStartCsr;
wire wDmaAdrsEndCsr;
wire wDmaAdrsAddCsr;
wire wDmaDoneCsr;
//
wire wMapXSizeCsr;
wire wMapYSizeCsr;
//
wire [lpColorDepth-1:0]	wDotSquareColor1Csr, wDotSquareColor2Csr, wDotSquareColor3Csr, wDotSquareColor4Csr, wDotSquareColor5Csr, wDotSquareColor6Csr, wDotSquareColor7Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft1Csr,  wDotSquareRight1Csr, wDotSquareTop1Csr,   wDotSquareUnder1Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft2Csr,  wDotSquareRight2Csr, wDotSquareTop2Csr,   wDotSquareUnder2Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft3Csr,  wDotSquareRight3Csr, wDotSquareTop3Csr,   wDotSquareUnder3Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft4Csr,  wDotSquareRight4Csr, wDotSquareTop4Csr,   wDotSquareUnder4Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft5Csr,  wDotSquareRight5Csr, wDotSquareTop5Csr,   wDotSquareUnder5Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft6Csr,  wDotSquareRight6Csr, wDotSquareTop6Csr,   wDotSquareUnder6Csr;
wire signed [lpVHAW:0] 	wDotSquareLeft7Csr,  wDotSquareRight7Csr, wDotSquareTop7Csr,   wDotSquareUnder7Csr;
//
wire wSceneColorCsr;
wire wSceneFrameTimingCsr;
wire wSceneFrameAddEnCsr;
wire wSceneFrameSubEnCsr;
wire wSceneFrameRstCsr;
wire wSceneAlphaMaxCsr;
wire wSceneAlphaMinCsr;
//
wire [lpVHAW-1:0] wPdpHposCsr;
wire [lpVVAW-1:0] wPdpVposCsr;

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
	.pColorDepth(lpColorDepth)
) VideoTxCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// DMA
	.oDmaEnable(wDmaEnableCsr),
	.oDmaCycleEnable(wDmaCycleEnableCsr),
	.oDmaAdrsStart(wDmaAdrsStartCsr),
	.oDmaAdrsEnd(wDmaAdrsEndCsr),
	.oDmaAdrsAdd(wDmaAdrsAddCsr),
	.iDmaDone(wDmaDoneCsr),
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
	// Status
	.iPdpHpos(wPdpHposCsr),
	.iPdpVpos(wPdpVposCsr),
	//
	.iSRST(iSRST),	.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Video Pixel Generator (Vpg)
//-----------------------------------------------------------------------------
wire [lpColorDepth-1:0] wVpgRd;
reg  qVpgRe;
wire wVpgRvd;
wire wVpgEmp;

VideoPixelGenUnit #(
	.pVHA(pVHA),		.pVVA(pVVA),
	.pVHAW(lpVHAW),		.pVVAW(lpVVAW),
	.pColorDepth(lpColorDepth)
) VideoPixelGenUnit (
	// Ufi Bus Master Read
	.iMUfiRd(iMUfiRd),		.iMUfiAdrs(iMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(oMUfiWd),		.oMUfiAdrs(oMUfiWAdrs),		.iMUfiRdy(iMUfiRdy),
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
	// Control Status
	.oPdpHpos(wPdpHposCsr),
	.oPdpVpos(wPdpVposCsr),
	.oFe(),
	// Dst Fifo Side
	.oRd(wVpgRd),		.iRe(qVpgRe),
	.oRvd(wVpgRvd),		.oEmp(wVpgEmp),
	// Common
	.iRST(iSRST),	.inRST(inSRST),		.iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Dual CLK Fifo Side SCLK to VCLK
// 外部 RAM のフレームバッファは使用せずに、内部ラインバッファのみで描画を行う
//-----------------------------------------------------------------------------
localparam lpVafDepth 		= 512;
localparam lpVafBitWidth 	= lpColorDepth;

reg  [lpVafBitWidth-1:0]	qVafWd;
reg							qVafWe;
wire						wVafFull;
wire 						wVafAlert;
wire [lpVafBitWidth-1:0]	wVafRd;
wire 						wVafRvd;
reg  						qVafRe;
wire 						wVafEmp;

ASyncFifoController #(
	.pFifoDepth(lpVafDepth),
	.pFifoBitWidth(lpVafBitWidth)
) VideoAsyncFifo (
	// Src Fifo Side
	.iWd(qVafWd),		.iWe(qVafWe),
	.oFull(wVafFull),	.oRemaingCntAlert(wVafAlert),
	// Dst Fifo Side
	.oRd(wVafRd),		.iRe(qVafRe),
	.oRvd(),			.oEmp(),
	// common
	.inARST(inSRST),	.iWCLK(iSCLK),	.iRCLK(iVCLK)
);

always @*
begin
	qVafWd 	<= wVpgRd;
	qVafWe 	<= wVpgRvd;
	qVpgRe	<= (~wVafAlert);
end

//-----------------------------------------------------------------------------
// Video Signal Generator
//-----------------------------------------------------------------------------
reg [2:1] rVideoHS, rVideoVS, rVideoDE, rVideoFE;
wire wVideoHS, wVideoVS, wVideoDE, wVideoFE;
reg  qVsgRst;

VideoSyncGen #(
	// Video Timing Parameter
    .pVHA(pVHA),	.pVHB(pVHB),	.pVHF(pVHF),	.pVHS(pVHS),
    .pVVA(pVVA),	.pVVF(pVVF),	.pVVB(pVVB),	.pVVS(pVVS),
	.pVHAW(lpVHAW)
) VideoSyncGen (
	// Video Signals
	.oHS(wVideoHS),	.oVS(wVideoVS),
	.oDE(wVideoDE),	.oFE(wVideoFE),
	// common
	.iVRST(qVsgRst),	.iVCLK(iVCLK)
);

always @(posedge iVCLK)
begin
	rVideoHS <= {rVideoHS[1],wVideoHS};
	rVideoVS <= {rVideoVS[1],wVideoVS};
	rVideoDE <= {rVideoDE[1],wVideoDE};
	rVideoFE <= {rVideoFE[1],wVideoFE};
end

always @*
begin
	qVafRe <= wVideoDE;
end


/**----------------------------------------------------------------------------
 * Video Signals Coneect
 *---------------------------------------------------------------------------*/
assign oVIDEO_R		= wVafRd[23:16];
assign oVIDEO_G		= wVafRd[15: 8];
assign oVIDEO_B		= wVafRd[ 7: 0];
assign oVIDEO_DCK 	= iVCLK;
assign oVIDEO_HS 	= rVideoHS[2];
assign oVIDEO_VS 	= rVideoVS[2];
assign oVIDEO_DE 	= rVideoDE[2];
assign oVIDEO_FE 	= rVideoFE[2];
assign oVIDEO_RST	= 1'b1;

//-----------------------------------------------------------------------------
// Rst 
//-----------------------------------------------------------------------------
reg [7:0] rVRstWaitCnt;

always @(posedge iVCLK)
begin
	if (iVRST) 			rVRstWaitCnt <= 8'd0;
	else if (!qVsgRst)	rVRstWaitCnt <= rVRstWaitCnt;
	else 				rVRstWaitCnt <= rVRstWaitCnt + 1'b1;
end

always @*
begin
	qVsgRst <= ~rVRstWaitCnt[7];
end

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