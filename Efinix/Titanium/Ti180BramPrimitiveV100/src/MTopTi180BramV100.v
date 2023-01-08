//-----------------------------------------------------------------------------
// Create  2023/1/7
// Author  kimura
// Editor  VSCode ver1.70.0
// Build   Efinity2022.1.22.6
// Borad   Ti180M484
// -
// BRAM プリミティブ確認プロジェクト
// efx_run.bat .\Ti180BramPrimitiveV100.xml --flow compile <- コンパイル
// efx_run.py <project name>.xml --flow program --pgm_opts mode=jtag <- FPGA 書き込み
//-----------------------------------------------------------------------------
module MTopTi180BramV100 (
//
// User Interface LED, SW
output	[ 5:0] 	oLed,
input  	[ 1:0]	iPushSw,
//
// PLL1 Control
input			iSCLK,				// 100 [MHz]
input			iPCLK,				// 25 [MHz]
input			iPll2Locked,		// PLL1 Locked
output			oPll2nRst,			// PLL1 Rst Active Low
//
// Jtag I/F
input  			jtag_inst1_TDI,
input  			jtag_inst1_TCK,
input  			jtag_inst1_TMS,
output 			jtag_inst1_TDO,
input  			jtag_inst1_SEL,
input  			jtag_inst1_DRCK,
input  			jtag_inst1_RUNTEST,
input  			jtag_inst1_CAPTURE,
input  			jtag_inst1_SHIFT,
input  			jtag_inst1_UPDATE,
input  			jtag_inst1_RESET
);


//-----------------------------------------------------------------------------
// RST 生成
//-----------------------------------------------------------------------------
assign 	oPll2nRst = 1'b1;
//
reg 	qLocked;
reg 	rSRST,		rnSRST, 	qSRST,		qnSRST;
reg 	rPRST,		rnPRST, 	qPRST,		qnPRST;

always @(posedge iSCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rSRST  <= 1'b1;
	else if (qLocked)			rSRST  <= 1'b0;
	else 						rSRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnSRST <= 1'b0;
	else if (qLocked)			rnSRST <= 1'b1;
	else 						rnSRST <= 1'b0;
end
//
always @(posedge iPCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rPRST  <= 1'b1;
	else if (qLocked)			rPRST  <= 1'b0;
	else 						rPRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnPRST <= 1'b0;
	else if (qLocked)			rnPRST <= 1'b1;
	else 						rnPRST <= 1'b0;
end

always @*
begin
	qLocked 	<= iPll2Locked;
	qSRST 		<= rSRST;
	qnSRST 		<= rnSRST;
	qPRST 		<= rPRST;
	qnPRST 		<= rnPRST;
end

//-----------------------------------------------------------------------------
// BRAM Core
//-----------------------------------------------------------------------------
localparam lpFifoBitWidth	= 8;
localparam lpFifoDepth		= 1024;
localparam lpFullAlMost		= 16;

reg	[lpFifoBitWidth-1:0]rWd;
reg  					qWe;
wire 					wFull;
wire[lpFifoBitWidth-1:0]wRd;
reg  					qRe;
wire 					wRvd;
wire 					wEmp;
//
reg 					qMaxCntCke;
reg [26:0]				rCnt;

EfxRamFifoController #(
	.pFifoBitWidth(lpFifoBitWidth),
	.pFifoDepth(lpFifoDepth),
	.pFullAlMost(lpFullAlMost)
) EfxRamFifoController (
	.iWd	(rWd),			.iWe	(qWe),
	.oFull	(wFull),
	.oRd	(wRd),			.iRe	(qRe),
	.oRvd	(wRvd),			.oEmp	(wEmp),
	.iRST	(qSRST),		.iCLK	(iSCLK)
);

always @(posedge iSCLK)
begin
	if (qSRST) 		rWd <= {lpFifoBitWidth{1'b0}};
	else if (qWe)	rWd <= rWd + 1'b1;
	else 			rWd <= rWd;

	if (qSRST)		rCnt <= 0;
	else if (qMaxCntCke) rCnt <= 0;
	else 			rCnt <= rCnt + 1'b1;
end

always @*
begin
	qMaxCntCke <= (rCnt == 'd10000000);
	qWe <= (~wFull);
	qRe <= (~wEmp) & qMaxCntCke;
end

assign oLed = wRd[5:0];


endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------