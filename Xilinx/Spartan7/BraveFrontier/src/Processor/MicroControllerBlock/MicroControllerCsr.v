//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// Master コントロール・ステータス・レジスタ
// [Write]
// iCke Assert を確認し指定アドレスのレジスタに iWd のデータを書き込む。
// バス経由をしない手動レジスタ更新は、CSR の上位モジュールが直接管理を行う
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
	parameter 		pBusSlaveConnectWidth	= 8,
	parameter		pBusAdrsBit				= 16
)(
    // Internal Port
	// Csr Manual
	input  	[31:0]						iWd,		// Ckeによる手動レジスタ更新時の Write Data
	input  	[ 7:0]						iAdrs,		// R/W アドレス指定
	input 								iCke,		// 有効データ書き込み時 Assert
	output 	[31:0]						oRd,		// Read Data
	// Csr Slave
	input	[31:0]						iMUsiRd,
	input  	[pBusSlaveConnectWidth:0]	iMUsiREd,
	// Csr Master
	output	[31:0]						oMUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,
	output								oMUsiWEd,	// コマンド有効時 Assert
	// Csr Output
	output	[31:0]						oMUsiRd,
	output	[pBusSlaveConnectWidth:0]	oMUsiREd,
    // CLK Reset
    input           					iSysClk,
    input           					iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
// Manual
reg [31:0] 						rMUsiWd;		assign oMUsiWd   = rMUsiWd;		// Bus 書き込みデータ
reg [pBusAdrsBit-1:0]			rMUsiAdrs;		assign oMUsiAdrs = rMUsiAdrs;	// Bus 書き込みアドレス
reg [ 0:0]		 				rMUsiWEd;		assign oMUsiWEd = rMUsiWEd;	// Bus 書き込み Enable 自動で 0クリア
// Auto
reg [31:0]						rMUsiRd;		assign oMUsiRd	 = rMUsiRd;		// 
reg [pBusSlaveConnectWidth:0] 	rMUsiREd;		assign oMUsiREd	 = rMUsiREd;		// 指定Bit が Assert されていればデータ書き込み可能と判断
// Access Address
reg [ 8:0] 						qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rMUsiWd		<= 'h0;
		rMUsiAdrs	<= {pBusAdrsBit{1'b0}};
		rMUsiWEd	<= 1'b0;
		rMUsiRd		<= 'h0;
		rMUsiREd		<= {pBusSlaveConnectWidth{1'b0}};
	end
	else
	begin
		// Manual
		rMUsiWd		<= (qCsrAdrs == 9'h100) ? iWd : rMUsiWd;
		rMUsiAdrs	<= (qCsrAdrs == 9'h104) ? iWd[pBusAdrsBit-1:0] : rMUsiAdrs;
		rMUsiWEd	<= (qCsrAdrs == 9'h108) ? iWd[0] : rMUsiWEd;		// TODO 自動クリアしたい
		// Auto
		rMUsiRd		<= iMUsiRd;
		rMUsiREd		<= iMUsiREd;

		// Ufi 
		// rSUfiBusRd	<= iSUfiBusRd;
		// rSUfiCke	<= iSUfiCke;
		// rSUfiRdy	<= iSUfiRdy;
	end
end

always @*
begin
	qCsrAdrs <= {iCke, iAdrs};
end

//----------------------------------------------------------
// Csr Read
// この Read データはプロセッサに入力する
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
			'h00: 		rRd <= rMUsiWd;
			'h04: 		rRd <= rMUsiAdrs;
			'h08: 		rRd <= rMUsiWEd;
			default: 	rRd <= rRd;
		endcase
	end
end

endmodule