//----------------------------------------------------------
// Enable信号生成モジュール
//----------------------------------------------------------
module enGen (
    input   iCLK, 
    input   iRST,
    output  oEn5ms,
    output  oEn1ms
);

localparam SYS_CLK = 25000000;
localparam KEY_CLK = 125000;
localparam CLK_1MS = 25000;
// localparam SYS_CLK = 16;
// localparam KEY_CLK = 6;
// localparam CLK_1MS = 2;

reg [24:0] tmp_count;

assign enable = (tmp_count == (SYS_CLK-1)) ? 1'b1 : 1'b0;
assign oEn5ms = (tmp_count[16:0] == (KEY_CLK-1)) ? 1'b1 : 1'b0;
assign oEn1ms = (tmp_count[14:0] == (CLK_1MS-1)) ? 1'b1 : 1'b0;


always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 0;
    end else if (enable == 1'b1) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 1'b1;
    end
end

endmodule
