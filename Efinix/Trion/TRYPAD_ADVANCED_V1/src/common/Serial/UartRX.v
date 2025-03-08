/*-----------------------------------------------------------------------------
 * Create  2023/04/15
 * Author  kouta kimura
 * -
 * UART RX module
 * 2023-08-22 v1.01 : UART RX 信号の中央のタイミングでサンプリングするように変更
 *-----------------------------------------------------------------------------*/
module UartRX #(
	parameter	pBaudRateGenDiv = 1600	// 100[MHz]/3200=31250[kbps]
)(
	// UART RX
	input  iUartRX,
	// Status
	output oUartRxThru,
	output [7:0] oRd,
	output oVd,
	// Clk Reset
    input  iRST,
    input  iCLK
);


//-----------------------------------------------------------------------------
// Debug Thru Uart
//-----------------------------------------------------------------------------
reg rUartRxThru;		assign oUartRxThru = rUartRxThru;

always @(posedge iCLK)
begin
	rUartRxThru <= iUartRX;
end


//-----------------------------------------------------------------------------
// UART Decord
//-----------------------------------------------------------------------------
localparam lpBaudRateWidth = func_getwidth(pBaudRateGenDiv);
localparam [lpBaudRateWidth-1:0] lpBaudRateGenDiv = pBaudRateGenDiv;
localparam [lpBaudRateWidth-1:0] lpCenterCntMax = lpBaudRateGenDiv / 2;
localparam [1:0]
	lpStartBit = 0,
	lpCenterWait = 1,
	lpSampling = 2,
	lpStopBit  = 3;

reg  [1:0] rState;
reg  [lpBaudRateWidth-1:0] rBaudRateCnt;
reg  qBaudRateCntRst;
reg  qBaudRateCntMaxCke;
reg  [lpBaudRateWidth-1:0] rCenterCnt;
reg  qCenterCke;
reg  [3:0] rSampCnt;
reg  qSampCke;
reg  [7:0] rRd;			assign oRd = {rRd[0],rRd[1],rRd[2],rRd[3],rRd[4],rRd[5],rRd[6],rRd[7]};	// iUartRX は LSB から取得するので Bit Swap する
reg  qRdCke;
reg  rVd, qVdCke;		assign oVd = rVd;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rState	<= lpStartBit;
	end
	else
	begin
		case (rState)
			lpStartBit:		rState	<= (iUartRX) 	? lpStartBit : lpCenterWait;		// Low検出
			lpCenterWait:	rState 	<= (qCenterCke) ? lpSampling : lpCenterWait;		// 信号の中央でサンプリングするように、タイミング調整
			lpSampling:		rState	<= (qSampCke) 	? lpStopBit : lpSampling;
			lpStopBit: 		rState	<= (qBaudRateCntMaxCke) ? lpStartBit : lpStopBit;	// StopBit は送信されるものとして、特に検出せずにボーレートの速度で lpStartBit に遷移
			default: 		rState	<= lpStartBit;
		endcase
	end
end

always @(posedge iCLK)
begin
	if (qRdCke) rRd <= {rRd[6:0], iUartRX};	// ボーレートの速度でサンプリング
	else 		rRd <=  rRd;

	if (iRST)				rVd <= 1'b0;
	else if (qVdCke)		rVd <= 1'b1;	// 1ショットパルスの生成
	else 					rVd <= 1'b0;

	if (rState==lpCenterWait)	rCenterCnt <= rCenterCnt + 1'b1;	// タイミング調整
	else 						rCenterCnt <= {lpBaudRateWidth{1'b0}};

	if (rState==lpStartBit)			rSampCnt <= 4'd0;
	else if (qBaudRateCntMaxCke)	rSampCnt <= rSampCnt + 1'b1;	// サンプリング回数をカウント
	else 							rSampCnt <= rSampCnt;

	if (qBaudRateCntRst)	rBaudRateCnt <= {lpBaudRateWidth{1'b0}};	// カウンターを動作させて、TX側とボーレートの同期を取る。
	else 					rBaudRateCnt <= rBaudRateCnt + 1'b1;
end

always @*
begin
	qBaudRateCntRst		<= |{(rState==lpStartBit),(rState==lpCenterWait),qBaudRateCntMaxCke};
	qBaudRateCntMaxCke 	<= (rBaudRateCnt == lpBaudRateGenDiv);
	qCenterCke <= (rCenterCnt == lpCenterCntMax);
	qSampCke <= (rSampCnt == 4'd8);
	qRdCke   <= &{qBaudRateCntMaxCke,rState==lpSampling};
	qVdCke   <= &{qBaudRateCntMaxCke,qSampCke};
end

//---------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//---------------------------------------------------------------------------
function[  7:0]	func_getwidth;
    input [31:0] iVAL;
    integer			i;

    begin
    func_getwidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            func_getwidth = i+1;
        end
    end
endfunction

endmodule