/*-----------------------------------------------------------------------------
 * Create  2023/07/21
 * Author  kouta kimura
 * -
 * UFIB Master Side バースト転送回数をカウントする
 *-----------------------------------------------------------------------------*/
module UfibBurstCnt #(
	parameter	pBurstCntNum 		= 256,
	parameter	pBurstCntBitWidth 	= f_detect_bitwidth(pBurstCntNum)
)(
	// Runner
	output 		oBurstRun,
	// CLK Reset
	input 		iRST,
	input 		iCKE,
	input 		iCLK
);


//-----------------------------------------------------------------------------
// Burst 転送 カウント
//-----------------------------------------------------------------------------
reg 						rBurstRun;				assign oBurstRun = rBurstRun;
reg 						qBurstRunCke;
reg [pBurstCntBitWidth-1:0]	rBurstCnt;
reg 						qBurstCntCke;
reg [2:0] 					rBurstWaitCnt;
reg 						qBurstWaitCntCke;

always @(posedge iCLK)
begin
	if (iRST)					rBurstRun <= 1'b0;
	else if (qBurstRunCke)		rBurstRun <= ~rBurstRun;
	else 						rBurstRun <=  rBurstRun;

	if (iRST) 					rBurstCnt <= {pBurstCntBitWidth{1'b0}};
	else if (qBurstCntCke)		rBurstCnt <= rBurstCnt + 1'b1;
	else 						rBurstCnt <= rBurstCnt;

	if (iRST) 					rBurstWaitCnt <= 3'd0;
	else if (qBurstWaitCntCke)	rBurstWaitCnt <= rBurstWaitCnt + 1'b1;
	else 						rBurstWaitCnt <= rBurstWaitCnt;
end

always @*
begin
	casex ({rBurstRun,(rBurstWaitCnt==3'd7),(rBurstCnt=={pBurstCntBitWidth{1'b1}})})
		'b1x1: 		qBurstRunCke <= 1'b1;	// Stop
		'b01x: 		qBurstRunCke <= 1'b1;	// Start
		default: 	qBurstRunCke <= 1'b0;
	endcase

	qBurstCntCke		<= iCKE & rBurstRun;
	qBurstWaitCntCke	<= ~rBurstRun;
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