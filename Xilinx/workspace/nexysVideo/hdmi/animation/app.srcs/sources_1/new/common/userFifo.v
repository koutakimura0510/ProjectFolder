//----------------------------------------------------------
// Create 2021/02/05
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFOの生成モジュール
// このFIFOを使用する上位モジュール内でインターフェースを制御することとする
//----------------------------------------------------------
module userFifo #(
    parameter BUFF_SIZE   = 256,    // FIFO BRAMのサイズ指定
    parameter BIT_WIDTH   = 32,     // bitサイズ
    parameter ADDR_LENGTH = 16      // addr size
)(
    input                       iCLK,
    input   [BIT_WIDTH-1:0]     iWD,    // write data
    input   [ADDR_LENGTH-1:0]   iWA,    // write addr
    input                       iWE,    // write enable
    output  [BIT_WIDTH-1:0]     oRD,    // read data
    input   [ADDR_LENGTH-1:0]   iRA     // read address
);

(* ram_style = "block" *) reg [BIT_WIDTH-1:0] fifo [0:2**BUFF_SIZE-1];
reg [BIT_WIDTH-1:0] rd;     assign oRD = rd;

// 書き込みポート
always @(posedge iCLK)
begin
    if (iWE) fifo[iWA] <= iWD;
end

// 読み込みポート
always @(posedge iCLK)
begin
    rd <= fifo[iRA];
end

endmodule
