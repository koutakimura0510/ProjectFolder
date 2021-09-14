# This script segment is generated automatically by AutoPilot

set id 91
set name affine_scale_mul_32ns_32ns_62_2_1
set corename simcore_mul
set op mul
set stage_num 2
set max_latency -1
set registered_input 1
set clk_width 1
set clk_signed 0
set reset_width 1
set reset_signed 0
set in0_width 32
set in0_signed 0
set in1_width 32
set in1_signed 0
set ce_width 1
set ce_signed 0
set out_width 62
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ap_gen_simcore_mul] == "ap_gen_simcore_mul"} {
eval "ap_gen_simcore_mul { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    clk_width ${clk_width} \
    clk_signed ${clk_signed} \
    reset_width ${reset_width} \
    reset_signed ${reset_signed} \
    in0_width ${in0_width} \
    in0_signed ${in0_signed} \
    in1_width ${in1_width} \
    in1_signed ${in1_signed} \
    ce_width ${ce_width} \
    ce_signed ${ce_signed} \
    out_width ${out_width} \
}"
} else {
puts "@W \[IMPL-100\] Cannot find ap_gen_simcore_mul, check your AutoPilot builtin lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler ${name}
}


set op mul
set corename Multiplier
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_multicycle_mul] == "::AESL_LIB_VIRTEX::xil_gen_multicycle_mul"} {
eval "::AESL_LIB_VIRTEX::xil_gen_multicycle_mul { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    max_latency ${max_latency} \
    registered_input ${registered_input} \
    clk_width ${clk_width} \
    clk_signed ${clk_signed} \
    reset_width ${reset_width} \
    reset_signed ${reset_signed} \
    in0_width ${in0_width} \
    in0_signed ${in0_signed} \
    in1_width ${in1_width} \
    in1_signed ${in1_signed} \
    ce_width ${ce_width} \
    ce_signed ${ce_signed} \
    out_width ${out_width} \
}"
} else {
puts "@W \[IMPL-101\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_multicycle_mul, check your platform lib"
}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 123 \
    name dst_V2 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename dst_V2 \
    op interface \
    ports { dst_V2_address0 { O 10 vector } dst_V2_ce0 { O 1 bit } dst_V2_we0 { O 1 bit } dst_V2_d0 { O 24 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'dst_V2'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name mapchip_draw_xsize \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_draw_xsize \
    op interface \
    ports { mapchip_draw_xsize_dout { I 32 vector } mapchip_draw_xsize_empty_n { I 1 bit } mapchip_draw_xsize_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name trunc_ln69 \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_trunc_ln69 \
    op interface \
    ports { trunc_ln69_dout { I 32 vector } trunc_ln69_empty_n { I 1 bit } trunc_ln69_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name frame_size \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_frame_size \
    op interface \
    ports { frame_size_dout { I 32 vector } frame_size_empty_n { I 1 bit } frame_size_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name dstin \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dstin \
    op interface \
    ports { dstin_dout { I 64 vector } dstin_empty_n { I 1 bit } dstin_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name dst \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dst \
    op interface \
    ports { m_axi_dst_AWVALID { O 1 bit } m_axi_dst_AWREADY { I 1 bit } m_axi_dst_AWADDR { O 64 vector } m_axi_dst_AWID { O 1 vector } m_axi_dst_AWLEN { O 32 vector } m_axi_dst_AWSIZE { O 3 vector } m_axi_dst_AWBURST { O 2 vector } m_axi_dst_AWLOCK { O 2 vector } m_axi_dst_AWCACHE { O 4 vector } m_axi_dst_AWPROT { O 3 vector } m_axi_dst_AWQOS { O 4 vector } m_axi_dst_AWREGION { O 4 vector } m_axi_dst_AWUSER { O 1 vector } m_axi_dst_WVALID { O 1 bit } m_axi_dst_WREADY { I 1 bit } m_axi_dst_WDATA { O 32 vector } m_axi_dst_WSTRB { O 4 vector } m_axi_dst_WLAST { O 1 bit } m_axi_dst_WID { O 1 vector } m_axi_dst_WUSER { O 1 vector } m_axi_dst_ARVALID { O 1 bit } m_axi_dst_ARREADY { I 1 bit } m_axi_dst_ARADDR { O 64 vector } m_axi_dst_ARID { O 1 vector } m_axi_dst_ARLEN { O 32 vector } m_axi_dst_ARSIZE { O 3 vector } m_axi_dst_ARBURST { O 2 vector } m_axi_dst_ARLOCK { O 2 vector } m_axi_dst_ARCACHE { O 4 vector } m_axi_dst_ARPROT { O 3 vector } m_axi_dst_ARQOS { O 4 vector } m_axi_dst_ARREGION { O 4 vector } m_axi_dst_ARUSER { O 1 vector } m_axi_dst_RVALID { I 1 bit } m_axi_dst_RREADY { O 1 bit } m_axi_dst_RDATA { I 32 vector } m_axi_dst_RLAST { I 1 bit } m_axi_dst_RID { I 1 vector } m_axi_dst_RUSER { I 1 vector } m_axi_dst_RRESP { I 2 vector } m_axi_dst_BVALID { I 1 bit } m_axi_dst_BREADY { O 1 bit } m_axi_dst_BRESP { I 2 vector } m_axi_dst_BID { I 1 vector } m_axi_dst_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name mapchip_maxwidth \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxwidth \
    op interface \
    ports { mapchip_maxwidth_dout { I 32 vector } mapchip_maxwidth_empty_n { I 1 bit } mapchip_maxwidth_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name d \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_d \
    op interface \
    ports { d_dout { I 20 vector } d_empty_n { I 1 bit } d_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
    name a \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_a \
    op interface \
    ports { a_dout { I 20 vector } a_empty_n { I 1 bit } a_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 118 \
    name c \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_c \
    op interface \
    ports { c_dout { I 20 vector } c_empty_n { I 1 bit } c_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name b \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_b \
    op interface \
    ports { b_dout { I 20 vector } b_empty_n { I 1 bit } b_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name m \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_m \
    op interface \
    ports { m_dout { I 32 vector } m_empty_n { I 1 bit } m_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name mapchip_maxheight \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxheight \
    op interface \
    ports { mapchip_maxheight_dout { I 32 vector } mapchip_maxheight_empty_n { I 1 bit } mapchip_maxheight_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name n \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_n \
    op interface \
    ports { n_dout { I 32 vector } n_empty_n { I 1 bit } n_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } ap_continue { I 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


