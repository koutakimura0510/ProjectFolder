module AXI_STREAM(
    input ACLK, RESET,
    output reg [31:0] tdata,
    output reg [3:0] tkeep,
    output reg tlast,
    input tready,
    output reg tvalid,
    output reg tuser
);

always @(posedge ACLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        tdata <= 0;
        tkeep <= 0;
        tlast <= 0;
        tvalid <= 0;
        tuser <= 0;
    end else begin
        tdata <= 0;
        tkeep <= 0;
        tlast <= 0;
        tvalid <= 0;
        tuser <= 0;
    end
end

endmodule
