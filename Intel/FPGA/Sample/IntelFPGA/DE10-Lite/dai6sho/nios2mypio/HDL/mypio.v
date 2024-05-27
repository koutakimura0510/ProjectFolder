/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第6章           */
/* project: nios2mypio      */
/* outline: 自作PIO         */

module mypio (
    /* Avalonバス */
    input           clk, reset,
    input           address,
    input           write, read,
    input   [7:0]   writedata,
    output  [7:0]   readdata,
    /* ポート */
    input       [3:0]   SW,
    output  reg [6:0]   nHEX
);

/* 出力レジスタ */
always @( posedge clk ) begin
    if ( reset )
        nHEX <= 7'h7f;
    else if ( write && address==1'b0 ) begin
        nHEX  <= writedata[6:0];
    end
end

/* 入力レジスタ */
assign readdata = (read==1'b0)    ? 8'h00:
                  (address==1'b0) ? {1'b0, nHEX}: {4'h0, SW};

endmodule
