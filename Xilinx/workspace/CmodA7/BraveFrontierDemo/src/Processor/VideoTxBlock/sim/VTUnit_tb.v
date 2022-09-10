`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/09/03
// Author  KoutaKimura
// -
// 参考文献
// https://qiita.com/takeru0x5569/items/b054cdcf9e014f332edd
//----------------------------------------------------------
module VTUnit_tb;


//-----------------------------------------------------------------------------
// ファイル名
//-----------------------------------------------------------------------------
localparam lpRawFileSave	= "d:/workspace/Xilinx/workspace/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.raw";


//----------------------------------------------------------
// Clk Generator
//----------------------------------------------------------
localparam 	lpSysClkCycle 	= 2;
localparam 	lpVideoClkCycle = 16;
//
reg  		rSysRst;
wire 		wSysClk;
reg 		rVtbSystemRst;
reg 		rVtbVideoRst;
wire 		wVideoClk;
//
SimSystemClk #(
	.pSystemClkCycle	(lpSysClkCycle)
) SIM_SYSTEM_CLK (
	.oSysClk			(wSysClk)
);

SimSystemClk #(
	.pSystemClkCycle	(lpVideoClkCycle)
) SIM_VIDEO_CLK (
	.oSysClk			(wVideoClk)
);


//-----------------------------------------------------------------------------
// リセット信号の生成
// rVtbVideoRst リセットは rVtbSystemRst より遅らせることで、
// Dual CLk FIFO にある程度データを溜める目的がある。
//-----------------------------------------------------------------------------
task system_reset();
begin
	rSysRst 		<= 1'b1;
	rVtbSystemRst 	<= 1'b1;
	rVtbVideoRst 	<= 1'b1;
	#(lpSysClkCycle);
	rSysRst <= 1'b0;
	#(lpSysClkCycle * 10);
	rVtbSystemRst 	<= 1'b0;
	#(lpSysClkCycle * 10);
	rVtbVideoRst 	<= 1'b0;
end
endtask


//----------------------------------------------------------
// Block に接続
//----------------------------------------------------------
parameter   lpHdisplayWidth	= 11;
parameter	lpVdisplayWidth	= 11;
localparam	lpHdisplay		= 32;
localparam	lpHfront		= 8;
localparam	lpHback			= 43;
localparam	lpHpulse		= 30;
localparam	lpVdisplay		= 32;
localparam	lpVfront		= 12;
localparam	lpVback			= 4;
localparam	lpVpulse		= 10;
localparam [lpHdisplayWidth:0] lpHSyncStart	= lpHdisplay + lpHfront;
localparam [lpHdisplayWidth:0] lpHSyncEnd	= lpHdisplay + lpHfront + lpHpulse - 1'b1;
localparam [lpHdisplayWidth:0] lpHSyncMax	= lpHdisplay + lpHfront + lpHpulse + lpHback - 1'b1;
localparam [lpVdisplayWidth:0] lpVSyncStart	= lpVdisplay + lpVfront;
localparam [lpVdisplayWidth:0] lpVSyncEnd	= lpVdisplay + lpVfront + lpVpulse - 1'b1;
localparam [lpVdisplayWidth:0] lpVSyncMax	= lpVdisplay + lpVfront + lpVpulse + lpVback - 1'b1;
//
localparam lpColorDepth 	= 16;
localparam pDualClkFifoDepth= 32;
//
wire [7:0]	wTftColorR;
wire [7:0]	wTftColorG;
wire [7:0]	wTftColorB;
wire 		wTftDclk;
wire 		wTftHSync;
wire 		wTftVSync;
wire 		wTftDe;
wire 		wTftBackLight;
wire 		wTftRst;
wire 		wAFE;
//
assign wTftColorR[3:0] = 4'b0000;
assign wTftColorG[3:0] = 4'b0000;
assign wTftColorB[3:0] = 4'b0000;
//
VideoTxUnit #(
	.pHdisplayWidth		(lpHdisplayWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pColorDepth		(lpColorDepth),
	.pDualClkFifoDepth	(pDualClkFifoDepth)
) VIDEO_TX_UNIt (
	.oTftColorR			(wTftColorR[7:4]),
	.oTftColorG			(wTftColorG[7:4]),
	.oTftColorB			(wTftColorB[7:4]),
	.oTftDclk			(wTftDclk),
	.oTftHSync			(wTftHSync),
	.oTftVSync			(wTftVSync),
	.oTftDe				(wTftDe),
	.oTftBackLight		(wTftBackLight),
	.oTftRst			(wTftRst),
	.iHdisplay			(lpHdisplay),
	.iVdisplay			(lpVdisplay),
	.iHSyncStart		(lpHSyncStart),
	.iHSyncEnd			(lpHSyncEnd),
	.iHSyncMax			(lpHSyncMax),
	.iVSyncStart		(lpVSyncStart),
	.iVSyncEnd			(lpVSyncEnd),
	.iVSyncMax			(lpVSyncMax),
	.iVtbSystemRst		(rVtbSystemRst),
	.iVtbVideoRst		(rVtbVideoRst),
	.iDisplayRst		(1'b0),
	.iBlDutyRatio		(127),
	.iSysClk			(wSysClk),
	.iVideoClk			(wVideoClk),
	.iSysRst			(rSysRst),
	.oFe				(wAFE)
);


//-----------------------------------------------------------------------------
// ファイル書き込み
//-----------------------------------------------------------------------------
wire wSaveEnd;

RawFileSaver #(
	.pRawFileSave (lpRawFileSave)
) RAW_FILE_SAVER (
	.iColorR	(wTftColorR),
	.iColorG	(wTftColorG),
	.iColorB	(wTftColorB),
	.iVde		(wTftDe),
	.iAFE		(wAFE),
	.oSaveEnd	(wSaveEnd),
	.iRst		(rVtbVideoRst),
	.iClk		(wVideoClk)
);


//
task RawWriteWait(
	input integer flag
);
begin
	while (wSaveEnd == flag)
	begin
		#(lpVideoClkCycle);
	end
end
endtask


//-----------------------------------------------------------------------------
// TestBench 動作
//-----------------------------------------------------------------------------
localparam lpFrameCnt = 10;
integer n;

initial
begin
	system_reset();

	for (n = 0; n < lpFrameCnt; n = n + 1)
	begin
		RawWriteWait(0);
		RawWriteWait(1);
	end
    $finish;
end


endmodule
