################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/draw/event/direct/direct_build.c \
../src/draw/event/direct/direct_dangeon.c \
../src/draw/event/direct/direct_worldmap.c \
../src/draw/event/direct/direct_wrapper.c 

OBJS += \
./src/draw/event/direct/direct_build.o \
./src/draw/event/direct/direct_dangeon.o \
./src/draw/event/direct/direct_worldmap.o \
./src/draw/event/direct/direct_wrapper.o 

C_DEPS += \
./src/draw/event/direct/direct_build.d \
./src/draw/event/direct/direct_dangeon.d \
./src/draw/event/direct/direct_worldmap.d \
./src/draw/event/direct/direct_wrapper.d 


# Each subdirectory must supply rules for building sources it contributes
src/draw/event/direct/%.o: ../src/draw/event/direct/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/Barrage_Platform/export/Barrage_Platform/sw/Barrage_Platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


