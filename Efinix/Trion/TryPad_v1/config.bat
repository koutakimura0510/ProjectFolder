@REM ------------------------------------------------------------------------------
@REM 2024-05-19
@REM Author Kouta Kimura
@REM Efinity Compile Batfile
@REM ------------------------------------------------------------------------------

if "%1" == "compile" (
    C:\Efinity\2023.1\bin\efx_run.bat TryPad_v1.xml --flow compile
) else if "%1" == "jtag" (
    C:\Efinity\2023.1\bin\efx_run.bat TryPad_v1.xml --flow program --pgm_opts mode=jtag
) else if "%1" == "flash" (
	@REM ../JTAG_Flash_Loader/config.bat
    C:\Efinity\2023.1\bin\efx_run.bat F:\workspace\ProjectFolder\Efinix\Trion\JTAG_Flash_Loader\JTAG_Flash_Loader.xml --flow program --pgm_opts mode=jtag
    @REM F:\workspace\ProjectFolder\Efinix\Trion\JTAG_Flash_Loader\config.bat
    C:\Efinity\2023.1\bin\efx_run.bat TryPad_v1.xml --flow program --pgm_opts mode=jtag_bridge
) else (
    echo Not hex File
)