// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xmapchip_color.h"

extern XMapchip_color_Config XMapchip_color_ConfigTable[];

XMapchip_color_Config *XMapchip_color_LookupConfig(u16 DeviceId) {
	XMapchip_color_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMAPCHIP_COLOR_NUM_INSTANCES; Index++) {
		if (XMapchip_color_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMapchip_color_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMapchip_color_Initialize(XMapchip_color *InstancePtr, u16 DeviceId) {
	XMapchip_color_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMapchip_color_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMapchip_color_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

