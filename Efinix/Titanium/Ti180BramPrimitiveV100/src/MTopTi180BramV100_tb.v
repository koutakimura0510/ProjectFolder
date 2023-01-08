//-----------------------------------------------------------------------------
// Create  2023/1/7
// Author  kimura
//-----------------------------------------------------------------------------
module MTopTi180BramV100_tb;


//-----------------------------------------------------------------------------
// CLK Gen
//-----------------------------------------------------------------------------
localparam lpSysClkCycle = 4;

reg	rSCLK = 0;
reg	rSRST = 1;

always begin
    #(lpSysClkCycle/2);
    rSCLK = ~rSCLK;
end
// Reset 処理
task reset_init;
begin
	rSRST = 1;
	#(lpSysClkCycle * 5);
	rSRST = 0;
	#(lpSysClkCycle * 5);
end
endtask


//-----------------------------------------------------------------------------
// BRAM 接続
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
reg [31:0]				rCnt;

EfxRamFifoController #(
	.pFifoBitWidth(lpFifoBitWidth),
	.pFifoDepth(lpFifoDepth),
	.pFullAlMost(lpFullAlMost)
) EfxRamFifoController (
	.iWd	(rWd),			.iWe	(qWe),
	.oFull	(wFull),
	.oRd	(wRd),			.iRe	(qRe),
	.oRvd	(wRvd),			.oEmp	(wEmp),
	.iRST	(rSRST),		.iCLK	(rSCLK)
);

always @(posedge rSCLK)
begin
	if (rSRST) 		rWd <= {lpFifoBitWidth{1'b0}};
	else if (qWe)	rWd <= rWd + 1'b1;
	else 			rWd <= rWd;

	if (qMaxCntCke) rCnt <= 0;
	else 			rCnt <= rCnt + 1'b1;
end

always @*
begin
	qMaxCntCke <= (rCnt == 'd50000000);
	qWe <= (~wFull) & qMaxCntCke;
	qRe <= (~wEmp);
end


//-----------------------------------------------------------------------------
// Initial
//-----------------------------------------------------------------------------
initial
begin
	// FPGA Slave
	reset_init();
	#(lpSysClkCycle * 100);
	$finish;
end



endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------