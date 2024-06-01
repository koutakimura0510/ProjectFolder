/**-----------------------------------------------------------------------------
 * 24-02-05 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module MemoryAccessTester #(
	parameter pRamDqWidth = 16
)(
	// Test Port to Ram Port
	output	[pRamDqWidth-1:0] 	oTestDq,
	output						oTestCs,
	output						oTestClk,
	output						oTestOe,
	input	[pRamDqWidth-1:0] 	iTestRd,
	input						iTestRe,
	// Control, Status
	output						oTestEn,
	output						oTestErr,
	output						oTestDone,
	input						iTestEn,
	// Mcu Memory Side
	input	[pRamDqWidth-1:0]	iMemWd,
	input						iMemWdOe,
	input	[7:0]				iMemWa,
	input						iMemWe,
	output	[pRamDqWidth-1:0]	oMemRd,
	input	[7:0]				iMemRa,
	//
	input	[7:0]				iMemClkDiv,
	// CLK Reset
	input						iRST,
	input						iCLK
);


/**----------------------------------------------------------------------------
 外部 HyperRam のテストアクセスを行う
 MCU 動作手順を下記に示す。
 
  [write pattern]
  ・iRST Assert
  ・iMemW Froup で Memroy にデータ書き込み
  ・Enable Assert
  ・Done Assert
  ・iRST Negate
  
  [read pattern]
  ・iRST Assert
  ・iMemW Froup で Memroy にデータ書き込み
  ・Enable Assert
  ・Done Assert
  ・iRST Negate
  
  ・write cmd = 0x38
  ・read cmd = 0xEB
 *---------------------------------------------------------------------------*/
reg  [pRamDqWidth-1:0]	qTestDq;					assign oTestDq	 = qTestDq;
reg  					rTestCs;					assign oTestCs	 = rTestCs;
reg  					rTestClk;					assign oTestClk	 = rTestClk;
reg  					rTestOe;					assign oTestOe	 = rTestOe;
reg  					rTestEn;					assign oTestEn	 = rTestEn;
//
reg						rTestDone;					assign oTestDone = rTestDone;
reg						qTestDoneCke;
reg						qTestOeCke;
reg						qTestClkCke;
reg						qTestRun;
//
reg [7:0]				rDivCnt;
reg						qDivCntMaxCke, qDivCntCke;

always @(posedge iCLK)
begin
	if (iRST) 				rTestCs <= 1'b1;
	else if (qTestRun) 		rTestCs <= 1'b0;
	else 					rTestCs <= 1'b1;
	
	if (iRST) 				rTestOe <= 1'b1;		// default write
	else if (qTestOeCke)	rTestOe <= 1'b0;		// read switch
	else					rTestOe <= rTestOe;		// 
	
	if (iRST) 				rTestEn <= 1'b0;
	else if (qTestRun) 		rTestEn <= 1'b1;
	else 					rTestEn <= 1'b0;
	
	if (iRST) 				rTestClk <=  1'b0;
	else if (qTestClkCke)	rTestClk <= ~rTestClk;
	else 					rTestClk <=  rTestClk;
	
	if (iRST) 				rTestDone <= 1'b0;
	else if (qTestDoneCke)	rTestDone <= 1'b1;
	else 					rTestDone <= rTestDone;
	
	if (qDivCntMaxCke)		rDivCnt <=  8'd0;
	else if (qDivCntCke)	rDivCnt <=  rDivCnt + 1'b1;
	else 					rDivCnt <=  rDivCnt;
end

always @*
begin
	qTestRun		<= iTestEn    & (~rTestDone);
	qTestClkCke		<= (~rTestCs) &   qDivCntMaxCke;
	qDivCntMaxCke  	<= iRST | (rDivCnt == iMemClkDiv);
	qDivCntCke  	<= (~rTestCs);
end

/**----------------------------------------------------------------------------
 * Mem Write Side
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0]	rWMem	[0:255];
reg [pRamDqWidth-1:0]	rWMemRd;
reg [7:0] 				rWMemRa;
reg						qWMemRaCke;

always @(posedge iCLK)
begin
	if (iMemWe) 	rWMem[iMemWa] 	<= iMemWd;
	rWMemRd	<= rWMem[rWMemRa];
	
	if (iRST)				rWMemRa <= 8'd0;
	else if (qWMemRaCke)	rWMemRa <= rWMemRa + 1'b1;
	else 					rWMemRa <= rWMemRa;
	
end

always @*
begin
	qTestDq			<= rWMemRd;
	qTestOeCke		<= (~iMemWdOe) & (rWMemRa[3:0] == 4'h8) & qWMemRaCke;	// CMD + 6byte adrs == 8cnt
	qWMemRaCke		<= (~rTestCs) & (~rTestClk) & qDivCntMaxCke;
	qTestDoneCke	<= rWMemRa == 8'hff;
end


/**----------------------------------------------------------------------------
 * Mem Read Side
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth:0]		rRMem [0:255];
reg [pRamDqWidth-1:0]	rRMemRd;						assign oMemRd = rRMemRd;
reg	[7:0]				rRMemWa;

always @(posedge iCLK)
begin
	if (iTestRe) rRMem[rRMemWa] <= iTestRd;
	rRMemRd	<= rRMem[iMemRa];
	
	if (iRST)			rRMemWa <= 8'd0;
	else if (iTestRe)	rRMemWa <= rRMemWa + 1'b1;
	else				rRMemWa <= rRMemWa;
end

assign oTestErr	 = 1'b0;	// 24-02-23 現状使用しない

endmodule