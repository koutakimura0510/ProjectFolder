`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/12
// Author  KoutaKimura
// 
//----------------------------------------------------------
module SPI_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 2;	// CLK サイクル
// parameter [3:0]		pBusSlaveConnect		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSysClk = 0;
reg	rSysRst = 1;

always begin
    #(lpSysClkCycle/2);
    rSysClk = ~rSysClk;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 5);
	rSysRst = 0;
	#(lpSysClkCycle * 5);
end
endtask //


//----------------------------------------------------------
// Gpio Connect
//----------------------------------------------------------
reg rioSpiSck		= 1'b0;
reg rioSpiMiso		= 1'bz;
reg rioSpiMosi		= 1'b0;
reg rioSpiWp		= 1'b1;
reg rioSpiHold		= 1'b1;
reg rioSpiCs		= 1'b1;
reg riMSSel			= 1'b0;
//
wire wioSpiSck;
wire wioSpiMiso;
wire wioSpiMosi;
wire wioSpiWp;
wire wioSpiHold;
wire wioSpiCs;
wire wiMSSel;
wire wSpiConfigCs;
//
assign wioSpiSck	= rioSpiSck;
assign wioSpiMiso	= rioSpiMiso;
assign wioSpiMosi	= rioSpiMosi;
assign wioSpiWp		= rioSpiWp;
assign wioSpiHold	= rioSpiHold;
assign wioSpiCs		= rioSpiCs;
assign wiMSSel		= riMSSel;
//
wire wMUsiMonopoly;
//

//----------------------------------------------------------
// Usi Buf 経由の CSR 設定
//----------------------------------------------------------
reg [31:0]			rMUsiRd		= 0;
reg 				rMUsiREd	= 0;
//
reg [31:0] 			rSUsiWd   	= 0;
reg [15:0] 			rSUsiAdrs 	= 0;
reg 				rSUsiWCke 	= 0;
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

// Slave Read データを Master に送信
wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;
// Master の命令データを Slave に送信
wire [31:0]			wMUsiWd;
wire [15:0]			wMUsiAdrs;
wire 				wMUsiWEd;
//
always @(posedge rSysClk)
begin
	rMUsiRd		<= wSUsiRd;
	rMUsiREd	<= wSUsiREd;
	//
	rSUsiWd		<= wMUsiWd;
	rSUsiAdrs	<= wMUsiAdrs;
	rSUsiWCke	<= wMUsiWEd;
end

//----------------------------------------------------------
// Ufi Bus
//----------------------------------------------------------
wire [31:0]	wMUfiWd;
wire [31:0]	wMUfiAdrs;
wire 		wMUfiWEd;
wire 		wMUfiWVd;


//----------------------------------------------------------
// SPI Master 設定
// 
// FPGA SPI Slave の仕様
// 4byte Adrs + Cmd + 2byte Data Length + dummy + nData... 
// -
// 最初に 8byte の命令シーケンスを受信する
// Cmd : 0. Non, 1. Csr Write, 2. Csr Read, 3. PSRAM Write
// -
// Csr 操作時は 連続アクセスは可能としない、必ず Data Length は 4byte 固定とする
// PSRAM 操作時は Data Length は最大 2048 byte とする
// 
//----------------------------------------------------------
localparam lpSclCycle = (lpSysClkCycle * 8);

// SPI CS 関数
task spi_cs (
	input iCs	// High / Low Sel
);
begin
	#(lpSclCycle);
	rioSpiCs = iCs;
	#(lpSclCycle);
end
endtask

// SPI 送信関数, 32bit 固定
task spi_send (
	input [31:0] iMiso
);
begin
	integer i;

	for (i = 32; i >= 0; i = i - 1)
	begin
		#(lpSysClkCycle * 2);
		rioSpiMosi	= iMiso[i];
		#(lpSysClkCycle * 6);
		rioSpiSck	= 1'b1;
		#(lpSclCycle);
		rioSpiSck	= 1'b0;
	end
end
endtask



//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	reset_init();
	spi_cs(1'b0);
	spi_send('h8765_0304);
	spi_send('h0100_0100);
	spi_send('h0000_000f);
	spi_cs(1'b1);
    $stop;
end


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
SPIBlock #(
	.pBlockAdrsMap		(8),
	.pAdrsMap			('h03),
	.pBusAdrsBit		(16),
	.pBusSlaveConnect	(1)
) SPI_BLOCK (
	// External Port
    .ioSpiSck			(wioSpiSck),
    .ioSpiMiso			(wioSpiMiso),
    .ioSpiMosi			(wioSpiMosi),
    .ioSpiWp			(wioSpiWp),
    .ioSpiHold			(wioSpiHold),
    .oSpiConfigCs		(wSpiConfigCs),
    .ioSpiCs			(wioSpiCs),
    .iMSSel				(wiMSSel),
    // Internal Port
	// Usi Bus Master Read
	.iMUsiRd			(rMUsiRd),		// CSR Read Data
	.iMUsiREd			(rMUsiREd),		// Read Assert
	// Usi Bus Master Write
	.oMUsiWd			(wMUsiWd),		// Write Data
	.oMUsiAdrs			(wMUsiAdrs),	// R/W Adrs
	.oMUsiWEd			(wMUsiWEd),		// Write Enable
	// Usi Bus Slave Read
	.oSUsiRd			(wSUsiRd),		// Read Data
	.oSUsiREd			(wSUsiREd),		// Read Data Enable
	// Usi Bus Slave Write
	.iSUsiWd			(rSUsiWd),		// Master Write Data
	.iSUsiAdrs			(rSUsiAdrs),	// Csr Access Adrs
	.iSUsiWCke			(rSUsiWCke),	// Data Enable
	// Ufi Bus Master Write
	.oMUfiWd			(wMUfiWd),		// Write Data
	.oMUfiAdrs			(wMUfiAdrs),	// Write address
	.oMUfiWEd			(wMUfiWEd),		// Write Data Enable
	.oMUfiWVd			(wMUfiWVd),		// 転送期間中 Assert
	// Interrupt
	.oMUsiREd			(oMUsiREd),
	// Usi Bus Master to Slave Select
	.oMUsiMonopoly		(wMUsiMonopoly),// 0. Slave として機能 / 1. Master バスを独占
	// CLK Reset
	.iSysClk			(rSysClk),
	.iSysRst			(rSysRst)
);

endmodule