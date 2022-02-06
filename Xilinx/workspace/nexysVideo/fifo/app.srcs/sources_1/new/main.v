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
localparam pWidth = 8;

reg  [pWidth-1:0] iWD;
wire [pWidth-1:0] oRD;
wire oRVD;
reg qWE, qRE;

reg delay;

always @(posedge iCLK)
begin
    if (iRST)   delay <= 1'b0;
    else        delay <= ~delay;
end

fifoController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_CONTROLLER (
    .iCLK   (iCLK),     .iRST   (iRST),
    .iWD    (iWD),      .oRD    (oRD),
    .iWE    (qWE),      .iRE    (qRE),
                        .oRVD   (oRVD),
    .oFLL   (oFLL),     .oEMP   (oEMP)
);

always @*
begin
    qWE <= (~oFLL);
    qRE <= (~oEMP);
end

always @(posedge iCLK)
begin
    if (iRST)       iWD <= 0;
    else if (oFLL)  iWD <= iWD;
    else            iWD <= (iWD + 1'b1) & 255;
end
////////////////////////////////////////////////////////////

reg [7:0] rled;

always @(posedge iCLK)
begin
    if (iRST)       rled <= 0;
    else if (!oRVD) rled <= 8'hff;
    else            rled <= oRD;
end

assign oLED = rled;

endmodule
