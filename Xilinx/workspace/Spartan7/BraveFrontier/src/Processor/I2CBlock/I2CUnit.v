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
	output					oI2CScl,
	inout 					ioI2CSda,
    // Internal Port
	input 					iI2CEn,
	input 	[pI2CDivClk:0]	iI2CDiv,
	output 	[15:0]			oI2CGetKeyPad,
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
	.iDiv		(iI2CDiv),
	.iCke		(iI2CEn),
	.oCke		(wDivCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);


//----------------------------------------------------------
// I2C Master の送受信データと GPIO TriState 制御
//----------------------------------------------------------
wire 		wTriState;
wire [7:0]	wSend;
wire [7:0]	wBufLen;
wire 		wBufVd;
wire 		wByteVd;
wire [7:0] 	wSdaByte;

I2CMasterMux I2C_MASTER_MUX (
	.oI2CGetKeyPad	(oI2CGetKeyPad),
	.oTriState		(wTriState),
	.oI2CSend		(wSend),
	.oI2CBufLen		(wBufLen),
	.iI2CBufVd		(wBufVd),
	.iI2CByteVd		(wByteVd),
	.iSdaByte		(wSdaByte),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Master I2C 通信信号生成
//----------------------------------------------------------
I2CMaster I2C_MASTER (
	.oI2CScl		(oI2CScl),
	.ioI2CSda		(ioI2CSda),
	.iDivCke		(wDivCke),
	.iI2CEn			(iI2CEn),
	.iTriState		(wTriState),
	.iI2CSend		(wSend),
	.iI2CBufLen		(wBufLen),
	.oI2CBufVd		(wBufVd),
	.oI2CByteVd		(wByteVd),
	.oSdaByte		(wSdaByte),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

endmodule