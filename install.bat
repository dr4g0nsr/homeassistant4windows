@echo off

set TEMP=C:\Tmp
set TMP=C:\Tmp

: 3.13.2, 3.12.9, 3.11.9, 3.10.9, 3.9.13, 3.8.13, 3.7.13, 3.6.15, 3.5.10, 3.4.10, 3.3.7, 3.2.6, 3.1.5, 3.0.1
set PYVER=3.13.2
: 2025.4.1, 2025.4.0, 2025.3.4, 2025.2.4, 2025.1.4, 2024.12.0, 2024.11.0, 2024.10.0, 2024.9.0, 2024.8.0, 2024.7.0, 2024.6.0, 2024.5.0, 2024.4.0, 2024.3.0, 2024.2.0, 2024.1.0
set HASS_VER=2025.10.0

rem set TEMP=I:\Tmp
rem set TMP=I:\Tmp

echo Installing Home Assistant %HASS_VER% on Python %PYVER% using tmp %TEMP%

IF NOT EXIST ".\python-%PYVER%.zip" (
    echo "Python version %PYVER% does not exist, downloading"
    wget "https://github.com/winpython/winpython/releases/download/13.1.202502222final/Winpython64-%PYVER%.0dot.zip" -O python-%PYVER%.zip
)

IF NOT EXIST ".\python-%PYVER%.zip" (
    echo Failed to download Python %PYVER%
    exit /b 1
)

echo Python %PYVER% downloaded

IF NOT EXIST "Homeassistant-%HASS_VER%" (

    echo Homeassistant %HASS_VER% does not exist, installing Python and creating env

    unzip python-%PYVER%.zip

    setlocal enabledelayedexpansion

    :: Find the folder starting with "WPy64-"
    for /d %%F in (WPy64-*) do (
        set "oldname=%%F"
    )

    :: Check if a folder was found
    if not defined oldname (
        echo No folder found matching WPy64-*
        exit /b 1
    )

    rename "!oldname!" "Homeassistant-%HASS_VER%"
)

cd Homeassistant-%HASS_VER%

echo Set envs from python venv

call scripts\env.bat

mkdir tmp_wheels

echo Install Homeassistant %HASS_VER% python %PYVER% dependencies and packages

python -m pip install homeassistant==%HASS_VER% --find-links=tmp_wheels

if %ERRORLEVEL%==0 (
    echo "Home Assistant installed successfully"
) else (
    echo "Failed with exit code %ERRORLEVEL%"
    cd ..
    exit /b 1
)

del *.exe
copy ..\run\hass.cmd hass.cmd
..\tools\sed -i "s/--HASS_VER--/%HASS_VER%/" hass.cmd
copy ..\inject\resource.py python\Lib\site-packages\homeassistant\util\
copy ..\inject\__init__[habluetooth].py python\Lib\site-packages\homeassistant\util\
copy ..\inject\fcntl.py python\Lib\site-packages\

mkdir python\Lib\site-packages\hass_win
copy ..\inject\hass_win\* python\Lib\site-packages\hass_win\

mkdir config

echo "Done"
pause