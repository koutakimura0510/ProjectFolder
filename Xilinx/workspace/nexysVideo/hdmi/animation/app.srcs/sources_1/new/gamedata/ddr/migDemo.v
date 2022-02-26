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
    output          oWRDY,      // write ready
    output          oRDV,       // read data valid
    output          oRRDY,      // read ready
    input           iCLK,
    input           iRST,
    output          oUiCLK,
    output          oUiRST
);


////////////////////////////////////////////////////////////
assign oUiCLK = iCLK;
assign oUiRST = iRST;
assign oCal   = ~iRST;


wire wFLL;                  assign oWRDY = (~wFLL);
wire wEMP;                  assign oRRDY = (~wEMP);
wire [31:0] wRD;            assign oData = {96'd0, wRD};
reg qWE, qRE;

fifoController #(
    .pBuffDepth (16),
    .pBitWidth  (32)
) FIFO_WRITE_ADDR (
    // write side           read side
    .iCLK   (iCLK),         .iRST   (iRST),
    .iWD    (iData[31:0]),  .oRD    (wRD),
    .iWE    (qWE),          .iRE    (qRE),
    .oFLL   (wFLL),         .oEMP   (wEMP),
                            .oRVD   (oRDV)
);

always @*
begin
    qWE <= iAppEN & iWE;
    qRE <= iAppEN & (~iWE);
end


endmodule