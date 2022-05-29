//----------------------------------------------------------
// Create 2022/03/20
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// 
//----------------------------------------------------------
module bitConverter #(
    parameter pBuffDepth        = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth         = 32,     // bitサイズ
    parameter pInDataWidth      = 128
)(
    input                       iCLKA,
    input                       iCLKB,
    input                       iRST,   // Active High
    input   [pInDataWidth-1:0]  iWD,    // write data
    input                       iWE,    // write enable 有効データ書き込み
    output                      oFLL,   // 最大書き込み時High
    output  [pBitWidth-1:0]     oRD,    // read data
    input                       iRE     // read enable
);

`include "../include/commonAddr.vh"

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 128bitデータを分割して保存
//----------------------------------------------------------
reg [pBitWidth-1:0] rWD [0:63];
reg [5:0] rPtr;

always @(posedge iCLKA)
begin
    if (iRST)     rPtr <= 0;
    else if (iWE) rPtr <= rPtr + 4'd4;
    else          rPtr <= rPtr;
end

always @(posedge iCLKA)
begin
    if (iWE)
    begin
        rWD[rPtr + 3] <= iWD[127:96];
        rWD[rPtr + 2] <= iWD[ 95:64];
        rWD[rPtr + 1] <= iWD[ 63:32];
        rWD[rPtr + 0] <= iWD[ 31: 0];
    end
    else
    begin
        rWD[rPtr + 3] <= rWD[rPtr + 3];
        rWD[rPtr + 2] <= rWD[rPtr + 2];
        rWD[rPtr + 1] <= rWD[rPtr + 1];
        rWD[rPtr + 0] <= rWD[rPtr + 0];
    end
end

//----------------------------------------------------------
// FIFO保存データ生成
//----------------------------------------------------------
reg rFWE, qWE;
reg [pBitWidth-1:0] rFWD;
reg [5:0] rFPtr;

always @(posedge iCLKA)
begin
    if (iRST)     rFPtr <= 0;
    else if (qWE) rFPtr <= rFPtr + 1'b1;
    else          rFPtr <= rFPtr;
end

always @(posedge iCLKA) rFWD <= rWD[rFPtr];
always @(posedge iCLKA) rFWE <= qWE;
always @*               qWE  <= (rPtr != rFPtr);

//----------------------------------------------------------
// Async FIFO 
// ディスプレイクロック(dclk)とアプリケーション側のクロック(aclk)で動作する
// FPSの向上の為、dclkの周期で必ず画素データがFIFOに存在していなければならない
// 画素データ出力とタイミングを合わせるため、iFVDEを使用し、iVDEがONになるより早くデータを出力する
//----------------------------------------------------------
wire wRVD, wEmp, wFLL;                  assign oFLL = wFLL;
wire [pBitWidth-1:0] wRD;

fifoDualController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitWidth)
) PIXEL_FIFO_DUAL_CONTROLLER (
    // write side               read side
    .iCLKA  (iCLKA),            .iCLKB  (iCLKB),
    .iRST   (iRST),
    .iWD    (rFWD),             .oRD    (wRD),
    .iWE    (rFWE),             .iRE    (iRE),
    .oFLL   (wFLL),             .oRVD   (wRVD),
                                .oEMP   (wEmp)
);

//----------------------------------------------------------
// ピクセルデータ送信
//----------------------------------------------------------
reg  [pBitWidth-1:0] rPixel;            assign oRD = rPixel;

always @(posedge iCLKB)
begin
    case ({iRST, wRVD, ~wEmp})
    'b000:      rPixel <= COLOR_BLACK;
    'b001:      rPixel <= COLOR_WHITE;
    'b010:      rPixel <= wRD;
    'b011:      rPixel <= wRD;
    default:    rPixel <= 0;
    endcase
end

////////////////////////////////////////////////////////////
endmodule