module tdpram_tb;
	
localparam ADDR_WIDTH_A = 3;
localparam DATA_WIDTH_A = 16;
localparam ADDR_WIDTH_B = 3;
localparam DATA_WIDTH_B = 16;
localparam BYTEEN_WIDTH_A = 1;
localparam BYTEEN_WIDTH_B = 1;
localparam GROUP_DATA_WIDTH_A = 0;
localparam GROUP_DATA_WIDTH_B = 0;
localparam RESET_A_ENABLE = 1;
localparam RESET_B_ENABLE = 1;
localparam RSTA_POLARITY = 1;
localparam RSTB_POLARITY = 1;
localparam DEVICE_FAMILY = 1;
localparam CLK_POLARITY = 1;
localparam RE_ENABLE = 1;
localparam RE_POLARITY = 1;
localparam RESET_ENABLE = 1;
localparam RST_POLARITY = 1;
localparam WCLKE_ENABLE = 1;
localparam WE_ENABLE = 1;
localparam WE_POLARITY = 1;
localparam WCLKE_POLARITY = 1;
localparam ADDRENA_POLARITY = 1;
localparam ADDRENB_POLARITY = 1;
localparam MODULE_MODE = 1;
localparam RESET_RAM_A = "ASYNC";
localparam RESET_RAM_B = "ASYNC";
localparam RESET_OUTREG_A = "ASYNC";
localparam RESET_OUTREG_B = "ASYNC";
localparam WRITE_MODE_A = "READ_FIRST";
localparam WRITE_MODE_B = "READ_FIRST";
localparam CLK_MODE = 2;
localparam CLKA_POLARITY = 1;
localparam CLKB_POLARITY = 1;
localparam CLKE_POLARITY = 1;
localparam CLKEA_ENABLE = 1;
localparam CLKEB_ENABLE = 1;
localparam CLKEA_POLARITY = 1;
localparam CLKEB_POLARITY = 1;
localparam OUTPUT_REG_A = 0;
localparam OUTPUT_REG_B = 0;
localparam WEA_ENABLE = 1;
localparam WEA_POLARITY = 1;
localparam WEB_ENABLE = 1;
localparam WEB_POLARITY = 1;
localparam RADDREN_ENABLE = 1;
localparam RADDREN_POLARITY = 1;
localparam WADDREN_ENABLE = 1;
localparam WADDREN_POLARITY = 1;
localparam RCLK_POLARITY = 1;
localparam WCLK_POLARITY = 1;
localparam ADDREN_A_ENABLE = 1;
localparam ADDREN_B_ENABLE = 1;
localparam MODULE_TYPE = 3;
localparam BYTEENA_ENABLE = 1;
localparam BYTEENB_ENABLE = 1;
localparam BYTEENA_POLARITY = 1;
localparam BYTEENB_POLARITY = 1;
localparam WIDTH_RATIO = 4;
localparam TOTAL_SIZE_A = (2**ADDR_WIDTH_A);
localparam TOTAL_SIZE_B = (2**ADDR_WIDTH_B);
localparam TEST_PATTERN = 1'b1;

localparam DATA_WIDTH_A_WGR	= (WIDTH_RATIO == 0)? 16 : 
                              (WIDTH_RATIO == 1)? 32 :
                              (WIDTH_RATIO == 2)? 32 :
                              (WIDTH_RATIO == 3)? 16 :
                              (WIDTH_RATIO == 4)? 16 :
                              (WIDTH_RATIO == 5)? 16 :
                              (WIDTH_RATIO == 6)? 16 :
                              (WIDTH_RATIO == 7)? 16 :
                              (WIDTH_RATIO == 8)? 16 : 16;
                              
