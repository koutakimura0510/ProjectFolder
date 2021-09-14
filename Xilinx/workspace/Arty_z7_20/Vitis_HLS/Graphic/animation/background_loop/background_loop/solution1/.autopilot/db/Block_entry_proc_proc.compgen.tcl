# This script segment is generated automatically by AutoPilot

set id 1
set name background_loop_mul_32ns_32ns_62_2_1
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
    name ycopy_V \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename ycopy_V \
    op interface \
    ports { ycopy_V_address0 { O 10 vector } ycopy_V_ce0 { O 1 bit } ycopy_V_we0 { O 1 bit } ycopy_V_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'ycopy_V'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name copy \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_copy \
    op interface \
    ports { m_axi_copy_AWVALID { O 1 bit } m_axi_copy_AWREADY { I 1 bit } m_axi_copy_AWADDR { O 64 vector } m_axi_copy_AWID { O 1 vector } m_axi_copy_AWLEN { O 32 vector } m_axi_copy_AWSIZE { O 3 vector } m_axi_copy_AWBURST { O 2 vector } m_axi_copy_AWLOCK { O 2 vector } m_axi_copy_AWCACHE { O 4 vector } m_axi_copy_AWPROT { O 3 vector } m_axi_copy_AWQOS { O 4 vector } m_axi_copy_AWREGION { O 4 vector } m_axi_copy_AWUSER { O 1 vector } m_axi_copy_WVALID { O 1 bit } m_axi_copy_WREADY { I 1 bit } m_axi_copy_WDATA { O 32 vector } m_axi_copy_WSTRB { O 4 vector } m_axi_copy_WLAST { O 1 bit } m_axi_copy_WID { O 1 vector } m_axi_copy_WUSER { O 1 vector } m_axi_copy_ARVALID { O 1 bit } m_axi_copy_ARREADY { I 1 bit } m_axi_copy_ARADDR { O 64 vector } m_axi_copy_ARID { O 1 vector } m_axi_copy_ARLEN { O 32 vector } m_axi_copy_ARSIZE { O 3 vector } m_axi_copy_ARBURST { O 2 vector } m_axi_copy_ARLOCK { O 2 vector } m_axi_copy_ARCACHE { O 4 vector } m_axi_copy_ARPROT { O 3 vector } m_axi_copy_ARQOS { O 4 vector } m_axi_copy_ARREGION { O 4 vector } m_axi_copy_ARUSER { O 1 vector } m_axi_copy_RVALID { I 1 bit } m_axi_copy_RREADY { O 1 bit } m_axi_copy_RDATA { I 32 vector } m_axi_copy_RLAST { I 1 bit } m_axi_copy_RID { I 1 vector } m_axi_copy_RUSER { I 1 vector } m_axi_copy_RRESP { I 2 vector } m_axi_copy_BVALID { I 1 bit } m_axi_copy_BREADY { O 1 bit } m_axi_copy_BRESP { I 2 vector } m_axi_copy_BID { I 1 vector } m_axi_copy_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name trunc_ln1345 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_trunc_ln1345 \
    op interface \
    ports { trunc_ln1345 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name frame_size \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_frame_size \
    op interface \
    ports { frame_size { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
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
    id 7 \
    name ddr_copy \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ddr_copy \
    op interface \
    ports { ddr_copy { I 64 vector } } \
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


