//----------------------------------------------------------
// Duty信号生成モジュール
// 
// 2022-08-21 指定タイミングで Duty 信号を出力
// 2022-08-27 Duty カウンターを 1周期カウントしたら Cke 信号を出力するように変更
//----------------------------------------------------------
module DutyGenerator #(
	parameter 					pPWMDutyWidth	= 8,	// PWM の分解能
	parameter 					pIVtimerWidth	= 32	// インターバルタイマ分周値
)(
    // Internal Port
	output						oPwm,
	output 						oDutyCycleCke,	// Duty Counter 1Cycle カウント完了割り込み信号
	output 						oIVCke,			// インターバルタイマーの Enable 信号出力、基本使用しない
	input 						iPWMEn,			// PWM 出力 Enable
	input 	[pPWMDutyWidth-1:0]	iPWMDuty,		// Duty 比入力
	input 	[pIVtimerWidth-1:0]	iIVtimer,		// PWM 周期
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// PWM インターバルタイマ
//----------------------------------------------------------
wire wDivCke;					assign oIVCke = wDivCke;

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
// PWM Logic
//----------------------------------------------------------
localparam [pPWMDutyWidth-1:0] lpDutyCycleMax = {pPWMDutyWidth{1'b1}};	// PWM Counter 最大値
//
reg [pPWMDutyWidth-1:0] rDutyCnt;
reg 					rPwm;				assign oPwm = rPwm;							// PWM信号
reg 					rDutyCycleCke;		assign oDutyCycleCke = rDutyCycleCke;		// 1周期カウント時 Assert
reg						qCntCompare;
reg						qDutyCycleCke;

always @(posedge iSysClk)
begin
	if (iSysRst) 			rDutyCnt <= {pPWMDutyWidth{1'b0}};
	else if (iPWMEn)		rDutyCnt <= rDutyCnt + wDivCke;
	else 					rDutyCnt <= {pPWMDutyWidth{1'b0}};

	if (iSysRst) 			rDutyCycleCke <= 1'b0;
	else if (qDutyCycleCke)	rDutyCycleCke <= 1'b1;
	else 					rDutyCycleCke <= 1'b0;

	if (iSysRst)			rPwm <= 1'b0;
	else if (qCntCompare)	rPwm <= 1'b1;
	else 					rPwm <= 1'b0;
end

always @*
begin
	qDutyCycleCke 	<= (rDutyCnt == lpDutyCycleMax);
	qCntCompare 	<= (iPWMDuty < rDutyCnt) & iPWMEn;
end

endmodule
