/*
 * Create 2021/1/3
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * UART送信モジュール
 * ホスト側のRXに送信するため、RXというモジュール名にしている
 */
module uartRx #(
    parameter UART_CLK_SPEED = 868  // 100MHz / 115200bps
)(
    input           iCLK,
    input           iRST,
    input           iEnable,        // 1. uart connect / 0. discon
    input [7:0]     iSendData,      // 送信データ
    output          oUartRX,        // 送信bit
    output          oReady          // 送信中Low 受付可能High
);


//----------------------------------------------------------
// uart ステートマシン、送信回数定数
//----------------------------------------------------------
localparam IDLE     = 0;
localparam START    = 1;
localparam SEND     = 2;
localparam STOP     = 3;
localparam MAX_SEND = 8;


//----------------------------------------------------------
// 変数宣言・信号接続
//----------------------------------------------------------
reg         o_uart_tx;      // uartデータ送信
reg [9:0]   tmp_count;      // 分周クロックカウント
reg [2:0]   state;          // 送信ステートマシン
reg [3:0]   send_count;     // 送信回数
reg [7:0]   i_send_data;    // 送信データ


//----------------------------------------------------------
// 信号接続
//----------------------------------------------------------
assign oUartTX = o_uart_tx;
assign enable  = (tmp_count == (UART_CLK_SPEED - 1)) ? 1'b1 : 1'b0;
assign oReady  = (state == IDLE) ? 1'b1 : 1'b0;


//----------------------------------------------------------
// 分周クロックカウンター
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1 || iEnable == 1'b0) begin
        tmp_count <= 0;
    end else if (enable == 1'b1) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 1'b1;
    end
end


//----------------------------------------------------------
// 送信回数カウント
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1 || iEnable == 1'b0) begin
        send_count <= 0;
    end else if (enable == 1'b1) begin
        if (send_count == MAX_SEND) begin
            send_count <= 0;
        end else begin
            send_count <= send_count + 1'b1;
        end
    end
end


//----------------------------------------------------------
// 送信ステートマシン管理
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1 || iEnable == 1'b0) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE:    state <= (iEnable    == 1'b1) ? START : IDLE;
            START:   state <= (enable     == 1'b1) ? SEND  : START;
            SEND:    state <= (send_count == MAX_SEND) ? STOP : SEND;
            STOP:    state <= (enable     == 1'b1) ? IDLE : STOP;
            default: state <= IDLE;
        endcase
    end
end


//----------------------------------------------------------
// Uart送信クロックの生成
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1 || iEnable == 1'b0) begin
        o_uart_tx <= 1'b1;
    end else begin
        case (state)
            IDLE: begin
                i_send_data <= iSendData;
            end

            START: begin
                if (enable == 1'b1) begin
                    o_uart_tx <= 0;
                end else begin
                    o_uart_tx <= 1;
                end
            end

            SEND: begin
                if (enable == 1'b1) begin
                    o_uart_tx <= i_send_data[0];
                    i_send_data <= {1'b1, i_send_data[7:1]};
                end
            end

            STOP: begin
                if (enable == 1'b1) begin
                    o_uart_tx <= 1;
                end
            end

            default: begin
                o_uart_tx <= 1'b1;
            end
        endcase
    end
end


endmodule