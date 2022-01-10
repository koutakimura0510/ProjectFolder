/*
 * Create 2021/1/9
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * フィールドのドット作成トップモジュール
 * 現在のユーザーの位置からキャラクター描画用のドット保存Rom参照アドレスを生成する
 */
module dotFieldTop (
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input           iVDE,
    input  [ 9:0]   iUXS,
    input  [ 9:0]   iUYS,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    output [31:0]   oFieldDot,
    output [ 7:0]   oFieldNumber
);


//----------------------------------------------------------
// 描画ドット参照
// マップチップの大きさが1マス32x32
//----------------------------------------------------------
localparam MAPCHIP_MAX_WIDTH = 6'd32;       // 1チップ最大横幅
localparam MAPCHIP_MAX_SIZE  = 11'd1024;    // 1チップの容量 32 x 32
localparam MAPCHIP_MASK      = (MAPCHIP_MAX_WIDTH-1);


//----------------------------------------------------------
// フィールドID参照
//----------------------------------------------------------
(* use_dsp48 ="value" *) wire [31:0] field_id_number;    // mapchip ID保存
wire [ 7:0] o_field_number;     // mapchip ID出力
wire [18:0] field_addr;         // mapchip addr
wire [31:0] mapchip_addr;
wire [ 4:0] waddr, haddr;
wire [15:0] oMapWidth;

assign field_addr      = (o_field_number == 0) ? 0 : o_field_number * MAPCHIP_MAX_SIZE;
assign field_id_number = (iHPOS >> 5) + ((iVPOS >> 5) * oMapWidth) + 16'd2;
assign waddr           = iHPOS[4:0];    // 横ドットアドレス
assign haddr           = iVPOS[4:0];    // 縦ドットアドレス
assign mapchip_addr    = (haddr * MAPCHIP_MAX_WIDTH) + waddr + field_addr;
assign oFieldNumber    = o_field_number;

// フィールド番号取得
dotFieldRom DOT_FIELD_ROM (
    .iCLK           (iCLK),
    .iAddr          (field_id_number),
    .oFieldNumber   (o_field_number),
    .oMapWidth      (oMapWidth)
);

// Bitmapデータ取得
dotFieldTextureRom DOT_FIELD_TEXTURE_ROM (
    .iCLK           (iCLK),
    .iAddr          (mapchip_addr),
    .oFieldDot      (oFieldDot)
);

endmodule