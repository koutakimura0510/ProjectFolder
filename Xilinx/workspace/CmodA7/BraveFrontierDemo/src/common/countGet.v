/*
 * Create 2022/04/02
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * 指定数値カウントを行い、Enable信号を出力する
 *
 * 2022-04-02: New Relese
 */
module countGet
#(
    parameter                   pCntSize     = 60  // Count Size
)(
    input                       iClk,               // clk
    input                       iRst,               // Active High system rst
    input                       iCKE,               // update enable
    output                      oCKE                // output enable
);


//----------------------------------------------------------
// 画面サイズ
//----------------------------------------------------------
localparam lpBitSize = fBitWidth(pCntSize);
localparam lpCntSize = pCntSize - 1'b1;


//----------------------------------------------------------
// カウンター
//----------------------------------------------------------
reg [lpBitSize-1:0] rCnt;
reg qEn;                    assign oCKE = qEn;

always @(posedge iClk) 
begin
    if (iRst)       rCnt <= 0;
    else if (iCKE)  rCnt <= (qEn) ? 0 : rCnt + 1'b1;
    else            rCnt <= rCnt;
end

always @*
begin
    qEn <= (rCnt == lpCntSize) & iCKE;
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule