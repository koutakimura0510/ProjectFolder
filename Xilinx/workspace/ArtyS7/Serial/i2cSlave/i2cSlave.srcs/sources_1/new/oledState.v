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
 * datasheet -> https://akizukidenshi.com/download/ds/solomon/ssd1306.pdf
 * -
 * 電源投入から300ms経過後、初期設定データと送信開始Enable信号を出力する
 * start condition sda low  scl low  = min 600ns order 1.4MHz
 * stop condition  scl high sda high = min 600ns order 1.4MHz
 * stop IDLE       sda high keep     = min 1.3us order 700kHz
 */
module oledState
(
input  		    iCLK,
input  		    iRST,
input           enSet,          // 設定時の待機時間計測用、1ms enable信号
input           iLE,            // masterがデータを送信完了したらHigh
output		    oOledPV,        // 起動待機時間完了、oledデータ送受信開始信号 oled power valid
output          oOledCV,        // 初期設定データ送信完了信号 oled cmd valid
output          wTimeEnable,    // 待機時間完了Enable信号
output [7:0]    sendByte        // 送信データ
);

// output制御信号
reg powerOnEnable;          assign oOledPV      = powerOnEnable;    // 起動時間経過後High
reg o_oledcv;               assign oOledCV      = o_oledcv;         // 指定モードのコマンド発行後High
reg [7:0] sendbyte;         assign sendByte     = sendbyte;         // 設定時のコマンドバイトとデータバイト16bit
reg wEnable;                assign wTimeEnable  = wEnable;          // 待機時間完了時High

//----------------------------------------------------------
// 待機時間に関するパラメーターリスト
//----------------------------------------------------------
localparam[5:0]
    powerOnTime     = 6'd63,
    cmdOnTime       = 6'd10;

localparam [5:0] 
	wTimeCntUp	    = 6'd1,
	wTimeNull 	    = 6'd0;

// 待機時間管理
reg [5:0] wTimeCnt;     // 待機時間カウント値保存
reg [5:0] wTime;        // 設定の待機時間保存


//----------------------------------------------------------
// 制御コマンド更新を管理する状態制御定数
//----------------------------------------------------------
localparam [1:0]
    sendStateWait   = 2'd0,
    sendStateOn     = 2'd1,
    sendStateBridge = 2'd2;

// コマンド配列参照用rpの更新方法制御変数
reg [1:0] sendState;


//----------------------------------------------------------
// oledコマンドリスト
//----------------------------------------------------------
localparam [7:0]
    SCAN_DIRECTION      = 8'hC8,	    // 反転表示コマンド、通常だと上下が逆のため設定
    SET_COM_PIN         = 8'hda,	    // hardware config
    PIN_HARD            = 8'h12,	    // 0だと間隔が広がる
    CONTRAST_SET        = 8'h81,        // 明るさ調整
    CONTRAST_VALUE      = 8'hff,	    // 最大255
    CHARGE_PUMP         = 8'h8d,        // 電圧設定
    SER_SEGMENT_REMAP   = 8'ha1,        // remap情報の設定
    ENABLE_CHARGE_PUMP  = 8'h14,        // チャージポンプの設定
    DISPLAY_ON          = 8'haf,        // 表示開始
    SET_DISPLAY_CLOCK   = 8'hd5,        // 表示速度設定用CLKのレジスタのアドレス
    OSCILLATOR_RATIO    = 8'hf0,	    // クロックを設定0x00~0xf0
    SET_PERIOD          = 8'hd9,        // 液晶同期に必要なDCLKのレジスタのアドレス
    SET_DCLK            = 8'hff,	    // Dクロックを設定0x00~0xff
    SET_VCOMH           = 8'hdb,        // 電圧発生回路操作レジスタのアドレス
    VCOMH_LEVEL         = 8'h30,	    // 電圧発生回路の設定
    MEMORY_MODE         = 8'h20,        // メモリー操作モード
    HORIZONTAL_MODE     = 8'h00,        // 横画面操作モード
    COLUMN_ADDRESS      = 8'h21,        // 書き込み座標操作レジスタのアドレス
    COLUMN_START        = 8'h00,        // 横ラインの書き込み開始座標
    COLUMN_END          = 8'h7f,        // 横ラインの書き込み終了座標
    PAGE_ADDRESS        = 8'h22,        // 書き込みページ操作レジスタのアドレス
    PAGE_START          = 8'h00,        // 縦ラインの0~7開始ページ
    PAGE_END            = 8'h07,        // 縦ラインの0~7終了ページ
    DUMMY               = 8'h00;        // ダミーデータ

