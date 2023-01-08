////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2022 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   tb_top.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /    
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// *******************************
// Revisions:
// 0.0 Initial rev
// Modified on 23 September  2022
// *******************************

module dpram_wrapper_mwm #(
	//parameter FAMILY = 0,	//0:Trion,  1:Titanium
	//Trion and Titanium parameters 
	parameter CLKA_POLARITY  = 1'b1, 		//clk A polarity,  0:falling edge, 1:rising edge
	parameter CLKEA_POLARITY = 1'b1, 		//clke A polarity, 0:active low, 1:active high
	parameter WEA_POLARITY	 = 1'b1, 		//we A polarity,    0:active low, 1:active high
	parameter WRITE_MODE_A 	 = "READ_FIRST",//write mode A,  "READ_FIRST" 	:Old memory content is read. (default)
											//			  	  "WRITE_FIRST" :Write data is passed to the read port.
											//				  "READ_UNKNOWN": Read and writes are unsynchronized, therefore, the results of the address can conflict.
	parameter OUTPUT_REG_A   = 1'b0, 		// Output register enable, 1:add pipe-line read register
	parameter BYTEENA_POLARITY   = 1'b1,     // byteen polarity		0:active low, 1:active high 
	
	parameter CLKB_POLARITY  = 1'b1, 		//clk A polarity,  0:falling edge, 1:rising edge
	parameter CLKEB_POLARITY = 1'b1, 		//clke A polarity, 0:active low, 1:active high
	parameter WEB_POLARITY	 = 1'b1, 		//we B polarity,    0:active low, 1:active high
	parameter WRITE_MODE_B 	 = "READ_FIRST",//write mode A,  "READ_FIRST" 	:Old memory content is read. (default)
											//			  	  "WRITE_FIRST" :Write data is passed to the read port.
											//				  "READ_UNKNOWN": Read and writes are unsynchronized, therefore, the results of the address can conflict.
	parameter OUTPUT_REG_B   = 1'b0, 		// Output register enable, 1:add pipe-line read register
	parameter BYTEENB_POLARITY   = 1'b1,     // byteen polarity		0:active low, 1:active high 
	
	//Titanium extra paramters 
	parameter RSTA_POLARITY 	= 1'b1,    	// rst A polarity
	parameter RESET_RAM_A 	    = "ASYNC", 	// reset A mode on ram,  "NONE": RST signals does not affect the RAM output.
											//					  "ASYNC": RAM output resets asynchronously to RCLK.
											//                     "SYNC": RAM output resets synchronously to RCLK. 
	parameter RESET_OUTREG_A 	= "ASYNC", 	// reset A mode on output register
											//					   "NONE": RST signals does not affect the RAM output register		
											//					  "ASYNC": RAM output register resets asynchronously to RCLK.
	parameter ADDRENA_POLARITY  = 1'b1,    	// addrena polarity
	
	parameter RSTB_POLARITY 	= 1'b1,    	// rst A polarity
	parameter RESET_RAM_B 	    = "ASYNC", 	// reset A mode on ram,  "NONE": RST signals does not affect the RAM output.
											//					  "ASYNC": RAM output resets asynchronously to RCLK.
											//                     "SYNC": RAM output resets synchronously to RCLK. 
	parameter RESET_OUTREG_B 	= "ASYNC", 	// reset A mode on output register
											//					   "NONE": RST signals does not affect the RAM output register		
											//					  "ASYNC": RAM output register resets asynchronously to RCLK.
	parameter ADDRENB_POLARITY  = 1'b1   	// addrenb polarity

	//Titanium Option for byte enable in WEN width = 2 when it is Mode 512x16 or  512x20
)   
(
	//Trion and Titanium ports
	clk_a, 		// A-port clk
	clke_a,		// A-port clk enable
    byteen_a,	// A-port Byteen input 
    we_a, 		// A-port write enable 
	addr_a, 	// A-port address input
    wdata_a,	// A-port write data input
	rdata_a, 	// A-port read address output
  
	clk_b, 		// B-port clk
	clke_b,		// B-port clk enable
    byteen_b,	// B-port Byteen input 
    we_b, 		// B-port write enable 
	addr_b, 	// B-port address input
    wdata_b,	// B-port write data input
	rdata_b, 	// B-port read address output
	     
	//Titanium extra ports
	reset_a,	// A-port reset 
	addren_a,	// A-port address enable
	
	reset_b,	// B-port reset 
	addren_b	// B-port address enable
	
 );

`include "bram_decompose.vh"
//`include "bram_feature.vh"

input clk_a; 
input clke_a;
input we_a;
input [BYTEEN_WIDTH_A-1:0] byteen_a;
input [ADDR_WIDTH_A-1:0 ] addr_a; 
input [DATA_WIDTH_A-1:0 ] wdata_a;
output [DATA_WIDTH_A-1:0 ]rdata_a;

