//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の管理を司るブロック
// 2023/04/08 V1.1 USIBの更新版に対応
//----------------------------------------------------------
module GpioBlock #(
	// variable
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	parameter pExLedNumber = 5,	// プロジェクトで使用する LED の個数
	parameter pExLedFlashMode = 2,// LED 点灯パターンの種類の数
	parameter pPWMDutyWidth	= 8,	// PWM Duty比 Bit幅
	parameter pIVtimerWidth	= 32	// インターバルタイマー Bit幅
)(
	// External Port
	output [1:0] oLed,
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
    // CLK Reset
    input  iSCLK,
    input  iSRST
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
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
GpioCsr #(
	.pBlockAdrsWidth	(pBlockAdrsWidth),
	.pAdrsMap		(pAdrsMap),
	.pUsiBusWidth	(pUsiBusWidth),
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
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);



endmodule