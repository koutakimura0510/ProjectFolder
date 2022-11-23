/**-------------------------------------------------
 * 同期信号生成モジュール
 * -
 * CLK		: 外部クロックの立ち上がり信号
 * RESET	: システムリセット入力
 * DRAW_ON	: 初期設定終了	= 1
 * 			  初期設定中	= 0
 *
 * HSYNC	: 水平同期カウンター
 * VSYNC	: 垂直同期カウンター
 * hpos		: 水平同期カウンターの現在の座標
 * vpos		: 垂直同期カウンターの現在の座標
 * DE		: ディスプレイ点灯信号
 * 			  ON  = 1
 * 			  OFF = 0
 * -------------------------------------------------*/
module HVSYNC_GEN (
    input CLK, RESET, DRAW_ON,
    output HSYNC, VSYNC,
    output reg [8:0] hpos, vpos,
    output DE
);

parameter H_DISPLAY        = 240; // horizontal display width
parameter H_BACK           =  24; // horizontal left border (back porch)
parameter H_FRONT          =  16; // horizontal right border (front porch)
parameter H_SYNC           =  16; // horizontal sync width
parameter V_DISPLAY        = 320; // vertical display height
parameter V_BACK           =   2; // vertical top border
parameter V_FRONT          =   4; // vertical bottom border
parameter V_SYNC           =   4; // vertical sync # lines
parameter H_SYNC_START     = H_DISPLAY + H_FRONT;
parameter H_SYNC_END       = H_DISPLAY + H_FRONT + H_SYNC - 1;
parameter H_MAX            = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;
parameter V_SYNC_START     = V_DISPLAY + V_FRONT;
parameter V_SYNC_END       = V_DISPLAY + V_FRONT + V_SYNC - 1;
parameter V_MAX            = V_DISPLAY + V_BACK + V_FRONT + V_SYNC - 1;
parameter DE_START_UP_TIME = H_BACK;


/**------------------------------------------
 * ファイル内、reg・wire宣言
 *------------------------------------------*/
wire hmax, vmax;
reg [7:0] de_start_up;


/**------------------------------------------
 * 描画幅の最大クロックをカウントしたらEnable
 *------------------------------------------*/
assign hmax = (hpos == H_MAX && RESET == 1'b1) ? 1'b1 : 1'b0;
assign vmax = (vpos == V_MAX && RESET == 1'b1) ? 1'b1 : 1'b0;


/**------------------------------------------
 * 水平同期カウンター
 *------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
    if (RESET == 1'b0) begin
        hpos <= 0;
    end else if (hmax == 1'b1) begin
        hpos <= 0;
    end else if (de_start_up == DE_START_UP_TIME && DRAW_ON == 1'b1) begin
        hpos <= hpos + 1;
    end
end


/**------------------------------------------
 * 垂直同期カウンター
 *------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
    if (RESET == 1'b0) begin
        vpos <= 0;
    end else if (hmax == 1'b1) begin
        if (vmax == 1'b1) begin
            vpos <= 0;
        end else if (DRAW_ON == 1'b1) begin
            vpos <= vpos + 1;
        end
    end
end


/**------------------------------------------
 * DENABLEカウンター
 * およそ20CLK程待機してから、同期カウンターを生成する必要がある
 *------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
    if (RESET == 1'b0) begin
        de_start_up <= 0;
    end else if (hmax == 1'b1) begin
        de_start_up <= 0;
    end else if (de_start_up != DE_START_UP_TIME && DRAW_ON == 1'b1) begin
        de_start_up <= de_start_up + 1;
    end
end


/**------------------------------------------
 * 有効領域のディスプレイON信号の生成
 *------------------------------------------*/
assign HSYNC = (hpos >= H_SYNC_START && hpos <= H_SYNC_END) ? 1'b0 : 1'b1;
assign VSYNC = (vpos >= V_SYNC_START && vpos <= V_SYNC_END) ? 1'b0 : 1'b1;
assign DE = (hpos < H_DISPLAY && vpos < V_DISPLAY && DRAW_ON == 1'b1 && de_start_up == DE_START_UP_TIME) ? 1'b1 : 1'b0;

endmodule
