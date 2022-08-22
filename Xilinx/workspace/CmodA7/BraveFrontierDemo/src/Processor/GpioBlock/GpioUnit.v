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
	parameter 						pPWMDutyWidth	= 16,
	parameter 						pIVtimerWidth	= 16,
)(
	// External port
	output	[1:0]					oLed,
	output 							oLedB,
	output 							oLedG,
	output 							oLedR,
	// Internal Port
	input  [pExLedNumber-1:0]		iGpioLed,
	input  [pExLedFlashMode-1:0]	iGpioFlashMode,
	input  [pPWMDutyWidth-1:0]		iGpioDuty,
	input  [pIVtimerWidth-1:0]		iGpioIVtimer,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// タイマービット幅
//----------------------------------------------------------
localparam lpPWMDutyWidth = pPWMDutyWidth / 2;
localparam lpIVtimerWidth = pIVtimerWidth / 2;


//----------------------------------------------------------
// Duty信号生成
//----------------------------------------------------------

wire [1:0] wPwm;
//
genvar i;

generate
	for (i = 0; i < 2; i = i + 1)
	begin
		DutyGenerator #(
			.pPWMDutyWidth	(lpPWMDutyWidth),
			.pIVtimerWidth	(lpIVtimerWidth)
		) DUTY_GPIO (
			.oPwm			(wPwm[i]),
			.iPWMEn			(1'b1),
			.iPWMDuty		(iGpioDuty[(lpPWMDutyWidth << i)-1 : lpPWMDutyWidth * i]),
			.iIVtimer		(iGpioIVtimer[(lpIVtimerWidth << i)-1 : lpIVtimerWidth * i]),
			.iSysClk		(iSysClk),
			.iSysRst		(iSysRst)
		);
	end
endgenerate


//----------------------------------------------------------
// RGB は負論理
//----------------------------------------------------------
localparam [pExLedFlashMode-1:0]
	lpGpioModeDefault 	= 0,	// GpioLed のデータで点灯
	lpGpioModeBlink   	= 1,	// GpioLed のデータで点滅
	lpGpioModePwm		= 2;	// GpioLed のデータで調光
//
reg [pExLedNumber-1:0]	rLed;
//
always @(posedge iSysClk)
begin
	case (iGpioFlashMode)
		lpGpioModeDefault:
		begin
			rLed 	<= iGpioLed;
		end

		lpGpioModeBlink:
		begin
			rLed[0]	<= iGpioLed[0] ? ~rLed[0] : 1'b0;
			rLed[1]	<= iGpioLed[1] ? ~rLed[1] : 1'b0;
			rLed[2]	<= iGpioLed[2] ? ~rLed[2] : 1'b1;
			rLed[3]	<= iGpioLed[3] ? ~rLed[3] : 1'b1;
			rLed[4]	<= iGpioLed[4] ? ~rLed[4] : 1'b1;
		end

		lpGpioModePwm:
		begin
			rLed[0]	<= iGpioLed[0] ? wPwm[0] : 1'b0;
			rLed[1]	<= iGpioLed[1] ? wPwm[1] : 1'b0;
			rLed[2]	<= iGpioLed[2] ? wPwm[1] : 1'b1;
			rLed[3]	<= iGpioLed[3] ? wPwm[0] : 1'b1;
			rLed[4]	<= iGpioLed[4] ? wPwm[1] : 1'b1;
		end

		default:
		begin
			rLed 	<= iGpioLed;
		end
	endcase
end

//----------------------------------------------------------
// ポート接続
//----------------------------------------------------------
OBUF GPIO_LED 	(.O (oLed[0]),.I (rLed[0]));
OBUF GPIO_LED 	(.O (oLed[1]),.I (rLed[1]));
OBUF GPIO_LED_R	(.O (oLedR),  .I (rLed[2]));
OBUF GPIO_LED_G	(.O (oLedG),  .I (rLed[3]));
OBUF GPIO_LED_B	(.O (oLedB),  .I (rLed[4]));

endmodule