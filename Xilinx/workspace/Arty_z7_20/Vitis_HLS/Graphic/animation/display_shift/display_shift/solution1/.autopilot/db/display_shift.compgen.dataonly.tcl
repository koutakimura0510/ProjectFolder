# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
ddr_copy { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
ddr_update { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 28
	offset_end 39
}
width { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 40
	offset_end 47
}
height { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 48
	offset_end 55
}
xstart { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 56
	offset_end 63
}
xend { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 64
	offset_end 71
}
ystart { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 72
	offset_end 79
}
yend { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 80
	offset_end 87
}
frame_size { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 88
	offset_end 95
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
}
dict set axilite_register_dict control $port_control


