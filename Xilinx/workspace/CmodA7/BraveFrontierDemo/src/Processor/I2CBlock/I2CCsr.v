//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module I2CCsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h04,
	parameter 						pCsrAdrsWidth 	= 8,
	parameter 						pCsrActiveWidth	= 8,
	parameter						pBusAdrsBit		= 32,
	parameter 						pI2CDivClk 		= 16
)(
    // Internal Port
	// Csr Read
	output	[31:0]				oSUsiRd,	// Read Data
	output						oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,  // R/W Adrs
	input						iSUsiWCke,	// Write Enable
	// Csr Input
	input 	[15:0]				iI2CGetKeyPad,
	input 						iI2CSeqComp,
	// Csr Output
	output 						oI2CEn,
	output 	[pI2CDivClk-1:0]	oI2CDiv,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);



//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
// USI/F Write
reg 					rI2CEn;				assign oI2CEn 	= rI2CEn;			// I2C 通信開始, Enable 1 の間、Adrs1 ~ 3 に設定した Slave に順番に繰り返し通信を行う
reg [pI2CDivClk-1:0]	rI2CDiv;			assign oI2CDiv 	= rI2CDiv;			// I2C CLK Division
// Upper module Write
reg [15:0]				rI2CGetKeyPad;		// Slave のコントローラーデータを保存
reg [0:0] 				rI2CSeqComp;
// reg [23:0]			rI2CGetGyro;	// Slave のジャイロセンサデータを保存
//
reg 					qCsrWCke00;
reg 					qCsrWCke04;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rI2CEn			<= 1'b0;
		rI2CDiv			<= {pI2CDivClk{1'b1}};
		rI2CGetKeyPad	<= 16'd0;
		rI2CSeqComp		<= 1'b0;
	end
	else
	begin
		rI2CEn			<= qCsrWCke00 ? iSUsiWd[ 0:0]				: rI2CEn;
		rI2CDiv			<= qCsrWCke04 ? iSUsiWd[pI2CDivClk-1:0] 	: rI2CDiv;
		rI2CGetKeyPad	<= iI2CGetKeyPad;
		rI2CSeqComp		<= iI2CSeqComp;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd  <= 'h0;
		rSUsiREd <= 1'b0;
	end
	else
	begin
		case (iSUsiAdrs[pCsrActiveWidth-1:0])
			8'h00:		rSUsiRd <= {31'd0, rI2CEn};
			8'h04:		rSUsiRd <= {{(32 - pI2CDivClk){1'b0}}, rI2CDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
			8'h80:		rSUsiRd <= {16'd0, rI2CGetKeyPad};
			8'h84:		rSUsiRd <= {31'd0, rI2CSeqComp};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:pCsrAdrsWidth] == pAdrsMap};
end

endmodule