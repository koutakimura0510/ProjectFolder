/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ送受信モジュール
 */
module ddr3Bridge (
    input           iCLK,           // system clk
    input           iPLLCLK,        // DDR3 PLL clk
    input           iRST,           // syste rst

    // DDR3 Port
    output [14:0]   oDDR3_ADDR,     // row col Addr
    output [ 2:0]   oDDR3_BA,       // Bank Select
    output [ 1:0]   oDDR3_DM,       // Data Mask Write時にHighで書き込み停止、それぞれ上位下位8bitに対応
    inout  [15:0]   ioDDR3_DQ,      // Cmd Data byte
    output          oDDR3_CKE,      // CLK Enable Lowで停止
    output          oDDR3_ODT,      // High 終端抵抗が有効、終端と出力を同時に行えないため基本Lowにする
    output          oDDR3_RAS,      // Row Address Strobe:RAS
    output          oDDR3_CAS,      // Column Address Strobe:CAS
    output          oDDR3_WE,       // Write Enable
    output          oDDR3_RESET,    // System RST Lowで停止
    output          oDDR3_CLK_n,    // DDR3 System CLK
    output          oDDR3_CLK_p,    // DDR3 System CLK
    inout  [ 1:0]   ioDDR3_DQS_n,   // Read Write CLK それぞれ上位下位8bitに対応
    inout  [ 1:0]   ioDDR3_DQS_p,   // Read Write CLK それぞれ上位下位8bitに対応

    // DDR3モードセレクト
    input  [3:0]    iDDR3_Mode,

    // 入出力データ
    input  [19:0]   iDDR3_Addr,     // 上位5bit {RST CKE RAS# CAS# WE#} {残り15bit A14 ~ A0}
    input  [ 2:0]   iDDR3_Bank,
    input  [15:0]   iDDR3_Wdata,    // write data
    output [15:0]   oDDR3_Rdata,    // read data

    // 送受信完了enable信号
    output          oWRComplete
);


//----------------------------------------------------------
// DDR3動作ステートマシン
//----------------------------------------------------------
localparam [3:0]
    DDR3_INIT   = 0,    // 初期化ステート
    DDR3_IDLE   = 1,    // アイドル
    DDR3_ACTIVE = 2,    // アクティブコマンド発行
    DDR3_WRITE  = 3,    // 書き込みコマンド発行
    DDR3_READ   = 4,    // 読み込みコマンド発行
    DDR3_PREA   = 5;    // プリチャージコマンド発行
    // DDR3_SELFREF
    // DDR3_REFRESH
    // DDR3_PDOWN


reg [14:0] oddr3_addr = 0;          assign oDDR3_ADDR      = oddr3_addr;
reg [ 2:0] oddr3_ba  = 0;           assign oDDR3_BA        = oddr3_ba;
reg [ 1:0] oddr3_dm  = 2'b00;       assign oDDR3_DM        = oddr3_dm;
reg [15:0] ioddr3_dq = 16'dz;       assign ioDDR3_DQ       = ioddr3_dq;
reg oddr3_cke = 0;                  assign oDDR3_CKE       = oddr3_cke;
reg oddr3_odt = 0;                  assign oDDR3_ODT       = oddr3_odt;
reg oddr3_ras = 0;                  assign oDDR3_RAS       = oddr3_ras;
reg oddr3_cas = 0;                  assign oDDR3_CAS       = oddr3_cas;
reg oddr3_we  = 0;                  assign oDDR3_WE        = oddr3_we;
reg oddr3_reset = 0;                assign oDDR3_RESET     = oddr3_reset;
reg oddr3_clk_n = 1;                assign oDDR3_CLK_n     = oddr3_clk_n;
reg oddr3_clk_p = 0;                assign oDDR3_CLK_p     = oddr3_clk_p;
reg [ 1:0] ioddr3_dqs_n = 2'bzz;    assign ioDDR3_DQS_n    = ioddr3_dqs_n;
reg [ 1:0] ioddr3_dqs_p = 2'bzz;    assign ioDDR3_DQS_p    = ioddr3_dqs_p;
reg [ 7:0] rbuff [7:0];
reg [ 3:0] rbuffp;
assign oDDR3_Rdata = rbuff[4];


