// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XAFFINE_SCALE_H
#define XAFFINE_SCALE_H

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
#include "xaffine_scale_hw.h"

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
} XAffine_scale_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XAffine_scale;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XAffine_scale_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XAffine_scale_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XAffine_scale_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XAffine_scale_ReadReg(BaseAddress, RegOffset) \
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
int XAffine_scale_Initialize(XAffine_scale *InstancePtr, u16 DeviceId);
XAffine_scale_Config* XAffine_scale_LookupConfig(u16 DeviceId);
int XAffine_scale_CfgInitialize(XAffine_scale *InstancePtr, XAffine_scale_Config *ConfigPtr);
#else
int XAffine_scale_Initialize(XAffine_scale *InstancePtr, const char* InstanceName);
int XAffine_scale_Release(XAffine_scale *InstancePtr);
#endif

void XAffine_scale_Start(XAffine_scale *InstancePtr);
u32 XAffine_scale_IsDone(XAffine_scale *InstancePtr);
u32 XAffine_scale_IsIdle(XAffine_scale *InstancePtr);
u32 XAffine_scale_IsReady(XAffine_scale *InstancePtr);
void XAffine_scale_EnableAutoRestart(XAffine_scale *InstancePtr);
void XAffine_scale_DisableAutoRestart(XAffine_scale *InstancePtr);

void XAffine_scale_Set_srcin(XAffine_scale *InstancePtr, u64 Data);
u64 XAffine_scale_Get_srcin(XAffine_scale *InstancePtr);
void XAffine_scale_Set_dstin(XAffine_scale *InstancePtr, u64 Data);
u64 XAffine_scale_Get_dstin(XAffine_scale *InstancePtr);
void XAffine_scale_Set_dstout(XAffine_scale *InstancePtr, u64 Data);
u64 XAffine_scale_Get_dstout(XAffine_scale *InstancePtr);
void XAffine_scale_Set_mapchip_maxwidth(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_mapchip_maxwidth(XAffine_scale *InstancePtr);
void XAffine_scale_Set_mapchip_maxheight(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_mapchip_maxheight(XAffine_scale *InstancePtr);
void XAffine_scale_Set_mapchip_draw_xsize(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_mapchip_draw_xsize(XAffine_scale *InstancePtr);
void XAffine_scale_Set_mapchip_draw_ysize(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_mapchip_draw_ysize(XAffine_scale *InstancePtr);
void XAffine_scale_Set_xstart_pos(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_xstart_pos(XAffine_scale *InstancePtr);
void XAffine_scale_Set_ystart_pos(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_ystart_pos(XAffine_scale *InstancePtr);
void XAffine_scale_Set_frame_size(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_frame_size(XAffine_scale *InstancePtr);
void XAffine_scale_Set_alpha(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_alpha(XAffine_scale *InstancePtr);
void XAffine_scale_Set_id(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_id(XAffine_scale *InstancePtr);
void XAffine_scale_Set_a(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_a(XAffine_scale *InstancePtr);
void XAffine_scale_Set_b(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_b(XAffine_scale *InstancePtr);
void XAffine_scale_Set_c(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_c(XAffine_scale *InstancePtr);
void XAffine_scale_Set_d(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_d(XAffine_scale *InstancePtr);
void XAffine_scale_Set_m(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_m(XAffine_scale *InstancePtr);
void XAffine_scale_Set_n(XAffine_scale *InstancePtr, u32 Data);
u32 XAffine_scale_Get_n(XAffine_scale *InstancePtr);

void XAffine_scale_InterruptGlobalEnable(XAffine_scale *InstancePtr);
void XAffine_scale_InterruptGlobalDisable(XAffine_scale *InstancePtr);
void XAffine_scale_InterruptEnable(XAffine_scale *InstancePtr, u32 Mask);
void XAffine_scale_InterruptDisable(XAffine_scale *InstancePtr, u32 Mask);
void XAffine_scale_InterruptClear(XAffine_scale *InstancePtr, u32 Mask);
u32 XAffine_scale_InterruptGetEnabled(XAffine_scale *InstancePtr);
u32 XAffine_scale_InterruptGetStatus(XAffine_scale *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
