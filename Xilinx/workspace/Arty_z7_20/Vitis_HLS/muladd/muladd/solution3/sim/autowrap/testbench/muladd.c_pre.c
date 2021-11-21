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
