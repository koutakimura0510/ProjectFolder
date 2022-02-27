//----------------------------------------------------------
// Create 2021/2/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// デュアルポートFIFO コントロールモジュール
// 
// 2022/02/26
// 処理の流れが分かりにくいため、全体をパイプライン処理に更新
// RE Active時 3CLK後に RVD Assert データが出力される
// 
// TODO Enableから出力まで遅延が発生するため、moduleのパラメータで、入力データの遅延数などを指定しなければならない
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
reg [pAddrWidth-1:0] qWAb, qWAb2;
reg [pAddrWidth-1:0] qRAb [3:0];
reg [pAddrWidth-1:0] rWA, rRA, rORP;
reg rWE, rRE;
reg qWE, qRE, qRst;

////////////////////////////////////////////////////////////
// write pointer
always @(posedge iCLKA)
begin
    if (qRst)       rWA <= 0;
    else if (!rWE)  rWA <= rWA;
    else            rWA <= (rWA + 1'b1) & pAddrMask;
end

// read pointer
always @(posedge iCLKB)
begin
    if (qRst)      rRA <= 0;
    else if (!rRE) rRA <= rRA;
    else           rRA <= (rRA + 1'b1) & pAddrMask;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iCLKB)
begin
    if (qRst)   rORP <= 0;
    else        rORP <= rRA;
end

////////////////////////////////////////////////////////////
// Hnad Shake信号、タイミング結合のためDFFに一度通す
always @(posedge iCLKA)
begin
    if (qRst)       {rFLL, rEMP} <= {1'b1, 1'b1};
    else            {rFLL, rEMP} <= {qFLL, qEMP};
end

always @(posedge iCLKB)
begin
    if (qRst)       {rRVD, rRE} <= 2'b00;
    else            {rRVD, rRE} <= {qRVD, qRE};
end

always @(posedge iCLKA)
begin
    if (qRst)       rWE <= 1'b0;
    else            rWE <= qWE;
end

integer i;

// DFFの段数により3clk遅延するため、3clk分のraポインタを先取りして計算しておく
always @*
begin
    for (i = 1; i < 5; i = i + 1)
    begin
        qRAb[i-1] <= (rRA - i) & pAddrMask;
    end

    qRst    <= iRST;
    qWAb    <= (rWA - 1'b1) & pAddrMask;
    qWAb2   <= (rWA - 2'd2) & pAddrMask;
    qFLL    <= (rWA == qRAb[0] || rWA == qRAb[1] || rWA == qRAb[2] || rWA == qRAb[3]);
    qEMP    <= (rWA == rRA || qWAb2 == rRA || qWAb == rRA) ? 1'b1 : 1'b0;
    qRVD    <= (rRA != rORP);
    qWE     <= iWE;
    qRE     <= iRE;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
//----------------------------------------------------------
reg  [pBitWidth-1:0] rWD, rRD;      assign oRD = rRD;
wire [pBitWidth-1:0] wRD;

userFifoDual #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO_DUAL (
    // write side       read side
    .iCLKA  (iCLKA),    .iCLKB  (iCLKB),
    .iWD    (rWD),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (rWE)
);

always @(posedge iCLKA)
begin
    if (qRst)       rWD  <= 0;
    else            rWD  <= iWD;
end

always @(posedge iCLKB)
begin
    if (qRst)       rRD  <= 0;
    else            rRD  <= wRD;
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