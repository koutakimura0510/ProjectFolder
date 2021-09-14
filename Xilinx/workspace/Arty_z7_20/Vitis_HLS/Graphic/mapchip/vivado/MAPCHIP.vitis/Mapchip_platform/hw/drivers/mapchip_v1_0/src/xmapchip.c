// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xmapchip.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMapchip_CfgInitialize(XMapchip *InstancePtr, XMapchip_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMapchip_Start(XMapchip *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMapchip_IsDone(XMapchip *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMapchip_IsIdle(XMapchip *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMapchip_IsReady(XMapchip *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMapchip_EnableAutoRestart(XMapchip *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMapchip_DisableAutoRestart(XMapchip *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_AP_CTRL, 0);
}

void XMapchip_Set_srcin(XMapchip *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_SRCIN_DATA, (u32)(Data));
    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_SRCIN_DATA + 4, (u32)(Data >> 32));
}

u64 XMapchip_Get_srcin(XMapchip *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_SRCIN_DATA);
    Data += (u64)XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_SRCIN_DATA + 4) << 32;
    return Data;
}

void XMapchip_Set_dstout(XMapchip *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_DSTOUT_DATA, (u32)(Data));
    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_DSTOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XMapchip_Get_dstout(XMapchip *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_DSTOUT_DATA);
    Data += (u64)XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_DSTOUT_DATA + 4) << 32;
    return Data;
}

void XMapchip_Set_alpha(XMapchip *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_ALPHA_DATA, Data);
}

u32 XMapchip_Get_alpha(XMapchip *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_ALPHA_DATA);
    return Data;
}

void XMapchip_InterruptGlobalEnable(XMapchip *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_GIE, 1);
}

void XMapchip_InterruptGlobalDisable(XMapchip *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_GIE, 0);
}

void XMapchip_InterruptEnable(XMapchip *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_IER);
    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_IER, Register | Mask);
}

void XMapchip_InterruptDisable(XMapchip *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_IER);
    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMapchip_InterruptClear(XMapchip *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMapchip_WriteReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_ISR, Mask);
}

u32 XMapchip_InterruptGetEnabled(XMapchip *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_IER);
}

u32 XMapchip_InterruptGetStatus(XMapchip *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMapchip_ReadReg(InstancePtr->Control_BaseAddress, XMAPCHIP_CONTROL_ADDR_ISR);
}

