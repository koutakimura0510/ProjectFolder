/*
 * Create 2021/1/09
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * フィールドマップのドット画像に対応したIDデータベースを管理する
 * 使用するBitmapデータに対応した番号を取得する
 */
module dotFieldRom
(
    input           iCLK,           // system clk
    input  [31:0]   iAddr,          // address
    output [ 7:0]   oFieldNumber,   // フィールド番号
    output [15:0]   oMapWidth
    // output [ 7:0]   o
);


//----------------------------------------------------------
// 定数値
//----------------------------------------------------------
localparam FILENAME  = "field_map1_1.dat";
localparam LENGTH    = (1024);
localparam BUFF_SIZE = (LENGTH - 1);


//----------------------------------------------------------
// 描画ドットデータの初期化
//----------------------------------------------------------
reg [7:0] dout = 0;             assign oFieldNumber = dout;
reg [15:0] o_map_width = 0;     assign oMapWidth    = o_map_width;

(* ram_style = "BLOCK" *) reg [7:0] memory [0:BUFF_SIZE];
// wire [7:0] next;

initial begin
    $readmemh(FILENAME, memory);
end

// assign oFieldNumber = memory[iAddr];
// assign next = memory[iAddr];

always @(posedge iCLK) begin
    dout <= memory[iAddr];
end

// マップサイズを出力
always @(posedge iCLK) begin
    o_map_width <= {memory[1], memory[0]};
end

endmodule