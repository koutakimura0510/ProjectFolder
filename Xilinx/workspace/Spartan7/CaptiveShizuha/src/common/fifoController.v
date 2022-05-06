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
// 2022-05-04
// 読み込みデータを Bit 結合できるよう改造
// 
//----------------------------------------------------------
module fifoController #(
    parameter pBuffDepth        = 256,      // FIFO BRAMのサイズ指定
    parameter pWriteWidth       = 8,        // bitサイズ
    parameter pBitConvert       = "off",    // on の場合 出力データの Bit 結合を行う
    parameter pReadWidth        = 8         // on の場合 WriteWidth と Bit 幅を合わせる
)(
    input                       iClk,
    input                       iRst,       // Active High
    input   [pWriteWidth-1:0]   iWd,        // write data
    input                       iWe,        // write enable 有効データ書き込み
    output                      oFull,      // 最大書き込み時High
    output  [pReadWidth-1:0]    oRd,        // read data
    input                       iRe,        // read enable
    output                      oRvd,       // 有効データ出力
    output                      oEmp        // バッファ空時High
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
reg rFLL, rEMP;                         assign {oFull, oEmp} = {rFLL, rEMP};

always @(posedge iClk)
begin
    if (iRst)       {rFLL, rEMP} <= {1'b0, 1'b0};
    else            {rFLL, rEMP} <= {qFLL, qEMP};
end


//----------------------------------------------------------
// rvd
//----------------------------------------------------------
generate
    if (pBitConvert == "on")
    begin
        reg [1:0] rRvd;                 assign oRvd = rRvd[1];

        always @(posedge iClk)
        begin
            if (iRst)       rRvd <= 2'd0;
            else if (qRVD)  rRvd <= (rRvd == 2'd2) ? 2'd1 : rRvd + 1'b1;
            else            rRvd <= (rRvd == 2'd2) ? 2'd0 : rRvd;
        end
    end
    else
    begin
        reg rRvd;                       assign oRvd = rRvd;

        always @(posedge iClk)
        begin
            rRvd <= qRVD;
        end
    end
endgenerate


///////////////////////////////////////////////////////////
//---------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//---------------------------------------------------------
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
// FIFO 動作
// 上記のハンドシェイク信号のタイミングを合わせるためDFFに入力を行う
//----------------------------------------------------------
wire [pWriteWidth-1:0] wRD;

userFifo #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pWriteWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO (
    // write side       read side
    .iClk   (iClk),
    .iWD    (iWd),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (qWE)
);


//----------------------------------------------------------
// Bit 結合
//----------------------------------------------------------
generate
    if (pBitConvert == "on")
    begin
        reg [pReadWidth-1:0] rRd;    assign oRd = rRd;

        always @(posedge iClk)
        begin
            if (qRVD)   {rRd[15:8], rRd[7:0]} <= {rRd[7:0], wRD};
            else        rRd <= rRd;
        end
    end
    else
    begin
                                    assign oRd = wRD;
    end
endgenerate


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