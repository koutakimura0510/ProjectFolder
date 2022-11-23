// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xbackground_loop.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XBackground_loop_CfgInitialize(XBackground_loop *InstancePtr, XBackground_loop_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XBackground_loop_Start(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL) & 0x80;
    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XBackground_loop_IsDone(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XBackground_loop_IsIdle(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XBackground_loop_IsReady(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XBackground_loop_EnableAutoRestart(XBackground_loop *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XBackground_loop_DisableAutoRestart(XBackground_loop *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_AP_CTRL, 0);
}

void XBackground_loop_Set_ddr_copy(XBackground_loop *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_COPY_DATA, (u32)(Data));
    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_COPY_DATA + 4, (u32)(Data >> 32));
}

u64 XBackground_loop_Get_ddr_copy(XBackground_loop *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_COPY_DATA);
    Data += (u64)XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_COPY_DATA + 4) << 32;
    return Data;
}

void XBackground_loop_Set_ddr_update(XBackground_loop *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_UPDATE_DATA, (u32)(Data));
    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_UPDATE_DATA + 4, (u32)(Data >> 32));
}

u64 XBackground_loop_Get_ddr_update(XBackground_loop *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_UPDATE_DATA);
    Data += (u64)XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DDR_UPDATE_DATA + 4) << 32;
    return Data;
}

void XBackground_loop_Set_width(XBackground_loop *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_WIDTH_DATA, Data);
}

u32 XBackground_loop_Get_width(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_WIDTH_DATA);
    return Data;
}

void XBackground_loop_Set_height(XBackground_loop *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_HEIGHT_DATA, Data);
}

u32 XBackground_loop_Get_height(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_HEIGHT_DATA);
    return Data;
}

void XBackground_loop_Set_frame_size(XBackground_loop *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_FRAME_SIZE_DATA, Data);
}

u32 XBackground_loop_Get_frame_size(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_FRAME_SIZE_DATA);
    return Data;
}

void XBackground_loop_Set_direction(XBackground_loop *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DIRECTION_DATA, Data);
}

u32 XBackground_loop_Get_direction(XBackground_loop *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_DIRECTION_DATA);
    return Data;
}

void XBackground_loop_InterruptGlobalEnable(XBackground_loop *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_GIE, 1);
}

void XBackground_loop_InterruptGlobalDisable(XBackground_loop *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_GIE, 0);
}

void XBackground_loop_InterruptEnable(XBackground_loop *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_IER);
    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_IER, Register | Mask);
}

void XBackground_loop_InterruptDisable(XBackground_loop *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_IER);
    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_IER, Register & (~Mask));
}

void XBackground_loop_InterruptClear(XBackground_loop *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBackground_loop_WriteReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_ISR, Mask);
}

u32 XBackground_loop_InterruptGetEnabled(XBackground_loop *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_IER);
}

u32 XBackground_loop_InterruptGetStatus(XBackground_loop *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XBackground_loop_ReadReg(InstancePtr->Control_BaseAddress, XBACKGROUND_LOOP_CONTROL_ADDR_ISR);
}

