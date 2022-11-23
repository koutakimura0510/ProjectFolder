// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xmapchip.h"

extern XMapchip_Config XMapchip_ConfigTable[];

XMapchip_Config *XMapchip_LookupConfig(u16 DeviceId) {
	XMapchip_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMAPCHIP_NUM_INSTANCES; Index++) {
		if (XMapchip_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMapchip_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMapchip_Initialize(XMapchip *InstancePtr, u16 DeviceId) {
	XMapchip_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMapchip_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMapchip_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

