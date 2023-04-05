//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の管理を司るブロック
// 
//----------------------------------------------------------
module GpioBlock #(
	// variable
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 16,
	parameter 						pCsrAdrsWidth 	= 8,
	parameter						pCsrActiveWidth = 8,
	// variable csr bit width
	//-----------------------------------------------------------------------------
	// プロジェクトで使用する LED の個数
	//-----------------------------------------------------------------------------
	parameter						pExLedNumber	= 5,

	//-----------------------------------------------------------------------------
	// LED 点灯パターンの種類の数
	//-----------------------------------------------------------------------------
	parameter						pExLedFlashMode	= 2,

	//-----------------------------------------------------------------------------
	// PWM Duty比 Bit幅
	//-----------------------------------------------------------------------------
	parameter						pPWMDutyWidth	= 8,

	//-----------------------------------------------------------------------------
	// インターバルタイマー Bit幅
	//-----------------------------------------------------------------------------
	parameter						pIVtimerWidth	= 32
)(
	// External Port
	output	[1:0]				oLed,
	output 						oLedB,
	output 						oLedG,
	output 						oLedR,
    // Internal Port
	// Bus Slave Read
	output	[31:0]				oSUsiRd,	// Read Data
	output						oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,  // R/W Adrs
	input						iSUsiWCke,	// Write Enable
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// GPIO UNIT
//----------------------------------------------------------
wire [pExLedNumber-1:0] 	wGpioEnCsr;
wire [pExLedFlashMode-1:0]	wGpioFlashModeCsr;
wire [pPWMDutyWidth-1:0]	wGpioDutyRatio0Csr;
wire [pPWMDutyWidth-1:0]	wGpioDutyRatio1Csr;
wire [pPWMDutyWidth-1:0]	wGpioDutyRatio2Csr;
wire [pPWMDutyWidth-1:0]	wGpioDutyRatio3Csr;
wire [pPWMDutyWidth-1:0]	wGpioDutyRatio4Csr;
wire [pIVtimerWidth-1:0]	wGpioIVtimer0Csr;
wire [pIVtimerWidth-1:0]	wGpioIVtimer1Csr;
wire [pIVtimerWidth-1:0]	wGpioIVtimer2Csr;
wire [pIVtimerWidth-1:0]	wGpioIVtimer3Csr;
wire [pIVtimerWidth-1:0]	wGpioIVtimer4Csr;

GpioUnit #(
	.pExLedNumber	(pExLedNumber),
	.pExLedFlashMode(pExLedFlashMode),
	.pPWMDutyWidth	(pPWMDutyWidth),
	.pIVtimerWidth	(pIVtimerWidth)
) GPIO_UNIT (
	.oLed			(oLed),
	.oLedB			(oLedB),
	.oLedG			(oLedG),
	.oLedR			(oLedR),
	.iGpioEn		(wGpioEnCsr),
	.iGpioFlashMode	(wGpioFlashModeCsr),
	.iGpioDutyRatio0(wGpioDutyRatio0Csr),
	.iGpioDutyRatio1(wGpioDutyRatio1Csr),
	.iGpioDutyRatio2(wGpioDutyRatio2Csr),
	.iGpioDutyRatio3(wGpioDutyRatio3Csr),
	.iGpioDutyRatio4(wGpioDutyRatio4Csr),
	.iGpioIVtimer0	(wGpioIVtimer0Csr),
	.iGpioIVtimer1	(wGpioIVtimer1Csr),
	.iGpioIVtimer2	(wGpioIVtimer2Csr),
	.iGpioIVtimer3	(wGpioIVtimer3Csr),
	.iGpioIVtimer4	(wGpioIVtimer4Csr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
GpioCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pCsrAdrsWidth	(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pExLedNumber	(pExLedNumber),
	.pExLedFlashMode(pExLedFlashMode),
	.pPWMDutyWidth	(pPWMDutyWidth),
	.pIVtimerWidth	(pIVtimerWidth)
) GPIO_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiREd		(oSUsiREd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.oGpioEn 		(wGpioEnCsr),
	.oGpioDutyRatio0(wGpioDutyRatio0Csr),
	.oGpioDutyRatio1(wGpioDutyRatio1Csr),
	.oGpioDutyRatio2(wGpioDutyRatio2Csr),
	.oGpioDutyRatio3(wGpioDutyRatio3Csr),
	.oGpioDutyRatio4(wGpioDutyRatio4Csr),
	.oGpioFlashMode	(wGpioFlashModeCsr),
	.oGpioIVtimer0	(wGpioIVtimer0Csr),
	.oGpioIVtimer1	(wGpioIVtimer1Csr),
	.oGpioIVtimer2	(wGpioIVtimer2Csr),
	.oGpioIVtimer3	(wGpioIVtimer3Csr),
	.oGpioIVtimer4	(wGpioIVtimer4Csr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);



endmodule