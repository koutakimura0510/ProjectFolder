`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/12
// Author  KoutaKimura
// SPI の Master Slave を切り替えながらデータの送受信を行う。
// 
//----------------------------------------------------------
module MemoryReadWriteTester_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 2;	// CLK サイクル
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSCLK = 0;
reg	rSRST = 1;

always begin
    #(lpSysClkCycle/2);
    rSCLK = ~rSCLK;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 5);
	rSRST = 0;
	#(lpSysClkCycle * 5);
end
endtask //


//-----------------------------------------------------------------------------
// Read Write Tester
//-----------------------------------------------------------------------------
localparam lpRamAdrsWidth = 15;
localparam lpRamDqWidth = 16;

wire [lpRamAdrsWidth-1:0] wAdrs;
wire [lpRamDqWidth-1:0] wWd;
wire wCmd, wCe;
reg  [lpRamDqWidth-1:0] rRd;
reg  rREd;
wire wErr, wDone;

MemoryReadWriteTester #(
	.pRamAdrsWidth(lpRamAdrsWidth),
	.pRamDqWidth(lpRamDqWidth)
) MemoryReadWriteTester (
	// R/W Signal
	.oAdrs(wAdrs),	.oWd(wWd),
	.oCmd(wCmd),	.oCe(wCe),
	.iRd(rRd),		.iREd(rREd),
	// Status
	.oErr(wErr),	.oDone(wDone),
	// CLK Reset
    .iRST(rSRST),	.iCLK(rSCLK)
);


//-----------------------------------------------------------------------------
// Memory の確保
//-----------------------------------------------------------------------------
reg [lpRamDqWidth-1:0] rMem [65535:0];
reg qMemWEd, qMemREd;

always @(posedge rSCLK)
begin
	if (qMemWEd) rMem[wAdrs] <= wWd;
	else 		 rMem[wAdrs] <= rMem[wAdrs];


	if (qMemREd) rREd <= 1'b1;
	else 		 rREd <= 1'b0;
end

always @*
begin
	rRd <= rMem[wAdrs];
	qMemWEd <= (~wCmd) & (~wCe);
	qMemREd <= wCmd & (~wCe);
end


//-----------------------------------------------------------------------------
// Donw フラグが立つまで待機する
//-----------------------------------------------------------------------------
task ReadWriteTesterDoneWait(
	input integer flag
);
begin
	while (wDone == flag)
	begin
		#(lpSysClkCycle);
	end
end
endtask


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	$dumpfile("MemoryReadWriteTester_tb.vcd");
	$dumpvars(0, MemoryReadWriteTester_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	ReadWriteTesterDoneWait(0);
    $finish;
end


endmodule