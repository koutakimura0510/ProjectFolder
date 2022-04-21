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
    parameter       pBuffDepth    = 1024
)(
    input           iPixelClk,      // Pixel Clk
    input           iSysClk,        // System Clk
    input           iRst,           // Active High Sync Reset
    output [1:0]    oApdsScl,       // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt / Open Drain Active Low
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    inout  [1:0]    ioQspiDq0,      // SPI時 MOSI
    inout  [1:0]    ioQspiDq1,      // SPI時 MISO
    inout  [1:0]    ioQspiDq2,      // SPI時 High 固定, 書き込み保護 Low Active
    inout  [1:0]    ioQspiDq3,      // SPI時 High 固定, 書き込み停止 Low Active
    input           iUartRx,        // Uart
    output          oUartTx,        // Uart
    input           iPFvde,         // Pixel Clk Timing fast video enable
    output [23:0]   oVRGB
);


//---------------------------------------------------------------------------
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
// UART
// iUartRx
assign oUartTx      = 1'b1;

// APDS
assign oApdsScl     = 2'b11;
assign ioApdsSda    = 2'bzz;
assign oQspiCs      = 2'b11;
assign oQspiSck     = 2'b00;
assign ioQspiDq0    = 2'b00;
assign ioQspiDq1    = 2'bzz;
assign ioQspiDq2    = 2'b00;
assign ioQspiDq3    = 2'b00;


//----------------------------------------------------------
// Ultra Simple Interface Bus
//----------------------------------------------------------


//----------------------------------------------------------
// Spi Rom Control Block
//----------------------------------------------------------


//----------------------------------------------------------
// APDS9960 Control Block
//----------------------------------------------------------


//----------------------------------------------------------
// Position Generate Block
//----------------------------------------------------------
// pgbWrapper #(
// .iSysClk
// ) PGB (
// 
// );


//----------------------------------------------------------
// Pixel Generate Block
//----------------------------------------------------------
reg  qCkeDgb;
wire [23:0] wPiDgb;
wire wVdDgb;

pgbWrapper #(
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelWidth    (24),
    .pPixelDebug    (pPixelDebug)
) DGB (
    .iSysClk       (iSysClk),
    .iRst           (iRst),
    .iCKE           (qCkeDgb),
    .oPixel         (wPiDgb),
    .oVd            (wVdDgb),
    .oFe            ()
);


//----------------------------------------------------------
// Pixel Operation Block 
//----------------------------------------------------------
// robWrapper #(

// ) ROB (

// );

//----------------------------------------------------------
// Pixel Async Fifo Block
//----------------------------------------------------------
wire [23:0] wRD;            assign oVRGB = wRD;
wire wFull;

pfbWrapper #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (24)
) PFB (
    .iSysClk       (iSysClk),
    .iPixelClk      (iPixelClk),
    .iRst           (iRst),
    .iWD            (wPiDgb),
    .oRD            (wRD),
    .iWE            (wVdDgb),
    .iRE            (iPFvde),
    .oFull          (wFull)
);

always @*
begin
    qCkeDgb <= (~wFull);
end

endmodule