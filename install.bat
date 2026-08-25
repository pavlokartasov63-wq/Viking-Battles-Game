@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: Python version settings
set "PYTHON_VER=3.11.5"
set "PYTHON_URL=https://python.org"
set "INSTALLER_NAME=python_installer.exe"

echo Checking for Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python was not found on this system.
    echo [.] Downloading official Python %PYTHON_VER% installer...
    
    :: Downloading file via built-in curl
    curl -L -o "%INSTALLER_NAME%" "%PYTHON_URL%"
    if !errorlevel! neq 0 (
        echo [Error] Failed to download Python. Please check your internet connection.
        pause
        exit /b
    )
    
    echo [.] Running silent Python installation...
    echo [.] Please wait, this will take about a minute...
    
    :: Silent installation with PATH environment variable update
    start /wait "" "%INSTALLER_NAME%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    :: Delete installer after installation
    del "%INSTALLER_NAME%"
    
    :: Update PATH variables for the current command line session
    set "PATH=%ProgramFiles%\Python311\;%ProgramFiles%\Python311\Scripts\;%PATH%"
    
    echo [+] Python successfully installed!
) else (
    echo [+] Python is already installed.
)

echo.
echo [.] Starting module installation...
python install_modules.py

echo.
echo [+] All done! Process finished.
pause
