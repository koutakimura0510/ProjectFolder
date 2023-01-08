"""

Copyright (C) 2022 Efinix Inc. All rights reserved.

No portion of this code may be reused, modified or
distributed in any way without the expressed written
consent of Efinix Inc.

Created on Dec 22, 2021

@author: Dragon Lai
"""
import sys
import os
import argparse
import math
import json

from enum import Enum

FAMILY = 0
in_addr_width_a = 0
in_data_width_a = 0
in_addr_width_b = 0
in_data_width_b = 0

actual_size_A = 0
actual_size_B = 0
byteen_width = 0
group_data_width = 0
group_columns = 0

bram_decompose_mode = 0
bram_feature_table = list()
group_columns = list()

bram_decompose_table = list()
bram_mapping_table = list()
rMux_mapping_table_A = list()
wen_sel_mapping_table_A = list()
rMux_mapping_table_B = list()
wen_sel_mapping_table_B = list()

data_mapping_table_A = list()
data_mapping_table_B = list()

address_mapping_table_A = list()
address_mapping_table_B = list()


mem_table = list()

def remove_comment(InString):
    
    result = False 

    outString = InString

    #find comment sytnax '//'
    Index_start = InString.find('//')
  
  
    #find end of line \n after //  
    if (Index_start != -1  ):
        Index_end = InString.find('\n',Index_start)
        
        if (Index_end == -1):
            Index_end = len(InString)
       
        if (Index_start == 0 ):
            outString = InString[Index_end:] 
        else:
            outString = InString[:Index_start] + InString[Index_end:]
       
        result = True
        
    return result, outString
        
def remove_comments(InString):

    result = True
    TempString = InString
    
    while(result):
        result, OutString = remove_comment(TempString)
        TempString = OutString
        
    return OutString
    
def dump2memTable(InString,in_format, port, in_data_width, in_addr_width):
    ProcesseData = remove_comments(InString)
    
    #print( in_format, in_data_width, in_addr_width)
    
    #print(ProcesseData)  

    lines = ProcesseData.split()    

    #print(lines)
    
    bit_count = 1 
    
    if (in_format == 'hex'):
        bit_count = 4
    
    line_ptr = 0
    for line in lines:
        if  (line_ptr+1) > (2**in_addr_width):
            break
        
        bit_ptr = 0
        
        for bits in reversed(line): 
        
            if (bit_ptr+1) > in_data_width: 
                break
            
            value = int(bits, 16)
            
            
            for x in range(0,bit_count):
            #    print ( line_ptr, bit_ptr)
                if (bit_ptr+1) > in_data_width: 
                    break
            
                mem_table[line_ptr][bit_ptr] = (value % 2)
                
                value = int(value / 2)
                bit_ptr = bit_ptr + 1
                
        #print(mem_table[line_ptr])
        line_ptr = line_ptr+1
        
        
    #print(mem_table)
    create_memory_init_file(port,in_data_width, in_addr_width )
    

def create_prmitive_map(data_width, addr_width, primitive_addr_width, primiive_data_width, map_data_msb, map_data_lsb, repeat, interval, row_index):
    
    #print(data_width, addr_width, primitive_addr_width,  primiive_data_width, map_data_msb, map_data_lsb, repeat, row_index) 
    #print(data_width, addr_width, primitive_addr_width, primiive_data_width, map_data_msb, map_data_lsb, repeat, interval, row_index)    
    
    primitive_mem = list()
    
    #initial primitive memory profile
    for y in range(0,(2**primitive_addr_width)):
        row = list() 
        for x in range(0,primiive_data_width): 
            row.append(int(0))
        primitive_mem.append(row)
    
    
    primitive_y = int(0)
    primitive_x = int(0)
    
    addr_start = row_index    * (2**primitive_addr_width)
    addr_End   = (row_index+1)* (2**primitive_addr_width) -1
    
    #print(addr_start, addr_End, primiive_data_width, map_data_lsb,map_data_msb  )
    
    if(addr_End > (2**addr_width)-1):
        addr_End = (2**addr_width)-1
    
    for y in range(addr_start, addr_End+1  ):
        init_row = mem_table[y]
      
        primitive_x = int(0)
        if repeat == 0:
            for x in range(map_data_lsb, map_data_msb +1 ) :
                if (primitive_x+1) > primiive_data_width:
                    break
                
                primitive_mem[primitive_y][primitive_x] = init_row[x]
                primitive_x = primitive_x+1
                
            #if (map_data_lsb == 10 ):
            #    print (y, primitive_y,primitive_x, primitive_mem[primitive_y], init_row, map_data_lsb,( map_data_msb-map_data_lsb) +1 )
        else: 
            for r_x in range(0,repeat):  
                temp_data_lsb = map_data_lsb + (interval * r_x)   
                temp_data_msb = map_data_msb + (interval * r_x)
                for x in range(temp_data_lsb, temp_data_msb +1 ) :
                    if (primitive_x+1) > primiive_data_width:
                        break
                    
                    primitive_mem[primitive_y][primitive_x] = init_row[x]
                    primitive_x = primitive_x+1
        
        primitive_y = primitive_y+1
        
        
    #print(primitive_mem)    
    converted_init_mem = list()
       
    #initial primitive init profile    
    for y in range(0,40):
        row =list()
        for x in range(0,32): 
            row.append(int(0))
        converted_init_mem.append(row)


    #initial primitive memory profile
    
    primitive_bit_ptr = int(0)
    primitive_byte    = int(0)
    
    primitive_x_ptr   = int(31)
    primitive_y_ptr   = int(0)
    
    
    for y in range(0,(2**primitive_addr_width)): 
        for x in range(0,primiive_data_width): 
            primitive_byte = primitive_byte + primitive_mem[y][x] * (2** primitive_bit_ptr)
            
            primitive_bit_ptr = primitive_bit_ptr + 1
            if primitive_bit_ptr >= 8:
                converted_init_mem[primitive_y_ptr][primitive_x_ptr]  = primitive_byte
                primitive_bit_ptr = 0
                primitive_byte = 0
                
                primitive_x_ptr = primitive_x_ptr-1
                if primitive_x_ptr < 0:
                    primitive_x_ptr = 31
                    
                    primitive_y_ptr = primitive_y_ptr +1
                    if primitive_y_ptr >= 40:
                        break   


    return  converted_init_mem                   
    
