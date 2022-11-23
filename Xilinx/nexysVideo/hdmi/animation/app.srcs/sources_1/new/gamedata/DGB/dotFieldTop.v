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
    input  [15:0]   iFXS,
    input  [15:0]   iFYS,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    output [31:0]   oFieldDot,
    output [15:0]   oMapWidth,
    output [ 3:0]   oMapDirect
);

`include "../../include/parameter.vh"

//----------------------------------------------------------
// フィールドID参照
//----------------------------------------------------------
wire [31:0] field_id_number;    // mapchip ID保存
wire [ 7:0] o_field_number;     // mapchip ID出力
wire [15:0] o_map_width;
(* use_dsp48 = "yes" *) wire [19:0] field_addr; // mapchip addr
wire [31:0] mapchip_addr;
wire [ 4:0] waddr, haddr;
// wire [11:0] fxpos = iFXS >> 5;
// wire [11:0] fypos = iFYS >> 5;

wire   [10:0] vp = (iVPOS + iFYS) >> 5;
(* use_dsp48 = "yes" *) wire [26:0] vp_width = vp * o_map_width;

assign oMapWidth       = o_map_width;
assign field_addr      = (o_field_number == 0) ? 0 : o_field_number * MAPCHIP_MAX_SIZE;
assign field_id_number = ((iHPOS + iFXS) >> 5) + vp_width + 16'd2;
assign waddr           = getAddr(iHPOS[4:0], iFXS[4:0]);
assign haddr           = getAddr(iVPOS[4:0], iFYS[4:0]);
assign mapchip_addr    = (haddr * MAPCHIP_MAX_WIDTH) + waddr + field_addr;
assign oFieldNumber    = o_field_number;


//----------------------------------------------------------
// 現在位置に対応したドットアドレスの取得
// フィールドアニメーション座標に応じてマップチップデータ生成用のアドレス取得方法を変更する
//----------------------------------------------------------
function [4:0] getAddr (
    input [4:0] hvpos,      // hsync or vsync
    input [4:0] fpos        // field pos
);
begin
    if (fpos == 0) begin
        getAddr = hvpos[4:0];
    end else begin
        getAddr = hvpos + fpos;   
    end
end
endfunction


//----------------------------------------------------------
// フィールド番号とキャラクターの座標に対応した当たり判定のデータを取得
//----------------------------------------------------------
dotFieldRom DOT_FIELD_ROM (
    .iCLK           (iCLK),
    .iAddr          (field_id_number),
    .iUXS           (iUXS),
    .iUYS           (iUYS),
    .iFXS           (iFXS),
    .iFYS           (iFYS),
    .oFieldNumber   (o_field_number),
    .oMapWidth      (o_map_width),
    .oMapDirect     (oMapDirect)
);


//----------------------------------------------------------
// フィールド番号に対応したBitmapデータを取得
//----------------------------------------------------------
dotFieldTextureRom DOT_FIELD_TEXTURE_ROM (
    .iCLK           (iCLK),
    .iAddr          (mapchip_addr),
    .oFieldDot      (oFieldDot)
);

endmodule