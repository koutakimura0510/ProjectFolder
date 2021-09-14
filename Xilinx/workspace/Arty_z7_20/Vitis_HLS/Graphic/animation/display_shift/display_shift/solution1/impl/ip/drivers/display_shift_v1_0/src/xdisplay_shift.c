// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xdisplay_shift.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XDisplay_shift_CfgInitialize(XDisplay_shift *InstancePtr, XDisplay_shift_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XDisplay_shift_Start(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL) & 0x80;
    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XDisplay_shift_IsDone(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XDisplay_shift_IsIdle(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XDisplay_shift_IsReady(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XDisplay_shift_EnableAutoRestart(XDisplay_shift *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XDisplay_shift_DisableAutoRestart(XDisplay_shift *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_AP_CTRL, 0);
}

void XDisplay_shift_Set_ddr_copy(XDisplay_shift *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_COPY_DATA, (u32)(Data));
    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_COPY_DATA + 4, (u32)(Data >> 32));
}

u64 XDisplay_shift_Get_ddr_copy(XDisplay_shift *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_COPY_DATA);
    Data += (u64)XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_COPY_DATA + 4) << 32;
    return Data;
}

void XDisplay_shift_Set_ddr_update(XDisplay_shift *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_UPDATE_DATA, (u32)(Data));
    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_UPDATE_DATA + 4, (u32)(Data >> 32));
}

u64 XDisplay_shift_Get_ddr_update(XDisplay_shift *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_UPDATE_DATA);
    Data += (u64)XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_DDR_UPDATE_DATA + 4) << 32;
    return Data;
}

void XDisplay_shift_Set_width(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_WIDTH_DATA, Data);
}

u32 XDisplay_shift_Get_width(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_WIDTH_DATA);
    return Data;
}

void XDisplay_shift_Set_height(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_HEIGHT_DATA, Data);
}

u32 XDisplay_shift_Get_height(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_HEIGHT_DATA);
    return Data;
}

void XDisplay_shift_Set_xstart(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_XSTART_DATA, Data);
}

u32 XDisplay_shift_Get_xstart(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_XSTART_DATA);
    return Data;
}

void XDisplay_shift_Set_xend(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_XEND_DATA, Data);
}

u32 XDisplay_shift_Get_xend(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_XEND_DATA);
    return Data;
}

void XDisplay_shift_Set_ystart(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_YSTART_DATA, Data);
}

u32 XDisplay_shift_Get_ystart(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_YSTART_DATA);
    return Data;
}

void XDisplay_shift_Set_yend(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_YEND_DATA, Data);
}

u32 XDisplay_shift_Get_yend(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_YEND_DATA);
    return Data;
}

void XDisplay_shift_Set_frame_size(XDisplay_shift *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_FRAME_SIZE_DATA, Data);
}

u32 XDisplay_shift_Get_frame_size(XDisplay_shift *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_FRAME_SIZE_DATA);
    return Data;
}

void XDisplay_shift_InterruptGlobalEnable(XDisplay_shift *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_GIE, 1);
}

void XDisplay_shift_InterruptGlobalDisable(XDisplay_shift *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_GIE, 0);
}

void XDisplay_shift_InterruptEnable(XDisplay_shift *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_IER);
    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_IER, Register | Mask);
}

void XDisplay_shift_InterruptDisable(XDisplay_shift *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_IER);
    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_IER, Register & (~Mask));
}

void XDisplay_shift_InterruptClear(XDisplay_shift *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XDisplay_shift_WriteReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_ISR, Mask);
}

u32 XDisplay_shift_InterruptGetEnabled(XDisplay_shift *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_IER);
}

u32 XDisplay_shift_InterruptGetStatus(XDisplay_shift *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XDisplay_shift_ReadReg(InstancePtr->Control_BaseAddress, XDISPLAY_SHIFT_CONTROL_ADDR_ISR);
}

