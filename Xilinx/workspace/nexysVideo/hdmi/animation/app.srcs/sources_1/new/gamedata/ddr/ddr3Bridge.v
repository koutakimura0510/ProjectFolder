//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// User Interface module <-> DDR3 Memory Controller Bridge module
// 
// ユーザーインタフェースとDDR3メモリの送受信データの管理を行う。
// RW sideはそれぞれ独立していて、RWのHand.Shakeを利用し、上位モジュールがこのモジュールの動作を管理する
// RWアドレスを指定するiWAとiRAは本来であればpDramAddrWidthのサイズだが、
// モジュール内で確保しているFIFOのBitsizeが32bitなため、32bitで定義している
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
    input  [pBitDepth-1:0]      iWD,                // WriteData
    input  [pBitDepth-1:0]      iWA,                // Write Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWE,                // write enable信号
    output                      oWFLL,              // write fifo full signal

    // read data side
    output [pBitDepth-1:0]      oRD,                // Pixel Read Data
    output                      oRDEMP,             // read fifo empty signal
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    input                       iRDE,               // read enable

    // read addr side
    input  [pBitDepth-1:0]      iRA,                // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRAE,               // read addr enable
    output                      oRAFLL,             // read fifo full signal

    // user clk
    output                      oUiCLK,             // user clk 100mhz
    output                      oUiRST,             // user rst Active High
    output                      oInitCalibComplete
);

////////////////////////////////////////////////////////////
wire wUiCLK;    assign oUiCLK = wUiCLK;
wire wUiRST;    assign oUiRST = wUiRST;


// wr state
reg rFifoRE, rFifoWE;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 読み込みデータ・アドレス保存バッファ
// 読み込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
// ddr side
wire [pDramDataWidth-1:0] oRdData;  // ddrの読み込み時のデータ
wire oRdDataValid;                  // ddrデータ読み込み時High

// fifo side
wire [pBitDepth-1:0] wFifoRad;      // 読み込みアドレスをddrに出力
wire wRaVd;
wire wRaEmp;
wire wRdFll;
reg  qArEMP;
reg  qRaED;

fifoController #(
    .pBuffDepth (pBuffDepth),
    .pBitWidth  (pBitDepth)
) FIFO_READ_DATA (
    // write side           read side
    .iCLK   (wUiCLK),       .iRST   (wUiRST),
    .iWD    (oRdData[31:0]),.oRD    (oRD),
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
    .iWD    (iRA),          .oRD    (wFifoRad),
    .iWE    (iRAE),         .iRE    (qRaED),
    .oFLL   (oRAFLL),       .oEMP   (wRaEmp),
                            .oRVD   (wRaVd)
);

always @*
begin
    qRaED  <= rFifoRE & (~wRdFll); // read start
    qArEMP <= (~wRaEmp);   // ddr enable ready
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 書き込みデータ・アドレス保存バッファ
// 書き込みデータとアドレス参照のインデックスは一致していなければならない
//----------------------------------------------------------
// top module out side
wire wWdFll, wWaFll;    assign oWFLL = wWdFll | wWaFll;

// fifo side
reg  qWE, qWED;         // write read enable
reg  qwReady, qwEMP;    // ddr write enable
wire oRwdVD, oRwaVD;    // データ出力時High
wire wWdEmp, wWaEmp;
wire [pBitDepth-1:0] wFifoWd;
wire [pBitDepth-1:0] wFifoAd;

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
    qwReady  <= oRwdVD & oRwaVD;
    qwEMP    <= (~wWdEmp) & (~wWaEmp);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 書き込みと読み込みの優先度を交互に切り替える回路
// write read どちらかのempty信号受信時に、FIFO読み込みのEnableを起動する。
// 起動後、データ出力Valid Dataの信号と同期してEnableをOFFにし、DDRモジュールにデータを出力する
//
// pIdleAhead
// 書き込みコマンド発行時->次回読み込み優先モードに移行
// 書き込みコマンド発行時->次回書き込み優先モードに移行
// 
// pWriteAhead
// 前回は読み込みコマンド発行のため、ReadReady信号の終了まで待機する
// 
// pReadAhead
// 前回は書き込みコマンド発行のため、Write Read Ready信号の終了まで待機する
//----------------------------------------------------------
localparam [2:0] 
    pIdleAhead  = 0,
    pWriteAhead = 1,
    pWriteWait  = 2,
    pReadAhead  = 3,
    pReadWait   = 4;

// ddr out side
wire oReady, oWdReady;

