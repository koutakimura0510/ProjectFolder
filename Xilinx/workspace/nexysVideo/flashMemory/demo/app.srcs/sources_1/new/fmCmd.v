/*
 * Create 2021/1/4
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * コマンド発行
 */
module flashCmd (
    input           iClk,           // system clk
    input           iRst,           // system rst
    input           iCke,           // 0. disconnect 1. active
    input  [7:0]    iWd,            // 書き込みデータ
    output [7:0]    oRd,            // 読み込みデータ
    output          oSpiVd,         // 1byteデータ送信完了時High
    output          oWdVd,          // 書き込み完了時High
    output          oRdVd           // 読み込みデータ出力時High
);


//----------------------------------------------------------
// メモリ構造例
// sector 256 KB
// page   1sector * 8 = 2048
// Block  1page   * 8 = 16392
// 
// 送信順
// 命令 + アドレス + モード + ダミー + データ (アドレス + モード + ダミーは省略される場合あり)
//
// [Write]
// 書き込み・消去コマンドを実行する場合、
// 直前に WREN コマンドを発行し、WELレジスタに1を設定する必要がある。
// WREN コマンド発行時はコマンドの1byteのみ発行しCSをHighにする必要がある
// ページ書き込みコマンドは 1セクタ 連続書き込みが可能（デバイスによるが512byte連続書き込みなど）
// 書き込み・消去後は RDSR1 コマンドを実行し、WIP レジスタに0が入力されるまで次のコマンドを実行してはならない
// .CS の High Low は最低 100ns 維持しなければならない
//
// 「1ページ 256byte のメモリに書き込む際の手順」
// .CS Low
// .WREN コマンド発行し Enable
// .CS High
// .CS Low
// .P4E(4P4E) コマンド発行し 1セクタを消去、書き込み前に 1セクタ領域を消去しなければならない
// .RDSR1 発行し、WIP レジスタに 0 が入力されるまで待機
// .CS High
// .CS Low
// .WREN コマンド発行し Enable
// .PP(4PP) コマンド発行
// .3~4 byte アドレス発行
// .256byte 書き込み
// .RDSR1 発行し、WIP レジスタに 0 が入力されるまで待機
// .CS High
// .CS Low
// .書き込み終了後 WRDI コマンド発行し Disable
// .CS High
//
// [Read]
// W25N01GV の場合 Read は列のアドレス (16bit) 指定のみ受け付けるみたい
// 列アドレス発行後、列の 0番地アドレスから 1セクタ又は1ページ分のデータを読み出す
// 
// 「Read 発行手順」
// .CS Low
// .READ(0x03) コマンド発行
// .2byte Column アドレス発行
// .1byte Dummy Clk 発行
// .SCK の立下がりで デバイスからデータが順次出力される 連続で 1page 読み込み可能
// .CS High
// 
// [容量]
// 128MB -> 24bit -> 24bitコマンド使用
// 256MB -> 25bit -> 32bitコマンド使用
//----------------------------------------------------------

//---------------------------------------------------------------------------
// Winbond W25N01GV　レジスタマップ
//---------------------------------------------------------------------------
localparam CMD_REMS  = 8'h90;   // デバイスのIDを取得、Cmd + Null24bit address + 2byte Null data
localparam CMD_RDID  = 8'h9f;   // JEDEC Manufacturer ID and JEDEC CF1
localparam CMD_READ  = 8'h03;   // Read 3 byte address -> Cmd + Addr + Data(MOSI は0でよい)
// localparam CMD_4READ = 8'h13;   // Read 4 byte address -> Cmd + Addr + Data(MOSI は0でよい)
localparam CMD_WREN  = 8'h06;   // Write Enable  -> Cmd
localparam CMD_WRDI  = 8'h04;   // Write Disable -> Cmd
localparam CMD_P4E   = 8'h20;   // Parameter Sector Erase 3byte Address -> Cmd + Addr
localparam CMD_4P4E  = 8'h21;   // Parameter Sector Erase 4byte Address -> Cmd + Addr
localparam CMD_BE    = 8'hD8;   // Parameter Block Erase 3byte Address -> Cmd + Dummy + 16bit page Addr
// localparam CMD_4BE   = 8'hDC;   // Parameter Block Erase 4byte Address -> Cmd + Dummy + 16bit page Addr
localparam CMD_P8E   = 8'h40;   // 全消去 
localparam CMD_BE    = 8'h60;   // Bulk Erase
localparam CMD_PP    = 8'h02;   // Page Program 3byte Address -> Cmd + Addr + Data
// localparam CMD_4PP   = 8'h12;   // Page Program 4byte Address -> Cmd + Addr + Data
localparam CMD_RDSR1 = 8'h05;   // Read Status Register-1 WIPの確認用0x01 -> Cmd + Dummy Clk

reg [7:0] out;  

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        Q <= D;
    end else begin
        Q <= D;
    end
end

endmodule