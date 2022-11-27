//----------------------------------------------------------
// Create  2022/11/26
// Author  koutakimura
// Editor  VSCode ver1.73.1
// Build   Vivado22.2
// Device  
// -
// BRAM の合成結果を確認するためのプロジェクト
// 
//----------------------------------------------------------
module BramTop (
	input	iRst,
	input 	iClk,
	output 	oLed
);


//----------------------------------------------------------
// BRAM の使用
// SDP では、ポートA を読み出しポート、ポートB を書き込みポートとして同時に独立して実行可能
//----------------------------------------------------------
localparam lpBramWidth = 16;

// read
wire 	[lpBramWidth-1:0]	wRd;
reg  	[lpBramWidth-1:0]	rRd;
reg 	[15:0]				rRa;
// reg 						rRe;

// write
reg 	[lpBramWidth-1:0]	rWd;
reg 	[15:0]				rWa;
reg 						rWe;

(*ram_style = "block"*) reg [15:0] ram [0:2047];
// BramBasicInst #(
// 	// .pInitFile		(),
// 	// .pRamMode		(),
// 	.pBramWidthA	(lpBramWidth),
// 	.pBramWidthB	(lpBramWidth),
// 	.pDataWidth		(16)
// ) BramBasicInst (
// 	.iWDA			({lpBramWidth{1'b0}}),
// 	.oRDA			(wRd),
// 	.iAdrsA			(rRa),
// 	.iCkeA			(1'b1),		// 常時読み出し
// 	.iWCkeA			(4'b0000),
// 	.iWDB			(rWd),
// 	.oRDB			(),
// 	.iAdrsB			(rWa),
// 	.iCkeB			(rWe),
// 	.iWCkeB			(8'b1111_1111),
// 	.iRstA			(iRst),
// 	.iRstB			(iRst),
// 	.iClkA			(iClk),
// 	.iClkB			(iClk)
// );

always @(posedge iClk)
begin
	if (iRst) 				rRa <= 0;
	else if (rWa <= rRa)	rRa <= rRa;
	else if (rWe)			rRa <= rRa + 1'b1;
	else 					rRa <= rRa;

	if (iRst) 				rWa <= 0;
	else if (rWe)			rWa <= rWa + 1'b1;
	else					rWa <= rWa;

	if (iRst) 				rWd <= 0;
	else if (rWe)			rWd <= rWd + 1'b1;
	else					rWd <= rWd;

	if (iRst) 				rWe <= 0;
	else					rWe <= ~rWe;

	if (rWe)	ram[rWa] <= rWd;
	rRd <= ram[rRa];
end

assign oLed = &{rRd};

endmodule