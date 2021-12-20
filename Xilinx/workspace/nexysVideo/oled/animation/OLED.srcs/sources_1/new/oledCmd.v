/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの書き込みページコマンド設定Rom制御
 */
module oledCmd
#(
parameter ADDR_WIDTH = 9        // 初期化Romサイズ
)(
input 			iCLK,		    // System Clock
input [3:0]     iAddr,          // バッファ参照アドレス
output [7:0]    oData           // 出力データ
);

reg [7:0] odata;    assign oData = odata;

//----------------------------------------------------------
// oled書き込み座標更新リスト
//----------------------------------------------------------
localparam [7:0]
    MEMORY_MODE         = 8'h20,        // メモリー操作モード
    HORIZONTAL_MODE     = 8'h00,        // 横画面操作モード
    COLUMN_ADDRESS      = 8'h21,        // 書き込み座標操作レジスタのアドレス
    COLUMN_START        = 8'h00,        // 横ラインの書き込み開始座標
    COLUMN_END          = 8'h7f,        // 横ラインの書き込み終了座標
    PAGE_ADDRESS        = 8'h22,        // 書き込みページ操作レジスタのアドレス
    PAGE_START          = 8'h00,        // 縦ラインの0~3開始ページ
    PAGE_END            = 8'h03,        // 縦ラインの0~3終了ページ
    DUMMY               = 8'h00;        // ダミーデータ

localparam LENGTH = 2**ADDR_WIDTH;

// 初期設定コマンド配列
(* ram_style = "BLOCK" *) reg [7:0] oled_cmd_rom [LENGTH-1:0];

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

always @(posedge iCLK) begin
    odata <= oled_cmd_rom[iAddr];
end

endmodule