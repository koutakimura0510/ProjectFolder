/*-----------------------------------------------------------------------------
 * Create  2023/05/13
 * Author  kouta kimura
 * -
 * UART TX module
 * 
 *-----------------------------------------------------------------------------*/
module UartTX #(
	parameter pBaudRateGenDiv = 1600,	// 100[MHz]/3200=31250[kbps]
	parameter pDqBitWidth = 16
)(
	output oUartTX,
	// status
	input  [pDqBitWidth-1:0] iWd,
	input  iWe,
	output oRdy,	
	// Clk Reset
    input  iRST,
    input  iCLK
);



//-----------------------------------------------------------------------------
// UART Decord
//-----------------------------------------------------------------------------
localparam lpBaudRateWidth = func_getwidth(pBaudRateGenDiv);
localparam [lpBaudRateWidth-1:0] lpBaudRateGenDiv = pBaudRateGenDiv;
localparam [1:0]
	lpStartBit = 0,
	lpEncode   = 1,
	lpStopBit  = 2,
	lpCRLF     = 3;

reg  [1:0] rState;
reg  [lpBaudRateWidth-1:0] rBaudRateCnt; reg qBaudRateCntMaxCke;
reg  [3:0] rSampCnt; reg qSampCke;
reg  [(pDqBitWidth*2)+8-1:0] rDqAscii;	// Data + "\n"
reg  qDqCaptureCke;
integer x;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rState	<= lpStartBit;
	end
	else
	begin
		case (rState)
			lpStartBit:	rState	<= (iUartRX) ? lpStartBit : lpSampling;		// Low遷移検出
			lpSampling:	rState	<= (qSampCke) ? lpStopBit : lpSampling;
			lpStopBit: 	rState	<= (qBaudRateCntMaxCke) ? lpStartBit : lpStopBit;	// StopBit は送信されるものとして、特に検出せずにボーレートの速度で lpStartBit に遷移
			default: 	rState	<= lpStartBit;
		endcase
	end
end

generate
for (x = 0; x < pDqBitWidth/4; x = x + 1)
begin
	always @(posedge iCLK)
	begin
		if (qDqCaptureCke)
		begin
			case (iWd[((x+1)*4)-1:x*4])
			4'd0: 	 rDqAscii[((x+1)*8)-1:x*8] <= "0";
			4'd1: 	 rDqAscii[((x+1)*8)-1:x*8] <= "1";
			4'd2: 	 rDqAscii[((x+1)*8)-1:x*8] <= "2";
			4'd3: 	 rDqAscii[((x+1)*8)-1:x*8] <= "3";
			4'd4: 	 rDqAscii[((x+1)*8)-1:x*8] <= "4";
			4'd5: 	 rDqAscii[((x+1)*8)-1:x*8] <= "5";
			4'd6: 	 rDqAscii[((x+1)*8)-1:x*8] <= "6";
			4'd7: 	 rDqAscii[((x+1)*8)-1:x*8] <= "7";
			4'd8: 	 rDqAscii[((x+1)*8)-1:x*8] <= "8";
			4'd9: 	 rDqAscii[((x+1)*8)-1:x*8] <= "9";
			4'dA: 	 rDqAscii[((x+1)*8)-1:x*8] <= "A";
			4'dB: 	 rDqAscii[((x+1)*8)-1:x*8] <= "B";
			4'dC: 	 rDqAscii[((x+1)*8)-1:x*8] <= "C";
			4'dD: 	 rDqAscii[((x+1)*8)-1:x*8] <= "D";
			4'dE: 	 rDqAscii[((x+1)*8)-1:x*8] <= "E";
			4'dF: 	 rDqAscii[((x+1)*8)-1:x*8] <= "F";
			default: rDqAscii[((x+1)*8)-1:x*8] <= "\n";
			endcase
		end
		else
		begin
			rDqAscii[((x+1)*8)-1:x*8] <= "\n";
		end
	end
end
endgenerate

always @(posedge iCLK)
begin
	rDqAscii[(pDqBitWidth*2)+8-1:pDqBitWidth+8] <= "\n";

	else if (qBaudRateCntMaxCke)	rDqAscii <= {rDqAscii[pDqBitWidth-2:0],1'b1}
	else 							rDqAscii <= rDqAscii;

	if (rState==lpStartBit)			rSampCnt <= 4'd0;
	else if (qBaudRateCntMaxCke)	rSampCnt <= rSampCnt + 1'b1;	// サンプリング回数をカウント
	else 							rSampCnt <= rSampCnt;

	if (rState==lpStartBit) 		rBaudRateCnt <= {lpBaudRateWidth{1'b0}};	// Start Bit 検出から、カウンターを動作させて、TX側とボーレートの同期を取る。
	else if (qBaudRateCntMaxCke)	rBaudRateCnt <= {lpBaudRateWidth{1'b0}};
	else 							rBaudRateCnt <= rBaudRateCnt + 1'b1;
end

always @*
begin
	qDqCaptureCke <= iWe & ;
	qBaudRateCntMaxCke <= (rBaudRateCnt == lpBaudRateGenDiv);
	qSampCke <= (rSampCnt == 4'd8);
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