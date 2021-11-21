	// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XMULADD_H
#define XMULADD_H

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
#include "xmuladd_hw.h"

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
} XMuladd_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMuladd;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMuladd_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMuladd_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMuladd_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMuladd_ReadReg(BaseAddress, RegOffset) \
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
int XMuladd_Initialize(XMuladd *InstancePtr, u16 DeviceId);
XMuladd_Config* XMuladd_LookupConfig(u16 DeviceId);
int XMuladd_CfgInitialize(XMuladd *InstancePtr, XMuladd_Config *ConfigPtr);
#else
int XMuladd_Initialize(XMuladd *InstancePtr, const char* InstanceName);
int XMuladd_Release(XMuladd *InstancePtr);
#endif

void XMuladd_Start(XMuladd *InstancePtr);
u32 XMuladd_IsDone(XMuladd *InstancePtr);
u32 XMuladd_IsIdle(XMuladd *InstancePtr);
u32 XMuladd_IsReady(XMuladd *InstancePtr);
void XMuladd_EnableAutoRestart(XMuladd *InstancePtr);
void XMuladd_DisableAutoRestart(XMuladd *InstancePtr);
u32 XMuladd_Get_return(XMuladd *InstancePtr);

u32 XMuladd_Get_a_BaseAddress(XMuladd *InstancePtr);
u32 XMuladd_Get_a_HighAddress(XMuladd *InstancePtr);
u32 XMuladd_Get_a_TotalBytes(XMuladd *InstancePtr);
u32 XMuladd_Get_a_BitWidth(XMuladd *InstancePtr);
u32 XMuladd_Get_a_Depth(XMuladd *InstancePtr);
u32 XMuladd_Write_a_Words(XMuladd *InstancePtr, int offset, word_type *data, int length);
u32 XMuladd_Read_a_Words(XMuladd *InstancePtr, int offset, word_type *data, int length);
u32 XMuladd_Write_a_Bytes(XMuladd *InstancePtr, int offset, char *data, int length);
u32 XMuladd_Read_a_Bytes(XMuladd *InstancePtr, int offset, char *data, int length);
u32 XMuladd_Get_b_BaseAddress(XMuladd *InstancePtr);
u32 XMuladd_Get_b_HighAddress(XMuladd *InstancePtr);
u32 XMuladd_Get_b_TotalBytes(XMuladd *InstancePtr);
u32 XMuladd_Get_b_BitWidth(XMuladd *InstancePtr);
u32 XMuladd_Get_b_Depth(XMuladd *InstancePtr);
u32 XMuladd_Write_b_Words(XMuladd *InstancePtr, int offset, word_type *data, int length);
u32 XMuladd_Read_b_Words(XMuladd *InstancePtr, int offset, word_type *data, int length);
u32 XMuladd_Write_b_Bytes(XMuladd *InstancePtr, int offset, char *data, int length);
u32 XMuladd_Read_b_Bytes(XMuladd *InstancePtr, int offset, char *data, int length);

void XMuladd_InterruptGlobalEnable(XMuladd *InstancePtr);
void XMuladd_InterruptGlobalDisable(XMuladd *InstancePtr);
void XMuladd_InterruptEnable(XMuladd *InstancePtr, u32 Mask);
void XMuladd_InterruptDisable(XMuladd *InstancePtr, u32 Mask);
void XMuladd_InterruptClear(XMuladd *InstancePtr, u32 Mask);
u32 XMuladd_InterruptGetEnabled(XMuladd *InstancePtr);
u32 XMuladd_InterruptGetStatus(XMuladd *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
