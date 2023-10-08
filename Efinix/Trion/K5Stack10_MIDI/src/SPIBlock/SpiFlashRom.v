/*-----------------------------------------------------------------------------
 * Create  2023/05/28
 * Author  Kimura
 * -
 * 外部 SPI フラッシュメモリとの通信を行う
 * 
 *-----------------------------------------------------------------------------*/
module SpiFlashRom (
	// External Port
	output oFlashRomSck,
	output oFlashRomMosi,
	input  iFlashRomMiso,
	output oFlashRomCs,
	// data
	input  [7:0] iWd,
	output [7:0] oRd,
	// Control Status
	input  iDivCke,
	input  iSpiEn,
	input  iCsOutCtrl,
	output oSpiIntr,
	// CLK Reset
	input  iSRST,
	input  iSCLK
);


//----------------------------------------------------------
// FPGA Master Side
// 1byte 送信のみ対応しており、4byte(32bit)のデータを送受信する場合は、
// 上位モジュールで対応を行う。
// このロジックはあくまで、1byte 送受信を行うだけにとどめる。
//----------------------------------------------------------
localparam [0:0]
	lpHolTimeIdle 		= 0,
	lpHoldTimeActive 	= 1;
localparam [2:0]
	lpHoldTimeMax   	= 2,
	lpHoldTimeClear 	= 0;

reg [7:0] 	rRd;
reg 		rSpiIntr;
reg 		rSck;
reg [7:0] 	rMosi;
reg [2:0] 	rSckNegCnt;
reg [2:0] 	rHoldTime;		reg qHoldTimeCke;
reg [0:0]	rHoldTimeState;
reg 		qSckCntCke;		// Master CLK の立ち下がり最大カウント
//
reg 		qSckRst;

always @(posedge iSCLK) 
begin
	// Sck の生成
	if (qSckRst)		rSck <=  1'b0;
	else if (iDivCke)	rSck <= ~rSck;
	else 				rSck <=  rSck;

	// Sck の立ち下がり回数カウント
	casex ({iSRST, iSpiEn, iDivCke, rSck})
		4'b1x_xx:		rSckNegCnt	<= 3'd0;
		4'bx0_xx:		rSckNegCnt	<= 3'd0;
		4'bx1_11:		rSckNegCnt	<= rSckNegCnt + 1'b1;
		default:		rSckNegCnt	<= rSckNegCnt;
	endcase

	// Sck negedge 後の Hold time 生成 ステートマシン
	casex ({iSRST, iSpiEn, qHoldTimeCke, rHoldTimeState[0:0], iDivCke, rSck})
		6'b1x_xx_xx:	rHoldTimeState <= lpHolTimeIdle;
		6'bx0_xx_xx:	rHoldTimeState <= lpHolTimeIdle;
		6'bx1_00_11:	rHoldTimeState <= lpHoldTimeActive;
		6'bx1_11_xx:	rHoldTimeState <= lpHolTimeIdle;
		default:		rHoldTimeState <= rHoldTimeState;
	endcase

	// Sck Hold Time Generate -> min 15ns lpHoldTimeActive
	// Sck の立下り時に Hold Time Count Start
	casex ({iSpiEn, qHoldTimeCke, rHoldTimeState})
		3'b0xx:			rHoldTime <= lpHoldTimeClear;
		3'bx00:			rHoldTime <= lpHoldTimeClear;
		3'bx01:			rHoldTime <= rHoldTime + 1'b1;
		default: 		rHoldTime <= lpHoldTimeClear;
	endcase

	// MOSI 設定 Mode の Hold Time 経過後データ送信
	if (!iSpiEn)			rMosi <=  iWd;
	else if (qHoldTimeCke)	rMosi <= {rMosi[6:0], 1'b1};
	else					rMosi <=  rMosi;

	// MISO 設定 Mode の SCK エッジで受信
	case ({rSck,iDivCke})
		2'b01:		rRd <= {rRd[6:0], iFlashRomMiso};
		default:	rRd <= rRd;
	endcase

	// 1byte データ操作完了の割り込み出力
	// Assert されると、CSR 空間の SpiEn がクリアされる。
	case ({qSckCntCke, iDivCke, rSck})
		3'b111:			rSpiIntr <= 1'b1;
		default:		rSpiIntr <= 1'b0;
	endcase
end

always @*
begin
	qSckCntCke		<= (rSckNegCnt == 3'd7);
	qHoldTimeCke 	<= (rHoldTime == lpHoldTimeMax);
	//
	qSckRst			<= |{iSRST,~iSpiEn};
end

assign oRd				= rRd;
assign oSpiIntr			= rSpiIntr;
assign oFlashRomSck	  	= rSck;
assign oFlashRomMosi  	= rMosi[7];
assign oFlashRomCs	  	= iCsOutCtrl;


endmodule