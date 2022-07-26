//----------------------------------------------------------
// Create 2022/7/25
// Author koutakimura
// -
// I2C の管理を司るブロック
// 
//----------------------------------------------------------
module I2CBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h01,
	parameter						pBusAdrsBit		= 'd31
)(
	// External Port
	output					oI2cScl,
	inout 					ioI2CSda,
    // Internal Port
	// Bus Slave Read
	output	[31:0]			oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output					oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]			iSUsiWd,	// Master からの書き込みデータ
	input	[pBusAdrsBit:0]	iSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input					iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
reg 		qI2CUnitEn;
reg [15:0]	qI2CUnitDiv;
reg [23:0]	qI2CUnitSAdrs;

I2CUnit I2C_UNIT (

);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 		wI2CCsrEn;
wire [15:0]	wI2CCsrDiv;
wire [23:0]	wI2CCsrSAdrs;

I2CCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit)
) I2C_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.iI2CGetKeyPad	(),
	.oI2cEn			(wI2CCsrEn),
	.oI2cDiv		(wI2CCsrDiv),
	.oI2CSAdrs		(wI2CCsrSAdrs),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qI2CUnitEn		<= wI2CCsrEn;
	qI2CUnitDiv		<= wI2CCsrDiv;
	qI2CUnitSAdrs	<= wI2CCsrSAdrs;
end


endmodule