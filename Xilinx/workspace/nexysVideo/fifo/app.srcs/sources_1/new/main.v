//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFOサンプルプロジェクト
// 
// write read同期FIFO動作などを行う
// 
// コーディング規則
// reg宣言でラッチにする場合、先頭にqを付属
// レジスタとして使用する場合、先頭にrを付属
//----------------------------------------------------------
module main (
    input           iCLK,
    input           iRST,
    output [7:0]    oLED
);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 非同期クロックの生成
//----------------------------------------------------------
wire oCLKA;     // 100mhz
wire oCLKB;     // 25mhz
wire locked;

clk_wiz_0 CLK_GEN (
    .clk_out1   (oCLKA),
    .clk_out2   (oCLKB),
    .reset      (iRST),
    .locked     (locked),
    .clk_in1    (iCLK)
);

wire rst = ~locked;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 1-stage
//----------------------------------------------------------
localparam pWidth = 8;

reg  [pWidth-1:0] iWD;
wire [pWidth-1:0] oRD1;
wire oRVD1, oEMP1, oFLL1;
reg qWE1, qRE1;

// single port ram
fifoController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_STAGE_1 (
    // write side       read side
    .iCLK   (oCLKA),    .iRST   (rst),
    .iWD    (iWD),      .oRD    (oRD1),
    .iWE    (qWE1),     .iRE    (qRE1),
                        .oRVD   (oRVD1),
    .oFLL   (oFLL1),    .oEMP   (oEMP1)
);

always @(posedge oCLKA)
begin
    if (rst)        iWD <= 0;
    else if (!qWE1)  iWD <= iWD;
    else            iWD <= (iWD + 1'b1) & 255;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 2-stage
//----------------------------------------------------------
wire [pWidth-1:0] oRD2;
wire oRVD2, oEMP2, oFLL2;
reg qRE2;

// single port ram
fifoController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_STAGE_2 (
    // write side       read side
    .iCLK   (oCLKA),    .iRST   (rst),
    .iWD    (oRD1),     .oRD    (oRD2),
    .iWE    (oRVD1),    .iRE    (qRE2),
                        .oRVD   (oRVD2),
    .oFLL   (oFLL2),    .oEMP   (oEMP2)
);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 3-stage
//----------------------------------------------------------
wire [pWidth-1:0] oDRD;
wire oDRVD, oDEMP, oDFLL;
reg qDRE;

fifoDualController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_DUAL_CONTROLLER (
    // write side       read side
    .iCLKA  (oCLKA),    .iCLKB  (oCLKB),
                        .iRST   (rst),
    .iWD    (oRD2),     .oRD    (oDRD),
    .iWE    (oRVD2),    .iRE    (qDRE),
                        .oRVD   (oDRVD),
    .oFLL   (oDFLL),    .oEMP   (oDEMP)
);

always @*
begin
    qWE1     <= (~oFLL1);
    qRE1     <= (~oFLL2) & (~oEMP1);
    qRE2     <= (~oDFLL) & (~oEMP2);
    qDRE     <= (~oDEMP);
end

////////////////////////////////////////////////////////////
reg [7:0] rled;

always @(posedge oCLKB)
begin
    if (rst)            rled <= 0;
    else if (!oDRVD)    rled <= 255;
    else                rled <= oDRD;
end

assign oLED = rled;

endmodule
