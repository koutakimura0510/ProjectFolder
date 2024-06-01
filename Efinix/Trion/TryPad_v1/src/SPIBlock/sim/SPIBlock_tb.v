`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/12
// Author  KoutaKimura
// SPI の Master Slave を切り替えながらデータの送受信を行う。
// 
//----------------------------------------------------------
/*-----------------------------------------------------------------------------
 * Create  2023/07/08
 * Author  kouta kimura
 * -
 * SPIBlock Testbench
 * 
 *-----------------------------------------------------------------------------*/
module SPIBlock_tb;

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
task wait_flag(
	input [31:0] flag
);
begin
	while (wSUsiRd == flag)	// iverilog の場合、等しい場合ループする
	begin
		#(lpSCLKCycle);
	end
end
endtask

//-----------------------------------------------------------------------------
// SPI GPIO
//-----------------------------------------------------------------------------
reg  rExMasterSck = 0;
reg  rExMasterMosi = 0;
wire wExMasterMiso;
reg  rExMasterCs = 0;
//
wire wFpgaSck;
wire wFpgaMosi;
reg  rFpgaMiso = 0;
wire wFpgaCs;
//
wire wFlashRomSck;
wire wFlashRomMosi;
reg  rFlashRomMiso = 0;
wire wFlashRomCs;

//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
SPIBlock #(
	.pBlockAdrsWidth(8),
	.pAdrsMap('h01),
	.pUsiBusWidth(32),
	.pCsrAdrsWidth(16)
) SPI_BLOCK (
	// External Port
	.iSpiSck(rExMasterSck),
	.iSpiMosi(rExMasterMosi),
	.oSpiMiso(wExMasterMiso),
	.iSpiCs(rExMasterCs),
	.oSpiSck(wFpgaSck),
	.oSpiMosi(wFpgaMosi),
	.iSpiMiso(rFpgaMiso),
	.oSpiCs(wFpgaCs),
	.iSpiDir(1'b0),
	//
	.oFlashRomSck(wFlashRomSck),
	.oFlashRomMosi(wFlashRomMosi),
	.iFlashRomMiso(rFlashRomMiso),
	.oFlashRomCs(wFlashRomCs),
	// Bus Master Read
	.iMUsiRd(0),
	.oSUsiRd(wSUsiRd),
	// Bus Master Write
	.oMUsiWd(),
	.oMUsiAdrs(),
	.iSUsiWd(rSUsiWd),
	.iSUsiAdrs(rSUsiAdrs),
	// Interrupt
	.oSpiDir(),
	.onSpiDir(),
	// CLK Reset
	.iSCLK(rSCLK),
	.iSRST(rSRST)
);


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("SPIBlock_tb.vcd");
	$dumpvars(0, SPIBlock_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	usi_csr_setting('h10, 'h40010014);
	usi_csr_setting('haa, 'h40010018);
	usi_csr_setting('h0, 'h4001001C);
	usi_csr_setting('h1, 'h40010010);
	usi_csr_setting('h1, 'h40010088);
	wait_flag(0);
	usi_csr_setting('h1, 'h4001001C);
	#(lpSCLKCycle*100);
    $finish;
end

endmodule