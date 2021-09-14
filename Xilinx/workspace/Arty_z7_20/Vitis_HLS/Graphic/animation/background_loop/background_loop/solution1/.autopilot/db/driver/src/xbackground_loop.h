// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XBACKGROUND_LOOP_H
#define XBACKGROUND_LOOP_H

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
#include "xbackground_loop_hw.h"

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
} XBackground_loop_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XBackground_loop;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XBackground_loop_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XBackground_loop_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XBackground_loop_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XBackground_loop_ReadReg(BaseAddress, RegOffset) \
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
int XBackground_loop_Initialize(XBackground_loop *InstancePtr, u16 DeviceId);
XBackground_loop_Config* XBackground_loop_LookupConfig(u16 DeviceId);
int XBackground_loop_CfgInitialize(XBackground_loop *InstancePtr, XBackground_loop_Config *ConfigPtr);
#else
int XBackground_loop_Initialize(XBackground_loop *InstancePtr, const char* InstanceName);
int XBackground_loop_Release(XBackground_loop *InstancePtr);
#endif

void XBackground_loop_Start(XBackground_loop *InstancePtr);
u32 XBackground_loop_IsDone(XBackground_loop *InstancePtr);
u32 XBackground_loop_IsIdle(XBackground_loop *InstancePtr);
u32 XBackground_loop_IsReady(XBackground_loop *InstancePtr);
void XBackground_loop_EnableAutoRestart(XBackground_loop *InstancePtr);
void XBackground_loop_DisableAutoRestart(XBackground_loop *InstancePtr);

void XBackground_loop_Set_ddr_copy(XBackground_loop *InstancePtr, u64 Data);
u64 XBackground_loop_Get_ddr_copy(XBackground_loop *InstancePtr);
void XBackground_loop_Set_ddr_update(XBackground_loop *InstancePtr, u64 Data);
u64 XBackground_loop_Get_ddr_update(XBackground_loop *InstancePtr);
void XBackground_loop_Set_width(XBackground_loop *InstancePtr, u32 Data);
u32 XBackground_loop_Get_width(XBackground_loop *InstancePtr);
void XBackground_loop_Set_height(XBackground_loop *InstancePtr, u32 Data);
u32 XBackground_loop_Get_height(XBackground_loop *InstancePtr);
void XBackground_loop_Set_frame_size(XBackground_loop *InstancePtr, u32 Data);
u32 XBackground_loop_Get_frame_size(XBackground_loop *InstancePtr);
void XBackground_loop_Set_direction(XBackground_loop *InstancePtr, u32 Data);
u32 XBackground_loop_Get_direction(XBackground_loop *InstancePtr);

void XBackground_loop_InterruptGlobalEnable(XBackground_loop *InstancePtr);
void XBackground_loop_InterruptGlobalDisable(XBackground_loop *InstancePtr);
void XBackground_loop_InterruptEnable(XBackground_loop *InstancePtr, u32 Mask);
void XBackground_loop_InterruptDisable(XBackground_loop *InstancePtr, u32 Mask);
void XBackground_loop_InterruptClear(XBackground_loop *InstancePtr, u32 Mask);
u32 XBackground_loop_InterruptGetEnabled(XBackground_loop *InstancePtr);
u32 XBackground_loop_InterruptGetStatus(XBackground_loop *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
