/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * プレイヤーのドット作成トップモジュール
 * 現在のユーザーの位置からキャラクター描画用のドット保存Rom参照アドレスを生成する
 */
module dotPlayerTop (
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input  [ 9:0]   iUXS,
    input  [ 9:0]   iUXE,
    input  [ 9:0]   iUYS,
    input  [ 9:0]   iUYE,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    input  [ 1:0]   iDirX,
    input  [ 1:0]   iDirY,
    output [31:0]   oPlayerDot
);

//----------------------------------------------------------
// X移動方向ステートマシン
//----------------------------------------------------------
localparam IDOL   = 0;
localparam LEFT   = 1;
localparam RIGHT  = 2;

//----------------------------------------------------------
// ジャンプ動作ステートマシン
//----------------------------------------------------------
localparam JUMP   = 1;  // 上昇
localparam FALL   = 2;  // 落下

reg [15:0] iAddr;
assign iEnable = (iUXS <= iHPOS && iHPOS < iUXE && iUYS <= iVPOS && iVPOS < iUYE) ? 1'b1 : 1'b0;

always @*
begin
    case (iDirX)
    begin
        
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        iAddr <= 0;
    end else if (480 < iVPOS) begin
        iAddr <= 0;
    end else if (iEnable == 1'b1) begin
        iAddr <= iAddr + 1'b1;
    end
end

dotPlayerRom DOT_PLAYER_ROM (
    .iCLK       (iCLK),
    .iAddr      (iAddr),
    .iEnable    (iEnable),
    .oPlayerDot (oPlayerDot)
);

endmodule