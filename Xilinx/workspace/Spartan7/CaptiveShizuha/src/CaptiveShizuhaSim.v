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
reg rUartRx  = 0;
reg rHdmiHpd = 0;
reg rQspiDq0 = 0;
reg rQspiDq1 = 0;
reg rQspiDq2 = 0;
reg rQspiDq3 = 0;

wire ioQspiDq0;
wire ioQspiDq1;
wire ioQspiDq2;
wire ioQspiDq3;


wire ioApdsScl;
wire ioApdsSda;
wire iApdsIntr;
wire oQspiCs;
wire oQspiSck;
wire oHdmiScl;
wire ioHdmiSda;
wire ioHdmiCec;
wire oUartTx;
wire oHdmiClkNeg, oHdmiClkPos;
wire [2:0] oHdmiDataNeg, oHdmiDataPos;
wire [1:0] oLED;

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
    .pBuffDepth     (32)
) TOP (
    .iClk           (iClk),
    .ioApdsScl      (ioApdsScl),
    .ioApdsSda      (ioApdsSda),
    .iApdsIntr      (iApdsIntr),
    .oQspiCs        (oQspiCs),
    .oQspiSck       (oQspiSck),
    .ioQspiDq0      (ioQspiDq0),
    .ioQspiDq1      (ioQspiDq1),
    .ioQspiDq2      (ioQspiDq2),
    .ioQspiDq3      (ioQspiDq3),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (iHdmiHpd),
    .iUartRx        (iUartRx),
    .oUartTx        (oUartTx),
    .oLed           (oLed)
);

always begin
    #(CYCLE/2);
    iClk = ~iClk;
end

initial begin
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
