`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/05 21:18:05
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input           iCLK,
    input           iRST,
    output          oUartTx,
    output [7:0]    oLED
);

wire rst = ~iRST;


//----------------------------------------------------------
// 1秒単位で割り込み信号を生成
//----------------------------------------------------------
wire wEn;

enGen # (
    .pSysClk    (100000000)
) EN (
    .iCLK       (iCLK),
    .iRST       (rst),
    .oEnable    (wEn)
);

////////////////////////////////////////////////////////////
wire [7:0] wLed;
wire wIrq;

microblaze_mcs_0 MB (
    .Clk            (iCLK),
    .Reset          (rst),
    .INTC_IRQ       (wIrq),
    .INTC_Interrupt (wEn),
    .UART_txd       (oUartTx),
    .GPIO1_tri_o    (wLed)
);


////////////////////////////////////////////////////////////
reg rMsbLed;
reg [7:0] rLed;             assign oLED = {rMsbLed, rLed[6:0]};

always @(posedge iCLK)
begin
    if (rst )       rMsbLed <= 1'b0;
    else if (wIrq)  rMsbLed <= ~rMsbLed;
    else            rMsbLed <= rMsbLed;
end

always @(posedge iCLK)
begin
    if (rst)    rLed <= 8'hff;
    else        rLed <= wLed;
end

endmodule
