//----------------------------------------------------------
// Create 2022/4/20
// Author koutakimura
// -
// APDS9960 の制御を行うブロック
// 
//----------------------------------------------------------
module acbWrapper #(
    parameter pClkDivsion = 400     // 分周数
)(
    input           iSysClk,
    input           iRst,
    inout  [1:0]    ioApdsScl,      // [1]. Left  [0]. Right
    inout  [1:0]    ioApdsSda,      // [1]. Left  [0]. Right
    input  [1:0]    iApdsIntr,      // [1]. Left  [0]. Right
    output [3:0]    oGestureR,      // 左側のジェスチャー信号送信 3.UP 2.RIGHT 1.DOWN 0.LEFT
    output [3:0]    oGestureL,      // 右側のジェスチャー信号送信 3.UP 2.RIGHT 1.DOWN 0.LEFT
);


//---------------------------------------------------------------------------
// IOBUF
// .IO => input 端子
// .O  => I/O が入力ポート扱い
// .I  => I/O が出力ポート扱い
// .T  => Tri State - High Input / Low Output
//---------------------------------------------------------------------------
wire [1:0] wApdsIntr;
wire [1:0] wIn

IBUF IBUF_APDS_INTR_0 (
    .O (wApdsIntr [0]),
    .I (iApdsIntr [0])
);

IBUF IBUF_APDS_INTR_1 (
    .O (wApdsIntr [1]),
    .I (iApdsIntr [1])
);

IOBUF IOBUF_SDA_0 (
    .O  (wInQspiDq0  [1]),
    .I  (wOutQspiDq0 [1]),
    .IO (ioApdsSda   [0]),
    .T  (1'b0)
);

IOBUF QSPI_IOBUF_DQ1_0 (
    .O (wInQspiDq1[1]),
    .I (wOutQspiDq1[1]),
    .IO (ioQspiDq1[1]),
    .T (1'b1)
);

IOBUF QSPI_IOBUF_DQ2_0 (
    .O (wInQspiDq2[1]),
    .I (wOutQspiDq2[1]),
    .IO (ioQspiDq2[1]),
    .T (1'b0)
);

IOBUF QSPI_IOBUF_DQ3_0 (
    .O (wInQspiDq3[1]),
    .I (wOutQspiDq3[1]),
    .IO (ioQspiDq3[1]),
    .T (1'b0)
);



// wire [1:0] wOutQspiCs, wOutQspiSck;
// wire [1:0] wOutQspiDq0, wOutQspiDq1, wOutQspiDq2, wOutQspiDq3;
// wire [1:0] wInQspiDq0, wInQspiDq1, wInQspiDq2, wInQspiDq3;



endmodule