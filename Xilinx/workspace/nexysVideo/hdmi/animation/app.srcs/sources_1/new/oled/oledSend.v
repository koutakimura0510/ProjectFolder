/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの送信データ制御
 */
module oledSend
(
    input 			iCLK,		    // System Clock
    input 			iRST,		    // System Reset

    // 状態制御信号
    input           iInitEnable,    // 初期化完了時High
    input           iCmdEnable,     // コマンド完了時High

    // data
    input [7:0]     iInitData,      // 初期化データ
    input [7:0]     iCmdData,       // コマンドデータ
    input [7:0]     iDispData,      // 表示データ
    output [7:0]    oSendData       // 送信データ
);


//----------------------------------------------------------
// 制御データ送信
//----------------------------------------------------------
reg [7:0] senddata;     assign oSendData    = senddata;


//----------------------------------------------------------
// 送信データ制御
// それぞれ初期設定コマンドデータ、書き込み範囲設定データ、描画データの順番で送信する
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        senddata <= iInitData;
    end else begin
        if (iInitEnable == 1'b0) begin
            senddata <= iInitData;
        end else if (iCmdEnable == 1'b0) begin
            senddata <= iCmdData;
        end else begin
            senddata <= iDispData;
        end
    end
end

endmodule