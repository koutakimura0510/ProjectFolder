`timescale 1ns / 1ps
/*
 * Create 2022/6/26
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * 
 */
module BraveFrontierSim;



//----------------------------------------------------------
// comment
//----------------------------------------------------------
parameter CYCLE = 20;
reg rSysClk     = 0;
reg rAudioClk   = 0;


//----------------------------------------------------------
// SPI 
//----------------------------------------------------------
reg  rSpiMiso   = 1'bz;
reg  rSpiMosi   = 1'bz;
reg  rSpiWp     = 1'bz;
reg  rSpiHold   = 1'bz;
wire ioSpiMiso;             assign ioSpiMiso = rSpiMiso;
wire ioSpiMosi;             assign ioSpiMosi = rSpiMosi;
wire ioSpiWp;               assign ioSpiWp   = rSpiWp;
wire ioSpiHold;             assign ioSpiHold = rSpiHold;
wire oSpiConfigCs;
wire oSpiCs;

always @(posedge rSysClk)
begin
    rSpiMiso    <= 1'bz;
    rSpiMosi    <= 1'bz;
    rSpiWp      <= 1'bz;
    rSpiHold    <= 1'bz;
end


//----------------------------------------------------------
// PSRAM
//----------------------------------------------------------
reg  [15:0] rSrampDq    = 16'dz;
reg  [1:0]  rSrampDqs   = 2'dz;
wire [15:0] ioSramDq;      assign ioSramDq  = rSrampDq;
wire [1:0]  ioSramDqs;     assign ioSramDqs = rSrampDqs;
wire oSramClk;
wire oSramCs;

reg  [15:0] rSramsDq    = 16'dz;
reg  [1:0]  rSramsDqs   = 2'dz;
wire [15:0] ioSramsDq;      assign ioSramsDq  = rSramsDq;
wire [1:0]  ioSramsDqs;     assign ioSramsDqs = rSramsDqs;
wire oSramsClk;
wire oSramsCs;

always @(posedge rSysClk)
begin
    rSrampDq    <= 16'dz;
    rSrampDqs   <= 2'dz;
    rSramsDq    <= 16'dz;
    rSramsDqs   <= 2'dz;
end


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
wire oAudioBclk;
wire oAudioCclk;
wire oAudioData;

//----------------------------------------------------------
// Uart
//----------------------------------------------------------
wire oUartTx;
reg  rUartRx    = 0;

//----------------------------------------------------------
// Led
//----------------------------------------------------------
wire oLedEdge;
wire oLedClk;


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
wire oAudio;

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
	.ioSpiSck			(),
	.ioSpiMiso			(),
	.ioSpiMosi			(),
	.ioSpiWp			(),
	.ioSpiHold			(),
	.oSpiConfigCs		(),
	.ioSpiCs			(),
	.iMSSel				(),
	.oMemAdr			(),
	.ioMemDq			(),
	.oRamOE				(),
	.oRamWE				(),
	.oRamCE				(),
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
	.oAudioMclk			(oAudio),
	.oLed				(),
	.oLedB				(),
	.oLedG				(),
	.oLedR				(),
	.oTestPort			()
);

always begin
    #(CYCLE/5);
    rSysClk = ~rSysClk;
end

initial begin
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
