/* -
 * Arduino IO Pin
 * [Input]
 * IO7 LRCLK
 * IO6 BCLK
 * IO5 DIN
 *
 * [Output]
 * IO13 LRCLK
 * IO12 BCLK
 * IO11 DIN
 *
 * [I2S]
 * 48khzサンプリング　32bitデータ送信
 * I2SのCLKで同期せずに、FPGAのCLKで同期を行う
 * 1LRCLK分出力を遅らせ、1サイクルの間に音源データにフィルタをかける
 */
module D_FILTER (
    input CLK, RESET,
    inout [15:0] ARDUINO_IO,
	output [9:0] LEDR
);

//* I2S通信
wire LRCLK, BCLK, DIN, MCLK;
wire SOUND_DATA, BCLK_LAST, LRCLK_LAST;
wire [7:0] BCOUNT;
wire [31:0] IDATA;
wire [31:0] RDATA, LDATA;

//* SPI通信
wire SCLK, SENABLE, MOSI;
wire [7:0] SDATA;


//* 同期カウンタのため、メタ・ステーブル対策を行う
FF lrclk_ff (CLK, ARDUINO_IO[7], LRCLK);
FF bclk_ff  (CLK, ARDUINO_IO[6], BCLK);
FF data_ff  (CLK, ARDUINO_IO[5], DIN);
FF mclk_ff	(CLK, ARDUINO_IO[4], MCLK);
FF mosi_ff  (CLK, ARDUINO_IO[2], MOSI);
FF cs_ff    (CLK, ARDUINO_IO[1], SENABLE);
FF sclk_ff  (CLK, ARDUINO_IO[0], SCLK);


//* SPIデータの取得
SPI SPI_GET_DATA (
	.CLK(CLK),
	.RESET(RESET),
	.SCLK(SCLK),
	.SENABLE(SENABLE),
	.MOSI(MOSI),
	.SDATA(SDATA)
);

//* 1LRCLK後の出力を取得
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

//* LRデータにフィルタをかける
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

//* データを出力
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

DECODER GAGE (.RESET(RESET), .COUNT(SDATA), .LEDR(LEDR));

assign ARDUINO_IO[10] = MCLK;
assign ARDUINO_IO[11] = SOUND_DATA;
assign ARDUINO_IO[12] = BCLK;
assign ARDUINO_IO[13] = LRCLK;

endmodule