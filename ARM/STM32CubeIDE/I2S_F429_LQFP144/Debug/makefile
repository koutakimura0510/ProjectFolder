################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Drivers/STM32F4xx_HAL_Driver/Src/subdir.mk
-include Core/Startup/subdir.mk
-include Core/Src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

BUILD_ARTIFACT_NAME := I2S_F429_LQFP144
BUILD_ARTIFACT_EXTENSION := elf
BUILD_ARTIFACT_PREFIX := 
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME).$(BUILD_ARTIFACT_EXTENSION)

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLES += \
I2S_F429_LQFP144.elf \

SIZE_OUTPUT += \
default.size.stdout \

OBJDUMP_LIST += \
I2S_F429_LQFP144.list \

OBJCOPY_BIN += \
I2S_F429_LQFP144.bin \


# All Target
all: main-build

# Main-build Target
main-build: I2S_F429_LQFP144.elf secondary-outputs

# Tool invocations
I2S_F429_LQFP144.elf: $(OBJS) $(USER_OBJS) /home/koutakimura/workspace/ProjectFolder/ARM/STM32CubeIDE/I2S_F429_LQFP144/STM32F429ZITX_FLASH.ld
	arm-none-eabi-gcc -o "I2S_F429_LQFP144.elf" @"objects.list" $(USER_OBJS) $(LIBS) -mcpu=cortex-m4 -T"/home/koutakimura/workspace/ProjectFolder/ARM/STM32CubeIDE/I2S_F429_LQFP144/STM32F429ZITX_FLASH.ld" --specs=nosys.specs -Wl,-Map="I2S_F429_LQFP144.map" -Wl,--gc-sections -static -L"/home/koutakimura/workspace/ProjectFolder/ARM/STM32CubeIDE/I2S_F429_LQFP144" -L../Middlewares/ST/ARM/DSP/Lib --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

default.size.stdout: $(EXECUTABLES)
	arm-none-eabi-size  $(EXECUTABLES)
	@echo 'Finished building: $@'
	@echo ' '

I2S_F429_LQFP144.list: $(EXECUTABLES)
	arm-none-eabi-objdump -h -S $(EXECUTABLES) > "I2S_F429_LQFP144.list"
	@echo 'Finished building: $@'
	@echo ' '

I2S_F429_LQFP144.bin: $(EXECUTABLES)
	arm-none-eabi-objcopy  -O binary $(EXECUTABLES) "I2S_F429_LQFP144.bin"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) *
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST) $(OBJCOPY_BIN)

fail-specified-linker-script-missing:
	@echo 'Error: Cannot find the specified linker script. Check the linker settings in the build configuration.'
	@exit 2

warn-no-linker-script-specified:
	@echo 'Warning: No linker script specified. Check the linker settings in the build configuration.'

.PHONY: all clean dependents fail-specified-linker-script-missing warn-no-linker-script-specified
.SECONDARY:

-include ../makefile.targets
