@echo off

rem 
rem IMPORTANT: Run the script as Administrator
rem

set DISTRO_NAME=%WSL_DISTRO_NAME%

set DISTRO_USER=%WSL_DISTRO_USER%

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	timeout 1 >nul
    echo Uninstalling distro %DISTRO_NAME% for user %DISTRO_USER% ...
    echo ...
    wsl -t %DISTRO_NAME%
	timeout 1 >nul
    wsl --unregister %DISTRO_NAME%
) ELSE (
    echo Installation failed: Administrator PRIVILEGES Required! 
	exit /B
)

setx /M WSL_DISTRO_NAME "" >nul 2>&1

setx /M WSL_DISTRO_USER "" >nul 2>&1

timeout 1 >nul

echo Distro %DISTRO_NAME% has been removed.

echo.

echo Bye! Have a nice day.
