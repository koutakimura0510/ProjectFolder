/*
Create 2022/12/19
Author koutakimura
-
設定によって操作キャラクターのピクセルデータを出力する module
上位 moduel から、HVSyncPos と PlayerPos が一致したときに

*/
module PlayerDraw #(
	parameter								pInitFileName	= "pPlayerTexture.txt"	// 本来は ROM データ書き込みだがデバッグ用に...
	parameter								pColorDepth		= 16,
	parameter								pRamDepth,		= 2048,		// pColorDepth と合わせて 32767Kbit に収まるようにする
	// not
	parameter								pRamAdrsWidth	= fBitWidth(pRamDepth);
	parameter								pRGBBitWidth 	= pColorDepth / 4,		// ARGB 一つの要素の Bit幅
	parameter								pAlphaBitMsb 	= pColorDepth - 1,
	parameter								pAlphaBitLsb 	= pColorDepth - (pColorDepth / 4),
	parameter	[pColorDepth-1:0]			pAlphaNum	 	= 1 << pAlphaBitLsb
)(
	// Pixrl
    output 	[pColorDepth-1:0]    			oPixel,				//
	// OverWrite
	input 	[pColorDepth-1:0]    			iPlayerPixelWd,		// 操作キャラクターの上書き描画データ
	input 									iPlayerPixelWe,		// 上書き時 Assert
	// Status
	input 									iFe,				// frame end
	input 									iPlayerDrawVd,		// 前段からのキャラクター描画タイミングのときに Assert される信号
	input									iSrcEn,				// 他の描画 module の出力準備が整ったら Assert される
	// Csr
	input 	[6:0]							iPDFeUpdateCnt,
	input	[pRamAdrsWidth-1:0]				iPDRadrsNext,
	input 									iPDRst,
	output 									oPDFeCntCke,
	// Clk rst
	input 									iRST,
    input                       			iCLK
);


//-----------------------------------------------------------------------------
// 設定データに基づき、暗転処理を行う。
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pColorDepth-1:0] rPlayerRam [0:pRamDepth-1];	// 分散 RAM は使用しないので MAX 宣言

initial begin
	$readmemh(pInitFileName, rPlayerRam);
end

//-----------------------------------------------------------------------------
// Local Side Rst Gen
//-----------------------------------------------------------------------------
reg	rLocalRst, qLocalRst;

always @(posedge iCLK)
begin
	rLocalRst <= qLocalRst;
end

always @*
begin
	qLocalRst <= |{iPDRst,iRST,iFe};
end

//-----------------------------------------------------------------------------
// R/W アドレスの更新
// 
// ハード面での 複数条件によるアドレス更新処理はロジックを多く消費するため、
// 操作キャラのアニメーション動作時のアドレス切り替えは CPU が FE のカウント、
// 座標位置、キャラの向き情報の CSR 空間を読み取りに行き、更新する処理にした。
// 
//-----------------------------------------------------------------------------
reg [pRamAdrsWidth-1:0] rRadrs, rWadrs;
reg [pRamAdrsWidth-1:0] qRadrsNext;
reg [pColorDepth-1:0]	rRamRd;					assign oPixel = rRamRd;
reg 					qRadrsCke;
//
wire wRadrs = rRadrs + 1'b1;
wire wWadrs = rWadrs + 1'b1;

always @(posedge iCLK)
begin
	// Read
	if (rLocalRst)				rRadrs <= iPDRadrsNext;
	else if (qRadrsCke)			rRadrs <= wRadrs;
	else 						rRadrs <= rRadrs;

	// Write
	if (iPDRst)					rWadrs <= {pRamAdrsWidth{1'b0}};
	else if (iPlayerPixelWe)	rWadrs <= wWadrs;
	else 						rWadrs <= rWadrs;

	// BRAM W/R
	if (iPlayerPixelWe)	rPlayerRam[rWadrs] <= iPlayerPixelWd;
	rRamRd <= rPlayerRam[rRadrs];
end

always @*
begin
	casex ( {iPlayerDrawVd,iSrcEn} )
		'b11: 		qRadrsCke <= 1'b1;
		default: 	qRadrsCke <= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// Fe Count
//-----------------------------------------------------------------------------
reg [5:0] 	rFeCnt = 6'd0;
reg 		rFeCke, qFeCke;				assign oPDFeCntCke = rFeCke;
//
wire wFeCnt = rFeCnt + 1'b1;

always @(posedge iCLK)
begin
	rFeCke <= qFeCke;

	if (qFeCke)		rFeCnt <= 6'd0;
	else if (iFe)	rFeCnt <= wFeCnt;
	else 			rFeCnt <= rFeCnt;
end

always @*
begin
	qFeCke <= (rFeCnt == iPDFeUpdateCnt);
end

endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// MSB の Bitを検出
//-----------------------------------------------------------------------------
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