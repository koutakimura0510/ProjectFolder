# Create 2024-06-15 CMakeLists.txt
# Target XIAO RP2040
# 
# 参考 URL
# https://qiita.com/dea-azat/items/d30122e408ef6be5d258
# https://ysin1128.hatenablog.com/entry/2023/07/09/163802
# https://zenn.dev/rjkuro/articles/054dab5b0e4f40
#
# ビルドの設定は .vscode の各種 json ファイル参照
#
cmake_minimum_required(VERSION 3.12)

# Set PICO SDK PATH
set(PICO_SDK_PATH "C:/Program Files/Raspberry Pi/Pico SDK v1.5.1/pico-sdk")
# set(PICO_BOARD "pico_w")

# Pull in SDK (must be before project)
include(pico_sdk_import.cmake)
include(pico_extras_import_optional.cmake)

project(pico_examples C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

if (PICO_SDK_VERSION_STRING VERSION_LESS "1.5.1")
    message(FATAL_ERROR "Raspberry Pi Pico SDK version 1.5.1 (or later) required. Your version is ${PICO_SDK_VERSION_STRING}")
endif()

set(PICO_EXAMPLES_PATH ${PROJECT_SOURCE_DIR})

# Initialize the SDK
pico_sdk_init()

add_compile_options(-Wall
        -Wno-format          # int != int32_t as far as the compiler is concerned because gcc has int32_t as long int
        -Wno-unused-function # we have some for the docs that aren't called
        )
if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
    add_compile_options(-Wno-maybe-uninitialized)
endif()

add_executable(RP2040
# main.c プロジェクト直下の場合
# ./src/main.c 複数階層の場合
    ./src/main.c
    ./src/Mtimer.c
    ./src/Mspi.c
    ./src/Mvideo.c
    ./src/Mpsram.c
    ./src/Mflash.c
)

# Hardware-specific examples in subdirectories:
# add_subdirectory(RP2040)

# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(RP2040 pico_stdlib hardware_spi hardware_timer)

# enable usb output, disable uart output
pico_enable_stdio_usb(RP2040 1)
pico_enable_stdio_uart(RP2040 0)

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(RP2040)
# example_auto_set_url(RP2040)