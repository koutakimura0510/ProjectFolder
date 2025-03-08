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
// Usi Buf 経由の CSR 設定
//----------------------------------------------------------
wire [31:0]	wSUsiRd;
reg  [31:0] rSUsiWd = 0;
reg  [31:0] rSUsiAdrs = 0;

task usi_csr_setting (
	input [31:0] wd,
	input [31:0] adrs
);
begin
	rSUsiWd   = wd;
	rSUsiAdrs = adrs;
	#(lpSCLKCycle);
end
endtask //usi_csr_setting

//-----------------------------------------------------------------------------
// Wait 関数 
//-----------------------------------------------------------------------------
task Wait(
	input [31:0] flag
);
begin
	while (wSUsiRd == flag)	// iverilog の場合、等しい場合ループする
	begin
		#(lpSCLKCycle);
	end
end
endtask


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
SysTimerBlock #(
	.pBlockAdrsWidth(8),
	.pAdrsMap('h04),
	.pUsiBusWidth(32),
	.pCsrAdrsWidth(16)
) SysTimerBlock (
	// Bus Master Read
	.oSUsiRd(wSUsiRd),
	// Bus Master Write
	.iSUsiWd(rSUsiWd),
	.iSUsiAdrs(rSUsiAdrs),
	// CLK Reset
	.iSCLK(rSCLK),
	.iSRST(rSRST)
);




//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("SysTimer_tb.vcd");
	$dumpvars(0, SysTimer_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	usi_csr_setting('d5000-1, 	'h40040000);
	usi_csr_setting('d500-1,	'h40040004);
	usi_csr_setting('d50-1, 	'h40040008);
	usi_csr_setting('b001, 		'h4004000C);
	usi_csr_setting('d0,	'h00040040);
	Wait(0);
    $finish;
end




endmodule