input clk_b; 
input clke_b;
input we_b;
input [BYTEEN_WIDTH_B-1:0] byteen_b;
input [ADDR_WIDTH_B-1:0 ] addr_b; 
input [DATA_WIDTH_B-1:0 ] wdata_b;
output [DATA_WIDTH_B-1:0 ]rdata_b;

input reset_a;
input addren_a;

input reset_b;
input addren_b;


localparam MAP_ADDR_WIDTH_A = (address_mapping_table_A_size!=0)?address_mapping_table_A_size:ADDR_WIDTH_A;
localparam MAP_ADDR_WIDTH_B = (address_mapping_table_B_size!=0)?address_mapping_table_B_size:ADDR_WIDTH_B;



wire [MAP_ADDR_WIDTH_A-1:0 ] w_addr_map_a; 
wire [DATA_WIDTH_A-1:0 ] w_wdata_map_a;
wire [DATA_WIDTH_A-1:0 ] w_rdata_map_a;

wire [MAP_ADDR_WIDTH_B-1:0 ] w_addr_map_b; 
wire [DATA_WIDTH_B-1:0 ] w_wdata_map_b;
wire [DATA_WIDTH_B-1:0 ] w_rdata_map_b;


function integer get_current_row_index;
input integer row;//Mode type 
integer x;	
	begin
		get_current_row_index = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if (bram_mapping_table(x,0) < row)
				get_current_row_index = get_current_row_index +1;
		end
	end 
endfunction 

function integer get_current_column_index;
input integer column;//Mode type 
integer x;	
	begin
		get_current_column_index = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if (bram_mapping_table(x,1) < column)
				get_current_column_index = get_current_column_index +1;
		end
	end 
endfunction 


function integer get_max_mux_row_A;
input integer temp;//Mode type
integer x;	
	begin
		get_max_mux_row_A = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_mux_row_A < bram_mapping_table(x,5) )
				get_max_mux_row_A =  bram_mapping_table(x,5);
		end
	end 
endfunction 

function integer get_max_wen_decode_A;
input integer temp;//Mode type
integer x;	
	begin
		get_max_wen_decode_A = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_wen_decode_A < bram_mapping_table(x,6) )
				get_max_wen_decode_A =  bram_mapping_table(x,6);
		end
	end 
endfunction 


function integer get_max_mux_row_B;
input integer temp;//Mode type
integer x;	
	begin
		get_max_mux_row_B = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_mux_row_B < bram_mapping_table(x,12) )
				get_max_mux_row_B =  bram_mapping_table(x,12);
		end
	end 
endfunction 

function integer get_max_wen_decode_B;
input integer temp;//Mode type
integer x;	
	begin
		get_max_wen_decode_B = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_wen_decode_B < bram_mapping_table(x,13) )
				get_max_wen_decode_B =  bram_mapping_table(x,13);
		end
	end 
