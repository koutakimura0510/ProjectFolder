`timescale 1ns / 100ps
/*-----------------------------------------------------------------------------
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * 24-07-06 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module TbTopVideoTftUnit;


//-----------------------------------------------------------------------------
// System Simlation Parameter
//-----------------------------------------------------------------------------
localparam lpWaitCycle			= 500;

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

/**-----------------------------------------------------------------------------
 * Video Tx Csr Space
 *-----------------------------------------------------------------------------*/
// Video tft Unit
wire [23:0]	wVtuMcuDqCsr;
wire 		wVtuMcuWRXCsr,	wVtuMcuDCXCsr,	wVtuMcuRDXCsr,	wVtuMcuCSXCsr;
wire 		wVtuMcuRSTCsr;
wire [3:0]	wVtuMcuIMCsr;
wire 		wVtuMcuGateCsr;
wire		wVtuConverterRstCsr;

/**-----------------------------------------------------------------------------
 * Video Tft Unit
 *-----------------------------------------------------------------------------*/
wire[23:0]	wTftDQ;
wire		wTftWRX;
wire		wTftDCX;
wire		wTftRDX;
wire		wTftCSX;
wire		wTftRST;
wire[ 3:0]	wTftIM;
reg [23:0] 	qVtuDS;
reg			qVtuWE;
wire		wVtuFLL;
reg	[23:0]	rVtuDS;
reg			rVtuWE;

VideoTftUnit VideoTftUnit(
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
	.iSRST(wSRST),		.inSRST(wnSRST),	.iSCLK(wSCLK),
	.iVRST(wVRST),		.inVRST(wnVRST),	.iVCLK(wVCLK)
);

always @*
begin
	qVtuDS	<= rVtuDS;//wVpgRd;
	qVtuWE	<= rVtuWE;//wVpgRvd;
	// qVpgRe 	<= ;//~wVtuFLL;
end

always @(posedge wSCLK)
begin
	if (wSRST) 			rVtuDS <= 24'd0;
	else if (~wVtuFLL)	rVtuDS <= rVtuDS + 1'b1;
	else 				rVtuDS <= rVtuDS;
	
	if (wSRST) 			rVtuWE <= 1'd0;
	else if (~wVtuFLL)	rVtuWE <= 1'b1;
	else 				rVtuWE <= 1'b0;
end

assign wVtuMcuDqCsr		= 24'd0;
assign wVtuMcuDCXCsr	= 1'b0;
assign wVtuMcuRSTCsr	= 1'b0;
assign wVtuMcuWRXCsr	= 1'b0;
assign wVtuMcuCSXCsr	= 1'b0;
assign wVtuMcuGateCsr	= 1'b0;
assign wVtuMcuRDXCsr	= 1'b0;
assign wVtuMcuIMCsr		= 4'd0;
assign wVtuConverterRstCsr = 1'b0;


//-----------------------------------------------------------------------------
// BmpFileSaver
//-----------------------------------------------------------------------------
// reg [7:0] qBfsColorR;
// reg [7:0] qBfsColorG;
// reg [7:0] qBfsColorB;
// reg qBfsVde;
// reg qBfsAfe;
wire wBfsSaveEnd;

// BmpFileSaver #(
// 	// .pFileSave(),
// 	.pHdisplay(lpVHA),
// 	.pVdisplay(lpVVA)
// 	// .pBmpFormat(),
// 	// .pBmpHeaderSize()
// ) BmpFileSaver (
// 	.iColorR(qBfsColorR),
// 	.iColorG(qBfsColorG),
// 	.iColorB(qBfsColorB),
// 	.iVde(qBfsVde),
// 	.iAFE(qBfsAfe),
// 	.oSaveEnd(wBfsSaveEnd),
// 	.iRST(wVRST),
// 	.iCLK(wVCLK)
// );

// always @*
// begin
// 	qBfsColorR 	<= wVIDEO_R;
// 	qBfsColorG 	<= wVIDEO_G;
// 	qBfsColorB 	<= wVIDEO_B;
// 	qBfsVde		<= wVIDEO_DE;
// 	qBfsAfe		<= wVIDEO_FE;
// end
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
	$dumpfile("TbTopVideoTftUnit.vcd");
	$dumpvars(0, TbTopVideoTftUnit);	// 引数0:下位モジュール表示, 1:Topのみ
	$display(" ----- VIDEO SIM START !!");
	reset_init();

	// for (n = 0; n < lpFrameCnt; n = n + 1)
	// begin
	// 	BmpFileSaveDone(0);
	// 	BmpFileSaveDone(1);
	// end

	#(lpSCLKCycle*lpWaitCycle);
	$display(" ----- VIDEO SIM END !!");
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
				bitcnt = bitcnt + 1;
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
					bitwidth = bitwidth + 1;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction
endmodule