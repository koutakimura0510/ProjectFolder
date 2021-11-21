// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xled_blink.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XLed_blink_CfgInitialize(XLed_blink *InstancePtr, XLed_blink_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XLed_blink_Set_onoff_offset(XLed_blink *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XLed_blink_WriteReg(InstancePtr->Control_BaseAddress, XLED_BLINK_CONTROL_ADDR_ONOFF_OFFSET_DATA, (u32)(Data));
    XLed_blink_WriteReg(InstancePtr->Control_BaseAddress, XLED_BLINK_CONTROL_ADDR_ONOFF_OFFSET_DATA + 4, (u32)(Data >> 32));
}

u64 XLed_blink_Get_onoff_offset(XLed_blink *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XLed_blink_ReadReg(InstancePtr->Control_BaseAddress, XLED_BLINK_CONTROL_ADDR_ONOFF_OFFSET_DATA);
    Data += (u64)XLed_blink_ReadReg(InstancePtr->Control_BaseAddress, XLED_BLINK_CONTROL_ADDR_ONOFF_OFFSET_DATA + 4) << 32;
    return Data;
}

