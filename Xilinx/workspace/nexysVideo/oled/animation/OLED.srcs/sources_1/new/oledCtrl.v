/*
 * Create 2021/12/17
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 評価基板付属のOLED SSD1306コントロールモジュール
 */
module oledCtrl
(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system oled
    output          oOledDC,
    output          oOledRes,
    output          oOledScl,
    output          oOledSda,
    output          oOledVbat,
    output          oOledVdd
);

reg oled_dc;                assign oOledDC      = oled_dc;
reg oled_res;               assign oOledRes     = oled_res;
reg oled_scl;               assign oOledScl     = oled_scl;
reg oled_sda;               assign oOledSda     = oled_sda;
reg oled_vbat;              assign oOledVbat    = oled_vbat;
reg oled_vdd;               assign oOledVdd     = oled_vdd;

//----------------------------------------------------------
// 待機時間に関するパラメーターリスト
//----------------------------------------------------------
localparam[5:0]
    POWER_ON_TIME     = 6'd63,
    CMD_ON_TIME       = 6'd10;

localparam [5:0] 
	WTIME_CNTUP	    = 6'd1,
	WTIME_NULL 	    = 6'd0;

// 待機時間管理
reg [5:0] wtime_cnt;     // 待機時間カウント値保存
reg [5:0] wtime_max;        // 設定の待機時間保存


//----------------------------------------------------------
// 制御コマンド更新を管理する状態制御定数
//----------------------------------------------------------
localparam [1:0]
    SEND_STATE_WAIT   = 2'd0,
    SEND_STATE_ON     = 2'd1,
    SEND_STATE_BRIDGE = 2'd2;

// コマンド配列参照用rpの更新方法制御変数
reg [1:0] send_state;


//----------------------------------------------------------
// oledコマンドリスト
//----------------------------------------------------------
localparam [7:0]
    SCAN_DIRECTION      = 8'hC0,	    // 反転表示コマンド、通常だと上下が逆のため設定
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
    INIT_CMDMAX          = 5'd16;

reg [4:0] init_cmd_rp;    // 初期設定コマンド配列参照用


// 書き込み座標指定配列の最大値
localparam [3:0]
    WRITE_CMDMAX         = 4'd9;

reg [3:0] write_cmd_rp;


// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oled_init_rom [0:16];
initial begin
    oled_init_rom[ 0] = DISPLAY_OFF;
    oled_init_rom[ 1] = CHARGE_PUMP;
    oled_init_rom[ 2] = ENABLE_CHARGE_PUMP;
    oled_init_rom[ 3] = SET_PERIOD;
    oled_init_rom[ 4] = SET_DCLK;
    oled_init_rom[ 5] = SET_VCOMH;
    oled_init_rom[ 6] = VCOMH_LEVEL;
    oled_init_rom[ 7] = SET_COM_PIN;
    oled_init_rom[ 8] = PIN_HARD;
    oled_init_rom[ 9] = CONTRAST_SET;
    oled_init_rom[10] = CONTRAST_VALUE;
    oled_init_rom[11] = SER_SEGMENT_REMAP;
    oled_init_rom[12] = SCAN_DIRECTION;
    oled_init_rom[13] = SET_DISPLAY_CLOCK;
    oled_init_rom[14] = OSCILLATOR_RATIO;
    oled_init_rom[15] = DISPLAY_ON;
    oled_init_rom[16] = DUMMY;
end

// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oled_cmd_rom [0:8];
initial begin
    oled_cmd_rom[0] = MEMORY_MODE;
    oled_cmd_rom[1] = HORIZONTAL_MODE;
    oled_cmd_rom[2] = COLUMN_ADDRESS;
    oled_cmd_rom[3] = COLUMN_START;
    oled_cmd_rom[4] = COLUMN_END;
    oled_cmd_rom[5] = PAGE_ADDRESS;
    oled_cmd_rom[6] = PAGE_START;
    oled_cmd_rom[7] = PAGE_END;
    oled_cmd_rom[8] = DUMMY;
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


//----------------------------------------------------------
// 起動時コマンド送信の状態制御
//----------------------------------------------------------

// rp更新ステートマシンの制御
// 指定バイト送信完了のEnable信号の立ち上がり時に配列参照用Rpの更新を行いたい。
// 立ち上がり判定用にシフトレジスタを用意しても良かったが、容量がもったいなく感じた。
// そのため、立ち上がりのHigh判定用と立下りのLow判定用のモードのほかに、一度だけ実行されるRp更新用のモードを設けた
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        send_state <= SEND_STATE_WAIT;
    end else begin
        case (send_state)
            SEND_STATE_WAIT:    send_state <= (iLE == 1'b1) ? SEND_STATE_ON : SEND_STATE_WAIT;
            SEND_STATE_ON:      send_state <= SEND_STATE_BRIDGE;
            SEND_STATE_BRIDGE:  send_state <= (iLE == 1'b0) ? SEND_STATE_WAIT : SEND_STATE_BRIDGE;
            default:            send_state <= SEND_STATE_WAIT;
        endcase
    end
end

// 初期設定配列のrp更新
// Rp更新モードの時だけレジスタの値を変更する
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        init_cmd_rp <= 5'd0;
    end else if (send_state == SEND_STATE_ON) begin
        if (init_cmd_rp != INIT_CMDMAX) begin
            init_cmd_rp <= init_cmd_rp + 5'd1;
        end
    end
end

// 書き込み配列のrp更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        write_cmd_rp <= 4'd0;
    end else if (send_state == SEND_STATE_ON && init_cmd_rp == INIT_CMDMAX) begin
        if (write_cmd_rp == WRITE_CMDMAX) begin
            write_cmd_rp <= 4'd0;
        end else begin
            write_cmd_rp <= write_cmd_rp + 4'd1;
        end
    end
end

// 全コマンドデータ送信完了信号の出力
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        o_oledcv <= 1'd0;
    end else begin
        o_oledcv <= (init_cmd_rp == INIT_CMDMAX && write_cmd_rp == WRITE_CMDMAX) ? 1'b1 : 1'b0;
    end
end

// 送信データの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendbyte <= oled_init_rom[init_cmd_rp];
    end else if (init_cmd_rp != INIT_CMDMAX) begin
        sendbyte <= oled_init_rom[init_cmd_rp];
    end else begin
        sendbyte <= oled_cmd_rom[write_cmd_rp];
    end
end

endmodule