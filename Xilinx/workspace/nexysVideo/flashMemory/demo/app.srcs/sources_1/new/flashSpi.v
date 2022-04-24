/*
 * Create 2022/4/24
 * Author koutakimura
 * 
 * Flash Memory Spi Access
 */
module flashSpi #(
    parameter       pClkDiv = 4     // 100MHz / 4 = 25MHz
)(
    input           iSysClk,        // system clk
    input           iRst,           // system rst
    output          oCs,            // Chip Select
    output          oSck,           // spi clk
    output          oMosi,          // master out slave in
    input           iMiso,          // master in slave out
    output          oWp,            // write guard Low Active
    output          oHold,          // write stop  Low Active
    input           iCke,           // 0. disconnect 1. active
    input           iCs,            // chip select
    input  [7:0]    iWd,            // 書き込みデータ
    output [7:0]    oRd,            // 読み込みデータ
    output          oSpiVd,         // 1byteデータ送信完了時High
    output          oWdVd,          // 書き込み完了時High
    output          oRdVd           // 読み込みデータ出力時High
);


//----------------------------------------------------------
// Flash Memory Control Pin
//----------------------------------------------------------
assign oWp   = 1'b1;
assign oHold = 1'b1;
assign oCs   = iCs;


//----------------------------------------------------------
// Division Clk Enable
//----------------------------------------------------------
localparam lpClkDiv = pClkDiv - 1'b1;
reg [15:0] rDiv;
reg qDiv

always @(posedge iSysClk)
begin
    if      (iRst)          rDiv <= 16'd0;
    else if (!iCke)         rDiv <= 16'd0;
    else if (qDiv)          rDiv <= 16'd0;
    else                    rDiv <= rDiv + 1'b1;
end

always @*
begin
    qDiv <= (rDiv == lpClkDiv);
end


//----------------------------------------------------------
// Sck Generate
// Sckの立ち下がりをモニタリングし、送信回数をカウントする
//----------------------------------------------------------
reg rScl;                           assign oSck = rScl;
reg [3:0] rSckCnt;
reg qSckCke;

always @(posedge iSysClk) 
begin
    if      (iRst)          rScl <= 1'b1;
    else if (!iCke)         rScl <= 1'b1;
    else if (qDiv)          rScl <= ~rScl;
    else                    rScl <= rScl;
end

always @(posedge iSysClk)
begin
    if      (iRst)          rSckCnt <= 0;
    else if (!iCke)         rSckCnt <= 0;
    else if (qDiv && !rScl) rSckCnt <= qSckCke ? 0 : rSckCnt + 4'd1;
    else                    rSckCnt <= rSckCnt;
end

always @*
begin
    qSckCke <= rSckCnt == 4'd7;
end


//----------------------------------------------------------
// 1byteデータ送信完了
//----------------------------------------------------------
reg rSpiVd;                         assign oSpiVd  = rSpiVd;
reg qSpiVd;

always @(posedge iSysClk)
begin
    if      (iRst)          rSpiVd <= 1'b0;
    else if (qSpiVd)        rSpiVd <= 1'b1;
    else                    rSpiVd <= 1'b0;
end

always @*
begin
    qSpiVd <= (iCke && qDiv && !rScl && qSckCke);
end


//----------------------------------------------------------
// Sck Hold Time Generate -> min 15ns HOLD
//----------------------------------------------------------
localparam lpHoldTimeMosi = 10;
localparam [2:0]
    IDLE = 0,
    HOLD = 1;

reg [5:0] rHoldTime;
reg [1:0] rStHold;
reg qHoldTimeCke;

always @(posedge iSysClk) begin
    if (iRst) 
    begin
        rStHold <= IDLE;
    end 
    else
    begin
        case (rStHold)
            IDLE:    rStHold <= (qDiv & rScl)  ? HOLD : IDLE;
            HOLD:    rStHold <= (qHoldTimeCke) ? IDLE : HOLD;
            default: rStHold <= IDLE;
        endcase
    end
end

always @(posedge iSysClk) begin
    if (iRst)
    begin
        rHoldTime <= 0;
    end
    else
    begin
        case (rStHold)
            IDLE:    rHoldTime <= 0;
            HOLD:    rHoldTime <= (qHoldTimeCke) ? 0 : rHoldTime + 1'b1;
            default: rHoldTime <= 0
        endcase
    end
end

always @*
begin
    qHoldTimeCke <= rHoldTime == lpHoldTimeMosi;
end


//----------------------------------------------------------
// 送信バイトデータの取り込み
// 1bitずつ送信するため、rSckCntの開始時に新規データで上書きする
//----------------------------------------------------------
reg [7:0] rWd;

always @(posedge iSysClk)
begin
    if      (iRst)          rWd <= iWd;
    else if (!iCke)         rWd <= iWd;
    else if (rSpiVd)        rWd <= iWd;
    else if (qHoldTimeCke)  rWd <= {rWd[6:0], 1'b1};
    else                    rWd <= rWd;
end


//----------------------------------------------------------
// sckの立ち下がりエッジ時にデータ更新
//----------------------------------------------------------
reg rMosi;                              assign oMosi  = rMosi;
reg qMosiCke;

always @(posedge iSysClk)
begin
    if      (iRst)          rMosi <= rWd[7];
    else if (qMosiCke)      rMosi <= rWd[7];
    else                    rMosi <= rMosi;
end

always @*
begin
    qMosiCke <= qHoldTimeCke & iCke;
end

endmodule