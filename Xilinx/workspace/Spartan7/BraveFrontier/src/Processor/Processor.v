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
reg  [7:0] qCmbSoundRd;
reg  qCmbSoundRdVd;
reg  qCmbSoundSectorCke;
wire [26:0] wCmbSoundAddr;
wire wCmbSoundCke;
wire wCmbSoundCmd;
reg  [4:0] qCmbAction;
wire [15:0] wCmbSoundCh0;
wire [15:0] wCmbSoundCh1;
wire [15:0] wCmbSoundCh2;
wire [15:0] wCmbSoundCh3;
wire [15:0] wCmbSoundCh4;
reg  [ 4:0] qCmbChannelRdy;
wire wCmbWdVdCh0;
wire wCmbWdVdCh1;
wire wCmbWdVdCh2;
wire wCmbWdVdCh3;
wire wCmbWdVdCh4;

cmbWrapper CMB (
    .iSysClk                (iSysClk),
    .iRst                   (iRst),
    .iSoundRd               (qCmbSoundRd),
    .iSoundRdVd             (qCmbSoundRdVd),
    .iSoundSectorCke        (qCmbSoundSectorCke),
    .oSoundAddr             (wCmbSoundAddr),
    .oSoundCke              (wCmbSoundCke),
    .oSoundCmd              (wCmbSoundCmd),
    .iAction                (5'b11111),
    .oSgbSoundCh0           (wCmbSoundCh0),
    .oSgbSoundCh1           (wCmbSoundCh1),
    .oSgbSoundCh2           (wCmbSoundCh2),
    .oSgbSoundCh3           (wCmbSoundCh3),
    .oSgbSoundCh4           (wCmbSoundCh4),
    .iSgbChannelRdy         (qCmbChannelRdy),
    .oSgbWdVdCh0            (wCmbWdVdCh0),
    .oSgbWdVdCh1            (wCmbWdVdCh1),
    .oSgbWdVdCh2            (wCmbWdVdCh2),
    .oSgbWdVdCh3            (wCmbWdVdCh3),
    .oSgbWdVdCh4            (wCmbWdVdCh4)
);



//----------------------------------------------------------
// Sound Generate Block
//----------------------------------------------------------
reg  [15:0] qSgbSoundCh0;
reg  [15:0] qSgbSoundCh1;
reg  [15:0] qSgbSoundCh2;
reg  [15:0] qSgbSoundCh3;
reg  [15:0] qSgbSoundCh4;
reg  qSgbWdVdCh0;
reg  qSgbWdVdCh1;
reg  qSgbWdVdCh2;
reg  qSgbWdVdCh3;
reg  qSgbWdVdCh4;
reg  qSgbCke;
wire [ 4:0] wSgbChannelRdy;

sgbWrapper SGB (
    .iSysClk                (iSysClk),
    .iRst                   (iRst),
    .iSoundCh0              (qSgbSoundCh0),
    .iSoundCh1              (qSgbSoundCh1),
    .iSoundCh2              (qSgbSoundCh2),
    .iSoundCh3              (qSgbSoundCh3),
    .iSoundCh4              (qSgbSoundCh4),
    .iWdVdCh0               (qSgbWdVdCh0),
    .iWdVdCh1               (qSgbWdVdCh1),
    .iWdVdCh2               (qSgbWdVdCh2),
    .iWdVdCh3               (qSgbWdVdCh3),
    .iWdVdCh4               (qSgbWdVdCh4),
    .oChannelRdy            (wSgbChannelRdy),
    .iCke                   (qSgbCke),
    .oSound                 (oSound)
);

always @*
begin
    qCmbChannelRdy  <= wSgbChannelRdy;
    qSgbSoundCh0    <= wCmbSoundCh0;
    qSgbSoundCh1    <= wCmbSoundCh1;
    qSgbSoundCh2    <= wCmbSoundCh2;
    qSgbSoundCh3    <= wCmbSoundCh3;
    qSgbSoundCh4    <= wCmbSoundCh4;
    qSgbWdVdCh0     <= wCmbWdVdCh0;
    qSgbWdVdCh1     <= wCmbWdVdCh1;
    qSgbWdVdCh2     <= wCmbWdVdCh2;
    qSgbWdVdCh3     <= wCmbWdVdCh3;
    qSgbWdVdCh4     <= wCmbWdVdCh4;
    qSgbCke         <= 1'b0;
end


//----------------------------------------------------------
// Update System Block
//----------------------------------------------------------
reg  qUsbWdVd;
reg  qUsbSectorCke;
reg  qUsbBlockCke;
reg  qUsbPdCmdCke;
wire [26:0] wUsbAddr;
wire [ 7:0] wUsbPixelUpDa;
wire wUsbPixelCke;
wire [ 7:0] wUsbSoundUpDa;
wire wUsbSoundCke;
wire wUsbCmd;
wire wUpdatCke;

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
    .oCmd               (wUsbCmd),
    .oUpdateCke         (wUpdatCke)
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
    if (wUpdatCke)
    begin
        qUsbSectorCke       <= wFmcPixelSectorCke | wFmcSoundSectorCke; 
        qUsbBlockCke        <= wFmcPixelWblockCke | wFmcSoundWblockCke; 
        qUsbWdVd            <= wFmcPixelWdVd      | wFmcSoundWdVd;
        qUsbPdCmdCke        <= wFmcPixelPdCmdCke  | wFmcSoundPdCmdCke;
        qCmbSoundRd         <= 1'b0;
        qCmbSoundRdVd       <= 1'b0;
        qCmbSoundSectorCke  <= 1'b0;
        qFmcPixelIn         <= wUsbPixelUpDa;
        qFmcPixelAddr       <= wUsbAddr;
        qFmcPixelCke        <= wUsbPixelCke;
        qFmcPixelCmd        <= wUsbCmd;
        qFmcSoundIn         <= wUsbSoundUpDa;
        qFmcSoundAddr       <= wUsbAddr;
        qFmcSoundCke        <= wUsbSoundCke;
        qFmcSoundCmd        <= wUsbCmd;
    end
    else
    begin
        qUsbSectorCke       <= 1'b0; 
        qUsbBlockCke        <= 1'b0; 
        qUsbWdVd            <= 1'b0;
        qUsbPdCmdCke        <= 1'b0;
        qCmbSoundRd         <= wFmcSoundOut;
        qCmbSoundRdVd       <= wFmcSoundRdVd;
        qCmbSoundSectorCke  <= wFmcSoundSectorCke;
        qFmcPixelIn         <= 0;
        qFmcPixelAddr       <= 0;
        qFmcPixelCke        <= 1'b0;
        qFmcPixelCmd        <= 1'b0;
        qFmcSoundIn         <= 0;
        qFmcSoundAddr       <= wCmbSoundAddr;
        qFmcSoundCke        <= wCmbSoundCke;
        qFmcSoundCmd        <= wCmbSoundCmd;
    end
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