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
(
    // systemclk 100MHz / 250 = 400kHz
    parameter SCK_SPEED = 250,
)(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system spi
    input           iEnable,    // 0. disconnect 1. active
    input  [7:0]    iSnedByte,
    output          sendValid,
    output          oOledScl,
    output          oOledSda
);

// シリアルデータ制御信号
reg oled_scl;       assign oOledScl  = oled_scl;
reg oled_sda;       assign oOledSda  = oled_sda;
reg send_valid;     assign sendValid = send_valid;


//----------------------------------------------------------
// scl発生用に関するパラメータリスト
//----------------------------------------------------------
localparam ENABLE_CNT = SCK_SPEED - 1;

reg enable_cnt[15:0];   // sck発生分周カウンター とりあえず65536分周可能
wire clk_enable;        // パラメータの値カウント時の発生enable信号


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

assign clk_enable = (ENABLE_CNT == enable_cnt) ? 1'b1 : 1'b0;


//----------------------------------------------------------
// spi通信の信号管理
//----------------------------------------------------------
reg [7:0] send_byte;    // 送信データ受信レジスタ
reg [3:0] sck_cnt;      // sckの立上り回数をカウント 最大8カウント


// sckの立上り回数をカウント
// 1byte送信時にHIGH
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sck_cnt <= 0;
        send_valid <= 0;
    end else if (iEnable == 1'b0) vbegin
        sck_cnt <= 0;
        send_valid <= 0;
    end else if (clk_enable == 1'b1 && oled_scl == 1'b0) begin
        if (sck_cnt == 4'd7) begin
            sck_cnt <= 0;
            send_valid <= 1'b1;
        end else begin
            sck_cnt <= sck_cnt + 4'd1;
            send_valid <= 1'b0;
        end
    end
end


// 送信バイトデータの取り込み
// 1bitずつ送信するため、sck_cntの開始時に新規データで上書きする
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        send_byte <= iSendByte;
    end else if (sck_cnt == 0 || iEnable == 1'b0) begin
        send_byte <= iSendByte;
    end else if (clk_enable == 1'b1) begin
        send_byte <= {send_byte[6:0], 1'b1};
    end
end

// sckの信号生成
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oled_scl <= 1'b0;
    end else if (iEnable == 1'b0) begin
        oled_scl <= 1'b0;
    end else if (clk_enable == 1'b1) begin
        oled_scl <= ~oled_scl;
    end
end

// sdaの信号生成
// sckの立ち下がりエッジ時にデータ更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oled_sda <= send_byte[7];
    end else if (iEnable == 1'b0) begin
        oled_sda <= send_byte[7];
    end else if (clk_enable == 1'b1 && oled_scl == 1'b1) begin
        oled_sda <= send_byte[7];
    end
end

endmodule