//----------------------------------------------------------
// AL + CWL = WL
// AL + CL  = RL
//----------------------------------------------------------
localparam CWL_MAX = 10;                     // MR2設定のCAS Write Latency
localparam CL_MAX  = 10;                     // MR0設定のCAS Latency(Read)
localparam AL_MAX  = 0;                     // MR1設定のAdditive Latency
localparam WL_MAX  = (CWL_MAX + AL_MAX);    // writeコマンド発行時のデータ出力までの待機時間
localparam RL_MAX  = (CL_MAX  + AL_MAX);    // readコマンド発行時のデータ出力までの待機時間
localparam TWPRE   = (WL_MAX - 2);          // writeコマンド発行時のDQS信号の待機時間
localparam TRPRE   = (RL_MAX - 2);          // readコマンド発行時のDQS信号の待機時間
localparam DQS_GENERATE = (WL_MAX - 1);

reg [15:0] send_data;
reg [4:0] wl_cnt;       // 待機時間
reg [4:0] send_cnt;     // 送信回数
assign oWRComplete = (send_cnt == 8) ? 1'b1 : 1'b0;


//----------------------------------------------------------
// WL RL 
//----------------------------------------------------------
always @(posedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        wl_cnt <= 0;
    end else begin
        case (iDDR3_Mode)
            DDR3_WRITE: begin
                if (wl_cnt == WL_MAX) begin
                    if (send_cnt == 7) begin
                        wl_cnt <= 0;
                    end else begin
                        wl_cnt <= WL_MAX;
                    end
                end else begin
                    wl_cnt <= wl_cnt + 1'b1;
                end
            end

            DDR3_READ: begin
                if (wl_cnt == WL_MAX) begin
                    if (send_cnt == 7) begin
                        wl_cnt <= 0;
                    end else begin
                        wl_cnt <= WL_MAX;
                    end
                end else begin
                    wl_cnt <= wl_cnt + 1'b1;
                end
            end

            default: begin
                wl_cnt <= 0;
            end
        endcase
    end
end


//----------------------------------------------------------
// 待機時間完了から送信が開始される。
// 待機サイクルカウント変数の値によって送信回数のカウントを数える
//----------------------------------------------------------
always @(posedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        send_cnt <= 0;
    end else begin
        if (wl_cnt == WL_MAX) begin
            send_cnt <= send_cnt + 1'b1;
        end else begin
            send_cnt <= 0;
        end
    end
end


//----------------------------------------------------------
// デモ送信データ生成
// clk clk#の立上りエッジでデータの書き込みを行うため
// 立ち下がり時にデータの更新を行う
//----------------------------------------------------------
always @(negedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        send_data <= 0;
    end else begin
        if (wl_cnt == WL_MAX) begin
            send_data <= send_data + 1'b1;
        end else begin
            send_data <= send_data;
        end
    end
end


//----------------------------------------------------------
// DQSの生成
//----------------------------------------------------------
always @(posedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        ioddr3_dqs_n <= 2'bzz;
        ioddr3_dqs_p <= 2'bzz;
    end else begin
        case (iDDR3_Mode)
            DDR3_WRITE: begin
                if (wl_cnt == TWPRE) begin // DQS信号開始の合図
                    ioddr3_dqs_n <= 2'b00;
                    ioddr3_dqs_p <= 2'b11;
                end else if (DQS_GENERATE <= wl_cnt) begin // tWPSTを含めた8byte分のクロックを生成
                    ioddr3_dqs_n <= ~ioddr3_dqs_n;
                    ioddr3_dqs_p <= ~ioddr3_dqs_p;
                end else begin
                    ioddr3_dqs_n <= 2'bzz; // 書き込み完了時はハイインピーダンスに戻さなければならない
                    ioddr3_dqs_p <= 2'bzz;
                end
            end

            default: begin
                ioddr3_dqs_n <= 2'bzz;
                ioddr3_dqs_p <= 2'bzz;
            end
        endcase
    end
end


//----------------------------------------------------------
// DDR3メモリ CLK生成
//----------------------------------------------------------
always @(posedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        oddr3_clk_n <= 1'b1;
        oddr3_clk_p <= 1'b0;
    end else begin
        oddr3_clk_n <= ~oddr3_clk_n;
        oddr3_clk_p <= ~oddr3_clk_p;
    end
end


//----------------------------------------------------------
// DDR3 Port
//----------------------------------------------------------
always @(negedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        oddr3_reset <= 1'b0;
        oddr3_cke   <= 1'b0;
        oddr3_ras   <= 1'b0;
        oddr3_cas   <= 1'b0;
        oddr3_we    <= 1'b0;
        oddr3_addr  <= 1'b0;
        oddr3_ba    <= 1'b0;
    end else begin
        case (iDDR3_Mode)
            DDR3_INIT: begin
                oddr3_reset <= iDDR3_Addr[19];
                oddr3_cke   <= iDDR3_Addr[18];
                oddr3_ras   <= iDDR3_Addr[17];
                oddr3_cas   <= iDDR3_Addr[16];
                oddr3_we    <= iDDR3_Addr[15];
                oddr3_addr  <= iDDR3_Addr[14:0];
                oddr3_ba    <= iDDR3_Bank;
            end

            DDR3_IDLE: begin
                oddr3_ras   <= 1'b1;
                oddr3_cas   <= 1'b1;
                oddr3_we    <= 1'b1;
                oddr3_addr  <= 14'd0;
                oddr3_ba    <= 3'd0;
            end

            DDR3_ACTIVE: begin
                oddr3_ras   <= iDDR3_Addr[17];
                oddr3_cas   <= iDDR3_Addr[16];
                oddr3_we    <= iDDR3_Addr[15];
                oddr3_addr  <= iDDR3_Addr[14:0];
                oddr3_ba    <= iDDR3_Bank;
            end

            DDR3_WRITE: begin
                oddr3_ras   <= iDDR3_Addr[17];
                oddr3_cas   <= iDDR3_Addr[16];
                oddr3_we    <= iDDR3_Addr[15];
                oddr3_addr  <= iDDR3_Addr[14:0];
                oddr3_ba    <= iDDR3_Bank;
                if (wl_cnt == WL_MAX) begin
                    ioddr3_dq <= send_data;
                end else begin
                    ioddr3_dq <= 16'hzzzz;
                end
            end

            DDR3_READ: begin
                oddr3_ras   <= iDDR3_Addr[17];
                oddr3_cas   <= iDDR3_Addr[16];
                oddr3_we    <= iDDR3_Addr[15];
                oddr3_addr  <= iDDR3_Addr[14:0];
                oddr3_ba    <= iDDR3_Bank;
                if (wl_cnt == WL_MAX) begin
                    rbuff[rbuffp] <= ioDDR3_DQ;
                end else begin
                    ioddr3_dq <= 16'hzzzz;
                end
            end

            DDR3_PREA: begin
                ioddr3_dq <= 16'hzzzz;
            end

            default: begin
                oddr3_ras   <= 1'b1;
                oddr3_cas   <= 1'b1;
                oddr3_we    <= 1'b1;
                oddr3_addr  <= 14'd0;
                oddr3_ba    <= 3'd0;
            end
        endcase
    end
end

always @(negedge iPLLCLK) begin
    if (iRST == 1'b1) begin
        rbuffp <= 0;
    end else begin
        case (iDDR3_Mode)
            DDR3_READ: begin
                if (wl_cnt == WL_MAX) begin
                    if (rbuffp == 7) begin
                        rbuffp <= 7;
                    end else begin
                        rbuffp <= rbuffp + 1'b1;
                    end
                end
            end

            default begin
                rbuffp <= 1'b0;
            end
        endcase
    end
end

endmodule