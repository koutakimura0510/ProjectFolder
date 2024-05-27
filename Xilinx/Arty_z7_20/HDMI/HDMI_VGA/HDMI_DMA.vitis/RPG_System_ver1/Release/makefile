################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/sound/subdir.mk
-include src/main/subdir.mk
-include src/hardware/subdir.mk
-include src/draw/wrapper/subdir.mk
-include src/draw/story/subdir.mk
-include src/draw/opening/subdir.mk
-include src/draw/minigame/subdir.mk
-include src/draw/fpga/subdir.mk
-include src/draw/event/unit/subdir.mk
-include src/draw/event/msg/subdir.mk
-include src/draw/event/map/subdir.mk
-include src/draw/event/direct/subdir.mk
-include src/draw/event/cmd/subdir.mk
-include src/draw/event/battle/subdir.mk
-include src/draw/draw/subdir.mk
-include src/draw/animation/subdir.mk
-include src/debug/subdir.mk
-include src/database/subdir.mk
-include src/calc/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
RPG_System_ver1.elf.size \


# All Target
all:
	$(MAKE) --no-print-directory pre-build
	$(MAKE) --no-print-directory main-build

# Main-build Target
main-build: RPG_System_ver1.elf secondary-outputs

# Tool invocations
RPG_System_ver1.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM v7 gcc linker'
	arm-none-eabi-gcc -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wl,-build-id=none -specs=Xilinx.spec -Wl,-T -Wl,../src/lscript.ld -L/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/Barrage_Platform/export/Barrage_Platform/sw/Barrage_Platform/standalone_domain/bsplib/lib -o "RPG_System_ver1.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

RPG_System_ver1.elf.size: RPG_System_ver1.elf
	@echo 'Invoking: ARM v7 Print Size'
	arm-none-eabi-size RPG_System_ver1.elf  |tee "RPG_System_ver1.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) RPG_System_ver1.elf
	-@echo ' '

pre-build:
	-a9-linaro-pre-build-step
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents main-build pre-build

-include ../makefile.targets
