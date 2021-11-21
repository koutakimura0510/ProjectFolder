module FF (
    input CLK, IDATA,
    output ODATA
);

reg [1:0] sreg;

always @(posedge CLK) begin
    sreg <= {sreg[0], IDATA};
end

assign ODATA = sreg[1];

endmodule