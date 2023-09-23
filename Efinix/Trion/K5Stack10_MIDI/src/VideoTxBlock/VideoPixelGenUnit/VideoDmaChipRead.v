/*-----------------------------------------------------------------------------
 * マップチップIDとライン番号からアドレスを算出し、SRAM からマップチップデータを読み込む
 *
 * 23-09-09 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module VideoDmaChipRead #(
	// UFI
	parameter 	pUfiDqBusWidth 		= 16,
	parameter 	pUfiAdrsBusWidth 	= 32,
	parameter 	[3:0] pUfiAdrsMap	= 'h2,
	parameter 	pDmaAdrsWidth 		= 18,
	parameter 	pDmaBurstLength 	= 256,
	// Pixel
	parameter	pColorDepth 		= 16,
	parameter	pMapChipSize		= 32,
	parameter	pMapChipBitWidth	= f_detect_bitwidth(pMapChipSize),
	parameter	pMapChipIdNum		= 10
)(
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] 	oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	input							iMUfiRdy,
	// Info
	output	[pUfiDqBusWidth-1:0]	oInfoMapChipWd,
	output	[pDmaAdrsWidth-1:0]		oInfoMapChipWa,
	output							oInfoMapChipWe,
	input	[pMapChipBitWidth-1:0]	iInfoLine,			// Line 番号
	input	[pMapChipIdNum-1:0]		iInfoMapChipId,		// MapChip ID
	input							iInfoMapChipIdRe,
	// common
	input	iRST,
	input	inRST,
	input	iCLK
);

//-----------------------------------------------------------------------------
// DMA
//-----------------------------------------------------------------------------
reg  						qDmaEnable;
reg  						qDmaCycleEnable;
reg  [pDmaAdrsWidth-1:0] 	qDmaAdrsStart;
reg  [pDmaAdrsWidth-1:0] 	qDmaAdrsEnd;
reg  [pDmaAdrsWidth-1:0] 	qDmaAdrsAdd;
wire [pUfiDqBusWidth-1:0]	wDmaRd;					assign oInfoMapChipWd = wDmaRd;
wire [pDmaAdrsWidth-1:0]	wDmaRa;					assign oInfoMapChipWa = wDmaRa;
wire 						wDmaRvd;				assign oInfoMapChipWe = wDmaRvd;
reg 						qDmaRe;

UfibReadDmaUnit #(
	// variable parameter
	.pUfiDqBusWidth(pUfiDqBusWidth),
	.pUfiAdrsBusWidth(pUfiAdrsBusWidth),
	.pUfiAdrsMap(pUfiAdrsMap),
	.pDmaAdrsWidth(pDmaAdrsWidth),
	.pDmaBurstLength(pDmaBurstLength),
	.pDmaReadDataSyncMode("sync")
) UfibReadDmaUnit (
	// Ufi Bus Master Read
	.iMUfiRd(iMUfiRd),				.iMUfiAdrs(iMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(oMUfiWd),				.oMUfiAdrs(oMUfiAdrs),
	.iMUfiRdy(iMUfiRdy),
	// Control / Status
	.iDmaEnable(qDmaEnable),		.iDmaCycleEnable(qDmaCycleEnable),
	.iDmaAdrsStart(qDmaAdrsStart),	.iDmaAdrsEnd(qDmaAdrsEnd),
	.iDmaAdrsAdd(qDmaAdrsAdd),
	.oDmaDone(),
	// read data
	.oDmaRd(wDmaRd),		.oDmaRa(wDmaRa),
	.oDmaRvd(wDmaRvd),		.iDmaRe(qDmaRe),
	// CLK Reset
	.iRST(iRST),			.inRST(inRST),
	.iCLK(iCLK),			.iACLK(iCLK)
);

always @*
begin
	qDmaEnable		<= 1'b1;
	qDmaCycleEnable	<= 1'b0;
	qDmaRe			<= iInfoMapChipIdRe;
	qDmaAdrsAdd 	<= {{(pDmaAdrsWidth-1){1'b0}},1'b1};
end

//-----------------------------------------------------------------------------
// Adrs Generate
//-----------------------------------------------------------------------------
localparam 								lpMapChipSizeBitWidth	= f_detect_bitwidth(pMapChipSize * pMapChipSize);
localparam [lpMapChipSizeBitWidth-1:0] 	lpMapChipIdAdrsSft 		= 0;
localparam [pMapChipBitWidth-1:0] 		lpMapChipIdAdrsSum 		= pMapChipSize - 1;
localparam [pMapChipBitWidth-1:0] 		lpMapChipLineAdrsSft 	= 0;

// reg [pDmaAdrsWidth-1:0] rDmaAdrsStart	= {pDmaAdrsWidth{1'b0}};
// reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd		= {pDmaAdrsWidth{1'b0}};

// always @(posedge iCLK)
// begin
// 	rDmaAdrsStart	<= {iInfoMapChipId, lpMapChipIdAdrsSft} + {iInfoLine, lpMapChipLineAdrsSft};
// 	rDmaAdrsEnd		<= {iInfoMapChipId, lpMapChipIdAdrsSft} + {iInfoLine, lpMapChipLineAdrsSft} + lpMapChipIdAdrsSum;
// end

always @*
begin
	qDmaAdrsStart	<= {iInfoMapChipId, lpMapChipIdAdrsSft} + {iInfoLine, lpMapChipLineAdrsSft};
	qDmaAdrsEnd		<= {iInfoMapChipId, lpMapChipIdAdrsSft} + {iInfoLine, lpMapChipLineAdrsSft} + lpMapChipIdAdrsSum;
end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction

endmodule

//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------