################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/system/wrapper/subdir.mk
-include src/system/story/subdir.mk
-include src/system/opening/subdir.mk
-include src/system/minigame/subdir.mk
-include src/system/hardware/timer/subdir.mk
-include src/system/hardware/sound/subdir.mk
-include src/system/hardware/rom/subdir.mk
-include src/system/hardware/fpga/subdir.mk
-include src/system/event/unit/subdir.mk
-include src/system/event/status/subdir.mk
-include src/system/event/msg/subdir.mk
-include src/system/event/menu/subdir.mk
-include src/system/event/map/subdir.mk
-include src/system/event/item/subdir.mk
-include src/system/event/formation/subdir.mk
-include src/system/event/exp/subdir.mk
-include src/system/event/draw/subdir.mk
-include src/system/event/direct/subdir.mk
-include src/system/event/cmd/standerd/subdir.mk
-include src/system/event/cmd/opening/subdir.mk
-include src/system/event/cmd/menu/paty/subdir.mk
-include src/system/event/cmd/menu/cook/subdir.mk
-include src/system/event/cmd/menu/subdir.mk
-include src/system/event/cmd/battle/subdir.mk
-include src/system/event/cmd/subdir.mk
-include src/system/event/battle/wrapper/subdir.mk
-include src/system/event/battle/subwindow/subdir.mk
-include src/system/event/battle/sort/subdir.mk
-include src/system/event/battle/damege/subdir.mk
-include src/system/event/battle/config/subdir.mk
-include src/system/event/battle/condition/subdir.mk
-include src/system/event/battle/animation/subdir.mk
-include src/system/event/battle/action/subdir.mk
-include src/system/event/animation/subdir.mk
-include src/system/debug/subdir.mk
-include src/system/calc/subdir.mk
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
	arm-none-eabi-gcc -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wl,-build-id=none -specs=Xilinx.spec -Wl,-T -Wl,../src/lscript.ld -L/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/HDMI/HDMI_VGA/HDMI_DMA.vitis/RpgPlatform/export/RpgPlatform/sw/RpgPlatform/standalone_domain/bsplib/lib -o "RPG_System_ver1.elf" $(OBJS) $(USER_OBJS) $(LIBS)
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
