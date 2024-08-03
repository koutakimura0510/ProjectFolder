/*------------------------------------------------------------------------------
 * Create  2024/07/28
 * Author  Kouta Kimura
 * 
 * new release: 背景色に重複色を合成する
 *-----------------------------------------------------------------------------*/
module AlphaBlend (
	// Dst Side
	output [15:0]	oPD,		// 
	output 			oVD,		// 
	// Src Side
	input  [15:0]	iPSA,		// 背景色 (Background=Bg), 合成される側
	input  [15:0]	iPSB,		// 重複色 (Overlay=Ov), 合成する側
	input  [ 7:0]	iAlpha,		// α値 0～255, 数値が小さいと背景色が強くなる
	input			iVS,
	// Common
	input			iRST,
	input			iCLK
);

/**-----------------------------------------------------------------------------
 * alpha blend Part
 *-----------------------------------------------------------------------------*/
// 符号拡張
wire signed [5:0] wPSAR  = {iPSA[15:11]};
wire signed [6:0] wPSAG  = {iPSA[10: 5]};
wire signed [5:0] wPSAB  = {iPSA[ 4: 0]};
wire signed [5:0] wPSBR  = {iPSB[15:11]};
wire signed [6:0] wPSBG  = {iPSB[10: 5]};
wire signed [5:0] wPSBB  = {iPSB[ 4: 0]};
wire signed [8:0] wAlpha = {iAlpha};
 
// 背景色 固定少数拡張
wire signed [13:0] wBgPxR = {wPSAR[4:0],8'h00}; // 固定少数 256
wire signed [14:0] wBgPxG = {wPSAG[5:0],8'h00};
wire signed [13:0] wBgPxB = {wPSAB[4:0],8'h00};

// 重複色 符号拡張計算
wire signed [ 5:0] wOvPxR = wPSBR - wPSAR;
wire signed [ 6:0] wOvPxG = wPSBG - wPSAG;
wire signed [ 5:0] wOvPxB = wPSBB - wPSAB;

(* syn_use_dsp = "yes" *) wire signed [13:0] wOvPxSR = wOvPxR * wAlpha;
(* syn_use_dsp = "yes" *) wire signed [14:0] wOvPxSG = wOvPxG * wAlpha;
(* syn_use_dsp = "yes" *) wire signed [13:0] wOvPxSB = wOvPxB * wAlpha;

reg signed [13:0] rR;
reg signed [14:0] rG;
reg signed [13:0] rB;

wire[4:0] 	wPDR = rR[12:8];
wire[5:0] 	wPDG = rG[13:8];
wire[4:0] 	wPDB = rB[12:8];
reg			rVD;

always @(posedge iCLK)
begin
	rR  <= wBgPxR + wOvPxSR;
	rG  <= wBgPxG + wOvPxSG;
	rB  <= wBgPxB + wOvPxSB;
	rVD <= iVS;
end

assign oPD = {wPDR,wPDG,wPDB};
assign oVD = rVD;

endmodule