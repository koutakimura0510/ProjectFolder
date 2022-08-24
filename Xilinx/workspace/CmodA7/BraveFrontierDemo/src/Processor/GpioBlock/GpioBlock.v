//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の管理を司るブロック
// 
//----------------------------------------------------------
module GpioBlock #(
	// variable
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 'd16,
	// variable csr bit width
	parameter						pExLedNumber	= 5,
	parameter						pExLedFlashMode	= 2,
	parameter						pPWMDutyWidth	= 16,
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
wire [pPWMDutyWidth-1:0]	wGpioDuty0Csr;
wire [pPWMDutyWidth-1:0]	wGpioDuty1Csr;
wire [pPWMDutyWidth-1:0]	wGpioDuty2Csr;
wire [pPWMDutyWidth-1:0]	wGpioDuty3Csr;
wire [pPWMDutyWidth-1:0]	wGpioDuty4Csr;
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
	.iGpioDuty0		(wGpioDuty0Csr),
	.iGpioDuty1		(wGpioDuty1Csr),
	.iGpioDuty2		(wGpioDuty2Csr),
	.iGpioDuty3		(wGpioDuty3Csr),
	.iGpioDuty4		(wGpioDuty4Csr),
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
	//
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
	.oGpioFlashMode	(wGpioFlashModeCsr),
	.oGpioDuty0		(wGpioDuty0Csr),
	.oGpioDuty1		(wGpioDuty1Csr),
	.oGpioDuty2		(wGpioDuty2Csr),
	.oGpioDuty3		(wGpioDuty3Csr),
	.oGpioDuty4		(wGpioDuty4Csr),
	.oGpioIVtimer0	(wGpioIVtimer0Csr),
	.oGpioIVtimer1	(wGpioIVtimer1Csr),
	.oGpioIVtimer2	(wGpioIVtimer2Csr),
	.oGpioIVtimer3	(wGpioIVtimer3Csr),
	.oGpioIVtimer4	(wGpioIVtimer4Csr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);



endmodule