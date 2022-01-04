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
    output          oUartRX,
    input           iUartTX,
    output [7:0]    oLED
);

reg [2:0] state;
reg [26:0] tmp;
reg d = 0;
wire oReady;

assign u_en = (2 <= state) ? 1'b1 : 1'b0;
assign en = (tmp == (50000000-1)) ? 1'b1 : 1'b0;
assign oLED = {1'd0, state, d, oUartRX, ~u_en, oReady};

always @(posedge iCLK) begin
    if (~iRST == 1'b1) begin
        tmp <= 0;
        d <= 0;
    end else if (en == 1'b1) begin
        tmp <= 0;
        d <= ~d;
    end else begin
        tmp <= tmp + 1'b1;
    end
end


always @(posedge iCLK) begin
    if (~iRST == 1'b1) begin
        state <= 0;
    end else begin
        case (state)
            0: begin
                if (en == 1'b1) begin
                    state <= 1;
                end
            end

            1: begin
                if (oReady == 1'b1) begin
                    state <= 2;
                end
            end

            2: begin
                if (oReady == 1'b0) begin
                    state <= 3;
                end
            end

            3: begin
                if (oReady == 1'b1) begin
                    state <= 0;
                end
            end

            default:  begin
                state <= 0;
            end
        endcase
    end
end

uartTx #(
    .UART_CLK_SPEED(UART_CLK_SPEED)
) UART_TX (
    .iCLK(iCLK),
    .iRST(~iRST),
    .iEnable(u_en),
    .iSendData(8'h53),
    .oUartRX(oUartRX),
    .oReady(oReady)
);

endmodule
