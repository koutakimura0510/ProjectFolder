################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/Graphic/animation/display_shift/display_shift_tb.cpp 

OBJS += \
./testbench/display_shift_tb.o 

CPP_DEPS += \
./testbench/display_shift_tb.d 


# Each subdirectory must supply rules for building sources it contributes
testbench/display_shift_tb.o: /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/Graphic/animation/display_shift/display_shift_tb.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/tools/Xilinx/Vitis_HLS/2020.2/include -I/tools/Xilinx/Vitis_HLS/2020.2/lnx64/tools/systemc/include -I/tools/Xilinx/Vitis_HLS/2020.2/lnx64/tools/auto_cc/include -I/tools/Xilinx/Vitis_HLS/2020.2/include/ap_sysc -I/tools/Xilinx/Vitis_HLS/2020.2/include/etc -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/Graphic/animation/display_shift -O0 -g3 -Wall -Wno-unknown-pragmas -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"testbench/display_shift_tb.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


