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
    parameter       pBitLengthState     = 2,
    parameter       pDramDebug          = "off"
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
localparam pDdrFbufSize = (pHDisplay * pVDisplay) - 1;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 画面サイズのアドレス送信回数をカウントする
// 最大値カウント時 Enable ON
//----------------------------------------------------------
reg qWE;                assign oWE = qWE & iDdrWE;
reg [20:0] rAddrCnt;

always @(posedge iCLK)
begin
    case ({iRST, qWE, iDdrWE})
    'b000:      rAddrCnt <= rAddrCnt;
    'b001:      rAddrCnt <= rAddrCnt + 1'b1;
    'b010:      rAddrCnt <= rAddrCnt;
    'b011:      rAddrCnt <= 0;
    default:    rAddrCnt <= 0;
    endcase
end

always @*
begin
    qWE <= (pDdrFbufSize == rAddrCnt);
end


////////////////////////////////////////////////////////////
reg [pBitWidth-1:0] rNextData;

always @(posedge iCLK)
begin
    case (iWS)
        IDOL        : rNextData <= rNextData;
        FBUF_AREA_1 : rNextData <= qWE ? COLOR_GREEN : COLOR_BLUE;
        FBUF_AREA_2 : rNextData <= qWE ? COLOR_RED   : COLOR_GREEN;
        FBUF_AREA_3 : rNextData <= qWE ? COLOR_BLUE  : COLOR_RED;
        default     : rNextData <= COLOR_RED;
    endcase
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// RGB Pixel data Gen
//----------------------------------------------------------
reg [pBitWidth-1:0] rWD;        assign oPixel   = rWD;

generate
    if (pDramDebug == "on")
        always @(posedge iCLK)
        begin
            case ({iRST, qWE, iDdrWE})
            'b000:      rWD <= rWD;
            'b001:      rWD <= rWD + 1'b1;
            'b010:      rWD <= rWD;
            'b011:      rWD <= 0;
            default:    rWD <= 0;
            endcase
        end
    else
        always @(posedge iCLK)
        begin
            case ({iRST, qWE, iDdrWE})
            'b000:      rWD <= rWD;
            'b001:      rWD <= rWD;
            'b010:      rWD <= rWD;
            'b011:      rWD <= rNextData;
            default:    rWD <= COLOR_RED;
            endcase
        end
endgenerate


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
    case ({iRST, qWE, iDdrWE})
    'b000:      rWA <= rWA;
    'b001:      rWA <= rWA + 4'd8;
    'b010:      rWA <= rWA;
    'b011:      rWA <= rNextAddr;
    default:    rWA <= DDR_ADDR_FBUF_1;
    endcase
end

endmodule