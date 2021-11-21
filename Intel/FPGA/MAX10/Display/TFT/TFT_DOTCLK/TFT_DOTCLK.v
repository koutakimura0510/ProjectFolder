/**-------------------------------------------------------------------
 * TFT-LCDサンプルソース
 * FPGAでTFT_LCD240x320の初期設定を行い、描画を行う
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
module TFT_DOTCLK (
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
 * I2S信号
 *------------------------------------------*/
wire LRCLK, BCLK, DIN, MCLK;
wire SOUND_DATA, BCLK_LAST, LRCLK_LAST;
wire [7:0] BCOUNT;
wire [31:0] IDATA;
wire [31:0] RDATA, LDATA;


/**------------------------------------------
 * SPI信号
 *------------------------------------------*/
wire SCLK, CS, MOSI;
wire [7:0]SDATA;


/**------------------------------------------
 * 液晶描画
 *------------------------------------------*/
wire RD, WRX, DCX;
wire DRAW_ON;
wire [7:0] TFT_BYTE;
wire [8:0] hpos, vpos;
wire VSYNC, HSYNC, DE;
wire [17:0] COLOR;


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
reg [2:0] dotclk_cnt;


/**------------------------------------------
 * 描画同期信号の生成 12.5MHzで動作
 *------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
  if (RESET == 1'b0) begin
    dotclk_cnt <= 0;
    DOTCLK <= 1'b0;
  end else if (dotclk_cnt == 2) begin
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
 * 同期カウンタのため、シリアル通信のメタ・ステーブル対策を行う
 * 2段フリップフロップで信号を受信して、出力すると良い
 * -------------------------------------------------*/
FF lrclk_ff (CLK, ARDUINO_IO[7], LRCLK);
FF data_ff  (CLK, ARDUINO_IO[6], DIN);
FF bclk_ff  (CLK, ARDUINO_IO[5], BCLK);
FF mclk_ff	(CLK, ARDUINO_IO[4], MCLK);

FF sclk_ff  (CLK, ARDUINO_IO[10], SCLK);
FF cs_ff    (CLK, ARDUINO_IO[11], CS);
FF mosi_ff  (CLK, ARDUINO_IO[13], MOSI);


/**-------------------------------------------------
 * SPI通信をパラレルデータに変換
 * -------------------------------------------------*/
SPI2 SPI_GET_DATA (
  .CLK(CLK),
  .RESET(RESET),
  .SCLK(SCLK),
  .CS(CS),
  .MOSI(MOSI),
  .SPI_8BIT_D_OUT(SDATA)
);


/**-------------------------------------------------
 * 1LRCLK後の出力を取得
 * -------------------------------------------------*/
I2S I2S_GET_DATA (
	.CLK(CLK),
	.RESET(RESET),
	.LRCLK(LRCLK),
	.BCLK(BCLK),
	.DIN(DIN),
	.IDATA(IDATA),
	.BCOUNT(BCOUNT),
	.BCLK_LAST(BCLK_LAST),
	.LRCLK_LAST(LRCLK_LAST)
);


/**-------------------------------------------------
 * LRデータにデジタルフィルタをかける
 * -------------------------------------------------*/
RC_FILTER RFIL (
	.CLK(CLK),
	.RESET(RESET),
	.ENABLE(~BCLK_LAST & BCLK && BCOUNT == 0 && ~LRCLK),
	.IDATA(IDATA),
	.ODATA(RDATA)
);

RC_FILTER LFIL(
	.CLK(CLK),
	.RESET(RESET),
	.ENABLE(~BCLK_LAST & BCLK && BCOUNT == 0 && LRCLK),
	.IDATA(IDATA),
	.ODATA(LDATA)
);


/**-------------------------------------------------
 * I2Sパラレルデータをシリアルデータに変換
 * -------------------------------------------------*/
I2S_OUT I2S_ODATA (
	.CLK(CLK),
	.RESET(RESET),
	.LRCLK(LRCLK),
	.BCLK_LAST(BCLK_LAST),
	.BCLK(BCLK),
	.BCOUNT(BCOUNT),
	.LDATA(LDATA),
	.RDATA(RDATA),
	.SOUND_DATA(SOUND_DATA)
);


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
 * RGB18bitデータの生成 
 * -------------------------------------------------*/
DRAW_GEN DRAW_COLOR (
  .CLK(CLK),
  .RESET(RESET),
  .ENABLE(ENABLE),
  .DE(DE),
  .COLOR(COLOR)
);


/**-------------------------------------------------
 * 信号の出力
 * -------------------------------------------------*/
assign ARDUINO_IO[3] = LRCLK;
assign ARDUINO_IO[2] = SOUND_DATA;
assign ARDUINO_IO[1] = BCLK;
assign ARDUINO_IO[0] = MCLK;

//assign ARDUINO_IO[8] = DOTCLK;
assign ARDUINO_IO[9] = DE;

assign GPIO[18]    = RD;
assign GPIO[20]    = WRX;
assign GPIO[22]    = DCX;

// assign GPIO[7:0]   = (DRAW_ON == 1'b0) ? TFT_BYTE[7:0] : (DE == 1'b1) && (((hpos & 4'b1111) == 0) || ((vpos & 4'b1111) == 0));
// assign GPIO[11:8]  = DE & vpos[5];
// assign GPIO[17:12] = DE & hpos[5];
assign GPIO[7:0]   = (DRAW_ON == 1'b0) ? TFT_BYTE[7:0] : (DE == 1'b1) && (((hpos & 4'b1111) == 0) || ((vpos & 4'b1111) == 0));
assign GPIO[11]    = DE & vpos[5];
assign GPIO[17]    = DE & hpos[5];
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
