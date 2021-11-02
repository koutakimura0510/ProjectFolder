// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xmapchip_png.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMapchip_png_CfgInitialize(XMapchip_png *InstancePtr, XMapchip_png_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMapchip_png_Start(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMapchip_png_IsDone(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMapchip_png_IsIdle(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMapchip_png_IsReady(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMapchip_png_EnableAutoRestart(XMapchip_png *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMapchip_png_DisableAutoRestart(XMapchip_png *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_AP_CTRL, 0);
}

void XMapchip_png_Set_srcin(XMapchip_png *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_SRCIN_DATA, (u32)(Data));
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_SRCIN_DATA + 4, (u32)(Data >> 32));
}

u64 XMapchip_png_Get_srcin(XMapchip_png *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_SRCIN_DATA);
    Data += (u64)XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_SRCIN_DATA + 4) << 32;
    return Data;
}

void XMapchip_png_Set_dstin(XMapchip_png *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTIN_DATA, (u32)(Data));
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTIN_DATA + 4, (u32)(Data >> 32));
}

u64 XMapchip_png_Get_dstin(XMapchip_png *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTIN_DATA);
    Data += (u64)XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTIN_DATA + 4) << 32;
    return Data;
}

void XMapchip_png_Set_dstout(XMapchip_png *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTOUT_DATA, (u32)(Data));
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XMapchip_png_Get_dstout(XMapchip_png *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTOUT_DATA);
    Data += (u64)XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_DSTOUT_DATA + 4) << 32;
    return Data;
}

void XMapchip_png_Set_mapchip_maxwidth(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_MAXWIDTH_DATA, Data);
}

u32 XMapchip_png_Get_mapchip_maxwidth(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_MAXWIDTH_DATA);
    return Data;
}

void XMapchip_png_Set_mapchip_maxheight(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_MAXHEIGHT_DATA, Data);
}

u32 XMapchip_png_Get_mapchip_maxheight(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_MAXHEIGHT_DATA);
    return Data;
}

void XMapchip_png_Set_mapchip_draw_xsize(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_DRAW_XSIZE_DATA, Data);
}

u32 XMapchip_png_Get_mapchip_draw_xsize(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_DRAW_XSIZE_DATA);
    return Data;
}

void XMapchip_png_Set_mapchip_draw_ysize(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_DRAW_YSIZE_DATA, Data);
}

u32 XMapchip_png_Get_mapchip_draw_ysize(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_MAPCHIP_DRAW_YSIZE_DATA);
    return Data;
}

void XMapchip_png_Set_xstart_pos(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_XSTART_POS_DATA, Data);
}

u32 XMapchip_png_Get_xstart_pos(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_XSTART_POS_DATA);
    return Data;
}

void XMapchip_png_Set_ystart_pos(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_YSTART_POS_DATA, Data);
}

u32 XMapchip_png_Get_ystart_pos(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_YSTART_POS_DATA);
    return Data;
}

void XMapchip_png_Set_frame_size(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_FRAME_SIZE_DATA, Data);
}

u32 XMapchip_png_Get_frame_size(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_FRAME_SIZE_DATA);
    return Data;
}

void XMapchip_png_Set_alpha(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ALPHA_DATA, Data);
}

u32 XMapchip_png_Get_alpha(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ALPHA_DATA);
    return Data;
}

void XMapchip_png_Set_id(XMapchip_png *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ID_DATA, Data);
}

u32 XMapchip_png_Get_id(XMapchip_png *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ID_DATA);
    return Data;
}

void XMapchip_png_InterruptGlobalEnable(XMapchip_png *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_GIE, 1);
}

void XMapchip_png_InterruptGlobalDisable(XMapchip_png *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_GIE, 0);
}

void XMapchip_png_InterruptEnable(XMapchip_png *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_IER);
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_IER, Register | Mask);
}

void XMapchip_png_InterruptDisable(XMapchip_png *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_IER);
    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMapchip_png_InterruptClear(XMapchip_png *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_png_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ISR, Mask);
}

u32 XMapchip_png_InterruptGetEnabled(XMapchip_png *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_IER);
}

u32 XMapchip_png_InterruptGetStatus(XMapchip_png *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMapchip_png_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_PNG_CONTROL_ADDR_ISR);
}

