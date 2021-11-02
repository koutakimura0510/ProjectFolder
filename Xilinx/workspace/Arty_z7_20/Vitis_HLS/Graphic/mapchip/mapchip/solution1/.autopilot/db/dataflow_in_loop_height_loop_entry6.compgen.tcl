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
    id 1 \
    name mapchip_draw_xsize \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_draw_xsize \
    op interface \
    ports { mapchip_draw_xsize { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 2 \
    name id \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_id \
    op interface \
    ports { id { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name mapchip_maxheight \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxheight \
    op interface \
    ports { mapchip_maxheight { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name ystart_pos \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_ystart_pos \
    op interface \
    ports { ystart_pos { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name mapchip_maxwidth \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxwidth \
    op interface \
    ports { mapchip_maxwidth { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name xstart_pos \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_xstart_pos \
    op interface \
    ports { xstart_pos { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
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
    id 8 \
    name srcin \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_srcin \
    op interface \
    ports { srcin { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
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
    id 10 \
    name dstin \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dstin \
    op interface \
    ports { dstin { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name dstout \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_dstout \
    op interface \
    ports { dstout { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name crip \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_crip \
    op interface \
    ports { crip { I 24 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name alpha \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_alpha \
    op interface \
    ports { alpha { I 8 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name mapchip_draw_xsize_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_draw_xsize_out \
    op interface \
    ports { mapchip_draw_xsize_out_din { O 32 vector } mapchip_draw_xsize_out_full_n { I 1 bit } mapchip_draw_xsize_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name mapchip_draw_xsize_out1 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_draw_xsize_out1 \
    op interface \
    ports { mapchip_draw_xsize_out1_din { O 32 vector } mapchip_draw_xsize_out1_full_n { I 1 bit } mapchip_draw_xsize_out1_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name id_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_id_out \
    op interface \
    ports { id_out_din { O 32 vector } id_out_full_n { I 1 bit } id_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name mapchip_maxheight_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxheight_out \
    op interface \
    ports { mapchip_maxheight_out_din { O 32 vector } mapchip_maxheight_out_full_n { I 1 bit } mapchip_maxheight_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name ystart_pos_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_ystart_pos_out \
    op interface \
    ports { ystart_pos_out_din { O 32 vector } ystart_pos_out_full_n { I 1 bit } ystart_pos_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name mapchip_maxwidth_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mapchip_maxwidth_out \
    op interface \
    ports { mapchip_maxwidth_out_din { O 32 vector } mapchip_maxwidth_out_full_n { I 1 bit } mapchip_maxwidth_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name xstart_pos_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_xstart_pos_out \
    op interface \
    ports { xstart_pos_out_din { O 32 vector } xstart_pos_out_full_n { I 1 bit } xstart_pos_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
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
    id 22 \
    name y_out2 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_y_out2 \
    op interface \
    ports { y_out2_din { O 32 vector } y_out2_full_n { I 1 bit } y_out2_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 23 \
    name srcin_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_srcin_out \
    op interface \
    ports { srcin_out_din { O 64 vector } srcin_out_full_n { I 1 bit } srcin_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 24 \
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
    id 25 \
    name frame_size_out3 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_frame_size_out3 \
    op interface \
    ports { frame_size_out3_din { O 32 vector } frame_size_out3_full_n { I 1 bit } frame_size_out3_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 26 \
    name dstin_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dstin_out \
    op interface \
    ports { dstin_out_din { O 64 vector } dstin_out_full_n { I 1 bit } dstin_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 27 \
    name dstout_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_dstout_out \
    op interface \
    ports { dstout_out_din { O 64 vector } dstout_out_full_n { I 1 bit } dstout_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name crip_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_crip_out \
    op interface \
    ports { crip_out_din { O 24 vector } crip_out_full_n { I 1 bit } crip_out_write { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name alpha_out \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_alpha_out \
    op interface \
    ports { alpha_out_din { O 8 vector } alpha_out_full_n { I 1 bit } alpha_out_write { O 1 bit } } \
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


