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
	parameter pVHAW  		= 11,
	parameter pVVAW  		= 11,
	parameter pColorDepth	= 16
)(
	// Dst Side
	output	[pColorDepth-1:0]	oPd,		// Pixel Data
	output 						oPv,		// Pixel Valid
	// Src Side
	input	[pColorDepth-1:0]	iPd,		// Pixel Data
	input						iPv,		// Pixel Valid
	// Control Status
	input			[pVHAW-1:0]			iHpos,
	input			[pVVAW-1:0]			iVpos,
	input			[pColorDepth-1:0]	iColor1,
	input signed	[pVHAW:0]			iLeft1,
	input signed	[pVHAW:0]			iRight1,
	input signed	[pVVAW:0]			iTop1,
	input signed	[pVVAW:0]			iUnder1,
	input			[pColorDepth-1:0]	iColor2,
	input signed	[pVHAW:0]			iLeft2,
	input signed	[pVHAW:0]			iRight2,
	input signed	[pVVAW:0]			iTop2,
	input signed	[pVVAW:0]			iUnder2,
	input			[pColorDepth-1:0]	iColor3,
	input signed	[pVHAW:0]			iLeft3,
	input signed	[pVHAW:0]			iRight3,
	input signed	[pVVAW:0]			iTop3,
	input signed	[pVVAW:0]			iUnder3,
	input			[pColorDepth-1:0]	iColor4,
	input signed	[pVHAW:0]			iLeft4,
	input signed	[pVHAW:0]			iRight4,
	input signed	[pVVAW:0]			iTop4,
	input signed	[pVVAW:0]			iUnder4,
	input			[pColorDepth-1:0]	iColor5,
	input signed	[pVHAW:0]			iLeft5,
	input signed	[pVHAW:0]			iRight5,
	input signed	[pVVAW:0]			iTop5,
	input signed	[pVVAW:0]			iUnder5,
	input			[pColorDepth-1:0]	iColor6,
	input signed	[pVHAW:0]			iLeft6,
	input signed	[pVHAW:0]			iRight6,
	input signed	[pVVAW:0]			iTop6,
	input signed	[pVVAW:0]			iUnder6,
	input			[pColorDepth-1:0]	iColor7,
	input signed	[pVHAW:0]			iLeft7,
	input signed	[pVHAW:0]			iRight7,
	input signed	[pVVAW:0]			iTop7,
	input signed	[pVVAW:0]			iUnder7,
	// Common
	input	iRST,
	input	iCKE,
	input	iCLK
);


//-----------------------------------------------------------------------------
// 符号拡張
//-----------------------------------------------------------------------------
wire signed [pVHAW:0] wHpos = {1'b0, iHpos};
wire signed [pVVAW:0] wVpos = {1'b0, iVpos};


//-----------------------------------------------------------------------------
// 指定色のデータ及び範囲外であれば透過値最大のデータを出力
// 画面外に座標データがはみ出ても、範囲内のドットデータは描画するようにする
//-----------------------------------------------------------------------------
reg [pColorDepth-1:0] rPd;		assign oPd = rPd;
reg rPv;						assign oPv = rPv;
reg [pColorDepth-1:0]	qColor;
reg [6:0] 				qPosMatch;

always @(posedge iCLK)
begin
	rPd <= qColor;
	
	if (iRST) 		rPv <= 1'b0;
	else 			rPv <= |{qPosMatch};
end

always @*
begin
	casex (qPosMatch)
		'b1xxxxxx: qColor <= iColor7;
		'b01xxxxx: qColor <= iColor6;
		'b001xxxx: qColor <= iColor5;
		'b0001xxx: qColor <= iColor4;
		'b00001xx: qColor <= iColor3;
		'b000001x: qColor <= iColor2;
		'b0000001: qColor <= iColor1;
		default: qColor <= {pColorDepth{1'b0}};
	endcase

	qPosMatch[0] <=  (iLeft1 <= wHpos) & (wHpos  < iRight1) & (iTop1 <= wVpos) & (wVpos < iUnder1);
	qPosMatch[1] <=  (iLeft2 <= wHpos) & (wHpos  < iRight2) & (iTop2 <= wVpos) & (wVpos < iUnder2);
	qPosMatch[2] <=  (iLeft3 <= wHpos) & (wHpos  < iRight3) & (iTop3 <= wVpos) & (wVpos < iUnder3);
	qPosMatch[3] <=  (iLeft4 <= wHpos) & (wHpos  < iRight4) & (iTop4 <= wVpos) & (wVpos < iUnder4);
	qPosMatch[4] <=  (iLeft5 <= wHpos) & (wHpos  < iRight5) & (iTop5 <= wVpos) & (wVpos < iUnder5);
	qPosMatch[5] <=  (iLeft6 <= wHpos) & (wHpos  < iRight6) & (iTop6 <= wVpos) & (wVpos < iUnder6);
	qPosMatch[6] <=  (iLeft7 <= wHpos) & (wHpos  < iRight7) & (iTop7 <= wVpos) & (wVpos < iUnder7);
end

endmodule