//----------------------------------------------------------
// Create 2022/02/05
// Author koutakimura
// -
// FIFOコントロールモジュール
// この回路を使用する上位モジュールでは下記の内容でデータのやり取りを行う
// 1.書き込み時はoFullのみ確認すれば良い
// 2.読み込み時はoEMPとoRdVを確認すれば良い
//
// 2022/02/26
// 処理の流れが分かりにくいため、全体をパイプライン処理に更新
// RE Active時 3CLK後に RVD Assert データが出力される
// 
// 2022/03/13
// 動作周波数を上げるため全体構成見直し、パイプライン処理中止
//
// 2022-03-21
// ReadEnableから 2レイテンシでデータ出力する構造に変更、ユーザが意識せずともハンドシェイクが上手く行く用に変更
// 
//----------------------------------------------------------
module fifoController #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input                       iClk,
    input                       iRst,   // Active High
    input   [pBitWidth-1:0]     iWd,    // write data
    input                       iWe,    // write enable 有効データ書き込み
    output                      oFull,   // 最大書き込み時High
    output  [pBitWidth-1:0]     oRd,    // read data
    input                       iRe,    // read enable
    output                      oRvd,   // 有効データ出力
    output                      oEmp    // バッファ空時High
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pBuffDepth);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFull 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEmp 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRvd Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg [pAddrWidth-1:0] rWA, rRA, rORP;
reg [pAddrWidth-1:0] qWAn [0:5];
reg qWE, qRE;


////////////////////////////////////////////////////////////
// write pointer
always @(posedge iClk)
begin
    if (iRst)       rWA <= 0;
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iClk)
begin
    if (iRst)      rRA <= 0;
    else if (qRE)  rRA <= rRA + 1'b1;
    else           rRA <= rRA;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iClk)
begin
    if (iRst)   rORP <= 0;
    else        rORP <= rRA;
end

//----------------------------------------------------------
// ハンドシェイク信号出力
//----------------------------------------------------------
reg qFLL, qEMP, qRVD;
reg rFLL, rEMP, rRVD;    assign {oFull, oEmp, oRvd} = {rFLL, rEMP, rRVD};

always @(posedge iClk)
begin
    if (iRst)       {rFLL, rEMP, rRVD} <= {1'b0, 1'b0, 1'b0};
    else            {rFLL, rEMP, rRVD} <= {qFLL, qEMP, qRVD};
end

///////////////////////////////////////////////////////////
//---------------------------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//---------------------------------------------------------------------------
always @*
begin
    qWAn[0] <= rWA + 1'd1;
    qWAn[1] <= rWA + 2'd2;
    qWAn[2] <= rWA + 2'd3;
    qWAn[3] <= rWA + 3'd4;
    qWAn[4] <= rWA + 3'd5;
    qWAn[5] <= rWA + 3'd6;
    qFLL    <= (qWAn[0] == rRA || qWAn[1] == rRA || qWAn[2] == rRA ||
                qWAn[3] == rRA || qWAn[4] == rRA || qWAn[5] == rRA);
    qEMP <= (rWA  == rRA) ? 1'b1 : 1'b0;
    qRVD <= (rRA != rORP);
    // qRVD <= iRe & (~qEMP);
    qWE  <= iWe;
    qRE  <= iRe & (~qEMP);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
// 上記のハンドシェイク信号のタイミングを合わせるためDFFに入力を行う
//----------------------------------------------------------
wire [pBitWidth-1:0] wRD;             assign oRd = wRD;

userFifo #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO (
    // write side       read side
    .iClk   (iClk),
    .iWD    (iWd),      .oRD    (wRD),
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