/*
 * Create 2021/11/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * oled ssd1306の状態遷移を管理
 * -
 * 使用したOLED
 * https://akizukidenshi.com/catalog/g/gP-12031/
 * -
 * 電源投入から300ms経過後、初期設定データと送信開始Enable信号を出力する
 */
module oledState
(
input  		iCLK,
input  		iRST,
input       enSet,          // 設定時の待機時間計測用、1ms enable信号
output		oledEnable,     // 起動待機時間完了、oledデータ送受信開始信号
output      initComplate    // 初期設定データ送信完了信号
);

// 待機時間に関するパラメーター一覧
localparam [1:0]
    powerOnTimeSet  = 2'd0,
    cmdOnTimeSet    = 2'd1,
    finishOnTimeSet = 2'd2;

localparam[4:0]
    powerOnTime     = 5'd20,
    cmdOnTime       = 5'd5,
    finishOnTime    = 5'd0;

localparam [4:0] 
	wTimeCntUp	    = 5'd1,
	wTimeNull 	    = 5'd0;

localparam [7:0]
    SCAN_DIRECTION      = 0xC8,	    // 反転表示
    SET_COM_PIN         = 0xda,	    //
    PIN_HARD            = 0x12,	    // 0だと間隔が広がる
    CONTRAST_SET        = 0x81,
    CONTRAST_VALUE      = 0xff,	    // 最大255
    CHARGE_PUMP         = 0x8d,
    SER_SEGMENT_REMAP   = 0xa1,
    ENABLE_CHARGE_PUMP  = 0x14,
    DISPLAY_ON          = 0xaf,
    SET_DISPLAY_CLOCK   = 0xd5,
    OSCILLATOR_RATIO    = 0xf0,	    // クロックを設定0x00~0xf0
    SET_PERIOD          = 0xd9,
    SET_DCLK            = 0xff,	    // Dクロックを設定0x00~0xff
    SET_VCOMH           = 0xdb,
    VCOMH_LEVEL         = 0x30;	    // 電圧発生回路の設定

reg powerOnEnable;          assign oledEnable = powerOnEnable;
reg complate;               assign initComplat = complate;

// 待機時間管理
reg [4:0] wTimeCnt;     // 待機時間カウント値保存
reg [1:0] wTimeState;   // 待機時間の切り替え状態管理
reg [4:0] wTime;        // 設定の待機時間保存

// 初期設定コマンド
(* ram_style = "BLOCK" *) reg [7:0] oledCmd [0:15];

initial begin
    oledCmd[ 0] = CONTRAST_SET;
    oledCmd[ 1] = CONTRAST_VALUE;
    oledCmd[ 2] = SER_SEGMENT_REMAP;
    oledCmd[ 3] = CHARGE_PUMP;
    oledCmd[ 4] = ENABLE_CHARGE_PUMP;
    oledCmd[ 5] = SCAN_DIRECTION;
    oledCmd[ 6] = SET_COM_PIN;
    oledCmd[ 7] = PIN_HARD;
    oledCmd[ 8] = SET_DISPLAY_CLOCK;
    oledCmd[ 9] = OSCILLATOR_RATIO;
    oledCmd[10] = SET_PERIOD;
    oledCmd[11] = SET_DCLK;
    oledCmd[12] = SET_VCOMH;
    oledCmd[13] = VCOMH_LEVEL;
    oledCmd[14] = DISPLAY_ON;
end

// 待機時間計測カウンタ
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wTimeCnt <= wTimeNull;
    end else if (enSet == 1'b1) begin
        if (wTimeCnt == wTime) begin
            wTimeCnt <= wTimeNull;
        end else begin
            wTimeCnt <= wTimeCnt + wTimeCntUp;
        end
    end
end

// 待機状態の設定
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wTimeState <= powerOnTimeSet;
    end else if (enSet == 1'b1 && wTimeCnt == wTime) begin
        case (wTimeState)
            powerOnTimeSet:     wTimeState <= cmdOnTimeSet;
            cmdOnTimeSet:       wTimeState <= finishOnTimeSet;
            finishOnTimeSet:    wTimeState <= finishOnTimeSet;
            default:            wTimeState <= powerOnTimeSet;
        endcase
    end
end

// 待機時間の設定
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wTime <= powerOnTime;
    end else if (enSet == 1'b1 && wTimeCnt == wTime) begin
        case (wTimeState)
            powerOnTimeSet:     wTime <= cmdOnTime;
            cmdOnTimeSet:       wTime <= finishOnTime;
            finishOnTimeSet:    wTime <= finishOnTime;
            default:            wTime <= powerOnTime;
        endcase
    end
end

// 起動待機時間完了enable信号の設定
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        powerOnEnable <= 1'b0;
    end else if (enSet == 1'b1 && wTimeCnt == wTime) begin
        case (wTimeState)
            powerOnTimeSet: powerOnEnable <= 1'b0;
            default:        powerOnEnable <= 1'b1;
        endcase
    end
end

endmodule