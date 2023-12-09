/**-----------------------------------------------------------------------------
 * I2C Slave I/F module
 * 
 * 23-11-23 v1.00	: new release, 2021/11/13 に作成した RTL を移植しリファクタリング
 * 					: Clock Streach には未対応
 *-----------------------------------------------------------------------------*/
module I2cSlaveIf (
	// External Port
	input			iI2cScl,
	output			oI2cScl,
	output			oI2cSclOe,
	input			iI2cSda,
	output			oI2cSda,
	output			oI2cSdaOe,
	// Decode Data
	output	[7:0] 	oDd,
	output			oVd,
	// Control / Status
	input	[6:0]	iSlaveAdrs,
	// common
	input			iRST,
	input			inRST,
	input			iCLK
);


/**----------------------------------------------------------------------------
 * State Machine
 *---------------------------------------------------------------------------*/
localparam [2:0] 
	lpDisCon 		= 3'd0,
	lpStartCondition= 3'd1,	// SCL"H", SDA"H" -> "L" Start Condition
	lpStopCondition = 3'd2;	// SCL"H", SDA"L" -> "H" Stop Condition
	
reg [2:0] 	rSt;
reg [1:0] 	qNextStCke;
reg [1:0] 	rSclSft, 		rSdaSft;
reg 		qSclPosEdge,	qSclNegEdge;
reg 		rCoreRst,		qCoreRst;
	
always @(posedge iCLK)
begin
	rSclSft <= {rSclSft[0], iI2cScl};
	rSdaSft <= {rSdaSft[0], iI2cSda};
	
	if (iRST)
	begin
		rSt <= lpDisCon;
	end
	else
	begin
		case (rSt)
			lpDisCon: 			rSt <= qNextStCke[0] ? lpStartCondition : lpDisCon;
			lpStartCondition:	rSt <= qNextStCke[1] ? lpDisCon 		: lpStartCondition;
			default:			rSt <= lpDisCon;
		endcase
	end
end

always @*
begin
	qNextStCke[0] 	<= &{rSclSft[0] & rSclSft[1],rSdaSft[0] ^ rSdaSft[1]};
	qNextStCke[1] 	<= &{rSclSft[0] & rSclSft[1],rSdaSft[0] ^ rSdaSft[1]};
	qSclPosEdge		<=  (rSclSft == 2'b01);
	qSclNegEdge		<=  (rSclSft == 2'b10);
end


/**----------------------------------------------------------------------------
 * Control Logic
 *---------------------------------------------------------------------------*/
 localparam [3:0] lpSclPosCntMax = 8;
 
reg [3:0] 	rSclPosCnt;
reg 		qSclPosCntMax, qSclPosCntByte;
reg [7:0]	rSdaDes;
reg 		rSdaVd,			qSdaVdCke;
reg			rGetAdrs;

always @(posedge iCLK)
begin
	
	if (iRST)				rSclPosCnt	<= 4'd0;
	else if (qSclPosCntMax)	rSclPosCnt	<= 4'd0;
	else if (qSclPosEdge)	rSclPosCnt	<= rSclPosCnt + 1'b1;
	else					rSclPosCnt	<= rSclPosCnt;
	
	if (iRST)				rGetAdrs	<=  1'd0;
	else if (qSclPosCntMax)	rGetAdrs	<= ~rGetAdrs;
	else					rGetAdrs	<=  rGetAdrs;
	
	if (qSclPosCntMax)		rSdaDes		<=  rSdaDes;
	else if (qSclPosEdge)	rSdaDes		<= {rSdaDes[6:0], iI2cSda};
	else					rSdaDes		<=  rSdaDes;
	
	if (rCoreRst)			rSdaVd		<= 1'b0;
	else if (qSdaVdCke)		rSdaVd		<= 1'b1;
	else					rSdaVd		<= 1'b0;
end

always @*
begin
	qSclPosCntByte	<=  (rSclPosCnt == lpSclPosCntMax);
	qSclPosCntMax 	<= &{qSclPosEdge,qSclPosCntByte};
	qSdaVdCke		<= &{qSclPosCntMax,rGetAdrs};
end

/**----------------------------------------------------------------------------
 * Logic to I/O Assign
 *---------------------------------------------------------------------------*/
reg			rScl;
reg			rSclOe;
reg			rSda;
reg 		rSdaOe;
reg			qSdaOeCke;

always @(posedge iCLK)
begin
	rScl	<= 1'b0;
	rSclOe	<= 1'b0;
	rSda	<= 1'b0;
	
	if (rCoreRst)		rSdaOe	<=  1'b0;
	else if (qSdaOeCke)	rSdaOe	<= ~rSdaOe;
	else				rSdaOe	<=  rSdaOe;
end

always @*
begin
	casex ({rSdaOe,qSclNegEdge,qSclPosCntByte})
		3'b011:		qSdaOeCke <= 1'b1;		// Assert 
		3'b11x:		qSdaOeCke <= 1'b1;		// Dissert
		default: 	qSdaOeCke <= 1'b0;
	endcase
end

/**----------------------------------------------------------------------------
 * Core Logic RST
 *---------------------------------------------------------------------------*/
always @(posedge iCLK)
begin
	rCoreRst <= qCoreRst;
end

always @*
begin
	qCoreRst <= |{iRST, (rSt == lpDisCon)};
end

/**----------------------------------------------------------------------------
 * Output Part
 *---------------------------------------------------------------------------*/
assign oI2cScl		= rScl;
assign oI2cSclOe	= rSclOe;
assign oI2cSda 		= rSda;
assign oI2cSdaOe 	= rSdaOe;
assign oDd			= rSdaDes;
assign oVd			= rSdaVd;


endmodule