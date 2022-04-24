//----------------------------------------------------------
// Create 2022/4/20
// Author koutakimura
// -
// SPI 通信を行うモジュール
// 
//----------------------------------------------------------
module fmSpi #(
    parameter       pClkDiv = 400     // 分周数
)(
    output          oCs,
    output          oSck,
    output          oMosi,
    input           iMiso,
    output          oWp,
    output          oHold,
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