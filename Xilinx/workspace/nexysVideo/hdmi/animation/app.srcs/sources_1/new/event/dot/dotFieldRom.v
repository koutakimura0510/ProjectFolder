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
    input  [ 9:0]   iUXS,
    input  [ 9:0]   iUYS,
    input  [15:0]   iFXS,
    input  [15:0]   iFYS,
    output [ 7:0]   oFieldNumber,   // フィールド番号
    output [15:0]   oMapWidth,
    output [ 3:0]   oMapDirect      // 当たり判定Bit
);

`include "../../include/parameter.vh"

//----------------------------------------------------------
// 定数値
//----------------------------------------------------------
localparam FILENAME  = "field_map1_1.dat";
localparam LENGTH    = (1024);
localparam BUFF_SIZE = (LENGTH - 1);


//----------------------------------------------------------
// 描画ドットデータの初期化
//----------------------------------------------------------
reg [ 7:0] dout = 0;            assign oFieldNumber = dout;
reg [15:0] o_map_width = 0;     assign oMapWidth    = o_map_width;
(* ram_style = "BLOCK" *) reg [7:0] memory [0:BUFF_SIZE];


//----------------------------------------------------------
// 現在位置から上下左右のマップIDを取得するための計算を行う
// 次にRAMを参照し移動可能な0以外のIDだったら0,移動可能であれば1を立てる
//----------------------------------------------------------

// 画面サイズ
wire [20:0] x_map_size = (o_map_width - 1'b1) << 5;
// wire [20:0] y_map_size = (o_map_width - 1'b1) << 5;

// 移動幅の合計座標
wire [16:0] xpos = iUXS + iFXS;
wire [16:0] ypos = iUYS + iFYS;

// 上移動時左右端判定
wire [24:0] up_lr       = (((ypos - 1'b1) >> 5) * o_map_width) + 2;
wire [31:0] up_pos_l    = (ypos == 0) ? 0 : (xpos >> 5) + up_lr;
wire [31:0] up_pos_r    = (ypos == 0) ? 0 : ((xpos + USER_X_DIRECT) >> 5) + up_lr;

// 下移動時左右端判定
wire [24:0] down_lr     = (((ypos + MAPCHIP_USER_HEIGHT) >> 5) * o_map_width) + 2;
wire [31:0] down_pos_l  = (ypos >= USER_HEIGHT_END) ? 0 : (xpos >> 5) + down_lr;
wire [31:0] down_pos_r  = (ypos >= USER_HEIGHT_END) ? 0 : ((xpos + USER_X_DIRECT) >> 5) + down_lr;

// 左右移動時上端判定
wire [24:0] rl_up        = ((ypos >> 5) * o_map_width) + 2; 
wire [31:0] right_pos_up = (xpos >= x_map_size) ? 0 : ((xpos + MAPCHIP_USER_WIDTH) >> 5) + rl_up;
wire [31:0] left_pos_up  = (xpos == 0) ? 0 : ((xpos - 1'b1) >> 5) + rl_up;

// 左右移動時下端判定
wire [24:0] rl_down        = (((ypos + USER_Y_DIRECT) >> 5) * o_map_width) + 2; 
wire [31:0] right_pos_down = (xpos >= x_map_size) ? 0 : ((xpos + MAPCHIP_USER_WIDTH) >> 5) + rl_down;
wire [31:0] left_pos_down  = (xpos == 0) ? 0 : ((xpos - 1'b1) >> 5) + rl_down;


reg dir_ul;
reg dir_ur;
reg dir_dl;
reg dir_dr;
reg dir_ru;
reg dir_rd;
reg dir_lu;
reg dir_ld;
assign oMapDirect = {(dir_ul & dir_ur), (dir_dl & dir_dr), (dir_ru & dir_rd), (dir_lu & dir_ld)};


//----------------------------------------------------------
// フィールドマップ初期化
//----------------------------------------------------------
initial begin
    $readmemh(FILENAME, memory);
end


// マップ情報を出力
always @(posedge iCLK) begin
    dout <= memory[iAddr];
    o_map_width <= {memory[1], memory[0]};
    dir_ul <= (0 != up_pos_l       && 0 == memory[up_pos_l])       ? 1'b1 : 1'b0;
    dir_dl <= (0 != down_pos_l     && 0 == memory[down_pos_l])     ? 1'b1 : 1'b0;
    dir_ur <= (0 != up_pos_r       && 0 == memory[up_pos_r])       ? 1'b1 : 1'b0;
    dir_dr <= (0 != down_pos_r     && 0 == memory[down_pos_r])     ? 1'b1 : 1'b0;
    dir_ru <= (0 != right_pos_up   && 0 == memory[right_pos_up])   ? 1'b1 : 1'b0;
    dir_lu <= (0 != left_pos_up    && 0 == memory[left_pos_up])    ? 1'b1 : 1'b0;
    dir_rd <= (0 != right_pos_down && 0 == memory[right_pos_down]) ? 1'b1 : 1'b0;
    dir_ld <= (0 != left_pos_down  && 0 == memory[left_pos_down])  ? 1'b1 : 1'b0;
end

endmodule