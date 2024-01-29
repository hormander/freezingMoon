@echo off

rem 
rem IMPORTANT: Run the script as Administrator
rem

set "DISTRO_NAME=freezing_moon"
set /p "DISTRO_NAME=Enter 'Distro Name' value or just ENTER for default [%DISTRO_NAME%] : "

set "DISTRO_USER=euronymous"
set /p "DISTRO_USER=Enter 'Distro user' value or just ENTER for default [%DISTRO_USER%] : "

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	timeout 1 >nul
    echo Installing distro %DISTRO_NAME% for user %DISTRO_USER% ...
    echo ...
	timeout 3 >nul
) ELSE (
    echo Installation failed: Administrator PRIVILEGES Required! 
	exit /B
)

echo.

timeout 1 >nul

call wsl\mocker.alpine.bat

echo.

timeout 1 >nul

call wsl\mocker.user.bat

echo.

timeout 1 >nul

call wsl\mocker.bin.bat

echo.

timeout 1 >nul

wsl -t %DISTRO_NAME%

echo.

echo Installation distro %DISTRO_NAME% is completed.

echo.

echo Now you can run the following command:

echo.

echo wsl -d %DISTRO_NAME%

echo.

echo Bye! Have a nice day.
