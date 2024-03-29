// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module affine_scale_dstin_loop_proc (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        mapchip_draw_xsize_dout,
        mapchip_draw_xsize_empty_n,
        mapchip_draw_xsize_read,
        trunc_ln1345_dout,
        trunc_ln1345_empty_n,
        trunc_ln1345_read,
        frame_size_dout,
        frame_size_empty_n,
        frame_size_read,
        dstin_dout,
        dstin_empty_n,
        dstin_read,
        m_axi_dst_AWVALID,
        m_axi_dst_AWREADY,
        m_axi_dst_AWADDR,
        m_axi_dst_AWID,
        m_axi_dst_AWLEN,
        m_axi_dst_AWSIZE,
        m_axi_dst_AWBURST,
        m_axi_dst_AWLOCK,
        m_axi_dst_AWCACHE,
        m_axi_dst_AWPROT,
        m_axi_dst_AWQOS,
        m_axi_dst_AWREGION,
        m_axi_dst_AWUSER,
        m_axi_dst_WVALID,
        m_axi_dst_WREADY,
        m_axi_dst_WDATA,
        m_axi_dst_WSTRB,
        m_axi_dst_WLAST,
        m_axi_dst_WID,
        m_axi_dst_WUSER,
        m_axi_dst_ARVALID,
        m_axi_dst_ARREADY,
        m_axi_dst_ARADDR,
        m_axi_dst_ARID,
        m_axi_dst_ARLEN,
        m_axi_dst_ARSIZE,
        m_axi_dst_ARBURST,
        m_axi_dst_ARLOCK,
        m_axi_dst_ARCACHE,
        m_axi_dst_ARPROT,
        m_axi_dst_ARQOS,
        m_axi_dst_ARREGION,
        m_axi_dst_ARUSER,
        m_axi_dst_RVALID,
        m_axi_dst_RREADY,
        m_axi_dst_RDATA,
        m_axi_dst_RLAST,
        m_axi_dst_RID,
        m_axi_dst_RUSER,
        m_axi_dst_RRESP,
        m_axi_dst_BVALID,
        m_axi_dst_BREADY,
        m_axi_dst_BRESP,
        m_axi_dst_BID,
        m_axi_dst_BUSER,
        dst_V2_address0,
        dst_V2_ce0,
        dst_V2_we0,
        dst_V2_d0
);

