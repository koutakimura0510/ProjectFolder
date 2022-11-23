/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * ボード搭載DDR3メモリ、サンプル動作プロジェクト
 */
module main #(
    parameter SYSTEM_CLK = 2000000000
)(
    input           iCLK,   // system clk
    input           iRST,   // syste rst

    input           iBTNU,
    input           iBTND,

    // DDR3 Port
    output [14:0]   oDDR3_ADDR,     // row col Addr
    output [2:0]    oDDR3_BA,       // Bank Select
    output [1:0]    oDDR3_DM,       // Data Mask Write時にHighで書き込み停止
    inout  [15:0]   ioDDR3_DQ,      // Cmd Data byte
    output          oDDR3_CKE,      // CLK Enable Lowで停止
    output          oDDR3_ODT,      // High 終端抵抗が有効、終端と出力を同時に行えないため基本Lowにする
    output          oDDR3_RAS,      // Row Address Strobe:RAS
    output          oDDR3_CAS,      // Column Address Strobe:CAS
    output          oDDR3_WE,       // Write Enable
    output          oDDR3_RESET,    // System RST Lowで停止
    output          oDDR3_CLK_n,    // DDR3 System CLK
    output          oDDR3_CLK_p,    // DDR3 System CLK
    inout  [1:0]    ioDDR3_DQS_n,   // Read Write CLK
    inout  [1:0]    ioDDR3_DQS_p,   // Read Write CLK
    output [7:0]    oLED
);


assign rst  = ~iRST;
wire oBTNU;
wire oBTND;
wire oEnable5ms;

// clk wiz
wire oCLK_200MHZ;
wire locked;

//ddr3 data
wire [15:0] oDDR3_Rdata;    assign oLED = oDDR3_Rdata[7:0];


//----------------------------------------------------------
// DDR3 PLL CLK生成
//----------------------------------------------------------
clk_wiz_0 DDR3_CLK
(
    .clk_out1(oCLK_200MHZ),
    .reset(rst),
    .locked(locked),
    .clk_in1(iCLK)
);


//----------------------------------------------------------
// システムEnable信号の生成
//----------------------------------------------------------
enGen #(
    .SYSTEM_CLK(1000000000)
) EN_GEN (
    .iCLK(iCLK),
    .iRST(rst),
    .oEnable5ms(oEnable5ms)
);


//----------------------------------------------------------
// 動作確認用に書き込みボタンと読み込みボタンを設置
//----------------------------------------------------------
swGen SW_GENU (.iCLK(iCLK), .iEnable(oEnable5ms), .iBTN(iBTNU), .oBTN(oBTNU));
swGen SW_GEND (.iCLK(iCLK), .iEnable(oEnable5ms), .iBTN(iBTND), .oBTN(oBTND));


//----------------------------------------------------------
// DDR3メモリ動作
//----------------------------------------------------------
ddr3Top #(
    .SYSTEM_CLK(SYSTEM_CLK)
) DDR3_TOP (
    .iCLK(iCLK),
    .iPLLCLK(oCLK_200MHZ),
    .iRST(rst),
    .iBTNU(oBTNU),
    .iBTND(oBTND),
    .oDDR3_ADDR(oDDR3_ADDR),
    .oDDR3_BA(oDDR3_BA),
    .oDDR3_DM(oDDR3_DM),
    .ioDDR3_DQ(ioDDR3_DQ),
    .oDDR3_CKE(oDDR3_CKE),
    .oDDR3_ODT(oDDR3_ODT),
    .oDDR3_RAS(oDDR3_RAS),
    .oDDR3_CAS(oDDR3_CAS),
    .oDDR3_WE(oDDR3_WE),
    .oDDR3_RESET(oDDR3_RESET),
    .oDDR3_CLK_n(oDDR3_CLK_n),
    .oDDR3_CLK_p(oDDR3_CLK_p),
    .ioDDR3_DQS_n(ioDDR3_DQS_n),
    .ioDDR3_DQS_p(ioDDR3_DQS_p),
    .oDDR3_Rdata(oDDR3_Rdata)
);

endmodule