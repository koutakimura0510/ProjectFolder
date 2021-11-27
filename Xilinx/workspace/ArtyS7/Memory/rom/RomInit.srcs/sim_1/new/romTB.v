`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 12:37:03
// Design Name: 
// Module Name: romTB
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


module romTB;

parameter sysCLK = 10;

reg iCLK = 0;
reg iRST = 1;
wire [3:0] led;

romTop  rom(.iCLK(iCLK), .iRST(iRST), .led(led));

always begin
    #(sysCLK/2);
    iCLK = ~iCLK;
end

initial begin
    #sysCLK;   iRST = 0;
    #(sysCLK * 200);
    $stop;

end

endmodule
