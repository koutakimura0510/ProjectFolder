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
    output          oI2cScl,
    inout           ioI2CSda,
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
assign oPixelData		= 1'b0;
assign oBackLightControl= 1'b0;
assign oAudioData		= 1'b0;


//----------------------------------------------------------
// バス接続の周辺機能アドレスマップ
//----------------------------------------------------------
localparam lpBlockAdrsMap = 'd8;

localparam [lpBlockAdrsMap-1'b1:0] 
	lpGpioAdrsMap 	= 8'h01,
	lpPWMAdrsMap 	= 8'h02,
	lpSPIAdrsMap	= 8'h03,
	lpI2CAdrsMap	= 8'h04,
	lpPGBAdrsMap	= 8'h05,
	lpAGBAdrsMap	= 8'h06,
	lpVDMAAdrsMap	= 8'h07,
	lpADMAAdrsMap	= 8'h08,
	lpPSRAMAdrsMap 	= 8'h09;


//----------------------------------------------------------
// バス幅を定義
//----------------------------------------------------------
// variable parameter
localparam	[3:0] 	lpBusSlaveConnect  	= 4'd9;		// 接続Slave数、最大16
localparam			lpBusDataBit  		= 32;		// バスデータ幅, 内部計算にも用いるため、bit数のままを指定
localparam	[3:0]	lpBusAdrsBit		= 4'd15;	// バスアドレス幅,内部計算には用いないため、bit数 - 1 を指定

// not variable parameter
localparam	[3:0] 	lpBusSlaveConnectWidth 	= lpBusSlaveConnect - 1'b1;
localparam			lpBusLen  				= (lpBusDataBit * lpBusSlaveConnect) - 1'b1;


//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 					wMUsiRd;
wire [lpBusSlaveConnectWidth:0]	wMUsiVd;
// Master -> Slave
wire [31:0] 			wMUsiWd;
wire [lpBusAdrsBit:0] 	wMUsiAdrs;
wire 					wMUsiWCke;

MicroControllerBlock #(
	.pBusSlaveConnect		(lpBusSlaveConnect),
	.pBusAdrsBit			(lpBusAdrsBit)
) MICRO_CONTROLLER_BLOCK (
	.iUartRx				(iUartRx),
	.oUartTx				(oUartTx),
	.iMUsiRd				(wMUsiRd),
	.iMUsiVd				(wMUsiVd),
	.oMUsiWd				(wMUsiWd),
	.oMUsiAdrs				(wMUsiAdrs),
	.oMUsiWCke				(wMUsiWCke),
	.iSysClk				(iSysClk),
	.iSysRst				(iSysRst)
);


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiGpioRd;
wire 					wSUsiGpioVd;
// Master -> Slave
reg  [31:0] 			qSUsiGpioWd;
reg  [lpBusAdrsBit:0] 	qSUsiGpioAdrs;
reg  					qSUsiGpioWCke;

GpioBlock #(
	.pBlockAdrsMap	(lpBlockAdrsMap),
	.pAdrsMap	 	(lpGpioAdrsMap),
	.pBusAdrsBit	(lpBusAdrsBit)
) GPIO_BLOCK (
	.oLedEdge		(oLedEdge),
	.oLedClk		(oLedClk),
	.oSUsiRd		(wSUsiGpioRd),
	.oSUsiVd		(wSUsiGpioVd),
	.iSUsiWd		(qSUsiGpioWd),
	.iSUsiAdrs		(qSUsiGpioAdrs),
	.iSUsiWCke		(qSUsiGpioWCke),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
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
// 外部コントローラ接続
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiI2CRd;
wire 					wSUsiI2CVd;
// Master -> Slave
reg  [31:0] 			qSUsiI2CWd;
reg  [lpBusAdrsBit:0] 	qSUsiI2CAdrs;
reg  					qSUsiI2CWCke;

I2CBlock #(
	.pBlockAdrsMap	(lpBlockAdrsMap),
	.pAdrsMap	 	(lpGpioAdrsMap),
	.pBusAdrsBit	(lpBusAdrsBit)
) I2C_BLOCK (
	.oI2cScl		(oI2cScl),
	.ioI2CSda		(ioI2CSda),
	.oSUsiRd		(wSUsiI2CRd),
	.oSUsiVd		(wSUsiI2CVd),
	.iSUsiWd		(qSUsiI2CWd),
	.iSUsiAdrs		(qSUsiI2CAdrs),
	.iSUsiWCke		(qSUsiI2CWCke),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

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
reg  [lpBusLen:0]				qSUsiRd;
reg  [lpBusSlaveConnectWidth:0]	qSUsiVd;
// Master -> Slave
wire [31:0] 					wSUsiWd;
wire [lpBusAdrsBit:0] 			wSUsiAdrs;
wire 							wSUsiWCke;

UltraSimpleInterface #(
	.pBusSlaveConnect	(lpBusSlaveConnect),
	.pBusDataBit		(lpBusDataBit),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pGpioAdrsMap		(lpGpioAdrsMap),
	.pPWMAdrsMap		(lpPWMAdrsMap),
	.pSPIAdrsMap		(lpSPIAdrsMap),
	.pI2CAdrsMap		(lpI2CAdrsMap),
	.pPGBAdrsMap		(lpPGBAdrsMap),
	.pAGBAdrsMap		(lpAGBAdrsMap),
	.pVDMAAdrsMap		(lpVDMAAdrsMap),
	.pADMAAdrsMap		(lpADMAAdrsMap),
	.pPSRAMAdrsMap		(lpPSRAMAdrsMap)
) USI_BUS (
	.oMUsiRd			(wMUsiRd),
	.oMUsiVd			(wMUsiVd),
	.iMUsiWd			(wMUsiWd),
	.iMUsiAdrs			(wMUsiAdrs),
	.iMUsiWCke			(wMUsiWCke),
	.oSUsiWd			(wSUsiWd),
	.oSUsiAdrs			(wSUsiAdrs),
	.oSUsiWCke			(wSUsiWCke),
	.iSUsiRd			(qSUsiRd),
	.iSUsiVd			(qSUsiVd),
	.iUsiClk 			(iSysClk),
	.iUsiRst			(iSysRst)
);

always @*
begin
	qSUsiGpioWd		<= wSUsiWd;
	qSUsiGpioAdrs 	<= wSUsiAdrs;
	qSUsiGpioWCke	<= wSUsiWCke;
	qSUsiI2CWd		<= wSUsiWd;
	qSUsiI2CAdrs	<= wSUsiAdrs;
	qSUsiI2CWCke	<= wSUsiWCke;
	qSUsiRd			<= { 'h0, 'h0, 'h0, 'h0, 'h0, wSUsiI2CRd,  'h0, 'h0, wSUsiGpioRd};
	qSUsiVd			<= {1'h0,1'h0,1'h0,1'h0,1'h0, wSUsiI2CVd, 1'h0, 1'h0, wSUsiGpioVd};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule