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
    input CLK,      /* 125MHz */
    input RESET,    /* RESET端子 */
    output PWM,     /* pwm出力 */
    output PWM_DEBUG, /* オシロで確認用にPWMの出力端子を増やす */
    output LED      /* 動作確認用LED端子 */
);

/* 内部パラメータ */
parameter MAX_CLK = (125000000 - 1) /* 入力クロックの1秒周期の最大値 */
parameter COUNT_WIDTH = 32;         /* 音源の分解能 */
parameter SOUND_BLOCK = (88-1);     /* 音源数 */


/* 内部レジスタ */
reg [6:0] temp;              /* sound_blockインデックス参照用 一応ピアノの88鍵盤のbit幅を用意した */
reg [COUNT_WIDTH-1:0] duty;  /* 周期カウンタ用レジスタ */
reg [COUNT_WIDTH-1:0] sound_block[0:SOUND_BLOCK]; /* ドレミファソラシドの音源 */
reg [26:0] count;


/* 音源バッファの初期化 initialの利用を推奨？されているらしい */
initial begin
    sound_block[0] <= 27;
    sound_block[1] <= 29;
    sound_block[2] <= 30;
    sound_block[3] <= 32;
    sound_block[4] <= 34;
    sound_block[5] <= 36;
    sound_block[6] <= 38;
    sound_block[7] <= 41;
    sound_block[8] <= 43;
    sound_block[9] <= 46;
    sound_block[10] <= 48;
    sound_block[11] <= 51;
    sound_block[12] <= 55;
    sound_block[13] <= 58;
    sound_block[14] <= 61;
    sound_block[15] <= 65;
    sound_block[16] <= 69;
    sound_block[17] <= 73;
    sound_block[18] <= 77;
    sound_block[19] <= 82;
    sound_block[20] <= 87;
    sound_block[21] <= 92;
    sound_block[22] <= 97;
    sound_block[23] <= 103;
    sound_block[24] <= 110;
    sound_block[25] <= 116;
    sound_block[26] <= 123;
    sound_block[27] <= 130;
    sound_block[28] <= 138;
    sound_block[29] <= 146;
    sound_block[30] <= 155;
    sound_block[31] <= 164;
    sound_block[32] <= 174;
    sound_block[33] <= 184;
    sound_block[34] <= 195;
    sound_block[35] <= 207;
    sound_block[36] <= 220;
    sound_block[37] <= 233;
    sound_block[38] <= 246;
    sound_block[39] <= 261;
    sound_block[40] <= 277;
    sound_block[41] <= 293;
    sound_block[42] <= 311;
    sound_block[43] <= 329;
    sound_block[44] <= 349;
    sound_block[45] <= 369;
    sound_block[46] <= 391;
    sound_block[47] <= 415;
    sound_block[48] <= 440;
    sound_block[49] <= 466;
    sound_block[50] <= 493;
    sound_block[51] <= 523;
    sound_block[52] <= 554;
    sound_block[53] <= 587;
    sound_block[54] <= 622;
    sound_block[55] <= 659;
    sound_block[56] <= 698;
    sound_block[57] <= 739;
    sound_block[58] <= 783;
    sound_block[59] <= 830;
    sound_block[60] <= 880;
    sound_block[61] <= 932;
    sound_block[62] <= 987;
    sound_block[63] <= 1046;
    sound_block[64] <= 1108;
    sound_block[65] <= 1174;
    sound_block[66] <= 1244;
    sound_block[67] <= 1318;
    sound_block[68] <= 1396;
    sound_block[69] <= 1479;
    sound_block[70] <= 1567;
    sound_block[71] <= 1661;
    sound_block[72] <= 1760;
    sound_block[73] <= 1864;
    sound_block[74] <= 1975;
    sound_block[75] <= 2093;
    sound_block[76] <= 2217;
    sound_block[77] <= 2349;
    sound_block[78] <= 2489;
    sound_block[79] <= 2637;
    sound_block[80] <= 2793;
    sound_block[81] <= 2959;
    sound_block[82] <= 3135;
    sound_block[83] <= 3322;
    sound_block[84] <= 3520;
    sound_block[85] <= 3729;
    sound_block[86] <= 3951;
    sound_block[87] <= 4186;
end


/* 1秒カウンタ */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        count <= 0;
    end else begin
        if (count == MAX_CLK) begin
            count <= 0;
        end else begin
            count <= 27'd1;
        end
    end
end


/* 一定周期でtemp切替 */
always @(posedge CLK negedge RESET) begin
    if (RESET == 1'h0) begin
        temp <= 0;
    end else begin
        if (count == MAX_CLK) begin
            if (temp == SOUND_BLOCK) begin
                temp <= 0;
            end else begin
                temp <= temp + 7'd1;
            end
        end
    end
end


/* tempの間隔で音源切替 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'h0) begin
        duty <= 0;
    end else begin
        duty <= duty + sound_block[temp];
    end
end

assign LED = duty[31];
assign PWM = duty[31];
assign PWM_DEBUG = duty[31];

endmodule
