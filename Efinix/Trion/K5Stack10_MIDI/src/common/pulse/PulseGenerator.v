//----------------------------------------------------------
// Pulse信号生成モジュール
// 
// 2022/7/21
// 指定タイミングで Pulse 信号を出力
//----------------------------------------------------------
module PulseGenerator #(
    parameter 		pSysClk  	= 25000000, // 分周クロックの値を指定
    parameter [7:0]	pTimeCke 	= 8'd1,     // Enable 出力の時間指定
	parameter [0:0] pStartPulse = 1'b1		// 起動時の Pulse の High/Low 指定
)(
    output  oPulse,
    input   iRST,
    input   iCLK
);


//----------------------------------------------------------
// reg Bit Length
//----------------------------------------------------------
localparam 						lpCtuCNTBits= f_detect_bitwidth(pSysClk);
localparam [lpCtuCNTBits-1:0] 	lpSysCnt 	= pSysClk-1'b1;
localparam [lpCtuCNTBits-1:0] 	lpRstCnt 	= 0;


//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [lpCtuCNTBits-1:0] rTmpCount;
reg qCke;

always @( posedge iCLK )
begin
    if (iRST)    rTmpCount <= lpRstCnt;
    else if (qCke)  rTmpCount <= lpRstCnt;
    else            rTmpCount <= rTmpCount + 1'b1;
end

always @*
begin
    qCke = rTmpCount == lpSysCnt;
end

//----------------------------------------------------------
// 指定時間カウント時 Cke 出力
//----------------------------------------------------------
reg [7:0] rTimeCkeCnt;
reg qTimeCke;

always @( posedge iCLK )
begin
    if (iRST)        rTimeCkeCnt <= 8'd0;
    else if (qTimeCke)  rTimeCkeCnt <= 8'd0;
    else if (qCke)      rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
    else                rTimeCkeCnt <= rTimeCkeCnt;
end

always @*
begin
    qTimeCke <= pTimeCke == rTimeCkeCnt;
end

//----------------------------------------------------------
// Ckeの立ち上がりタイミング で Pulse をトグルさせ出力
//----------------------------------------------------------
reg  rPulse;			assign oPulse = rPulse;

always @(posedge iCLK)
begin
	if (iRST) 		rPulse <= pStartPulse;
	else if (qTimeCke)	rPulse <= ~rPulse;
	else 				rPulse <= rPulse;
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
