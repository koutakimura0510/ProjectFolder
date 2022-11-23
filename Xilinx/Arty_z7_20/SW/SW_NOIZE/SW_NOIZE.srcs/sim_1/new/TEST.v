`timescale 1ns / 1ps

module TEST;

parameter CYCLE = 20;
parameter SIM_MAX = 4;

reg reset, clk;
reg [3:0] btn;
wire [3:0] led;

SW_NOIZE #(.TYATA_CLK(SIM_MAX), .SYSTEM_CLK(SIM_MAX))
io(
    .CLK(clk),
    .RESET(reset),
    .BTN(btn),
    .LED(led)
);

always #(CYCLE)
	clk = ~clk;


initial begin
    #0;
    #(CYCLE);
    reset = 0;
    btn = 0;
    #(CYCLE);
    reset = 1;
	clk   = 0;
    #(CYCLE * 200);
    btn = 4'b0001;
    #(CYCLE * 200);
    btn = 4'b0011;

    #(CYCLE * 200);
    btn = 4'b0010;
    #(CYCLE * 200);
    btn = 4'b0000;

    #(CYCLE * 200);
    btn = 4'b1100;
    #(CYCLE * 200);
    btn = 4'b0000;

    #(CYCLE * 200);
    btn = 4'b1001;
    #(CYCLE * 200);
    btn = 4'b0000;

    #(CYCLE * 5000);
    $finish;
end
endmodule