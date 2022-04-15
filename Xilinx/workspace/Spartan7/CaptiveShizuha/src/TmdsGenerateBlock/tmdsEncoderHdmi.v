/*
 * Create 2021/12/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * DVI/TMDS信号の送信データの符号化処理を行う
 * 
 * 8b/10b -> ビデオデータ
 * 2b/10b -> H/VSync
 * 4b/10b -> 補助データ（パケット・Audioなど）
 */

module tmdsEncoderDvi(
    input           iClk,           // pll clk
    input           iRst,           // system rst
    input [7:0]     iVideoData,     // r or g or b video data
    input [1:0]     iCD,
    input           iVDE,           // High to display on
    output [9:0]    oTmdsPara
);

reg [9:0] tmds_para;        assign oTmdsPara = tmds_para;

reg [3:0] bal_acc;
wire [3:0] nb1s = vd[0] + vd[1] + vd[2] + vd[3] + vd[4] + vd[5] + vd[6] + vd[7];
wire XNOR = (nb1s > 4'd4) || (nb1s == 4'd4 && vd[0] == 1'b0);
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ vd[7:1] ^ {7{XNOR}}, vd[0]};
wire [3:0] bal = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;
wire bal_sign_eq = (bal[3] == bal_acc[3]);
wire invert_q_m = (bal == 0 || bal_acc == 0) ? ~q_m[8] : bal_sign_eq;
wire [3:0] bal_acc_inc = bal - ({q_m[8] ^ ~bal_sign_eq} & ~(bal == 0 || bal_acc == 0));
wire [3:0] bal_acc_new = invert_q_m ? bal_acc - bal_acc_inc : bal_acc + bal_acc_inc;
wire [9:0] tmds_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
wire [9:0] tmds_code = cd[1] ? (cd[0] ? 10'b1010101011 : 10'b0101010100) : (cd[0] ? 10'b0010101011 : 10'b1101010100);

00:1101010100
01:0010101011
10:0101010100
11:1010101011

always @(posedge iClk) begin
    if (iRst == 1'b1) begin
        tmds_para <= 0;
    end else if (iVDE == 1'b1) begin
        tmds_para <= tmds_data;
    end else begin
        tmds_para <= tmds_code;
    end
end

always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        bal_acc <= 0;
    end else begin
        bal_acc <= vde ? bal_acc_new : 4'h0;
    end
end


endmodule