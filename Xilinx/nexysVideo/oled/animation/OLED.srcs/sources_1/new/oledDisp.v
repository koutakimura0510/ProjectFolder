/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの書き込みページコマンド設定Rom制御
 */
module oledDisp
#(
parameter DISPLAY_WIDTH  = 128, // 初期化Romサイズ
parameter DISPLAY_HEIGHT = 4    // 終了ページ
)(
input 			iCLK,		    // System Clock
input           iRST,           // active high
input           iSpiValid,      // 1byteデータ送信完了
input           iInitEnable,    // 初期化完了時High
input           iCmdEnable,     // コマンド送信完了時High
output [7:0]    oData           // 出力データ
);

// 描画データ出力
reg [7:0] odata;    assign oData = odata;


//----------------------------------------------------------
// 表示用文字列の設定
//----------------------------------------------------------
localparam STR1 = "  OLED.Project  ", str1len=16;
localparam STR2 = " Author  Kimura ", str2len=16;
localparam STR3 = " -~-~-~-~-~-~-~ ", str3len=16;
localparam STR4 = " 2021 - 12 - 22 ", str4len=16;


//----------------------------------------------------------
// fontファイルの設定、描画データが0xa1の場合、描画とbitの関係は下記の通りである
// 
// MSB Farst
// 0 - 1
// 1 - 0
// 2 - 0
// 3 - 0
// 4 - 0
// 5 - 1
// 6 - 0
// 7 - 1
//----------------------------------------------------------
localparam DATA_WIDTH = 8;
localparam ADDR_WIDTH = 1024;
localparam FILENAME   = "charLib.dat";

(* ram_style = "BLOCK" *) reg [7:0] font_rom [0:ADDR_WIDTH-1];
initial begin
    $readmemh(FILENAME, font_rom);
end

reg [9:0] r_font_addr;  // 文字列のアスキーコードからfontデータのアドレスを抽出
reg [2:0] addr_index;   // 文字列romのインデックス更新用
reg [3:0] str_count;    // 16文字の文字列カウント
reg [1:0] line;         // 描画行選択

//----------------------------------------------------------
// フレームバッファの確保、ダブルバッファを使用
//----------------------------------------------------------
localparam DISP_SIZE = (DISPLAY_WIDTH * DISPLAY_HEIGHT);
localparam DISP_LEN  = ((DISPLAY_WIDTH * DISPLAY_HEIGHT) - 1);

(* ram_style = "BLOCK" *) reg [7:0] frame_1 [0:DISP_SIZE-1];

// (* ram_style = "BLOCK" *) reg [7:0] frame2 [DISP_SIZE:0];
reg [9:0] w_frame_addr;
reg [9:0] r_frame_addr;

// 初期設定コマンド配列
// (* multstyle = "dsp" *) wire [17:0] res;


//----------------------------------------------------------
// font rom参照用アドレスの更新
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        addr_index <= 0;
    end else if (addr_index == 3'd7) begin
        addr_index <= 0;
    end else begin
        addr_index <= addr_index + 1'b1;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        str_count <= 0;
    end else if (addr_index == 3'd7) begin
        if (str_count == 4'd15) begin
            str_count <= 0;
        end else begin
            str_count <= str_count + 1'b1;
        end
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        line <= 0;
    end else if (addr_index == 3'd7 && str_count == 4'd15) begin
        if (line == 2'd3) begin
            line <= 0;
        end else begin
            line <= line + 1'b1;
        end
    end
end

always @(line or str_count or addr_index) begin
    case (line)
        0: r_font_addr <= ((8'hff & (STR1 >> ((str1len - 1 - str_count) << 3))) << 3) + addr_index;
        1: r_font_addr <= ((8'hff & (STR2 >> ((str2len - 1 - str_count) << 3))) << 3) + addr_index;
        2: r_font_addr <= ((8'hff & (STR3 >> ((str3len - 1 - str_count) << 3))) << 3) + addr_index;
        3: r_font_addr <= ((8'hff & (STR4 >> ((str4len - 1 - str_count) << 3))) << 3) + addr_index;
        default: r_font_addr <= 0;
    endcase
end


//----------------------------------------------------------
// フレームバッファ書き込み・読み込みアドレスの更新
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        r_frame_addr <= 0;
    end else if (iSpiValid == 1'b1 && iInitEnable == 1'b1 && iCmdEnable == 1'b1) begin
        if (r_frame_addr == DISP_LEN) begin
            r_frame_addr <= 0;
        end else begin
            r_frame_addr <= r_frame_addr + 1'b1;
        end
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        w_frame_addr <= 0;
    end else if (w_frame_addr == DISP_LEN) begin
        w_frame_addr <= 0;
    end else begin
        w_frame_addr <= w_frame_addr + 1'b1;
    end
end


//----------------------------------------------------------
// データ読み込み・書き込み動作
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        odata <= 0;
    end else begin
        frame_1[w_frame_addr] <= font_rom[r_font_addr];
        odata <= frame_1[r_frame_addr];
    end
end

endmodule