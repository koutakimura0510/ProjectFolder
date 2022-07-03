//----------------------------------------------------------
// Create 2022/7/3
// Author koutakimura
// -
// プロセッサから受信するデータをI2S信号に変換しGPIOに出力
//----------------------------------------------------------
module i2cWrapper (
    // External Port
    output          oAudioMclk,
    output          oAudioBclk,
    output          oAudioCclk,
    output          oAudioData,
    // Internal Port
    input           iAudioClk,
    input           iAudioRst,
    input [31:0]    iAudioData
);



OBUF I2S_MCLK 	(.O (oAudioMclk),   .I (1'b0));
OBUF I2S_BCLK 	(.O (oAudioBclk),   .I (1'b0));
OBUF I2S_CCLK 	(.O (oAudioCclk),   .I (1'b0));
OBUF I2S_DATA 	(.O (oAudioData),   .I (1'b0));



endmodule