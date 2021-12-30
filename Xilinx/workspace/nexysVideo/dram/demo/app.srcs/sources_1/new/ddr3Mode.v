/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3enable信号に応じた現在のモードを管理
 */
module ddr3Mode (
    input           iCLK,
    input           iRST,
    input           iInitEnable,
    input           iActiveEnable,
    input           iWriteEnable,
    input           iReadEnable,
    input           iWRComplete,
    output [3:0]    oDDR3_Mode
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
    DDR3_PREA   = 5,    // プリチャージコマンド発行
    DDR3_WWAIT  = 6,
    DDR3_RWAIT  = 7;

localparam WAIT_MAX = 8;

reg [3:0] ddr3_state = DDR3_INIT;   assign oDDR3_Mode = ddr3_state;
reg [3:0] wait_cycle;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wait_cycle <= 0;
    end else begin
        case (ddr3_state)
            DDR3_WWAIT: begin
                wait_cycle <= wait_cycle + 1'b1;
            end

            DDR3_RWAIT: begin
                wait_cycle <= wait_cycle + 1'b1;
            end

            default begin
                wait_cycle <= 0;
            end
        endcase
    end
end


//----------------------------------------------------------
// 状態制御ステートマシン
// 連続送信やバンク切り替え制御などが必要だが、とりあえず動作確認したいため保留
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        ddr3_state <= DDR3_INIT;
    end else begin
        case (ddr3_state)
            DDR3_INIT: begin
                if (iInitEnable == 1'b1) begin
                    ddr3_state <= DDR3_IDLE;
                end else begin
                    ddr3_state <= DDR3_INIT;
                end
            end

            DDR3_IDLE: begin
                if (iActiveEnable == 1'b1) begin
                    ddr3_state <= DDR3_ACTIVE;
                end else begin
                    ddr3_state <= DDR3_IDLE;
                end
            end

            DDR3_ACTIVE: begin
                if (iWriteEnable == 1'b1) begin
                    ddr3_state <= DDR3_WWAIT;
                end else if (iReadEnable == 1'b1) begin
                    ddr3_state <= DDR3_RWAIT;
                end else begin
                    ddr3_state <= DDR3_ACTIVE;
                end
            end

            DDR3_WWAIT: begin
                if (wait_cycle == WAIT_MAX) begin
                    ddr3_state <= DDR3_WRITE;
                end else begin
                    ddr3_state <= DDR3_WWAIT;
                end
            end

            DDR3_RWAIT: begin
                if (wait_cycle == WAIT_MAX) begin
                    ddr3_state <= DDR3_READ;
                end else begin
                    ddr3_state <= DDR3_RWAIT;
                end
            end

            DDR3_WRITE: begin
                if (iWRComplete == 1'b1) begin
                    ddr3_state <= DDR3_IDLE;
                end else begin
                    ddr3_state <= DDR3_WRITE;
                end
            end

            DDR3_READ: begin
                if (iWRComplete == 1'b1) begin
                    ddr3_state <= DDR3_IDLE;
                end else begin
                    ddr3_state <= DDR3_READ;
                end
            end

            DDR3_PREA: begin
                ddr3_state <= DDR3_IDLE;
            end

            default: begin
                ddr3_state <= DDR3_IDLE;
            end
        endcase
    end
end

endmodule