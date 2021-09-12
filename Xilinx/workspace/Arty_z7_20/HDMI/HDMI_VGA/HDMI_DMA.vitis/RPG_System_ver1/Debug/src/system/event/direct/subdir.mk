################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/system/event/direct/direct_build.c \
../src/system/event/direct/direct_dangeon.c \
../src/system/event/direct/direct_worldmap.c \
../src/system/event/direct/direct_wrapper.c 

OBJS += \
./src/system/event/direct/direct_build.o \
./src/system/event/direct/direct_dangeon.o \
./src/system/event/direct/direct_worldmap.o \
./src/system/event/direct/direct_wrapper.o 

C_DEPS += \
./src/system/event/direct/direct_build.d \
./src/system/event/direct/direct_dangeon.d \
./src/system/event/direct/direct_worldmap.d \
./src/system/event/direct/direct_wrapper.d 


# Each subdirectory must supply rules for building sources it contributes
src/system/event/direct/%.o: ../src/system/event/direct/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/RpgPlatform/export/RpgPlatform/sw/RpgPlatform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


