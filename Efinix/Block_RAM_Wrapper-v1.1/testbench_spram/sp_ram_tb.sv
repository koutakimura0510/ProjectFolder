module spram_tb;
localparam ADDR_WIDTH_A = 3;
localparam ADDR_WIDTH_B = 3;
localparam DEVICE_FAMILY = 1;
localparam DATA_WIDTH_A = 8;
localparam DATA_WIDTH_B = 8;
localparam ADDREN_ENABLE = 1;
localparam ADDREN_POLARITY = 1;
localparam CLK_POLARITY = 1;
localparam OUTPUT_REG = 0;
localparam RE_ENABLE = 1;
localparam RE_POLARITY = 1;
localparam RESET_ENABLE = 1;
localparam RST_POLARITY = 1;
localparam WCLKE_ENABLE = 1;
localparam WE_ENABLE = 1;
localparam WE_POLARITY = 1;
localparam WCLKE_POLARITY = 1;
localparam MODULE_MODE = 1;
localparam RESET_OUTREG = "ASYNC";
localparam RESET_RAM = "ASYNC";
localparam CLK_MODE = 2;
localparam RCLK_POLARITY = 1;
localparam WCLK_POLARITY = 1;
localparam WRITE_MODE = "READ_FIRST";
localparam MODULE_TYPE = 1;
localparam GROUP_DATA_WIDTH = 8;
localparam BYTEEN_ENABLE = 1;
localparam BYTEEN_POLARITY = 1;
localparam WIDTH_RATIO = 4;
localparam BYTEEN_WIDTH = 1;

localparam TOTAL_SIZE_A = 2**ADDR_WIDTH_A;
localparam TOTAL_SIZE_B = 2**ADDR_WIDTH_B;
localparam TEST_PATTERN = 1'b1;

reg                        clk;
reg                        wclke;
reg [ADDR_WIDTH_A-1:0]     addr;
reg [DATA_WIDTH_A-1:0]     wdata;                  
reg [BYTEEN_WIDTH-1:0]     byteen;
reg                        we;
reg                        re; 
reg                        reset;	
reg                        addren;

reg                        result;
reg                        start_in;
reg [2:0]                  err_count;
reg [ADDR_WIDTH_A:0]       r_wcount;
reg [ADDR_WIDTH_B:0]       r_rcount;
reg [DATA_WIDTH_A-1:0]     data_arr[0:TOTAL_SIZE_A-1];
reg [DATA_WIDTH_A-1:0]     exp_val[0:TOTAL_SIZE_A-1];
reg [DATA_WIDTH_B-1:0]     err_mask[0:TOTAL_SIZE_A-1];
reg [DATA_WIDTH_B-1:0]     tester;
reg [2:0]                  test_state;
integer                    i;

wire  [DATA_WIDTH_B-1:0]   rdata;
/////////////// Initialize clock and start/////////////////
initial begin
	clk      <= 0;
	wclke    <= 0;
	start_in <= 0;
	#150
	forever begin @ (negedge clk)
	start_in <= 1;
	wclke    <= 1;
	end
end
//////// Generate Clock and initialize Reset //////////////
always begin
	#50 clk <= ~clk;
end
initial begin
	reset   <= 1'b1;
	#150 
	forever begin @ (negedge clk)
	reset   <= 1'b0;
	end
end
///////// Initialize input ///////////////////
initial begin
	wdata             = 0;
	addr              = 0;
	addren            = 0;
	byteen            = 0;
	data_arr[r_wcount]= 0;
	exp_val[r_wcount] = 0;
	exp_val[i]        = 0;
	err_mask[i]       = 0;
	r_wcount          = 0;
	r_rcount          = 0;
	i                 = 0;
	we                = 0;
	re                = 0;
	result            = 0;
	err_count         = 0;
	tester            = 0; 