localparam DATA_WIDTH_A_RGW	= (WIDTH_RATIO == 0)? 16 : 
                              (WIDTH_RATIO == 1)? 16 :
                              (WIDTH_RATIO == 2)? 16 :
                              (WIDTH_RATIO == 3)? 16 :
                              (WIDTH_RATIO == 4)? 16 :
                              (WIDTH_RATIO == 5)? 8  :
                              (WIDTH_RATIO == 6)? 8  :
                              (WIDTH_RATIO == 7)? 4  :
                              (WIDTH_RATIO == 8)? 1  : 16;
	
localparam DATA_WIDTH_B_48     = (WIDTH_RATIO >= 4) ? DATA_WIDTH_B : 16;

localparam MEM_DATA_WIDTH     = (DATA_WIDTH_A >= DATA_WIDTH_B) ? DATA_WIDTH_B : DATA_WIDTH_A;
localparam RAM_MUX_RATIO      = (DATA_WIDTH_B <= DATA_WIDTH_A/32) ? 32 :
                                (DATA_WIDTH_B <= DATA_WIDTH_A/16) ? 16 :
                                (DATA_WIDTH_B <= DATA_WIDTH_A/8)  ? 8  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A/4)  ? 4  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A/2)  ? 2  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A)    ? 1  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A*2)  ? 2  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A*4)  ? 4  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A*8)  ? 8  :
                                (DATA_WIDTH_B <= DATA_WIDTH_A*16) ? 16 : 32; 
localparam LSB_WIDTH          = (ADDR_WIDTH_A > ADDR_WIDTH_B) ? (ADDR_WIDTH_A - ADDR_WIDTH_B) : (ADDR_WIDTH_B - ADDR_WIDTH_A);


reg                        clk;
reg                        clke;
reg                        clk_a;
reg                        clke_a;
reg                        clk_b;
reg                        clke_b;
reg                        reset_a;
reg                        addren_a;
reg   [BYTEEN_WIDTH_A-1:0] byteen_a;
reg                        we_a;
reg   [ADDR_WIDTH_A-1:0 ]  addr_a;
reg   [DATA_WIDTH_A-1:0 ]  wdata_a;
wire  [DATA_WIDTH_A-1:0 ]  rdata_a;
reg                        reset_b;
reg                        addren_b;
reg   [BYTEEN_WIDTH_B-1:0] byteen_b;
reg                        we_b;
reg   [ADDR_WIDTH_B-1:0 ]  addr_b;
reg   [DATA_WIDTH_B-1:0 ]  wdata_b;
wire  [DATA_WIDTH_B-1:0 ]  rdata_b;

reg [0:DATA_WIDTH_B-1]     monitor, monitor_temp;
reg [MEM_DATA_WIDTH-1:0]   dynamic_a[$];
reg [MEM_DATA_WIDTH-1:0]   dynamic_b[$];
reg                        result;
reg                        start_in;
reg                        on_monitor;
reg						   final_trigger;
reg [ADDR_WIDTH_A:0]       r_wcount_A;
reg [ADDR_WIDTH_B:0]       r_wcount_B;
reg [ADDR_WIDTH_A:0]       r_wcount_C;
reg [ADDR_WIDTH_B:0]       r_wcount_D;
reg [ADDR_WIDTH_A:0]       r_rcount_A;
reg [ADDR_WIDTH_B:0]       r_rcount_B;
reg [2:0]                  test_state;
integer i;

/////////////// Initialize clock and start/////////////////
initial begin
	clk      <= 0;
	clke     <= 0;
	clk_a    <= 0;
	clke_a   <= 0;
	clk_b    <= 0;
	clke_b   <= 0;
	start_in <= 0;
	#150
	forever begin @ (negedge clk)
	start_in <= 1;
	clke     <= 1;
	clke_a   <= 1;
	clke_b   <= 1;
	end
end
////////// Generate Clocks and initialize Reset //////////////
always begin
	#200 clk <= ~clk;
end
always begin
	#200 clk_a <= ~clk_a;
end
always begin
	#200 clk_b <= ~clk_b;
