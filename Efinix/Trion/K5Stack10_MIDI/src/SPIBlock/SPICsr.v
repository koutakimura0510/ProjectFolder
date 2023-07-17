//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module SPICsr #(
	// 各 Block 共通
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	// Block origin
	parameter pDivClk = 16
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Csr Output
	output oSPIEn,
	output [pDivClk-1:0] oSPIDiv,
	output [7:0] oMWd,
	output oMSpiCs,
	output oFlashSpiEn,
	output [pDivClk-1:0] oFlashSpiDiv,
	output [7:0] oFlashWd,
	output oFlashCsOutCtrl,
	output oFlashSpiIoHiz,
	// Csr Input
	input  [7:0] iMRd,
	input  iMSpiIntr,
	input  [7:0] iFlashRd,
	input  iFlashSpiIntr,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
reg 				rSPIEn;				assign oSPIEn 	= rSPIEn;			// 通信開始
reg [pDivClk-1:0]	rSPIDiv;			assign oSPIDiv 	= rSPIDiv;			// CLK Division
reg [7:0]	        rMWd;			 	assign oMWd 	= rMWd;				// Send Data
reg					rMSpiCs;			assign oMSpiCs	= rMSpiCs;			// chip select 
//
reg					rFlashSpiEn;		assign oFlashSpiEn 		= rFlashSpiEn;		// 通信開始
reg [pDivClk-1:0]	rFlashSpiDiv;		assign oFlashSpiDiv 	= rFlashSpiDiv;		// CLK Division
reg [7:0]			rFlashWd;			assign oFlashWd 		= rFlashWd;			// Send Data
reg 				rFlashCsOutCtrl;	assign oFlashCsOutCtrl	= rFlashCsOutCtrl;	// chip select 
reg 				rFlashSpiIoHiz;		assign oFlashSpiIoHiz	= rFlashSpiIoHiz;	// "1" SPI 機能有効, "0" 通常GPIO
//
reg [7:0]			rMRd;			// 読み込みデータ
reg [7:0]			rFlashRd;		// 読み込みデータ
reg 				rFlashIntrMon;	// 
//
reg 				qCsrWCke00;
reg 				qCsrWCke04;
reg 				qCsrWCke08;
reg 				qCsrWCke0c;
reg 				qCsrWCke10;
reg 				qCsrWCke14;
reg 				qCsrWCke18;
reg 				qCsrWCke1c;
reg 				qCsrWCke20;
reg 				qCsrWCke88;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSPIEn		<= 1'b0;
		rSPIDiv		<= {pDivClk{1'b1}};
		rMWd		<= 8'd0;
		rMSpiCs		<= 1'b1;
		rMRd		<= 8'd0;
		//
		rFlashSpiEn		<= 1'b0;
		rFlashSpiDiv	<= {pDivClk{1'b1}};
		rFlashWd		<= 8'd0;
		rFlashCsOutCtrl	<= 1'b1;
		rFlashSpiIoHiz	<= 1'b0;
		rFlashRd		<= 8'd0;
		rFlashIntrMon	<= 1'b0;
	end
	else
	begin
		rSPIEn		<= iMSpiIntr  ? 1'b0 : qCsrWCke00 ? iSUsiWd[0:0] : rSPIEn;
		rSPIDiv		<= qCsrWCke04 ? iSUsiWd[pDivClk-1:0] : rSPIDiv;
		rMWd		<= qCsrWCke08 ? iSUsiWd[7:0] : rMWd;
		rMSpiCs		<= qCsrWCke0c ? iSUsiWd[0:0] : rMSpiCs;
		rMRd		<= iMRd;
		//
		rFlashSpiEn		<= iFlashSpiIntr ? 1'b0 : qCsrWCke10 ? iSUsiWd[0:0] : rFlashSpiEn;	// 1バイト送受信完了時の割り込みで Enable Auto Dissert
		rFlashSpiDiv	<= qCsrWCke14 ? iSUsiWd[pDivClk-1:0] : rFlashSpiDiv;
		rFlashWd		<= qCsrWCke18 ? iSUsiWd[7:0] : rFlashWd;
		rFlashCsOutCtrl	<= qCsrWCke1c ? iSUsiWd[0:0] : rFlashCsOutCtrl;
		rFlashSpiIoHiz	<= qCsrWCke20 ? iSUsiWd[0:0] : rFlashSpiIoHiz;
		rFlashRd		<= iFlashSpiIntr ? iFlashRd : rFlashRd;
		rFlashIntrMon	<= iFlashSpiIntr ? 1'b1 : qCsrWCke88 ? 1'b0 : rFlashIntrMon;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke1c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001c});
	qCsrWCke20 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0020});
	qCsrWCke88 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0088});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:		rSUsiRd <= {31'd0, rSPIEn};
		'h04:		rSUsiRd <= {{(32 - pDivClk){1'b0}}, rSPIDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
		'h08:		rSUsiRd <= {24'd0, rMWd};
		'h0c:		rSUsiRd <= {31'd0, rMSpiCs};
		'h10:		rSUsiRd <= {31'd0, rFlashSpiEn};
		'h14:		rSUsiRd <= {{(32 - pDivClk){1'b0}}, rFlashSpiDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
		'h18:		rSUsiRd <= {24'd0, rFlashWd};
		'h1c:		rSUsiRd <= {31'd0, rFlashCsOutCtrl};
		'h20:		rSUsiRd <= {31'd0, rFlashSpiIoHiz};
		'h80:		rSUsiRd <= {24'd0, rMRd};
		'h84:		rSUsiRd <= {24'd0, rFlashRd};
		'h88:		rSUsiRd <= {31'd0, rFlashIntrMon};
		default:  	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule