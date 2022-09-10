//----------------------------------------------------------
// Create 2021/02/05
// Author koutakimura
// -
// FIFOの生成モジュール
// このFIFOを使用する上位モジュール内でインターフェースを制御することとする
// 
//----------------------------------------------------------
module userFifo #(
    parameter pBuffDepth = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth  = 32,     // bitサイズ
    parameter pAddrWidth = 16      // addr size
)(
    input                      iClk,
    input   [pBitWidth-1:0]    iWD,    // write data
    input   [pAddrWidth-1:0]   iWA,    // write addr
    input                      iWE,    // write enable
    output  [pBitWidth-1:0]    oRD,    // read data
    input   [pAddrWidth-1:0]   iRA     // read address
);

localparam pDepth = pBuffDepth - 1;

(* ram_style = "block" *) reg [pBitWidth-1:0] fifo [0:pDepth];
reg [pBitWidth-1:0] rd;     assign oRD = rd;
// assign oRD = fifo[iRA];

// rwポート
always @(posedge iClk)
begin
    if (iWE) fifo[iWA] <= iWD;
    rd <= fifo[iRA];
end

endmodule
