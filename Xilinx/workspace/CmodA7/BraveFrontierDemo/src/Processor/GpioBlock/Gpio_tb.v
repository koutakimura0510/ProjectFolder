`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/24
// Author  KoutaKimura
// -
//----------------------------------------------------------
module Gpio_tb;

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam 	lpSysClkCycle = 2;
//
wire 		wSysClk;
reg  		rSysRst;
//
SimSystemClk #(
	.pSystemClkCycle	(lpSysClkCycle)
) SIM_SYSTEM_CLK (
	.oSysClk			(wSysClk)
);
//
task system_reset();
begin
	rSysRst <= 1'b1;
	#(lpSysClkCycle);
	rSysRst <= 1'b0;
	#(lpSysClkCycle);
end
endtask


//----------------------------------------------------------
// Usi Buf 経由の CSR 設定
//----------------------------------------------------------
wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;
//
reg [31:0] 			rSUsiWd = 0;
reg [31:0] 			rSUsiAdrs = 0;
reg 				rSUsiWCke = 0;
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
// Block に接続
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
	.pBusAdrsBit	(16),
	.pPWMDutyWidth	(8),
	.pIVtimerWidth	(32)
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
	.iSysRst		(rSysRst)
);

//----------------------------------------------------------
// 
//----------------------------------------------------------
initial begin
	system_reset();
	usi_csr_setting('b10101, 'h0100);
	usi_csr_setting('h0001,  'h0104);
	usi_csr_setting('h0020,  'h0108);
	usi_csr_setting('h0008,  'h011c);
    #(lpSysClkCycle * 2000 * 4);
    $stop;
end

endmodule
