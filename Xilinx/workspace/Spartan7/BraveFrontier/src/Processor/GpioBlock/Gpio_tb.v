`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/07/23
// Author  KoutaKimura
// -
// MCB 専用のテストベンチ
// 
//----------------------------------------------------------
module Gpio_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
parameter 			CYCLE 		= 2;				// CLK サイクル
parameter [3:0]		pBusNum		= 10; 				// Busに接続する Slave数 最大16
parameter [3:0]		pBusWidth 	= pBusNum - 1'b1;	// Busに接続する Slave数 最大16

reg 				rSysClk = 0;
reg 				rSysRst = 1;
wire [1:0]			wLedEdge;
wire 				wLedClk;
wire [31:0] 		wSUsiRd;
wire 				wSUsiVd;
reg [31:0] 			rSUsiWd;
reg [31:0] 			rSUsiAdrs;
reg 				rSUsiWCke;

GpioBlock GPIO_BLOCK (
	.oLedEdge	(wLedEdge),
	.oLedClk	(wLedClk),
	.oSUsiRd	(wSUsiRd),
	.oSUsiVd	(wSUsiVd),
	.iSUsiWd	(rSUsiWd),
	.iSUsiAdrs	(rSUsiAdrs),
	.iSUsiWCke	(rSUsiWCke),
	.iSysClk	(rSysClk),
	.iSysRst	(rSysRst)
);

always @(posedge rSysClk)
begin
	if (rSysRst) 	rSUsiWd <= 32'h0289;
	else 			rSUsiWd <= rSUsiWd;

	if (rSysRst) 	rSUsiAdrs <= 32'h0100;
	else 			rSUsiAdrs <= rSUsiAdrs;

	if (rSysRst) 	rSUsiWCke <= 1'b1;
	else 			rSUsiWCke <= rSUsiWCke;
end

always begin
    #(CYCLE);
    rSysClk = ~rSysClk;
end

initial begin
	#(CYCLE * 5);
	rSysRst = 0;
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
