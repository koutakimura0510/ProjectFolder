/**-----------------------------------------------------------------------------
 * HyperRam Device Configration
 * https://www.infineon.com/dgdl/Infineon-AN226576_-_Getting_started_with_HYPERRAM_TM_JA-ApplicationNotes-v02_00-JA.pdf?fileId=8ac78c8c7cdc391c017d0d3995ec66e2
 * 
 * Device COnfigration Read / Write
 *
 * 23-11-14 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module HyperRamDeviceConfig (
	// Write Side for I/O
	output[ 7:0]	oMemDq,
	output			oMemDqOe,
	output			oMemRwds,
	output			oMemRwdsOe,
	output			oMemClk,
	output			oMemCs,
	// Read Side for I/O
	input [ 7:0]	iMemDq,
	input			iMemRwds,
	// Internal Data
	output[15:0]	oCapDq,			// Reg Read Data
	input [15:0]	iWDq,
	input [47:0]	iCmdAdrs,
	// control / status
	input [ 3:0]	iLatencyCnt,	// = LC + CmdCnt(4'd4)
	input			iRwCmd,			// [0] Read, [1] Write
	input			iSeqEn,			// Sequence Start
	output			oDone,			// Sequence Done
	// Clk Reset
	input			iRST,
	input			iCKE,
	input			iCLK
);

/**----------------------------------------------------------------------------
 Infineon
 Identification Reg 0 Read		C0h, 00h, 00h, 00h, 00h, 00h
 Identification Reg 1 Read		C0h, 00h, 00h, 00h, 00h, 01h
 Configration   Reg 0 Read		C0h, 00h, 01h, 00h, 00h, 00h
 Configration   Reg 0 Write		60h, 00h, 01h, 00h, 00h, 00h
 Configration   Reg 1 Read		C0h, 00h, 01h, 00h, 00h, 01h
 Configration   Reg 1 Write		60h, 00h, 01h, 00h, 00h, 01h
 Die Manufacture Info Read		C0h, 00h, 02h, 00h, 00h, 00h - 11h

 ISSI
 Identification Reg 0 Read		C0h, 00h, 00h, 00h, 00h, 00h
 Configration   Reg 0 Read		C0h, 00h, 00h, 04h, 00h, 00h
 Configration   Reg 0 Write		60h, 00h, 00h, 04h, 00h, 00h
 Die Manufacture Info Read		F0h, 00h, 00h, 00h, 00h, 00h
 *---------------------------------------------------------------------------*/
localparam
	lpIdol		= 3'd0,
	lpCsAssert	= 3'd1,
	lpRWDS		= 3'd2,
	lpCmdAdrs	= 3'd3,
	lpLcCmd		= 3'd4,
	lpDqSeq1	= 3'd5,
	lpDqSeq2	= 3'd6,
	lpComplete	= 3'd7;

// Intenal Logic
reg [ 2:0] 	rSt;
reg 		qNextStCke;
reg 		qNextStLcCke;
// Gpio Connect
reg 		rMemClk;					assign oMemClk		= rMemClk;
reg 		rMemCs;						assign oMemCs		= rMemCs;
reg [47:0] 	rMemDq;						assign oMemDq		= rMemDq[47:40];
reg 		rMemDqOe;					assign oMemDqOe		= rMemDqOe;
reg 		rMemRwds;					assign oMemRwds		= rMemRwds;
reg 		rMemRwdsOe;					assign oMemRwdsOe	= rMemRwdsOe;

/**----------------------------------------------------------------------------
 * State Machine
 *---------------------------------------------------------------------------*/
