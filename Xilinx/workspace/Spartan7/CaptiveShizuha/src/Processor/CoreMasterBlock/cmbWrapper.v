//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// Processor の中枢、システム管理を担うブロック
// Pixel Rom に画像データとシステム命令のデータを保存
// Sound Rom に音源データを保存
// 
// 音源データはバスを経由せずに直接 サウンドブロックと結線する
//----------------------------------------------------------
module cmbWrapper (
    input           iSysClk,            // Top Side: System Clk
    input           iRst,               // Top Side: Active High Sync Reset
    input  [ 7:0]   iPixelRd,           // Fmc Side: Read Data
    input           iPixelRdVd,         // Fmc Side: 有効データ読み込み時 High
    input           iPixelSectorCke,    // Fmc Side: Pixel Page Read 時 High
    output [26:0]   oPixelAddr,         // Fmc Side: 26:17 Block - 16:11 Page - 10:0 Column
    output          oPixelCke,          // Fmc Side: Rom 読み込み開始
    output          oPixelCmd,          // Fmc Side: 1.Read 0.Write
    input  [ 7:0]   iSoundRd,           // Fmc Side: Read Data
    input           iSoundRdVd,         // Fmc Side: 有効データ読み込み時 High
    input           iSoundSectorCke,    // Fmc Side: Sound Page Read 時 High
    output [26:0]   oSoundAddr,         // Fmc Side: 26:17 Block - 16:11 Page - 10:0 Column
    output          oSoundCke,          // Fmc Side: Rom 読み込み開始
    output          oSoundCmd,          // Fmc Side: 1.Read 0.Write
    input  [ 7:0]   iSlaveRd,           // Usi Bus : 各Slave Module の Csr から読み込むデータ
    input           iSlaveRdVd,         // Usi Bus : 読み込みデータ入力時 High
    output [ 7:0]   oSlaveWd,           // Usi Bus : 各Slave Module の Csr に書き込むデータ
    output [15:0]   oSlaveAddr,         // Usi Bus : 各Slave Module の Csr アドレス
    output          oSlaveWdVd,         // Usi Bus : 書き込みデータ出力時High
    output [15:0]   oSgbSound0,         // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSound1,         // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSound2,         // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSound3,         // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSound4,         // Sgb Side: 書き込みデータ
    input  [ 4:0]   iSgbChannelRdy,     // Sgb Side: 書き込み可能 Channel 1.
    output          oSgbWdVd0,          // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVd1,          // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVd2,          // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVd3,          // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVd4           // Sgb Side: 有効データ書き込み時 High
);


//----------------------------------------------------------
// Pixel Address Gen
//----------------------------------------------------------
localparam [16:0] lpPageUp = 17'h00800;
reg [26:0] rPixelAddr;                                assign oPixelAddr = rPixelAddr;

always @(posedge iSysClk)
begin
    if (iRst)                   rPixelAddr <= 0;
    else if (iPixelSectorCke)   rPixelAddr <= rPixelAddr + lpPageUp;
    else                        rPixelAddr <= rPixelAddr;
end


//----------------------------------------------------------
// Sound Address Gen
//----------------------------------------------------------
seLoadBram SE_LOAD_BRAM (
    .iSysClk                (iSysClk),
    .iRst                   (iRst),
    .iSoundRd               (iSoundRd),
    .iSoundRdVd             (iSoundRdVd),
    .iSoundSectorCke        (iSoundSectorCke),
    .oSoundAddr             (oSoundAddr),
    .oSoundCke              (oSoundCke),
    .oSoundCmd              (oSoundCmd),
    .iSlaveRd               (iSlaveRd),
    .iSlaveRdVd             (iSlaveRdVd),
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


//----------------------------------------------------------
// Rom System Data の並び順
// 0. Addr Msb 8bit
// 1. Addr Lsb 8bit
// 2. Data Msb 8bit
// 3. Data Lsb 8bit
// 
//----------------------------------------------------------

reg [15:0] rSlaveAddr;
reg [15:0] rSlaveWd;

always @(posedge iSysClk)
begin
    rSlaveAddr <= ;
end


endmodule