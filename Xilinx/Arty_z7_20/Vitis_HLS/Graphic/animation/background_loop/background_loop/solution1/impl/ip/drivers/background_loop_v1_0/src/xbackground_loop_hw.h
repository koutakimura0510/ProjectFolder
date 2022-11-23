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
// 0x10 : Data signal of ddr_copy
//        bit 31~0 - ddr_copy[31:0] (Read/Write)
// 0x14 : Data signal of ddr_copy
//        bit 31~0 - ddr_copy[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of ddr_update
//        bit 31~0 - ddr_update[31:0] (Read/Write)
// 0x20 : Data signal of ddr_update
//        bit 31~0 - ddr_update[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of width
//        bit 31~0 - width[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of height
//        bit 31~0 - height[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of frame_size
//        bit 31~0 - frame_size[31:0] (Read/Write)
// 0x3c : reserved
// 0x40 : Data signal of direction
//        bit 31~0 - direction[31:0] (Read/Write)
// 0x44 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL         0x00
#define XBACKGROUND_LOOP_CONTROL_ADDR_GIE             0x04
#define XBACKGROUND_LOOP_CONTROL_ADDR_IER             0x08
#define XBACKGROUND_LOOP_CONTROL_ADDR_ISR             0x0c
#define XBACKGROUND_LOOP_CONTROL_ADDR_DDR_COPY_DATA   0x10
#define XBACKGROUND_LOOP_CONTROL_BITS_DDR_COPY_DATA   64
#define XBACKGROUND_LOOP_CONTROL_ADDR_DDR_UPDATE_DATA 0x1c
#define XBACKGROUND_LOOP_CONTROL_BITS_DDR_UPDATE_DATA 64
#define XBACKGROUND_LOOP_CONTROL_ADDR_WIDTH_DATA      0x28
#define XBACKGROUND_LOOP_CONTROL_BITS_WIDTH_DATA      32
#define XBACKGROUND_LOOP_CONTROL_ADDR_HEIGHT_DATA     0x30
#define XBACKGROUND_LOOP_CONTROL_BITS_HEIGHT_DATA     32
#define XBACKGROUND_LOOP_CONTROL_ADDR_FRAME_SIZE_DATA 0x38
#define XBACKGROUND_LOOP_CONTROL_BITS_FRAME_SIZE_DATA 32
#define XBACKGROUND_LOOP_CONTROL_ADDR_DIRECTION_DATA  0x40
#define XBACKGROUND_LOOP_CONTROL_BITS_DIRECTION_DATA  32

