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
	output [7:3]	oVIDEO_R,
	output [7:2]	oVIDEO_G,
	output [7:3]	oVIDEO_B,
	output			oVIDEO_DCK,
	output			oVIDEO_HS,
	output			oVIDEO_VS,
	output			oVIDEO_DE,
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
localparam lpColorDepth = 16;
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
wire wSceneColorCsr;
wire wSceneFrameTimingCsr;
wire wSceneFrameAddEnCsr;
wire wSceneFrameSubEnCsr;
wire wSceneFrameRstCsr;
wire wSceneAlphaMaxCsr;
wire wSceneAlphaMinCsr;

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
	// Video Status
	.pColorDepth(lpColorDepth)
	//
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
	// Scene Change
	.oSceneColor(wSceneColorCsr),
	.oSceneFrameTiming(wSceneFrameTimingCsr),
	.oSceneFrameAddEn(wSceneFrameAddEnCsr),
	.oSceneFrameSubEn(wSceneFrameSubEnCsr),
	.oSceneFrameRst(wSceneFrameRstCsr),
	.iSceneAlphaMax(wSceneAlphaMaxCsr),
	.iSceneAlphaMin(wSceneAlphaMinCsr),
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
	.pVHA(pVHA),
	.pVVA(pVVA),
	.pVHAW(lpVHAW),
	.pVVAW(lpVVAW),
	.pColorDepth(lpColorDepth)
) VideoPixelGenUnit (
	.iSceneColor(wSceneColorCsr),
	.iSceneFrameTiming(wSceneFrameTimingCsr),
	.iSceneFrameAddEn(wSceneFrameAddEnCsr),
	.iSceneFrameSubEn(wSceneFrameSubEnCsr),
	.iSceneFrameRst(wSceneFrameRstCsr),
	.oSceneAlphaMax(wSceneAlphaMaxCsr),
	.oSceneAlphaMin(wSceneAlphaMinCsr),
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
reg		qVafWe;
wire	wVafFull;
wire [lpVafBitWidth-1:0]	wVafRd;
wire 	wVafRvd;
reg  	qVafRe;
wire 	wVafEmp;

ASyncFifoController #(
	.pFifoDepth(lpVafDepth),
	.pFifoBitWidth(lpVafBitWidth)
) VideoAsyncFifo (
	// Src Fifo Side
	.iWd(qVafWd),		.iWe(qVafWe),
	.oFull(wVafFull),
	.oRemaingCntAlert(),
	// Dst Fifo Side
	.oRd(wVafRd),		.iRe(qVafRe),
	.oRvd(),			.oEmp(),
	// common
	.inARST(inRST),		.iWCLK(iSCLK),	.iRCLK(iVCLK)
);

always @*
begin
	qVafWd 	<= wVpgRd;
	qVafWe 	<= wVpgRvd;
	qVpgRe	<= ~wVafFull;
end

//-----------------------------------------------------------------------------
// Video Signal Generator
//-----------------------------------------------------------------------------
reg [2:1] rVideoHS, rVideoVS, rVideoDE;
wire wVideoHS, wVideoVS, wVideoDE, wVideoFE;

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
	.iVRST(iVRST),	.iVCLK(iVCLK)
);

always @(posedge iVCLK)
begin
	rVideoHS <= {rVideoHS[1],wVideoHS};
	rVideoVS <= {rVideoVS[1],wVideoVS};
	rVideoDE <= {rVideoDE[1],wVideoDE};
end

always @*
begin
	qVafRe <= wVideoDE;
end

assign oVIDEO_R		= wVafRd[15:11];
assign oVIDEO_G		= wVafRd[10: 6];
assign oVIDEO_B		= wVafRd[ 5: 0];
assign oVIDEO_DCK 	= iVCLK;
assign oVIDEO_HS 	= rVideoHS[2];
assign oVIDEO_VS 	= rVideoVS[2];
assign oVIDEO_DE 	= rVideoDE[2];
assign oVIDEO_RST	= 1'b1;

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