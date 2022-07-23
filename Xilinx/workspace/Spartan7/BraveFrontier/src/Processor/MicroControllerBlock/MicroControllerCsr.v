//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// コントロール・ステータス・レジスタ
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
	parameter 				pBusWidth	= 8
)(
    // Internal Port
	// Csr Manual
	input  	[31:0]			iWd,		// Ckeによる手動レジスタ更新時の Write Data
	input  	[ 7:0]			iAdrs,		// R/W アドレス指定
	input 					iCke,		// 有効データ書き込み時 Assert
	output 	[31:0]			oRd,		// Read Data
	// Csr Auto
	input	[31:0]			iSUsiRd,
	input  	[pBusWidth:0]	iSUsiRdy,
	input	[pBusWidth:0]	iSUsiCke,
	output 			
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst,
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
// Manual R/W Reg
reg [31:0] 			rMUsiWd;	// Bus 書き込みデータ
reg [31:0] 			rMUsiAdrs;	// Bus 書き込みアドレス
reg [pBusWidth:0] 	rMUsiCke;	// Bus 書き込み Enable 自動で 0クリア
// Auto R/W Reg
reg [31:0]			rSUsiGpioRd;	// GPIO ブロック
reg [31:0]			rSUsiPwmRd;		// PWM ブロック
reg [31:0]			rSUsiSpiRd;		// SPI ブロック
reg [31:0]			rSUsiI2cRd;		// I2C ブロック
reg [31:0]			rSUsiPgbRd;		// Pixel Gen Block
reg [31:0]			rSUsiAgbRd;		// Audio Gen Block
reg [31:0]			rSUsiVdamRd;	// Video DMA ブロック
reg [31:0]			rSUsiAdmaRd;	// Audio DMA ブロック
reg [31:0]			rSUsiSramRd;	// PSRAM ブロック
reg [31:0]			rSUsiBusRd;		// USI Bus I/F
// reg [31:0]			rSUsiUfiBusRd;	// Ufi Bus I/F
reg [pBusWidth:0] 	rSUsiCke;		// 指定Bit が Assert されていればデータが書き込まれていると判断
reg [pBusWidth:0] 	rSUsiRdy;		// 指定Bit が Assert されていればデータ書き込み可能と判断
// Access Address
reg [ 8:0] 			qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rMUsiWd			<= 'h0;
		rMUsiAdrs		<= 'h0;
		rMUsiCke		<= 1'b0;
		rMUsiRdy		<= {pBusWidth{1'b1}};
		rSUsiGpioRd		<= 'h0;
		rSUsiPwmRd		<= 'h0;
		rSUsiSpiRd		<= 'h0;
		rSUsiI2cRd		<= 'h0;
		rSUsiPgbRd		<= 'h0;
		rSUsiAgbRd		<= 'h0;
		rSUsiVdamRd		<= 'h0;
		rSUsiAdmaRd		<= 'h0;
		rSUsiSramRd		<= 'h0;
		rSUsiBusRd		<= 'h0;
		rSUsiCke		<= {pBusWidth{1'b0}};
		rSUsiRdy		<= {pBusWidth{1'b0}};
	end
	else
	begin
		// Manual
		rMUsiWd		<= (qCsrAdrs == 9'h100) ? iWd : rMUsiWd;
		rMUsiAdrs	<= (qCsrAdrs == 9'h104) ? iWd : rMUsiAdrs;
		rMUsiCke	<= (qCsrAdrs == 9'h108) ? iWd : rMUsiCke;		// TODO 自動クリアしたい
		// Auto
		rSUsiGpioRd	<= (iSUsiCke[0] == 1'd1) ? iSUsiRd : rSUsiGpioRd;
		rSUsiPwmRd	<= (iSUsiCke[1] == 1'd1) ? iSUsiRd : rSUsiPwmRd;
		rSUsiSpiRd	<= (iSUsiCke[2] == 1'd1) ? iSUsiRd : rSUsiSpiRd;
		rSUsiI2cRd	<= (iSUsiCke[3] == 1'd1) ? iSUsiRd : rSUsiI2cRd;
		rSUsiPgbRd	<= (iSUsiCke[4] == 1'd1) ? iSUsiRd : rSUsiPgbRd;
		rSUsiAgbRd	<= (iSUsiCke[5] == 1'd1) ? iSUsiRd : rSUsiAgbRd;
		rSUsiVdamRd	<= (iSUsiCke[6] == 1'd1) ? iSUsiRd : rSUsiVdamRd;
		rSUsiAdmaRd	<= (iSUsiCke[7] == 1'd1) ? iSUsiRd : rSUsiAdmaRd;
		rSUsiSramRd	<= (iSUsiCke[8] == 1'd1) ? iSUsiRd : rSUsiSramRd;
		rSUsiBusRd	<= (iSUsiCke[9] == 1'd1) ? iSUsiRd : rSUsiBusRd;
		rSUsiCke	<= iSUsiCke;
		rSUsiRdy	<= iSUsiRdy;

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
			'h08: 		rRd <= rMUsiCke;
			'h0c: 		rRd <= rRd;
			'h10: 		rRd <= rRd;			// 空き
			'h14:		rRd <= rSUsiGpioRd;
			'h18:		rRd <= rSUsiPwmRd;
			'h1c:		rRd <= rSUsiSpiRd;
			'h20:		rRd <= rSUsiI2cRd;
			'h24:		rRd <= rSUsiPgbRd;
			'h28:		rRd <= rSUsiAgbRd;
			'h2c:		rRd <= rSUsiVdamRd;
			'h30:		rRd <= rSUsiAdmaRd;
			'h34:		rRd <= rSUsiSramRd;
			'h38:		rRd <= rSUsiBusRd;
			'h3c:		rRd <= rSUsiCke;
			'h40:		rRd <= rSUsiRdy;
			default: 	rRd <= rRd;
		endcase
	end
end

endmodule