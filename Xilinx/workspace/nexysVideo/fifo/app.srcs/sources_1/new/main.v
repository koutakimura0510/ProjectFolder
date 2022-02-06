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


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFOを利用する場合は、Full Empty信号を利用して、
// インターフェース回路やWRENABLEを制御する
//----------------------------------------------------------
reg  [pWidth-1:0] iWD;
wire [pWidth-1:0] oRD;
wire oRVD;
reg qWE, qRE;


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
    else if (!qWE)  iWD <= iWD;
    else            iWD <= (iWD + 1'b1) & 255;
end
////////////////////////////////////////////////////////////

reg [7:0] rled;

always @(posedge iCLK)
begin
    if (iRST)       rled <= 0;
    else if (!oRVD) rled <= 0;
    else            rled <= oRD;
end

assign oLED = rled;

endmodule
