//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// GPIO ポートの制御を司るユニット
// 
//----------------------------------------------------------
module GpioUnit #(
	// Variable
	parameter 						pExLedNumber	= 5,
	parameter 						pExLedFlashMode	= 2,
	parameter 						pPWMDutyWidth	= 8,
	parameter 						pIVtimerWidth	= 16
)(
	// External port
	output	[1:0]					oLed,
	output 							oLedB,
	output 							oLedG,
	output 							oLedR,
	// Internal Port
	input  [pExLedNumber-1:0]		iGpioEn,
	input  [pExLedFlashMode-1:0]	iGpioFlashMode,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer0,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer1,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer2,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer3,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer4,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// タイマー信号生成
//----------------------------------------------------------
reg [pPWMDutyWidth-1:0] rGpioDuty 		[pExLedNumber-1:0];
reg [pIVtimerWidth-1:0] qGpioIVtimer 	[pExLedNumber-1:0];
reg [pExLedNumber-1:0] qDutyEn;
//
wire [pExLedNumber-1:0] wPwm;
wire [pExLedNumber-1:0] wDutyCycleCke;
wire [pExLedNumber-1:0] wIVCke;
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
			.iPWMDuty		(rGpioDuty[i]),
			.iIVtimer		(qGpioIVtimer[i]),
			.iSysClk		(iSysClk),
			.iSysRst		(iSysRst)
		);

		always @(posedge iSysClk)
		begin
			if (iSysRst) 				rGpioDuty[i] <= {pPWMDutyWidth{1'b0}};
			else if (wDutyCycleCke[i])	rGpioDuty[i] <= rGpioDuty[i] + 1'b1;
			else 						rGpioDuty[i] <= rGpioDuty[i];
		end

		always @*
		begin
			qDutyEn[i] <= iGpioEn[i] & (iGpioFlashMode[0] | iGpioFlashMode[1]);
		end
	end
endgenerate
//
always @*
begin
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
always @(posedge iSysClk)
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

//----------------------------------------------------------
// ポート接続
//----------------------------------------------------------
OBUF GPIO_LED1 	(.O (oLed[0]),.I (rLed[0]));
OBUF GPIO_LED2 	(.O (oLed[1]),.I (rLed[1]));
OBUF GPIO_LED_R	(.O (oLedR),  .I (rLed[2]));
OBUF GPIO_LED_G	(.O (oLedG),  .I (rLed[3]));
OBUF GPIO_LED_B	(.O (oLedB),  .I (rLed[4]));

endmodule