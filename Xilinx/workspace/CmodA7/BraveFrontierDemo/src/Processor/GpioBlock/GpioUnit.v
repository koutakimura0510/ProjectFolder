//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// GPIO ポートの制御を司るユニット
// 
//----------------------------------------------------------
module GpioUnit (
	// External port
	output	[1:0]			oLed,
	output 					oLedB,
	output 					oLedG,
	output 					oLedR,
	// Internal Port
	input  [7:0]			iGpioLed,
	input  [3:0]			iGpioFlashMode,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// 点灯パターン
//----------------------------------------------------------
localparam [3:0]
	lpGpioModeDefault 	= 4'h00,	// GpioLed のデータで点灯
	lpGpioModeBlink   	= 4'h01,	// GpioLed のデータで点滅
	lpGpioModeOrder		= 4'h02,	// 自動で順番に点灯
	lpGpioModePwm		= 4'h03;	// 自動でランダムに調光


//----------------------------------------------------------
// 
//----------------------------------------------------------
reg [1:0]	rLed;
reg 		rLedB, rLedG, rLedR;
//
always @(posedge iSysClk)
begin
	if (iSysRst) 	rLed <= 2'd0;
	else 			rLed <= iGpioLed[1:0];

	if (iSysRst) 	rLed <= 1'd0;
	else 			rLed <= iGpioLed[1:0];

	case (iGpioFlashMode)
		lpGpioModeDefault:
		lpGpioModeBlink:
		lpGpioModeOrder:
		lpGpioModePwm:
		default: 
	endcase
end


generate
	DutyGenerator #(
		.pPWMDutyWidth	(pPWMDutyWidth),
		.pIVtimerWidth	(pIVtimerWidth)
	) DUTY_GPIO (
		.oPwm			(oPwm),
		.iPWMEn			(iPWMEn),
		.iPWMDuty		(iPWMDuty),
		.iIVtimer		(iIVtimer),
	);
endgenerate


//----------------------------------------------------------
// ポート接続
//----------------------------------------------------------
OBUF GPIO_SFT_CLK 	(.O (oLed),	  .I (rLed));
OBUF GPIO_SFT_AND1 	(.O (oLedB),  .I (rLedB));
OBUF GPIO_SFT_AND2 	(.O (oLedG),  .I (rLedG));
OBUF GPIO_SFT_AND2 	(.O (oLedR),  .I (rLedR));




endmodule