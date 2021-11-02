// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xaffine_scale.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XAffine_scale_CfgInitialize(XAffine_scale *InstancePtr, XAffine_scale_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XAffine_scale_Start(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XAffine_scale_IsDone(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XAffine_scale_IsIdle(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XAffine_scale_IsReady(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XAffine_scale_EnableAutoRestart(XAffine_scale *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XAffine_scale_DisableAutoRestart(XAffine_scale *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_AP_CTRL, 0);
}

void XAffine_scale_Set_srcin(XAffine_scale *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_SRCIN_DATA, (u32)(Data));
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_SRCIN_DATA + 4, (u32)(Data >> 32));
}

u64 XAffine_scale_Get_srcin(XAffine_scale *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_SRCIN_DATA);
    Data += (u64)XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_SRCIN_DATA + 4) << 32;
    return Data;
}

void XAffine_scale_Set_dstin(XAffine_scale *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTIN_DATA, (u32)(Data));
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTIN_DATA + 4, (u32)(Data >> 32));
}

u64 XAffine_scale_Get_dstin(XAffine_scale *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTIN_DATA);
    Data += (u64)XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTIN_DATA + 4) << 32;
    return Data;
}

void XAffine_scale_Set_dstout(XAffine_scale *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTOUT_DATA, (u32)(Data));
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XAffine_scale_Get_dstout(XAffine_scale *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTOUT_DATA);
    Data += (u64)XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_DSTOUT_DATA + 4) << 32;
    return Data;
}

void XAffine_scale_Set_mapchip_maxwidth(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXWIDTH_DATA, Data);
}

u32 XAffine_scale_Get_mapchip_maxwidth(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXWIDTH_DATA);
    return Data;
}

void XAffine_scale_Set_mapchip_maxheight(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXHEIGHT_DATA, Data);
}

u32 XAffine_scale_Get_mapchip_maxheight(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_MAXHEIGHT_DATA);
    return Data;
}

void XAffine_scale_Set_mapchip_draw_xsize(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_XSIZE_DATA, Data);
}

u32 XAffine_scale_Get_mapchip_draw_xsize(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_XSIZE_DATA);
    return Data;
}

void XAffine_scale_Set_mapchip_draw_ysize(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_YSIZE_DATA, Data);
}

u32 XAffine_scale_Get_mapchip_draw_ysize(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_MAPCHIP_DRAW_YSIZE_DATA);
    return Data;
}

void XAffine_scale_Set_xstart_pos(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_XSTART_POS_DATA, Data);
}

u32 XAffine_scale_Get_xstart_pos(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_XSTART_POS_DATA);
    return Data;
}

void XAffine_scale_Set_ystart_pos(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_YSTART_POS_DATA, Data);
}

u32 XAffine_scale_Get_ystart_pos(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_YSTART_POS_DATA);
    return Data;
}

void XAffine_scale_Set_frame_size(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_FRAME_SIZE_DATA, Data);
}

u32 XAffine_scale_Get_frame_size(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_FRAME_SIZE_DATA);
    return Data;
}

void XAffine_scale_Set_alpha(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ALPHA_DATA, Data);
}

u32 XAffine_scale_Get_alpha(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ALPHA_DATA);
    return Data;
}

void XAffine_scale_Set_id(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ID_DATA, Data);
}

u32 XAffine_scale_Get_id(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ID_DATA);
    return Data;
}

void XAffine_scale_Set_a(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_A_DATA, Data);
}

u32 XAffine_scale_Get_a(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_A_DATA);
    return Data;
}

void XAffine_scale_Set_b(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_B_DATA, Data);
}

u32 XAffine_scale_Get_b(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_B_DATA);
    return Data;
}

void XAffine_scale_Set_c(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_C_DATA, Data);
}

u32 XAffine_scale_Get_c(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_C_DATA);
    return Data;
}

void XAffine_scale_Set_d(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_D_DATA, Data);
}

u32 XAffine_scale_Get_d(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_D_DATA);
    return Data;
}

void XAffine_scale_Set_m(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_M_DATA, Data);
}

u32 XAffine_scale_Get_m(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_M_DATA);
    return Data;
}

void XAffine_scale_Set_n(XAffine_scale *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_N_DATA, Data);
}

u32 XAffine_scale_Get_n(XAffine_scale *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_N_DATA);
    return Data;
}

void XAffine_scale_InterruptGlobalEnable(XAffine_scale *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_GIE, 1);
}

void XAffine_scale_InterruptGlobalDisable(XAffine_scale *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_GIE, 0);
}

void XAffine_scale_InterruptEnable(XAffine_scale *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_IER);
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_IER, Register | Mask);
}

void XAffine_scale_InterruptDisable(XAffine_scale *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_IER);
    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XAffine_scale_InterruptClear(XAffine_scale *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAffine_scale_WriteReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ISR, Mask);
}

u32 XAffine_scale_InterruptGetEnabled(XAffine_scale *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_IER);
}

u32 XAffine_scale_InterruptGetStatus(XAffine_scale *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAffine_scale_ReadReg(InstancePtr->Control_BaseAddress, XAFFINE_SCALE_CONTROL_ADDR_ISR);
}

