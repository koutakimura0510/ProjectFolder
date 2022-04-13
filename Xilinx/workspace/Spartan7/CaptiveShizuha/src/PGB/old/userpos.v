/*
 * Create 2022/3/26
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * ユーザーの描画座標データ生成
 */

module userpos
(
    input           iCLK,       // system clk
    input           iRST,       // system rst
    input  [ 5:0]   iBtn,
    input           iEn1Ms,
    input  [ 9:0]   iStartX,    // 描画開始開始x座標
    input  [ 9:0]   iStartY,    // 描画開始開始y座標
    output [ 9:0]   oUXS,       // ユーザーの左上端のx座標
    output [ 9:0]   oUYS,       // ユーザーの左上端のy座標
    output [ 9:0]   oUXE,       // ユーザーの右上端のx座標
    output [ 9:0]   oUYE,       // ユーザーの右下端のy座標
    output [15:0]   oFXS,       // field user xpos
    output [15:0]   oFYS,       // field user ypos
    output [ 1:0]   oDirX,      // 現在のキャラクターの横方向の向き
    output [ 1:0]   oDirY,      // 現在のキャラクターの縦方向の向き
    input  [15:0]   iMapWidth,
    input  [ 3:0]   iMapDirect  // bit列 上[3] 下[2] 左[1] 右[0]
);

