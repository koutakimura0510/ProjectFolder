`timescale 1ns / 1ps
/*
Create  2022/12/04
Author  kimura
Editor  VSCode ver1.73.1
Build   Vivado22.2
Device  CmodA7
-
内蔵乗算機がちゃんと使用されるか、合成結果を確認するためのサンプル

*/

module DspTop(
	output oLed,
	input iClk,
	input iRst
);


//-----------------------------------------------------------------------------
// 乗算用計算値生成
//-----------------------------------------------------------------------------
reg [7:0] rDstR;
reg [7:0] rDstG;
reg [7:0] rDstB;

always @( posedge iClk )
begin
	if (iRst)
	begin
		rDstR <= 8'hff;
		rDstG <= 8'hff;
		rDstB <= 8'hff;
	end
	else
	begin
		rDstR <= rDstR + 1'd1;
		rDstG <= rDstG + 2'd2;
		rDstB <= rDstB + 2'd3;
	end
end

//-----------------------------------------------------------------------------
// 内蔵乗算機を使用
// この場合は 3つ使用される
// (* use_dsp ="yes" *) wire[7:0] wSrcR = 4'd10 * rDstR;
// (* use_dsp ="yes" *) wire[7:0] wSrcG = 4'd10 * rDstG;
// (* use_dsp ="yes" *) wire[7:0] wSrcB = 4'd10 * rDstB;
// 
// (* use_dsp ="yes" *) reg[7:0] rDspR;
// (* use_dsp ="yes" *) reg[7:0] rDspG;
// (* use_dsp ="yes" *) reg[7:0] rDspB;
// 
// (* use_dsp ="yes" *) プリミティブをなくすと、LUT と FF が使用される。
// ソースコード上では乗算だが、加算器をたくさん並べた回路に生成される。
// 上記3つ使用をなくすと下記のリソースが増える。
//-----------------------------------------------------------------------------
(* use_dsp ="yes" *) wire[7:0] wSrcR = rDstR[4+:4] * rDstR[3:0];
(* use_dsp ="yes" *) wire[7:0] wSrcG = rDstG[ 7:4] * rDstG[3:0];
(* use_dsp ="yes" *) wire[7:0] wSrcB = rDstB[ 7:4] * rDstB[3:0];
// (* use_dsp ="yes" *) reg[7:0] rDspR;
// (* use_dsp ="yes" *) reg[7:0] rDspG;
// (* use_dsp ="yes" *) reg[7:0] rDspB;

reg [7:0] rSrcR;
reg [7:0] rSrcG;
reg [7:0] rSrcB;

always @( posedge iClk )
begin
	if (iRst)
	begin
		rSrcR <= 8'hff;
		rSrcG <= 8'hff;
		rSrcB <= 8'hff;
	end
	else
	begin
		rSrcR <= wSrcR;
		rSrcG <= wSrcG;
		rSrcB <= wSrcB;
		// rDspR <= 4'd10 * rDstR;
		// rDspG <= 4'd10 * rDstG;
		// rDspB <= 4'd10 * rDstB;
		// rSrcR <= rDspR;
		// rSrcG <= rDspG;
		// rSrcB <= rDspB;
	end
end

assign oLed = &{rSrcR} && &{rSrcG} && &{rSrcB};

endmodule
