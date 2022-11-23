// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xframebuffer_copy.h"

extern XFramebuffer_copy_Config XFramebuffer_copy_ConfigTable[];

XFramebuffer_copy_Config *XFramebuffer_copy_LookupConfig(u16 DeviceId) {
	XFramebuffer_copy_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFRAMEBUFFER_COPY_NUM_INSTANCES; Index++) {
		if (XFramebuffer_copy_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFramebuffer_copy_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFramebuffer_copy_Initialize(XFramebuffer_copy *InstancePtr, u16 DeviceId) {
	XFramebuffer_copy_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFramebuffer_copy_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFramebuffer_copy_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

