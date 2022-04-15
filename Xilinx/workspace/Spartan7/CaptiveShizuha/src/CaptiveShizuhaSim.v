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

reg iClk    = 0;
reg iRst    = 1;
reg [4:0] iBTN = 0;
wire oHdmiClkNeg;
wire oHdmiClkPos;
wire [2:0] oHdmiDataNeg;
wire [2:0] oHdmiDataPos;
wire [7:0] oLED;
wire oOledScl;
wire oOledSda;
wire oOledDC;
wire oOledRes;
wire oOledVbat;
wire oOledVdd;

CaptiveShizuhaTop #(
    // .H_DISPLAY  (640),      .H_BACK     (48),
    // .H_FRONT    (16),       .H_SYNC     (96),
    // .V_DISPLAY  (480),      .V_TOP      (31),
    // .V_BOTTOM   (11),       .V_SYNC     (2),
    .pHdisplay  (50),        .pHback     (2),
    .pHfront    (2),        .pHsync     (2),
    .pVdisplay  (50),        .pVtop      (2),
    .pVbottom   (2),        .pVsync     (2),
    .pPixelDebug ("yes"),   .pBuffDepth (32)
) TOP (
    .iClk           (iClk),         .iRst           (iRst),
    .iBtn           (iBTN),         .iSW            (8'd00),
    .oHdmiClkNeg    (oHdmiClkNeg),  .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiDataNeg        (oHdmiDataNeg),      .oHdmiDataPos        (oHdmiDataPos),
    .oLED           (oLED),
    .oOledScl       (oOledScl),     .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),      .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),     .oOledVdd       (oOledVdd)
);

always begin
    #(CYCLE/2);
    iClk = ~iClk;
end

initial begin
    iRst = 0;
    #(CYCLE * 2);
    iRst = 1;
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
