//----------------------------------------------------------
// Create 2021/2/19
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// DDRメモリに確保しているフレームバッファ領域にアクセスするためのアドレスを生成するモジュール
//----------------------------------------------------------
module frameBufferRead # (
    parameter pHDisplay         = 640,
    parameter pVDisplay         = 480,
    parameter pAddrWidth        = 32,           // address
    parameter pBitLengthState   = 2
)(
    input                           iCLK,       // system clk
    input                           iRST,       // system rst
    input                           iDdrRaE,    // ddr memory sideの FIFO FULL信号受信
    input  [pBitLengthState-1:0]    iRS,        // read buffer state
    output [pAddrWidth-1:0]         oAddr,      // framebuffer addr
    output                          oRE
);

////////////////////////////////////////////////////////////
`include "../include/commonAddr.vh"
localparam pDdrFbufSize  = (pHDisplay * pVDisplay) - 1;
localparam pDdrFbufSize2 = (pHDisplay * pVDisplay) - 2;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 画面サイズのアドレス送信回数をカウントする
// 最大値カウント時 Enable ON
//----------------------------------------------------------
reg qRE;
reg qREn;               assign oRE = qREn;
reg [20:0] rAddrCnt;

always @(posedge iCLK)
begin
    if (iRST)           rAddrCnt <= 21'd0;
    else if (qRE)       rAddrCnt <= 21'd0;
    else if (iDdrRaE)   rAddrCnt <= rAddrCnt + 1'b1;
    else                rAddrCnt <= rAddrCnt;
end

always @*
begin
    qRE  <= (pDdrFbufSize  == rAddrCnt);
    qREn <= (pDdrFbufSize2 == rAddrCnt);
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 次回アクセスするフレームバッファ領域の保存
//----------------------------------------------------------
reg [pAddrWidth-1:0] rNextAddr;

always @(posedge iCLK)
begin
    case (iRS)
        IDOL        : rNextAddr <= DDR_ADDR_FBUF_1;
        FBUF_AREA_1 : rNextAddr <= DDR_ADDR_FBUF_2;
        FBUF_AREA_2 : rNextAddr <= DDR_ADDR_FBUF_3;
        FBUF_AREA_3 : rNextAddr <= DDR_ADDR_FBUF_1;
        default     : rNextAddr <= DDR_ADDR_FBUF_1;
    endcase
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// フレームバッファアクセス用のアドレス更新
//----------------------------------------------------------
reg [pAddrWidth-1:0] rFramAddr;     assign oAddr = rFramAddr;

always @(posedge iCLK)
begin
    if (iRST)           rFramAddr <= DDR_ADDR_FBUF_1;
    else if (qRE)       rFramAddr <= rNextAddr;
    else if (iDdrRaE)   rFramAddr <= rFramAddr + 4'd8;
    else                rFramAddr <= rFramAddr;
end

endmodule