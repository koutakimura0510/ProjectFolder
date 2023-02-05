/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : axi4_adrs_generator.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 04/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module axi4_adrs_generator #(
parameter pDataBitWidth	= 16,
parameter pDdrBurstSize	= 16,
parameter pDdrMemSize 	= "4"	// 単位 Gb
)(
// AXI4 Address Channel
output [32:0]	oAdrs,	// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
output 			oAdrsDone,
// common
input 			iRST,
input 			iCKE,	// adrs 更新タイミングで Assert
input 			iCLK
);


//-----------------------------------------------------------------------------
// Adrs 生成
//-----------------------------------------------------------------------------
localparam lpRowBitWidth  = (pDdrMemSize == "4") ? 14  : 1;
localparam lpColBitWidth  = (pDdrMemSize == "4") ? 10  : 1;
localparam lpBankBitWidth = (pDdrMemSize == "4") ? 3   : 1;
// offset
localparam [lpRowBitWidth-1:0] 	lpRowOffset = pDdrBurstSize * (pDataBitWidth / 8);	// メモリサイズによって変更する
localparam [lpColBitWidth-1:0] 	lpColOffset = 64;	// メモリサイズによって変更する
// adrs max value
localparam [lpRowBitWidth-1:0]	lpRowAdrsMax  = {lpRowBitWidth{1'b1}} + 1'b1 - lpRowOffset;
localparam [lpColBitWidth-1:0]	lpColAdrsMax  = {lpColBitWidth{1'b1}} + 1'b1 - lpColOffset;
localparam [lpBankBitWidth-1:0]	lpBankAdrsMax = {lpBankBitWidth{1'b1}};

reg [lpRowBitWidth-1:0]	 rRow;
reg [lpColBitWidth-1:0]	 rCol;
reg	[lpBankBitWidth-1:0] rBank;
reg 					 qRowMax, qColMax;
reg 					 rAdrsDone, qAdrsDoneCke;

always @(posedge iCLK)
begin
	if (iRST)			rRow	<= {lpRowBitWidth{1'b0}};
	else if (iCKE)		rRow	<= rRow + lpRowOffset;
	else 				rRow	<= rRow;

	if (iRST)			rCol	<= {lpColBitWidth{1'b0}};
	else if (qRowMax)	rCol	<= rCol + lpColOffset;
	else 				rCol	<= rCol;

	if (iRST)			rBank	<= {lpBankBitWidth{1'b0}};
	else if (qColMax)	rBank	<= rBank + 1'b1;
	else 				rBank	<= rBank;
	//
	if (iRST)				rAdrsDone	<= 1'b0;
	else if (qAdrsDoneCke)	rAdrsDone	<= 1'b1;
	else 					rAdrsDone	<= 1'b0;
end

always @*
begin
	case ( {iCKE,(lpRowAdrsMax == rRow)} )
		'b11: 		qRowMax <= 1'b1;
		default:	qRowMax <= 1'b0;
	endcase

	case ( {(lpColAdrsMax == rCol),qRowMax} )
		'b11: 		qColMax <= 1'b1;
		default:	qColMax <= 1'b0;
	endcase

	case ( {(lpBankAdrsMax == rBank),qColMax} )
		'b11: 		qAdrsDoneCke <= 1'b1;
		default:	qAdrsDoneCke <= 1'b0;
	endcase
end

assign oAdrs 	 = {1'b0,3'd0,rRow,rBank,rCol,2'b00};;
assign oAdrsDone = rAdrsDone;

endmodule