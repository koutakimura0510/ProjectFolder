"""

Copyright (C) 2022 Efinix Inc. All rights reserved.

No portion of this code may be reused, modified or
distributed in any way without the expressed written
consent of Efinix Inc.

Modified on 28 September  2022

@author: Dragon Lai
"""
import sys
import os
import argparse
import math
import json
    
from enum import Enum




class BRAM_TYPE(Enum):
    EFX_RAM_5K   = 0
    EFX_DPRAM_5K = 1
    EFX_RAM10    = 2
    EFX_DPRAM10  = 3

class COMPATIBLE(Enum):
    LARGE = 0
    SMALL = 1

class FEATURE(Enum):
    ADDRW = 0
    DATAW = 1
    WENW  = 2
    BRAM_TYPE = 3   
    COMPATIBLE= 4

#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_RAM10_feature_table =[
[9 ,20,2,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.LARGE.value],    
[9 ,16,2,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[10,10,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.LARGE.value],
[10,8 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[11,5 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.LARGE.value],
[11,4 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[12,2 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[13,1 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value]
]


#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_RAM10_MWM_feature_table =[   
[9 ,16,2,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[10,8 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[11,4 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[12,2 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value],
[13,1 ,1,BRAM_TYPE.EFX_RAM10.value,COMPATIBLE.SMALL.value]
]


#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_DPRAM10_feature_table =[
[10,10,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.LARGE.value],
[11,5 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.LARGE.value],
[10,8 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[11,4 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[12,2 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[13,1 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value]
]

#Table for MixedDataWIdth
#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_DPRAM10_MWM_feature_table =[
[10,8 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[11,4 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[12,2 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value],
[13,1 ,1,BRAM_TYPE.EFX_DPRAM10.value,COMPATIBLE.SMALL.value]
]

#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_RAM_5K_feature_table =[
[8 ,20,2,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.LARGE.value],    
[9 ,10,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.LARGE.value],
[10,5 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.LARGE.value],
[8 ,16,2,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[9 ,8 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[10,4 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[11,2 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[12,1 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value]
]

#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_RAM_5K_MWM_feature_table =[
[8 ,16,2,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[9 ,8 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[10,4 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[11,2 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value],
[12,1 ,1,BRAM_TYPE.EFX_RAM_5K.value,COMPATIBLE.SMALL.value]
]


#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_DPRAM_5K_feature_table =[
[9 ,10,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.LARGE.value],
[10,5 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.LARGE.value],
[9 ,8 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[10,4 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[11,2 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[12,1 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value]
]


#Address Width, Data Width , Number of wen, BRAM_TYPE, COMPATIBLE
EFX_DPRAM_5K_MWM_feature_table =[
[9 ,8 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[10,4 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[11,2 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value],
[12,1 ,1,BRAM_TYPE.EFX_DPRAM_5K.value,COMPATIBLE.SMALL.value]
]

#Index of Mode Write (A), Index of Mode Read (B), Number of bram in column/row    
bram_decompose_table =[
[0 ,0, 5, 0, 0],
[0 ,0, 1, 0, 0],
]

#Index of Y of bram_decompose_table, 
#Index of X of bram_decompose_table, 
#Port A Data MSB, 
#Port A Data LSB,
#Port A Data Repart, 
#PORT A rdata MUX,
#PORT A WEN Selecion,
#PORT A BYTEEN, 
#Port B Data MSB, 
#PORT B Data LSB, 
#Port A Data Repart, 
#PORT B rdata MUX, 
#PORT B BYTEEN,
#PORT B WEN Selecion,
bram_mapping_table = list()

#Port Address Selection MSB,
#Port Address Selection LSB,
#DATA MSB,
#DATA LSB, 
rMux_mapping_table_A = list()

#Port Address Selection MSB,
#Port Address Selection LSB,
#WEN Range MSB,
#WEN Ragne LSB, 
wen_sel_mapping_table_A = list()

#Port Address Selection MSB,
#Port Address Selection LSB,
#DATA MSB,
#DATA LSB, 
rMux_mapping_table_B = list()

#Port Address Selection MSB,
#Port Address Selection LSB,
#WEN Range MSB,
#WEN Ragne LSB, 
wen_sel_mapping_table_B = list()



#Data Bit Index for Mixed Width Mode
data_mapping_table_A = list()

#Data Bit Index for Mixed Width Mode 
data_mapping_table_B = list()

#Address Bit Index for Mixed Width Mode 
address_mapping_table_A = list()

#Address Bit Index for Mixed Width Mode 
address_mapping_table_B = list()


bram_decompose_mode = 1 # 1: LOOP ROW FIRST", 0: LOOP COLUMN FIRST" 
in_addr_width_a = 10
in_data_width_a = 10
in_addr_width_b = 10
in_data_width_b = 10

#byteen mapping 
# byteen index, Write Enable (WE) mode for primitive (e.g. for we[0] or we[1], 1 for wen 0, 2 for wen 1
bram_decompose_byteen_table = list()
byteen_width = 1
byteen_width_A = 1
byteen_width_B = 1

byteen_enable = 0
group_data_width = 8
group_data_width_A = 8
group_data_width_B = 8


group_columns = 1
FAMILY = 1
actual_size = 0
actual_size_A = 0
actual_size_B = 0

bram_we_mapping_table =[0,1,2,3]

def create_feature_file():
    f = open("bram_feature.vh", "w")
    y = 0
   
    line = ""   
    
    line += 'function integer bram_feature_table;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer type; //Address_width, data_width, en_width, reserved \n'
    line += 'case (index)\n'
    f.write (line)
    for row in bram_feature_table:
       
        line = ""   
        x = 0
        
        line += str(y )
        line += ': bram_feature_table='
        
        for feature in row:
            line += '(type==' + str(x) + ')?' + str(feature) + ':'
            x = x + 1
        
        line += '0;\n'
        f.write (line)
        y = y +1
    

    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"
    f.write (line)
    f.close()


def create_memory_init_file():
    f = open("bram_ini.vh", "w")
   
    line  = '\n'
    line += 'function [255:0] bram_ini_table;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_; //Port A index, Port B Index, Number of Items in Loop, Port A Start, Port B Start, reserved \n'
    line += 'case (index)\n'
    f.write (line)
    y = 0
    for row in bram_mapping_table:
       
        line = ""   
        x = 0
        
        line += '%4s: bram_ini_table=\n' %(y)
        
        
        stringline ="256'h"
        for hexChar in range(0,32):
           #stringline +=  '%02x' % (y)
           stringline +=  '%02x' % (0)
        
        
        for x in range(0,  40):
            #line += '(type==' + str(x) + ')?' + str(feature) + ':'
            line += '(val_==%2s)?' % (x)
            
            line += stringline
           #line += "256'h0000000000000000000000000000000000000000000000000000000000000000"
            
            line += ":\n"
            x = x + 1
        line += '0;\n'
        f.write (line)
        
        
        
        y = y +1
    
    
    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"
    f.write (line)
    
    
    
    
    f.close()


    
def create_decompose_file():
    f = open("bram_decompose.vh", "w")
    y = 0
   
    line = ""   
    line += 'localparam FAMILY       = '  + str(FAMILY) + '; //0:Trion,  1:Titanium\n'
    line += 'localparam ADDR_WIDTH_A = '  + str(in_addr_width_a) + ';\n'
    line += 'localparam DATA_WIDTH_A = '  + str(in_data_width_a) + ';\n'
    line += 'localparam ADDR_WIDTH_B = '  + str(in_addr_width_b) + ';\n'
    line += 'localparam DATA_WIDTH_B = '  + str(in_data_width_b) + ';\n'
    line += 'localparam TOTAL_SIZE_A = '  + str(actual_size_A) + ';\n'
    line += 'localparam TOTAL_SIZE_B = '  + str(actual_size_B) + ';\n'    
    line += 'localparam BYTEEN_WIDTH = '  + str(byteen_width) + ';\n'
    line += 'localparam BYTEEN_WIDTH_A = '  + str(byteen_width_A) + ';\n'
    line += 'localparam BYTEEN_WIDTH_B = '  + str(byteen_width_B) + ';\n'
    line += 'localparam GROUP_DATA_WIDTH = ' + str(group_data_width) + ';\n'
    line += 'localparam GROUP_DATA_WIDTH_A = ' + str(group_data_width_A) + ';\n'
    line += 'localparam GROUP_DATA_WIDTH_B = ' + str(group_data_width_B) + ';\n'

    line += 'localparam GROUP_COLUMNS    = ' + str(group_columns) + ';\n'
    
    line += 'localparam bram_table_size = '  + str(len(bram_decompose_table)) + ';\n'
    line += 'localparam bram_table_loop_mode = '  + str(bram_decompose_mode)  + ';\n'
    
    line += 'localparam bram_mapping_size = '  + str(len(bram_mapping_table))  + ';\n'
    line += 'localparam rMux_mapping_A_size = '  + str(len(rMux_mapping_table_A))  + ';\n'
    line += 'localparam rMux_mapping_B_size = '  + str(len(rMux_mapping_table_B))  + ';\n'
    line += 'localparam wen_sel_mapping_A_size = '  + str(len(wen_sel_mapping_table_A))  + ';\n'
    line += 'localparam wen_sel_mapping_B_size = '  + str(len(wen_sel_mapping_table_B))  + ';\n'
    
    
    line += 'localparam data_mapping_table_A_size = '  + str(len(data_mapping_table_A))  + ';\n'
    line += 'localparam data_mapping_table_B_size = '  + str(len(data_mapping_table_B))  + ';\n'
    line += 'localparam address_mapping_table_A_size = '  + str(len(address_mapping_table_A))  + ';\n'
    line += 'localparam address_mapping_table_B_size = '  + str(len(address_mapping_table_B))  + ';\n'
    f.write (line)
   
   
    y = 0
   
    line = '\n\n' 
    
    line += 'function integer bram_feature_table;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_; //Address_width, data_width, en_width, reserved \n'
    line += 'case (index)\n'
    f.write (line)
    for row in bram_feature_table:
       
        line = ""   
        x = 0
        
        line += str(y )
        line += ': bram_feature_table='
        
        for feature in row:
            line += '(val_==' + str(x) + ')?' + str(feature) + ':'
            x = x + 1
        
        line += '0;\n'
        f.write (line)
        y = y +1
    

    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"
    f.write (line)   
   
    
    line = '\n\n'
    y = 0
    line += 'function integer bram_decompose_table;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_; //Port A index, Port B Index, Number of Items in Loop, Port A Start, Port B Start, reserved \n'
    line += 'case (index)\n'
    f.write (line)
    for row in bram_decompose_table:
       
        line = ""   
        x = 0
        
        line += '%4s: bram_decompose_table=' %(y)
        
        for feature in row:
            #line += '(type==' + str(x) + ')?' + str(feature) + ':'
            line += '(val_==%1s)?%4s:' % (x,feature)
            x = x + 1
        line += '0;\n'
        f.write (line)
        y = y +1
    
    
    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"
    f.write (line)

    #line = ""   
    #line += '\n\n'
    #y = 0
    #line += 'function integer bram_decompose_byteen_table;\n'
    #line += 'input integer index;//Mode type \n'
    #line += 'input integer type; //Port A index, Port B Index, Number of Items in Loop, Port A Start, Port B Start, reserved \n'
    #line += 'case (index)\n'
    #f.write (line)
    #
    #
    #for row in bram_decompose_byteen_table:
    #   
    #    line = ""   
    #    x = 0
    #    
    #    line += str(y )
    #    line += ': bram_decompose_byteen_table='
    #    
    #    for feature in row:
    #        line += '(type==' + str(x) + ')?' + str(feature) + ':'
    #        x = x + 1
    #    line += '0;\n'
    #    f.write (line)
    #    y = y +1
    #
    #line =  ""   
    #line += "   endcase\n"
    #line += "endfunction  \n"    
    #f.write (line)
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer bram_mapping_table;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_;'
    line += '//            '
    line += 'Y,              '
    line += 'X,              '
    line += 'DataA [MSB],    '
    line += 'DataA [LSB],    '
    line += 'DataA Repeat,   '
    line += 'Read MuxA,      '    
    line += 'Wen0 SelA,      '    
    line += 'Wen1 SelA,      '    
    line += 'Byteen A,       '
    line += 'DataB [MSB],    '
    line += 'DataB [LSB],    '
    line += 'DataB Repeat,   '
    line += 'Read MuxB,      '    
    line += 'Wen0 SelB,      '    
    line += 'Wen1 SelB,      '    
    line += 'Byteen B,       '
    line += 'Addr Width A    '
    line += 'Data Width A    '
    line += 'Addr Width B    '
    line += 'Data Width B    '
    
    line += '\n'
    
    line += 'case (index)\n'
    f.write (line)
    
    
    for row in bram_mapping_table:
       
        line = ""   
        x = 0
        
        line += '%4s: bram_mapping_table=' % (y)
        
        for feature in row:
            line += '(val_==%2s)?%4s:' % (x,feature)
        #    line += '(val_==' + str(x) + ')?' + str(feature) + ':'
        
        
            x = x + 1
        line += '0;\n'
        f.write (line)
        y = y +1
    
    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"    
    f.write (line)
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer rMux_mapping_table_A;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_;'
    line += '//            '
    line += 'PortA Addr MSB, '
    line += 'PortA Addr LSB, '
    line += 'DataA[MSB],     '
    line += 'DataA[LSB],     '
    line += 'MuxSelA[MSB],   '
    line += 'MuxSelA[LSB],   '
    line += 'Bypass,         '
    line += '\n'
    f.write (line)
    
    if len(rMux_mapping_table_A) != 0:
        line = 'case (index)\n'
        f.write (line)
        
        for row in rMux_mapping_table_A:
        
            line = ""   
            x = 0
            
            line += '%4s: rMux_mapping_table_A=' % (y)
            
            for feature in row:
                line += '(val_==%2s)?%4s:' % (x,feature)
            #    line += '(val_==' + str(x) + ')?' + str(feature) + ':'
            
            
                x = x + 1
            line += '0;\n'
            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "rMux_mapping_table_A = 0; \n"
        f.write (line)
        
    line = "endfunction  \n"    
    f.write (line)
    
 
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer rMux_mapping_table_B;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_;'
    line += '//            '
    line += 'PortB Addr MSB, '
    line += 'PortB Addr LSB, '
    line += 'DataB[MSB],     '
    line += 'DataB[LSB],     '
    line += 'MuxSelB[MSB],   '
    line += 'MuxSelB[LSB],   '
    line += 'Bypass,         '
    line += '\n'
    f.write (line)
    
    
    if len(rMux_mapping_table_B) != 0:
        line = 'case (index)\n'
        f.write (line)
        
        for row in rMux_mapping_table_B:
        
            line = ""   
            x = 0
            
            line += '%4s: rMux_mapping_table_B=' % (y)
            
            for feature in row:
                line += '(val_==%2s)?%4s:' % (x,feature)
            #    line += '(val_==' + str(x) + ')?' + str(feature) + ':'
            
            
                x = x + 1
            line += '0;\n'
            f.write (line)
            y = y +1
        
        line = ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "rMux_mapping_table_B = 0; \n"
        f.write (line)
    
    line = "endfunction  \n"    
    f.write (line)
    
     
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer wen_sel_mapping_table_A;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_;'
    line += '//              '
    line += 'PortA Addr MSB,   '
    line += 'PortA Addr LSB,   '
    line += 'WenSelA[MSB],     '
    line += 'WenSelA[LSB],     '
    line += 'Bypass,         '
    line += '\n'
    f.write (line)
    
    
    if len(wen_sel_mapping_table_A) != 0:
        line = 'case (index)\n'
        f.write (line)
        for row in wen_sel_mapping_table_A:
        
            line = ""   
            x = 0
            
            line += '%4s: wen_sel_mapping_table_A=' % (y)
            
            for feature in row:
                line += '(val_==%2s)?%4s:' % (x,feature)
            #    line += '(val_==' + str(x) + ')?' + str(feature) + ':'
            
            
                x = x + 1
            line += '0;\n'
            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "wen_sel_mapping_table_A = 0; \n"
        f.write (line)

    
    line = "endfunction  \n"    
    f.write (line)
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer wen_sel_mapping_table_B;\n'
    line += 'input integer index;//Mode type \n'
    line += 'input integer val_;'
    line += '//            '
    line += 'PortB Addr MSB, '
    line += 'PortB Addr LSB, '
    line += 'WenSelB[MSB],   '
    line += 'WenSelB[LSB],   '
    line += 'Bypass,         '
    line += '\n'
    f.write (line)
    
    if len(wen_sel_mapping_table_B) !=0:
    
        line = 'case (index)\n'
        f.write (line)
        for row in wen_sel_mapping_table_B:
        
            line = ""   
            x = 0
            
            line += '%4s: wen_sel_mapping_table_B=' % (y)
            
            for feature in row:
                line += '(val_==%2s)?%4s:' % (x,feature)
            #    line += '(val_==' + str(x) + ')?' + str(feature) + ':'
            
            
                x = x + 1
            line += '0;\n'
            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "wen_sel_mapping_table_B = 0; \n"
        f.write (line)
    
    
    line = "endfunction  \n"    
    f.write (line)
    
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer data_mapping_table_A;\n'
    line += 'input integer index;// \n'
    f.write (line)
    
    if len(data_mapping_table_A) !=0:
    
        line = 'case (index)\n'
        f.write (line)
        for row in data_mapping_table_A:
        
            line = ""   
            
            line += '%4s: data_mapping_table_A= %4s;\n' % (y,row)

            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "data_mapping_table_A = 0; \n"
        f.write (line)
    
    
    line = "endfunction  \n"    
    f.write (line)
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer data_mapping_table_B;\n'
    line += 'input integer index;// \n'
    f.write (line)
    
    if len(data_mapping_table_B) !=0:
    
        line = 'case (index)\n'
        f.write (line)
        for row in data_mapping_table_B:
        
            line = ""   
      
            line += '%4s: data_mapping_table_B= %4s;\n' % (y,row)
            
            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "data_mapping_table_B = 0; \n"
        f.write (line)
    
    
    line = "endfunction  \n"    
    f.write (line)
    
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer address_mapping_table_A;\n'
    line += 'input integer index;// \n'
    f.write (line)
    
    if len(address_mapping_table_A) !=0:
    
        line = 'case (index)\n'
        f.write (line)
        for row in address_mapping_table_A:
        
            line = ""   
            
            line += '%4s: address_mapping_table_A= %4s;\n' % (y,row)

            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "address_mapping_table_A = 0; \n"
        f.write (line)
    
    
    line = "endfunction  \n"    
    f.write (line)
    
    
    line = ""   
    line += '\n\n'
    y = 0
    line += 'function integer address_mapping_table_B;\n'
    line += 'input integer index;// \n'
    f.write (line)
    
    if len(address_mapping_table_B) !=0:
    
        line = 'case (index)\n'
        f.write (line)
        for row in address_mapping_table_B:
        
            line = ""   
            
            line += '%4s: address_mapping_table_B= %4s;\n' % (y,row)
          
            f.write (line)
            y = y +1
        
        line =  ""   
        line = "   endcase\n"
        f.write (line)
    else:
        line = "address_mapping_table_B = 0; \n"
        f.write (line)
    
    
    line = "endfunction  \n"    
    f.write (line)
    
    
    
    f.close()

def create_decompose_column__(address_width, data_width, size, decompose_mode):
    
    #flag_find = true;
    index = 0 
    
    Find_success = False
    
    Max_addrw  = 0
    Max_dataw  = 0
    min_dataw  = 0
    rows       = 0
    
    #result = "Input Address:"+ str(address_width) +" data:" + str(data_width)
    #print (result)
    
    #Find Max Address Width 
    for feature in bram_feature_table:
        if feature[FEATURE.COMPATIBLE.value] == COMPATIBLE.LARGE.value or decompose_mode == 'speed':
            if Max_addrw < feature[FEATURE.ADDRW.value]:
                Max_addrw = feature[FEATURE.ADDRW.value]
            if address_width <= Max_addrw:
                break
                
   # result = "Max Address:"+ str(Max_addrw)
   # print (result)
             
    
   #Find Max Data Width 
   # for feature in bram_feature_table:
   #     if feature[FEATURE.COMPATIBLE.value] == COMPATIBLE.LARGE.value:
   #         if Max_dataw < feature[FEATURE.DATAW.value]:
   #             Max_dataw = feature[FEATURE.DATAW.value]
 
   # result = "Max Data:"+ str(Max_dataw)
   # print (result)
  
 
    #Find Max Data Width
    index = 0
    for feature in bram_feature_table:
    
        min_dataw = feature[FEATURE.DATAW.value]
        
        if feature[FEATURE.ADDRW.value] >= address_width:
            break
        
        if feature[FEATURE.ADDRW.value] >= Max_addrw:
            
        #    result = "Min Data:"+ str(min_dataw)
        #    print (result)
        
            if min_dataw <= data_width:
                break   
            
            
            
            min_dataw =  feature[FEATURE.DATAW.value]
                
        index += 1
            
  #  result = "Min Data:"+ str(min_dataw)
  #  print (result)
  #  result = "Index:"+ str(index)
  #  print (result)
    
    primitive_dataw = bram_feature_table[index][FEATURE.DATAW.value]
    primitive_addrw = bram_feature_table[index][FEATURE.ADDRW.value]
    
    
    total_address = pow(2,address_width)  
    total_primitive_address = pow(2,primitive_addrw)
    
    if size != 0:
        if size <= total_address:
            total_address = size
        
    rows = int(total_address/total_primitive_address)
        
    if total_address % total_primitive_address :
        rows += 1

    
    
    return index, rows, primitive_addrw, primitive_dataw

def create_decompose_column(address_width, data_width, size):
    
    #flag_find = true;
    index = 0 
    
    Find_success = False
    
    Max_addrw  = 0
    Max_dataw  = 0
    min_dataw  = 0
    rows       = 0
    
    #result = "Input Address:"+ str(address_width) +" data:" + str(data_width)
    #print (result)
    
    #Find Max Address Width 
    for feature in bram_feature_table:
        if feature[FEATURE.COMPATIBLE.value] == COMPATIBLE.LARGE.value:
            if Max_addrw < feature[FEATURE.ADDRW.value]:
                Max_addrw = feature[FEATURE.ADDRW.value]
            if address_width <= Max_addrw:
                break
                
   # result = "Max Address:"+ str(Max_addrw)
   # print (result)
             
    
   #Find Max Data Width 
   # for feature in bram_feature_table:
   #     if feature[FEATURE.COMPATIBLE.value] == COMPATIBLE.LARGE.value:
   #         if Max_dataw < feature[FEATURE.DATAW.value]:
   #             Max_dataw = feature[FEATURE.DATAW.value]
 
   # result = "Max Data:"+ str(Max_dataw)
   # print (result)
  
 
    #Find Max Data Width
    index = 0
    for feature in bram_feature_table:
    
        min_dataw = feature[FEATURE.DATAW.value]
        
        if feature[FEATURE.ADDRW.value] >= address_width:
            break
        
        if feature[FEATURE.ADDRW.value] >= Max_addrw:
            
        #    result = "Min Data:"+ str(min_dataw)
        #    print (result)
        
            if min_dataw <= data_width:
                break   
            
            
            
            min_dataw =  feature[FEATURE.DATAW.value]
                
        index += 1
            
  #  result = "Min Data:"+ str(min_dataw)
  #  print (result)
  #  result = "Index:"+ str(index)
  #  print (result)
    
    primitive_dataw = bram_feature_table[index][FEATURE.DATAW.value]
    primitive_addrw = bram_feature_table[index][FEATURE.ADDRW.value]
    
    
    total_address = pow(2,address_width)  
    total_primitive_address = pow(2,primitive_addrw)
    
    if size != 0:
        if size <= total_address:
            total_address = size
        
    rows = int(total_address/total_primitive_address)
        
    if total_address % total_primitive_address :
        rows += 1

    
    
    return index, rows, primitive_addrw, primitive_dataw



def create_decompose_row(data_width, size, group_data_width):
    
    #flag_find = true;
    index = 0 
    
    Find_success = False
    
    Max_addrw  = 0
    Max_dataw  = 0
    min_dataw  = 0
    columns    = 0
    
    #result = "Input Address:"+ str(address_width) +" data:" + str(data_width)
    #print (result)
    
    address_width = math.log2(size)
    
    #Find Max Address Width 
    for feature in bram_feature_table:
        if Max_addrw < feature[FEATURE.ADDRW.value]:
            Max_addrw = feature[FEATURE.ADDRW.value]
        if address_width <= Max_addrw:
            break
                
   # result = "Max Address:"+ str(Max_addrw)
   # print (result)
             
    
   #Find Max Data Width 
   # for feature in bram_feature_table:
   #     if feature[FEATURE.COMPATIBLE.value] == COMPATIBLE.LARGE.value:
   #         if Max_dataw < feature[FEATURE.DATAW.value]:
   #             Max_dataw = feature[FEATURE.DATAW.value]
 
   # result = "Max Data:"+ str(Max_dataw)
   # print (result)
  
 
    #Find Max Data Width
    index = 0
    for feature in bram_feature_table:
    
        min_dataw = feature[FEATURE.DATAW.value]
        
        if feature[FEATURE.ADDRW.value] >= address_width:
            break
        
        if feature[FEATURE.ADDRW.value] >= Max_addrw:
            
        #    result = "Min Data:"+ str(min_dataw)
        #    print (result)
        
            if min_dataw <= data_width:
                break   
           
        #    min_dataw =  feature[FEATURE.DATAW.value]
                
        index += 1
            
  #  result = "Min Data:"+ str(min_dataw)
  #  print (result)
  #  result = "Index:"+ str(index)
  #  print (result)
    
    primitive_dataw = bram_feature_table[index][FEATURE.DATAW.value]
    primitive_addrw = bram_feature_table[index][FEATURE.ADDRW.value]
    
    if group_data_width == 0:
        columns = int(data_width/primitive_dataw)
        
        if data_width % primitive_dataw:
            columns += 1
    else: 
        sub_columns  = int(group_data_width/primitive_dataw)
          
        if group_data_width % primitive_dataw:
            sub_columns += 1 
            
        columns = (int(data_width/group_data_width)) * sub_columns
        
        sub_columns_remain = (data_width % group_data_width)
        
        columns += int(sub_columns_remain/primitive_dataw)
       
        if sub_columns_remain % primitive_dataw:
            columns += 1
    
    return index, columns, primitive_addrw, primitive_dataw



def create_decompose_table(address_width, data_width, size, decompose_mode):
    
    total_width = 0
    total_bram  = 0
    column      = 0
    while True:
    
        index, rows, column_addrw, column_dataw = create_decompose_column(address_width, (data_width-total_width), size, decompose_mode)
    
        total_width += column_dataw
        total_bram  += rows
        
        result = "Column " + str(column) + ") Primitive index: " + str(index) + " addr"+ str(column_addrw) + " data: " + str(column_dataw) + " number of rows:" +str(rows)
        print (result)
        
        if total_width >= data_width:
            break
            
        column += 1
    
    result = "Total Bram used in:" + str(total_bram)
    print (result)
    
    
def create_decompose_table_scan_col(address_width, data_width, size, group_data_width, address_width_B, data_width_B):
    
   
    total_width = 0
    total_bram  = 0
    column      = 0
    global bram_decompose_mode
    global in_addr_width_a
    global in_data_width_a
    global in_addr_width_b
    global in_data_width_b 
    global byteen_width
    global byteen_enable
    global group_columns
    global bram_decompose_table      
    global bram_decompose_byteen_table
    global bram_mapping_table
    global rMux_mapping_table_A
    global rMux_mapping_table_B
    global wen_sel_mapping_table_A
    global wen_sel_mapping_table_B
    global actual_size_A
    global actual_size_B
   
   
    bram_decompose_byteen_table = list()
    
    total_address = pow(2,address_width)  
   
    if size != 0:
        if size <= total_address:
            total_address = size
            
    actual_size_A = total_address 
    actual_size_B = total_address 
    
    
    
    group_data_count = 0;
    group_data_ptr   = 0;
    for x in range(0, data_width):
        bram_data_row = [group_data_ptr,1]
        bram_decompose_byteen_table.append(bram_data_row)
        
        group_data_count += 1
        if(group_data_count == group_data_width):
            group_data_ptr += 1
            group_data_count = 0  
 
    if group_data_width != 0:
        byteen_enable = 1
        byteen_width =  group_data_ptr
        if ( ( data_width % group_data_width ) != 0):
            byteen_width += 1
        result = "byteen width: " + str(byteen_width) + " Group Data Width: " + str(group_data_width)
        print (result)
   
    bram_decompose_mode = 0 # 1: LOOP ROW FIRST", 0: LOOP COLUMN FIRST" 
    
    in_addr_width_a = address_width
    in_data_width_a = data_width
    in_addr_width_b = address_width
    in_data_width_b = data_width    
    
    byteen_index = 0;
    wen_index = 0;
    
    bram_decompose_table = list()
    rMux_mapping_table_A = list()
    rMux_mapping_table_B = list()
    wen_sel_mapping_table_A = list()
    wen_sel_mapping_table_B = list()    
        
    wenSelIndex = 0    
    

    data_start = 0    
 
    Flg_row_detected = False
 
    while True:
        
        if group_data_width == 0 :
    
            index, rows, column_addrw, column_dataw = create_decompose_column(address_width, (data_width-total_width), size)
        
            bram_column = [index,index, rows, 0,0] 
            bram_decompose_table.append(bram_column)
            
            data_start = total_width
            data_end = data_start + column_dataw
            if data_end > data_width:
                data_end = data_width
            data_end -= 1
            
            
            nBits = data_end - data_start +1 
            interval = 0
            Repeat = 0
            
            wenSel_Start = wenSelIndex
            
            
            for x in range(0,  rows):
                bram_map = [x,column,data_end,data_start,Repeat,x,wenSelIndex,wenSelIndex,byteen_index,data_end,data_start,Repeat,x,wenSelIndex,wenSelIndex,byteen_index,  column_addrw, column_dataw,  column_addrw, column_dataw]
                    
                bram_mapping_table.append(bram_map)
                wenSelIndex += 1
            
            Bypassed = 0
            if( address_width > column_addrw  ) | (Flg_row_detected == True) :
                Flg_row_detected = True 
                if (address_width <= column_addrw):
                    Bypassed = 1
            
                rMuxA = [address_width-1,column_addrw, data_end,data_start, rows-1, 0 , Bypassed]
                rMux_mapping_table_A.append(rMuxA)
                
                rMuxB = [address_width-1,column_addrw, data_end,data_start, rows-1, 0 , Bypassed]
                rMux_mapping_table_B.append(rMuxB)
                
                WenSelA = [address_width-1,column_addrw, wenSelIndex-1,wenSel_Start , Bypassed]
                wen_sel_mapping_table_A.append(WenSelA)
                
                WenSelB = [address_width-1,column_addrw, wenSelIndex-1,wenSel_Start , Bypassed]
                wen_sel_mapping_table_B.append(WenSelB)
            
            
            
            total_width += column_dataw
            total_bram  += rows
            result = "Column " + str(column) + ") Primitive index: " + str(index) + " addr"+ str(column_addrw) + " data: " + str(column_dataw) + " number of rows:" +str(rows)
            print (result)
            
            if total_width >= data_width:
                break
                
            column += 1    
        else :
            
            total_group_data_width = 0;
                              
           
            while True:
            
                index, rows, column_addrw, column_dataw = create_decompose_column(address_width, (group_data_width-total_group_data_width), size)
            
                bram_column = [index,index, rows, 0,0] 
                bram_decompose_table.append(bram_column)
                
                data_start = total_width + total_group_data_width
                data_end = data_start + column_dataw
                
                if (total_group_data_width+column_dataw) > group_data_width:
                    data_end =  total_width + group_data_width
                elif data_end > data_width:
                    data_end = data_width
                data_end -= 1
                
                nBits = data_end - data_start +1 
                interval = 0
                Repeat = 0
                
                wenSel_Start = wenSelIndex
                
                for x in range(0,  rows):
                    bram_map = [x,column,data_end,data_start,Repeat,x,wenSelIndex,wenSelIndex,byteen_index,data_end,data_start,Repeat,x,wenSelIndex,wenSelIndex,byteen_index,   column_addrw, column_dataw,  column_addrw, column_dataw]
                    
                    bram_mapping_table.append(bram_map)
                    wenSelIndex += 1
                    
                Bypassed = 0
                if( address_width > column_addrw  ) | (Flg_row_detected == True) :
                    Flg_row_detected = True 
                    if (address_width <= column_addrw):
                        Bypassed = 1
                        
                    rMuxA = [address_width-1,column_addrw, data_end,data_start, rows-1, 0 , Bypassed]
                    rMux_mapping_table_A.append(rMuxA)
                    
                    rMuxB = [address_width-1,column_addrw, data_end,data_start, rows-1, 0 , Bypassed]
                    rMux_mapping_table_B.append(rMuxB)
                    
                    WenSelA = [address_width-1,column_addrw, wenSelIndex-1,wenSel_Start , Bypassed]
                    wen_sel_mapping_table_A.append(WenSelA)
                    
                    WenSelB = [address_width-1,column_addrw, wenSelIndex-1,wenSel_Start , Bypassed]
                    wen_sel_mapping_table_B.append(WenSelB)
               
                result = "Column " + str(column) + ") Primitive index: " + str(index) + " addr"+ str(column_addrw) + " data: " + str(column_dataw) + " number of rows:" +str(rows)
                print (result)
                             
                                           
                column += 1 
                
                total_group_data_width += column_dataw
                total_bram  += rows
                if total_group_data_width >= group_data_width:
                    byteen_index += 1
                    total_group_data_width = group_data_width
                    break
               
                if (total_width + total_group_data_width ) >= data_width:
                    byteen_index += 1
                    break
                    
                  
                    
            total_width += total_group_data_width         
            
            if total_width >= data_width:
                break
            
        
        
        
    
    result = "Total BRAM used :" + str(total_bram)
    print (result)
    print("")
    

def check_row_mwm (address_width_A, data_width_A, size_A, group_data_width, address_width_B, data_width_B):
    
    if(data_width_B != 0) | (address_width_B!=0):
        if (data_width_B != 0):    
        
            temp_address_width_B = int(0)
            
            if (data_width_A > data_width_B):
                if (data_width_A % data_width_B) != 0:
                    #print("In Mixed Width Mode, Don't support remainder that Data Width A divided by Data Width of B.")
                    print("In Mixed Width Mode, please apply the equation : data_width_A = data_width_b x (n power of 2). ")             
                    return False, 0, 0, 0, 0, 0, 0, 0 
                    
                temp_data_width_B = data_width_A    
                while (True ):
                    temp_data_width_B /= 2
                    if (temp_data_width_B <=  data_width_B):
                        break; 
                    
                if  temp_data_width_B !=  data_width_B:
                    print("In Mixed Width Mode, please apply the equation : data_width_A = data_width_b x (n power of 2). ")
                    return False, 0, 0, 0, 0, 0, 0, 0 
                    
                extend_addr =  (data_width_A / data_width_B) 
                
                temp_address_width_B = address_width_A + math.log2(extend_addr)
            
            elif (data_width_B > data_width_A):
                if (data_width_B % data_width_A) != 0:
                    #print("In Mixed Width Mode, Don't support remainder that Data Width B divided by Data Width of A.")
                    print("In Mixed Width Mode, please apply the equation : data_width_B = data_width_A x (n power of 2). ")
                    return False, 0, 0, 0, 0, 0, 0, 0 
                
                print(data_width_B, data_width_A)                
                temp_data_width_A = data_width_B    
                while (True ):
                    temp_data_width_A /= 2
                    if (temp_data_width_A <=  data_width_A):
                        break; 
                    
                if  temp_data_width_A !=  data_width_A:
                    print(temp_data_width_A, data_width_A)
                    print("In Mixed Width Mode, please apply the equation : data_width_B = data_width_A x (n power of 2). ")
                    return False, 0, 0, 0, 0, 0, 0, 0 
                    
                extend_addr =  (data_width_B / data_width_A) 
                
                temp_address_width_B = address_width_A - math.log2(extend_addr)    
            else: 
                temp_address_width_B = address_width_A
                
            if address_width_B != 0:
                if address_width_B < temp_address_width_B:
                   print("In Mixed Width Mode, the address_width_B is lesser than expected address_width. ")
                   return False, 0, 0, 0, 0, 0, 0, 0
            else:
                address_width_B = temp_address_width_B
 
        if (address_width_B != 0): 
            if address_width_B > address_width_A:
                if (data_width_B == 0):
                    addr_diff = address_width_B - address_width_A
                    temp_data_width_B = data_width_A
                    
                    for i in range (0,addr_diff):
                        temp_data_width_B /= 2
                    
                    if temp_data_width_B <= 0:
                       print("In Mixed Width Mode, please apply the equation : data_width_A = data_width_b X ( ( address_width_B - address_width_A  ) power of 2). ")
                       return False, 0, 0, 0, 0, 0, 0, 0 
                       
                    data_width_B = temp_data_width_B
                    
            if address_width_A > address_width_B:
                if (data_width_B == 0):
                    addr_diff = address_width_A - address_width_B
                    temp_data_width_B = data_width_A
                    
                    for i in range (0,addr_diff):
                        temp_data_width_B *= 2
                       
                    data_width_B = temp_data_width_B        
    
        size_B = 0
        if size_A != 0:
            if data_width_A !=  data_width_B:       
                #find Max Bram Address of Port A
                max_primitive_addressA = 0
                for row in bram_decompose_table:
                    primitive_data = bram_feature_table[row[0]][FEATURE.DATAW.value]
                    primitive_addr = bram_feature_table[row[0]][FEATURE.ADDRW.value]
                    if max_primitive_addressA < primitive_addr:
                        max_primitive_addressA = primitive_addr
            
                if (size_A % pow(2, max_primitive_addressA )) != 0: 
                    Rows = (size_A / pow(2, max_primitive_addressA ))+1
                    size_A = Rows * pow(2, max_primitive_addressA )        
            
        
            if data_width_A < data_width_B:
                size_B = size_A / ( data_width_B/data_width_A)    
            elif data_width_A > data_width_B:
                size_B = size_A * ( data_width_A/data_width_B)
            else:
                size_B = size_A
        
        
    return True, int(address_width_A), int (data_width_A), int(size_A), int(group_data_width), int(address_width_B), int(data_width_B), int(size_B) 
    
    

        
    
def find_mixed_width_row(index, targetRatio ):
    
    primitive_dataw = bram_feature_table[index][FEATURE.DATAW.value]
    compatible =  bram_feature_table[index][FEATURE.COMPATIBLE.value]
    TargetDataWidth = int(primitive_dataw*targetRatio)
    
    #print (TargetDataWidth, primitive_dataw, targetRatio)
    
    MaxDataWidth = primitive_dataw
    
    Index = 0
    MaxIndex = Index
    TargetIndex = Index
    
    result = False
    for feature in bram_feature_table:
        if feature[FEATURE.COMPATIBLE.value]  == compatible:
            if MaxDataWidth <= feature[FEATURE.DATAW.value]:
                MaxDataWidth = feature[FEATURE.DATAW.value]
                MaxIndex = Index
            if TargetDataWidth == feature[FEATURE.DATAW.value]:
                result = True
                TargetIndex = Index
                break
                
        Index += 1
    
    if result == False : 
        TargetIndex = MaxIndex
        TargetDataWidth = MaxDataWidth
    
    TargetAddressWidth = bram_feature_table[TargetIndex][FEATURE.ADDRW.value]
    
    return result, TargetIndex, TargetDataWidth, TargetAddressWidth
    

def create_decompose_table_scan_row(scan_index, address_width_A, data_width_A, size_A, group_data_width_A,  address_width_B, data_width_B, size_B, group_data_width_B): 
   
    total_width = 0
    total_bram  = 0
    row      = 0
    mixed_row =0
    global bram_decompose_mode
    global in_addr_width_a
    global in_data_width_a
    global in_addr_width_b
    global in_data_width_b   
    global byteen_width
    global byteen_width_A
    global byteen_width_B
    
    global byteen_enable
    global group_columns
    global bram_decompose_table  
    global bram_decompose_byteen_table
    global bram_mapping_table
    global rMux_mapping_table_A
    global rMux_mapping_table_B
    global wen_sel_mapping_table_A
    global wen_sel_mapping_table_B
    global actual_size_A
    global actual_size_B
    
    actual_size_A = pow(2,address_width_A)  
    if size_A != 0:
        if size_A <= actual_size_A:
            actual_size_A = size_A

    actual_size_B = pow(2,address_width_B)  
    if size_B != 0:
        if size_B <= actual_size_B:
            actual_size_B = size_B
    
    
    if data_width_A <= data_width_B:
        address_width    = address_width_A 
        data_width       = data_width_A 
        size             = size_A 
        group_data_width = group_data_width_A
        if data_width_A == data_width_B:
            if group_data_width_A > group_data_width_B:
                group_data_width = group_data_width_B
            
    else:
        address_width    = address_width_B 
        data_width       = data_width_B 
        size             = size_B 
        group_data_width = group_data_width_B
    
    mixed_total_width    = 0
    extend_row_index     = 0
    extend_data_width    = 0
    
    max_extend_row_index  = 0
    
    
       
    bram_decompose_byteen_table = list()
    group_columns = 1
    group_data_count = 0;
    group_data_ptr   = 0;
    for x in range(0, data_width):
        bram_data_row = [group_data_ptr,1]
        bram_decompose_byteen_table.append(bram_data_row)
        
        group_data_count += 1
        if(group_data_count == group_data_width):
            group_data_ptr += 1
            group_data_count = 0      
    
    if group_data_width != 0:
        byteen_width =  group_data_ptr
        byteen_enable = 1
        if ( ( data_width % group_data_width ) != 0):
            byteen_width += 1
        result = "byteen width: " + str(byteen_width) + " Group Data Width: " + str(group_data_width)
        byteen_width_A = byteen_width
        byteen_width_B = byteen_width
        print (result)

    
    bram_decompose_mode = 1 # 1: LOOP ROW FIRST", 0: LOOP COLUMN FIRST"
   
    total_address = pow(2,address_width)  
   
    if size != 0:
        if size <= total_address:
            total_address = size
    
    in_addr_width_a = address_width_A
    in_data_width_a = data_width_A
    in_addr_width_b = address_width_B
    in_data_width_b = data_width_B    
   
    bram_decompose_table = list()
    bram_mapping_table   = list()
    
    bram_mapping_table_index = 0
    
    if group_data_width == 0:
        group_data_width = data_width
        
    
    Max_addrw  = 0
    Min_addrw  = 1000
    mwm_ratio  = 1
       
    #Find Max Address Width 
    for feature in bram_feature_table:
        if Max_addrw < feature[FEATURE.ADDRW.value]:
            Max_addrw = feature[FEATURE.ADDRW.value]
    #Find Min Address Width 
    for feature in bram_feature_table:
        if Min_addrw > feature[FEATURE.ADDRW.value]:
            Min_addrw = feature[FEATURE.ADDRW.value]
        
    
    
    while True:

        index, columns, column_addrw, column_dataw = create_decompose_row(data_width, total_address,group_data_width)
        
       
        if(data_width_A != data_width_B):
            
            temp_total_address = total_address
            
            limit = 0
            while(True):
            
                print (limit, Max_addrw,Min_addrw, column_addrw, temp_total_address, address_width_B, address_width_A)
                
                if(column_addrw == Max_addrw):
                    break
                    
                if(data_width_A > data_width_B):
                    mwm_ratio = data_width_A/data_width_B
                    extend_mwm_addr = int(math.log2(mwm_ratio)); 

                    print ("A>B",column_addrw, (address_width_B+extend_mwm_addr), address_width_A, address_width_B, mwm_ratio, extend_mwm_addr, "Data",column_dataw,"Group", group_data_width )
                    if (column_addrw < (Min_addrw+extend_mwm_addr)) :
                    	
                        temp_total_address *= 2
                        index, columns, column_addrw, column_dataw = create_decompose_row(data_width, temp_total_address,group_data_width)
                    else: 
                        break
                        
                if (data_width_A < data_width_B):        
                    mwm_ratio = data_width_B/data_width_A
                    extend_mwm_addr = int(math.log2(mwm_ratio)); 

                    print ("B>A",column_addrw, (address_width_A+extend_mwm_addr), address_width_A, address_width_B, mwm_ratio, extend_mwm_addr, "Group", group_data_width )
                    if(column_addrw < (Min_addrw+extend_mwm_addr)) :    
                        temp_total_address *= 2
                        index, columns, column_addrw, column_dataw = create_decompose_row(data_width, temp_total_address,group_data_width)
                    else: 
                        break

                        
                limit += 1
                
                if limit > 10:
                    return 
       
        index_A = index
        index_B = index
        column_addr_A = column_addrw
        column_data_A = column_dataw
        
        column_addr_B = column_addrw
        column_data_B = column_dataw
        
       
        if(data_width_A != data_width_B):
            if data_width_A > data_width_B:
                mixedResult, mixedIndex, MixedDataWidth, MixedAddressWidth = find_mixed_width_row( index, int(data_width_A/data_width_B) )
                index_A = mixedIndex                    
                index_B = index
                
                column_addr_A = MixedAddressWidth
                column_data_A = MixedDataWidth
                
                
            elif data_width_A < data_width_B:                    
                mixedResult, mixedIndex, MixedDataWidth, MixedAddressWidth = find_mixed_width_row(index, int(data_width_B/data_width_A))
                index_A = index                    
                index_B = mixedIndex 
        
                column_addr_B = MixedAddressWidth
                column_data_B = MixedDataWidth
                
        
        
        
        bram_row = [index_A,index_B, columns,0,0] 
        bram_decompose_table.append(bram_row)
    
        total_address -= pow(2,column_addrw)
    
    
        total_width += column_dataw
        total_bram  += columns
        
        result = "row " + str(row) + ") Primitive index A: " + str(index_A) + " addrA "+ str(column_addr_A) + " dataA: " + str(column_data_A) + " index B: " + str(index_B) + " addrB "+ str(column_addr_B) + " dataB: " + str(column_data_B) +  " number of columns:" +str(columns)
        print (result)
   
       
        # Basic Mapping A
        
        #for x in range(0,  columns):
        #    
        #    data_start = byteen_index*group_data_width +  total_group_width
        #    data_end = data_start + column_dataw
        #    if data_end > data_width:
        #        data_end = data_width
        #    if data_end > ((byteen_index+1)*group_data_width):
        #        data_end = ((byteen_index+1)*group_data_width)
        #
        #    data_end -= 1
        #    nBits = data_end - data_start +1 
        #    interval = 0
        #    
        #    
        #    bram_map = [row,x,data_start,nBits,interval,row,row,row,byteen_index,data_start,nBits,interval,row,row,row,byteen_index]
        #
        #    if group_data_width != 0:
        #        total_group_width += column_dataw
        #        if total_group_width >=  group_data_width :
        #            total_group_width = 0
        #            byteen_index += 1
        #
        #    bram_mapping_table.append(bram_map)

        # Basic Mapping for Scan First
        
        # Mapping A
        data_start = 0
        byteen_index = 0
        total_group_width = 0
        
        for x in range(0,  columns):
            
            data_start = byteen_index*group_data_width +  total_group_width
            data_end = data_start + column_dataw
            if data_end > data_width:
                data_end = data_width
            if data_end > ((byteen_index+1)*group_data_width):
                data_end = ((byteen_index+1)*group_data_width)
        
            data_end -= 1
            Repeat = 0
            
            
            bram_map = [row,x,data_end,data_start,Repeat,row,row,row,byteen_index,data_end,data_start,Repeat,row,row,row,byteen_index, column_addr_A, column_data_A, column_addr_B, column_data_B]
        
            if group_data_width != 0:
                total_group_width += column_dataw
                if total_group_width >=  group_data_width :
                    total_group_width = 0
                    byteen_index += 1
        
            bram_mapping_table.append(bram_map)
        
        
        
        

        # Mapping A
        if data_width_A > data_width_B:
        
            if group_data_width_A == 0:
                group_data_width_A = data_width_A
                
        
            data_start = 0
            byteen_index = 0
            total_group_width = 0
            temp_data_width_A = 0
            
            for x in range(0,  columns):
                
                Repeat = int(column_data_A / column_data_B)
                
                bram_map_A = bram_mapping_table[bram_mapping_table_index + x] 
                              
                bram_map_A[2] += extend_row_index*extend_data_width
                bram_map_A[3] += extend_row_index*extend_data_width
                bram_map_A[4] = Repeat
                bram_map_A[5] = mixed_row
                bram_map_A[6] = mixed_row
                bram_map_A[7] = mixed_row
                bram_map_A[8] = byteen_index
            
               # print (bram_map_A)
            
                if group_data_width_A != 0:
                    total_group_width += column_data_A
                    if total_group_width >=  group_data_width_A :
                        total_group_width = 0
                        byteen_index += 1
                

                temp_data_width_A  += column_data_A                

                
            
                
            mixed_total_width +=  temp_data_width_A
            if mixed_total_width >= data_width_A:
                mixed_total_width = 0
                extend_row_index  = 0
                mixed_row += 1
            else: 
                extend_row_index += 1
                extend_data_width = temp_data_width_A
            
            
            if max_extend_row_index < extend_row_index:
                max_extend_row_index = extend_row_index

            
            #print (extend_row_index)    
            
            
        # Mapping B
        if data_width_A < data_width_B:
        
            if group_data_width_B == 0:
                group_data_width_B = data_width_B
                
        
            data_start = 0
            byteen_index = 0
            total_group_width = 0
            temp_data_width_B = 0
            
            for x in range(0,  columns):
                
                Repeat = int(column_data_B / column_data_A)
                
                bram_map_B = bram_mapping_table[bram_mapping_table_index + x] 
                        
                bram_map_B[9]  += extend_row_index*extend_data_width                
                bram_map_B[10] += extend_row_index*extend_data_width
                bram_map_B[11] = Repeat
                bram_map_B[12] = mixed_row
                bram_map_B[13] = mixed_row
                bram_map_B[14] = mixed_row
                bram_map_B[15] = byteen_index
            
               # print (bram_map_A)
            
                if group_data_width_B != 0:
                    total_group_width += column_data_B
                    if total_group_width >=  group_data_width_B :
                        total_group_width = 0
                        byteen_index += 1
                

                temp_data_width_B  += column_data_B
                
            mixed_total_width +=  temp_data_width_B
            if mixed_total_width >= data_width_B:
                mixed_total_width = 0
                extend_row_index  = 0
                mixed_row += 1
            else: 
                extend_row_index += 1
                extend_data_width = temp_data_width_B

            
            if max_extend_row_index < extend_row_index:
                max_extend_row_index = extend_row_index
            
            #print (extend_row_index)    

        
        if total_address <= 0:
            break
        
        bram_mapping_table_index += columns
        
        row += 1
    
    #find Max Bram Address of Port A
    max_primitive_addressA = 0
    
    for row in bram_decompose_table:
        primitive_data = bram_feature_table[row[0]][FEATURE.DATAW.value]
        primitive_addr = bram_feature_table[row[0]][FEATURE.ADDRW.value]
        if max_primitive_addressA < primitive_addr:
            max_primitive_addressA = primitive_addr
    
    max_primitive_addressB = 0

    for row in bram_decompose_table:
        primitive_data = bram_feature_table[row[1]][FEATURE.DATAW.value]
        primitive_addr = bram_feature_table[row[1]][FEATURE.ADDRW.value]
        if max_primitive_addressB < primitive_addr:
            max_primitive_addressB = primitive_addr
    
    max_rMux_index_A = 0;
    max_rMux_index_B = 0;
    for row in bram_mapping_table:
        if row[5] > max_rMux_index_A:
            max_rMux_index_A = row[5];
        if row[12] > max_rMux_index_B:
            max_rMux_index_B = row[12];


    max_WenSel_index_A = 0;
    max_WenSel_index_B = 0;
    for row in bram_mapping_table:
        if row[6] > max_WenSel_index_A:
            max_WenSel_index_A = row[6];
        if row[13] > max_WenSel_index_B:
            max_WenSel_index_B = row[13];

    

 
    rMux_mapping_table_A = list()
    rMux_mapping_table_B = list()
    
    wen_sel_mapping_table_A = list()
    wen_sel_mapping_table_B = list()
    
    
    if (len(bram_decompose_table) > 1   ):
    
        if (address_width_A> max_primitive_addressA):
            rMuxA = [address_width_A-1,max_primitive_addressA, data_width_A-1,0, max_rMux_index_A, 0 , 0]
            rMux_mapping_table_A.append(rMuxA)
        
            WenSelA = [address_width_A-1,max_primitive_addressA, max_WenSel_index_A,0 , 0]
            wen_sel_mapping_table_A.append(WenSelA)
            
            if max_extend_row_index != 0: 
           
                if data_width_A < data_width_B:
                    
                    mixed_addr_width  = int(max_primitive_addressA -max_primitive_addressB )
                    
                    extend_addr = int(math.log2(max_extend_row_index+1))
                    
                    for index in range(0,mixed_addr_width):
                        row = index
                        address_mapping_table_A.append(row)
                    
                    for index in range(0,extend_addr):
                        row = index + max_primitive_addressA
                        address_mapping_table_A.append(row)
                        
                    for index in range(mixed_addr_width,max_primitive_addressA):
                        row = index
                        address_mapping_table_A.append(row)
                        
                    for index in range(max_primitive_addressA+extend_addr,address_width_A):
                        row = index
                        address_mapping_table_A.append(row)
                        
       
        if (address_width_B> max_primitive_addressB):
            rMuxB = [address_width_B-1,max_primitive_addressB, data_width_B-1,0, max_rMux_index_B, 0, 0]
            rMux_mapping_table_B.append(rMuxB)
    
            WenSelB = [address_width_B-1,max_primitive_addressB, max_WenSel_index_B,0 , 0]
            wen_sel_mapping_table_B.append(WenSelB)
            
            if max_extend_row_index != 0:
             
                if data_width_B < data_width_A:
                    
                    mixed_addr_width  = int(max_primitive_addressB -max_primitive_addressA )
                
                    extend_addr = int(math.log2(max_extend_row_index+1))
                    
                    for index in range(0,mixed_addr_width):
                        row = index
                        address_mapping_table_B.append(row)
                    
                    for index in range(0,extend_addr):
                        row = index + max_primitive_addressB
                        address_mapping_table_B.append(row)
                        
                    for index in range(mixed_addr_width,max_primitive_addressB):
                        row = index
                        address_mapping_table_B.append(row)
                        
                    for index in range(max_primitive_addressB+extend_addr,address_width_B):
                        row = index
                        address_mapping_table_B.append(row)
            
        
    result = "Total BRAM used:" + str(total_bram)
    print (result) 
    print("")
 
#def create_decompose_table_scan_row(address_width, data_width, size, group_data_width ): 
#   
#    total_width = 0
#    total_bram  = 0
#    row      = 0
#    global bram_decompose_mode
#    global in_addr_width_a
#    global in_data_width_a
#    global in_addr_width_b
#    global in_data_width_b   
#    global byteen_width
#    global byteen_enable
#    global group_columns
#    global bram_decompose_table  
#    global bram_decompose_byteen_table
#    global bram_mapping_table
#    global rMux_mapping_table_A
#    global rMux_mapping_table_B
#    global wen_sel_mapping_table_A
#    global wen_sel_mapping_table_B
#    global actual_size
#       
#    bram_decompose_byteen_table = list()
#    group_columns = 1
#    group_data_count = 0;
#    group_data_ptr   = 0;
#    for x in range(0, data_width):
#        bram_data_row = [group_data_ptr,1]
#        bram_decompose_byteen_table.append(bram_data_row)
#        
#        group_data_count += 1
#        if(group_data_count == group_data_width):
#            group_data_ptr += 1
#            group_data_count = 0      
#    
#    if group_data_width != 0:
#        byteen_width =  group_data_ptr
#        byteen_enable = 1
#        if ( ( data_width % group_data_width ) != 0):
#            byteen_width += 1
#        result = "byteen width: " + str(byteen_width) + " Group Data Width: " + str(group_data_width)
#        print (result)
#
#    
#    bram_decompose_mode = 1 # 1: LOOP ROW FIRST", 0: LOOP COLUMN FIRST"
#   
#    total_address = pow(2,address_width)  
#   
#    if size != 0:
#        if size <= total_address:
#            total_address = size
#            
#    actual_size = total_address   
#
#    in_addr_width_a = address_width
#    in_data_width_a = data_width
#    in_addr_width_b = address_width
#    in_data_width_b = data_width    
#   
#    bram_decompose_table = list()
#    bram_mapping_table   = list()
#    
#    if group_data_width == 0:
#        group_data_width = data_width
#    while True:
#    
#        index, columns, column_addrw, column_dataw = create_decompose_row(data_width, total_address,group_data_width)
#        bram_row = [index,index, columns,0,0] 
#        bram_decompose_table.append(bram_row)
#    
#        total_address -= pow(2,column_addrw)
#    
#    
#        total_width += column_dataw
#        total_bram  += columns
#        
#        result = "row " + str(row) + ") Primitive index: " + str(index) + " addr"+ str(column_addrw) + " data: " + str(column_dataw) + " number of columns:" +str(columns)
#        print (result)
#   
#        data_start = 0
#        byteen_index = 0
#        total_group_width = 0 
#        for x in range(0,  columns):
#            
#            data_start = byteen_index*group_data_width +  total_group_width
#            data_end = data_start + column_dataw
#            if data_end > data_width:
#                data_end = data_width
#            if data_end > ((byteen_index+1)*group_data_width):
#                data_end = ((byteen_index+1)*group_data_width)
#        
#            data_end -= 1
#            nBits = data_end - data_start +1 
#            interval = 0
#            
#            
#            bram_map = [row,x,data_start,nBits,interval,row,row,row,byteen_index,data_start,nBits,interval,row,row,row,byteen_index]
#        
#            if group_data_width != 0:
#                total_group_width += column_dataw
#                if total_group_width >=  group_data_width :
#                    total_group_width = 0
#                    byteen_index += 1
#        
#            bram_mapping_table.append(bram_map)
#
#
#
#   
#        if total_address <= 0:
#            break
#            
#        row += 1
#    
#    #find Max Bram Address of Port A
#    max_primitive_addressA = 0
#    for row in bram_decompose_table:
#        primitive_data = bram_feature_table[row[0]][FEATURE.DATAW.value]
#        primitive_addr = bram_feature_table[row[0]][FEATURE.ADDRW.value]
#        if max_primitive_addressA < primitive_addr:
#            max_primitive_addressA = primitive_addr
#    
#    
#    max_primitive_addressB = 0
#    for row in bram_decompose_table:
#        primitive_data = bram_feature_table[row[1]][FEATURE.DATAW.value]
#        primitive_addr = bram_feature_table[row[1]][FEATURE.ADDRW.value]
#        if max_primitive_addressB < primitive_addr:
#            max_primitive_addressB = primitive_addr
#    
#    max_rMux_index_A = 0;
#    max_rMux_index_B = 0;
#    for row in bram_mapping_table:
#        if row[4] > max_rMux_index_A:
#            max_rMux_index_A = row[4];
#        if row[10] > max_rMux_index_B:
#            max_rMux_index_B = row[10];
# 
#    rMux_mapping_table_A = list()
#    rMux_mapping_table_B = list()
#    
#    wen_sel_mapping_table_A = list()
#    wen_sel_mapping_table_B = list()
#     
#    if (len(bram_decompose_table) > 1   ):
#        rMuxA = [address_width-1,max_primitive_addressA, data_width-1,0, max_rMux_index_A, 0]
#        rMux_mapping_table_A.append(rMuxA)
#       
#        rMuxB = [address_width-1,max_primitive_addressB, data_width-1,0, max_rMux_index_B, 0]
#        rMux_mapping_table_B.append(rMuxB)
#    
#        WenSelA = [address_width-1,max_primitive_addressB, len(bram_decompose_table)-1,0]
#        wen_sel_mapping_table_A.append(WenSelA)
#    
#        WenSelB = [address_width-1,max_primitive_addressB, len(bram_decompose_table)-1,0]
#        wen_sel_mapping_table_B.append(WenSelB)
#       
#    result = "Total BRam used:" + str(total_bram)
#    print (result) 


def mapping_mux_wen(address_width_A, data_width_A, address_width_B, data_width_B) :
   
    global bram_decompose_table  
    global bram_decompose_byteen_table
    global bram_mapping_table
    global rMux_mapping_table_A
    global rMux_mapping_table_B
    global wen_sel_mapping_table_A
    global wen_sel_mapping_table_B
    global address_mapping_table_A
    global address_mapping_table_B
    global byteen_width_A
    global byteen_width_B
    
    
    #find Max Bram Address of Port A
    max_primitive_addressA = 0
    
    for row in bram_decompose_table:
        primitive_data = bram_feature_table[row[0]][FEATURE.DATAW.value]
        primitive_addr = bram_feature_table[row[0]][FEATURE.ADDRW.value]
        if max_primitive_addressA < primitive_addr:
            max_primitive_addressA = primitive_addr
    
    max_primitive_addressB = 0

    for row in bram_decompose_table:
        primitive_data = bram_feature_table[row[1]][FEATURE.DATAW.value]
        primitive_addr = bram_feature_table[row[1]][FEATURE.ADDRW.value]
        if max_primitive_addressB < primitive_addr:
            max_primitive_addressB = primitive_addr
    
    max_rMux_index_A = 0;
    max_rMux_index_B = 0;
    for row in bram_mapping_table:
        if row[5] > max_rMux_index_A:
            max_rMux_index_A = row[5];
        if row[12] > max_rMux_index_B:
            max_rMux_index_B = row[12];


    max_WenSel_index_A = 0;
    max_WenSel_index_B = 0;
    for row in bram_mapping_table:
        if row[6] > max_WenSel_index_A:
            max_WenSel_index_A = row[6];
        if row[13] > max_WenSel_index_B:
            max_WenSel_index_B = row[13];
    max_extend_row_index=0

    if data_width_A > data_width_B :
        wen_sel_mapping_table_B = list()
        rMux_mapping_table_B = list()
        address_mapping_table_B = list()
        
        max_extend_row_index = data_width_A/data_width_B
        
        extend_addr = int(math.log2(max_extend_row_index+1))
        if (len(wen_sel_mapping_table_A)>0):
            for wen_sel_A in wen_sel_mapping_table_A:
            
                rMuxB = [wen_sel_A[0] + extend_addr, wen_sel_A[1], data_width_B-1,0, max_rMux_index_B, 0 , 0]
                rMux_mapping_table_B.append(rMuxB)
       
                WenSelB = [wen_sel_A[0] + extend_addr, wen_sel_A[1], max_WenSel_index_B,0 , 0]
                wen_sel_mapping_table_B.append(WenSelB)
        
        else:
            rMuxB = [max_primitive_addressA + extend_addr - 1,max_primitive_addressA, data_width_B-1,0, max_rMux_index_B, 0 , 0]
            rMux_mapping_table_B.append(rMuxB)
       
            WenSelB = [max_primitive_addressA + extend_addr - 1,max_primitive_addressA, max_WenSel_index_B,0 , 0]
            wen_sel_mapping_table_B.append(WenSelB)
            
        for index in range(0,extend_addr):
            row = index + max_primitive_addressA
            address_mapping_table_B.append(row)
            
        for index in range(0,max_primitive_addressA):
            row = index
            address_mapping_table_B.append(row)
            
        for index in range(max_primitive_addressA+extend_addr,address_width_B):
            row = index
            address_mapping_table_B.append(row)

        
        
    
        

    if data_width_B > data_width_A :
        wen_sel_mapping_table_A = list()
        rMux_mapping_table_A = list()
        address_mapping_table_A = list()
        
        max_extend_row_index = data_width_B/data_width_A
        
        extend_addr = int(math.log2(max_extend_row_index+1))
        if (len(wen_sel_mapping_table_A)>0):
            for wen_sel_B in wen_sel_mapping_table_B:
            
                rMuxA = [wen_sel_B[0] + extend_addr, wen_sel_B[1], data_width_A-1,0, max_rMux_index_A, 0 , 0]
                rMux_mapping_table_A.append(rMuxA)
       
                WenSelA = [wen_sel_B[0] + extend_addr, wen_sel_B[1], max_WenSel_index_A,0 , 0]
                wen_sel_mapping_table_A.append(WenSelA)
        
        else:
            rMuxA = [max_primitive_addressB + extend_addr - 1,max_primitive_addressB, data_width_A-1,0, max_rMux_index_A, 0 , 0]
            rMux_mapping_table_A.append(rMuxA)
       
            WenSelA = [max_primitive_addressB + extend_addr - 1,max_primitive_addressB, max_WenSel_index_A,0 , 0]
            wen_sel_mapping_table_A.append(WenSelA)
            
        for index in range(0,extend_addr):
            row = index + max_primitive_addressB
            address_mapping_table_A.append(row)
            
        for index in range(0,max_primitive_addressB):
            row = index
            address_mapping_table_A.append(row)
            
        for index in range(max_primitive_addressB+extend_addr,address_width_A):
            row = index
            address_mapping_table_A.append(row)
       
    
    
 
def create_decompose_table_scan_row_mwm(address_width_A, data_width_A, size, group_data_width, address_width_B, data_width_B, group_data_width_B, memory_type):
    
    result = True
    if(data_width_B != 0) | (address_width_B!=0):
       result, address_width_A, data_width_A, size_A, group_data_width, address_width_B, data_width_B, size_B  =  check_row_mwm (address_width_A, data_width_A, size, group_data_width, address_width_B, data_width_B)    
    else:
        size_A = size
        size_B = size
        
    
    if result == False:
        print("Error! don't support current setting in Mixed Width Mode ")
        return 
    
    print (address_width_A, data_width_A, size_A, group_data_width, address_width_B, data_width_B, size_B, group_data_width_B)
    
    scan_index = 0
    
    if (data_width_B == 0) | (data_width_B == data_width_A) :
        create_decompose_table_scan_row(scan_index, address_width_A, data_width_A, size_A, group_data_width,  address_width_A, data_width_A, size_A, group_data_width_B)
    
    
    else:# Mixed Width Mode
        print("Mixed Width Mode is Enabled!")
        if data_width_A > data_width_B:
            scan_index = 1
            
        #separate tdp and sdp since tdp doesnt want to pickup default gdw=8
        if args.memory_type == 'sdp_ram': 
        	create_decompose_table_scan_row(scan_index, address_width_A, data_width_A, size_A, group_data_width,  address_width_B, data_width_B, size_B, group_data_width_B)
        elif args.memory_type == 'tdp_ram':
        	group_data_width = 0
        	group_data_width_B = 0
        	create_decompose_table_scan_row(scan_index, address_width_A, data_width_A, size_A, group_data_width,  address_width_B, data_width_B, size_B, group_data_width_B)
        
        #result = "group_data_width:" + str(group_data_width) + " group_data_width_B: " + str(group_data_width_B)
        #print(result)


def create_decompose_table_scan_row_mwm_byteEn(address_width_A, data_width_A, size, group_data_width, address_width_B, data_width_B, group_data_width_A, group_data_width_B, memory_type):
    
    global in_addr_width_a
    global in_data_width_a
    global in_addr_width_b
    global in_data_width_b 
    global byteen_width_A
    global byteen_width_B
    global actual_size_A
    global actual_size_B
    
       
    result = True
    if(data_width_B != 0) | (address_width_B!=0):
       result, address_width_A, data_width_A, size_A, group_data_width, address_width_B, data_width_B, size_B  =  check_row_mwm (address_width_A, data_width_A, size, group_data_width, address_width_B, data_width_B)    
    else:
        size_A = size
        size_B = size
        
    
    if result == False:
        print("Error! don't support current setting in Mixed Width Mode ")
        return  
        
    if (group_data_width_A == 0):
        if(group_data_width !=0):
            group_data_width_A = group_data_width
        else: 
            print("Please input paramter group_data_width_A or group_data_width ")
            return  
    
    if (group_data_width_B == 0):
        if(group_data_width !=0):
            group_data_width_B = group_data_width
        else: 
            print("Please input paramter group_data_width_B or group_data_width ")
            return  
                
    if(data_width_A == data_width_B):
        create_decompose_table_scan_row_mwm(address_width_A, data_width_A, size, group_data_width_A, address_width_A, data_width_A, group_data_width_B, memory_type)
             
        Max_byteen_index_A = 0
        Max_byteen_index_B = 0

        
        for row in bram_mapping_table:
            msb_data_A = row[3]
            msb_data_B = row[9] 
            
            byteen_index_A = int( (msb_data_A) / group_data_width_A )
            byteen_index_B = int( (msb_data_B) / group_data_width_B )           
            
            if byteen_index_A> Max_byteen_index_A :
                Max_byteen_index_A = byteen_index_A
                
            if byteen_index_B> Max_byteen_index_B :
                Max_byteen_index_B = byteen_index_B    
            
            row[8] = byteen_index_A  
            row[15]= byteen_index_B
            
            
            
            byteen_width_A =  Max_byteen_index_A+1
            byteen_width_B =  Max_byteen_index_B+1
                
        
    elif (data_width_A > data_width_B):     
        create_decompose_table_scan_row_mwm(address_width_A, data_width_A, size, group_data_width_A, address_width_A, data_width_A, group_data_width_A, memory_type)
        
        print("MWM remapping Byte Enable mode")
             
        current_data_ptr = 0 
        
        group_data_ptr = 0 
        
        
        row_index = 0
        byteen_index = 0
        
        
        for row in bram_mapping_table:
            
            index_row    = row[0]    
            index_column = row[1]    
            
            msb_data_A   = row[2]    
            lsb_data_A   = row[3]
        
            primitive_dataB = row[19]
          
            
            row_index   =   int(msb_data_A/data_width_B)
            
            lsb_data_B  =   int(lsb_data_A%data_width_B)
            msb_data_B  =   int(msb_data_A%data_width_B)
            
            byteen_index =  int(lsb_data_B/group_data_width_B)
            
            row[9]  = msb_data_B
            row[10] = lsb_data_B
            
            row[12] = row_index
            row[13] = row_index
            row[14] = row_index
            row[15] = byteen_index
            
             
         #   lsb_data_B   = current_data_ptr
         #   
         #   msb_data_B   = current_data_ptr + primitive_dataB
         #
         #              
         #   if(msb_data_B>= data_width_B):
         #       msb_data_B = data_width_B
         #          
         #   row[9]  = msb_data_B-1
         #   row[10] = lsb_data_B
         #   
         #   row[12] = row_index
         #   row[13] = row_index
         #   row[14] = row_index
         #   row[15] = byteen_index
            
           
         #   current_data_ptr += primitive_dataB
         #   if(current_data_ptr>= data_width_B):
         #       current_data_ptr = 0
         #       group_data_ptr = 0
         #       byteen_index = 0
         #       row_index += 1
         #   
         #   else: 
         #       group_data_ptr += primitive_dataB
         #       if (group_data_ptr >= group_data_width_B):
         #           group_data_ptr = 0
         #           byteen_index += 1;

        print("Mapping ", address_width_A, data_width_A, address_width_B, data_width_B)
        mapping_mux_wen(address_width_A, data_width_A, address_width_B, data_width_B)
        
        in_addr_width_a = address_width_A
        in_data_width_a = data_width_A
        in_addr_width_b = address_width_B
        in_data_width_b = data_width_B    
        
        byteen_width_A = int(data_width_A / group_data_width_A)
        byteen_width_B = int(data_width_B / group_data_width_B)
            
        actual_size_A = pow(2,address_width_A)  
        if size_A != 0:
            if size_A <= actual_size_A:
                actual_size_A = size_A
    
        actual_size_B = pow(2,address_width_B)  
        if size_B != 0:
            if size_B <= actual_size_B:
                actual_size_B = size_B
        

        print("PortA: ", in_addr_width_a, in_data_width_a, actual_size_A, group_data_width_A, byteen_width_A)
        print("PortB: ", in_addr_width_b, in_data_width_b, actual_size_B, group_data_width_B, byteen_width_B)
        print("")
        
    elif (data_width_A < data_width_B):     
        create_decompose_table_scan_row_mwm(address_width_B, data_width_B, size, group_data_width_B, address_width_B, data_width_B, group_data_width_B, memory_type)

        print("MWM remapping Byte Enable mode")
        
        current_data_ptr = 0 
        
        group_data_ptr = 0 
        
        
        row_index = 0
        byteen_index = 0
        
        
        for row in bram_mapping_table:
            
            index_row    = row[0]    
            index_column = row[1]    
            
            msb_data_B   = row[9]    
            lsb_data_B   = row[10]
        
            primitive_dataA = row[17]
            
            row_index   =   int(msb_data_B/data_width_A)
            
            lsb_data_A  =   int(lsb_data_B%data_width_A)
            msb_data_A  =   int(msb_data_B%data_width_A)
            
            byteen_index =  int(lsb_data_A/group_data_width_A)
            
            row[2]  = msb_data_A
            row[3]  = lsb_data_A
            
            row[5] = row_index
            row[6] = row_index
            row[7] = row_index
            row[8] = byteen_index
             
            #lsb_data_A   = current_data_ptr
            #
            #msb_data_A   = current_data_ptr + primitive_dataA
            #
            #
            #if(msb_data_A>= data_width_A):
            #    msb_data_A = data_width_A
            #          
            #row[2]  = msb_data_A-1
            #row[3]  = lsb_data_A
            #
            #row[5] = row_index
            #row[6] = row_index
            #row[7] = row_index
            #row[8] = byteen_index
            #
            #
            #current_data_ptr += primitive_dataA
            #if(current_data_ptr>= data_width_A):
            #    current_data_ptr = 0
            #    group_data_ptr = 0
            #    byteen_index = 0
            #    row_index += 1
            #
            #else: 
            #    group_data_ptr += primitive_dataA
            #    if (group_data_ptr >= group_data_width_A):
            #        group_data_ptr = 0
            #        byteen_index += 1;

        print("Mapping ", address_width_A, data_width_A, address_width_B, data_width_B)
        mapping_mux_wen(address_width_A, data_width_A, address_width_B, data_width_B)
        
        in_addr_width_a = address_width_A
        in_data_width_a = data_width_A
        in_addr_width_b = address_width_B
        in_data_width_b = data_width_B    
        
        if (group_data_width_A != 0):
            byteen_width_A = int(data_width_A / group_data_width_A)
        
        if (group_data_width_B != 0):
            byteen_width_B = int(data_width_B / group_data_width_B) 
            
        actual_size_A = pow(2,address_width_A)  
        if size_A != 0:
            if size_A <= actual_size_A:
                actual_size_A = size_A
    
        actual_size_B = pow(2,address_width_B)  
        if size_B != 0:
            if size_B <= actual_size_B:
                actual_size_B = size_B
                
                
        print("PortA: ", in_addr_width_a, in_data_width_a, actual_size_A, group_data_width_A, byteen_width_A)
        print("PortB: ", in_addr_width_b, in_data_width_b, actual_size_B, group_data_width_B, byteen_width_B)         
        print("")        
                
                
def write_config_file():

    config_param = list()
    
    config_param.append(FAMILY)
    config_param.append(in_addr_width_a)
    config_param.append(in_data_width_a)
    config_param.append(in_addr_width_b)
    config_param.append(in_data_width_b)
    
    config_param.append(actual_size_A)
    config_param.append(actual_size_B)
    config_param.append(byteen_width)
    config_param.append(group_data_width)
    config_param.append(group_columns)
    
    config_param.append(bram_decompose_mode)
    config_param.append(bram_feature_table)
    config_param.append(group_columns)
    
    config_param.append(bram_decompose_table)
    config_param.append(bram_mapping_table)
    config_param.append(rMux_mapping_table_A)
    config_param.append(wen_sel_mapping_table_A)
    config_param.append(rMux_mapping_table_B)
    config_param.append(wen_sel_mapping_table_B)
    
    config_param.append(data_mapping_table_A)
    config_param.append(data_mapping_table_B)
    
    config_param.append(address_mapping_table_A)
    config_param.append(address_mapping_table_B)
   
    with open('mem_config.txt', 'w') as f:
        f.write(json.dumps(config_param))

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Memory Decompose to BRAM')
    parser.add_argument("memory_type", choices=['sp_ram', 'sdp_ram', 'tdp_ram'], help="Memory type")
    parser.add_argument("address_width", help="Address Width")
    parser.add_argument("data_width",    help="Data Width")
    parser.add_argument("--size",        default=0, help="Memory Size, it will be limited by the address_width")
    parser.add_argument("--address_width_B", default=0, help="address width of Port B or Read Port")
    parser.add_argument("--data_width_B"   , default=0, help="data width of Port B or Read Port")
    parser.add_argument("--family",      choices=['Trion', 'Titanium'], default='Trion', help="Device family (SVF only)")
    parser.add_argument("--decompose",   choices=['area', 'speed'], default='speed',      help="Decompose mode")
    parser.add_argument("--group_data_width",default=8,help="Group data width for each byteen Enable. If 0, it will disable byte enable.")
    parser.add_argument("--group_data_width_A",default=0,help="Group data width for each byteen Enable in Port A. If 0, it will disable byte enable.")
    parser.add_argument("--group_data_width_B",default=0,help="Group data width for each byteen Enable in Port B. If 0, it will disable byte enable.")
    
    
    # run parser
    args = parser.parse_args()
    
    if args.memory_type == 'sp_ram':
        print("\nSingle-port RAM")
        print("-----------------")
 
        if args.family == 'Titanium':
            bram_feature_table = EFX_RAM10_feature_table
            FAMILY  = 1
        elif args.family == 'Trion':
            bram_feature_table = EFX_RAM_5K_feature_table
            FAMILY  = 0      
                  
        if args.decompose == 'speed':
            if ((args.data_width_B == 0 )|(args.data_width==args.data_width_B)) & ((args.address_width_B == 0 )|(args.address_width==args.address_width_B)):
                create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width), str(args.memory_type))
            else:
                print("Single Port RAM has no Mixed Width Mode ! \n")    
        
                #if args.family == 'Titanium':
                #    bram_feature_table = EFX_RAM10_MWM_feature_table
                #    FAMILY  = 1
                #elif args.family == 'Trion':
                #    bram_feature_table = EFX_RAM_5K_MWM_feature_table
                #    FAMILY  = 0 
                #    
                #create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width))     
                    
                    
        elif args.decompose == 'area':
        	print("Currently support decompose-Speed Mode only\n")
            #if (args.data_width_B == 0 ) & (args.address_width_B == 0 ): 
            #    create_decompose_table_scan_col(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B))
            #else:
            #    print("Area Mode don't support Mixed Width Mode./n ")
            
        group_data_width = args.group_data_width
        group_data_width_A = args.group_data_width_A
        group_data_width_B = args.group_data_width_B 
  
 
        #create_feature_file()
        create_decompose_file()
        create_memory_init_file()
        
        write_config_file()
    
    elif   args.memory_type == 'sdp_ram':
        print("\nSimple Dual-port RAM")
        print("----------------------")
        
        
        if args.family == 'Titanium':
            bram_feature_table = EFX_RAM10_feature_table
            FAMILY  = 1
        elif args.family == 'Trion':
            bram_feature_table = EFX_RAM_5K_feature_table
            FAMILY  = 0      
                  
        if ((args.data_width_B == 0 )|(args.data_width==args.data_width_B)) & ((args.address_width_B == 0 )|(args.address_width==args.address_width_B)): 
            args.data_width_B = args.data_width
            args.address_width_B = args.address_width
            if args.decompose == 'speed':
                if (args.group_data_width == 0) & (args.group_data_width_A == 0) & (args.group_data_width_B == 0) : 
                    create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width), str(args.memory_type))
                else:
                    print("Byte Enable Mode!")    
                    create_decompose_table_scan_row_mwm_byteEn(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width_A),int(args.group_data_width_B), str(args.memory_type))    
                
            elif args.decompose == 'area':
            	print("Currently Support decompose-Speed Mode only\n")
                #create_decompose_table_scan_col(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B))
        else:
            print("Mixed Width Mode is Enabled!")    
        
            if args.family == 'Titanium':
                bram_feature_table = EFX_RAM10_MWM_feature_table
                FAMILY  = 1
            elif args.family == 'Trion':
                bram_feature_table = EFX_RAM_5K_MWM_feature_table
                FAMILY  = 0 
            
            if (args.group_data_width == 0) & (args.group_data_width_A == 0) & (args.group_data_width_B == 0) : 
                if args.decompose == 'speed':
                    print("Speed Mode.")  
                    create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width), str(args.memory_type))
                    
                elif args.decompose == 'area':
                    print("Area Mode don't support Mixed Width Configuration ")  
                    
                
            else:
                print("Byte Enable Mode!")    
                
                if args.decompose == 'speed':
                	print("Speed Mode")
                	create_decompose_table_scan_row_mwm_byteEn(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width_A),int(args.group_data_width_B), str(args.memory_type))
                
                elif args.decompose == 'area':
                	print("Area Mode")
                	print("------------------------------------------------------- ")
                	print("Oopps! Area Mode dont support Mixed Width Configuration \n")
            	
                
        
      
        group_data_width = args.group_data_width
        group_data_width_A = args.group_data_width_A
        group_data_width_B = args.group_data_width_B 
  
 
        #create_feature_file()
        create_decompose_file()
        create_memory_init_file()
        
        write_config_file()
        
    elif args.memory_type == 'tdp_ram':
        print("\nTrue Dual-port RAM")
        print("-------------------")
        
        #if (args.group_data_width_A ==0) & (args.group_data_width_B ==0):
        #    if (args.group_data_width != 0 ):
        #        print("Please use the group_data_width_A or group_data_width_B to define group data width of corresponding port. ")
        
        
        if args.family == 'Titanium':
            bram_feature_table = EFX_DPRAM10_feature_table
            FAMILY  = 1
        elif args.family == 'Trion':
            bram_feature_table = EFX_DPRAM_5K_feature_table
            FAMILY  = 0 
        
        
        if ((args.data_width_B == 0 )|(args.data_width==args.data_width_B)) & ((args.address_width_B == 0 )|(args.address_width==args.address_width_B)): 
            args.data_width_B = args.data_width
            args.address_width_B = args.address_width
            if args.decompose == 'speed':
                if (args.group_data_width == 0) & (args.group_data_width_A == 0) & (args.group_data_width_B == 0) : 
                    create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width), str(args.memory_type))
                else:
                    print("Byte Enable Mode!")    
                    create_decompose_table_scan_row_mwm_byteEn(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width_A),int(args.group_data_width_B), str(args.memory_type))    
                
            elif args.decompose == 'area':
            	print("Current support decompose-Speed Mode only\n")
                #create_decompose_table_scan_col(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B))
        else:
            print("Mixed Width Mode is Enabled!")
            print("Oopps! Currently not support Mixed Width Mode!\n")
        
            #if args.family == 'Titanium':
            #    bram_feature_table = EFX_DPRAM10_MWM_feature_table
            #    FAMILY  = 1
            #elif args.family == 'Trion':
            #    bram_feature_table = EFX_DPRAM_5K_MWM_feature_table
            #    FAMILY  = 0 
            #    
            #if (args.group_data_width_A == 0) & (args.group_data_width_B == 0) : 
            #    if args.decompose == 'speed':
            #        print("Speed Mode")  
            #        create_decompose_table_scan_row_mwm(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width), str(args.memory_type))
            #        
            #    elif args.decompose == 'area':
            #        print("Area Mode don't support Mixed Width Case ")  
                    
                
            if (args.group_data_width_A != 0) & (args.group_data_width_B != 0):
                print("Byte Enable Mode!")
                print("Oopps! Currently not support Byte Enable Mode!\n")
                
                #if args.decompose == 'speed':
                #	create_decompose_table_scan_row_mwm_byteEn(int(args.address_width), int(args.data_width), int(args.size), int(args.group_data_width), int(args.address_width_B), int(args.data_width_B), int(args.group_data_width_A),int(args.group_data_width_B), str(args.memory_type))
                #elif args.decompose == 'area':
                #	print("Area Mode dont support Mixed Width Case")
                
                
        
        group_data_width   = args.group_data_width
        group_data_width_A = args.group_data_width_A
        group_data_width_B = args.group_data_width_B 
        
        #create_feature_file()
        create_decompose_file()
        create_memory_init_file()
        
        write_config_file()
        
    
           
  