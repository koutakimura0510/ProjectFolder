/*
 * SPI通信のシリアルデータを、パラレルデータに変換
 *
 * シリアルデータ(クロック同期、8ビット固定長)をシフトレジスタで受信
 * システムCLKのみで動作させるため、シリアルクロックの立ち上がりエッジでシリアルイネーブルとデータをサンプリングする
 * チップセレクトはLowアクティブとする
 */

module SPI (
    input CLK, RESET,
    input SCLK,         //* シリアルクロック
    input SENABLE,      //* シリアルイネーブル
    input MOSI,         //* シリアルデータ
    output [7:0] SDATA
);

wire      s_clk_rise;   // s_clkの立ち上がりエッジ
reg       s_enb_reg;    // s_enb入力レジスタ
reg [2:0] s_clk_reg;
reg [2:0] cnt_reg;      // s_enb長カウンタ
reg [7:0] rcv_reg;      // s_datのシフトレジスタ
reg [7:0] p_dat_reg;    // p_dat出力レジスタ


//* SCLKのエッジを検出
always @(posedge CLK) begin
    if(RESET == 1'b1) begin
        s_clk_reg[2:0] <= 3'b0;
    end else begin
        s_clk_reg[2:0] <= {s_clk_reg[1:0], SCLK};
    end
end

assign s_clk_rise = (s_clk_reg[2:1] == 2'b01);  //* SCKの立ち上がりエッジ取得


//* SENABLEをラッチ
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        s_enb_reg <= 1'b1;
    end else if (s_clk_rise == 1'b1) begin
        s_enb_reg <= SENABLE;
    end
end


//* MOSIをシリアルパラレル変換
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        rcv_reg[7:0] <= 8'b0;
    end else if (s_clk_rise == 1'b1) begin
        rcv_reg[7:0] <= {rcv_reg[6:0], MOSI};
    end
end


//* SENABLEの長さをカウント
always @(posedge CLK) begin
    if (RESET == 1'h1) begin
        cnt_reg <= 3'h0;
    end else if (s_clk_rise == 1'b1) begin
        if (s_enb_reg == 1'b0) begin
            cnt_reg <= cnt_reg + 3'b1;
        end else begin
            cnt_reg <= 3'b0;
        end
        // cnt_reg <= (s_enb_reg == 1'b0) ? (cnt_reg + 3'b1) : 3'b0;
    end
end


//* 8ビット入力したらパラレルレジスタに保存
//* 1SCLK遅れてデータを取得するため、1byte = 0x00を末尾にデータとして送信してもらう
always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        p_dat_reg <= 8'h0;
    end else if (s_clk_rise & cnt_reg == 3'd7) begin
        p_dat_reg <= rcv_reg;
    end
end

assign SDATA = p_dat_reg;

endmodule