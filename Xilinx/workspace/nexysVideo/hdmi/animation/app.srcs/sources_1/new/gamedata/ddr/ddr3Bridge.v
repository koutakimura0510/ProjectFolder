//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFO <-> DDR3メモリコントローラ ブリッジモジュール
// 
// 受信データと送信データをそれぞれ保存しておくFIFOを用意し、DDR3メモリの送受信データの管理を行う。
// 受信・送信ともにEmpty Full信号で制御を行う。
//
// 受信・送信用それぞれ用意しておく、read writeに必要な要素はデータとアドレスなので
// それぞれ下記のバッファが必要である
// 読み込みデータ保存FIFO
// 読み込みアドレス保存FIFO
// 書き込みデータ保存FIFO
// 書き込みアドレス保存FIFOが必要である
//----------------------------------------------------------
module ddr3Bridge #(
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitDepth      = 32           // data bit
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
    input  [pDramDataWidth-1:0] iWD,                // WriteData
    input  [pDramAddrWidth-1:0] iWA,                // Write Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWE,                // write enable信号
    output                      oWFLL,              // write fifo full signal
    output [pDramDataWidth-1:0] oRD,                // Read Data
    input  [pDramAddrWidth-1:0] iRA,                // Read Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    output                      oRFLL,              // read fifo full signal
    output                      oUICLK,             // user clk 100mhz
    output                      oUIRST,             // user rst Active High
);

////////////////////////////////////////////////////////////
wire wUiCLK;    assign oUICLK = wUiCLK;
wire wUiRST;    assign oUIRST = wUiRST;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 読み込みデータ・アドレス保存バッファ
// 読み込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_READ_DATA (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (),             .oRD    (),
    .iWE    (),             .iRE    (),
    .oFLL   (),             .oEMP   (),
                            .oRVD   ()
);

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_READ_ADDR (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (),             .oRD    (),
    .iWE    (),             .iRE    (),
    .oFLL   (),             .oEMP   (),
                            .oRVD   ()
);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 書き込みデータ・アドレス保存バッファ
// 書き込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_WRITE_DATA (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (),             .oRD    (),
    .iWE    (),             .iRE    (),
    .oFLL   (),             .oEMP   (),
                            .oRVD   ()
);

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_WRITE_ADDR (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (),             .oRD    (),
    .iWE    (),             .iRE    (),
    .oFLL   (),             .oEMP   (),
                            .oRVD   ()
);

////////////////////////////////////////////////////////////
ddr3Controller #(
    .pDramAddrWidth(pDramAddrWidth),
    .pDramDataWidth(pDramDataWidth),
    .pDramMaskWidth(pDramMaskWidth)
) DDR3_CONTROLLER (
    // DDR port                             hand shake
    .ioDDR3_DQ          (ioDDR3_DQ),        .iWEnable           (iWEnable),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),     .iREnable           (iREnable),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),     .iWdData            (iWdData),
    .oDDR3_ADDR         (oDDR3_ADDR),       .iAddr              (iAddr),
    .oDDR3_BA           (oDDR3_BA),         .iMask              (16'h0000),
    .oDDR3_RAS          (oDDR3_RAS),        .oRdData            (oRdData),
    .oDDR3_CAS          (oDDR3_CAS),        .oRdDataValid       (oRdDataValid),
    .oDDR3_WE           (oDDR3_WE),         .oReady             (oReady),
    .oDDR3_RESET        (oDDR3_RESET),      .oWdReady           (oWdReady),
    .oDDR3_CLK_P        (oDDR3_CLK_P),      .oInitCalibComplete (oInitCalibComplete),
    .oDDR3_CLK_N        (oDDR3_CLK_N),
    .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),
    .oDDR3_ODT          (oDDR3_ODT),

    // user interface clk rst
    .iCLK               (iCLK),             .iRST               (iRST),
    .oUiCLK             (wUiCLK),           .oUiRST             (wUiRST)
);

endmodule