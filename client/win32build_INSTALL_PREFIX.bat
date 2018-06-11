@echo off

:: Define installation folder for foolib's library
:: Note it is also assumed that googletest is installed at the same location.
set FOOLIB_INSTALL_DIR=%cd%\..\installs

mkdir build >NUL 2>NUL
cd build

cmake -DCMAKE_INSTALL_PREFIX=%FOOLIB_INSTALL_DIR% ..

pause
