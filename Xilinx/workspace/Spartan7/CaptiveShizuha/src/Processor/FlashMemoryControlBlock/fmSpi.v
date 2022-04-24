//----------------------------------------------------------
// Create 2022/4/20
// Author koutakimura
// -
// SPI 通信を行うモジュール
// 
//----------------------------------------------------------
module fmSpi #(
    parameter       pClkDiv = 400       // 分周数
)(
    output          oCs,                // Chip Select
    output          oSck,               // spi clk
    output          oMosi,              // master out slave in
    input           iMiso,              // master in slave out
    output          oWp,                // write guard Low Active
    output          oHold,              // write stop  Low Active
    output [15:0]   oData,
    input  [23:0]   iAddr,
    input           iCke,
    output          oVd
);

assign oCs      = 1'b1;
assign oSck     = 1'b1;
assign oMosi    = 1'b1;
// assign iMiso
assign oWp      = 1'b1;
assign oHold    = 1'b1;
assign oData    = 16'd0;
// assign iAddr
// assign iCke
assign oVd      = 1'b1;


endmodule