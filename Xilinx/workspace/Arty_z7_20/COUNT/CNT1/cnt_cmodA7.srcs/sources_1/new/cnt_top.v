//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/14 19:55:03
// Design Name: 
// Module Name: cnt_top
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


module cnt_top(
    input CLK,
    output [1:0] LED,
    output LEDR,
    output LEDG,
    output LEDB,
    input BTN
);

parameter SYS_CLK = (12000000 - 1);

wire reset = ~BTN;
reg [23:0] tmp_count;

always @(posedge CLK, negedge reset) begin
    if (reset == 1'b0) begin
        tmp_count <= 0;
    end else if (tmp_count == SYS_CLK) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 24'd1;
    end
end

assign LED = (tmp_count == SYS_CLK) ? 2'd3 : 2'd0;
assign LEDR = (tmp_count > (SYS_CLK >> 1)) ? 1'b0 : 1'b1;
assign LEDG = 1'd1;
assign LEDB = 1'd1;

endmodule
