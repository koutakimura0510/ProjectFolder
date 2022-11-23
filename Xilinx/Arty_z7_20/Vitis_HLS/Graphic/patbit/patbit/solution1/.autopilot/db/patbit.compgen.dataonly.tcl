# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
dstout { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 16
	offset_end 27
}
xpos { 
	dir I
	width 11
	depth 1
	mode ap_none
	offset 28
	offset_end 35
}
ypos { 
	dir I
	width 11
	depth 1
	mode ap_none
	offset 36
	offset_end 43
}
width { 
	dir I
	width 11
	depth 1
	mode ap_none
	offset 44
	offset_end 51
}
height { 
	dir I
	width 11
	depth 1
	mode ap_none
	offset 52
	offset_end 59
}
color { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 60
	offset_end 67
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
}
dict set axilite_register_dict control $port_control


