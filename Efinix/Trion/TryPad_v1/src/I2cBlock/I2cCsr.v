//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module I2cCsr #(
	// variable parameter
	parameter 						pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap	  	= 'h04,
	parameter 						pCsrAdrsWidth 	= 8,
	parameter 						pCsrActiveWidth	= 8,
	parameter						pUsiBusWidth	= 32,
	parameter 						pI2CDivClk 		= 16
)(
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0]	oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0]	iSUsiWd,
	input	[pUsiBusWidth-1:0]	iSUsiAdrs,
	// Csr Output
	output						oSlaveCoreRst,
	// Csr Input
	input	[7:0]				iSlaveRd,
	input						iSlaveVd,
	// CLK Reset
	input						iSRST,
	input						iSCLK
);



/**----------------------------------------------------------------------------
 * レジスタマップ
 *---------------------------------------------------------------------------*/
reg 		rSlaveCoreRst;							assign oSlaveCoreRst = rSlaveCoreRst;
//
reg [ 7:0] 	rSlaveRd;
//
reg qCsrWCke00;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSlaveCoreRst <= 1'b0;
	end
	else
	begin
		rSlaveCoreRst	<= qCsrWCke00 	? iSUsiWd[0:0]	: rSlaveCoreRst;
		rSlaveRd		<= iSlaveVd		? iSlaveRd 		: rSlaveRd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
end

/**----------------------------------------------------------------------------
 * Csr Read
 *---------------------------------------------------------------------------*/
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	case (iSUsiAdrs[pCsrActiveWidth - 1:0])
		8'h00:		rSUsiRd <= {31'd0, rSlaveCoreRst};
		8'h40:		rSUsiRd <= {24'd0, rSlaveRd};
		default: 	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule