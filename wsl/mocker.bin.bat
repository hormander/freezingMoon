@echo off

if not exist "%ProgramFiles%\apps" (
	md "%ProgramFiles%\apps"
)

if not exist "%ProgramFiles%\apps\bin" (
	md "%ProgramFiles%\apps\bin"
)

icacls "%ProgramFiles%\apps\bin" /grant "everyone":(OI)(CI)M

(for /f "delims=" %%i in (wsl/mocker.bat.txt) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
	set "line=!line:__my_wsl_distro__=%DISTRO_NAME%!"
	set "line=!line:__my_wsl_user__=%DISTRO_USER%!"
    echo !line!
    endlocal
))>"%ProgramFiles%\apps\bin\mocker.bat"

icacls "%ProgramFiles%\apps\bin\mocker.bat" /grant "everyone":(OI)(CI)M

timeout 1 >nul

echo.%PATH%|findstr /C:"%ProgramFiles%\apps\bin;" >nul 2>&1

if errorlevel 1 (	
	echo Updating PATH variable ...
	
	setx PATH "%PATH%;%ProgramFiles%\apps\bin;" >nul 2>&1
	
	setx /M PATH "%PATH%;%ProgramFiles%\apps\bin;" >nul 2>&1
)

setx /M WSL_DISTRO_NAME "%DISTRO_NAME%" >nul 2>&1

setx /M WSL_DISTRO_USER "%DISTRO_USER%" >nul 2>&1
