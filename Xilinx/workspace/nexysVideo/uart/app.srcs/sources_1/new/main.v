/*
 * Create 2021/1/3
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * UARTデモプロジェクト
 */
module main #(
    parameter UART_CLK_SPEED = 868
)(
    input           iCLK,
    input           iRST,
    input           iBtnC,
    input           iUartRX,
    output          oUartTX,
    output [7:0]    oLED
);

wire oReady;
assign oLED = {5'd0, oUartTX, iBtnC, oReady};

uartTx #(
    .UART_CLK_SPEED(UART_CLK_SPEED)
) UART_TX (
    .iCLK(iCLK),
    .iRST(~iRST),
    .iEnable(iBtnC),
    .iSendData(8'h30),
    .oUartTX(oUartTX),
    .oReady(oReady),
);

endmodule
