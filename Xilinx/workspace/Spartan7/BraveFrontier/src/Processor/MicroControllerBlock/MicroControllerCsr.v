//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// コントロール・ステータス・レジスタ
// [Write]
// iCke Assert を確認し指定アドレスのレジスタに iWd のデータを書き込む。
// 
// [Read]
// 読み込みの場合はアドレスを変更するだけにする。
// ハンドシェイク信号は用意せずに、iAdrs の入力アドレスに応じて、
// レジスタ値を常時出力しておくことで、アドレス指定後に oRd の値を確認すれば、
// レジスタ値を取得することができる。
// 
// [Latency]
// W/R ともにレイテンシはレジスタ経由のため 1 とする。
// レイテンシによる遅延は上位モジュールが調整することとし、他の Csr と仕様を合わせるとする。
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module MicroControllerCsr #(
	parameter 		pBusWidth	= 8
)(
    // Internal Port
	// Csr Ctl
	input  	[31:0]	iWd,		// Ckeによる手動レジスタ更新時の Write Data
	input  	[ 7:0]	iAdrs,		// R/W アドレス指定
	input 			iCke,		// 有効データ書き込み時 Assert
	output 	[31:0]	oRd,		// Read Data
    // CLK Reset
    input           iSysClk,
    input           iSysRst,
	// Csr
	input  	[pBusWidth:0]	iUsiRdy,
	input	[pBusWidth:0]	iUsiCke,
	input	[31:0]			iUsiRd,
	output 			
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [31:0] 			rMUsiWd;		// Bus 書き込みデータ
reg [31:0] 			rMUsiAdrs;	// Bus 書き込みアドレス
reg [pBusWidth:0] 	rMUsiCke;	// Bus 書き込み Enable 自動で 0クリア
reg [pBusWidth:0] 	rMUsiRdy;	//
reg [31:0] 			rSUsiRd;
reg [pBusWidth:0] 	rSUsiCke;
reg [pBusWidth:0] 	rSUsiRdy;	//
reg [ 8:0] 			qAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		
	end
	else
	begin
		// Usi Write
		rMUsiWd		<= (qAdrs == 9'h100) ? iWd : rMUsiWd;
		rMUsiAdrs	<= (qAdrs == 9'h104) ? iWd : rMUsiAdrs;
		rMUsiCke	<= (qAdrs == 9'h108) ? iWd : 1'b0;		// TODO 自動クリアしたい

		rSUsiGpioRd	<= iSUsiGpioRd; // TODO Slave ブロック名のレジスタ用意
		rSUsiCke	<= iSUsiCke;
		rSUsiRdy	<= iSUsiRdy;

	end
end

always @*
begin
	qAdrs <= {iCke, iAdrs};
end

//----------------------------------------------------------
// Read
//----------------------------------------------------------
reg [31:0] rRd;			assign oRd = rRd;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rRd <= 'h0;
	end
	else
	begin
		case (iAdrs)
			'h00: 		rRd <= rUsiWd;
			'h04: 		rRd <= rUsiAdrs;
			'h08: 		rRd <= rUsiCke;
			'h0c: 		rRd <= rUsiRdy;
			'h10: 		rRd <= rUsiRd;
			default: 	rRd <= rRd;
		endcase
	end
end

endmodule