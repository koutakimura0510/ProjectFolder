//----------------------------------------------------------
// Create 2022/6/28
// Author koutakimura
// -
// ユーザー後処理ブロック
// ターゲットの規格に対応したデータを出力
//----------------------------------------------------------
module PostProcesser (
	// External Port
	output [7:4] 	oTftColorR,
	output [7:4] 	oTftColorG,
	output [7:4] 	oTftColorB,
	output 			oTftDclk,
	output 			oTftHsync,
	output 			oTftVsync,
	output 			oTftDe,
	output 			oTftBackLight,
	output 			oTftRst,
	output 			oAudioMclk,
	output 			oAudioBclk,
	output 			oAudioCclk,
	output 			oAudioData,
	// Internal Port
	input 			iPixelClk,
	input 			iSysRst,
	input  [15:0] 	iPixelData,
	input 			iVde,
	input 			iHsync,
	input 			iVsync,
	input 			iBackLightControl,
	input 			iAudioClk,
	input 			iAudioRst,
	input  [31:0]	iAudioData,
	output          oAudioLRch
);

//---------------------------------------------------------------------------
// TFT Display 送信
//---------------------------------------------------------------------------
tftWrapper TFT_WRAPPER (
	.oTftColorR			(oTftColorR),
	.oTftColorG			(oTftColorG),
	.oTftColorB			(oTftColorB),
	.oTftDclk			(oTftDclk),
	.oTftHsync			(oTftHsync),
	.oTftVsync			(oTftVsync),
	.oTftDe				(oTftDe),
	.oTftBackLight		(oTftBackLight),
	.oTftRst			(oTftRst),
	.iPixelClk 			(iPixelClk),
	.iSysRst			(iSysRst),
	.iPixelData			(iPixelData),
	.iVde				(iVde),
	.iHsync				(iHsync),
	.iVsync				(iVsync),
	.iBackLightControl 	(iBackLightControl)
);


//---------------------------------------------------------------------------
// Audio データを I2S 規格で送信
//---------------------------------------------------------------------------
i2sWrapper I2S_WRAPPER (
	.oAudioMclk		(oAudioMclk),
	.oAudioBclk		(oAudioBclk),
	.oAudioCclk		(oAudioCclk),
	.oAudioData		(oAudioData),
	.iAudioClk		(iAudioClk),
	.iAudioRst		(iAudioRst),
	.iAudioData		(iAudioData),
	.oAudioLRch     (oAudioLRch)
);

endmodule