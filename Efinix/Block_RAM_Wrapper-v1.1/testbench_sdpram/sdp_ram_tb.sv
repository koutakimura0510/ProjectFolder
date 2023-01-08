module sdpram_tb;
localparam ADDR_WIDTH_A = 4;
localparam ADDR_WIDTH_B = 3;
localparam RESET_A_ENABLE = 1;
localparam RESET_B_ENABLE = 1;
localparam DEVICE_FAMILY = 1;
localparam DATA_WIDTH_A = 8;
localparam DATA_WIDTH_B = 16;
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
localparam RADDREN_ENABLE = 1;
localparam RADDREN_POLARITY = 1;
localparam WADDREN_ENABLE = 1;
localparam WADDREN_POLARITY = 1;
localparam RCLK_POLARITY = 1;
localparam WCLK_POLARITY = 1;
localparam WRITE_MODE = "READ_FIRST";
localparam MODULE_TYPE = 2;
localparam GROUP_DATA_WIDTH = 4;
localparam BYTEEN_ENABLE = 1;
localparam BYTEEN_POLARITY = 1;
localparam WIDTH_RATIO = 5;
localparam BYTEEN_WIDTH = 2;
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
reg                        wclk;
reg                        wclke;
reg [ADDR_WIDTH_A-1:0]     waddr;
reg [DATA_WIDTH_A-1:0]     wdata;     
reg [ADDR_WIDTH_B-1:0]     raddr;
wire [DATA_WIDTH_B-1:0]    rdata;
reg                        rclk;
reg [BYTEEN_WIDTH-1:0]     byteen;
reg                        we;
reg                        re; 
reg                        reset;	
reg                        waddren;
reg                        raddren;

reg [0:DATA_WIDTH_B-1]     monitor, monitor_temp;
reg [MEM_DATA_WIDTH-1:0]   dynamic_a[$];
reg [MEM_DATA_WIDTH-1:0]   dynamic_b[$];
reg                        result;
reg                        start_in;
reg [ADDR_WIDTH_A:0]       r_wcount;
reg [ADDR_WIDTH_B:0]       r_rcount;
reg [2:0]                  test_state;
integer i;


/////////////// Initialize clock and start/////////////////
initial begin
	clk      <= 0;
	rclk     <= 0;
	wclk     <= 0;
	wclke    <= 0;
	start_in <= 0;
	#150
	forever begin @ (negedge clk)
	start_in <= 1;
	wclke    <= 1;
	end
end
//////// Generate Clocks and initialize Reset //////////////
always begin
	#50 clk <= ~clk;
end
always begin
	#50 wclk <= ~wclk;
end
always begin
	#50 rclk <= ~rclk;
end
initial begin
	reset   <= 1'b1;
	#150 
	forever begin @ (negedge clk)
	reset   <= 1'b0;
	end
