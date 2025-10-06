# Homeassistant for Windows

Setup and install script for Homeassistant on Windows. Currently running Homeassistant 2025.10 (latest version).

Script will download latest Python if it's not already downloaded, unpack it, create venv and install Homeassistant there, so completely separated from system.

You just need to run "install.bat" and wait until it's done.

If you want to change version to something else you can do it in "install.bat" file which you'll find on top of same file:

```
set HASS_VER=2025.10.0
```

You will see Homeassistant installed in clone path and run script called "hass.cmd".

## Bugs

This is not meant for production purposes but for testing and developing stuff.

Some things like bluetooth will not work. FFMpeg will show missing in console. Also other stuff, but it appears that usual functionality is there like ESPHome for example. In future releases it should support any new homeassistant along with fixed stuff you see in console.
