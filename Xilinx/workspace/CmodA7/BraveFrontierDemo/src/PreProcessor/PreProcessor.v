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
    output          oSysRst,        // Active High Sync Reset
    output          oAudioRst		// Active High Sync Reset
    output          oMemClk,
    output          oVideoClk,
    output          oSysClk,
    output          oAudioClk,
	output 			oUfibClk,
);


//----------------------------------------------------------
// Clock Generate Block
//----------------------------------------------------------
wire wSysRst;			assign oSysRst 		= wSysRst;
wire wAudioRst;			assign oAudioRst 	= wAudioRst;
//
wire wMemClk;			assign oMemClk		= wMemClk;
wire wVideoClk;			assign oVideoClk	= wVideoClk;
wire wSysClk;			assign oSysClk		= wSysClk;
wire wAudioClk;			assign oAudioClk 	= wAudioClk;
wire wUfibClk;			assign oUfibClk 	= wUfibClk;

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
    .oAudioClk  (wAudioClk),
    .oUfibClk   (wUfibClk)
);


endmodule