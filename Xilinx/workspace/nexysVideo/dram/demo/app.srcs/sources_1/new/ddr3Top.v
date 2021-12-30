/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリトップモジュール
 */
module ddr3Top #(
    parameter SYSTEM_CLK = 1000000000
)(
    input           iCLK,           // system clk
    input           iPLLCLK,
    input           iRST,           // syste rst

    input           iBTNU,
    input           iBTND,

    // DDR3 Port
    output [14:0]   oDDR3_ADDR,     // row col Addr
    output [2:0]    oDDR3_BA,       // Bank Select
    output [1:0]    oDDR3_DM,       // Data Mask Write時にHighで書き込み停止、それぞれ上位下位8bitに対応
    inout  [15:0]   ioDDR3_DQ,      // Cmd Data byte
    output          oDDR3_CKE,      // CLK Enable Lowで停止
    output          oDDR3_ODT,      // High 終端抵抗が有効、終端と出力を同時に行えないため基本Lowにする
    output          oDDR3_RAS,      // Row Address Strobe:RAS
    output          oDDR3_CAS,      // Column Address Strobe:CAS
    output          oDDR3_WE,       // Write Enable
    output          oDDR3_RESET,    // System RST Lowで停止
    output          oDDR3_CLK_n,    // DDR3 System CLK
    output          oDDR3_CLK_p,    // DDR3 System CLK
    inout  [1:0]    ioDDR3_DQS_n,   // Read Write CLK それぞれ上位下位8bitに対応
    inout  [1:0]    ioDDR3_DQS_p,   // Read Write CLK それぞれ上位下位8bitに対応

    // データ出力
    output [15:0]   oDDR3_Rdata
);


// timing enable
wire oEnable1us;

// コマンドデータ
wire [19:0] oDDR3_InitAddr;
wire [2:0]  oDDR3_InitBank;
wire [19:0] oDDR3_SendAddr;
wire [2:0]  oDDR3_SendBank;

wire [15:0] iDDR3_Wdata;

// モード制御
wire oInitEnable;
wire iActiveEnable;
wire iWriteEnable;
wire iReadEnable;
wire oWRComplete;
wire [3:0] oDDR3_Mode;


//----------------------------------------------------------
// 指定タイミングのEnable信号出力
//----------------------------------------------------------
ddr3Enable #(
    .SYSTEM_CLK(SYSTEM_CLK)
) DDR3_ENABLE (
    .iCLK(iPLLCLK),
    .iRST(iRST),
    .oEnable1us(oEnable1us)
);


//----------------------------------------------------------
// 初期化モジュール
//----------------------------------------------------------
ddr3Init DDR3_INIT (
    .iCLK(iPLLCLK),
    .iRST(iRST),
    .iEnable1us(oEnable1us),
    .oInitEnable(oInitEnable),
    .oDDR3_InitAddr(oDDR3_InitAddr),
    .oDDR3_InitBank(oDDR3_InitBank)
);


//----------------------------------------------------------
// モード管理
//----------------------------------------------------------
ddr3Mode DDR3_MODE (
    // .iCLK(iCLK),
    .iCLK(iPLLCLK),
    .iRST(iRST),
    .iInitEnable(oInitEnable),
    .iActiveEnable(1'b1),
    .iWriteEnable(iBTNU),
    .iReadEnable(iBTND),
    .iWRComplete(oWRComplete),
    .oDDR3_Mode(oDDR3_Mode)
);


//----------------------------------------------------------
// 送信コマンドデータ管理
//----------------------------------------------------------
ddr3Send DDR3_SEND (
    .iDDR3_Mode(oDDR3_Mode),
    .iDDR3_InitAddr(oDDR3_InitAddr),
    .iDDR3_InitBank(oDDR3_InitBank),
    .iDDR3_CmdAddr(20'b1101_1000_0000_0000_0000),
    .iDDR3_CmdBank(3'b000),
    .iDDR3_WAddr(20'b1110_0000_1000_0000_0000),
    .iDDR3_WBank(3'b000),
    .iDDR3_RAddr(20'b1110_1000_1000_0000_0000),
    .iDDR3_RBank(3'b000),
    .oDDR3_Addr(oDDR3_SendAddr),
    .oDDR3_Bank(oDDR3_SendBank)
);


//----------------------------------------------------------
// DDR3 Portブリッジ接続
//----------------------------------------------------------
ddr3Bridge DDR3_BRIDGE (
    .iCLK(iCLK),
    .iPLLCLK(iPLLCLK),
    .iRST(iRST),
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
    .iDDR3_Mode(oDDR3_Mode),
    .iDDR3_Addr(oDDR3_SendAddr),
    .iDDR3_Bank(oDDR3_SendBank),
    .iDDR3_Wdata(iDDR3_Wdata),
    .oDDR3_Rdata(oDDR3_Rdata),
    .oWRComplete(oWRComplete)
);


endmodule