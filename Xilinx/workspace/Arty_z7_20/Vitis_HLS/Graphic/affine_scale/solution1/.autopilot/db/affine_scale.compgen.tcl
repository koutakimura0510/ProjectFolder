# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
set port_control {
srcin { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
dstin { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
dstout { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 40
	offset_end 51
}
mapchip_maxwidth { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 52
	offset_end 59
}
mapchip_maxheight { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 60
	offset_end 67
}
mapchip_draw_xsize { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 68
	offset_end 75
}
mapchip_draw_ysize { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 76
	offset_end 83
}
xstart_pos { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 84
	offset_end 91
}
ystart_pos { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 92
	offset_end 99
}
frame_size { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 100
	offset_end 107
}
alpha { 
	dir I
	width 8
	depth 1
	mode ap_none
	offset 108
	offset_end 115
}
id { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 116
	offset_end 123
}
a { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 124
	offset_end 131
}
b { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 132
	offset_end 139
}
c { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 140
	offset_end 147
}
d { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 148
	offset_end 155
}
m { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 156
	offset_end 163
}
n { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 164
	offset_end 171
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
}
dict set axilite_register_dict control $port_control


# Native S_AXILite:
if {${::AESL::PGuard_simmodel_gen}} {
	if {[info proc ::AESL_LIB_XILADAPTER::s_axilite_gen] == "::AESL_LIB_XILADAPTER::s_axilite_gen"} {
		eval "::AESL_LIB_XILADAPTER::s_axilite_gen { \
			id 165 \
			corename affine_scale_control_axilite \
			name affine_scale_control_s_axi \
			ports {$port_control} \
			op interface \
			is_flushable 0 \ 
			is_datawidth64 0 \ 
		} "
	} else {
		puts "@W \[IMPL-110\] Cannot find AXI Lite interface model in the library. Ignored generation of AXI Lite  interface for 'control'"
	}
}

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler affine_scale_control_s_axi
}

# Native M_AXI:
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::m_axi_gen] == "::AESL_LIB_XILADAPTER::m_axi_gen"} {
eval "::AESL_LIB_XILADAPTER::m_axi_gen { \
    id 166 \
    corename {m_axi} \
    op interface \
    max_latency -1 \ 
    delay_budget 7.3 \ 
    is_flushable 0 \ 
    name {affine_scale_src_m_axi} \
} "
} else {
puts "@W \[IMPL-110\] Cannot find AXI interface model in the library. Ignored generation of AXI interface for 'src'"
}
}

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler affine_scale_src_m_axi
}

# Native M_AXI:
if {${::AESL::PGuard_simmodel_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::m_axi_gen] == "::AESL_LIB_XILADAPTER::m_axi_gen"} {
eval "::AESL_LIB_XILADAPTER::m_axi_gen { \
    id 167 \
    corename {m_axi} \
    op interface \
    max_latency -1 \ 
    delay_budget 7.3 \ 
    is_flushable 0 \ 
    name {affine_scale_dst_m_axi} \
} "
} else {
puts "@W \[IMPL-110\] Cannot find AXI interface model in the library. Ignored generation of AXI interface for 'dst'"
}
}

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler affine_scale_dst_m_axi
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -1 \
    name ${PortName} \
    reset_level 0 \
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
set PortName ap_rst_n
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -2 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_rst_n \
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


