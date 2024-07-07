/*------------------------------------------------------------------------------
 * Create 2024/06/30
 * Author Kouta Kimura
 * 
 * Stream Data to TFT Module I/F Data Convert
 * new release : v1.00
 *-----------------------------------------------------------------------------*/
module VideoTftUnit (
	// Video Output Part
	output [23:0]	oTftDQ,
	output			oTftWRX,
	output			oTftDCX,
	output			oTftRDX,
	output			oTftCSX,
	output			oTftRST,
	output [ 3:0]	oTftIM,
	// Data Stream Input Part
	input  [23:0]	iDS,
	input			iWE,
	output			oFLL,
	// MCU Data Stream Input Part
	input  [23:0]	iMcuDS,
	input			iMcuWRX,
	input			iMcuDCX,
	input			iMcuRDX,
	input			iMcuCSX,
	input			iMcuRST,
	input  [ 3:0]	iMcuIM,
	input			iMcuGate,
	// Control / Status
	input			iConverterRst,
	// Common
	input 			iSRST,
	input 			inSRST,
	input 			iSCLK,
	input 			iVRST,
	input 			inVRST,
	input 			iVCLK
);


//-----------------------------------------------------------------------------
// Dual CLK Fifo Side SCLK to VCLK
//-----------------------------------------------------------------------------
localparam lpVafDepth 		= 512;
localparam lpVafBitWidth 	= 16;

reg  [lpVafBitWidth-1:0]	qVafDS;
reg							qVafWE;
wire 						wVafFLL;
wire [lpVafBitWidth-1:0]	wVafDD;
wire 						wVafVD;
reg  						qVafRE;
wire						wVafEMP;

ASyncFifoController #(
	.pFifoDepth(lpVafDepth),
	.pFifoBitWidth(lpVafBitWidth)
) VideoAsyncFifo (
	// Src Fifo Side
	.iWd(qVafDS),		.iWe(qVafWE),
	.oFull(),			.oRemaingCntAlert(wVafAlert),
	// Dst Fifo Side
	.oRd(wVafDD),		.iRe(qVafRE),
	.oRvd(wVafVD),		.oEmp(wVafEMP),
	// common
	.inARST(inSRST),	.iWCLK(iSCLK),	.iRCLK(iVCLK)
);

always @*
begin
	qVafDS 	<= iDS[15:0];
	qVafWE 	<= iWE;
end

assign oFLL = wVafAlert;


/**-----------------------------------------------------------------------------
 * Tft I/F Convert Part
 *-----------------------------------------------------------------------------*/
reg [23:0] 	rDS[1:1];
reg [ 2:1]	rWE;
reg			rTftRe;
reg			qTftConverterRst;

always @(posedge iVCLK)
begin
	if (wVafVD)		rDS[1]	<= wVafDD;
	else			rDS[1]	<= rDS[1];
	
	rWE[1]	<= wVafVD;
	rWE[2]	<= rWE[1];
	
	if (qTftConverterRst) 	rTftRe <= 1'b0;
	else					rTftRe <= ~rTftRe;
end

always @*
begin
	qVafRE				<= rTftRe;
	qTftConverterRst	<= |{iVRST,iConverterRst};
end


/**-----------------------------------------------------------------------------
 * Data Stream Pipelines
 *-----------------------------------------------------------------------------*/
reg [23:0] 	rDD,  qDD;
reg			rWRX, rDCX, rRDX, rCSX, rRST;
reg			qWRX, qDCX, qRDX, qCSX, qRST;

always @(posedge iVCLK)
begin
	rDD		<= qDD;
	rWRX	<= qWRX;
	rDCX	<= qDCX;
	rRDX	<= qRDX;
	rCSX	<= qCSX;
	rRST	<= qRST;
end

always @*
begin
	qDD  <= iMcuGate ? iMcuDS	: rDS[1];
	qWRX <= iMcuGate ? iMcuWRX	: rWE[2];
	qDCX <= iMcuGate ? iMcuDCX	: 1'b1;
	qRDX <= iMcuGate ? iMcuRDX	: 1'b1;
	qCSX <= iMcuGate ? iMcuCSX	: 1'b0;
	qRST <= iMcuGate ? iMcuRST	: 1'b1;
end


/**-----------------------------------------------------------------------------
 * Data Dest Part
 *-----------------------------------------------------------------------------*/
assign oTftDQ	= rDD;
assign oTftWRX	= rWRX;
assign oTftDCX	= rDCX;
assign oTftRDX	= rRDX;
assign oTftCSX	= rCSX;
assign oTftRST	= rRST;
assign oTftIM	= iMcuIM;


/**-----------------------------------------------------------------------------
 * RST Logic
 *-----------------------------------------------------------------------------*/



endmodule