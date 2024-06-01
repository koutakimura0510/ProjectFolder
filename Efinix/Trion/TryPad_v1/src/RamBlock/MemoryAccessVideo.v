/**-----------------------------------------------------------------------------
 * 24-03-06 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module MemoryAccessVideo #(
	parameter pRamDqWidth = 16
)(
	// Video Port to Ram Port
	output	[pRamDqWidth-1:0] 	oVideoDq,
	output						oVideoCs,
	output						oVideoClk,
	output						oVideoOe,
	output						oVideoEn,
	input	[pRamDqWidth-1:0] 	iVideoRd,
	input						iVideoRe,
	// Ufib Port to Video Port
	input	[15:0]				iVideoBurstLen,
	input 						iVideoRwSel,
	input	[28:0]				iVideoAdrs,
	input						iVideoVd,
	output						oVideoDone,
	output						oVideoRdy,
	// Control / Status
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
reg  [pRamDqWidth-1:0]	qVideoDq;					assign oVideoDq	 = qVideoDq;
reg  					rVideoCs;					assign oVideoCs	 = rVideoCs;
reg  					rVideoClk;					assign oVideoClk = rVideoClk;
reg  					rVideoOe;					assign oVideoOe	 = rVideoOe;
reg  					rVideoEn;					assign oVideoEn	 = rVideoEn;
reg						rVideoDone;					assign oVideoDone= rVideoDone;
//
reg						qVideoDoneCke;
reg						qVideoOeCke;
reg						qVideoClkCke;
reg						rVideoRun,	qVideoRunCke;
//
reg [7:0]				rDivCnt;
reg						qDivCntMaxCke, qDivCntCke;
//
reg						qVideoLoclRst;

always @(posedge iCLK)
begin
	if (qVideoLoclRst)		rVideoCs <= 1'b1;
	else 					rVideoCs <= 1'b0;
	
	if (qVideoLoclRst)		rVideoOe <= 1'b1;		// Run 前は write 設定
	else if (qVideoOeCke)	rVideoOe <= 1'b0;		// Read 要求があった場合のみ Read に切り替え
	else					rVideoOe <= rVideoOe;	// Run 中に R/W 切り替えは発生しないので、そのままにしておく。
	
	if (qVideoLoclRst)		rVideoEn <= 1'b0;
	else 					rVideoEn <= 1'b1;
	
	if (qVideoLoclRst)		rVideoClk <=  1'b0;
	else if (qVideoClkCke)	rVideoClk <= ~rVideoClk;	// CS Assert から Drive Start
	else 					rVideoClk <=  rVideoClk;
	
	if (qVideoLoclRst)		rVideoDone <= 1'b0;
	else if (qVideoDoneCke)	rVideoDone <= 1'b1;
	else 					rVideoDone <= rVideoDone;
	
	if (qVideoLoclRst)		rDivCnt <=  8'd0;
	else if (qDivCntMaxCke)	rDivCnt <=  8'd0;
	else if (qDivCntCke)	rDivCnt <=  rDivCnt + 1'b1;	// CS Assert からカウント開始
	else 					rDivCnt <=  rDivCnt;
	
	if (iRST)				rVideoRun <=   1'd0;
	else if (qVideoRunCke)	rVideoRun <=  ~rVideoRun;
	else 					rVideoRun <=   rVideoRun;
	
end

always @*
begin
	casex ({rVideoRun,iVideoVd,rVideoDone})
		3'b01x:	 	qVideoRunCke <= 1'b1;	// Assert
		3'b1x1:	 	qVideoRunCke <= 1'b1;	// Negate
		default: 	qVideoRunCke <= 1'b0;
	endcase
	
	qDivCntMaxCke  	<=  (rDivCnt == iMemClkDiv);
	qVideoClkCke	<= &{~rVideoCs,qDivCntMaxCke};
	qDivCntCke  	<=  (~rVideoCs);
	qVideoLoclRst	<= |{iRST,rVideoDone,~rVideoRun};	// Done 時に回路リセット
end

/**----------------------------------------------------------------------------
 * 前段への Rdy 信号発行
 * 一定周期で前段にデータ受付通知を発行する。
 * 通知を受信した前段の回路がデータを出力して回路が駆動したら、駆動が終了するまで Rdy を発行しない。
 *---------------------------------------------------------------------------*/
reg			rVideoRdy;					assign oVideoRdy = rVideoRdy;
reg			qVideoRdyCke;
reg [2:0] 	rWaitCnt;
reg			qWaitCntMax;
		
always @(posedge iCLK)
begin
	if (iRST)				rWaitCnt <= 3'd0;
	else if (qWaitCntMax)	rWaitCnt <= 3'd0;
	else 					rWaitCnt <= rWaitCnt + 1'b1;
	
	if (iRST)				rVideoRdy <= 1'd0;
	else if (qVideoRdyCke)	rVideoRdy <= 1'b1;
	else 					rVideoRdy <= 1'b0;
end

always @*
begin
	qVideoRdyCke <= &{~rVideoRun,qWaitCntMax};
	qWaitCntMax  <=  (rWaitCnt == 3'd5);
end

/**----------------------------------------------------------------------------
 * Mem Write Side
 *---------------------------------------------------------------------------*/
reg [31:0] 	rMemCmd;
reg [15:0]	rMemBurstCnt;
reg			rMemRwSel;
reg			qMemSftCke;
reg			qMemBurstCntCke;
reg [3:0]	rCmdSendCnt;

always @(posedge iCLK)
begin
	if (iVideoVd)				rMemCmd <= {8'hE8,iVideoAdrs[23:0]};
	else if (qMemSftCke)		rMemCmd <= {rMemCmd[27:0],4'h0};
	else						rMemCmd	<=  rMemCmd;
	
	if (iVideoVd)				rMemBurstCnt <= iVideoBurstLen;
	else if (qMemBurstCntCke)	rMemBurstCnt <= rMemBurstCnt - 1'b1;
	else						rMemBurstCnt <= rMemBurstCnt;
	
	if (iVideoVd)				rMemRwSel <= iVideoRwSel;
	else						rMemRwSel <= rMemRwSel;
	
	if (iVideoVd)				rCmdSendCnt <= 4'd0;
	else if (qMemSftCke)		rCmdSendCnt <= rCmdSendCnt + 1'b1;
	else						rCmdSendCnt <= rCmdSendCnt;
end

always @*
begin
	qVideoDq		<=  {4{rMemCmd[31:28]}};
	qMemSftCke		<= &{~rVideoCs,  rVideoClk, qDivCntMaxCke};		// clk negedge でデータ更新
	qVideoOeCke		<= &{~rMemRwSel, rCmdSendCnt[3], qMemSftCke};	// rCmdSendCnt[3], CMD + 6byte adrs = 8cnt(4bit目)
	qVideoDoneCke	<= &{~rVideoCs,  rMemBurstCnt == 16'h0000};		// 
	qMemBurstCntCke	<=    iVideoRe;
end

endmodule