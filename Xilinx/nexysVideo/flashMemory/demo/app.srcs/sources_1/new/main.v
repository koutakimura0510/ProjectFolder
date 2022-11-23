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
module main (
    input           iCLK,       // system clk
    input           iRST,       // system rst
    output          oQspiCLK,   // フラッシュメモリsck
    output          oQspiCS,    // フラッシュメモリチップセレクト
    output          oQspiDO,    // SPIデータ出力端子
    input           iQspiDI,    // SPIデータ入力端子
    output          oQspiWP,    // spiモードで使用するためHigh固定
    output          oQspiHOLD   // spiモードで使用するためHigh固定
);


flashTop #(
    .pClkDiv    (4),
    .pHoldTime  (10),
    .pMode      ("mode0")
) FLASH_TOP (
    .iSysClk    (iClk),
    .oCs        (oQspiCS),
    .oSck       (oQspiCLK),
    .oMosi      (oQspiDO),
    .iMiso      (oQspiDI),
    .oWp        (oQspiWP),
    .oHold      (oQspiHOLD),
    .iWd        (iWd),
    .oRd        (oRd),
    .iAddr      (iAddr),
    .iCke       (iCke),
    .iCmd       (iCmd),
    .oWdVd      (oWdVd),
    .oRdVd      (oRdVd)
);

endmodule
