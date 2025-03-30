@REM ------------------------------------------------------------------------------
@REM Created 2025-03-20
@REM Author Kouta Kimura
@REM Efinity Compile Batfile
@REM 
@REM Project = TryPad_v1
@REM Efinity Version = 2024.2
@REM JTAG Version = JTAG_Flash_Loader_TRYPAD_V1
@REM 
@REM 2025-03-20 : release
@REM 2025-03-30 : Flashコマンド実行後に FPGA に対して Gardware Reset を発行するように更新
@REM ------------------------------------------------------------------------------
echo off
if "%1" == "compile" (
    C:\Efinity\2024.2\bin\efx_run.bat TryPad_v1.xml --flow compile
) else if "%1" == "jtag" (
    C:\Efinity\2024.2\bin\efx_run.bat TryPad_v1.xml --flow program --pgm_opts mode=jtag
) else if "%1" == "flash" (
    cd ..\JTAG_Flash_Loader_TRYPAD_V1\
    .\config.bat
    cd ..\TRYPAD_ADVANCED_V1
    C:\Efinity\2024.2\bin\efx_run.bat TryPad_v1.xml --flow program --pgm_opts mode=jtag_bridge
    @REM C:\Efinity\2024.2\bin\efx_run.bat TryPad_v1.xml --flow program --pgm_opts mode=jtag_bridge
    python ./python/fpga_hardrst.py
) else (
    echo Not hex File
)