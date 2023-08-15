/*-----------------------------------------------------------------------------
 * Create  2023/8/12
 * Author  kouta kimura
 * -
 * https://westgate-lab.hatenablog.com/entry/2020/07/11/160507
 * v1.00 : new Relaese
 *  
 *-----------------------------------------------------------------------------*/
module MIDIDecoder (
	// MIDI Signal Input
	input iMIDI,
	// control status
	output [15:0] 	oAudioFreq,	// note number
	output			oAudioPlay,	// note on / off 
	// common
	input 	iSRST,
	input	inSRST,
	input 	iSCLK
);


//-----------------------------------------------------------------------------
// MIPI Decode
//-----------------------------------------------------------------------------
wire [7:0] 	wMidiRd;
wire 		wMidiVd;

UartRX #(
	.pBaudRateGenDiv(3200)
) MIPI_RX (
	// External Port
	.iUartRX(iMIDI),
	// Decord Data
	.oRd(wMidiRd),	.oVd(wMidiVd),
	// CLK RST
	.iRST(iSRST),	.iCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// ノートオン / ノートオフ
// ノートオン / ノートオフの次にfreqの情報を取得するため、
// レイテンシを合わせるために2段のレジスタを使用する。
//-----------------------------------------------------------------------------
reg [1:0] 	rMidiNoteChange;
reg			qMidiNoteChangeCke;

always @(posedge iSCLK)
begin
	if (iSRST) 						rMidiNoteChange[0] <=  1'b0;
	else if (qMidiNoteChangeCke)	rMidiNoteChange[0] <= ~rMidiNoteChange[0];
	else 							rMidiNoteChange[0] <=  rMidiNoteChange[0];

	if (iSRST) 			rMidiNoteChange[1] <= 1'b0;
	else if (wMidiVd)	rMidiNoteChange[1] <= rMidiNoteChange[0];
	else 				rMidiNoteChange[1] <= rMidiNoteChange[1];
end

always @*
begin
	case ({wMidiVd,wMidiRd[7:4]})
		'h1_9:		qMidiNoteChangeCke <= 1'b1;	// ノートオン
		'h1_8:		qMidiNoteChangeCke <= 1'b1;	// ノートオフ
		default:	qMidiNoteChangeCke <= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// Get freq
//-----------------------------------------------------------------------------
(* syn_romstyle = "block_rom" *) reg [15:0] rBramNoteFreq [128:0];
reg [15:0] 	rMidiNoteFreq;
reg 		qMidiNoteFreqCke;

always @(posedge iSCLK)
begin
	if (iSRST) 					rMidiNoteFreq <= 16'd0;
	else if (qMidiNoteFreqCke)	rMidiNoteFreq <= rBramNoteFreq[wMidiRd[6:0]];
	else 						rMidiNoteFreq <= rMidiNoteFreq;
end

always @*
begin
	qMidiNoteFreqCke <= &{wMidiVd,(wMidiRd[7:0] < 8'd128)};
end

assign oAudioFreq	= rMidiNoteFreq;
assign oAudioPlay	= rMidiNoteChange[1];

//-----------------------------------------------------------------------------
// BRAM Init
//-----------------------------------------------------------------------------
initial
begin
	rBramNoteFreq[0] = 16'd9;
	rBramNoteFreq[1] = 16'd9;
	rBramNoteFreq[2] = 16'd10;
	rBramNoteFreq[3] = 16'd10;
	rBramNoteFreq[4] = 16'd11;
	rBramNoteFreq[5] = 16'd11;
	rBramNoteFreq[6] = 16'd12;
	rBramNoteFreq[7] = 16'd13;
	rBramNoteFreq[8] = 16'd13;
	rBramNoteFreq[9] = 16'd14;
	rBramNoteFreq[10] = 16'd15;
	rBramNoteFreq[11] = 16'd16;
	rBramNoteFreq[12] = 16'd17;
	rBramNoteFreq[13] = 16'd18;
	rBramNoteFreq[14] = 16'd19;
	rBramNoteFreq[15] = 16'd20;
	rBramNoteFreq[16] = 16'd21;
	rBramNoteFreq[17] = 16'd22;
	rBramNoteFreq[18] = 16'd24;
	rBramNoteFreq[19] = 16'd25;
	rBramNoteFreq[20] = 16'd26;
	rBramNoteFreq[21] = 16'd28;
	rBramNoteFreq[22] = 16'd30;
	rBramNoteFreq[23] = 16'd31;
	rBramNoteFreq[24] = 16'd33;
	rBramNoteFreq[25] = 16'd35;
	rBramNoteFreq[26] = 16'd37;
	rBramNoteFreq[27] = 16'd39;
	rBramNoteFreq[28] = 16'd42;
	rBramNoteFreq[29] = 16'd44;
	rBramNoteFreq[30] = 16'd47;
	rBramNoteFreq[31] = 16'd49;
	rBramNoteFreq[32] = 16'd52;
	rBramNoteFreq[33] = 16'd55;
	rBramNoteFreq[34] = 16'd59;
	rBramNoteFreq[35] = 16'd62;
	rBramNoteFreq[36] = 16'd66;
	rBramNoteFreq[37] = 16'd70;
	rBramNoteFreq[38] = 16'd74;
	rBramNoteFreq[39] = 16'd78;
	rBramNoteFreq[40] = 16'd83;
	rBramNoteFreq[41] = 16'd88;
	rBramNoteFreq[42] = 16'd93;
	rBramNoteFreq[43] = 16'd98;
	rBramNoteFreq[44] = 16'd104;
	rBramNoteFreq[45] = 16'd110;
	rBramNoteFreq[46] = 16'd117;
	rBramNoteFreq[47] = 16'd124;
	rBramNoteFreq[48] = 16'd131;
	rBramNoteFreq[49] = 16'd139;
	rBramNoteFreq[50] = 16'd147;
	rBramNoteFreq[51] = 16'd156;
	rBramNoteFreq[52] = 16'd165;
	rBramNoteFreq[53] = 16'd175;
	rBramNoteFreq[54] = 16'd185;
	rBramNoteFreq[55] = 16'd196;
	rBramNoteFreq[56] = 16'd208;
	rBramNoteFreq[57] = 16'd220;
	rBramNoteFreq[58] = 16'd234;
	rBramNoteFreq[59] = 16'd247;
	rBramNoteFreq[60] = 16'd262;
	rBramNoteFreq[61] = 16'd278;
	rBramNoteFreq[62] = 16'd294;
	rBramNoteFreq[63] = 16'd312;
	rBramNoteFreq[64] = 16'd330;
	rBramNoteFreq[65] = 16'd350;
	rBramNoteFreq[66] = 16'd370;
	rBramNoteFreq[67] = 16'd392;
	rBramNoteFreq[68] = 16'd416;
	rBramNoteFreq[69] = 16'd440;
	rBramNoteFreq[70] = 16'd467;
	rBramNoteFreq[71] = 16'd494;
	rBramNoteFreq[72] = 16'd524;
	rBramNoteFreq[73] = 16'd555;
	rBramNoteFreq[74] = 16'd588;
	rBramNoteFreq[75] = 16'd623;
	rBramNoteFreq[76] = 16'd660;
	rBramNoteFreq[77] = 16'd699;
	rBramNoteFreq[78] = 16'd740;
	rBramNoteFreq[79] = 16'd784;
	rBramNoteFreq[80] = 16'd831;
	rBramNoteFreq[81] = 16'd880;
	rBramNoteFreq[82] = 16'd933;
	rBramNoteFreq[83] = 16'd988;
	rBramNoteFreq[84] = 16'd1047;
	rBramNoteFreq[85] = 16'd1109;
	rBramNoteFreq[86] = 16'd1175;
	rBramNoteFreq[87] = 16'd1245;
	rBramNoteFreq[88] = 16'd1319;
	rBramNoteFreq[89] = 16'd1397;
	rBramNoteFreq[90] = 16'd1480;
	rBramNoteFreq[91] = 16'd1568;
	rBramNoteFreq[92] = 16'd1662;
	rBramNoteFreq[93] = 16'd1760;
	rBramNoteFreq[94] = 16'd1865;
	rBramNoteFreq[95] = 16'd1976;
	rBramNoteFreq[96] = 16'd2094;
	rBramNoteFreq[97] = 16'd2218;
	rBramNoteFreq[98] = 16'd2350;
	rBramNoteFreq[99] = 16'd2490;
	rBramNoteFreq[100] = 16'd2638;
	rBramNoteFreq[101] = 16'd2794;
	rBramNoteFreq[102] = 16'd2960;
	rBramNoteFreq[103] = 16'd3136;
	rBramNoteFreq[104] = 16'd3323;
	rBramNoteFreq[105] = 16'd3520;
	rBramNoteFreq[106] = 16'd3730;
	rBramNoteFreq[107] = 16'd3952;
	rBramNoteFreq[108] = 16'd4187;
	rBramNoteFreq[109] = 16'd4435;
	rBramNoteFreq[110] = 16'd4699;
	rBramNoteFreq[111] = 16'd4979;
	rBramNoteFreq[112] = 16'd5275;
	rBramNoteFreq[113] = 16'd5588;
	rBramNoteFreq[114] = 16'd5920;
	rBramNoteFreq[115] = 16'd6272;
	rBramNoteFreq[116] = 16'd6645;
	rBramNoteFreq[117] = 16'd7040;
	rBramNoteFreq[118] = 16'd7459;
	rBramNoteFreq[119] = 16'd7903;
	rBramNoteFreq[120] = 16'd8373;
	rBramNoteFreq[121] = 16'd8870;
	rBramNoteFreq[122] = 16'd9398;
	rBramNoteFreq[123] = 16'd9957;
	rBramNoteFreq[124] = 16'd10549;
	rBramNoteFreq[125] = 16'd11176;
	rBramNoteFreq[126] = 16'd11840;
	rBramNoteFreq[127] = 16'd12544;
end


endmodule