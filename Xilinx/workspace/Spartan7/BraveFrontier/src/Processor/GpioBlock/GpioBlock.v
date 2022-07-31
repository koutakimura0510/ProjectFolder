//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 汎用 GPIO の操作を司るブロック
// 
//----------------------------------------------------------
module GpioBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 'd31
)(
	// External Port
	output	[1:0]			oLedEdge,
	output 					oLedClk,
    // Internal Port
	// Bus Slave Read
	output	[31:0]			oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output					oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]			iSUsiWd,	// Master からの書き込みデータ
	input	[pBusAdrsBit:0]	iSUsiAdrs,
	input					iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// GPIO UNIT
//----------------------------------------------------------
wire [7:0] 	wGpioLed;
wire [7:0] 	wGpioDiv;

GpioUnit GPIO_UNIT (
	.oSftEdge	(oLedEdge),
	.oSftClk	(oLedClk),
	.iGpioLed	(wGpioLed),
	.iGpioDiv	(wGpioDiv),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
GpioCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit)
) GPIO_CSR (
	.oSUsiRd	(oSUsiRd),
	.oSUsiVd	(oSUsiVd),
	.iSUsiWd	(iSUsiWd),
	.iSUsiAdrs	(iSUsiAdrs),
	.iSUsiWCke	(iSUsiWCke),
	.oGpioLed 	(wGpioLed),
	.oGpioDiv	(wGpioDiv),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);



endmodule