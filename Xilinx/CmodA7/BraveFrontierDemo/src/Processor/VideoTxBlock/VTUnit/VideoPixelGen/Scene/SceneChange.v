/*
Create 2022/12/04
Author koutakimura
-
シーンチェンジ用のピクセルデータを生成する
※シーンチェンジとはマップ間移動時の 暗転・明転処理などのこと

例えば 30fps 毎に 黒画面で徐々に暗転させる場合は下記設定にする。
iSceneFrameTiming 	= 30
iSceneFrameAddEn  	= 1
iSceneFrameRst		= 1

設定後 Alpha 値が 0 から F になると、oSceneAlphaMax が Assert される。
Host は 通知を読み取り命令に応じて下記設定にする。
iSceneFrameTiming 	= 30
iSceneFrameAddEn  	= 0
iSceneFrameSubEn  	= 1
iSceneFrameRst		= 1


設定後 Alpha 値が F から 0 になると、oSceneAlphaMin が Assert される。
Host は 通知を読み取り命令に応じて下記設定にする。
iSceneFrameRst		= 0
*/
module SceneChange #(
	parameter								pColorDepth		= 16,
)(
	// Internal Port
	// output pixel data
    output 	[pColorDepth-1:0]    			oPixel,				// Dest Pixel Data
	// Status
	input 									iFe,				// frame end
	// Csr
    input	[pColorDepth-1:0]				iSceneColor,		// 描画色
	input 	[6:0]							iSceneFrameTiming,	// SceneChange の更新速度,fps基準
	input 									iSceneFrameAddEn,	// SceneChange Add Start
	input 									iSceneFrameSubEn,	// SceneChange Sub Start
    input                       			iSceneFrameRst,
	output									oSceneAlphaMax,
	output 									oSceneAlphaMin,
	// Clk rst
    input                       			iClk
);


//-----------------------------------------------------------------------------
// 設定データに基づき、暗転処理を行う。
//-----------------------------------------------------------------------------
reg [pColorDepth-1:0] 	rColor;					assign oPixel 			= rColor;
reg 					rSceneAlphaMax;			assign oSceneAlphaMax 	= rSceneAlphaMax;
reg 					rSceneAlphaMin;			assign oSceneAlphaMin 	= rSceneAlphaMin;
reg [6:0]				rFeCnt;
reg 					qFrameUpdateEn;
reg 					qAlphaMax;
reg 					qAlphaMin;
//
wire [];
//
wire [pColorDepth-1:0] 	wColorAdd = rColor + 16'1000;
wire [pColorDepth-1:0] 	wColorSub = rColor - 16'1000;

always @(posedge iClk)
begin
	casex ({iFrameRst, qFrameUpdateEn, iFe, qAlphaMin, qAlphaMax, iFrameSubEn, iFrameAddEn})
		'b1xxxxxx:	rColor <= iColor;
		'b011x0x1:	rColor <= wColorAdd;
		'b0110x1x:	rColor <= wColorSub;
		default: 	rColor <= rColor;
	endcase

	casex ({iFrameRst, qFrameUpdateEn, iFe, iFrameSubEn, iFrameAddEn})
		'b1xxxx: 		rFeCnt <= 8'd0;
		'b011xx:		rFeCnt <= 8'd0;
		'b001x1:		rFeCnt <= rFeCnt + 1'b1;
		'b0011x:		rFeCnt <= rFeCnt + 1'b1;
		default:	 	rFeCnt <= rFeCnt;
	endcase

	// CSR 保存用にレジスタ出力
	rSceneAlphaMax	<= qAlphaMax;
	rSceneAlphaMin	<= qAlphaMin;
end

always @*
begin
	qFrameUpdateEn 	<= (rFeCnt == iFrameTiming);
	qAlphaMax		<= rColor[15:12] == 4'd15;
	qAlphaMin		<= rColor[15:12] == 4'd0;
end

endmodule