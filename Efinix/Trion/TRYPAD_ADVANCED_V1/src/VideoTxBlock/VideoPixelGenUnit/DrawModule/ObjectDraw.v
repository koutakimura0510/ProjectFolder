/*------------------------------------------------------------------------------
 * Object Draw module
 * 2025-03-29 v1.00 : release
 *-----------------------------------------------------------------------------*/
module ObjectDraw #(
	parameter		pVHAW  			= 11,
	parameter		pVVAW  			= 11,
	parameter		pDstColorDepth	= 16,			// 入出力ピクセルデータの深度
	parameter 		pSynColorDepth	= 24,			// α値を含む内部生成データの深度
	parameter [7:0]	pCacheBaseAdrs	= 8'h10,
	parameter		pRamDepth		= 1024,			// Block Ram Size
	parameter		pObjectAnimeNum	= 8,			// アニメーション可能なオブジェクトの個数
	parameter		pObjectAnimeTime= 8,			// アニメーション指定時間の最大時間 Bit幅で指定する。1フレーム単位で処理するため、8bit幅だったら 最大255フレーム間隔で可能になる。
	parameter		pObjectAnimeXposWidth	= 16,	// [15:11] NC Bit, [10:0] xpos
	parameter		pObjectAnimeYposWidth	= 16	// [15:11] NC Bit, [10:0] ypos
)(
	// Dst Pixel Stream I/F
	output	[pDstColorDepth-1:0]	oPD,		// Pixel Data
	output 							oVD,		// Pixel Valid
	output 							oFD,		// Frame Valid
	output 							oLD,		// Line Valid
	output	[pVHAW-1:0]				oBHPD,
	output	[pVVAW-1:0]				oBVPD,
	output	[pVHAW-1:0]				oPHPD,		// Player Horizontal Position
	output	[pVVAW-1:0]				oPVPD,		// Player Vertical Position
	// Src Pixel Stream I/F
	input	[pDstColorDepth-1:0]	iPS,		// Pixel Data
	input							iVS,		// Pixel Valid
	input							iFS,		// Frame Valid
	input							iLS,		// Line Valid
	input	[pVHAW-1:0]				iBHPS,		// Base Horizontal Position
	input	[pVVAW-1:0]				iBVPS,		// Base Vertical Position
	input	[pVHAW-1:0]				iPHPS,		// Player Horizontal Position
	input	[pVVAW-1:0]				iPVPS,		// Player Vertical Position
	// Control / Status
	input	[pObjectAnimeNum-1:0]							iDrawEnable,	// オブジェクト描画 Enable
	input	[(pObjectAnimeNum * pObjectAnimeTime)-1:0]		iAnimeFrameNum,	// フレーム更新回数
	input	[(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] iAnimeXpos,		// 描画 X 座標
	input	[(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] iAnimeYpos,		// 描画 Y 座標
	// input	[(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] iAnimeXposAdd,	// 描画 X 座標
	// input	[(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] iAnimeYposAdd,	// 描画 Y 座標
	// Memory Mapchip Access
	input 	[23:0]					iBramWd,
	input 	[31:0]					iBramAdrs,
	// common
	input							iRST,
	input							iCLK
);

/**-----------------------------------------------------------------------------
 * module 共通変数
 *-----------------------------------------------------------------------------*/
genvar gen;
integer xloop;

// Logic Elements: 7212 / 19728 (36.56%)
// 	LE: LUTs/Adders: 4454 / 19728 (22.58%)
// 	LE: Registers: 3850 / 13920 (27.66%)

/**-----------------------------------------------------------------------------
 * BRAM
 *-----------------------------------------------------------------------------*/
localparam lpRamAdrsWidth = fBitWidth(pRamDepth);
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam1 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam2 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam3 [0:pRamDepth-1];
 
reg [pSynColorDepth-1:0]	rPSB, qPSB;
reg [lpRamAdrsWidth-1:0] 	rRamRadrs[0:pObjectAnimeNum];
reg [lpRamAdrsWidth-1:0] 	rRamRadrsFix;
reg [pObjectAnimeNum-1:0]	qRamRadrsCke;
reg 						rRamRadrsCkeFix;
reg							qRamRadrsRst;
reg [7:0]					qRamWe;
reg [1:0]					rRamSel;
reg [1:0]					qMapchipSel[0:pObjectAnimeNum];

always @(posedge iCLK)
begin
	if (qRamWe[0])	rObjectRam1[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[1])	rObjectRam2[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[2])	rObjectRam3[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	
	rPSB <= qPSB;
	
	casex (qRamRadrsCke)
		'b000000_0001:	rRamRadrsFix <= rRamRadrs[0];
		'b000000_001x:	rRamRadrsFix <= rRamRadrs[1];
		'b000000_01xx:	rRamRadrsFix <= rRamRadrs[2];
		'b000000_1xxx:	rRamRadrsFix <= rRamRadrs[3];
		'b000001_xxxx:	rRamRadrsFix <= rRamRadrs[4];
		'b00001x_xxxx:	rRamRadrsFix <= rRamRadrs[5];
		'b0001xx_xxxx:	rRamRadrsFix <= rRamRadrs[6];
		'b001xxx_xxxx:	rRamRadrsFix <= rRamRadrs[7];
		'b01xxxx_xxxx:	rRamRadrsFix <= rRamRadrs[8];
		'b1xxxxx_xxxx:	rRamRadrsFix <= rRamRadrs[9];
		default:		rRamRadrsFix <= rRamRadrs[0];
	endcase
	
	casex (qRamRadrsCke)
		'b000000_0001:	rRamSel <= qMapchipSel[0];
		'b000000_001x:	rRamSel <= qMapchipSel[1];
		'b000000_01xx:	rRamSel <= qMapchipSel[2];
		'b000000_1xxx:	rRamSel <= qMapchipSel[3];
		'b000001_xxxx:	rRamSel <= qMapchipSel[4];
		'b00001x_xxxx:	rRamSel <= qMapchipSel[5];
		'b0001xx_xxxx:	rRamSel <= qMapchipSel[6];
		'b001xxx_xxxx:	rRamSel <= qMapchipSel[7];
		'b01xxxx_xxxx:	rRamSel <= qMapchipSel[8];
		'b1xxxxx_xxxx:	rRamSel <= qMapchipSel[9];
		default:		rRamSel <= qMapchipSel[0];
	endcase
	
	rRamRadrsCkeFix <= |{qRamRadrsCke};
end

always @*
begin
	qRamWe[0]	<= iBramAdrs[31:24] == (pCacheBaseAdrs);
	qRamWe[1]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd1);
	qRamWe[2]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd2);
	
	case({rRamRadrsCkeFix,rRamSel})
		'b1_00:		qPSB <= rObjectRam1[rRamRadrsFix];
		'b1_01:		qPSB <= rObjectRam2[rRamRadrsFix];
		'b1_10:		qPSB <= rObjectRam3[rRamRadrsFix];
		default:	qPSB <= 24'd0;
	endcase
end


/**-----------------------------------------------------------------------------
 * draw position
 * posAdd と RamAdrs の加算具合で 2の乗数の拡大縮小であれば簡単に実現可能
 *-----------------------------------------------------------------------------*/
wire [pVHAW-1:0] 	wOdpXpos[0:pObjectAnimeNum];
wire [pVVAW-1:0] 	wOdpYpos[0:pObjectAnimeNum];
wire [pVHAW:0] 		wOdpXposAdd[0:pObjectAnimeNum];
wire [pVVAW:0] 		wOdpYposAdd[0:pObjectAnimeNum];
reg	 [0:0]			qXposMatch[0:pObjectAnimeNum];
reg  [0:0]			qYposMatch[0:pObjectAnimeNum];

generate
for (gen = 0; gen < pObjectAnimeNum; gen = gen + 1)
begin : ObjectDrawPositionX
	PlayerDrawPosition #(
		.pVHAW(pVHAW),	.pVVAW(pVVAW)
	) ObjectDrawPosition (
		.oXpos(wOdpXpos[gen]),			.oYpos(wOdpYpos[gen]),
		.oXposAdd(wOdpXposAdd[gen]),	.oYposAdd(wOdpYposAdd[gen]),
		.oXposBs(),						.oYposBs(),
		.iFS(iFS),	.iLS(iLS),	.iVS(iVS),
		// control status
		.iXpos(iAnimeXpos[(pObjectAnimeXposWidth * (gen+1))-1 : (pObjectAnimeXposWidth * gen)]),
		.iYpos(iAnimeYpos[(pObjectAnimeYposWidth * (gen+1))-1 : (pObjectAnimeYposWidth * gen)]),
		.iXposAdd(6'd32),
		.iYposAdd(6'd32),
		.iInit(1'b0),
		// common
		.iRST(iRST),	.iCLK(iCLK)
	);
	
	always @(posedge iCLK)
	begin
		if (iRST)					rRamRadrs[gen] <= {lpRamAdrsWidth{1'b0}};
		else if (qRamRadrsRst)		rRamRadrs[gen] <= {lpRamAdrsWidth{1'b0}};
		else if (qRamRadrsCke[gen])	rRamRadrs[gen] <= rRamRadrs[gen] + 1'b1;
		else 						rRamRadrs[gen] <= rRamRadrs[gen];
	end
	
	always @*
	begin
		qXposMatch[gen]		<=  (wOdpXpos[gen] <= iBHPS) & (iBHPS < wOdpXposAdd[gen]);
		qYposMatch[gen]		<=  (wOdpYpos[gen] <= iBVPS) & (iBVPS < wOdpYposAdd[gen]);
		qRamRadrsCke[gen]	<= &{iVS,iDrawEnable[gen],qXposMatch[gen],qYposMatch[gen]};
	end
end
endgenerate

always @*
begin
	qRamRadrsRst	<= iVS & iFS;
end

/**-----------------------------------------------------------------------------
 * animation logic
 *-----------------------------------------------------------------------------*/
reg [7:0] 	rFsCnt[0:pObjectAnimeNum];			// フレーム数カウンタ
reg	[0:0]	qFsCntCke;
reg [0:0]	qFsCntMax[0:pObjectAnimeNum];
reg [1:0]	rAnimeFrmaeNum[0:pObjectAnimeNum];
reg [0:0]	qAnimeFrmaeMax[0:pObjectAnimeNum];

generate
for (gen = 0; gen < pObjectAnimeNum; gen = gen + 1)
begin : ObjectAnimationLogicX
	always @(posedge iCLK)
	begin
		if (iRST) 					rFsCnt[gen] <= 8'd0;
		else if (qFsCntMax[gen])	rFsCnt[gen] <= 8'd0;
		else if (qFsCntCke)			rFsCnt[gen] <= rFsCnt[gen] + 1'b1;
		else 						rFsCnt[gen] <= rFsCnt[gen];
		
		if (iRST) 						rAnimeFrmaeNum[gen] <= 2'd0;
		else if (qAnimeFrmaeMax[gen])	rAnimeFrmaeNum[gen] <= 2'd0;
		else if (qFsCntMax[gen])		rAnimeFrmaeNum[gen] <= rAnimeFrmaeNum[gen] + 1'b1;
		else 							rAnimeFrmaeNum[gen] <= rAnimeFrmaeNum[gen];
	end

	always @*
	begin
		qFsCntMax[gen]		<= qFsCntCke & (rFsCnt[gen] == iAnimeFrameNum[(pObjectAnimeTime * (gen+1))-1 : (pObjectAnimeTime * gen)]);
		qAnimeFrmaeMax[gen]	<= qFsCntMax[gen] & (rAnimeFrmaeNum[gen] == 2'd2);
		qMapchipSel[gen]	<= rAnimeFrmaeNum[gen];
	end
end
endgenerate

always @*
begin
	qFsCntCke	<= iFS & iVS;
end


/**-----------------------------------------------------------------------------
 * PipeLine Alpha Blend
 *-----------------------------------------------------------------------------*/
PipeLineBlend #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(pDstColorDepth),
	.pSynColorDepth(pSynColorDepth),
	.pPipeLine(2)
) PipeLineBlend (
	// Dst Pixel Stream I/F
	.oPD(oPD),			.oVD(oVD),		.oFD(oFD),	.oLD(oLD),
	.oBHPD(oBHPD),		.oBVPD(oBVPD),
	.oPHPD(oPHPD),		.oPVPD(oPVPD),
	// Src Pixel Stream I/F
	.iPSA(iPS),			.iPSB(rPSB),
	.iVSA(iVS),			.iFS(iFS),		.iLS(iLS),
	.iBHPS(iBHPS),		.iBVPS(iBVPS),
	.iPHPS(iPHPS),		.iPVPS(iPVPS),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

//-----------------------------------------------------------------------------
// MSB の Bitを検出
//-----------------------------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction

endmodule