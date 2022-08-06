//----------------------------------------------------------
// Create 2022/8/3
// Author koutakimura
// -
// SPI 通信の制御を司るユニット
// 
//----------------------------------------------------------
module SPIUnit #(
	// variable parameter
	parameter 				pDivClk = 16
)(
	// External Port
    inout	          		ioSpiSck,
    inout           		ioSpiMiso,
    inout           		ioSpiMosi,
    inout           		ioSpiWp,
    inout           		ioSpiHold,
    output          		oSpiConfigCs,
    input	          		ioSpiCs1,
    input	          		ioSpiCs2,
    // Internal Port
	input 					iSPIEn;
	input 	[lpDivClk-1:0]	iSPIDiv;
	input 	[31:0]			iSPIDeviceAdrs;
	input 	[11:0]			iSPINeglength;
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
	.pDivWidth	(pDivClk)
) I2C_CKE_GEN (
	.iCke		(iSPIEn),
	.iDiv		(iSPIDiv),
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
// SPI 通信信号生成
//----------------------------------------------------------
SPISignal SPI_SIGNAL (
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