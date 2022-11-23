// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module AESL_axi_slave_control (
    clk,
    reset,
    TRAN_s_axi_control_AWADDR,
    TRAN_s_axi_control_AWVALID,
    TRAN_s_axi_control_AWREADY,
    TRAN_s_axi_control_WVALID,
    TRAN_s_axi_control_WREADY,
    TRAN_s_axi_control_WDATA,
    TRAN_s_axi_control_WSTRB,
    TRAN_s_axi_control_ARADDR,
    TRAN_s_axi_control_ARVALID,
    TRAN_s_axi_control_ARREADY,
    TRAN_s_axi_control_RVALID,
    TRAN_s_axi_control_RREADY,
    TRAN_s_axi_control_RDATA,
    TRAN_s_axi_control_RRESP,
    TRAN_s_axi_control_BVALID,
    TRAN_s_axi_control_BREADY,
    TRAN_s_axi_control_BRESP,
    TRAN_control_write_data_finish,
    TRAN_control_start_in,
    TRAN_control_idle_out,
    TRAN_control_ready_out,
    TRAN_control_ready_in,
    TRAN_control_done_out,
    TRAN_control_write_start_in   ,
    TRAN_control_write_start_finish,
    TRAN_control_interrupt,
    TRAN_control_transaction_done_in
    );

//------------------------Parameter----------------------
`define TV_IN_dstout "../tv/cdatafile/c.patbit.autotvin_dstout.dat"
`define TV_IN_xpos "../tv/cdatafile/c.patbit.autotvin_xpos.dat"
`define TV_IN_ypos "../tv/cdatafile/c.patbit.autotvin_ypos.dat"
`define TV_IN_width "../tv/cdatafile/c.patbit.autotvin_width.dat"
`define TV_IN_height "../tv/cdatafile/c.patbit.autotvin_height.dat"
`define TV_IN_color "../tv/cdatafile/c.patbit.autotvin_color.dat"
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 32;
parameter dstout_DEPTH = 1;
reg [31 : 0] dstout_OPERATE_DEPTH = 0;
parameter dstout_c_bitwidth = 64;
parameter xpos_DEPTH = 1;
reg [31 : 0] xpos_OPERATE_DEPTH = 0;
parameter xpos_c_bitwidth = 11;
parameter ypos_DEPTH = 1;
reg [31 : 0] ypos_OPERATE_DEPTH = 0;
parameter ypos_c_bitwidth = 11;
parameter width_DEPTH = 1;
reg [31 : 0] width_OPERATE_DEPTH = 0;
parameter width_c_bitwidth = 11;
parameter height_DEPTH = 1;
reg [31 : 0] height_OPERATE_DEPTH = 0;
parameter height_c_bitwidth = 11;
parameter color_DEPTH = 1;
reg [31 : 0] color_OPERATE_DEPTH = 0;
parameter color_c_bitwidth = 32;
parameter START_ADDR = 0;
parameter patbit_continue_addr = 0;
parameter patbit_auto_start_addr = 0;
parameter dstout_data_in_addr = 16;
parameter xpos_data_in_addr = 28;
parameter ypos_data_in_addr = 36;
parameter width_data_in_addr = 44;
parameter height_data_in_addr = 52;
parameter color_data_in_addr = 60;
parameter STATUS_ADDR = 0;

output [ADDR_WIDTH - 1 : 0] TRAN_s_axi_control_AWADDR;
output  TRAN_s_axi_control_AWVALID;
input  TRAN_s_axi_control_AWREADY;
output  TRAN_s_axi_control_WVALID;
input  TRAN_s_axi_control_WREADY;
output [DATA_WIDTH - 1 : 0] TRAN_s_axi_control_WDATA;
output [DATA_WIDTH/8 - 1 : 0] TRAN_s_axi_control_WSTRB;
output [ADDR_WIDTH - 1 : 0] TRAN_s_axi_control_ARADDR;
output  TRAN_s_axi_control_ARVALID;
input  TRAN_s_axi_control_ARREADY;
input  TRAN_s_axi_control_RVALID;
output  TRAN_s_axi_control_RREADY;
input [DATA_WIDTH - 1 : 0] TRAN_s_axi_control_RDATA;
input [2 - 1 : 0] TRAN_s_axi_control_RRESP;
input  TRAN_s_axi_control_BVALID;
output  TRAN_s_axi_control_BREADY;
input [2 - 1 : 0] TRAN_s_axi_control_BRESP;
output TRAN_control_write_data_finish;
input     clk;
input     reset;
input     TRAN_control_start_in;
output    TRAN_control_done_out;
output    TRAN_control_ready_out;
input     TRAN_control_ready_in;
output    TRAN_control_idle_out;
input  TRAN_control_write_start_in   ;
output TRAN_control_write_start_finish;
input     TRAN_control_interrupt;
input     TRAN_control_transaction_done_in;

