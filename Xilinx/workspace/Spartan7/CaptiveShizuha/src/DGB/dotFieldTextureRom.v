/*
 * Create 2021/1/09
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * フィールドマップのドット画像データRom
 * 使用するBitmapデータに対応した番号を取得する
 */
module dotFieldTextureRom
(
    input           iCLK,        // system clk
    input  [31:0]   iAddr,       // address
    output [31:0]   oFieldDot    // フィールド番号
);


//----------------------------------------------------------
// 定数値
//----------------------------------------------------------
localparam FILENAME  = "field_dot.dat";
localparam LENGTH    = (4096);
localparam BUFF_SIZE = (LENGTH - 1);


//----------------------------------------------------------
// 描画ドットデータの初期化
//----------------------------------------------------------
reg [31:0] dout;   assign oFieldDot = dout;
(* ram_style = "BLOCK" *) reg [31:0] memory [0:BUFF_SIZE];

// assign oFieldDot = memory[iAddr];
// clkを入れないとBRAMが使われずLUTが使用される

initial begin
    $readmemh(FILENAME, memory);
end

// 次の立上りエッジに備えて、立ち下がり時にデータをセットしておく
always @(negedge iCLK) begin
    dout <= memory[iAddr];
end

endmodule