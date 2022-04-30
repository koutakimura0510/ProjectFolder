//------------------------------------------------------
// Create 2022/4/30
// Author koutakimura
// -
// システムのアップデートデータを受信
// 
//------------------------------------------------------
module usbWrapper #(
    parameter [ 9:0]        pClkDiv = 868,  // 100MHz / 115200bps
    parameter               pBitLen = 8     // 送信ビット長
)(
    input                   iSysClk,        // System Clk
    input                   iRst,           // Active High
    input                   iUartRx,        // 受信bit
    output                  oUartTx,        // 送信bit
    input                   iWdVd,          // 上位モジュールが 有効データ使用完了時 High
    output [pBitLen-1:0]    oUpdateData,    // 読み込みデータ
    output                  oRdVd           // 有効読み込みデータ出力時 High
);


//----------------------------------------------------------
// 非同期 Rx シフトレジスタ受信
//----------------------------------------------------------
reg [2:0] rRx;

always @(posedge iSysClk)
begin
    if (iRst)   rRx <= 3'b111;
    else        rRx <= {rRx[1:0], iUartRx};
end


//----------------------------------------------------------
// RX State
//----------------------------------------------------------
localparam [2:0] 
        lpStartBit  = 0,    // Start Bit 検出
        lpDataBits  = 1,    // Data Bits 検出
        lpStopBit   = 2;    // Stop Bits 検出

reg [9:0] rDiv;
reg qDivCke;
reg [2:0] rSt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpStartBit:
        begin
            rSt <= (!rRx[1]) ? lpDataBits : lpStartBit;
        end

        lpDataBits:
        begin
            rDiv <= (qDivCke) ? 10'd0 : rDiv + 1'b1;
        end

        lpStopBit: 
        begin
            
        end

        default: 
        begin
            
        end
    endcase
end

always @*
begin
    qDivCke <= rDiv == pClkDiv;
end


//----------------------------------------------------------
// Data Bits レジスタ受信
// 受信データは LSB Farst
//----------------------------------------------------------
reg [7:0] rRd;

always @(posedge iSysClk)
begin
    if (qDivCke)    rRd <= {rRx[6:0], rRx[2]};
    else            rRd <= rRd;
end


endmodule