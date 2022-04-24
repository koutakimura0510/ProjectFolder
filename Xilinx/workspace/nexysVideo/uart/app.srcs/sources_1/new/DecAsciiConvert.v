//------------------------------------------------------
// Create 2022/4/24
// Author koutakimura
// -
// 10進数を ASCII 文字列に変換し末尾に改行文字挿入
// 
//------------------------------------------------------
module DecAsciiConvert #(
    parameter                   pBitLen = 16   // 送信ビット長
)(
    input                       iSysClk,       // System Clk
    input  [pBitLen-1:0]        iDec,          // 10進数データ
    output [(pBitLen*2)+7:0]    oAscii         // Ascii
);

localparam lpBitMsb = (pBitLen * 2) + 7;
localparam lpBitLsb = (pBitLen * 2);

reg [(pBitLen * 2) + 7:0] rAscii;             assign oAscii = rAscii;

always @(posedge iSysClk)
begin
    rAscii[lpBitMsb:lpBitLsb]   <= 8'h0a;
    rAscii[31:24]               <= (iDec[ 3: 0] < 4'd10) ? iDec[ 3: 0] + 8'h30 : iDec[ 3: 0] + 8'h57;
    rAscii[23:16]               <= (iDec[ 7: 4] < 4'd10) ? iDec[ 7: 4] + 8'h30 : iDec[ 7: 4] + 8'h57;
    rAscii[15: 8]               <= (iDec[11: 8] < 4'd10) ? iDec[11: 8] + 8'h30 : iDec[11: 8] + 8'h57;
    rAscii[ 7: 0]               <= (iDec[15:12] < 4'd10) ? iDec[15:12] + 8'h30 : iDec[15:12] + 8'h57;
end

endmodule