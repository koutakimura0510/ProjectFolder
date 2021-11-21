# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
ap_return { 
	dir o
	width 32
	depth 1
	mode ap_ctrl_hs
	offset 16
	offset_end 0
}
a { 
	dir I
	width 32
	depth 16
	mode ap_memory
	offset 64
	offset_end 127
}
b { 
	dir I
	width 32
	depth 16
	mode ap_memory
	offset 128
	offset_end 191
}
}
dict set axilite_register_dict control $port_control


