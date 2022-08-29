/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * 
 * プレイヤーのドット作成トップモジュール
 * 現在のユーザーの位置からキャラクター描画用のドット保存Rom参照アドレスを生成する
 */
module dotPlayerTop #(
    parameter VMAX = 480,
    parameter CHIP_WIDTH = 32
)(
    input           iClk,   // ディスプレイ描画clk
    input           iRst,   // system rst
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

// 
localparam MAPCHIP_ADDR = CHIP_WIDTH - 1;
localparam UNIT_WARK_1  = 1024 - 1;
localparam UNIT_WARK_2  = 2048 - 1;

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

reg signed [15:0] iAddr;
assign iEnable = (iUXS <= iHPOS && iHPOS < iUXE && iUYS <= iVPOS && iVPOS < iUYE) ? 1'b1 : 1'b0;

reg signed [ 7:0] addr;
reg [ 7:0] q_start_addr;
reg [15:0] next_line;
reg [ 1:0]  old_dir;
wire o_en_animation;

//----------------------------------------------------------
// enable信号生成
//----------------------------------------------------------
enGen #(
    .SYS_CLK(6250000)
) RGB_1MS_GEN (
    .iClk(iClk), .iRst(iRst), .oEnable(o_en_animation)
);


//----------------------------------------------------------
// キャラクターの向きによって画像参照のアドレス更新方法を変更する
// IDOL  前回の状態を維持
// LEFT  画像データは左向きのものを使用しているため、0番地から参照すれば描画される
// RIGHT 反転描画するために右端のアドレスから参照を開始する
//----------------------------------------------------------
always @(posedge iClk)
begin
    if (iRst) begin
        addr <= -1;
        q_start_addr <= MAPCHIP_ADDR;
        old_dir <= RIGHT;
    end else begin
        case (iDirX)
            IDOL: 
            begin
                addr <= addr;
                q_start_addr <= q_start_addr;
                old_dir <= old_dir;
            end

            LEFT:
            begin
                addr <= 1;
                q_start_addr <= 0;
                old_dir <= LEFT;
            end

            RIGHT:
            begin
                if (o_en_animation)
                begin
                    if (q_start_addr == UNIT_WARK_1)
                    begin
                        q_start_addr <= UNIT_WARK_2;
                    end
                    else
                    begin
                        q_start_addr <= UNIT_WARK_1;
                    end
                end
                else
                begin
                    q_start_addr <= q_start_addr;
                end
                addr <= -1;
                old_dir <= RIGHT;
            end

            default:
            begin
                addr <= -1;
                q_start_addr <= MAPCHIP_ADDR;
                old_dir <= RIGHT;
            end
        endcase
    end
end

//----------------------------------------------------------
// キャラクタードットデータ参照アドレスの更新
//----------------------------------------------------------
always @(posedge iClk) begin
    if (iRst == 1'b1) begin
        iAddr      <= MAPCHIP_ADDR;
        next_line  <= 0;
    end else if (VMAX < iVPOS) begin
        iAddr      <= q_start_addr;
        next_line  <= 0;
    end else if (iEnable == 1'b1) begin
        iAddr      <= addr + iAddr;
        next_line  <= next_line + 1'b1;
    end else begin
        iAddr      <= (old_dir == LEFT) ? iAddr : next_line + MAPCHIP_ADDR;
    end
end

dotPlayerRom DOT_PLAYER_ROM (
    .iClk(iClk), .iAddr(iAddr), .iEnable(iEnable), .oPlayerDot(oPlayerDot)
);

endmodule