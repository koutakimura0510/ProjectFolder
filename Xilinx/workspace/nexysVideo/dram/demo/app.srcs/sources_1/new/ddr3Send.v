/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3のモードに対応したコマンドデータを管理するモジュール
 */
module ddr3Send (
    input  [ 3:0]   iDDR3_Mode,
    input  [19:0]   iDDR3_InitAddr, // 初期設定時のコマンドデータ
    input  [ 2:0]   iDDR3_InitBank, // 同上
    input  [19:0]   iDDR3_CmdAddr,  // コマンド実行時のコマンドデータ
    input  [ 2:0]   iDDR3_CmdBank,  // 同上
    input  [19:0]   iDDR3_WAddr,    // write時のアドレス指定
    input  [ 2:0]   iDDR3_WBank,
    input  [19:0]   iDDR3_RAddr,
    input  [ 2:0]   iDDR3_RBank,
    output [19:0]   oDDR3_Addr,
    output [ 2:0]   oDDR3_Bank
);


//----------------------------------------------------------
// DDR3動作ステートマシン
//----------------------------------------------------------
localparam [3:0]
    DDR3_INIT   = 0,    // 初期化ステート
    DDR3_IDLE   = 1,    // アイドル
    DDR3_ACTIVE = 2,    // アクティブコマンド発行
    DDR3_WRITE  = 3,    // 書き込みコマンド発行
    DDR3_READ   = 4,    // 読み込みコマンド発行
    DDR3_PREA   = 5;    // プリチャージコマンド発行


//----------------------------------------------------------
// 現在の状況に応じて出力データを制御する
//----------------------------------------------------------
reg [19:0] ddr3_addr;       assign oDDR3_Addr = ddr3_addr;
reg [ 2:0] ddr3_bank;       assign oDDR3_Bank = ddr3_bank;


//----------------------------------------------------------
// 状態制御ステートマシン
// 連続送信やバンク切り替え制御などが必要だが、とりあえず動作確認したいため保留
//----------------------------------------------------------
always @(iDDR3_Mode or iDDR3_InitAddr or iDDR3_InitBank or
        iDDR3_CmdAddr or iDDR3_CmdBank or 
        iDDR3_WAddr or iDDR3_WBank or iDDR3_RAddr or iDDR3_RBank) begin
    case (iDDR3_Mode)
        DDR3_INIT: begin
            ddr3_addr <= iDDR3_InitAddr;
            ddr3_bank <= iDDR3_InitBank;
        end

        DDR3_IDLE: begin
            ddr3_addr <= iDDR3_CmdAddr;
            ddr3_bank <= iDDR3_CmdBank;
        end

        DDR3_ACTIVE: begin
            ddr3_addr <= iDDR3_CmdAddr;
            ddr3_bank <= iDDR3_CmdBank;
        end

        DDR3_WRITE: begin
            ddr3_addr <= iDDR3_WAddr;
            ddr3_bank <= iDDR3_WBank;
        end

        DDR3_READ: begin
            ddr3_addr <= iDDR3_RAddr;
            ddr3_bank <= iDDR3_RBank;
        end

        DDR3_PREA: begin
            ddr3_addr <= iDDR3_CmdAddr;
            ddr3_bank <= iDDR3_CmdBank;
        end

        default: begin
            ddr3_addr <= iDDR3_CmdAddr;
            ddr3_bank <= iDDR3_CmdBank;
        end
    endcase
end

endmodule