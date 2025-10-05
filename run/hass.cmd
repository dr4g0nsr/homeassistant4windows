@echo off

set PYVER=3.13.2
set HASS_VER=--HASS_VER--
set PYTHONWARNINGS=ignore

echo "Starting Home Assistant %HASS_VER%"

call "%~dp0scripts\env.bat"
python.exe -m hass_win --config "%~dp0config" --verbose --open-ui
pause