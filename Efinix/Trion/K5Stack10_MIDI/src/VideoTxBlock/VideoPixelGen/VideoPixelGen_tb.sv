`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/10/10
// Author  KoutaKimura
// -
// VideoPixelGen.v をシミュレーションする
// -
// 2022-12-11 : SceneChange のオーバーレイ処理追加に伴い更新
//----------------------------------------------------------
module VideoPixelGen_tb;


//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam lpSysClkCycle = 4;

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
// module
//-----------------------------------------------------------------------------
localparam	lpHdisplayWidth		= 11;
localparam	lpVdisplayWidth		= 11;
localparam	lpColorDepth		= 16;
localparam	lpHDisplay			= 5;
localparam	lpVDisplay			= 5;
localparam	lpSceneColor		= 16'hf123;
//
localparam	[1:0]
			lpSceneIdol	= 0,
			lpSceneAddEn = 1,
			lpSceneSubEn = 2;
//
wire 	[lpColorDepth-1:0]	wPixel;
wire 						wVd;
// wire 					wEdd;
reg		[1:0]	rSceneState;
reg 			rSceneFrameAddEn;
reg 			rSceneFrameSubEn;
reg 			rSceneFrameRst;
wire 			wSceneAlphaMax;
wire 			wSceneAlphaMin;

VideoPixelGen #(
	.pHdisplayWidth		(lpHdisplayWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pColorDepth		(lpColorDepth)
) VideoPixelGen (
	.iSUfiWd			(),
	.iSUfiAdrs			(),
	.iSUfiWEd			(),
	//
	.iHdisplay			(lpHDisplay),
	.iVdisplay			(lpVDisplay),
	//
	.iSceneColor		(lpSceneColor),
	.iSceneFrameTiming	(7'd5),
	.iSceneFrameAddEn	(rSceneFrameAddEn),
	.iSceneFrameSubEn	(rSceneFrameSubEn),
	.iSceneFrameRst		(rSceneFrameRst),
	.oSceneAlphaMax		(wSceneAlphaMax),
	.oSceneAlphaMin		(wSceneAlphaMin),
	//
	.oPixel				(wPixel),
	.oWEd				(wVd),
	.iEdd				(1'b1),
	//
	.iRST				(rSysRst),
	.iCLK				(rSysClk)
);

//-----------------------------------------------------------------------------
// Scene Change Test State
// 塗りつぶし色で alpha 値の加算と減算を繰り返す
//-----------------------------------------------------------------------------
always @(posedge rSysClk)
begin
	if (rSysRst)
	begin
		rSceneState			<= lpSceneIdol;
		rSceneFrameAddEn 	<= 1'b0;
		rSceneFrameSubEn	<= 1'b0;
		rSceneFrameRst		<= 1'b1;
	end
	else
	begin
		casex (rSceneState)
			lpSceneIdol:
			begin
				rSceneState			<= lpSceneAddEn;
				rSceneFrameRst 		<= 1'b0;
				rSceneFrameAddEn	<= 1'b0;
				rSceneFrameSubEn	<= 1'b0;
			end
			//
			lpSceneAddEn:
			if (wSceneAlphaMax)
			begin
				rSceneState			<= lpSceneSubEn;
				rSceneFrameAddEn	<= 1'b0;
				rSceneFrameSubEn	<= 1'b0;
			end
			else
			begin
				rSceneState			<= lpSceneAddEn;
				rSceneFrameAddEn	<= 1'b1;
				rSceneFrameSubEn	<= 1'b0;
			end
			//
			lpSceneSubEn:
			if (wSceneAlphaMin)
			begin
				rSceneState			<= lpSceneIdol;
				rSceneFrameAddEn	<= 1'b0;
				rSceneFrameSubEn	<= 1'b0;
			end
			else
			begin
				rSceneState			<= lpSceneSubEn;
				rSceneFrameAddEn	<= 1'b0;
				rSceneFrameSubEn	<= 1'b1;
			end
			//
			default:
			begin
				rSceneState			<= lpSceneAddEn;
				rSceneFrameRst 		<= 1'b0;
				rSceneFrameAddEn	<= 1'b0;
				rSceneFrameSubEn	<= 1'b0;
			end
		endcase
	end
end


//-----------------------------------------------------------------------------
// TestBench 動作
//-----------------------------------------------------------------------------

initial
begin
	reset_init();
    $stop;
end


endmodule
