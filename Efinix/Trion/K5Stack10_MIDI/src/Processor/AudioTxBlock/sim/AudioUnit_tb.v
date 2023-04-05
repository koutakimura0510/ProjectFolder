`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/09/03
// Author  KoutaKimura
// -
// 参考文献
// https://qiita.com/takeru0x5569/items/b054cdcf9e014f332edd
//----------------------------------------------------------
module AudioUnit_tb;


//-----------------------------------------------------------------------------
// ファイル名
//-----------------------------------------------------------------------------
// localparam lpRawFileSave	= "d:/workspace/Xilinx/workspace/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.raw";


//----------------------------------------------------------
// CLK Rst 生成
//----------------------------------------------------------
localparam 	lpSysClkCycle 	= 2;
//
reg  		rSysRst;
wire 		wSysClk;
reg 		rAudioRst;
//
SimSystemClk #(
	.pSystemClkCycle	(lpSysClkCycle)
) SIM_SYSTEM_CLK (
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
	rAudioRst	 	<= 1'b0;
	#(lpSysClkCycle);
	rSysRst 		<= 1'b0;
	#(lpSysClkCycle * 10);
	rAudioRst 		<= 1'b1;
end
endtask


//----------------------------------------------------------
// Block に接続
//----------------------------------------------------------
localparam [6:0] lpTone = 69;
//
wire wAudioMClk;

AudioTxUnit #(
	.pSamplingBitWidth	(8)
) AudioTxUnit (
	.oAudioMclk			(wAudioMClk),
	.iAudioCke		(rAudioRst),
	.iAudioTone			(lpTone),
	.iSysRst			(rSysRst),
	.iAudioClk			(wSysClk)
);


//-----------------------------------------------------------------------------
// TestBench 動作
//-----------------------------------------------------------------------------
localparam lpFrameCnt = 10;
integer n;

initial
begin
	system_reset();

    $stop;
end


endmodule
