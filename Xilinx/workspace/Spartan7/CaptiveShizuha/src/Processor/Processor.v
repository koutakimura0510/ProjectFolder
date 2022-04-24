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
    output [2:0]    oUnusedPin,     // not pin
    output          oApdsScl,       // APDS I2C SCL
    inout           ioApdsSda,      // APDS I2C SDA
    input           iApdsIntr,      // APDS Interrupt / Open Drain Active Low
    output [1:0]    oQspiCs,        // Qspi Mode Cs   / Spi Mode Cs   Low Active
    output [1:0]    oQspiSck,       // Qspi Mode Clk  / Spi Mode Clk
    output [1:0]    ioQspiDq0,      // Qspi Mode DQ 0 / Spi Mode MOSI
    input  [1:0]    ioQspiDq1,      // Qspi Mode DQ 1 / Spi Mode MISO
    output [1:0]    ioQspiDq2,      // Qspi Mode DQ 2 / Spi Mode Wp   Low Active
    output [1:0]    ioQspiDq3,      // Qspi Mode DQ 3 / Spi Mode Hold Low Active
    input           iUartRx,        // Debug use Uart
    output          oUartTx,        // Debug use Uart
    input           iPFvde,         // Pixel Clk Timing fast video enable
    output [23:0]   oPixel          // Display Pixel Data
);


//---------------------------------------------------------------------------
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
// UART
// iUartRx
assign oUartTx      = 1'b1;

//
assign oUnusedPin   = 3'd0;
assign oApdsScl     = 1'b1;
assign ioApdsSda    = 1'bz;

//----------------------------------------------------------
// Ultra Simple Interface Bus
//----------------------------------------------------------


//----------------------------------------------------------
// Spi Rom Control Block
//----------------------------------------------------------
srcWrapper #(
    .pClkDiv (400)
) SRC (
    .oQspiCs        (oQspiCs),
    .oQspiSck       (oQspiSck),
    .ioQspiDq0      (ioQspiDq0),
    .ioQspiDq1      (ioQspiDq1),
    .ioQspiDq2      (ioQspiDq2),
    .ioQspiDq3      (ioQspiDq3),
    .oPixel         (),
    .iPixelAddr     (0),
    .iPixelCke      (0),
    .oPixelVd       (),
    .oSound         (),
    .iSoundAddr     (0),
    .iSoundCke      (0),
    .oSoundVd       ()
);

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
) PGB (
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
wire [23:0] wRD;            assign oPixel = wRD;
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