endfunction 



 //   localparam column_size = (bram_table_loop_mode==1)?bram_table_size:1;
   // wire [DATA_WIDTH_B-1:0] w_rdata [bram_table_size-1:0 ];
   // assign rdata = w_rdata[wdata];
    genvar gen_x;
    genvar gen_y;
	genvar gen_z;
	
    generate
			
		wire [DATA_WIDTH_A-1:0 ] rMux_a [get_max_mux_row_A(0):0]; 
		if (rMux_mapping_A_size == 0) 
        begin
            assign w_rdata_map_a = rMux_a[0]; 
        end 
        else 
        begin
            for (gen_y=0; gen_y<rMux_mapping_A_size; gen_y =gen_y +1)
            begin:rDataMux_a
                localparam ADDR_START = rMux_mapping_table_A(gen_y,1);
                localparam ADDR_END   = rMux_mapping_table_A(gen_y,0);
                
                localparam DATA_START = rMux_mapping_table_A(gen_y,3);
                localparam DATA_END   = rMux_mapping_table_A(gen_y,2);
				
				localparam BYPRASSED  = rMux_mapping_table_A(gen_y,6);
								
                if( BYPRASSED == 0 )
				begin 
				
					wire [ADDR_END:ADDR_START] rdSel;
					reg [ADDR_END:ADDR_START] r_rdSel_1P;
					
					assign rdSel = w_addr_map_a[ADDR_END:ADDR_START];
					
					always @ (posedge clk_a)
					begin
						r_rdSel_1P <= rdSel;
					end
					
					if (OUTPUT_REG_A == 0)
                    begin
					
						assign w_rdata_map_a[DATA_END:DATA_START] = rMux_a[r_rdSel_1P][DATA_END:DATA_START];
					end 
					begin
                        reg [ADDR_END:ADDR_START] r_rdSel_2P;
                        always @ (posedge clk_a)
                        begin
                            r_rdSel_2P <= r_rdSel_1P;
                        end
                            assign w_rdata_map_a[DATA_END:DATA_START] = rMux_a[r_rdSel_2P][DATA_END:DATA_START];
                    end 
                
				end 
				else 
				begin 
					assign w_rdata_map_a[DATA_END:DATA_START] = rMux_a[0][DATA_END:DATA_START];
					
				end 
				
            end
        end

		wire [DATA_WIDTH_B-1:0 ] rMux_b [get_max_mux_row_B(0):0]; 
		if (rMux_mapping_B_size == 0) 
        begin
            assign w_rdata_map_b = rMux_b[0]; 
        end 
        else 
        begin
            for (gen_y=0; gen_y<rMux_mapping_B_size; gen_y =gen_y +1)
            begin:rDataMux_b
                localparam ADDR_START = rMux_mapping_table_B(gen_y,1);
                localparam ADDR_END   = rMux_mapping_table_B(gen_y,0);
                
                localparam DATA_START = rMux_mapping_table_B(gen_y,3);
                localparam DATA_END   = rMux_mapping_table_B(gen_y,2);
				
				localparam BYPRASSED  = rMux_mapping_table_B(gen_y,6);
                
				if( BYPRASSED == 0 )
				begin 
				
					wire [ADDR_END:ADDR_START] rdSel;
					reg [ADDR_END:ADDR_START] r_rdSel_1P;
					
					assign rdSel = w_addr_map_b[ADDR_END:ADDR_START];
					
					always @ (posedge clk_b)
					begin
						r_rdSel_1P <= rdSel;
					end
					
					if (OUTPUT_REG_B == 0)
                    begin
						assign w_rdata_map_b[DATA_END:DATA_START] = rMux_b[r_rdSel_1P][DATA_END:DATA_START];
					end 
					begin
                        reg [ADDR_END:ADDR_START] r_rdSel_2P;
                        always @ (posedge clk_b)
                        begin
                            r_rdSel_2P <= r_rdSel_1P;
                        end
                            assign w_rdata_map_b[DATA_END:DATA_START] = rMux_b[r_rdSel_2P][DATA_END:DATA_START];
                    end 
					
					
                end 
				else 
				begin 
					assign w_rdata_map_b[DATA_END:DATA_START] = rMux_b[0][DATA_END:DATA_START];
				
				end 
            end
        end
		
        
		wire [get_max_wen_decode_A(0):0] wen_decode_a ;
        if (wen_sel_mapping_A_size!=0)
        begin  
			for (gen_y=0; gen_y<wen_sel_mapping_A_size; gen_y =gen_y +1)
			begin:wDataEn
				localparam ADDR_START = wen_sel_mapping_table_A(gen_y,1);
				localparam ADDR_END   = wen_sel_mapping_table_A(gen_y,0);
				
				localparam SEL_START = wen_sel_mapping_table_A(gen_y,3);
				localparam SEL_END   = wen_sel_mapping_table_A(gen_y,2);
				
				localparam BYPRASSED  = wen_sel_mapping_table_A(gen_y,4);
				
				if( BYPRASSED == 0 )
				begin 
					wire [ADDR_END:ADDR_START] wrSel;
					assign wrSel = w_addr_map_a[ADDR_END:ADDR_START];
					
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode_a[gen_x] = (wrSel==(gen_x-SEL_START))?1'b1:1'b0;
					end 
				end 
				else 
				begin
										
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode_a[gen_x] = 1'b1;
					end 
				
				end 
				
			end
		end 
		else 
		begin 
			assign wen_decode_a = {(get_max_wen_decode_A(0)+1){1'b1}};
		end 
		
        
        wire [get_max_wen_decode_B(0):0] wen_decode_b ;
        if (wen_sel_mapping_B_size!=0)
        begin  
			for (gen_y=0; gen_y<wen_sel_mapping_B_size; gen_y =gen_y +1)
			begin:wDataEn
				localparam ADDR_START = wen_sel_mapping_table_B(gen_y,1);
				localparam ADDR_END   = wen_sel_mapping_table_B(gen_y,0);
				
				localparam SEL_START = wen_sel_mapping_table_B(gen_y,3);
				localparam SEL_END   = wen_sel_mapping_table_B(gen_y,2);
				
				localparam BYPRASSED  = wen_sel_mapping_table_B(gen_y,4);
				
				if( BYPRASSED == 0 )
				begin 
					wire [ADDR_END:ADDR_START] wrSel;
					assign wrSel = w_addr_map_b[ADDR_END:ADDR_START];
					
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode_b[gen_x] = (wrSel==(gen_x-SEL_START))?1'b1:1'b0;
					end
				end 
				else 
				begin
					
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode_b[gen_x] = 1'b1;
					end 
				end 
					
			end
		end 
		else 
		begin 
			assign wen_decode_b = {(get_max_wen_decode_B(0)+1){1'b1}};
		end 
		
		//For Mixed Width Mode 
		if (data_mapping_table_A_size!=0)
        begin  
			for (gen_y=0; gen_y<data_mapping_table_A_size; gen_y = gen_y +1)
			begin
				assign w_wdata_map_a[data_mapping_table_A(gen_y)] =  wdata_a[gen_y] ;
				assign rdata_a[gen_y]  = w_rdata_map_a[data_mapping_table_B(gen_y)] ;
			end
		end 
		else 
		begin 
			assign w_wdata_map_a = wdata_a;
			assign rdata_a = w_rdata_map_a;
		end 
	
		if (address_mapping_table_A_size!=0)
        begin  
			for (gen_y=0; gen_y<address_mapping_table_A_size; gen_y = gen_y +1)
			begin
				if (gen_y < ADDR_WIDTH_A)
					assign w_addr_map_a[address_mapping_table_A(gen_y)] =  addr_a[gen_y] ;
				else 
					assign w_addr_map_a[address_mapping_table_A(gen_y)] = 1'b0;
			end
		end 
		else 
		begin 
			assign w_addr_map_a = addr_a;
		end 
	
	
		if (data_mapping_table_B_size!=0)
        begin  
			for (gen_y=0; gen_y<data_mapping_table_B_size; gen_y = gen_y +1)
			begin
				assign w_wdata_map_b[data_mapping_table_A(gen_y)] =  wdata_b[gen_y] ;
				assign rdata_b[gen_y]  = w_rdata_map_b[data_mapping_table_B(gen_y)] ;
			end
		end 
		else 
		begin 
			assign w_wdata_map_b = wdata_b;
			assign rdata_b = w_rdata_map_b;
		end 
	
		if (address_mapping_table_B_size!=0)
        begin  
			for (gen_y=0; gen_y<address_mapping_table_B_size; gen_y = gen_y +1)
			begin
				if(gen_y<ADDR_WIDTH_B)
					assign w_addr_map_b[address_mapping_table_B(gen_y)] =  addr_b[gen_y] ;
				else 
					assign w_addr_map_b[address_mapping_table_B(gen_y)] = 1'b0;
			end 
		end 
		else 
		begin 
			assign w_addr_map_b = addr_b;
		end 
			
			
		if (bram_table_loop_mode == 0 ) 
		begin:scan_column
			for (gen_x=0; gen_x<bram_table_size; gen_x =gen_x +1)
			begin:column
				localparam bram_mode_a = bram_decompose_table(gen_x,0); 
				localparam bram_mode_b = bram_decompose_table(gen_x,1); 
				localparam row_count = bram_decompose_table(gen_x,2);
			
				localparam ADDR_WIDTH_ROW_A  = bram_feature_table(bram_mode_a,0);
				localparam DATA_WIDTH_ROW_A  = bram_feature_table(bram_mode_a,1); 
				localparam WEN_WIDTH_ROW_A   = bram_feature_table(bram_mode_a,2); 
	
				localparam ADDR_WIDTH_ROW_B  = bram_feature_table(bram_mode_b,0);
				localparam DATA_WIDTH_ROW_B  = bram_feature_table(bram_mode_b,1); 
				localparam WEN_WIDTH_ROW_B   = bram_feature_table(bram_mode_b,2); 	
				
				localparam START_COLUMN_INDEX = get_current_column_index(gen_x);
				
										
				for (gen_y=0; gen_y<row_count; gen_y =gen_y +1)
				begin:row
					
					localparam DATA_MAP_INDEX = START_COLUMN_INDEX+gen_y;

					localparam DATA_END_A     = bram_mapping_table(DATA_MAP_INDEX,2);					
					localparam DATA_START_A   = bram_mapping_table(DATA_MAP_INDEX,3);
					localparam DATA_REPART_A   = bram_mapping_table(DATA_MAP_INDEX,4);
					localparam WRSEL_INDEX_A   = bram_mapping_table(DATA_MAP_INDEX,6);
					localparam BYTEEN_INDEX_A  = bram_mapping_table(DATA_MAP_INDEX,8);
					localparam RMUX_INDEX_A    = bram_mapping_table(DATA_MAP_INDEX,5);
				
				
					localparam DATA_END_B     = bram_mapping_table(DATA_MAP_INDEX,9);					
					localparam DATA_START_B   = bram_mapping_table(DATA_MAP_INDEX,10);
					localparam DATA_REPART_B   = bram_mapping_table(DATA_MAP_INDEX,11);
					localparam WRSEL_INDEX_B   = bram_mapping_table(DATA_MAP_INDEX,13);
					localparam BYTEEN_INDEX_B  = bram_mapping_table(DATA_MAP_INDEX,15);	
					localparam RMUX_INDEX_B    = bram_mapping_table(DATA_MAP_INDEX,12);
						
					wire [ADDR_WIDTH_ROW_A-1:0] w_addr_a;
					wire [DATA_WIDTH_ROW_A-1:0] w_wdata_a;
					wire [DATA_WIDTH_ROW_A-1:0] w_rdata_a;
					wire [WEN_WIDTH_ROW_A-1:0]   w_we_a;

					wire [ADDR_WIDTH_ROW_B-1:0] w_addr_b;
					wire [DATA_WIDTH_ROW_B-1:0] w_wdata_b;
					wire [DATA_WIDTH_ROW_B-1:0] w_rdata_b;
					wire [WEN_WIDTH_ROW_B-1:0]   w_we_b;
					
					//assign w_addr_a[ADDR_WIDTH_ROW_A-1:0] = w_addr_map_a[ADDR_WIDTH_ROW_A-1:0];
					//assign w_addr_b[ADDR_WIDTH_ROW_B-1:0]  = w_addr_map_b[ADDR_WIDTH_ROW_B-1:0];	
					
					
					for(gen_z=0;gen_z<ADDR_WIDTH_ROW_A; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_A) 
							assign w_addr_a[gen_z] = w_addr_map_a[gen_z];
						else
							assign w_addr_a[gen_z] = 1'b0;
					end
					
					for(gen_z=0;gen_z<ADDR_WIDTH_ROW_B; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_B) 
							assign w_addr_b[gen_z] = w_addr_map_b[gen_z];
						else
							assign w_addr_b[gen_z] = 1'b0;			
					
					end
					
					
					if (DATA_REPART_A == 0)
					begin
						assign w_wdata_a[DATA_WIDTH_ROW_A-1:0] = w_wdata_map_a[DATA_END_A:DATA_START_A];
						assign rMux_a[RMUX_INDEX_A][DATA_END_A:DATA_START_A]   = w_rdata_a[DATA_WIDTH_ROW_A-1:0]; 
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<DATA_REPART_A; gen_z = gen_z+1)
						begin
							localparam MIXED_DATA_START =  DATA_START_A + gen_z*row_count* (DATA_END_B-DATA_START_B+1); //DATA_WIDTH_ROW_B;
							localparam MIXED_DATA_END   =  DATA_END_A   + gen_z*row_count* (DATA_END_B-DATA_START_B+1); //DATA_WIDTH_ROW_B; 
							
							localparam MAPPED_DATA_START =  DATA_WIDTH_ROW_B* gen_z;
							localparam MAPPED_DATA_END   =  DATA_WIDTH_ROW_B*(gen_z+1) -1; 
							
							assign w_wdata_a[MAPPED_DATA_END: MAPPED_DATA_START]  =  w_wdata_map_a[MIXED_DATA_END:MIXED_DATA_START];
							assign rMux_a[RMUX_INDEX_A][MIXED_DATA_END:MIXED_DATA_START]   = w_rdata_a[MAPPED_DATA_END:MAPPED_DATA_START]; 
						end
					end 
	
					if (DATA_REPART_B == 0)
					begin
						assign w_wdata_b[DATA_WIDTH_ROW_B-1:0] = w_wdata_map_b[DATA_END_B:DATA_START_B];
						assign rMux_b[RMUX_INDEX_B][DATA_END_B:DATA_START_B]   = w_rdata_b[DATA_WIDTH_ROW_B-1:0]; 
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<DATA_REPART_B; gen_z = gen_z+1)
						begin
							localparam MIXED_DATA_START =  DATA_START_B + gen_z*row_count*(DATA_END_A-DATA_START_A+1);//DATA_WIDTH_ROW_A;
							localparam MIXED_DATA_END   =  DATA_END_B   + gen_z*row_count*(DATA_END_A-DATA_START_A+1);//DATA_WIDTH_ROW_A; 
							
							localparam MAPPED_DATA_START =  DATA_WIDTH_ROW_A* gen_z;
							localparam MAPPED_DATA_END   =  DATA_WIDTH_ROW_A*(gen_z+1) -1; 
							
							assign w_wdata_b[MAPPED_DATA_END: MAPPED_DATA_START]  =  w_wdata_map_b[MIXED_DATA_END:MIXED_DATA_START];
							assign rMux_b[RMUX_INDEX_B][MIXED_DATA_END:MIXED_DATA_START]   = w_rdata_b[MAPPED_DATA_END:MAPPED_DATA_START]; 
						end
					end 	
							
					assign w_we_a[0] = ( (we_a == WEA_POLARITY) & wen_decode_a[WRSEL_INDEX_A] & (byteen_a[BYTEEN_INDEX_A] == BYTEENA_POLARITY) ) ? WEA_POLARITY: !WEA_POLARITY;
					if ( WEN_WIDTH_ROW_A >1)
					begin
						assign w_we_a[1] = ( (we_a == WEA_POLARITY) & wen_decode_a[WRSEL_INDEX_A] & (byteen_a[BYTEEN_INDEX_A] == BYTEENA_POLARITY) ) ? WEA_POLARITY: !WEA_POLARITY;
					end 	

					assign w_we_b[0] = ( (we_b == WEB_POLARITY) & wen_decode_b[WRSEL_INDEX_B] & (byteen_b[BYTEEN_INDEX_B] == BYTEENB_POLARITY) ) ? WEB_POLARITY: !WEB_POLARITY;
					if ( WEN_WIDTH_ROW_B >1)
					begin
						assign w_we_b[1] =((we_b == WEB_POLARITY) & wen_decode_b[WRSEL_INDEX_B] & (byteen_b[BYTEEN_INDEX_B] == BYTEENB_POLARITY) )? WEB_POLARITY: !WEB_POLARITY ;
					end 	

					dpbram_primitive #(
						.FAMILY(FAMILY),	//0:Trion,  1:Titanium
	
						//Trion and Titanium parameters 
						.WRITE_WIDTH_A(DATA_WIDTH_ROW_A),
						.READ_WIDTH_A(DATA_WIDTH_ROW_A),
						
						.CLKA_POLARITY(CLKA_POLARITY),  
						.CLKEA_POLARITY(CLKEA_POLARITY), 
						.WEA_POLARITY(WEA_POLARITY),	
						.WRITE_MODE_A(WRITE_MODE_A), 	
						.OUTPUT_REG_A(OUTPUT_REG_A),   
						
						.WRITE_WIDTH_B(DATA_WIDTH_ROW_B),	
						.READ_WIDTH_B(DATA_WIDTH_ROW_B),	
						
						.CLKB_POLARITY(CLKB_POLARITY),  
						.CLKEB_POLARITY(CLKEB_POLARITY), 
						.WEB_POLARITY(WEB_POLARITY),	
						.WRITE_MODE_B(WRITE_MODE_B), 	
						.OUTPUT_REG_B(OUTPUT_REG_B),   

						.ini_index(DATA_MAP_INDEX),
						
						//Titanium extra paramters 
						.RSTA_POLARITY(RSTA_POLARITY), 	
						.RESET_RAM_A(RESET_RAM_A), 	
						.RESET_OUTREG_A(RESET_OUTREG_A), 	
						.ADDRENA_POLARITY(ADDRENA_POLARITY),
						
						.RSTB_POLARITY(RSTB_POLARITY), 	
						.RESET_RAM_B(RESET_RAM_B), 	 	
						.RESET_OUTREG_B(RESET_OUTREG_B), 	
						.ADDRENB_POLARITY(ADDRENB_POLARITY)   											
				
						
					) bram (
					//Trion and Titanium ports
						.CLKA  (clk_a), 		// A-port clk 
						.CLKEA (clke_a), 		// A-port clk enable 
						.WEA   (w_we_a), 		// A-port write enable 
						.ADDRA (w_addr_a), 		// A-port address input
						.WDATAA(w_wdata_a), 	// A-port write data input
						.RDATAA(w_rdata_a), 	// A-port read address output
						
						.CLKB  (clk_b), 		// B-port clk 
						.CLKEB (clke_b), 		// B-port clk enable 
						.WEB   (w_we_b), 		// B-port write enable 
						.ADDRB (w_addr_b), 		// B-port address input
						.WDATAB(w_wdata_b), 	// B-port write data input
						.RDATAB(w_rdata_b), 	// B-port read address output
					
					//Titanium extra ports
						
						.RSTA	(reset_a), // A-port reset 
						.ADDRENA(addren_a), // A-port address enable
						
						.RSTB(reset_b), // B-port reset 
						.ADDRENB(addren_b) // B-port address enable							
					);					
				end
			end
			
		end
		else if (bram_table_loop_mode == 1 ) 
		begin:scan_row
			for (gen_y=0; gen_y<bram_table_size; gen_y =gen_y +1)
			begin:row
				
				localparam bram_mode_a = bram_decompose_table(gen_y,0); 
				localparam bram_mode_b = bram_decompose_table(gen_y,1); 
				localparam column_count = bram_decompose_table(gen_y,2);
			
				localparam ADDR_WIDTH_ROW_A  = bram_feature_table(bram_mode_a,0);
				localparam DATA_WIDTH_ROW_A  = bram_feature_table(bram_mode_a,1); 
				localparam WEN_WIDTH_ROW_A   = bram_feature_table(bram_mode_a,2); 
				localparam ADDR_WIDTH_ROW_MAP_A = (ADDR_WIDTH_ROW_A > ADDR_WIDTH_A )? ADDR_WIDTH_A:ADDR_WIDTH_ROW_A;
				
	
				localparam ADDR_WIDTH_ROW_B  = bram_feature_table(bram_mode_b,0);
				localparam DATA_WIDTH_ROW_B  = bram_feature_table(bram_mode_b,1); 
				localparam WEN_WIDTH_ROW_B   = bram_feature_table(bram_mode_b,2); 	
				localparam ADDR_WIDTH_ROW_MAP_B = (ADDR_WIDTH_ROW_B > ADDR_WIDTH_B )? ADDR_WIDTH_B:ADDR_WIDTH_ROW_B;


				
				localparam START_ROW_INDEX = get_current_row_index(gen_y);								

                
         								
				for (gen_x=0; gen_x<column_count; gen_x =gen_x +1)
				begin:column
					localparam DATA_MAP_INDEX = START_ROW_INDEX+gen_x;

					localparam DATA_END_A     = bram_mapping_table(DATA_MAP_INDEX,2);					
					localparam DATA_START_A   = bram_mapping_table(DATA_MAP_INDEX,3);
					localparam DATA_REPART_A   = bram_mapping_table(DATA_MAP_INDEX,4);
					localparam WRSEL_INDEX_A   = bram_mapping_table(DATA_MAP_INDEX,6);
					localparam BYTEEN_INDEX_A  = bram_mapping_table(DATA_MAP_INDEX,8);
					localparam RMUX_INDEX_A    = bram_mapping_table(DATA_MAP_INDEX,5);
				
				
					localparam DATA_END_B     = bram_mapping_table(DATA_MAP_INDEX,9);					
					localparam DATA_START_B   = bram_mapping_table(DATA_MAP_INDEX,10);
					localparam DATA_REPART_B   = bram_mapping_table(DATA_MAP_INDEX,11);
					localparam WRSEL_INDEX_B   = bram_mapping_table(DATA_MAP_INDEX,13);
					localparam BYTEEN_INDEX_B  = bram_mapping_table(DATA_MAP_INDEX,15);	
					localparam RMUX_INDEX_B    = bram_mapping_table(DATA_MAP_INDEX,12);
						
					wire [ADDR_WIDTH_ROW_A-1:0] w_addr_a;
					wire [DATA_WIDTH_ROW_A-1:0] w_wdata_a;
					wire [DATA_WIDTH_ROW_A-1:0] w_rdata_a;
					wire [WEN_WIDTH_ROW_A-1:0]   w_we_a;

					wire [ADDR_WIDTH_ROW_B-1:0] w_addr_b;
					wire [DATA_WIDTH_ROW_B-1:0] w_wdata_b;
					wire [DATA_WIDTH_ROW_B-1:0] w_rdata_b;
					wire [WEN_WIDTH_ROW_B-1:0]   w_we_b;
					
					//assign w_addr_a[ADDR_WIDTH_ROW_A-1:0] = w_addr_map_a[ADDR_WIDTH_ROW_A-1:0];
					//assign w_addr_b[ADDR_WIDTH_ROW_B-1:0]  = w_addr_map_b[ADDR_WIDTH_ROW_B-1:0];	
					
					for(gen_z=0;gen_z<ADDR_WIDTH_ROW_A; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_A) 
							assign w_addr_a[gen_z] = w_addr_map_a[gen_z];
						else
							assign w_addr_a[gen_z] = 1'b0;
					end
					
					for(gen_z=0;gen_z<ADDR_WIDTH_ROW_B; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_B) 
							assign w_addr_b[gen_z] = w_addr_map_b[gen_z];
						else
							assign w_addr_b[gen_z] = 1'b0;			
					
					end
					
					
					if (DATA_REPART_A == 0)
					begin
						assign w_wdata_a[DATA_WIDTH_ROW_A-1:0] = w_wdata_map_a[DATA_END_A:DATA_START_A];
						assign rMux_a[RMUX_INDEX_A][DATA_END_A:DATA_START_A]   = w_rdata_a[DATA_WIDTH_ROW_A-1:0]; 
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<DATA_REPART_A; gen_z = gen_z+1)
						begin
							localparam MIXED_DATA_START =  DATA_START_A + gen_z*column_count* (DATA_END_B-DATA_START_B+1);//DATA_WIDTH_ROW_B;
							localparam MIXED_DATA_END   =  DATA_END_A   + gen_z*column_count* (DATA_END_B-DATA_START_B+1);//DATA_WIDTH_ROW_B; 
							
							localparam MAPPED_DATA_START =  DATA_WIDTH_ROW_B* gen_z;
							localparam MAPPED_DATA_END   =  DATA_WIDTH_ROW_B*(gen_z+1) -1; 
							
							assign w_wdata_a[MAPPED_DATA_END: MAPPED_DATA_START]  =  w_wdata_map_a[MIXED_DATA_END:MIXED_DATA_START];
							assign rMux_a[RMUX_INDEX_A][MIXED_DATA_END:MIXED_DATA_START]   = w_rdata_a[MAPPED_DATA_END:MAPPED_DATA_START]; 
						end
					end 
	
					if (DATA_REPART_B == 0)
					begin
						assign w_wdata_b[DATA_WIDTH_ROW_B-1:0] = w_wdata_map_b[DATA_END_B:DATA_START_B];
						assign rMux_b[RMUX_INDEX_B][DATA_END_B:DATA_START_B]   = w_rdata_b[DATA_WIDTH_ROW_B-1:0]; 
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<DATA_REPART_B; gen_z = gen_z+1)
						begin
							localparam MIXED_DATA_START =  DATA_START_B + gen_z*column_count* (DATA_END_A-DATA_START_A+1);//DATA_WIDTH_ROW_A;
							localparam MIXED_DATA_END   =  DATA_END_B   + gen_z*column_count* (DATA_END_A-DATA_START_A+1);//DATA_WIDTH_ROW_A; 
							
							localparam MAPPED_DATA_START =  DATA_WIDTH_ROW_A* gen_z;
							localparam MAPPED_DATA_END   =  DATA_WIDTH_ROW_A*(gen_z+1) -1; 
							
							assign w_wdata_b[MAPPED_DATA_END: MAPPED_DATA_START]  =  w_wdata_map_b[MIXED_DATA_END:MIXED_DATA_START];
							assign rMux_b[RMUX_INDEX_B][MIXED_DATA_END:MIXED_DATA_START]   = w_rdata_b[MAPPED_DATA_END:MAPPED_DATA_START]; 
						end
					end 	
					
					assign w_we_a[0] = ((we_a == WEA_POLARITY) & wen_decode_a[WRSEL_INDEX_A] & (byteen_a[BYTEEN_INDEX_A] == BYTEENA_POLARITY) ) ? WEA_POLARITY: !WEA_POLARITY;
					if ( WEN_WIDTH_ROW_A >1)
					begin
						assign w_we_a[1] = ((we_a == WEA_POLARITY) & wen_decode_a[WRSEL_INDEX_A] & (byteen_a[BYTEEN_INDEX_A] == BYTEENA_POLARITY) ) ?  WEA_POLARITY: !WEA_POLARITY;
					end 	

					assign w_we_b[0] = ((we_b == WEB_POLARITY) & wen_decode_b[WRSEL_INDEX_B] & (byteen_b[BYTEEN_INDEX_B] == BYTEENB_POLARITY)) ?  WEB_POLARITY: !WEB_POLARITY;
					if ( WEN_WIDTH_ROW_B >1)
					begin
						assign w_we_b[1] = ((we_b == WEB_POLARITY) & wen_decode_b[WRSEL_INDEX_B] & (byteen_b[BYTEEN_INDEX_B] == BYTEENB_POLARITY)) ? WEB_POLARITY : !WEB_POLARITY;
					end 
									
					dpbram_primitive #(
						.FAMILY(FAMILY),	//0:Trion,  1:Titanium
	
						//Trion and Titanium parameters 
						.WRITE_WIDTH_A(DATA_WIDTH_ROW_A),
						.READ_WIDTH_A(DATA_WIDTH_ROW_A),
						
						.CLKA_POLARITY(CLKA_POLARITY),  
						.CLKEA_POLARITY(CLKEA_POLARITY), 
						.WEA_POLARITY(WEA_POLARITY),	
						.WRITE_MODE_A(WRITE_MODE_A), 	
						.OUTPUT_REG_A(OUTPUT_REG_A),   
						
						.WRITE_WIDTH_B(DATA_WIDTH_ROW_B),	
						.READ_WIDTH_B(DATA_WIDTH_ROW_B),	
						
						.CLKB_POLARITY(CLKB_POLARITY),  
						.CLKEB_POLARITY(CLKEB_POLARITY), 
						.WEB_POLARITY(WEB_POLARITY),	
						.WRITE_MODE_B(WRITE_MODE_B), 	
						.OUTPUT_REG_B(OUTPUT_REG_B),   

						.ini_index(DATA_MAP_INDEX),
						
						//Titanium extra paramters 
						.RSTA_POLARITY(RSTA_POLARITY), 	
						.RESET_RAM_A(RESET_RAM_A), 	
						.RESET_OUTREG_A(RESET_OUTREG_A), 	
						.ADDRENA_POLARITY(ADDRENA_POLARITY),
						
						.RSTB_POLARITY(RSTB_POLARITY), 	
						.RESET_RAM_B(RESET_RAM_B), 	 	
						.RESET_OUTREG_B(RESET_OUTREG_B), 	
						.ADDRENB_POLARITY(ADDRENB_POLARITY)   											
				
						
					) bram (
					//Trion and Titanium ports
						.CLKA  (clk_a), 		// A-port clk 
						.CLKEA (clke_a), 		// A-port clk enable 
						.WEA   (w_we_a), 		// A-port write enable 
						.ADDRA (w_addr_a), 		// A-port address input
						.WDATAA(w_wdata_a), 	// A-port write data input
						.RDATAA(w_rdata_a), 	// A-port read address output
						
						.CLKB  (clk_b), 		// B-port clk 
						.CLKEB (clke_b), 		// B-port clk enable 
						.WEB   (w_we_b), 		// B-port write enable 
						.ADDRB (w_addr_b), 		// B-port address input
						.WDATAB(w_wdata_b), 	// B-port write data input
						.RDATAB(w_rdata_b), 	// B-port read address output
					
					//Titanium extra ports
						
						.RSTA	(reset_a), // A-port reset 
						.ADDRENA(addren_a), // A-port address enable
						
						.RSTB(reset_b), // B-port reset 
						.ADDRENB(addren_b) // B-port address enable							
					);
					

					
				end
			end
 
		end 
    endgenerate 
 
 
endmodule