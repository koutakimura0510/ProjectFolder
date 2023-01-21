/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MCsiRxController.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MCsiRxController.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MMipiDphyGen_tb (
	output	[7:0] 	oDphyHsDataLane0,
	output	[7:0] 	oDphyHsDataLane1,
	output			oDphyHsDataLaneLs,
	output			oDphyHsDataLaneVd,
	//
	input 			iRST,
	input 			iMCLK
);


//-----------------------------------------------------------------------------
// MIPI D-PHY 信号生成
//-----------------------------------------------------------------------------
localparam lpHsStNum  = 2;
localparam [lpHsStNum-1:0]
	lpHsIdol		  = 0,
	lpHsStartTrigger  = 1,
	lpHsPacketHeader1 = 2,
	lpHsPacketHeader2 = 3,
	lpHsPacketData    = 4,
	lpHsPacketFooter  = 5;

localparam lpLineCntWidth = 16;

reg [lpHsStNum-1:0]	rSt;
reg [7:0] 	rDphyHsDataLane0;				assign oDphyHsDataLane0  = rDphyHsDataLane0;
reg [7:0] 	rDphyHsDataLane1;				assign oDphyHsDataLane1  = rDphyHsDataLane1;
reg 		rDphyHsDataLaneLs;				assign oDphyHsDataLaneLs = rDphyHsDataLaneLs;
reg 		rDphyHsDataLaneVd;				assign oDphyHsDataLaneVd = rDphyHsDataLaneVd;
//
reg [lpLineCntWidth-1:0]  rLineCnt;
reg 					  qLineMaxCke;

always @(posedge iMCLK)
begin
	if (iRST)
	begin
		rSt <= lpHsIdol;
		rDphyHsDataLane0  <= 8'h00;
		rDphyHsDataLane1  <= 8'h00;
		rDphyHsDataLaneLs <= 1'b0;
		rDphyHsDataLaneVd <= 1'b0;
	end
	else
	begin
		case (rSt)
			lpHsIdol:
			begin
				rSt <= lpHsStartTrigger;
				rDphyHsDataLane0  <= 8'h00;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= 1'b0;
			end

			lpHsStartTrigger:
			begin
				rSt <= lpHsPacketHeader1;
				rDphyHsDataLane0  <= 8'h00;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b1;
				rDphyHsDataLaneVd <= 1'b0;
			end

			lpHsPacketHeader1:
			begin
				rSt <= lpHsPacketHeader2;
				rDphyHsDataLane0  <= 8'h1E;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= 1'b1;
			end

			lpHsPacketHeader2:
			begin
				rSt <= lpHsPacketHeader2;
				rDphyHsDataLane0  <= 8'h0F;
				rDphyHsDataLane1  <= 8'h14;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= 1'b1;
			end

			lpHsPacketData:
			begin
				rSt <= qLineMaxCke ? lpHsPacketFooter : lpHsPacketData;
				rDphyHsDataLane0  <= 8'h80;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= qLineMaxCke ? 1'b0 : 1'b1;
			end

			lpHsPacketFooter: 
			begin
				rSt <= qLineMaxCke ? lpHsIdol : lpHsPacketFooter;
				rDphyHsDataLane0  <= 8'h80;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= 1'b0;
			end

			default:
			begin
				rSt <= lpHsIdol;
				rDphyHsDataLane0  <= 8'h80;
				rDphyHsDataLane1  <= 8'h00;
				rDphyHsDataLaneLs <= 1'b0;
				rDphyHsDataLaneVd <= 1'b0;
			end
		endcase
	end
end

always @(posedge iMCLK)
begin
	if (iRST) 				rLineCnt <= {lpLineCntWidth{1'b0}};
	else if (qLineMaxCke)	rLineCnt <= {lpLineCntWidth{1'b0}};
	else 					rLineCnt <= rLineCnt + 1'b1;
end

always @*
begin
	qLineMaxCke <= (rLineCnt == 16'h0200);
end

endmodule