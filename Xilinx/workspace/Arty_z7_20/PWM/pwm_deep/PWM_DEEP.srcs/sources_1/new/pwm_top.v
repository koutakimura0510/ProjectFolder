/*
 * Create 2021/09/21
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  vivado20.2
 * Borad  ArtyZ7-20
 * -
 * pwm出力サンプル回路
 */
module pwm_top(
    input CLK,              /* 125MHz */
    input [1:0] SLIDE_SW,   /* duty変更用 */
    output AUD_PWM,         /* pwm出力 */
    output CK_IO8,          /* オシロで確認用にPWMの出力端子を増やす */
    output LED1             /* 動作確認用LED端子 */
);

/* 内部パラメータ */
parameter MAX_CLK = (125000000 - 1); /* 入力クロックの1秒周期の最大値 */
parameter COUNT_WIDTH = 32;         /* 音源の分解能 */
parameter SOUND_BLOCK = (88-1);     /* 音源数 */


/* 内部レジスタ */
reg [6:0] temp;              /* sound_blockインデックス参照用 一応ピアノの88鍵盤のbit幅を用意した */
reg [COUNT_WIDTH-1:0] duty;  /* 周期カウンタ用レジスタ */
reg [COUNT_WIDTH-1:0] pulse_count;
reg pulse_out;
reg [COUNT_WIDTH-1:0] sound_block[0:SOUND_BLOCK]; /* ドレミファソラシドの音源 */
reg [26:0] count;


/* 音源バッファの初期化 initialの利用を推奨？されているらしい */
initial begin
    sound_block[0] <= 274; // 8
    sound_block[1] <= 274; // 8
    sound_block[2] <= 309; // 9
    sound_block[3] <= 309; // 9
    sound_block[4] <= 343; // 10
    sound_block[5] <= 343; // 10
    sound_block[6] <= 377; // 11
    sound_block[7] <= 412; // 12
    sound_block[8] <= 412; // 12
    sound_block[9] <= 446; // 13
    sound_block[10] <= 481; // 14
    sound_block[11] <= 515; // 15
    sound_block[12] <= 549; // 16
    sound_block[13] <= 584; // 17
    sound_block[14] <= 618; // 18
    sound_block[15] <= 652; // 19
    sound_block[16] <= 687; // 20
    sound_block[17] <= 721; // 21
    sound_block[18] <= 790; // 23
    sound_block[19] <= 824; // 24
    sound_block[20] <= 858; // 25
    sound_block[21] <= 927; // 27
    sound_block[22] <= 996; // 29
    sound_block[23] <= 1030; // 30
    sound_block[24] <= 1099; // 32
    sound_block[25] <= 1168; // 34
    sound_block[26] <= 1236; // 36
    sound_block[27] <= 1305; // 38
    sound_block[28] <= 1408; // 41
    sound_block[29] <= 1477; // 43
    sound_block[30] <= 1580; // 46
    sound_block[31] <= 1649; // 48
    sound_block[32] <= 1752; // 51
    sound_block[33] <= 1889; // 55
    sound_block[34] <= 1992; // 58
    sound_block[35] <= 2095; // 61
    sound_block[36] <= 2233; // 65
    sound_block[37] <= 2370; // 69
    sound_block[38] <= 2508; // 73
    sound_block[39] <= 2645; // 77
    sound_block[40] <= 2817; // 82
    sound_block[41] <= 2989; // 87
    sound_block[42] <= 3161; // 92
    sound_block[43] <= 3332; // 97
    sound_block[44] <= 3539; // 103
    sound_block[45] <= 3779; // 110
    sound_block[46] <= 3985; // 116
    sound_block[47] <= 4226; // 123
    sound_block[48] <= 4466; // 130
    sound_block[49] <= 4741; // 138
    sound_block[50] <= 5016; // 146
    sound_block[51] <= 5325; // 155
    sound_block[52] <= 5634; // 164
    sound_block[53] <= 5978; // 174
    sound_block[54] <= 6322; // 184
    sound_block[55] <= 6700; // 195
    sound_block[56] <= 7112; // 207
    sound_block[57] <= 7559; // 220
    sound_block[58] <= 8005; // 233
    sound_block[59] <= 8452; // 246
    sound_block[60] <= 8967; // 261
    sound_block[61] <= 9517; // 277
    sound_block[62] <= 10067; // 293
    sound_block[63] <= 10685; // 311
    sound_block[64] <= 11304; // 329
    sound_block[65] <= 11991; // 349
    sound_block[66] <= 12678; // 369
    sound_block[67] <= 13434; // 391
    sound_block[68] <= 14259; // 415
    sound_block[69] <= 15118; // 440
    sound_block[70] <= 16011; // 466
    sound_block[71] <= 16939; // 493
    sound_block[72] <= 17970; // 523
    sound_block[73] <= 19035; // 554
    sound_block[74] <= 20169; // 587
    sound_block[75] <= 21371; // 622
    sound_block[76] <= 22643; // 659
    sound_block[77] <= 23983; // 698
    sound_block[78] <= 25391; // 739
    sound_block[79] <= 26903; // 783
    sound_block[80] <= 28518; // 830
    sound_block[81] <= 30236; // 880
    sound_block[82] <= 32023; // 932
    sound_block[83] <= 33913; // 987
    sound_block[84] <= 35940; // 1046
    sound_block[85] <= 38070; // 1108
    sound_block[86] <= 40338; // 1174
    sound_block[87] <= 42743; // 1244
end


/* 1秒カウンタ */
always @(posedge CLK) begin
    if (count == MAX_CLK) begin
        count <= 0;
    end else begin
        count <= count + 27'd1;
    end
end


/* 一定周期でtemp切替 */
always @(posedge CLK) begin
    if (count == MAX_CLK) begin
        if (71 < temp) begin
            temp <= 64;
        end else begin
            temp <= temp + 7'd1;
        end
    end
end


/* duty比更新 50% 25% */
always @(posedge CLK) begin
    duty[31:30] <= SLIDE_SW;
end


/* tempの間隔で音源切替 */
always @(posedge CLK) begin
    pulse_count <= pulse_count + sound_block[temp];
end

/* pulse波発生 */
always @(posedge CLK) begin
    if (pulse_count < duty) begin
        pulse_out <= 1'd1;
    end else begin
        pulse_out <= 1'd0;
    end
end


assign LED1 = pulse_out;
assign AUD_PWM = pulse_out;
assign CK_IO8 = pulse_out;

endmodule
