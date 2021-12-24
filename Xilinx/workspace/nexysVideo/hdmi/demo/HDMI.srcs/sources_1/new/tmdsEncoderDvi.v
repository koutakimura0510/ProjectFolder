/*
 * Create 2021/12/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DVI/TMDS信号の送信データの符号化処理を行う
 * DVIのため4b/10b変換処理は行わない
 *
 * 8b/10b -> ビデオデータ
 * 2b/10b -> H/VSync
 *
 * 参考URL -> http://www.hdmi-navi.com/tmds/
 */

module tmdsEncoderDvi(
    input           iCLK,           // pll clk
    input           iRST,           // system rst
    input [7:0]     iVD,            // r or g or b video data
    input [1:0]     iCD,
    input           iVDE,           // High to display on
    output [9:0]    oTmdsPara
);

reg [9:0] tmds_para;        assign oTmdsPara = tmds_para;

// 2b/10b
reg [9:0] tmds_code;


//----------------------------------------------------------
// Transition Maximized(遷移時間最長) 2b/10b TMDS変換
// CD[1] vsync
// CD[0] hsync
//----------------------------------------------------------
always @(iCD) begin
    case (iCD)
        2'b00:   tmds_code <= 10'b1101010100;
        2'b01:   tmds_code <= 10'b0010101011;
        2'b10:   tmds_code <= 10'b0101010100;
        2'b11:   tmds_code <= 10'b1010101011;
        default: tmds_code <= 10'b1101010100;
    endcase
end


//----------------------------------------------------------
// 8b/9b変換 Transition Minimized(遷移時間最短)
// EMI防止のため0->1の遷移回数を削減する
// 
// 下記の条件に当てはまる場合XNORを行う、そうでなければNORを行う
// 1.8ビットのデータ上の[1]の総数が4つよりも多い場合
// 2.8ビットのデータ上の[1]の総数が4つあり、かつLSBが[0]である場合
//
// XNORの場合9bit目を0にし、NORの場合1にする
//----------------------------------------------------------

