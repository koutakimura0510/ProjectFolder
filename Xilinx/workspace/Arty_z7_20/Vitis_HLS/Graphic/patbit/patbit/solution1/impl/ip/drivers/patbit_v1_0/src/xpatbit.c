// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xpatbit.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XPatbit_CfgInitialize(XPatbit *InstancePtr, XPatbit_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XPatbit_Start(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL) & 0x80;
    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XPatbit_IsDone(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XPatbit_IsIdle(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XPatbit_IsReady(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XPatbit_EnableAutoRestart(XPatbit *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XPatbit_DisableAutoRestart(XPatbit *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_AP_CTRL, 0);
}

void XPatbit_Set_dstout(XPatbit *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_DSTOUT_DATA, (u32)(Data));
    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_DSTOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XPatbit_Get_dstout(XPatbit *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_DSTOUT_DATA);
    Data += (u64)XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_DSTOUT_DATA + 4) << 32;
    return Data;
}

void XPatbit_Set_xpos(XPatbit *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_XPOS_DATA, Data);
}

u32 XPatbit_Get_xpos(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_XPOS_DATA);
    return Data;
}

void XPatbit_Set_ypos(XPatbit *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_YPOS_DATA, Data);
}

u32 XPatbit_Get_ypos(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_YPOS_DATA);
    return Data;
}

void XPatbit_Set_width(XPatbit *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_WIDTH_DATA, Data);
}

u32 XPatbit_Get_width(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_WIDTH_DATA);
    return Data;
}

void XPatbit_Set_height(XPatbit *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_HEIGHT_DATA, Data);
}

u32 XPatbit_Get_height(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_HEIGHT_DATA);
    return Data;
}

void XPatbit_Set_color(XPatbit *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_COLOR_DATA, Data);
}

u32 XPatbit_Get_color(XPatbit *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_COLOR_DATA);
    return Data;
}

void XPatbit_InterruptGlobalEnable(XPatbit *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_GIE, 1);
}

void XPatbit_InterruptGlobalDisable(XPatbit *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_GIE, 0);
}

void XPatbit_InterruptEnable(XPatbit *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_IER);
    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_IER, Register | Mask);
}

void XPatbit_InterruptDisable(XPatbit *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_IER);
    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_IER, Register & (~Mask));
}

void XPatbit_InterruptClear(XPatbit *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPatbit_WriteReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_ISR, Mask);
}

u32 XPatbit_InterruptGetEnabled(XPatbit *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_IER);
}

u32 XPatbit_InterruptGetStatus(XPatbit *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPatbit_ReadReg(InstancePtr->Control_BaseAddress, XPATBIT_CONTROL_ADDR_ISR);
}

