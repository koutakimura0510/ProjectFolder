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


// アドレス送信
reg [4:0] init_rp;      assign oAddrInit = init_rp;     // 初期設定コマンド配列参照用
reg [3:0] cmd_rp;       assign oAddrCmd  = cmd_rp;      // 座標更新コマンド配列参照用
assign oInitEnable = (init_rp == INIT_CMDMAX)  ? 1'b1 : 1'b0;
assign oCmdEnable  = (cmd_rp  == WRITE_CMDMAX) ? 1'b1 : 1'b0;

//----------------------------------------------------------
// 制御コマンド更新を管理する状態制御定数
//----------------------------------------------------------
localparam [1:0]
    SEND_STATE_WAIT   = 2'd0,
    SEND_STATE_ON     = 2'd1,
    SEND_STATE_BRIDGE = 2'd2;

// コマンド配列参照用rpの更新方法制御変数
reg [1:0] send_state;


//----------------------------------------------------------
// 配列参照用アドレスの更新
//----------------------------------------------------------

// rp更新ステートマシンの制御
// 指定バイト送信完了のEnable信号の立ち上がり時に配列参照用Rpの更新を行いたい。
// 立ち上がり判定用にシフトレジスタを用意しても良かったが、容量がもったいなく感じた。
// そのため、立ち上がりのHigh判定用と立下りのLow判定用のモードのほかに、一度だけ実行されるRp更新用のモードを設けた
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        send_state <= SEND_STATE_WAIT;
    end else begin
        case (send_state)
            SEND_STATE_WAIT: begin 
                send_state <= (iEnable == 1'b1) ? SEND_STATE_ON : SEND_STATE_WAIT;
            end

            SEND_STATE_ON: begin 
                send_state <= SEND_STATE_BRIDGE;
            end

            SEND_STATE_BRIDGE: begin
                send_state <= (iEnable == 1'b0) ? SEND_STATE_WAIT : SEND_STATE_BRIDGE;
            end

            default: begin 
                send_state <= SEND_STATE_WAIT;
            end
        endcase
    end
end

// コマンド発行配列のrp更新
// 初期化コマンド発行後は書き込み座標更新用のrp更新に切り替える
// Rp更新モードの時だけレジスタの値を変更する
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        init_rp <= 5'd0;
        cmd_rp <= 4'd0;
    end else if (send_state == SEND_STATE_ON) begin
        if (init_rp != INIT_CMDMAX) begin
            init_rp <= init_rp + 5'd1;
        end else if (cmd_rp == WRITE_CMDMAX) begin
            cmd_rp <= 4'd0;
        end else begin
            cmd_rp <= cmd_rp + 4'd1;
        end
    end
end

endmodule