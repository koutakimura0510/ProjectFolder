//----------------------------------------------------------
// Create 2022/3/20
// Author koutakimura
// -
// デュアルポートFIFO コントロールモジュール
// 
// LUTRAM使用のため、レイテンシ0で動作する
// 
//----------------------------------------------------------
module fifoDualController #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input                       iClkA,  // clk write side
    input                       iClkB,  // clk read  side
    input                       iRstA,  // Active High
    input                       iRstB,  // Active High
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
localparam lpAddrWidth  = fBitWidth(pBuffDepth);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFLL 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEMP 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRVD Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg qFLL, qEMP, qRVD;    assign {oFLL, oEMP, oRVD} = {qFLL, qEMP, qRVD};
reg [lpAddrWidth-1:0] rWA, rWAn, rRA, rORP;
reg qWE, qRE, qRst;


////////////////////////////////////////////////////////////
// write pointer
always @(posedge iClkA)
begin
    if (iRstA)      rWA <= 0;
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iClkB)
begin
    if (iRstB)     rRA <= 0;
    else if (qRE)  rRA <= rRA + 1'b1;
    else           rRA <= rRA;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iClkB)
begin
    if (iRstB)  rORP <= 0;
    else        rORP <= rRA;
end

///////////////////////////////////////////////////////////
//---------------------------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//---------------------------------------------------------------------------
always @*
begin
    rWAn <= rWA + 1'b1;
    qFLL <= (rWAn == rRA) ? 1'b1 : 1'b0;
    qEMP <= (rWA == rRA) ? 1'b1 : 1'b0;
    // qRVD <= (rRA != rORP);
    qRVD <= iRE & (~qEMP);
    qWE  <= iWE & (~qFLL);
    qRE  <= iRE & (~qEMP);
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
    .iClkA  (iClkA),    .iClkB  (iClkB),
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