// ddr in side
reg rWready, rRready;           // 同期ready
reg [pBitDepth-1:0] rWd;        // 書き込み時のデータ
reg [pBitDepth-1:0] rWa;        // 書き込み、読み込み時のアドレス

// state side
reg [2:0] rAheadState;          // 優先度切り替えステートマシン

always @(posedge wUiCLK)
begin
    if (wUiRST)
    begin
        rAheadState        <= pWriteAhead;
        {rFifoWE, rFifoRE} <= 2'b00;
        {rWready, rRready} <= 2'b00;
        {rWd, rWa}         <= 0;
    end else begin
        case (rAheadState)
        pIdleAhead: begin
            if (oWdReady && oReady) begin
                if (qwEMP) begin
                    rAheadState        <= (qwReady) ? pReadAhead : pIdleAhead;
                    {rFifoWE, rFifoRE} <= (qwReady) ? 2'b00 : 2'b10;
                    {rWready, rRready} <= {qwReady, 1'b0};
                    {rWd, rWa}         <= {wFifoWd, wFifoAd};
                end else if (qArEMP) begin
                    rAheadState        <= (wRaVd) ? pWriteAhead : pIdleAhead;
                    {rFifoWE, rFifoRE} <= (wRaVd) ? 2'b00 : 2'b01;
                    {rWready, rRready} <= {1'b0, wRaVd};
                    {rWd, rWa}         <= {wFifoWd, wFifoRad};
                end else begin
                    rAheadState        <= pIdleAhead;
                    {rFifoWE, rFifoRE} <= 2'b00;
                    {rWready, rRready} <= 2'b00;
                    {rWd, rWa}         <= 0;
                end
            end
        end

        pWriteAhead: begin
            if (oReady) begin
                if (qwEMP) begin
                    rAheadState        <= (qwReady) ? pReadAhead : pWriteAhead;
                    {rFifoWE, rFifoRE} <= (qwReady) ? 2'b00 : 2'b10;
                    {rWready, rRready} <= {qwReady, 1'b0};
                    {rWd, rWa}         <= {wFifoWd, wFifoAd};
                end else if (qArEMP) begin
                    rAheadState        <= pWriteAhead;
                    {rFifoWE, rFifoRE} <= (wRaVd) ? 2'b00 : 2'b01;
                    {rWready, rRready} <= {1'b0, wRaVd};
                    {rWd, rWa}         <= {wFifoWd, wFifoRad};
                end else begin
                    rAheadState        <= pWriteAhead;
                    {rFifoWE, rFifoRE} <= 2'b00;
                    {rWready, rRready} <= 2'b00;
                    {rWd, rWa}         <= 0;
                end
            end
        end

        pReadAhead: begin
            if (oWdReady && oReady) begin
                if (qArEMP) begin
                    rAheadState        <= (wRaVd) ? pWriteAhead : pReadAhead;
                    {rFifoWE, rFifoRE} <= (wRaVd) ? 2'b00 : 2'b01;
                    {rWready, rRready} <= {1'b0, wRaVd};
                    {rWd, rWa}         <= {wFifoWd, wFifoRad};
                end else if (qwEMP) begin
                    rAheadState        <= pReadAhead;
                    {rFifoWE, rFifoRE} <= (qwReady) ? 2'b00 : 2'b10;
                    {rWready, rRready} <= {qwReady, 1'b0};
                    {rWd, rWa}         <= {wFifoWd, wFifoAd};
                end else begin
                    rAheadState        <= pReadAhead;
                    {rFifoWE, rFifoRE} <= 2'b00;
                    {rWready, rRready} <= 2'b00;
                    {rWd, rWa}         <= 0;
                end
            end
        end

        default: begin
            rAheadState <= pWriteAhead;
            {rFifoWE, rFifoRE} <= 2'b00;
            {rWready, rRready} <= 2'b00;
            {rWd, rWa}         <= 0;
        end
        endcase
    end
end


////////////////////////////////////////////////////////////
wire [pDramDataWidth-1:0] iWdData = {96'd0, rWd};

ddr3Controller #(
    .pDramAddrWidth(pDramAddrWidth),
    .pDramDataWidth(pDramDataWidth),
    .pDramMaskWidth(pDramMaskWidth)
) DDR3_CONTROLLER (
    // DDR port                             hand shake
    .ioDDR3_DQ          (ioDDR3_DQ),        .iWEnable           (rWready),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),     .iREnable           (rRready),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),     .iWdData            (iWdData),
    .oDDR3_ADDR         (oDDR3_ADDR),       .iAddr              (rWa[28:0]),
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