//------------------------------------------------------
// Create 2022/4/24
// Author koutakimura
// -
// 10進数を ASCII 文字列に変換し末尾に改行文字挿入
// 16bit 固定, 3段パイプライン
//------------------------------------------------------
module DecAsciiConvert #(
    parameter                   pBitLen = 16    // 送信ビット長
)(
    input                       iSysClk,        // System Clk
    input                       iCke,           // 有効データ入力 High
    input  [pBitLen-1:0]        iDec,           // 10進数データ
    output [(pBitLen*2)+7:0]    oAscii,         // Ascii data
    output                      oVd             // valid data High
);


//----------------------------------------------------------
// stage-1
//----------------------------------------------------------
reg [pBitLen-1:0] rDec;
reg rVd1;

always @(posedge iSysClk)
begin
    if (iCke)   rDec <= iDec;
    else        rDec <= rDec;
end

always @(posedge iSysClk)
begin
    rVd1 <= iCke;
end


//----------------------------------------------------------
// stage-2
//----------------------------------------------------------
reg rVd2;
reg [3:0] qJuge, rJuge;
reg [7:0] qDec2 [0:3];
reg [7:0] qAsc2 [0:3];
reg [7:0] rDec2 [0:3];
reg [7:0] rAsc2 [0:3];

always @(posedge iSysClk)
begin
    rVd2     <= rVd1;
    rJuge    <= qJuge;
    rDec2[0] <= qDec2;
    rDec2[1] <= qDec2;
    rDec2[2] <= qDec2;
    rDec2[3] <= qDec2;
    rAsc2[0] <= qAsc2;
    rAsc2[1] <= qAsc2;
    rAsc2[2] <= qAsc2;
    rAsc2[3] <= qAsc2;
end

always @*
begin
    qJuge[0] <= rDec[ 3: 0] < 4'd10;
    qJuge[1] <= rDec[ 7: 4] < 4'd10;
    qJuge[2] <= rDec[11: 8] < 4'd10;
    qJuge[3] <= rDec[15:12] < 4'd10;
    qDec2[0] <= rDec[ 3: 0] + 8'h30;
    qDec2[1] <= rDec[ 7: 4] + 8'h30;
    qDec2[2] <= rDec[11: 8] + 8'h30;
    qDec2[3] <= rDec[15:12] + 8'h30;
    qAsc2[0] <= rDec[ 3: 0] + 8'h57;
    qAsc2[1] <= rDec[ 7: 4] + 8'h57;
    qAsc2[2] <= rDec[11: 8] + 8'h57;
    qAsc2[3] <= rDec[15:12] + 8'h57;
end


//----------------------------------------------------------
// stage-2
//----------------------------------------------------------
localparam lpBitMsb = (pBitLen * 2) + 7;
localparam lpBitLsb = (pBitLen * 2);

reg rVd3;                       assign oVd    = rVd3;
reg [7:0] rAsc3 [0:4];          assign oAscii = {rAsc3[4], rAsc3[3], rAsc3[2], rAsc3[1], rAsc3[0]};
reg [7:0] qAsc3 [0:3];

always @(posedge iSysClk)
begin
    rAsc3[0] <= qAsc3[0];
    rAsc3[1] <= qAsc3[1];
    rAsc3[2] <= qAsc3[2];
    rAsc3[3] <= qAsc3[3];
    rAsc3[4] <= 8'h0a;
end

always @*
begin
    qAsc3[0] <= qJuge[0] ? rDec2[0] : rAsc2[0];
    qAsc3[1] <= qJuge[1] ? rDec2[1] : rAsc2[1];
    qAsc3[2] <= qJuge[2] ? rDec2[2] : rAsc2[2];
    qAsc3[3] <= qJuge[3] ? rDec2[3] : rAsc2[3];
end

endmodule