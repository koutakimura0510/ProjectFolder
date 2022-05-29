//----------------------------------------------------------
// Create 2021/04/14
// Author koutakimura
// -
// リセット信号を生成する
//----------------------------------------------------------
module rstGen # (
    parameter [7:0] pRstFallTime = 150
)(
    input   iClk,
    output  oRst
);


//---------------------------------------------------------------------------
// リセットの立下り時間
//---------------------------------------------------------------------------
localparam lpRstFallTime = pRstFallTime - 1;


//---------------------------------------------------------------------------
// リセットの生成
//---------------------------------------------------------------------------
reg         qEn;
reg [7:0]   rCnt = 0;
reg         rRst = 1;

always @( posedge iClk )
begin
    rCnt <= rCnt + 1'b1;
end

always @(posedge iClk)
begin
    if (qEn)    rRst <= 1'b0;
    else        rRst <= rRst;
end

always @*
begin
   qEn <= (rCnt == lpRstFallTime);
end

endmodule
