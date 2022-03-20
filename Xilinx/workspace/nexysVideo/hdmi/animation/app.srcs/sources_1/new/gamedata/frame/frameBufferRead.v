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
reg qREn;               assign oRE = qRE & iDdrRaE;
reg [20:0] rDispCnt;

always @(posedge iCLK)
begin
    case ({iRST, qRE, iDdrRaE})
    'b000:      rDispCnt <= rDispCnt;
    'b001:      rDispCnt <= rDispCnt + 1'b1;
    'b010:      rDispCnt <= rDispCnt;
    'b011:      rDispCnt <= 0;
    default:    rDispCnt <= 0;
    endcase
end

always @*
begin
    qRE  <= (pDdrFbufSize  == rDispCnt);
    qREn <= (pDdrFbufSize2 == rDispCnt);
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
reg [pAddrWidth-1:0] rRA;     assign oAddr = rRA;

always @(posedge iCLK)
begin
    case ({iRST, qRE, iDdrRaE})
    'b000:      rRA <= rRA;
    'b001:      rRA <= rRA + 4'd8;
    'b010:      rRA <= rRA;
    'b011:      rRA <= rNextAddr;
    default:    rRA <= DDR_ADDR_FBUF_1;
    endcase
end

endmodule