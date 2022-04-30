//----------------------------------------------------------
// Create 2022/4/29
// Author koutakimura
// -
// Flash  Memory Control Top Module
//----------------------------------------------------------
module fmTop #(
    parameter [9:0] pClkDiv     = 4,        // 100MHz / 4 = 25MHz
    parameter       pSector     = 2048,     // 1 page の合計セクタ数
    parameter       pPage       = 64,       // 1 block の合計ページ数　
    parameter       pBlock      = 1024,     // Memory のブロック数
    parameter       pHoldTime   = 1,        // Mosi Hold Time
    parameter       pMode       = "mode0"   // mode0 mode3 対応
)(
    input           iSysClk,                // system clk
    input           iRst,                   // Active High
    output          oCs,                    // Chip Select
    output          oSck,                   // spi clk
    output          oMosi,                  // master out slave in
    input           iMiso,                  // master in slave out
    output          oWp,                    // write guard Low Active
    output          oHold,                  // write stop  Low Active
    input  [ 7:0]   iWd,                    // 書き込みデータ
    output [ 7:0]   oRd,                    // 読み込みデータ
    input  [26:0]   iAddr,                  // 26:17 Block - 16:11 Page - 10:0 Column
    input           iCke,                   // 0. disconnect 1. active
    input           iCmd,                   // 1. Read / 0. Write
    output          oWdVd,                  // 書き込み完了時High
    output          oRdVd,                  // 読み込みデータ出力時High
    output          oSectorCke,             // 1page カウント時 High
    output          oWblockCke              // 1block 書き込み時 High
);


//----------------------------------------------------------
// Spi Data Generate
// 上位モジュールからの Addr. Data. Cmd. Cke. を受信し、
// 後段の Spi 送受信モジュール の
//----------------------------------------------------------
wire [7:0] wWd, wRd;
wire wWdVd, wRdVd;
wire wCs, wCke, wCmd;

fmState #(
    .pSector        (pSector),
    .pPage          (pPage),
    .pBlock         (pBlock)
) FM_STATE (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iCke           (iCke),
    .iCmd           (iCmd),
    .iAddr          (iAddr),
    .iWd            (iWd),
    .oWdVd          (oWdVd),
    .oRd            (oRd),
    .oRdVd          (oRdVd),
    .oSectorCke     (oSectorCke),
    .oWblockCke     (oWblockCke),
    .oWd            (wWd),
    .iWdVd          (wWdVd),
    .iRd            (wRd),
    .iRdVd          (wRdVd),
    .oCs            (wCs),
    .oCke           (wCke),
    .oCmd           (wCmd)
);


//----------------------------------------------------------
// Flash Memory Spi Access
//----------------------------------------------------------
fmSpi #(
    .pClkDiv        (pClkDiv),
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
    .iCke           (wCke),
    .iCmd           (wCmd),
    .iCs            (wCs),
    .iWd            (wWd),
    .oRd            (wRd),
    .oWdVd          (wWdVd),
    .oRdVd          (wRdVd)
);

endmodule