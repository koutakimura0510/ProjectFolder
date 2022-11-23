`timescale 1ns / 1ps

/*
 * Create 2021/12/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3テストベンチ
 */
module tb;

reg btnU = 1;
reg btnD = 1;
reg iCLK = 0;
reg iRST = 0;
reg rs   = 0;
reg [15:0] io_dq  = 16'hzzzz;
reg [1:0] io_dqsp = 2'bzz;
reg [1:0] io_dqsn = 2'bzz;
wire [14:0] ADDR;
wire [2:0] BA;
wire [1:0] DM;
wire [15:0] DQ;
wire CKE;
wire ODT;
wire RAS;
wire CAS;
wire WE;
wire RESET;
wire CLK_N;
wire CLK_P;
wire [1:0] DQS_N;
wire [1:0] DQS_P;
wire [7:0] led;
wire oOledScl;
wire oOledSda;
wire oOledDC;
wire oOledRes;
wire oOledVbat;
wire oOledVdd;



//----------------------------------------------------------
// clk 速度
//----------------------------------------------------------
parameter CYCLE = 2;


//----------------------------------------------------------
// inout port設定
// read時は1'bzにする
//----------------------------------------------------------
assign DQ    = io_dq;
assign DQS_N = io_dqsp;
assign DQS_P = io_dqsn;

//----------------------------------------------------------
// DDR3 Top module接続
//----------------------------------------------------------
main MAIN (
    .iCLK(iCLK),
    .iRST(iRST),
    .iBtnU(btnU),
    .iBtnD(btnD),
    .ddr3_dq(DQ),
    .ddr3_dqs_n(DQS_P),
    .ddr3_dqs_p(DQS_N),
    .ddr3_addr(ADDR),
    .ddr3_ba(BA),
    .ddr3_ras_n(RAS),
    .ddr3_cas_n(CAS),
    .ddr3_we_n(WE),
    .ddr3_reset_n(RESET),
    .ddr3_ck_p(CLK_P),
    .ddr3_ck_n(CLK_N),
    .ddr3_cke(CKE),
    .ddr3_dm(DM),
    .ddr3_odt(ODT),
    .oOledScl(oOledScl),
    .oOledSda(oOledSda),
    .oOledDC(oOledDC),
    .oOledRes(oOledRes),
    .oOledVbat(oOledVbat),
    .oOledVdd(oOledVdd),
    .oLED(led)
);

// wire us;
// Top #(
//     .DDR3_DQ_WIDTH(16),
//     .DDR3_DQS_WIDTH(2),
//     .DDR3_ADDR_WIDTH(14),
//     .DDR3_BA_WIDTH(3),
//     .DDR3_DM_WIDTH(2),
//     .APP_ADDR_WIDTH(28),
//     .APP_CMD_WIDTH(3),
//     .APP_DATA_WIDTH(128),
//     .APP_MASK_WIDTH(16)
// ) top (
//     .clk_in(iCLK),
//     .rstx_in(rs),
//     .ddr3_dq(DQ),
//     .ddr3_dqs_n(DQS_P),
//     .ddr3_dqs_p(DQS_N),
//     .ddr3_addr(ADDR),
//     .ddr3_ba(BA),
//     .ddr3_ras_n(RAS),
//     .ddr3_cas_n(CAS),
//     .ddr3_we_n(WE),
//     .ddr3_reset_n(RESET),
//     .ddr3_ck_p(CLK_P),
//     .ddr3_ck_n(CLK_N),
//     .ddr3_cke(CKE),
//     .ddr3_dm(DM),
//     .ddr3_odt(ODT),
//     .uart_txd(us)
// );

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    #(CYCLE * 2);
    // #(CYCLE * 4 * 30);
    iRST = 1;
    rs   = 1;
    #(CYCLE * 4 * 30);
    $stop;
end

endmodule
