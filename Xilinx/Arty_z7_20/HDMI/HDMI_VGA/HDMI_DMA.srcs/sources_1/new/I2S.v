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

module I2S (
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
    input [31:0] GP_IN,

    /* 
     * [0:0] High. CPU側のデータ送信準備完了  Low. 準備未完了
     * [8:4] 音量調整 最大32bitシフト
     */
    input [31:0] GP_STATUS,

    /* 
     * High FPGA側のデータ受信完了
     * Low  受信未完了
     */
    output [31:0] GP_OUT
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
 * I2Sの動作に必要なカウンターと信号のレジスタ
 */
reg mclk_cnt;
reg [BCLK_COUNT_SIZE:0] bclk_cnt;
reg BCLK, LRCLK, SDATA;


/*
 * 音源データ保存用リングバッファ
 */
reg [FIFO_WIDTH:0] audio_data_fifo[0:FIFO_HEIGHT];
reg [FIFO_POS_NUM:0] rp, wp;


/* 状態遷移用 */
reg response_state;


/*
 * 現在のデータ取得情報をCPUに出力
 */
assign GP_OUT[31:0] = ((response_state << FIFO_POS_NUM) | wp);


/*
 * I2Sの各CLKを出力
 */
assign LRCLK_OUT = LRCLK;
assign BCLK_OUT  = BCLK;
assign AUDIO_DATA_OUT = SDATA;


/*
 * 音源データをCPUから取得して保存
 * wpがrpの位置を越さないように動作
 */
always @(negedge CLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        response_state <= 1'b0;
        wp <= 0;
    end else if (GP_STATUS[0] == 1'b1 && response_state == 1'b0) begin
        audio_data_fifo[wp][FIFO_WIDTH:0] <= GP_IN[31:0] << GP_STATUS[8:4];
        response_state <= 1'b1;
    end else if (GP_STATUS[0] == 1'b0 && response_state == 1'b1) begin
        response_state <= 1'b0;
        if (wp == FIFO_HEIGHT && rp == 0) begin
            wp <= FIFO_HEIGHT;
        end else if (rp == wp || rp < wp) begin
            if (wp == FIFO_HEIGHT) begin
                wp <= 0;
            end else begin
                wp <= wp + 1;
            end
        end else if (wp < rp && rp != 0) begin
            if (wp != (rp - 1)) begin
                wp <= wp + 1;
            end
        end
    end
end


/*
 * FIFO rpカウンター
 * LRCLKの各チャネルごとにrpのインクリメントを行う
 */
always @(negedge BCLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        rp <= 0;  
    end else if (bclk_cnt == MAX_BCLK_COUNT) begin
        if (rp == FIFO_HEIGHT) begin
            rp <= 0;
        end else begin
            rp <= rp + 1;
        end
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
    end else if (bclk_cnt == MAX_BCLK_COUNT) begin
        SDATA <= audio_data_fifo[rp][0];
    end else begin
        SDATA <= audio_data_fifo[rp][MAX_BCLK_COUNT & ~bclk_cnt];
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
