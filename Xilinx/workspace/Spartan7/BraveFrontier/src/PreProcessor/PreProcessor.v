//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト前処理ブロック
// Processor. PostProcesser のシステムを動作させるための CLK を生成する
// 
//----------------------------------------------------------
module PreProcesser #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2,
    parameter       pPixelDebug     = "off",
    parameter       pSystemPll      = "on",
    parameter       pAudioPll       = "on"
)(
    input           iClk,
    input           iAudioClk,
    output          oMemClk,
    output          oPixelClk,
    output          oSysClk,
    output          oAudioClk,
    output          oSysRst,        // Active High Sync Reset
    output          oAudioRst,      // Active High Sync Reset
    output          oVde,
    output          oFe,
    output          oFvde,
    output          oHsync,
    output          oVsync
);


//----------------------------------------------------------
// Clock Generate Block
//----------------------------------------------------------
wire wMemClk, wPixelClk, wSysClk, wAudioClk;    assign {oMemClk, oPixelClk, oSysClk, oAudioClk} = {wMemClk, wPixelClk, wSysClk, wAudioClk};
wire wSysRst, wAudioRst;                        assign {oSysRst, oAudioRst} = {wSysRst, wAudioRst};

cgbWrapper # (
    .pSystemPll (pSystemPll),
    .pAudioPll  (pAudioPll)
) CGB (
    .iClk       (iClk),
    .iAudioClk  (iAudioClk),
    .oRst       (wSysRst),
    .oAudioRst  (wAudioRst),
    .oMemClk    (wMemClk),
    .oPixelClk  (wPixelClk),
    .oSysClk    (wSysClk),
    .oAudioClk  (wAudioClk)
);


//----------------------------------------------------------
// Display Timing Block 
//----------------------------------------------------------
wire wVde, wFe, wFvde, wHsync, wVsync;

assign oVde     = wVde;
assign oFe      = wFe;
assign oFvde    = wFvde;
assign oHsync   = wHsync;
assign oVsync   = wVsync;

dtbWrapper #(
    .pHdisplay  (pHdisplay),
    .pHback     (pHback),
    .pHfront    (pHfront),
    .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),
    .pVtop      (pVtop),
    .pVbottom   (pVbottom),
    .pVsync     (pVsync)
) DTP (
    .iClk       (wPixelClk),
    .iRst       (wSysRst),
    .oVde       (wVde),
    .oFe        (wFe),
    .oFvde      (wFvde),
    .oHsync     (wHsync),
    .oVsync     (wVsync)
);

endmodule