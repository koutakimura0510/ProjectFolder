//-----------------------------------------------------------------------------
// Create  2022/9/28
// Author  koutakimura
// Editor  VSCode ver1.70.0
// Build   Vivado22.1
// Borad   CmodA7
// -
// Veriog で module を Instance した場合の signed の取り扱いを確認するプロジェクト
// top は使用しておらず、testbench で確認を行う
//-----------------------------------------------------------------------------

module Top(
	input 	iClk,
	output 	oLed
);

localparam lpBitWidth = 4;

wire signed[lpBitWidth:0] wDec;

Signed #(
	.pBitWidth	(lpBitWidth)
) sign (
	.oDec	(wDec),
	.iRst	(1'b0),
	.iClk 	(iClk)
);

assign oLed = &{wDec};

endmodule
