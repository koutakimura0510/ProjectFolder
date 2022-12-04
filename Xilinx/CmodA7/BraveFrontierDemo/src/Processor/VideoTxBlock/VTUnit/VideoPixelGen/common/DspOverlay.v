/*
Create  2022/12/04
Author  kimura
-
ピクセルデータのオーバーレイ処理を行うモジュール

*/
module DspOverlay #(
	// variable
	parameter						pColorDepth	 = 16,
	// not
	parameter						pRGBBitWidth = pColorDepth / 4,
	parameter						pRBitLsb	 = 0,
	parameter						pGBitLsb	 = pRGBBitWidth,
	parameter						pBBitLsb	 = pRGBBitWidth + pRGBBitWidth,
	parameter						pAlphaBitMsb = pColorDepth - 1,
	parameter						pAlphaBitLsb = pColorDepth - (pColorDepth / 4)
)(
	//
	input	[pColorDepth-1:0]		iDstPixel,
	input	[pColorDepth-1:0]		iSrcPixel,
	output	[pColorDepth-1:0]		oDstPixel,
    // CLK Reset
    input           				iRst,
    input							iClk
);

//
// (* use_dsp48 ="yes" *) wire[31:0] wSrcR = iSrcPixel[pAlphaBitMsb:pAlphaBitLsb] * iSrcPixel[pRBitLsb+:pRGBBitWidth];

// (* use_dsp48 ="yes" *) wire[7:0] wSrcR = iSrcPixel[pAlphaBitMsb:pAlphaBitLsb] * iSrcPixel[pRBitLsb+:pRGBBitWidth];
// (* use_dsp48 ="yes" *) wire[7:0] wSrcG = iSrcPixel[pAlphaBitMsb:pAlphaBitLsb] * iSrcPixel[pGBitLsb+:pRGBBitWidth];
// (* use_dsp48 ="yes" *) wire[7:0] wSrcB = iSrcPixel[pAlphaBitMsb:pAlphaBitLsb] * iSrcPixel[pBBitLsb+:pRGBBitWidth];
//


always @( posedge iCLK )
begin
   if ( src )  <= 
   else  <= 
end

endmodule