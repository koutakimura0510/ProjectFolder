//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module SpiCsr #(
	// 各 Block 共通
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth		= 32,
	parameter pCsrAdrsWidth 	= 8,
	parameter pCsrActiveWidth 	= 8,
	parameter pSfmNum			= 3,
	parameter pSfmPageWidth		= 16
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Csr Sfm
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
	input	[(pSfmNum*pSfmPageWidth)-1:0]	iSfmAdrsAdd,
	output	[ 2:0] 							oSspDeviceSel,
	input									iSdioDetA,
	input									iSdioDetB,
	// CLK Reset
	input  iSRST,
	input  iSCLK
);

// ※1 Sfm = Serial Flash Memory 略称
// ※2 現時点では 1Page の開始と終了をアドレス設定する必要あり。Col 毎の読み込みには対応していない

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
reg [pSfmNum-1:0]  					rSfmIoHiz;				assign oSfmIoHiz 		= rSfmIoHiz;		// 使用していない
reg [pSfmNum-1:0]  					rSfmEn;					assign oSfmEn 			= rSfmEn;			// Sfm Access Enable
reg [pSfmNum-1:0]  					rSfmCycleEn;			assign oSfmCycleEn 		= rSfmCycleEn;		// Sfm Access Cycle Moving
reg [(pSfmNum*8)-1:0]				rSfmDiv;				assign oSfmDiv 			= rSfmDiv;			// SPI SCLK Division
reg [(pSfmNum*8)-1:0]				rSfmCsHoldTime;			assign oSfmCsHoldTime 	= rSfmCsHoldTime;	// CS "H","L", Hold Time
reg [(pSfmNum*pSfmPageWidth)-1:0] 	rSfmStartAdrs;			assign oSfmStartAdrs 	= rSfmStartAdrs;	// Sfm Load Start Adrs
reg [(pSfmNum*pSfmPageWidth)-1:0] 	rSfmEndAdrs;			assign oSfmEndAdrs 		= rSfmEndAdrs;		// Sfm Load End Adrs
reg [(pSfmNum*8)-1:0] 				rSfmCpuWd;				assign oSfmCpuWd		= rSfmCpuWd;		// CPU Side Write Data
reg [pSfmNum-1:0] 					rSfmCpuEn;				assign oSfmCpuEn		= rSfmCpuEn;		// CPU Side Write Enable
reg [pSfmNum-1:0] 					rSfmCpuCsCtrl;			assign oSfmCpuCsCtrl	= rSfmCpuCsCtrl;	// CPU Side Write CS Ctrl
reg [pSfmNum-1:0] 					rSfmCpuValid;			assign oSfmCpuValid		= rSfmCpuValid;		// CPU Side Valid
//
reg [ 2:0] 							rSspDeviceSel;			assign oSspDeviceSel	= rSspDeviceSel;	// 
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
reg qCsrWCke24;
reg qCsrWCke28;
reg qCsrWCke30;
reg qCsrWCke34;
reg qCsrWCke38;
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
		rSfmDiv			<= {(pSfmNum){8'd4}};
		rSfmCsHoldTime	<= {(pSfmNum){8'd20}};
		rSfmStartAdrs	<= {(pSfmNum*pSfmPageWidth){1'b0}};
		rSfmEndAdrs		<= {(pSfmNum*pSfmPageWidth){1'b0}};
		//
		rSfmCpuWd		<= {(pSfmNum*8){1'b0}};
		rSfmCpuEn		<= {pSfmNum{1'b0}};
		rSfmCpuCsCtrl	<= {pSfmNum{1'b1}};
		rSfmCpuValid	<= {pSfmNum{1'b0}};
		//
		rSspDeviceSel	<= 3'd0;
	end
	else
	begin
		rSfmIoHiz		<= qCsrWCke00 	? iSUsiWd[pSfmNum-1:0] 			: rSfmIoHiz;
		rSfmEn[0]		<= iSfmDone[0]	? rSfmCycleEn[0]				: qCsrWCke04 ? iSUsiWd[0] 	: rSfmEn[0];
		rSfmCycleEn		<= qCsrWCke08 	? iSUsiWd[pSfmNum-1:0] 			: rSfmCycleEn;
		rSfmDiv			<= qCsrWCke0C 	? iSUsiWd[pSfmNum*8-1:0]		: rSfmDiv;
		rSfmCsHoldTime	<= qCsrWCke10 	? iSUsiWd[pSfmNum*8-1:0]  		: rSfmCsHoldTime;
		//
		rSfmCpuWd[ 0+:8]<= qCsrWCke14 		? iSUsiWd[7:0]  			: rSfmCpuWd[ 0+:8];
		rSfmCpuEn[0]	<= iSfmCpuDone[0]	? 1'b0						: qCsrWCke18 	? iSUsiWd[0]  	: rSfmCpuEn[0];
		rSfmCpuCsCtrl	<= qCsrWCke1C 		? iSUsiWd[pSfmNum-1:0]  	: rSfmCpuCsCtrl;
		rSfmCpuValid	<= qCsrWCke20 		? iSUsiWd[pSfmNum-1:0]  	: rSfmCpuValid;
		//
		rSfmCpuRd[ 0+:8]<= iSfmCpuDone[0]	? iSfmCpuRd[ 0+:8]			: rSfmCpuRd[ 0+:8];
		rSfmDone[0]		<= iSfmCpuDone[0]	? 1'b1 						: qCsrWCke30 ? 1'b0 : rSfmDone[0];
		//
		rSspDeviceSel[2:0]	<= qCsrWCke34 ? iSUsiWd[2:0]				: rSspDeviceSel[2:0];
		//
		rSfmStartAdrs	[ 0+:pSfmPageWidth]	<= qCsrWCke60 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmStartAdrs	[ 0+:pSfmPageWidth];
		rSfmEndAdrs		[ 0+:pSfmPageWidth]	<= qCsrWCke64 	? iSUsiWd[pSfmPageWidth-1:0]	: rSfmEndAdrs	[ 0+:pSfmPageWidth];
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
	qCsrWCke24 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0024});
	qCsrWCke28 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0028});
	qCsrWCke30 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0030});
	qCsrWCke34 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0034});
	qCsrWCke38 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0038});
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
		'h14:	 rSUsiRd <= {{(32 - 8				){1'b0}}, rSfmCpuWd[ 0+:8]};
		'h18:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuEn};
		'h1C:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuCsCtrl};
		'h20:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmCpuValid};
		'h30:	 rSUsiRd <= {{(32 - pSfmNum			){1'b0}}, rSfmDone};
		'h34:	 rSUsiRd <= {{(32 - 29				){1'b0}}, rSspDeviceSel};
		'h38:	 rSUsiRd <= {{(32 - 30				){1'b0}}, iSdioDetB, iSdioDetA};
		'h60:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmStartAdrs	[ 0+:pSfmPageWidth]};
		'h64:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, rSfmEndAdrs	[ 0+:pSfmPageWidth]};
		'h90:	 rSUsiRd <= {{(32 - 8				){1'b0}}, rSfmCpuRd		[ 0+:8]};
		'hA0:	 rSUsiRd <= {{(32 - pSfmPageWidth	){1'b0}}, iSfmAdrsAdd	[ 0+:pSfmPageWidth]};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule