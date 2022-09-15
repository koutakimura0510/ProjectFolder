//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// メモリ専用バスシステム I/F モジュール
// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている。 2022-09-14 現在
// 
//----------------------------------------------------------
module UltraFastInterface #(
	// variable parameter
	parameter 							pUfiBusWidth	=  8,	// Bus幅
	parameter							pBusAdrsBit		= 32	// アドレスBit幅
)(
    // Internal Port
	// Master -> Slave
	input [pUfiBusWidth-1:0] 			iMUfiWdMcs,
	input [pBusAdrsBit-1:0] 			iMUfiAdrsMcs,
	input 								iMUfiEdMcs,
	input 								iMUfiVdMcs,
	//
	input [pUfiBusWidth-1:0] 			iMUfiWdSpi,
	input [pBusAdrsBit-1:0] 			iMUfiAdrsSpi,
	input 								iMUfiEdSpi,
	input 								iMUfiVdSpi,		// 転送期間中 Assert
	input 								iMUfiCmdSpi,	// High Read / Lor Write
	//
	input [pUfiBusWidth-1:0] 			iMUfiWdVtb,
	input [pBusAdrsBit-1:0] 			iMUfiAdrsVtb,
	input 								iMUfiEdVtb,
	input 								iMUfiVdVtb,		// 転送期間中 Assert
	input 								iMUfiCmdVtb,	// High Read / Lor Write
	output 								oMUfiRdyVtb,	// Vtb に対する Ready 信号
	//
	input [pBusAdrsBit-1:0] 			iMUfiAdrsAtb,
	input 								iMUfiEdAtb,
	input 								iMUfiVdAtb,		// 転送期間中 Assert
	output 								oMUfiRdyAtb,	// Atb に対する Ready 信号
	// 
	output [pUfiBusWidth-1:0] 			oMUfiRd,		// Master に対する 読み込みデータ
	output 								oMUfiREd,		// Master に対する 読み込み有効信号
	output 								oMUfiRdy,		// Master に対する Ready 信号
	// Slave Memory Block Side
	output [pUfiBusWidth-1:0] 			oSUfiWdRam,		// Slave に対する 書き込みデータ
	output [pBusAdrsBit-1:0]			oSUfiAdrsRam,	// Slave に対する R/W 共通のアドレス指定バス
	output 								oSUfiEdRam,		// Slave に対する 書き込み有効信号
	output 								oSUfiCmd,		// Slave に対する High Read, Low Write
	input  [pUfiBusWidth-1:0] 			iSUfiRdRam,		// Master に対する 読み込みデータ 
	input  								iSUfiREdRam,	// Master に対する 読み込み有効信号
	input 								iSUfiRdyRam,	// Master に対する Ready 信号
    // CLK Reset
    input								iUfiRst,
    input								iUfiClk 
);


//----------------------------------------------------------
// ATB は VTB の Rdy 信号を、 VTB は ATB の Rdy 信号を確認し、
// Valid 受信中でも、どちらかの動作が終了するまで待機するようにした。
// 
// また RCmd 発行後 から 実際のデータ読み込みまでタイムラグがあり、
// いくつかのレイテンシが発生する。RAM 側で アドレスを判定して
// タイミングがずれていても ATB や VTB にデータを振り分ける制御線を作ってもよかったが、
// アクセスするブロックが増えた場合にソース管理が面倒になるので止めた。
// 
// 解決策として、ATB,VTB ブロック内に、RCmd 発行回数とデータの読み込み回数の
// カウンタを用意しておき、比較することで指定回数受信したことを判定するようにする。
// こうするとブロック内で変更を完結できるようになる。
// 
// メモリアクセス優先順位
// 1.MCS
// 2.SPI
// 3.ATB
// 4.VTB
//----------------------------------------------------------
reg [pUfiBusWidth-1:0] 	rMUfiRd;			assign oMUfiRd  	= rMUfiRd;
reg 					rMUfiREd;			assign oMUfiREd 	= rMUfiREd;
reg 					rMUfiRdy;			assign oMUfiRdy 	= rMUfiRdy;
//
reg [pUfiBusWidth-1:0]	rMUfiWd;			assign oSUfiWdRam 	= rMUfiWd;
reg [pBusAdrsBit-1:0]	rMUfiAdrs;			assign oSUfiAdrsRam = rMUfiAdrs;
reg 					rMUfiEd;			assign oSUfiEdRam	= rMUfiEd;
reg 					rMUfiCmd;			assign oSUfiCmd 	= rMUfiCmd;
reg 					rMUfiRdyAtb;		assign oMUfiRdyAtb  = rMUfiRdyAtb;
reg 					rMUfiRdyVtb;		assign oMUfiRdyVtb  = rMUfiRdyVtb;

always @(posedge iUfiClk)
begin
	casex ({iMUfiVdMcs, iMUfiVdSpi, iMUfiVdVtb, iMUfiVdAtb, rMUfiRdyVtb, rMUfiRdyAtb})
		'b1xxxxx:	// MCS は優先して制御
		begin
			rMUfiWd 	<= iMUfiWdMcs;
			rMUfiAdrs 	<= iMUfiAdrsMcs;
			rMUfiEd 	<= iMUfiEdMcs;
			rMUfiCmd 	<= 1'b0;		// mcs は 書き込み固定
			rMUfiRdyAtb <= 1'b0;
			rMUfiRdyVtb <= 1'b0;
		end
		'b01xxxx:	// SPI は優先して制御
		begin
			rMUfiWd 	<= iMUfiWdSpi;
			rMUfiAdrs 	<= iMUfiAdrsSpi;
			rMUfiEd 	<= iMUfiEdSpi;
			rMUfiCmd 	<= iMUfiCmdSpi;	// debug 用に R/W 両方
			rMUfiRdyAtb <= 1'b0;
			rMUfiRdyVtb <= 1'b0;
		end
		'b00x10x:	// Vtb 稼働中 OFF
		begin
			rMUfiWd 	<= 'h00000000;
			rMUfiAdrs 	<= iMUfiAdrsAtb;
			rMUfiEd 	<= iMUfiEdAtb;
			rMUfiCmd 	<= 1'b1;		// Atb は 読み込み固定
			rMUfiRdyAtb	<= 1'b1;		// Atb 動作中
			rMUfiRdyVtb	<= 1'b0;
		end
		'b001xx0:	// Atb 稼働中 OFF
		begin
			rMUfiWd 	<= iMUfiWdVtb;
			rMUfiAdrs 	<= iMUfiAdrsVtb;
			rMUfiEd 	<= iMUfiEdVtb;
			rMUfiCmd 	<= iMUfiCmdVtb;	// フレームバッファの R/W があるため 両対応
			rMUfiRdyAtb	<= 1'b0;
			rMUfiRdyVtb	<= 1'b1;		// Vtb 動作中
		end
		default:
		begin
			rMUfiWd 	<= 'h12345678;
			rMUfiEd 	<= 1'b0;
			rMUfiAdrs 	<= 'hffffffff;
			rMUfiCmd 	<= 1'b1;
			rMUfiRdyAtb <= 1'b0;
			rMUfiRdyVtb <= 1'b0;
		end
	endcase
	//
	rMUfiRd		<= iSUfiRdRam;
	rMUfiRdy 	<= iSUfiRdyRam;

	if (iUfiRst) 			rMUfiREd <= 1'b0;
	else if (iSUfiREdRam)	rMUfiREd <= 1'b1;
	else 					rMUfiREd <= 1'b0;
end

endmodule