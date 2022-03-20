//----------------------------------------------------------
// Create 2022/3/11
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// User Interface module <-> DDR3 Memory Controller Bridge module
//----------------------------------------------------------
module ddr3Fifo #(
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitWidth      = 32           // data bit
)(
    input                       iCLKA,          // app clk
    input                       iRSTA,          // reset High
    input                       iCLKB,          // ui clk
    input                       iRSTB,          // reset High
    input  [pBitWidth-1:0]      iWD,            // WriteData
    input  [pBitWidth-1:0]      iWA,            // Write Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iWDE,           // write data enable信号
    input                       iWRE,           // write fifo read enable
    input  [pBitWidth-1:0]      iRA,            // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRDE,
    input                       iRRE,
    output [pBitWidth-1:0]      oWD,
    output [pBitWidth-1:0]      oWA,
    output                      oWVD,           // write Valid data
    output                      oWFLL,          // write side fifo full
    output                      oWEMP,
    output [pBitWidth-1:0]      oRA,            // read address
    output                      oRVD,           // read Valid data
    output                      oRFLL,          // read side fifo full
    output                      oREMP
);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write side
// データとアドレスは同一で動作するため片方のfull empty信号を見れば良いことにした
//----------------------------------------------------------
fifoController #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth)
) DDR3_WD_FIFO (
    .iCLK           (iCLKA),    .iRST           (iRSTA),
    .iWD            (iWD),      .iWE            (iWDE),
    .oFLL           (oWFLL),
    .oRD            (oWD),      .iRE            (iWRE),
    .oRVD           (oWVD),     .oEMP           (oWEMP)
);

fifoController #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth)
) DDR3_WA_FIFO (
    .iCLK           (iCLKA),    .iRST           (iRSTA),
    .iWD            (iWA),      .iWE            (iWDE),
    .oFLL           (),
    .oRD            (oWA),      .iRE            (iWRE),
    .oRVD           (),         .oEMP           ()
);
// fifoDualController #(
//     .pBuffDepth     (pBuffDepth),
//     .pBitWidth      (pBitWidth)
// ) DDR3_WD_FIFO (
//     .iCLKA          (iCLKA),    .iRSTA          (iRSTA),
//     .iCLKB          (iCLKB),    .iRSTB          (iRSTB),
//     .iWD            (iWD),      .iWE            (iWDE),
//     .oFLL           (oWFLL),
//     .oRD            (oWD),      .iRE            (iWRE),
//     .oRVD           (oWVD),     .oEMP           (oWEMP)
// );

// fifoDualController #(
//     .pBuffDepth     (pBuffDepth),
//     .pBitWidth      (pBitWidth)
// ) DDR3_WA_FIFO (
//     .iCLKA          (iCLKA),    .iRSTA          (iRSTA),
//     .iCLKB          (iCLKB),    .iRSTB          (iRSTB),
//     .iWD            (iWA),      .iWE            (iWDE),
//     .oFLL           (),
//     .oRD            (oWA),      .iRE            (iWRE),
//     .oRVD           (),         .oEMP           ()
// );

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// read side
//----------------------------------------------------------
fifoController #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth)
) DDR3_RA_FIFO (
    .iCLK           (iCLKA),    .iRST           (iRSTA),
    .iWD            (iRA),      .iWE            (iRDE),
    .oFLL           (oRFLL),
    .oRD            (oRA),      .iRE            (iRRE),
    .oRVD           (oRVD),     .oEMP           (oREMP)
);
// fifoDualController #(
//     .pBuffDepth     (pBuffDepth),
//     .pBitWidth      (pBitWidth)
// ) DDR3_RA_FIFO (
//     .iCLKA          (iCLKA),    .iRSTA          (iRSTA),
//     .iCLKB          (iCLKB),    .iRSTB          (iRSTB),
//     .iWD            (iRA),      .iWE            (iRDE),
//     .oFLL           (oRFLL),
//     .oRD            (oRA),      .iRE            (iRRE),
//     .oRVD           (oRVD),     .oEMP           (oREMP)
// );


endmodule