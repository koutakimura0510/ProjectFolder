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
    parameter       pClkDiv = 4
)(
    input           iSysClk,        // system clk
    input           iRst,           // system rst
    output          oCs,            // Chip Select
    output          oSck,           // spi clk
    output          oMosi,          // master out slave in
    input           iMiso,          // master in slave out
    output          oWp,            // write guard Low Active
    output          oHold,          // write stop  Low Active
    input           iCke,           // 0. disconnect 1. active
    input  [15:0]   iWd,            // 書き込みデータ
    output [15:0]   oRd,            // 読み込みデータ
    output          oWdVd,          // 書き込み完了時High
    output          oRdVd           // 読み込みデータ出力時High
);

// parameter ERASE_SECTOR_SIZE  = 256,   // KB
// parameter PROGRAM_SIZE = 512    // Byte
// parameter PARAMETER_SECTOR_SIZE = 4 // KB

flashSpi #(
    .pClkDiv        (pClkDiv)
) FLASH_SPI (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .oCs            (oCs),
    .oSck           (oSck),
    .oMosi          (oMosi),
    .iMiso          (iMiso),
    .oWp            (oWp),
    .oHold          (oHold),
    .iCke           (iCke),
    .iCs            (iCs),
    .iWd            (iWd),
    .oRd            (oRd),
    .oSpiVd         (oSpiVd),
    .oWdVd          (oWdVd),
    .oRdVd          (oRdVd)
);

endmodule