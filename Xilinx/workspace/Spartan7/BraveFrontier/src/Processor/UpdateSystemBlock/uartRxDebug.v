//------------------------------------------------------
// Create 2022/5/2
// Author koutakimura
// -
// Uart Rx Debug モジュール
// 
//------------------------------------------------------
module uartRxDebug #(
    parameter [ 9:0]        pClkDiv = 868,  // 100MHz / 115200bps
    parameter               pBitLen = 8     // 送信ビット長
)(
    input                   iSysClk,        // System Clk
    input                   iRst,           // Active High
    input                   iWdVd,
    output [pBitLen-1:0]    oUpdateData,    // 読み込みデータ
    output                  oRdVd           // 有効読み込みデータ出力時 High
);


//----------------------------------------------------------
// RX State
//----------------------------------------------------------
reg [9:0] rDiv;
reg [3:0] rRxCnt;
reg [1:0] rSt;
reg qDivCke;
reg qCntCke;                                    assign oRdVd = qCntCke;

always @(posedge iSysClk)
begin
    if (iRst)
    begin
        rDiv   <= 0;
        rRxCnt <= 0;
        rSt    <= 0;
    end
    else
    begin
        case (rSt)
        0:
        begin
            rDiv   <= (qDivCke) ? 10'd0 : rDiv + 1'b1;
            rRxCnt <= (qCntCke) ? 4'd0  : (qDivCke) ? rRxCnt + 1'b1 : rRxCnt;
            rSt    <= (qCntCke) ? 1 : 0;
        end

        1:
        begin
            rDiv   <= (qDivCke) ? 10'd0 : rDiv + 1'b1;
            rRxCnt <= (qCntCke) ? 4'd0  : (qDivCke) ? rRxCnt + 1'b1 : rRxCnt;
            rSt    <= (qCntCke) ? 2 : 1;
        end

        2:
        begin
            rDiv   <= 0;
            rRxCnt <= 0;
            rSt    <= iWdVd ? 1 : 2;
        end

        default:
        begin
            rDiv   <= 0;
            rRxCnt <= 0;
            rSt    <= 0;
        end
        endcase
    end
end

always @*
begin
    qDivCke <= rDiv == pClkDiv;
    qCntCke <= rRxCnt == 4'd8;
end


//----------------------------------------------------------
// Data Bits レジスタ受信
// Rx は LSB Farst
//----------------------------------------------------------
reg [7:0] rRd;                                  assign oUpdateData  = rRd;

always @(posedge iSysClk)
begin
    if (iRst)           rRd <= 8'd0;
    else if (qCntCke)   rRd <= rRd + 1'b1;
    else                rRd <= rRd;
end

endmodule