parameter    ap_ST_fsm_state1 = 13'd1;
parameter    ap_ST_fsm_state2 = 13'd2;
parameter    ap_ST_fsm_state3 = 13'd4;
parameter    ap_ST_fsm_state4 = 13'd8;
parameter    ap_ST_fsm_state5 = 13'd16;
parameter    ap_ST_fsm_state6 = 13'd32;
parameter    ap_ST_fsm_state7 = 13'd64;
parameter    ap_ST_fsm_state8 = 13'd128;
parameter    ap_ST_fsm_state9 = 13'd256;
parameter    ap_ST_fsm_state10 = 13'd512;
parameter    ap_ST_fsm_state11 = 13'd1024;
parameter    ap_ST_fsm_pp0_stage0 = 13'd2048;
parameter    ap_ST_fsm_state15 = 13'd4096;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] mapchip_draw_xsize_dout;
input   mapchip_draw_xsize_empty_n;
output   mapchip_draw_xsize_read;
input  [31:0] trunc_ln1345_dout;
input   trunc_ln1345_empty_n;
output   trunc_ln1345_read;
input  [31:0] frame_size_dout;
input   frame_size_empty_n;
output   frame_size_read;
input  [63:0] dstin_dout;
input   dstin_empty_n;
output   dstin_read;
output   m_axi_dst_AWVALID;
input   m_axi_dst_AWREADY;
output  [63:0] m_axi_dst_AWADDR;
output  [0:0] m_axi_dst_AWID;
output  [31:0] m_axi_dst_AWLEN;
output  [2:0] m_axi_dst_AWSIZE;
output  [1:0] m_axi_dst_AWBURST;
output  [1:0] m_axi_dst_AWLOCK;
output  [3:0] m_axi_dst_AWCACHE;
output  [2:0] m_axi_dst_AWPROT;
output  [3:0] m_axi_dst_AWQOS;
output  [3:0] m_axi_dst_AWREGION;
output  [0:0] m_axi_dst_AWUSER;
output   m_axi_dst_WVALID;
input   m_axi_dst_WREADY;
output  [31:0] m_axi_dst_WDATA;
output  [3:0] m_axi_dst_WSTRB;
output   m_axi_dst_WLAST;
output  [0:0] m_axi_dst_WID;
output  [0:0] m_axi_dst_WUSER;
output   m_axi_dst_ARVALID;
input   m_axi_dst_ARREADY;
output  [63:0] m_axi_dst_ARADDR;
output  [0:0] m_axi_dst_ARID;
output  [31:0] m_axi_dst_ARLEN;
output  [2:0] m_axi_dst_ARSIZE;
output  [1:0] m_axi_dst_ARBURST;
output  [1:0] m_axi_dst_ARLOCK;
output  [3:0] m_axi_dst_ARCACHE;
output  [2:0] m_axi_dst_ARPROT;
output  [3:0] m_axi_dst_ARQOS;
output  [3:0] m_axi_dst_ARREGION;
output  [0:0] m_axi_dst_ARUSER;
input   m_axi_dst_RVALID;
output   m_axi_dst_RREADY;
input  [31:0] m_axi_dst_RDATA;
input   m_axi_dst_RLAST;
input  [0:0] m_axi_dst_RID;
input  [0:0] m_axi_dst_RUSER;
input  [1:0] m_axi_dst_RRESP;
input   m_axi_dst_BVALID;
output   m_axi_dst_BREADY;
input  [1:0] m_axi_dst_BRESP;
input  [0:0] m_axi_dst_BID;
input  [0:0] m_axi_dst_BUSER;
output  [9:0] dst_V2_address0;
output   dst_V2_ce0;
output   dst_V2_we0;
output  [23:0] dst_V2_d0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg mapchip_draw_xsize_read;
reg trunc_ln1345_read;
reg frame_size_read;
reg dstin_read;
reg m_axi_dst_ARVALID;
reg m_axi_dst_RREADY;
reg dst_V2_ce0;
reg dst_V2_we0;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [12:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    mapchip_draw_xsize_blk_n;
reg    trunc_ln1345_blk_n;
reg    frame_size_blk_n;
reg    dstin_blk_n;
reg    dst_blk_n_AR;
wire    ap_CS_fsm_state5;
reg    dst_blk_n_R;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0;
reg   [0:0] icmp_ln878_reg_245;
reg   [31:0] x_V_reg_122;
reg   [31:0] x_V_reg_122_pp0_iter1_reg;
wire    ap_block_state12_pp0_stage0_iter0;
reg    ap_block_state13_pp0_stage0_iter1;
wire    ap_block_state14_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [31:0] mapchip_draw_xsize_read_reg_198;
reg   [31:0] trunc_ln1345_read_reg_204;
reg  signed [31:0] frame_size_read_reg_209;
reg   [63:0] dstin_read_reg_214;
wire    ap_CS_fsm_state2;
wire   [61:0] grp_fu_140_p2;
reg   [61:0] ret_reg_229;
wire    ap_CS_fsm_state3;
reg   [63:0] dst_addr_reg_234;
wire    ap_CS_fsm_state4;
wire   [31:0] add_ln691_fu_178_p2;
reg   [31:0] add_ln691_reg_240;
reg    ap_enable_reg_pp0_iter0;
wire   [0:0] icmp_ln878_fu_184_p2;
reg   [0:0] icmp_ln878_reg_245_pp0_iter1_reg;
wire   [23:0] trunc_ln324_fu_189_p1;
reg   [23:0] trunc_ln324_reg_249;
wire    ap_CS_fsm_state11;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state12;
reg    ap_enable_reg_pp0_iter2;
reg   [31:0] ap_phi_mux_x_V_phi_fu_126_p4;
wire   [63:0] zext_ln137_fu_193_p1;
wire  signed [63:0] sext_ln324_fu_168_p1;
reg    ap_block_state1;
wire   [31:0] grp_fu_140_p0;
wire   [63:0] shl_ln324_1_fu_146_p3;
wire   [63:0] add_ln324_fu_153_p2;
wire   [61:0] trunc_ln324_2_fu_158_p4;
wire    ap_CS_fsm_state15;
reg   [12:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [61:0] grp_fu_140_p00;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 13'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
end

affine_scale_mul_32ns_32s_62_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 62 ))
mul_32ns_32s_62_2_1_U84(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_140_p0),
    .din1(frame_size_read_reg_209),
    .ce(1'b1),
    .dout(grp_fu_140_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state15)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state12) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state11)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp0_exit_iter0_state12)) begin
                ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state12);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if ((1'b1 == ap_CS_fsm_state11)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state11)) begin
        x_V_reg_122 <= 32'd0;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_245 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        x_V_reg_122 <= add_ln691_reg_240;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        add_ln691_reg_240 <= add_ln691_fu_178_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        dst_addr_reg_234 <= sext_ln324_fu_168_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        dstin_read_reg_214 <= dstin_dout;
        frame_size_read_reg_209 <= frame_size_dout;
        mapchip_draw_xsize_read_reg_198 <= mapchip_draw_xsize_dout;
        trunc_ln1345_read_reg_204 <= trunc_ln1345_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln878_reg_245 <= icmp_ln878_fu_184_p2;
        icmp_ln878_reg_245_pp0_iter1_reg <= icmp_ln878_reg_245;
        x_V_reg_122_pp0_iter1_reg <= x_V_reg_122;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        ret_reg_229 <= grp_fu_140_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_245 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        trunc_ln324_reg_249 <= trunc_ln324_fu_189_p1;
    end
end

always @ (*) begin
    if ((icmp_ln878_fu_184_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state12 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state12 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_245 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        ap_phi_mux_x_V_phi_fu_126_p4 = add_ln691_reg_240;
    end else begin
        ap_phi_mux_x_V_phi_fu_126_p4 = x_V_reg_122;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        dst_V2_ce0 = 1'b1;
    end else begin
        dst_V2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln878_reg_245_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        dst_V2_we0 = 1'b1;
    end else begin
        dst_V2_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        dst_blk_n_AR = m_axi_dst_ARREADY;
    end else begin
        dst_blk_n_AR = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_245 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        dst_blk_n_R = m_axi_dst_RVALID;
    end else begin
        dst_blk_n_R = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstin_blk_n = dstin_empty_n;
    end else begin
        dstin_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        dstin_read = 1'b1;
    end else begin
        dstin_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_blk_n = frame_size_empty_n;
    end else begin
        frame_size_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        frame_size_read = 1'b1;
    end else begin
        frame_size_read = 1'b0;
    end
end

always @ (*) begin
    if (((m_axi_dst_ARREADY == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        m_axi_dst_ARVALID = 1'b1;
    end else begin
        m_axi_dst_ARVALID = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln878_reg_245 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        m_axi_dst_RREADY = 1'b1;
    end else begin
        m_axi_dst_RREADY = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_blk_n = mapchip_draw_xsize_empty_n;
    end else begin
        mapchip_draw_xsize_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        mapchip_draw_xsize_read = 1'b1;
    end else begin
        mapchip_draw_xsize_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        trunc_ln1345_blk_n = trunc_ln1345_empty_n;
    end else begin
        trunc_ln1345_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        trunc_ln1345_read = 1'b1;
    end else begin
        trunc_ln1345_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            if (((m_axi_dst_ARREADY == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((icmp_ln878_fu_184_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)) & ~((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)) | ((icmp_ln878_fu_184_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0)))) begin
                ap_NS_fsm = ap_ST_fsm_state15;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln324_fu_153_p2 = (dstin_read_reg_214 + shl_ln324_1_fu_146_p3);

assign add_ln691_fu_178_p2 = (ap_phi_mux_x_V_phi_fu_126_p4 + 32'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd11];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state11 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_state15 = ap_CS_fsm[32'd12];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((m_axi_dst_RVALID == 1'b0) & (icmp_ln878_reg_245 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((m_axi_dst_RVALID == 1'b0) & (icmp_ln878_reg_245 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_state1 = ((dstin_empty_n == 1'b0) | (frame_size_empty_n == 1'b0) | (trunc_ln1345_empty_n == 1'b0) | (mapchip_draw_xsize_empty_n == 1'b0) | (ap_done_reg == 1'b1) | (ap_start == 1'b0));
end

assign ap_block_state12_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state13_pp0_stage0_iter1 = ((m_axi_dst_RVALID == 1'b0) & (icmp_ln878_reg_245 == 1'd0));
end

assign ap_block_state14_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign dst_V2_address0 = zext_ln137_fu_193_p1;

assign dst_V2_d0 = trunc_ln324_reg_249;

assign grp_fu_140_p0 = grp_fu_140_p00;

assign grp_fu_140_p00 = trunc_ln1345_read_reg_204;

assign icmp_ln878_fu_184_p2 = ((ap_phi_mux_x_V_phi_fu_126_p4 == mapchip_draw_xsize_read_reg_198) ? 1'b1 : 1'b0);

assign m_axi_dst_ARADDR = dst_addr_reg_234;

assign m_axi_dst_ARBURST = 2'd0;

assign m_axi_dst_ARCACHE = 4'd0;

assign m_axi_dst_ARID = 1'd0;

assign m_axi_dst_ARLEN = mapchip_draw_xsize_read_reg_198;

assign m_axi_dst_ARLOCK = 2'd0;

assign m_axi_dst_ARPROT = 3'd0;

assign m_axi_dst_ARQOS = 4'd0;

assign m_axi_dst_ARREGION = 4'd0;

assign m_axi_dst_ARSIZE = 3'd0;

assign m_axi_dst_ARUSER = 1'd0;

assign m_axi_dst_AWADDR = 64'd0;

assign m_axi_dst_AWBURST = 2'd0;

assign m_axi_dst_AWCACHE = 4'd0;

assign m_axi_dst_AWID = 1'd0;

assign m_axi_dst_AWLEN = 32'd0;

assign m_axi_dst_AWLOCK = 2'd0;

assign m_axi_dst_AWPROT = 3'd0;

assign m_axi_dst_AWQOS = 4'd0;

assign m_axi_dst_AWREGION = 4'd0;

assign m_axi_dst_AWSIZE = 3'd0;

assign m_axi_dst_AWUSER = 1'd0;

assign m_axi_dst_AWVALID = 1'b0;

assign m_axi_dst_BREADY = 1'b0;

assign m_axi_dst_WDATA = 32'd0;

assign m_axi_dst_WID = 1'd0;

assign m_axi_dst_WLAST = 1'b0;

assign m_axi_dst_WSTRB = 4'd0;

assign m_axi_dst_WUSER = 1'd0;

assign m_axi_dst_WVALID = 1'b0;

assign sext_ln324_fu_168_p1 = $signed(trunc_ln324_2_fu_158_p4);

assign shl_ln324_1_fu_146_p3 = {{ret_reg_229}, {2'd0}};

assign trunc_ln324_2_fu_158_p4 = {{add_ln324_fu_153_p2[63:2]}};

assign trunc_ln324_fu_189_p1 = m_axi_dst_RDATA[23:0];

assign zext_ln137_fu_193_p1 = x_V_reg_122_pp0_iter1_reg;

endmodule //affine_scale_dstin_loop_proc
