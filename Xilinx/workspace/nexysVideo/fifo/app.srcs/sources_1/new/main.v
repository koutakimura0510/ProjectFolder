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
wire [pWidth-1:0] oRD, oDRD;
wire oRVD,  oEMP,  oFLL;
wire oDRVD, oDEMP, oDFLL;
reg qWE, qRE, qDRE;

// single port ram
fifoController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_CONTROLLER (
    // write side       read side
    .iCLK   (oCLKA),    .iRST   (rst),
    .iWD    (iWD),      .oRD    (oRD),
    .iWE    (qWE),      .iRE    (qRE),
                        .oRVD   (oRVD),
    .oFLL   (oFLL),     .oEMP   (oEMP)
);

always @(posedge oCLKA)
begin
    if (rst)        iWD <= 0;
    else if (!qWE)  iWD <= iWD;
    else            iWD <= (iWD + 1'b1) & 255;
end

////////////////////////////////////////////////////////////

// dual
fifoDualController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_DUAL_CONTROLLER (
    // write side       read side
    .iCLKA  (oCLKA),    .iCLKB  (oCLKB),
                        .iRST   (rst),
    .iWD    (oRD),      .oRD    (oDRD),
    .iWE    (oRVD),     .iRE    (qDRE),
                        .oRVD   (oDRVD),
    .oFLL   (oDFLL),    .oEMP   (oDEMP)
);

always @*
begin
    qWE     <= (~oFLL);
    qRE     <= (~oDFLL) & (~oEMP);
    qDRE    <= (~oDEMP);
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