end
///////////// Initialize input ///////////////////
initial begin
	wdata             = 0;
	waddr             = 0;
	raddr             = 0;
	waddren           = 0;
	raddren           = 0;
	byteen            = 0;
	r_wcount          = 0;
	r_rcount          = 0;
	i                 = 0;
	we                = 0;
	re                = 0;
	result            = 0; 
	dynamic_a         = {};
	dynamic_b         = {};
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
/////////////////// Test Pattern /////////////////////
always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
	
		test_state <= STATE_IDLE;
		
		start_in          <= 0;
		we                <= 0;
		re                <= 1'b0;
		r_wcount          <= {ADDR_WIDTH_A{1'b0}};
		r_rcount          <= {ADDR_WIDTH_A{1'b0}};
		
		
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
				waddr <= r_wcount;
			    wdata <= r_wcount;
				if (r_wcount == TOTAL_SIZE_A)
				begin
					test_state <= STATE_WE_END;
					we      <= 0;
					waddr   <= 0;
					waddren <= 0;
					wdata   <= 0;
				end 
				else 
				begin
					
					wdata       <= {DATA_WIDTH_A{$random}};
					r_wcount    <= r_wcount+1;  
					test_state  <= STATE_WE;
				end 
			end 
			STATE_WE_END:
			begin 
				waddren    <= 0;
				test_state <= STATE_RE_START;
			end 
			STATE_RE_START:
			begin 
				r_rcount   <= {ADDR_WIDTH_B{1'b0}};
				test_state <= STATE_RE;
			end 
			STATE_RE:
			begin
				if (r_rcount == TOTAL_SIZE_B)
				begin
					test_state <= STATE_RE_END;
					re         <= 0;
					raddren    <= 0;
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
				raddren    <= 0;
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
		    if (we) begin
		    	if (DATA_WIDTH_A <= DATA_WIDTH_B) begin
					dynamic_a.push_back(wdata);
                    dynamic_b.push_back(wdata);
                    $display("WRITING DATA");
                    $display("write data %h into address %d ", wdata, waddr);
		    		$display("\n");
                    //$display("Temporary data store into dynamic_a = %p\n", dynamic_a);
                end
                else begin
                	integer i;
                	reg  [LSB_WIDTH-1 :0 ] lsbaddr;
                	for (i = RAM_MUX_RATIO; i > 0; i=i-1) begin
                	    lsbaddr = i;
                	    dynamic_a.push_back(wdata[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                        dynamic_b.push_back(wdata[((DATA_WIDTH_A_WGR/RAM_MUX_RATIO)*i)-1 -: DATA_WIDTH_A_WGR/RAM_MUX_RATIO]);
                    end
                    $display("WRITING DATA");
                    $display("write data %h into address %d ", wdata, waddr);
		    		$display("\n");
                    //$display("Temporary data store into dynamic_a = %p\n", dynamic_a);
                end
            end
        end
    end
end
/////////////////////////////// Checker /////////////////////////////////
initial begin
	forever begin
		@(posedge clk) begin
		    if (re) begin
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
end
///////////////////////////// Print Checker ////////////////////////////////////
initial begin
	forever begin
		@(negedge clk) begin
		    if (re) begin
		    	if (DATA_WIDTH_B <= DATA_WIDTH_A) begin
		    		$display("READING DATA: ");
		    		$display("read data %h from address %d", rdata, raddr);
		    	end
		    	else begin
		    		$display("READING DATA: ");
		    		$display("read data %h from address %d", rdata, raddr);
		    	end
		    end
		end
	end
end		    
////////////////////////// Conclusion //////////////////////////////////////
initial begin
	forever begin
		@(negedge clk) begin
		    if (re) begin
		    	if (monitor === rdata) begin
		    		$display("PASS! BRAM read data %h matches expected data %h", rdata, monitor);
		    		$display("\n");
		    	end
		    	else begin
		    		$display("FAIL! BRAM read data %h does not match expected data %h", rdata, monitor);
		    		$display("\n");
		    	end
		    end
		end
	end
end		    		
//////////////// INPUT DERIVE at STATE MACHINE ////////////////////////
always@(negedge clk or posedge reset)
begin
	if(reset)
	begin
		we         <= 1'b0;
		waddr      <= {ADDR_WIDTH_A{1'b0}};
		raddr      <= {ADDR_WIDTH_B{1'b0}};
		wdata      <= {DATA_WIDTH_A{1'b0}};
		r_wcount   <= 0;
		r_rcount   <= 0;
		re         <= 1'b0;
		byteen     <= 0;
	end 
	else 
	begin
		if(test_state == STATE_WE)
		begin
			we        <= 1;
			byteen    <= {BYTEEN_WIDTH{1'b1}};
			waddren   <= 1;
			re        <= 0;
			r_rcount  <= 0;
		end 
		else if(test_state == STATE_RE)
		begin
			wclke   <= 0;
			we      <= 0;
			wdata   <= {DATA_WIDTH_A{1'b0}};
			//byteen  <= 4'b1111;
			raddren <= 1;
			re      <= 1;
			raddr   <= r_rcount;
		end 
		else 
		begin
			wclke      <= 0;
			we         <= 0;
			//addr = {ADDR_WIDTH_A{1'b0}};
			wdata      <= {DATA_WIDTH_A{1'b0}};
			waddren    <= 0;
			raddren    <= 0;
			r_wcount   <= 0;
			r_rcount   <= 0;
			re         <= 0;
		end 
	end 
end   
/////////  Instantiate DUT /////////////////
	efx_simple_dual_port_ram #(
	
	    .CLK_POLARITY(CLK_POLARITY),
	    .WCLK_POLARITY(WCLK_POLARITY),
	    .WCLKE_POLARITY(WCLKE_POLARITY),
	    .WE_POLARITY(WE_POLARITY),
	    .WRITE_MODE(WRITE_MODE),
	    .RCLK_POLARITY(RCLK_POLARITY),
	    .RE_POLARITY(RE_POLARITY),
	    .OUTPUT_REG(OUTPUT_REG),    
	    .BYTEEN_POLARITY(BYTEEN_POLARITY),
	    .CLK_MODE(CLK_MODE),
	    .WCLKE_ENABLE(WCLKE_ENABLE),
	    .WE_ENABLE(WE_ENABLE),
	    .RE_ENABLE(RE_ENABLE),
	    .BYTEEN_ENABLE(BYTEEN_ENABLE),
	    .RST_POLARITY(RST_POLARITY),
	    .RESET_RAM(RESET_RAM),
	    .RESET_OUTREG(RESET_OUTREG),
	    .WADDREN_POLARITY(WADDREN_POLARITY),
	    .RADDREN_POLARITY(RADDREN_POLARITY),
	    .RESET_ENABLE(RESET_ENABLE),
	    .WADDREN_ENABLE(WADDREN_ENABLE),
	    .RADDREN_ENABLE(RADDREN_ENABLE)
	    
	) sdp_ram (
	    .clk      (clk    ),
	    .wclk     (wclk   ),
	    .wclke    (wclke  ),
	    .byteen   (byteen ),
	    .we       (we     ),
	    .waddr    (waddr  ),
	    .wdata    (wdata  ),
	    .rclk     (rclk   ),
	    .re       (re     ),
	    .raddr    (raddr  ),
	    .rdata    (rdata  ),
	    .reset    (reset  ),
	    .waddren  (waddren),
	    .raddren  (raddren)
	);
///////////// Conclusion ////////////    
//always @ (re) begin
//	if (result) begin
//		$display("\n");
//		$display("Simulation Complete");
//		$display("Simulation OK!");
//	end
//	else begin
//		$display("\n");
//		$display("Simulation Complete");
//		$display("Simulation NOT OK!");
//	end
//end
/////////////////////////////////////
endmodule


	
		  



















		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
