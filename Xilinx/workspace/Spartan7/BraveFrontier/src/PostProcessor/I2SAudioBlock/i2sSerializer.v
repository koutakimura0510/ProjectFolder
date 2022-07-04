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
// BCLK Generator
// MCLK = BCLK(MHz) * 8
// 24.576MHz = 3.072MHz * 8
// negedge だけの SDR なので 実際は 4cnt で検出する
//----------------------------------------------------------
localparam lpBclkCntMax = 4'd4; 

reg  [2:0] rMclkCnt;
reg  rBclk;              assign oAudioBclk = rBclk;
wire wBclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rMclkCnt <= 3'd0;
    else if (wBclkCke)  rMclkCnt <= 3'd0;
    else                rMclkCnt <= rMclkCnt + 1'd1;

    if (iAudioRst)      rBclk <= 1'd0;
    else if (wBclkCke)  rBclk <= ~rBclk;
    else                rBclk <= rBclk;
end

always @*
begin
    wBclkCke <= (rMclkCnt == lpBclkCntMax);
end


//----------------------------------------------------------
// LRCLK
// Low  LCLK Output
// High RCLK Output
// Bclk の CKE が DDR でアサートされるので、32bit x 2clk
// 合計 64カウント のレジスタを確保する
//----------------------------------------------------------
localparam lpCclkCntMax = 7'd63;

reg  rCclk;             assign oAudioCclk = rCclk;
reg  [6:0] rCclkCnt;
wire wCclkCke;

always @(negedge iAudioClk)
begin
    if (iAudioRst)      rCclkCnt <= 7'd0;
    else if (wBclkCke)  rCclkCnt <= rCclkCnt + 1'd1;
    else                rCclkCnt <= rCclkCnt;

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
// LRch 32bit MSB farst
//----------------------------------------------------------
reg  rAudioData;           assign oAudioData = rAudioData;
wire wBitRp;

always @(negedge iAudioClk)
begin
    if (wCclkCke)  rAudioData <= iAudioData[0];
    else           rAudioData <= iAudioData[wBitRp];
end

always @*
begin
    wBitRp <= ~(rCclkCnt[6:1]);
end

endmodule