/*
Create  2022/12/04
Author  kimura
-
22-12-04:新規作成 ピクセルデータのオーバーレイ処理を行うモジュール, パイプライン処理で 出力レイテンシ 3
22-12-10:並列処理で Overlay 計算を行う場合のために、Src 側の Alpha値を含んだデータを出力するように変更

*/
module OverlayMarge #(
	// variable
	parameter						pDspUsed	= "no",		// "yes" の場合 Dsp 6つ使用
	parameter						pColorDepth	 = 16,
	// not
	parameter						pRGBBitWidth = pColorDepth / 4,					// ARGB 一つの要素の Bit幅
	parameter						pRBitLsb	 = 0,								// Red 開始 Bit ABGR データの並び順に則る
	parameter						pGBitLsb	 = pRGBBitWidth,					// Green 開始 Bit
	parameter						pBBitLsb	 = pRGBBitWidth + pRGBBitWidth,		// Blue 開始 Bit
	parameter						pAlphaBitMsb = pColorDepth - 1,					// Alpha Msb
	parameter						pAlphaBitLsb = pColorDepth - (pColorDepth / 4),	// Alpha Lsb
	parameter						pDspBitWidth = (pRGBBitWidth * 2)				// 乗算器 の Bit幅
)(
	//
	input	[pColorDepth-1:0]		iSrcPixel,		// 合成元の色データ
	input	[pColorDepth-1:0]		iOverlayPixel,	// 合成を行う色データ
	input 							iWe,			// 前段の write enable 信号
	//
	output	[pColorDepth-1:0]		oDstPixel,		// 合成後の色データ
	output 							oWe,
    // CLK Reset
    input           				iRst,
    input							iClk
	// copy paste
	// .iSrcPixel		(),
	// .iOverlayPixel	(),
	// .iWe			(),
	// .oDstPixel		(),
	// .oWe			(),
	// .iRst			(),
	// .iClk			()
);

/*
下記計算を stage 毎に分けてパイプライン化で計算を行う
((src_a * src_r) + ((255 - src_a) * dst_r)) / 255;

上記は割り算のリソースが厳しいので下記計算に変更
8bit は実際に使用する 4bit で記載
((src_a * src_r) + 15 + ((15 - src_a) * dst_r)) / 16;
*/

//-----------------------------------------------------------------------------
// Stage 1
//-----------------------------------------------------------------------------
(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wOverlayRstage1 = iOverlayPixel[pAlphaBitMsb:pAlphaBitLsb] * iOverlayPixel[pRBitLsb+:pRGBBitWidth];
(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wOverlayGstage1 = iOverlayPixel[pAlphaBitMsb:pAlphaBitLsb] * iOverlayPixel[pGBitLsb+:pRGBBitWidth];
(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wOverlayBstage1 = iOverlayPixel[pAlphaBitMsb:pAlphaBitLsb] * iOverlayPixel[pBBitLsb+:pRGBBitWidth];

wire[pRGBBitWidth-1:0] wSrcAstage1	   = {pRGBBitWidth{1'b1}} - iOverlayPixel[pAlphaBitMsb:pAlphaBitLsb];
//
reg [pColorDepth-1:0]	rSrcPixelstage1;
reg [pDspBitWidth-1:0] 	rOverlayRstage1;
reg [pDspBitWidth-1:0] 	rOverlayGstage1;
reg [pDspBitWidth-1:0] 	rOverlayBstage1;
reg [pRGBBitWidth-1:0] 	rSrcAstage1;
reg 					rWestage1;

always @( posedge iClk )
begin
	rSrcPixelstage1	<= iSrcPixel;
	rOverlayRstage1	<= wOverlayRstage1;
	rOverlayGstage1	<= wOverlayGstage1;
	rOverlayBstage1	<= wOverlayBstage1;
	rSrcAstage1		<= wSrcAstage1;

	if (iRst)	rWestage1	<= 1'b0;
	else 		rWestage1	<= iWe;
end

//-----------------------------------------------------------------------------
// stage 2
//-----------------------------------------------------------------------------
wire[pDspBitWidth-1:0] wOverlayRstage2 = rOverlayRstage1 + {pRGBBitWidth{1'b1}};
wire[pDspBitWidth-1:0] wOverlayGstage2 = rOverlayGstage1 + {pRGBBitWidth{1'b1}};
wire[pDspBitWidth-1:0] wOverlayBstage2 = rOverlayBstage1 + {pRGBBitWidth{1'b1}};

(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wSrcRstage2 = wSrcAstage1 * rSrcPixelstage1[pRBitLsb+:pRGBBitWidth];
(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wSrcGstage2 = wSrcAstage1 * rSrcPixelstage1[pGBitLsb+:pRGBBitWidth];
(* use_dsp =pDspUsed *) wire[pDspBitWidth-1:0] wSrcBstage2 = wSrcAstage1 * rSrcPixelstage1[pBBitLsb+:pRGBBitWidth];
//
reg [pRGBBitWidth-1:0]	rSrcAstage2;	// Alpha 値のみ抜粋
reg [pDspBitWidth-1:0] 	rOverlayRstage2;
reg [pDspBitWidth-1:0] 	rOverlayGstage2;
reg [pDspBitWidth-1:0] 	rOverlayBstage2;
reg [pDspBitWidth-1:0] 	rSrcRstage2;
reg [pDspBitWidth-1:0] 	rSrcGstage2;
reg [pDspBitWidth-1:0] 	rSrcBstage2;
reg 					rWestage2;

always @( posedge iClk )
begin
	rSrcAstage2		<= rSrcPixelstage1[pAlphaBitMsb:pAlphaBitLsb];
	rOverlayRstage2	<= wOverlayRstage2;
	rOverlayGstage2	<= wOverlayGstage2;
	rOverlayBstage2	<= wOverlayBstage2;
	rSrcRstage2		<= wSrcRstage2;
	rSrcGstage2		<= wSrcGstage2;
	rSrcBstage2		<= wSrcBstage2;
	
	if (iRst)	rWestage2	<= 1'b0;
	else 		rWestage2	<= rWestage1;
end


//-----------------------------------------------------------------------------
// stage 3
//-----------------------------------------------------------------------------
wire[pDspBitWidth-1:0] wSrcRstage3 = rOverlayRstage2 + rSrcRstage2;
wire[pDspBitWidth-1:0] wSrcGstage3 = rOverlayGstage2 + rSrcGstage2;
wire[pDspBitWidth-1:0] wSrcBstage3 = rOverlayBstage2 + rSrcBstage2;
//
reg [pRGBBitWidth-1:0]	rSrcAstage3;
reg [pRGBBitWidth-1:0]  rSrcRstage3;
reg [pRGBBitWidth-1:0]  rSrcGstage3;
reg [pRGBBitWidth-1:0]  rSrcBstage3;			assign oDstPixel = {rSrcAstage3, rSrcBstage3, rSrcGstage3, rSrcRstage3};
reg 					rWestage3;				assign oWe		 =  rWestage3;

always @( posedge iClk )
begin
	rSrcAstage3	<= rSrcAstage2;
	rSrcRstage3	<= wSrcRstage3[pRGBBitWidth+:pRGBBitWidth];
	rSrcGstage3	<= wSrcGstage3[pRGBBitWidth+:pRGBBitWidth];
	rSrcBstage3	<= wSrcBstage3[pRGBBitWidth+:pRGBBitWidth];

	if (iRst)	rWestage3	<= 1'b0;
	else 		rWestage3	<= rWestage2;
end

endmodule