//----------------------------------------------------------
// Create 2021/04/14
// Author koutakimura
// -
// システムのリセット信号を生成する
//----------------------------------------------------------
module rstGen (
    input   iCLK,
    output  oRST
);

always @(posedge iCLK)
begin
    rSig <= iSig;
end

endmodule
