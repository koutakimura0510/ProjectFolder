/*
 * I2S outout Generate
 *
 * Author KoutaKimura
 * 2021/05/02/12:41
 *
 * OS : Ubuntu LTS 20.04
 * Tool : Vivado 20.2
 * Board : Arty Z7-20
 *
 * Use DAC PCM5102A
 * MCLK 24.576MHz
 * Sampling CLK = 48KHz, 96KHz, 192KHz
 * 16bit ~ 32bit
 */

module I2S_DEMO (
    /* Low RESET */
    input RESET,

    /* 24.576MHz出力*/
    // output MCLK_OUT_OBUF,

    /* 基本3.12MHz出力 */
    output reg BCLK,

    /* LR各チャンネル32bitシリアルデータ出力、MSBファースト */
    output reg SDATA,

    /* 48kHz, 96kHz, 192kHz */
    output reg LRCLK,

    /* 水晶CLK入力24.576MHz*/
    input MCLK_IN_IBUF,
    input SDATA_IN
    // input BCLK_IN,
    // input LRCLK_IN
);

/* MCLK COUNTER */
parameter MAX_MCLK_COUNT    = (2 - 1);


/* BCLK COUNTER */
parameter MAX_BCLK_COUNT  = (32 - 1);
parameter BCLK_COUNT_SIZE = (6 - 1);
parameter BCLK_COUNT      = (6'h1);


/* Shift Regster = 1024byte */
parameter BIT_LENGTH        = (32 - 1);
parameter SHIFT_REG_SIZE    = (32 - 1);

/* I2S Register */
reg mclk_cnt;
reg [BCLK_COUNT_SIZE:0] bclk_cnt;
reg [5:0] lrclk_cnt;


/*
 * MCLK Counter
 * MCLK = BCLK(MHz) * 8
 * 24.576MHz = 3.072MHz * 8count
 */
always @(negedge MCLK_IN_IBUF, negedge RESET) begin
    if (RESET == 1'h0) begin
        mclk_cnt <= 0;  
    end else if (mclk_cnt == MAX_MCLK_COUNT) begin
        mclk_cnt <= 0;
    end else begin
        mclk_cnt <= mclk_cnt + 1'b1;
    end
end


/*
 * BCLK Generate
 */
always @(negedge MCLK_IN_IBUF, negedge RESET) begin
    if (RESET == 1'h0) begin
        BCLK <= 0;  
    end else if (mclk_cnt == MAX_MCLK_COUNT) begin
        BCLK <= ~BCLK;
    end
end


/*
 * BCLK Counter
 * LRCLK(Khz) = BCLK(Mhz) / 32bit / LR(2ch)
 * 48Khz = 3.072(Mhz) / 32 / 2
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        bclk_cnt <= 0;  
    end else if (bclk_cnt == MAX_BCLK_COUNT) begin
        bclk_cnt <= 0;
    end else begin
        bclk_cnt <= bclk_cnt + BCLK_COUNT;
    end
end


/*
 * LRCLK Generate
 * LRch 32bit MSB farst
 * Low  = LCLK Output
 * High = RCLK Output
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        LRCLK <= 0;  
    end else if (bclk_cnt == MAX_BCLK_COUNT) begin
        LRCLK <= ~LRCLK;
    end
end


/*
 * LRCLKカウンター
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        lrclk_cnt <= 0;  
    end else if (bclk_cnt == MAX_BCLK_COUNT) begin
        if (lrclk_cnt == SHIFT_REG_SIZE) begin
            lrclk_cnt <= 0;
        end else begin
            lrclk_cnt <= lrclk_cnt + 1;
        end
    end
end


/*
 * I2S Audio Data Serial Output
 * PCM5102Aの仕様上、1BCLK遅れてデータ送信を行う必要がある
 * 32bitの音源データを使用する場合、2回目からのLRCLKの MSB farstのデータには
 * LSBのデータを送信する
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        SDATA <= 0;
    end else begin
        SDATA <= SDATA_IN;        
    end
end

endmodule
