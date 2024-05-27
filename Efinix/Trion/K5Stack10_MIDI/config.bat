@REM ------------------------------------------------------------------------------
@REM 2024-05-19
@REM Author Kouta Kimura
@REM Efinity Compile Batfile
@REM ------------------------------------------------------------------------------

if "%1" == "compile" (
    C:\Efinity\2023.1\bin\efx_run.bat K5Stack10_MIDI.xml --flow compile
) else if "%1" == "jtag" (
    C:\Efinity\2023.1\bin\efx_run.bat K5Stack10_MIDI.xml --flow program --pgm_opts mode=jtag
) else if "%1" == "flash" (
	../JTAG_Flash_Loader/config.bat
    C:\Efinity\2023.1\bin\efx_run.bat K5Stack10_MIDI.xml --flow program --pgm_opts mode=jtag_bridge
) else (
    echo Not hex File
)