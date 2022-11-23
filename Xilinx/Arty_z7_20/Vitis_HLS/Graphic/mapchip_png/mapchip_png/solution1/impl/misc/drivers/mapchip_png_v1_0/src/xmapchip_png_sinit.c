// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xmapchip_png.h"

extern XMapchip_png_Config XMapchip_png_ConfigTable[];

XMapchip_png_Config *XMapchip_png_LookupConfig(u16 DeviceId) {
	XMapchip_png_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMAPCHIP_PNG_NUM_INSTANCES; Index++) {
		if (XMapchip_png_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMapchip_png_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMapchip_png_Initialize(XMapchip_png *InstancePtr, u16 DeviceId) {
	XMapchip_png_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMapchip_png_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMapchip_png_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

