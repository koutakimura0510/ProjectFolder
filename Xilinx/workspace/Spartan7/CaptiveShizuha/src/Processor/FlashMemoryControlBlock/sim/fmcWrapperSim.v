`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/04/29
// Author  koutakimura
// -
// Flash Memory Module Test Bentch
// 
//----------------------------------------------------------
module fmcWrapperSim;


//----------------------------------------------------------
// Clk Generate
//----------------------------------------------------------
parameter pSysCycle = 2;

reg rSysClk = 0;

always
begin
    #(pSysCycle/2);
    rSysClk = ~rSysClk;
end


//----------------------------------------------------------
// テストデータ生成
//----------------------------------------------------------
reg [26:0] rAddr = 0;
reg [ 7:0] rPi   = 0;
wire[ 7:0] wPi;
wire wWdVd, wRdVd;

always @(posedge rSysClk)
begin
    if (wWdVd)  rPi <= rPi + 1'b1;
    else        rPi <= rPi;
end

always @(posedge rSysClk)
begin
    if (wWdVd)  rAddr <= rAddr + 1'b1;
    else        rAddr <= rAddr;
end


//----------------------------------------------------------
// 制御信号生成
//----------------------------------------------------------
reg rCke = 0;
reg rCmd = 0;

always @(posedge rSysClk)
begin
    if (wWdVd)  rCke <= 1'b0;
    else        rCke <= 1'b1;
end


//----------------------------------------------------------
// Spi Rom Control Block
//----------------------------------------------------------
reg  [1:0] rQspiDq1 = 0;
wire [1:0] wQspiCs,  wQspiSck;
wire [1:0] wQspiDq0, wQspiDq2, wQspiDq3;

fmcWrapper #(
    .pClkDiv        (4),
    .pHoldTime      (10),
    .pMode          ("mode0")
) FMC (
    .iSysClk        (rSysClk),
    .oQspiCs        (wQspiCs),
    .oQspiSck       (wQspiSck),
    .ioQspiDq0      (wQspiDq0),
    .ioQspiDq1      (rQspiDq1),
    .ioQspiDq2      (wQspiDq2),
    .ioQspiDq3      (wQspiDq3),
    .iPixel         (rPi),
    .oPixel         (wPi),
    .iPixelAddr     (rAddr),
    .iPixelCke      (rCke),
    .iPixelCmd      (rCmd),
    .oPixelWdVd     (wWdVd),
    .oPixelRdVd     (wRdVd),
    .iSound         (0),
    .oSound         (),
    .iSoundAddr     (0),
    .iSoundCke      (0),
    .iSoundCmd      (0),
    .oSoundWdVd     (),
    .oSoundRdVd     ()
);


//----------------------------------------------------------
// Simlation
//----------------------------------------------------------
initial
begin
    #(10 * 2000 * 4);
    $stop;
end

endmodule
