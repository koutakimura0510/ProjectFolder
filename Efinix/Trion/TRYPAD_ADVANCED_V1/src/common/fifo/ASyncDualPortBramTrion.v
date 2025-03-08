/*-----------------------------------------------------------------------------
 * Create  2023/05/05
 * Author  kouta kimura
 * -
 * ASync Dual Port BlockRam Trion version
 * 
 *-----------------------------------------------------------------------------*/
module ASyncDualPortBramTrion #(
    parameter 	pBuffDepth 		= 256,    // FIFO BRAMのサイズ指定
    parameter 	pBitWidth  		= 32,     // bitサイズ
    parameter 	pAddrWidth 		= 16,     // addr size
	parameter	pFifoBlockRam	= "yes"
)(
    input   [pBitWidth-1:0]    iWd,    // write data
    input   [pAddrWidth-1:0]   iWa,    // write addr
    input                      iWe,    // write enable
    output  [pBitWidth-1:0]    oRd,    // read data
    input   [pAddrWidth-1:0]   iRa,     // read address
    input                      iWCLK,
    input                      iRCLK
);

(* ram_style = "block" *) reg [pBitWidth-1:0] bram [0:pBuffDepth-1];
reg [pBitWidth-1:0] rRd;		assign oRd = rRd;

always @(posedge iWCLK)
begin
	if (iWe)
	begin
		bram[iWa] <= iWd;
	end
end

always @(posedge iRCLK)
begin
	rRd <= bram[iRa];
end


// generate
// 	if (pFifoBlockRam == "yes")
// 	begin
// 		reg [pBitWidth-1:0] rd;     assign oRD = rd;
// 		// assign oRD = fifo[iRA];

// 		// rwポート
// 		always @(posedge iCLK)
// 		begin
// 			if (iWE) fifo[iWA] <= iWD;
// 			rd <= fifo[iRA];
// 		end
// 	end
// 	else
// 	begin
// 		assign oRD = fifo[iRA];

// 		// rwポート
// 		always @(posedge iCLK)
// 		begin
// 			if (iWE) fifo[iWA] <= iWD;
// 		end
// 	end
// endgenerate

endmodule
