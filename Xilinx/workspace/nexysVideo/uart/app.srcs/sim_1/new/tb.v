`timescale 1ns / 1ps

/*
 * Create 2021/1/4
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * uartテストベンチ
 */
module tb;

parameter CYCLE = 2;

reg  iCLK = 0;
reg  iRST = 0;
reg  iBtnC = 0;
reg  iUartRX = 0;
wire oUartTX;
wire [7:0] oLED;

main #(
    .UART_CLK_SPEED(20)
) MAIN (
    .iCLK(iCLK),
    .iRST(iRST),
    .iBtnC(iBtnC),
    .iUartRX(iUartRX),
    .oUartTX(oUartTX),
    .oLED(oLED)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    #(CYCLE*2);
    iRST = 1;
    #(CYCLE*2);
    iBtnC = 1;
    #(CYCLE*4*16);
    $stop;
end

endmodule
