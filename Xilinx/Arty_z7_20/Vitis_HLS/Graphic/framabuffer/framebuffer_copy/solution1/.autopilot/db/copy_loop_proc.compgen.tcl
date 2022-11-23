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
    id 18 \
    name src_V1 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename src_V1 \
    op interface \
    ports { src_V1_address0 { O 10 vector } src_V1_ce0 { O 1 bit } src_V1_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'src_V1'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name width \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_width \
    op interface \
    ports { width_dout { I 32 vector } width_empty_n { I 1 bit } width_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name y \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_y \
    op interface \
    ports { y_dout { I 32 vector } y_empty_n { I 1 bit } y_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name display_xsize \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_display_xsize \
    op interface \
    ports { display_xsize_dout { I 32 vector } display_xsize_empty_n { I 1 bit } display_xsize_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name update \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_update \
    op interface \
    ports { update_dout { I 64 vector } update_empty_n { I 1 bit } update_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name up \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_up \
    op interface \
    ports { m_axi_up_AWVALID { O 1 bit } m_axi_up_AWREADY { I 1 bit } m_axi_up_AWADDR { O 64 vector } m_axi_up_AWID { O 1 vector } m_axi_up_AWLEN { O 32 vector } m_axi_up_AWSIZE { O 3 vector } m_axi_up_AWBURST { O 2 vector } m_axi_up_AWLOCK { O 2 vector } m_axi_up_AWCACHE { O 4 vector } m_axi_up_AWPROT { O 3 vector } m_axi_up_AWQOS { O 4 vector } m_axi_up_AWREGION { O 4 vector } m_axi_up_AWUSER { O 1 vector } m_axi_up_WVALID { O 1 bit } m_axi_up_WREADY { I 1 bit } m_axi_up_WDATA { O 32 vector } m_axi_up_WSTRB { O 4 vector } m_axi_up_WLAST { O 1 bit } m_axi_up_WID { O 1 vector } m_axi_up_WUSER { O 1 vector } m_axi_up_ARVALID { O 1 bit } m_axi_up_ARREADY { I 1 bit } m_axi_up_ARADDR { O 64 vector } m_axi_up_ARID { O 1 vector } m_axi_up_ARLEN { O 32 vector } m_axi_up_ARSIZE { O 3 vector } m_axi_up_ARBURST { O 2 vector } m_axi_up_ARLOCK { O 2 vector } m_axi_up_ARCACHE { O 4 vector } m_axi_up_ARPROT { O 3 vector } m_axi_up_ARQOS { O 4 vector } m_axi_up_ARREGION { O 4 vector } m_axi_up_ARUSER { O 1 vector } m_axi_up_RVALID { I 1 bit } m_axi_up_RREADY { O 1 bit } m_axi_up_RDATA { I 32 vector } m_axi_up_RLAST { I 1 bit } m_axi_up_RID { I 1 vector } m_axi_up_RUSER { I 1 vector } m_axi_up_RRESP { I 2 vector } m_axi_up_BVALID { I 1 bit } m_axi_up_BREADY { O 1 bit } m_axi_up_BRESP { I 2 vector } m_axi_up_BID { I 1 vector } m_axi_up_BUSER { I 1 vector } } \
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


