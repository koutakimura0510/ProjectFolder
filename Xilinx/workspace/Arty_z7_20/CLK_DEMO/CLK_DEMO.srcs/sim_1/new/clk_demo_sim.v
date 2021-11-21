`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/20 14:17:05
// Design Name: 
// Module Name: clk_demo_sim
// Project Name: CLK_DEMO
// Target Devices: Arty Z7-20
// Tool Versions: 20.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
module clk_demo_sim;

parameter CYCLE = 100;
parameter SIM_SEX_MAX = 5;

reg reset, clk;
wire led1;

clk_demo #(.SYSTEM_CLK(SIM_SEX_MAX))
          i0(.CLK(clk), .RESET(reset), .LED1(led1));

always #(CYCLE)
	clk = ~clk;


initial begin
    #0;
    #(CYCLE);
    reset = 0;
    #(CYCLE);
    reset = 1;
	clk   = 0;
    #(CYCLE * 5000);
    $finish;
end

endmodule
