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
module ddr3TB;

reg btnU = 1;
reg btnD = 1;
reg iCLK = 0;
reg iRST = 0;
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
main #(
    .SYSTEM_CLK(2000000)
) MAIN (
    .iCLK(iCLK),
    .iRST(iRST),
    .iBTNU(btnU),
    .iBTND(btnD),
    .oDDR3_ADDR(ADDR),
    .oDDR3_BA(BA),
    .oDDR3_DM(DM),
    .ioDDR3_DQ(DQ),
    .oDDR3_CKE(CKE),
    .oDDR3_ODT(ODT),
    .oDDR3_RAS(RAS),
    .oDDR3_CAS(CAS),
    .oDDR3_WE(WE),
    .oDDR3_RESET(RESET),
    .oDDR3_CLK_n(CLK_N),
    .oDDR3_CLK_p(CLK_P),
    .ioDDR3_DQS_n(DQS_N),
    .ioDDR3_DQS_p(DQS_P)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 4 * 30);
    btnD = 0;
    #(CYCLE * 4 * 100);
    $stop;
end

endmodule
