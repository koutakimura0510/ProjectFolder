/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの制御用待機時間生成モジュール
 */
module oledTime
#(
parameter PDIVCLK = 100000      // 分周回路の値 通常1ms
)(
input 			iCLK,		    // System Clock
input 			iRST,		    // System Reset
output          oEnable,        // 
);

//----------------------------------------------------------
// 待機時間に関するパラメーターリスト
//----------------------------------------------------------
localparam[5:0]
    POWER_ON_TIME   = 6'd63,
    CMD_ON_TIME     = 6'd10;

localparam [5:0] 
	WTIME_CNTUP     = 6'd1,
	WTIME_NULL 	    = 6'd0;

// 待機時間管理
reg [5:0] wtime_cnt;     // 待機時間カウント値保存
reg [5:0] wtime_max;     // 設定の待機時間保存


//----------------------------------------------------------
// 分周回路パラメータ 最大1Secまで分周可能
//----------------------------------------------------------
localparam COUNT_ORDER = (PDIVCLK - 1);

wire div_enable;
reg [26:0] tmp_count;       assign div_enable = (tmp_count == COUNT_ORDER) ? 1'b1 : 1'b0;

// 分周回路
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 27'd0;
    end else if (div_enable == 1'b1) begin
        tmp_count <= 27'd0;
    end else begin
        tmp_count <= tmp_count + 27'd1;
    end
end


//-----------------------------------------------------------
// 待機時間制御回路
//-----------------------------------------------------------

// 待機時間計測カウンタ
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wtime_cnt <= WTIME_NULL;
    end else if (iLE == 1'b1) begin
        wtime_cnt <= WTIME_NULL;
    end else if (enSet == 1'b1) begin
        if (wtime_cnt == wtime_max) begin
            wtime_cnt <= WTIME_NULL;
        end else begin
            wtime_cnt <= wtime_cnt + WTIME_CNTUP;
        end
    end
end

// 待機時間の設定
// 電源投入時間が完了したら、コマンド操作の時間に切り替える
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wtime_max <= POWER_ON_TIME;
    end else if (enSet == 1'b1 && wtime_cnt == wtime_max) begin
        wtime_max <= CMD_ON_TIME;
    end
end

// 待機時間完了Enable信号の出力
// oled初期設定時や起動時の各コマンド送信時に、
// 一定の待ち時間が必要なためEnable信号で判定を行うようにした。
// 全ての設定データ送信後は常にighを維持し、待機時間を設けないようにする。
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wEnable <= 1'b0;
    end else if (wtime_cnt == wtime_max) begin
        wEnable <= 1'b1;
    end else begin
        wEnable <= 1'b0;
    end
end

// oledに電源投入時に300ms程待機時間が必要なため、
// 起動待機時間完了enable信号を設けた。
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        powerOnEnable <= 1'b0;
    end else if (enSet == 1'b1 && wtime_cnt == wtime_max) begin
        powerOnEnable <= 1'b1;
    end
end

endmodule