/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * FIFO <-> DDR3メモリコントローラ ブリッジモジュール
 */
module ddr3Bridge #(
    parameter ADDR_WIDTH = 29,
    parameter DATA_WIDTH = 128,
    parameter MASK_WIDTH = 16
)(
    input                   iCLK,           // system clk
    input                   iRST,           // reset High
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
    input                   iWEnable,           // user write enable data書き込み時 high
    input                   iREnable,           // user read enable data読み込み時high
    input  [DATA_WIDTH-1:0] iWdData,            // write data
    input  [ADDR_WIDTH-1:0] iAddr,              // access addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input  [MASK_WIDTH-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    output [DATA_WIDTH-1:0] oRdData,            // read data Rd Validのタイミングで出力
    output                  oRdDataValid,       // 読み込みデータ出力時High
    output                  oReady,             // MIG 動作可能時High
    output                  oWdReady,           // 書き込み 可能時High
    output                  oInitCalibComplete, // 初期化完了時High
    output                  oUiCLK,             // ddr memory user clk 100mhz
    output                  oUiRST              // ddr memory user rst High Active
);


wire ui_clk;    assign oUiCLK = ui_clk;
wire ui_rst;    assign oUiRST = ui_rst;


localparam BANK = 3'b000;
localparam ROW  = 15'b000000011000000;
localparam COL  = 10'b0000000000;

ddr3Controller #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .MASK_WIDTH(MASK_WIDTH)
) DDR3_CONTROLLER (
    .iCLK               (iCLK),
    .iRST               (iRST),
    .ioDDR3_DQ          (ddr3_dq),
    .ioDDR3_DQS_N       (ddr3_dqs_n),
    .ioDDR3_DQS_P       (ddr3_dqs_p),
    .oDDR3_ADDR         (ddr3_addr),
    .oDDR3_BA           (ddr3_ba),
    .oDDR3_RAS          (ddr3_ras_n),
    .oDDR3_CAS          (ddr3_cas_n),
    .oDDR3_WE           (ddr3_we_n),
    .oDDR3_RESET        (ddr3_reset_n),
    .oDDR3_CLK_P        (ddr3_ck_p),
    .oDDR3_CLK_N        (ddr3_ck_n),
    .oDDR3_CKE          (ddr3_cke),
    .oDDR3_DM           (ddr3_dm),
    .oDDR3_ODT          (ddr3_odt),
    .iWEnable           (iWEnable),
    .iREnable           (iREnable),
    .iWdData            (128'h00112233445566778899aabbccddeeff),
    .iAddr              ({1'b0, BANK, ROW, COL}),
    .iMask              (16'h0000),
    .oRdData            (oRdData),
    .oRdDataValid       (oRdDataValid),
    .oReady             (oReady),
    .oWdReady           (oWdReady),
    .oInitCalibComplete (oInitCalibComplete),
    .oUiCLK             (ui_clk),
    .oUiRST             (ui_rst)
);


endmodule