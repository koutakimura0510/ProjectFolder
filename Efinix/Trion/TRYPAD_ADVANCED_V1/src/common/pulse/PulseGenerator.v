//----------------------------------------------------------
// Pulse信号生成モジュール
// 指定タイミングで Pulse 信号を出力
// 
// 2022/7/21
// 23-08-19 v1.01: パルス生成ロジックの修正、ロジック規模縮小
//----------------------------------------------------------
module PulseGenerator #(
    parameter 		pDivClk  	= 25000000, // 分周クロックの値を指定
	parameter [0:0] pStartPulse = 1'b1		// 起動時の Pulse の High/Low 指定
)(
    output  oPulse,
    input   iRST,
    input   iCLK
);


//----------------------------------------------------------
// reg Bit Length
//----------------------------------------------------------
localparam 						lpCtuCNTBits	= f_detect_bitwidth(pDivClk);
localparam [lpCtuCNTBits-1:0] 	lpTmpCountMax	= pDivClk - 1'b1;
localparam [lpCtuCNTBits-1:0] 	lpTmpCountRst	= 0;


//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [lpCtuCNTBits-1:0] rTmpCount;
reg qRst, qCke;

always @( posedge iCLK )
begin
    if (qRst)	rTmpCount <= lpTmpCountRst;
    else 		rTmpCount <= rTmpCount + 1'b1;
end

always @*
begin
	qCke <= (rTmpCount == lpTmpCountMax);
	qRst <= |{iRST,qCke};
end

//----------------------------------------------------------
// Ckeの立ち上がりタイミング で Pulse をトグルさせ出力
//----------------------------------------------------------
reg  rPulse;			assign oPulse = rPulse;

always @(posedge iCLK)
begin
	if (iRST) 		rPulse <= pStartPulse;
	else if (qCke)	rPulse <= ~rPulse;
	else 			rPulse <=  rPulse;
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
