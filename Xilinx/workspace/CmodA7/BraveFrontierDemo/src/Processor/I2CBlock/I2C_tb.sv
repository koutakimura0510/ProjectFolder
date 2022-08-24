`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/07/31
// Author  KoutaKimura
//----------------------------------------------------------
module I2C_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 2;	// CLK サイクル
// parameter [3:0]		pBusSlaveConnect		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// Csr Settings State Machine
//----------------------------------------------------------
// typedef enum logic [7:0] { 
// 	eEN,
// 	eDIV
// } EnumCsrState;

// EnumCsrState csr_state;

//----------------------------------------------------------
// 
//----------------------------------------------------------
reg rScl = 1'bz;
reg rSda = 1'bz;
wire wScl, wSda;

assign wScl = rScl;
assign wSda = rSda;


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
// CSR Read
//----------------------------------------------------------
wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;

task CsrReadWhile(
	input [31:0] adrs,	// Csr Adrs
	input [31:0] rdata	// 指定のデータがセットされるまで待機
);
begin
	rSUsiAdrs = adrs[15:0];
	$display("--- Adrs = %8d", rSUsiAdrs);
	#(lpSysClkCycle);
	#(lpSysClkCycle);
	while (1)
	begin
		if (wSUsiRd == rdata)	#(lpSysClkCycle/2);
		else					break;
	end
end
endtask

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
	CsrSetting(250, 'h0404);
	CsrSetting(1, 'h0400);
	CsrReadWhile('h0484, 'h0);
	CsrSetting(0, 'h0400);
	//
	CsrReadWhile('h0484, 'h1);
	CsrSetting(250, 'h0404);
	CsrSetting(1, 'h0400);
    // #(lpSysClkCycle * 2000 * 4);
    $stop;
end


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
I2CBlock #(
	.pBlockAdrsMap	(8),
	.pAdrsMap		(4),
	.pBusAdrsBit	(16)
) I2C_BLOCK (
	.oI2CScl	(wScl),
	.ioI2CSda	(wSda),
	.oSUsiRd	(wSUsiRd),
	.oSUsiREd	(wSUsiREd),
	.iSUsiWd	(rSUsiWd),
	.iSUsiAdrs	(rSUsiAdrs),
	.iSUsiWCke	(rSUsiWCke),
	.iSysClk	(rSysClk),
	.iSysRst	(rSysRst)
);

endmodule