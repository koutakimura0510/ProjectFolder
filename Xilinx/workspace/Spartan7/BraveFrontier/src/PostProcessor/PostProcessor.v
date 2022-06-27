//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト後処理ブロック
// ターゲットの規格に対応したデータを出力
//----------------------------------------------------------
module PostProcesser (
	input 			iPixelClk,
	input 			iAudioClk,
	input 			iSysRst,
	input 			iAudioRst,
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
	input  [15:0] 	iPixel,
	input 			iVde,
	input 			iHsync,
	input 			iVsync,
	input  [15:0]	iAudio
);

//---------------------------------------------------------------------------
// TFT Display 送信
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
// Audio データを I2S 規格で送信
//---------------------------------------------------------------------------



endmodule