`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * 23-09-02 v1.00 : New Release
 * 25-03-22 v1.01 : New Release
 *-----------------------------------------------------------------------------*/
`include "./include/video_csr.vh"

module VideoPixelGenUnit_tb;

/**-----------------------------------------------------------------------------
 * System Simlation Parameter
 *-----------------------------------------------------------------------------*/
localparam lpWaitCycle			= 100;
genvar x;		// System 共通変数

/**-----------------------------------------------------------------------------
 * CLK RST Generator
 *-----------------------------------------------------------------------------*/
localparam	lpSCLKCycle = 4;	// CLK サイクル

reg	wSCLK	= 0;
reg	wSRST	= 1;
reg	wnSRST	= 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end

/**-----------------------------------------------------------------------------
 * Reset task
 *-----------------------------------------------------------------------------*/
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = ~wSRST;
	#(lpSCLKCycle * 10);
end
endtask //reset_init

/**-----------------------------------------------------------------------------
 * USI Write Task
 *-----------------------------------------------------------------------------*/
wire [31:0]	wSUsiRd;
reg  [31:0] rSUsiWd = 0;
reg  [31:0] rSUsiAdrs = 0;

task usi_write (
	input [31:0] wd,
	input [31:0] adrs
);
begin
	rSUsiWd   = wd;
	rSUsiAdrs = adrs | 32'h40000000;
	#(lpSCLKCycle);
end
endtask //usi_write


/**-----------------------------------------------------------------------------
 * VideoTxCsr
 *-----------------------------------------------------------------------------*/
 // Video Timing Parametor
localparam lpVHA	= 80;		// 生成画像 横サイズ
localparam lpVVA	= 80;		// 生成画像 縦サイズ
localparam lpVHAW = f_detect_bitwidth(lpVHA);	// Video Horizontal Active Width
localparam lpVHBW = f_detect_bitwidth(2);		// Video Horizontal Back Width
localparam lpVHFW = f_detect_bitwidth(2);		// Video Horizontal Front Width
localparam lpVHSW = f_detect_bitwidth(2);		// Video Horizontal Sync Width
localparam lpVVAW = f_detect_bitwidth(lpVVA);	// Video Vertical Active Width
localparam lpVVBW = f_detect_bitwidth(2);		// Video Vertical Front Width
localparam lpVVFW = f_detect_bitwidth(2);		// Video Vertical Back Width
localparam lpVVSW = f_detect_bitwidth(2);		// Video Vertical Sync Width
// Color Depth Parametor
localparam lpDstColorDepth 	= 16;	// RGB565
localparam lpSynColorDepth	= 24;	// α8bit +  RGB565
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
wire [23:0] wBramWdCsr;
wire [31:0] wBramAdrsCsr;
//
wire [lpVHAW-1:0] wPdpHposCsr;
wire [lpVVAW-1:0] wPdpVposCsr;

VideoTxCsr #(
	// USIB
	.pBlockAdrsWidth(4),					.pAdrsMap(6),	
	.pUsiBusWidth(32),						.pCsrAdrsWidth(16),
	.pCsrActiveWidth(12),					.pDmaAdrsWidth(1),
	// Video Timing Parameter
    .pVHA(lpVHA),	.pVHB(2),		.pVHF(2),		.pVHS(2),
    .pVVA(lpVVA),	.pVVF(2),		.pVVB(2),		.pVVS(2),
	.pVHAW(lpVHAW),	.pVHBW(lpVHBW),	.pVHFW(lpVHFW),	.pVHSW(lpVHSW),
    .pVVAW(lpVVAW),	.pVVBW(lpVVBW),	.pVVFW(lpVVFW),	.pVVSW(lpVVSW),
	// Video Control / Status
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth)
) VideoTxCsr (
	// Bus Master Read
	.oSUsiRd(wSUsiRd),
	// Bus Master Write
	.iSUsiWd(rSUsiWd),	.iSUsiAdrs(rSUsiAdrs),
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
	// Block Ram Cache
	.oBramWd(wBramWdCsr),
	.oBramAdrs(wBramAdrsCsr),
	// Status
	.iPdpHpos(wPdpHposCsr),
	.iPdpVpos(wPdpVposCsr),
	//
	.iSRST(wSRST),	.iSCLK(wSCLK)
);

always @(posedge wSCLK)
begin
	rBRST	<= wSRST | wBRST;
	rnBRST	<= wnSRST & (~wBRST);
end


/**-----------------------------------------------------------------------------
 * VideoPixelGenUnit
 *-----------------------------------------------------------------------------*/
wire [lpDstColorDepth-1:0] 	wVpgPD;
reg  						qVpgRS;
wire 						wVpgVD;
wire 						wVpgFD;

VideoPixelGenUnit #(
	.pVHA(lpVHA),
	.pVVA(lpVVA),
	.pVHAW(lpVHAW),
	.pVVAW(lpVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth)
) VideoPixelGenUnit (
	// Csr Dot Square Gen
	.iDotSquareColor1(wDotSquareColor1Csr),	.iDotSquareLeft1(wDotSquareLeft1Csr),	.iDotSquareRight1(wDotSquareRight1Csr),	.iDotSquareTop1(wDotSquareTop1Csr),	.iDotSquareUnder1(wDotSquareUnder1Csr),
	.iDotSquareColor2(wDotSquareColor2Csr),	.iDotSquareLeft2(wDotSquareLeft2Csr),	.iDotSquareRight2(wDotSquareRight2Csr),	.iDotSquareTop2(wDotSquareTop2Csr),	.iDotSquareUnder2(wDotSquareUnder2Csr),
	.iDotSquareColor3(wDotSquareColor3Csr),	.iDotSquareLeft3(wDotSquareLeft3Csr),	.iDotSquareRight3(wDotSquareRight3Csr),	.iDotSquareTop3(wDotSquareTop3Csr),	.iDotSquareUnder3(wDotSquareUnder3Csr),
	.iDotSquareColor4(wDotSquareColor4Csr),	.iDotSquareLeft4(wDotSquareLeft4Csr),	.iDotSquareRight4(wDotSquareRight4Csr),	.iDotSquareTop4(wDotSquareTop4Csr),	.iDotSquareUnder4(wDotSquareUnder4Csr),
	.iDotSquareColor5(wDotSquareColor5Csr),	.iDotSquareLeft5(wDotSquareLeft5Csr),	.iDotSquareRight5(wDotSquareRight5Csr),	.iDotSquareTop5(wDotSquareTop5Csr),	.iDotSquareUnder5(wDotSquareUnder5Csr),
	.iDotSquareColor6(wDotSquareColor6Csr),	.iDotSquareLeft6(wDotSquareLeft6Csr),	.iDotSquareRight6(wDotSquareRight6Csr),	.iDotSquareTop6(wDotSquareTop6Csr),	.iDotSquareUnder6(wDotSquareUnder6Csr),
	.iDotSquareColor7(wDotSquareColor7Csr),	.iDotSquareLeft7(wDotSquareLeft7Csr),	.iDotSquareRight7(wDotSquareRight7Csr),	.iDotSquareTop7(wDotSquareTop7Csr),	.iDotSquareUnder7(wDotSquareUnder7Csr),
	// Csr SceneChange
	.iSceneColor(),
	.iSceneFrameTiming(),
	.iSceneFrameAddEn(),
	.iSceneFrameSubEn(),
	.iSceneFrameRst(),
	.oSceneAlphaMax(),
	.oSceneAlphaMin(),
	// Block Ram (Cache)
	.iBramWd(wBramWdCsr),
	.iBramAdrs(wBramAdrsCsr),
	// Fifo I/F
	.oPD(wVpgPD),		.iRS(qVpgRS),
	.oVD(wVpgVD),		.oFD(wVpgFD),
	// Control Status
	.oBdpHpos(),		.oBdpVpos(),		.oBdpFe(),
	// common
	.iRST(rBRST),		.inRST(rnBRST),		.iCLK(wSCLK)
);

reg rEmp;

always @(posedge wSCLK)
begin
	if (wSRST) 	rEmp <= 1'b1;
	else 		rEmp <= ~rEmp;
end

always @*
begin
	// qVpgRS		<= ~wVpgEmp;
	qVpgRS		<= rEmp;
end

/**-----------------------------------------------------------------------------
 * BmpFileSaver
 *-----------------------------------------------------------------------------*/
reg [7:0] 	qBfsColorR, qBfsColorG, qBfsColorB;
reg 		qBfsVde, qBfsAfe;
wire 		wBfsSaveEnd;

BmpFileSaver #(
	// .pFileSave(),
	.pHdisplay(lpVHA),
	.pVdisplay(lpVVA)
	// .pBmpFormat(),
	// .pBmpHeaderSize()
) BmpFileSaver (
	.iColorR(qBfsColorR),
	.iColorG(qBfsColorG),
	.iColorB(qBfsColorB),
	.iVde(qBfsVde),
	.iAFE(qBfsAfe),
	.oSaveEnd(wBfsSaveEnd),
	.iRST(rBRST),
	.iCLK(wSCLK)
);

always @*
begin
	qBfsColorR 	<= {wVpgPD[15:11],3'b000};
	qBfsColorG 	<= {wVpgPD[10:5],2'b00};
	qBfsColorB 	<= {wVpgPD[4:0],3'b000};
	qBfsVde		<= wVpgVD;
	// qBfsAfe		<= wVpgFD & wVpgVD;
	qBfsAfe		<= wVpgFD;
end
//-----------------------------------------------------------------------------
task BmpFileSaveDone(
	input integer flag
);
begin
	while (wBfsSaveEnd == flag)
	begin
		#(lpSCLKCycle);
	end
end
endtask


/**-----------------------------------------------------------------------------
 * Simlation Start
 *-----------------------------------------------------------------------------*/
localparam lpFrameCnt = 1;
reg [23:0] rColor;
reg [7:0] rRom [0:1024*3];
integer n;
integer fd;
integer filesize;

initial
begin
	$dumpfile("VideoPixelGenUnit_tb.vcd");
	$dumpvars(0, VideoPixelGenUnit_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	$display(" ----- SIM START !!");
	reset_init();
	usi_write(0, `VIDEO_REG_DOT_SQUARE_LEFT1);
	usi_write(80, `VIDEO_REG_DOT_SQUARE_RIGHT1);
	usi_write(0, `VIDEO_REG_DOT_SQUARE_TOP1);
	usi_write(80, `VIDEO_REG_DOT_SQUARE_UNDER1);
	usi_write('h40ff00, `VIDEO_REG_DOT_SQUARE_COLOR1);
	//
	
	fd = $fopen("./res/minoriko.bin", "rb");
	$display("File FD %d", fd);
	filesize = $fread(rRom, fd);
	$display("FileSize %d ", filesize);
	$fclose(fd);

	for (n = 0; n < 1024; n = n + 1)
	begin
		rColor[23:16] = rRom[0+n*3];
		rColor[15:8] = rRom[1+n*3];
		rColor[7:0] = rRom[2+n*3];
		// $display("Adrs %d = %h", n, rColor);
		usi_write(32'h0100_0000 + n, `VIDEO_REG_BRAM_ADRS);
		usi_write(rColor, `VIDEO_REG_BRAM_WD);
	end
	usi_write(32'h0, `VIDEO_REG_BRAM_ADRS);
	
	// Reset シーケンス
	usi_write(1, `VIDEO_REG_BLOCK_RST);
	#(lpSCLKCycle*lpWaitCycle);
	usi_write(0, `VIDEO_REG_BLOCK_RST);

	for (n = 0; n < lpFrameCnt; n = n + 1)
	begin
		BmpFileSaveDone(0);
		BmpFileSaveDone(1);
	end

	#(lpSCLKCycle*lpWaitCycle);
	$display(" ----- SIM END !!");
	$finish;
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
// UFIB_tb
//----------------------------------------------------------------------------