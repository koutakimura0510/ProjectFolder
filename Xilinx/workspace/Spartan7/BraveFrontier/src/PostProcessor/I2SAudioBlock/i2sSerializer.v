//----------------------------------------------------------
// Create 2022/7/3
// Author koutakimura
// -
// パラレルデータを I2S規格のシリアルデータに変換する
// BCLK LRCLK SDATA をそれぞれ出力
//----------------------------------------------------------
module i2sSerializer (
    // Internal Port
    input           iAudioClk,
    input           iAudioRst,
    input  [31:0]   iAudioData,
    output          oAudioBclk,
    output          oAudioCclk,
    output          oAudioData
);


//----------------------------------------------------------
// MCLK Counter
// MCLK = BCLK(MHz) * 8
// 24.576MHz = 3.072MHz * 8
// negedge だけの SDR なので 実際は 4cnt で検出する
//----------------------------------------------------------
localparam lpMclkCntMax = 4'd4; 

reg  [2:0] rMclkCnt;
wire wMclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rMclkCnt <= 3'd0;
    else if (wMclkCke)  rMclkCnt <= 3'd0;
    else                rMclkCnt <= rMclkCnt + 1'd1;
end

always @*
begin
    wMclkCke <= (rMclkCnt == lpMclkCntMax);
end


//----------------------------------------------------------
// BCLK Generator
//----------------------------------------------------------
reg rBclk;              assign oAudioBclk = rBclk;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rBclk <= 1'd0;
    else if (wMclkCke)  rBclk <= ~rBclk;
    else                rBclk <= rBclk;
end


//----------------------------------------------------------
// LRCLK
// LRch 32bit MSB farst
// Low  LCLK Output
// High RCLK Output
//----------------------------------------------------------
localparam lpCclkCntMax = 6'd31;

reg  rCclk;             assign oAudioCclk = rCclk;
reg  [5:0] rCclkCnt;
wire wCclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rCclkCnt <= 6'd0;
    else if (wCclkCke)  rCclkCnt <= 6'd0;
    else                rCclkCnt <= rCclkCnt + 1'd1;

    if (iAudioRst)      rCclk <= 1'd0;
    else if (wCclkCke)  rCclk <= ~rCclk;
    else                rCclk <= rCclk;
end

always @*
begin
    wCclkCke <= (rCclkCnt == lpCclkCntMax);
end


//----------------------------------------------------------
// パラレル -> シリアル変換
//----------------------------------------------------------


endmodule