@echo off

:: Specify the installation folder for foolib's library
set foolib_DIR=%cd%\..\installs

mkdir build >NUL 2>NUL
cd build

cmake -Dfoolib_DIR=%foolib_DIR% ..

pause
