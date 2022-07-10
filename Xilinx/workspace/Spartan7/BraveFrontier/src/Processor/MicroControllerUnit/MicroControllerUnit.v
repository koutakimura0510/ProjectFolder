//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// プロセッサ内部構造の Master を司るブロック
// 独自の I/F BUS をマスターの立場から操作し、
// BUS に接続されている Slaveブロック の操作を行う。
// 
//----------------------------------------------------------
module MicroControllerBlock (
    // Internal Port
	// Bus System
	
    // CLK Reset
    input           iSysClk,
    input           iSysRst,
);

// 
assign ioSpiSck      	= 1'bz;
assign ioSpiMiso    	= 1'bz;
assign ioSpiMosi    	= 1'bz;
assign ioSpiWp      	= 1'bz;
assign ioSpiHold    	= 1'bz;
assign oSpiConfigCs 	= 0;
assign oSpiCs1      	= 0;
assign oSpiCs2      	= 0;
assign oSwScl			= 1'b0;
assign ioSwSda			= 1'bz;
assign oUartTx			= 1'b0;
assign oLedEdge			= 1'b0;
assign oLedClk			= 1'b0;
assign oPixelData		= 1'b0;
assign oBackLightControl= 1'b0;
assign oAudioData		= 1'b0;

//----------------------------------------------------------
// デバッグ用 MicroBlaze
//----------------------------------------------------------
MicroBlaze MCS;



endmodule