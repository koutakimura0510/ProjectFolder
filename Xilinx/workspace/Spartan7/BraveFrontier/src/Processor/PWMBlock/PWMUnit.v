//----------------------------------------------------------
// Create 2022/7/31
// Author koutakimura
// -
// PWM の制御を司るユニット
// 
//----------------------------------------------------------
module PWMUnit #(
	parameter 					pPWMDutyWidth	= 'd16,	// PWM の分解能
	parameter 					pIVtimerWidth	= 'd16	// インターバルタイマ分周値
)(
    // Internal Port
	output						oPwm,
	input 						iPWMEn,
	input 	[pPWMDutyWidth-1:0]	iPWMDuty,
	input 	[pIVtimerWidth-1:0]	iIVtimer,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// PWM インターバルタイマ
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg	("yes"),
	.pDivWidth	(pIVtimerWidth)
) PWM_CKE_GEN (
	.iDiv		(iIVtimer),
	.iCke		(iPWMEn),
	.oCke		(wDivCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);


//----------------------------------------------------------
// PWM Unit
//----------------------------------------------------------
reg 	[pPWMDutyWidth-1:0] rDutyCnt;
reg 	rPwm;							assign oPwm = rPwm;
//
reg		qCntCompare;

always @(posedge iSysClk)
begin
	if (iSysRst) 		rDutyCnt <= {pPWMDutyWidth{1'b0}};
	else if (iPWMEn)	rDutyCnt <= rDutyCnt + wDivCke;
	else 				rDutyCnt <= {pPWMDutyWidth{1'b0}};

	if (qCntCompare)	rPwm <= 1'b1;
	else 				rPwm <= 1'b0;
end

always @*
begin
	qCntCompare <= (iPWMDuty < rDutyCnt);
end
endmodule