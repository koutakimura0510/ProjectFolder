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
    input           iBtnC,
    output          oQspiCLK,   // フラッシュメモリsck
    output          oQspiCS,    // フラッシュメモリチップセレクト
    output          oQspiDO,    // SPIデータ出力端子
    input           iQspiDI,    // SPIデータ入力端子
    output          oQspiWP,    // spiモードで使用するためHigh固定
    output          oQspiHOLD,  // spiモードで使用するためHigh固定
    output          oUartRX,    // test用 uart端子
    output [7:0]    oLED    
);


flashTop #(
    .PDIVSCK(250)
) FLASH_TOP (
    .iCLK(iCLK),
    .iRST(iRST),
    .oQspiCLK(oQspiCLK),
    .oQspiCS(oQspiCS),
    .oQspiDO(oQspiDO),
    .iQspiDI(iQspiDI),
    .oQspiWP(oQspiWP),
    .oQspiHOLD(oQspiHOLD)
);

endmodule
