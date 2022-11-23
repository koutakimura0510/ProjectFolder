#ifndef vdma_struct_h   /* prevent circular inclusions */
#define vdma_struct_h   /* by using protection macros */

typedef struct vdmawork
{
    bool ischannel;
    uint8_t pos;
} VdmaWork;


#endif