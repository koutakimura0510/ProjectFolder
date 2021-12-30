/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ制御 トップモジュール
 */
module ddr3Top #(
    parameter ADDR_WIDTH = 28,
    parameter DATA_WIDTH = 128,
    parameter MASK_WIDTH = 16
)(
    input           iCLK,           // system clk
    input           iRST,           // reset High
    inout  [15:0]   ioDDR3_DQ,
    inout  [ 1:0]   ioDDR3_DQS_N,
    inout  [ 1:0]   ioDDR3_DQS_P,
    output [14:0]   oDDR3_ADDR,
    output [ 2:0]   oDDR3_BA
    output          oDDR3_RAS,
    output          oDDR3_CAS,
    output          oDDR3_WE,
    output          oDDR3_RESET,
    output          oDDR3_CLK_P,
    output          oDDR3_CLK_N,
    output          oDDR3_CKE,
    output [ 1:0]   oDDR3_DM,
    output          oDDR3_ODT,
    input           iWEnable,           // user write enable
    input           iREnable,           // user read enable
    input  [15:0]   iWdData,            // write data
    input  [14:0]   iAddr,              // access addr
    input  [15:0]   iMask,              // write mask
    output [15:0]   oRdData,            // read data
    output          oRdDataValid,       // 読み込みデータ出力時High
    output          oReady,             // MIG 動作可能時High
    output          oWdReady,           // 書き込み 可能時High
    output          oInitCalibComplete, // 初期化完了時High
);


// user design
wire ui_clk;
wire ui_clk_sync_rst;

// mig signal 
wire [ADDR_WIDTH-1:0] o_app_addr;
wire [2:0] o_app_cmd;
wire o_app_enable;
wire [DATA_WIDTH-1:0] o_app_wdf_data;
wire o_app_wdf_wren;
wire [MASK_WIDTH-1:0] o_app_wdf_mask;
wire [DATA_WIDTH-1:0] i_app_rd_data;
wire i_app_rd_data_valid;
wire i_app_ready;
wire i_app_wdf_ready;
wire i_initcalibcomplete;


// clk wiz
wire o_DDR3_200mhz;
wire o_DDR3_100mhz;
wire locked;

clk_wiz_0 DDR3_CLK (
    .clk_out1(o_DDR3_200mhz),
    .clk_out2(o_DDR3_100mhz),
    .reset(iRST),
    .locked(locked),
    .clk_in1(iCLK)
);

migController MIG_CONTROLLER
#(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .MASK_WIDTH(MASK_WIDTH)
)(
    .iCLK                   (ui_clk),
    .iRST                   (ui_clk_sync_rst),
    .iWEnable               (iWEnable),
    .iREnable               (iREnable),
    .iAddr                  (iAddr),
    .iWdData                (iWdData),
    .iMask                  (iMask),
    .oRdData                (oRdData),
    .oRdDataValid           (oRdDataValid),
    .oReady                 (oReady),
    .oWdReady               (oWdReady),
    .oInitCalibComplete     (oInitCalibComplete),
    .oAppAddr               (o_app_addr),
    .oAppCmd                (o_app_cmd),
    .oAppEnable             (o_app_enable),
    .oAppWdfData            (o_app_wdf_data),
    .oAppWdfWren            (o_app_wdf_wren),
    .oAppWdfMask            (o_app_wdf_mask),
    .iAppRdData             (i_app_rd_data),
    .iAppRdDataValid        (i_app_rd_data_valid),
    .iAppReady              (i_app_ready),
    .iAppWdfReady           (i_app_wdf_ready),
    .iInitCalibComplete     (i_initcalibcomplete)
);

mig_7series_0 MIG (
    //DDR3 port
    .ddr3_addr              (oDDR3_ADDR),
    .ddr3_ba                (oDDR3_BA),
    .ddr3_cas_n             (oDDR3_CAS),
    .ddr3_ck_n              (oDDR3_CLK_N),
    .ddr3_ck_p              (oDDR3_CLK_P),
    .ddr3_cke               (oDDR3_CKE),
    .ddr3_ras_n             (oDDR3_RAS),
    .ddr3_reset_n           (oDDR3_RESET),
    .ddr3_we_n              (oDDR3_WE),
    .ddr3_dq                (ioDDR3_DQ),
    .ddr3_dqs_n             (ioDDR3_DQS_N),
    .ddr3_dqs_p             (ioDDR3_DQS_P),
    .ddr3_dm                (oDDR3_DM),
    .ddr3_odt               (oDDR3_ODT),
    .init_calib_complete    (i_initcalibcomplete),          // output init_calib_complete High Out

    // Application interface ports
    .app_addr                       (o_app_addr),           // input [28:0]		addr[28:3] / Bank[2:0]
    .app_cmd                        (o_app_cmd),            // input [2:0]		Write 000 / Read 001
    .app_en                         (o_app_enable),         // input			ユーザー側がapp_cmd有効時にHighにする
    .app_wdf_data                   (o_app_wdf_data),       // input [127:0]	書き込みデータ 16bit x 8byte
    .app_wdf_end                    (o_app_wdf_wren),       // input			下記のwrite enable信号と同期させる
    .app_wdf_wren                   (o_app_wdf_wren),       // input			write enable
    .app_wdf_rdy                    (i_app_wdf_ready),      // output			データ書き込み可能時High
    .app_wdf_mask                   (o_app_wdf_mask),       // input [15:0]		各bitに1が立っていたら対応したbyteは書き込まれない
    .app_rd_data                    (i_app_rd_data),        // output [127:0]	読み込みデータ 16bit x 8byte
    .app_rd_data_end                (),                     // output			
    .app_rd_data_valid              (i_app_rd_data_valid),  // output			読み込みデータ出力開始時High
    .app_rdy                        (i_app_ready),          // output			データ読み込み可能時High
    .app_sr_req                     (1'b0),                 // input			
    .app_ref_req                    (1'b0),                 // input			
    .app_zq_req                     (1'b0),                 // input			
    .app_sr_active                  (),                     // output			
    .app_ref_ack                    (),                     // output			
    .app_zq_ack                     (),                     // output			
    .ui_clk                         (ui_clk),               // output			MIGと同期のユーザーインターフェースCLK
    .ui_clk_sync_rst                (ui_clk_sync_rst),      // output			ユーザーインターフェースリセット信号

    // System Clock Ports 100MHz
    .sys_clk_i                      (o_DDR3_100mhz),

    // Reference Clock Ports 200MHz rst Active High
    .clk_ref_i                      (o_DDR3_200mhz),
    .sys_rst                        (iRST)               // input sys_rst
);

endmodule