// 初期化配列の最大値
localparam [4:0]
    initCmdMax          = 5'd15;

reg [4:0] initCmdRp;    // 初期設定コマンド配列参照用


// 書き込み座標指定配列の最大値
localparam [3:0]
    writeCmdMax         = 4'd8;

reg [3:0] writeCmdRp;


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
    oledCmdBuff[15] = DUMMY;
end

// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oledWriteBuff [0:8];
initial begin
    oledWriteBuff[0] = MEMORY_MODE;
    oledWriteBuff[1] = HORIZONTAL_MODE;
    oledWriteBuff[2] = COLUMN_ADDRESS;
    oledWriteBuff[3] = COLUMN_START;
    oledWriteBuff[4] = COLUMN_END;
    oledWriteBuff[5] = PAGE_ADDRESS;
    oledWriteBuff[6] = PAGE_START;
    oledWriteBuff[7] = PAGE_END;
    oledWriteBuff[8] = DUMMY;
end


//-----------------------------------------------------------
// 待機時間制御回路
//-----------------------------------------------------------

// 待機時間計測カウンタ
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wTimeCnt <= wTimeNull;
    end else if (iLE == 1'b1) begin
        wTimeCnt <= wTimeNull;
    end else if (enSet == 1'b1) begin
        if (wTimeCnt == wTime) begin
            wTimeCnt <= wTimeNull;
        end else begin
            wTimeCnt <= wTimeCnt + wTimeCntUp;
        end
    end
end

// 待機時間の設定
// 電源投入時間が完了したら、コマンド操作の時間に切り替える
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wTime <= powerOnTime;
    end else if (enSet == 1'b1 && wTimeCnt == wTime) begin
        wTime <= cmdOnTime;
    end
end

// 待機時間完了Enable信号の出力
// oled初期設定時や起動時の各コマンド送信時に、
// 一定の待ち時間が必要なためEnable信号で判定を行うようにした。
// 全ての設定データ送信後は常にighを維持し、待機時間を設けないようにする。
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wEnable <= 1'b0;
    end else if (wTimeCnt == wTime) begin
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
    end else if (enSet == 1'b1 && wTimeCnt == wTime) begin
        powerOnEnable <= 1'b1;
    end
end


//----------------------------------------------------------
// 起動時コマンド送信の状態制御
//----------------------------------------------------------

// rp更新ステートマシンの制御
// 指定バイト送信完了のEnable信号の立ち上がり時に配列参照用Rpの更新を行いたい。
// 立ち上がり判定用にシフトレジスタを用意しても良かったが、容量がもったいなく感じた。
// そのため、立ち上がりのHigh判定用と立下りのLow判定用のモードのほかに、一度だけ実行されるRp更新用のモードを設けた
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendState <= sendStateWait;
    end else begin
        case (sendState)
            sendStateWait:      sendState <= (iLE == 1'b1) ? sendStateOn : sendStateWait;
            sendStateOn:        sendState <= sendStateBridge;
            sendStateBridge:    sendState <= (iLE == 1'b0) ? sendStateWait : sendStateBridge;
            default:            sendState <= sendStateWait;
        endcase
    end
end

// 初期設定配列のrp更新
// Rp更新モードの時だけレジスタの値を変更する
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        initCmdRp <= 5'd0;
    end else if (sendState == sendStateOn) begin
        if (initCmdRp != initCmdMax) begin
            initCmdRp <= initCmdRp + 5'd1;
        end
    end
end

// 書き込み配列のrp更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        writeCmdRp <= 4'd0;
    end else if (sendState == sendStateOn && initCmdRp == initCmdMax) begin
        if (writeCmdRp == writeCmdMax) begin
            writeCmdRp <= 4'd0;
        end else begin
            writeCmdRp <= writeCmdRp + 4'd1;
        end
    end
end

// 全コマンドデータ送信完了信号の出力
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        o_oledcv <= 1'd0;
    end else begin
        o_oledcv <= (initCmdRp == initCmdMax && writeCmdRp == writeCmdMax) ? 1'b1 : 1'b0;
    end
end

// 送信データの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendbyte <= 8'd0;
    end else if (initCmdRp != initCmdMax) begin
        sendbyte <= oledCmdBuff[initCmdRp];
    end else begin
        sendbyte <= oledWriteBuff[writeCmdRp];
    end
end

endmodule