////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2022 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   efx_single_port_ram.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /    
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// *******************************
// Revisions:
// 0.0 Initial rev
//
// *******************************

module efx_single_port_ram #(
	//Trion and Titanium parameters 
	parameter CLK_POLARITY  = 1'b1, 		//clk polarity,  0:falling edge, 1:rising edge
	
	parameter WCLKE_POLARITY = 1'b1, 		//wclke polarity, 0:active low, 1:active high
	parameter WE_POLARITY	 = 1'b1, 		//we polarity,    0:active low, 1:active high
	parameter WRITE_MODE  	 = "READ_UNKNOWN",//write mode,  	  "READ_FIRST" 	:Old memory content is read. (default)
											//			  	  "WRITE_FIRST" :Write data is passed to the read port.
											//				  "READ_UNKNOWN": Read and writes are unsynchronized, therefore, the results of the address can conflict.
	parameter RE_POLARITY    = 1'b1, 		// re polarity,	  0:active low  , 1:active high
	parameter OUTPUT_REG     = 1'b0, 		// Output register enable, 1:add pipe-line read register

	parameter BYTEEN_POLARITY = 1'b1,		//byteen polarity,    0:active low, 1:active high   

	//Port Enable  
	parameter WCLKE_ENABLE 		= 1'b1, 	//1: Enable  the port for waddren pin  , 0: disable 
	
	parameter WE_ENABLE 		= 1'b1,		//1: Enable  the port for WE pin , 0: disable 
	parameter RE_ENABLE 		= 1'b1,		//1: Enable  the port for RE pin , 0: disable 
	parameter BYTEEN_ENABLE 	= 1'b1,		//1: Enable  the port for Byteen pins , 0: disable 

	//Titanium extra paramters 
	parameter RST_POLARITY 	    = 1'b1,    	// rst polarity
	parameter RESET_RAM 	    = "ASYNC", 	// reset mode on ram,  "NONE": RST signals does not affect the RAM output.
											//					  "ASYNC": RAM output resets asynchronously to RCLK.
											//                     "SYNC": RAM output resets synchronously to RCLK. 
	parameter RESET_OUTREG 	    = "ASYNC", 	// reset mode on output register
											//					   "NONE": RST signals does not affect the RAM output register		
											//					  "ASYNC": RAM output register resets asynchronously to RCLK.
	parameter ADDREN_POLARITY  = 1'b1,    	// addren polarity


	//Port Enable  
	parameter RESET_ENABLE 		= 1'b1,		//1: Enable  the port for reset pin  , 0: disable 
		
	parameter ADDREN_ENABLE 	= 1'b1		//1: Enable  the port for addren pin  , 0: disable 

)   
(
	//Trion and Titanium ports
	clk,		// clock input for one clock mode
	addr, 		// address input

	wclke,		// Write clock-enable input
    byteen,		// Byteen input 
    we, 		// Write-enable input
    wdata,		// Write data input
  
    re, 		// Read-enable input
    rdata, 		// Read data output     
     
	//Titanium extra ports
	reset,		 // reset	
	addren,	     // address enable
 );

`include "bram_decompose.vh"

//Trion and Titanium ports
input clk;
input [ADDR_WIDTH_A-1:0] addr;

input wclke;
input [BYTEEN_WIDTH-1:0] byteen;
input we;
input [DATA_WIDTH_A-1:0] wdata;

input re; 
output [DATA_WIDTH_B-1:0] rdata;

//Titanium extra ports
input reset;	
input addren;

wire w_wclk;
wire w_rclk;
wire w_wclke;
wire [BYTEEN_WIDTH-1:0] w_byteen;
wire w_we;
wire w_re;
wire w_reset;
wire w_addren;

assign w_wclke = (WCLKE_ENABLE==1) ? wclke : WCLKE_POLARITY;
assign w_byteen= (BYTEEN_ENABLE==1) 	? byteen : {BYTEEN_WIDTH{BYTEEN_POLARITY}};
assign w_we   = (WE_ENABLE==1)  ? we : WE_POLARITY;
assign w_re   = (RE_ENABLE==1)  ? re : RE_POLARITY;

//Titanium extra ports
assign w_reset   = (RESET_ENABLE==1)  ? reset   : (RST_POLARITY==1'b1) ? 1'b0: 1'b1;
assign w_addren = (ADDREN_ENABLE==1)? addren : ADDREN_POLARITY;

 	bram_wrapper_mwm #(
		//.FAMILY(FAMILY),
		//Trion and Titanium parameters 
		.WCLK_POLARITY(CLK_POLARITY), 	
		.WCLKE_POLARITY(WCLKE_POLARITY),
		.WE_POLARITY(WE_POLARITY), 		
		.WRITE_MODE(WRITE_MODE),		
				
		.RCLK_POLARITY(CLK_POLARITY), 	
		.RE_POLARITY(RE_POLARITY), 		
		.OUTPUT_REG(OUTPUT_REG),		
		
		.BYTEEN_POLARITY(BYTEEN_POLARITY),
		
		//Titanium extra paramters 
		.RST_POLARITY(RST_POLARITY),   	
		.RESET_RAM(RESET_RAM), 			
		.RESET_OUTREG(RESET_OUTREG), 	
		.WADDREN_POLARITY(ADDREN_POLARITY),
		.RADDREN_POLARITY(ADDREN_POLARITY) 
		
	) brams (
		.wclk(clk), 
		.wclke(w_wclke),
		.we(w_we), 
		.byteen(w_byteen),
        
        .waddr(addr), 
		.wdata(wdata),
          
		.rclk(clk), 
		.re(w_re), 
		.raddr(addr), 
		.rdata(rdata),
		      
        
		//Titanium extra ports
		.reset(w_reset), 	// reset	
		.waddren(w_addren), // write address enable
		.raddren(w_addren)  // read address enable	
	);
 
 
endmodule