/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oled専用のspi通信モジュール
 */
module spiCtrl
#(
    parameter PDIVSCK = 250 // systemclk 100MHz / 250 = 400kHz
)(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system spi
    input           iEnable,        // 0. disconnect 1. active
    input  [7:0]    iSendByte,
    output          oAddrValid,     // romのアドレス更新信号
    output          oSpiValid,      // データ送信完了時High
    output          oOledScl,
    output          oOledSda
);

// シリアルデータ制御信号
reg oled_scl;       assign oOledScl   = oled_scl;
reg oled_sda;       assign oOledSda   = oled_sda;
reg spi_valid;      assign oSpiValid  = spi_valid;
reg addr_valid;     assign oAddrValid = addr_valid;


//----------------------------------------------------------
// scl発生用に関するパラメータリスト
//----------------------------------------------------------
localparam ENABLE_CNT = PDIVSCK - 1;
reg [15:0] enable_cnt;   assign clk_enable = (ENABLE_CNT == enable_cnt) ? 1'b1 : 1'b0; // sck発生分周カウンター とりあえず65536分周可能


//----------------------------------------------------------
// spi通信の信号管理
//----------------------------------------------------------
localparam [2:0]
    IDLE = 0,
    HOLD = 1;

localparam HOLD_TIME = 4;

reg [7:0] send_byte;     // 送信データ受信レジスタ
reg [3:0] sck_cnt;       // sckの立上り回数をカウント 最大8カウント
reg [2:0] hold_time;     // sda hold
reg [1:0] hold_state = IDLE;


//----------------------------------------------------------
// sck enable信号の生成
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        enable_cnt <= 0;
    end else if (clk_enable == 1'b1 || iEnable == 1'b0) begin
        enable_cnt <= 0;
    end else begin
        enable_cnt <= enable_cnt + 1'b1;
    end
end


//----------------------------------------------------------
// spi ハンド・シェイク信号
// addr_valid   コマンドのアドレス更新命令
// spi_valid    1byteデータ送信完了
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        addr_valid <= 1'b0;
    end else if (iEnable == 1'b1 && clk_enable == 1'b1 && oled_scl == 1'b1 && sck_cnt == 4'd7) begin
        addr_valid <= 1'b1;
    end else begin
        addr_valid <= 1'b0;
    end
end

// 1byteデータ送信時High
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        spi_valid <= 0;
    end else if (iEnable == 1'b1 && clk_enable == 1'b1 && oled_scl == 1'b0 && sck_cnt == 4'd7) begin
        spi_valid <= 1'b1;
    end else begin
        spi_valid <= 1'b0;
    end
end


//----------------------------------------------------------
// SCLの生成
//----------------------------------------------------------
// sckの立上り回数をカウント
// 1byte送信時にHIGH
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sck_cnt <= 0;
    end else if (iEnable == 1'b0) begin
        sck_cnt <= 0;
    end else if (clk_enable == 1'b1 && oled_scl == 1'b0) begin
        if (sck_cnt == 4'd7) begin
            sck_cnt <= 0;
        end else begin
            sck_cnt <= sck_cnt + 4'd1;
        end
    end
end

// sckの信号生成
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oled_scl <= 1'b1;
    end else if (iEnable == 1'b0) begin
        oled_scl <= 1'b1;
    end else if (clk_enable == 1'b1) begin
        oled_scl <= ~oled_scl;
    end
end


//----------------------------------------------------------
// SDAの生成
//----------------------------------------------------------
// sda出力の遅延カウンター
// sclの立ち下がりに対して max15ns HOLDする必要あり
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hold_state <= IDLE;
        hold_time  <= 0;
    end else begin
        case (hold_state)
            IDLE: begin
                if (clk_enable == 1'b1 && oled_scl == 1'b1) begin
                    hold_state <= HOLD;
                end else begin
                    hold_state <= IDLE;
                end
            end

            HOLD: begin
                if (hold_time == HOLD_TIME) begin
                    hold_time <= 0;
                    hold_state <= IDLE;
                end else begin
                    hold_time <= hold_time + 1'b1;
                    hold_state <= HOLD;
                end
            end

            default: begin
                hold_state <= IDLE;
                hold_time  <= 0;
            end
        endcase
    end
end

// 送信バイトデータの取り込み
// 1bitずつ送信するため、sck_cntの開始時に新規データで上書きする
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        send_byte <= iSendByte;
    end else if (iEnable == 1'b0 || spi_valid == 1'b1) begin
        send_byte <= iSendByte;
    end else if (hold_time == HOLD_TIME) begin
        send_byte <= {send_byte[6:0], 1'b1};
    end
end

// sdaの信号生成
// sckの立ち下がりエッジ時にデータ更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oled_sda <= send_byte[7];
    end else if (iEnable == 1'b0) begin
        oled_sda <= send_byte[7];
    end else if (hold_time == HOLD_TIME) begin
        oled_sda <= send_byte[7];
    end
end

endmodule