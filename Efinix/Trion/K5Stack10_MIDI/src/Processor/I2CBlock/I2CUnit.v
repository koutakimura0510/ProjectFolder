//----------------------------------------------------------
// Create 2022/7/26
// Author koutakimura
// -
// I2C 通信の制御を司るユニット
// 
//----------------------------------------------------------
module I2CUnit #(
	// variable parameter
	parameter 					pI2CDivClk = 16
)(
	// External Port
	output						oI2CScl,
	inout 						ioI2CSda,
    // Internal Port
	input 						iI2CEn,
	input 	[pI2CDivClk-1:0]	iI2CDiv,
	output 	[15:0]				oI2CGetKeyPad,
	output 						oI2CSeqComp,
    // CLK Reset
    input           			iSCLK,
    input           			iSRST
);

//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg	("yes"),
	.pDivWidth	(pI2CDivClk)
) I2CCkeGen (
	.iDiv		(iI2CDiv),
	.iCke		(iI2CEn),
	.oCke		(wDivCke),
	.iClk		(iSCLK),
	.iRst		(iSRST)
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
wire 		wI2CEnMux;

I2CMasterMux I2CMasterMux (
	.oI2CSeqComp	(oI2CSeqComp),
	.oI2CGetKeyPad	(oI2CGetKeyPad),
	.oTriState		(wTriState),
	.oI2CSend		(wSend),
	.oI2CBufLen		(wBufLen),
	.oI2CEn			(wI2CEnMux),
	.iI2CEn			(iI2CEn),
	.iI2CBufVd		(wBufVd),
	.iI2CByteVd		(wByteVd),
	.iSdaByte		(wSdaByte),
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);


//----------------------------------------------------------
// Master I2C 通信信号生成
//----------------------------------------------------------
I2CMaster I2CMaster (
	.oI2CScl		(oI2CScl),
	.ioI2CSda		(ioI2CSda),
	.iDivCke		(wDivCke),
	.iI2CEn			(wI2CEnMux),
	.iTriState		(wTriState),
	.iI2CSend		(wSend),
	.iI2CBufLen		(wBufLen),
	.oI2CBufVd		(wBufVd),
	.oI2CByteVd		(wByteVd),
	.oSdaByte		(wSdaByte),
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);

endmodule