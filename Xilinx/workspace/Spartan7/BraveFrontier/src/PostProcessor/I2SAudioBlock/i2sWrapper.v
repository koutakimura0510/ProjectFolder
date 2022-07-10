//----------------------------------------------------------
// Create 2022/7/3
// Author koutakimura
// -
// I2S信号生成ラッパーモジュール
//----------------------------------------------------------
module i2sWrapper (
    // External Port
    output          oAudioMclk, // Master CLK
    output          oAudioBclk, // Base CLK
    output          oAudioCclk, // LR CLK
    output          oAudioData, // Serial Data
    // Internal Port
    input           iAudioClk,  // MCLK
    input           iAudioRst,  // MCLK Sync Reset
    input [31:0]    iAudioData, // 
    output          oAudioLRch  // Low L-Ch / High R-Ch 上位モジュールでLRChを区別する時に使用する
);


//----------------------------------------------------------
// パラレル -> シリアル変換と I2S 信号の生成
//----------------------------------------------------------
wire wAudioBclk;
wire wAudioCclk;
wire wAudioData;
wire wAudioLRch;            assign oAudioLRch = wAudioLRch;

i2sSerializer I2S_SERIALIZER (
    .iAudioClk  (iAudioClk),
    .iAudioRst  (iAudioRst),
    .iAudioData (iAudioData),
    .oAudioBclk (wAudioBclk),
    .oAudioCclk (wAudioCclk),
    .oAudioData (wAudioData),
    .oAudioLRch (wAudioLRch)
);

OBUF I2S_MCLK 	(.O (oAudioMclk),   .I (iAudioClk));
OBUF I2S_BCLK 	(.O (oAudioBclk),   .I (wAudioBclk));
OBUF I2S_CCLK 	(.O (oAudioCclk),   .I (wAudioCclk));
OBUF I2S_DATA 	(.O (oAudioData),   .I (wAudioData));

endmodule