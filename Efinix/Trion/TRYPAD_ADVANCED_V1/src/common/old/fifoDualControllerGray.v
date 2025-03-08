//----------------------------------------------------------
// Create 2021/2/13
// Author koutakimura
// -
// デュアルポートFIFO コントロールモジュール
// 
// 2022/02/26
// 処理の流れが分かりにくいため、全体をパイプライン処理に更新
// RE Active時 3CLK後に RVD Assert データが出力される
// 
// 2022/03/13
// 非同期FIFO対応のため全体構成見直し、メタ・ステーブル対策を行うようにした
//
// 2022-03-21
// ReadEnableから 2レイテンシでデータ出力する構造に変更、ユーザが意識せずともハンドシェイクが上手く行く用に変更
// -
// 参考文献
// 非同期FIFO Verilog ->    https://zenn.dev/sk6labo/articles/fd2bb32f6e570e
// 非同期FIFO 概念 ->       http://altmo.html.xdomain.jp/src_01/2017_0110/00.html
// グレイコード ->          http://www5.nkansai.ne.jp/users/khateen/gray-code.html
// 
//----------------------------------------------------------
module fifoDualControllerGray #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input   [pBitWidth-1:0]     iWD,    // write data
    input                       iWE,    // write enable 有効データ書き込み
    output                      oFLL,   // 最大書き込み時High
    output  [pBitWidth-1:0]     oRD,    // read data
    input                       iRE,    // read enable
    output                      oRVD,   // 有効データ出力
    output                      oEMP,   // バッファ空時High
	//
    input                       iSrcRst,// Active High
    input                       iDstRst,// Active High
    input                       iSrcClk,// clk write side
    input                       iDstClk // clk read  side
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam lpAddrWidth   = fBitWidth(pBuffDepth);
localparam lpAddrMsb     = lpAddrWidth - 1;
localparam lpAddrMsbNext = lpAddrWidth - 2;
localparam pAddrMax      = pBuffDepth  - 1;

localparam [lpAddrWidth-1:0] lpAddrNull = 0;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFLL 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEMP 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRVD Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg [lpAddrWidth-1:0] rWA, rWG, rWB, wWGf1, wWGf2;
reg [lpAddrWidth-1:0] qWAn [0:5];
reg [lpAddrWidth-1:0] rRA, rRG, rRB, wRGf1, wRGf2, rORP;
reg qWE, qRE;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write addr 更新
// 非同期で動作するため、一度グレイコードに変換したものを別CLKでバイナリに復元する必要がある
// そのためグレイコード変換後、別クロックでメタ・ステーブル対策として2段FFで受信しバイナリに変換を行う
//----------------------------------------------------------
always @(posedge iSrcClk)
begin
    if (iSrcRst)    rWA <= 0;
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

//----------------------------------------------------------
// Address -> Gray Code
//----------------------------------------------------------
always @(posedge iSrcClk)
begin
    if (iSrcRst)       rWG <= 0;
    else            rWG <= {rWA[lpAddrMsb], rWA[lpAddrMsbNext:0] ^ rWA[lpAddrMsb:1]};
end

//----------------------------------------------------------
// meta stable
//----------------------------------------------------------
always @(posedge iDstClk)
begin
    if (iDstRst)    {wWGf2, wWGf1} <= {lpAddrNull, lpAddrNull};
    else            {wWGf2, wWGf1} <= {wWGf1, rWG};
end

//----------------------------------------------------------
// Gray Code -> Bin Code
//----------------------------------------------------------
integer i;

always @*
begin

    for (i = lpAddrMsb; i >= 0; i = i - 1)
    begin
        if (i == lpAddrMsb)
        begin
            rWB[i] <= wWGf2[i];
        end
        else
        begin
            rWB[i] <= wWGf2[i] ^ rWB[i+1];
        end
    end
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// read addr 更新
// 非同期で動作するため、一度グレイコードに変換したものを別CLKでバイナリに復元する必要がある
// そのためグレイコード変換後、別クロックでメタ・ステーブル対策として2段FFで受信しバイナリに変換を行う
//----------------------------------------------------------
//----------------------------------------------------------
// 前回のrpが更新されていたら新規データを出力できる状態と判断する
//----------------------------------------------------------
always @(posedge iDstClk)
begin
    if (iDstRst)       rORP <= 0;
    else            rORP <= rRA;
end

always @(posedge iDstClk)
begin
    if (iDstRst)       rRA <= 0;
    else if (qRE)   rRA <= rRA + 1'b1;
    else            rRA <= rRA;
end

//----------------------------------------------------------
// Address -> Gray Code
//----------------------------------------------------------
always @(posedge iDstClk)
begin
    if (iDstRst)       rRG <= 0;
    else            rRG <= {rRA[lpAddrMsb], rRA[lpAddrMsbNext:0] ^ rRA[lpAddrMsb:1]};
end

//----------------------------------------------------------
// meta stable
//----------------------------------------------------------
always @(posedge iSrcClk)
begin
    if (iSrcRst)    {wRGf2, wRGf1} <= {lpAddrNull, lpAddrNull};
    else            {wRGf2, wRGf1} <= {wRGf1, rRG};
end

//----------------------------------------------------------
// Gray Code -> Bin Code
//----------------------------------------------------------
integer j;

always @*
begin

    for (j = lpAddrMsb; j >= 0; j = j - 1)
    begin
        if (j == lpAddrMsb)
        begin
            rRB[j] <= wRGf2[j];
        end
        else
        begin
            rRB[j] <= wRGf2[j] ^ rRB[j+1];
        end
    end
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//----------------------------------------------------------
reg qFLL, qEMP, qRVD;
reg rFLL, rEMP, rRVD;    assign {oFLL, oEMP, oRVD} = {rFLL, rEMP, rRVD};

always @(posedge iSrcClk)
begin
    if (iSrcRst)    {rFLL, rEMP} <= {1'b0, 1'b0};
    else            {rFLL, rEMP} <= {qFLL, qEMP};
end

always @(posedge iDstClk)
begin
    if (iDstRst)    {rRVD} <= {1'b0};
    else            {rRVD} <= {qRVD};
end

always @*
begin
    qWAn[0] <= rWA + 1'b1;
    qWAn[1] <= rWA + 2'd2;
    qWAn[2] <= rWA + 2'd3;
    qWAn[3] <= rWA + 3'd4;
    qWAn[4] <= rWA + 3'd5;
    qWAn[5] <= rWA + 3'd6;
    qFLL    <= (qWAn[0] == rRA || qWAn[1] == rRA || qWAn[2] == rRA ||
                qWAn[3] == rRA || qWAn[4] == rRA || qWAn[5] == rRA);
    qEMP    <= (rWB  == rRA) ;
    qRVD    <= (rRA != rORP);
    // qRVD    <= iRE & (~qEMP);
    qWE     <= iWE;
    qRE     <= iRE & (~qEMP);
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
//----------------------------------------------------------
wire [pBitWidth-1:0] wRD;           assign oRD = wRD;

userFifoDual #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (lpAddrWidth)
) USER_FIFO_DUAL (
    // write side       read side
    .iSrcClk(iSrcClk),  .iDstClk(iDstClk),
    .iWD    (iWD),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (qWE)
);


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