//----------------------------------------------------------
// Create 2022/09/21
// Author koutakimura
// -
// 読み出し レイテンシ0 の FIFO (LUTRAM)
// 
//----------------------------------------------------------
module LutRam #(
    parameter 					pBuffDepth = 256,    // FIFO BRAMのサイズ指定
    parameter 					pBitWidth  = 32,     // bitサイズ
    parameter 					pAddrWidth = 16      // addr size
)(
    input   [pBitWidth-1:0]    iWD,    // write data
    input   [pAddrWidth-1:0]   iWA,    // write addr
    input                      iWE,    // write enable
    output  [pBitWidth-1:0]    oRD,    // read data
    input   [pAddrWidth-1:0]   iRA,    // read address
    input                      iCLK
);

reg [pBitWidth-1:0] fifo [0:pBuffDepth-1];		assign oRD = fifo[iRA];

always @(posedge iCLK)
begin
    if (iWE) 	fifo[iWA] <= iWD;
end

endmodule
