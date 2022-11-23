//----------------------------------------------------------
// Create 2022/09/04
// Author koutakimura
// -
// シフトレジスタ経由でデータを出力する汎用モジュール
//----------------------------------------------------------
module SftReg #(
    parameter 	pBitWidth	 	= 1,	// データ幅
	parameter 	pSftRegDepth	= 2,	// シフトレジスタの段数
	parameter	pLutRam			= "no"	// no register, yes LUTRAM
)(
    input   [pBitWidth-1:0] iD,
    output  [pBitWidth-1:0] oQ,
	input 					iRst,
    input                   iClk
);

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
localparam lpSftRegDepth = pSftRegDepth - 1;

reg [pBitWidth-1:0] rD [0:pSftRegDepth-1];       assign oQ = rD[pSftRegDepth-1];
integer i;

generate
	if (pLutRam == "no")
	begin
		always @(posedge iClk)
		begin
			if (iRst)
			begin
				for (i = 0; i < pSftRegDepth; i = i + 1)
				begin
					rD[i] <= {pBitWidth{1'b0}};
				end
			end
			else
			begin
				rD[0] <= iD;

				for (i = 0; i < lpSftRegDepth; i = i + 1)
				begin
					rD[i+1] <= rD[i];
				end
			end
		end
	end
	else
	begin
		always @(posedge iClk)
		begin
			rD[0] <= iD;
			for (i = 0; i < lpSftRegDepth; i = i + 1)
			begin
				rD[i+1] <= rD[i];
			end
		end
	end
endgenerate

endmodule
