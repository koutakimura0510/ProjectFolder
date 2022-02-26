//----------------------------------------------------------
// Create 2021/02/05
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// DualPortFIFOの生成モジュール
// このFIFOを使用する上位モジュール内でインターフェースを制御することとする
//----------------------------------------------------------
module userFifoDual #(
    parameter pBuffDepth = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth  = 32,     // bitサイズ
    parameter pAddrWidth = 16      // addr size
)(
    input                      iCLKA,   // write side
    input                      iCLKB,   // read side
    input   [pBitWidth-1:0]    iWD,     // write data
    input   [pAddrWidth-1:0]   iWA,     // write addr
    input                      iWE,     // write enable
    output  [pBitWidth-1:0]    oRD,     // read data
    input   [pAddrWidth-1:0]   iRA      // read address
);

localparam [pAddrWidth-1:0] pDepth = pBuffDepth - 1;

(* ram_style = "block" *) reg [pBitWidth-1:0] fifo [0:pDepth];
reg [pBitWidth-1:0] rd;     assign oRD = rd;

// write side
always @(posedge iCLKA)
begin
    if (iWE) fifo[iWA] <= iWD;
end

// read side
always @(posedge iCLKB)
begin
    rd <= fifo[iRA];
end

endmodule
