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
// デモ動作用のステートマシン
//----------------------------------------------------------
localparam pWidth = 8;

reg [3:0] state;
reg  [pWidth-1:0] iWD;
wire [pWidth-1:0] oRD;
wire oRVD, oEMP, oFLL;
reg qWE, qRE;

always @(posedge oCLKA)
begin
    if (rst) begin
        state <= 0;
    end
    else
    begin
        case (state)
        0: state <= (~oFLL) ? 1 : 0;
        1: state <= (~oFLL) ? 2 : 1;
        2: state <= (~oFLL) ? 3 : 2;
        3: state <= (~oFLL) ? 4 : 3;
        4: state <= (~oFLL) ? 0 : 4;
        default state <= 0;
        endcase
    end
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// Dual port ram
//----------------------------------------------------------
fifoDualController #(
    .pBuffDepth (8),
    .pBitWidth  (pWidth)
) FIFO_DUAL_CONTROLLER (
    // write side       read side
    .iCLKA  (oCLKA),    .iCLKB  (oCLKB),
                        .iRST   (rst),
    .iWD    (iWD),      .oRD    (oRD),
    .iWE    (qWE),      .iRE    (qRE),
                        .oRVD   (oRVD),
    .oFLL   (oFLL),     .oEMP   (oEMP)
);

// single port ram
// fifoController #(
//     .pBuffDepth (8),
//     .pBitWidth  (pWidth)
// ) FIFO_CONTROLLER (
//     // write side       read side
//     .iCLK   (oCLKA),    .iRST   (rst),
//     .iWD    (iWD),      .oRD    (oRD),
//     .iWE    (qWE),      .iRE    (qRE),
//                         .oRVD   (oRVD),
//     .oFLL   (oFLL),     .oEMP   (oEMP)
// );

always @*
begin
    qWE <= (~oFLL);
    qRE <= (~oEMP);
end

always @(posedge oCLKA)
begin
    if (rst)        iWD <= 0;
    else if (!qWE)  iWD <= iWD;
    else            iWD <= (iWD + 1'b1) & 255;
end
////////////////////////////////////////////////////////////
reg [7:0] rled;

always @(posedge oCLKA)
begin
    if (rst)        rled <= 0;
    else if (!oRVD) rled <= 255;
    else            rled <= oRD;
end

assign oLED = rled;

endmodule
