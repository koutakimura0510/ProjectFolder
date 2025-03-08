/*-----------------------------------------------------------------------------
 * Create  2023/6/3
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * -
 * V1.0：乗算器を使用した、疑似 Sin 波形生成回路
 * 
 *-----------------------------------------------------------------------------*/	
module SinGenDsp (
	output signed [15:0] oSin,
	output oVd,
	input  iRST,
	input  iCLK
);

reg signed [15:0] sin_sample;			assign oSin = sin_sample;
reg [31:0] phase_accumulator;
reg [15:0] amplitude = 32767; // 振幅の調整
reg [31:0] phase_increment = 1666; // 周波数の設定

always @(posedge iCLK)
begin
	if (iRST)	phase_accumulator <= 0;
	else 		phase_accumulator <= phase_accumulator + phase_increment;

	if (iRST)	sin_sample <= 0;
	else 		sin_sample <= amplitude * $sin(phase_accumulator[31:16]);
end


// fn+1 = fn + k * gn
// gn+1 = gn - k * fn+1
// localparam 	      lpN = 18;
// localparam signed [17:0] lpk   = 1608;
// localparam [17:0] lpFix = 262144;

// reg signed [35:0] rFn1;
// reg signed [17:0] rGn1;

// (* syn_use_dsp = "yes" *) wire signed [35:0] wGnk = rGn1[15:0] * lpk;
// wire signed [35:0] wFn1 = wGnk[35:18] + rFn1;
// wire signed [35:0] wFn1k = rFn1[17:0] * lpk;

// (* syn_use_dsp = "yes" *) wire signed [35:0] wGnFix = rGn1 * lpFix;
// (* syn_use_dsp = "yes" *) wire signed [35:0] wGn1 = wGnFix - wFn1k;

// reg  rFnSel;
// reg  qFnCke, qFn1Cke;

// always @(posedge iCLK)
// begin
// 	if (iRST) 			rFn1 <= 36'd0;
// 	else if (qFn1Cke)	rFn1 <= wFn1;
// 	else 				rFn1 <= rFn1;

// 	if (iRST)			rFnSel <= 1'b0;
// 	else 				rFnSel <= ~rFnSel;

// 	if (iRST) 			rGn1 <= 18'd32767;
// 	else if (qFnCke)	rGn1 <= wGn1[35:18];
// 	else 				rGn1 <= rGn1;
// end

// always @*
// begin
// 	qFnCke	<=  rFnSel;
// 	qFn1Cke	<= ~rFnSel;
// end

// assign oSin = rFn1[15:0];
// assign oCos = rGn1[15:0];

endmodule