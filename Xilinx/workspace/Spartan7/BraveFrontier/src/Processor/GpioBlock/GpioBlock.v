//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 汎用 GPIO の操作を司るブロック
// 
//----------------------------------------------------------
module GpioBlock (
	// External Port
	output	[1:0]			oLedEdge,
	output 					oLedClk,
    // Internal Port
	// Bus Slave Read
	output	[31:0]			oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output					oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]			iSUsiWd,	// Master からの書き込みデータ
	input	[31:0]			iSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input					iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// 外部 シフトレジスタ動作
//----------------------------------------------------------
wire [1:0]	wSftEdge;		assign oLedEdge	= wSftEdge;
wire 		wSftClk;		assign oLedClk	= wSftClk;
wire [7:0] 	wGpioEn;
wire [7:0] 	wGpioDiv;

LedSftReg LED_SFT_REG (
	.oSftEdge	(wSftEdge),
	.oSftClk	(wSftClk),
	.iGpioEn	(wGpioEn),
	.iGpioDiv	(wGpioDiv),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
GpioCsr GPIO_CSR (
	.oSUsiRd	(oSUsiRd),
	.oSUsiVd	(oSUsiVd),
	.iSUsiWd	(iSUsiWd),
	.iSUsiAdrs	(iSUsiAdrs),
	.iSUsiWCke	(iSUsiWCke),
	.oGpioEn 	(wGpioEn),
	.oGpioDiv	(wGpioDiv),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);



endmodule