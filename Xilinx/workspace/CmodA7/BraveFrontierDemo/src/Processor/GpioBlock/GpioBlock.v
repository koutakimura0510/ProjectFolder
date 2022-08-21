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
	parameter						pBusAdrsBit		= 'd32
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
localparam lpPWMDutyWidth = 16;		// 最大 16bit
localparam lpIVtimerWidth = 16;		// 最大 16bit


//----------------------------------------------------------
// GPIO UNIT
//----------------------------------------------------------
wire [7:0] 	wGpioLedCsr;
wire [3:0] 	wGpioFlashModeCsr;

GpioUnit #(
	.pPWMDutyWidth	(pPWMDutyWidth),
	.pIVtimerWidth	(pIVtimerWidth)
) GPIO_UNIT (
	.oLed			(oLed),
	.oLedB			(oLedB),
	.oLedG			(oLedG),
	.oLedR			(oLedR),
	.iGpioLed		(wGpioLedCsr),
	.iGpioFlashMode	(wGpioFlashModeCsr),
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
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);



endmodule