//----------------------------------------------------------
// Create 2022/03/20
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// 入力データをbitに分割して出力する
//----------------------------------------------------------
module bitSplit #(
    parameter pBuffDepth   = 256,       // FIFO BRAMのサイズ指定
    parameter pBitInWidth  = 128,       // 入力bitサイズ
    parameter pBitOutWidth = 32         // 出力bitサイズ
)(
    input                       iCLK,
    input                       iRST,   // Active High
    input   [pBitInWidth-1:0]   iWD,    // write data
    input                       iWE,    // write enable 有効データ書き込み
    output                      oFLL,   // 最大書き込み時High
    output  [pBitOutWidth-1:0]  oRD,    // read data
    input                       iRE,    // read enable
    output                      oRVD,   // 有効データ出力
    output                      oEMP    // バッファ空時High
);


////////////////////////////////////////////////////////////
localparam [pBitInWidth-1:0] lpWdNull = 0;


////////////////////////////////////////////////////////////
reg [pBitInWidth-1:0] rWdSh [0:1];
reg rWe [0:1];

always @(posedge iCLK)
begin
    {rWdSh[1], rWdSh[0]} <= {rWdSh[0], iWD};
end

always @(posedge iCLK)
begin
    {rWe[1], rWe[0]} <= {rWe[0], iWD};
end



////////////////////////////////////////////////////////////
endmodule