//----------------------------------------------------------
// Create 2022/11/18
// Author koutakimura
// -
// Ufi-Slave-I/F を持つ module で BRAM にデータが
// 
//----------------------------------------------------------
module SlaveUfiAllocation #(
	// variable parameter
	parameter 							pUfiBusWidth	  =  8,	// 
	parameter							pBusAdrsBit		  = 32,	// アドレスBit幅
	parameter							pUfiAllocationNum =  9
)(
    // Internal Port
	// Slave write data
	input [pUfiBusWidth-1:0] 			iSUfiWd,
	input [pBusAdrsBit-1:0] 			iSUfiWAdrs,
	input 								iSUfiWEd,
	// 
	output [pUfiBusWidth-1:0] 			oSUfiWd,				// Slave に対する 書き込みデータ
	output [pBusAdrsBit-1:0]			oSUfiAdrs,				// Slave に対する R/W 共通のアドレス指定バス
	output 								oSUfiWEd,				// Slave に対する 書き込み有効信号
    // CLK Reset
    input								iRst,
    input								iClk
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
reg [pBusAdrsBit-1:0]	rMUfiAdrsRam;		assign oSUfiAdrsRam = rMUfiAdrsRam;
reg 					rMUfiWEdRam;		assign oSUfiWEdRam	= rMUfiWEdRam;
reg 					rMUfiREdRam;		assign oSUfiREdRam	= rMUfiREdRam;
reg 					rMUfiCmdRam;		assign oSUfiCmd 	= rMUfiCmdRam;
reg 					rMUfiRdyAtb;		assign oMUfiRdyAtb  = rMUfiRdyAtb;
reg 					rMUfiRdyVtb;		assign oMUfiRdyVtb  = rMUfiRdyVtb;
reg 					rMUfiRdy;			assign oMUfiRdy 	= rMUfiRdy;
reg [pUfiIdNumber-1:0]	rMUfiIdO;			assign oMUfiIdO		= rMUfiIdO;
//
reg [pUfiBusWidth-1:0] 	rSUfiWdVtb;			assign oSUfiWdVtb	= rSUfiWdVtb;
reg [pBusAdrsBit-1:0] 	rSUfiAdrsVtb;		assign oSUfiAdrsVtb	= rSUfiAdrsVtb;
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
	rSUfiAdrsVtb	<=	{7'd0,iMUfiAdrsMcs[24:0]};

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