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
    // write side
    input  [pDramDataWidth-1:0] iWD,                // WriteData
    input  [pDramAddrWidth-1:0] iWA,                // Write Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWE,                // write enable信号
    output                      oWFLL,              // write fifo full signal

    // read data side
    output [pDramDataWidth-1:0] oRD,                // Pixel Read Data
    output                      oRDEMP,             // read fifo empty signal
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    input                       iRDE,               // read enable
    output                      oRDFLL,             // read data fifo fll

    // read addr side
    input  [pDramAddrWidth-1:0] iRA,                // Read Addr 28:0固定 / 27-25:Bank / 24-10:Row / 9-0:Col
    input                       iRAE,               // read addr enable
    output                      oRAFLL,             // read fifo full signal

    // user clk
    output                      oUICLK,             // user clk 100mhz
    output                      oUIRST,             // user rst Active High
);

////////////////////////////////////////////////////////////
wire wUiCLK;    assign oUICLK = wUiCLK;
wire wUiRST;    assign oUIRST = wUiRST;


// ddr memory 
wire oReady, oWdReady;
wire oRdData, oRdDataValid;

// wr state
reg rFifoRE, rFifoWE;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 読み込みデータ・アドレス保存バッファ
// 読み込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
wire wRAD, wRaVd;
wire wRaEmp;
wire wRdFll, wRaFll;
reg  qArReady;
reg  qRaED;

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_READ_DATA (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (oRdData),      .oRD    (oRD),
    .iWE    (oRdDataValid), .iRE    (iRDE),
    .oFLL   (wRdFll),       .oEMP   (oRDEMP),
                            .oRVD   (oRVD)
);

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_READ_ADDR (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (iRA),          .oRD    (wRAD),
    .iWE    (iRAE),         .iRE    (qRaED),
    .oFLL   (oRAFLL),       .oEMP   (wRaEmp),
                            .oRVD   (wRaVd)
);

always @*
begin
    qRaED       <= rFifoRE;   // read start
    qArReady    <= (~wRaEmp) & wRaVd; // ddr enable ready
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 書き込みデータ・アドレス保存バッファ
// 書き込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
wire wWdFll, wWaFll;    assign oWFLL = wWdFll | wWaFll;
reg  qWE, qWED;         // write read enable
reg  qwReady;           // ddr write enable
wire oRwdVD, oRwaVD;    // データ出力時High
wire wWdEmp, wWaEmp;
wire [pBitDepth-1:0] wFifoWd, wFifoAd;

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_WRITE_DATA (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (iWD),          .oRD    (wFifoWd),
    .iWE    (qWE),          .iRE    (qWED),
    .oFLL   (wWdFll),       .oEMP   (wWdEmp),
                            .oRVD   (oRwdVD)
);

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_WRITE_ADDR (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (iWA),          .oRD    (wFifoAd),
    .iWE    (qWE),          .iRE    (qWED),
    .oFLL   (wWaFll),       .oEMP   (wWaEmp),
                            .oRVD   (oRwaVD)
);

always @*
begin
    qWE      <= iWE;
    qWED     <= rFifoWE;
    qwReady  <= (~wWdEmp) & (~wWaEmp) & oRwdVD & oRwaVD;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 書き込みと読み込みの優先度を交互に切り替える回路
// データと同期させるため、FIFOのready信号を受信し、ステートマシン内で
// クロックと同期したDDRモジュールに接続するready信号を生成する
//----------------------------------------------------------
localparam [0:0] 
    pWriteAhead = 0,
    pReadAhead  = 1;

reg rWRahead;                   // 優先度切り替えステートマシン
reg rWready, rRready;           // 同期ready
reg [pBitDepth-1:0] rWd, rWa;   // データとアドレス

always @(posedge iCLK)
begin
    if (iRST)
    begin
        rWRahead           <= pWriteAhead;
        {rFifoWE, rFifoRE} <= 2'b00;
        {rWready, rRready} <= 2'b00;
        {rWd, rWa}         <= 0;
    end
    else
    begin
        case (rWRahead)
        pWriteAhead:
        begin
            if (oWdReady)
            begin
                rWRahead <= pReadAhead;
                
            end
            else if (oReady)
            begin
                rWRahead <= pWriteAhead;

            end
            else
            begin
                rWRahead <= pWriteAhead;

            end
        end

        pReadAhead:
        begin
            if (oReady)
            begin
                rWRahead           <= (qArReady) ? pWriteAhead : pReadAhead;
                {rFifoWE, rFifoRE} <= 2'b01;
                rWa <= wRAD;
            end
            else if (oWdReady)
            begin
                rWRahead           <= (qwReady) ? pReadAhead : pWriteAhead;
                {rFifoWE, rFifoRE} <= 2'b10;
                {rWd, rWa}         <= {wFifoWd, wFifoAd};
            end
            else
            begin
                rWRahead <= pReadAhead;
                {rFifoWE, rFifoRE} <= 2'b00;
                {rWd, rWa}         <= 0;
            end
        end

        default:
        begin
            rWRahead <= pWriteAhead;
        end
        endcase
    end
end


////////////////////////////////////////////////////////////
ddr3Controller #(
    .pDramAddrWidth(pDramAddrWidth),
    .pDramDataWidth(pDramDataWidth),
    .pDramMaskWidth(pDramMaskWidth)
) DDR3_CONTROLLER (
    // DDR port                             hand shake
    .ioDDR3_DQ          (ioDDR3_DQ),        .iWEnable           (rFifoWE),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),     .iREnable           (rFifoRE),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),     .iWdData            (rWd),
    .oDDR3_ADDR         (oDDR3_ADDR),       .iAddr              (rWa),
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