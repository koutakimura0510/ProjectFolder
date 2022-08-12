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

//----------------------------------------------------------
// Gpio Connect
//----------------------------------------------------------
reg rioSpiSck		= 1'b0;
reg rioSpiMiso		= 1'bz;
reg rioSpiMosi		= 1'b0;
reg rioSpiWp		= 1'b1;
reg rioSpiHold		= 1'b1;
reg rioSpiCs1		= 1'b1;
reg rioSpiCs2		= 1'b0;
//
wire wioSpiSck;
wire wioSpiMiso;
wire wioSpiMosi;
wire wioSpiWp;
wire wioSpiHold;
wire wioSpiCs1;
wire wioSpiCs2;
wire wSpiConfigCs;
//
assign wioSpiSck	= rioSpiSck;
assign wioSpiMiso	= rioSpiMiso;
assign wioSpiMosi	= rioSpiMosi;
assign wioSpiWp		= rioSpiWp;
assign wioSpiHold	= rioSpiHold;
assign wioSpiCs1	= rioSpiCs1;
assign wioSpiCs2	= rioSpiCs2;
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

task SpiMaster (
	input integer iSendCnt,
	input [7:0] iMiso
);
begin
	integer i;

	rioSpiCs1 = 1'b0;
	#(lpSclCycle);

	for (i = iSendCnt; i >= 0; i = i - 1)
	begin
		#(lpSysClkCycle * 2);
		rioSpiMosi	= iMiso[i];
		#(lpSysClkCycle * 6);
		rioSpiSck	= 1'b1;
		#(lpSclCycle);
		rioSpiSck	= 1'b0;
	end

	#(lpSclCycle);
	rioSpiCs1 = 1'b1;
end
endtask



//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	#(lpSysClkCycle * 5);
	rSysRst = 0;
	#(lpSysClkCycle * 5);
	SpiMaster();
    #(lpSysClkCycle * 2000 * 4);
    $stop;
end


//----------------------------------------------------------
// Simlation Module Connect
//----------------------------------------------------------
SPIBlock #(
	.pBlockAdrsMap		(8),
	.pAdrsMap			(4),
	.pBusAdrsBit		(15),
	.pBusSlaveConnect	(1)
) SPI_BLOCK (
	// External Port
    .ioSpiSck			(wioSpiSck),
    .ioSpiMiso			(wioSpiMiso),
    .ioSpiMosi			(wioSpiMosi),
    .ioSpiWp			(wioSpiWp),
    .ioSpiHold			(wioSpiHold),
    .oSpiConfigCs		(wSpiConfigCs),
    .ioSpiCs1			(wioSpiCs1),
    .ioSpiCs2			(wioSpiCs2),
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