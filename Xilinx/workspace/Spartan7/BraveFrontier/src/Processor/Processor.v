//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer #(
    parameter       pHdisplay     = 640,
    parameter       pVdisplay     = 480,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024,
    parameter       pDebug        = "off"
)(
    // External port
    // SPI
    output          ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    output          oSpiCs1,
    output          oSpiCs2,
    // PSRAM
    inout  [15:0]   ioSrampDq,
    inout  [1:0]    ioSrampDqs,
    output          oSrampClk,
    output          oSrampCs,
    inout  [15:0]   ioSramsDq,
    inout  [1:0]    ioSramsDqs,
    output          oSramsClk,
    output          oSramsCs,
    // I2C
    output          oSwScl,
    inout           ioSwSda,
    // UART
    output          oUartTx,
    input           iUartRx,
    // LED
    output [1:0]    oLedEdge,
    output          oLedClk,
    // Internal Port
    // Video
    input           iPFvde,
    output [15:0]   oPixelData,
    output          oBackLightControl,
    // Audio
    input           iAudioLRch,
    output [31:0]   oAudioData,
    // CLK Reset
    input           iSysClk,
    input           iPixelClk,
    input           iMemClk,
    input           iAudioClk,
    input           iSysRst,
    input           iAudioRst
);

// 
assign ioSpiSck      	= 1'bz;
assign ioSpiMiso    	= 1'bz;
assign ioSpiMosi    	= 1'bz;
assign ioSpiWp      	= 1'bz;
assign ioSpiHold    	= 1'bz;
assign oSpiConfigCs 	= 1'b0;
assign oSpiCs1      	= 1'b0;
assign oSpiCs2      	= 1'b0;
assign ioSrampDqs		= 2'bz;
assign oSrampClk		= 1'b0;
assign oSrampCs			= 1'b0;
assign ioSramsDqs		= 2'bz;
assign oSramsClk		= 1'b0;
assign oSramsCs			= 1'b0;
assign oSwScl			= 1'b0;
assign ioSwSda			= 1'bz;
assign oPixelData		= 1'b0;
assign oBackLightControl= 1'b0;
assign oAudioData		= 1'b0;


//----------------------------------------------------------
// バス幅を定義
//----------------------------------------------------------
// variable parameter
localparam  [3:0] 	pBusNum   = 4'd9;
localparam			pBusBit	  = 32;

// not variable parameter
localparam  [3:0] 	pBusWidth = pBusNum - 1'b1;
localparam			pBusLen	  = (pBusBit * pBusNum) - 1'b1;

//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 		wMUsiRd;
wire [pBusWidth:0]	wMUsiVd;
// Master -> Slave
wire [31:0] wMUsiWd,wMUsiAdrs;
wire wMUsiWCke;

MicroControllerBlock #(
	.pBusNum	(pBusNum)
) MCB (
	.iUartRx	(iUartRx),
	.oUartTx	(oUartTx),
	.iMUsiRd	(wMUsiRd),
	.iMUsiVd	(wMUsiVd),
	.oMUsiWd	(wMUsiWd),
	.oMUsiAdrs	(wMUsiAdrs),
	.oMUsiWCke	(wMUsiWCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] wSUsiGpioRd;
wire 		wSUsiGpioVd;
// Master -> Slave
reg  [31:0] qSUsiGpioWd;
reg  [31:0] qSUsiGpioAdrs;
reg  		qSUsiGpioWCke;

GpioBlock GPIO_BLOCK (
	.oLedEdge	(oLedEdge),
	.oLedClk	(oLedClk),
	.oSUsiRd	(wSUsiGpioRd),
	.oSUsiVd	(wSUsiGpioVd),
	.iSUsiWd	(qSUsiGpioWd),
	.iSUsiAdrs	(qSUsiGpioAdrs),
	.iSUsiWCke	(qSUsiGpioWCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

//----------------------------------------------------------
// PWM BackLight
//----------------------------------------------------------
// PWMBlock PWM_BLOCK

//----------------------------------------------------------
// Flash Memory Block
//----------------------------------------------------------
// SPIBlock SPI_BLOCK

//----------------------------------------------------------
// SW
//----------------------------------------------------------
// I2CBlock I2C1_BLOCK()

//----------------------------------------------------------
// PGB
//----------------------------------------------------------
// PixelGenBlock PGB

//----------------------------------------------------------
// AGB
//----------------------------------------------------------
// AudioGenBlock AGB

//----------------------------------------------------------
// VDMA
//----------------------------------------------------------
// VDMABlock VDMA ()

//----------------------------------------------------------
// ADMA
//----------------------------------------------------------
// ADMABlock ADMA ()

//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// PSRAMBlock PSRAM_BLOCK

//----------------------------------------------------------
// USI/F BUS
//----------------------------------------------------------
// Slave -> Master
reg  [pBusLen:0]	qSUsiRd;
reg  [pBusWidth:0]	qSUsiVd;
// Master -> Slave
wire [31:0] 		wSUsiWd;
wire [31:0] 		wSUsiAdrs;
wire 				wSUsiWCke;

UltraSimpleInterface #(
	.pBusNum	(pBusNum),
	.pBusBit	(pBusBit)
) USI_BUS (
	.oMUsiRd	(wMUsiRd),
	.oMUsiVd	(wMUsiVd),
	.iMUsiWd	(wMUsiWd),
	.iMUsiAdrs	(wMUsiAdrs),
	.iMUsiWCke	(wMUsiWCke),
	.oSUsiWd	(wSUsiWd),
	.oSUsiAdrs	(wSUsiAdrs),
	.oSUsiWCke	(wSUsiWCke),
	.iSUsiRd	(qSUsiRd),
	.iSUsiVd	(qSUsiVd),
	.iUsiClk 	(iSysClk),
	.iUsiRst	(iSysRst)
);

always @*
begin
	qSUsiGpioWd		<= wSUsiWd;
	qSUsiGpioAdrs 	<= wSUsiAdrs;
	qSUsiGpioWCke	<= wSUsiWCke;
	qSUsiRd			<= {pBusNum{wSUsiGpioRd}};
	qSUsiVd			<= {pBusNum{wSUsiGpioVd}};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule