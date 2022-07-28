//----------------------------------------------------------
// Create 2022/7/26
// Author koutakimura
// -
// I2C 通信の制御を司るユニット
// 
//----------------------------------------------------------
module I2CUnit #(
	// variable parameter
	parameter 				pI2CDivClk = 15
)(
	// External Port
	output					oI2cScl,
	inout 					ioI2CSda,
    // Internal Port
	input 					iI2cEn,
	input [pI2CDivClk:0]	iI2cDiv,
	input [23:0]			iI2CSAdrs,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);

//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg	("yes"),
	.pDivWidth	(pI2CDivClk)
) I2C_CKE_GEN (
	.iDiv		(iI2cDiv),
	.oCke		(wDivCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);


//----------------------------------------------------------
// I2C ステートマシン
//----------------------------------------------------------


//----------------------------------------------------------
// Master I2C 通信信号生成
//----------------------------------------------------------

endmodule