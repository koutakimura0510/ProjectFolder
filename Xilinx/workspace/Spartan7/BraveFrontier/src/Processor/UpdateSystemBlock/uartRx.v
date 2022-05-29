//------------------------------------------------------
// Create 2022/5/1
// Author koutakimura
// -
// Uart Rx モジュール
// 
//------------------------------------------------------
module uartRx #(
    parameter [ 9:0]        pClkDiv = 868,  // 100MHz / 115200bps
    parameter               pBitLen = 8     // 送信ビット長
)(
    input                   iSysClk,        // System Clk
    input                   iRst,           // Active High
    input                   iUartRx,        // 受信bit
    output [pBitLen-1:0]    oUpdateData,    // 読み込みデータ
    output                  oRdVd           // 有効読み込みデータ出力時 High
);


//----------------------------------------------------------
// 非同期 Rx メタ・ステーブル対策 シフトレジスタ受信
//----------------------------------------------------------
reg [3:0] rRx;

always @(posedge iSysClk)
begin
    if (iRst)   rRx <= 4'b1111;
    else        rRx <= {rRx[2:0], iUartRx};
end


//----------------------------------------------------------
// RX State
//----------------------------------------------------------
localparam [1:0] 
        lpStartBit  = 2'd0,    // Start Bit 検出
        lpDataBits  = 2'd1,    // Data Bits 検出
        lpStopBit   = 2'd2;    // Stop  Bit 検出

reg [1:0] rSt       = lpStartBit;
reg [9:0] rDiv;
reg [3:0] rRxCnt;
reg qDivCke;
reg qCntCke;

always @(posedge iSysClk)
begin
    case (rSt)
        lpStartBit:
        begin
            rSt    <= (!rRx[2]) ? lpDataBits : lpStartBit;
            rDiv   <= 10'd0;
            rRxCnt <= 4'd0;
        end

        lpDataBits:
        begin
            rSt    <= (qCntCke) ? lpStopBit : lpDataBits;
            rDiv   <= (qDivCke) ? 10'd0 : rDiv + 1'b1;
            rRxCnt <= (qCntCke) ? 4'd0  : (qDivCke) ? rRxCnt + 1'b1 : rRxCnt;
        end

        lpStopBit: 
        begin
            rSt    <= (rRx[2]) ? lpStartBit : lpStopBit;
            rDiv   <= 10'd0;
            rRxCnt <= 4'd0;
        end

        default: 
        begin
            rSt    <= lpStartBit;
            rDiv   <= 10'd0;
            rRxCnt <= 4'd0;
        end
    endcase
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
reg rRdVd;                                      assign oRdVd        = rRdVd;

always @(posedge iSysClk)
begin
    if (qDivCke)    rRd <= {rRd[6:0], rRx[3]};
    else            rRd <= rRd;
end

always @(posedge iSysClk)
begin
    rRdVd <= qCntCke;
end


endmodule