/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * ボード搭載DDR3メモリ、サンプル動作プロジェクト
 * inout [DRC RPBF-3] IO port buffering is incomplete: Device port ioDDR3_DQS_n[0] expects both input and output buffering but the buffers are incomplete.
 */
module main(
    input           iCLK,
    input           iRST,
    output [14:0]   oDDR3_ADDR,
    inout  [15:0]   ioDDR3_DQ,
    output          oDDR3_CLK_n,
    output          oDDR3_CLK_p,
    inout  [1:0]    ioDDR3_DQS_n,
    inout  [1:0]    ioDDR3_DQS_p,
    output [7:0]    oLED
);


reg [14:0] addr;    assign oDDR3_ADDR   = addr;
reg [15:0] dq;      assign ioDDR3_DQ    = ((dq & 1'b1) == 1'b1) ? dq : 16'bzzzzzzzzzzzzzzzz;
reg clk_n;          assign oDDR3_CLK_n  = clk_n;
reg clk_p;          assign oDDR3_CLK_p  = clk_p;
reg [1:0] dqs_n;          assign ioDDR3_DQS_n = (dqs_n == 2'b11) ? 2'b11 : 2'bzz;
reg [1:0] dqs_p;          assign ioDDR3_DQS_p = (dqs_p == 2'b11) ? 2'b11 : 2'bzz;
assign oLED = 8'h20;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        addr  <= 0;
        dq    <= 0;
        clk_n <= 0;
        clk_p <= 0;
        dqs_n <= 0;
        dqs_p <= 0;
    end else begin
        addr  <= addr + 1'b1;
        dq    <= ((dq & 1'b1) == 1'b1) ? dq + 1'b1 : ioDDR3_DQ;
        clk_n <= ~clk_n;
        clk_p <= ~clk_p;
        dqs_n <= ~dqs_n;
        dqs_p <= ~dqs_p;
    end
end

endmodule
