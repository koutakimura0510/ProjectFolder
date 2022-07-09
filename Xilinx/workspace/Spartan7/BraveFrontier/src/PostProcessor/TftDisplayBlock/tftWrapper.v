/*
 * Create 2022/6/28
 * Author koutakimura
 * -
 * ディスプレイ制御データをGPIOに接続する
 * パラレル接続なのでシリアル変換などはしなくてよく
 * プロセッサからのデータを出力するだけ
 */
module tftWrapper (
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
	// Internal Port
	input 			iPixelClk,
	input  			iSysRst,
	input [15:0]	iPixelData,
	input  			iVde,
	input  			iHsync,
	input  			iVsync,
	input 			iBackLightControl
);


//---------------------------------------------------------------------------
// TFT DIsplay 出力
//---------------------------------------------------------------------------
genvar i;

generate
	for (i = 0; i < 4; i = i + 1)
	begin
		OBUF TFT_R (.O (oTftColorR[4+i]),	.I (iPixelData[8+i]));
		OBUF TFT_G (.O (oTftColorG[4+i]),	.I (iPixelData[4+i]));
		OBUF TFT_B (.O (oTftColorB[4+i]),	.I (iPixelData[0+i]));
	end
	OBUF TFT_DCLK 	(.O (oTftDclk),		.I (iPixelClk));
	OBUF TFT_HSYNC 	(.O (oTftHsync),	.I (iHsync));
	OBUF TFT_VSYNC 	(.O (oTftVsync),	.I (iVsync));
	OBUF TFT_VDE 	(.O (oTftDe),		.I (iVde));
	OBUF TFT_RST 	(.O (oTftRst),		.I (~iSysRst));
	OBUF TFT_BL 	(.O (oTftBackLight),.I (iBackLightControl));
endgenerate

endmodule