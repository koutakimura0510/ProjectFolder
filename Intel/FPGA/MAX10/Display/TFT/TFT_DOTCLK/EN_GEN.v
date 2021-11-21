/**-------------------------------------------------------------------
 * ENABLE信号の生成を行う
 * -------------------------------------------------------------------*/
module EN_GEN (
    input CLK, RESET,
    output ENABLE, ENABLE_10ms
);

/**------------------------------------------
 * 分周クロックの生成用定数
 *------------------------------------------*/
parameter SYSTEM_CLK      = 50000000;	// 50MHz cycle
parameter SYSTEM_CLK_10MS = 500000;


/**------------------------------------------
 * 周期カウンタ
 *------------------------------------------*/
reg [25:0] tmp_count;


/**-------------------------------------------------
 * CLK Counter
 * -------------------------------------------------*/
always @ (posedge CLK or negedge RESET) begin
  if (RESET == 1'b0) begin
    tmp_count <= 26'b0;
  end else if (ENABLE == 1'b1) begin
		tmp_count <= 26'b0;
  end else begin
		tmp_count <= tmp_count + 26'b1;
  end
end

assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_10ms = (tmp_count[18:0] == (SYSTEM_CLK_10MS - 1)) ? 1'b1 : 1'b0;


endmodule
