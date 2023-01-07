/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MVideoPostProcess.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MVideoPostProcess.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MVideoPostProcess #(
parameter		pVideoMaxHRES		= 11'd1920,
parameter		pVideoHBP			= 8'd148,
parameter		pVideoHSP			= 8'd44,
parameter		pVideoHFP			= 8'd88,
parameter		pVideoMaxVRES		= 11'd1080,
parameter		pVideoVBP			= 6'd36,
parameter		pVideoVSP			= 6'd5,
parameter		pVideoVFP			= 6'd4,
//
parameter		pHbitWidth			= fBitWidth(pVideoMaxHRES),
parameter		pVbitWidth			= fBitWidth(pVideoMaxVRES)
)(
output 			oAdv7511Vs,
output 			oAdv7511Hs,
output 			oAdv7511De,
output	[15:0]	oAdv7511Data,
input			iAdv7511Sda,
output			oAdv7511SdaOe,
input			iAdv7511Scl,
output			oAdv7511SclOe,
// Video Signals
input  [15:0]	iVideoData,
input 	 		iVideoVd,
output 			oVideofull,
// Status
input 			iVideoSignalSel,
input 			i_pll_locked,
// common
input 			iSRST,
input 			inSRST,
input 			iPRST,
input 			inPRST,
input 			iVRST,
input 			inVRST,
input 			iBRST,
input 			inBRST,
input			iFRST,
input			inFRST,
input 			iSCLK,
input 			iPCLK,
input 			iVCLK,
input 			iBCLK,
input			iFCLK
);


//-----------------------------------------------------------------------------
// I2C initialization for ADV7511, sample 流用
//-----------------------------------------------------------------------------
adv7511_config #(
	.INITIAL_CODE	("./src/sample/adv7511_reg.mem")
) inst_adv7511_config (
	// Status
	.o_state(),				.o_confdone(),	// ConfDone は 初期設定が完了しても Assert されない
	// I2C I/F
	.i_sda(iAdv7511Sda),	.o_sda_oe(oAdv7511SdaOe),
	.i_scl(iAdv7511Scl),	.o_scl_oe(oAdv7511SclOe),
	// common
	.o_rstn(),				.i_pll_locked(i_pll_locked),
	.i_arst(iBRST),			.i_sysclk(iBCLK)
);


//-----------------------------------------------------------------------------
// SYNC信号生成
//-----------------------------------------------------------------------------
wire 		wVgaGenHs, wVgaGenVs, wVgaGenDe, wVgaGenFDe;
reg [2:0]	rVtgRST;

MVideoTimingGen #(
	.pHdisplay(pVideoMaxHRES),	.pHback(pVideoHBP),
	.pHfront(pVideoHFP),		.pHpulse(pVideoHSP),
	.pVdisplay(pVideoMaxVRES),	.pVback(pVideoVBP),
	.pVfront(pVideoVFP),		.pVpulse(pVideoVSP),
	.pPipeLine(4),				.pFastVdTiming(2)
) mVideoTimingGen (
	.oHSync(wVgaGenHs),			.oVSync(wVgaGenVs),
	.oVde(wVgaGenDe),
	.oFvde(wVgaGenFDe),			.oFe(),
	.oHpos(),					.oVpos(),
	// common
	.iClk(iVCLK),				.iRst(rVtgRST[2])
);


//-----------------------------------------------------------------------------
// ColorBar Gen
//-----------------------------------------------------------------------------

// MColorBarGen mColorBarGen


//-----------------------------------------------------------------------------
// 内部用高速クロックを ビデオタイミングに変換
//-----------------------------------------------------------------------------
localparam lpVdcFifoBitWidth	= 8;
localparam lpVdcFifoDepth		= 8192 / lpVdcFifoBitWidth;
localparam lpVdcFifoBitLoop		= 16   / lpVdcFifoBitWidth;
localparam lpVdcFifoFullAlMost	= 16;

wire [15:0] wVdcRd;
wire [lpVdcFifoBitLoop-1:0]	wVdcfull;			assign oVideofull = wVdcfull[0];

genvar n;

generate
	for (n = 0; n < lpVdcFifoBitLoop; n = n + 1) begin
		fifoDualController #(
			.pFifoDepth(lpVdcFifoDepth),	.pFifoBitWidth(lpVdcFifoBitWidth),
			.pFullAlMost(lpVdcFifoFullAlMost)
		) mVideoDualClkFIFO (
			// Write Side
			.iWd(iVideoData[(n+1)*lpVdcFifoBitWidth-1:n*lpVdcFifoBitWidth]),
			.iWe(iVideoVd),					.ofull(wVdcfull[n]),
			.iSrcClk(iFCLK),				.iSrcRst(iFRST),
			// Read Side
			.oRd(wVdcRd[(n+1)*lpVdcFifoBitWidth-1:n*lpVdcFifoBitWidth]),
			.iRe(wVgaGenFDe),
			.oRvd(),						.oEmp(),
			.iDstClk(iVCLK),				.iDstRst(iVRST)
		);
	end
endgenerate

assign oAdv7511Vs	= wVgaGenVs;
assign oAdv7511Hs	= wVgaGenHs;
assign oAdv7511De	= wVgaGenDe;
assign oAdv7511Data = wVdcRd;	// ADV7511, YUYV -> [15:8] U,V, [7:0] Y


//-----------------------------------------------------------------------------
// RST Generate
// 出力するピクセルデータが一定数溜まるまで VGA の Rst Active をキープする
//-----------------------------------------------------------------------------
localparam 	lpVtgRstMaxCnt	  = 1920;
localparam 	lpVtgRstBitWidth  = 11;

reg 						rVtgRstSel, qVtgRstSelCke;
reg 						qVtgRstCntCke;
reg  [lpVtgRstBitWidth-1:0] rVtgRstCnt;
wire [lpVtgRstBitWidth:0]	wVtgRstCnt = rVtgRstCnt + 1'b1;

always @(posedge iFCLK)
begin
	if (iFRST) 				rVtgRstSel <= 1'b1;
	else if (qVtgRstSelCke)	rVtgRstSel <= 1'b0;
	else 					rVtgRstSel <= rVtgRstSel;

	if (iFRST) 				rVtgRstCnt <= {lpVtgRstBitWidth{1'b0}};
	else if (qVtgRstCntCke)	rVtgRstCnt <= wVtgRstCnt;
	else 					rVtgRstCnt <= rVtgRstCnt;
end

always @(posedge iVCLK)
begin
	if (iVRST) 				rVtgRST <= 3'b111;
	else 					rVtgRST <= {rVtgRST[1:0],rVtgRstSel};
end

always @*
begin
	qVtgRstSelCke <= (lpVtgRstMaxCnt == rVtgRstCnt);
	qVtgRstCntCke <= &{iVideoVd,rVtgRstSel};
end



//-----------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//-----------------------------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule

//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------