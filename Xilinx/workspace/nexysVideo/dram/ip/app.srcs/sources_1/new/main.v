/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * MIG IP動作確認プロジェクト Topモジュール
 */
module main(
    input           iCLK,
    input           iRST,
    
    // user btn
    input           iBtnU,
    input           iBtnD,

    // ddr3 port
    inout  [15:0]   ddr3_dq,
    inout  [ 1:0]   ddr3_dqs_n,
    inout  [ 1:0]   ddr3_dqs_p,
    output [14:0]   ddr3_addr,
    output [ 2:0]   ddr3_ba,
    output          ddr3_ras_n,
    output          ddr3_cas_n,
    output          ddr3_we_n,
    output          ddr3_reset_n,
    output [0:0]    ddr3_ck_p,
    output [0:0]    ddr3_ck_n,
    output [0:0]    ddr3_cke,
    output [1:0]    ddr3_dm,
    output [0:0]    ddr3_odt,

    // user led
    output [ 7:0]   oLED
);

assign rst = ~iRST;


ddr3Top DDR3_TOP 
#(
    .ADDR_WIDTH(28),
    .DATA_WIDTH(128),
    .MASK_WIDTH(16)
)(
    .iCLK               (iCLK),
    .iRST               (rst),
    .ioDDR3_DQ          (),
    .ioDDR3_DQS_N       (),
    .ioDDR3_DQS_P       (),
    .oDDR3_ADDR         (),
    .oDDR3_BA           (),
    .oDDR3_RAS          (),
    .oDDR3_CAS          (),
    .oDDR3_WE           (),
    .oDDR3_RESET        (),
    .oDDR3_CLK_P        (),
    .oDDR3_CLK_N        (),
    .oDDR3_CKE          (),
    .oDDR3_DM           (),
    .oDDR3_ODT          (),
    .iWEnable           (),
    .iREnable           (),
    .iWdData            (),
    .iAddr              (),
    .iMask              (),
    .oRdData            (),
    .oRdDataValid       (),
    .oReady             (),
    .oWdReady           (),
    .oInitCalibComplete ()
);


endmodule