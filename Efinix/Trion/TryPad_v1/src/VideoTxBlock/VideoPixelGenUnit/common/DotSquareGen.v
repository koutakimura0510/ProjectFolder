//----------------------------------------------------------
// Create 2022/08/31
// Author koutakimura
// -
// 指定範囲で指定色の四角形データを出力する
// 
// 2022-09-29 座標が画面外の場合のドットデータ生成に対応
// 
//----------------------------------------------------------
module DotSquareGen #(
	parameter pVHAW  			= 11,
	parameter pVVAW  			= 11,
	parameter pDstColorDepth	= 16,	// RGB 色深度
	parameter pSynColorDepth	= 24	// 合成を行うピクセルデータの色深度
)(
	// Dst Pixel Stream I/F
	output	[pDstColorDepth-1:0]		oPD,		// Pixel Data
	output 								oVD,		// Pixel Valid
	output								oFD,		// Frame End
	output	[pVHAW-1:0]					oBHPD,		// Base Horizontal Position
	output	[pVVAW-1:0]					oBVPD,		// Base Vertical Position
	output	[pVHAW-1:0]					oPHPD,		// Player Horizontal Position
	output	[pVVAW-1:0]					oPVPD,		// Player Vertical Position
	// Src Pixel Stream I/F
	input	[pDstColorDepth-1:0]		iPS,		// Pixel Data
	input								iVS,		// Pixel Valid
	input								iFS,		// Pixel Valid
	input	[pVHAW-1:0]					iBHPS,		// Base Horizontal Position
	input	[pVVAW-1:0]					iBVPS,		// Base Vertical Position
	input	[pVHAW-1:0]					iPHPS,		// Player Horizontal Position
	input	[pVVAW-1:0]					iPVPS,		// Player Vertical Position
	// Control Status
	input			[pSynColorDepth-1:0]iColor1,
	input signed	[pVHAW:0]			iLeft1,
	input signed	[pVHAW:0]			iRight1,
	input signed	[pVVAW:0]			iTop1,
	input signed	[pVVAW:0]			iUnder1,
	input			[pSynColorDepth-1:0]iColor2,
	input signed	[pVHAW:0]			iLeft2,
	input signed	[pVHAW:0]			iRight2,
	input signed	[pVVAW:0]			iTop2,
	input signed	[pVVAW:0]			iUnder2,
	input			[pSynColorDepth-1:0]iColor3,
	input signed	[pVHAW:0]			iLeft3,
	input signed	[pVHAW:0]			iRight3,
	input signed	[pVVAW:0]			iTop3,
	input signed	[pVVAW:0]			iUnder3,
	input			[pSynColorDepth-1:0]iColor4,
	input signed	[pVHAW:0]			iLeft4,
	input signed	[pVHAW:0]			iRight4,
	input signed	[pVVAW:0]			iTop4,
	input signed	[pVVAW:0]			iUnder4,
	input			[pSynColorDepth-1:0]iColor5,
	input signed	[pVHAW:0]			iLeft5,
	input signed	[pVHAW:0]			iRight5,
	input signed	[pVVAW:0]			iTop5,
	input signed	[pVVAW:0]			iUnder5,
	input			[pSynColorDepth-1:0]iColor6,
	input signed	[pVHAW:0]			iLeft6,
	input signed	[pVHAW:0]			iRight6,
	input signed	[pVVAW:0]			iTop6,
	input signed	[pVVAW:0]			iUnder6,
	input			[pSynColorDepth-1:0]iColor7,
	input signed	[pVHAW:0]			iLeft7,
	input signed	[pVHAW:0]			iRight7,
	input signed	[pVVAW:0]			iTop7,
	input signed	[pVVAW:0]			iUnder7,
	// Common
	input	iRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// 符号拡張
//-----------------------------------------------------------------------------
wire signed [pVHAW:0] wHpos = {1'b0, iBHPS};
wire signed [pVVAW:0] wVpos = {1'b0, iBVPS};


//-----------------------------------------------------------------------------
// 指定色のデータ及び範囲外であれば透過値最大のデータを出力
// 画面外に座標データがはみ出ても、範囲内のドットデータは描画するようにする
//-----------------------------------------------------------------------------
reg [pSynColorDepth-1:0]	rPSB;
reg [pSynColorDepth-1:0]	qColor;
reg [6:0] 					qPosMatch;

always @(posedge iCLK)
begin
	rPSB 	<= qColor;
end

always @*
begin
	casex (qPosMatch)
		'b1xxxxxx: 	qColor <= iColor7;
		'b01xxxxx: 	qColor <= iColor6;
		'b001xxxx: 	qColor <= iColor5;
		'b0001xxx: 	qColor <= iColor4;
		'b00001xx: 	qColor <= iColor3;
		'b000001x: 	qColor <= iColor2;
		'b0000001: 	qColor <= iColor1;
		default: 	qColor <= {pSynColorDepth{1'b0}};
	endcase

	qPosMatch[0] <=  (iLeft1 <= wHpos) & (wHpos  < iRight1) & (iTop1 <= wVpos) & (wVpos < iUnder1);
	qPosMatch[1] <=  (iLeft2 <= wHpos) & (wHpos  < iRight2) & (iTop2 <= wVpos) & (wVpos < iUnder2);
	qPosMatch[2] <=  (iLeft3 <= wHpos) & (wHpos  < iRight3) & (iTop3 <= wVpos) & (wVpos < iUnder3);
	qPosMatch[3] <=  (iLeft4 <= wHpos) & (wHpos  < iRight4) & (iTop4 <= wVpos) & (wVpos < iUnder4);
	qPosMatch[4] <=  (iLeft5 <= wHpos) & (wHpos  < iRight5) & (iTop5 <= wVpos) & (wVpos < iUnder5);
	qPosMatch[5] <=  (iLeft6 <= wHpos) & (wHpos  < iRight6) & (iTop6 <= wVpos) & (wVpos < iUnder6);
	qPosMatch[6] <=  (iLeft7 <= wHpos) & (wHpos  < iRight7) & (iTop7 <= wVpos) & (wVpos < iUnder7);
end

/**-----------------------------------------------------------------------------
 * PipeLine Alpha Blend
 *-----------------------------------------------------------------------------*/
PipeLineBlend #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(pDstColorDepth),
	.pSynColorDepth(pSynColorDepth),
	.pPipeLine(1)
) PipeLineBlend (
	// Dst Pixel Stream I/F
	.oPD(oPD),			.oVD(oVD),		.oFD(oFD),
	.oBHPD(oBHPD),		.oBVPD(oBVPD),
	.oPHPD(oPHPD),		.oPVPD(oPVPD),
	// Src Pixel Stream I/F
	.iPSA(iPS),			.iPSB(rPSB),
	.iVSA(iVS),			.iFS(iFS),
	.iBHPS(iBHPS),		.iBVPS(iBVPS),
	.iPHPS(iPHPS),		.iPVPS(iPVPS),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

endmodule