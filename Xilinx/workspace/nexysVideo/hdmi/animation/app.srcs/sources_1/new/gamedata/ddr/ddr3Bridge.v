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
//
// 2022/03/06 
// FIFO形式でアドレスと書き込みデータの一時保存を行っていたが、動作が非常に分かりにくくなってしまったため、
// データ単体を操作するようにし、ddrコントローラから受信するready,valid信号でread/writeの制御を行うように変更
//----------------------------------------------------------
module ddr3Bridge #(
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitDepth      = 32,          // data bit
    parameter pDramDebug     = "off"
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
    input                       iWvalid,            // write enable信号
    input                       iWFLL,              // dual buffer fifo full signal
    output                      oWready,            // write ready Active High

    // read data side
    output [pBitDepth-1:0]      oRD,                // Pixel Read Data
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    input  [pBitDepth-1:0]      iRA,                // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRvalid,            // read addr enable
    output                      oRready,            // read ready Active High

    // user clk
    output                      oUiCLK,             // user clk 100mhz
    output                      oUiRST              // user rst Active High
);

////////////////////////////////////////////////////////////
wire wUiCLK;    assign oUiCLK = wUiCLK;
wire wUiRST;    assign oUiRST = wUiRST;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// read / write 切り替えステートマシン
// この検証でwrite readの速度が間に合わなければ、128bit対応にする
//----------------------------------------------------------
wire wRready, wWready;
wire oWEMP,   oREMP;
reg  rRready, rWready, qRemp, qWemp;

// always @(posedge wUiCLK)
// begin
//     casex ({wRready, wWready})
//         'b00    : {rRready, rWready}  <= 2'b00;
//         'b01    : {rRready, rWready}  <= {1'b0, qWemp};
//         'b10    : {rRready, rWready}  <= {qRemp, 1'b0};
//         'b11    : {rRready, rWready}  <= 2'b01;
//         default : {rRready, rWready}  <= 2'b00;
//     endcase
// end
reg [1:0] state;

always @(posedge wUiCLK)
begin
    if (wUiRST)
    begin
        {state, rRready, rWready}  <= 4'd0;
    end
    else
    begin
        casex ({state, wRready, wWready})
            'b00_00     : {state, rRready, rWready}  <= {2'b00, 1'b0, 1'b0};
            'b00_01     : {state, rRready, rWready}  <= {2'b01, 1'b0, qWemp};
            'b00_10     : {state, rRready, rWready}  <= {qRemp, 1'b0};
            'b00_11     : {state, rRready, rWready}  <= {2'b11, 1'b0, 1'b1};

            'b01_00     : {state, rRready, rWready}  <= {2'b00, 1'b0, 1'b0};
            'b01_01     : {state, rRready, rWready}  <= {2'b01, 1'b0, 1'b0};
            'b01_10     : {state, rRready, rWready}  <= {2'b10, 1'b1, 1'b0};
            'b01_11     : {state, rRready, rWready}  <= {2'b11, 1'b1, 1'b0};

            'b10_00     : {state, rRready, rWready}  <= {2'b00, 1'b0, 1'b0};
            'b10_01     : {state, rRready, rWready}  <= {2'b01, 1'b0, 1'b1};
            'b10_10     : {state, rRready, rWready}  <= {2'b10, 1'b0, 1'b0};
            'b10_11     : {state, rRready, rWready}  <= {2'b11, 1'b0, 1'b1};

            'b11_00     : {state, rRready, rWready}  <= {2'b00, 1'b0, 1'b0};
            'b11_01     : {state, rRready, rWready}  <= {2'b01, 1'b0, 1'b1};
            'b11_10     : {state, rRready, rWready}  <= {2'b10, 1'b1, 1'b0};
            'b11_11     : {state, rRready, rWready}  <= {2'b11, 1'b0, 1'b0};

            default     : {state, rRready, rWready}  <= {2'b00, 1'b0, 1'b0};
        endcase
    end
end

always @*
begin
    qWemp <= (~oWEMP);
    qRemp <= (~iWFLL) & (~oREMP);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 上位モジュールからの、書き込みデータと読み込みアドレスを保存するFIFO
//----------------------------------------------------------
wire oRFLL, oWFLL;                  assign {oRready, oWready} = {~oRFLL, ~oWFLL};
wire oFifoRVD, oWVD;
wire [pBitDepth-1:0] oRA, oWD, oWA;

ddr3Fifo #(
    .pBuffDepth     (pBuffDepth),
    .pBitDepth      (pBitDepth)
) DDR3_FIFO (
    // input side
    .iCLK           (wUiCLK),       .iRST       (wUiRST),
    .iWD            (iWD),          .iWA        (iWA),
    .iWDE           (iWvalid),      .iWRE       (rWready),
    .iRA            (iRA),          .iRDE       (iRvalid),
    .iRRE           (rRready),

    // output side
    .oWD            (oWD),          .oWA        (oWA),
    .oWVD           (oWVD),         .oWFLL      (oWFLL),
    .oWEMP          (oWEMP),        .oREMP      (oREMP),
    .oRA            (oRA),          .oRVD       (oFifoRVD),
    .oRFLL          (oRFLL)
);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO から書き込みと読み込みアドレスデータが交互に送信される
// そのため 出力制御信号のvalidで判定を行い、DDR3の送信データを変更する
//----------------------------------------------------------
reg [pBitDepth-1:0] rData, rAddr;
reg [1:0] rDdrValid;

always @(posedge wUiCLK)
begin
    if (wUiRST)     {rData, rAddr} <= {32'd0, 32'd0};
    else            {rData, rAddr} <= (oFifoRVD) ? {32'd0, oRA} : {oWD, oWA};
end

always @(posedge wUiCLK)
begin
    if (wUiRST)     rDdrValid <= 2'b00;
    else            rDdrValid <= {oFifoRVD, oWVD};
end

////////////////////////////////////////////////////////////
ddr3Controller #(
    .pDramAddrWidth     (pDramAddrWidth),
    .pDramDataWidth     (pDramDataWidth),
    .pDramMaskWidth     (pDramMaskWidth),
    .pDramDebug         (pDramDebug)
) DDR3_CONTROLLER (
    // DDR port                             hand shake
    .ioDDR3_DQ          (ioDDR3_DQ),        .iWEnable           (rDdrValid[0]),
    .ioDDR3_DQS_N       (ioDDR3_DQS_N),     .iREnable           (rDdrValid[1]),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P),     .iWdData            ({96'd0, rData}),
    .oDDR3_ADDR         (oDDR3_ADDR),       .iAddr              (rAddr[28:0]),
    .oDDR3_BA           (oDDR3_BA),         .iMask              (iMask),
    .oDDR3_RAS          (oDDR3_RAS),        .oRdData            (oRD),
    .oDDR3_CAS          (oDDR3_CAS),        .oRdDataValid       (oRVD),
    .oDDR3_WE           (oDDR3_WE),         .oReady             (wRready),
    .oDDR3_RESET        (oDDR3_RESET),      .oWdReady           (wWready),
    .oDDR3_CLK_P        (oDDR3_CLK_P),
    .oDDR3_CLK_N        (oDDR3_CLK_N),
    .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),
    .oDDR3_ODT          (oDDR3_ODT),

    // user interface clk rst
    .iCLK               (iCLK),             .iRST               (iRST),
    .oUiCLK             (wUiCLK),           .oUiRST             (wUiRST)
);

endmodule