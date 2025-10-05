# Homeassistant for Windows

Setup and install script for Homeassistant on Windows. Currently running Homeassistant 2025.10 (latest version).

Script will download latest Python if it's not already downloaded, unpack it, create venv and install Homeassistant there, so completely separated from system.

You just need to run "install.bat" and wait until it's done.

If you want to change version to something else you can do it in "install.bat" file:

```
set HASS_VER=2025.10.0
```