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
	input  [pPWMDutyWidth-1:0]		iGpioDuty0,
	input  [pPWMDutyWidth-1:0]		iGpioDuty1,
	input  [pPWMDutyWidth-1:0]		iGpioDuty2,
	input  [pPWMDutyWidth-1:0]		iGpioDuty3,
	input  [pPWMDutyWidth-1:0]		iGpioDuty4,
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
reg [(pPWMDutyWidth * pExLedNumber)-1:0] qGpioDuty;
reg [(pIVtimerWidth * pExLedNumber)-1:0] qGpioIVtimer;
//
wire [pExLedNumber-1:0] wPwm;
wire [pExLedNumber-1:0] wCke;
//
genvar i;

generate
	for (i = 0; i < pExLedNumber; i = i + 1)
	begin
		DutyGenerator #(
			.pPWMDutyWidth	(pPWMDutyWidth),
			.pIVtimerWidth	(pIVtimerWidth)
		) DUTY_GPIO (
			.oPwm			(wPwm[i]),
			.oCke			(wCke[i]),
			.iPWMEn			(iGpioEn[i]),
			.iPWMDuty		(qGpioDuty[		(pPWMDutyWidth * (i+1))-1 : pPWMDutyWidth * i]),
			.iIVtimer		(qGpioIVtimer[	(pIVtimerWidth * (i+1))-1 : pIVtimerWidth * i]),
			.iSysClk		(iSysClk),
			.iSysRst		(iSysRst)
		);
	end
endgenerate

always @*
begin
	qGpioDuty 	 <= {iGpioDuty4, iGpioDuty3, iGpioDuty2, iGpioDuty1, iGpioDuty0};
	qGpioIVtimer <= {iGpioIVtimer4, iGpioIVtimer3, iGpioIVtimer2, iGpioIVtimer1, iGpioIVtimer0};
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
			rLed[0]	<= (iGpioEn[0] & wCke[0]) ? ~rLed[0] : 1'b0;
			rLed[1]	<= (iGpioEn[1] & wCke[1]) ? ~rLed[1] : 1'b0;
			rLed[2]	<= (iGpioEn[2] & wCke[2]) ? ~rLed[2] : 1'b1;
			rLed[3]	<= (iGpioEn[3] & wCke[3]) ? ~rLed[3] : 1'b1;
			rLed[4]	<= (iGpioEn[4] & wCke[4]) ? ~rLed[4] : 1'b1;
		end

		lpGpioModePwm:
		begin
			rLed[0]	<= iGpioEn[0] ? wPwm[0] : 1'b0;
			rLed[1]	<= iGpioEn[1] ? wPwm[1] : 1'b0;
			rLed[2]	<= iGpioEn[2] ? wPwm[2] : 1'b1;
			rLed[3]	<= iGpioEn[3] ? wPwm[3] : 1'b1;
			rLed[4]	<= iGpioEn[4] ? wPwm[4] : 1'b1;
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