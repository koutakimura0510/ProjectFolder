//----------------------------------------------------------
// Create 2021/2/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// デュアルポートFIFO コントロールモジュール
//----------------------------------------------------------
module fifoDualController #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input                       iCLKA,  // clk write side
    input                       iCLKB,  // clk read  side
    input                       iRST,   // Active High
    input   [pBitWidth-1:0]     iWD,    // write data
    input                       iWE,    // write enable 有効データ書き込み
    output                      oFLL,   // 最大書き込み時High
    output  [pBitWidth-1:0]     oRD,    // read data
    input                       iRE,    // read enable
    output                      oRVD,   // 有効データ出力
    output                      oEMP    // バッファ空時High
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pBuffDepth);
localparam [pAddrWidth-1:0] pAddrMask = pBuffDepth - 1;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFLL 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEMP 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRVD Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg rFLL, rEMP, rRVD;    assign {oFLL, oEMP, oRVD} = {rFLL, rEMP, rRVD};
reg qFLL, qEMP, qRVD;
reg [pAddrWidth-1:0] rWAb, rRAb;    // R/W Address Back 現在のwrポインタの一つ手前のインデックス参照
reg [pAddrWidth-1:0] rWA, rRA;      // 現在参照中のwrポインタ
reg [pAddrWidth-1:0] rORP;
reg qWE, qRE, qRst;

////////////////////////////////////////////////////////////
// write pointer
always @(posedge iCLKA)
begin
    if (qRst)       rWA <= 0;
    else if (!qWE)  rWA <= rWA;
    else            rWA <= (rWA + 1'b1) & pAddrMask;
end

always @(posedge iCLKA)
begin
    if (qRst)       rWAb <= 0;
    else            rWAb <= (rWA - 1'b1) & pAddrMask;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iCLKB)
begin
    if (qRst)      rRA <= 0;
    else if (!qRE) rRA <= rRA;
    else           rRA <= (rRA + 1'b1) & pAddrMask;
end

always @(posedge iCLKB)
begin
    if (qRst)       rRAb <= 0;
    else            rRAb <= (rRA - 1'b1) & pAddrMask;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iCLKB)
begin
    if (qRst)   rORP <= 0;
    else        rORP <= rRA;
end

////////////////////////////////////////////////////////////
always @(posedge iCLKA)
begin
    if (qRst)       rFLL <= 1'b0;
    else if (qFLL)  rFLL <= 1'b1;
    else            rFLL <= 1'b0;
end

always @(posedge iCLKA)
begin
    if (qRst)       rEMP <= 1'b0;
    else if (qEMP)  rEMP <= 1'b1;
    else            rEMP <= 1'b0;
end

always @(posedge iCLKB)
begin
    if (qRst)       rRVD <= 1'b0;
    else if (qRVD)  rRVD <= 1'b1;
    else            rRVD <= 1'b0;
end

////////////////////////////////////////////////////////////
// Hand Shake

always @*
begin
    // rWAb <= (rWA - 1'b1) & pAddrMask;
    // rRAb <= (rRA - 1'b1) & pAddrMask;
    qRst <= iRST;
    qWE  <= iWE & (~rFLL);
    qRE  <= iRE & (~rEMP);
    qFLL <= (rRAb == rWA) ? 1'b1 : 1'b0;
    qEMP <= (rWA == rRA || rWAb == rRA) ? 1'b1 : 1'b0;
    qRVD <= (rRA == rORP) ? 1'b0 : 1'b1;
end
////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
//----------------------------------------------------------
reg  [pBitWidth-1:0] qWD;
wire [pBitWidth-1:0] qRD;    assign oRD = qRD;

userFifoDual #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO_DUAL (
    // write side       read side
    .iCLKA  (iCLKA),    .iCLKB  (iCLKB),
    .iWD    (qWD),      .oRD    (qRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (qWE)
);

always @*
begin
    qWD <= iWD;
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) 
        begin
            fBitWidth = i+1;
        end
    end
endfunction
////////////////////////////////////////////////////////////

endmodule