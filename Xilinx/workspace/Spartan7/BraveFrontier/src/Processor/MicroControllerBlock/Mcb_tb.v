`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/07/23
// Author  KoutaKimura
// -
// MCB 専用のテストベンチ
// 
//----------------------------------------------------------
module Mcb_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
parameter 			CYCLE 		= 2;				// CLK サイクル
parameter [3:0]		pBusSlaveConnect		= 10; 				// Busに接続する Slave数 最大16
parameter [3:0]		pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1;	// Busに接続する Slave数 最大16

reg 				rSysClk = 0;
reg 				rSysRst = 1;
reg  [31:0] 		rSUsiRd;
reg  [pBusSlaveConnectWidth:0] 	rSUsiVd;
reg  [pBusSlaveConnectWidth:0] 	rSUsiCke;
wire [31:0] 		wMUsiWd;
wire [31:0] 		wMUsiAdrs;
wire 				wMUsiCke;

MicroControllerBlock #(
	.pBusSlaveConnect	(pBusSlaveConnect)
) MCB (
	.iSUsiRd	(rSUsiRd),
	.iSUsiVd	(rSUsiVd),
	.iSUsiCke	(rSUsiCke),
	.oMUsiWd	(wMUsiWd),
	.oMUsiAdrs	(wMUsiAdrs),
	.oMUsiCke	(wMUsiCke),
	.iSysClk	(rSysClk),
	.iSysRst	(rSysRst)
);

always @(posedge rSysClk)
begin
	if (rSysRst) 	rSUsiRd <= 0;
	else 			rSUsiRd <= rSUsiRd + 1'b1;

	if (rSysRst) 	rSUsiVd <= 0;
	else 			rSUsiVd <= rSUsiVd + 1'b1;

	if (rSysRst) 	rSUsiCke <= 0;
	else 			rSUsiCke <= rSUsiCke + 1'b1;
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
