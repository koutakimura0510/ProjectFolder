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
reg rRst    = 1;

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
reg qCke;

always @(posedge rSysClk)
begin
    if (wWdVd)  rCke <= 1'b0;
    else        rCke <= 1'b1;
end

always @*
begin
    qCke <= rCke & ~rRst;
end



//----------------------------------------------------------
// Spi Rom Control Block
//----------------------------------------------------------
reg  [1:0] rQspiDq1 = 0;
wire [1:0] wQspiCs,  wQspiSck;
wire [1:0] wQspiDq0, wQspiDq2, wQspiDq3;

fmcWrapper #(
    .pClkDiv        (4),
    .pSector        (8),
    .pPage          (4),
    .pBlock         (1024),
    .pHoldTime      (1),
    .pMode          ("mode0")
) FMC (
    .iSysClk        (rSysClk),
    .iRst           (rRst),
    .oQspiCs        (wQspiCs),
    .oQspiSck       (wQspiSck),
    .ioQspiDq0      (wQspiDq0),
    .ioQspiDq1      (rQspiDq1),
    .ioQspiDq2      (wQspiDq2),
    .ioQspiDq3      (wQspiDq3),
    .iPixel         (rPi),
    .oPixel         (wPi),
    .iPixelAddr     (rAddr),
    .iPixelCke      (qCke),
    .iPixelCmd      (rCmd),
    .oPixelWdVd     (wWdVd),
    .oPixelRdVd     (wRdVd),
    .oPixelSectorCke(),
    .oPixelWblockCke(),
    .iSound         (0),
    .oSound         (),
    .iSoundAddr     (0),
    .iSoundCke      (0),
    .iSoundCmd      (0),
    .oSoundWdVd     (),
    .oSoundRdVd     (),
    .oSoundSectorCke(),
    .oSoundWblockCke()
);


//----------------------------------------------------------
// comment
//----------------------------------------------------------
always @(posedge rSysClk)
begin
    rQspiDq1 <= 1;
end


//----------------------------------------------------------
// Simlation
//----------------------------------------------------------
initial
begin
    #(10);
    rRst = 1;
    #(10);
    rRst = 0;
    #(10 * 2000 * 4);
    $stop;
end

endmodule
