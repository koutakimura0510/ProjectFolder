/*
 * Create 2021/1/4
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 評価ボード付属デバイス S25FL256SAGMFI00
 * SPI接続のフラッシュメモリデモプロジェクト
 */
module flashTop #(
    parameter PDIVSCK = 250
)(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    output          oQspiCLK,       // フラッシュメモリsck
    output          oQspiCS,        // フラッシュメモリチップセレクト
    output          oQspiDO,        // SPIデータ出力端子
    input           iQspiDI,        // SPIデータ入力端子
    output          oQspiWP,        // spiモードで使用するためHigh固定
    output          oQspiHOLD       // spiモードで使用するためHigh固定
    input [7:0]     iWData,         // 書き込みデータ
    output [7:0]    oRData,         // 読み込みデータ
    input [15:0]    iLength,        // 書き込み・読み込みバイト数
    input [15:0]    iAddr,          // 書き込み・読み込みアドレス
    output          oWDataValid,    // 書き込み完了時High
    output          oRDataValid     // 読み込みデータ出力時High
);

// parameter ERASE_SECTOR_SIZE  = 256,   // KB
// parameter PROGRAM_SIZE = 512    // Byte
// parameter PARAMETER_SECTOR_SIZE = 4 // KB

flashSpi #(
    .PDIVCLK(PDIVCLK)
) FLASH_SPI (
    .iCLK(iCLK),
    .iRST(iRST),
    .oQspiCLK(oQspiCLK),
    .oQspiCS(oQspiCS),
    .oQspiDO(oQspiDO),
    .iQspiDI(iQspiDI),
    .oQspiWP(oQspiWP),
    .oQspiHOLD(oQspiHOLD),
    .iEnable(iEnable),
    .iWData(iWData),
    .oRData(oRData),
    .oSpiValid(oSpiValid),
    .oWDataValid(oWDataValid),
    .oRDataValid(oRDataValid)
);

endmodule