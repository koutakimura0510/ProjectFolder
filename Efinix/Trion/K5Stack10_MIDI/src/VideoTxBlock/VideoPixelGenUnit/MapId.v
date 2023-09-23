/*-----------------------------------------------------------------------------
 * Map ID 
 *
 * 23-09-09 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module MapId #(
	// Display Size
	parameter	pVHAW = 11,
	// UFI
	parameter 	pUfiDqBusWidth 		= 16,
	parameter 	pUfiAdrsBusWidth 	= 32,
	parameter 	[3:0] pUfiAdrsMap	= 'h2,
	parameter 	pDmaAdrsWidth 		= 18,
	parameter 	pDmaBurstLength 	= 256,
	// Pixel
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
	input	[7:0]							iMapSizeX,
	input	[pVHAW-pMapChipBitWidth-1:0]	iHposBs,
	output	[pMapChipIdNum-1:0]				oMapChipId,
	// common
	input	iRST,
	input	inRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// DMA
//-----------------------------------------------------------------------------
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
	.iDmaEnable(),					.iDmaCycleEnable(1'b0),
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
	qDmaRe		<= 1'b1;		// 常に読み出し
	qDmaAdrsAdd <= {{(pDmaAdrsWidth-1){1'b0}},1'b1};
end


//-----------------------------------------------------------------------------
// 2Line 分の Map Id を格納
//-----------------------------------------------------------------------------
(* syn_ramstyle = "block_ram" *) reg [15:0] rMapIdLine1 [0:255];
(* syn_ramstyle = "block_ram" *) reg [15:0] rMapIdLine2 [0:255];

reg 		qMapIdWd;
reg 		qMapIdWa;
reg 		qMapIdWe;
reg [15:0] 	rMapIdRd;
reg [ 7:0] 	rMapIdRa;

always @(posedge iCLK)
begin
	if (qMapIdWe) rMapIdLine1 <= qMapIdWd[qMapIdWa];
	rMapIdRd <= rMapIdLine1[rMapIdRa];
end

always @*
begin
	qMapIdWd <= wDmaRd;
	qMapIdWa <= wDmaRa;
	qMapIdWe <= wDmaRvd
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