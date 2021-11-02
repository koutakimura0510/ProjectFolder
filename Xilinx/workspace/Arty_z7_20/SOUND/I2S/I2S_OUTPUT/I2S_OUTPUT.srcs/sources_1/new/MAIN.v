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

module MAIN (
    /* 100 MHz */
    input CLK,

    /* Low RESET */
    input RESET,

    /* 外部MCLK入力、24.576MHz*/
    input MCLK_IN_IBUF,

    /* 3.12MHz出力 */
    output BCLK_OUT,

    /* LR各チャンネル32bitシリアルデータ出力、MSBファースト */
    output AUDIO_DATA_OUT,

    /* 48kHz, 96kHz, 192kHz出力 */
    output LRCLK_OUT,

    /* 32bit音源データを保存*/
    input [31:0] SOUND_IN,

    /* COUN_OUT */
    output [31:0] COUNT_OUT,

    /* 音源再生操作コマンド */
    input [31:0] GP_OPERATION
);

/*
 * MCLKの最大カウント回数、1で固定
 */
parameter MAX_MCLK_COUNT  = (2 - 1);


/*
 * BCLKの最大カウント回数
 * カウント回数に応じてレジスタのサイズを変更する
 */
parameter MAX_BCLK_COUNT  = (32 - 1);
parameter BCLK_COUNT_SIZE = (6 - 1);
parameter BCLK_COUNT      = (6'h1);


/*
 * FIFO_HEIGHT
 * 可変可能、2の乗数の値を設定すること
 *
 * FIFO_WIDTH
 * 32bit固定、BCLKの最大カウント数と一致させる
 *
 * FIFO_POS_NUM
 * HEIGHTの配列長に対応したbit幅を指定
 */
parameter FIFO_HEIGHT   = (32 - 1);
parameter FIFO_WIDTH    = (32 - 1);
parameter FIFO_POS_NUM  = (6 - 1);


/*
 * PLAY_START
 */
parameter PLAY_START = 16;


/*
 * I2Sの動作に必要なカウンターと信号のレジスタ
 */
reg mclk_cnt;
reg [BCLK_COUNT_SIZE:0] bclk_cnt;
reg BCLK, LRCLK, SDATA;


/*
 * 音源データ保存用リングバッファ
 */
reg [31:0] rp;


/*
 * I2Sの各CLKを出力
 */
assign LRCLK_OUT = LRCLK;
assign BCLK_OUT  = BCLK;
assign AUDIO_DATA_OUT = SDATA;
assign COUNT_OUT = rp;



/*
 * FIFO rpカウンター
 * LRCLKの各チャネルごとにrpのインクリメントを行う
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        rp <= 0;  
    end else if (GP_OPERATION == PLAY_START) begin
        if (bclk_cnt == MAX_BCLK_COUNT) begin
            rp <= rp + 1;
        end
    end else begin
        rp <= 0;
    end
end


/*
 * I2S Audio Data Serial Output
 * PCM5102Aの仕様上、1BCLK遅れてデータ送信を行う必要がある
 * 32bitの音源データを使用する場合、2回目からのLRCLKのMSB farstのデータには
 * LSBのデータを送信する
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        SDATA <= 0;
    end else if (GP_OPERATION == PLAY_START) begin
        if (bclk_cnt == MAX_BCLK_COUNT) begin
            SDATA <= SOUND_IN[0];
        end else begin
            SDATA <= SOUND_IN & MAX_BCLK_COUNT & ~bclk_cnt;
        end
    end else begin
        SDATA <= 0;
    end
end


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
        mclk_cnt <= mclk_cnt + 1'd1;
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

endmodule
