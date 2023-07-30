/*-----------------------------------------------------------------------------
 * Create  2023/04/15
 * Author  koutakimura
 * -
 * I2SSignalGen のテストベンチ
 * 
 *-----------------------------------------------------------------------------*/
module I2SSignalGen_tb;

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam	lpMCLKCycle = 2;	// CLK サイクル

reg	rMCLK = 0;
reg	rMRST = 1;

always begin
    #(lpMCLKCycle/2);
    rMCLK = ~rMCLK;
end

task reset_init;	// Reset 処理
begin
	#(lpMCLKCycle * 5);
	rMRST = 0;
	#(lpMCLKCycle * 5);
end
endtask //


//-----------------------------------------------------------------------------
// I2S Gen
//-----------------------------------------------------------------------------
wire wI2S_MCLK, wI2S_BCLK, wI2S_LRCLK, wI2S_SDATA;
reg  [31:0] rAudioData;
wire wAudioDataRdy;

I2SSignalGen I2SSignalGen(
	.oI2S_MCLK(wI2S_MCLK),		.oI2S_BCLK(wI2S_BCLK),
	.oI2S_LRCLK(wI2S_LRCLK),	.oI2S_SDATA(wI2S_SDATA),
	//
	.iAudioData(rAudioData),	.oAudioDataRdy(wAudioDataRdy),
	//
	.iMRST(rMRST),	.iSRST(),
	.iMCLK(rMCLK),	.iSCLK()
);

always @(posedge rMCLK)
begin
	if (rMRST) 				rAudioData <= 32'd0;
	else if (wAudioDataRdy)	rAudioData <= rAudioData + 1'b1;
	else 					rAudioData <= rAudioData;
end


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	$dumpfile("I2SSignalGen_tb.vcd");
	$dumpvars(0, I2SSignalGen_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpMCLKCycle * 4800);
    $finish;
end


endmodule