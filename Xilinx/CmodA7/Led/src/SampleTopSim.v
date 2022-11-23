//----------------------------------------------------------
// Create  2022/08/26
// Author  koutakimura
// -
// 
// 
//----------------------------------------------------------
module SampleTopSim;

//----------------------------------------------------------
// comment
//----------------------------------------------------------
parameter CYCLE = 2;
reg rSysClk     = 0;


//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
SampleTop TOP (
    .iOscSystemClk      (rSysClk),
	.oLed				(oLed),
	.oLedB				(oLedB),
	.oLedG				(oLedG),
	.oLedR				(oLedR),
	.oTestPort			(oTestPort)
);

always begin
    #(CYCLE/2);
    rSysClk = ~rSysClk;
end

initial begin
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
