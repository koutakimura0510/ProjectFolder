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
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input           iEnable,        // 0. disconnect 1. active
    input  [7:0]    iWData,         // 書き込みデータ
    output [7:0]    oRData,         // 読み込みデータ
    output          oSpiValid,      // 1byteデータ送信完了時High
    output          oWDataValid,    // 書き込み完了時High
    output          oRDataValid     // 読み込みデータ出力時High
);


//----------------------------------------------------------
// コマンド定数
//
// [Write]
// 書き込み・消去コマンドを実行する場合、
// 直前にWRENコマンドを発行し、WELレジスタに1を設定する必要がある。
// WRENコマンド発行時はコマンドの1byteのみ発行しCSをHighにする必要がある
// ページ書き込みコマンドは1セクタ連続書き込みが可能（デバイスによるが512byte連続書き込みなど）
// 書き込み・消去後はRDSR1コマンドを実行し、WIPレジスタに0が入力されるまで次のコマンドを実行してはならない
// .CSのHigh Lowは最低100ns維持しなければならない
//
// 仮の1ページ256byteのメモリに書き込む際の手順
// .CS Low
// .WRENコマンド発行しEnable
// .CS High
// .CS Low
// .P4E(4P4E)コマンド発行しセクタを消去、書き込み前に1セクタ領域を消去しなければならない
// .WIPレジスタに0が入力されるまで待機
// .CS High
// .CS Low
// .WRENコマンド発行しEnable
// .PP(4PP)コマンド発行
// .256byte書き込み
// .WIPレジスタに0が入力されるまで待機
// .CS High
// .書き込み終了後WRDIコマンド発行しDisable
//
// [Read]
// 連続で1セクタ読み込み可能
// 
// [容量]
// 128MB -> 24bit -> 24bitコマンド使用
// 256MB -> 25bit -> 32bitコマンド使用
//----------------------------------------------------------

//---------------------------------------------------------------------------
// Winbond W25Q256　レジスタマップ
//---------------------------------------------------------------------------
localparam CMD_REMS  = 8'h90;   // デバイスのIDを取得、Cmd + Null24bit address + 2byte Null data
localparam CMD_RDID  = 8'h9f;   // JEDEC Manufacturer ID and JEDEC CF1
localparam CMD_READ  = 8'h03;   // Read 3 byte address
localparam CMD_4READ = 8'h13;   // Read 4 byte address
localparam CMD_WREN  = 8'h06;   // Write Enable
localparam CMD_WRDI  = 8'h04;   // Write Disable
localparam CMD_P4E   = 8'h20;   // Parameter 4-KB Sector Erase 3byte Address
localparam CMD_4P4E  = 8'h21;   // Parameter 4-KB Sector Erase 4byte Address
localparam CMD_BE    = 8'hD8;   // Parameter 64-KB Block Erase 3byte Address
localparam CMD_4BE   = 8'hDC;   // Parameter 64-KB Block Erase 4byte Address
localparam CMD_P8E   = 8'h40;   // 全消去
localparam CMD_BE    = 8'h60;   // Bulk Erase
localparam CMD_PP    = 8'h02;   // Page Program 3byte Address
localparam CMD_4PP   = 8'h12;   // Page Program 4byte Address
localparam CMD_RDSR1 = 8'h05;   // Read Status Register-1 WIPの確認用0x01

reg [7:0] out;  

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        Q <= D;
    end else begin
        Q <= D;
    end
end

endmodule