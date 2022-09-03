//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト前処理ブロック
// Processor. PostProcesser のシステムを動作させるための CLK を生成する
// 
//----------------------------------------------------------
module PreProcesser #(
    parameter       pSystemPll      = "on",
    parameter       pAudioPll       = "on"
)(
	// External Port
    input           iClk,
    input           iAudioClk,
	// Internal Port
    output          oMemClk,
    output          oVideoClk,
    output          oSysClk,
    output          oAudioClk,
    output          oSysRst,        // Active High Sync Reset
    output          oAudioRst		// Active High Sync Reset
);


//----------------------------------------------------------
// Clock Generate Block
//----------------------------------------------------------
wire wMemClk, wVideoClk, wSysClk, wAudioClk;    assign {oMemClk, oVideoClk, oSysClk, oAudioClk} = {wMemClk, wVideoClk, wSysClk, wAudioClk};
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
    .oVideoClk  (wVideoClk),
    .oSysClk    (wSysClk),
    .oAudioClk  (wAudioClk)
);


endmodule