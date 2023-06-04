/*-----------------------------------------------------------------------------
 * Create  2023/05/28
 * Author  Kimura
 * -
 * のこぎり波形生成
 * 
 *-----------------------------------------------------------------------------*/
module SawGen #(
	parameter pAudioBitWidth = 16,
	parameter pDivBitWidth	 = 16
)(
	output [pAudioBitWitdh-1:0] oSaw,
	// Control and Data
	input  iCke,
	input  [pDivBitWidth-1:0] iDiv,
    // CLK Reset
	input  iRST,
	input  iCLK
);


//-----------------------------------------------------------------------------
// 分周カウンタ
//-----------------------------------------------------------------------------
localparam [pDivBitWidth-1:0] lpDivCntRstData = 1;

reg [pDivBitWidth-1:0] rDivCnt;
reg qDivCntCke, qDivCntRst;

always @(posedge iCLK)
begin
	if (qDivCntRst)			rDivCnt <= lpDivCntRstData;
	else if (qDivCntCke)	rDivCnt <= rDivCnt + 1'b1;
	else 					rDivCnt <= rDivCnt;
end

always @*
begin
	qDivCntCke <= &{iCke,(rDivCnt==iDiv)};
	qDivCntRst <= |{iRST,qDivCntCke};
end

//-----------------------------------------------------------------------------
// SAW Gen
//-----------------------------------------------------------------------------
reg [pAudioBitWidth-1:0] rSaw;		assign oSaw = rSaw;

always @(posedge iCLK)
begin
	if (iRST) 				rSaw <= {pAudioBitWidth{1'b0}};
	else if (qDivCntCke)	rSaw <= rSaw + 16'd600;
	else 					rSaw <= rSaw;
end

endmodule