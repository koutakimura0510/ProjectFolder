//----------------------------------------------------------
// Create 2023/4/9
// Author koutakimura
// -
// V1.0 : I2S 信号生成 module
// 
//----------------------------------------------------------
module AudioTxI2S (
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
	input  iMCLK
);


/**-----------------------------------------------------------------------------
I2S I/F Signals Generator
PCM5102Aの仕様上、32bit SDATA は [0][31][30][29]...[1]の順番で送信しなければならない
各信号の生成に使用する MCLK COUNT はSDRでカウント値をインクリメントしていることに注意

 *-----------------------------------------------------------------------------*/
localparam lpMclkCntWidth = 8;
genvar x;
reg  [1:0] rMclkBCnt;	// BCLK 生成カウンタ  = 3.072MHz
reg  [lpMclkCntWidth-1:0] rMclkLRCnt;	// LRCLK 生成カウンタ = 48KHz
reg  rBclk, qBclkCke;
reg  rLRclk, qLRclkCke;
reg  [31:0] rSdata, qSdata;
reg  qSdataSftCke;
// control
reg  rRdy, qRdyCke;

always @(negedge iMCLK)
begin

	if (iMRST) 			rMclkBCnt <= 2'd0;
	else if	(qBclkCke)	rMclkBCnt <= 2'd0;
	else 				rMclkBCnt <= rMclkBCnt + 1'b1;

	if (iMRST) 			rBclk <= 1'b0;
	else if	(qBclkCke)	rBclk <= ~rBclk;
	else 				rBclk <=  rBclk;

	if (iMRST) 			rMclkLRCnt <= {lpMclkCntWidth{1'b0}};
	else 				rMclkLRCnt <= rMclkLRCnt + 1'b1;

	if (iMRST) 			rLRclk <= 1'b0;
	else if	(qLRclkCke)	rLRclk <= ~rLRclk;
	else 				rLRclk <=  rLRclk;

	if (qLRclkCke)			rSdata <=  qSdata;
	else if	(qSdataSftCke)	rSdata <= {rSdata[30:0],1'b0};
	else 					rSdata <=  rSdata;

	if (iMRST) 			rRdy <= 1'b0;	// Right音源出力のときに、次の音源データを読みこみ
	else if	(qRdyCke)	rRdy <= 1'b1;	// Ready Valid のタイミング入れ違い対策として
	else 				rRdy <= 1'b0;	// Rdy は 1ショットパルスの動作とする
end

always @*
begin
	qBclkCke  	 <= rMclkBCnt == 2'd3;
	qLRclkCke 	 <= rMclkLRCnt == {lpMclkCntWidth{1'b1}};
	qSdataSftCke <= qBclkCke & rBclk;	// BCLK のたち下がりエッジで SDATAシフト
	qRdyCke   	 <= qLRclkCke & (~rLRclk);
end

assign oI2S_MCLK	= iMCLK;
assign oI2S_BCLK	= rBclk;
assign oI2S_LRCLK	= rLRclk;
assign oI2S_SDATA	= rSdata[31];
assign oAudioDataRdy= rRdy;


//-----------------------------------------------------------------------------
// PCM5102 I2S仕様に則り、ビット位置を変更
//-----------------------------------------------------------------------------
always @*
begin
	qSdata[0]  <= iAudioData[1];
	qSdata[1]  <= iAudioData[2];
	qSdata[2]  <= iAudioData[3];
	qSdata[3]  <= iAudioData[4];
	qSdata[4]  <= iAudioData[5];
	qSdata[5]  <= iAudioData[6];
	qSdata[6]  <= iAudioData[7];
	qSdata[7]  <= iAudioData[8];
	qSdata[8]  <= iAudioData[9];
	qSdata[9]  <= iAudioData[10];
	qSdata[10] <= iAudioData[11];
	qSdata[11] <= iAudioData[12];
	qSdata[12] <= iAudioData[13];
	qSdata[13] <= iAudioData[14];
	qSdata[14] <= iAudioData[15];
	qSdata[15] <= iAudioData[16];
	qSdata[16] <= iAudioData[17];
	qSdata[17] <= iAudioData[18];
	qSdata[18] <= iAudioData[19];
	qSdata[19] <= iAudioData[20];
	qSdata[20] <= iAudioData[21];
	qSdata[21] <= iAudioData[22];
	qSdata[22] <= iAudioData[23];
	qSdata[23] <= iAudioData[24];
	qSdata[24] <= iAudioData[25];
	qSdata[25] <= iAudioData[26];
	qSdata[26] <= iAudioData[27];
	qSdata[27] <= iAudioData[28];
	qSdata[28] <= iAudioData[29];
	qSdata[29] <= iAudioData[30];
	qSdata[30] <= iAudioData[31];
	qSdata[31] <= iAudioData[0];
end

endmodule