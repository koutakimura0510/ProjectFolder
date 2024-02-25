/**-----------------------------------------------------------------------------
 * 24-02-05 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module MemoryAccessTester #(
	parameter pRamDqWidth = 16
)(
	// Test Port to Ram Port
	output	[pRamDqWidth-1:0] 	oTestDq,
	input	[pRamDqWidth-1:0] 	iTestDq,
	output						oTestCs,
	output						oTestClk,
	output						oTestOe,
	// Control, Status
	output						oTestEn,
	output						oTestErr,
	output						oTestDone,
	input						iTestRwSel, // "0" W, "1" R
	input						iTestEn,
	// Memory Dq Read
	input	[9:0]				iMemRa,
	output	[pRamDqWidth-1:0]	oMemRd,
	// CLK Reset
    input  						iRST,
    input  						iCLK
);


/**----------------------------------------------------------------------------
 外部 HyperRam のテストアクセスを行う
 MCU からのロジック設定順序を下記に記す。
  Core Rst Assert
  Cmd Set
  Test Enable
  Core Rst Negate
  
 *---------------------------------------------------------------------------*/
reg  [pRamDqWidth-1:0]	rTestDq;					assign oTestDq	 = rTestDq;
reg  					rTestCs;					assign oTestCs	 = rTestCs;
reg  					rTestClk;					assign oTestClk	 = rTestClk;
reg  					rTestOe;					assign oTestOe	 = rTestOe;
reg  					rTestEn;					assign oTestEn	 = rTestEn;
//
reg						rTestDone;					assign oTestDone = rTestDone;
reg						qTestDoneCke;
reg  [pRamDqWidth-1:0]	qTestDq;
reg						qTestOe

always @(posedge iCLK)
begin
	if (iRST) 				rTestDq <=  16'd0;
	else if (qTestCke) 		rTestDq <=  qTestDq;
	else 					rTestDq <=  rTestDq;
	
	if (iRST) 				rTestCs <= 1'b1;
	else if (qTestRun) 		rTestCs <= 1'b0;
	else 					rTestCs <= 1'b1;
	
	if (iRST) 				rTestOe <= 1'b0;		// default read
	else 					rTestOe <= qTestOe;
	
	if (iRST) 				rTestEn <= 1'b0;
	else if (qTestRun) 		rTestEn <= 1'b1;
	else 					rTestEn <= 1'b0;
	
	if (iRST) 				rTestClk <=  1'b0;
	else if (qTestClkCke)	rTestClk <= ~rTestClk;
	else 					rTestClk <=  rTestClk;
	
	if (iRST) 				rTestDone <= 1'b0;
	else if (qTestDoneCke)	rTestDone <= 1'b1;
	else 					rTestDone <= rTestDone;
end

always @*
begin
	qTestCke 		<= iTestEn & rTestClk;
	qTestRun		<= iTestEn & (~rTestDone);
	qTestClkCke		<= ~rTestCs;
end

/**----------------------------------------------------------------------------
 * State Machine
 *---------------------------------------------------------------------------*/
localparam [2:0]
	lpCmd1 = 0,
	lpCmd2 = 1,
	lpAdrs = 2,
	lpWait = 3,
	lpData = 4;

reg [2:0] 	rSt;
reg			qStNextCke;
reg	[15:0]	rStCnt;
reg			qStCntRst,	qStCntCke;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt	<= lpCmd1;
	end
	else
	begin
		case (rSt)
			lpCmd1:		rSt <= qStNextCke ? lpCmd2 : lpCmd1; 
			lpCmd2:		rSt <= qStNextCke ? lpAdrs : lpCmd2; 
			lpAdrs:		rSt <= qStNextCke ? iTestRwSel ? lpWait : lpData : lpAdrs; 
			lpWait:		rSt <= qStNextCke ? lpData : lpAdrs; 
			lpData:		rSt <= qStNextCke ? lpCmd1 : lpData; 
			default:	rSt <= lpCmd1; 
		endcase
	end
	
	if (qStCntRst)		rStCnt <= 16'd0;
	else if (qStCntCke)	rStCnt <= rStCnt + 1'b1;
	else				rStCnt <= rStCnt;
end

always @*
begin
	case (rSt)
		lpCmd1:		qTestDq <= iTestRwSel ? 16'hEEEE : 16'h3333;
		lpCmd2:		qTestDq <= iTestRwSel ? 16'hBBBB : 16'h8888;
		lpAdrs:		qTestDq <= 16'd0;
		lpData:		qTestDq <= rStCnt;
		default:	qTestDq <= 16'd0;
	endcase
	
	casex ({rSt,qStCntCke,(rStCnt==16'd1024),(rStCnt==16'd6),(rStCnt==16'd1)})
		{lpCmd1,1'b1,3'bxx1}:	qStNextCke <= 1'b1;	// Quad Mode W="3", R="E" を送信
		{lpCmd2,1'b1,3'bxx1}:	qStNextCke <= 1'b1;	// Quad Mode W="8", R="B" を送信
		{lpAdrs,1'b1,3'bx1x}:	qStNextCke <= 1'b1;	// Max 64Mbit=A[22:0], 6byte
		{lpWait,1'b1,3'bx1x}:	qStNextCke <= 1'b1;	// Quad Mode W="0", R="6" Wait Cycle
		{lpData,1'b1,3'b1xx}:	qStNextCke <= 1'b1;	// 
		default:				qStNextCke <= 1'b0;
	endcase
	
	case (rSt)
		lpCmd1:		qTestOe <= 1'b1;
		lpCmd2:		qTestOe <= 1'b1;
		lpAdrs:		qTestOe <= 1'b1;
		lpData:		qTestOe <= iTestRwSel ? 1'b0 : 1'b1;
		default:	qTestOe <= 1'b0;
	endcase
	
	case ({rSt,qStNextCke})
		{lpData,1'b1}: 	qTestDoneCke <= 1'b1;
		default: 		qTestDoneCke <= 1'b0;
	endcase
	
	qStCntRst 		<= (iRST | qStNextCke);
	qStCntCke 		<= (~rTestCs) & (~rTestClk);
end


/**----------------------------------------------------------------------------
 * Mem Read Side
 * Ext RAM から 読み出したデータは、MCU が Read を行い正常に動作しているか判定する。
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0]	rMem [0:1023];
reg [pRamDqWidth-1:0]	rMemRd;						assign oMemRd = rMemRd;
reg						qMemWe;

always @(posedge iCLK)
begin
	if (qMemWe) rMem[rStCnt[9:0]] <= iTestDq;
	rMemRd	<= rMem[iMemRa];
end

always @*
begin
	qMemWe <= iTestRwSel & qStCntCke;
end

assign oTestErr	 = 1'b0;	// 24-02-23 現状使用しない

endmodule