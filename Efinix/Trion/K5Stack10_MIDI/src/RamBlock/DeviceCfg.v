/**-----------------------------------------------------------------------------
 * 24-01-21 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module DeviceCfg (
	// Config Port
	output	[15:0]	oCfgDq,
	output			oCfgClk,
	output			oCfgCs,
	output			oCfgEn,
	// Control, Status
	input 	[7:0]	iCfgCmd,
	input			iCfgEn,			// Config Enable
	output			oCfgDone,		// Config Done
	// Clk Reset
	input			iRST,
	input			iCKE,
	input			iCLK
);

/**---------------------------------------------------------------------------
 外部 HyperRam のコンフィグレーションを行う。
 MCU からのロジック設定順序を下記に記す。
  Core Rst Assert
  Cmd Set
  Cfg Enable
  Core Rst Dissert
  
  SPI Quad Mode Enable = 0x35
 *---------------------------------------------------------------------------*/
reg [7:0] 	rCfgDq;				assign oCfgDq 	= {16{rCfgDq[7]}};
reg			rCfgClk;			assign oCfgClk 	= rCfgClk;
reg			rCfgCs;				assign oCfgCs 	= rCfgCs;
reg			rCfgEn;				assign oCfgEn 	= rCfgEn;
reg			rCfgDone;			assign oCfgDone	= rCfgDone;
reg			qCfgDoneCke;
reg [4:0]	rDoneCnt;
reg			qCfgCke;
reg			qCfgRun;
reg			qCfgClkCke;

always @(posedge iCLK)
begin
	if (iRST) 				rCfgDq <=  iCfgCmd;
	else if (qCfgCke) 		rCfgDq <= {rCfgDq[6:0],1'b0};
	else 					rCfgDq <=  rCfgDq;
	
	if (iRST) 				rDoneCnt <= 5'd0;
	else if (qCfgCke) 		rDoneCnt <= rDoneCnt + 1'b1;
	else 					rDoneCnt <= rDoneCnt;
	
	if (iRST) 				rCfgDone <= 1'b0;
	else if (qCfgDoneCke)	rCfgDone <= 1'b1;
	else 					rCfgDone <= rCfgDone;
	
	if (iRST) 				rCfgCs <= 1'b1;
	else if (qCfgRun) 		rCfgCs <= 1'b0;
	else 					rCfgCs <= 1'b1;
	
	if (iRST) 				rCfgEn <= 1'b0;
	else if (qCfgRun) 		rCfgEn <= 1'b1;
	else 					rCfgEn <= 1'b0;
	
	if (iRST) 				rCfgClk <=  1'b0;
	else if (qCfgClkCke)	rCfgClk <= ~rCfgClk;
	else 					rCfgClk <=  rCfgClk;
end

always @*
begin
	qCfgCke 	<= iCfgEn & rCfgClk & (~rCfgDone);
	qCfgRun		<= iCfgEn & (~rCfgDone);
	qCfgClkCke	<= ~rCfgCs;
	qCfgDoneCke	<= (rDoneCnt == 5'd9);
end

endmodule