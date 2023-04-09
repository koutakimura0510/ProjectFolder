//----------------------------------------------------------
// Create 2023/4/9
// Author koutakimura
// -
// V1.0 : I2S 信号生成 module
// 
//----------------------------------------------------------
module I2SSignalGen (
	// I2S Output Ctrl
	output oI2S_MCLK,
	output oI2S_BCLK,
	output oI2S_LRCLK,	// Low "LCLK", High "RCLK"
	output oI2S_SDATA,
	// Control and Data
	input  [31:0] iAudioData,
	output oAudioDataRdy,
    // CLK Reset
	input  iMRST,
    input  iSRST,
	input  iMCLK,
    input  iSCLK
);


/**-----------------------------------------------------------------------------
I2S I/F Signals Generator
PCM5102Aの仕様上、32bit SDATA は [0][31][30][29]...[1]の順番で送信しなければならない
各信号の生成に使用する MCLK COUNT はSDRでカウント値をインクリメントしていることに注意

 *-----------------------------------------------------------------------------*/
localparam lpMclkCntWidth = 8;
reg  [lpMclkCntWidth-1:0] rMclkCnt;	// 最大カウント時 = 48KHzの周波数
reg  rBclk, rBclkCke;
reg  rLRclk, rLRclkCke;
reg  [31:0] rSdata;
// control
reg  rRdy, qRdyCke;

always @(negedge iMCLK)
begin
	if (iMRST) 			rMclkCnt <= {lpMclkCntWidth{1'b0}};
	else 				rMclkCnt <= rMclkCnt + 1'b1;

	if (iMRST) 			rBclk <= 1'b0;
	else if	(rBclkCke)	rBclk <= ~rBclk;
	else 				rBclk <=  rBclk;

	if (iMRST) 			rLRclk <= 1'b0;
	else if	(rLRclkCke)	rLRclk <= ~rLRclk;
	else 				rLRclk <=  rLRclk;

	if (rLRclkCke)		rSdata <= {iAudioData[0],iAudioData[31:1]};
	else if	(rBclkCke)	rSdata <= {rSdata[30:0],1'b0};
	else 				rSdata <=  rSdata;

	if (iMRST) 			rRdy <= 1'b0;
	else if	(qRdyCke)	rRdy <= 1'b1;
	else 				rRdy <= 1'b0;
end

always @*
begin
	rBclkCke  <= rMclkCnt[1];
	rLRclkCke <= rMclkCnt == {lpMclkCntWidth{1'b1}};
	qRdyCke   <= rLRclkCke & (~rLRclk);
end

assign oI2S_MCLK	= iMCLK;
assign oI2S_BCLK	= rBclk;
assign oI2S_LRCLK	= rLRclk;
assign oI2S_SDATA	= rSdata[31];
assign oAudioDataRdy= rRdy;

endmodule