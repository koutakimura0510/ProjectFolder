//---------------------------------------------------------------------------
// signデータ出力
//---------------------------------------------------------------------------
module Signed #(
	parameter pBitWidth = 8
)(
	output signed [pBitWidth:0]	oDec,
	input 					iRst,
	input 					iClk
);

reg [pBitWidth:0] rDec;		assign oDec = rDec;

always @(posedge iClk)
begin
	if (iRst) 	rDec <= {pBitWidth{1'b1}};
	else 		rDec <= rDec - 1'b1;
end


endmodule