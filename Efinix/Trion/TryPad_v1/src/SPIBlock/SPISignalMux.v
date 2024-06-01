//------------------------------------------------------------------------------
// Create 2022/8/11
// Author koutakimura
// -
// FPGA が Slave の場合の、Upper モジュールと SPI Signalモジュールとの調停を行う
// V1.1 USIB 更新版に対応、UFIB は拡張用としてコメントアウト
//------------------------------------------------------------------------------
module SPISignalMux #(
	parameter pUsiBusWidth = 32
	// parameter pUfiBusWidth = 32
)(
	// SPI USIB Bridge
	input  [pUsiBusWidth-1:0] iSpiRd,
	input  [pUsiBusWidth-1:0] iSpiAdrs,
	input  iSpiREd,
	// Bus Master Write/Read
	output [pUsiBusWidth-1:0] oMUsiRd,
	input  [pUsiBusWidth-1:0] iMUsiRd,
	output [pUsiBusWidth-1:0] oMUsiWd,
	output [pUsiBusWidth-1:0] oMUsiAdrs,
	// Ufi Bus Master Write
	// output	[pUfiBusWidth-1:0]	oMUfiWd,	// Write Data
	// output	[31:0]				oMUfiAdrs,	// Write address
	// output						oMUfiEd,	// Write Data Enable
	// output 						oMUfiVd,	// 転送期間中 Assert
	// output 						oMUfiCmd,	// High Read, Low Write
	// CLK Reset
	input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// Master Cmd で RW を判定し Cke を発行するため、1clk 遅延する
// タイミングを合わせるため、データバスもレジスタ経由にする
// Cmd のデータ構造は SPISignal module 参照
//----------------------------------------------------------

//----------------------------------------------------------
// USI Bus
// Adrs 32bit内にデータ有効bitを含むため、32bit データ受信時にアドレスは更新するようにする。
// 
//----------------------------------------------------------
reg  [pUsiBusWidth-1:0] rMUsiWd, rMUsiAdrs;

always @(posedge iSCLK)
begin
	rMUsiWd	<= iSpiRd;

	if (iSpiREd)	rMUsiAdrs <= iSpiAdrs;
	else 			rMUsiAdrs <= {pUsiBusWidth{1'b0}};
end

assign oMUsiRd	 	= iMUsiRd; 	// Csr RData はそのまま経由させる
assign oMUsiWd   	= rMUsiWd;
assign oMUsiAdrs 	= rMUsiAdrs;

//----------------------------------------------------------
// UFI Bus
//----------------------------------------------------------
// reg [pUfiBusWidth-1:0] 	rMUfiWd;		assign oMUfiWd		= rMUfiWd;
// reg [31:0] 				rMUfiAdrs;		assign oMUfiAdrs	= rMUfiAdrs;
// reg 					rMUfiEd;		assign oMUfiEd		= rMUfiEd;
// reg  					rMUfiVd;		assign oMUfiVd		= rMUfiVd;
// reg  					rMUfiCmd;		assign oMUfiCmd		= rMUfiCmd;
// //
// reg 					qMUfiVd;
// //
// always @(posedge iSCLK)
// begin
// 	rMUfiWd		<= iSRd[pUfiBusWidth-1:0];
// 	rMUfiAdrs	<= iSAdrs;

// 	// Data Enable
// 	case ({iSREd, iSCmd})
// 		4'b1011:	rMUfiEd <= 1'b1;
// 		4'b1100:	rMUfiEd <= 1'b1;
// 		default 	rMUfiEd <= 1'b0;
// 	endcase

// 	// Cmd
// 	case ({iSCmd})
// 		3'b011:		rMUfiCmd <= 1'b0;
// 		default 	rMUfiCmd <= 1'b1;
// 	endcase

// 	// wVd SDLen を取得したら 転送期間中とする
// 	if (qMUfiVd) 	rMUfiVd <= 1'b0;
// 	else			rMUfiVd <= 1'b1;
// end

// always @*
// begin
// 	qMUfiVd <= (iSDLen == 16'd0);
// end


endmodule