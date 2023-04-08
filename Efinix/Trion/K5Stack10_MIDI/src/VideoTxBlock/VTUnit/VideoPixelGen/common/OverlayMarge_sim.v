/*
Create  2022/12/10
Author  kimura
-
OverlayMarge.v のシミュレーションファイル

*/
module OverlayMarge_sim;


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 4;	// CLK サイクル


//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSysClk = 0;
reg	rSysRst = 1;

always begin
    #(lpSysClkCycle/2);
    rSysClk = ~rSysClk;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 5);
	rSysRst = 0;
	#(lpSysClkCycle * 5);
end
endtask


//-----------------------------------------------------------------------------
// init
//-----------------------------------------------------------------------------
initial
begin
	reset_init();
	$stop;
end


//-----------------------------------------------------------------------------
// module connect
//-----------------------------------------------------------------------------
localparam lpSrcPixel 		= 16'hf269;
localparam lpOverlayPixel 	= 16'hf111;
//
wire [15:0]	wDst;
wire		wWe;

OverlayMarge #(
	.pDspUsed		("yes"),
	.pColorDepth	(16)
) OverlayMarge (
	.iSrcPixel		(lpSrcPixel),
	.iOverlayPixel	(lpOverlayPixel),
	.iWe			(1'b1),
	.oDstPixel		(wDst),
	.oWe			(wWe),
	.iRST			(rSysRst),
	.iCLK			(rSysClk)
);

endmodule