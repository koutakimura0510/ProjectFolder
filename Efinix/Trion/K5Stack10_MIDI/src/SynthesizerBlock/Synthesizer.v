/*-----------------------------------------------------------------------------
 * Create  2023/4/13
 * Author  koutakimura
 * -
 * シンセサイザーの制御を行う。
 * MIDI 信号をデコードし、パラメータ設定に則ってサウンドを生成する。
 * 
 * V1.0 new release
 *-----------------------------------------------------------------------------*/
module Synthesizer #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8
)(
	// MIDI IN
	input  iMIDI,
	// AUDIO OUT
	output [31:0] oAUDIO,
	//
    // CLK Reset
	input  iMRST,
    input  iSRST,
	input  iMCLK,
    input  iSCLK
);




endmodule