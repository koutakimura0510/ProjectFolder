`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * 
 * 23-09-02 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module VideoTxBlock_tb;


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
localparam	lpVCLKCycle = 13;	// VCLK サイクル

reg	wSCLK = 0;	reg	wSRST = 1;	reg	wnSRST = 0;
reg	wVCLK = 0;	reg	wVRST = 1;	reg	wnVRST = 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end

always begin
    #(lpVCLKCycle/2);
    wVCLK = ~wVCLK;
end

//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = 1;
	wVRST  = 0;
	wnVRST = 1;
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

wire [7:0] wVIDEO_R;
wire [7:0] wVIDEO_G;
wire [7:0] wVIDEO_B;
wire wVIDEO_DCK;
wire wVIDEO_HS;
wire wVIDEO_VS;
wire wVIDEO_DE;
wire wVIDEO_FE;
wire wVIDEO_RST;

VideoTxBlock #(
	.pVHA(lpVHA),
	.pVVA(lpVVA)
) VideoTxBlock (
	//
	.oVIDEO_R(wVIDEO_R),	
	.oVIDEO_G(wVIDEO_G),
	.oVIDEO_B(wVIDEO_B),
	.oVIDEO_DCK(wVIDEO_DCK),
	.oVIDEO_HS(wVIDEO_HS),
	.oVIDEO_VS(wVIDEO_VS),
	.oVIDEO_DE(wVIDEO_DE),
	.oVIDEO_FE(wVIDEO_FE),
	.oVIDEO_RST(wVIDEO_RST),
	// Usi Bus Master Read
	.oSUsiRd(),
	// Usi Bus Master Write
	.iSUsiWd(),
	.iSUsiAdrs(),
	// Ufi Bus Master Read
	.iMUfiRd(),
	.iMUfiAdrs(),
	// Ufi Bus Master Write
	.oMUfiWd(),
	.oMUfiAdrs(),
	.iMUfiRdy(),
	// common
	.iSRST(wSRST),		.inSRST(wnSRST),	.iSCLK(wSCLK),
	.iVRST(wVRST),		.inVRST(wnVRST),	.iVCLK(wVCLK)
);

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
	.iRST(wVRST),
	.iCLK(wVCLK)
);

always @*
begin
	qBfsColorR 	<= wVIDEO_R;
	qBfsColorG 	<= wVIDEO_G;
	qBfsColorB 	<= wVIDEO_B;
	qBfsVde		<= wVIDEO_DE;
	qBfsAfe		<= wVIDEO_FE;
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
	$dumpfile("VideoTxBlock_tb.vcd");
	$dumpvars(0, VideoTxBlock_tb);	// 引数0:下位モジュール表示, 1:Topのみ
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