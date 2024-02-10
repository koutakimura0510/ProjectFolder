/**-----------------------------------------------------------------------------
 * 24-01-21 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module McuMemoryAccess (
	//
	output	[15:0]	oCfgDq,
	output			oCfgClk,
	output			oCfgCs,
	output			oCfgEn,
	// control / status
	input 	[7:0]	iCfgCmd,
	input			iCfgEn,			// Config Enable
	output			oCfgDone,		// Config Done
	// Clk Reset
	input			iRST,
	input			iCKE,
	input			iCLK
);

/**---------------------------------------------------------------------------
 ロジック処理
 . Core Rst
 . Cmd Set
 . Cfg Enable
 *---------------------------------------------------------------------------*/

endmodule