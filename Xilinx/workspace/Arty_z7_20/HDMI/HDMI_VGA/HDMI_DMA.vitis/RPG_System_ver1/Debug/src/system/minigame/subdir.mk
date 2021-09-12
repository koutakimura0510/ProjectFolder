################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/system/minigame/minigame.c \
../src/system/minigame/shooting.c 

OBJS += \
./src/system/minigame/minigame.o \
./src/system/minigame/shooting.o 

C_DEPS += \
./src/system/minigame/minigame.d \
./src/system/minigame/shooting.d 


# Each subdirectory must supply rules for building sources it contributes
src/system/minigame/%.o: ../src/system/minigame/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/RpgPlatform/export/RpgPlatform/sw/RpgPlatform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


