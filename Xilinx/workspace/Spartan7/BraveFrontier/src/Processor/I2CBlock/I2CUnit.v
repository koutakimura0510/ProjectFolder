//----------------------------------------------------------
// Create 2022/7/26
// Author koutakimura
// -
// I2C 通信の制御を司るユニット
// 
//----------------------------------------------------------
module I2CUnit (
	// External Port
	output					oI2cScl,
	inout 					ioI2CSda,
    // Internal Port
	input 					iI2cEn,
	input [15:0] 			iI2cDiv,
	input [23:0]			iI2CSAdrs,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);



endmodule