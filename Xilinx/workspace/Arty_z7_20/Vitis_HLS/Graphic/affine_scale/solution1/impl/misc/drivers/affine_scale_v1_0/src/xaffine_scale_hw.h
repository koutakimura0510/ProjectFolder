// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x10 : Data signal of srcin
//        bit 31~0 - srcin[31:0] (Read/Write)
// 0x14 : Data signal of srcin
//        bit 31~0 - srcin[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of dstin
//        bit 31~0 - dstin[31:0] (Read/Write)
// 0x20 : Data signal of dstin
//        bit 31~0 - dstin[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of dstout
//        bit 31~0 - dstout[31:0] (Read/Write)
// 0x2c : Data signal of dstout
//        bit 31~0 - dstout[63:32] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of mapchip_maxwidth
//        bit 31~0 - mapchip_maxwidth[31:0] (Read/Write)
// 0x38 : reserved
// 0x3c : Data signal of mapchip_maxheight
//        bit 31~0 - mapchip_maxheight[31:0] (Read/Write)
// 0x40 : reserved
// 0x44 : Data signal of mapchip_draw_xsize
//        bit 31~0 - mapchip_draw_xsize[31:0] (Read/Write)
// 0x48 : reserved
// 0x4c : Data signal of mapchip_draw_ysize
//        bit 31~0 - mapchip_draw_ysize[31:0] (Read/Write)
// 0x50 : reserved
// 0x54 : Data signal of xstart_pos
//        bit 31~0 - xstart_pos[31:0] (Read/Write)
// 0x58 : reserved
// 0x5c : Data signal of ystart_pos
//        bit 31~0 - ystart_pos[31:0] (Read/Write)
// 0x60 : reserved
// 0x64 : Data signal of frame_size
//        bit 31~0 - frame_size[31:0] (Read/Write)
// 0x68 : reserved
// 0x6c : Data signal of alpha
//        bit 7~0 - alpha[7:0] (Read/Write)
//        others  - reserved
// 0x70 : reserved
// 0x74 : Data signal of id
//        bit 31~0 - id[31:0] (Read/Write)
// 0x78 : reserved
// 0x7c : Data signal of a
//        bit 31~0 - a[31:0] (Read/Write)
// 0x80 : reserved
// 0x84 : Data signal of b
//        bit 31~0 - b[31:0] (Read/Write)
// 0x88 : reserved
// 0x8c : Data signal of c
//        bit 31~0 - c[31:0] (Read/Write)
// 0x90 : reserved
// 0x94 : Data signal of d
//        bit 31~0 - d[31:0] (Read/Write)
// 0x98 : reserved
// 0x9c : Data signal of m
//        bit 31~0 - m[31:0] (Read/Write)
// 0xa0 : reserved
// 0xa4 : Data signal of n
//        bit 31~0 - n[31:0] (Read/Write)
// 0xa8 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL                 0x00
#define XAFFINE_SCALE_CONTROL_ADDR_GIE                     0x04
#define XAFFINE_SCALE_CONTROL_ADDR_IER                     0x08
#define XAFFINE_SCALE_CONTROL_ADDR_ISR                     0x0c
#define XAFFINE_SCALE_CONTROL_ADDR_SRCIN_DATA              0x10
#define XAFFINE_SCALE_CONTROL_BITS_SRCIN_DATA              64
#define XAFFINE_SCALE_CONTROL_ADDR_DSTIN_DATA              0x1c
#define XAFFINE_SCALE_CONTROL_BITS_DSTIN_DATA              64
#define XAFFINE_SCALE_CONTROL_ADDR_DSTOUT_DATA             0x28
#define XAFFINE_SCALE_CONTROL_BITS_DSTOUT_DATA             64
#define XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXWIDTH_DATA   0x34
#define XAFFINE_SCALE_CONTROL_BITS_MAPCHIP_MAXWIDTH_DATA   32
#define XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXHEIGHT_DATA  0x3c
#define XAFFINE_SCALE_CONTROL_BITS_MAPCHIP_MAXHEIGHT_DATA  32
#define XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_XSIZE_DATA 0x44
#define XAFFINE_SCALE_CONTROL_BITS_MAPCHIP_DRAW_XSIZE_DATA 32
#define XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_YSIZE_DATA 0x4c
#define XAFFINE_SCALE_CONTROL_BITS_MAPCHIP_DRAW_YSIZE_DATA 32
#define XAFFINE_SCALE_CONTROL_ADDR_XSTART_POS_DATA         0x54
#define XAFFINE_SCALE_CONTROL_BITS_XSTART_POS_DATA         32
#define XAFFINE_SCALE_CONTROL_ADDR_YSTART_POS_DATA         0x5c
#define XAFFINE_SCALE_CONTROL_BITS_YSTART_POS_DATA         32
#define XAFFINE_SCALE_CONTROL_ADDR_FRAME_SIZE_DATA         0x64
#define XAFFINE_SCALE_CONTROL_BITS_FRAME_SIZE_DATA         32
#define XAFFINE_SCALE_CONTROL_ADDR_ALPHA_DATA              0x6c
#define XAFFINE_SCALE_CONTROL_BITS_ALPHA_DATA              8
#define XAFFINE_SCALE_CONTROL_ADDR_ID_DATA                 0x74
#define XAFFINE_SCALE_CONTROL_BITS_ID_DATA                 32
#define XAFFINE_SCALE_CONTROL_ADDR_A_DATA                  0x7c
#define XAFFINE_SCALE_CONTROL_BITS_A_DATA                  32
#define XAFFINE_SCALE_CONTROL_ADDR_B_DATA                  0x84
#define XAFFINE_SCALE_CONTROL_BITS_B_DATA                  32
#define XAFFINE_SCALE_CONTROL_ADDR_C_DATA                  0x8c
#define XAFFINE_SCALE_CONTROL_BITS_C_DATA                  32
#define XAFFINE_SCALE_CONTROL_ADDR_D_DATA                  0x94
#define XAFFINE_SCALE_CONTROL_BITS_D_DATA                  32
#define XAFFINE_SCALE_CONTROL_ADDR_M_DATA                  0x9c
#define XAFFINE_SCALE_CONTROL_BITS_M_DATA                  32
#define XAFFINE_SCALE_CONTROL_ADDR_N_DATA                  0xa4
#define XAFFINE_SCALE_CONTROL_BITS_N_DATA                  32

