/**-------------------------------------------------
 * 1sec count 7segmen led
 * -------------------------------------------------*/
module SEG10_COUNT (
	input CLK, RST,
	output [7:0] HEX0,
	output [7:0] HEX1
);


/**-------------------------------------------------
 * 1Hz cycle --- CLK50MHz
 * -------------------------------------------------*/
reg [25:0] systemclk;
reg [3:0] CNT10;	// 10sec
reg [2:0] CNT6;	// 10minutu
wire enable = (systemclk == 26'd49_999_99);


/**-------------------------------------------------
 * 1sec counter Generate
 * -------------------------------------------------*/
always @ (posedge CLK)
begin
	if (RST == 1'b1) 
		systemclk <= 26'b0;
	else if (enable == 1'b1)
		systemclk <= 26'b0;
	else
		systemclk <= systemclk + 26'b1;
end


/**-------------------------------------------------
 * 7segment move
 * -------------------------------------------------*/
always @(posedge CLK)
begin
	if (RST == 1'b1)
		CNT10 <= 4'h0;
	else if (enable == 1'b1)
		if (CNT10 == 4'h9)
			CNT10 <= 4'h0;
		else
			CNT10 <= CNT10 + 4'h1;
end


always @(posedge CLK)
begin
	if (RST == 1'b1)
		CNT6 <= 3'h0;
	else if ((enable == 1'b1) && (CNT10 == 4'h9))
	begin
		if (CNT6 == 3'h5)
			CNT6 <= 3'h0;
		else
			CNT6 <= CNT6 + 3'h1;
	end
end		

DECODER dec_min(CNT6, HEX1);
DECODER dec_sec(CNT10, HEX0);

endmodule