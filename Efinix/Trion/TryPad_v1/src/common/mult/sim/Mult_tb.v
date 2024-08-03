`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * Create  2023/07/22
 * Author  kouta kimura
 * -
 * FIFO Lib Simlation
 * 
 *-----------------------------------------------------------------------------*/
module Mult_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle   = 2;	// CLK サイクル
localparam	lpSimlationTime = 2000;	// シミュレーション時間を指定
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSCLK = 0;
reg	rSRST = 0;	//初期値
reg	rnSRST = 0;	//初期値

always
begin
    #(lpSysClkCycle/2);
    rSCLK = ~rSCLK;
end

// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 10);
	rnSRST = ~rnSRST;
	#(lpSysClkCycle * 4);
	rSRST = ~rSRST;
	#(lpSysClkCycle * 4);
	rSRST = ~rSRST;
	#(lpSysClkCycle * 5);
end
endtask 

//-----------------------------------------------------------------------------
// Fifo Read Write Tester
//-----------------------------------------------------------------------------
wire [ 4:0] wR,wB;
wire [ 5:0] wG;
reg  [ 4:0] rRA, rBA;
reg  [ 5:0] rGA;
reg  [ 4:0] rRB, rBB, rAB;
reg  [ 5:0] rGB;
wire		wVD;
reg  		qVS;

AlphaBlend AlphaBlend (
	// Dst Side
	.oPD({wR, wG, wB}),
	.oVD(wVD),
	// Src Side
	.iPSA({rRA, rGA, rBA}),
	.iPSB({rRB, rGB, rBB}),
	.iVS(qVS),
	.iAlpha(8'd127),
	// CLK Reset
	.iRST(rSRST),
	.iCLK(rSCLK)
);

always @(posedge rSCLK)
begin
	if (rSRST) 		rRA <= 5'd0;
	else 			rRA <= rRA;
	
	if (rSRST) 		rGA <= 6'd63;
	else if (qVS)	rGA <= rGA+1'b1;
	else 			rGA <= rGA;
	
	if (rSRST) 		rBA <= 5'd17;
	else 			rBA <= rBA;
	//
	if (rSRST) 		rRB <= 5'd21;
	else 			rRB <= rRB;
	
	if (rSRST) 		rGB <= 6'd50;
	else 			rGB <= rGB;
	
	if (rSRST) 		rBB <= 5'd2;
	else 			rBB <= rBB;
	
	if (rSRST) 		rAB <= 5'd31;
	else 			rAB <= rAB;
end

//-----------------------------------------------------------------------------
// FIFO の書き込み読み込みタイミングの調整と WD 生成
//-----------------------------------------------------------------------------
wire wTimingGen;

PulseGenerator #(
	.pDivClk(2),
	.pStartPulse(0)
) PulseGenerator (
	.oPulse(wTimingGen),
	.iRST(rSRST),
	.iCLK(rSCLK)
);

always @*
begin
	qVS <= wTimingGen;
end

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$display("--- SIMLATION START !! ---\n");

	$dumpfile("Mult_tb.vcd");
	$dumpvars(0, Mult_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSimlationTime);
	$display("\n");
	$display("--- SIMLATION END !! ---\n");
    $finish;
end


endmodule