end	
////////////// State Machine for Test Pattern /////////////
localparam STATE_IDLE  		             = 3'd0;
localparam STATE_START 		             = 3'd1;
localparam STATE_WE_START	             = 3'd2;
localparam STATE_WE     	             = 3'd3;
localparam STATE_WE_END	                 = 3'd4;
localparam STATE_RE_START	             = 3'd5;
localparam STATE_RE     	             = 3'd6;
localparam STATE_RE_END		             = 3'd7;
localparam FIRST_ACCESS  = (TEST_PATTERN==0)?STATE_RE_START:(TEST_PATTERN==1)?STATE_WE_START:STATE_WE_START;//0=read first, 1=write first
////////// Generate random value in Array ////////////////
initial 
begin
   	for (i=0; i < TOTAL_SIZE_A; i = i+1)
   	begin
   		exp_val[i]  = $urandom;
   		err_mask[i] = $urandom;
   	end   	
end
/////////// Generate random err_count ///////////////////
always @ (re) begin
	err_count = $urandom_range(TOTAL_SIZE_A-1,0);
end
///////////////// Test Pattern /////////////////////
always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
	
		test_state <= STATE_IDLE;
		
		start_in          <= 0;
		exp_val[r_wcount] <= 0;
		re                <= 1'b0;
		r_wcount          <= {ADDR_WIDTH_A{1'b0}};
		r_rcount          <= {ADDR_WIDTH_A{1'b0}};
		tester            <= 0;
		err_count         <= 0;
		
		
	end 
	else 
	begin
		case (test_state)
			STATE_IDLE:
			begin 
				if (start_in)
				begin
					test_state <= STATE_START;
				end 
			end 
			STATE_START:
			begin
				test_state <= FIRST_ACCESS; //STATE_RE_START;//STATE_WE_START;
			end
			STATE_WE_START:
			begin 
				r_wcount   <= {ADDR_WIDTH_A{1'b0}};
				test_state <= STATE_WE;
			end 
			STATE_WE:
			begin
				addr  <= r_wcount;
			    wdata <= r_wcount;
				if (r_wcount == TOTAL_SIZE_A)
				begin
					test_state <= STATE_WE_END;
					we      <= 0;
					addr    <= 0;
					addren  <= 0;
					wdata   <= 0;
				end 
				else 
				begin
					wdata       <= (exp_val[r_wcount] ^ err_mask[r_wcount]);
					data_arr[r_wcount] <= (exp_val[r_wcount] ^ err_mask[r_wcount]);
					r_wcount    <= r_wcount+1'b1;  
					test_state  <= STATE_WE;
				end 
			end 
			STATE_WE_END:
			begin 
				addren <= 0;
				test_state <= STATE_RE_START;
			end 
			STATE_RE_START:
			begin 
				r_rcount   <= {ADDR_WIDTH_B{1'b0}};
				test_state <= STATE_RE;
			end 
			STATE_RE:
			begin
			    
				if (r_rcount == TOTAL_SIZE_A)
				begin
					test_state <= STATE_RE_END;
					re         <= 0;
					addren     <= 0;
				end 
				else
				begin     
					r_rcount   <= r_rcount+1'b1;
					test_state <= STATE_RE;
				end
			end
			STATE_RE_END :
			begin 
				re         <= 0;
				addren     <= 0;
				test_state <= STATE_IDLE;
				//if (r_rcount == addr) begin
        	    //    if (result) begin
        	    //    	$display("\n");
        	    //    	$display("=====================================");
        	    //    	$display("===========Simulation Pass===========");
        	    //    	$display("=====================================");
        	    //    end
        	    //    else begin
        	    //    	$display("\n");
        	    //    	$display("=====================================");
        	    //    	$display("===========Simulation Fail===========");
        	    //    	$display("=====================================");
        	    //    end
        	    //end
		    	$finish;
		    end 
		
		endcase 
			
	end 

end   
/////////////////////// Display on Terminal ///////////////////////////////
initial begin
	forever begin
		@(negedge clk) begin
		    if (we) begin
		    	$display("WRITING DATA");
				$display("exp_val XOR err_mask = %h write into addr = %d and data_arr[%d]\n",wdata, addr, addr);
			end
		end
	end
end
//////////////// To show in waveform ///////////////////////
always@(rdata) begin
    tester = (rdata ^ exp_val[addr]);
end
///////////////// Corrupting //////////////////////////
always begin
	forever begin @ (negedge clk)
		if (re)
		begin
			exp_val[err_count] <= 8'hxx;
		end
	end
end
////////////////////// Checker //////////////////////////////////////
always begin 
	forever begin @(negedge clk)
	    if (re)
	    begin
	    	$display("-----------------------------------------");
	    	$display("COMPARING DATA");
		    $display("addr = %d, rdata = %h, exp_val = %h, tester = %h, err_mask = %h", addr, rdata, exp_val[addr], rdata ^ exp_val[addr], err_mask[addr]);
	    	if ((rdata ^ exp_val[addr]) === err_mask[addr])
	    	begin
	    		result <= 1'b1;
	            $display("tester is equal to err_mask");
		        $display("PASS!");
		        $display("-----------------------------------------");
	        end
	        else begin
	        	$display("tester is not equal to err_mask");
	        	$display("-----------------------------------------");
	        	$display("Checking RDATA content :");
	        	if (rdata !== data_arr[addr]) //
	            begin
	            	result <= 1'b0;
	            	$display("COMPARING DATA");
	            	$display("addr = %d, rdata = %h, data_arr = %h", addr, rdata, data_arr[addr]);
	            	$display("rdata is not equal to data_arr");
	            	$display("RDATA Corrupted"); 
	            	$display("FAIL!\n");
	            	$display("-----------------------------------------");
	            end
	            else //if (rdata === data_arr[addr]), begin check for exp_val
	            begin
	            	$display("addr = %d, rdata = %h, data_arr[%d] = %h", addr, rdata, addr, data_arr[addr]);
	            	$display("RDATA not corrupted");
	            	$display("-----------------------------------------");
	            	$display("Purposely corrupting exp_val? :");
	            	if (exp_val[err_count] !== 8'hxx) 
	            	begin
	            	$display("NO!");
	            	result <= 1'b0;
	            	$display("COMPARING DATA");
	            	$display("addr = %d, rdata = %h, exp_val = %h, tester = %h, err_mask = %h", addr, rdata, exp_val[addr], rdata ^ exp_val[err_count], err_mask[addr]);
	            	$display("tester is not equal to err_mask");
	            	$display("exp_val suppose to be = %h", exp_val[err_count]);
	            	$display("UNEXPECTED FAILURE"); 
	            	$display("FAIL!\n");
	            	$display("-----------------------------------------");
	                end
	                else //if (exp_val[err_count] === 8'hxx), array is corrupted purposely then NEGATIVE TEST begin
	                begin
	                	$display("YES!");
	                	$display("Corrupted exp_val value = %h", exp_val[err_count]);
	                	$display("-----------------------------------------");
	                	$display("BEGIN NEGATIVE TEST CHECKER:");
	                	$display("-----------------------------------------");
	                	if ((rdata ^ exp_val[err_count]) === err_mask[addr]) 
	                	begin
	                		result <= 1'b0;
	                		$display("COMPARING DATA");
	                	    $display("addr = %d, rdata = %h, exp_val = %h, tester = %h, err_mask = %h", addr, rdata, exp_val[addr], rdata ^ exp_val[err_count], err_mask[addr]);
	                	    $display("tester is equal to err_mask");
	                	    $display("UNEXPECTED FAILURE");              
	                	    $display("NEGATIVE TEST FAIL!");
	                	    $display("-----------------------------------------");
	                	end
	                	else
	                	begin
	                		result <= 1'b1;
	                		$display("COMPARING DATA");
	                	    $display("addr = %d, rdata = %h, exp_val = %h, tester = %h, err_mask = %h", addr, rdata, exp_val[addr], rdata ^ exp_val[err_count], err_mask[addr]);
	                	    $display("tester is not equal to err_mask");
	                	    $display("EXPECTED FAILURE");          
	                	    $display("NEGATIVE TEST PASS!");
	                	    $display("-----------------------------------------");
	                    end
	                end
	            end
	        end
	    end
	end
end
///////////////// INPUT DERIVE at STATE MACHINE ////////////////////////
always@(negedge clk or posedge reset)
begin
	if(reset)
	begin
	
		we         <= 1'b0;
		addr       <= {ADDR_WIDTH_A{1'b0}};
		wdata      <= {DATA_WIDTH_A{1'b0}};
		r_wcount   <= 0;
		r_rcount   <= 0;
		re         <= 1'b0;
		tester     <= 0;
		err_count  <= 0;
	end 
	else 
	begin
		if(test_state == STATE_WE)
		begin
			we        <= 1;
			byteen    <= 8'hFF;
			addren    <= 1;
			re        <= 0;
			r_rcount  <= 0;
			tester    <= 0;
			err_count <= 0;
		end 
		else if(test_state == STATE_RE)
		begin
			we     <= 0;
			wdata  <= {DATA_WIDTH_A{1'b0}};
			byteen <= 8'hFF;
			addren <= 1;
			re     <= 1;
			addr   <= r_rcount;
		end 
		else 
		begin
			we <= 0;
			//addr = {ADDR_WIDTH_A{1'b0}};
			wdata      <= {DATA_WIDTH_A{1'b0}};
			addren     <= 0;
			r_wcount   <= 0;
			r_rcount   <= 0;
			re         <= 0;	
			tester     <= 0;
			err_count  <= 0;
		end 
	end 
end   
/////////  Instantiate DUT /////////////////
	efx_single_port_ram #(
	
	    .CLK_POLARITY(CLK_POLARITY),
	    .WCLKE_POLARITY(WCLKE_POLARITY),
	    .WE_POLARITY(WE_POLARITY),
	    .WRITE_MODE(WRITE_MODE),
	    .RE_POLARITY(RE_POLARITY),
	    .OUTPUT_REG(OUTPUT_REG),
	    .BYTEEN_POLARITY(BYTEEN_POLARITY),
	    .WCLKE_ENABLE(WCLKE_ENABLE),
	    .WE_ENABLE(WE_ENABLE),
	    .RE_ENABLE(RE_ENABLE),
	    .BYTEEN_ENABLE(BYTEEN_ENABLE),
	    .RST_POLARITY(RST_POLARITY),
	    .RESET_RAM(RESET_RAM),
	    .RESET_OUTREG(RESET_OUTREG),
	    .ADDREN_POLARITY(ADDREN_POLARITY),
	    .RESET_ENABLE(RESET_ENABLE),
	    .ADDREN_ENABLE(ADDREN_ENABLE)	
	
	) sp_ram (
	    .clk (clk),
	    .addr (addr),
	    .wclke (wclke),
	    .byteen (byteen),
	    .we (we),
	    .wdata (wdata),
	    .re (re),
	    .rdata (rdata),
	    .reset (reset),
	    .addren (addren)
	);
/////////////// Conclusion ////////////  
//initial begin
//	if(test_state == STATE_RE_END) begin
//        if (r_rcount == addr) begin
//        	if (result) begin
//        		$display("=====================");
//        		$display("===Simulation Pass===");
//        		$display("=====================");
//        	end
//        	else begin
//        		$display("=====================");
//        		$display("===Simulation Fail===");
//        		$display("=====================");
//        	end
//        end
//    end
//end
///////////////////////////////////////
endmodule


	
		  





















		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
