# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name ram \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ram \
    op interface \
    ports { m_axi_ram_AWVALID { O 1 bit } m_axi_ram_AWREADY { I 1 bit } m_axi_ram_AWADDR { O 64 vector } m_axi_ram_AWID { O 1 vector } m_axi_ram_AWLEN { O 32 vector } m_axi_ram_AWSIZE { O 3 vector } m_axi_ram_AWBURST { O 2 vector } m_axi_ram_AWLOCK { O 2 vector } m_axi_ram_AWCACHE { O 4 vector } m_axi_ram_AWPROT { O 3 vector } m_axi_ram_AWQOS { O 4 vector } m_axi_ram_AWREGION { O 4 vector } m_axi_ram_AWUSER { O 1 vector } m_axi_ram_WVALID { O 1 bit } m_axi_ram_WREADY { I 1 bit } m_axi_ram_WDATA { O 32 vector } m_axi_ram_WSTRB { O 4 vector } m_axi_ram_WLAST { O 1 bit } m_axi_ram_WID { O 1 vector } m_axi_ram_WUSER { O 1 vector } m_axi_ram_ARVALID { O 1 bit } m_axi_ram_ARREADY { I 1 bit } m_axi_ram_ARADDR { O 64 vector } m_axi_ram_ARID { O 1 vector } m_axi_ram_ARLEN { O 32 vector } m_axi_ram_ARSIZE { O 3 vector } m_axi_ram_ARBURST { O 2 vector } m_axi_ram_ARLOCK { O 2 vector } m_axi_ram_ARCACHE { O 4 vector } m_axi_ram_ARPROT { O 3 vector } m_axi_ram_ARQOS { O 4 vector } m_axi_ram_ARREGION { O 4 vector } m_axi_ram_ARUSER { O 1 vector } m_axi_ram_RVALID { I 1 bit } m_axi_ram_RREADY { O 1 bit } m_axi_ram_RDATA { I 32 vector } m_axi_ram_RLAST { I 1 bit } m_axi_ram_RID { I 1 vector } m_axi_ram_RUSER { I 1 vector } m_axi_ram_RRESP { I 2 vector } m_axi_ram_BVALID { I 1 bit } m_axi_ram_BREADY { O 1 bit } m_axi_ram_BRESP { I 2 vector } m_axi_ram_BID { I 1 vector } m_axi_ram_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name ramadr \
    type fifo \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ramadr \
    op interface \
    ports { ramadr_dout { I 64 vector } ramadr_empty_n { I 1 bit } ramadr_read { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name sdata \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_sdata \
    op interface \
    ports { sdata { O 32 vector } sdata_ap_vld { O 1 bit } } \
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


