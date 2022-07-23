`resetall
`timescale 1ns/10ps

module Top_tb;

parameter CYCLE = 2;

reg rClk = 0;
wire [7:0] wLed;

Top TOP(
	.iClk	(rClk),
	.oLed	(wLed)
);

always begin
	#(CYCLE/2);
	rClk = ~rClk;
end

initial begin
    #(CYCLE * 2000 * 4);
	$display("TEST : PASS");
    $finish;
end

initial begin
	$dumpfile("outflow/Top.vcd");
	$dumpvars(0, Top_tb);
end

endmodule