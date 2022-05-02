`timescale 1ns / 1ps
/*
 * Create 2021/12/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * hdmi video timing テストベンチ
 */
module CaptiveShizuhaSim;

parameter CYCLE = 10;

reg rClk     = 0;


// APDS9960
wire rApdsIntr  = 0; 
wire oApdsScl;
wire ioApdsSda;

// QSPI
reg  [1:0] rQspiDq1 = 2'b11;
wire [1:0] oQspiCs;
wire [1:0] oQspiSck;
wire [1:0] ioQspiDq0;
wire [1:0] ioQspiDq2;
wire [1:0] ioQspiDq3;


// HDMI
reg  rHdmiHpd = 0;
reg  rHdmiSda = 1;
reg  rHdmiCec = 0;
wire oHdmiScl;
wire ioHdmiSda;             assign ioHdmiSda = rHdmiSda;
wire ioHdmiCec;             assign ioHdmiCec = rHdmiCec;
wire oHdmiClkNeg, oHdmiClkPos;
wire [2:0] oHdmiDataNeg, oHdmiDataPos;

// DEBUG
reg  rUartRx  = 0;
wire oUartTx;
wire [1:0] oLED;
wire [2:0] oUnusedPin;

CaptiveShizuhaTop #(
    // .H_DISPLAY  (640),      .H_BACK     (48),
    // .H_FRONT    (16),       .H_SYNC     (96),
    // .V_DISPLAY  (480),      .V_TOP      (31),
    // .V_BOTTOM   (11),       .V_SYNC     (2),
    .pHdisplay      (50),
    .pHback         (2),
    .pHfront        (2),
    .pHsync         (2),
    .pVdisplay      (50),
    .pVtop          (2),
    .pVbottom       (2),
    .pVsync         (2),
    .pPixelDebug    ("yes"),
    .pBuffDepth     (32),
    .pDebug         ("on")
) TOP (
    .iClk           (rClk),
    .oUnusedPin     (oUnusedPin),
    .oApdsScl       (oApdsScl),
    .ioApdsSda      (ioApdsSda),
    .iApdsIntr      (rApdsIntr),
    .oQspiCs        (oQspiCs),
    .oQspiSck       (oQspiSck),
    .ioQspiDq0      (ioQspiDq0),
    .ioQspiDq1      (rQspiDq1),
    .ioQspiDq2      (ioQspiDq2),
    .ioQspiDq3      (ioQspiDq3),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (rHdmiHpd),
    .iUartRx        (rUartRx),
    .oUartTx        (oUartTx),
    .oLed           (oLed)
);

always begin
    #(CYCLE/2);
    rClk = ~rClk;
end

initial begin
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
