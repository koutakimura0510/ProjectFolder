// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XDISPLAY_SHIFT_H
#define XDISPLAY_SHIFT_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xdisplay_shift_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XDisplay_shift_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XDisplay_shift;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XDisplay_shift_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XDisplay_shift_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XDisplay_shift_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XDisplay_shift_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XDisplay_shift_Initialize(XDisplay_shift *InstancePtr, u16 DeviceId);
XDisplay_shift_Config* XDisplay_shift_LookupConfig(u16 DeviceId);
int XDisplay_shift_CfgInitialize(XDisplay_shift *InstancePtr, XDisplay_shift_Config *ConfigPtr);
#else
int XDisplay_shift_Initialize(XDisplay_shift *InstancePtr, const char* InstanceName);
int XDisplay_shift_Release(XDisplay_shift *InstancePtr);
#endif

void XDisplay_shift_Start(XDisplay_shift *InstancePtr);
u32 XDisplay_shift_IsDone(XDisplay_shift *InstancePtr);
u32 XDisplay_shift_IsIdle(XDisplay_shift *InstancePtr);
u32 XDisplay_shift_IsReady(XDisplay_shift *InstancePtr);
void XDisplay_shift_EnableAutoRestart(XDisplay_shift *InstancePtr);
void XDisplay_shift_DisableAutoRestart(XDisplay_shift *InstancePtr);

void XDisplay_shift_Set_ddr_copy(XDisplay_shift *InstancePtr, u64 Data);
u64 XDisplay_shift_Get_ddr_copy(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_ddr_update(XDisplay_shift *InstancePtr, u64 Data);
u64 XDisplay_shift_Get_ddr_update(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_width(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_width(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_height(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_height(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_xstart(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_xstart(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_xend(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_xend(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_ystart(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_ystart(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_yend(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_yend(XDisplay_shift *InstancePtr);
void XDisplay_shift_Set_frame_size(XDisplay_shift *InstancePtr, u32 Data);
u32 XDisplay_shift_Get_frame_size(XDisplay_shift *InstancePtr);

void XDisplay_shift_InterruptGlobalEnable(XDisplay_shift *InstancePtr);
void XDisplay_shift_InterruptGlobalDisable(XDisplay_shift *InstancePtr);
void XDisplay_shift_InterruptEnable(XDisplay_shift *InstancePtr, u32 Mask);
void XDisplay_shift_InterruptDisable(XDisplay_shift *InstancePtr, u32 Mask);
void XDisplay_shift_InterruptClear(XDisplay_shift *InstancePtr, u32 Mask);
u32 XDisplay_shift_InterruptGetEnabled(XDisplay_shift *InstancePtr);
u32 XDisplay_shift_InterruptGetStatus(XDisplay_shift *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
