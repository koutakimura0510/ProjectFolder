/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MVideoTimingGen.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Revision    :
 * 02/Jan-2023 V1.00 New Release, Inh.fr. "MVideoTimingGen.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MColorBarGen #(
	parameter					pColorWidth = 16
)(
	input	[11:0]				iHpos,
	input	[11:0]				iVpos,
	//
	output	[pColorWidth-1:0]	oWd,
	//
    input						iRST,
    input						iCLK
);

//
reg [pColorWidth-1:0] rWd;

always @(posedge iCLK)
begin
	if (iRST) 	rWd <= D;
	else 		rWd <= D;
end


//-----------------------------------------------------------------------------
// Color Gen
//-----------------------------------------------------------------------------
function[pColorWidth-1:0] fColor;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule