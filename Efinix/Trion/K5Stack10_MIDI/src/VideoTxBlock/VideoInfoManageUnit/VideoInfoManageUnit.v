/**-----------------------------------------------------------------------------
 * 外部 module と通信を行い、ビデオデータの管理を司る
 * [47:32] Burst Length				Min 1〜, "0" NG
 * [31:31] Enable Bit				"1" Enable,   	"1" Disable
 * [30:30] R/W Select Bit			"1" WriteCmd,	"0" ReadCmd
 * [29:29] NC
 * [28: 0] Memory R/W Start Adrs	Max 512[MB] 
 *
 * 24-03-09 v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module VideoInfoManageUnit #(
	parameter 		pUfiBusWidth 		= 48
)(
	// Ufi Bus Master Read
	input	[pUfiBusWidth-1:0] 		iMUfiRd,
	input							iMUfiVd,
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0] 		oMUfiWd,
	input							iMUfiRdy,
	// Control Status
	output	[31:0]					oVideoBramDq,	// Ext Ram から読み出したビデオデータ
	output	[31:0]					oVideoBramAdrs,	// 書き込み先のアドレス
	output							oVideoBramWe,
	input							iHsyncEndIntr,	// HSYNC 
	input							iVsyncEndIntr,	// VSYNC
	//　
	input							iVramAdrs,		// 
	// CLK Rst
	input 							iSRST,
	input 							inSRST,
	input 							iSCLK
);

/**----------------------------------------------------------------------------
 * マップ ID に応じて UFIB 経由で画像データ Read 要求を発行
 * Local 内にも発行の順番で ID を保持しておき、UFIB の Enable を検出したら、
 * ID の順番で後段へデータを振り分ける。
 *---------------------------------------------------------------------------*/
//  * レイヤーの並び順は下記の通りである。
//  * Field			:ワールドマップ・フィールドマップ
//  * NPC			:プレイヤー以外のキャラクター
//  * Player		:操作キャラクター
//  * Object		:宝箱などのオブジェクトと、滝の裏側など通過できるフィールドのこと
//  * Field2		:ドラクエ5 のエルヘブンのような立体感のあるマップを生成するのに必要
//  * Effect		:戦闘エフェクト描画、フィールドエフェクトはない予定
//  * Foreground	:前景、霧や光源など
//  * Menu			:ウィンドウメニュー
//  * Scene			:シーンチェンジ

/**----------------------------------------------------------------------------
 * 
 *---------------------------------------------------------------------------*/
reg [47:0] 	qMUfiWd;						assign oMUfiWd <= qMUfiWd;
reg [28:0] 	rUfibAdrs;
reg			rUfibEn;
reg			qUfibRst,	qUfibCke;
reg [8:0]	rDispLineCnt;			// 描画中のライン箇所
reg [8:0]	rDrawLineCnt;			// 描画データのライン箇所

always @(posedge iCLK)
begin
	if (qUfibRst)			rUfibAdrs	<= 29'd0;
	else if (qUfibCke)		rUfibAdrs	<= rUfibAdrs + 10'd1024;
	else 					rUfibAdrs	<= rUfibAdrs;
	
	if (qUfibRst)			rUfibEn		<= 1'd0;
	else if (qUfibCke)		rUfibEn		<= 1'b1;
	else 					rUfibEn		<= 1'b0;
	
	if (qUfibRst)			rDispLineCnt <= 9'd0;
	else if (iHsyncEndIntr) rDispLineCnt <= rDispLineCnt + 1'b1;
	else 					rDispLineCnt <= rDispLineCnt;
	
	if (qUfibRst)			rDrawLineCnt <= 9'd0;
	else if (qUfibCke)		rDrawLineCnt <= rDrawLineCnt + 1'b1;
	else 					rDrawLineCnt <= rDrawLineCnt;
end

always @*
begin
	qUfibRst 		<= |{iRST,};
	qUfibCke		<= 
	qMUfiWd[47:32]	<= 16'd1023;
	qMUfiWd[31:31]	<= rUfibEn;
	qMUfiWd[30:30]	<= 1'b0;
	qMUfiWd[29:29]	<= 1'b0;
	qMUfiWd[28: 0]	<= rUfibAdrs;
end

endmodule