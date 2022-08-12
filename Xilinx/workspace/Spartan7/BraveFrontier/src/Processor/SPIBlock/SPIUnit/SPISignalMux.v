//----------------------------------------------------------
// Create 2022/8/11
// Author koutakimura
// -
// FPGA が Slave の場合の、Upper モジュールと SPI Signalモジュールとの調停を行う
// 
//----------------------------------------------------------
module SPISignalMux #(
	// variable parameter
	parameter					pBusAdrsBit	= 16
)(
	// Internal Port FPGA Slave Side SPI Module Connect
	output	[31:0]				oSMiso,
	input 	[31:0]				iSRd,
	input 	[31:0]				iSAdrs,
	input 	[1:0]				iSCmd,
	input 	[15:0]				iSDLen,
	input 						iSRdVd,
	// Internal Port FPGA Slave Side Upper Module Connect
	input	[31:0]				iMUsiRd,
	output 	[31:0]				oMUsiWd,
	output 	[pBusAdrsBit-1:0]	oMUsiAdrs,
	output 						oMUsiWEd,
	// Ufi Bus Master Write
	output	[31:0]				oMUfiWd,	// Write Data
	output	[31:0]				oMUfiAdrs,	// Write address
	output						oMUfiWEd,	// Write Data Enable
	output 						oMUfiWVd,	// 転送期間中 Assert
	// CLK Reset
    input           			iSysClk,
	input 						iSyRst
);


//----------------------------------------------------------
// Master Cmd で RW を判定し Cke を発行するため、1clk 遅延する
// タイミングを合わせるため、データバスもレジスタ経由にする
// Cmd のデータ構造は SPI module 参照
//----------------------------------------------------------

//----------------------------------------------------------
// USI Bus
//----------------------------------------------------------
reg [31:0]				rMUsiWd;		assign oMUsiWd   	= rMUsiWd;
reg [pBusAdrsBit-1:0]	rMUsiAdrs;		assign oMUsiAdrs 	= rMUsiAdrs;
reg 					rMUsiWEd;		assign oMUsiWEd		= rMUsiWEd;
										assign oSMiso	 	= iMUsiRd; 	// Csr RData はそのまま経由させる
always @(posedge iSysClk)
begin
	rMUsiWd		<= iSRd;
	rMUsiAdrs	<= iSAdrs[pBusAdrsBit-1:0];

	// Csr Write のみ判定
	case (iSRdVd, iSCmd)
		3'b101:		rMUsiWEd <= 1'b1;
		default 	rMUsiWEd <= 1'b0;
	endcase
end

//----------------------------------------------------------
// UFI Bus
//----------------------------------------------------------
reg [31:0] 	rMUfiWd;				assign oMUfiWd		= rMUfiWd;
reg [31:0] 	rMUfiAdrs;				assign oMUfiAdrs	= rMUfiAdrs;
reg 		rMUfiWEd;				assign oMUfiWEd		= rMUfiWEd;
reg  		rMUfiWVd;				assign oMUfiWVd		= rMUfiWVd;
//
reg 		qMUfiWVd;
//
always @(posedge iSysClk)
begin
	rMUfiWd		<= iSRd;
	rMUfiAdrs	<= iSAdrs;

	// Data Enable
	case (iSRdVd, iSCmd)
		3'b111:		rMUfiWEd <= 1'b1;
		default 	rMUfiWEd <= 1'b0;
	endcase

	// wVd SDLen を取得したら 転送期間中とする
	if (qMUfiWVd) 	rMUfiWVd <= 1'b0;
	else			rMUfiWVd <= 1'b1;
end

always @*
begin
	qMUfiWVd <= (iSDLen == 16'd0);
end


endmodule