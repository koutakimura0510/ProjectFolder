`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * 
 * 23-09-02 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module VideoPixelGenUnit_tb;


//-----------------------------------------------------------------------------
// System Simlation Parameter
//-----------------------------------------------------------------------------
localparam lpWaitCycle			= 100;

//-----------------------------------------------------------------------------
// System 共通変数
//-----------------------------------------------------------------------------
genvar x;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
localparam	lpSCLKCycle = 4;	// CLK サイクル

reg	wSCLK	= 0;
reg	wSRST	= 1;
reg	wnSRST	= 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end

//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = ~wSRST;
	#(lpSCLKCycle * 10);
end
endtask

//-----------------------------------------------------------------------------
// VideoPixelGenUnit
//-----------------------------------------------------------------------------
localparam lpVHA	= 64;
localparam lpVVA	= 64;
localparam lpVHAW	= f_detect_bitwidth(lpVHA);
localparam lpVVAW	= f_detect_bitwidth(lpVVA);
//
localparam lpDstColorDepth = 16;
localparam lpSynColorDepth = 24;
//
wire [lpDstColorDepth-1:0] 	wVpgPD;
reg  						qVpgRS;
wire 						wVpgVD;
wire 						wVpgFD;
//
reg [lpSynColorDepth-1:0]	qDsgColor;
reg [lpVHAW:0]				qDsgLeft;
reg [lpVHAW:0]				qDsgRight;
reg [lpVVAW:0]				qDsgUp;
reg [lpVVAW:0]				qDsgDown;

VideoPixelGenUnit #(
	.pVHA(lpVHA),
	.pVVA(lpVVA),
	.pVHAW(lpVHAW),
	.pVVAW(lpVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth)
) VideoPixelGenUnit (
	// Csr Dot Square Gen
	.iDotSquareColor1(qDsgColor),	.iDotSquareLeft1(qDsgLeft),	.iDotSquareRight1(qDsgRight),	.iDotSquareTop1(qDsgUp),	.iDotSquareUnder1(qDsgDown),
	.iDotSquareColor2(qDsgColor),	.iDotSquareLeft2(qDsgLeft),	.iDotSquareRight2(qDsgRight),	.iDotSquareTop2(qDsgUp),	.iDotSquareUnder2(qDsgDown),
	.iDotSquareColor3(qDsgColor),	.iDotSquareLeft3(qDsgLeft),	.iDotSquareRight3(qDsgRight),	.iDotSquareTop3(qDsgUp),	.iDotSquareUnder3(qDsgDown),
	.iDotSquareColor4(qDsgColor),	.iDotSquareLeft4(qDsgLeft),	.iDotSquareRight4(qDsgRight),	.iDotSquareTop4(qDsgUp),	.iDotSquareUnder4(qDsgDown),
	.iDotSquareColor5(qDsgColor),	.iDotSquareLeft5(qDsgLeft),	.iDotSquareRight5(qDsgRight),	.iDotSquareTop5(qDsgUp),	.iDotSquareUnder5(qDsgDown),
	.iDotSquareColor6(qDsgColor),	.iDotSquareLeft6(qDsgLeft),	.iDotSquareRight6(qDsgRight),	.iDotSquareTop6(qDsgUp),	.iDotSquareUnder6(qDsgDown),
	.iDotSquareColor7(qDsgColor),	.iDotSquareLeft7(qDsgLeft),	.iDotSquareRight7(qDsgRight),	.iDotSquareTop7(qDsgUp),	.iDotSquareUnder7(qDsgDown),
	// Csr SceneChange
	.iSceneColor(),
	.iSceneFrameTiming(),
	.iSceneFrameAddEn(),
	.iSceneFrameSubEn(),
	.iSceneFrameRst(),
	.oSceneAlphaMax(),
	.oSceneAlphaMin(),
	// Fifo I/F
	.oPD(wVpgPD),		.iRS(qVpgRS),
	.oVD(wVpgVD),		.oFD(wVpgFD),
	// Control Status
	.oBdpHpos(),		.oBdpVpos(),		.oBdpFe(),
	// common
	.iRST(wSRST),		.inRST(wnSRST),		.iCLK(wSCLK)
);

reg rEmp;

always @(posedge wSCLK)
begin
	if (wSRST) 	rEmp <= 1'b1;
	else 		rEmp <= ~rEmp;
end

always @*
begin
	qDsgColor	<= 24'h44ffff;
	qDsgLeft	<= 0;
	qDsgRight	<= 32;
	qDsgUp		<= 0;
	qDsgDown	<= 32;
	// qVpgRS		<= ~wVpgEmp;
	qVpgRS		<= rEmp;
end

//-----------------------------------------------------------------------------
// BmpFileSaver
//-----------------------------------------------------------------------------
reg [7:0] qBfsColorR;
reg [7:0] qBfsColorG;
reg [7:0] qBfsColorB;
reg qBfsVde;
reg qBfsAfe;
wire wBfsSaveEnd;

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
	.iRST(wSRST),
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

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
localparam lpFrameCnt = 1;
integer n;

initial
begin
	$dumpfile("VideoPixelGenUnit_tb.vcd");
	$dumpvars(0, VideoPixelGenUnit_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	$display(" ----- SIM START !!");
	reset_init();

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