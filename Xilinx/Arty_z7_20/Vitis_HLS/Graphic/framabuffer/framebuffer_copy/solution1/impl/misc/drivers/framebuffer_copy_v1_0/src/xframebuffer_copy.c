// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xframebuffer_copy.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XFramebuffer_copy_CfgInitialize(XFramebuffer_copy *InstancePtr, XFramebuffer_copy_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XFramebuffer_copy_Start(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL) & 0x80;
    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XFramebuffer_copy_IsDone(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XFramebuffer_copy_IsIdle(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XFramebuffer_copy_IsReady(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XFramebuffer_copy_EnableAutoRestart(XFramebuffer_copy *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XFramebuffer_copy_DisableAutoRestart(XFramebuffer_copy *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_AP_CTRL, 0);
}

void XFramebuffer_copy_Set_copy(XFramebuffer_copy *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_COPY_DATA, (u32)(Data));
    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_COPY_DATA + 4, (u32)(Data >> 32));
}

u64 XFramebuffer_copy_Get_copy(XFramebuffer_copy *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_COPY_DATA);
    Data += (u64)XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_COPY_DATA + 4) << 32;
    return Data;
}

void XFramebuffer_copy_Set_update(XFramebuffer_copy *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_UPDATE_DATA, (u32)(Data));
    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_UPDATE_DATA + 4, (u32)(Data >> 32));
}

u64 XFramebuffer_copy_Get_update(XFramebuffer_copy *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_UPDATE_DATA);
    Data += (u64)XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_UPDATE_DATA + 4) << 32;
    return Data;
}

void XFramebuffer_copy_Set_width(XFramebuffer_copy *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_WIDTH_DATA, Data);
}

u32 XFramebuffer_copy_Get_width(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_WIDTH_DATA);
    return Data;
}

void XFramebuffer_copy_Set_height(XFramebuffer_copy *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_HEIGHT_DATA, Data);
}

u32 XFramebuffer_copy_Get_height(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_HEIGHT_DATA);
    return Data;
}

void XFramebuffer_copy_Set_display_xsize(XFramebuffer_copy *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_DISPLAY_XSIZE_DATA, Data);
}

u32 XFramebuffer_copy_Get_display_xsize(XFramebuffer_copy *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_DISPLAY_XSIZE_DATA);
    return Data;
}

void XFramebuffer_copy_InterruptGlobalEnable(XFramebuffer_copy *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_GIE, 1);
}

void XFramebuffer_copy_InterruptGlobalDisable(XFramebuffer_copy *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_GIE, 0);
}

void XFramebuffer_copy_InterruptEnable(XFramebuffer_copy *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_IER);
    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_IER, Register | Mask);
}

void XFramebuffer_copy_InterruptDisable(XFramebuffer_copy *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_IER);
    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_IER, Register & (~Mask));
}

void XFramebuffer_copy_InterruptClear(XFramebuffer_copy *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFramebuffer_copy_WriteReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_ISR, Mask);
}

u32 XFramebuffer_copy_InterruptGetEnabled(XFramebuffer_copy *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_IER);
}

u32 XFramebuffer_copy_InterruptGetStatus(XFramebuffer_copy *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFramebuffer_copy_ReadReg(InstancePtr->Control_BaseAddress, XFRAMEBUFFER_COPY_CONTROL_ADDR_ISR);
}

