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


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFLL 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEMP 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRVD Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg [pAddrWidth-1:0] rWA, qWAn, rRA, rORP;
reg qWE, qRE;


////////////////////////////////////////////////////////////
// write pointer
always @(posedge iCLK)
begin
    if (iRST)       rWA <= 0;
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iCLK)
begin
    if (iRST)      rRA <= 0;
    else if (qRE)  rRA <= rRA + 1'b1;
    else           rRA <= rRA;
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iCLK)
begin
    if (iRST)   rORP <= 0;
    else        rORP <= rRA;
end

//----------------------------------------------------------
// ハンドシェイク信号出力
//----------------------------------------------------------
reg qFLL, qEMP, qRVD;
reg rFLL, rEMP, rRVD;    assign {oFLL, oEMP, oRVD} = {qFLL, qEMP, qRVD};

always @(posedge iCLK)
begin
    if (iRST)       {rFLL, rEMP, rRVD} <= {1'b0, 1'b0, 1'b0};
    else            {rFLL, rEMP, rRVD} <= {qFLL, qEMP, qRVD};
end

///////////////////////////////////////////////////////////
//---------------------------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//---------------------------------------------------------------------------
always @*
begin
    qWAn <= rWA + 1'b1;
    qFLL <= (qWAn == rRA) ? 1'b1 : 1'b0;
    qEMP <= (rWA  == rRA) ? 1'b1 : 1'b0;
    // qRVD <= (rRA != rORP);
    qRVD <= iRE & (~qEMP);
    qWE  <= iWE & (~qFLL);
    qRE  <= iRE & (~qEMP);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
// 上記のハンドシェイク信号のタイミングを合わせるためDFFに入力を行う
//----------------------------------------------------------
wire [pBitWidth-1:0] wRD;             assign oRD = wRD;

userFifo #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO (
    // write side       read side
    .iCLK   (iCLK),
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