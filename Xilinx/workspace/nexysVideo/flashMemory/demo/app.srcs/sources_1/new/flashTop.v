//----------------------------------------------------------
// Create 2022/4/28
// Author koutakimura
// -
//----------------------------------------------------------
module flashTop #(
    parameter [9:0] pClkDiv   = 4,      // 100MHz / 4 = 25MHz
    parameter       pHoldTime = 10,     // Mosi Hold Time
    parameter       pMode     = "mode0" // mode0 mode3 対応
)(
    input           iSysClk,            // system clk
    input           iRst,               // system rst
    output          oCs,                // Chip Select
    output          oSck,               // spi clk
    output          oMosi,              // master out slave in
    input           iMiso,              // master in slave out
    output          oWp,                // write guard Low Active
    output          oHold,              // write stop  Low Active
    input  [15:0]   iWd,                // 書き込みデータ
    output [15:0]   oRd,                // 読み込みデータ
    input  [26:0]   iAddr,              // 26:17 Block - 16:11 Page - 10:0 Column
    input           iCke,               // 0. disconnect 1. active
    input           iCmd,               // 1. Read / 0. Write
    output          oWdVd,              // 書き込み完了時High
    output          oRdVd               // 読み込みデータ出力時High
);

// parameter ERASE_SECTOR_SIZE  = 256,   // KB
// parameter PROGRAM_SIZE = 512    // Byte
// parameter PARAMETER_SECTOR_SIZE = 4 // KB


//----------------------------------------------------------
// Spi Data Generate
// 上位モジュールからの Addr. Data. Cmd. Cke. を受信し、
// 後段の Spi 送受信モジュール の
//----------------------------------------------------------
flash


//----------------------------------------------------------
// Flash Memory Spi Access
//----------------------------------------------------------
fmSpi #(
    .pClkDiv        (pClkDiv)
    .pHoldTime      (pHoldTime),
    .pMode          (pMode)
) FM_SPI (
    .iSysClk        (iSysClk),
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
    .oWdVd          (oWdVd),
    .oRdVd          (oRdVd)
);

endmodule