// 8b/9b
wire [3:0] bit_total = iVD[0] + iVD[1] + iVD[2] + iVD[3] + iVD[4] + iVD[5] + iVD[6] + iVD[7];
wire XNOR = ((4'd4 < bit_total) || (bit_total == 4'd4 && iVD[0] == 1'b0)) ? 1'b1 : 1'b0;
reg  [8:0] tm;

always @(iVD or XNOR) begin
    if (XNOR == 1'b1) begin
        tm[0] <= iVD[0];
        tm[1] <= iVD[0] ~^ iVD[1];
        tm[2] <= iVD[0] ~^ iVD[1] ~^ iVD[2];
        tm[3] <= iVD[0] ~^ iVD[1] ~^ iVD[2] ~^ iVD[3];
        tm[4] <= iVD[0] ~^ iVD[1] ~^ iVD[2] ~^ iVD[3] ~^ iVD[4];
        tm[5] <= iVD[0] ~^ iVD[1] ~^ iVD[2] ~^ iVD[3] ~^ iVD[4] ~^ iVD[5];
        tm[6] <= iVD[0] ~^ iVD[1] ~^ iVD[2] ~^ iVD[3] ~^ iVD[4] ~^ iVD[5] ~^ iVD[6];
        tm[7] <= iVD[0] ~^ iVD[1] ~^ iVD[2] ~^ iVD[3] ~^ iVD[4] ~^ iVD[5] ~^ iVD[6] ~^ iVD[7];
        tm[8] <= 1'b0;
    end else begin
        tm[0] <= iVD[0];
        tm[1] <= iVD[0] ^ iVD[1];
        tm[2] <= iVD[0] ^ iVD[1] ^ iVD[2];
        tm[3] <= iVD[0] ^ iVD[1] ^ iVD[2] ^ iVD[3];
        tm[4] <= iVD[0] ^ iVD[1] ^ iVD[2] ^ iVD[3] ^ iVD[4];
        tm[5] <= iVD[0] ^ iVD[1] ^ iVD[2] ^ iVD[3] ^ iVD[4] ^ iVD[5];
        tm[6] <= iVD[0] ^ iVD[1] ^ iVD[2] ^ iVD[3] ^ iVD[4] ^ iVD[5] ^ iVD[6];
        tm[7] <= iVD[0] ^ iVD[1] ^ iVD[2] ^ iVD[3] ^ iVD[4] ^ iVD[5] ^ iVD[6] ^ iVD[7];
        tm[8] <= 1'b1;
    end
end


//----------------------------------------------------------
// 9b/10b変換 DC-Balancing（DCバランス)
//
// old_bit_cnt = Cnt(t-1)
// new_bit_cnt = N1
// 5'd8,5'd4   = N0
//
// DC変換後のbit整形処理
// 10bit目の値によって変換内容が異なり、それぞれのbitを結合し10bitのTMDSとする
// 10bitが[0]の場合 10bit = 0, 9bit = 1, 8~1bit = tm[7:0]
// 10bitが[1]の場合 10bit = 1, 9bit = 0, 8~1bit = ~tm[7:0]
//----------------------------------------------------------

// 9b/10b
reg [3:0] cnt_n_1;

// 新しい8b/9b変換の1,0の数の差異を積算する
// 次に前回のカウンターの値と比較し10bit目のデータ生成を行う
wire [3:0] tm_cnt = tm[0] + tm[1] + tm[2] + tm[3] + tm[4] + tm[5] + tm[6] + tm[7] - 4'd4;
wire sign         = (tm_cnt[3] == cnt_n_1[3]) ? 1'b1 : 1'b0;
wire tm_bit10     = (tm_cnt == 0 || cnt_n_1 == 0) ? ~tm[8] : sign;

// (0 or 2) (+ or -) N0 - N1
wire [3:0] cnt_inc = tm_cnt - ({tm[8] ^ ~sign} & ~(tm_cnt == 0 || cnt_n_1 == 0));

// cnt(t-1) + or - (N0 - N1)
// cnt_n_1のDFFに保存しておくためのwire変数
wire [3:0] cnt_new = (tm_bit10 == 1'b1) ? (cnt_n_1 - cnt_inc) : (cnt_n_1 + cnt_inc);

// bit結合し10bitパラレルデータ作成
// 10bitが1の場合、bit拡張を行いxorすることでbit反転を再現している
wire [9:0] tmds_data = {tm_bit10, tm[8], tm[7:0] ^ {8{tm_bit10}}};


//----------------------------------------------------------
// 新規カウンターの値を保存
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        cnt_n_1 <= 0;
    end else if (iVDE == 1'b1) begin
        cnt_n_1 <= cnt_new;
    end else begin
        cnt_n_1 <= 4'h0;
    end
end


//----------------------------------------------------------
// 出力データ選択
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmds_para <= 0;
    end else if (iVDE == 1'b0) begin
        tmds_para <= tmds_code;
    end else begin
        tmds_para <= tmds_data;
    end
end

// reg signed [4:0] old_bit_cnt = 0;
// wire [4:0] new_bit_cnt = tm[0] + tm[1] + tm[2] + tm[3] + tm[4] + tm[5] + tm[6] + tm[7];
// wire signed [4:0] iold_bit = old_bit_cnt;
// wire [8:0] itm      = tm;

// always @(new_bit_cnt or iold_bit or itm) begin
//     if ((iold_bit == 5'sd0) || (new_bit_cnt == 5'd4)) begin
//         tmds_data <= {~itm[8], itm[8], (itm[8] == 1'b1) ? itm[7:0] : ~itm[7:0]};
//         if (itm[8] == 1'b1) begin
//             old_bit_cnt <= iold_bit + (new_bit_cnt + new_bit_cnt - 5'd8);
//         end else begin 
//             old_bit_cnt <= iold_bit + (5'd8 - new_bit_cnt - new_bit_cnt);
//         end
//     end else if (((iold_bit > 5'sd0) && (new_bit_cnt > 5'd4)) || ((iold_bit < 5'sd0) && (new_bit_cnt < 5'd4))) begin
//         tmds_data   <= {1'b1, itm[8], ~itm[7:0]};
//         old_bit_cnt <= iold_bit + {3'b0, itm[8], 1'b0} + (5'd8 - new_bit_cnt - new_bit_cnt);
//     end else begin
//         tmds_data   <= {1'b0, itm[8], itm[7:0]};
//         old_bit_cnt <= iold_bit - {3'b0, ~itm[8], 1'b0} + (new_bit_cnt + new_bit_cnt - 5'd8);
//     end
// end

endmodule