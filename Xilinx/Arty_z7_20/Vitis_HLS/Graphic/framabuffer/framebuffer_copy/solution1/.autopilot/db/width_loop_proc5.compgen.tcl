# This script segment is generated automatically by AutoPilot

set id 1
set name framebuffer_copy_mul_32ns_32ns_62_2_1
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
    id 8 \
    name src_V1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename src_V1 \
    op interface \
    ports { src_V1_address0 { O 10 vector } src_V1_ce0 { O 1 bit } src_V1_we0 { O 1 bit } src_V1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'src_V1'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name width \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_width \
    op interface \
    ports { width { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name y \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_y \
    op interface \
    ports { y { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name display_xsize \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_display_xsize \
    op interface \
    ports { display_xsize { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name copy \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_copy \
    op interface \
    ports { copy { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name cp \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_cp \
    op interface \
    ports { m_axi_cp_AWVALID { O 1 bit } m_axi_cp_AWREADY { I 1 bit } m_axi_cp_AWADDR { O 64 vector } m_axi_cp_AWID { O 1 vector } m_axi_cp_AWLEN { O 32 vector } m_axi_cp_AWSIZE { O 3 vector } m_axi_cp_AWBURST { O 2 vector } m_axi_cp_AWLOCK { O 2 vector } m_axi_cp_AWCACHE { O 4 vector } m_axi_cp_AWPROT { O 3 vector } m_axi_cp_AWQOS { O 4 vector } m_axi_cp_AWREGION { O 4 vector } m_axi_cp_AWUSER { O 1 vector } m_axi_cp_WVALID { O 1 bit } m_axi_cp_WREADY { I 1 bit } m_axi_cp_WDATA { O 32 vector } m_axi_cp_WSTRB { O 4 vector } m_axi_cp_WLAST { O 1 bit } m_axi_cp_WID { O 1 vector } m_axi_cp_WUSER { O 1 vector } m_axi_cp_ARVALID { O 1 bit } m_axi_cp_ARREADY { I 1 bit } m_axi_cp_ARADDR { O 64 vector } m_axi_cp_ARID { O 1 vector } m_axi_cp_ARLEN { O 32 vector } m_axi_cp_ARSIZE { O 3 vector } m_axi_cp_ARBURST { O 2 vector } m_axi_cp_ARLOCK { O 2 vector } m_axi_cp_ARCACHE { O 4 vector } m_axi_cp_ARPROT { O 3 vector } m_axi_cp_ARQOS { O 4 vector } m_axi_cp_ARREGION { O 4 vector } m_axi_cp_ARUSER { O 1 vector } m_axi_cp_RVALID { I 1 bit } m_axi_cp_RREADY { O 1 bit } m_axi_cp_RDATA { I 32 vector } m_axi_cp_RLAST { I 1 bit } m_axi_cp_RID { I 1 vector } m_axi_cp_RUSER { I 1 vector } m_axi_cp_RRESP { I 2 vector } m_axi_cp_BVALID { I 1 bit } m_axi_cp_BREADY { O 1 bit } m_axi_cp_BRESP { I 2 vector } m_axi_cp_BID { I 1 vector } m_axi_cp_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name update \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_update \
    op interface \
    ports { update { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name width_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_width_out \
    op interface \
    ports { width_out_din { O 32 vector } width_out_full_n { I 1 bit } width_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name y_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_y_out \
    op interface \
    ports { y_out_din { O 32 vector } y_out_full_n { I 1 bit } y_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name display_xsize_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_display_xsize_out \
    op interface \
    ports { display_xsize_out_din { O 32 vector } display_xsize_out_full_n { I 1 bit } display_xsize_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name update_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_update_out \
    op interface \
    ports { update_out_din { O 64 vector } update_out_full_n { I 1 bit } update_out_write { O 1 bit } } \
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


