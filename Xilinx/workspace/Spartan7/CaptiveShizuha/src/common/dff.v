//----------------------------------------------------------
// Create 2021/04/03
// Author koutakimura
// -
// 入力信号をD-FFに入力して出力するモジュール
//----------------------------------------------------------
module dff #(
    parameter pBitWidth = 1
)(
    input                   iCLK,
    input   [pBitWidth-1:0] iSig,
    output  [pBitWidth-1:0] oSig
);

reg [pBitWidth-1:0] rSig;       assign oSig = rSig;

always @(posedge iCLK)
begin
    rSig <= iSig;
end

endmodule