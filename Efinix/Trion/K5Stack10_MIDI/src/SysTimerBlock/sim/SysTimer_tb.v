/*-----------------------------------------------------------------------------
 * Create  2023/7/3
 * Author  kouta kimura
 * Editor  VSCode ver1.73.1
 * Build   iverilog ver11.0
 * -
 * SysTimerBlock testbench
 * 
 *-----------------------------------------------------------------------------*/
module SysTimer_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSCLKCycle = 2;	// CLK サイクル
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSCLK = 0;
reg	rSRST = 1;

always begin
    #(lpSCLKCycle/2);
    rSCLK = ~rSCLK;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 5);
	rSRST = 0;
	#(lpSCLKCycle * 5);
end
endtask

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("SysTimer_tb.vcd");
	$dumpvars(0, SysTimer_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSCLKCycle * 5000)
    $finish;
end


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
SysTimerBlock #(
	.pBlockAdrsWidth(8),
	.pAdrsMap('h04),
	.pUsiBusWidth(32),
	.pCsrAdrsWidth(16),
	.pSysClk(1000)
) SysTimerBlock (
	// Bus Master Read
	.oSUsiRd(),
	// Bus Master Write
	.iSUsiWd(0),
	.iSUsiAdrs(32'h00040004),
	// CLK Reset
	.iSCLK(rSCLK),
	.iSRST(rSRST)
);

endmodule