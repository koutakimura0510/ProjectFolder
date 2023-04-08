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
// 2022-09-06
// コーディング規則に則りソースコードの修正
// 
//----------------------------------------------------------
module fifoController #(
    parameter 	pFifoDepth        	= 16,		// FIFO BRAMのサイズ指定
    parameter 	pFifoBitWidth     	= 8,		// bitサイズ
	parameter	pFifoBlockRam		= "yes"		// yes BRAM, no reg
)(
	// src side
    input   [pFifoBitWidth-1:0] iWd,        // write data
    input                       iWe,        // write enable 有効データ書き込み
    output                      oFull,      // 最大書き込み時High
	// dst side
    output  [pFifoBitWidth-1:0] oRd,        // read data
    input                       iRe,        // read enable
    output                      oRvd,       // 有効データ出力
    output                      oEmp,       // バッファ空時High
	//
    input                       iRST,
    input                       iCLK
);

//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pFifoDepth);


//-----------------------------------------------------------------------------
// アドレスの更新
//-----------------------------------------------------------------------------
reg [pAddrWidth-1:0] rWA, rRA, rORP;
reg qWE, qRE;

always @(posedge iCLK)
begin
    if (iRST)       rWA <= {pAddrWidth{1'b0}};
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
	//
    if (iRST)      	rRA <= {pAddrWidth{1'b0}};
    else if (qRE)  	rRA <= rRA + 1'b1;
    else           	rRA <= rRA;
	// 前回のrpが更新されていたら新規データを出力できる状態と判断する
    if (iRST)   	rORP <= {pAddrWidth{1'b0}};
    else        	rORP <= rRA;
end

//----------------------------------------------------------
// ハンドシェイク信号出力
//----------------------------------------------------------
reg qFLL, qEMP, qRVD;
reg rFLL;							assign oFull = rFLL;
reg rEMP;							assign oEmp  = rEMP;
reg rRvd;							assign oRvd = rRvd;
reg [pAddrWidth-1:0] qWAn [0:5];

always @(posedge iCLK)
begin
    if (iRST)       rFLL <= 1'b0;
    else            rFLL <= qFLL;

    if (iRST)       rEMP <= 1'b0;
    else            rEMP <= qEMP;

    if (iRST)       rRvd <= 1'b0;
    else            rRvd <= qRVD;
end

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
    qEMP <= (rWA  == rRA);
    qRVD <= (rRA != rORP);
    // qRVD <= iRe & (~qEMP);
    qWE  <= iWe;
    qRE  <= iRe & (~qEMP);
end


//----------------------------------------------------------
// FIFO 動作
//----------------------------------------------------------
reg  [pFifoBitWidth-1:0] rRD;					assign oRd = rRD;
wire [pFifoBitWidth-1:0] wRD;


userFifo #(
    .pBuffDepth    	(pFifoDepth),
    .pBitWidth     	(pFifoBitWidth),
    .pAddrWidth    	(pAddrWidth),
	.pFifoBlockRam	(pFifoBlockRam)
) USER_FIFO (
    // write side       read side
    .iCLK   (iCLK),
    .iWD    (iWd),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (qWE)
);


always @(posedge iCLK)
begin
	rRD <= wRD;
end


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