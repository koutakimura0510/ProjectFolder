/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの制御配列参照用Rp生成
 */
module oledRp
#(
    parameter INIT_CMDMAX  = 17,
    parameter WRITE_CMDMAX = 9
)(
    input 			iCLK,		    // System Clock
    input 			iRST,		    // System Reset
    input           iEnable,        // 1byteデータ送信完了時High
    output [4:0]    oAddrInit,      // 初期設定配列参照アドレス
    output [3:0]    oAddrCmd,       // 座標更新配列参照アドレス
    output          oInitEnable,    // 初期化完了時High
    output          oCmdEnable      // コマンド完了時High
);


//----------------------------------------------------------
// アドレス更新用初期化romの配列長
//----------------------------------------------------------
localparam INIT_LENGTH  = (INIT_CMDMAX - 1);
localparam WRITE_LENGTH = (WRITE_CMDMAX - 1);


// アドレス送信
reg [4:0] init_rp;      assign oAddrInit = init_rp;     // 初期設定コマンド配列参照用
reg [3:0] cmd_rp;       assign oAddrCmd  = cmd_rp;      // 座標更新コマンド配列参照用
assign oInitEnable = (init_rp == INIT_LENGTH) ? 1'b1 : 1'b0;
assign oCmdEnable  = (cmd_rp  == WRITE_LENGTH) ? 1'b1 : 1'b0;


// コマンド発行配列のrp更新
// 初期化コマンド発行後は書き込み座標更新用のrp更新に切り替える
// Rp更新モードの時だけレジスタの値を変更する
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        init_rp <= 5'd0;
    end else if (iEnable == 1'b1) begin
        if (init_rp == INIT_LENGTH) begin
            init_rp <= INIT_LENGTH;
        end else begin
            init_rp <= init_rp + 5'd1;
        end
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        cmd_rp <= 0;
    end else if (iEnable == 1'b1 && init_rp == INIT_LENGTH) begin
        if (cmd_rp == WRITE_LENGTH) begin
            cmd_rp <= WRITE_LENGTH;
        end else begin
            cmd_rp <= cmd_rp + 4'd1;
        end
    end
end

endmodule