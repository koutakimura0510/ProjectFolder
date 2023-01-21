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
// 
// 2022-09-19
// oRVd のクロックを DstCLK に修正
// -
// 参考文献
// 非同期FIFO Verilog ->    https://zenn.dev/sk6labo/articles/fd2bb32f6e570e
// 非同期FIFO 概念 ->       http://altmo.html.xdomain.jp/src_01/2017_0110/00.html
// グレイコード ->          http://www5.nkansai.ne.jp/users/khateen/gray-code.html
// 
//----------------------------------------------------------
module fifoDualController #(
    parameter 					pFifoDepth  	= 256,    	// FIFO BRAMのサイズ指定
    parameter 					pFifoBitWidth   = 24,     	// bitサイズ
	parameter					pFullAlMost 	= 6			// 指定値、早く full 出力
)(
    input   [pFifoBitWidth-1:0] iWd,    // write data
    input                       iWe,    	// write enable 有効データ書き込み
    output                      ofull,   	// 最大書き込み時High
    output  [pFifoBitWidth-1:0] oRd,    	// read data
    input                       iRe,    	// read enable
    output                      oRvd,   	// 有効データ出力
    output                      oEmp,   	// バッファ空時High
	//
    input                       iWnRST,	// Active High
    input                       iRnRST,	// Active High
    input                       iWCLK,	// clk write side
    input                       iRCLK 	// clk read  side
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam lpAddrWidth   = fBitWidth(pFifoDepth);


//----------------------------------------------------------
// write addr 更新
// 非同期で動作するため、一度グレイコードに変換したものを別CLKでバイナリに復元する必要がある
// そのためグレイコード変換後、別クロックでメタ・ステーブル対策として2段FFで受信しバイナリに変換を行う
//----------------------------------------------------------
reg [lpAddrWidth-1:0] rWA;
reg qWE;

always @(posedge iWCLK, negedge iWnRST)
begin
    if (!iWnRST)    rWA <= {lpAddrWidth{1'b0}};
    else if (qWE)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
end

always @*
begin
	qWE <= iWe;
end

//----------------------------------------------------------
// 前回のrpが更新されていたら新規データを出力できる状態と判断する
//----------------------------------------------------------
reg [lpAddrWidth-1:0] rRA, rORP;
reg qRE;

always @(posedge iRCLK, negedge iRnRST)
begin
    if (!iRnRST)    rORP <= {lpAddrWidth{1'b0}};
    else            rORP <= rRA;

    if (!iRnRST)	rRA <= {lpAddrWidth{1'b0}};
    else if (qRE)   rRA <= rRA + 1'b1;
    else            rRA <= rRA;
end


//----------------------------------------------------------
// ハンドシェイク信号、read ptrが write ptrを超えないように調整
//----------------------------------------------------------
localparam lpFullAlMost = pFullAlMost + 1;

reg rFull;						assign ofull = rFull;
reg rEmp;						assign oEmp = rEmp;
reg rRVd;						assign oRvd = rRVd;
reg qEmp, qRVd;
reg [pFullAlMost-1:0] qFull;
reg qFullAllmost;
reg [lpAddrWidth-1:0] qWAn [0:pFullAlMost];

always @(posedge iWCLK, negedge iWnRST)
begin
    if (!iWnRST)    rFull <= 1'b0;
    else            rFull <= qFullAllmost;

end

always @(posedge iRCLK, negedge iRnRST)
begin
    if (!iRnRST)    rEmp <= 1'b1;
    else            rEmp <= qEmp;

    if (!iRnRST)    rRVd <= 1'b0;
    else            rRVd <= qRVd;
end
//
integer n;

generate
	always @*
	begin
		for (n = 1; n < lpFullAlMost; n = n + 1)
		begin
			qWAn[n-1]   <= rWA + n;
			qFull[n-1]	<= (qWAn[n-1] == rRA);
		end
		qFullAllmost <= |{qFull};
	end
endgenerate

always @*
begin
    qEmp    <= (rWA  == rRA) || (rWA  == (rRA+1'b1));
    qRVd    <= (rRA != rORP);
    qRE     <= iRe & (~qEmp);
end


//----------------------------------------------------------
// FIFO動作
//----------------------------------------------------------
wire [pFifoBitWidth-1:0] wRD;			assign oRd = wRD;

userFifoDual #(
    .pBuffDepth    (pFifoDepth),
    .pBitWidth     (pFifoBitWidth),
    .pAddrWidth    (lpAddrWidth)
) USER_FIFO_DUAL (
    // write side       read side
    .iWCLK(iWCLK),  	.iRCLK(iRCLK),
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