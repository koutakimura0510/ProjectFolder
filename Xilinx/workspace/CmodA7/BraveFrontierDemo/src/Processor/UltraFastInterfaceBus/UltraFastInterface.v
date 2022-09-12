//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// メモリ専用バスシステム I/F モジュール
// 
//----------------------------------------------------------
module UltraFastInterface #(
	// variable parameter
	parameter 							pUfiBusWidth	= 16,	// Bus幅
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
	input 								iMUfiVdSpi,
	input 								iMUfiCmdSpi,
	//
	input [pUfiBusWidth-1:0] 			iMUfiWdVtb,
	input [pBusAdrsBit-1:0] 			iMUfiAdrsVtb,
	input 								iMUfiEdVtb,
	input 								iMUfiVdVtb,
	input 								iMUfiCmdVtb,
	output 								oMUfiRdyVtb,
	//
	input [pBusAdrsBit-1:0] 			iMUfiAdrsAtb,
	input 								iMUfiEdAtb,
	input 								iMUfiVdAtb,
	output 								oMUfiRdyAtb,
	// 
	output [pUfiBusWidth-1:0] 			oMUfiRd,		// Master に対する読み込みデータ
	output 								oMUfiREd,		// Master に対する読み込み有効信号
	// Slave Memory Block Side
	output [pUfiBusWidth-1:0] 			oSUfiWdRam,		// Slave に対する書き込みデータ
	output [pBusAdrsBit-1:0]			oSUfiAdrsRam,	// Slave に対する R/W 共通のアドレス指定バス
	output 								oSUfiEdRam,		// Slave に対する書き込み有効信号
	output 								oSUfiCmd,		// Slave に対する Assert Read, Low Write
	input 								iSUfiRdy,
	input  [pUfiBusWidth-1:0] 			iSUfiRdRam,		// Master に対する 読み込みデータ 
	input  								iSUfiREdRam,	// Master に対する 読み込み有効信号
    // CLK Reset
    input								iUfiRst,
    input								iUfiClk 
);


//----------------------------------------------------------
// ATB は VTB の Rdy 信号を、 VTB は ATB の Rdy 信号を確認し、
// Valid 受信中でも、どちらかの動作が終了するまで待機するようにした。
// 
// メモリアクセス優先順位
// 1.MCS
// 2.SPI
// 3.ATB
// 4.VTB
//----------------------------------------------------------
reg [pUfiBusWidth-1:0] 	rMUfiRd;			assign oMUfiRd  	= rMUfiRd;
reg 					rMUfiREd;			assign oMUfiREd 	= rMUfiREd;
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
		'b1xxxxx:
		begin
			rMUfiWd 	<= iMUfiWdMcs;
			rMUfiAdrs 	<= iMUfiAdrsMcs;
			rMUfiEd 	<= iMUfiEdMcs;
			rMUfiCmd 	<= 1'b0;		// mcs は 書き込み固定
			rMUfiRdyAtb <= 1'b0;
			rMUfiRdyVtb <= 1'b0;
		end
		'b01xxxx:
		begin
			rMUfiWd 	<= iMUfiWdSpi;
			rMUfiAdrs 	<= iMUfiAdrsSpi;
			rMUfiEd 	<= iMUfiEdSpi;
			rMUfiCmd 	<= iMUfiCmdSpi;	// debug 用に R/W 両方
			rMUfiRdyAtb <= 1'b0;
			rMUfiRdyVtb <= 1'b0;
		end
		'b00x10x:
		begin
			rMUfiWd 	<= 'h00000000;
			rMUfiAdrs 	<= iMUfiAdrsAtb;
			rMUfiEd 	<= iMUfiEdAtb;
			rMUfiCmd 	<= 1'b1;		// Atb は 読み込み固定
			rMUfiRdyAtb	<= 1'b1;
			rMUfiRdyVtb	<= 1'b0;
		end
		'b001xx0:
		begin
			rMUfiWd 	<= iMUfiWdVtb;
			rMUfiAdrs 	<= iMUfiAdrsVtb;
			rMUfiEd 	<= iMUfiEdVtb;
			rMUfiCmd 	<= iMUfiCmdVtb;	// フレームバッファの R/W があるため 両対応
			rMUfiRdyAtb	<= 1'b0;
			rMUfiRdyVtb	<= 1'b1;
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
	rMUfiRd	<= iSUfiRdRam;

	if (iUfiRst) 			rMUfiREd <= 1'b0;
	else if (iSUfiREdRam)	rMUfiREd <= 1'b1;
	else 					rMUfiREd <= 1'b0;
end


endmodule