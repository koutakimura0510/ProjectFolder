//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFO <-> DDR3メモリコントローラ ブリッジモジュール
// 
// 受信データと送信データをそれぞれ保存しておくFIFOを用意し、
// DDR3メモリの送受信データの管理を行う。
// 受信・送信ともにEmpty Full信号で制御を行う。
// 
// FIFOは2系統のCLKで動作する。システムクロックとDDRモジュールから生成されるユーザーインターフェースCLKの2つ。
// 非同期で動作するモジュール間を結合、動作させるため、ブリッジモジュールを作成した。
//----------------------------------------------------------
module ddr3Bridge #(
    parameter ADDR_WIDTH = 29,
    parameter DATA_WIDTH = 128,
    parameter MASK_WIDTH = 16
)(
    input                   iCLK,           // system clk
    input                   iRST,           // reset High

    // DDRメモリ制御GPIO
    inout  [15:0]           ioDDR3_DQ,      // ddr portはtopモジュールから接続
    inout  [ 1:0]           ioDDR3_DQS_N,
    inout  [ 1:0]           ioDDR3_DQS_P,
    output [14:0]           oDDR3_ADDR,
    output [ 2:0]           oDDR3_BA,
    output                  oDDR3_RAS,
    output                  oDDR3_CAS,
    output                  oDDR3_WE,
    output                  oDDR3_RESET,
    output                  oDDR3_CLK_P,
    output                  oDDR3_CLK_N,
    output                  oDDR3_CKE,
    output [ 1:0]           oDDR3_DM,
    output                  oDDR3_ODT,

    // インターフェース制御信号一覧
    input  [DATA_WIDTH-1:0] iWD,                // WriteData
    input  [ADDR_WIDTH-1:0] iWA,                // Write Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input  [MASK_WIDTH-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                   iWE,                // write enable信号
    output                  oWFLL,              // write fifo full signal
    output [DATA_WIDTH-1:0] oRD,                // Read Data
    input  [ADDR_WIDTH-1:0] iRA,                // Read Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    output                  oRDV,               // 有効データ出力時High Read Data Valid
    output                  oRFLL,              // read fifo full signal
    output                  oUICLK,             // user clk 100mhz
    output                  oUIRST,             // user rst Active High
);

// 非同期fifo制御
// 受信・送信用それぞれ用意しておく、read writeに必要なデータはデータとアドレスなので
// それぞれ下記のバッファが必要である
// 読み込みデータ保存FIFO
// 読み込みアドレス保存FIFO
// 書き込みデータ保存FIFO
// 書き込みアドレス保存FIFOが必要である
//
// 例えば書き込みデータが残っている場合は、iWEnable信号はこのモジュール内で生成することができる
// 上の階層のモジュールはEMPとFull信号のみ確認すればよいだけなので、制御しやすくなる
// このモジュール内で流れてくるデータを制御すればよい

wire ui_clk;    assign oUICLK = ui_clk;
wire ui_rst;    assign oUIRST = ui_rst;

ddr3Controller #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .MASK_WIDTH(MASK_WIDTH)
) DDR3_CONTROLLER (
    .iCLK               (iCLK),
    .iRST               (iRST),
    .ioDDR3_DQ          (ioDDR3_DQ),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),
    .oDDR3_ADDR         (oDDR3_ADDR),
    .oDDR3_BA           (oDDR3_BA),
    .oDDR3_RAS          (oDDR3_RAS),
    .oDDR3_CAS          (oDDR3_CAS),
    .oDDR3_WE           (oDDR3_WE),
    .oDDR3_RESET        (oDDR3_RESET),
    .oDDR3_CLK_P        (oDDR3_CLK_P),
    .oDDR3_CLK_N        (oDDR3_CLK_N),
    .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),
    .oDDR3_ODT          (oDDR3_ODT),
    .iWEnable           (iWEnable),
    .iREnable           (iREnable),
    .iWdData            (iWdData),
    .iAddr              (iAddr),
    .iMask              (16'h0000),
    .oRdData            (oRdData),
    .oRdDataValid       (oRdDataValid),
    .oReady             (oReady),
    .oWdReady           (oWdReady),
    .oInitCalibComplete (oInitCalibComplete),
    .oUiCLK             (ui_clk),
    .oUiRST             (ui_rst)
);

always @*
begin
    
end

endmodule