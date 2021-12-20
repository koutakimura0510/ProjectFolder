/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの初期設定Rom制御
 */
module oledInit
#(
parameter ADDR_WIDTH = 17       // 初期化Romサイズ
)(
input 			iCLK,		    // System Clock
input [4:0]     iAddr,          // バッファ参照アドレス
output [7:0]    oData           // 出力データ
);

reg [7:0] odata;        assign oData = odata;

//----------------------------------------------------------
// oled初期化コマンドリスト
//----------------------------------------------------------
localparam [7:0]
    SCAN_DIRECTION      = 8'hC0,	    // 画面の上下の向き設定 c0 通常描画 / c8反転描画
    SET_COM_PIN         = 8'hda,	    // hardware config
    PIN_HARD            = 8'h12,	    // 描画の間隔
    CONTRAST_SET        = 8'h81,        // 明るさ調整
    CONTRAST_VALUE      = 8'hff,	    // 最大255
    CHARGE_PUMP         = 8'h8d,        // 電圧設定
    SER_SEGMENT_REMAP   = 8'ha0,        // 描画の方向設定 a0左->右 / a1右->左
    ENABLE_CHARGE_PUMP  = 8'h14,        // チャージポンプの設定
    DISPLAY_OFF         = 8'hae,        // 表示停止
    DISPLAY_ON          = 8'haf,        // 表示開始
    SET_DISPLAY_CLOCK   = 8'hd5,        // 表示速度設定用CLKのレジスタのアドレス
    OSCILLATOR_RATIO    = 8'hf0,	    // クロックを設定0x00~0xf0
    SET_PERIOD          = 8'hd9,        // 液晶同期に必要なDCLKのレジスタのアドレス
    SET_DCLK            = 8'hff,	    // Dクロックを設定0x00~0xff
    SET_VCOMH           = 8'hdb,        // 電圧発生回路操作レジスタのアドレス
    VCOMH_LEVEL         = 8'h30,	    // 電圧発生回路の設定
    DUMMY               = 8'h00;        // ダミーデータ

localparam LENGTH = 2**ADDR_WIDTH;

// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oled_init_rom [LENGTH-1:0];

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

always @(posedge iCLK) begin
    odata <= oled_init_rom[iAddr];
end

endmodule