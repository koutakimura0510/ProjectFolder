//----------------------------------------------------------
// Create 2022/7/31
// Author koutakimura
// -
// PWM の管理を司るブロック
// 
//----------------------------------------------------------
module PWMBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h02,
	parameter						pBusAdrsBit		= 'd32	// 32bit ならば (32-1)31 を指定
)(
	// External Port
	output						oPwm,
    // Internal Port
	// Bus Slave Read
	output	[31:0]				oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output						oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Master からの書き込みデータ
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,
	input						iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpPWMDutyWidth = 10;	// Duty比の分解能
localparam lpIVtimerWidth = 10;	// PWM インターバルタイマの分周値


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
wire 							wPWMEnCsr;
wire 	[lpPWMDutyWidth-1:0]	wPWMDutyCsr;
wire 	[lpIVtimerWidth-1:0]	wIVtimerCsr;

PWMUnit #(
	.pPWMDutyWidth	(lpPWMDutyWidth),
	.pIVtimerWidth	(lpIVtimerWidth)
) PWM_UNIT (
	.oPwm			(oPwm),
	.iPWMEn			(wPWMEnCsr),
	.iPWMDuty		(wPWMDutyCsr),
	.iIVtimer		(wIVtimerCsr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
PWMCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pPWMDutyWidth	(lpPWMDutyWidth),
	.pIVtimerWidth	(lpIVtimerWidth)
) PWM_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.oPWMEn			(wPWMEnCsr),
	.oPWMDuty		(wPWMDutyCsr),
	.oIVtimer		(wIVtimerCsr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

endmodule