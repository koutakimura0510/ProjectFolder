`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/10/10
// Author  KoutaKimura
// -
//----------------------------------------------------------
module VideoPixelGen_tb;


//----------------------------------------------------------
// Clk Generator
//----------------------------------------------------------
localparam 	lpSysClkCycle 	= 4;

wire 		wSysClk;
reg  		rSysRst;
//
SimSystemClk #(
	.pSystemClkCycle	(lpSysClkCycle)
) SimSystemClk (
	.oSysClk			(wSysClk)
);


//-----------------------------------------------------------------------------
// リセット信号の生成
// rVtbVideoRst リセットは rVtbSystemRst より遅らせることで、
// Dual CLk FIFO にある程度データを溜める目的がある。
//-----------------------------------------------------------------------------
task system_reset();
begin
	rSysRst 		<= 1'b1;
	#(lpSysClkCycle * 10);
	rSysRst 		<= 1'b0;
end
endtask


//-----------------------------------------------------------------------------
// module
//-----------------------------------------------------------------------------
localparam lpHdisplayWidth		= 11;
localparam lpVdisplayWidth		= 11;
localparam lpColorDepth			= 16;
localparam lpHDisplay			= 120;
localparam lpVDisplay			= 272;

VideoPixelGen #(
	.pHdisplayWidth		(lpHdisplayWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pColorDepth		(lpColorDepth)
) VideoPixelGen (
	.iHdisplay			(lpHDisplay),
	.iVdisplay			(lpVDisplay),
	.oPixel				(),
	.oVd				(),
	.iRst				(rSysRst),
	.iCke				(1'b1),
	.iClk				(wSysClk)
);


//-----------------------------------------------------------------------------
// TestBench 動作
// lpFrameCnt 画像出力の回数を指定可能、複数回ループさせて正しく raw 画像が出れば OK
//-----------------------------------------------------------------------------
localparam lpFrameCnt = 15;
integer n;

initial
begin
	system_reset();

    $stop;
end


endmodule
