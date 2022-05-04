//------------------------------------------------------
// Create 2022/5/3
// Author koutakimura
// -
// 音源の生成を行うブロック
// ピクセルデータと同じく、ビデオタイミングの音源データを使用する
// データアイランド領域になる前に、音源の生成を完了していなければならない
// そのため、有効データの出力を表す Valid 信号を用意しない
//------------------------------------------------------
module sgbWrapper (
    input                   iSysClk,        // Pre  Side: System Clk
    input                   iRst,           // Pre  Side: Active High
    input  [15:0]           iSoundCh0,      // Cmb  Side: 音源データ
    input  [15:0]           iSoundCh1,      // Cmb  Side: 音源データ
    input  [15:0]           iSoundCh2,      // Cmb  Side: 音源データ
    input  [15:0]           iSoundCh3,      // Cmb  Side: 音源データ
    input  [15:0]           iSoundCh4,      // Cmb  Side: 音源データ
    input                   iWdVdCh0,       // Cmb  Side: 有効データ書き込み時 High
    input                   iWdVdCh1,       // Cmb  Side: 有効データ書き込み時 High
    input                   iWdVdCh2,       // Cmb  Side: 有効データ書き込み時 High
    input                   iWdVdCh3,       // Cmb  Side: 有効データ書き込み時 High
    input                   iWdVdCh4,       // Cmb  Side: 有効データ書き込み時 High
    output [ 4:0]           oChannelRdy,    // Cmb  Side: 書き込み可能 Channel ID 1.
    input                   iCke,           // Post Side: 音源データ読み込み時 High
    output [15:0]           oSound          // Post Side: 音源データ出力
);



endmodule