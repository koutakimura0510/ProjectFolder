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
input  		    iCLK,
input  		    iRST,
input           enSet,          // 設定時の待機時間計測用、1ms enable信号
input           sendComplete,   // masterがデータを送信完了したらHigh
input           clear,          // 表示クリア信号
output [15:0]   sendByte,       // cmd + 送信データ
output		    oledPowerOn,    // 起動待機時間完了、oledデータ送受信開始信号
output          initComplate    // 初期設定データ送信完了信号
);


//----------------------------------------------------------
// 待機時間に関するパラメーターリスト
//----------------------------------------------------------
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


//----------------------------------------------------------
// 制御コマンド更新を管理する状態制御定数
//----------------------------------------------------------
localparam [1:0]
    sendStateWait   = 2'd0,
    sendStateOn     = 2'd1,
    sendStateBridge = 2'd2;


//----------------------------------------------------------
// oledコマンドリスト
//----------------------------------------------------------
localparam [7:0]
    SCAN_DIRECTION      = 8'hC8,	    // 反転表示
    SET_COM_PIN         = 8'hda,	    // hardware config
    PIN_HARD            = 8'h12,	    // 0だと間隔が広がる
    CONTRAST_SET        = 8'h81,        // 明るさ調整
    CONTRAST_VALUE      = 8'hff,	    // 最大255
    CHARGE_PUMP         = 8'h8d,        // 電圧設定
    SER_SEGMENT_REMAP   = 8'ha1,        // remap情報の設定
    ENABLE_CHARGE_PUMP  = 8'h14,        // チャージポンプの設定
    DISPLAY_ON          = 8'haf,        // 表示開始
    SET_DISPLAY_CLOCK   = 8'hd5,        // レジスタのアドレス
    OSCILLATOR_RATIO    = 8'hf0,	    // クロックを設定0x00~0xf0
    SET_PERIOD          = 8'hd9,        // レジスタのアドレス
    SET_DCLK            = 8'hff,	    // Dクロックを設定0x00~0xff
    SET_VCOMH           = 8'hdb,        // 電圧発生回路操作レジスタのアドレス
    VCOMH_LEVEL         = 8'h30,	    // 電圧発生回路の設定
    SCROLL_STOP         = 8'h2e,        // スクロールの停止コマンド
    MEMORY_MODE         = 8'h20,        // メモリー操作モード
    HORIZONTAL_MODE     = 8'h00,        // 横画面操作モード
    COLUMN_ADDRESS      = 8'h21,        // 座標操作レジスタのアドレス
    COLUMN_START        = 8'h00,        // 開始座標
    COLUMN_END          = 8'h7f,        // 終了座標
    PAGE_ADDRESS        = 8'h22,        // ページ操作レジスタのアドレス
    PAGE_START          = 8'h00,        // 開始ページ
    PAGE_END            = 8'h07,        // 終了ページ
    CLEAR_DISP          = 8'h00,        // 消去コマンド
    CMD_BYTE            = 8'h00,        // 設定コマンド
    WR_BYTE             = 8'h40;        // 書き込みコマンド

localparam [3:0]
    initCmdMax          = 4'd15,
    clearCmdWd          = 4'd9,
    clearCmdMax         = 4'd10;


//----------------------------------------------------------
// 送信データ制御モードリスト
//----------------------------------------------------------
localparam
    cmdMode            = 1'b0,
    clearMode          = 1'b1;


//----------------------------------------------------------
// 変数宣言
//----------------------------------------------------------

// output制御信号
reg powerOnEnable;          assign oledPowerOn = powerOnEnable;  // 起動時間経過後High
reg complate;               assign initComplate = complate;      // 指定モードのコマンド発行後High
reg [15:0] sendbyte;        assign sendByte = sendbyte;

// 配列rp
reg [3:0] initCmdRp;    // 初期設定コマンド配列参照用
reg [3:0] clearCmdRp;   // クリアコマンド配列参照用

// oledのデータ送信モード管理
reg oledMode;

// 待機時間管理
reg [4:0] wTimeCnt;     // 待機時間カウント値保存
reg [1:0] wTimeState;   // 待機時間の切り替え状態管理
reg [4:0] wTime;        // 設定の待機時間保存

// コマンド配列参照用rpの更新方法制御変数
reg [1:0] sendState;

// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oledCmdBuff [0:15];
initial begin
    oledCmdBuff[ 0] = CONTRAST_SET;
    oledCmdBuff[ 1] = CONTRAST_VALUE;
    oledCmdBuff[ 2] = SER_SEGMENT_REMAP;
    oledCmdBuff[ 3] = CHARGE_PUMP;
    oledCmdBuff[ 4] = ENABLE_CHARGE_PUMP;
    oledCmdBuff[ 5] = SCAN_DIRECTION;
    oledCmdBuff[ 6] = SET_COM_PIN;
    oledCmdBuff[ 7] = PIN_HARD;
    oledCmdBuff[ 8] = SET_DISPLAY_CLOCK;
    oledCmdBuff[ 9] = OSCILLATOR_RATIO;
    oledCmdBuff[10] = SET_PERIOD;
    oledCmdBuff[11] = SET_DCLK;
    oledCmdBuff[12] = SET_VCOMH;
    oledCmdBuff[13] = VCOMH_LEVEL;
    oledCmdBuff[14] = DISPLAY_ON;
    oledCmdBuff[15] = DISPLAY_ON;
end

// クリアコマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oledClearBuff [0:10];
initial begin
    oledClearBuff[ 0] = SCROLL_STOP;
    oledClearBuff[ 1] = MEMORY_MODE;
    oledClearBuff[ 2] = HORIZONTAL_MODE;
    oledClearBuff[ 3] = COLUMN_ADDRESS;
    oledClearBuff[ 4] = COLUMN_START;
    oledClearBuff[ 5] = COLUMN_END;
    oledClearBuff[ 6] = PAGE_ADDRESS;
    oledClearBuff[ 7] = PAGE_START;
    oledClearBuff[ 8] = PAGE_END;
    oledClearBuff[ 9] = CLEAR_DISP;
    oledClearBuff[10] = CLEAR_DISP;
end


//-----------------------------------------------------------
// 待機時間制御回路
//-----------------------------------------------------------

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

//----------------------------------------------------------
// 状態制御信号回路
//----------------------------------------------------------

// rp更新ステートマシンの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendState <= sendStateWait;
    end else begin
        case (sendState)
            sendStateWait: begin
                sendState <= (sendComplete == 1'b1) ? sendStateOn : sendStateWait;
            end

            sendStateOn: begin
                sendState <= sendStateBridge;
            end

            sendStateBridge: begin
                sendState <= (sendComplete == 1'b0) ? sendStateWait : sendStateBridge;
            end

            default: begin
                sendState <= sendStateWait;
            end
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

// 初期設定配列のrp更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        initCmdRp <= 4'd0;
    end else if (sendState == sendStateOn) begin
        if (initCmdRp != initCmdMax) begin
            initCmdRp <= initCmdRp + 4'd1;
        end
    end
end

// クリアコマンド配列のrp更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        clearCmdRp <= 4'd0;
    end else begin
        case (oledMode)
            cmdMode: begin
                clearCmdRp <= 4'd0;
            end

            clearMode: begin
                if (clearCmdRp != clearCmdMax && sendState == sendStateOn) begin
                    clearCmdRp <= clearCmdRp + 4'd1;
                end
            end

            default: begin
                clearCmdRp <= 4'd0;
            end
        endcase
    end
end

// コマンド送信モードの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oledMode <= cmdMode;
    end else begin
        case (oledMode)
            cmdMode: begin
                oledMode <= (initCmdRp == initCmdMax && clear == 1'b1) ? clearMode : cmdMode;
            end

            clearMode: begin
                oledMode <= (clearCmdMax == initCmdMax) ? cmdMode : clearMode;
            end

            default: begin
                oledMode <= cmdMode;
            end
        endcase
    end
end

// 全コマンドデータ送信完了信号の出力
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        complate <= 1'd0;
    end else begin
        case (oledMode)
            cmdMode: begin
                complate <= (initCmdRp == initCmdMax) ? 1'b1 : 1'b0;
            end

            clearMode: begin
                complate <= (clearCmdMax == clearCmdRp) ? 1'b1 : 1'b0;
            end

            default: begin
                complate <= 1'b0;
            end
        endcase
    end
end


// 送信データの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendbyte <= 16'd0;
    end else begin
        case (oledMode)
            cmdMode:   begin
                sendbyte <= {CMD_BYTE, oledCmdBuff[initCmdRp]};
            end

            clearMode: begin
                sendbyte <= (clearCmdRp == clearCmdWd) ? {WR_BYTE, CLEAR_DISP} : {CMD_BYTE, oledClearBuff[clearCmdRp]};
            end

            default: begin
                sendbyte <= 16'd0;
            end
        endcase
    end
end

endmodule