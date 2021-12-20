`timescale 1ns / 1ps
/*
 * Create 2021/12/19
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 
 */
module TB;

parameter CYCLE = 2;

reg     iCLK        = 0;
reg     iRST        = 0;
reg     iBtnC       = 0;
reg     iBtnD       = 0;
reg     iBtnU       = 0;
wire    Scl;
wire    Sda;
wire    dc;
wire    res;
wire    vbat;
wire    vdd;
wire [7:0] led;

top #(
    .PDIVCLK(20),
    .PDIVSCK(10),
    .DISPLAY_WIDTH(10),
    .DISPLAY_PAGE(1)
) TOP (
    .iCLK(iCLK),
    .iRST(iRST),
    .iBtnC(iBtnC),
    .iBtnD(iBtnD),
    .iBtnU(iBtnU),
    .oOledScl(Scl),
    .oOledSda(Sda),
    .oOledDC(dc),
    .oOledRes(res),
    .oOledVbat(vbat),
    .oOledVdd(vdd),
    .oLED(led)
);


always  begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    iRST = 0;
    #(CYCLE * 4);
    iRST = 1;
    #(CYCLE * 100 * 4);
    $stop;
end

endmodule
