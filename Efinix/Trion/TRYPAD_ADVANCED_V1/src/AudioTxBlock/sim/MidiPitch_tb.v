/*-----------------------------------------------------------------------------
 * Midi Decoder Simlation
 * 
 * 23-08-26 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module MidiPitch_tb;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
genvar x;
localparam	lpSCLKCycle = 4;	// CLK サイクル
localparam	lpMCLKCycle = 7;	// CLK サイクル

reg	wSCLK = 0;		reg	wMCLK = 0;
reg	wSRST = 1;		reg	wMRST = 1;
reg	wnSRST = 0;		reg	wnMRST = 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end

always begin
    #(lpMCLKCycle/2);
    wMCLK = ~wMCLK;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = ~wSRST;
	wMRST  = 0;
	wnMRST = ~wMRST;
	#(lpSCLKCycle * 10);
end
endtask


//-----------------------------------------------------------------------------
// MIDI Signal Gen Debug
// MIDI 送信データを BRAM に保存し、一定間隔(rMidiWeWait)で MIDI Decode Unit に送信する。
// Decode Unit 内部で、Note On/Off の命令どおりに Channnel の割当てやデータ生成を行えることを確認する。
//-----------------------------------------------------------------------------
reg [7:0] 	rMidiWd[255:0];
reg 		rMidiWe;
reg [7:0]	rMidiWa;
reg [3:0]	rMidiWeWait;
reg 		qMidiWeCke;

always @(posedge wSCLK)
begin
	if (wSRST) 	rMidiWeWait <= 4'd0;
	else 		rMidiWeWait <= rMidiWeWait + 1'b1;

	if (wSRST)				rMidiWe <= 1'b0;
	else if (qMidiWeCke)	rMidiWe <= 1'b1;
	else 					rMidiWe <= 1'b0;

	if (wSRST)				rMidiWa <= 8'd0;
	else if (qMidiWeCke)	rMidiWa <= rMidiWa + 1'b1;
	else 					rMidiWa <= rMidiWa;
end

always @*
begin
	qMidiWeCke <= (rMidiWeWait == 4'd15);
end

initial
begin
	rMidiWd[0] = 8'h90;	// note on
	rMidiWd[1] = 8'h36;	// tone
	rMidiWd[2] = 8'h30;	// strength 
	rMidiWd[3] = 8'h90; // note on
	rMidiWd[4] = 8'h40; 
	rMidiWd[5] = 8'h20;
	rMidiWd[6] = 8'h90; // note on
	rMidiWd[7] = 8'h44;
	rMidiWd[8] = 8'h20;
	//
	rMidiWd[9] = 8'h80; // note off
	rMidiWd[10] = 8'h44;
	rMidiWd[11] = 8'h20;
	//
	rMidiWd[12] = 8'h90; // note on
	rMidiWd[13] = 8'h12;
	rMidiWd[14] = 8'h20;
	//
	rMidiWd[15] = 8'h90; // note on
	rMidiWd[16] = 8'h14;
	rMidiWd[17] = 8'h20;
	//
	rMidiWd[18] = 8'h80;	// note off
	rMidiWd[19] = 8'h36;	// tone
	rMidiWd[20] = 8'h30;	// strength 
end

//-----------------------------------------------------------------------------
// Midi Decoder
// 
// oAudioFreq
// Note Tone に応じて周波数の増減値を出力する。
// 
// oAudioPlay
// Note On を受信することで AudioPlay が "L"->"H"に遷移する。
// Note Off を受信することで AudioPlay が "H"->"L"に遷移する。
// 
//-----------------------------------------------------------------------------
localparam lpAudioBitDepth = 8;
localparam lpIntegerFileName = "../dat/IndexInteger.dat";
localparam lpDecimalFileName = "../dat/IndexDecimal.dat";
localparam lpPitchFileName = "../dat/PitchSin.dat";

wire [lpAudioBitDepth-1:0] 	wPitAudioFreq;
reg  qPitNoteOn;

MidiPitch #(
	.pAudioBitDepth(lpAudioBitDepth),
	.pIntegerFileName(lpIntegerFileName),
	.pDecimalFileName(lpDecimalFileName),
	.pPitchFileName(lpPitchFileName)
) MidiPitch (
	// MIDI Status
	.iNoteNumber(rMidiWd[rMidiWa][6:0]),
	.iNoteOn(qPitNoteOn),
	// Audio Signals
	.oAudioFreq(wPitAudioFreq),
	// Common
	.iRST(wSRST),
	.iCLK(wSCLK)
);

always @*
begin
	qPitNoteOn <= 1'b1;//qMidiWeCke;
end

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
integer i;

initial begin
	$dumpfile("MidiPitch_tb.vcd");
	$dumpvars(0, MidiPitch_tb);	// 引数0:下位モジュール表示, 1:Topのみ

	for (i = 0; i < 128; i++)
	begin
		$dumpvars(0, MidiPitch.MidiPitchIndex.rIntBram[i]);	// 引数0:下位モジュール表示, 1:Topのみ
	end

	reset_init();
	#(lpMCLKCycle * 4800);
    $finish;
end


endmodule