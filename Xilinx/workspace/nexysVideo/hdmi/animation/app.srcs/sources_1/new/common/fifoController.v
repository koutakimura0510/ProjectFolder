//----------------------------------------------------------
// Create 2022/02/05
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFOコントロールモジュール
// この回路を使用する上位モジュールでは下記の内容でデータのやり取りを行う
// 1.書き込み時はoFLLのみ確認すれば良い
// 2.読み込み時はoEMPとoRDVを確認すれば良い
//
// 2022/02/26 処理の流れが分かりにくいため、全体をパイプライン処理に更新
//----------------------------------------------------------
module fifoController #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input                       iCLK,
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
localparam pAddrMax    = pBuffDepth - 1'b1;


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
reg [pAddrWidth-1:0] qWAb, qWAb2, qRAb, qRAb2, qRAb3;
reg [pAddrWidth-1:0] rWA, rWNA, rRA, rRBA;
reg [pAddrWidth-1:0] rORP;
reg rWE, rRE;
reg qWE, qRE, qRst;


////////////////////////////////////////////////////////////
// write pointer
always @(posedge iCLK)
begin
    if (qRst)       rWA <= 0;
    else if (rWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

always @(posedge iCLK)
begin
    if (qRst)       rWNA <= 1;
    else if (rWE)   rWNA <= rWNA + 1'b1;
    else            rWNA <= rWNA;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iCLK)
begin
    if (qRst)      rRA <= 0;
    else if  (rRE) rRA <= rRA + 1'b1;
    else           rRA <= rRA;
end

always @(posedge iCLK)
begin
    if (qRst)      rRBA <= pAddrMax;
    else if  (rRE) rRBA <= rRA - 1'b1;
    else           rRBA <= rRBA;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iCLK)
begin
    if (qRst)   rORP <= 0;
    else        rORP <= rRA;
end

////////////////////////////////////////////////////////////
// Hnad Shake信号、タイミング結合のためDFFに一度通す
always @(posedge iCLK)
begin
    if (qRst)       {rFLL, rEMP, rRVD} <= {1'b1, 1'b1, 1'b0};
    else            {rFLL, rEMP, rRVD} <= {qFLL, qEMP, qRVD};
end

always @(posedge iCLK)
begin
    if (qRst)       {rWE, rRE}  <= {1'b0, 1'b0};
    else            {rWE, rRE}  <= {qWE, qRE};
end

// DFFの段数により3clk遅延するため、3clk分のraポインタを先取りして計算しておく
always @*
begin
    qWAb    <= rWA - 1'b1;
    qWAb2   <= rWA - 2'd2;
    qRAb    <= rRA - 1'b1;
    qRAb2   <= rRA - 2'd2;
    qRAb3   <= rRA - 2'd3;
    qRst    <= iRST;
    qFLL    <= (rWA == qRAb || rWA == qRAb2 || rWA == qRAb3);
    qEMP    <= (rWA == rRA || qWAb2 == rRA || qWAb == rRA) ? 1'b1 : 1'b0;
    qRVD    <= (rRA != rORP);
    qWE     <= iWE;
    qRE     <= iRE;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
// 上記のハンドシェイク信号のタイミングを合わせるためDFFに入力を行う
//----------------------------------------------------------
reg  [pBitWidth-1:0] rWD, rRD;      assign oRD = rRD;
wire [pBitWidth-1:0] wRD;

userFifo #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO (
    // write side       read side
    .iCLK   (iCLK),
    .iWD    (rWD),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (rWE)
);

always @(posedge iCLK)
begin
    if (qRst)       rRD  <= 0;
    else            rRD  <= wRD;
end

always @(posedge iCLK)
begin
    if (qRst)       rWD  <= 0;
    else            rWD  <= iWD;
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction
////////////////////////////////////////////////////////////
endmodule