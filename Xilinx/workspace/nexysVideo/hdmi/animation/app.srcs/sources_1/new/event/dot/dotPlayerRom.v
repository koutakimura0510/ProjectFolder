/*
 * Create 2021/1/07
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * キャラクターのドット画像データRom
 */
module dotPlayerRom
(
    input           iCLK,       // system clk
    input  [15:0]   iAddr,      // address
    input           iEnable,    // 1. Dot Data Output 0. 0x00 output
    output [31:0]   oPlayerDot  // dot data
);


//----------------------------------------------------------
// 定数値
//----------------------------------------------------------
localparam FILENAME  = "remi1.dat";
localparam LENGTH    = (6144);
localparam BUFF_SIZE = (LENGTH - 1);


//----------------------------------------------------------
// 描画ドットデータの初期化
//----------------------------------------------------------
reg [31:0] dout;   assign oPlayerDot = (iEnable == 1'b1) ? dout : 32'h00000000;
(* ram_style = "BLOCK" *) reg [31:0] memory [0:BUFF_SIZE];

initial begin
    $readmemh(FILENAME, memory);
end

always @(posedge iCLK) begin
    dout <= memory[iAddr];
end

endmodule