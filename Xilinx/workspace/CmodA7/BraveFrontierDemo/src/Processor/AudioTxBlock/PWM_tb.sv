`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/07/31
// Author  KoutaKimura
//----------------------------------------------------------
module PWM_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 2;	// CLK サイクル
// parameter [3:0]		pBusBlockConnect		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBusBlockConnectWidth 	= pBusBlockConnect - 1'b1;	// Busに接続する Slave数 最大16

wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;
wire 				wPwm;


//----------------------------------------------------------
// CSR初期設定
//----------------------------------------------------------
reg [31:0] 			rSUsiWd   = 0;
reg [15:0] 			rSUsiAdrs = 0;
reg 				rSUsiWCke = 0;

task CsrSetting (
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
endtask //CsrSetting


//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSysClk = 0;
reg	rSysRst = 1;

always begin
    #(lpSysClkCycle/2);
    rSysClk = ~rSysClk;
end


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	#(lpSysClkCycle * 5);
	rSysRst = 0;
	#(lpSysClkCycle * 5);
	CsrSetting(100, 'h0204);
	CsrSetting(5, 'h0208);
	CsrSetting(1, 'h0200);
    #(lpSysClkCycle * 2000 * 4);
    $stop;
end


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
PWMBlock #(
	.pBlockAdrsMap	(8),
	.pAdrsMap		(2),
	.pBusAdrsBit	(15)
) PWM_BLOCK (
	.oPwm		(wPwm),
	.oSUsiRd	(wSUsiRd),
	.oSUsiREd	(wSUsiREd),
	.iSUsiWd	(rSUsiWd),
	.iSUsiAdrs	(rSUsiAdrs),
	.iSUsiWCke	(rSUsiWCke),
	.iSysClk	(rSysClk),
	.iSysRst	(rSysRst)
);

endmodule