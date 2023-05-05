`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/12
// Author  KoutaKimura
// SPI の Master Slave を切り替えながらデータの送受信を行う。
// 
//----------------------------------------------------------
module ASyncFifoController_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSCLKCycle   = 2;	// CLK サイクル
localparam	lpBCLKCycle   = 7;	// CLK サイクル
localparam	lpSimlationTime = 2000;	// シミュレーション時間を指定
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg rBCLK = 0;
reg	rSCLK = 0;
reg	rSRST = 1;	//初期値
reg	rnSRST = 0;	//初期値

always
begin
    #(lpSCLKCycle);
    rSCLK = ~rSCLK;
end

always
begin
    #(lpBCLKCycle);
    rBCLK = ~rBCLK;
end

// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 5);
	rnSRST = ~rnSRST;
	rSRST = ~rSRST;
	#(lpSCLKCycle * 5);
end
endtask 

//-----------------------------------------------------------------------------
// Fifo Read Write Tester
//-----------------------------------------------------------------------------
localparam lpFifoDepth		= 1024;
localparam lpFifoBitWidth 	= 4;

reg  [lpFifoBitWidth-1:0] rWd, rRd;
wire [lpFifoBitWidth-1:0] wRd;
reg  qWe, qRe;
wire wFull, wEmp;
wire wRvd;

ASyncFifoController #(
	.pFifoDepth(lpFifoDepth),
	.pFifoBitWidth(lpFifoBitWidth)
) ASyncFifoController (
	.iWd(rWd),
	.iWe(qWe),
	.oFull(wFull),
	.oRd(wRd),
	.iRe(qRe),
	.oRvd(wRvd),
	.oEmp(wEmp),
	// CLK Reset
	.inARST(rnSRST),
	.iWCLK(rSCLK),
	.iRCLK(rBCLK)
);

always @(posedge rBCLK)
begin
	if (wRvd) 	rRd <= wRd;
	else 		rRd <= rRd;
end

//-----------------------------------------------------------------------------
// FIFO の書き込み読み込みタイミングの調整と WD 生成
//-----------------------------------------------------------------------------
wire wTimingGen;

PulseGenerator #(
	.pSysClk(1),
	.pTimeCke(1),
	.pStartPulse(0)
) PulseGenerator (
	.oPulse(wTimingGen),
	.iRST(rSRST),
	.iCLK(rSCLK)
);

always @(posedge rSCLK)
begin
	if (rSRST) 		rWd <= 0;
	else if (qWe)	rWd <= rWd + 1'b1;
	else 			rWd <= rWd;
end

always @*
begin
	qWe <= ~wFull & wTimingGen;
	qRe <= ~wEmp;
end

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("ASyncFifoController_tb.vcd");
	$dumpvars(0, ASyncFifoController_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSimlationTime);
    $finish;
end


endmodule