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
module SpiSlaveTopSim;

//----------------------------------------------------------
// comment
//----------------------------------------------------------
parameter CYCLE = 10;
reg rSysClk     = 0;


//----------------------------------------------------------
// SPI 
//----------------------------------------------------------
reg  rSpiMiso   = 1'bz;
reg  rSpiMosi   = 1'bz;
reg  rSpiWp     = 1'bz;
reg  rSpiHold   = 1'bz;
reg  rSpiCs     = 1'bz;
wire ioSpiMiso;             assign ioSpiMiso = rSpiMiso;
wire ioSpiMosi;             assign ioSpiMosi = rSpiMosi;
wire ioSpiWp;               assign ioSpiWp   = rSpiWp;
wire ioSpiHold;             assign ioSpiHold = rSpiHold;
wire oSpiConfigCs;
wire ioSpiCs;				assign ioSpiCs = rSpiCs;

always @(posedge rSysClk)
begin
    rSpiMiso    <= 1'bz;
    rSpiMosi    <= 1'bz;
    rSpiWp      <= 1'bz;
    rSpiHold    <= 1'bz;
end


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
SpiSlaveTop TOP (
    .iOscSystemClk      (rSysClk),
	.ioSpiSck			(ioSpiSck),
	.ioSpiMiso			(ioSpiMiso),
	.ioSpiMosi			(ioSpiMosi),
	.ioSpiWp			(ioSpiWp),
	.ioSpiHold			(ioSpiHold),
	.oSpiConfigCs		(oSpiConfigCs),
	.ioSpiCs			(ioSpiCs),
	.iMSSel				(1'b0),
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
