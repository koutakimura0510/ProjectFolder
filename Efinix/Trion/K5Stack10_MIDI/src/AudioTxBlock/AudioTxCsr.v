/*-----------------------------------------------------------------------------
 * [Csr 規則]
 * 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
 * 上位モジュールへの output port は必ずレジスタ経由で出力する。
 *
 * 23-09-02 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module AudioTxCsr #(
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth 	= 8,
	parameter pSfmNum			= 3,
	parameter pSfmPageWidth		= 16,
	parameter p_non_variable 	= 0
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Csr Output
	output 	[pSfmNum-1:0]					oSfmIoHiz,
	output 	[pSfmNum-1:0]					oSfmEn,				// ※1
	output 	[pSfmNum-1:0]					oSfmCycleEn,
	output 	[(pSfmNum*8)-1:0]				oSfmDiv,
	output 	[(pSfmNum*8)-1:0]				oSfmCsHoldTime,
	output 	[(pSfmNum*pSfmPageWidth)-1:0]	oSfmStartAdrs,		// ※2
	output 	[(pSfmNum*pSfmPageWidth)-1:0]	oSfmEndAdrs,		// ※2
	input	[pSfmNum-1:0]					iSfmDone,
	output	[(pSfmNum*8)-1:0]				oSfmCpuWd,
	output	[pSfmNum-1:0]					oSfmCpuEn,
	output	[pSfmNum-1:0]					oSfmCpuCsCtrl,
	output	[pSfmNum-1:0]					oSfmCpuValid,
	input	[(pSfmNum*8)-1:0]				iSfmCpuRd,
	input	[pSfmNum-1:0]					iSfmCpuDone,
	// CLK RST
	input 	iSRST,
	input 	iSCLK
);

// ※1 Sfm = Serial Flash Memory 略称
// ※1 Sfm は音源データ読み込みなので Write は必要ない
// ※2 現時点では 1Page の開始と終了をアドレス設定する必要あり。Col 毎の読み込みには対応していない

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pSfmNum-1:0]  					rSfmIoHiz;				assign oSfmIoHiz 		= rSfmIoHiz;
reg [pSfmNum-1:0]  					rSfmEn;					assign oSfmEn 			= rSfmEn;
reg [pSfmNum-1:0]  					rSfmCycleEn;			assign oSfmCycleEn 		= rSfmCycleEn;
reg [(pSfmNum*8)-1:0]				rSfmDiv;				assign oSfmDiv 			= rSfmDiv;
reg [(pSfmNum*8)-1:0]				rSfmCsHoldTime;			assign oSfmCsHoldTime 	= rSfmCsHoldTime;
reg [(pSfmNum*pSfmPageWidth)-1:0] 	rSfmStartAdrs;			assign oSfmStartAdrs 	= rSfmStartAdrs;
reg [(pSfmNum*pSfmPageWidth)-1:0] 	rSfmEndAdrs;			assign oSfmEndAdrs 		= rSfmEndAdrs;
reg [(pSfmNum*8)-1:0] 				rSfmCpuWd;				assign oSfmCpuWd		= rSfmCpuWd;
reg [pSfmNum-1:0] 					rSfmCpuEn;				assign oSfmCpuEn		= rSfmCpuEn;
reg [pSfmNum-1:0] 					rSfmCpuCsCtrl;			assign oSfmCpuCsCtrl	= rSfmCpuCsCtrl;
reg [pSfmNum-1:0] 					rSfmCpuValid;			assign oSfmCpuValid		= rSfmCpuValid;
//
reg [(pSfmNum*8)-1:0]				rSfmCpuRd;
reg [pSfmNum-1:0] 					rSfmDone;
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
reg qCsrWCke0C;
reg qCsrWCke10;
reg qCsrWCke14;
reg qCsrWCke18;
reg qCsrWCke1C;
reg qCsrWCke20;
reg qCsrWCke30;
reg qCsrWCke60;
reg qCsrWCke64;
reg qCsrWCke68;
reg qCsrWCke6C;
reg qCsrWCke70;
reg qCsrWCke74;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSfmIoHiz		<= {pSfmNum{1'b0}};
		rSfmEn			<= {pSfmNum{1'b0}};
		rSfmCycleEn		<= {pSfmNum{1'b0}};
		rSfmDiv			<= {(pSfmNum*8){1'b0}};
		rSfmCsHoldTime	<= {(pSfmNum*8){1'b0}};
		rSfmStartAdrs	<= {(pSfmNum*pSfmPageWidth){1'b0}};
		rSfmEndAdrs		<= {(pSfmNum*pSfmPageWidth){1'b0}};
		//
		rSfmCpuWd		<= {(pSfmNum*8){1'b0}};
		rSfmCpuEn		<= {pSfmNum{1'b0}};
		rSfmCpuCsCtrl	<= {pSfmNum{1'b0}};
		rSfmCpuValid	<= {pSfmNum{1'b0}};
	end
	else
	begin
		rSfmIoHiz		<= qCsrWCke00 	? iSUsiWd[pSfmNum-1:0] 		: rSfmIoHiz;
		rSfmEn			<= iSfmDone[0]	? rSfmCycleEn[0]			: qCsrWCke04 ? iSUsiWd[0] 	: rSfmEn[0];
		rSfmEn			<= iSfmDone[1]	? rSfmCycleEn[1]			: qCsrWCke04 ? iSUsiWd[1] 	: rSfmEn[1];
		rSfmEn			<= iSfmDone[2]	? rSfmCycleEn[2]			: qCsrWCke04 ? iSUsiWd[2] 	: rSfmEn[2];
		rSfmCycleEn		<= qCsrWCke08 	? iSUsiWd[pSfmNum-1:0] 		: rSfmCycleEn;
		rSfmDiv			<= qCsrWCke0C 	? iSUsiWd[pSfmNum*8-1:0]	: rSfmDiv;
		rSfmCsHoldTime	<= qCsrWCke10 	? iSUsiWd[pSfmNum*8-1:0]  	: rSfmCsHoldTime;
		//
		rSfmCpuWd		<= qCsrWCke14 	? iSUsiWd[pSfmNum*8-1:0]  	: rSfmCpuWd;
		rSfmCpuEn		<= iSfmCpuDone[0]	? 1'b0					: qCsrWCke18 	? iSUsiWd[0]  	: rSfmCpuEn[0];
		rSfmCpuEn		<= iSfmCpuDone[1]	? 1'b0					: qCsrWCke18 	? iSUsiWd[1]  	: rSfmCpuEn[1];
		rSfmCpuEn		<= iSfmCpuDone[2]	? 1'b0					: qCsrWCke18 	? iSUsiWd[2]  	: rSfmCpuEn[2];
		rSfmCpuCsCtrl	<= qCsrWCke1C 	? iSUsiWd[pSfmNum-1:0]  	: rSfmCpuCsCtrl;
		rSfmCpuValid	<= qCsrWCke20 	? iSUsiWd[pSfmNum-1:0]  	: rSfmCpuValid;
		//
		rSfmCpuRd[ 0+:8]<= iSfmCpuDone[0]	? iSfmCpuRd[ 0+:8]		: rSfmCpuRd[ 0+:8];
		rSfmCpuRd[ 8+:8]<= iSfmCpuDone[1]	? iSfmCpuRd[ 8+:8]		: rSfmCpuRd[ 8+:8];
		rSfmCpuRd[16+:8]<= iSfmCpuDone[2]	? iSfmCpuRd[16+:8]		: rSfmCpuRd[16+:8];
		rSfmDone[0]		<= iSfmCpuDone[0]	? 1'b1 					: qCsrWCke30 ? 1'b0 : rSfmDone[0];
		rSfmDone[1]		<= iSfmCpuDone[1]	? 1'b1 					: qCsrWCke30 ? 1'b0 : rSfmDone[1];
		rSfmDone[2]		<= iSfmCpuDone[2]	? 1'b1 					: qCsrWCke30 ? 1'b0 : rSfmDone[2];
		//
		rSfmStartAdrs	[ 0+:pSfmPageWidth]	<= qCsrWCke60 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmStartAdrs	[ 0+:pSfmPageWidth];
		rSfmEndAdrs		[ 0+:pSfmPageWidth]	<= qCsrWCke64 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmEndAdrs	[ 0+:pSfmPageWidth];
		rSfmStartAdrs	[16+:pSfmPageWidth]	<= qCsrWCke68 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmStartAdrs	[16+:pSfmPageWidth];
		rSfmEndAdrs		[16+:pSfmPageWidth]	<= qCsrWCke6C 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmEndAdrs	[16+:pSfmPageWidth];
		rSfmStartAdrs	[32+:pSfmPageWidth]	<= qCsrWCke70 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmStartAdrs	[32+:pSfmPageWidth];
		rSfmEndAdrs		[32+:pSfmPageWidth]	<= qCsrWCke74 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmEndAdrs	[32+:pSfmPageWidth];
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000C});
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke1C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001C});
	qCsrWCke20 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0020});
	qCsrWCke30 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0030});
	qCsrWCke60 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0060});
	qCsrWCke64 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0064});
	qCsrWCke68 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0068});
	qCsrWCke6C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h006C});
	qCsrWCke70 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0070});
	qCsrWCke74 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0074});
end


//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmIoHiz};
		'h04:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmEn};
		'h08:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCycleEn};
		'h0C:	 rSUsiRd <= {{(32 - pSfmNum*8		){1'b0}}, rSfmDiv};
		'h10:	 rSUsiRd <= {{(32 - pSfmNum*8		){1'b0}}, rSfmCsHoldTime};
		'h14:	 rSUsiRd <= {{(32 - pSfmNum*8		){1'b0}}, rSfmCpuWd};
		'h18:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuEn};
		'h1C:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuCsCtrl};
		'h20:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuValid};
		'h30:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmDone};
		'h60:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmStartAdrs[0+:pSfmPageWidth]};
		'h64:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmEndAdrs[0+:pSfmPageWidth]};
		'h68:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmStartAdrs[16+:pSfmPageWidth]};
		'h6C:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmEndAdrs[16+:pSfmPageWidth]};
		'h70:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmStartAdrs[32+:pSfmPageWidth]};
		'h74:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmEndAdrs[32+:pSfmPageWidth]};
		'h90:	 rSUsiRd <= {{(32 - 8	){1'b0}}, rSfmCpuRd[ 0+:8]};
		'h94:	 rSUsiRd <= {{(32 - 8	){1'b0}}, rSfmCpuRd[ 8+:8]};
		'h98:	 rSUsiRd <= {{(32 - 8	){1'b0}}, rSfmCpuRd[16+:8]};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule