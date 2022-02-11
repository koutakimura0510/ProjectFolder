/*
 * Create 2021/1/4
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * フラッシュメモリ専用SPIモジュール
 *
 * ver2. Bit幅を変更可能にしなければならない
 */
module flashSpi #(
    parameter PDIVSCK = 250 // systemclk 100MHz / 250 = 400kHz
)(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    output          oQspiCLK,       // sclk
    output          oQspiCS,        // フラッシュメモリチップセレクト
    output          oQspiDO,        // SPIデータ出力端子
    input           iQspiDI,        // SPIデータ入力端子
    output          oQspiWP,        // spiモードで使用するためHigh固定
    output          oQspiHOLD,      // spiモードで使用するためHigh固定
    input           iEnable,        // 0. disconnect 1. active
    input  [7:0]    iWData,         // 書き込みデータ
    output [7:0]    oRData,         // 読み込みデータ
    output          oSpiValid,      // 1byteデータ送信完了時High
    output          oWDataValid,    // 書き込み完了時High
    output          oRDataValid     // 読み込みデータ出力時High
);


// シリアルデータ制御信号
assign oQspiWP   = 1'b1;
assign oQspiHOLD = 1'b1;
assign oQspiCS   = ~iEnable;
reg o_scl;          assign oQspiCLK   = o_scl;
reg o_sdo;          assign oQspiDO    = o_sdo;
reg o_sdi;          assign iQspiDI    = o_sdi;
reg spi_valid;      assign oSpiValid  = spi_valid;


//----------------------------------------------------------
// scl発生用に関するパラメータリスト
//----------------------------------------------------------
localparam ENABLE_CNT = (PDIVSCK - 1);
reg [15:0] enable_cnt;  
assign clk_enable = (ENABLE_CNT == enable_cnt) ? 1'b1 : 1'b0; // sck発生分周カウンター とりあえず65536分周可能


//----------------------------------------------------------
// spi通信の信号管理
//----------------------------------------------------------
localparam [2:0]
    IDLE = 0,
    HOLD = 1;

localparam HOLD_TIME_SDA = 10;

reg [7:0] send_byte;     // 送信データ受信レジスタ
reg [3:0] sck_cnt;       // sckの立上り回数をカウント 最大8カウント
reg [5:0] hold_time;     // sda hold
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
// spi_valid    1byteデータ送信完了
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        spi_valid <= 0;
    end else if (iEnable == 1'b1 && clk_enable == 1'b1 && o_scl == 1'b0 && sck_cnt == 4'd7) begin
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
    end else if (clk_enable == 1'b1 && o_scl == 1'b0) begin
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
        o_scl <= 1'b1;
    end else if (iEnable == 1'b0) begin
        o_scl <= 1'b1;
    end else if (clk_enable == 1'b1) begin
        o_scl <= ~o_scl;
    end
end


//----------------------------------------------------------
// SDAの生成
//----------------------------------------------------------

// sda出力の遅延カウンターステートマシン
// sclの立ち下がりに対して max15ns HOLDする必要あり
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hold_state <= IDLE;
    end else begin
        case (hold_state)
            IDLE:    hold_state <= (clk_enable == 1'b1 && o_scl == 1'b1) ? HOLD : IDLE;
            HOLD:    hold_state <= (hold_time == HOLD_TIME_SDA) ? IDLE : HOLD;
            default: hold_state <= IDLE;
        endcase
    end
end


// sda出力の遅延カウンター
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hold_time <= 0;
    end else begin
        case (hold_state)
            IDLE:    hold_time <= 0;
            HOLD:    hold_time <= (hold_time == HOLD_TIME_SDA) ? 0 : hold_time + 1'b1;
            default: hold_time <= 0
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
    end else if (hold_time == HOLD_TIME_SDA) begin
        send_byte <= {send_byte[6:0], 1'b1};
    end
end


// sdaの信号生成
// sckの立ち下がりエッジ時にデータ更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        o_sdo <= send_byte[7];
    end else if (hold_time == HOLD_TIME_SDA && iEnable == 1'b1) begin
        o_sdo <= send_byte[7];
    end
end

endmodule