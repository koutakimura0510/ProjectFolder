# This script segment is generated automatically by AutoPilot

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


