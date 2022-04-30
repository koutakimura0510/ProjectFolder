//----------------------------------------------------------
// Create 2022/4/24
// Author koutakimura
// 
// Flash Memory Spi Access
//----------------------------------------------------------
module fmSpi #(
    parameter [9:0] pClkDiv   = 4,      // 100MHz / 4 = 25MHz
    parameter       pHoldTime = 10,     // Mosi Hold Time
    parameter       pMode     = "mode0" // mode0 mode3 対応
)(
    input           iSysClk,            // system clk
    output          oCs,                // Chip Select
    output          oSck,               // spi clk
    output          oMosi,              // master out slave in
    input           iMiso,              // master in slave out
    output          oWp,                // write guard Low Active
    output          oHold,              // write stop  Low Active
    input           iCke,               // 0. disconnect 1. active
    input           iCmd,               // 1. Read Active
    input           iCs,                // chip select
    input  [7:0]    iWd,                // 書き込みデータ
    output [7:0]    oRd,                // 読み込みデータ
    output          oWdVd,              // 1byteデータ送信完了時High
    output          oRdVd               // 1byte読み込みデータ出力時High
);


//----------------------------------------------------------
// Flash Memory Control Pin
// CS High Low Min 100ns
//----------------------------------------------------------
assign oWp   = 1'b1;
assign oHold = 1'b1;
assign oCs   = iCs;


//----------------------------------------------------------
// Division Clk Enable
//----------------------------------------------------------
localparam [9:0] lpClkDiv = pClkDiv - 1'b1;
reg [9:0] rDiv;
reg qDiv;

always @(posedge iSysClk)
begin
    if (!iCke)              rDiv <= 10'd0;
    else if (qDiv)          rDiv <= 10'd0;
    else                    rDiv <= rDiv + 1'b1;
end

always @*
begin
    qDiv <= rDiv == lpClkDiv;
end


//----------------------------------------------------------
// Sck Generate
// Sckの立ち下がりをモニタリングし、送信回数をカウントする
//----------------------------------------------------------
reg rScl;                           assign oSck = rScl;
reg [3:0] rSckCnt;
reg qSckNeg;
reg qSckCke, qByteVd;

generate
    if (pMode == "mode0")
    begin
        always @(posedge iSysClk) 
        begin
            if (!iCke)              rScl <= 1'b0;
            else if (qDiv)          rScl <= ~rScl;
            else                    rScl <= rScl;
        end
        
        always @(posedge iSysClk)
        begin
            if (!iCke)              rSckCnt <= 0;
            else if (qSckNeg)       rSckCnt <= qSckCke ? 0 : rSckCnt + 4'd1;
            else                    rSckCnt <= rSckCnt;
        end

        always @*
        begin
            qSckNeg <= qDiv & rScl;
            qSckCke <= rSckCnt == 4'd7;
            qByteVd <= qSckNeg & qSckCke;
        end
    end
    else
    begin
        always @(posedge iSysClk) 
        begin
            if (!iCke)              rScl <= 1'b1;
            else if (qDiv)          rScl <= ~rScl;
            else                    rScl <= rScl;
        end

        always @(posedge iSysClk)
        begin
            if (!iCke)              rSckCnt <= 0;
            else if (qSckNeg)       rSckCnt <= qSckCke ? 0 : rSckCnt + 4'd1;
            else                    rSckCnt <= rSckCnt;
        end

        always @*
        begin
            qSckNeg <= qDiv & (~rScl);
            qSckCke <= rSckCnt == 4'd7;
            qByteVd <= qSckNeg & qSckCke;
        end
    end
endgenerate




//----------------------------------------------------------
// 1byteデータ送信完了
//----------------------------------------------------------
reg rWdVd;                         assign oWdVd  = rWdVd;
reg qWdVd;

always @(posedge iSysClk)
begin
    if      (!iCke)         rWdVd <= 1'b0;
    else if (qWdVd)         rWdVd <= 1'b1;
    else                    rWdVd <= 1'b0;
end

always @*
begin
    qWdVd <= qByteVd;
end


//----------------------------------------------------------
// Sck Hold Time Generate -> min 15ns HOLD
// Sck の立下り時に Hold Time Count Start
//----------------------------------------------------------
localparam [2:0]
    IDLE = 0,
    HOLD = 1;

reg [5:0] rHoldTime;
reg [1:0] rStHold;
reg qHoldTimeCke;

always @(posedge iSysClk) begin
    if (!iCke)
    begin
        rStHold <= IDLE;
    end 
    else
    begin
        case (rStHold)
            IDLE:    rStHold <= (qSckNeg)      ? HOLD : IDLE;
            HOLD:    rStHold <= (qHoldTimeCke) ? IDLE : HOLD;
            default: rStHold <= IDLE;
        endcase
    end
end

always @(posedge iSysClk) begin
    if (!iCke)
    begin
        rHoldTime <= 0;
    end
    else
    begin
        case (rStHold)
            IDLE:    rHoldTime <= 0;
            HOLD:    rHoldTime <= (qHoldTimeCke) ? 0 : rHoldTime + 1'b1;
            default: rHoldTime <= 0;
        endcase
    end
end

always @*
begin
    qHoldTimeCke <= rHoldTime == pHoldTime;
end


//----------------------------------------------------------
// 送信バイトデータの取り込み
// 1bitずつ送信するため、rSckCntの開始時に新規データで上書きする
//----------------------------------------------------------
reg [7:0] rMosi;                        assign oMosi  = rMosi[7];

always @(posedge iSysClk)
begin
    if (!iCke)              rMosi <= iWd;
    else if (qHoldTimeCke)  rMosi <= {rMosi[6:0], 1'b1};
    else                    rMosi <= rMosi;
end


//----------------------------------------------------------
// Miso Pin Capture
// 1byte Sck カウント時に Read Cmd 発行されていればデータを出力
//----------------------------------------------------------
reg [7:0] rMiso;                        assign oRd   = rMiso;
reg rRdVd;                              assign oRdVd = rRdVd;
reg qMiso, qRdVd;

always @(posedge iSysClk)
begin
    if  (qMiso) rMiso <= {rMiso[6:0], iMiso};
    else        rMiso <= rMiso;
end

always @(posedge iSysClk)
begin
    if (qRdVd)   rRdVd <= 1'b1;
    else         rRdVd <= 1'b0;
end

generate
    if (pMode == "mode0")
    begin
        always @*
        begin
            qMiso <= ~rScl & qDiv;
            qRdVd <= qByteVd;
        end
    end
    else
    begin
        always @*
        begin
            qMiso <= rScl & qDiv;
            qRdVd <= qByteVd;
        end
    end
endgenerate


endmodule