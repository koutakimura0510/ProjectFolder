//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// [Write]
// Master から受信する iSUsiWCke を確認し指定アドレスのレジスタに iSUsiWd のデータを書き込む。
// 
// [Read]
// 読み込みの場合はアドレスを変更するだけにする。
// ハンドシェイク信号は用意せずに、iSUsiAdrs の入力アドレスに応じて、
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
module GpioCsr (
    // Internal Port
	// Csr Read
	output	[31:0]			oSUsiRd,
	output 					oSUsiVd,
	// Csr Write
	input	[31:0]			iSUsiWd,	// 書き込みデータ
	input	[31:0]			iSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 {29: 0} アドレス入力
	input					iSUsiWCke,	// コマンド有効時 Assert
	// Csr Output
	output 	[7:0]			oGpioEn,
	output 	[7:0]			oGpioDiv,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [ 7:0]		rGpioEn;		assign oGpioEn  = rGpioEn;	// 汎用 GPIO ON/OFF 制御
reg [ 7:0]		rGpioDiv;		assign oGpioDiv = rGpioDiv;	// 汎用 GPIO 動作周波数
reg [32:0]		qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioEn		<= 8'hff;
		rGpioDiv	<= 8'h5;	// default 50MHz / 5 = 10MHz
	end
	else
	begin
		{rGpioDiv, rGpioEn}	<= (qCsrAdrs == 33'h1_0000_0100) ? iSUsiWd[15:0] : {rGpioDiv, rGpioEn};
	end
end

always @*
begin
	qCsrAdrs <= {iSUsiWCke, iSUsiAdrs};
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;
reg 			rSUsiVd;		assign oSUsiVd = rSUsiVd;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
		rSUsiVd <= 1'b0;
	end
	else
	begin
		case (iSUsiAdrs[15:0])
			'h0100:		{rSUsiVd, rSUsiRd} <= {1'd1, 16'd0, rGpioDiv, rGpioEn};
			default: 	{rSUsiVd, rSUsiRd} <= {1'd0, iSUsiWd};
		endcase
	end
end

endmodule