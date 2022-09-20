`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/09/12
// Author  KoutaKimura
// システム全体の稼働を確認
// 
//----------------------------------------------------------
module BraveFrontierSim;


//-----------------------------------------------------------------------------
// ファイル名
//-----------------------------------------------------------------------------
localparam lpRawFileSave	= "d:/workspace/Xilinx/workspace/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.raw";


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
// TFT Display
//----------------------------------------------------------
localparam	lpHdisplay		= 100;
localparam	lpHfront		= 5;
localparam	lpHback			= 5;
localparam	lpHpulse		= 5;
localparam	lpVdisplay		= 100;
localparam	lpVfront		= 5;
localparam	lpVback			= 4;
localparam	lpVpulse		= 5;
localparam  lpFrameSize		= lpHdisplay * lpVdisplay * 2; // ダブルフレームバッファ構造

wire [7:0] 	wTftColorR;
wire [7:0] 	wTftColorG;
wire [7:0] 	wTftColorB;
wire 		wTftDclk;
wire 		wTftHSync;
wire 		wTftVSync;
wire 		wTftDe;
wire 		wTftBackLight;
wire 		wTftRst;


//----------------------------------------------------------
// RAM
//----------------------------------------------------------
localparam lpRamDqWidth		= 8;
localparam lpMemAdrsWidth	= 19;

reg  [lpRamDqWidth-1:0] 	rMem	[0:lpFrameSize-1];	// RW フレームバッファ領域
reg  [lpRamDqWidth-1:0]		qMemDq;
wire [lpMemAdrsWidth-1:0]	wMemAdrs;
wire [lpRamDqWidth-1:0]		wMemDq;
wire 						wMemOE;
wire 						wMemWE;
wire 						wMemCE;
//
assign wMemDq = qMemDq;

integer i;

initial
begin
	for (i = 0; i < lpFrameSize; i = i + 1)		// 左右半分で色分けしたデータを初期値とする
	begin
		if (i[4:0] < (lpHdisplay/2))
		begin
			rMem[i] <= 12'h0f0;
		end
		else
		begin
			rMem[i] <= 12'hfff;
		end
	end
end


always @*
begin
	casex ({wMemWE, wMemCE})	// フレームバッファにデータを書き込み
		'b00:		rMem[wMemAdrs] <= wMemDq;
		default:	rMem[wMemAdrs] <= rMem[wMemAdrs];
	endcase

	casex ({wMemWE, wMemCE})	// フレームバッファのデータを読み出し
		'b00:		qMemDq <= {lpRamDqWidth{1'bz}};
		'b10:		qMemDq <= rMem[wMemAdrs];
		default:	qMemDq <= {lpRamDqWidth{1'bz}};
	endcase
end

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
		if (wTestPort[1] == 1)	#(lpSclCycle);
		else				break;
	end
end
endtask


//-----------------------------------------------------------------------------
// ファイル書き込み
//-----------------------------------------------------------------------------
wire wSaveEnd;

RawFileSaver #(
	.pRawFileSave (lpRawFileSave)
) RAW_FILE_SAVER (
	.iColorR	(wTftColorR),
	.iColorG	(wTftColorG),
	.iColorB	(wTftColorB),
	.iVde		(wTftDe),
	.iAFE		(wTestPort[0]),
	.oSaveEnd	(wSaveEnd),
	.iRst		(wTestPort[1]),
	.iClk		(wTftDclk)
);

//
task RawWriteWait(
	input integer flag
);
begin
	while (wSaveEnd == flag)
	begin
		#(lpSysClkCycle);
	end
end
endtask

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
localparam lpFrameCnt = 4;
integer n;

initial
begin
	// FPGA Slave
	spi_slave_init();
	reset_init();
	rst_wait();
	spi_cs(1'b0);
	spi_send('h0006_0000);
	spi_send('h0001_0004);
	spi_send('h0000_0000);
	spi_cs(1'b1);
	spi_cs(1'b0);
	spi_send('h0004_0010);
	spi_send('h0001_0004);
	spi_send('h0000_0000);
	spi_cs(1'b1);
	spi_cs(1'b0);
	spi_send('h0004_0010);
	spi_send('h0001_0004);
	spi_send('h0000_000e);
	spi_cs(1'b1);
	spi_cs(1'b0);
	spi_send('h0004_0010);
	spi_send('h0001_0004);
	spi_send('h0000_000c);
	spi_cs(1'b1);

	for (n = 0; n < lpFrameCnt; n = n + 1)
	begin
		RawWriteWait(0);
		RawWriteWait(1);
	end
    $finish;
end


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
BraveFrontier #(
    .pHdisplay      (lpHdisplay),
    .pHback         (lpHfront),
    .pHfront        (lpHback),
    .pHpulse        (lpHpulse),
    .pVdisplay      (lpVdisplay),
    .pVfront        (lpVfront),
    .pVback       	(lpVback),
    .pVpulse        (lpVpulse),
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
	.oTftColorR			(wTftColorR),
	.oTftColorG			(wTftColorG),
	.oTftColorB			(wTftColorB),
	.oTftDclk			(wTftDclk),
	.oTftHSync			(wTftHSync),
	.oTftVSync			(wTftVSync),
	.oTftDe				(wTftDe),
	.oTftBackLight		(wTftBackLight),
	.oTftRst			(wTftRst),
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
