/*
 * Create 2022/3/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * Display Timing Block
 */
module dtbWrapper #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2
)(
    input           iCLK,           // clk
    input           iRST,           // Active High to sync rst
    output          oVde,           // video enable signal
    output          oFe,            // frame end
    output          oFvde,          // fast vde
    output          oHsync,
    output          oVsync
);

//----------------------------------------------------------
// ディスプレイ制御信号生成
//----------------------------------------------------------
hvsyncGen #(
    // hrizontal                vertical
    .pHdisplay  (pHdisplay),    .pVdisplay  (pVdisplay),
    .pHback     (pHback),       .pVtop      (pVtop),
    .pHfront    (pHfront),      .pVbottom   (pVbottom),
    .pHsync     (pHsync),       .pVsync     (pVsync)
) HVSYNC_GEN (
    .iCLK       (iPClk),        .iRST       (iRST),
    .oHsync     (oHsync),       .oVsync     (oVsync),
    .oVde       (oVde),         .oFe        (oFe),
    .oFvde      (oFvde)
);

endmodule