/*-----------------------------------------------------------------------------
 * SPI ROM から音源データを読み出しのステート・マシン
 *
 * 23-09-18 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module AudioRomReadSequence #(
	parameter pSfmPageWidth = 16
)(
	// Audio Data
	output[15:0] 				oAudioData,
	output 						oAudioVd,
	// Rom Logic Access
	input [7:0]					iSfmRd,
	input 						iSfmDone,
	output[7:0]					oSfmWd,
	output						oSfmEn,
	output						oSfmCsCtrl,
	// Control Status
	input						iSfmEn,
	input						iSfmCycleEn,
	input [7:0]					iSfmCsHoldTime,
	input [pSfmPageWidth-1:0] 	iSfmStartAdrs,
	input [pSfmPageWidth-1:0] 	iSfmEndAdrs,
	output 						oSfmDone,
	// CLK Reset
	input iRST,
	input iCLK
);

//-----------------------------------------------------------------------------
// 容量の大きい Flash ROM は操作方法が煩雑なので、
// ステート・マシンで制御を行う
// ひとまず BUF=1 の 1Page 読み出しモードで動作行う
//-----------------------------------------------------------------------------
localparam
	lpStAdrsCheck	= 4'd0,
	lpStPageReadUpr = 4'd1,
	lpStPageReadCmd	= 4'd2,
	lpStBusyUpr 	= 4'd3,
	lpStBusyCmd		= 4'd4,
	lpStBusyCheck	= 4'd5,
	lpStReadDataUpr	= 4'd6,
	lpStReadDataCmd	= 4'd7,
	lpStFlashRead	= 4'd8;

reg [7:0]	rWd;							assign oSfmWd		= rWd;
reg rEn;									assign oSfmEn		= rEn;
reg rCsCtrl;								assign oSfmCsCtrl	= rCsCtrl;
//
reg [3:0]	rSt;
reg 		qNextStCke;
reg [15:0]	rAdrsAdd;
reg 		qAdrsMatch;
reg [1:0]	rWp;
reg [7:0]	rRd;
reg [11:0]	rRdCnt;					// 読み込み回数 1Page Max 2048 にしている
reg 		qRdCntRst,	qRdCntCke;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt		<= lpStAdrsCheck;
		rWd 	<= 8'h00;
		rEn		<= 1'b0;
		rCsCtrl <= 1'b1;
		rWp		<= 2'd0;
	end
	else
	begin
		case (rSt)
		lpStAdrsCheck:
		begin
			rSt			<= qNextStCke ? lpStPageReadCmd : lpStAdrsCheck;	// cycle 時の　処理追加予定
			rWd		 	<= 32'd0;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp			<= 2'd0;
		end

		lpStPageReadUpr:
		begin
			rSt			<= lpStPageReadUpr;
			rWd[ 0+: 8]	<= 8'h13;	// Page Read
			rWd[ 8+: 8]	<= 8'h00;	// dummy
			rWd[16+:16]	<= rAdrsAdd;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp			<= 2'd0;
		end

		lpStPageReadCmd:
		begin
			rSt			<= qNextStCke 	? lpStBusyUpr : lpStPageReadCmd;
			rWd			<= iSfmDone		? {8'h00,rWd[31:8]} : rWd;
			rEn			<= iSfmDone 	? 1'b0 : 1'b1;
			rCsCtrl 	<= qNextStCke 	? 1'b1 : 1'b0;
			rWp 		<= iSfmDone		? rWp + 1'b1 : rWp;
		end

		lpStBusyUpr:
		begin
			rSt			<= lpStBusyCmd;
			rWd[ 0+:8] 	<= 8'h0f;	// Busy Wait Check
			rWd[ 8+:8] 	<= 8'hC3;	// Status Reg3 Adrs
			rWd[16+:8] 	<= 8'h00;
			rWd[24+:8] 	<= 8'h00;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp 		<= 2'd0;
		end

		lpStBusyCmd:
		begin
			rSt			<= qNextStCke 	? lpStBusyCheck : lpStBusyCmd;
			rWd			<= iSfmDone		? {8'h00,rWd[31:8]} : rWd;
			rEn			<= iSfmDone 	? 1'b0 : 1'b1;
			rCsCtrl 	<= qNextStCke 	? 1'b1 : 1'b0;
			rWp 		<= iSfmDone 	? rWp + 1'b1 : rWp;
		end

		lpStBusyCheck:
		begin
			rSt		<= qNextStCke 	? lpStReadDataUpr : lpStBusyUpr;
			rWd 	<= rWd;
			rEn		<= 1'b0;
			rCsCtrl <= 1'b1;
			rWp 	<= 2'd0;
		end

		lpStReadDataUpr:
		begin
			rSt		<= lpStReadDataCmd;
			rWd 	<= 8'h03;	// Flash Read Data Cmd
			rWd 	<= 8'h00;	// col adrs Msb
			rWd 	<= 8'h00;	// col adrs lsb
			rWd 	<= 8'h00;	// dummy cmd
			rEn		<= 1'b0;
			rCsCtrl <= 1'b1;
			rWp 	<= 2'd0;
		end

		lpStReadDataCmd:
		begin
			rSt			<= qNextStCke 	? lpStFlashRead : lpStReadDataCmd;
			rWd			<= iSfmDone		? {8'h00,rWd[31:8]} : rWd;
			rEn			<= 1'b1;
			rCsCtrl 	<= 1'b0;
			rWp 		<= iSfmDone 	? rWp + 1'b1 : rWp;
		end

		lpStFlashRead:
		begin
			rSt			<= qNextStCke 	? lpStPageReadUpr : lpStReadData;
			rWd			<= 32'd0;
			rEn			<= 1'b1;
			rCsCtrl 	<= 1'b0;
			rWp 		<= 2'd0;
		end
		endcase
	end

	if (iSfmDone)	rRd <= iSfmRd;
	else 			rRd <= rRd;

	if (qRdCntRst)		rRdCnt <= 12'd0;			// 0〜2047 まで読み込みカウントして、
	else if (qRdCntCke)	rRdCnt <= rRdCnt + 1'b1;	// 2048 = [11]bit に 1が立ったかどうかで
	else 				rRdCnt <= rRdCnt;			// 読み込み領域の判定を行うことができる。

	rAdrsAdd <= iSfmStartAdrs + rRdCnt[11];
end

always @*
begin
	casex ( {rSt} )
		lpStFlashRead:			qRdCntRst <= 1'b0;		// Dissert
		default: 				qRdCntRst <= 1'b1;		// Assert
	endcase

	casex ( {rSt,iSfmDone} )
		{lpStFlashRead,1'b1}:	qRdCntCke <= 1'b1;		// Flash Read
		default: 				qRdCntCke <= 1'b0;
	endcase

	casex ( {rSt,iSfmEn,iSfmDone,rWp[1:0],(rRd[0]==1'b1),rRdCnt[11],(rAdrsAdd==iSfmEndAdrs)} )
		{lpStAdrsCheck,		7'b1_x_xx_x_x_0}:	qNextStCke <= 1'b1;
		{lpStPageReadCmd,	7'bx_1_11_x_x_x}:	qNextStCke <= 1'b1;
		{lpStBusyCmd,		7'bx_1_10_x_x_x}:	qNextStCke <= 1'b1;
		{lpStBusyCheck,		7'bx_x_xx_1_x_x}:	qNextStCke <= 1'b1;
		{lpStReadDataCmd,	7'bx_1_11_x_x_x}:	qNextStCke <= 1'b1;
		{lpStFlashRead,		7'bx_x_xx_x_1_x}:	qNextStCke <= 1'b1;
		default: 								qNextStCke <= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------


endmodule