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
    input           iUartRx,        // use Uart
    output          oUartTx,        // use Uart
    input           iPFvde,         // Pixel Clk Timing fast video enable
    output [23:0]   oPixel,         // Display Pixel Data
    input           iSoundCke,      // Sound Valid
    output [15:0]   oSound          // Sound Data
);


//---------------------------------------------------------------------------
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
assign oUnusedPin   = 3'd0;
assign oApdsScl     = 1'b1;
assign ioApdsSda    = 1'bz;


//----------------------------------------------------------
// Core Master Block
//----------------------------------------------------------
// cmbWrapper CMB (

// );


//----------------------------------------------------------
// Sound Generate Block
//----------------------------------------------------------
assign oSound = 0;

// sgbWrapper (

// );


//----------------------------------------------------------
// Ultra Simple Interface Bus
//----------------------------------------------------------



//----------------------------------------------------------
// Update System Block
//----------------------------------------------------------
wire [26:0] wUsbAddr;
wire [ 7:0] wUsbPixelUpDa;
wire wUsbPixelCke;
wire [ 7:0] wUsbSoundUpDa;
wire wUsbSoundCke;
wire wUsbCmd;
reg  qUsbWdVd;
reg  qUsbSectorCke;
reg  qUsbBlockCke;
reg  qUsbPdCmdCke;

usbWrapper #(
    .pClkDiv            (868),
    .pBitLen            (8),
    .pDebug             (pDebug)
) USB (
    .iSysClk            (iSysClk),
    .iRst               (iRst),
    .iUartRx            (iUartRx),
    .oUartTx            (oUartTx),
    .iWdVd              (qUsbWdVd),
    .iSectorCke         (qUsbSectorCke),
    .iBlockCke          (qUsbBlockCke),
    .iPdCmdCke          (qUsbPdCmdCke),
    .oAddr              (wUsbAddr),
    .oPixelUpdate       (wUsbPixelUpDa),
    .oPixelCke          (wUsbPixelCke),
    .oSoundUpdate       (wUsbSoundUpDa),
    .oSoundCke          (wUsbSoundCke),
    .oCmd               (wUsbCmd)
);


//----------------------------------------------------------
// Spi Rom Control Block
//----------------------------------------------------------
reg  [ 7:0] qFmcPixelIn;
wire [ 7:0] wFmcPixelOut;
reg  [26:0] qFmcPixelAddr;
reg  qFmcPixelCke;
reg  qFmcPixelCmd;
wire wFmcPixelWdVd;
wire wFmcPixelRdVd;
wire wFmcPixelSectorCke;
wire wFmcPixelWblockCke;
wire wFmcPixelPdCmdCke;

reg  [ 7:0] qFmcSoundIn;
wire [ 7:0] wFmcSoundOut;
reg  [26:0] qFmcSoundAddr;
reg  qFmcSoundCke;
reg  qFmcSoundCmd;
wire wFmcSoundWdVd;
wire wFmcSoundRdVd;
wire wFmcSoundSectorCke;
wire wFmcSoundWblockCke;
wire wFmcSoundPdCmdCke;

fmcWrapper #(
    .pClkDiv            (3),
    .pSector            (2048),
    .pPage              (64),
    .pBlock             (1024),
    .pHoldTime          (1),
    .pMode              ("mode0")
) FMC (
    .iSysClk            (iSysClk),
    .iRst               (iRst),
    .oQspiCs            (oQspiCs),
    .oQspiSck           (oQspiSck),
    .ioQspiDq0          (ioQspiDq0),
    .ioQspiDq1          (ioQspiDq1),
    .ioQspiDq2          (ioQspiDq2),
    .ioQspiDq3          (ioQspiDq3),
    .iPixel             (qFmcPixelIn),
    .oPixel             (wFmcPixelOut),
    .iPixelAddr         (qFmcPixelAddr),
    .iPixelCke          (qFmcPixelCke),
    .iPixelCmd          (qFmcPixelCmd),
    .oPixelWdVd         (wFmcPixelWdVd),
    .oPixelRdVd         (wFmcPixelRdVd),
    .oPixelSectorCke    (wFmcPixelSectorCke),
    .oPixelWblockCke    (wFmcPixelWblockCke),
    .oPixelPdCmdCke     (wFmcPixelPdCmdCke),
    .iSound             (qFmcSoundIn),
    .oSound             (wFmcSoundOut),
    .iSoundAddr         (qFmcSoundAddr),
    .iSoundCke          (qFmcSoundCke),
    .iSoundCmd          (qFmcSoundCmd),
    .oSoundWdVd         (wFmcSoundWdVd),
    .oSoundRdVd         (wFmcSoundRdVd),
    .oSoundSectorCke    (wFmcSoundSectorCke),
    .oSoundWblockCke    (wFmcSoundWblockCke),
    .oSoundPdCmdCke     (wFmcSoundPdCmdCke)
);

always @*
begin
    qUsbSectorCke   <= wFmcPixelSectorCke | wFmcSoundSectorCke; 
    qUsbBlockCke    <= wFmcPixelWblockCke | wFmcSoundWblockCke; 
    qUsbWdVd        <= wFmcPixelWdVd      | wFmcSoundWdVd;
    qUsbPdCmdCke    <= wFmcPixelPdCmdCke  | wFmcSoundPdCmdCke;
    qFmcPixelIn     <= wUsbPixelUpDa;
    qFmcPixelAddr   <= wUsbAddr;
    qFmcPixelCke    <= wUsbPixelCke;
    qFmcPixelCmd    <= wUsbCmd;
    qFmcSoundIn     <= wUsbSoundUpDa;
    qFmcSoundAddr   <= wUsbAddr;
    qFmcSoundCke    <= wUsbSoundCke;
    qFmcSoundCmd    <= wUsbCmd;
end


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
reg  qPgbCke;
wire [23:0] wPgbPi;
wire wPgbVd;

pgbWrapper #(
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelWidth    (24),
    .pPixelDebug    (pPixelDebug)
) PGB (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iCKE           (qPgbCke),
    .oPixel         (wPgbPi),
    .oVd            (wPgbVd),
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
wire [23:0] wPfbRd;            assign oPixel = wPfbRd;
reg  [23:0] qPfbPi;
reg  qPfbVd;
wire wPfbFull;

pfbWrapper #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (24)
) PFB (
    .iSysClk        (iSysClk),
    .iPixelClk      (iPixelClk),
    .iRst           (iRst),
    .iWD            (qPfbPi),
    .oRD            (wPfbRd),
    .iWE            (qPfbVd),
    .iRE            (iPFvde),
    .oFull          (wPfbFull)
);

always @*
begin
    qPfbVd  <= wPgbVd;
    qPfbPi  <= wPgbPi;
    qPgbCke <= (~wPfbFull);
end

endmodule