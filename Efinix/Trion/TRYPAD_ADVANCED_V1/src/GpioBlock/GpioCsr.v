//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
// 
// 2023/04/08 V1.1 USIBの更新版に対応
//----------------------------------------------------------
module GpioCsr #(
	// 各ブロック共通パラメータ
	parameter pBlockAdrsWidth	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth	= 8,
	// Block 固有のパラメータ
	parameter pGpioWidth		= 5,
	parameter pExtSwNum			= 7,
	parameter p_non_variable	= 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output [pGpioWidth-1:0]	oGpioOutCtrl,
	output [pGpioWidth-1:0]	oGpioDir,
	output [pGpioWidth-1:0]	oGpioAltMode,
	input  [pExtSwNum-1:0]	iPushSw,
	input  [pExtSwNum-1:0]	iEdgeSw,
	input  [pExtSwNum-1:0]	iLongSw,
	input  					iPllLock,
	// Csr Input
	input  [pGpioWidth-1:0]	iGpioIn,
	// CLK RST
	input iSRST,
	input iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pGpioWidth-1:0]	rGpioOutCtrl;		assign 	oGpioOutCtrl	= rGpioOutCtrl;	// 汎用 GPIO ON/OFF 制御
reg [pGpioWidth-1:0]	rGpioDir;			assign 	oGpioDir  		= rGpioDir;		// 汎用 GPIO IN/OUT 制御
reg [pGpioWidth-1:0]	rGpioAltMode;		assign 	oGpioAltMode	= rGpioAltMode;	// 汎用 GPIO Altnate Mode
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rGpioOutCtrl	<= {pGpioWidth{1'b0}};
		rGpioDir		<= {pGpioWidth{1'b1}};
		rGpioAltMode 	<= {pGpioWidth{1'b1}};
	end
	else
	begin
		rGpioOutCtrl	<= qCsrWCke00	? iSUsiWd[pGpioWidth-1:0] 	: rGpioOutCtrl;
		rGpioDir		<= qCsrWCke04	? iSUsiWd[pGpioWidth-1:0] 	: rGpioDir;
		rGpioAltMode	<= qCsrWCke08	? iSUsiWd[pGpioWidth-1:0] 	: rGpioAltMode;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - pGpioWidth	){1'b0}}, rGpioOutCtrl};
		'h04:	 rSUsiRd <= {{(32 - pGpioWidth	){1'b0}}, rGpioDir};
		'h08:	 rSUsiRd <= {{(32 - pGpioWidth	){1'b0}}, rGpioAltMode};
		'h40:	 rSUsiRd <= {{(32 - pGpioWidth	){1'b0}}, iGpioIn};
		'h41:	 rSUsiRd <= {{(32 - pExtSwNum	){1'b0}}, iPushSw};
		'h42:	 rSUsiRd <= {{(32 - pExtSwNum	){1'b0}}, iEdgeSw};
		'h43:	 rSUsiRd <= {{(32 - pExtSwNum	){1'b0}}, iLongSw};
		'h44:	 rSUsiRd <= {{(32 - 1			){1'b0}}, iPllLock};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule