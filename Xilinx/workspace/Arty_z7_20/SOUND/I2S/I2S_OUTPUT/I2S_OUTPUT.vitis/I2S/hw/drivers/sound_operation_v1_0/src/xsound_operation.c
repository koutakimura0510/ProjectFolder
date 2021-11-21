// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xsound_operation.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XSound_operation_CfgInitialize(XSound_operation *InstancePtr, XSound_operation_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XSound_operation_Set_ramadr(XSound_operation *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSound_operation_WriteReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_RAMADR_DATA, (u32)(Data));
    XSound_operation_WriteReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_RAMADR_DATA + 4, (u32)(Data >> 32));
}

u64 XSound_operation_Get_ramadr(XSound_operation *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSound_operation_ReadReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_RAMADR_DATA);
    Data += (u64)XSound_operation_ReadReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_RAMADR_DATA + 4) << 32;
    return Data;
}

void XSound_operation_Set_status(XSound_operation *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSound_operation_WriteReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_STATUS_DATA, Data);
}

u32 XSound_operation_Get_status(XSound_operation *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSound_operation_ReadReg(InstancePtr->Control_BaseAddress, XSOUND_OPERATION_CONTROL_ADDR_STATUS_DATA);
    return Data;
}

