/**-------------------------------------------------------------------
 * ラズベリーパイから信号を受け取り、描画を行う
 * RGBインターフェースモードで動作
 * -------------------------------------------------------------------
 * Quartus Prime: 20.1
 * Ubuntu LTS   : 20.04
 * Simlation    : Model Sim
 * FPGA Board   : DE10_Lite
 * TFT_LCD      : ILI9341 Controller
 *
 * Created on   : 2021/2/13
 * Author       : kimura
 *--------------------------------------------------------------------*/
module TFT_RASPI (
    input CLK, RESET,
    inout [15:0] ARDUINO_IO,
    inout [35:0] GPIO,
    output [9:0] LEDR
);

/**------------------------------------------
 * 一定周期ENABLE信号
 *------------------------------------------*/
wire ENABLE, ENABLE_10ms;


/**------------------------------------------
 * 液晶描画
 *------------------------------------------*/
wire RD, WRX, DCX;
wire DRAW_ON;
wire [7:0] TFT_BYTE;
wire [8:0] hpos, vpos;
wire VSYNC, HSYNC, DE;


/**------------------------------------------
 * 分周クロックの生成用定数
 *------------------------------------------*/
parameter SYSTEM_CLK      = 50000000;	// 50MHz cycle
parameter SYSTEM_CLK_10MS = 500000;


/**------------------------------------------
 * 周期カウンタ
 *------------------------------------------*/
reg [25:0] tmp_count;
reg DOTCLK;
reg [3:0] dotclk_cnt;


/**------------------------------------------
 * 描画同期信号の生成 12.5MHzで動作
 *------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
  if (RESET == 1'b0) begin
    dotclk_cnt <= 0;
    DOTCLK <= 1'b0;
  end else if (dotclk_cnt == 8) begin
    dotclk_cnt <= 0;
    DOTCLK <= ~DOTCLK;
  end else begin
    dotclk_cnt <= dotclk_cnt + 1;
  end
end


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

//EN_GEN EN (
//    .CLK(CLK),
//    .RESET(RESET),
//    .ENABLE(ENABLE),
//    .ENABLE_10ms(ENABLE_10ms)
//);


/**-------------------------------------------------
 * 液晶の初期設定
 * -------------------------------------------------*/
TFT_INIT RGB_MODE (
  .CLK(CLK),
  .RESET(RESET),
  .ENABLE_10ms(ENABLE_10ms),
  .WRX(WRX),
  .RD(RD),
  .DCX(DCX),
  .TFT_BYTE(TFT_BYTE),
  .DRAW_ON(DRAW_ON),
  .LEDR(LEDR)
);


/**-------------------------------------------------
 * 液晶同期信号の生成
 * -------------------------------------------------*/
HVSYNC_GEN HVSYNC (
  .CLK(DOTCLK),
  .RESET(RESET),
  .DRAW_ON(DRAW_ON),
  .HSYNC(HSYNC),
  .VSYNC(VSYNC),
  .hpos(hpos),
  .vpos(vpos),
  .DE(DE)
);


/**-------------------------------------------------
 * 信号の出力
 * -------------------------------------------------*/
assign ARDUINO_IO[8] = DE;
assign ARDUINO_IO[9] = (DE & DOTCLK);

assign GPIO[18]    = RD;
assign GPIO[20]    = WRX;
assign GPIO[22]    = DCX;

// assign GPIO[7:0]   = (DRAW_ON == 1'b0) ? TFT_BYTE[7:0] : (DE == 1'b1) && (((hpos & 4'b1111) == 0) || ((vpos & 4'b1111) == 0));
// assign GPIO[11:8]  = DE & vpos[5];
// assign GPIO[17:12] = DE & hpos[5];
assign GPIO[7:0]   = (DRAW_ON == 1'b0) ? TFT_BYTE[7:0] : ARDUINO_IO[1:0] << 4;
assign GPIO[8]     = 0;
assign GPIO[11:9]  = ARDUINO_IO[4:2];
assign GPIO[14:12] = 0;
assign GPIO[17:15] = ARDUINO_IO[7:5];
assign GPIO[19]    = DE;
assign GPIO[21]    = DOTCLK;
assign GPIO[23]    = HSYNC;
assign GPIO[25]    = VSYNC;
assign GPIO[24]    = 0;  // CS
assign GPIO[33]    = 1;  // IM0
assign GPIO[27]    = 1;  // IM1
assign GPIO[29]    = 0;  // IM2
assign GPIO[31]    = 0;  // IM3


endmodule
