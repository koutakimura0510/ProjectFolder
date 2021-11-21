module CLK_GEN (
    input CLK, RESET,
    output [35:0] GPIO,
	output reg [9:0] LEDR
);

parameter DIV = 4;
parameter DIV_PARA = 5'h1;
parameter DIV_NUMBER = 5'd24;

reg [25:0] tmp_count;
reg [DIV:0] bclk_cnt;		// BCLK Counter
reg [DIV:0] div_number;		// 分周数
reg [DIV:0] cnt_p, cnt_n;	// 立ち上がりと立ち下がりの回数をカウント
reg out_p, out_n;			// 分周数x2の周波数を出力
reg BCLK;
wire ENABLE, TOGGLE;


assign ENABLE = out_p ^ out_n;


initial begin
	LEDR[9:0] = 10'b1010101010;
    div_number = DIV_NUMBER;
end

/**--------------------------------------------------------
 * LED demo
 *---------------------------------------------------------*/
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        tmp_count <= 26'b0;
        LEDR <= 10'b1010101010;
    end else if (tmp_count == 49999999) begin
        tmp_count <= 26'b0;
        LEDR <= ~LEDR;
    end else begin
        tmp_count <= tmp_count + 26'b1;
    end
end


/**--------------------------------------------------------
 * CLKの立ち上がりをカウント
 *---------------------------------------------------------*/
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        cnt_p <= DIV_PARA;
        out_p <= 1'b0;
    end else begin
        cnt_p <= cnt_n + DIV_PARA;
        if (cnt_n == div_number) begin
            cnt_p <= DIV_PARA;
            out_p <= ~out_p;
        end
    end
end


/**--------------------------------------------------------
 * 立ち下がりをカウント
 *---------------------------------------------------------*/
always @(negedge CLK) begin
    if (RESET == 1'b1) begin
        out_n <= 1'b0;
        cnt_n <= DIV_PARA;
    end else begin
        cnt_n <= cnt_p + DIV_PARA;
        if (cnt_p == div_number) begin
            cnt_n <= DIV_PARA;
            out_n <= ~out_n;
        end
    end
end


/**--------------------------------------------------------
 * BCLKを32カウント
 *---------------------------------------------------------*/
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        BCLK <= 5'h0;
        bclk_cnt <= 5'h0;
    end else if (ENABLE == 1'b1) begin
        BCLK <= ~BCLK;
        if (bclk_cnt == 5'd31) begin
            bclk_cnt <= 5'b0;
        end else begin
            bclk_cnt <= bclk_cnt + 5'b1;
        end
    end
end

always @(posedge CLK) begin
    if (ENABLE == 1'b1) begin
        out_p <= 1'b0;
        out_n <= 1'b0;
        cnt_n <= 5'h0;
        cnt_p <= 5'h0;
    end
end

/**--------------------------------------------------------
 * LRCLKの生成
 *---------------------------------------------------------*/
//always @(posedge CLK) begin
//    
//end

endmodule