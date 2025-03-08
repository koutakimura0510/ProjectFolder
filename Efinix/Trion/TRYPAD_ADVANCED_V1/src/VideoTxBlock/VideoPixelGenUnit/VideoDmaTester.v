/*-----------------------------------------------------------------------------
 * マップチップIDとライン番号からアドレスを算出し、SRAM からマップチップデータを読み込む
 *
 * 23-09-09 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module VideoDmaTester #(
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
	// Info
	input	[pUfiDqBusWidth-1:0]	iMapChipWd,
	input	[pDmaAdrsWidth-1:0]		iMapChipWa,
	input							iMapChipWe,
	// input	[pMapChipBitWidth-1:0]	iInfoLine,			// Line 番号
	// input	[pMapChipIdNum-1:0]		iInfoMapChipId,		// MapChip ID
	// input							iInfoMapChipIdRe,
	// common
	input	iRST,
	input	inRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
(* syn_ramstyle = "block_ram" *) reg [15:0] rMapIdLine [0:255];
reg [15:0] 	rMapChipId [0:7];
reg [15:0] 	rMapId [0:15];

reg 		qMapIdWd;
reg 		qMapIdWa;
reg 		qMapIdWe;
reg [15:0] 	rMapIdRd;
reg [ 7:0] 	rMapIdRa;

always @(posedge iCLK)
begin
	if (qMapIdWe) rMapIdLine <= qMapIdWd[qMapIdWa];
	rMapIdRd <= rMapIdLine[rMapIdRa];

	rMapChipId[0] <= 16'd0;
	rMapChipId[1] <= 16'd1;
	rMapChipId[2] <= 16'd2;
	rMapChipId[3] <= 16'd3;
	rMapChipId[4] <= 16'd4;
	rMapChipId[5] <= 16'd5;
	rMapChipId[6] <= 16'd6;
	rMapChipId[7] <= 16'd7;
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