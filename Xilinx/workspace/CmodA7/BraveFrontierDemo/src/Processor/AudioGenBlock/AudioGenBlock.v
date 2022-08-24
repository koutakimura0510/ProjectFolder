//----------------------------------------------------------
// Create 2022/8/24
// Author koutakimura
// -
// Audio の管理を司るブロック
// 
//----------------------------------------------------------
module AudioGenBlock #(
	parameter 						pBlockAdrsMap 	= 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h05,
	parameter						pBusAdrsBit		= 32	// 32bit ならば (32-1)31 を指定
)(
	// External Port
	output							oAudioMclk,
    // Internal Port
	// Bus Slave Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


assign oAudioMclk 	= 1'b0;
assign oSUsiRd		= 32'd0;
assign oSUsiREd		= 1'b0;

//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
// wire 							wPWMEnCsr;
// wire 	[lpPWMDutyWidth-1:0]	wPWMDutyCsr;
// wire 	[lpIVtimerWidth-1:0]	wIVtimerCsr;

// PWMUnit #(
// 	.pPWMDutyWidth	(lpPWMDutyWidth),
// 	.pIVtimerWidth	(lpIVtimerWidth)
// ) PWM_UNIT (
// 	.oPwm			(oAudioMclk),
// 	.iPWMEn			(wPWMEnCsr),
// 	.iPWMDuty		(wPWMDutyCsr),
// 	.iIVtimer		(wIVtimerCsr),
// 	.iSysClk		(iSysClk),
// 	.iSysRst		(iSysRst)
// );


// //----------------------------------------------------------
// // Csr space
// //----------------------------------------------------------
// PWMCsr #(
// 	.pBlockAdrsMap	(pBlockAdrsMap),
// 	.pAdrsMap		(pAdrsMap),
// 	.pBusAdrsBit	(pBusAdrsBit),
// 	.pPWMDutyWidth	(lpPWMDutyWidth),
// 	.pIVtimerWidth	(lpIVtimerWidth)
// ) PWM_CSR (
// 	.oSUsiRd		(oSUsiRd),
// 	.oSUsiREd		(oSUsiREd),
// 	.iSUsiWd		(iSUsiWd),
// 	.iSUsiAdrs		(iSUsiAdrs),
// 	.iSUsiWCke		(iSUsiWCke),
// 	.oPWMEn			(wPWMEnCsr),
// 	.oPWMDuty		(wPWMDutyCsr),
// 	.oIVtimer		(wIVtimerCsr),
// 	.iSysClk		(iSysClk),
// 	.iSysRst		(iSysRst)
// );

endmodule