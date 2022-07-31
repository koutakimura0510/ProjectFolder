//----------------------------------------------------------
// Create 2022/7/25
// Author koutakimura
// -
// I2C の管理を司るブロック
// 
//----------------------------------------------------------
module I2CBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h04,	
	parameter						pBusAdrsBit		= 'd31	// 32bit ならば (32-1)31 を指定
)(
	// External Port
	output					oI2CScl,
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
// Csr ビット幅
//----------------------------------------------------------
localparam lpI2CDivClk = 15;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
reg 				qI2CUnitEn;
reg [lpI2CDivClk:0]	qI2CUnitDiv;
wire [15:0]			wI2CGetKeyPad;

I2CUnit #(
	.pI2CDivClk		(lpI2CDivClk)
) I2C_UNIT (
	.oI2CScl		(oI2CScl),
	.ioI2CSda		(ioI2CSda),
	.iI2CEn			(qI2CUnitEn),
	.iI2CDiv		(qI2CUnitDiv),
	.oI2CGetKeyPad	(wI2CGetKeyPad),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 					wI2CCsrEn;
wire 	[lpI2CDivClk:0]	wI2CCsrDiv;
reg		[15:0]			qI2CGetKeyPad;

I2CCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pI2CDivClk		(lpI2CDivClk)
) I2C_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.iI2CGetKeyPad	(qI2CGetKeyPad),
	.oI2CEn			(wI2CCsrEn),
	.oI2CDiv		(wI2CCsrDiv),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qI2CUnitEn		<= wI2CCsrEn;
	qI2CUnitDiv		<= wI2CCsrDiv;
	qI2CGetKeyPad	<= wI2CGetKeyPad;
end


endmodule