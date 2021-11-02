// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XMAPCHIP_COLOR_H
#define XMAPCHIP_COLOR_H

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
#include "xmapchip_color_hw.h"

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
} XMapchip_color_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMapchip_color;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMapchip_color_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMapchip_color_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMapchip_color_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMapchip_color_ReadReg(BaseAddress, RegOffset) \
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
int XMapchip_color_Initialize(XMapchip_color *InstancePtr, u16 DeviceId);
XMapchip_color_Config* XMapchip_color_LookupConfig(u16 DeviceId);
int XMapchip_color_CfgInitialize(XMapchip_color *InstancePtr, XMapchip_color_Config *ConfigPtr);
#else
int XMapchip_color_Initialize(XMapchip_color *InstancePtr, const char* InstanceName);
int XMapchip_color_Release(XMapchip_color *InstancePtr);
#endif

void XMapchip_color_Start(XMapchip_color *InstancePtr);
u32 XMapchip_color_IsDone(XMapchip_color *InstancePtr);
u32 XMapchip_color_IsIdle(XMapchip_color *InstancePtr);
u32 XMapchip_color_IsReady(XMapchip_color *InstancePtr);
void XMapchip_color_EnableAutoRestart(XMapchip_color *InstancePtr);
void XMapchip_color_DisableAutoRestart(XMapchip_color *InstancePtr);

void XMapchip_color_Set_srcin(XMapchip_color *InstancePtr, u64 Data);
u64 XMapchip_color_Get_srcin(XMapchip_color *InstancePtr);
void XMapchip_color_Set_dstin(XMapchip_color *InstancePtr, u64 Data);
u64 XMapchip_color_Get_dstin(XMapchip_color *InstancePtr);
void XMapchip_color_Set_dstout(XMapchip_color *InstancePtr, u64 Data);
u64 XMapchip_color_Get_dstout(XMapchip_color *InstancePtr);
void XMapchip_color_Set_mapchip_maxwidth(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_mapchip_maxwidth(XMapchip_color *InstancePtr);
void XMapchip_color_Set_mapchip_maxheight(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_mapchip_maxheight(XMapchip_color *InstancePtr);
void XMapchip_color_Set_mapchip_draw_xsize(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_mapchip_draw_xsize(XMapchip_color *InstancePtr);
void XMapchip_color_Set_mapchip_draw_ysize(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_mapchip_draw_ysize(XMapchip_color *InstancePtr);
void XMapchip_color_Set_xstart_pos(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_xstart_pos(XMapchip_color *InstancePtr);
void XMapchip_color_Set_ystart_pos(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_ystart_pos(XMapchip_color *InstancePtr);
void XMapchip_color_Set_frame_size(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_frame_size(XMapchip_color *InstancePtr);
void XMapchip_color_Set_alpha(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_alpha(XMapchip_color *InstancePtr);
void XMapchip_color_Set_fill(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_fill(XMapchip_color *InstancePtr);
void XMapchip_color_Set_com(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_com(XMapchip_color *InstancePtr);
void XMapchip_color_Set_id(XMapchip_color *InstancePtr, u32 Data);
u32 XMapchip_color_Get_id(XMapchip_color *InstancePtr);

void XMapchip_color_InterruptGlobalEnable(XMapchip_color *InstancePtr);
void XMapchip_color_InterruptGlobalDisable(XMapchip_color *InstancePtr);
void XMapchip_color_InterruptEnable(XMapchip_color *InstancePtr, u32 Mask);
void XMapchip_color_InterruptDisable(XMapchip_color *InstancePtr, u32 Mask);
void XMapchip_color_InterruptClear(XMapchip_color *InstancePtr, u32 Mask);
u32 XMapchip_color_InterruptGetEnabled(XMapchip_color *InstancePtr);
u32 XMapchip_color_InterruptGetStatus(XMapchip_color *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
