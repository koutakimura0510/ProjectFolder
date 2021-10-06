/*
 * Zynq CLK 100MHz
 */

module COUNT (
    input CLK, RESET,
    output [31:0]GP_COUNT
);


/* 100MHz x 50us */
parameter US_COUNT = (5000 - 1);


/* (1 / 50us) x 60 x 60 x 24 */
parameter DAY_COUNT = (1728000000 - 1);
reg [12:0]tmp_count;
reg [31:0]us_count;
wire ENABLE;


/*
 * イネーブル信号の生成
 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        tmp_count <= 13'b0;
    end else if (ENABLE == 1'b1) begin
        tmp_count <= 13'b0;
    end else begin
        tmp_count <= tmp_count + 13'b1;
    end
end


/*
 * 50usカウンター動作
 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        us_count <= 31'b0;
    end else if (ENABLE == 1'b1) begin
        if (us_count == DAY_COUNT) begin
            us_count <= 31'b0;
        end else begin
            us_count <= us_count + 31'b1;
        end
    end
end

assign ENABLE = (tmp_count == US_COUNT) ? 1'b1 : 1'b0;
assign GP_COUNT[31:0] = us_count[31:0];

endmodule