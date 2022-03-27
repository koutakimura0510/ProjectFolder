/*
 * Create 2022/3/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * Display Timing Block
 * Sync系統の制御信号とディスプレイクロックを生成するブロック
 *
 */
module dtpWrapper #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2
)(
    input           iCLK,           // system clk
    input           iRST,           // async rst
    output          oVde,           // video enable signal
    output          oFe,            // frame end
    output          oFvde,          // fast vde
    output          oHsync,
    output          oVsync,
    output          oSCLK,          // Sync CLK
    output          oTCLK,          // Tmds CLk
    output          oRST
);

//----------------------------------------------------------
// ピクセルクロック生成
//----------------------------------------------------------
wire wTClk;                     assign oTCLK = wTClk;
wire wSClk;                     assign oSCLK = wSClk;
wire wLock;
wire wRST = (~wLock);           assign oRST  = wRST;

dtpClkGen DTP_CLK_GEN (
    .clk_out1   (wSClk),        .clk_out2   (wTClk),
    .reset      (iRST),         .locked     (wLock),
    .clk_in1    (iCLK)
);

//----------------------------------------------------------
// ディスプレイ制御信号生成
//----------------------------------------------------------
hvsyncGen #(
    // hrizontal                vertical
    .pHdisplay  (pHdisplay),    .pVdispaly  (pVdispaly),
    .pHback     (pHback),       .pVtop      (pVtop),
    .pHfront    (pHfront),      .pVbottom   (pVbottom),
    .pHsync     (pHsync),       .pVsync     (pVsync)
) HVSYNC_GEN (
    .iSCLK      (wSClk),        .iRST       (wRST),
    .oHsync     (oHsync),       .oVsync     (oVsync),
    .oVde       (oVde),         .oFe        (oFe),
    .oFvde      (oFvde)
);

endmodule