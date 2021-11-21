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
// 0x10 : Data signal of ap_return
//        bit 31~0 - ap_return[31:0] (Read)
// 0x40 ~
// 0x7f : Memory 'a' (16 * 32b)
//        Word n : bit [31:0] - a[n]
// 0x80 ~
// 0xbf : Memory 'b' (16 * 32b)
//        Word n : bit [31:0] - b[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XMULADD_CONTROL_ADDR_AP_CTRL   0x00
#define XMULADD_CONTROL_ADDR_GIE       0x04
#define XMULADD_CONTROL_ADDR_IER       0x08
#define XMULADD_CONTROL_ADDR_ISR       0x0c
#define XMULADD_CONTROL_ADDR_AP_RETURN 0x10
#define XMULADD_CONTROL_BITS_AP_RETURN 32
#define XMULADD_CONTROL_ADDR_A_BASE    0x40
#define XMULADD_CONTROL_ADDR_A_HIGH    0x7f
#define XMULADD_CONTROL_WIDTH_A        32
#define XMULADD_CONTROL_DEPTH_A        16
#define XMULADD_CONTROL_ADDR_B_BASE    0x80
#define XMULADD_CONTROL_ADDR_B_HIGH    0xbf
#define XMULADD_CONTROL_WIDTH_B        32
#define XMULADD_CONTROL_DEPTH_B        16