reg [ADDR_WIDTH - 1 : 0] AWADDR_reg = 0;
reg  AWVALID_reg = 0;
reg  WVALID_reg = 0;
reg [DATA_WIDTH - 1 : 0] WDATA_reg = 0;
reg [DATA_WIDTH/8 - 1 : 0] WSTRB_reg = 0;
reg [ADDR_WIDTH - 1 : 0] ARADDR_reg = 0;
reg  ARVALID_reg = 0;
reg  RREADY_reg = 0;
reg [DATA_WIDTH - 1 : 0] RDATA_reg = 0;
reg  BREADY_reg = 0;
reg [dstout_c_bitwidth - 1 : 0] mem_dstout [dstout_DEPTH - 1 : 0];
reg dstout_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_xpos [xpos_DEPTH - 1 : 0];
reg xpos_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_ypos [ypos_DEPTH - 1 : 0];
reg ypos_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_width [width_DEPTH - 1 : 0];
reg width_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_height [height_DEPTH - 1 : 0];
reg height_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_color [color_DEPTH - 1 : 0];
reg color_write_data_finish;
reg AESL_ready_out_index_reg = 0;
reg AESL_write_start_finish = 0;
reg AESL_ready_reg;
reg ready_initial;
reg AESL_done_index_reg = 0;
reg AESL_idle_index_reg = 0;
reg AESL_auto_restart_index_reg;
reg process_0_finish = 0;
reg process_1_finish = 0;
reg process_2_finish = 0;
reg process_3_finish = 0;
reg process_4_finish = 0;
reg process_5_finish = 0;
reg process_6_finish = 0;
reg process_7_finish = 0;
//write dstout reg
reg [31 : 0] write_dstout_count = 0;
reg write_dstout_run_flag = 0;
reg write_one_dstout_data_done = 0;
//write xpos reg
reg [31 : 0] write_xpos_count = 0;
reg write_xpos_run_flag = 0;
reg write_one_xpos_data_done = 0;
//write ypos reg
reg [31 : 0] write_ypos_count = 0;
reg write_ypos_run_flag = 0;
reg write_one_ypos_data_done = 0;
//write width reg
reg [31 : 0] write_width_count = 0;
reg write_width_run_flag = 0;
reg write_one_width_data_done = 0;
//write height reg
reg [31 : 0] write_height_count = 0;
reg write_height_run_flag = 0;
reg write_one_height_data_done = 0;
//write color reg
reg [31 : 0] write_color_count = 0;
reg write_color_run_flag = 0;
reg write_one_color_data_done = 0;
reg [31 : 0] write_start_count = 0;
reg write_start_run_flag = 0;

//===================process control=================
reg [31 : 0] ongoing_process_number = 0;
//process number depends on how much processes needed.
reg process_busy = 0;

//=================== signal connection ==============
assign TRAN_s_axi_control_AWADDR = AWADDR_reg;
assign TRAN_s_axi_control_AWVALID = AWVALID_reg;
assign TRAN_s_axi_control_WVALID = WVALID_reg;
assign TRAN_s_axi_control_WDATA = WDATA_reg;
assign TRAN_s_axi_control_WSTRB = WSTRB_reg;
assign TRAN_s_axi_control_ARADDR = ARADDR_reg;
assign TRAN_s_axi_control_ARVALID = ARVALID_reg;
assign TRAN_s_axi_control_RREADY = RREADY_reg;
assign TRAN_s_axi_control_BREADY = BREADY_reg;
assign TRAN_control_write_start_finish = AESL_write_start_finish;
assign TRAN_control_done_out = AESL_done_index_reg;
assign TRAN_control_ready_out = AESL_ready_out_index_reg;
assign TRAN_control_idle_out = AESL_idle_index_reg;
assign TRAN_control_write_data_finish = 1 & dstout_write_data_finish & xpos_write_data_finish & ypos_write_data_finish & width_write_data_finish & height_write_data_finish & color_write_data_finish;
always @(TRAN_control_ready_in or ready_initial) 
begin
    AESL_ready_reg <= TRAN_control_ready_in | ready_initial;
end

always @(reset or process_0_finish or process_1_finish or process_2_finish or process_3_finish or process_4_finish or process_5_finish or process_6_finish or process_7_finish ) begin
    if (reset == 0) begin
        ongoing_process_number <= 0;
    end
    else if (ongoing_process_number == 0 && process_0_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 1 && process_1_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 2 && process_2_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 3 && process_3_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 4 && process_4_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 5 && process_5_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 6 && process_6_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 7 && process_7_finish == 1) begin
            ongoing_process_number <= 0;
    end
end

task count_c_data_four_byte_num_by_bitwidth;
input  integer bitwidth;
output integer num;
integer factor;
integer i;
begin
    factor = 32;
    for (i = 1; i <= 32; i = i + 1) begin
        if (bitwidth <= factor && bitwidth > factor - 32) begin
            num = i;
        end
        factor = factor + 32;
    end
end    
endtask

task count_seperate_factor_by_bitwidth;
input  integer bitwidth;
output integer factor;
begin
    if (bitwidth <= 8) begin
        factor=4;
    end
    if (bitwidth <= 16 & bitwidth > 8 ) begin
        factor=2;
    end
    if (bitwidth <= 32 & bitwidth > 16 ) begin
        factor=1;
    end
    if (bitwidth <= 1024 & bitwidth > 32 ) begin
        factor=1;
    end
end    
endtask

task count_operate_depth_by_bitwidth_and_depth;
input  integer bitwidth;
input  integer depth;
output integer operate_depth;
integer factor;
integer remain;
begin
    count_seperate_factor_by_bitwidth (bitwidth , factor);
    operate_depth = depth / factor;
    remain = depth % factor;
    if (remain > 0) begin
        operate_depth = operate_depth + 1;
    end
end    
endtask

task write; /*{{{*/
    input  reg [ADDR_WIDTH - 1:0] waddr;   // write address
    input  reg [DATA_WIDTH - 1:0] wdata;   // write data
    output reg wresp;
    reg aw_flag;
    reg w_flag;
    reg [DATA_WIDTH/8 - 1:0] wstrb_reg;
    integer i;
begin 
    wresp = 0;
    aw_flag = 0;
    w_flag = 0;
