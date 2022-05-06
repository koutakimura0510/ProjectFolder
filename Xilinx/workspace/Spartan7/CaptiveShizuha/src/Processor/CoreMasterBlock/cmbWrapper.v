//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// Processor の中枢、システム管理を担うブロック
// Sound Rom に音源データを保存
// 
// 音源データはバスを経由せずに直接 サウンドブロックと結線する
//----------------------------------------------------------
module cmbWrapper (
    input           iSysClk,            // Top Side: System Clk
    input           iRst,               // Top Side: Active High Sync Reset
    input  [ 7:0]   iSoundRd,           // Fmc Side: Read Data
    input           iSoundRdVd,         // Fmc Side: 有効データ読み込み時 High
    input           iSoundSectorCke,    // Fmc Side: Sound Page Read 時 High
    output [26:0]   oSoundAddr,         // Fmc Side: 26:17 Block - 16:11 Page - 10:0 Column
    output          oSoundCke,          // Fmc Side: Rom 読み込み開始
    output          oSoundCmd,          // Fmc Side: 1.Read 0.Write
    input  [ 4:0]   iAction,            // 現在のゲーム状況 Bit
    output [15:0]   oSgbSoundCh0,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh1,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh2,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh3,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh4,       // Sgb Side: 書き込みデータ
    input  [ 4:0]   iSgbChannelRdy,     // Sgb Side: 書き込み可能 Channel 1.
    output          oSgbWdVdCh0,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh1,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh2,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh3,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh4         // Sgb Side: 有効データ書き込み時 High
);


//----------------------------------------------------------
// 現在のモードと状況に応じて、
// SPI Rom の音源データをアドレスを指定して取得し、
// データを各チャンネルに振り分ける
//----------------------------------------------------------
seChannelConnect SE_CHANNEL_CONNECT (
    .iSysClk                (iSysClk),
    .iRst                   (iRst),
    .iSoundRd               (iSoundRd),
    .iSoundRdVd             (iSoundRdVd),
    .iSoundSectorCke        (iSoundSectorCke),
    .oSoundAddr             (oSoundAddr),
    .oSoundCke              (oSoundCke),
    .oSoundCmd              (oSoundCmd),
    .iAction                (iAction),
    .oSgbSoundCh0           (oSgbSoundCh0),
    .oSgbSoundCh1           (oSgbSoundCh1),
    .oSgbSoundCh2           (oSgbSoundCh2),
    .oSgbSoundCh3           (oSgbSoundCh3),
    .oSgbSoundCh4           (oSgbSoundCh4),
    .iSgbChannelRdy         (iSgbChannelRdy),
    .oSgbWdVdCh0            (oSgbWdVdCh0),
    .oSgbWdVdCh1            (oSgbWdVdCh1),
    .oSgbWdVdCh2            (oSgbWdVdCh2),
    .oSgbWdVdCh3            (oSgbWdVdCh3),
    .oSgbWdVdCh4            (oSgbWdVdCh4)
);


endmodule