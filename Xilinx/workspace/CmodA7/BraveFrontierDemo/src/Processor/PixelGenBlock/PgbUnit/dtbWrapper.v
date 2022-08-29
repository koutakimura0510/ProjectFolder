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
    parameter       pHpulse         =  96,
    parameter       pVdisplay       = 480,
    parameter       pVfront           =  31,
    parameter       pVback        =  11,
    parameter       pVpulse         =   2
)(
    input           iClk,           // clk
    input           iRst,           // Active High to sync rst
    output          oVde,           // video enable signal
    output          oFe,            // frame end
    output          oFvde,          // fast vde
    output          oHSync,
    output          oVSync
);

//----------------------------------------------------------
// ディスプレイ制御信号生成
//----------------------------------------------------------
hVSyncGen #(
    .pHdisplay  (pHdisplay),
    .pVdisplay  (pVdisplay),
    .pHback     (pHback),
    .pVfront      (pVfront),
    .pHfront    (pHfront),
    .pVback   (pVback),
    .pHpulse     (pHpulse),
    .pVpulse     (pVpulse)
) HVSync_GEN (
    .iClk       (iClk),
    .iRst       (iRst),
    .oHSync     (oHSync),
    .oVSync     (oVSync),
    .oVde       (oVde),
    .oFe        (oFe),
    .oFvde      (oFvde)
);

endmodule