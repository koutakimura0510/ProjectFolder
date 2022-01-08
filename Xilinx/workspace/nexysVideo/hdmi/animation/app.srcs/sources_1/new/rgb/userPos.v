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
    input  [4:0]    iBtn,       // bit -> 4.C 3.D 2.L 1.R 0.U
    input           iEn1Ms,
    input  [9:0]    iStartX,    // 開始x座標
    input  [9:0]    iStartY,    // 開始y座標
    output [9:0]    oUXS,       // user xpos start   
    output [9:0]    oUYS,       // user ypos start
    output [9:0]    oUXE,       // user xpos end
    output [9:0]    oUYE        // user ypos end
);

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
localparam JUMP   = 1;
localparam FALL   = 2;

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
reg [9:0] xpos;       assign oUXS = xpos;
reg [9:0] ypos;       assign oUYS = ypos; 
assign oUXE = xpos + 32;
assign oUYE = ypos + 48;

// キー入力ステートマシン
reg [1:0] x_state, old_x;
reg [1:0] y_state, old_y;

// 横移動速度
reg [3:0] x_speed;
reg [3:0] x_comp;

// ジャンプステータス
reg [1:0] jump_count;   // ジャンプの回数
reg [5:0] jump_height;  // ジャンプ中の高さ
reg [3:0] jump_speed;   // ジャンプの速度
wire [3:0] jump_comp;   // 速度値
wire [1:0] jump_max_count; // 最大ジャンプ回数


//----------------------------------------------------------
// 左右キーの座標更新ステートマシン
// 右キーを押している間に左キーを押した場合、キャラクターは左に移動する
// 左キーを押している間に右キーを押した場合、キャラクターは右に移動する
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        x_state <= IDOL;
    end else begin
        case ({iBtn[1], iBtn[2]})
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
    end else if ((iBtn[1] | iBtn[2]) == 1'b1) begin
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
    end else if ((iBtn[1] | iBtn[2]) == 1'b1) begin
        if (x_speed == KEY_END_TIME && x_comp != KEY_COMP_TIME && iEn1Ms == 1'b1) begin
            x_comp <= x_comp - 1'b1;
        end
    end else begin
        x_comp <= KEY_START_TIME;
    end
end


//----------------------------------------------------------
// ユーザーx座標の生成
// 現在押している方向を保存しておき、
// 左右キーが同時押された場合反対に進むようにする
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        xpos  <= iStartX;
        old_x <= 0;
    end else if (x_speed == x_comp) begin
        case (x_state)
            IDOL: begin
                old_x <= IDOL;
            end

            RIGHT: begin
                xpos  <= (xpos < 608) ? xpos + 1'b1 : xpos;
                old_x <= RIGHT;
            end

            LEFT: begin
                xpos  <= (xpos != 0) ? xpos - 1'b1 : xpos;
                old_x <= LEFT;
            end

            DOUBLE: begin
                if (old_x == RIGHT) begin
                    xpos <= (xpos != 0) ? xpos - 1'b1 : xpos;
                end else begin
                    xpos <= (xpos < 608) ? xpos + 1'b1 : xpos;
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
        getJumpCompare = 12;
    end
end
endfunction

assign jump_comp = (getJumpCompare(jump_height));
assign jump_max_count = 2;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        ypos    <= iStartY;
        y_state <= IDOL;
        jump_speed <= 0;
        jump_count <= 0;
    end else begin
        case (y_state)
            IDOL: begin
                if (iBtn[4] == 1'b1) begin
                    y_state    <= JUMP;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed <= 0;
                    jump_count <= 1;
                end
            end

            JUMP: begin
                if (iBtn[4] == 1'b1 && jump_count < jump_max_count) begin
                    y_state     <= JUMP;
                    jump_count  <= 2;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                end else if (jump_height == 0) begin
                    y_state    <= FALL;
                    jump_speed <= 0;
                end else if (jump_speed == jump_comp) begin
                    jump_height <= jump_height - 1'b1;
                    ypos       <= ypos - 1'b1;
                    jump_speed <= 0;
                end else if (iEn1Ms == 1'b1) begin
                    jump_speed <= jump_speed + 1'b1;
                end
            end

            FALL: begin
                if (iBtn[4] == 1'b1 && jump_count < jump_max_count) begin
                    y_state     <= JUMP;
                    jump_count  <= 2;
                    jump_height <= JUMP_HEIGHT;
                    jump_speed  <= 0;
                end else if (jump_height == JUMP_HEIGHT) begin
                    y_state <= IDOL;
                end else if (jump_speed == jump_comp) begin
                    jump_height <= jump_height + 1'b1;
                    ypos       <= ypos + 1'b1;
                    jump_speed <= 0;
                end else if (iEn1Ms == 1'b1) begin
                    jump_speed <= jump_speed + 1'b1;
                end
            end

            default: begin
                y_state <= IDOL;
            end
        endcase
    end
end
endmodule