`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/05 18:27:33
// Design Name: 
// Module Name: fifotb
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


module fifotb;

parameter CYCLE = 2;

reg iCLK = 0;
reg iRST = 0;
wire [7:0] oLED;

main MAIN (
    .iCLK       (iCLK),
    .iRST       (iRST),
    .oLED       (oLED)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 4);
    iRST = 0;
    #(CYCLE * 100 * 4);
    $stop;
end


endmodule
