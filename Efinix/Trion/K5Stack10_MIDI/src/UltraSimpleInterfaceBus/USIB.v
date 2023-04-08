/**-----------------------------------------------------------------------------
 * Create  2023/04/07
 * Author  KoutaKimura
 * -
 * 汎用バスシステム I/F
 * Master が Slaveの各ブロックにある CSRに R/W を行う。
 * アドレスポートに、データ・アドレスが有効であることを示す Bitと、R/W を判定する Bit を持つ。
 *
 *-----------------------------------------------------------------------------*/
module USIB #(
	// variable parameter
	parameter pBlockConnectNum = 2,	// UsiBus 接続ブロック数
	parameter pUsiBusWidth = 32,	// UsiBus 幅
	parameter pCsrAdrsWidth = 16,	// 各ブロック共通の基本CSR幅
	// not variable parameter
	parameter pBlockAdrsWidth = 3,
	parameter pSUsibWidth = pUsiBusWidth * pBlockConnectNum
)(
	// Bus Master Read
	input	[pSUsibWidth-1:0]	iSUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	output	[pUsiBusWidth-1:0]	oMUsiRd,
	// Bus Master Write
	input 	[pUsiBusWidth-1:0]	iMUsiWd,	// Write Data
	input 	[pUsiBusWidth-1:0]	iMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd / {29:21} 未実装 / {20:16} Busアドレス / {15:0} Csrアドレス
	output	[pUsiBusWidth-1:0]	oSUsiWd,
	output	[pUsiBusWidth-1:0]	oSUsiAdrs,
    // CLK Reset
    input	iSRST,
    input	iSCLK 
);

//----------------------------------------------------------
// バスクロックで バス経由データ保存
//----------------------------------------------------------
genvar x;
reg  [pUsiBusWidth-1:0]		rMUsiWd;				assign oSUsiWd		= rMUsiWd;
reg  [pUsiBusWidth-1:0]		rMUsiAdrs;				assign oSUsiAdrs	= rMUsiAdrs;
reg	 [pUsiBusWidth-1:0]		rSUsiRd;				assign oMUsiRd		= rSUsiRd;
wire [pUsiBusWidth-1:0]		wSUsiRd[pBlockConnectNum-1:0];
reg  [pBlockAdrsWidth-1:0]	qBusAdrs;

always @(posedge iSCLK)
begin
	rMUsiWd 	<= iMUsiWd;

	if (iSRST) 	rMUsiAdrs 	<= {pUsiBusWidth{1'b0}};
	else 		rMUsiAdrs 	<= iMUsiAdrs;

	rSUsiRd <= wSUsiRd[qBusAdrs];
end

// アドレスのインデックス参照で取得しやすいように
// Read Dataをデータ幅で分解し二次元配列に保存
generate
	for (x = 0; x < pBlockConnectNum; x = x + 1)
	begin
		assign wSUsiRd[x] = iSUsiRd[((x+1)*32)-1:x*32];
	end
endgenerate

always @*
begin
	qBusAdrs <= iMUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:pCsrAdrsWidth];
end

endmodule