end
initial begin
	reset_a   <= 1'b1;
	reset_b   <= 1'b1;
	#150 
	forever begin @ (negedge clk)
	reset_a   <= 1'b0;
	reset_b   <= 1'b0;
	end
end
///////////// Initialize input ///////////////////
initial begin
	wdata_a           = 0;
	wdata_b           = 0;
	addr_a            = 0; 
	addr_b            = 0;
	addren_a          = 0;
	addren_b          = 0;
	byteen_a          = 0;
	byteen_b          = 0;
	r_wcount_A        = 0;
	r_wcount_B        = 0;
	r_wcount_C        = 0;
    r_wcount_D        = 0;
	r_rcount_A        = 0;
	r_rcount_B        = 0;
	i                 = 0;
	we_a              = 0;
	we_b              = 0;
	result            = 0;
	on_monitor        = 0;
	final_trigger     = 0;
	dynamic_a         = {};
	dynamic_b         = {};
end	
////////////// State Machine for Test Pattern /////////////
localparam STATE_IDLE  		             = 3'd0;
localparam STATE_START 		             = 3'd1;
localparam STATE_WE_START	             = 3'd2;
localparam STATE_WE_A     	             = 3'd3;
localparam STATE_WE_B    	             = 3'd4;
localparam STATE_FINAL_READ              = 3'd5;
localparam STATE_FINISH                  = 3'd6;
localparam FIRST_ACCESS  = (TEST_PATTERN==1)?STATE_WE_START:STATE_WE_START;//0=read first, 1=write first
///////////////////// Test Pattern /////////////////////
always@(negedge clk) //or posedge reset_a or posedge reset_b)
begin
	if(reset_a) begin
		
		test_state <= STATE_IDLE;
		
		start_in          <= 0;
		we_a              <= 0;
		wdata_a           <= 0;
		addr_a            <= 0;
		byteen_a          <= {BYTEEN_WIDTH_A{1'b0}};
		r_wcount_A        <= {ADDR_WIDTH_A{1'b0}};
		r_rcount_A        <= {ADDR_WIDTH_A{1'b0}};
		r_wcount_C        <= {ADDR_WIDTH_A{1'b0}};
		
		
	end 
	else if (reset_b) begin
		
		test_state <= STATE_IDLE;
		
		start_in          <= 0;
		we_b              <= 0;
		wdata_b           <= 0;
		addr_b            <= 0;
		byteen_b          <= {BYTEEN_WIDTH_B{1'b0}};
		r_wcount_B        <= {ADDR_WIDTH_B{1'b0}};
		r_rcount_B        <= {ADDR_WIDTH_B{1'b0}};
		r_wcount_D        <= {ADDR_WIDTH_B{1'b0}};
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
				
				test_state <= FIRST_ACCESS; //always start WE_A
			end
			
			STATE_WE_START:
			begin 
				we_a       <= 0;
				we_b       <= 0;
				
				test_state <= STATE_WE_A;
			end 
			
			STATE_WE_A:
			begin
				on_monitor    <= 1;
				we_a          <= 1;
				we_b          <= 0;
				addr_a        <= r_wcount_A;
				addr_b        <= r_wcount_B;
				byteen_a      <= {BYTEEN_WIDTH_A{1'b1}};
				byteen_b      <= {BYTEEN_WIDTH_B{1'b1}};
				addren_a      <= 1;
				addren_b      <= 1;
				wdata_b       <= 0;
				wdata_a     <= {DATA_WIDTH_A{$random}};
				r_wcount_A  <= r_wcount_A+1'b1;
                r_wcount_B  <= r_wcount_B+1'b1;
                
                test_state  <= STATE_WE_A;
				
				if (r_wcount_A == TOTAL_SIZE_A && r_wcount_B == TOTAL_SIZE_B)
				begin
			    	we_a          <= 0;
			        wdata_a       <= 0;
			        r_wcount_A    <= 0;
			        r_wcount_B    <= 0; 
			        on_monitor    <= 0;
			        
					test_state <= STATE_WE_B;
				end 
			end 
			
			STATE_WE_B:
			begin		
				on_monitor    <= 1;
				r_wcount_C    <= r_wcount_C+1;
				r_wcount_D    <= r_wcount_D+1;
				addr_a        <= r_wcount_C;
				addr_b        <= r_wcount_D;
				byteen_a      <= {BYTEEN_WIDTH_A{1'b1}};
				byteen_b      <= {BYTEEN_WIDTH_B{1'b1}};
				addren_a      <= 1;
				addren_b      <= 1;
				we_a          <= 0;
			    we_b          <= 1;
			    wdata_a       <= 0;
			    wdata_b       <= {DATA_WIDTH_B{$random}};
			    
			    test_state  <= STATE_WE_B;
			    
				if (r_wcount_C == TOTAL_SIZE_A && r_wcount_D == TOTAL_SIZE_B)
				begin
					wdata_a     <= 0;
					wdata_b     <= 0;
					we_b        <= 0; 
					r_wcount_C  <= 0;
					r_wcount_D  <= 0;
					
					test_state  <= STATE_FINAL_READ;
				end
			end
			
			STATE_FINAL_READ:
			begin 
				final_trigger  <= 1;
				r_rcount_A     <= r_rcount_A+1'b1; 
				r_rcount_B     <= r_rcount_B+1'b1;
				addr_a         <= r_rcount_A;
				addr_b         <= r_rcount_B;
				wdata_a        <= {DATA_WIDTH_A{1'b0}};
			    wdata_b        <= {DATA_WIDTH_B{1'b0}};
			    addren_a       <= 1;
			    addren_b       <= 1;
			    we_a           <= 0;
			    we_b           <= 0;
			    
			    test_state  <= STATE_FINAL_READ;
			    
				if (r_rcount_A == TOTAL_SIZE_A && r_rcount_B == TOTAL_SIZE_B)
				begin
					we_a          <= 0;
			        we_b          <= 0;
			        r_rcount_A    <= 0;
			        r_rcount_B    <= 0;
					test_state <= STATE_FINISH;
				end 
			end 
		    
		    STATE_FINISH:
		    begin
		    	test_state <= STATE_IDLE;
		    	$finish;
		    end
		endcase 
	end 
end   
//////////////////// push data into array /////////////////////////
initial begin
	forever begin
		@(negedge clk) begin
		    if (we_a) begin
		    	if (DATA_WIDTH_A <= DATA_WIDTH_B) begin
					dynamic_a.push_back(wdata_a);
                    dynamic_b.push_back(wdata_a);
                    $display("\nStore write data into array dynamic_a = %p", dynamic_a);
                end
                else begin
                	integer i;
                	reg  [LSB_WIDTH-1 :0 ] lsbaddr;
                	for (i = RAM_MUX_RATIO; i > 0; i=i-1) begin
                	    lsbaddr = i;
                	    dynamic_a.push_back(wdata_a[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                        dynamic_b.push_back(wdata_a[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                    end
                    $display("\nStore write data into array dynamic_a = %p", dynamic_a);
                end
            end
            else if (we_b) begin
            	if (DATA_WIDTH_A <= DATA_WIDTH_B) begin
					dynamic_a.push_back(wdata_b);
                    dynamic_b.push_back(wdata_b);
                    $display("\nStore write data into array dynamic_a = %p", dynamic_a);
                end
                else begin
                	integer i;
                	reg  [LSB_WIDTH-1 :0 ] lsbaddr;
                	for (i = RAM_MUX_RATIO; i > 0; i=i-1) begin
                	    lsbaddr = i;
                	    dynamic_a.push_back(wdata_b[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                        dynamic_b.push_back(wdata_b[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                    end
                    $display("\nStore write data into array dynamic_a = %p", dynamic_a);
                end
            end
        end
    end
end
///////////////////////////// Checker /////////////////////////////////
always@(posedge clk) begin
	if (test_state == STATE_WE_A) begin
		if (we_a == 1 && addren_a ==1) begin 
			monitor <= 0;
    	end
    end
    else if (test_state == STATE_WE_B) begin
    	if (on_monitor == 1) begin
    	    if (DATA_WIDTH_B <= DATA_WIDTH_A) begin
    	    	monitor <= dynamic_a.pop_front();
    	    end
    	    else begin
    	    	integer i;
    	    	for (i=RAM_MUX_RATIO; i > 0; i=i-1) begin
    	    	    monitor[((DATA_WIDTH_B_48/RAM_MUX_RATIO)*i)-1 -: (DATA_WIDTH_B_48/RAM_MUX_RATIO)] <= dynamic_a.pop_front();
    	    	end
    	    end
    	end
    end
    else if (test_state == STATE_FINAL_READ) begin
        if (final_trigger == 1) begin
            if (DATA_WIDTH_B <= DATA_WIDTH_A) begin
            	monitor <= dynamic_a.pop_front();
            end
            else begin
            	integer i;
            	for (i=RAM_MUX_RATIO; i > 0; i=i-1) begin
            	    monitor[((DATA_WIDTH_B_48/RAM_MUX_RATIO)*i)-1 -: (DATA_WIDTH_B_48/RAM_MUX_RATIO)] <= dynamic_a.pop_front();
            	end
            end
        end
    end
end
/////////////////////////// Print Checker //////////////////////////////////
initial begin
	forever begin 
		@(negedge clk) begin
	        if (test_state == STATE_WE_A) begin
	        	if (we_a) begin
		            $display("\n");
	        		$display("STATE_WRITE Port A Only");
	        	    $display("-----------------------");
	        		$display("WRITING DATA:");
                    $display("write data %d into address Port A : %d", wdata_a, addr_a);
                    $display("write data %d into address Port B : %d", wdata_b, addr_b);
                    $display("READING DATA: ");
                    $display("read data %h from address Port A : %d", rdata_a, addr_a);
                    $display("read data %h from address Port B : %d", rdata_b, addr_b);
                    $display("monitor = %h\n", monitor);
                    if (monitor === rdata_a && monitor === rdata_b) begin
		               	$display("PASS! BRAM read data Port A : %h matches expected data %h", rdata_a, monitor);
		               	$display("PASS! BRAM read data Port B : %h matches expected data %h", rdata_b, monitor);
		            end
		            else begin
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_a, monitor);
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_b, monitor);
		            end
                    end
                end 
            else if (test_state == STATE_WE_B) begin
            	if (we_b) begin
		            $display("\n");
            	    $display("STATE_WRITE Port B Only");
	        	    $display("-----------------------");
            		$display("WRITING DATA:");
                    $display("write data %d into address Port A : %d", wdata_a, addr_a);
                    $display("write data %d into address Port B : %d", wdata_b, addr_b);
                    $display("READING DATA: ");
                    $display("read data %h from address Port A : %d", rdata_a, addr_a);
                    $display("read data %h from address Port B : %d", rdata_b, addr_b);
                    $display("monitor = %h\n", monitor);
                    if (monitor === rdata_a && monitor === rdata_b) begin
		               	$display("PASS! BRAM read data Port A : %h matches expected data %h", rdata_a, monitor);
		               	$display("PASS! BRAM read data Port B : %h matches expected data %h", rdata_b, monitor);
		            end
		            else begin
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_a, monitor);
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_b, monitor);
		            end
                    end
                end
            else if (test_state == STATE_FINAL_READ) begin
            	if (final_trigger) begin
		            $display("\n");
            	    $display("STATE_READ Only");
	        	    $display("-----------------------");
            		$display("WRITING DATA:");
                    $display("write data %d into address Port A : %d", wdata_a, addr_a);
                    $display("write data %d into address Port B : %d", wdata_b, addr_b);
                    $display("READING DATA: ");
                    $display("read data %h from address Port A : %d", rdata_a, addr_a);
                    $display("read data %h from address Port B : %d", rdata_b, addr_b);
                    $display("monitor = %h\n", monitor);
                    if (monitor === rdata_a && monitor === rdata_b) begin
		               	$display("PASS! BRAM read data Port A : %h matches expected data %h", rdata_a, monitor);
		               	$display("PASS! BRAM read data Port B : %h matches expected data %h", rdata_b, monitor);
		            end
		            else begin
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_a, monitor);
		               	$display("FAIL! BRAM read data Port A : %h does not match expected data %h", rdata_b, monitor);
		            end
                end
            end
        end
    end
end
/////////  Instantiate DUT /////////////////
	efx_true_dual_port_ram #(
	
	    .CLK_POLARITY(CLK_POLARITY),
	    .CLKE_POLARITY(CLKE_POLARITY),
	    .CLKA_POLARITY(CLKA_POLARITY),
	    .CLKEA_POLARITY(CLKEA_POLARITY),
	    .WEA_POLARITY(WEA_POLARITY),
	    .WRITE_MODE_A(WRITE_MODE_A),
	    .OUTPUT_REG_A(OUTPUT_REG_A),
	    .BYTEENA_POLARITY(BYTEENA_POLARITY),
	    .CLKB_POLARITY(CLKB_POLARITY),
	    .CLKEB_POLARITY(CLKEB_POLARITY),
	    .WEB_POLARITY(WEB_POLARITY),
	    .WRITE_MODE_B(WRITE_MODE_B),
	    .OUTPUT_REG_B(OUTPUT_REG_B),
	    .BYTEENB_POLARITY(BYTEENB_POLARITY),
	    .CLK_MODE(CLK_MODE),
	    .CLKEA_ENABLE(CLKEA_ENABLE),
	    .WEA_ENABLE(WEA_ENABLE),
	    .BYTEENA_ENABLE(BYTEENA_ENABLE),
	    .CLKEB_ENABLE(CLKEB_ENABLE),
	    .WEB_ENABLE(WEB_ENABLE),
	    .BYTEENB_ENABLE(BYTEENB_ENABLE),
	    .RSTA_POLARITY(RSTA_POLARITY),
	    .RESET_RAM_A(RESET_RAM_A),
	    .RESET_OUTREG_A(RESET_OUTREG_A),
	    .ADDRENA_POLARITY(ADDRENA_POLARITY),
	    .RSTB_POLARITY(RSTB_POLARITY),
	    .RESET_RAM_B(RESET_RAM_B),
	    .RESET_OUTREG_B(RESET_OUTREG_B),
	    .ADDRENB_POLARITY(ADDRENB_POLARITY),
	    .RESET_A_ENABLE(RESET_A_ENABLE),
	    .ADDREN_A_ENABLE(ADDREN_A_ENABLE),
	    .RESET_B_ENABLE(RESET_B_ENABLE),
	    .ADDREN_B_ENABLE(ADDREN_B_ENABLE)
	   
	    
	) tdp_ram (
	    .clk      (clk    ),
	    .clke     (clke   ),
	    .clk_a    (clk_a  ),
	    .clke_a   (clke_a ),
	    .byteen_a (byteen_a),
	    .we_a     (we_a   ),
	    .addr_a   (addr_a ),
	    .wdata_a  (wdata_a),
	    .rdata_a  (rdata_a),
	    .clk_b    (clk_b  ),
	    .clke_b   (clke_b ),
	    .byteen_b (byteen_b),
	    .we_b     (we_b   ),
	    .addr_b   (addr_b ),
	    .wdata_b  (wdata_b),
	    .rdata_b  (rdata_b),
	    .reset_a  (reset_a),
	    .addren_a (addren_a),
	    .reset_b  (reset_b),
	    .addren_b (addren_b)
	    
	);
endmodule


	
		  



















		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
