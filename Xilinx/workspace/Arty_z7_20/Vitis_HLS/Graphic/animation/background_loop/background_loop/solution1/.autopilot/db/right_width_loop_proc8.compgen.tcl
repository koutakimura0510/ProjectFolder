# This script segment is generated automatically by AutoPilot

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
    id 27 \
    name xcopy_V1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename xcopy_V1 \
    op interface \
    ports { xcopy_V1_address0 { O 10 vector } xcopy_V1_ce0 { O 1 bit } xcopy_V1_we0 { O 1 bit } xcopy_V1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'xcopy_V1'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
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
    id 23 \
    name y_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_y_1 \
    op interface \
    ports { y_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
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
    id 25 \
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
    id 26 \
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
    id 28 \
    name ddr_update \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ddr_update \
    op interface \
    ports { ddr_update { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
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
    id 30 \
    name y_1_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_y_1_out \
    op interface \
    ports { y_1_out_din { O 32 vector } y_1_out_full_n { I 1 bit } y_1_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 31 \
    name frame_size_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_frame_size_out \
    op interface \
    ports { frame_size_out_din { O 32 vector } frame_size_out_full_n { I 1 bit } frame_size_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 32 \
    name ddr_update_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_ddr_update_out \
    op interface \
    ports { ddr_update_out_din { O 64 vector } ddr_update_out_full_n { I 1 bit } ddr_update_out_write { O 1 bit } } \
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

