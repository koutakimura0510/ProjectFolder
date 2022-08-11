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
    input			ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    input	        ioSpiCs1,
    input	        ioSpiCs2,
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
    output          oI2CScl,
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
assign ioSrampDqs		= 2'bz;
assign oSrampClk		= 1'b0;
assign oSrampCs			= 1'b0;
assign ioSramsDqs		= 2'bz;
assign oSramsClk		= 1'b0;
assign oSramsCs			= 1'b0;
assign oPixelData		= 1'b0;
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
localparam	lpBusSlaveConnect  	= 4'd9;		// 接続Slave数、最大16
localparam	lpBusDataBit  		= 32;		// バスデータ幅
localparam	lpBusAdrsBit		= 16;		// バスアドレス幅


//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 					wMUsiMcbRd;
wire [lpBusSlaveConnect-1:0]	wMUsiMcbVd;
// Master -> Slave
wire [31:0] 					wMUsiMcbWd;
wire [lpBusAdrsBit-1:0]			wMUsiMcbAdrs;
wire 							wMUsiMcbWCke;

MicroControllerBlock #(
	.pBusSlaveConnect	(lpBusSlaveConnect),
	.pBusAdrsBit		(lpBusAdrsBit)
) MICRO_CONTROLLER_BLOCK (
	.iUartRx			(iUartRx),
	.oUartTx			(oUartTx),
	.iMUsiRd			(wMUsiMcbRd),
	.iMUsiVd			(wMUsiMcbVd),
	.oMUsiWd			(wMUsiMcbWd),
	.oMUsiAdrs			(wMUsiMcbAdrs),
	.oMUsiWEd			(wMUsiMcbWCke),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiGpioRd;
wire 					wSUsiGpioVd;
// Master -> Slave
reg  [31:0] 			qSUsiGpioWd;
reg  [lpBusAdrsBit-1:0] qSUsiGpioAdrs;
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
// Slave -> Master
wire [31:0] 			wSUsiPWMRd;
wire 					wSUsiPWMVd;
// Master -> Slave
reg  [31:0] 			qSUsiPWMWd;
reg  [lpBusAdrsBit-1:0]	qSUsiPWMAdrs;
reg  					qSUsiPWMWCke;

PWMBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpPWMAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit)
	.pBusSlaveConnect	(),
) PWM_BLOCK (
	.oPwm				(oBackLightControl),
	.oSUsiRd			(wSUsiPWMRd),
	.oSUsiVd			(wSUsiPWMVd),
	.iSUsiWd			(qSUsiPWMWd),
	.iSUsiAdrs			(qSUsiPWMAdrs),
	.iSUsiWCke			(qSUsiPWMWCke),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 					wMUsiSpiRd;
wire [lpBusSlaveConnect-1:0]	wMUsiSpiVd;
wire [31:0] 					wSUsiSpiRd;
wire 							wSUsiSpiVd;
// Master -> Slave
wire [31:0] 					wMUsiSpiWd;
wire [lpBusAdrsBit-1:0]			wMUsiSpiAdrs;
wire 							wMUsiSpiWCke;
reg  [31:0] 					qSUsiSpiWd;
reg  [lpBusAdrsBit-1:0]			qSUsiSpiAdrs;
reg  							qSUsiSpiWCke;
// Master Select
wire 							wMUsiMonopoly;

SPIBlock #(
	.pBlockAdrsMap				(lpBlockAdrsMap),
	.pAdrsMap	 				(lpSPIAdrsMap),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pBusSlaveConnect			(lpBusSlaveConnect)
) SPI_BLOCK (
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs1					(ioSpiCs1),
	.ioSpiCs2					(ioSpiCs2),
	.oMUsiMonopoly				(wMUsiMonopoly),

	.iMUsiRd					(wMUsiSpiRd),
	.iMUsiVd					(wMUsiSpiVd),
	.oMUsiWd					(wMUsiSpiWd),
	.oMUsiAdrs					(wMUsiSpiAdrs),
	.oMUsiWEd					(wMUsiSpiWCke),

	.oSUsiRd					(wSUsiSpiRd),
	.oSUsiVd					(wSUsiSpiVd),
	.iSUsiWd					(qSUsiSpiWd),
	.iSUsiAdrs					(qSUsiSpiAdrs),
	.iSUsiWCke					(qSUsiSpiWCke),
	.iSysClk					(iSysClk),
	.iSysRst					(iSysRst)
);


//----------------------------------------------------------
// 外部コントローラ接続
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiI2CRd;
wire 					wSUsiI2CVd;
// Master -> Slave
reg  [31:0] 			qSUsiI2CWd;
reg  [lpBusAdrsBit-1:0]	qSUsiI2CAdrs;
reg  					qSUsiI2CWCke;

I2CBlock #(
	.pBlockAdrsMap	(lpBlockAdrsMap),
	.pAdrsMap	 	(lpGpioAdrsMap),
	.pBusAdrsBit	(lpBusAdrsBit)
) I2C_BLOCK (
	.oI2CScl		(oI2CScl),
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
// not variable parameter
localparam	lpBusLen = (lpBusDataBit * lpBusSlaveConnect) - 1'b1;

// Slave -> Master
wire [31:0] 					wMUsiRd;
wire [lpBusSlaveConnect-1:0]	wMUsiVd;
reg  [lpBusLen:0]				qSUsiRd;
reg  [lpBusSlaveConnect-1:0]	qSUsiVd;
// Master -> Slave
reg  [31:0]						qMUsiWd;
reg  [lpBusAdrsBit-1:0] 		qMUsiAdrs;
reg  							qMUsiWEd;
wire [31:0] 					wSUsiWd;
wire [lpBusAdrsBit-1:0] 		wSUsiAdrs;
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
	.iMUsiWd			(qMUsiWd),
	.iMUsiAdrs			(qMUsiAdrs),
	.iMUsiWEd			(qMUsiWEd),
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
	wMUsiMcbRd		<= wMUsiRd;
	wMUsiMcbVd		<= wMUsiVd;
	wMUsiSpiRd		<= wMUsiRd;
	wMUsiSpiVd		<= wMUsiVd;
	//
	qMUsiWd			<= wMUsiMonopoly ? wMUsiMcbWd	: wMUsiSpiWd;
	qMUsiAdrs		<= wMUsiMonopoly ? wMUsiMcbAdrs	: wMUsiSpiAdrs;
	qMUsiWEd		<= wMUsiMonopoly ? wMUsiMcbWCke	: wMUsiSpiWCke;
	//
	qSUsiGpioWd		<= wSUsiWd;
	qSUsiGpioAdrs 	<= wSUsiAdrs;
	qSUsiGpioWCke	<= wSUsiWCke;
	//
	qSUsiPWMWd		<= wSUsiWd;
	qSUsiPWMAdrs	<= wSUsiAdrs;
	qSUsiPWMWCke	<= wSUsiWCke;
	//
	qSUsiSpiWd		<= wSUsiWd;
	qSUsiSpiAdrs	<= wSUsiAdrs;
	qSUsiSpiWCke	<= wSUsiWCke;
	//
	qSUsiI2CWd		<= wSUsiWd;
	qSUsiI2CAdrs	<= wSUsiAdrs;
	qSUsiI2CWCke	<= wSUsiWCke;
	//
	qSUsiRd			<= {{5{32'd0}}, wSUsiI2CRd, wSUsiSpiRd, wSUsiPWMRd, wSUsiGpioRd};
	qSUsiVd			<= {{5{1'h0}},  wSUsiI2CVd, wSUsiSpiVd, wSUsiPWMVd, wSUsiGpioVd};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule