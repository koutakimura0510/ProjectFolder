/*------------------------------------------------------------------------------
 * Create  2024/07/28
 * Author  Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
module Overlay (
	// Dst Side
	output [15:0]	oPD,		// 
	output 			oVD,		// 
	// Src Side
	input  [15:0]	iPSA,		// Pixel A, 合成される側
	input  [15:0]	iPSB,		// Pixel B, 合成する側
	input			iVS,
	input  [ 8:0]	iAlpha,		//
	// Common
	input			iRST,
	input			iCLK
);

/**-----------------------------------------------------------------------------
 * Overlay Part
 * dsp の数減らせそうだけど、開発速度優先
 *-----------------------------------------------------------------------------*/
wire[12:0]	wRA = iPSA[15:11] * iAlpha;
wire[13:0]	wGA = iPSA[10: 5] * iAlpha;
wire[12:0]	wBA = iPSA[ 4: 0] * iAlpha;

wire[12:0]	wRB = iPSB[15:11] * (9'd256 - iAlpha);
wire[13:0]	wGB = iPSB[10: 5] * (9'd256 - iAlpha);
wire[12:0]	wBB = iPSB[ 4: 0] * (9'd256 - iAlpha);

(* syn_use_dsp = "yes" *) reg [13:0]	rRA, rRB;
(* syn_use_dsp = "yes" *) reg [14:0]	rGA, rGB;
(* syn_use_dsp = "yes" *) reg [13:0]	rBA, rBB;

reg [12:0] 	rPDR;
reg [13:0] 	rPDG;
reg [12:0] 	rPDB;
reg	[1:0]	rVD;
wire[4:0] 	wPDR = rPDR[12:8];
wire[5:0] 	wPDG = rPDG[13:8];
wire[4:0] 	wPDB = rPDB[12:8];

always @(posedge iCLK)
begin
	rRA <= wRA;
	rGA <= wGA;
	rBA <= wBA;
	rRB <= wRB;
	rGB <= wGB;
	rBB <= wBB;
	//
	rPDR <= rRA + rRB;
	rPDG <= rGA + rGB;
	rPDB <= rBA + rBB;
	//
	rVD <= {rVD[0],iVS};
end

assign oPD = {wPDR,wPDG,wPDB};
assign oVD = rVD[1];

endmodule