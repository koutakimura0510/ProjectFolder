//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の制御を司るブロック
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
// Csr Space
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

GpioCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pExLedNumber(pExLedNumber),
	.pExLedFlashMode(pExLedFlashMode),
	.pPWMDutyWidth(pPWMDutyWidth),
	.pIVtimerWidth(pIVtimerWidth)
) GPIO_CSR (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oGpioEn(wGpioEnCsr),
	.oGpioDutyRatio0(wGpioDutyRatio0Csr),
	.oGpioDutyRatio1(wGpioDutyRatio1Csr),
	.oGpioDutyRatio2(wGpioDutyRatio2Csr),
	.oGpioDutyRatio3(wGpioDutyRatio3Csr),
	.oGpioDutyRatio4(wGpioDutyRatio4Csr),
	.oGpioFlashMode(wGpioFlashModeCsr),
	.oGpioIVtimer0(wGpioIVtimer0Csr),
	.oGpioIVtimer1(wGpioIVtimer1Csr),
	.oGpioIVtimer2(wGpioIVtimer2Csr),
	.oGpioIVtimer3(wGpioIVtimer3Csr),
	.oGpioIVtimer4(wGpioIVtimer4Csr),
    // CLK RST
	.iSCLK(iSCLK),
	.iSRST(iSRST)
);


//----------------------------------------------------------
// Blink 動作用の Enable信号と、PWM 調光動作用の Duty信号の生成
//----------------------------------------------------------
reg  [pPWMDutyWidth-1:0] 	qGpioDutyRatio	[pExLedNumber-1:0];
reg  [pIVtimerWidth-1:0] 	qGpioIVtimer 	[pExLedNumber-1:0];
reg  [pExLedNumber-1:0]		qDutyEn;
wire [pExLedNumber-1:0] 	wPwm;
wire [pExLedNumber-1:0] 	wDutyCycleCke;
wire [pExLedNumber-1:0] 	wIVCke;
//
genvar i;
//
generate
	for (i = 0; i < pExLedNumber; i = i + 1)
	begin
		DutyGenerator #(
			.pPWMDutyWidth	(pPWMDutyWidth),
			.pIVtimerWidth	(pIVtimerWidth)
		) DUTY_GPIO (
			.oPwm			(wPwm[i]),
			.oDutyCycleCke	(wDutyCycleCke[i]),
			.oIVCke			(wIVCke[i]),
			.iPWMEn			(qDutyEn[i]),
			.iDutyRatio		(qGpioDutyRatio[i]),
			.iIVtimer		(qGpioIVtimer[i]),
			.iCLK			(iSCLK),
			.iRST			(iSRST)
		);

		always @*
		begin
			qDutyEn[i] <= iGpioEn[i] & (iGpioFlashMode[0] | iGpioFlashMode[1]);
		end
	end
endgenerate
//
always @*
begin
	qGpioDutyRatio[0] <= iGpioDutyRatio0;
	qGpioDutyRatio[1] <= iGpioDutyRatio1;
	qGpioDutyRatio[2] <= iGpioDutyRatio2;
	qGpioDutyRatio[3] <= iGpioDutyRatio3;
	qGpioDutyRatio[4] <= iGpioDutyRatio4;
	//
	qGpioIVtimer[0] <= iGpioIVtimer0;
	qGpioIVtimer[1] <= iGpioIVtimer1;
	qGpioIVtimer[2] <= iGpioIVtimer2;
	qGpioIVtimer[3] <= iGpioIVtimer3;
	qGpioIVtimer[4] <= iGpioIVtimer4;
end


//----------------------------------------------------------
// RGB は負論理
//----------------------------------------------------------
localparam [pExLedFlashMode-1:0]
	lpGpioModeDefault 	= 0,	// GpioEn のデータで点灯
	lpGpioModeBlink   	= 1,	// GpioEn のデータで点滅
	lpGpioModePwm		= 2;	// GpioEn のデータで調光
//
reg [pExLedNumber-1:0]	rLed;
//
always @(posedge iSCLK)
begin
	case (iGpioFlashMode)
		lpGpioModeDefault:
		begin
			rLed[0]	<=  iGpioEn[0];
			rLed[1]	<=  iGpioEn[1];
			rLed[2]	<= ~iGpioEn[2];
			rLed[3]	<= ~iGpioEn[3];
			rLed[4]	<= ~iGpioEn[4];
		end

		lpGpioModeBlink:
		begin
			rLed[0]	<= wIVCke[0] ? (~rLed[0] & iGpioEn[0]) : rLed[0];
			rLed[1]	<= wIVCke[1] ? (~rLed[1] & iGpioEn[1]) : rLed[1];
			rLed[2]	<= wIVCke[2] ? (~rLed[2] & iGpioEn[2]) : rLed[2];
			rLed[3]	<= wIVCke[3] ? (~rLed[3] & iGpioEn[3]) : rLed[3];
			rLed[4]	<= wIVCke[4] ? (~rLed[4] & iGpioEn[4]) : rLed[4];
		end

		lpGpioModePwm:
		begin
			rLed[0]	<=  wPwm[0];
			rLed[1]	<=  wPwm[1];
			rLed[2]	<= ~wPwm[2];
			rLed[3]	<= ~wPwm[3];
			rLed[4]	<= ~wPwm[4];
		end

		default:
		begin
			rLed[0]	<= iGpioEn[0];
			rLed[1]	<= iGpioEn[1];
			rLed[2]	<= ~iGpioEn[2];
			rLed[3]	<= ~iGpioEn[3];
			rLed[4]	<= ~iGpioEn[4];
		end
	endcase
end


endmodule