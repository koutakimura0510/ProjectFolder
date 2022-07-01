//----------------------------------------------------------
// Create 2022/6/28
// Author koutakimura
// -
// ホスト後処理ブロック
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
	input 			iAudioClk,
	input 			iSysRst,
	input 			iAudioRst,
	input  [15:0] 	iPixel,
	input 			iVde,
	input 			iHsync,
	input 			iVsync,
	input  [15:0]	iAudio,
	input 			iBackLightControl,
	input  [1:0]	iAudioVolumeSw	// [1] UP / [0] DOWN
);

//---------------------------------------------------------------------------
// TFT Display 送信
//---------------------------------------------------------------------------
tftWrapper TFT_WRAPPER (
	.oTftColorR		(oTftColorR),
	.oTftColorG		(oTftColorG),
	.oTftColorB		(oTftColorB),
	.oTftDclk		(oTftDclk),
	.oTftHsync		(oTftHsync),
	.oTftVsync		(oTftVsync),
	.oTftDe			(oTftDe),
	.oTftBackLight	(oTftBackLight),
	.oTftRst		(oTftRst),
	.PixelClk 		(iPixelClk),
	.iSysRst		(iSysRst),
	.iPixel			(iPixel),
	.iVde			(iVde),
	.iHsync			(iHsync),
	.iVsync			(iVsync)
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
	.iAudio			(iAudio)
);


endmodule