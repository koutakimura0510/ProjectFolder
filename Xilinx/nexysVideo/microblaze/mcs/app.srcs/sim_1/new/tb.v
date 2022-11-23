`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/06 12:44:51
// Design Name: 
// Module Name: sim
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
module tb;

parameter CYCLE = 4;

reg iCLK    = 0;
reg iRST    = 1;
wire [7:0] oLED;

main # (
    .pMB ("off")
) MAIN (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .oUartTx        (),
    .oLED           (oLED)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule