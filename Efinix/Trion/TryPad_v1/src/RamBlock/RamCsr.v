//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module RamCsr #(
	parameter pBlockAdrsWidth	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth	= 8,
	parameter pRamDqWidth		= 16,
	parameter p_non_variable	= 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] 	iSUsiWd,
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Csr Device Config
	output [7:0]				oCfgCmd,
	output						oCfgEn,
	output						oCfgRst,
	input						iCfgDone,
	// Csr Memory Access Tester
	output						oMatEn,
	output						oMatRst,
	input						iMatDone,
	output [pRamDqWidth-1:0]	oMatMemWd,
	output						oMatMemWdOe,
	output [7:0]				oMatMemWa,
	output 						oMatMemWe,
	input  [pRamDqWidth-1:0]	iMatMemRd,
	output [7:0]				oMatMemRa,
	output [7:0]				oMemClkDiv,
    // CLK Reset
    input  						iSRST,
    input  						iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [ 7:0]				rCfgCmd;				assign oCfgCmd		= rCfgCmd;
reg						rCfgEn;					assign oCfgEn		= rCfgEn;
reg						rCfgRst;				assign oCfgRst		= rCfgRst;
reg 					rMatEn;					assign oMatEn		= rMatEn;
reg 					rMatRst;				assign oMatRst		= rMatRst;
reg [pRamDqWidth-1:0] 	rMatMemWd;				assign oMatMemWd	= rMatMemWd;
reg 					rMatMemWdOe;			assign oMatMemWdOe	= rMatMemWdOe;
reg [ 7:0]				rMatMemWa;				assign oMatMemWa	= rMatMemWa;
reg 					rMatMemWe;				assign oMatMemWe	= rMatMemWe;
reg [ 7:0]				rMatMemRa;				assign oMatMemRa	= rMatMemRa;
reg [ 7:0]				rMemClkDiv;				assign oMemClkDiv	= rMemClkDiv;
//
//
reg qCsrWCke00, qCsrWCke01, qCsrWCke02, qCsrWCke03, qCsrWCke04, qCsrWCke05;
reg qCsrWCke10, qCsrWCke11, qCsrWCke12, qCsrWCke13, qCsrWCke14, qCsrWCke15, qCsrWCke16;
reg qCsrWCke30;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rCfgCmd			<= 8'h35;
		rCfgEn			<= 1'b0;
		rCfgRst			<= 1'b1;
		rMatEn			<= 1'b0;
		rMatRst			<= 1'b1;
		rMatMemWd		<= 16'h0000;
		rMatMemWdOe		<= 1'b1;
		rMatMemWa		<= 8'd0;
		rMatMemWe		<= 1'b0;
		rMatMemRa		<= 8'd0;
		rMemClkDiv		<= 8'd0;
	end
	else
	begin
		rCfgCmd			<= qCsrWCke00 ? iSUsiWd[ 7:0] : rCfgCmd;
		rCfgEn			<= qCsrWCke01 ? iSUsiWd[ 0:0] : rCfgEn;
		rCfgRst			<= qCsrWCke02 ? iSUsiWd[ 0:0] : rCfgRst;
		rMatEn			<= qCsrWCke10 ? iSUsiWd[ 0:0] : rMatEn;
		rMatRst			<= qCsrWCke11 ? iSUsiWd[ 0:0] : rMatRst;
		rMatMemWd		<= qCsrWCke12 ? iSUsiWd[15:0] : rMatMemWd;
		rMatMemWdOe		<= qCsrWCke13 ? iSUsiWd[ 0:0] : rMatMemWdOe;
		rMatMemWa		<= qCsrWCke14 ? iSUsiWd[ 7:0] : rMatMemWa;
		rMatMemWe		<= qCsrWCke15 ? iSUsiWd[ 0:0] : rMatMemWe;
		rMatMemRa		<= qCsrWCke16 ? iSUsiWd[ 7:0] : rMatMemRa;
		rMemClkDiv		<= qCsrWCke30 ? iSUsiWd[ 7:0] : rMemClkDiv;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke01 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0001});
	qCsrWCke02 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0002});
	qCsrWCke03 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0003});
	//
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke11 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0011});
	qCsrWCke12 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0012});
	qCsrWCke13 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0013});
	qCsrWCke14 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke15 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0015});
	qCsrWCke16 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0016});
	//
	qCsrWCke30 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0030});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - 24			){1'b0}}, rCfgCmd};
		'h01:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rCfgEn};
		'h02:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rCfgRst};
		'h10:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rMatEn};
		'h11:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rMatRst};
		'h12:	 rSUsiRd <= {{(32 - pRamDqWidth	){1'b0}}, rMatMemWd};
		'h13:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rMatMemWdOe};
		'h14:	 rSUsiRd <= {{(32 - 8			){1'b0}}, rMatMemWa};
		'h15:	 rSUsiRd <= {{(32 - 31			){1'b0}}, rMatMemWe};
		'h16:	 rSUsiRd <= {{(32 - 8			){1'b0}}, rMatMemRa};
		'h30:	 rSUsiRd <= {{(32 - 8			){1'b0}}, rMemClkDiv};
		'h40:	 rSUsiRd <= {{(32 - 31			){1'b0}}, iCfgDone};
		'h50:	 rSUsiRd <= {{(32 - 31			){1'b0}}, iMatDone};
		'h51:	 rSUsiRd <= {{(32 - pRamDqWidth	){1'b0}}, iMatMemRd};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule