//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// メモリ専用バスシステム I/F モジュール
// マルチエージェントの機能を持ち、読み込み・書き込み命令は並列に処理される。
// 
// 2022-09-23
// 複数 DMA 転送ブロック接続時の RAM からデータを吸い上げた時の、
// Edd による有効データ出力タイミングのずれを UFIB で吸収できるように更新。
// 
// 2022-10-29
// マルチエージェント機能の一環として、mcs から slave に対してのトランザクションの追加
// 
//----------------------------------------------------------
module UltraFastInterface #(
	// variable parameter
	parameter 							pUfiBusWidth	=  8,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている。 2022-09-14 現在
	parameter							pUsiBusWidth		= 32,	// アドレスBit幅
	parameter							pUfiIdNumber	=  3
)(
    // Internal Port
	// Mcs Master Side
	input [pUfiBusWidth-1:0] 			iMUfiWdMcs,
	input [pUsiBusWidth-1:0] 			iMUfiAdrsMcs,
	input 								iMUfiWEdMcs,
	input 								iMUfiREdMcs,	// データ読み込み命令 Assert 
	input 								iMUfiCmdMcs,
	input 								iMUfiVdMcs,
	// Mcs のアクセスは優先度が一番高いため、Mcs 個別の Rdy 信号は無い、Slaveが動けるかどうかだけ確認する
	//
	input [pUfiBusWidth-1:0] 			iMUfiWdSpi,
	input [pUsiBusWidth-1:0] 			iMUfiAdrsSpi,
	input 								iMUfiEdSpi,
	input 								iMUfiCmdSpi,	// High Read / Lor Write
	input 								iMUfiVdSpi,		// 転送期間中 Assert
	// Vtb Master Side
	input [pUfiBusWidth-1:0] 			iMUfiWdVtb,
	input [pUsiBusWidth-1:0] 			iMUfiAdrsVtb,
	input 								iMUfiWEdVtb,	// 有効データ入力命令 Assert
	input 								iMUfiREdVtb,	// データ読み込み命令 Assert 
	input 								iMUfiCmdVtb,	// High Read / Lor Write
	input 								iMUfiVdVtb,		// 転送期間中 Assert
	output 								oMUfiRdyVtb,	// Vtb に対する Ready 信号
	// Vtb Slave Side
	output [pUfiBusWidth-1:0] 			oSUfiWdVtb,		// Mcs から Vtb に対する書き込みデータ
	output [pUsiBusWidth-1:0] 			oSUfiAdrsVtb,	// Mcs から Vtb に対する書き込みアドレス
	output 								oSUfiWEdVtb,	// Mcs から Vtb に対する書き込み命令
	// Atb Master Side
	input [pUsiBusWidth-1:0] 			iMUfiAdrsAtb,
	input 								iMUfiWEdAtb,	// 有効データ入力命令 Assert
	input 								iMUfiREdAtb,	// データ読み込み命令 Assert
	input 								iMUfiVdAtb,		// 転送期間中 Assert
	output 								oMUfiRdyAtb,	// Atb に対する Ready 信号
	// Ufib SlaveRam -> Master
	output [pUfiBusWidth-1:0] 			oMUfiRd,		// Master に対する 読み込みデータ
	output 								oMUfiEddMcs,	// Master に対する 読み込み有効信号
	output 								oMUfiEddVtb,	// Master に対する 読み込み有効信号
	output 								oMUfiEddAtb,	// Master に対する 読み込み有効信号
	output 								oMUfiRdy,		// Master に対する Ready 信号
	//
	input 	[pUfiIdNumber-1:0]			iMUfiIdI,		// どのブロックからアクセス中かを表す ID
	output	[pUfiIdNumber-1:0]			oMUfiIdO,		// どのブロックからアクセス中かを表す ID
	// Slave Memory Block Side
	output [pUfiBusWidth-1:0] 			oSUfiWdRam,		// Slave に対する 書き込みデータ
	output [pUsiBusWidth-1:0]			oSUfiAdrsRam,	// Slave に対する R/W 共通のアドレス指定バス
	output 								oSUfiWEdRam,	// Slave に対する 書き込み有効信号
	output 								oSUfiREdRam,	// Slave に対する 書き込み有効信号
	output 								oSUfiCmd,		// Slave に対する High Read, Low Write
	input  [pUfiBusWidth-1:0] 			iSUfiRdRam,		// Master に対する 読み込みデータ 
	input  								iSUfiREdRam,	// Master に対する 読み込み有効信号
	input 								iSUfiRdyRam,	// Master に対する Ready 信号
    // CLK Reset
    input								iUfiRst,
    input								iUfiClk 
);


//----------------------------------------------------------
// Valid-then-Ready プロトコル を採用
// ATB は VTB の Rdy 信号を、 VTB は ATB の Rdy 信号を確認し、
// Valid 受信中でも、どちらかの動作が終了するまで待機するようにした。
// 
// Block への Edd 判定を行うために UFIB 内で ID を発行し、
// RAM に対する 読込命令と同時に、Ram FIFO に溜めてある ID も読み出す。
// 
//----------------------------------------------------------
localparam [pUfiIdNumber-1:0]
	lpIdIdol = 0,
	lpIdMcs  = 1,
	lpIdSpi  = 2,
	lpIdVtb  = 3,
	lpIdAtb  = 4;

reg [pUfiBusWidth-1:0]	rMUfiWdRam;			assign oSUfiWdRam 	= rMUfiWdRam;
reg [pUsiBusWidth-1:0]	rMUfiAdrsRam;		assign oSUfiAdrsRam = rMUfiAdrsRam;
reg 					rMUfiWEdRam;		assign oSUfiWEdRam	= rMUfiWEdRam;
reg 					rMUfiREdRam;		assign oSUfiREdRam	= rMUfiREdRam;
reg 					rMUfiCmdRam;		assign oSUfiCmd 	= rMUfiCmdRam;
reg 					rMUfiRdyAtb;		assign oMUfiRdyAtb  = rMUfiRdyAtb;
reg 					rMUfiRdyVtb;		assign oMUfiRdyVtb  = rMUfiRdyVtb;
reg 					rMUfiRdy;			assign oMUfiRdy 	= rMUfiRdy;
reg [pUfiIdNumber-1:0]	rMUfiIdO;			assign oMUfiIdO		= rMUfiIdO;
//
reg [pUfiBusWidth-1:0] 	rSUfiWdVtb;			assign oSUfiWdVtb	= rSUfiWdVtb;
reg [pUsiBusWidth-1:0] 	rSUfiAdrsVtb;		assign oSUfiAdrsVtb	= rSUfiAdrsVtb;
reg 					rSUfiWEdVtb;		assign oSUfiWEdVtb	= rSUfiWEdVtb;

always @(posedge iUfiClk)
begin
	// UFIB 制御ステートマシン、ハブとして機能
	// Master Side
	casex ({iMUfiVdMcs, iMUfiVdSpi, iMUfiVdVtb, iMUfiVdAtb, rMUfiRdyVtb, rMUfiRdyAtb})
		'b1xxx00:	// MCS は優先して制御
		begin
			rMUfiWdRam 		<= iMUfiWdMcs;
			rMUfiAdrsRam 	<= {7'd0,iMUfiAdrsMcs[24:0]};
			rMUfiWEdRam 	<= iMUfiWEdMcs & iMUfiAdrsMcs[25];
			rMUfiREdRam 	<= iMUfiREdMcs & iMUfiAdrsMcs[25];
			rMUfiCmdRam 	<= iMUfiCmdMcs;
			rMUfiRdyAtb 	<= 1'b0;
			rMUfiRdyVtb 	<= 1'b0;
			rMUfiIdO		<= lpIdMcs;
		end
		'b01xxxx:	// SPI は優先して制御
		begin
			rMUfiWdRam 		<= iMUfiWdSpi;
			rMUfiAdrsRam 	<= iMUfiAdrsSpi;
			rMUfiWEdRam 	<= iMUfiEdSpi;
			rMUfiREdRam 	<= 1'b0;
			rMUfiCmdRam 	<= iMUfiCmdSpi;	// debug 用に R/W 両方
			rMUfiRdyAtb 	<= 1'b0;
			rMUfiRdyVtb 	<= 1'b0;
			rMUfiIdO		<= lpIdSpi;
		end
		'b001xx0:	// Vtb
		begin
			rMUfiWdRam	 	<= iMUfiWdVtb;
			rMUfiAdrsRam 	<= iMUfiAdrsVtb;
			rMUfiWEdRam 	<= iMUfiWEdVtb;
			rMUfiREdRam 	<= iMUfiREdVtb;
			rMUfiCmdRam 	<= iMUfiCmdVtb;	// フレームバッファの R/W があるため 両対応
			rMUfiRdyAtb		<= 1'b0;
			rMUfiRdyVtb		<= 1'b1;		// Vtb 動作中
			rMUfiIdO		<= lpIdVtb;
		end
		'b00x10x:	// Atb
		begin
			rMUfiWdRam	 	<= 'h00000000;
			rMUfiAdrsRam 	<= iMUfiAdrsAtb;
			rMUfiWEdRam 	<= iMUfiWEdAtb;
			rMUfiREdRam 	<= iMUfiREdAtb;
			rMUfiCmdRam 	<= 1'b1;		// Atb は Ram に書き込むことはないため読み込み固定
			rMUfiRdyAtb		<= 1'b1;		// Atb 動作中
			rMUfiRdyVtb		<= 1'b0;
			rMUfiIdO		<= lpIdAtb;
		end
		default:
		begin
			rMUfiWdRam 		<= 'h12345678;
			rMUfiAdrsRam 	<= 'hffffffff;
			rMUfiWEdRam 	<= 1'b0;
			rMUfiREdRam 	<= 1'b0;
			rMUfiCmdRam 	<= 1'b0;
			rMUfiRdyAtb 	<= 1'b0;		// 全てのRdy Dessert で 受付可能
			rMUfiRdyVtb 	<= 1'b0;
			rMUfiIdO		<= lpIdIdol;
		end
	endcase
	//
	if (iUfiRst)	rMUfiRdy <= 1'b0;
	else 			rMUfiRdy <= iSUfiRdyRam;
	//
	rSUfiWdVtb		<=	iMUfiWdMcs;
	rSUfiAdrsVtb	<=	iMUfiAdrsMcs;

	if (iUfiRst) 	rSUfiWEdVtb <= 1'b0;
	else 			rSUfiWEdVtb <= iMUfiWEdMcs & iMUfiAdrsMcs[26];
end


//-----------------------------------------------------------------------------
// ID による、取得データの振り分け
//-----------------------------------------------------------------------------
reg [pUfiBusWidth-1:0] 	rMUfiRd;			assign oMUfiRd  	= rMUfiRd;
reg 					rMUfiEddMcs;		assign oMUfiEddMcs 	= rMUfiEddMcs;
reg 					rMUfiEddVtb;		assign oMUfiEddVtb 	= rMUfiEddVtb;
reg 					rMUfiEddAtb;		assign oMUfiEddAtb 	= rMUfiEddAtb;
reg 					qIdCkeMcs;
reg 					qIdCkeVtb;
reg 					qIdCkeAtb;

always @(posedge iUfiClk)
begin
	rMUfiRd	<= iSUfiRdRam;

	if (iUfiRst)		rMUfiEddMcs <= 1'b0;
	else if (qIdCkeMcs)	rMUfiEddMcs <= iSUfiREdRam;
	else 				rMUfiEddMcs <= 1'b0;

	if (iUfiRst)		rMUfiEddVtb <= 1'b0;
	else if (qIdCkeVtb)	rMUfiEddVtb <= iSUfiREdRam;
	else 				rMUfiEddVtb <= 1'b0;

	if (iUfiRst)		rMUfiEddAtb <= 1'b0;
	else if (qIdCkeAtb)	rMUfiEddAtb <= iSUfiREdRam;
	else 				rMUfiEddAtb <= 1'b0;
end

always @*
begin
	qIdCkeMcs <= (iMUfiIdI == lpIdMcs);
	qIdCkeVtb <= (iMUfiIdI == lpIdVtb);
	qIdCkeAtb <= (iMUfiIdI == lpIdAtb);
end

endmodule