//=======================one single write operate======================
    AWADDR_reg <= waddr;
    AWVALID_reg <= 1;
    WDATA_reg <= wdata;
    WVALID_reg <= 1;
    for (i = 0; i < DATA_WIDTH/8; i = i + 1) begin
        wstrb_reg [i] = 1;
    end    
    WSTRB_reg <= wstrb_reg;
    while (!(aw_flag && w_flag)) begin
        @(posedge clk);
        if (aw_flag != 1)
            aw_flag = TRAN_s_axi_control_AWREADY & AWVALID_reg;
        if (w_flag != 1)
            w_flag = TRAN_s_axi_control_WREADY & WVALID_reg;
        AWVALID_reg <= !aw_flag;
        WVALID_reg <= !w_flag;
    end

    BREADY_reg <= 1;
    while (TRAN_s_axi_control_BVALID != 1) begin
        //wait for response 
        @(posedge clk);
    end
    @(posedge clk);
    BREADY_reg <= 0;
    if (TRAN_s_axi_control_BRESP === 2'b00) begin
        wresp = 1;
        //input success. in fact BRESP is always 2'b00
    end   
//=======================one single write operate======================

end
endtask/*}}}*/

task read (/*{{{*/
    input  [ADDR_WIDTH - 1:0] raddr ,   // write address
    output [DATA_WIDTH - 1:0] RDATA_result ,
    output rresp
);
begin 
    rresp = 0;
//=======================one single read operate======================
    ARADDR_reg <= raddr;
    ARVALID_reg <= 1;
    while (TRAN_s_axi_control_ARREADY !== 1) begin
        @(posedge clk);
    end
    @(posedge clk);
    ARVALID_reg <= 0;
    RREADY_reg <= 1;
    while (TRAN_s_axi_control_RVALID !== 1) begin
        //wait for response 
        @(posedge clk);
    end
    @(posedge clk);
    RDATA_result  <= TRAN_s_axi_control_RDATA;
    RREADY_reg <= 0;
    if (TRAN_s_axi_control_RRESP === 2'b00 ) begin
        rresp <= 1;
        //output success. in fact RRESP is always 2'b00
    end  
    @(posedge clk);

//=======================one single read operate end======================

end
endtask/*}}}*/

initial begin : ready_initial_process
    ready_initial = 0;
    wait(reset === 1);
    @(posedge clk);
    ready_initial = 1;
    @(posedge clk);
    ready_initial = 0;
end

initial begin : update_status
    integer process_num ;
    integer read_status_resp;
    wait(reset === 1);
    @(posedge clk);
    process_num = 0;
    while (1) begin
        process_0_finish = 0;
        AESL_done_index_reg         <= 0;
        AESL_ready_out_index_reg        <= 0;
        if (ongoing_process_number === process_num && process_busy === 0) begin
            process_busy = 1;
            read (STATUS_ADDR, RDATA_reg, read_status_resp);
                AESL_done_index_reg         <= RDATA_reg[1 : 1];
                AESL_ready_out_index_reg    <= RDATA_reg[1 : 1];
                AESL_idle_index_reg         <= RDATA_reg[2 : 2];
            process_0_finish = 1;
            process_busy = 0;
        end 
        @(posedge clk);
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        dstout_write_data_finish <= 0;
        write_dstout_run_flag <= 0; 
        write_dstout_count = 0;
        count_operate_depth_by_bitwidth_and_depth (dstout_c_bitwidth, dstout_DEPTH, dstout_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            dstout_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_dstout_run_flag <= 1; 
            write_dstout_count = 0;
        end
        if (write_one_dstout_data_done === 1) begin
            write_dstout_count = write_dstout_count + 1;
            if (write_dstout_count == dstout_OPERATE_DEPTH) begin
                write_dstout_run_flag <= 0; 
                dstout_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_dstout
    integer write_dstout_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] dstout_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = dstout_c_bitwidth;
    process_num = 1;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_1_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_dstout_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write dstout data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (dstout_c_bitwidth < 32) begin
                        dstout_data_tmp_reg = mem_dstout[write_dstout_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < dstout_c_bitwidth) begin
                                dstout_data_tmp_reg[j] = mem_dstout[write_dstout_count][i*32 + j];
                            end
                            else begin
                                dstout_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (dstout_data_in_addr + write_dstout_count * four_byte_num * 4 + i * 4, dstout_data_tmp_reg, write_dstout_resp);
                end
                process_busy = 0;
                write_one_dstout_data_done <= 1;
                @(posedge clk);
                write_one_dstout_data_done <= 0;
            end   
            process_1_finish <= 1;
        end
        @(posedge clk);
    end    
end
always @(reset or posedge clk) begin
    if (reset == 0) begin
        xpos_write_data_finish <= 0;
        write_xpos_run_flag <= 0; 
        write_xpos_count = 0;
        count_operate_depth_by_bitwidth_and_depth (xpos_c_bitwidth, xpos_DEPTH, xpos_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            xpos_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_xpos_run_flag <= 1; 
            write_xpos_count = 0;
        end
        if (write_one_xpos_data_done === 1) begin
            write_xpos_count = write_xpos_count + 1;
            if (write_xpos_count == xpos_OPERATE_DEPTH) begin
                write_xpos_run_flag <= 0; 
                xpos_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_xpos
    integer write_xpos_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] xpos_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = xpos_c_bitwidth;
    process_num = 2;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_2_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_xpos_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write xpos data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (xpos_c_bitwidth < 32) begin
                        xpos_data_tmp_reg = mem_xpos[write_xpos_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < xpos_c_bitwidth) begin
                                xpos_data_tmp_reg[j] = mem_xpos[write_xpos_count][i*32 + j];
                            end
                            else begin
                                xpos_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (xpos_data_in_addr + write_xpos_count * four_byte_num * 4 + i * 4, xpos_data_tmp_reg, write_xpos_resp);
                end
                process_busy = 0;
                write_one_xpos_data_done <= 1;
                @(posedge clk);
                write_one_xpos_data_done <= 0;
            end   
            process_2_finish <= 1;
        end
        @(posedge clk);
    end    
end
always @(reset or posedge clk) begin
    if (reset == 0) begin
        ypos_write_data_finish <= 0;
        write_ypos_run_flag <= 0; 
        write_ypos_count = 0;
        count_operate_depth_by_bitwidth_and_depth (ypos_c_bitwidth, ypos_DEPTH, ypos_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            ypos_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_ypos_run_flag <= 1; 
            write_ypos_count = 0;
        end
        if (write_one_ypos_data_done === 1) begin
            write_ypos_count = write_ypos_count + 1;
            if (write_ypos_count == ypos_OPERATE_DEPTH) begin
                write_ypos_run_flag <= 0; 
                ypos_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_ypos
    integer write_ypos_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] ypos_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = ypos_c_bitwidth;
    process_num = 3;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_3_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_ypos_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write ypos data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (ypos_c_bitwidth < 32) begin
                        ypos_data_tmp_reg = mem_ypos[write_ypos_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < ypos_c_bitwidth) begin
                                ypos_data_tmp_reg[j] = mem_ypos[write_ypos_count][i*32 + j];
                            end
                            else begin
                                ypos_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (ypos_data_in_addr + write_ypos_count * four_byte_num * 4 + i * 4, ypos_data_tmp_reg, write_ypos_resp);
                end
                process_busy = 0;
                write_one_ypos_data_done <= 1;
                @(posedge clk);
                write_one_ypos_data_done <= 0;
            end   
            process_3_finish <= 1;
        end
        @(posedge clk);
    end    
end
always @(reset or posedge clk) begin
    if (reset == 0) begin
        width_write_data_finish <= 0;
        write_width_run_flag <= 0; 
        write_width_count = 0;
        count_operate_depth_by_bitwidth_and_depth (width_c_bitwidth, width_DEPTH, width_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            width_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_width_run_flag <= 1; 
            write_width_count = 0;
        end
        if (write_one_width_data_done === 1) begin
            write_width_count = write_width_count + 1;
            if (write_width_count == width_OPERATE_DEPTH) begin
                write_width_run_flag <= 0; 
                width_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_width
    integer write_width_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] width_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = width_c_bitwidth;
    process_num = 4;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_4_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_width_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write width data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (width_c_bitwidth < 32) begin
                        width_data_tmp_reg = mem_width[write_width_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < width_c_bitwidth) begin
                                width_data_tmp_reg[j] = mem_width[write_width_count][i*32 + j];
                            end
                            else begin
                                width_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (width_data_in_addr + write_width_count * four_byte_num * 4 + i * 4, width_data_tmp_reg, write_width_resp);
                end
                process_busy = 0;
                write_one_width_data_done <= 1;
                @(posedge clk);
                write_one_width_data_done <= 0;
            end   
            process_4_finish <= 1;
        end
        @(posedge clk);
    end    
end
always @(reset or posedge clk) begin
    if (reset == 0) begin
        height_write_data_finish <= 0;
        write_height_run_flag <= 0; 
        write_height_count = 0;
        count_operate_depth_by_bitwidth_and_depth (height_c_bitwidth, height_DEPTH, height_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            height_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_height_run_flag <= 1; 
            write_height_count = 0;
        end
        if (write_one_height_data_done === 1) begin
            write_height_count = write_height_count + 1;
            if (write_height_count == height_OPERATE_DEPTH) begin
                write_height_run_flag <= 0; 
                height_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_height
    integer write_height_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] height_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = height_c_bitwidth;
    process_num = 5;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_5_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_height_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write height data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (height_c_bitwidth < 32) begin
                        height_data_tmp_reg = mem_height[write_height_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < height_c_bitwidth) begin
                                height_data_tmp_reg[j] = mem_height[write_height_count][i*32 + j];
                            end
                            else begin
                                height_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (height_data_in_addr + write_height_count * four_byte_num * 4 + i * 4, height_data_tmp_reg, write_height_resp);
                end
                process_busy = 0;
                write_one_height_data_done <= 1;
                @(posedge clk);
                write_one_height_data_done <= 0;
            end   
            process_5_finish <= 1;
        end
        @(posedge clk);
    end    
end
always @(reset or posedge clk) begin
    if (reset == 0) begin
        color_write_data_finish <= 0;
        write_color_run_flag <= 0; 
        write_color_count = 0;
        count_operate_depth_by_bitwidth_and_depth (color_c_bitwidth, color_DEPTH, color_OPERATE_DEPTH);
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            color_write_data_finish <= 0;
        end
        if (AESL_ready_reg === 1) begin
            write_color_run_flag <= 1; 
            write_color_count = 0;
        end
        if (write_one_color_data_done === 1) begin
            write_color_count = write_color_count + 1;
            if (write_color_count == color_OPERATE_DEPTH) begin
                write_color_run_flag <= 0; 
                color_write_data_finish <= 1;
            end
        end
    end
end

initial begin : write_color
    integer write_color_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    reg [31 : 0] color_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = color_c_bitwidth;
    process_num = 6;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num) ;
    while (1) begin
        process_6_finish <= 0;

        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            get_ack = 1;
            if (write_color_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write color data 
                for (i = 0 ; i < four_byte_num ; i = i+1) begin
                    if (color_c_bitwidth < 32) begin
                        color_data_tmp_reg = mem_color[write_color_count];
                    end
                    else begin
                        for (j=0 ; j<32 ; j = j + 1) begin
                            if (i*32 + j < color_c_bitwidth) begin
                                color_data_tmp_reg[j] = mem_color[write_color_count][i*32 + j];
                            end
                            else begin
                                color_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    write (color_data_in_addr + write_color_count * four_byte_num * 4 + i * 4, color_data_tmp_reg, write_color_resp);
                end
                process_busy = 0;
                write_one_color_data_done <= 1;
                @(posedge clk);
                write_one_color_data_done <= 0;
            end   
            process_6_finish <= 1;
        end
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_start_run_flag <= 0; 
        write_start_count <= 0;
    end
    else begin
        if (write_start_count >= 3) begin
            write_start_run_flag <= 0; 
        end
        else if (TRAN_control_write_start_in === 1) begin
            write_start_run_flag <= 1; 
        end
        if (AESL_write_start_finish === 1) begin
            write_start_count <= write_start_count + 1;
            write_start_run_flag <= 0; 
        end
    end
end

initial begin : write_start
    reg [DATA_WIDTH - 1 : 0] write_start_tmp;
    integer process_num;
    integer write_start_resp;
    wait(reset === 1);
    @(posedge clk);
    process_num = 7;
    while (1) begin
        process_7_finish = 0;
        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            if (write_start_run_flag === 1) begin
                process_busy = 1;
                write_start_tmp=0;
                write_start_tmp[0 : 0] = 1;
                write (START_ADDR, write_start_tmp, write_start_resp);
                process_busy = 0;
                AESL_write_start_finish <= 1;
                @(posedge clk);
                AESL_write_start_finish <= 0;
            end
            process_7_finish <= 1;
        end 
        @(posedge clk);
    end
end

//------------------------Task and function-------------- 
task read_token; 
    input integer fp; 
    output reg [151 : 0] token;
    integer ret;
    begin
        token = "";
        ret = 0;
        ret = $fscanf(fp,"%s",token);
    end 
endtask 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_dstout_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [dstout_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (dstout_c_bitwidth , factor);
  fp = $fopen(`TV_IN_dstout ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_dstout); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < dstout_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_dstout [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_dstout [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_dstout [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_dstout [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_dstout [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_xpos_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [xpos_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (xpos_c_bitwidth , factor);
  fp = $fopen(`TV_IN_xpos ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_xpos); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < xpos_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_xpos [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_xpos [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_xpos [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_xpos [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_xpos [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_ypos_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [ypos_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (ypos_c_bitwidth , factor);
  fp = $fopen(`TV_IN_ypos ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_ypos); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < ypos_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_ypos [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_ypos [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_ypos [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_ypos [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_ypos [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_width_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [width_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (width_c_bitwidth , factor);
  fp = $fopen(`TV_IN_width ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_width); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < width_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_width [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_width [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_width [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_width [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_width [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_height_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [height_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (height_c_bitwidth , factor);
  fp = $fopen(`TV_IN_height ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_height); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < height_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_height [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_height [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_height [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_height [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_height [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_color_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [color_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] mem_tmp; 
  reg [ 8*5 : 1] str;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (color_c_bitwidth , factor);
  fp = $fopen(`TV_IN_color ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_color); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < color_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  mem_tmp [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  mem_tmp [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  mem_tmp [31 : 24] = token_tmp;
                  mem_color [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  mem_tmp [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  mem_tmp [31 : 16] = token_tmp;
                  mem_color [i/factor] = mem_tmp;
                  mem_tmp [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_color [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_color [i/factor] = mem_tmp;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_color [i/factor] = mem_tmp;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
endmodule
