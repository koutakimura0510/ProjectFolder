//----------------------------------------------------------
// Create 2021/2/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// ピクセルデータ生成トップモジュール
//----------------------------------------------------------
module pixelTop # (
    parameter       pHDisplay           = 640,
    parameter       pVDisplay           = 480,
    parameter       pAddrWidth          = 32,           // address
    parameter       pBitWidth           = 32,
    parameter       pBitLengthState     = 2
)(
    input [ 7:0]                    iSW,
    input                           iCLK,       // user clk
    input                           iRST,       // system rst
    input  [pBitLengthState-1:0]    iWS,        // write buffer state
    input                           iDdrWE,     // ddr side が受付可能なら High
    output [pBitWidth-1:0]          oPixel,     // アドレスに書き込むピクセルデータ
    output [pAddrWidth-1:0]         oAddr,      // ddr memoryに確保したフレームバッファ領域に書き込むアドレスを指定
    output                          oWE
);

////////////////////////////////////////////////////////////
`include "../include/commonAddr.vh"
localparam pDdrFbufSize = (pHDisplay * pVDisplay);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 画面サイズのアドレス送信回数をカウントする
// 最大値カウント時 Enable ON
//----------------------------------------------------------
reg qWE;                assign oWE = qWE;
reg [20:0] rAddrCnt;

always @(posedge iCLK)
begin
    if (iRST)           rAddrCnt <= 21'd0;
    else if (qWE)       rAddrCnt <= 21'd0;
    else if (iDdrWE)    rAddrCnt <= rAddrCnt + 1'b1;
    else                rAddrCnt <= rAddrCnt;
end

always @*
begin
    qWE <= (pDdrFbufSize == rAddrCnt);
end


////////////////////////////////////////////////////////////
// demo color gen
reg [pBitWidth-1:0] rNextData;

always @(posedge iCLK)
begin
    if (iRST)
    begin
        rNextData <= COLOR_RED;
    end
    else if (!qWE)
    begin
        rNextData <= rNextData;
    end
    case (iSW)
        8'h00       : rNextData <= COLOR_RED;
        8'h01       : rNextData <= COLOR_BLUE;
        8'h02       : rNextData <= COLOR_GREEN;
        default     : rNextData <= rNextData;
    endcase
end

// reg [7:0] rFpsCnt;
// reg qFEN;

// always @(posedge iCLK)
// begin
//     if (iRST)               rFpsCnt <= 0;
//     else if (qFEN && qWE)   rFpsCnt <= 0;
//     else if (qWE)           rFpsCnt <= rFpsCnt + 1'b1;
//     else                    rFpsCnt <= rFpsCnt;
// end

// always @(posedge iCLK)
// begin
//     case (iWS)
//         IDOL        : rNextData <= rNextData;
//         FBUF_AREA_1 : rNextData <= (qFEN && qWE) ? COLOR_GREEN : COLOR_BLUE;
//         FBUF_AREA_2 : rNextData <= (qFEN && qWE) ? COLOR_RED   : COLOR_GREEN;
//         FBUF_AREA_3 : rNextData <= (qFEN && qWE) ? COLOR_BLUE  : COLOR_RED;
//         default     : rNextData <= COLOR_RED;
//     endcase
// end

// always @*
// begin
//     qFEN <= (rFpsCnt == 254);
// end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// RGB Pixel data Gen
//----------------------------------------------------------
reg [pBitWidth-1:0] rWD;        assign oPixel   = rWD;

always @(posedge iCLK)
begin
    if (iRST)           rWD <= COLOR_RED;
    else if (qWE)       rWD <= rNextData;
    else                rWD <= rWD;
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 次回アクセスするフレームバッファ領域の生成
//----------------------------------------------------------
reg [pAddrWidth-1:0] rWA;       assign oAddr    = rWA;
reg [pAddrWidth-1:0] rNextAddr;

always @(posedge iCLK)
begin
    case (iWS)
        IDOL        :   rNextAddr <= rNextAddr;
        FBUF_AREA_1 :   rNextAddr <= DDR_ADDR_FBUF_2;
        FBUF_AREA_2 :   rNextAddr <= DDR_ADDR_FBUF_3;
        FBUF_AREA_3 :   rNextAddr <= DDR_ADDR_FBUF_1;
        default     :   rNextAddr <= DDR_ADDR_FBUF_1;
    endcase
end

always @(posedge iCLK)
begin
    if (iRST)           rWA <= DDR_ADDR_FBUF_1;
    else if (qWE)       rWA <= rNextAddr;
    else if (iDdrWE)    rWA <= rWA + 4'd8;
    else                rWA <= rWA;
end

endmodule