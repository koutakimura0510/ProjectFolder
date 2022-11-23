// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
# 1 "/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd.c"
# 1 "/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd.c" 1
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 149 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd.c" 2


int muladd(int a[16], int b[16])
{
    int i, temp = 0;

    muladd_loop:for (i = 0; i < 16; i++)
    {
        temp += a[i] * b[i];
    }

    return temp;
}
#ifndef HLS_FASTSIM
#ifdef __cplusplus
extern "C"
#endif
int apatb_muladd_ir(int *, int *);
#ifdef __cplusplus
extern "C"
#endif
int muladd_hw_stub(int *a, int *b){
int _ret = muladd(a, b);
return _ret;
}
#ifdef __cplusplus
extern "C"
#endif
int apatb_muladd_sw(int *a, int *b){
int _ret = apatb_muladd_ir(a, b);
return _ret;
}
#endif
# 13 "/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd.c"

