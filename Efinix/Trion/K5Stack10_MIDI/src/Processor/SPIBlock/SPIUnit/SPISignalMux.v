//----------------------------------------------------------
// Create 2022/8/11
// Author koutakimura
// -
// FPGA が Slave の場合の、Upper モジュールと SPI Signalモジュールとの調停を行う
// 
//----------------------------------------------------------
module SPISignalMux #(
	// variable parameter
	parameter					pUsiBusWidth	= 16,
	parameter					pUfiBusWidth= 16
)(
	// Internal Port FPGA Slave Side SPI Module Connect
	output	[31:0]				oSMiso,
	input 	[31:0]				iSRd,
	input 	[31:0]				iSAdrs,
	input 	[2:0]				iSCmd,
	input 	[15:0]				iSDLen,
	input 						iSREd,
	// Internal Port FPGA Slave Side Upper Module Connect
	input	[31:0]				iMUsiRd,
	output 	[31:0]				oMUsiWd,
	output 	[pUsiBusWidth-1:0]	oMUsiAdrs,
	output 						oMUsiWEd,
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0]	oMUfiWd,	// Write Data
	output	[31:0]				oMUfiAdrs,	// Write address
	output						oMUfiEd,	// Write Data Enable
	output 						oMUfiVd,	// 転送期間中 Assert
	output 						oMUfiCmd,	// High Read, Low Write
	// CLK Reset
    input           			iSCLK,
	input 						iSRST
);


//----------------------------------------------------------
// Master Cmd で RW を判定し Cke を発行するため、1clk 遅延する
// タイミングを合わせるため、データバスもレジスタ経由にする
// Cmd のデータ構造は SPISignal module 参照
//----------------------------------------------------------

//----------------------------------------------------------
// USI Bus
//----------------------------------------------------------
reg [31:0]				rMUsiWd;		assign oMUsiWd   	= rMUsiWd;
reg [pUsiBusWidth-1:0]	rMUsiAdrs;		assign oMUsiAdrs 	= rMUsiAdrs;
reg 					rMUsiWEd;		assign oMUsiWEd		= rMUsiWEd;
										assign oSMiso	 	= iMUsiRd; 	// Csr RData はそのまま経由させる
always @(posedge iSCLK)
begin
	rMUsiWd		<= iSRd;
	rMUsiAdrs	<= iSAdrs[pUsiBusWidth-1:0];

	// Csr Write のみ判定
	case ({iSREd, iSCmd})
		4'b1001:	rMUsiWEd <= 1'b1;
		default 	rMUsiWEd <= 1'b0;
	endcase
end

//----------------------------------------------------------
// UFI Bus
//----------------------------------------------------------
reg [pUfiBusWidth-1:0] 	rMUfiWd;		assign oMUfiWd		= rMUfiWd;
reg [31:0] 				rMUfiAdrs;		assign oMUfiAdrs	= rMUfiAdrs;
reg 					rMUfiEd;		assign oMUfiEd		= rMUfiEd;
reg  					rMUfiVd;		assign oMUfiVd		= rMUfiVd;
reg  					rMUfiCmd;		assign oMUfiCmd		= rMUfiCmd;
//
reg 					qMUfiVd;
//
always @(posedge iSCLK)
begin
	rMUfiWd		<= iSRd[pUfiBusWidth-1:0];
	rMUfiAdrs	<= iSAdrs;

	// Data Enable
	case ({iSREd, iSCmd})
		4'b1011:	rMUfiEd <= 1'b1;
		4'b1100:	rMUfiEd <= 1'b1;
		default 	rMUfiEd <= 1'b0;
	endcase

	// Cmd
	case ({iSCmd})
		3'b011:		rMUfiCmd <= 1'b0;
		default 	rMUfiCmd <= 1'b1;
	endcase

	// wVd SDLen を取得したら 転送期間中とする
	if (qMUfiVd) 	rMUfiVd <= 1'b0;
	else			rMUfiVd <= 1'b1;
end

always @*
begin
	qMUfiVd <= (iSDLen == 16'd0);
end


endmodule