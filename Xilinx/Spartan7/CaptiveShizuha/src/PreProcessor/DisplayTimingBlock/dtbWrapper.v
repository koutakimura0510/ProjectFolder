/*
 * Create 2022/3/27
 * Author koutakimura
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
    input           iClk,           // clk
    input           iRst,           // Active High to sync rst
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
    .pHdisplay  (pHdisplay),
    .pVdisplay  (pVdisplay),
    .pHback     (pHback),
    .pVtop      (pVtop),
    .pHfront    (pHfront),
    .pVbottom   (pVbottom),
    .pHsync     (pHsync),
    .pVsync     (pVsync)
) HVSYNC_GEN (
    .iClk       (iClk),
    .iRst       (iRst),
    .oHsync     (oHsync),
    .oVsync     (oVsync),
    .oVde       (oVde),
    .oFe        (oFe),
    .oFvde      (oFvde)
);

endmodule