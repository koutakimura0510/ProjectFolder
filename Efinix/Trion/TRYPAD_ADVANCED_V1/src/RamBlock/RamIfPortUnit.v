/**-----------------------------------------------------------------------------
 * 24-01-21 v1.00: new release
 * 24-03-09 v1.10: Video Port に対応
 *-----------------------------------------------------------------------------*/
module RAMIfPortUnit #(
	parameter pRamDqWidth = 16
)(
	// RAM I/F Port
	output	[pRamDqWidth-1:0] 	oRamDq,
	input	[pRamDqWidth-1:0] 	iRamDq,
	output	[1:0]				oRamDq_OE,
	output	[1:0]				oRamClk,
	output	[1:0]				oRamCe,
	// Config Port
	input	[pRamDqWidth-1:0]	iCfgDq,
	input						iCfgClk,
	input						iCfgCs,
	input						iCfgEn,
	// Vtb Port
	input	[pRamDqWidth-1:0]	iVideoDq,
	input						iVideoClk,
	input						iVideoCs,
	input						iVideoOe,
	input						iVideoEn,
	// Mcu Port
	// Memory Test Port
	input	[pRamDqWidth-1:0]	iTestDq,
	input						iTestClk,
	input						iTestCs,
	input						iTestOe,
	input						iTestEn,
	// Read Port
	output	[pRamDqWidth-1:0]	oRamRd,
	output						oRamRe,
	// Control
	input	[7:0]				iMemClkDiv,
	// Clk Reset
	input						iRST,
	input						iCKE,
	input						iCLK
);

/**----------------------------------------------------------------------------
 * External Ram I/F Port
 * 優先度が高いのは Video Port,  Cfg Port は基本起動時に一回のみ行う設定
 * Test Port は、Debug のときや、MCU から RAM のデータ書き換えを行いたいときに使用する。
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0] 	rRamDq,		qRamDq;
reg						rRamClk,	qRamClk;
reg						rRamCs,		qRamCs;
reg						rRamOe,		qRamOe;
//
reg	[pRamDqWidth-1:0]	rRamRd;			assign oRamRd = rRamRd;
reg						rRamRe;			assign oRamRe = rRamRe;
reg						qRamReCke;
reg	[2:0]				rWaitCnt;
reg						qWaitCntCke;
//
reg [7:0]				rDivCnt;
reg						qDivCntMaxCke, qDivCntCke;

always @(posedge iCLK)
begin
	rRamDq	<= qRamDq;
	rRamClk <= qRamClk;
	rRamCs	<= qRamCs;
	rRamOe	<= qRamOe;
	
	if (~rRamClk) 	rRamRd <= iRamDq;
	else			rRamRd <= rRamRd;
	
	if (qRamReCke) 	rRamRe <= 1'b1;
	else			rRamRe <= 1'b0;
	
	if (rRamOe)				rWaitCnt <= 3'd0;			// Quad Read Cmd のとき
	else if (qWaitCntCke)	rWaitCnt <= rWaitCnt + 1'b1;// "6" Cycle Wait が発生する
	else 					rWaitCnt <= rWaitCnt;
	
	if (qDivCntMaxCke)		rDivCnt <=  8'd0;			// 高速CLK で動作しない場合
	else if (qDivCntCke)	rDivCnt <=  rDivCnt + 1'b1; // Division で速度調整する
	else 					rDivCnt <=  rDivCnt;		// "0" で SCLK /2 の速度
end

always @*
begin
	case ({iVideoEn,iTestEn,iCfgEn})
		'b001:		qRamDq <= iCfgDq;
		'b010:		qRamDq <= iTestDq;
		'b100:		qRamDq <= iVideoDq;
		default: 	qRamDq <= iVideoDq;
	endcase
	
	case ({iVideoEn,iTestEn,iCfgEn})
		'b001: 		qRamClk <= iCfgClk;
		'b010: 		qRamClk <= iTestClk;
		'b100: 		qRamClk <= iVideoClk;
		default: 	qRamClk <= iVideoClk;
	endcase
	
	case ({iVideoEn,iTestEn,iCfgEn})
		'b001: 		qRamCs <= iCfgCs;
		'b010: 		qRamCs <= iTestCs;
		'b100: 		qRamCs <= iVideoCs;
		default: 	qRamCs <= iVideoCs;
	endcase
	
	case ({iVideoEn,iTestEn,iCfgEn})
		'b001: 		qRamOe <= 1'b1;
		'b010: 		qRamOe <= iTestOe;
		'b100: 		qRamOe <= iVideoOe;
		default: 	qRamOe <= iVideoOe;
	endcase
	
	qRamReCke		<= &{~qRamCs,~rRamClk,(rWaitCnt == 3'd5),qDivCntMaxCke};
	qWaitCntCke		<= &{~qRamOe,~rRamClk,(rWaitCnt != 3'd5),qDivCntMaxCke};
	qDivCntMaxCke	<= |{iRST,(rDivCnt == iMemClkDiv)};
	qDivCntCke  	<=  (~qRamCs);
end

assign oRamDq	 	= rRamDq;
assign oRamDq_OE[0] = rRamOe;
assign oRamClk[0]	= rRamClk;
assign oRamCe[0]	= rRamCs;
assign oRamDq_OE[1] = rRamOe;
assign oRamClk[1]	= rRamClk;
assign oRamCe[1]	= rRamCs;

endmodule