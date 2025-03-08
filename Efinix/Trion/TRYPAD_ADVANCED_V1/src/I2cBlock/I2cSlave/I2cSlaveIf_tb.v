`timescale 1ns / 1ps
/**-----------------------------------------------------------------------------
 * I2C Slave If module Test Bench
 * 
 * 23-12-9 v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module I2cSlaveIf_tb;


//-----------------------------------------------------------------------------
// System Simlation Parameter
//-----------------------------------------------------------------------------
localparam lpWaitCycle			= 3000;

//-----------------------------------------------------------------------------
// System 共通変数
//-----------------------------------------------------------------------------
genvar x;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
localparam	lpSCLKCycle = 4;	// CLK サイクル

reg	wSCLK	= 0;
reg	wSRST	= 1;
reg	wnSRST	= 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end


/**----------------------------------------------------------------------------
 * I2C Master Sequence
 *---------------------------------------------------------------------------*/
localparam	lpI2cCycle = 128;	// i2c サイクル

reg rI2cScl = 1'b1;
reg rI2cSda = 1'b1;

always @( posedge wSCLK )
begin
	if (wSRST)
	begin
		rI2cSda <= 1'b1;
	end
	else
	begin
		#(10);
		rI2cSda <= 1'b0;
	end
	
	if (wSRST)
	begin
		rI2cScl <= 1'b1;
	end
	else
	begin
		#(lpI2cCycle/2);
		rI2cScl <= ~rI2cScl;
	end
end

/**----------------------------------------------------------------------------
 * I2C Slave I/F
 *---------------------------------------------------------------------------*/
wire [ 7:0] wSlaveRd;
wire		wSlaveVd;
 
I2cSlaveIf I2cSlaveIf(
	// External Port
	.iI2cScl(rI2cScl),		.oI2cScl(),			.oI2cSclOe(),
	.iI2cSda(rI2cSda),		.oI2cSda(),			.oI2cSdaOe(),
	// Internal Read Data
	.oDd(wSlaveRd),			.oVd(wSlaveVd),
	// Control / Status
	.iSlaveAdrs(7'd0),
	// common
	.iRST(wSRST),			.inRST(wnSRST),		.iCLK(wSCLK)
);


/**----------------------------------------------------------------------------
 * Simlation Start
 *---------------------------------------------------------------------------*/
localparam lpFrameCnt = 1;
integer n;

initial
begin
	$dumpfile("I2cSlaveIf_tb.vcd");
	$dumpvars(0, I2cSlaveIf_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	$display(" ----- SIM START !!");
	reset_init();
	I2cDone(0);
	#(lpSCLKCycle*100);
	$display(" ----- SIM END !!");
    $finish;
end

/**----------------------------------------------------------------------------
 * task
 *---------------------------------------------------------------------------*/
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = ~wSRST;
	#(lpSCLKCycle * 10);
end
endtask

task I2cDone(
	input integer flag
);
begin
	while (wSlaveVd == flag)
	begin
		#(lpSCLKCycle);
	end
end
endtask


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