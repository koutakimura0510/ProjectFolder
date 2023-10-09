/*-----------------------------------------------------------------------------
 * SPI ROM から音源データを読み出しのステート・マシン
 *
 * 23-09-18 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module AudioRomReadSequence #(
	parameter pSfmPageWidth = 16,
	parameter pSfmPageSize	= 2048
)(
	// Audio Data Fifo I/F
	output[15:0] 				oRd,
	output 						oRvd,
	output						oEmp,
	input 						iRe,
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
	input inRST,
	input iCLK
);

//-----------------------------------------------------------------------------
// localparam
//-----------------------------------------------------------------------------
localparam lpSfmPageSize = f_detect_bitwidth(pSfmPageSize);
localparam lpSfmPageSizeRst = lpSfmPageSize + 1'b1;


//-----------------------------------------------------------------------------
// Fifo Sfm Stack
//-----------------------------------------------------------------------------
localparam lpFifoDepth				= 256;
localparam lpFifoBitWidth 			= 16;
localparam lpFifoRemaingCntBorder	= lpFifoDepth - 8;
localparam lpFifoRemaingCntUsed		= "yes";

reg  [lpFifoBitWidth-1:0] qSfcWd;
reg  qSfcWe;
wire wFscFull, wSfcAlert;

SyncFifoController #(
	.pFifoDepth(lpFifoDepth),
	.pFifoBitWidth(lpFifoBitWidth),
	.pFifoRemaingCntBorder(lpFifoRemaingCntBorder),
	.pFifoRemaingCntUsed(lpFifoRemaingCntUsed)
) SyncFifoController (
	// read side
	.oRd(oRd),			.iRe(iRe),
	.oRvd(oRvd),		.oEmp(oEmp),
	// write side
	.iWd(qSfcWd),		.iWe(qSfcWe),
	.oFull(wFscFull),	.oRemaingCntAlert(wSfcAlert),
	// common
	.inARST(inRST),		.iCLK(iCLK)
);


//-----------------------------------------------------------------------------
// 容量の大きい Flash ROM は操作方法が煩雑なので、
// ステート・マシンで制御を行う
// ひとまず BUF=1 の 1Page 読み出しモードで動作行う
//-----------------------------------------------------------------------------
localparam
	lpStAdrsCheck	= 4'd0,	// 指定Page読み込まれたか確認
	lpStPageReadUpr = 4'd1,	// Page Read Cmd Setting
	lpStPageReadCmd	= 4'd2,	// Page Read Cmd 発行
	lpStBusyUpr 	= 4'd3,	// Busy Read Cmd Setting
	lpStBusyCmd		= 4'd4,	// Busy Read Cmd 発行
	lpStBusyCheck	= 4'd5,	// Busy Bit 検出
	lpStReadDataUpr	= 4'd6,	// Read Data Cmd Setting
	lpStReadDataCmd	= 4'd7,	// Read Data Cmd 発行
	lpStFlashRead	= 4'd8,	// Page Read Cycle
	lpStCsLowHold	= 4'd9,	// CS Low Hold Time
	lpStCsIdleHold	= 4'd10,// CS Low -> High に遷移するための中間ステート
	lpStCsHighHold	= 4'd11,// CS High Hold Time
	lpStNull		= 4'dx;

reg [31:0]				rWd;							assign oSfmWd		= rWd[7:0];
reg 					rEn;							assign oSfmEn		= rEn;
reg 					rCsCtrl;						assign oSfmCsCtrl	= rCsCtrl;
reg 					rDone;							assign oSfmDone		= rDone;
reg 					qDoenCke;
reg [3:0]				rSt, 		rNextSt;
reg 					qNextStCke;
reg [15:0]				rAdrsAdd;
reg 					qAdrsRst;
reg [1:0]				rWp;
reg 					rEnRemaing;
reg 					qEnRemaingCke;
reg [15:0]				rRd;
reg 					rRe,		rReCke;
reg 					rSel,		rSelCke;
reg [lpSfmPageSize:0]	rRdCnt;
reg 					qRdCntRst,	qRdCntCke;
reg [7:0]				rCsHoldCnt;
reg 					qCsHoldRst;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt		<= lpStAdrsCheck;
		rNextSt	<= lpStAdrsCheck;
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
			rSt			<= qNextStCke ? lpStPageReadUpr : lpStAdrsCheck;
			rNextSt		<= rNextSt;
			rWd		 	<= 32'd0;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp			<= 2'd0;
		end

		lpStPageReadUpr:
		begin
			rSt			<= lpStPageReadCmd;
			rNextSt		<= rNextSt;
			rWd[ 0+: 8]	<= 8'h13;	// Page Read
			rWd[ 8+: 8]	<= 8'h00;	// dummy
			rWd[16+: 8]	<= rAdrsAdd[15:8];
			rWd[24+: 8]	<= rAdrsAdd[7:0];
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp			<= 2'd0;
		end

		lpStPageReadCmd:
		begin
			rSt			<= qNextStCke 	? lpStCsLowHold : lpStPageReadCmd;
			rNextSt		<= lpStBusyUpr;
			rWd			<= iSfmDone		? {8'h00,rWd[8+:24]} : rWd;
			rEn			<= iSfmDone 	? 1'b0 : 1'b1;
			rCsCtrl 	<= 1'b0;
			rWp 		<= iSfmDone		? rWp + 1'b1 : rWp;
		end

		lpStBusyUpr:
		begin
			rSt			<= lpStBusyCmd;
			rNextSt		<= rNextSt;
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
			rSt			<= qNextStCke 	? lpStCsLowHold : lpStBusyCmd;
			rNextSt		<= lpStBusyCheck;
			rWd			<= iSfmDone		? {8'h00,rWd[8+:24]} : rWd;
			rEn			<= iSfmDone 	? 1'b0 : 1'b1;
			rCsCtrl 	<= 1'b0;
			rWp 		<= iSfmDone 	? rWp + 1'b1 : rWp;
		end

		lpStBusyCheck:
		begin
			rSt		<= qNextStCke 	? lpStReadDataUpr : lpStBusyUpr;
			rNextSt	<= rNextSt;
			rWd 	<= rWd;
			rEn		<= 1'b0;
			rCsCtrl <= 1'b1;
			rWp 	<= 2'd0;
		end

		lpStReadDataUpr:
		begin
			rSt			<= lpStReadDataCmd;
			rNextSt		<= rNextSt;
			rWd[ 0+:8]	<= 8'h03;	// Flash Read Data Cmd
			rWd[ 8+:8]	<= 8'h00;	// col adrs Msb
			rWd[16+:8]	<= 8'h00;	// col adrs lsb
			rWd[24+:8]	<= 8'h00;	// dummy cmd
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp 		<= 2'd0;
		end

		lpStReadDataCmd:
		begin
			rSt			<= qNextStCke 	? lpStFlashRead : lpStReadDataCmd;
			rNextSt		<= rNextSt;
			rWd			<= iSfmDone		? {8'h00,rWd[8+:24]} : rWd;
			rEn			<= iSfmDone		? 1'b0 : 1'b1;
			rCsCtrl 	<= 1'b0;
			rWp 		<= iSfmDone 	? rWp + 1'b1 : rWp;
		end

		lpStFlashRead:
		begin
			rSt			<= qNextStCke 	? lpStCsLowHold : lpStFlashRead;
			rNextSt		<= lpStAdrsCheck;
			rWd			<= 32'd0;
			rEn			<= rEnRemaing;
			rCsCtrl 	<= 1'b0;
			rWp 		<= 2'd0;
		end

		lpStCsLowHold:
		begin
			rSt			<= qNextStCke 	? lpStCsIdleHold : lpStCsLowHold;
			rNextSt		<= rNextSt;
			rWd			<= 32'd0;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b0;
			rWp 		<= 2'd0;
		end

		lpStCsIdleHold:
		begin
			rSt			<= lpStCsHighHold;
			rNextSt		<= rNextSt;
			rWd			<= 32'd0;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b0;
			rWp 		<= 2'd0;
		end

		lpStCsHighHold:
		begin
			rSt			<= qNextStCke 	? rNextSt : lpStCsHighHold;
			rNextSt		<= rNextSt;
			rWd			<= 32'd0;
			rEn			<= 1'b0;
			rCsCtrl 	<= 1'b1;
			rWp 		<= 2'd0;
		end
		endcase
	end

	if (iSfmDone)		rRd	<= {rRd[7:0],iSfmRd};			// Busy Bit と、MSB 8bit,LSB 8bit 結合
	else				rRd <= rRd;

	if (iRST)				rEnRemaing <=  1'b1;			// 後段の FIFO が FULL の場合、
	else if (qEnRemaingCke)	rEnRemaing <= ~rEnRemaing;		// 次の読み込み Cycle を一時停止しておく
	else 					rEnRemaing <=  rEnRemaing;

	if (iRST)			rRe <= 1'b0;						// Sel と組み合わせて、16bit 結合時に
	else if (rReCke)	rRe <= 1'b1;						// 後段の FIFO へ有効データとして Assert する
	else				rRe <= 1'b0;

	if (iRST)			rSel <=  1'b0;
	else if (rSelCke)	rSel <= ~rSel;
	else				rSel <=  rSel;

	if (qRdCntRst)		rRdCnt <= {lpSfmPageSizeRst{1'b0}};	// 0〜2047 まで読み込みカウントして、
	else if (qRdCntCke)	rRdCnt <= rRdCnt + 1'b1;			// 2048 = [11]bit に 1が立ったかどうかで
	else 				rRdCnt <= rRdCnt;					// 読み込み領域の判定を行うことができる。

	if (qAdrsRst)		rAdrsAdd <= iSfmStartAdrs;	
	else 				rAdrsAdd <= rAdrsAdd + rRdCnt[lpSfmPageSize];

	if (qDoenCke)		rDone <= 1'b1;	
	else 				rDone <= 1'b0;

	if (qCsHoldRst)		rCsHoldCnt <= 8'd0;
	else 				rCsHoldCnt <= rCsHoldCnt + 1'b1;
end

always @*
begin
	case ( {rEnRemaing,iSfmDone,wSfcAlert} )
		'b111:					qEnRemaingCke <= 1'b1;	// Assert
		'b000:					qEnRemaingCke <= 1'b1;	// Dissert
		default:				qEnRemaingCke <= 1'b0;
	endcase

	case ( {rSt,iSfmDone,rSel} )
		{lpStFlashRead, 2'b11}:	rReCke <= 1'b1;			// Assert
		default:				rReCke <= 1'b0;
	endcase

	case ( {rSt,iSfmDone} )
		{lpStFlashRead, 1'b1}:	rSelCke <= 1'b1;
		default:				rSelCke <= 1'b0;
	endcase

	casex ( {iSfmEn,rRdCnt[lpSfmPageSize],(rAdrsAdd==iSfmEndAdrs)} )
		'bx11:					qAdrsRst <= 1'b1;		// Assert
		'b0xx:					qAdrsRst <= 1'b1;		// Assert
		default:				qAdrsRst <= 1'b0;
	endcase

	case ( {rRdCnt[lpSfmPageSize],(rAdrsAdd==iSfmEndAdrs)} )
		'b11:					qDoenCke <= 1'b1;		// Assert
		default:				qDoenCke <= 1'b0;		// Dissert
	endcase

	case ( {rSt,rRdCnt[lpSfmPageSize]} )
		{lpStFlashRead,	1'b0}:	qRdCntRst <= 1'b0;		// Dissert
		default: 				qRdCntRst <= 1'b1;		// Assert
	endcase

	case ( {rSt,iSfmDone} )
		{lpStFlashRead,1'b1}:	qRdCntCke <= 1'b1;		// Flash Read
		default: 				qRdCntCke <= 1'b0;
	endcase

	case ( {rSt} )
		{lpStCsLowHold}:		qCsHoldRst <= 1'b0;		// Dissert
		{lpStCsHighHold}:		qCsHoldRst <= 1'b0;		// Dissert
		default: 				qCsHoldRst <= 1'b1;		// Assert
	endcase

	casex ( {rSt, (rCsHoldCnt==iSfmCsHoldTime),rDone,iSfmEn,iSfmDone,rWp[1:0],rRd[0],rRdCnt[lpSfmPageSize]} )
		{lpStAdrsCheck,		8'bx_01_x_xx_x_x}:	qNextStCke <= 1'b1;
		{lpStPageReadCmd,	8'bx_xx_1_11_x_x}:	qNextStCke <= 1'b1;
		{lpStBusyCmd,		8'bx_xx_1_10_x_x}:	qNextStCke <= 1'b1;
		{lpStBusyCheck,		8'bx_xx_x_xx_0_x}:	qNextStCke <= 1'b1;
		{lpStReadDataCmd,	8'bx_xx_1_11_x_x}:	qNextStCke <= 1'b1;
		{lpStFlashRead,		8'bx_xx_x_xx_x_1}:	qNextStCke <= 1'b1;
		{lpStCsLowHold,		8'b1_xx_x_xx_x_x}:	qNextStCke <= 1'b1;
		{lpStCsHighHold,	8'b1_xx_x_xx_x_x}:	qNextStCke <= 1'b1;
		default: 								qNextStCke <= 1'b0;
	endcase

	qSfcWd <= {rRd[7:0],rRd[15:8]};	// Sfm に対する MSB,LSB の書き込みに合わせてスワップする
	qSfcWe <= rRe;
end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction



endmodule