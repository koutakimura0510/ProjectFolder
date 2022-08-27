//----------------------------------------------------------
// Duty信号生成モジュール
// 
// 2022/8/21
// 指定タイミングで Duty 信号を出力
// 
//----------------------------------------------------------
module DutyGenerator #(
	parameter 					pPWMDutyWidth	= 'd16,	// PWM の分解能
	parameter 					pIVtimerWidth	= 'd16	// インターバルタイマ分周値
)(
    // Internal Port
	output						oPwm,
	output 						oCke,
	input 						iPWMEn,		// PWM 出力 Enable
	input 	[pPWMDutyWidth-1:0]	iPWMDuty,	// Duty 比入力
	input 	[pIVtimerWidth-1:0]	iIVtimer,	// PWM 周期
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// PWM インターバルタイマ
//----------------------------------------------------------
wire wDivCke;					assign oCke = wDivCke;

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
reg [pPWMDutyWidth-1:0] rDutyCnt;
reg 					rPwm;				assign oPwm = rPwm;
//
reg						qCntCompare;

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
