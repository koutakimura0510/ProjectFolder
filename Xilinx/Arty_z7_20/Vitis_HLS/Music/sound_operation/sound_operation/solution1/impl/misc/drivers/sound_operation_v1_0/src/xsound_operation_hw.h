// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of ramadr
//        bit 31~0 - ramadr[31:0] (Read/Write)
// 0x14 : Data signal of ramadr
//        bit 31~0 - ramadr[63:32] (Read/Write)
// 0x18 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XSOUND_OPERATION_CONTROL_ADDR_RAMADR_DATA 0x10
#define XSOUND_OPERATION_CONTROL_BITS_RAMADR_DATA 64

