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
#(
parameter INIT_CMDMAX  = 17,
parameter WRITE_CMDMAX = 9
)(
input 			iCLK,		    // System Clock
input 			iRST,		    // System Reset
input           iEnable,        // 1byteデータ送信完了時High
output [4:0]    oAddrInit,      // 初期設定配列参照アドレス
output [3:0]    oAddrCmd        // 座標更新配列参照アドレス
);

endmodule