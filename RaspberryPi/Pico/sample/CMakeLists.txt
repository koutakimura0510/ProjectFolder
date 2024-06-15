# 
# 2024-06-15 CMakeLists.txt
# Target XIAO RP2040
# 
# 参考 URL
# https://qiita.com/dea-azat/items/d30122e408ef6be5d258
# https://ysin1128.hatenablog.com/entry/2023/07/09/163802
# https://zenn.dev/rjkuro/articles/054dab5b0e4f40
#
cmake_minimum_required(VERSION 3.12)

# Pull in SDK (must be before project)
include(pico_sdk_import.cmake)

include(pico_extras_import_optional.cmake)

project(pico_examples C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

if (PICO_SDK_VERSION_STRING VERSION_LESS "1.3.0")
    message(FATAL_ERROR "Raspberry Pi Pico SDK version 1.3.0 (or later) required. Your version is ${PICO_SDK_VERSION_STRING}")
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

add_executable(sample
# main.c プロジェクト直下の場合
# ./src/main.c 複数階層の場合
./src/main.c
)

# Hardware-specific examples in subdirectories:
# add_subdirectory(sample)

# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(sample pico_stdlib)

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(sample)