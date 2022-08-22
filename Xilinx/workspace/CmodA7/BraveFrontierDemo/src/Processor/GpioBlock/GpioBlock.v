//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の管理を司るブロック
// 
//----------------------------------------------------------
module GpioBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 'd16
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
// localparam
//----------------------------------------------------------
localparam lpExLedNumber 	= 5;			// 外部 LED の数
localparam lpExLedFlashMode = 2;			// モード数の Bit幅
localparam lpPWMDutyWidth	= (16*2);		// Full Color LED + Single Led, Max 16bit まで
localparam lpIVtimerWidth	= (16*2);		// Duty 比と合わせて Bit幅は 2 の乗数で設定する


//----------------------------------------------------------
// GPIO UNIT
//----------------------------------------------------------
wire [lpExLedNumber-1:0] 	wGpioLedCsr;
wire [lpExLedFlashMode-1:0]	wGpioFlashModeCsr;
wire [pPWMDutyWidth-1:0]	wGpioDutyCsr;
wire [pIVtimerWidth-1:0]	wGpioIVtimerCsr;

GpioUnit #(
	.pExLedNumber	(lpExLedNumber),
	.pExLedFlashMode(lpExLedFlashMode),
	.pPWMDutyWidth	(pPWMDutyWidth),
	.pIVtimerWidth	(pIVtimerWidth)
) GPIO_UNIT (
	.oLed			(oLed),
	.oLedB			(oLedB),
	.oLedG			(oLedG),
	.oLedR			(oLedR),
	.iGpioLed		(wGpioLedCsr),
	.iGpioFlashMode	(wGpioFlashModeCsr),
	.iGpioDuty		(wGpioDutyCsr),
	.iGpioIVtimer	(wGpioIVtimerCsr),
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
	//
	.pExLedNumber	(lpExLedNumber),
	.pExLedFlashMode(lpExLedFlashMode),
	.pPWMDutyWidth	(pPWMDutyWidth),
	.pIVtimerWidth	(pIVtimerWidth)
) GPIO_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiREd		(oSUsiREd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.oGpioLed 		(wGpioLedCsr),
	.oGpioFlashMode	(wGpioFlashModeCsr),
	.oGpioDuty		(wGpioDutyCsr),
	.oGpioIVtimer	(wGpioIVtimerCsr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);



endmodule