always @(posedge iCLK)
begin
	rMemRwdsOe	<= 1'b0;
	
	if (iRST)
	begin
		rSt 		<= lpIdol;
		rMemDq		<= 48'd0;
		rMemCs		<= 1'b1;
		rMemDqOe	<= 1'b0;
		rMemRwds	<= 1'b0;
	end
	else
	begin
	case (rSt)
		lpIdol:
		begin
			rSt 		<= qNextStCke ? lpCsAssert : lpIdol;
			rMemDq		<= iCmdAdrs;
			rMemCs		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
		end
		
		lpCsAssert:
		begin
			rSt 		<= lpRWDS;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b0;
			rMemDqOe	<= rMemDqOe;
			rMemRwds	<= rMemRwds;
		end
		
		lpRWDS:
		begin
			rSt 		<= lpCmdAdrs;
			rMemDq		<= rMemDq;
			rMemCs 		<= rMemCs;
			rMemDqOe	<= 1'b1;
			rMemRwds	<= rMemRwds;
		end
		
		lpCmdAdrs:
		begin
			rSt 		<= qNextStCke ? qNextStLcCke ? lpLcCmd : lpDqSeq1 : lpCmdAdrs;
			rMemDq		<= qNextStCke ? {iWDq[15:8],40'd0} : {rMemDq[39:0],rMemDq[47:40]};
			rMemCs 		<= rMemCs;
			rMemDqOe	<= qNextStCke ? iRwCmd : rMemDqOe;
			rMemRwds	<= rMemRwds;
		end
		
		lpLcCmd:
		begin
			rSt 		<= qNextStCke ? lpDqSeq1 : lpLcCmd;
			rMemDq		<= rMemDq;
			rMemCs 		<= rMemCs;
			rMemDqOe	<= iRwCmd;
			rMemRwds	<= rMemRwds;
		end
		
		lpDqSeq1:
		begin
			rSt 			<= lpDqSeq2;
			rMemDq[47:40]	<= iWDq[7:0];
			rMemDq[39:0]	<= rMemDq[39:0];
			rMemCs 			<= rMemCs;
			rMemDqOe		<= rMemDqOe;
			rMemRwds		<= rMemRwds;
		end
		
		lpDqSeq2:
		begin
			rSt 			<= lpComplete;
			rMemDq[47:40]	<= rMemDq[47:40];
			rMemDq[39:0]	<= rMemDq[39:0];
			rMemCs 			<= rMemCs;
			rMemDqOe		<= rMemDqOe;
			rMemRwds		<= rMemRwds;
		end
		
		lpComplete:
		begin
			rSt 		<= qNextStCke ? lpIdol : lpComplete;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
		end
		
		default:
		begin
			rSt 		<= lpIdol;
			rMemDq		<= rMemDq;
			rMemCs 		<= 1'b1;
			rMemDqOe	<= 1'b0;
			rMemRwds	<= 1'b0;
		end
	endcase
	end
end

/**----------------------------------------------------------------------------
 * メモリクロック生成、データ取得
 *---------------------------------------------------------------------------*/
reg [15:0] 	rCapDq;						assign oCapDq = rCapDq;
reg 		qMemClkCke;

always @(negedge iCLK)
begin
	if (iRST) 				rMemClk <=  1'b0;
	else if (qMemClkCke)	rMemClk <= ~rMemClk;
	else 					rMemClk <=  1'b0;
	
end

always @(posedge iCLK)
begin
	if (rDone)				rCapDq[15:8] <= rCapDq[15:8];
	else if (iMemRwds)		rCapDq[15:8] <= iMemDq[7:0]; 
	else 					rCapDq[15:8] <= rCapDq[15:8];
	
	if (rDone)				rCapDq[7:0] <= rCapDq[7:0];
	else if (!iMemRwds)		rCapDq[7:0] <= iMemDq[7:0]; 
	else 					rCapDq[7:0] <= rCapDq[7:0];
end

always @*
begin
	qMemClkCke <= (lpCmdAdrs <= rSt) ? 1'b1 : 1'b0;
end

/**----------------------------------------------------------------------------
 * ステートマシン制御ロジック & ステータス管理
 *---------------------------------------------------------------------------*/
reg [3:0] 	rLatencyCnt,	rCmdCnt;
reg 		qLcCntCke,		qCmdCntCke;
reg 		rDone;						assign oDone		= rDone;
reg 		qDoneCke;

always @(posedge iCLK)
begin
	if (iRST) 				rCmdCnt <= 4'd0;			// Reg R/W 時は、コマンド発行後レイテンシが発生するデバイスがあるため、
	else if (qCmdCntCke)	rCmdCnt <= rCmdCnt + 1'b1;	// コマンドの送信回数 + レイテンシカウント数を Csr 空間から指定する必要がある。
	else					rCmdCnt <= 4'd0;			// 
	
	if (iRST) 				rLatencyCnt <= 4'd0;
	else if (qLcCntCke)		rLatencyCnt <= rLatencyCnt + 1'b1;
	else					rLatencyCnt <= 4'd0;
	
	if (iRST) 				rDone <= 1'b0;
	else if (qDoneCke)		rDone <= 1'b1;
	else					rDone <= 1'b0;
end

always @*
begin
	qCmdCntCke	<= (rSt == lpCmdAdrs)	? 1'b1 : 1'b0;
	qLcCntCke	<= (rSt == lpLcCmd)		? 1'b1 : 1'b0;
	qDoneCke	<= (rSt == lpComplete)	? 1'b1 : 1'b0;
	
	casex ({rSt, (rLatencyCnt == iLatencyCnt), (rCmdCnt == 4'd5), iSeqEn})
		{lpIdol, 	3'bxx1}:	qNextStCke <= 1'b1;
		{lpCmdAdrs, 3'bx1x}:	qNextStCke <= 1'b1;
		{lpLcCmd,	3'b1xx}:	qNextStCke <= 1'b1;
		{lpComplete,3'bxx0}:	qNextStCke <= 1'b1;
		default: 				qNextStCke <= 1'b0;
  	endcase
	
	qNextStLcCke <= |{iLatencyCnt};
end

endmodule