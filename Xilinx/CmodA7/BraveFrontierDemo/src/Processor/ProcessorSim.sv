`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/09/12
// Author  KoutaKimura
// システム全体の稼働を確認
// 
//----------------------------------------------------------
module BraveFrontierSim;


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 4;	// CLK サイクル


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
endtask


//----------------------------------------------------------
// Spi
//----------------------------------------------------------
reg rioSpiSck		= 1'b0;
reg rioSpiMiso		= 1'bz;
reg rioSpiMosi		= 1'b0;
reg rioSpiWp		= 1'b1;
reg rioSpiHold		= 1'b1;
reg rioSpiCs		= 1'b1;
reg riMSSel			= 1'b1;
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
//
wire wMSpiIntr;
wire wMUsiSel;

// テストベンチ master / FPGA Slave 設定
// 
// FPGA SPI Slave の仕様
// 4byte Adrs + Cmd + 2byte Data Length + dummy + nData... 
// -
// 最初に 8byte の命令シーケンスを受信する
// Cmd : 0. Non, 1. Csr Write, 2. Csr Read, 3. PSRAM Write
// -
// Csr 操作時は 連続アクセスは可能としない、必ず Data Length は 4byte 固定とする
// PSRAM 操作時は Data Length は最大 2048 byte とする
localparam lpSclCycle = (lpSysClkCycle * 8);
integer i;

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

	for (i = 31; i >= 0; i = i - 1)
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

// FPGA Slave 設定
task spi_slave_init;
begin
	rioSpiSck		= 1'b0;
	rioSpiMiso		= 1'bz;
	rioSpiMosi		= 1'b0;
	rioSpiWp		= 1'b1;
	rioSpiHold		= 1'b1;
	rioSpiCs		= 1'b1;
	riMSSel			= 1'b1;
end
endtask

// FPGA Master 設定
task spi_master_init;
begin
	rioSpiSck		= 1'bz;
	rioSpiMiso		= 1'b0;
	rioSpiMosi		= 1'bz;
	rioSpiWp		= 1'bz;
	rioSpiHold		= 1'bz;
	rioSpiCs		= 1'bz;
	riMSSel			= 1'b0;
end
endtask


//----------------------------------------------------------
// RAM
//----------------------------------------------------------
wire [18:0] wMemAdrs;
wire [ 7:0] wMemDq;
wire 		wMemOE;
wire 		wMemWE;
wire 		wMemCE;


//----------------------------------------------------------
// TFT Display
//----------------------------------------------------------
wire [7:4] oTftColorR;
wire [7:4] oTftColorG;
wire [7:4] oTftColorB;
wire oTftDclk;
wire oTftHSync;
wire oTftVSync;
wire oTftDe;
wire oTftBackLight;
wire oTftRst;

//----------------------------------------------------------
// I2C
//----------------------------------------------------------
reg  rSwSda  = 0;
wire oI2CScl;
wire ioI2CSda;               assign ioI2CSda = rSwSda;

always @(posedge rSysClk)
begin
    rSwSda   <= 1'dz;
end

//----------------------------------------------------------
// Audio
//----------------------------------------------------------
wire oAudioMclk;


//----------------------------------------------------------
// Led
//----------------------------------------------------------
wire oLedEdge;
wire oLedClk;


//-----------------------------------------------------------------------------
// TestPort
//-----------------------------------------------------------------------------
wire [3:0] wTestPort;

task rst_wait;
begin
	while (1)
	begin
		if (wTestPort[0] == 1)	#(lpSclCycle);
		else				break;
	end
end
endtask


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	// FPGA Slave
	spi_slave_init();
	reset_init();
	rst_wait();
	spi_cs(1'b0);
	spi_send('h0000_9999);
	spi_send('h0003_0004);
	spi_send('h0000_00aa);
	spi_cs(1'b1);
	spi_cs(1'b0);
	spi_send('h0000_0004);
	spi_send('h0004_0004);
	spi_send('h0000_0000);
	spi_cs(1'b1);
    $stop;
end


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
BraveFrontier #(
    // .H_DISPLAY  (640),      .H_BACK     (48),
    // .H_FRONT    (16),       .H_SYNC     (96),
    // .V_DISPLAY  (480),      .V_TOP      (31),
    // .V_BOTTOM   (11),       .V_SYNC     (2),
    .pHdisplay      (50),
    .pHback         (2),
    .pHfront        (2),
    .pHpulse        (2),
    .pVdisplay      (50),
    .pVfront        (2),
    .pVback       	(2),
    .pVpulse        (2),
    .pPixelDebug    ("no"),
    .pBuffDepth     (32),
    .pDebug         ("off")
) TOP (
    .iOscSystemClk      (rSysClk),
	.ioSpiSck			(wioSpiSck),
	.ioSpiMiso			(wioSpiMiso),
	.ioSpiMosi			(wioSpiMosi),
	.ioSpiWp			(wioSpiWp),
	.ioSpiHold			(wioSpiHold),
	.oSpiConfigCs		(wSpiConfigCs),
	.ioSpiCs			(wioSpiCs),
	.iMSSel				(riMSSel),
	.oMemAdrs			(wMemAdrs),
	.ioMemDq			(wMemDq),
	.oMemOE				(wMemOE),
	.oMemWE				(wMemWE),
	.oMemCE				(wMemCE),
	.oTftColorR			(),
	.oTftColorG			(),
	.oTftColorB			(),
	.oTftDclk			(),
	.oTftHSync			(),
	.oTftVSync			(),
	.oTftDe				(),
	.oTftBackLight		(),
	.oTftRst			(),
	.oI2CScl			(),
	.ioI2CSda			(),
	.oAudioMclk			(oAudioMclk),
	.oLed				(),
	.oLedB				(),
	.oLedG				(),
	.oLedR				(),
	.oTestPort			(wTestPort)
);

endmodule
