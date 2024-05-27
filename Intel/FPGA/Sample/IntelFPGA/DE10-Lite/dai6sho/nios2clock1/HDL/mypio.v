/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第6章課題       */
/* project: nios2clock1     */
/* outline: 自作32ビットPIO */

module mypio (
    /* Avalonバス */
    input           clk, reset,
    input           address,
    input           write, read,
    input   [31:0]  writedata,
    output  [31:0]  readdata,
    /* ポート */
    input       [1:0]   INPORT,
    output  reg [31:0]  OUTPORT
);

/* 出力レジスタ */
always @( posedge clk ) begin
    if ( reset )
        OUTPORT <= 32'h0;
    else if ( write && address==1'b0 ) begin
        OUTPORT  <= writedata;
    end
end

/* 入力レジスタ */
assign readdata = (read==1'b0)    ? 32'h0:
                  (address==1'b0) ? OUTPORT: {30'h0, INPORT};

endmodule
