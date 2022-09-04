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
    parameter pBitWidth   = 24      // bitサイズ
)(
    input   [pBitWidth-1:0]     iWD,    	// write data
    input                       iWE,    	// write enable 有効データ書き込み
    output                      oFLL,   	// 最大書き込み時High
    output  [pBitWidth-1:0]     oRD,    	// read data
    input                       iRE,    	// read enable
    output                      oRVD,   	// 有効データ出力
    output                      oEMP,   	// バッファ空時High
	//
    input                       iSrcRst,	// Active High
    input                       iDstRst,	// Active High
    input                       iSrcClk,	// clk write side
    input                       iDstClk 	// clk read  side
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam lpAddrWidth   = fBitWidth(pBuffDepth);


//----------------------------------------------------------
// write addr 更新
// 非同期で動作するため、一度グレイコードに変換したものを別CLKでバイナリに復元する必要がある
// そのためグレイコード変換後、別クロックでメタ・ステーブル対策として2段FFで受信しバイナリに変換を行う
//----------------------------------------------------------
reg [lpAddrWidth-1:0] rWA;
reg qWE;

always @(posedge iSrcClk)
begin
    if (iSrcRst)    rWA <= 0;
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

always @*
begin
	qWE <= iWE;
end

//----------------------------------------------------------
// 前回のrpが更新されていたら新規データを出力できる状態と判断する
//----------------------------------------------------------
reg [lpAddrWidth-1:0] rRA, rORP;
reg qRE;

always @(posedge iDstClk)
begin
    if (iDstRst)    rORP <= 0;
    else            rORP <= rRA;

    if (iDstRst)	rRA <= 0;
    else if (qRE)   rRA <= rRA + 1'b1;
    else            rRA <= rRA;
end


//----------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//----------------------------------------------------------
reg rFull;						assign oFLL = rFull;
reg rEmp;						assign oEMP = rEmp;
reg rRVd;						assign oRVD = rRVd;
reg qFull, qEmp, qRVd;
reg [lpAddrWidth-1:0] qWAn [0:5];

always @(posedge iSrcClk)
begin
    if (iSrcRst)    rFull <= 1'b0;
    else            rFull <= qFull;

    if (iSrcRst)    rEmp <= 1'b0;
    else            rEmp <= qEmp;

    if (iDstRst)    rRVd <= 1'b0;
    else            rRVd <= qRVd;
end

always @*
begin
    qWAn[0] <= rWA + 1'b1;
    qWAn[1] <= rWA + 2'd2;
    qWAn[2] <= rWA + 2'd3;
    qWAn[3] <= rWA + 3'd4;
    qWAn[4] <= rWA + 3'd5;
    qWAn[5] <= rWA + 3'd6;
    qFull    <= (qWAn[0] == rRA || qWAn[1] == rRA || qWAn[2] == rRA ||
                 qWAn[3] == rRA || qWAn[4] == rRA || qWAn[5] == rRA);
    qEmp    <= (rWA  == rRA) ;
    qRVd    <= (rRA != rORP);
    qRE     <= iRE & (~qEmp);
end


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