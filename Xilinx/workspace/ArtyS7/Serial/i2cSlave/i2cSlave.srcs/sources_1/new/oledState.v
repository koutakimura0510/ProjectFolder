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
input       enSet,      // 設定時の待機時間計測用、1ms enable信号
output		oledEnable  // oledデータ送受信開始
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

reg powerOnEnable;         assign oledEnable = powerOnEnable;

// 待機時間管理
reg [4:0] wTimeCnt;     // 待機時間カウント値保存
reg [1:0] wTimeState;   // 待機時間の切り替え状態管理
reg [4:0] wTime;        // 設定の待機時間保存


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