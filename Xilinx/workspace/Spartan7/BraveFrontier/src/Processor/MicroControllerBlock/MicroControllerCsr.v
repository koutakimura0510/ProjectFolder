//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// コントロール・ステータス・レジスタ
// [Write]
// iCke Assert を確認し指定アドレスのレジスタに iWd のデータを書き込む。
// 
// [Read]
// 読み込みの場合はアドレスを変更するだけにする。
// ハンドシェイク信号は用意せずに、iAdrs の入力アドレスに応じて、
// レジスタ値を常時出力しておくことで、アドレス指定後に oRd の値を確認すれば、
// レジスタ値を取得することができる。
// 
// [Latency]
// W/R ともにレイテンシはレジスタ経由のため 1 とする。
// レイテンシによる遅延は上位モジュールが調整することとし、他の Csr と仕様を合わせるとする。
// 
// 
//----------------------------------------------------------
module MicroControllerCsr (
    // Internal Port
	// Csr Ctl
	input  [31:0]	iWd,		// Write Data
	input  [31:0]	iAdrs,		// アドレス指定
	input 			iCke,		// 有効データ書き込み時 Assert
	output [31:0]	oRd,		// Read Data
    // CLK Reset
    input           iSysClk,
    input           iSysRst
);



endmodule