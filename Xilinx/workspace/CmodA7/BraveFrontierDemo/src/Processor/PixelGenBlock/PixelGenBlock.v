//----------------------------------------------------------
// Create  2022/08/21
// Author  KoutaKimura
// -
// TFT Display の制御を司る
// 
//----------------------------------------------------------
module TFTBlock #(
    parameter       pHdisplay     = 480,
    parameter       pHback        =  43,
    parameter       pHfront       =   8,
    parameter       pHsync        =  30,
    parameter       pVdisplay     = 272,
    parameter       pVtop         =  12,
    parameter       pVbottom      =   4,
    parameter       pVsync        =  10
)(
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
	input [11:0]	iPixelData,
	output 			oVde,
	output 			oHsync,
	output 			oVsync,
	// CLK Rst
	input 			iPixelClk,
	input  			iSysRst
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
	OBUF TFT_DCLK 	(.O (oTftDclk),			.I (iPixelClk));
	OBUF TFT_HSYNC 	(.O (oTftHsync),		.I (iHsync));
	OBUF TFT_VSYNC 	(.O (oTftVsync),		.I (iVsync));
	OBUF TFT_VDE 	(.O (oTftDe),			.I (iVde));
	OBUF TFT_RST 	(.O (oTftRst),			.I (~iSysRst));
	OBUF TFT_BL 	(.O (oTftBackLight),	.I (iBackLightControl));
endgenerate


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