/*------------------------------------------------------------------------------
 * Create  2024/07/27
 * Author  Kouta Kimura
 * 
 * Mult module
 * 
 *-----------------------------------------------------------------------------*/
module Mult (
	// Dst Side
	output [31:0]	oPD,		// 
	output 			oVD,		// 
	// Src Side
	input  [15:0]	iDQA,		// Dq A
	input  [15:0]	iDQB,		// Dq B
	input			iVS,
	// Common
	input			iRST,
	input			iCLK
);

/**-----------------------------------------------------------------------------
 * 乗算 計算
 *-----------------------------------------------------------------------------*/
(* syn_use_dsp = "yes" *) reg [31:0] rNum;		assign oPD	 = rNum;
reg rVS;										assign oVD	 = rVS;
wire signed [31:0] wMult;						assign wMult = iDQA * iDQB;

always @(posedge iCLK)
begin
	rNum <= wMult;
	
	if (iRST) 	rVS <= 1'b0;
	else		rVS <= iVS;
end


//-----------------------------------------------------------------------------
// 指定色のデータ及び範囲外であれば透過値最大のデータを出力
// 画面外に座標データがはみ出ても、範囲内のドットデータは描画するようにする
//-----------------------------------------------------------------------------
// reg [2:0]	rVD;		assign oVD = rVD[2];
// reg			qCE;

// EFX_MULT # (
// 	.WIDTH(18),
// 	.A_REG(1),
// 	.B_REG(1),
// 	.O_REG(1),
// 	.CLK_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.CEA_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTA_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTA_SYNC(1'b1),	 	// 0 aynchronous, 1 synchronous
// 	.RSTA_VALUE(1'b1),	 	// 0 reset, 1 set
// 	.CEB_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTB_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTB_SYNC(1'b1),	 	// 0 aynchronous, 1 synchronous
// 	.RSTB_VALUE(1'b1),	 	// 0 reset, 1 set
// 	.CEO_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTO_POLARITY(1'b1),	// 0 falling edge, 1 rising edge
// 	.RSTO_SYNC(1'b1),	 	// 0 aynchronous, 1 synchronous
// 	.RSTO_VALUE(1'b1)		// 0 reset, 1 set
// ) mult (
// 	.CLK(iCLK),
// 	.CEA(qCE),
// 	.RSTA(iRST),
// 	.CEB(qCE),
// 	.RSTB(iRST),
// 	.CEO(1'b1),
// 	.RSTO(iRST),
// 	.A(iDQA),
// 	.B(iDQB),
// 	.O(oPD)
// );

// always @(posedge iCLK)
// begin
// 	rVD <= {rVD[1:0],iVS};
// end

// always @*
// begin
// 	qCE <= iVS;
// end

endmodule