def create_memory_init_file(port, data_width, addr_width ):
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
    
        index_primitive_row    = row[0]
        index_primitive_column = row[1]

        DataA_MSB              = row[2]
        DataA_LSB              = row[3]
        DataA_REPEAT           = row[4]
        DataA_RdMux            = row[5]
        
        DataB_MSB              = row[9]
        DataB_LSB              = row[10]
        DataB_REPEAT           = row[11]
        DataB_RdMux            = row[12]
        
        
        primitive_addrW_A       = row[16] 
        primitive_dataW_A       = row[17] 
        primitive_addrW_B       = row[18] 
        primitive_dataW_B       = row[19]
        
        maptable = list()
        
        if port == 'a': 
            maptable = create_prmitive_map(data_width, addr_width, primitive_addrW_A, primitive_dataW_A, DataA_MSB, DataA_LSB, DataA_REPEAT, in_data_width_b, DataA_RdMux)
            
        
        elif port == 'b': 
            maptable = create_prmitive_map(data_width, addr_width, primitive_addrW_B, primitive_dataW_B, DataB_MSB, DataB_LSB, DataB_REPEAT, in_data_width_a, DataB_RdMux)
           
        
      
      
        stringline = ""
        
        for Values in maptable:
            stringline ="256'h"    
            for value in Values: 
                stringline +=  '%02x' % (value)
      
            line += '(val_==%2s)?' % (x)
            line += stringline
            line += ":\n"
            x = x + 1
        line += '0;\n'    
        f.write (line)        

          
        #stringline ="256'h"
        #for hexChar in range(0,32):
        #   #stringline +=  '%02x' % (y)
        #   stringline +=  '%02x' % (0)
        #
        #
        #for x in range(0,  40):
        #    #line += '(val_==' + str(x) + ')?' + str(feature) + ':'
        #    line += '(val_==%2s)?' % (x)
        #    
        #    line += stringline
        #   #line += "256'h0000000000000000000000000000000000000000000000000000000000000000"
        #    
        #    line += ":\n"
        #    x = x + 1
        #line += '0;\n'
        #f.write (line)
        
        
        
        y = y +1
    
    
    line =  ""   
    line += "   endcase\n"
    line += "endfunction  \n"
    f.write (line)
    
    
    
    
    f.close()    
    
if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Memory Decompose to BRAM')
    parser.add_argument("format", choices=['hex', 'bin'], help="Memory file format")
    parser.add_argument("init_file", help="Input file name")
    parser.add_argument("--port",      choices=['a', 'b'], default='b', help="inital data width based on port A(Write) , or port B(Read)")
    
    
    # run parser
    args = parser.parse_args()
    text_file = open(args.init_file, "r")
    
    try:
        with open('mem_config.txt', 'r') as f:
            mem_config = json.loads(f.read())
            FAMILY = mem_config[0]
            in_addr_width_a = mem_config[1]
            in_data_width_a = mem_config[2]
            in_addr_width_b = mem_config[3]
            in_data_width_b = mem_config[4]
            
            actual_size_A = mem_config[5]
            actual_size_B = mem_config[6]
            byteen_width = mem_config[7]
            group_data_width = mem_config[8]
            group_columns = mem_config[9]
            
            bram_decompose_mode = mem_config[10]
            bram_feature_table = mem_config[11]
            group_columns = mem_config[12]
            
            bram_decompose_table = mem_config[13]
            bram_mapping_table = mem_config[14]
            rMux_mapping_table_A = mem_config[15]
            wen_sel_mapping_table_A = mem_config[16]
            rMux_mapping_table_B = mem_config[17]
            wen_sel_mapping_table_B = mem_config[18]
            
            data_mapping_table_A = mem_config[19]
            data_mapping_table_B = mem_config[20]
            
            address_mapping_table_A = mem_config[21]
            address_mapping_table_B = mem_config[22]
            
            data_width = 0
            addr_width = 0
            
            
            if args.port == 'a':
                data_width = in_data_width_a
                addr_width = in_addr_width_a
                
            elif args.port == 'b':
                data_width = in_data_width_b
                addr_width = in_addr_width_b
            
            for y in range(0,2 ** addr_width):
                column = list()
                for x in range(0,data_width):
                    column.append(0)
                mem_table.append(column)
            
            
            
            
            #read whole file to a string
            InString = text_file.read()
            result = "Data width = " + str(data_width) + " Address width = " + str(addr_width)
            print (result)
            print ("Status : Memory Initialization has completed")
            dump2memTable(InString,args.format,args.port, data_width, addr_width)    
            
            #close file
            text_file.close()        
            
            
            
    except OSError as e:
        print(f"{type(e)}: {e}")
    
    

    
    
    
    
 
    
    
 