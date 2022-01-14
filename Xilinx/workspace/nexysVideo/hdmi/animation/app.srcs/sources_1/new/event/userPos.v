/*
 * Create 2021/1/06
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * ユーザーの描画座標データ生成
 */

module userPos
(
    input           iCLK,       // system clk
    input           iRST,       // system rst
    input  [ 5:0]   iBtn,
    input           iEn1Ms,
    input  [ 9:0]   iStartX,    // 開始x座標
    input  [ 9:0]   iStartY,    // 開始y座標
    output [ 9:0]   oUXS,       // user xpos start   
    output [ 9:0]   oUYS,       // user ypos start
    output [ 9:0]   oUXE,       // user xpos end
    output [ 9:0]   oUYE,       // user ypos end
    output [15:0]   oFXS,       // field user xpos
    output [15:0]   oFYS,       // field user ypos
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

// キー入力ステートマシン
reg [1:0] x_state, old_x;
reg [1:0] y_state, old_y;

// 横移動速度
reg [3:0] x_speed;
reg [3:0] x_comp;

// ジャンプステータス
reg  [ 1:0] jump_count;      // ジャンプの回数
reg  [ 9:0] jump_height;     // ジャンプ中の高さ
reg  [ 3:0] jump_speed;      // ジャンプの速度
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
        x_state <= IDOL;
    end else begin
        case ({iBtn[SW_RIGHT], iBtn[SW_LEFT]})
            0:       x_state <= IDOL; 
            1:       x_state <= LEFT;
            2:       x_state <= RIGHT;
            3:       x_state <= DOUBLE;
            default: x_state <= IDOL;
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
        old_x <= 0;
    end else if (x_speed == KEY_END_TIME && iEn1Ms == 1'b1) begin
        case (x_state)
            IDOL: begin
                old_x <= IDOL;
            end

            RIGHT: begin
                if (iMapDirect[1] == 1) begin
                    if (iMapWidth < (H_CHIP_NUMBER + wire_fxpos) || xpos < H_DISP_HALF)  begin
                        xpos  <= xpos + 1'b1;
                    end else begin
                        fxpos <= fxpos + 1'b1;
                    end
                end
                old_x <= RIGHT;
            end

            LEFT: begin
                if (iMapDirect[0] == 1) begin
                    if ((H_CHIP_NUMBER + wire_fxpos) < iMapWidth || H_DISP_HALF <= xpos)  begin
                        xpos  <= xpos - 1'b1;
                    end else begin
                        fxpos <= fxpos - 1'b1;
                    end
                end
                old_x <= LEFT;
            end

            DOUBLE: begin
                if (old_x == RIGHT) begin
                    if (iMapDirect[0] == 1) begin
                        if ((H_CHIP_NUMBER + wire_fxpos) < iMapWidth || H_DISP_HALF <= xpos)  begin
                            xpos  <= xpos - 1'b1;
                        end else begin
                            fxpos <= fxpos - 1'b1;
                        end
                    end
                end else begin
                    if (iMapDirect[1] == 1) begin
                        if (iMapWidth < (H_CHIP_NUMBER + wire_fxpos) || xpos < H_DISP_HALF)  begin
                            xpos  <= xpos + 1'b1;
                        end else begin
                            fxpos <= fxpos + 1'b1;
                        end
                    end
                end
            end

            default: begin 
                old_x <= IDOL;
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
        y_state <= IDOL;
        jump_speed <= 0;
        jump_count <= 0;
    end else begin
        case (y_state)
            IDOL: begin
                if (jump_key_toggle == 1'b0 && iBtn[SW_A] == 1'b1) begin
                    y_state     <= JUMP;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                    jump_count  <= 1;
                end else if (iMapDirect[2] == 1'b1) begin
                    y_state <= FALL;
                    jump_height <= 30;
                    jump_speed  <= 0;
                    jump_count  <= 1;
                end
            end

            JUMP: begin
                if (iBtn[SW_A] == 1'b1) begin
                    if (jump_height == 0) begin
                        y_state     <= FALL;
                        jump_speed  <= 0;
                    end else if (jump_speed == jump_comp) begin
                        jump_height <= jump_height - 1'b1;
                        ypos        <= ypos - 1'b1;
                        jump_speed  <= 0;
                    end else if (iEn1Ms == 1'b1) begin
                        jump_speed  <= jump_speed + 1'b1;
                    end
                end else begin
                    y_state <= FALL;
                end
            end

            FALL: begin
                if (jump_key_toggle == 1'b0 && iBtn[SW_A] == 1'b1 && jump_count < jump_max_count) begin
                    y_state     <= JUMP;
                    jump_count  <= 2;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                end else if (iMapDirect[2] == 1'b0) begin
                    y_state <= IDOL;
                end else if (jump_speed == jump_comp) begin
                    jump_height <= (jump_height == JUMP_HEIGHT) ? JUMP_HEIGHT : jump_height + 1'b1;
                    ypos        <= ypos + 1'b1;
                    jump_speed  <= 0;
                end else if (iEn1Ms == 1'b1) begin
                    jump_speed  <= jump_speed + 1'b1;
                end
            end

            default: begin
                y_state <= IDOL;
            end
        endcase
    end
end
endmodule