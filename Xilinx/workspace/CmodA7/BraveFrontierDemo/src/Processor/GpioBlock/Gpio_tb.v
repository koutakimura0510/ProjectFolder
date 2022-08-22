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
// System Clk Generator
//----------------------------------------------------------
localparam 	lpClkCycle = 2;
//
wire 		wSysClk;
wire 		wSysRst;
//
SimSystemClk #(
	.pSystemClkCycle	(lpClkCycle)
) SIM_SYSTEM_CLK (
	.oSysClk			(wSysClk),
	.oSysRst			(wSysRst)
);


//----------------------------------------------------------
// Usi Buf 経由の CSR 設定
//----------------------------------------------------------
wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;
//
reg [31:0] 			rSUsiWd;
reg [31:0] 			rSUsiAdrs;
reg 				rSUsiWCke;
//
task usi_csr_setting (
	input [31:0] wd,
	input [31:0] adrs
);
begin
	rSUsiWd   = wd;
	rSUsiAdrs = adrs[15:0];
	#(lpSysClkCycle);
	rSUsiWCke = 1'b1;
	#(lpSysClkCycle);
	rSUsiWCke = 1'b0;
	#(lpSysClkCycle);
end
endtask //usi_csr_setting

//----------------------------------------------------------
// comment
//----------------------------------------------------------
//
wire 				wLed;
wire 				wLedB;
wire 				wLedG;
wire 				wLedR;
//
GpioBlock #(
	.pBlockAdrsMap	(8),
	.pAdrsMap		(1),
	.pBusAdrsBit	(16)
) GPIO_BLOCK (
	.oLed			(wLed),
	.oLedB			(wLedB),
	.oLedG			(wLedG),
	.oLedR			(wLedR),
	.oSUsiRd		(wSUsiRd),
	.oSUsiREd		(wSUsiREd),
	.iSUsiWd		(rSUsiWd),
	.iSUsiAdrs		(rSUsiAdrs),
	.iSUsiWCke		(rSUsiWCke),
	.iSysClk		(wSysClk),
	.iSysRst		(wSysRst)
);

//----------------------------------------------------------
// 
//----------------------------------------------------------
initial begin
	while (wSysRst);
	usi_csr_setting('b10101, 'h0100);
    #(lpClkCycle * 2000 * 4);
    $stop;
end

endmodule
