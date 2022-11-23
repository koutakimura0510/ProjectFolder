//------------------------------------------------------
// Create 2021/1/3
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// UART送信モジュール
// 
// 2022/4/24 汎用性を上げるために全体構成更新、命名規則変更
// 
//------------------------------------------------------
module uartTx #(
    parameter [ 9:0]    pClkDiv = 868,  // 100MHz / 115200bps
    parameter           pBitLen = 16    // 送信ビット長
)(
    input               iSysClk,        // System Clk
    input               iRst,           // Active High
    input               iCke,           // 1. connect / 0. discon
    input [pBitLen-1:0] iSendData,      // 送信データ
    output              oUartRX,        // 送信bit
    output              oReady          // 送信中Low 受付可能High
);


//----------------------------------------------------------
// 分周クロックカウンター
//----------------------------------------------------------
localparam lpClkDiv = pClkDiv - 1'b1;

reg qDivEn;
reg [ 9:0] rDivCnt;

always @(posedge iSysClk)
begin
    if (iRst)           rDivCnt <= 0;
    else if (qDivEn)    rDivCnt <= 0;
    else                rDivCnt <= rDivCnt + 1'b1;
end

always @*
begin
    qDivEn <= (rDivCnt == lpClkDiv);
end


//----------------------------------------------------------
// ASCII 変換
//----------------------------------------------------------
localparam              lpAsciiCnt  = ((pBitLen * 2) >> 3) + 1'b1;
localparam              lpBitMsb    = (pBitLen  * 2) + 7;
localparam [lpBitMsb:0] lpBitNull   = 0;

wire [lpBitMsb:0] wAscii;
wire wVd;

DecAsciiConvert # (
    .pBitLen    (pBitLen)
) DEC_ASCII_CON (
    .iSysClk    (iSysClk),
    .iCke       (iCke),
    .iDec       (iSendData),
    .oAscii     (wAscii),
    .oVd        (wVd)
);


//----------------------------------------------------------
// Uart RX ステートマシン
// 送信データに改行文字をビット連結して送信
//----------------------------------------------------------
localparam [3:0] 
    lpStIdle        = 4'd0,
    lpStStartBit    = 4'd1,
    lpStSend        = 4'd2,
    lpStStopBit     = 4'd3,
    lpStNextLine    = 4'd4;

reg rRx;                            assign oUartRX = rRx;
reg rReady;                         assign oReady  = rReady;
reg [3:0]        rCnt, rAsCnt;
reg [lpBitMsb:0] rData;
reg [3:0]        rSt;


always @(posedge iSysClk)
begin
    if (iRst)
    begin
        rRx    <= 1'b1;
        rSt    <= lpStIdle;
        rData  <= lpBitNull;
        rAsCnt <= 0;
        rCnt   <= 0;
        rReady <= 1'b1;
    end 
    else
    begin
        case (rSt)
            lpStIdle:
            begin
                rRx    <= 1'b1;
                rSt    <= wVd;
                rData  <= wAscii;
                rCnt   <= 0;
                rReady <= ~wVd;
            end

            lpStStartBit:
            begin
                if (qDivEn)
                begin
                    rRx   <= 1'b0;
                    rSt   <= lpStSend;
                end
                else
                begin
                    rRx   <= 1'b1;
                    rSt   <= lpStStartBit;
                end
            end

            lpStSend:
            begin
                if (qDivEn)
                begin
                    rRx   <= rData[0];
                    rSt   <= (rCnt == 4'd7) ? lpStStopBit : lpStSend;
                    rCnt  <= (rCnt == 4'd7) ? 0 : rCnt + 1'b1;
                    rData <= {1'b1, rData[lpBitMsb:1]};
                end
                else
                begin
                    rRx   <= rRx;
                    rSt   <= lpStSend;
                    rData <= rData;
                    rCnt  <= rCnt;
                end
            end

            lpStStopBit:
            begin
                if (qDivEn)
                begin
                    rRx    <= 1'b1;
                    rReady <= (rAsCnt == lpAsciiCnt) ? 1'b1 : 1'b0;
                    rSt    <= (rAsCnt == lpAsciiCnt) ? lpStIdle : lpStStartBit;
                    rAsCnt <= (rAsCnt == lpAsciiCnt) ? 0 : rAsCnt + 1'b1;
                end
                else
                begin
                    rRx    <= 1'b0;
                    rReady <= 1'b0;
                    rSt    <= lpStStopBit;
                    rAsCnt <= rAsCnt;
                end
            end

            default:
            begin
                rRx    <= 1'b1;
                rSt    <= lpStIdle;
                rData  <= lpBitNull;
                rAsCnt <= 0;
                rCnt   <= 0;
                rReady <= 1'b1;
            end
        endcase
    end
end


endmodule