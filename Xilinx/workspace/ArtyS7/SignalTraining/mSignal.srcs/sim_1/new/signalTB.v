`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/21 21:14:39
// Design Name: 
// Module Name: nv_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module nv_tb;

wire CarBlue, CarYellow, CarRed;
wire WarkBlue, WarkRed, WarkDled;
reg  sw, reset, clk;

parameter CYCLE = 20;
parameter SIM_MAX = 4;
parameter LOOP = 5;
integer i;

nv_top #(.pCLKFreqDiv10(SIM_MAX))
        i0(.oCB(CarBlue), .oCY(CarYellow), .oCR(CarRed),
            .oWB(WarkBlue), .oWR(WarkRed), .oWD(WarkDled),
            .iWPBS(sw), .iRST(reset), .iCLK(clk));

always begin
    #(CYCLE/2)
    clk = ~clk;
end

initial begin
    clk = 1'b0;
    reset = 1'b1;
    #CYCLE reset = 1'd0;

    for (i = 0; i < LOOP; i = i + 1) begin
        #CYCLE sw = 1'd1;
        #CYCLE sw = 1'd0;
        #(CYCLE * SIM_MAX * 20);
    end
    $stop;
end

endmodule
