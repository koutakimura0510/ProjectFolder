`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * 
 * 23-09-02 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module VideoPixelGenUnit_tb;


//-----------------------------------------------------------------------------
// System Simlation Parameter
//-----------------------------------------------------------------------------
localparam lpWaitCycle			= 3000;

//-----------------------------------------------------------------------------
// System 共通変数
//-----------------------------------------------------------------------------
genvar x;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
localparam	lpSCLKCycle = 4;	// CLK サイクル

reg	wSCLK = 0;
reg	wSRST = 1;
reg	wnSRST = 0;

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
localparam lpVHA	= 480;
localparam lpVVA	= 272;
localparam lpVHAW	= f_detect_bitwidth(lpVHA);
localparam lpVVAW	= f_detect_bitwidth(lpVVA);
//
wire [16:0] wVpgRd;
reg  qVpgRe;
wire wVpgRvd;
wire wVpgEmp;
wire wVpgFe;

VideoPixelGenUnit #(
	.pVHA(lpVHA),
	.pVVA(lpVVA),
	.pVHAW(lpVHAW),
	.pVVAW(lpVVAW)
) VideoPixelGenUnit (
	// Csr SceneChange
    .iSceneColor(),
	.iSceneFrameTiming(),
	.iSceneFrameAddEn(),
	.iSceneFrameSubEn(),
    .iSceneFrameRst(),
	.oSceneAlphaMax(),
	.oSceneAlphaMin(),
	// Fifo I/F
	.oRd(wVpgRd),		.iRe(qVpgRe),
    .oRvd(wVpgRvd),		.oEmp(wVpgEmp),
	// control status
	.oFe(wVpgFe),
    // common
    .iRST(wSRST),		.inRST(wnSRST),		.iCLK(wSCLK)
);

always @*
begin
	qVpgRe <= ~wVpgEmp;
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
	qBfsColorR 	<= {wVpgRd[5:0],3'b000};
	qBfsColorG 	<= {wVpgRd[10:6],2'b00};
	qBfsColorB 	<= {wVpgRd[15:11],3'b000};
	qBfsVde		<= wVpgRvd;
	qBfsAfe		<= wVpgFe;
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

	// #(lpSCLKCycle*lpWaitCycle);
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