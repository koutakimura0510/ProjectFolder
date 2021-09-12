################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/database/system_db.c 

OBJS += \
./src/database/system_db.o 

C_DEPS += \
./src/database/system_db.d 


# Each subdirectory must supply rules for building sources it contributes
src/database/%.o: ../src/database/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/Barrage_Platform/export/Barrage_Platform/sw/Barrage_Platform/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