`include "../include/parameter.vh"

//----------------------------------------------------------
// X移動方向ステートマシン
//----------------------------------------------------------
localparam IDOL   = 0;
localparam LEFT   = 1;
localparam RIGHT  = 2;
localparam DOUBLE = 3;

//----------------------------------------------------------
// ジャンプ動作ステートマシン
//----------------------------------------------------------
localparam JUMP   = 1;  // 上昇
localparam FALL   = 2;  // 落下

//----------------------------------------------------------
// x軸の移動速度基礎値
//----------------------------------------------------------
localparam KEY_START_TIME = 14;
localparam KEY_END_TIME   = 1;
localparam KEY_COMP_TIME  = 3;

//----------------------------------------------------------
// ジャンプ基礎値
//----------------------------------------------------------
localparam JUMP_HEIGHT = 50;
localparam JUMP_SPEED = 1;

// ユーザー座標データ出力
reg [ 9:0] xpos;    assign oUXS = xpos;
reg [ 9:0] ypos;    assign oUYS = ypos; 
reg [15:0] fxpos;   assign oFXS = fxpos;
reg [15:0] fypos;   assign oFYS = fypos;
assign oUXE = xpos + MAPCHIP_USER_WIDTH;
assign oUYE = ypos + MAPCHIP_USER_HEIGHT;

// キャラクターの向き
reg [1:0] now_xdir, next_xdir;  assign oDirX = now_xdir;
reg [1:0] now_ydir, next_ydir;  assign oDirY = now_ydir;

// 横移動速度
reg [3:0] x_speed;
reg [3:0] x_comp;

// ジャンプステータス
reg  [ 1:0] jump_count;     // ジャンプの回数
reg  [ 9:0] jump_height;    // ジャンプ中の高さ
reg  [ 3:0] jump_speed;     // ジャンプの速度
reg  jump_key_toggle;       // ジャンプ中に再度ジャンプボタンを押した際の判定処理
wire [ 3:0] jump_comp;      // 速度値
wire [ 1:0] jump_max_count; // 最大ジャンプ回数
wire [11:0] wire_fxpos = fxpos >> 5; 
wire [11:0] wire_fypos = fypos >> 5; 


//----------------------------------------------------------
// 左右キーの座標更新ステートマシン
// 右キーを押している間に左キーを押した場合、キャラクターは左に移動する
// 左キーを押している間に右キーを押した場合、キャラクターは右に移動する
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        now_xdir  <= IDOL;
        next_xdir <= IDOL;
    end else begin
        case ({iBtn[SW_RIGHT], iBtn[SW_LEFT]})
            0: begin
                now_xdir  <= IDOL;
                next_xdir <= IDOL;
            end

            1: begin 
                now_xdir  <= LEFT;
                next_xdir <= LEFT;
            end

            2: begin 
                now_xdir  <= RIGHT;
                next_xdir <= RIGHT;
            end

            3: begin
                now_xdir <= (next_xdir == RIGHT) ? LEFT : RIGHT;
            end

            default: begin
                now_xdir  <= IDOL;
                next_xdir <= IDOL;
            end
        endcase
    end
end


//----------------------------------------------------------
// 左右キー長押し時の移動速度更新
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        x_speed <= KEY_START_TIME;
    end else if ((iBtn[SW_RIGHT] | iBtn[SW_LEFT]) == 1'b1) begin
        if (iEn1Ms == 1'b1) begin
            if (x_speed == KEY_END_TIME) begin
                x_speed <= x_comp;
            end else begin
                x_speed <= x_speed - 1'b1;
            end
        end
    end else begin
        x_speed <= KEY_START_TIME;
    end
end


//----------------------------------------------------------
// 比較時間の設定
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        x_comp <= KEY_START_TIME;
    end else if ((iBtn[SW_RIGHT] | iBtn[SW_LEFT]) == 1'b1) begin
        if (x_speed == KEY_END_TIME && x_comp != KEY_COMP_TIME && iEn1Ms == 1'b1) begin
            x_comp <= x_comp - 1'b1;
        end else begin
            x_comp <= x_comp;
        end
    end else begin
        x_comp <= KEY_START_TIME;
    end
end


//----------------------------------------------------------
// ユーザーx座標の生成
// 現在押している方向を保存しておき、左右キーが同時押された場合反対に進むようにする
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        xpos  <= iStartX;
        fxpos <= 0;
    end else if (x_speed == KEY_END_TIME && iEn1Ms == 1'b1) begin
        case (now_xdir)
            RIGHT: begin
                if (iMapDirect[1] == 1) begin
                    if (iMapWidth < (H_CHIP_NUMBER + wire_fxpos) || xpos < H_DISP_HALF)  begin
                        xpos  <= xpos + 1'b1;
                    end else begin
                        fxpos <= fxpos + 1'b1;
                    end
                end
            end

            LEFT: begin
                if (iMapDirect[0] == 1) begin
                    if (fxpos == 0 || H_DISP_HALF <= xpos) begin
                        xpos  <= xpos - 1'b1;
                    end else begin
                        fxpos <= fxpos - 1'b1;
                    end
                end
            end

            default: begin 
                xpos <= xpos;
            end
        endcase
    end
end


//----------------------------------------------------------
// ジャンプ動作座標更新
//----------------------------------------------------------

//----------------------------------------------------------
// ジャンプの上昇下降スピード管理、現在のジャンプカウント値に応じて速度を変更
//----------------------------------------------------------
function [3:0] getJumpCompare (
    input [5:0] jump_height
);
begin
    if (30 <= jump_height && jump_height <= 50) begin
        getJumpCompare = 3;
    end else if (19 <= jump_height && jump_height <= 29) begin
        getJumpCompare = 5;
    end else if (8 <= jump_height && jump_height <= 18) begin
        getJumpCompare = 7;
    end else if (4 <= jump_height && jump_height <= 7) begin
        getJumpCompare = 10;
    end else if (0 < jump_height && jump_height <= 3) begin
        getJumpCompare = 12;
    end else begin
        getJumpCompare = 3;
    end
end
endfunction

assign jump_comp = (getJumpCompare(jump_height));
assign jump_max_count = 2;


//----------------------------------------------------------
// 通常2回ジャンプ動作
// キーを押す -> ジャンプ
// キーを離す -> ジャンプ待機完了
// キーを押す -> 2回目ジャンプ
// キーを離す -> ジャンプ待機完了
// 
// 押しっぱなし状態で連続でジャンプを行わないようにした
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        jump_key_toggle <= 0;
    end else if (iBtn[SW_A] == 1'b1) begin
        jump_key_toggle <= 1;
    end else begin
        jump_key_toggle <= 0;
    end
end


//----------------------------------------------------------
// なるべく山なりなジャンプ動作にしたつもりである
// 1pixel単位で当たり判定を行うため増分値は1固定する。
// そのため座標の更新スピードを調整することで、速度のアニメーションを再現している
//----------------------------------------------------------

// TODO 二回ジャンプステートを追加する
// それぞれのレジスタごとに回路を分ける
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        ypos    <= iStartY;
        now_ydir <= IDOL;
        jump_speed <= 0;
        jump_count <= 0;
    end else begin
        case (now_ydir)
            IDOL: begin
                if (jump_key_toggle == 1'b0 && iBtn[SW_A] == 1'b1) begin
                    now_ydir    <= JUMP;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                    jump_count  <= 1;
                end else if (iMapDirect[2] == 1'b1) begin
                    now_ydir <= FALL;
                    jump_height <= 30;
                    jump_speed  <= 0;
                    jump_count  <= 1;
                end
            end

            JUMP: begin
                if (iBtn[SW_A] == 1'b1) begin
                    if (jump_height == 0) begin
                        now_ydir    <= FALL;
                        jump_speed  <= 0;
                    end else if (jump_speed == jump_comp) begin
                        jump_height <= jump_height - 1'b1;
                        ypos        <= ypos - 1'b1;
                        jump_speed  <= 0;
                    end else if (iEn1Ms == 1'b1) begin
                        jump_speed  <= jump_speed + 1'b1;
                    end
                end else begin
                    now_ydir <= FALL;
                end
            end

            FALL: begin
                if (jump_key_toggle == 1'b0 && iBtn[SW_A] == 1'b1 && jump_count < jump_max_count) begin
                    now_ydir    <= JUMP;
                    jump_count  <= 2;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                end else if (iMapDirect[2] == 1'b0) begin
                    now_ydir <= IDOL;
                end else if (jump_speed == jump_comp) begin
                    jump_height <= (jump_height == JUMP_HEIGHT) ? JUMP_HEIGHT : jump_height + 1'b1;
                    ypos        <= ypos + 1'b1;
                    jump_speed  <= 0;
                end else if (iEn1Ms == 1'b1) begin
                    jump_speed  <= jump_speed + 1'b1;
                end
            end

            default: begin
                now_ydir <= IDOL;
            end
        endcase
    end
end
endmodule