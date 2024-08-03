/*------------------------------------------------------------------------------
 * Create  2024/07/30
 * Author  kouta kimura
 * 
 * Player Draw module
 * 
 *-----------------------------------------------------------------------------*/
module PlayerDraw #(
	parameter	pVHAW  			= 11,
	parameter	pVVAW  			= 11,
	parameter	pDstColorDepth	= 16,
	parameter 	pSynColorDepth	= 24,
	parameter	pRamDepth		= 1024,					// pDstColorDepth と合わせて 32767Kbit に収まるようにする
	parameter	pInitFileName	= "pPlayerTexture.txt"	// 本来は ROM データ書き込みだがデバッグ用に...
)(
	// Dst Pixel Stream I/F
	output	[pDstColorDepth-1:0]	oPD,		// Pixel Data
	output 							oVD,		// Pixel Valid
	output 							oFD,		// Frame Valid
	output	[pVHAW-1:0]				oBHPD,
	output	[pVVAW-1:0]				oBVPD,
	output	[pVHAW-1:0]				oPHPD,		// Player Horizontal Position
	output	[pVVAW-1:0]				oPVPD,		// Player Vertical Position
	// Src Pixel Stream I/F
	input	[pDstColorDepth-1:0]	iPS,		// Pixel Data
	input							iVS,		// Pixel Valid
	input							iFS,		// Frame Valid
	input	[pVHAW-1:0]				iBHPS,		// Base Horizontal Position
	input	[pVVAW-1:0]				iBVPS,		// Base Vertical Position
	input	[pVHAW-1:0]				iPHPS,		// Player Horizontal Position
	input	[pVVAW-1:0]				iPVPS,		// Player Vertical Position
	// Memory Mapchip Access
	input 	[23:0]					iBramWd,
	input 	[31:0]					iBramAdrs,
	// Control / Status
	input	[1:0]					iPlayerdir,	// "3"=Left,"2"=Right,"1"=Up,"0"=Down
	// common
	input							iRST,
	input							iCLK
);


//-----------------------------------------------------------------------------
// 設定データに基づき、暗転処理を行う。
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam [0:pRamDepth-1];	// 分散 RAM は使用しないので MAX 宣言

initial begin
	$readmemh(pInitFileName, rPlayerRam);
end

/**-----------------------------------------------------------------------------
 * RAW
 *-----------------------------------------------------------------------------*/
localparam lpRamAdrsWidth = fBitWidth(pRamDepth);
 
reg [pSynColorDepth-1:0]	rPSB;
reg [lpRamAdrsWidth-1:0] 	rRamRadrs;
reg 						qRamRadrsCke;
reg							qRamWe;

always @(posedge iCLK)
begin
	if (qRamWe)	rPlayerRam[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	rPSB <= rPlayerRam[rRamRadrs];
	
	if (iRST)				rRamRadrs <= {lpRamAdrsWidth{1'b0}};
	else if (qRamRadrsCke)	rRamRadrs <= rRamRadrs + 1'b1;
	else 					rRamRadrs <= rRamRadrs;
end

always @*
begin
	qRamRadrsCke	<= iVS;
	qRamWe			<= iBramAdrs[31:23] == 8'h01;
end

/**-----------------------------------------------------------------------------
 * PipeLine Alpha Blend
 *-----------------------------------------------------------------------------*/
PipeLineBlend #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(pDstColorDepth),
	.pSynColorDepth(pSynColorDepth),
	.pPipeLine(1)
) PipeLineBlend (
	// Dst Pixel Stream I/F
	.oPD(oPD),			.oVD(oVD),		.oFD(oFD),
	.oBHPD(oBHPD),		.oBVPD(oBVPD),
	.oPHPD(oPHPD),		.oPVPD(oPVPD),
	// Src Pixel Stream I/F
	.iPSA(iPS),			.iPSB(rPSB),
	.iVSA(iVS),			.iFS(iFS),
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