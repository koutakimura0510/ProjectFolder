`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * Create  2023/07/22
 * Author  kouta kimura
 * -
 * FIFO Lib Simlation
 * 
 *-----------------------------------------------------------------------------*/
module SyncFifoController_tb;

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
reg	rSRST = 1;	//初期値
reg	rnSRST = 0;	//初期値

always
begin
    #(lpSysClkCycle/2);
    rSCLK = ~rSCLK;
end

// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 5);
	rnSRST = ~rnSRST;
	rSRST = ~rSRST;
	#(lpSysClkCycle * 5);
end
endtask 

//-----------------------------------------------------------------------------
// Fifo Read Write Tester
//-----------------------------------------------------------------------------
localparam lpFifoDepth		= 256;
localparam lpFifoBitWidth 	= 32;

reg  [lpFifoBitWidth-1:0] rWd, rRd;
wire [lpFifoBitWidth-1:0] wRd;
reg  qWe, qRe;
wire wFull, wEmp;
wire wRvd;

SyncFifoController #(
	.pFifoDepth(lpFifoDepth),
	.pFifoBitWidth(lpFifoBitWidth)
) SyncFifoController (
	.iWd(rWd),
	.iWe(qWe),
	.oFull(wFull),
	.oRd(wRd),
	.iRe(qRe),
	.oRvd(wRvd),
	.oEmp(wEmp),
	// CLK Reset
	.inARST(rnSRST),
	.iCLK(rSCLK)
);

always @(posedge rSCLK)
begin
	if (wRvd) 	rRd <= wRd;
	else 		rRd <= rRd;
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

always @(posedge rSCLK)
begin
	if (rSRST) 		rWd <= 65536*2;
	else if (qWe)	rWd <= rWd + 1'b1;
	else 			rWd <= rWd;
end

always @*
begin
	qWe <= ~wFull;
	qRe <= ~wEmp  & wTimingGen;
end

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$display("--- SIMLATION START !! ---\n");

	$dumpfile("SyncFifoController_tb.vcd");
	$dumpvars(0, SyncFifoController_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSimlationTime);
	$display("\n");
	$display("--- SIMLATION END !! ---\n");
    $finish;
end


endmodule