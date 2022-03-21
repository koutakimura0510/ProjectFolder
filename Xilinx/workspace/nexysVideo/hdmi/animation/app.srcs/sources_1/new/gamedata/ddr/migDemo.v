/*
 * Create 2021/2/20
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ制御 ハンドシェイク信号デモ動作
 */
module migDemo (
    input  [127:0]  iData,
    output [127:0]  oData,
    output          oCal,
    input           iAppEN,
    input           iWE,        // write enable
    input           iReadCmd,
    output          oWready,    // write ready
    output          oRVD,       // read data valid
    output          oAready,    // active ready
    input           iCLK,
    input           iRST,
    output          oUiCLK,
    output          oUiRST
);


////////////////////////////////////////////////////////////
assign oUiCLK = iCLK;
assign oUiRST = iRST;
assign oCal   = ~iRST;

////////////////////////////////////////////////////////////
reg qRE, qWE;
wire wEmp, wFull;
wire [31:0] wData;              assign oData = {96'd0, wData};

fifoController #(
    .pBuffDepth     (4096),
    .pBitWidth      (32)
) MIG_DEMO_FIFO (
    .iCLK           (iCLK),             .iRST           (iRST),
    .iWD            (iData[31:0]),      .iWE            (qWE),
    .oFLL           (wFull),
    .oRD            (wData),            .iRE            (qRE),
    .oRVD           (oRVD),             .oEMP           (wEmp)
);

always @*
begin
    qRE <= iAppEN & iReadCmd & (~wEmp);
    qWE <= iAppEN & iWE & (~wFull);
end

assign oWready = (~wFull);
assign oAready = 1'b1;//(iAppEN && iWE) ? (~wFull) : (~wEmp);

endmodule